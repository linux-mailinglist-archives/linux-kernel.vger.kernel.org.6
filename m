Return-Path: <linux-kernel+bounces-565916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E4A67109
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDB119A0F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25329204F7E;
	Tue, 18 Mar 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UT0Qy1+7"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB92066EF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293133; cv=none; b=B2TuJXCfWpDAhIGz3Kome5b0aN1LeuxE7eZj8KCnr4//gUJZw1awgN7Qx5zm9epD5x9hoIJgiQuEJrCX1S40PUNMJcoUAgYCuOUxYqsZKqUVbi9RCemm2OA5jweB18u0ZYduLW55NtrVvY8Ir4sRK247eUmfDuMLqy9Gqlsv/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293133; c=relaxed/simple;
	bh=4ssJsJxIWYpA3fFkasszhPUhMVSzH9qY3MwdoCqp/rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcOx0B2YUOW/N6oKpyIGGrdEAaa/aHuSTgijPA6y8QvnWstZ9zIOsnxNNSCq9fWcJbJS6f/gx89tSPHpanTtTzC4tG6frEaXCRPmAkwwDLntmkc2LJ9UiYDgpzJ7k7k5Bap+VzLeRFBaD47ccB9rnBDZgpQn/Joafj1vMOJYfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UT0Qy1+7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf257158fso20525425e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742293129; x=1742897929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7xGOMAuQUF7MWyNDY6Z3/tomm5PbBSvhnd4ckgMx6g=;
        b=UT0Qy1+7UWpCaH/QVVmkp+9HAWJag4LEgdwwnzby6gS2CyaMOCRwkQTy4YbwaubF8H
         2abQZDC/Ua/YiM/V8mKxkwkM4eP+KRBWedKbPZdXI281fKp1umeNnIDRNyJY2RtRU4lb
         vHYt4VAbdXYpo0evg1PoaywwasJG+Gn7MR9fz7Nyqy5jRFpOSX9Y3EimxKJ4P+sY6JaV
         RM8NndL2vGcyk7lQ8BS6cNmA/RIavjKZgcBdkAIiGlT54XdiyK6ymcHw02egnVc6Xems
         zCDTnUVB32TWOvtWk25Z8GQ2AcRy/ouB+s/p1jzX+Gvy/wEn/r32BCwiYq2eyaJWsqY9
         06EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293129; x=1742897929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7xGOMAuQUF7MWyNDY6Z3/tomm5PbBSvhnd4ckgMx6g=;
        b=C/SiREGUf7awAz8txh54MkRKFDCI1vNdA1tGea/OwFBTbTV8yLE9pmwSy7thGq1BlF
         Gr1rlHouCaC4py7CiGA27iUbXVc+qfrWuVV85vp4aY90Q1JFxesdJrPuLIA/CUeYtjPG
         KWoQuZnRUiv9FEFt1FvDrzE/Dp7V2Jfk9oeC9jVjt9Nn05WTYK9QkiQse9v1hDXHqsVF
         fq0JJKJrUWTE4kZdRqAcUpwpKE6F4gyxNtICmlCt+mEuMNCHcw5M8HBmC7I9TKwe04g9
         nwmaJY6KiNB88vHrp7yC7+Z8dTvyn6mlcmXj3U9+dZdkDaOosOBwi4Ot2kgV7MCZO6a6
         3F0g==
X-Forwarded-Encrypted: i=1; AJvYcCWD/74rR42WHzZ9XWthnCI3VBNTmSVJFZnZDUlcN22UY+885InTRbi9j2mTZcExtChXprd9NY/rTWJPSAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Kx8iLMgSJdWEVqzA4tfctlt+MIkuH83m5uQGiWfd/+fELoum
	aaAOUThwimzkS6hQLjlEZnAE6aNQdC65wbbyLkU3NPGMv7NTisFuADJsYgB4ky8=
X-Gm-Gg: ASbGncsX7nHPCje2LANsme2EGa+sXxD80FoCd+xZ3QBlNVudcv2KIPuam+6c+2/3+Mr
	oHlXCFLPEIAO6U0DQx1d3mqsEzKCgBKGCiBbhjwmWGy8XUqfKz824BMn2XSGxzbQYRf5OxkwLHo
	WExTWUsKZKB4YFo2YLxKj+vFvhkRDRnX2Ww+Q2mnrbe5FXgwsotQ/4OER1Fl7cmihrMbMXVa0TX
	ilwnWZJcCvDLJYuIRDnki/0ubWhtIB+DyhulNbm0H7yW+9o9PkpLk4uLyFArijvonP6tCv+gDQK
	2A2Yvd76dekDnYeOUMxP8i8WjkWmWAj0Fu8ieM9z785msxg=
X-Google-Smtp-Source: AGHT+IFrT2crDX0AazaJrXxMyeiUJbVXB4waHwmUEuTI2Pk2priOkOM8LHglNdNkvzmeJCEOd9dpDg==
X-Received: by 2002:a05:600c:4ec6:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43d3b987ec2mr14873995e9.12.1742293129530;
        Tue, 18 Mar 2025 03:18:49 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda208sm132395975e9.6.2025.03.18.03.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:18:49 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:18:47 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, tj@kernel.org, 
	corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 2/2] cgroup: docs: Add pswpin and pswpout items in cgroup
 v2 doc
Message-ID: <2bzz6n6ugfuvw7kpnewqhdzmv3yxghe5o4y4jxrwtrw65f6jsd@zgnh7qkpw33y>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-3-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ceucqiazdoxttvyr"
Content-Disposition: inline
In-Reply-To: <20250318075833.90615-3-jiahao.kernel@gmail.com>


--ceucqiazdoxttvyr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] cgroup: docs: Add pswpin and pswpout items in cgroup
 v2 doc
MIME-Version: 1.0

On Tue, Mar 18, 2025 at 03:58:33PM +0800, Hao Jia <jiahao.kernel@gmail.com>=
 wrote:
> From: Hao Jia <jiahao1@lixiang.com>
>=20
> The commit 15ff4d409e1a ("mm/memcontrol: add per-memcg pgpgin/pswpin
> counter") introduced the pswpin and pswpout items in the memory.stat
> of cgroup v2. Therefore, update them accordingly in the cgroup-v2
> documentation.

Fixes: 15ff4d409e1a ("mm/memcontrol: add per-memcg pgpgin/pswpin counter")=
=20

> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks,
Michal

--ceucqiazdoxttvyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9lIhQAKCRAt3Wney77B
SQcmAPj5mu7c5i0F7YE9fLx+JKryDsiUXIhpYvodLh4TGWAxAQCdwaT9YNeayOac
3hnyVehCiIPruqy8kwaAR7cXejMfAw==
=IbXD
-----END PGP SIGNATURE-----

--ceucqiazdoxttvyr--

