Return-Path: <linux-kernel+bounces-286364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5731D951A18
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDD61C213FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9181B012D;
	Wed, 14 Aug 2024 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kgLa47Hc"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158471B0137
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635573; cv=none; b=Zdg7boV8xDudLHwN5RxOlOTdQhtrLcD0xzftkx6hl7UICSY7EOjcg6kWQet9STM0h/UrDcZjoNvYMWkt11IiWnv7Ry50iCPtXkxnQHJFgNVQHc5xlUeU01hgyjhsa9CJzd6RlgDqaPlvHwh7/spv8WUihzETwH+qtpwQ5YbE9K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635573; c=relaxed/simple;
	bh=Sv3wnLESn0x+4EjPwl9XXffhuwptYLQmakQ09d0MPlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTe2NJsdnko+SbsfFTOJUaVK3fT+ORJTSl1webZpSRVUxryasrCSH8BxLt5W8nMBb32cqxXPt8nfQQSylutCG3xC7oubGtXVW/QPHx5EtFuxCagvnvdJoei5p076mCQ3IHSSYJd4NnYvILelw9VXHLqD6xpjNvumh7fB+sga22U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kgLa47Hc; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-651da7c1531so58948087b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723635571; x=1724240371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbZBMh9jJa4Sx0XDfCtUJJo6xYR8XeaNAE9cdhAst/g=;
        b=kgLa47Hc91zsevsh8GSdETSKT864Rccdl7DTPd8C3ry8ZTXANsv16F8HaBGoBfBRFr
         iu2Rp8QbabORqOYCYwk70uvqzi45fG6SQ/14Q/9UzG4AoEeNdQkzWondTfbGXhZRgtk9
         8tBT/dkFPls8JCmzd6/DSL7IUanKkdMS1+TIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635571; x=1724240371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbZBMh9jJa4Sx0XDfCtUJJo6xYR8XeaNAE9cdhAst/g=;
        b=IgLzVumKSvGIm8ooernYFMaJ8XG/CxuR/X0sSnMgKcRwqCouR1ydj+UmWXx3iLhoGM
         5nR9WVxGbCiizF6Ax1kWhnrnoJkmqk/8eXvSSrZIPPGCnNh3IAMhGx5s3AcfleWU9dCH
         2fH5KTfUJgkgY3KJQGamHg6Ku7KHz6V6kH6OJKKWI710cKysr6yaPPuAIlYsRl7EmQfV
         DkhTefi+TBecU7oZK/4+Lkp/EFXGT0MOb1Bpg83/C2Ry9mdhcVK9RkFgyAUOYktUuet8
         a0gOH5jtxbhRnMhE1Ahvpd5uSJBgDePdd1LSlhqo+vsgqagwf0Tfemn6H+TTU7sHxA6N
         dSYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMZH/22CJceVJdazbn8rGXe4g3a/bzLV7SZfXDyhIWDzsQdr1AMlmyWr2fiz3t0u6ySsFQPF9CbP0fa0l6X18cBnZUd8D/WxiaFNM2
X-Gm-Message-State: AOJu0Yy/W0szg4h6srcqKm8IawXePxNK/qOerTipXIcttANGJ42gTMkK
	KxXbeD9/uzlxSG6qawKilmUlDzf/4bFsJ/la/6iMbQY6quauqGm81mvpBALQHDvcGlPc3/B7Wrw
	b3y1p
X-Google-Smtp-Source: AGHT+IHRsykAwCMx5tZRxY5hmqyA+Ey5x0wiBbORQkW1hfMduV6yGvJe4ltt2zFO97WRae+NRAydfA==
X-Received: by 2002:a05:690c:fd4:b0:62f:cb31:1be with SMTP id 00721157ae682-6ac95696a52mr30104587b3.8.1723635570906;
        Wed, 14 Aug 2024 04:39:30 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca0daasm42167916d6.68.2024.08.14.04.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:39:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 14 Aug 2024 11:39:24 +0000
Subject: [PATCH v7 04/10] media: venus: Refactor struct
 hfi_uncompressed_format_supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-cocci-flexarray-v7-4-8a1cc09ae6c4@chromium.org>
References: <20240814-cocci-flexarray-v7-0-8a1cc09ae6c4@chromium.org>
In-Reply-To: <20240814-cocci-flexarray-v7-0-8a1cc09ae6c4@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

plane_info is not a typical array, the data is not contiguous:
pinfo = (void *)pinfo + sizeof(*constr) * num_planes +
	2 * sizeof(u32);

Replace the single element array with a single element field.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_helper.h:1009:36-46: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 2 +-
 drivers/media/platform/qcom/venus/hfi_parser.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index 5e91f3f6984d..3edefa4edeb9 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1011,7 +1011,7 @@ struct hfi_uncompressed_plane_info {
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
2.46.0.76.ge559c4bf1a-goog


