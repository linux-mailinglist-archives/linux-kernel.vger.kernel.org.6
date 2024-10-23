Return-Path: <linux-kernel+bounces-378767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D19AD541
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E89282CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202701E0B6F;
	Wed, 23 Oct 2024 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gA2paiJC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D91DB344
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713365; cv=none; b=fgYwwvGbgkmfCWG74VjjbaOfzUoCT6TJ24crb84wF8uRsls+6C0j1AXlrlJfTHk0OLNW5nruZ9BPplq0pvlAd8t2DrQ4/Jt2K96TT27ddB2d5AfQlz6XT2JMpCF5YSh4D3RE5olRhIHKDltFfN3p7GLHEP20QVEqFiXqyUIjCF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713365; c=relaxed/simple;
	bh=2eGHmJWpTtKq2UCn19+DLfNCWbbeEMvh4tEJO3QfZAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTRc+xqQR/XguFfGkgnb6vwYUg6ehueAMqRtBoqBgP4vQdGe2RyQxP0RBgaZP6K7g2YMrRnCgCY5lsR/hdkWvVm6wwONwte3hpeL4c+xNfyoLEpSXVm15R5J4jbviJHHbieQYV8WOhbA2snANvqO/gYor9DZxrCtsPDE9cO3/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gA2paiJC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729713361;
	bh=2eGHmJWpTtKq2UCn19+DLfNCWbbeEMvh4tEJO3QfZAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gA2paiJC92mudSnR8YyTFNbcubgzip/VTq5MZfltH90ocje1KVVd4HME7Gttk1UXh
	 N5s16qKAPZ9RHODI6CIaLeAb6E4p39arDDQDiT0bJdmxj+Jyej9lVp7pkikAli5BlQ
	 OTUoCivLOmkKHc5MhJ7t0Zid4KeFP3QAvJ7CESHate0iHwdW/QCDkg20+V2B+897Tp
	 VtqsTwBcer2k+qyrGl5UH4zAm3Z95QAMII86lxVWfuKtF8lbZzqJevUS4YB/HKspuC
	 jwBFnSVjFdf5aD/yUO8DiYrsWyM84v8HEhSZoB3KFBTI8a0NR0zntmITfRMh5UEmBE
	 9x/5laTCVAmlA==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 26AFC17E3703;
	Wed, 23 Oct 2024 21:55:58 +0200 (CEST)
Date: Wed, 23 Oct 2024 15:55:56 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jon Hunter <jonathanh@nvidia.com>, kernel-team@android.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] drm: display: Set fwnode for aux bus devices
Message-ID: <7a8dede1-ef29-4553-9412-de8e2f45b860@notapiano>
References: <20241023191339.1491282-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241023191339.1491282-1-saravanak@google.com>

On Wed, Oct 23, 2024 at 12:13:36PM -0700, Saravana Kannan wrote:
> fwnode needs to be set for a device for fw_devlink to be able to
> track/enforce its dependencies correctly. Without this, you'll see error
> messages like this when the supplier has probed and tries to make sure
> all its fwnode consumers are linked to it using device links:
> 
> mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0
> tegra-xusb-padctl 3520000.padctl: Failed to create device link (0x180) with 1-0008
> 
> Reported-by: "Nícolas F. R. A. Prado" <nfraprado@collabora.com>
> Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@notapiano/
> Tested-by: "Nícolas F. R. A. Prado" <nfraprado@collabora.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/all/20240910130019.35081-1-jonathanh@nvidia.com/

Hi Saravana,

the issue faced by Jon needs the exact same change but in a different place,
drivers/phy/tegra/xusb.c, which I posted at:
https://lore.kernel.org/all/f979aff2-34f4-4f6d-bb9a-03a02afc4635@notapiano/

So we need two separate patches, one for each issue. Feel free to add that to
this series. (I could send it myself, but I think it makes more sense to keep
them together)

Thanks,
Nícolas

