Return-Path: <linux-kernel+bounces-303686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BFB9613BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6371F232CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8A619EEB4;
	Tue, 27 Aug 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="juqeHwTa"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C741C6896
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775167; cv=none; b=nS2TU9Bk5TXY5ZdcLI5EfEDxiogzjCSyaaeWFuEhgA+xh19oDq0O03zoWcAccRuHeiMVBab7x0Fe3XNZhm6+PhNG3QlHYH31w9GDb3xaDBeVKlIfyyxs/DaY7fxvbheYkH0w7UiLdXvn/32GdRXDlUtQWvJ+5cpShyrh6YQ0xY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775167; c=relaxed/simple;
	bh=nmXJAR6RVRD6mnPF65nLEdO2cbSiEydr9qRa6oOUEt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RHL7m4BuKcUNRi/0fwmSzLiqWCJHPUiqXTNtlA2O5DrLMqWgeFl67WURU80YHT8TKIhXcVMU5Dgg892Qm7SAZaog886iOsr3kyFXsYUBTEaUHaIJdLRh9X4QueEb8idZCk6pkTpA9DnK6ZWRLfRP0TMIIqhpvWjFnq6jn0EyjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=juqeHwTa; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8692bbec79so730340966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724775164; x=1725379964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=piJPr55iEdZk5ZJwGTOr2RVcn9q807tLtC9WUC+Aa70=;
        b=juqeHwTaQASHmMm863x0tQ8kBz/78dfAeNrs8kKx9U+qR694x4RQqBaEryopQH823L
         4ZoIB9AOtkNpcC8hUSokhc1P4GE9um6t6CB1VNn3ZO5ZXMNNlxZXIG4pOK8ZDjBG/dYH
         VfXfINyYXVMaIff5wc8YZt3mDbP596JMAobFgFd6zew8YONjzos7xTwCb3HuVo9+KCOD
         G8jZVuiKkH5iobA19xOJQaTfUUVoRe9ZD+bnGfFaBGoT6kJxXKKI6UeoYFJOfEO//FWT
         uEOfcmk6vL5+UV/41ratxRxlDW/Dk8OBR/gk7yF9JoTIgeaw3nouRxmJ6Pq7fRsPGrgS
         zZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724775164; x=1725379964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piJPr55iEdZk5ZJwGTOr2RVcn9q807tLtC9WUC+Aa70=;
        b=VAjWZ0rdfXUecLSBGvSIrJ1tva6rMMA9bOIASuzFtFktTNJtfUTZyV6DKQMOqLXRCh
         WaEL7slyfo1kBVCq84hcTCnVuOfFbGtjrf+tqmZr5AFsLx3VS+1OwT/mkt+jQxXSkhF5
         KAFoozjjtEoVaXk3tPSnSER/+TCd/BbBm/PgJstANYLvdqd7I4zjlFUGnpVHbltGAwF4
         9Yt9BdRsj2bT3IyUWUrpeJ4U6hrVeZod7Y50foMxbLhtlrnTf42fQK2HjugvJA+5q4VA
         /Uyz+ZbC8eLVAlcqttbHTUgeGYgljzG3qxeE2mpzYIs+UeKGIn+qF1cCZGMXHTxdoalJ
         lalg==
X-Forwarded-Encrypted: i=1; AJvYcCW1w8ZcW+APjPqpnVl/T33s3nfHXM6ZfCuUlbjTwT6HhzDf/jeUZ9Wv64GlaTVCIAp3i6F7TnS6PnHk40k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAFRsVWoT+WHTcpqLzdK2IxhXqJlcxUBXgdQwzk5i80bmGf3eu
	GIa80s+gM7srzgV5qiHKV49kdLaiHxsYOxhaiYlOLo5FXBj3ODZum9bcF10Q1dY=
X-Google-Smtp-Source: AGHT+IHW7b1aEQa8czupgCr/Z7h8PsBi0N06GP8cOqzjDQvW+B5ECoLogrJ2bT1xGLXCmUEfXQ5KRg==
X-Received: by 2002:a17:907:7246:b0:a86:b923:4a04 with SMTP id a640c23a62f3a-a86e3c1cfb0mr261149066b.50.1724775163715;
        Tue, 27 Aug 2024 09:12:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e54b50dbsm127893966b.93.2024.08.27.09.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:12:43 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: manikandan.m@microchip.com,
	dharma.b@microchip.com,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hari.prasathge@microchip.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 0/3] drm/bridge: microchip-lvds: Cleanups
Date: Tue, 27 Aug 2024 19:12:20 +0300
Message-Id: <20240827161223.4152195-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Series adds few cleanups identified while looking though the driver.
Please note that these are compile test only.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  drm/bridge: microchip-lvds: Revert clk_prepare_enable() in case of
    failure
  drm/bridge: microchip-lvds: Drop unused headers
  drm/bridge: microchip-lvds: Use devm_platform_ioremap_resource()

 drivers/gpu/drm/bridge/microchip-lvds.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

-- 
2.39.2


