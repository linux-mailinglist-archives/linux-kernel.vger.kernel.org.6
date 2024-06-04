Return-Path: <linux-kernel+bounces-201130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119CE8FB9EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAD0282BC4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE286149C79;
	Tue,  4 Jun 2024 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KdU73S0M"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE2149C77
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520766; cv=none; b=gRBJzsp0jo7xU37BGnMwNDfr0ZrW56YUHHxs+b38ymcUxbzg3uSH2husfgCzLiq/KpNk/iVGEkjmp8wbTNd0eV4RzFvYF2ARK1mhTsmaX+AtYRKYqDL9fe3B02mecgGRLak2hbs4LNTmLufbI0Q6neWXADTRR4IMa+EEHFfSzyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520766; c=relaxed/simple;
	bh=rEVud8jYCenY75ArS4e4npQEZOeDDa8qDxgOauldd3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFfUsNMARHTBzAckBUSlgbYhP0WJoVC7obuXbrRiH7hRbxYOqW4U5OazlX30aDipR08NRONVtvnbuVPRcRCJE0Z7j8bTcrE0Af2XTfezz/lpOejr9t+ntjU4FxvB01zVRLWQDkgJ4E38HCMWVf3UGIwm2Yf0yuFO41Kk8KM9QG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KdU73S0M; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f4603237e0so23402b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717520761; x=1718125561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgJ5+iEOSgKZgq1LxXHnvCk2860Dw4BLXVAkjQni18I=;
        b=KdU73S0MrArtUIvzdV8S/zE81viRGPgVg6TDvu3lu1z9mrer6UhcSvBd1I13bjF4G6
         QlR0EQPJZuhXaSoLsGeytQ3lLdXeOGiiOO3uIUrOQL/JIe83HN+4d04xy18q4piGg9cT
         1t5/59cHgaafiVN6OlYS/aqZfCGFGqR+RXE6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717520761; x=1718125561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgJ5+iEOSgKZgq1LxXHnvCk2860Dw4BLXVAkjQni18I=;
        b=usHPuKn8fwpxzafoslfZB/OOHF2bRip0L5Ph4XS33s3gZoBJHM/6XFJyc80IQyWN49
         tPoozOUh7qoaWF8W/T/RDmEV+628LBY5QsthICWKzJXHoQgd2nZPsZDpUEbAjDY1kkr3
         /sMV4Tm6n8qdWOhmjdjvIkCxzWu4b63SzY2dMy0aN/6ek5rnntXes9aLcSIyLn9Zpx9V
         +m+FGrV1J/wWyPDqMWsehVtRhd7wr9x1cH/s9jAed2XiCxXspVIad9N8F9Xa5FiXxcMo
         i3VoHz5GA1Lpk1I0ksANAJ/5x+pVWzHUMoMiiwa822KkFzReCp6FYmuCnfjJFLvmju16
         wgJA==
X-Forwarded-Encrypted: i=1; AJvYcCVifz9KVo+Z6QxlGc3INe4v44E/+xhXdJByxyfEmDRyXHacmrAMnBbZUCxoza06rGccQjDO28JHM2lLKNsg8jz7Yav/KRGqMrs55yWQ
X-Gm-Message-State: AOJu0YwPEVfbs4hPvbpI5LQniDPZdhLWlV69m/lUsOq9Fvi3KXIhl1Ti
	O9oygLTeydR+5saKFqg81Lbc9s8J+Zp2T85lJ/o8bPcFTDTRohudGbAxJ5WJ6Q==
X-Google-Smtp-Source: AGHT+IFGAiCt40jA5/yhChT2c5Qddf9o2Q57U/QnPJLBpXj9m7oYVO4h6NEpzDCXz6oyMA7cKGh7fA==
X-Received: by 2002:a05:6a00:2d1d:b0:6f4:d5d8:e0a3 with SMTP id d2e1a72fcca58-703e4bf60cfmr331030b3a.9.1717520760886;
        Tue, 04 Jun 2024 10:06:00 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:6203:d1ca:c560:52f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b0914dsm7510672b3a.179.2024.06.04.10.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 10:06:00 -0700 (PDT)
From: Daisuke Nojiri <dnojiri@chromium.org>
To: 
Cc: Daisuke Nojiri <dnojiri@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Reka Norman <rekanorman@chromium.org>,
	Tzung-Bi Shih <tzungbi@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Pavan Holla <pholla@chromium.org>,
	Ching-Kang Yen <chingkang@chromium.org>,
	Lukasz Majczak <lma@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/chrome: Add struct ec_response_get_next_event_v3
Date: Tue,  4 Jun 2024 10:01:48 -0700
Message-ID: <20240604170552.2517189-1-dnojiri@chromium.org>
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


