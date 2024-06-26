Return-Path: <linux-kernel+bounces-231606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D99919AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983661C21C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77563194158;
	Wed, 26 Jun 2024 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HPD+KyCU"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78816D33A;
	Wed, 26 Jun 2024 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719441284; cv=none; b=CzAbZ9QUP3GCnHG4v0xZeGifNhMp0Da1DD5iX5usmPJBYMhCJcByfYuSL4qZ/jO8CRiBbn9G43ppCrJjGzeNGTnYAoa9EyK6nR/N9ylrq5sTnfdDBlFWI31mwdOas9/mp2bgUhXDokzG8PnwpIIZqKPwJdYSs7kH07auvWv3cuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719441284; c=relaxed/simple;
	bh=/D23BNJJrMHedj1VDlfPxn1b8cpcMtjGEKw2trHD+fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qlirq5/EKLrg/E1mZJpkLpXcCNZaFJ6YpUGiARdyWEwGahD4FzbhXHqeopJM4li489azBKYZwRoi0EKmOhgdtmCEIZYlqpoC2krqyH1qPJhfp3ciQpoZl7r2Tp3WgDVqK4PPUPv9AWtudZIxwJdwoUyi2g0zD76Ok75heWfbqQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HPD+KyCU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7859345E2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1719441282; bh=gMOPHcarQixtV+jPYg5ZGtLbw0+AFN5Ero2NvFfEWDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HPD+KyCUi5/bvPHqjOfoNO1sLltTNlwofqndxXFWPw6bBvN3Xsv5v/s0j2n63IpOJ
	 f4bcwqsCAZ7DB9v39OOJt4B/pKcc7QjQzg8rQNabYB+ySF6X6z6h/kAx9nnLTSXJWX
	 FMhWburEUbWNHLuSND6uW1FzXwx8YVD/zW71mnDlyG+NG2UtbSx2kA6F1vVnzjtai2
	 Is4FX0SqQRl2L/8mSxU/NqmW8as34y0wlJr+mnNCm5CRY6hSC+LNKP4+4pl0ca1V/g
	 Xr9zv2ssG16h1P9PLmAnNJ40Rk6NVbmNLdrAsTW9hd09/vebbkX5IViVlfT7yJc86c
	 JTVk98HQhjuuw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7859345E2B;
	Wed, 26 Jun 2024 22:34:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: SeongJae Park <sj@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, Federico Vaga <federico.vaga@vaga.pv.it>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, Avadhut Naik
 <avadhut.naik@amd.com>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <siyanteng@loongson.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] Docs: Move magic-number from process to staging
In-Reply-To: <20240624185312.94537-4-sj@kernel.org>
References: <20240624185312.94537-1-sj@kernel.org>
 <20240624185312.94537-4-sj@kernel.org>
Date: Wed, 26 Jun 2024 16:34:41 -0600
Message-ID: <878qyrz62m.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SeongJae Park <sj@kernel.org> writes:

> 'Other material' section on 'process/index' is for unsorted documents.
> However we also have a dedicated place for the purpose, 'staging/'.
> Move 'magic-number' from the section to 'staging/' directory.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/process/index.rst                           | 1 -
>  Documentation/staging/index.rst                           | 1 +
>  Documentation/{process => staging}/magic-number.rst       | 0
>  Documentation/translations/it_IT/process/magic-number.rst | 2 +-
>  Documentation/translations/sp_SP/process/magic-number.rst | 2 +-
>  Documentation/translations/zh_CN/process/magic-number.rst | 2 +-
>  Documentation/translations/zh_TW/process/magic-number.rst | 2 +-
>  7 files changed, 5 insertions(+), 5 deletions(-)
>  rename Documentation/{process => staging}/magic-number.rst (100%)

I'll apply this for now, but I really think that this file, which has
little to say about Git-era kernels, should just be removed.

Thanks,

jon

