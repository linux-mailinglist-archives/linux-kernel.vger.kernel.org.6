Return-Path: <linux-kernel+bounces-420193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBB69D76B5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AE31643D7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201845103F;
	Sun, 24 Nov 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nPBzh11L"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E455336E
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732469358; cv=none; b=FEyvijS1rJHOEqbTxWQUPpT4/6a6AMHpIsrrzjCoFgmL8oIDcr9uxleeHroGNyN81el0mMx4ut1LnpCZOn55p85TGTyrFgJ4phO9E5IwYyv5lHhU5yS93EVHE6zMvHDcgI8+1TwN+XQ4FZXfyhnN8QJ5FTcFdL/XpA6PLLgVK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732469358; c=relaxed/simple;
	bh=x/9YCTJtzXjFmlHzX6wKtA5B/Rvf6drfPHI8SxoJVy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bwj81l+D+xhXUOBBUUepX3ewua0W3eMn/HPN1s9USegbxFMw7ADZseROPvIgzHfPAC4+rosp7F/yQWbj9oJ3fkxvF4yx79RLTmMh/69ATtM4cRn3oxpKZOv3F/kAZ3GyJhJLEjOWBAMSd5FNv4b/6Na/k/PnuSM6UCYkuuLPVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nPBzh11L; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <46d85c32-7181-4fdc-81fd-041f2f48957e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732469354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yPrjpApjI7+sunD0DBOT2pilTdinEYc/vCqHPllEbY=;
	b=nPBzh11Lzsi7gx5857ZRs2AQbwqOhVzjL/7T9ITFuwut0X+63GkPqSRhcVYUzb1avc6zYn
	Qhtai//HltCI+9AcTb5hAF9KScxJW4O4m13+VoRiVnwSeQXtTtNxAG9dPK11qh1RCbgYRl
	3C4VjpTjXzfxD+TPRrfgopypzbtaX+Y=
Date: Sun, 24 Nov 2024 22:59:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6/7] drm/tidss: Fix race condition while handling
 interrupt registers
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jonathan Cormier <jcormier@criticallink.com>, stable@vger.kernel.org
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
 <20241021-tidss-irq-fix-v1-6-82ddaec94e4a@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20241021-tidss-irq-fix-v1-6-82ddaec94e4a@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/21/24 19:37, Tomi Valkeinen wrote:
> From: Devarsh Thakkar <devarsht@ti.com>
> 
> The driver has a spinlock for protecting the irq_masks field and irq
> enable registers. However, the driver misses protecting the irq status
> registers which can lead to races.
> 
> Take the spinlock when accessing irqstatus too.
> 
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> [Tomi: updated the desc]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>

Regards
Aradhya

[...]

