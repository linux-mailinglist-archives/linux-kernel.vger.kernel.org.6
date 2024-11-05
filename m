Return-Path: <linux-kernel+bounces-396341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C999BCBE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9F91C228B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CF21D515F;
	Tue,  5 Nov 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqIPm0z2"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AB1D433C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730806137; cv=none; b=Y758dz3IVFGz/SNTKOqW3k6zk6ld/RjrBbjCz7Hi/WWoQYbFoBI43dtbX+iQOkNDiuDjlCD1vn4y5IN2EBl49MeQ4hUJhKalaVZ1KG0wouOzjh/uy7pxrtilxD6f/fkFybt9mq0urOFuJjU/Ng63Eo+RBQ99MCIbmabz/c5LK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730806137; c=relaxed/simple;
	bh=A1gEWSRfef7Z5iAxxFSzk6fEnhZztWmluE1Pr5DuBrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXyV2nLPmh2XBNbpWAlr5tAv+5rhTAT9kDPQIS3fk5FwiGh9FQGFjne2hKIuQnvnOlMGcrV4PQOEnf/rScOOYAqWU1rNFXuTX/VUDKQWYmQ6k1fxjW2AC1rnpnLww+ULEa45js6qLuPAqeXgMoqp4rxPiq/wJgVeO9kfZjwaOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mqIPm0z2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e690479cso5554305e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730806134; x=1731410934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lqc3fxtDc2RwHuGGy/EVNQGz4UxO/NG1km2hGQDTiaU=;
        b=mqIPm0z2y6q2AWojEGjO4swO9lOXZBTfuwHYIHlBU+v5LNiXakjGQZ329bLU7/Rv93
         fKpYuO62FHV2RODzDuHB1pVaqCeHwsAJX04FGKrm4w7bUOhov5RQSZgDVLz68zpEKVRK
         bZpNnPPX/DEXVhTGt1avhDJDEU81DQ1fsmaMaaH8yHJlVtNFSeohP2omlVy9a+Mw8kAD
         R/h+NLtBe7TKOOINw9oAIuYj6o1knlhoEH9WJ3DYExhRU7uzpXFIwmf6nBzygux/j4Xz
         pS2YEQS3+8iZYQGYxPZgsEKcEZ9htJ4Z4F+QHEhsZPmD6DAJQGgGcimALy255NVyK1nA
         /nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730806134; x=1731410934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lqc3fxtDc2RwHuGGy/EVNQGz4UxO/NG1km2hGQDTiaU=;
        b=L4vW3SaA4RnDeGFYY7qZOtxUqI6Z5k9MI8q5yCAF1zKDvPLe8CGJDFf6vbgBnn2w2c
         klx5u9uz/wNgYoIDItD74wylvteEGFZoo+mAgZUVBSKUSAo1kRRwZiY3q0cA1xrjracK
         l2hfJCISdd1f58K/OvT3ZKhpC5qxPK3BevWYYNGGFuQ2miDr74N7iCffJ08EhBw38H4/
         sMd7ln/nwIkyprchEvEtnULPCIOBVPQRS1frlVbgoNJf+weqb94FGV9ZM5QKQdffsLlK
         132l57LC657RYNRdQ2tDwv2YthLEtyU2Y2ZIDoeWK3b53O3Q8ZorMsA41zvfxNpuAi3g
         B/9w==
X-Forwarded-Encrypted: i=1; AJvYcCU03EFcvCxKO9FSKFoOeHog9fZBTGvb6YHGIrtPXYGgvoG9/z3Vff7DNARbygPGuPptav+NeTDBZz7gtjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCaWCvK0v5TYT/KJkB6rWUJjREaVwy5UDFtwcZretS3JuuTN3r
	OZQJDS0BzAVZDGyk1JNneQ0k70u5ibjU8U7njVtBon0DnrOB3p7ldSMwR211T3E=
X-Google-Smtp-Source: AGHT+IGazolcFL8rsDXTC+coJxYFbQY28nmJAc6aKVJwz0sBWevsWrSg6NX0J5MzQM2/Ky5L0ke0DA==
X-Received: by 2002:a05:6512:3e24:b0:539:918c:5124 with SMTP id 2adb3069b0e04-53d65df3203mr7408960e87.31.1730806134153;
        Tue, 05 Nov 2024 03:28:54 -0800 (PST)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc95957sm2098533e87.55.2024.11.05.03.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:28:52 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Liu Ying <victor.liu@nxp.com>
Cc: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quic_jesszhan@quicinc.com,
	mchehab@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	sakari.ailus@linux.intel.com,
	hverkuil@xs4all.nl,
	tomi.valkeinen@ideasonboard.com,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	arnd@arndb.de,
	nfraprado@collabora.com,
	thierry.reding@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	sam@ravnborg.org,
	marex@denx.de,
	biju.das.jz@bp.renesas.com
Subject: Re: (subset) [PATCH v5 00/13] Add ITE IT6263 LVDS to HDMI converter support
Date: Tue,  5 Nov 2024 13:28:48 +0200
Message-ID: <173080602214.231309.12977765173766280536.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104032806.611890-1-victor.liu@nxp.com>
References: <20241104032806.611890-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 04 Nov 2024 11:27:53 +0800, Liu Ying wrote:
> This patch series aims to add ITE IT6263 LVDS to HDMI converter on
> i.MX8MP EVK.  Combined with LVDS receiver and HDMI 1.4a transmitter,
> the IT6263 supports LVDS input and HDMI 1.4 output by conversion
> function.  IT6263 product link can be found at [1].
> 
> Patch 1 is a preparation patch to allow display mode of an existing
> panel to pass the added mode validation logic in patch 3.
> 
> [...]

Applied to drm-misc-next, thanks!

[04/13] media: uapi: Add MEDIA_BUS_FMT_RGB101010_1X7X5_{SPWG, JEIDA}
        commit: 5205b63099507a84458075c3ca7e648407e6c8cc
[05/13] drm: of: Get MEDIA_BUS_FMT_RGB101010_1X7X5_{JEIDA, SPWG} LVDS data mappings
        commit: 34902c2d022f9d36b739189efae3f5fd569983fd
[06/13] drm: of: Add drm_of_lvds_get_dual_link_pixel_order_sink()
        commit: 606410292f54ef08632bdfd5c58974cf4ebc3cc9
[07/13] dt-bindings: display: lvds-data-mapping: Add 30-bit RGB pixel data mappings
        commit: e3160748780c66f32ae5e7c17373c36a4a802bc3
[08/13] dt-bindings: display: Document dual-link LVDS display common properties
        commit: 8cd4937ebfeae03a094e9115ab3286bf01498a5f
[09/13] dt-bindings: display: bridge: Add ITE IT6263 LVDS to HDMI converter
        commit: 0a86a4d1a09185cebe071136599b7da619388f7a
[10/13] drm/bridge: Add ITE IT6263 LVDS to HDMI converter
        commit: 049723628716c7286d6265812567ef1b1ff4827e
[13/13] MAINTAINERS: Add maintainer for ITE IT6263 driver
        commit: 946f2b6a1c1383fb3a16780b425e0ddf40b3a2dd

Best regards,
-- 
With best wishes
Dmitry


