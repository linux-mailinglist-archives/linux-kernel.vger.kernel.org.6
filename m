Return-Path: <linux-kernel+bounces-553729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657D5A58E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045887A4274
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68846222589;
	Mon, 10 Mar 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="lQvNuWi2"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5564117C77
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595416; cv=none; b=RQXYj/ybexzQGr/7GNX62h8CbRHyHXgqntvGgwNXK+fkewVBVmwkWmSdUQ3T9j94X4NLu1fAYQNyRMalLoMwar05G03jMXZ3yxvox26qdT3R5HAaGrxBgW+Z3A27HgDAsoT7TPS8WU/9NE1RkCnCSF8F13pLPeqENfec0S/Isvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595416; c=relaxed/simple;
	bh=Ub4+sfEkaTuvoiFXp6g227hjeLcn8Ebx9FY2V0fxJtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYGdlKrS9r1yTmlNx79uNDSYtXHxjp2f+MtEyc7zU5AqwI5iMOH8asMgMNIxFzB99d7DYy5ZSKalMU9845JP2/2S1w6XvXSwZcNyuC3zrfJQqdVCAR5/yys2CLAaQzDZ6HMyLmHrgyBaGdw0p22KoqJSZRcjzgR3DYRklHL7W4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=lQvNuWi2; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 500134501F;
	Mon, 10 Mar 2025 09:30:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741595413;
	bh=Ub4+sfEkaTuvoiFXp6g227hjeLcn8Ebx9FY2V0fxJtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQvNuWi29bFC2oHJB1sakgj/Xa1ojVvvIbN8BMQLpWEe6loDPNAM3dGciN840ldP2
	 H77ItSolIsdRKb9zeboBBneqiALH6v1sKK0Lu+id5BBzTnSrFOcDy4ah7sLu85sOKK
	 z/S9N5ZvXL2cIeSGCg1KwpsV4kyTb9+bOVgX5mWxQKNOJ36zvgXHG8qYkKZmhrh2M5
	 qAznYyosQp7K7N5GGrVIbmgixd0rue0gaFOzvGEzD3SH/EgtHNKD2hC27YojPoPA9i
	 hCkKqjjR8q7AOrgkpp8Tsdmf9Jqy6+XELbyZf/Q91OEtyVTfo+dHsViB1Elc1d6QcR
	 aRZdY0NHghOGQ==
Date: Mon, 10 Mar 2025 09:30:12 +0100
From: Joerg Roedel <joro@8bytes.org>
To: fnkl.kernel@gmail.com
Cc: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 0/2] iommu: apple-dart: Support the ISP DART
Message-ID: <Z86jFK0IS5aja6mC@8bytes.org>
References: <20250307-isp-dart-v3-0-684fe4489591@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-isp-dart-v3-0-684fe4489591@gmail.com>

On Fri, Mar 07, 2025 at 09:07:44PM +0100, Sasha Finkelstein via B4 Relay wrote:
> Hector Martin (2):
>       iommu: apple-dart: Increase MAX_DARTS_PER_DEVICE to 3
>       iommu: apple-dart: Allow mismatched bypass support
> 
>  drivers/iommu/apple-dart.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Applied, thanks.

