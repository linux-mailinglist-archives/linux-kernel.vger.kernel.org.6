Return-Path: <linux-kernel+bounces-241013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228C69275BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD0F1F22A25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03619409E;
	Thu,  4 Jul 2024 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SvnGp9fd"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1694317995
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095155; cv=none; b=jWBgqZEXpyCIx9L8JULyEF4Qz4CSoMMriA3PR0Ncmop2AeTI8ePZx31rjr9BPYu5ef54FOYk0+XMz2bc0KjMKnDh0zctlp5POqYXjV28tG4x4CKs7JXsPi3BVTH8Cyypw/Z1vf6Vi5VyNcobJB0N1eOxtAVNU/VYUrH40Qz0/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095155; c=relaxed/simple;
	bh=/L8RpMI0AIzYt3SDf5oEdlmD7357rNaV1BZH1go1oxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrB00BKW9roPhOD/hQwafknnFCH1mqNcuzo0pz8E3YHJHtJocCmf2yQKpBxMX2aTBt1CCb90a30gFXbIDdWOu7un9fKwmtyInK399uaqj6XXLyvH4zg0wVHgWqBOj9XEgC+UmIC/8c0kJ6Mc+ELlTz4B+cnE41ayTwmidZJe53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SvnGp9fd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111b0so422458a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720095151; x=1720699951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=30WkcI2XN7ZKxp46jucJdLjj2rsE35KOzhzMbBHJY6M=;
        b=SvnGp9fdeL9kjd89eXKPl6upfFXuEFx4d2Ckj7eRuOuJY7wPlbJq33ZTONCk0X3rm/
         j0G0Qr9S+LKqj+Yp5ji2wpD1eNim6e8Q/oEv7QDaSFyJ+IxPrv5QDm4smJ8chl1jCMmZ
         cy34uVeCXN3ffSU89Q/KDNN/3X/+X55v2knik/7tUtoRp5KIM12MI07OOH98ewckqIVX
         EipgWpdAkmiNMmDRvQbQGgmXnTIMCEjyGsdX52LBhH60jPdyXCim1FZxbfP1ONyIMQOy
         rRQxjTo7EwSQf6i3nfavJ7LzF/GUVj5s8q1kkbj+cc4UahgjPOcsQViK81cZmNZS+VK0
         chyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720095151; x=1720699951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30WkcI2XN7ZKxp46jucJdLjj2rsE35KOzhzMbBHJY6M=;
        b=GY8oOWvosQX+rVKkkeBDo0eT510RyYHS3ha7TjSGT0Z89JOibE9xWGzFECPW/yXJyk
         cVqdft1d7Mm5YEK2BO/VGgStQC0nt6vhEDYQbqEjAOEKo7+I5oOgcJwDuGV1Y+BngJ7D
         9ul6iQqum2y5JbU1gktjr8O5vd2WARufUzXOc/CW72CpCF96bJZ86O4+gF2NjvUhyLjR
         DJTTH+wXYVTp+XmENztXRO+1lErUwODeFxujr0nbD3DD2DJdpyp3uo4HTSbcLnMxXXHB
         LFRS1ptqQza/EQx6uj/lEtludUBsWI/1sFzvMuy4Z5YbUmgM9R5byhBA1m4aj4K3BBvY
         7mxA==
X-Forwarded-Encrypted: i=1; AJvYcCUw1gvRXL/2f7jlc4zDQKnbScFAlIVX/N8sF2BkGAbQBAulJ8gw/q0FTbOqI5EWRs6WiLculMuBccZomnLHL4QUvpoPKWpjQ/8JNbND
X-Gm-Message-State: AOJu0YzCb+6dDliYjzEc8Ju2OoYNpUtr/5Qki7hHZVH6j7F4Ts3Ej3Zw
	66syQ5odDeo1gi8MwhnOUdVvomFZnSzM2zNo5nmsKIKZjrrefBnc7b5kra63zVg=
X-Google-Smtp-Source: AGHT+IFw/pQrCU942dv1/+ZVwuZjVBu1zYboDoTUa7dDrxssvyk1Ho3MZM3/M2ZDqxAaktRuo8S0DQ==
X-Received: by 2002:a05:6402:2792:b0:578:638e:3683 with SMTP id 4fb4d7f45d1cf-58e5994e612mr1652698a12.5.1720095151366;
        Thu, 04 Jul 2024 05:12:31 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58eeabbf108sm194512a12.93.2024.07.04.05.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:12:30 -0700 (PDT)
Date: Thu, 4 Jul 2024 14:12:29 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Xavier <xavier_qy@163.com>
Cc: tj@kernel.org, longman@redhat.com, akpm@linux-foundation.org, 
	lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH-cpuset v10 1/2] Union-Find: add a new module in kernel
 library
Message-ID: <ga4sohvmxgu4hr5o2l5uylb3ryjfqbn7z4nlqb7gryw5lk5rdo@lgqh5rndrfln>
References: <ZoRThI4lcZLxBlwc@slm.duckdns.org>
 <20240703063727.258722-1-xavier_qy@163.com>
 <20240703063727.258722-2-xavier_qy@163.com>
 <haimyc4y2trcyvbnkpw2gkfoiaunykb2q2d5ybr6qgt6upf3lm@afhcevtyjcjl>
 <13bf9422.aeb4.1907852c7ce.Coremail.xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zwr5qrurnxwgzr3x"
Content-Disposition: inline
In-Reply-To: <13bf9422.aeb4.1907852c7ce.Coremail.xavier_qy@163.com>


--zwr5qrurnxwgzr3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 07:20:09PM GMT, Xavier <xavier_qy@163.com> wrote:
> >Xavier, not sure if you responded to my suggestion of considered zeroed
> >object a valid initialized one. That could save some init work (and
> >move it to alternative uf_find, see below).
> >
> >With uf_find body checking for NULL:
> >
> >	while (node->parent !=3D node) {
> >		parent =3D node->parent;
> >		node->parent =3D parent ? parent->parent : node;
> >		node =3D node->parent;
> >	}
>=20
> Yes, I noticed your suggestion. In patch v4, I implemented it by
> initializing to 0 and adding a check for whether the parent is 0 in
> uf_find.

Ah, I didn't read all versions. (You may consider adding a short
changelog when sending a new version of patches where main evolution
points are summed up. ;-))

> However, later, when I was reviewing the algorithm's documentation, I
> noticed it requires initialization to itself.

Well, that's not a hard requirement.

> Moreover, uf_find is a high-frequency operation, if we add a parent
> check within it, the efficiency impact each time would be more
> significant than initializing once. Therefore, I adhered to the
> initialization to itself approach.

I see, thanks for the clarifications,
Michal

--zwr5qrurnxwgzr3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZoaRqAAKCRAt3Wney77B
SeeiAQCo1j0ve5vYgiced6AV3KscuwHWw54IB3C1CMEj1F6/yQEA8lXi8eFLlMl9
+injSP+dwCnJuw6bux4jE9pIkuF49AI=
=TMIo
-----END PGP SIGNATURE-----

--zwr5qrurnxwgzr3x--

