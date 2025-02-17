Return-Path: <linux-kernel+bounces-517626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C811A3836D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E5A7A1B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B051F21B1AB;
	Mon, 17 Feb 2025 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GKyRUeGt"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121581FCD09
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796705; cv=none; b=a9N9tz+KYFFmttIhuU0EpaI85JQMKz7hDplGBIJmSDwXN6JTFoEUjvIpuiZgzbmBMtNFpat+YZPzfxufRSp+anNpwzTk7PaLEP8w8LFS865PSWPctuj8qLr+JcQCs7PWAFB1wJMOOp1sCrMbpiQWUZXWOpgTS2PVr+IRXQ2k+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796705; c=relaxed/simple;
	bh=jiX0y0MTU/alODmjaoSPV0vx0SMSc3fr+qbU/rvNdH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhPQEFqhQDOiJBb7psrcQmsulpxcA4W8lhvJwpIqQtOMGUQPNRckaPAgTr98B85OVEz4SfKmuNQHV4rcq7wLUfVHBj1SNuzFEev3ew9Cd8GL64LR7xxUVbbLLuRfVHO6/pxxoSPrA2TYMH3Me+5hRfV3iAP8dx+s+FqPW1tqb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GKyRUeGt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aba868c6e88so429642366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739796701; x=1740401501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nj1L+8nX/9kMXQDQ3FNBhb9ptIaN0gRET18ncQ6m0oY=;
        b=GKyRUeGtEXXKVk4uBLiaODmpGADXH1aYplLiDhSUGZFqM9KA7/B9/rnnz2tjqokxHB
         fmXthWHSMuyzU18w04tdjd0X+ig+AfJX37I6/20fYMs9DjIWqvkntzSls9uL7F1nztKi
         B1P2sv5YTJ2Tru1FvijHlUzuwpa25J3kauiKbin8h+1X9QkMs3aZWk7zbkC6Nt+9+EU6
         bCb/ZC/MZrrWeEs6YDU5OGEoYqzlgRmUkRgRJm9+/MybVdozeiwJNDFc9I/dRvzOn52Y
         h7AIJpa4/CwxIATAebJBOCIELjqH6Tr0LE3iclpMTEcuHq6ZTrKI16T0FYj+oLal/7yR
         8u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796701; x=1740401501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj1L+8nX/9kMXQDQ3FNBhb9ptIaN0gRET18ncQ6m0oY=;
        b=v3tVNRVRdrP32UVu3OgW6sBb7FGIDU41MfwFK5CUVVLk26zQEbtlH+U4qOOWgrinoB
         fo1Qq46rOspNxUESm6Hzm5Zrg1GZgzZ39R2Y3ddWmN3iYXN+hoeipInQZFtpfMgTZEtD
         Yk9ayXM0XLVPB7V/5MaF6IbTJifDQ7Cv9/TrCDhjX5sfZsKooO+ltk5l5u/1LjD9Y9M/
         f9tvAUzqvu9CONPMaFGxdsTepoj+ByaQo3ieqXGAc2qR89BJRyAN6cfO/aPpZ+mkVFVW
         r9iEiRmYiCzfdEa92y/Ar3i/FpAE+E2K2xlJJkca8BAL6CUmccKeDK6V4lXNNnCut2Ug
         y27g==
X-Forwarded-Encrypted: i=1; AJvYcCWk5wmhwomh9h+obFAPU1EtvQefffWRNahlikNaplN5mpeRh1kgiCoC7EBB1AassTMjvWeiSV6HrjPaIFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+nz0dXQWhBF9WYhpAo6G0ov7yr5YK4Lvvu0WJexAJIldGXt5
	hcAiNEpTAiGP+Tp4MYEXEmirt9k2n/4QiZ3cYx3TDYVjHR4p+X4hbxlNBCzYoXwwB66fDOxigWP
	l0cI=
X-Gm-Gg: ASbGncvEmac3jyTBIsjujp/OSp6zbQMb8Nq8WwkWeKxoS7niOAKrNpVSeCQuB9Rv4I1
	l37tVqQV1S50eBQnWdKINdrdeZ5YbbBsnUigK1ql8MlJtxfqDOyr/V7sNIu4XUeIqWJlVGoUcCM
	Yrzu5yyhAMqSyD3b/rPbRO0OTTBfAgF8KSgQ7KmA6q67lTHyTT0RXCuzjZXErcvchJYQM2wUwNz
	Eqcv4GmIsHPlCIQ7Khjk0aEJudm42lFCdVWgqMqmTQLHcBVxq2A4D5hP7MgoSZBZ0P32xHzhYgg
	DWgRCONCrPYX+WUg+g==
X-Google-Smtp-Source: AGHT+IEBAv8od2qJ58LSnXUp5OhSn10k7UUZV8kIh6qmxvoneMQrnZi+5A69qII0l0WJNpneUQ7E0w==
X-Received: by 2002:a17:906:c154:b0:aaf:74dc:5dbc with SMTP id a640c23a62f3a-abb70bbe128mr1078545566b.29.1739796701300;
        Mon, 17 Feb 2025 04:51:41 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba9cf8a262sm593031566b.22.2025.02.17.04.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:51:40 -0800 (PST)
Date: Mon, 17 Feb 2025 13:51:39 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jin Guojie <guojie.jin@gmail.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3] cgroup/cpuset: fmeter_getrate() returns 0 when
 memory_pressure disabled
Message-ID: <tswmetugmdpeu663sdyx2pb6aawhiajb64g4gmjjup2riz23ha@r6vsgo5tdv2w>
References: <20250217071500.1947773-1-guojie.jin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zuy5tgvimnzk3spp"
Content-Disposition: inline
In-Reply-To: <20250217071500.1947773-1-guojie.jin@gmail.com>


--zuy5tgvimnzk3spp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] cgroup/cpuset: fmeter_getrate() returns 0 when
 memory_pressure disabled
MIME-Version: 1.0

On Mon, Feb 17, 2025 at 07:15:00AM +0000, Jin Guojie <guojie.jin@gmail.com>=
 wrote:
> In the current kernel, the variable cpuset_memory_pressure_enabled is
> not actually used=E3=80=82

This statement is weird, it's generally not true and not false without
further context.

> This patch modifies fmeter_getrate() to determine whether to return 0
> based on cpuset_memory_pressure_enabled.
>=20
> Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
> Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>

I'm not sure I'd still suggest this :-) but
Acked-by: Michal Koutn=C3=BD <mkoutny@suse.com>

> Suggested-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset-v1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


--zuy5tgvimnzk3spp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7Mw2QAKCRAt3Wney77B
SdBYAP42ZtNzkfLFN+EdzJxWj0fhqLNVOhJk8lW9kQMc2GVciQEAvMW0vKe9ljBB
t5oDLrSLU3smNd2JN+gSpdECc51yPQU=
=fO+q
-----END PGP SIGNATURE-----

--zuy5tgvimnzk3spp--

