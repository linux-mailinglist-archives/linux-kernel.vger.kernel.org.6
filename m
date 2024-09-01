Return-Path: <linux-kernel+bounces-310042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF8C9673E0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 02:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097A31C2111A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 00:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DCA259C;
	Sun,  1 Sep 2024 00:11:29 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14ED17C
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725149489; cv=none; b=WYklwwPX22TETrslfUbxlFywnNZ0jpodxvAVgF0GeE2d9ZAbyr0kl5NtXwZqt6KugAdIX15puYgLFpYb25JXRz7LJFDdnGzmxDoOY91EDQGCKwcHPyktExr5L4Gge2Rj0mFPxdp1/yFUfHqPFE/woIJ5cudzfgDnsXzzSfOQ4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725149489; c=relaxed/simple;
	bh=1ghdCMy+245nyoDJ2jnL4ZnbQU+Tlg0+giOL8P7/l4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+TR99xlXUvw/EGyBSlBQ/34Gxxkmv3YAsVfDEApeN7M5FTQfPXAcF4ESYrEjaLcxW9z4z/GyjrB51qUU79g9C3jCC1WRQjxk8jXS7vjQ1x8F7HlbV0lDKlE7uRcfMvdKZHy96KiNv1piJaY5eTBFLVDSugDCTyXjozyL6/JAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4568780a168so16699301cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 17:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725149486; x=1725754286;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ghdCMy+245nyoDJ2jnL4ZnbQU+Tlg0+giOL8P7/l4k=;
        b=ccQ7Qf4ZM+n4Rnj6ejv8TEOI4/IpNF++geTXXL6lX7UzvOp+FqDTvnTw6NMSN4K94m
         a2Hf+4lQyvtawJSoUsj+VCvDOLLEE/ABcef2g4I9uM0RfBuZSikfIpssD+6BegzLIvSE
         bcsbv+1hMCFCFld1xSDjxdvO92WWT99B3dT9mYfFNh0/Czq9HQsYccDYetLJ9jHzUSjG
         FiZi5aPGt9G7/d+8aQCY3iP5JqMOb8vcf/6fu2us4tuO8ZzPssFZXro7MKt6iDJmNYmz
         zJEVpitigA8/uYN6swce9pCxKdGdrUr36j8+iafixNEHapVzcWFiIbX/BnnSh5lK9yht
         I3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUUKbI4jlGAuftCB7B0714nzqiDTP0aHGNyK1gICxRurkcg1XKDVu2eKHmxdPk3cITFQs4uNz6bKxTeqoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSOzqe54Jz/LPjAhuEe7kgaRFY4H6hJwVOiBbaN9k36gNbk5tz
	OpZBIYlUN9ZpgAfaREXusCe3mD/7qejeSncEo39mT/r80PCFQtyu
X-Google-Smtp-Source: AGHT+IEnfcqw1dposaLZI8nQDfMC73a/CsNxVFuugjcOmg6G9COmsOORjU8+W7oUYDRexswUM90IQg==
X-Received: by 2002:a05:622a:5988:b0:453:5c37:3391 with SMTP id d75a77b69052e-456965b037dmr69668061cf.7.1725149486512;
        Sat, 31 Aug 2024 17:11:26 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682db92cbsm27140501cf.96.2024.08.31.17.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 17:11:25 -0700 (PDT)
Date: Sat, 31 Aug 2024 19:11:23 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] sched_ext: Make find_dsq_for_dispatch() handle
 SCX_DSQ_LOCAL_ON
Message-ID: <20240901001123.GC70166@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3wLKQZUBLNtviTVD"
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-4-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--3wLKQZUBLNtviTVD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 01:03:47AM -1000, Tejun Heo wrote:
> find_dsq_for_dispatch() handles all DSQ IDs except SCX_DSQ_LOCAL_ON.
> Instead, each caller is hanlding SCX_DSQ_LOCAL_ON before calling it. Move
> SCX_DSQ_LOCAL_ON lookup into find_dsq_for_dispatch() to remove duplicate
> code in direct_dispatch() and dispatch_to_local_dsq().
>=20
> No functional changes intended.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--3wLKQZUBLNtviTVD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtOxKwAKCRBZ5LhpZcTz
ZAmZAPwMaJSXuwKRl9Jj0VSi9nYOxX0R+63m4oQDjj5s6OaM+AD/ehUlyU4e3Hus
y8DtaZqszB/+umtjV54OKx5H+IItngU=
=D1nb
-----END PGP SIGNATURE-----

--3wLKQZUBLNtviTVD--

