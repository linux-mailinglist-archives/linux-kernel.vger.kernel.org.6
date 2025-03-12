Return-Path: <linux-kernel+bounces-557522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4DEA5DA58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EFA3B76F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7595423C8AE;
	Wed, 12 Mar 2025 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g0zL4dey"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997E23E326
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774773; cv=none; b=SadkIZPtH35PO3KVZ85Zp4k8jpPLvaKFumgFggbCY4obAHqZCfFPUu5HtgL97+W277DflmgCIY8GCTHWHHKEa82dhqqckSF2gtFSUG84cF+Z9I0F+GUwsourLuraH+JieIivIPxndPIz2Uzq1wHZvg2epPOMgr6awBOvzwjhmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774773; c=relaxed/simple;
	bh=28xJg6gapHqktUP3G98ig3pZzO9ELnPrig/osmgFQUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sVbjqEq+DPv0Nsj0rKScXlm7n5WNQkinefngDH74PoplJhB7HXcqEi6XU+fBVtAh8YgPjBgZeeGbN1opv5169wGS4Ryss6OEbMqIW87WaGfaOPP71qE64Oxvi85N4E/ym+avZN8TZE/iSSWcANCjG3nB+NJUIgem6MZXOz8fjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g0zL4dey; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 3FEEB583C7B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:59:59 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4370F43212;
	Wed, 12 Mar 2025 09:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741773596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YE1jiy9kN43iGRytxK1aWHUVaHmUxNQdzJgC95dMlMc=;
	b=g0zL4deymrtd8MN4KO2/Qh7LgNN5pePACqlhrAV6WkWqMoKBwxG0oldRqDgAvRjqrr6w2M
	2uLmzsOuKNrkhBMPTOz9+xtj+OIguIZfI3z58WD+j47Hny2W6obQSARDoltGTDP7BN7J4k
	CwgunAMYVaAwHGXke8uG9W5jwb/oM8lUI+2AxOPXtXqG94A9/tKCM3ppdmJSpnwOWbsipQ
	jXbA0eYVFwJ+IAD4l+7FaGmEDP9HBalpBnX9gRgFxjjZd7rnv7jnyY515n+bJIwTviqo2J
	u62kZaaAsmNCtGiX504fufXtu0ttiwm0Frns7AgsKzc8Or9hC8eJRSHrF3JiLQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226-drm-debugfs-show-all-bridges-v8-0-bb511cc49d83@bootlin.com>
References: <20250226-drm-debugfs-show-all-bridges-v8-0-bb511cc49d83@bootlin.com>
Subject: Re: [PATCH v8 0/2] drm: show "all" bridges in debugfs
Message-Id: <174177359506.2719371.292782597798658368.b4-ty@bootlin.com>
Date: Wed, 12 Mar 2025 10:59:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdegjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthejredtredtjeenucfhrhhomhepnfhouhhishcuvehhrghuvhgvthcuoehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejheeiledvkeeigeeluddtleejvdfhleefleffffeitdetvdeltddttddtgfelteenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgdujedvrddujedrtddrudgnpdhmrghilhhfrhhomheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopegumhhithhrhidrsggrrhihshhhkhhovheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepjhgrnhhirdhnihhkuhhlrgeslhhinhhugidrihhnthgvlhdrtghomhdpr
 hgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com


On Wed, 26 Feb 2025 22:23:51 +0100, Luca Ceresoli wrote:
> This series adds a /sys/kernel/debug/dri/bridges file showing all bridges
> between drm_bridge_add() and drm_bridge_remove(), which might not be bound
> to any encoder and thus not visible anywhere in debugfs.
> 
> It also cleans up the DRM bridge debugfs code by moving code to
> drm_bridge.c.
> 
> [...]

Applied, thanks!

[1/2] drm/bridge: move bridges_show logic from drm_debugfs.c
      commit: 9497c5a0f7c26ff81f11df738a94c6b80f890c0a
[2/2] drm/debugfs: add top-level 'bridges' file showing all added bridges
      commit: eff0347e7c228335e9ff64aaf02c66957803af6a

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


