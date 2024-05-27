Return-Path: <linux-kernel+bounces-191431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5264D8D0F15
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F03283289
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B138169AF5;
	Mon, 27 May 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PXkP8kUF"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759C168C3F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844144; cv=none; b=arbMmas+O7YMURvqYRcHkMb1mthGxV8MvYTMD2PjBSIsFWpIUPIiQ638oSDzwjNH3ZKivxPi0l+OgLhlXoQH0bIwRs/JXCL60lGwFyUaAjn6vbSvQHJjpl2vRtuEBblOhZCjL5BycXgqjaut1Iki7Z9ESAg+uf7VI8EcJW9obtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844144; c=relaxed/simple;
	bh=00nzIkoHTNIKc3OYcYRUmI3ETcNlAeSphWbClDXv8F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3CZzSnWN1cnP2TCOI3C0lKE6gagrV9sCuOl2JIcfXW4sOPrqL3jtK6h/1dbLyPN3hppQ/1/e5+tEkFgtxegN+/mIqsLyMQ3rCqidtsoHJyqrm8nObiMbV3vNUJXCnrtgry6YFWH7YZEWUnix/0AyGD5Im3L1qePfuZXjrYNiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PXkP8kUF; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-794ab0ae817so13399285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716844141; x=1717448941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuxfMIsewXqkBzK5BeYTD0bqNkQisbi89qotRNy4YBs=;
        b=PXkP8kUFahC6n2hMVqlULQwdbOBEJ2EvztX7xBhCCAgYqQQSb3cNNZ1Jx9ggfzaH15
         aFE1B7RwrBQUTQ+QhS+DsRomXrSS6IUiAEGc8lYj0VvQ8HUTngoTf39VDlzxjh7nEOu7
         G5A+M9O/BodlpValA7HUKiuM/ooDLW1bX76qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716844141; x=1717448941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuxfMIsewXqkBzK5BeYTD0bqNkQisbi89qotRNy4YBs=;
        b=dRmHfFW4JCFviql0+evxOgG6SU/NKWwKlHC3DRcUkOgCE8hjAnHDmZ/R6OzasbvK3H
         RmlwWqGp77LdKtRs1wXQj/+UHTPvQXtuENAyy+ImsZYx88Us47Ob32cEc4yAu+uHT7Em
         U4afNJvtPBco9FXh03aCyhi+1BiwT33XkEYKp6sOp8uqhsNbQZ0Ff5dLEXdsNejVU0A+
         5gUQmcLU2njd4cmNuP10Yl+Yvz7ElGJiLHRucbdDTzoSptHljP/c2jyQTrMtjvBCklAM
         J8uH3Emf49l7Dd54D/+d7kVA/Izzhtz3Yn2smideHZkJw/kY/avDrWaf6boTpEgLNXab
         u9yg==
X-Forwarded-Encrypted: i=1; AJvYcCXn9YDbpdOmo1giV1dlHm/IfCbaa+bXWhjOt5nRBscDEsgVqt0AlArTgikadfFOCB3Did8q1LkHF9pJudIAc7x3TRJMJpxf04vzIZEs
X-Gm-Message-State: AOJu0YxwAzLYUV4WHrt1swQldytrZaWNWQ2Kzdp2RpRMQFkSxdIQ/K+o
	T6O4/iat5IZpwEVyjmQh4B5mKX3eYcVrJ7JLLffHeB+f1AyACYljjSpMm8zYnA==
X-Google-Smtp-Source: AGHT+IGqdInSLU92W7+DtYzv0+k6nwEHlNXV5KrK57NXQ1324WfJB7q1ATelwAen4Mc0bFmHLxIsJw==
X-Received: by 2002:a05:6214:3bc5:b0:6ad:73c0:eb22 with SMTP id 6a1803df08f44-6ad73c0ec3emr79133716d6.12.1716844141308;
        Mon, 27 May 2024 14:09:01 -0700 (PDT)
Received: from denia.c.googlers.com (125.135.86.34.bc.googleusercontent.com. [34.86.135.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad850a6dc7sm9511866d6.93.2024.05.27.14.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 14:09:01 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 May 2024 21:08:57 +0000
Subject: [PATCH v3 07/18] media: siano: Remove unused structures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-cocci-flexarray-v3-7-cda09c535816@chromium.org>
References: <20240527-cocci-flexarray-v3-0-cda09c535816@chromium.org>
In-Reply-To: <20240527-cocci-flexarray-v3-0-cda09c535816@chromium.org>
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
2.45.1.288.g0e0cd299f1-goog


