Return-Path: <linux-kernel+bounces-516810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D08A377B2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E238B7A2169
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D22019D89B;
	Sun, 16 Feb 2025 21:06:24 +0000 (UTC)
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FABC7D3F4
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739739983; cv=none; b=Y2n2+kace6qcHZ4y9NcLvKaKSfdB8L3xNFgFDiO/VIuHwpXCy39Xh2IhAyT80lWwhCjpBp5lTZcBhp2UdAmKUQjHVZNMVRVE15u8wnN/xzg2nX3olJh7xhPTFM+4t76ltmCU5QIjd6RyVy1RhpPH/fb/htxtB2VeMNBBUvn2qT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739739983; c=relaxed/simple;
	bh=/lJW4Nwa9drddAWPmv4yfiD0e1cGAXOU5bzRZiMUNdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/89MKqcvNZvok4SfZpQPRPCg9cKzeuLvMOUhQ+VEzZS2ZAZENENVIrXoigtqRqBbtAuV3E4ukBtwtl92jSnSB3yPpyT9gIr1jzbiqXtDAzFNEYxvx62aR/NJVZeBKix17qF+Jeb6YYT8Ssz6Rz5UPeV6uB+P9YCR5xffRIg830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1tjlXh-00000007Mme-24sX;
	Sun, 16 Feb 2025 21:47:09 +0100
Message-ID: <ecbc5fd0-06fd-4de3-b77e-f0af24377f12@maciej.szmigiero.name>
Date: Sun, 16 Feb 2025 21:47:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/pm/legacy: fix suspend/resume issues
To: Alex Deucher <alexander.deucher@amd.com>
Cc: "chr[]" <chris@rudorff.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20250212161129.2712730-1-alexander.deucher@amd.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Disposition-Notification-To: "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
In-Reply-To: <20250212161129.2712730-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: mhej@vps-ovh.mhejs.net

On 12.02.2025 17:11, Alex Deucher wrote:
> From: "chr[]" <chris@rudorff.com>
> 
> resume and irq handler happily races in set_power_state()
> 
> * amdgpu_legacy_dpm_compute_clocks() needs lock
> * protect irq work handler
> * fix dpm_enabled usage
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2524
> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
> Signed-off-by: chr[] <chris@rudorff.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name> # on Oland PRO

Thanks,
Maciej


