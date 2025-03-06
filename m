Return-Path: <linux-kernel+bounces-548403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E02A5445B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5191018921FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7268B1FCFC6;
	Thu,  6 Mar 2025 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OAmb5Orx"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCB1DF964
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248782; cv=none; b=KsvoUYg8pj8TiW9rOPd+UEQxhSiZ2nLUjnbi/nPir0zxbrrlNM88uIrSEquqgZDXpu+2aXU2H2aKRjq836QNqz8Dep7jyF7QoHJPxfBhEaPVSXcJ/NzcJHwC9xXpf5nLJmmZ5hXySkyA9MIinzctczLT7Op1H430DKEfuCvTJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248782; c=relaxed/simple;
	bh=fBjxN+xIt9ilCLdxyrcr3thnjmcBvvOorf9DKJTxReY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgVbN6bRG9vZdExCqf+kk8IGuR+X57dTe52oqSFhsbwWR69br36jkGRXRykM7E8pyLZFQkztDIbzJniw8NNWZobBtq+unShTDKzAZ3i/9GVJm1FTI3KQF8ykAZ7HaD1s9aZ1cSDpirnOsDiDTvZq4bPBOxBb6mY9rhg4St+9KcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OAmb5Orx; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF9BC442A4;
	Thu,  6 Mar 2025 08:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741248778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8EKlyOPXjkNZAG+QiNmAnCRyBkRUayYQjOTsTJ/8zU=;
	b=OAmb5OrxJqHbXkzQJk86hL/XvqDltPG4L41QY0wohsgUv6WMFdT3dW8BgiBTiGLZfY8PeA
	YrDQXB3Jlrw8vHAbkiqhwwdmeoRAxWsDGocfCEM1l++8vbw5Wyt91s5eBP7GSI+z3Axho2
	aij6fxN/EY0jsscgB5qFrRunZXsAXrYfa26h3BKGxvDSIbOtcXsXcTl7rLhawlXMEVb/+Q
	TvR7G4RJMy9oS359Ro+QJxXeTsx8Ejag3APkqFfAI5+fR+CcNJb8SmWanInbqeLE2VhoJp
	3y4A8JgBoCS25x7wb6A67NZ8FUliXyMaxgJG7wOB9yjUBy18rhQP7IyJdHmJ2w==
Date: Thu, 6 Mar 2025 09:12:56 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas
 Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v5 08/16] drm/bridge: Add helper to reset bridge
 pipeline
Message-ID: <20250306091256.2f0e2e86@bootlin.com>
In-Reply-To: <20250304-bridge-connector-v5-8-aacf461d2157@kernel.org>
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
	<20250304-bridge-connector-v5-8-aacf461d2157@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtkeertdertdejnecuhfhrohhmpefjvghrvhgvucevohguihhnrgcuoehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveeiffefgeeitdelleeigefhjeelueeuveekveetgeffheeltdekgeduiefggfdvnecukfhppedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgdphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhiv
 ggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrgh
X-GND-Sasl: herve.codina@bootlin.com

Hi Maxime,

On Tue, 04 Mar 2025 12:10:51 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> Let's provide an helper to make it easier for bridge drivers to
> power-cycle their bridge.
> 
> In order to avoid a circular dependency between that new helper and
> drm_atomic_helper_reset_crtc(), this new helper will be in a
> drm_bridge_helper.c file to follow the pattern we have for other
> objects.
> 
> Co-developed-by: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/Makefile            |  1 +
>  drivers/gpu/drm/drm_bridge_helper.c | 55 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_bridge_helper.h     | 12 ++++++++
>  3 files changed, 68 insertions(+)
> 

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Also tested on my system using the ti-sn65dsi83 driver (updated in this series)
with faults manually generated on the hardware. No regressions were observed in
the driver recovery process. Works fine.

Tested-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

