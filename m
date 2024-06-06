Return-Path: <linux-kernel+bounces-204818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13958FF3DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3823B2772F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B361990BE;
	Thu,  6 Jun 2024 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MgtF9tvj"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE8F19597A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695344; cv=none; b=ZKZkmg93vQaTEGICeEy1ZBwxw4dy6ghGhQkL8UaM8DfF6krY++JyRhxngztJOqsvxfZ+C+v/lkdkk8zZkoH7qU+VixWMyb1WMQb4hjBG8dk2qSmr5r+OUVRlFo4YwnOARDikcy8uzvQBJrHAwMbnnlAv07iRKI1OgbilsWCIaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695344; c=relaxed/simple;
	bh=xABQwRoV/rPfzO361kpsP71OpAjQdGoHAsuSMSpEf8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4GVV3Px/YcBu1Q71bJ+ZUtTp9vZsEbF0/HgA21zLeOwDbhPGrtELy77EU8tltTsOrtp6g+ZihRxeM+Sd0Nj8N91ptL/+641EeOwN7CG49u23BcLRlULq67EZlSR916lYpVUpZgBoHoA77M3t1IIF5mVjlFh4IFte972Kb8WwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MgtF9tvj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-702555eb23bso1038794b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717695342; x=1718300142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhekWzHrW9NurW+RaIOThqGP3SBDgZ6s+7MlrIOk/wY=;
        b=MgtF9tvjfVG8WgSxaKt8mO71/UMk+7A30hmM3C83g13Rs40RWKwUcZKMR8uCYmuLDX
         3hYE+pmuwHTstiuKAiNisE1Fq8GWkyiDGUv2qKIDC5dkj+u6vhfADFcGMd4c1CmNRaTY
         born717BynFipcQsyahuffnF3llwfl5e2k2uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717695342; x=1718300142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhekWzHrW9NurW+RaIOThqGP3SBDgZ6s+7MlrIOk/wY=;
        b=g4lo80CGIk/1pZeDw6OD4DxTXIuCBUCr37zPrfCpWpiiZGpYFH8rlrDnErx6k5jfDc
         HAwebCNQWafwxBUBAlClYhAGECs03XEgYoeoz7Z9zBWH3ScXkKr9TLaFXdw42DLZzW8t
         dTH+0QfQ0AyatFUtV4KQRat/7F52ipbF1qkhZWFoV337tCmRbIAxzzGDf5xau3Vfke2d
         glAOnC0HjORE57A/BkLOdW0gPRbVPPkMxVcvHcWBm7rOngwNvzBX4P2x/vjZoua+IoKY
         ZtZZIxQnAcNSe9uLM5yAjzRoqtTUgv0Orgvy0B70aA46Lw5enmglEHmJ7Tyaekpritjz
         qTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWONjuZQIua6iuC6uw720Dy/JZOISgcJiCAMIyFbip85811vv5BUjdmxpzwx81/oi8wDzoOKj5vTbFoAqVIsfuRtFI2cqhR2XOqliQW
X-Gm-Message-State: AOJu0YzvNqakAEyjH594jEz2XO2mM0hsp+vnD4hnpoYRFoO35r0Eky/4
	MUEtlgdWBYl6jlUcroPll8c9bWGleOzlpXJBeAxM2hoKQl+JMl7jnBP3ibkTAg==
X-Google-Smtp-Source: AGHT+IGqky3MNy6C2rzmt/288+9Xbb/3YZaZphiKwa4B9QhEBIhCOCT7QnAC/sV7qoLsAhgL5gCPbA==
X-Received: by 2002:a05:6a20:7f8c:b0:1af:fff9:30dd with SMTP id adf61e73a8af0-1b2f9bd93c6mr270327637.35.1717695342540;
        Thu, 06 Jun 2024 10:35:42 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:3fe9:f321:712c:442f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd375503sm1334904b3a.42.2024.06.06.10.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:35:42 -0700 (PDT)
From: Daisuke Nojiri <dnojiri@chromium.org>
To: 
Cc: Daisuke Nojiri <dnojiri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Reka Norman <rekanorman@chromium.org>,
	Tzung-Bi Shih <tzungbi@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Pavan Holla <pholla@chromium.org>,
	Ching-Kang Yen <chingkang@chromium.org>,
	Lukasz Majczak <lma@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3 v4] platform/chrome: Add struct ec_response_get_next_event_v3
Date: Thu,  6 Jun 2024 10:34:28 -0700
Message-ID: <20240606173509.243739-2-dnojiri@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240606173509.243739-1-dnojiri@chromium.org>
References: <20240604005354.2294468-1-dnojiri@chromium.org>
 <20240606173509.243739-1-dnojiri@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add struct ec_response_get_next_event_v3 to upgrade
EC_CMD_GET_NEXT_EVENT to version 3.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
---
 .../linux/platform_data/cros_ec_commands.h    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 070e49c5381e..fff191a8d413 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3527,6 +3527,34 @@ union __ec_align_offset1 ec_response_get_next_data_v1 {
 };
 BUILD_ASSERT(sizeof(union ec_response_get_next_data_v1) == 16);
 
+union __ec_align_offset1 ec_response_get_next_data_v3 {
+	uint8_t key_matrix[18];
+
+	/* Unaligned */
+	uint32_t host_event;
+	uint64_t host_event64;
+
+	struct __ec_todo_unpacked {
+		/* For aligning the fifo_info */
+		uint8_t reserved[3];
+		struct ec_response_motion_sense_fifo_info info;
+	} sensor_fifo;
+
+	uint32_t buttons;
+
+	uint32_t switches;
+
+	uint32_t fp_events;
+
+	uint32_t sysrq;
+
+	/* CEC events from enum mkbp_cec_event */
+	uint32_t cec_events;
+
+	uint8_t cec_message[16];
+};
+BUILD_ASSERT(sizeof(union ec_response_get_next_data_v3) == 18);
+
 struct ec_response_get_next_event {
 	uint8_t event_type;
 	/* Followed by event data if any */
@@ -3539,6 +3567,12 @@ struct ec_response_get_next_event_v1 {
 	union ec_response_get_next_data_v1 data;
 } __ec_align1;
 
+struct ec_response_get_next_event_v3 {
+	uint8_t event_type;
+	/* Followed by event data if any */
+	union ec_response_get_next_data_v3 data;
+} __ec_align1;
+
 /* Bit indices for buttons and switches.*/
 /* Buttons */
 #define EC_MKBP_POWER_BUTTON	0
-- 
2.45.2.505.gda0bf45e8d-goog


