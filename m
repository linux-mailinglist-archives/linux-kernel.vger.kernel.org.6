Return-Path: <linux-kernel+bounces-396475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531CC9BCD9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D070AB2141D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3992B1D63C4;
	Tue,  5 Nov 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rh0AQUT4"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FDA1D5AB6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812498; cv=none; b=tpNfxCTvY/75l6ImJU+ffP4J2Hq65WG5QlSNXjgGH4ywcInnZ8QwNKA+FAMFaLChXVL/VJgoyChLmsKqVAzUvfYWn6/bRyD2YMk/siUQqY7FKo88UTg8KcQ9nfMKpfqSmKypqKxrY/NBOyh6UK5I9lz6jTBMZ7yB+SFsjG8S6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812498; c=relaxed/simple;
	bh=nIfRuCv8NOVzvOxVlZqFNtL7vNI/sQ8/tUTt7WPlACo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UO1gLAQ+avqEaBccFHY5d/PfzGrOnaMV+d3AWYbj/64KLtn/YhO0tRWDyCerPNod0YVG0yWXisYX0ivYXxd9fEPJ14LvQ96EyhfXPJ6TyEH1uVaxXve5poQvSxW12jwlhlRIzrA6vvor2sL74++M4kTCqYLRAusp+frKtboJXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rh0AQUT4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9eaaab29bcso265476366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 05:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730812495; x=1731417295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nIfRuCv8NOVzvOxVlZqFNtL7vNI/sQ8/tUTt7WPlACo=;
        b=Rh0AQUT40T3yxAOvwll+ZDF8g7rJXzH9G3WxDL3gXNCF5T130Ms9qF/AmE/fqUXGeh
         jCw9Cgb/oDmMP0M2EnwJ9ITxN4F6qXMjh0dJvaewCsbsCvV1IXoT8yKQ5tUy6kyuU4Cz
         uRu07x1DUUvtVSnNBHxLPMcHCXSxPskktQi2y0K0zzJQWlMRPvAZVVXZZIehCST4PSJn
         4VlHeuXUgpUK4zx/cl/pANyCovnYdMOkaWP/Rs55U4R1I9dO/oL8R5mKqT9t6dMdlAbt
         7zq4KTxXKNZJwtsYZcG6H9B/i8nWaBN4wn3gcWYybbE/c0UmNxv1qf/W/ewk9T0Oby2C
         7g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730812495; x=1731417295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIfRuCv8NOVzvOxVlZqFNtL7vNI/sQ8/tUTt7WPlACo=;
        b=C9TbAfFsjMbKeC97LeS9wCkIKOd1lkzWUK0ALePKtXj4BBP7QHY14H4zxhSs7OBkUW
         IabWbAUN1fgWhlyDHif6YXxffKVABw5T1xhkdkImc6NIrlwVoCQj/woO2tqtwEBAO7HH
         s19AhfUrSfD4YI8Xqq+lnHFcqbS8eDn1+0q2GBi/F178AgDWUEEh4U61+34lSdrbrDby
         qH7lK6E+rFBoY24CsNlDqaFHwDwi+u7f3ASRSPr9prlK0ihk1hPIH8fADlDN7SnlHSaM
         HaDi2HeoyDyD8P2tRT0VZfdS8omJ+BDMGFNJKj1iNJe2URnEFc9x4hh0IN/kyGiHessV
         bARg==
X-Forwarded-Encrypted: i=1; AJvYcCXZvLZ/9kpTVN0Vlv4oJoaKH9n6su+IK4kawpb17IQjOmazG/9PP6877xnoXJGeu521D+qKbOVPccbjvLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOT3hAd5drvO7jqOmA5utyojDuT8qPCzzGVyoHZ1TyMmBSBGUa
	LUbcMiKpeWXAXoHQExM+ruRINdQzgB6xmN+zjkxm7WAhsTb2LrO4d1+RSjTaO8w=
X-Google-Smtp-Source: AGHT+IHVOo+x/THWNs3/mHtaNNJeAx+rDnTMptfCEAVraFtB0d4G6Dagju4LnspKhatdDFwS1cWHxg==
X-Received: by 2002:a17:907:2d8e:b0:a9a:3705:9ad9 with SMTP id a640c23a62f3a-a9e50b95730mr1721715366b.50.1730812494709;
        Tue, 05 Nov 2024 05:14:54 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17ceb1dsm134961666b.101.2024.11.05.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 05:14:54 -0800 (PST)
Date: Tue, 5 Nov 2024 14:14:52 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, longman@redhat.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Zefan Li <lizf.kern@gmail.com>, 
	Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v2] MAINTAINERS: remove Zefan Li
Message-ID: <lplrh5jp3iuoy5esckhc4pbed2fhi4nriqxlswknlxiyvcrbod@pxvho7abga5b>
References: <20241105030252.82419-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pqyjwghnwb2xyzmv"
Content-Disposition: inline
In-Reply-To: <20241105030252.82419-1-songmuchun@bytedance.com>


--pqyjwghnwb2xyzmv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 11:02:52AM GMT, Muchun Song <songmuchun@bytedance.c=
om> wrote:
> From: Zefan Li <lizf.kern@gmail.com>
>=20
> Not active for a long time, so remove myself from MAINTAINERS.
>=20
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Signed-off-by: Zefan Li <lizf.kern@gmail.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

I trust this comes from lizf.kern@gmail.com so

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

(And thanks for the past work too.)

Michal

--pqyjwghnwb2xyzmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZyoaSgAKCRAt3Wney77B
SZjXAQDoJlx7lBPFcdB9S4uIo37WQs7bEjiKDaP89P4fbiw78AEA6AxPnD8IJMAB
R8DLE56cwcmwIU6FuGTQp/d9GqIAqQM=
=LWDx
-----END PGP SIGNATURE-----

--pqyjwghnwb2xyzmv--

