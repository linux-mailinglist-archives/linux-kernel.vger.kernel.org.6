Return-Path: <linux-kernel+bounces-171406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E258BE3ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8099F1F21C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F70A16F84E;
	Tue,  7 May 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bOMgnXAQ"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DFC16EBFB
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087925; cv=none; b=VUq7VhsN/B6qzf9oJpS+KaTVwBpZ4iTM9GqwgjE2ywpCLczLGPkzQovyXyu1NgMSM5oRN2mqjUhkOeHV43GD6xyD5NFvpF6UdXwT2mnRvtqD4y8uXZhq4iYJRhtnqpFFf+4nvzLHHD756asSRWQ5uOZIDMXSs1fUxitdIoFojG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087925; c=relaxed/simple;
	bh=EDdfr0+Pnj9r3H0XIbqR962gzmaw2rY41SXbAP3xmuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cEA7rHFdOhQRmqLISHyB1ofHPCVYZkZmSgL3ofBHDNHglsjQlgXrnogw23rwdcnBOIiK18N7+Durgtbqh6V7Wt8zs+chTqxGA1U68SNeQUHL4Jq+lBVRhgKc5Og23ESFpj7x2DVKJ8FeQAisKZMWuIgdo8JabiRB8iuOxz9qr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bOMgnXAQ; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9741777f0so561832b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715087922; x=1715692722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grfwfbVNg0FYwVP8zOHueia/jYu69rJdnTVnLodDO7c=;
        b=bOMgnXAQIlSZ3+/vgUBIIa/mHpEFDCRanOzOdnSiWt1kvfa1jab0oi4iNDST74XXqk
         eMY8oXCbnQdPQejspqU4D3iNXc5upN8R96HVrP2IKCD4YxEC5wmlGufJA/By6sn61hw+
         1rj+NVp8HagunRxlzzj7kFWKxDD9aSiQ3yZug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087922; x=1715692722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grfwfbVNg0FYwVP8zOHueia/jYu69rJdnTVnLodDO7c=;
        b=EHxtXMU2TyXntGhbUl86i8KXrU/hu+F3HkPSLgsG8Nz+dR86m3ST/DqBcxTrKwj6jI
         ry8oMkS00ojQzvZoI5ZyAR26cLD6uaNMVV91AujP3l1r9g6khEW/6JjZ2aLzCf/TmaHi
         P170HecTksUGfKcLq6zhvl/bbyNAGulstOPKYoEo1vetBpGDpzWXhbcBQBOvfJaFnxsu
         nqpApeXbrde2o/gzFcluA9ZUhZxzwSm4Ox4Os90yc07n8VW8lveTVrxzK0cAuT02Hilh
         +tU1RQqCm/Lk1xCUDS5W75tuj1wn1TRmk/sj8e/zCUkt4thiUhIknzDLXCz90QzDQpe4
         Dg4w==
X-Forwarded-Encrypted: i=1; AJvYcCW5MdPV/0s3LLZ7GR88ks3BfnG5esSQcG9UosIRlrY/TsyxjsRlEZmOZmBGZ1+/R3GepJN6f/5zEmqKamkD82qFqv/UwcI2hDUilfsg
X-Gm-Message-State: AOJu0YzuM6Gl2Ac2PT62osWVMk8d/qDu7nN4By2lJ0l5PqxxKmowwArx
	BnEB377LXkvPrHMWa6cd4ybSClFwq9DtoDIGk7EfhtWiSmiJEyqc2+gkvt4vFg==
X-Google-Smtp-Source: AGHT+IFSSR3o5HtKdgIS/uE+VKpBV5Rv+stUdj3V5A3bS3LVQVk3ZyFe5CBq7bVuSTRuzIUL5DJ6ng==
X-Received: by 2002:a05:6808:210a:b0:3c8:6223:c7bc with SMTP id r10-20020a056808210a00b003c86223c7bcmr17391584oiw.7.1715087922276;
        Tue, 07 May 2024 06:18:42 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id t15-20020a05621405cf00b006a0d19c3139sm4655105qvz.118.2024.05.07.06.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:18:42 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 13:18:39 +0000
Subject: [PATCH 13/18] media: venus: Refactor struct
 hfi_uncompressed_format_supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v1-13-4a421c21fd06@chromium.org>
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

plane_info is not a typical array, the data is not contiguous:
pinfo = (void *)pinfo + sizeof(*constr) * num_planes +
	2 * sizeof(u32);

Replace the single element array with a single element field.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_helper.h:1009:36-46: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 2 +-
 drivers/media/platform/qcom/venus/hfi_parser.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index eb0a4c64b7ef..dee439ea4d2e 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1006,7 +1006,7 @@ struct hfi_uncompressed_plane_info {
 struct hfi_uncompressed_format_supported {
 	u32 buffer_type;
 	u32 format_entries;
-	struct hfi_uncompressed_plane_info plane_info[1];
+	struct hfi_uncompressed_plane_info plane_info;
 };
 
 struct hfi_uncompressed_plane_actual {
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index c43839539d4d..3df241dc3a11 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -157,7 +157,7 @@ static void
 parse_raw_formats(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_uncompressed_format_supported *fmt = data;
-	struct hfi_uncompressed_plane_info *pinfo = fmt->plane_info;
+	struct hfi_uncompressed_plane_info *pinfo = &fmt->plane_info;
 	struct hfi_uncompressed_plane_constraints *constr;
 	struct raw_formats rawfmts[MAX_FMT_ENTRIES] = {};
 	u32 entries = fmt->format_entries;

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


