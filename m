Return-Path: <linux-kernel+bounces-420187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C679D7691
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDC1164C9E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BDF53365;
	Sun, 24 Nov 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e5gRR55a"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77601433AB
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468827; cv=none; b=t/lMrcUnoE+ZaFvRokvJnTVyk/gPhA7M8WGph5R35jtWdzhWA3LDx7Ux/WzxgH2kW7JlhLkUFeHiBg8c3ef06o6afY/n9wlpb5HFdVpljYbBX4EFi2XKic+1gO+v0SMBGT/tM3sDxrDm4oo+r8PrymzNsFI8at9rCESjYCs8cCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468827; c=relaxed/simple;
	bh=oTVUStx1Sq8VhcICsbjF8KXRzqMXiVCnwCfJV/n/i6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4OQa5+iivdSabu852qtU3JWrYD/nqNnIEzzc+COxMDSXlRBJG8P0I9VF6Pol+DwxgBsxHgVytRwBDhSTnMAIZr89KMTe5tDY1Piq9uURZCtATf2Dtc/0VfBy3yyPYxWbavzSePSf+CEjdsYN3SisoAWZZlJ3iMwPOWAypo/nqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e5gRR55a; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7d74caae-6a4c-43e6-ae5e-d2955a9a9fcf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732468821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB/DaOTNV+23hCf9768jgIKuISC0rsE5LCF1LNpxYYc=;
	b=e5gRR55aJN4T5yDft72qC0iZ0glYBjzo7FdPXuOpqRm+xfJ8qVzvGbF88tDZX4S0MdXYaX
	BC81uiBuzuGOluq4uJ/1rnue8Ldbsg/9JMwpbbzk1eFSAEez/tZbWP59C6qWf6ysHusFpe
	qUoxhEzLAuAe/5germ6xgp0o2824smg=
Date: Sun, 24 Nov 2024 22:50:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/7] drm/tidss: Remove extra K2G check
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jonathan Cormier <jcormier@criticallink.com>
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
 <20241021-tidss-irq-fix-v1-3-82ddaec94e4a@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20241021-tidss-irq-fix-v1-3-82ddaec94e4a@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/21/24 19:37, Tomi Valkeinen wrote:
> We check if the platform is K2G in dispc_k3_clear_irqstatus(), and
> return early if so. This cannot happen, as the _k3_ functions are never
> called on K2G in the first place. So remove the check.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>

Regards
Aradhya

[...]

