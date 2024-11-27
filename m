Return-Path: <linux-kernel+bounces-423387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8AF9DA6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD58B2A55D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE471F1312;
	Wed, 27 Nov 2024 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="AobZesyZ"
Received: from mail-wr1-f97.google.com (mail-wr1-f97.google.com [209.85.221.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0B1EF0AC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732706124; cv=none; b=EMdF12esRNqTNC/sIfWqdKx78fEd/M5mtWqjIjvF/uzhP1WSRvym0UhQelTWeEj+4qE4kYh6RMCB8cfVxpamFqX9j45tW2ynij8TbhEPRp8rJ7C0mG4qmDBbN0WhcOnlFpjOThmIa9M9R6U4M6dFsHFO8rrvR5XNzYm9Ry4Y2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732706124; c=relaxed/simple;
	bh=6GnAB8AluBnog7NYl4+hJYVAAOZJGkmDUBrswi9xVtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hy2yXWXIq+9eWWh0s9VUb9NDzehkabapEPUYXINQFkdxgZEOJutzhZu2rSYsxqLV3lZi3G0LIWgtrvdlujEr/Zaga7OXYMtX664YcB1ZJiKq5nBgm5W1epMUeozdNSvq+5575KNu2bkjqdTh6Bm4OOg5crAW1JzEbq5ODoMBQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=AobZesyZ; arc=none smtp.client-ip=209.85.221.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f97.google.com with SMTP id ffacd0b85a97d-382433611d0so5558697f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732706121; x=1733310921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8u/tqgNbTDWlnzWRktGlQ9tYzEXbqX8e0KFyaCvDAo=;
        b=AobZesyZ8E7j3C71TYrOJAH7NDf1o5LrcepcRO3w580ZEYfIdebIP1hP/KD409sMJQ
         NfiWVntSB5ezBYpHSgfvJTVL5W8W4b3eylFzL4hCp4dDlhPZnHT5gjTh9IXr5BjZHs6+
         LWdEaVJdSg4lbjuk4lAO4bh1lzdf4Sfh6KrF9kSvQgLf0lHfGo61tepnt9aFoDtSk/dP
         GFxxYjBCUDa1KwRzJk6OhMQipu0x5I5De+oqEZMpCvbX46jUpS/klBappqowMNEz7W2h
         kS/PjpDSibO2uhM6jtcfUVu6/g5TJYnAUcIZIEtikiTOFz5bI3kt/1ITh4b306OLuNu6
         M/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732706121; x=1733310921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8u/tqgNbTDWlnzWRktGlQ9tYzEXbqX8e0KFyaCvDAo=;
        b=n7H6iGyK3yBi/VFi6EUJhCQ7yRvN3quzw5H57wAqSQmx4AI6GQNSO8L5E7wlvJUFD5
         OZm5VxpE082f71k8PHOF4lAk1pwNLY6q6/C0/zW3HqUWzD96xLzrUy62lfZXxbZOqugv
         OYD537UNqnOgDewoeMSQ5iPOOr4ZPGViSKvt/DJib6ghn/2s2Y6oSBZjVMqe3UEFvZ+y
         kJ4pj30M3dqPyTRsm9JliRD8D00dbRoE/gosUc3Wlx/pdq7cSr3VcpHBMoOj6eM8zKeD
         y/1QhRF12RNhdN3OolZd4hxSwmPow9vMkpmtfcg1yAqBeho3vmVDsw9+qBMYntPBlmwn
         7k/w==
X-Forwarded-Encrypted: i=1; AJvYcCUpG65Vgk/crFx0wpEkzsCw15IEkMqWiZLoHPvpXMRxy0RgAtjs1qQxSbsdyPTMa3HwghhqUFIiOen6lYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUi15uaVJFUHk0D5asizTxDf/V+qpVR1MgSGEkt/i73mxsDtC
	lYRXehPIM/SowZNGp1T25EWY8OBmgkmm3ttNYRypXK7AQ9gh9r90QZ/NC7VCVNnjGti36MJKokq
	vZ8DvfAnrZtpN1YCV5f0h0sLawvP+UFBj
X-Gm-Gg: ASbGncuXk7ygsTNVBsJQ9PvsXkRAGH5ZaqfJUTu4tc7gsehoKO0u4RKbrptwjHFdlwM
	QbbTTXc4GfFALC+EF653XQKnizHJVbeJ4MRM5Qpj4zUUhA5Zl9PEt1OhGd+E0SKb7FTegsnSz7a
	Y/TMDHnovzm/gq1PAFVQL+AQlZEV7iv/xWYzl+8hPckvsExejV6ahZ5uLXWrfDKpydW798esiN+
	7nJrTnqKm3thh/vZv8l1PDuNoFTXrI7oP9Jo+oW4xlrUJSO2tIWS+VEdRGKSzWJ3Q==
X-Google-Smtp-Source: AGHT+IF6UYuhlMZWwu6G6XRnHvnHedKpIlZ7ngLVPHb1A9KO+apfgpcWvh597QK+I/YFytjWK0k3yOJSuLhK
X-Received: by 2002:a05:6000:389:b0:381:d890:b5b7 with SMTP id ffacd0b85a97d-385c6edd314mr2620035f8f.52.1732706121160;
        Wed, 27 Nov 2024 03:15:21 -0800 (PST)
Received: from raspberrypi.com ([93.93.133.154])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-3825fbee19dsm441144f8f.82.2024.11.27.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:15:21 -0800 (PST)
X-Relaying-Domain: raspberrypi.com
From: Naushir Patuck <naush@raspberrypi.com>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jacopo.mondi@ideasonboard.com,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Naushir Patuck <naush@raspberrypi.com>
Subject: [PATCH v2 3/4] drivers: media: bcm2835-unicam: Disable trigger mode operation
Date: Wed, 27 Nov 2024 11:15:14 +0000
Message-Id: <20241127111515.565992-4-naush@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127111515.565992-1-naush@raspberrypi.com>
References: <20241127111515.565992-1-naush@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The imx219/imx708 sensors frequently generate a single corrupt frame
(image or embedded data) when the sensor first starts. This can either
be a missing line, or invalid samples within the line. This only occurrs
using the upstream Unicam kernel driver.

Disabling trigger mode elimiates this corruption. Since trigger mode is
a legacy feature copied from the firmware driver and not expected to be
needed, remove it. Tested on the Raspberry Pi cameras and shows no ill
effects.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index d573d4d89881..550eb1b064f1 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -834,11 +834,6 @@ static irqreturn_t unicam_isr(int irq, void *dev)
 		}
 	}
 
-	if (unicam_reg_read(unicam, UNICAM_ICTL) & UNICAM_FCM) {
-		/* Switch out of trigger mode if selected */
-		unicam_reg_write_field(unicam, UNICAM_ICTL, 1, UNICAM_TFC);
-		unicam_reg_write_field(unicam, UNICAM_ICTL, 0, UNICAM_FCM);
-	}
 	return IRQ_HANDLED;
 }
 
@@ -1002,8 +997,7 @@ static void unicam_start_rx(struct unicam_device *unicam,
 
 	unicam_reg_write_field(unicam, UNICAM_ANA, 0, UNICAM_DDL);
 
-	/* Always start in trigger frame capture mode (UNICAM_FCM set) */
-	val = UNICAM_FSIE | UNICAM_FEIE | UNICAM_FCM | UNICAM_IBOB;
+	val = UNICAM_FSIE | UNICAM_FEIE | UNICAM_IBOB;
 	line_int_freq = max(fmt->height >> 2, 128);
 	unicam_set_field(&val, line_int_freq, UNICAM_LCIE_MASK);
 	unicam_reg_write(unicam, UNICAM_ICTL, val);
-- 
2.34.1


