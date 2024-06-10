Return-Path: <linux-kernel+bounces-209042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B285C902C46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB0C2856DA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE67153BD2;
	Mon, 10 Jun 2024 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N1IFK/ip"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847541527A7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718061000; cv=none; b=rGN5USy6r4e5+w9SSsV+xA6sZZxuxH+X4r8hIjdjiekWd7Uqy4VnM4JpGRV5SntKULYZOxTVCapW8XflD6JYc0cmmwJ+5io2Y2yeS6+3zXvcEgybAYrEi0+QQ5n4DcboSzDUPf74GuYtDUkRl0+SumaLCzUF0JEFTtWdOObn0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718061000; c=relaxed/simple;
	bh=iTfdC4btNMwXyVr7bat6V5XQY3nrpXEk8t37YJiWujI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RV2nE4fVt9+WmmJ8ALjt3Y0gMHzRTrKKMgoocRb5SrMT8krEtHX8QIkdDe2nQZjj+aQeh8WiCyXg4c2KhFa2RWMcaJM/ykpTESlpzjqoNYBzdWeJ11uk0EG6HkmU6Ttq2C+aaZB7NDxlLbQ3aSb6LPSEn+X9s2olj8qULRn5qPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N1IFK/ip; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b970e90ab8so228331eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718060999; x=1718665799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRxFROHQ2dCXosAMLsg5w59iJitkjf3IVXz7c5nb/d0=;
        b=N1IFK/ipZvDThxXX6hB/DDIE2Jr3cmYqpQ2DckOfWxYHhPpIVZP5uxcBUOsWFSTR89
         1ND8hSMNRQiRePyCpmfcUeMzwb3FlRbk8hpZfkTIhkLyKaIqAZCN91b8m4rYlqRKqpK9
         odIVzqBCcuAzUnTAWue4gRy6p+G4wLXY0hLwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060999; x=1718665799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRxFROHQ2dCXosAMLsg5w59iJitkjf3IVXz7c5nb/d0=;
        b=MfTNHHgiRtW51xRufIlwBrKR0Pi25dulRA4DjNhUK5OQrySH9zA8ANmn1Ov8geNCNc
         RwN8uVOppv1sIW0phy0OKZ9bLjHZ/76kEbOnHz3gP8I/0/CM3K290s9RkweQ+hvrysrf
         06m6BioTTAwbT3X/8Kliw0jCagX7Kr2b2HwHeM8Zums/atYJl+HVYrFQbIWDhkH+a/v9
         gCE9hnmoX2Ez8h6KItytQfGOwP4+7gAOF2q7rkKyYheYNTffv38I2iVss0WAwge2DrGY
         kYAeRSlMRE5v9RirmotpnbbpsQ6H5cg4qIaSABAgAsdBBGWjvE9QTnbXoR9aAjZMBSuU
         FqNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFjX5POl2GJv0jCpTc6RxFe4chuBwjjagKxk7btYI2UjCcHOuOPo0atiEF7CC8xaqE/LJvuTEQaytDHIZELM+F1xmGeUOugCwUjaBj
X-Gm-Message-State: AOJu0YwtnRvm0oN0X1fCaziucpoAAIpSwq/WwoqAkoDK4+p7Fhmo4ZH/
	yXG/FSwUHpWrDqwWFHueZ+h7zAtTJw7AIR3IBJm5yOfX/kAqNhLCAxEeouFqHg==
X-Google-Smtp-Source: AGHT+IFmlKoKWOJj2qo73Wl0NsPia9kSU0phIwncQtRQ3A99zhJAaMJL4Mw8zF7B8tzfmU8kOru5aA==
X-Received: by 2002:a05:6358:5294:b0:19f:1ce8:dc0 with SMTP id e5c5f4694b2df-19f1fe13fa9mr1605477555d.12.1718060998529;
        Mon, 10 Jun 2024 16:09:58 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06519d521sm35256946d6.65.2024.06.10.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 16:09:57 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 10 Jun 2024 23:09:55 +0000
Subject: [PATCH v2 4/7] media: uvcvideo: Cleanup version-specific mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-billion-v2-4-38e861475f85@chromium.org>
References: <20240610-billion-v2-0-38e861475f85@chromium.org>
In-Reply-To: <20240610-billion-v2-0-38e861475f85@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

We do not have more version specific mappings. Let's remove this code
for now. It can be easily reverted later if needed.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 5b77ac308c84..efc46f53ac81 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -847,14 +847,6 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 	},
 };
 
-static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc11[] = {
-	NULL, /* Sentinel */
-};
-
-static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc15[] = {
-	NULL, /* Sentinel */
-};
-
 /* ------------------------------------------------------------------------
  * Utility functions
  */
@@ -2656,7 +2648,6 @@ static void uvc_ctrl_prune_entity(struct uvc_device *dev,
 static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 			       struct uvc_control *ctrl)
 {
-	const struct uvc_control_mapping **mappings;
 	unsigned int i;
 
 	/*
@@ -2721,18 +2712,6 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 		    ctrl->info.selector == mapping->selector)
 			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
 	}
-
-	/* Finally process version-specific mappings. */
-	mappings = chain->dev->uvc_version < 0x0150
-		 ? uvc_ctrl_mappings_uvc11 : uvc_ctrl_mappings_uvc15;
-
-	for (i = 0; mappings[i]; ++i) {
-		const struct uvc_control_mapping *mapping = mappings[i];
-
-		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
-		    ctrl->info.selector == mapping->selector)
-			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
-	}
 }
 
 /*

-- 
2.45.2.505.gda0bf45e8d-goog


