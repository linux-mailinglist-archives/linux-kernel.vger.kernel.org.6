Return-Path: <linux-kernel+bounces-263066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2B93D093
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD72D282323
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA87176AB0;
	Fri, 26 Jul 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N4Z/jtEI"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA123741
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987166; cv=none; b=tTIDDVlpPhVADWqY+TIGKI0Tqy1I2idrHKwA9YP0zwFSC2P7F/ro/JuohIw7y/KIU9yBIaA8SIKOl70fvH699jvTiKFt5nZOEROIQ0FVUcegjSSgPb5WQZG1WyUrKEHXiPQHcfrUWoZXOfMV+/CL8BhK/o4mGCGoPXcmmQA2xwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987166; c=relaxed/simple;
	bh=4F7w1+788iMUSs2nEiCYxzYRKXbq7n4kJqkNLr/tIJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byfsjlmlujDjZMB3IOMx0DBqMS9RyU0Zq++04adLLiIa8Q2/B0xKe0i5YC/QMujanXqwj/2zRuLabsMXufnI99b000DWxGS+RXSPCx97rJV5/IUI24uvT9ECqK0GnRyR90tbmp/2+uRUZHwfZiNBD8Nc7mROIxKpThoAVcAeaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N4Z/jtEI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f00ad303aso1597527e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721987162; x=1722591962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXVeMoayXi+AYkYoCL6auJzoGlTFoFw5V6xlLMIvhLE=;
        b=N4Z/jtEITpggIKPSujBs/0mM5cUXgbHBz4BO6QWKCfhpfRDwDRGyrL4b2PceaXIR2a
         4XlTl2RL64ONuimQZT/rDHBwqCju0xQDhMq33NygGg14gdEd0fdXX6BbKJA7J9+R6XoM
         PfAXMuflHv1/ScA/9120wqIbIDaArXxF4wVWnwi4Yj0xFHFxxo360K8L6XA10dC74E49
         QwRWjs4pMk0J8Jv3/t1Cq4FiYLxhm5UfGZ6RtpmsM0xblBEvoVJjN3VG9sj9XBRpQIt7
         LfFV1OlIxlOA8HY9qQZb6OYNmzQqhEB7Bc4Qrtj4kmogAQw7+zqQVaa8Su9GpwxrW3th
         TGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721987162; x=1722591962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXVeMoayXi+AYkYoCL6auJzoGlTFoFw5V6xlLMIvhLE=;
        b=J+vXefB48ZBRtz0EK9p6DP8KuBLURrdqdtUb0rDTHX3DM9Nxn29nlpzNRNbQ1ceSLy
         7rYz1BYw08sr0K7QtVWDz4sLqSa0UlJTEkGXhtt1T7ny/kbZ2rFyU0F5ovGtUWA3nxCC
         XSiSvW/EazwfRrBR7BmcRNYLrR7DCmss1HCoeDel9WMFA3xYs/Q6TgADO/eDrt3kOofp
         AQX6fueVetgTAvm9JMHXd2TMnBeN7WpCh+9nd6SHOLdMquF5uV016heThrwy2JU2U986
         Ju6S/TMzmq9Hbienf+MpWGUsLk77MSFtSwFxYTgHdvIbWrLDcgYpcDVSJO7caaU8fF95
         lu6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXp/MwpQfSAiRlSxgITeMDVeXvaxLiH8IoaBI9rtjKt6JWXi9Gpg3/06wVkFRESWPm5qpuWeF8OQPoxDeqEO4NK/Fp2ETgAPYmeY9r
X-Gm-Message-State: AOJu0YxMhEZJt52x4llO/3mKbDI0EHk+tL4nUXkMiyHusyHCRudU27vz
	Pm81+hVwiwXXQUFCvp6zYEKzpsG5lInVFmZGKhGp9z5Pv1zLBCJwt/1EpBLQw2o=
X-Google-Smtp-Source: AGHT+IHqS9NyxuUzWu4kOGXYWW2TsDbsPiI+hUKYXT9KNZfk50rPvYyWgL/1EX8EgMVQG5MOZE645w==
X-Received: by 2002:a05:6512:12d2:b0:52c:e054:4149 with SMTP id 2adb3069b0e04-52fd3efcc2emr4098244e87.15.1721987161794;
        Fri, 26 Jul 2024 02:46:01 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23d56sm154577466b.38.2024.07.26.02.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 02:46:01 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:45:59 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>
Subject: Re: CVE-2024-35918: randomize_kstack: Improve entropy diffusion
Message-ID: <lsh7xgorp67fplqey6evmukt66tbstbjob34bwyt7wiklkqu3n@6wftjk4z7xja>
References: <2024051912-CVE-2024-35918-3fed@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lzeb7tpj3dgrev55"
Content-Disposition: inline
In-Reply-To: <2024051912-CVE-2024-35918-3fed@gregkh>


--lzeb7tpj3dgrev55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Sun, May 19, 2024 at 12:11:12PM GMT, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:
> Description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> In the Linux kernel, the following vulnerability has been resolved:
>=20
> randomize_kstack: Improve entropy diffusion
>=20
> The kstack_offset variable was really only ever using the low bits for
> kernel stack offset entropy. Add a ror32() to increase bit diffusion.
>=20
> The Linux kernel CVE team has assigned CVE-2024-35918 to this issue.
>=20
>=20
> Affected and fixed versions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>=20
> 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 5.15.155 =
with commit dfb2ce952143
> 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.1.86 wi=
th commit e80b4980af26
> 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.6.27 wi=
th commit 300a2b9c2b28
> 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.8.6 wit=
h commit 6be74b1e21f8
> 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.9 with =
commit 9c573cd31343

The commit
9c573cd313433 ("randomize_kstack: Improve entropy diffusion") v6.9-rc4~35^2
adds ~2 bits of entropy to stack offsets (+the diffusion, x86_64)

The commit
39218ff4c625d ("stack: Optionally randomize kernel stack offset each syscal=
l") v5.13-rc1~184^2~3
adds ~8 bit of entropy to stack offsets (there was none before, x86_64)

Why the former commit has a CVE while the latter doesn't? (2 < 8)

I'd expect both to be treated equally or even inversely.

Thanks,
Michal

--lzeb7tpj3dgrev55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqNwVQAKCRAt3Wney77B
ScO+AP0Wpd8AISy8OzVV/CwRGMRidnLVLNTuG4eT3w+aQnFkSQD/QOSHNXt85HlP
iaCny8Gb0h4BPuPqaZxbr9sbcHbDZgU=
=nYeP
-----END PGP SIGNATURE-----

--lzeb7tpj3dgrev55--

