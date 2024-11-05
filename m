Return-Path: <linux-kernel+bounces-395917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB51E9BC500
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849E31F22A05
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2099C1FE10F;
	Tue,  5 Nov 2024 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXOrPVAx"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F21DCB20;
	Tue,  5 Nov 2024 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786049; cv=none; b=tSSY0jxARyH3PvgRf9CMDQgR0Nqs1zaLZdMLNQZKa0NnR2DfWHePj5EPyptZ+2nDPhDBfFmAKZdaAvuaRqcMPuk48OrXWtkyCWBh0SPLe1gqjr9QRM08eZhh5WKtGxYDFGtFfRqeJXkDDeBZculg+WFfA0hFZSTYvx/1NQA13Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786049; c=relaxed/simple;
	bh=M1QbV8jUSLdS3bCR5razbuOE+JbrhnHNbA3kueAHOyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtIT0T3qNs13Ov0DPxL+wfJ3ZML/O0TWDZNyZ+G4o3L7JTSlIyUHW51oG2adoWEYLD4YhOjLXtV49L9fBzpz14FTz+x9fui04Lt9w23UsWhhV2V9IrXu7xIhn0T6uOarFNyPWweN975+ZrsUqizP0AOJsTq0yD6vXrAYgYb4Tq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXOrPVAx; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso2633019a12.1;
        Mon, 04 Nov 2024 21:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786047; x=1731390847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4arZk0p0VPlza97zof+KayaWUIzMuwjvTBGsx2BEfA=;
        b=lXOrPVAxYyo9qMY+5MtKbw7eOFMnRPHB+g+nKy8g43qLDiJUC5Kz8BG35x191NVCep
         gVS3G30UUtio7DBo667xN9hHDlsJxK09YN82d2exjGrLqi6+aW3OtDd9Mhj8RqAsE02q
         +k90l/VyBIza/OaWWBEIWwlJQhO3NScf19N7TXyT2nzYkZ5H7cg+y6t8Z6/kWpuRxSEz
         Gv8gQnP5yGsxVt9SLYIkhcv+2Wj34aAOwXjB8+5bhrsY1zdX9Fc2YbG9jqyFb0b1zAn2
         iZRnlcHkhZDJwuNqJbbQRLtSAZ2tyG6uYDGxWX0nvFTuY90LntYi3WaGAfY9NVj4qBK7
         h3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786047; x=1731390847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4arZk0p0VPlza97zof+KayaWUIzMuwjvTBGsx2BEfA=;
        b=RnwPk+wpSBqxt3zb2YAdA7DKkASbPDd5N+yYeKjt62s7u97l1HJqd+QrWLUdmW+nC/
         bLyjS+eR9Bgb4YzxTMquqxKrNXDaZO1Ftuux6nr25u06YqwB3j1+02pbXMluib/HGqw4
         xNnJ5vnFV/DZ2oheJuZROsQImzvPXyGyja9YuypCEmx9lC44T/Sp9KuiuqbaGdhDVy4o
         iz2m6egAYG3NvJ7sxsYOewDnTP9yGKBn0hOI9Wb/PW8mk6nLy6WRSo+bR6prH3fcBcMA
         QVPYVnYciqIoyczBKioqVOYWqcxd/nUmsdyGfzIZ4mueLPvOL6ZimeNPMT9knSpijjlP
         rHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDG84a5VNZroOmpBgsy0eBEo0yfCeoN9sS88GvFAIjFdcRzhMdj/NaAZaoCcXR+zmOaczgD5xXjQvh@vger.kernel.org
X-Gm-Message-State: AOJu0YwLv7WNxTFF+wPHrBv7TfoYmg68cDZMI7j/+81iqgmmgePtijz+
	aZ0Qz/h0LK6xJG6/QyMHG0CGRZGAwO3CPLK0Ac5ZRhLJoEb5ywJMSNdxJ0oa
X-Google-Smtp-Source: AGHT+IGC9kl31Sp+055bbsciqTzeV//KgUd64QAAm85Mm2OmpR+CzCYrU//EVOzEjFD2+vVhJCcjHQ==
X-Received: by 2002:a17:90b:38ca:b0:2e2:cf5c:8ee8 with SMTP id 98e67ed59e1d1-2e93c186141mr24223930a91.12.1730786047333;
        Mon, 04 Nov 2024 21:54:07 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa4570fsm10952198a91.30.2024.11.04.21.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:54:06 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/7] drm: panel: nv3052c: Rename rg35xx-plus-panel back to WL-355608-A8
Date: Tue,  5 Nov 2024 14:52:30 +0900
Message-ID: <20241105055239.1577275-3-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105055239.1577275-1-kikuchan98@gmail.com>
References: <20241105055239.1577275-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A panel assembly is changed in the recent revision of Anbernic RG35XX
Plus, so the `anbernic,rg35xx-plus-panel` identifier is neither suitable
nor unique for the panel anymore.

Fortunately, the panel can be distinguished by a label printed on the
FPC cable, so use the label "WL-355608-A8" as an identifier instead.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 drivers/gpu/drm/panel/panel-newvision-nv3052c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 06e16a7c14a..2da1e924177 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -917,7 +917,7 @@ static const struct nv3052c_panel_info wl_355608_a8_panel_info = {
 static const struct spi_device_id nv3052c_ids[] = {
 	{ "ltk035c5444t", },
 	{ "fs035vg158", },
-	{ "rg35xx-plus-panel", },
+	{ "wl-355608-a8", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, nv3052c_ids);
@@ -925,7 +925,7 @@ MODULE_DEVICE_TABLE(spi, nv3052c_ids);
 static const struct of_device_id nv3052c_of_match[] = {
 	{ .compatible = "leadtek,ltk035c5444t", .data = &ltk035c5444t_panel_info },
 	{ .compatible = "fascontek,fs035vg158", .data = &fs035vg158_panel_info },
-	{ .compatible = "anbernic,rg35xx-plus-panel", .data = &wl_355608_a8_panel_info },
+	{ .compatible = "anbernic,wl-355608-a8", .data = &wl_355608_a8_panel_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nv3052c_of_match);
-- 
2.47.0


