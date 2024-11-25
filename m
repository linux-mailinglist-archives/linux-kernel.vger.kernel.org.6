Return-Path: <linux-kernel+bounces-421229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FBC9D89DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C39B46F64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783451B2183;
	Mon, 25 Nov 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uQngW/k1"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD316419
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545753; cv=none; b=MFDViQ1DrTYbFM9FrjOaCZlJa3h5aSIhs33yzeagrmo79HOPC6HgY36iybZVVDSLvXs4J9U+4Nk1Ar0TlsvwQwrYBlnd7XaUMqkmDwfAh+yLDXjohhzc45VftZXGyUEkhmJepTO5VoQ2cKZ9t3NZXgzB+/xXqMzGDKDN2TS1FDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545753; c=relaxed/simple;
	bh=iACkCXDg/CzpXnOK8dpmgrm/S7Qydfd63Vqo29Ktq1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pD3OVd7Afk9V8eF1hAwTpZwK1XsQZ9GBs95snstmFRKWfR5ce7wud5yeZIYCcUGQUTzMx4kDiBXln2Soa3BYWmlo7gcvlnyjsFvi6M6Y0qdQMLGGtDCkY53JAtCL3oX9jbeqJqW7uKPPJhnv5Pbg0Pf8LS+Zhh/xNkHVdAeOLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uQngW/k1; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <060d97f1-34e6-424d-9060-b657283e9739@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732545748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oXr1hU3SpCJH4VXUZuIfZ1cmp8m2c58mEk8Ky+EMYg=;
	b=uQngW/k10fEaYc1ATAOFujVAtxubSQeARsxeV6fhYM0D4AXGKAv632NbvzceVjxgTERMix
	4zocKl9oTKjnz41NW7pfSV0Zdc9tz3y2KH+raeiyhBGxosIS53GJlgYaQ2bB4e4AXjXzJd
	3DlwwCPCne7xD6WXe/eS2PvRHG4pVes=
Date: Mon, 25 Nov 2024 22:42:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/lsdc: Request PCI BAR
To: Philipp Stanner <pstanner@redhat.com>,
 Sui Jingfeng <suijingfeng@loongson.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241125140228.58492-2-pstanner@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20241125140228.58492-2-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

Thanks. Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/lsdc: Request PCI BAR
       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/ca053ee3c6a7a877754e6f444ce5f520e3c0a856


On 2024/11/25 22:02, Philipp Stanner wrote:
> lsdc currently just ioremaps its PCI BAR with pcim_iomap(). Performing
> a region regquest additionally can make the driver more robust.

'regquest' ->'request'.

Please avoid typos next time, sound safer otherwise.

-- 
Best regards,
Sui


