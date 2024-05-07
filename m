Return-Path: <linux-kernel+bounces-171399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5328F8BE3D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E68D28AAB9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E8F16DEDA;
	Tue,  7 May 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JFt4TNkp"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B116D4D5
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087920; cv=none; b=V/N0N/brgblugJGB9GvMM/4SZ88ZgO91/kNqg1ngvHoWpc0gpqDiivP68SfB39N+rmOUGpBkBd8GWBPIf7KZ2rFVC9Ec/5WQ+pTicvxcTcBywnpUi2s35DlDeYpD3ZsCsYBY7JZZBRtf5bCHz09OSor/EfNZ1gO/HYxakJGZZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087920; c=relaxed/simple;
	bh=3FQmdzC7rLah5bHXqxL1pjRWMb/l2vnOq/dIwPsVxiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EduBW3xnVHHa6c6LYAdUmB2CFwDs2CStwSMqfmlow8vReT2n26FkJKw3I9CFG73g9Hzxg1BZRHSqG/HHqjiscTmD2l4Sx6bL5dboZfpij7VcjWd74rCMWISkIykgNdRZi/CqLHS3AicurfJmPrJYoJU/yY5nlpznjGs9JjpIPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JFt4TNkp; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b50b8239fso29890776d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715087917; x=1715692717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKfhOSoHE1VqyRhgB0xYInvnK6a8zz5LZUqmCULZe+M=;
        b=JFt4TNkpMT5jL5IFAYGuw28lBWwu84Ak+EoHQOC6AlPJzZQOXDDwp2LfLftQDkcI48
         kePHAN4Bhd5TFp56PnCYmL0IjqhZvKlhNTePDpTlPyuZOgFXVPm3H+gBFvSW2TKQP2V5
         t4vOxqEd9Db93cAxWnLWBikZe5wQjTQDdToXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087917; x=1715692717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKfhOSoHE1VqyRhgB0xYInvnK6a8zz5LZUqmCULZe+M=;
        b=GFNlVcgTHoM9d7tpWaLSK/O6JxukV+432U4h4oYQzV8+1UKIQXwmHnzsM8yufjjygW
         2WdKhDjvAPIeyRT6E94G2h07ovR7MckgsM5pNA0kb5hllRM4TEjR/Z2ZSpAsWIaAHuOw
         jFYCikhhOESN6yBg5MUB/vClrQxs1ydZAcl5VRWtp/h8s6CGtqMR6K6g2geODBnoM38W
         tZjsFcNR6Jzd6rd6+ftefX8BqfYEDfGYNxY38uTdmx2YtsoTk5iOktPaWgIshy7u12Z1
         Xx4ICZ78taB9WWnd4kqb6lpHFw4OpFcWSwIKnlopRnGGwVjm6jfmXpGJVCGFFfjLQcRu
         om+A==
X-Forwarded-Encrypted: i=1; AJvYcCXT2hlO0brhX36ixDuS8nkfYa3W0bMc7A+xX0pKtvE5p0CcinZbW1mZZAIhGUXGebdAwTwndOIVp7r7Vj0px4Z7kdJ822rt60gTkcEG
X-Gm-Message-State: AOJu0YyuR0tUFc/zhJIwpKtJ7xRFX8gIYCv48UzUtpeTW+7d7fH7Rgi4
	n7yshfR2WS28KMni70v3qm4o3jlD/XwayPDhijsywczhCkqidlPHWFmQDNfXnsZ15dtWSTkb9+x
	Lag==
X-Google-Smtp-Source: AGHT+IFKliypIzu0YjFcg14a69MBEAau+ZXpSAYRUE5dq1ueGc4ePsCBbZXpGGTph+KzlVWTljAkDg==
X-Received: by 2002:a0c:e082:0:b0:6a0:f637:667 with SMTP id 6a1803df08f44-6a14600e407mr45875746d6.12.1715087917380;
        Tue, 07 May 2024 06:18:37 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id t15-20020a05621405cf00b006a0d19c3139sm4655105qvz.118.2024.05.07.06.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:18:36 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 13:18:34 +0000
Subject: [PATCH 08/18] media: siano: Use flex arrays for sms_firmware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v1-8-4a421c21fd06@chromium.org>
References: <20240507-cocci-flexarray-v1-0-4a421c21fd06@chromium.org>
In-Reply-To: <20240507-cocci-flexarray-v1-0-4a421c21fd06@chromium.org>
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

Replace old style single array member, with flex array.

The struct is allocated, but it seems like there was an over allocation
error:

fw_buf = kmalloc(ALIGN(fw->size + sizeof(struct sms_firmware),
		SMS_ALLOC_ALIGNMENT), GFP_KERNEL | coredev->gfp_buf_flags);

This change fixes this cocci warning:
drivers/media/common/siano/smscoreapi.h:669:6-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/common/siano/smscoreapi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/siano/smscoreapi.h b/drivers/media/common/siano/smscoreapi.h
index bc61bc8b9ea9..82d9f8a64d99 100644
--- a/drivers/media/common/siano/smscoreapi.h
+++ b/drivers/media/common/siano/smscoreapi.h
@@ -666,7 +666,7 @@ struct sms_firmware {
 	u32			check_sum;
 	u32			length;
 	u32			start_address;
-	u8			payload[1];
+	u8			payload[];
 };
 
 /* statistics information returned as response for

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


