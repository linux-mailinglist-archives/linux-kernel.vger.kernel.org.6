Return-Path: <linux-kernel+bounces-171805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855398BE8EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4075A283675
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B5F16C688;
	Tue,  7 May 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UA3k66DF"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D6716D9B7
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099238; cv=none; b=FdwYuyY0z6YKIW5lEKq15OICoDZzABTTkxP3pAdqxg2m9f4OJJq73OoipZc4KdLV705vlS8M4xAi0CJra2BzWVerFoyRKTUv+2IhfJXOBrTtKotr1r14cCLNGWoUNQKjYcefo3SMAqv5IgmtZq3Ihx/1M0RDIvt2wnQLi1ZUnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099238; c=relaxed/simple;
	bh=ENYjVBtJ4EPS9w/ftPm8y0fja8ouSlg/VUcwtfy4KyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jll0vjnwJCZIPmaDDXfe2rl+pSerOXDs8tZong8ueueIWwkH4Vy0Hu8blGgfZUYaLXZOR3e1neQD6E05wQxKw/CjZVtkmHeVWGStVotUewmWvfRNSAcmmGqvNXVk1drIVdi4aVbvPMErBKBEqQiExLoGbZurLSA9gFDDjNAhTWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UA3k66DF; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7f74cca5a2bso796233241.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715099236; x=1715704036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bajBIKBKiGkzVrECr+DrCDdr2oyOzpQYYR0WAIoyaos=;
        b=UA3k66DFfs3JyEw6Ln1PQp42U0s8/PnEhrADYrBRrV68wiEopRlrjbeo4QlpOpjp8m
         3kJidugwcb8u74p5/ZEfcgZQKRRPFFnD+3pISJp1t12on7X+hI/WVwUe9IAaru/GLXM/
         fcoJmssdPd1J55izmRHLqXY1UCsYcwziFqODQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099236; x=1715704036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bajBIKBKiGkzVrECr+DrCDdr2oyOzpQYYR0WAIoyaos=;
        b=wHP3q7duZb/ciStKPetVsJsZ+2jDMO50L2ASD44IN6U2UYqwa2Fu2axZgdKYnOD5wE
         04fqsPBozM12vucM52z0XkhflSkC1829AleS/C6CjLqj1gWEgs4+QEsAFMz7Wq430VzI
         VvhReL7mBUn2PCC6XV3wdgQ1h2K+U8/BKOxsObGneJhbd4RAKlxUqrxONjmZrGuyOfc0
         qB9zZf6E1UtuqSKcsrBih0Zq97YQVjb8ahfxQz7lnf7BglajaZCaKK5P2hRheY3tQFOe
         7jV0tg3iObR9a7Cgd8Kh1vjk2ZSXP8UzFtIL3sC5vJqU05Iun0G3I5Pm4z51AOly+a0r
         Ifhw==
X-Forwarded-Encrypted: i=1; AJvYcCW5OYg9TGdHv2bURmGCLPNos4k7IYjatjJVPwI0L+qSixlnIq86s6u0hO1jaiMqBv7Xv0ZYhKZ8uZpxJZ69gKuBQe76V/qZUFC3c4iJ
X-Gm-Message-State: AOJu0YyqtG1c4pwKKqRHlBFC+NfkgRzVrsP4b2EMUT/NHl2NCaO2VpKT
	pcbxEyfLl//fasOiI3W3AmSP9dA/Cie3A2KJWjWewKQqV4dXmGCTtAGcJWzpMA==
X-Google-Smtp-Source: AGHT+IF792y8yHb1G1T8p5qXRpEfx35eaFsBGY9qOmU3ppGSWJfi2EDsEDzymoanJSEvwZpNFlF1oA==
X-Received: by 2002:a05:6122:2a02:b0:4d3:4ac2:29f4 with SMTP id 71dfb90a1353d-4df692a6b65mr38747e0c.2.1715099235965;
        Tue, 07 May 2024 09:27:15 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id hf23-20020a05622a609700b0043d1fc9b7d9sm4160597qtb.48.2024.05.07.09.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:27:15 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 16:27:12 +0000
Subject: [PATCH v2 07/18] media: siano: Remove unused structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v2-7-7aea262cf065@chromium.org>
References: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
In-Reply-To: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
To: Michael Tretter <m.tretter@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, Andy Walls <awalls@md.metrocast.net>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

These structs are not used in the code, remove them.

This fixes the following cocci warning:

drivers/media/common/siano/smscoreapi.h:1049:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/common/siano/smscoreapi.h:1055:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/common/siano/smscoreapi.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/media/common/siano/smscoreapi.h b/drivers/media/common/siano/smscoreapi.h
index 46dc74ac9318..bc61bc8b9ea9 100644
--- a/drivers/media/common/siano/smscoreapi.h
+++ b/drivers/media/common/siano/smscoreapi.h
@@ -1042,20 +1042,6 @@ struct sms_srvm_signal_status {
 	u32 request_id;
 };
 
-struct sms_i2c_req {
-	u32	device_address; /* I2c device address */
-	u32	write_count; /* number of bytes to write */
-	u32	read_count; /* number of bytes to read */
-	u8	Data[1];
-};
-
-struct sms_i2c_res {
-	u32	status; /* non-zero value in case of failure */
-	u32	read_count; /* number of bytes read */
-	u8	Data[1];
-};
-
-
 struct smscore_config_gpio {
 #define SMS_GPIO_DIRECTION_INPUT  0
 #define SMS_GPIO_DIRECTION_OUTPUT 1

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


