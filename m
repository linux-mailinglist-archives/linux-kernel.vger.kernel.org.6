Return-Path: <linux-kernel+bounces-171816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD908BE911
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B761F23016
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E59017F398;
	Tue,  7 May 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kijo11kH"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9A171085
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099247; cv=none; b=KYOgIk86xSGMw/oKhjsEqB90Ql8vYZfoeoTXjSfPcFSq21icAPyTyG8XAm8hrDw/3qseHm9a2AQJOY4GtjKYKPQEPwgb4EEcXgWyS6CVjEH2TriRzFEdoA+p204A6Hl/yxCdB0xUqbrvDJfJxgYx7gXfmnczOWKqGEA2HcPU9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099247; c=relaxed/simple;
	bh=xx+wxFNs3ZuqK7Hxds/mLdbM5HIFghI8UQG5DaBamLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6FwvxWYF61XDaeKAVP1Exwq+Ha0RKEVflZXGUQahvhZ9COncD7cYNKorkiSP3oYcsgUlR+uV7XGref/RWJGPUDXDtWCm0qsfx1D6e2DWLnF4OvWf/H76map7h/UDMIufeTlqW3FeXjdW9s/G1z13vkR2vHhSSDm8M575yRXOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kijo11kH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43d4a2d0a0bso16204511cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715099245; x=1715704045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24yjDTHuOCF+C8SbX9O7bVVIA87jnk99ezK2b/3Gma4=;
        b=kijo11kHp2VAvCMSD4iUw/+pq4P4CA+f7MIsCw0/FUSb+XujX+hkKeCu264OA5aDBA
         5wdUM8cO+wONlCxMUKFSKDh721ktw7XSngbs7+Rd90021jKDJMZvbRBUegNR6CIVvnz2
         Rkgqrs9ZYugnUb5sh1vbaYj7t8FOMVc1EvYRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099245; x=1715704045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24yjDTHuOCF+C8SbX9O7bVVIA87jnk99ezK2b/3Gma4=;
        b=eF5sWtqtq/ByPc8Bs0k7EAJsdmB7/6EDtWgfPUDQX8lahjpzZ4U0/oHLXhIdTdvdmK
         hu6b1Z4UKOboFsM1D/gvsLYEZdSG5WXPgu7dCMszrtHGP2OOovBN57gl7whfGSg9glQF
         RIeb/QqfblJ2jjLMx7I13wsIpneGHfCX1I6tMZFDkwcwaDyMmNSIRReOpqEoDuJTwNFQ
         NK8wAWf3NZ5pobHpvuofiaKxYExToo/TiwrsjjEZ0/oBVPaMGrmRTOV5ZL9NZumw2/8n
         BNGcrU8P+6uw/tCHsHwupUQxOoKqKCWZdk4YnJ0DRreGSXQJT18VvNIyWJsOfxUsPwur
         y6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWGnP36hHimAfZuL5E0PgMeaV4VbJqVSfob+gygiKpwlJTUHp0CaiMcsYUdI0VmkZGbqEtlKQRVRZH/9uUSgjy1wR5ZQPIPBNGeIFub
X-Gm-Message-State: AOJu0Yx+b9r1TTpvKJw4KIrsX1v9+JJA6u9AXERvRilI4SUpmPp4aOkd
	5tugbJknfyXC31mhZthTrIfATBIaNPyYCTYYQ2DxJqdiuDALTWDoAqcIXdyr3g==
X-Google-Smtp-Source: AGHT+IFXk9TiPGkyPd47b/0bfL7TWw3sW2kfDIDAt+NnUsqL7Hhdu3EhERFFZlCigfyFh6dM5Cuiow==
X-Received: by 2002:ac8:7e8b:0:b0:439:dfc7:aca4 with SMTP id d75a77b69052e-43dbf868fd7mr1746031cf.63.1715099244908;
        Tue, 07 May 2024 09:27:24 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id hf23-20020a05622a609700b0043d1fc9b7d9sm4160597qtb.48.2024.05.07.09.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:27:24 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 16:27:23 +0000
Subject: [PATCH v2 18/18] media: venus: Refactor
 hfi_buffer_alloc_mode_supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v2-18-7aea262cf065@chromium.org>
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

Replace the old style single element array at the end of the struct with
a flex array.

The code does not allocate this structure, so the size change should not
be a problem.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_helper.h:1233:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index dee439ea4d2e..9545c964a428 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1230,7 +1230,7 @@ struct hfi_interlace_format_supported {
 struct hfi_buffer_alloc_mode_supported {
 	u32 buffer_type;
 	u32 num_entries;
-	u32 data[1];
+	u32 data[];
 };
 
 struct hfi_metadata_pass_through {

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


