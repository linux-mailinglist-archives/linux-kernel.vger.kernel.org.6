Return-Path: <linux-kernel+bounces-201529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1408FBF94
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4AD1C214E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D760A14D297;
	Tue,  4 Jun 2024 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H4ECdkj6"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ACE14C582
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542479; cv=none; b=Clsd4+r6jY0RNmy4OFxYwh7x6WbbM6bANe0NpzZONxOgXEhhyOhiURcaU8S2BdBeqqmf/scnJz9qfhNo0AP9t6glqhA39mpIhlnSW0JgTnarjR91OmlIkLWMbxRpUFQhHYqbSZN4s2WtaLTN0K147uv4D3FadqkHeu9k2sr0gxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542479; c=relaxed/simple;
	bh=S+9zz71oaA3sB9uTHupPRjwzN/Kg3Zov6NucuxB+qjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKx1ABwImrInHoipq1zbCKn7AIsMbykyZ/KVUVFFViKHFzgAN+qqlkg+YtmTh46KAc1dnCHUaBNHztO4YSzymYSGGRZIYvyNiVGD4ds3dQqY/tfmvatNCEL/Cu10EiKCcnW8d6c833FFMUDoyn9EFTDGZwVbkgE/k4VmihQ71sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H4ECdkj6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f61f775738so43853265ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717542477; x=1718147277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80AADrANMPKTbjfSl+glHpJQtK8BahTa2d2kuE5FSZM=;
        b=H4ECdkj6td0FrZVX4XiC5x0B+JtB5kUeS0yme318nuJM08lompve/C7mzGixohIXa9
         h2BHWx+W0rVoEF2bPQ/pgqR2sUmd0c3UjE3rMoWwhapnFshL+Amcw9X82s85om+ZXnEG
         zwsJG9QP6ypkyip+k6mDJaqXj36zQSGsEsaSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717542477; x=1718147277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80AADrANMPKTbjfSl+glHpJQtK8BahTa2d2kuE5FSZM=;
        b=IiAuRH7xdmMVk+vfYnSKr7QUjqQWrJmgjr5nQ+hoinzmtAab4T2tD9yAZblPctwYkr
         CEOGpPuh5E3oD8H9ZQRFXzem714lI7BGZ1obrxJaPu740Zb6EQIzmLQvw8cF/r9QDcx8
         uEzd8n70SjScUX/UuYb5o6MBPnVGLDu6l+dZDtxt5xwFMo2fZWsSoX+5T0ZaCo3xAidH
         Rq0+8kpuxavx4tbUNORVLY/ebSuQze0wr+zWxxHJhtdSIbfVBmic1BezrZ6DcAF1yKvI
         2JhsIqSpJQjmbCHTY4b6VHjBd+YJZe3r0OO+ra4ytKPmOjSTl+BKOfNdlFfJK5RGp6u4
         4F5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAwEePBmrEws66ROE4UIa44/pjbtbS1SD0AaYBx9sNFdM21sTrKKPRQiDsFTJ57Z1m9XbR2NmflDGFKqDRP5DszV9Ay/jL9eyBcCRj
X-Gm-Message-State: AOJu0YwCrf7kqXYGPsq6gWWRU8wWupyO4raIOaJ1AMTBAvBkJKu2luTn
	Expzo5adMmaRg+YoDEqyf37cC7bFsn3zjrENR+yywJKj1LzKqTnN/HWnH2oUzg==
X-Google-Smtp-Source: AGHT+IESK5FVg7WsCAIz1cS7J9B0Nn73/Zd4nIJdxwYoZbUDUI7xTGlZe6xJjA3kgjPYsmniqjhxQw==
X-Received: by 2002:a17:902:dac9:b0:1f6:1c72:955f with SMTP id d9443c01a7336-1f6a5a5ca77mr11660895ad.43.1717542476907;
        Tue, 04 Jun 2024 16:07:56 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:c108:1a83:e639:e62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232dd60sm88556845ad.38.2024.06.04.16.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 16:07:56 -0700 (PDT)
From: Daisuke Nojiri <dnojiri@chromium.org>
To: 
Cc: Daisuke Nojiri <dnojiri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Reka Norman <rekanorman@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Tzung-Bi Shih <tzungbi@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Pavan Holla <pholla@chromium.org>,
	Ching-Kang Yen <chingkang@chromium.org>,
	Lukasz Majczak <lma@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/chrome: Add struct ec_response_get_next_event_v3
Date: Tue,  4 Jun 2024 16:07:29 -0700
Message-ID: <20240604230742.2878452-1-dnojiri@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
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
Change-Id: I69ac374fd88c3d3ef294f8e81443a2fea588bbce
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
2.45.1.288.g0e0cd299f1-goog


