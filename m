Return-Path: <linux-kernel+bounces-203488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F9B8FDC04
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D257D1C23027
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621C8EEC5;
	Thu,  6 Jun 2024 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kIrajryf"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB341373
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 01:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717636011; cv=none; b=W3nUdAhgZB1cdU8sxXCl/MW0+A0uqg0OKx3iMNG2OPCXndd/KSe2Hw0J7fJZN463ff3UC5cWADZ2IPq8FpQHlgaOSKSXYpYfbIn12mTzZKo93Ceg2XhhOXfQfiS8zpF3R5Ib0UsJvXOLkwx3OJ2/AXriQfGDUC+wF6IHlBOBOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717636011; c=relaxed/simple;
	bh=++WJqqND1ZBOGt6/Onp3wurt4JaeFMyxGGslVsp1Zgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9mnNlKGB1tx5IRDbk6LVNHzdafW3v7XAkaRAKd0wfn/l8dOYpp2KhAT8LTSl17YY01jdIDwvrByRxA8V+ReEqRLdFh2E7r+SVStu0txQkISPRINB+cvdYFbudGYwy+QGT/+9MbtjtaUyQRzRHsHLxCDU1PPLIUCDoC0bgQuqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kIrajryf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7025c5e6b94so343796b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 18:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717636009; x=1718240809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAPtVWkfmldUTyM5Hk8/0Btwi/UZMj5h/uZteLACq0o=;
        b=kIrajryfLnTiqIZ9WhDi+u1QPDOtXLGkm+wxR3/S+tAddv2NMuLqd0uD7QOULK2q8H
         56FszvcGqDIx+lZMHSteBp9g4FRD5ai5nX1JEJNyS0ry69uj7Mfr25sMEucw+PN7MtwJ
         sTSBPeFpWTvT6GiDW6oV0oZ7VLx7TH3dINhos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717636009; x=1718240809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAPtVWkfmldUTyM5Hk8/0Btwi/UZMj5h/uZteLACq0o=;
        b=NYJRg4LwD/Sgv0+WmWo1/UXx9pyBzyWfbKS/ASK5blfaYi7gBtEtUr3j6e0ch37Z/Q
         Y8HQ6yT79rcMnVqhok4Bazd1l64AmmdwkKoktmK6WPlESEntALq9NlR+af1I1gko4SAP
         G5x0pnFta3+4ym0qTDoYXbd9lHW3I96/mo91by3R+cc5ZaPVlR1VuStAKx0evAvwnRCQ
         CU2deXnCrppvO7yJfOwwh7KQ1dDaamxgFyA2kv1tIYvlPDA1Sl8zs3DMQBIibuJrKqC+
         tygCvasKxV4W2kffB4MBsu0JhY5sGqlf1ty4lJH8gM5a5S3aNeKoHUyz7oexGTSDTZXU
         d8Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXoZKgs1Q6wnkD1Emst2CTrZbIjYU6SFQKfGAaRZ41vVu2lvNQ/Re0i1rgoUiyEm3q4MWAM5+pW6oFCPCCCGgG8py+WUumHMIsDGScH
X-Gm-Message-State: AOJu0Yy2A3rP5nhORhuVPN9tLamTq7Ro8vb7wNRRtZmRwlnRFUbhSkOD
	/AFcrrdBcbrvr2qmu46xn7dErjr2p54enZlGzQup+MtMjWqiEwGqz9D5lGYXnA==
X-Google-Smtp-Source: AGHT+IHQV1kfgZV3G6K5sktJH/jDVBDRoR3swfw8i+wl5vd2Br20L4UfMz635guhJ5oPDUP07aLGwQ==
X-Received: by 2002:a05:6a00:130f:b0:6f4:56d1:2fbe with SMTP id d2e1a72fcca58-703e594acffmr4302257b3a.11.1717636008266;
        Wed, 05 Jun 2024 18:06:48 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:3fe9:f321:712c:442f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd372dbfsm121871b3a.38.2024.06.05.18.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 18:06:47 -0700 (PDT)
From: Daisuke Nojiri <dnojiri@chromium.org>
To: 
Cc: Daisuke Nojiri <dnojiri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Reka Norman <rekanorman@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Tzung-Bi Shih <tzungbi@chromium.org>,
	Pavan Holla <pholla@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Lukasz Majczak <lma@chromium.org>,
	Ching-Kang Yen <chingkang@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/chrome: Add struct ec_response_get_next_event_v3
Date: Wed,  5 Jun 2024 18:06:26 -0700
Message-ID: <20240606010639.25074-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
In-Reply-To: <20240604005354.2294468-1-dnojiri@chromium.org>
References: <20240604005354.2294468-1-dnojiri@chromium.org>
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
2.45.1.467.gbab1589fc0-goog


