Return-Path: <linux-kernel+bounces-420194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D519D76B8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EE4164A67
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186157BAEC;
	Sun, 24 Nov 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nSqf4itm"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A31E664C6
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732469420; cv=none; b=Q9uSpZmaownLhyCWxouxVCJaBczhO2uYQCDDwRHgbsaIAEghNm6Tova+JPW6XXffxhur1qfOSrx+BVUKYfYfbYOP7aJI8Vru3z1K0fgpMNIYMrS+Xe4Q0J7aZc5X5qD7OS7e1hlA58ydIdWqfOAa/ibfsvzFawrN0i+AAFAUDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732469420; c=relaxed/simple;
	bh=EJ3K/diBSYpKOFSN2kAXlHy07iUDkk3cbKEZu/TU5bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4BEoaEtjy2RDbY0zJQoVcoWZKzeIE8/L9FcLLO1N9vW7QeNbLB0t8a83NSW3CEmbJ+zrV9u0UXf7xH8w2JEi9YyB+PhqckSMxIV9WAs0bdXLmB/NjTdflkE+bYf9NWrMSrGRRAEEnTI6khubxDZ2eX6f8PdRywJoHO15I8rEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nSqf4itm; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <561af7e3-dd81-4b56-abf5-46dbc29e722d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732469416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rK1mzmJ7vpkr+04+AqkMIb5woGMrT4y42UHtCqLFTmo=;
	b=nSqf4itmaNqH9PVzApKVjjqJlI8hDj18w/GAfwGpTjMBDORyMJI65keO8zwBWzyi2vSXI1
	wQm6mYniY5rEzTwWwYxWhg7Yz49e6duo9dl3Z0HA6bQ5u1xqU6QpdyFVPOPUe5/vLDYvLZ
	ysHRTLdrmrrdXuiXdbmlzF/B64lK5mQ=
Date: Sun, 24 Nov 2024 23:00:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] drm/tidss: Rename 'wait_lock' to 'irq_lock'
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jonathan Cormier <jcormier@criticallink.com>
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
 <20241021-tidss-irq-fix-v1-7-82ddaec94e4a@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20241021-tidss-irq-fix-v1-7-82ddaec94e4a@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/21/24 19:37, Tomi Valkeinen wrote:
> The 'wait_lock' name seems to be a copy-paste from omapdrm, and makes no
> sense here. Rename it to 'irq_lock'. Also clarify the related comment to
> make it clear what it protects, and drop any comments related to
> 'wait_list' which doesn't exist in tidss.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>

Regards
Aradhya

[...]

