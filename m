Return-Path: <linux-kernel+bounces-420190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D64D9D77C1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F537B28F35
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F95C53804;
	Sun, 24 Nov 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c1NDafdB"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE629A9
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732469186; cv=none; b=d05ygpm7j8kExdIMw5msvjae0qhgEJOW5f90JwmJcudptK4M1Lc9psMnRwuJvG+2JmsU5K4NMx1dAlHfvUG5rveKp7lu7Ofni9SX/U5ijKq8DlA4dsNjyL3/Ccad0+2NL5zi/SnZmTDacSx5q5RTWk4CB86JxeIFCmupK1vhTZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732469186; c=relaxed/simple;
	bh=m19Kp7mMI8MYbohPzKg1/Hq4+gxTJM6g/ldFdn6kUXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ej6lrRk+96wQjnLcjN2NZHeG/ghjL4PopnIiTP9oO8sXOPrF3OZiXKnOTbczwvSFI8K4VoMCseIBsss4sfdrRFe8S8uQxjDdH2T1ribYABwlt8K8Gt3Vv/F3KUS3t7hIXrjoco5Ya7Uc6Xtro0tUewReCO6jn4P0mLWpZOLoYlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c1NDafdB; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c4273ac2-4ce5-4fa9-affc-db5081eefd36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732469180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bhx9GWrlh15tI8+NICW2csUyfRfC9547Fo3fTXaA0fc=;
	b=c1NDafdBxg0t3m+Ux0StZjGw1GnBATsMTOxH9Zec0zbHL5rfmcmBQ25WFppQFV6WpcLNxp
	e4fAgz0ubhjej+w7ClgTcl+okBKfVfo/Tfu+iwdIcv4w8ra7VkwuVfEz0T+kiiyuPXf4QY
	vVy49Djfe4eQqlFkUlkYsproyDZpmwg=
Date: Sun, 24 Nov 2024 22:56:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/7] drm/tidss: Add printing of underflows
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jonathan Cormier <jcormier@criticallink.com>
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
 <20241021-tidss-irq-fix-v1-4-82ddaec94e4a@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20241021-tidss-irq-fix-v1-4-82ddaec94e4a@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/21/24 19:37, Tomi Valkeinen wrote:
> Add printing of underflows the same way as we handle sync losts.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>

Regards
Aradhya

[...]

