Return-Path: <linux-kernel+bounces-433907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB619E5EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E205E18824B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D0225788;
	Thu,  5 Dec 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQYDzPsS"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17B218AAB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733425840; cv=none; b=Kj4i5D7AbyNBzqwVSXznk24YWqwFVaiIkNAAw/4bvV1UiFjOkOX3R3sWiVOUbrSAfwQr68H52S7KWyXq8nFxGVYRh9gQArJMJUbqVS9qcBJs8GbQ9VtEEm5+SGXRzeuvZzT9vm430w/Wpmude4P5WsP2jRv6aQMt8j3u1LBCD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733425840; c=relaxed/simple;
	bh=0JOKcMjrSG6aj6AIJO2JxGS5M9AVOqmJUhLj4Yqo7Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvgCrI6wkJolA6vdrDULBqXUw26Qe69tttJYxBfAkU0In/VhjIEtY+ZoLOyKsUyTQuCUF97ZVd+kvhdGLZqTQgMRXvrp3JGbF1Q7QBqB0SGYwN91n0igWvemINFMfxPkyxQJe900OAvS82we1RFba+uheXtzA1J0CKEo2oBKLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pQYDzPsS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e0844ee50so1409735e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733425837; x=1734030637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQVG1tQuHt3SHcx2mPIxH4KYBUQ1F6QooRs+6KQiv2g=;
        b=pQYDzPsS6rEGj/XsMdsewEGb2U4mJ0hbUCXLxVBqhAMIazYKHZ4+WoWdODioAgm2WB
         KUmp4sTapfWiMXP9FNy6h6n+3oFNe5sdYZcrmARK/ZFT+7pTDwtPuyiFR1YmuO8c2Csn
         MsLFVLzrkwWbUYNDDI/IAG/oyFteC1wZOSI1wdE2Y1VIxcp1GVLJWG+pZNx7IYH0wY0c
         sX1R4Up61fYe6FCwJIjN+bIkoNuSDBsMoS5oYBCLKiADM8NJtW5dw7Qce7lUwTPDTEhh
         qH083DBluvPb/6M0uwQ4fLdS88m3XfpBhIKJiHA1FX14uuoQVoX5GN3b2xO7vQPeWpI9
         tc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733425837; x=1734030637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQVG1tQuHt3SHcx2mPIxH4KYBUQ1F6QooRs+6KQiv2g=;
        b=QYC2t3Dwfy6o/KkIXRvq1GpMwoS84h794XRFQXsaVGc33r/olw3NsPduxEIBuL9+5j
         OX0q/O0AjLsp64r52eQTIIorqh1zOWNPvso9WU4aFRHlo1wMJmpTsIkt8FEjtggTfNvS
         bweTWJz6PwH1jDrzDorKdBGr1zIbfguBd4OChvcWMua1oaUSUY0OGgOMsQSJ/TcJ4QC9
         pBUUK7bTZj4wS5MyT3CgZ+QtzblDFNLb43R/fBydy8awILzu8vjtzJ6G/PPDrTkNxuia
         OT1UudXQbL7BRWMibg2/2PEouoojQgCB1/FGOwUGDJbtr2hUki1MzVm6jPyHug9ruZA8
         j15A==
X-Forwarded-Encrypted: i=1; AJvYcCVEbkdNCLVIMYn2DV4Z35jeSKN0kkN9EQ4wwgOVnAdhf+6104H1m4yRLzBsNuyfG0Wa7TyRX3s+LceTgqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfABNNMqpnYgOr7Pu0o2pqgiSpYi3vatCUBgFdW16uo9hJ9CT
	izwwwZRc1TlvOnPKDDlVKut9zIrwpcgfasWU2GH+jq/z8babGFh2nvwrV+3C4jI=
X-Gm-Gg: ASbGncubfvU27q4GMHYMxVyNGujZLzq9uAyc09a+zQK7WDAia4BtlGfueLMuhhZeQcB
	dwZuw2fPtSnGxuQSYETKST3iX9RiqZ53EuOnrmYHxJwIqsoAbgIXBY8jnGVyyk2arTXKdS2vpXI
	vd8OP74si+ea5oTQf08GCCH38DmnH2kCtGekYUlRQZLJuYsEvHi6d8Hb+8vw+iK1kgb2TuctE+M
	vy+kxxKYXXpEIWur99JXe9NVRM4MlPlIuif2xkcH1MAkHeSCJUBcQp0aCab4/bmY+QkesuWcdYn
	KFhSigfO05GTCuFzzg==
X-Google-Smtp-Source: AGHT+IHUNLqaLQBuYan1ZGoMqkshI2yl9UY4KpKLMA9S8dD5jZebO/X3lWSvz99JLzTn4lGzisOwhw==
X-Received: by 2002:a05:6512:3c99:b0:53d:ab21:4e17 with SMTP id 2adb3069b0e04-53e2c2f0135mr21836e87.55.1733425836767;
        Thu, 05 Dec 2024 11:10:36 -0800 (PST)
Received: from eriador.lan (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e2294738fsm314252e87.52.2024.12.05.11.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:10:35 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v5 00/10] drm/display: hdmi: add drm_hdmi_connector_mode_valid()
Date: Thu,  5 Dec 2024 21:10:31 +0200
Message-ID: <173342582161.2533869.11795486713615996638.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
References: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 30 Nov 2024 03:52:25 +0200, Dmitry Baryshkov wrote:
> Several HDMI drivers have common code pice in the .mode_valid function
> that validates RGB / 8bpc rate using the TMDS char rate callbacks.
> 
> Move this code piece to the common helper and remove the need to perform
> this check manually. In case of DRM_BRIDGE_OP_HDMI bridges, they can
> skip the check in favour of performing it in drm_bridge_connector.
> 
> [...]

Applied to drm-misc-next, thanks!

[01/10] drm/tests: hdmi: handle empty modes in find_preferred_mode()
        commit: d3314efd6ebf335a3682b1d6b1b81cdab3d8254a
[02/10] drm/tests: hdmi: rename connector creation function
        commit: 67d31cd02c8dfb3d006dba62a854e6758cf7a0e4
[03/10] drm/tests: hdmi: return meaningful value from set_connector_edid()
        commit: a8403be6eea91e4f5d8ad5dbc463dd08339eaece
[04/10] drm/display: hdmi: add generic mode_valid helper
        commit: 47368ab437fdd1b5118644659a97a6e5dab45248
[05/10] drm/sun4i: use drm_hdmi_connector_mode_valid()
        commit: ae048fc4f96d716a2ef326bd6e894694057c078c
[06/10] drm/vc4: use drm_hdmi_connector_mode_valid()
        commit: d4581ae8695863b21f9b739dddce8159f3068ca3
[07/10] drm/display: bridge_connector: use drm_bridge_connector_mode_valid()
        commit: 54d7b7f9d637a53ba19d117eb9b01619bb1704ed
[08/10] drm/bridge: lontium-lt9611: drop TMDS char rate check in mode_valid
        commit: efda6551aa866b80dcb5a94158d805c560fc4f1c
[09/10] drm/bridge: dw-hdmi-qp: replace mode_valid with tmds_char_rate
        commit: 2d7202c6f38d14260a3998a2aa249a53415a24f5
[10/10] drm/sun4i: use drm_atomic_helper_connector_hdmi_check()
        commit: 84e541b1e58e04d808e1bb13ef566ffbe87aa89b

Best regards,
-- 
With best wishes
Dmitry


