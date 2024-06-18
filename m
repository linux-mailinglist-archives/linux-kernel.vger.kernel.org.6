Return-Path: <linux-kernel+bounces-219486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5DA90D349
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F280C281B03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8D216DC26;
	Tue, 18 Jun 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SFXobsN7"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CFE16B3B7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717879; cv=none; b=fnq6HDKaomklX+dEYSrvRxaMYCvZ0h9uX4whhz+bts3Bw/EDHs2FWZD80wBfeeZ5S0uao3axWdvYQyPVnX4yzsWxmM+HR1GUssMTDHVb1n5lDlcTDVwhYD+FylY9hzddHtcxeQnCIrXvYE0KlS1tDz3dkBcSkwYz7kM1ylFY7Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717879; c=relaxed/simple;
	bh=iELnSY5gu3MPwTWIlT31gap3UcK/8g4Z6s90Q+ubKso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=inzA2JKK/MEcILW4JhTzzLOYIEwA8Ocx0ofauaDlKOmsimXwVq/RgcUGzuxMY9VsJyT8B/RcBU4AX/M4gusCDdgqusP9guXTND/XrdGCpDhehJwFSUL3MAqFmjCDeigemxEsg1s0AcULVT3Pq2VUZ0OvSri6TTvXUcKh/ynnkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SFXobsN7; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-797fb0b4832so269354585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718717876; x=1719322676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MW9bvh2bp76Of1yyIbqQelf17GV+Jkv7epwXCqKgstg=;
        b=SFXobsN7Y6qcPfXteidGdyqryJ6i8m4cGzKjTwpBzq723v/hKxWvLJVMJXsvJ/NfY/
         Rks9t35kGa4vZhavMRJK7XsX2Unhz6aiZigj1eoiowFBgs4t44czVOlB+IFfZslA1CtK
         7VHHA+tKaSB68PEB5xEUwFVN8nNkYmd9PlAUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717876; x=1719322676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MW9bvh2bp76Of1yyIbqQelf17GV+Jkv7epwXCqKgstg=;
        b=mVgwdGSjHSnsEXqSDwc+9XSUGUdNmPJxMYnR+8Lz2s6x+jEJ8A+k5LAjyIV1OzOLbP
         7URS6vEJ6byg1eejhsfLsBUmX49ifJkrjOUCb/ixfiv1vxeUFnp65YEe3/FqsVxnTJ2e
         KqwyvbirVhWTKXn82BRU4Q/aP7434cJ6pwnFBkeszRubxEMYf3q0eWjPmuHNLklIVPI/
         wVL9ufyRhTPIpZXdj5WNji/zToXCkyRfea8c0PB3TH52dLyaoOq6rY7hL3rx4FJEvf18
         gh2lTjpOnQmwnmnD92UOsde/RQD+ggg76LTh56m+j7jmt0d4EoJ/jJKEbHtKpchI7+dM
         /N2A==
X-Forwarded-Encrypted: i=1; AJvYcCVMIfTcp9GUdVBnOzpq1YqlCoTri151NZqFcAwlG5nUZVI/jyr1+t6wEfrFqYcQSEauViKt+rtfDVDdqzmy0O9va8GAyXJwpIi0uFKn
X-Gm-Message-State: AOJu0YyRPsaT6HUjXweeBfGl8xnsiCFMIXs2uCr5/9cxSUSg4OIiUpPE
	Xw5RB+SU3jNA++DpKGL3+DHcblj+YrCvc5OWgnstFX3b2s51eM2FZ9tjRL29pw==
X-Google-Smtp-Source: AGHT+IHUPkEjN1Rk4xvtyWc0bLx9LlZNTQuD6SlnDrxbm7CEFP8MpAyoWDysNL5JPs/xrPrkaHldpg==
X-Received: by 2002:a05:620a:2586:b0:797:5765:b844 with SMTP id af79cd13be357-798d242f63bmr1493021685a.37.1718717876400;
        Tue, 18 Jun 2024 06:37:56 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc06e93sm521666385a.82.2024.06.18.06.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:37:55 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 18 Jun 2024 13:37:49 +0000
Subject: [PATCH v5 06/10] media: venus: Refactor
 hfi_session_empty_buffer_uncompressed_plane0_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cocci-flexarray-v5-6-6a8294942f48@chromium.org>
References: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org>
In-Reply-To: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The single element array data[1] is never used. Replace it with a
padding field of the same size.

This fixes the following cocci error:
drivers/media/platform/qcom/venus/hfi_cmds.h:163:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index f5708fdfb197..8768ee052adc 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -160,7 +160,7 @@ struct hfi_session_empty_buffer_uncompressed_plane0_pkt {
 	u32 input_tag;
 	u32 packet_buffer;
 	u32 extradata_buffer;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_session_fill_buffer_pkt {

-- 
2.45.2.627.g7a2c4fd464-goog


