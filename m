Return-Path: <linux-kernel+bounces-449550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E169F50B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88328170E22
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5F1F76AC;
	Tue, 17 Dec 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pb1H+ovL"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42471F76A9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451609; cv=none; b=UAq9Rv9yS7p/u9HBOirYu/Cq9MVMSn1WIEFQ79JyTxjOPvuhAILnsI+equaRGze8PmvMz30liod0HYyvfRw2Fl1De8LdwQnXTBUrYiTqnsjsCYtOG0SNNqOsD5KWW4iV9TUI68Wn2Vz4q+iJpi9fj9uWOlUtd11aMy5Sj6FxNCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451609; c=relaxed/simple;
	bh=8gV5mWWYmu0S4QNHmHlWMPxce9rA8S6G14y7UjuGALc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeM+xWgI2L1nqkCptp8ziHGqI6AX1ZXXysTlRR0TjOErzq7gk70c+Qg7kyqvZ/A5kSFq34Ke50xIboanrm/v0SwoVTFMz6KnwU1tFYgdoFpe/5MLaI5QA7ERERtKeMBwGo3oyc4yvWGolGyxeiDI/ZHnXQGUxU5IEVmxjRL1ftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pb1H+ovL; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41B2B20007;
	Tue, 17 Dec 2024 16:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734451599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7QDxB7ttCT3f928duF1sBDfU54SNcLGFr+6XlIU/P0=;
	b=pb1H+ovL4E89Ij5PpNP/cqdiiPIFrAs9145uI6YrgF5nkIcAjUN1pNY7yGSFeemDYWP0iu
	E3X5H5hzNUr1QZJF5es97OjH29DFcT5hLTYMIXFTknfFQpVpZlock4yLuDKpQZSGlR61aB
	vcZjBKUYKB6tFF/VAB1lctMnM+IpK29gGVkDdyPloFN6CU5405DX7NspCSOvp7WXn+KY2u
	37v+iGu+kLJzwWPT730sopSPxrap796PFEwQc7+WH+il/riE9mb1+ludRuzzF6aDorkfvs
	SpEthPUjYIiZPHnWS54ynDZuDEsoDLIELCC8WxjBERezo/itB5k/RHkZ/eTzbw==
Date: Tue, 17 Dec 2024 17:06:35 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Herve Codina <herve.codina@bootlin.com>, Simona Vetter
 <simona.vetter@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Louis
 Chauvet <louis.chauvet@bootlin.com>, Andi Shyti
 <andi.shyti@linux.intel.com>
Subject: Re: [PATCH RESEND] drm/bridge: ti-sn65dsi83: use dev_err_probe when
 failing to get panel bridge
Message-ID: <20241217170635.2ba35c08@booty>
In-Reply-To: <20241217-ti-sn65dsi83-dev_err_probe-v1-1-3fdce386400c@bootlin.com>
References: <20241217-ti-sn65dsi83-dev_err_probe-v1-1-3fdce386400c@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello,

On Tue, 17 Dec 2024 17:02:51 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> When devm_drm_of_get_bridge() fails, the probe fails silently. Use
> dev_err_probe() instead to log an error or report the deferral reason,
> whichever is applicable.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

This patch got a reviewed-by from Andi Shyti when I sent it the first
time [0], but b4 didn't keep it when resending. I think it is fair for
me to add it now, even though I'm not sure patchwork and b4 will catch
it:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

[0] https://lore.kernel.org/all/ZrtuksiarZNS8L79@ashyti-mobl2.lan/

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

