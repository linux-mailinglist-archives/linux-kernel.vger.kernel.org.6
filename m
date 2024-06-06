Return-Path: <linux-kernel+bounces-204346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A7C8FE77E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EED4285CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B44196450;
	Thu,  6 Jun 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hz5QRfdb"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C4E1974E0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679859; cv=none; b=Esu2uuZpD3KDn2BsyfiJJ7iqWWp5ygTvM6gFanTUCYfH3lp5/c7hgK2FwOkJokal8azEu29GgCRDVNE++x3iv5ZzoeeyRXvpgog/FEx7vYrgLnmd4NbdKYI0QY+SQ5gxMDsJfncY1hOwD7tQTMLftDJ0ziWUWM0yrivVgtJ1pxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679859; c=relaxed/simple;
	bh=eSS6CFxpjOrEMCtb9xmg56c0gCLfaI7dITUwdjRcSbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZt1fSmaPj5Eu2lZv6MhJyjXSgr6vB7C7EXFd5IXR/nrUSa67mmUtJYWWIMR0CBMsi9OT5OXizeVWSzhHutKEfTIuNkjxQMh/Fthu0LW+K6y+lFsRKIGjoau1jfg660tGBr/6Y97NHnla0eMAsCgNK7aRJ58UDfLb8DImLH3Mcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hz5QRfdb; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6af55412d69so4126886d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717679857; x=1718284657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAc0af9hq9pueFWwvpNqs+gjxvVge6a6O9DHrtQZV0s=;
        b=Hz5QRfdbzej5QLlbrWvb4i+VPuU2IgPOnLuFxX7frGcuhbkT9mZy3FbM35RiBVoJIv
         7zeEOd/K0SSh/F0Vaeb8eQOq77+5ef6L8xe2HOYFsGB7hcgUHaSRVw5T6ru9QvcDGFHz
         m8FvAIrqdJkP8dyR1Qo6oJuLOWyFLcxWsewKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679857; x=1718284657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAc0af9hq9pueFWwvpNqs+gjxvVge6a6O9DHrtQZV0s=;
        b=Hko2lx1q6tAhuWku+dwzPHnm9qmC9jfT6wLQQRF2WHp05m+6VzmBaxtSfCyxrpvijL
         e+ZOVLvVAY/FHAlF2S/FPzAR4WJ+/KkBLxmtHoHK1rg/1clQnq6JRggnMqXMkoobW/TX
         iWAY7wEoclxxuApGhYdVaKqjDWSVSmCrFEFmLN+Isl44yhZkqri9xIYd9LsWwx3iGpFj
         sBL33aacGl0Gy7XJquwT+WXV7+g/aIqNFBDUAGwzQ/KjouEqYd4pW+1pO9cgUjh4uXu8
         +cgumFgpjtSGG9Dgu5ZRAj5MUA+V6JFz9eHfuJGUVcJ1nmO4Iu/ge7XbwwNtqZKBVF1t
         pjzg==
X-Forwarded-Encrypted: i=1; AJvYcCVpx2ilOJ7WBnmmt9hPEduUKUi1uKWEyS68Dggxu1oGWpgFb/znppmvYjS3bH7l8SOimyJOJ47iURekE8hiVSntQP03jAIuhs4VU8X/
X-Gm-Message-State: AOJu0YzSf/pxp8Q88YJOBGi96786JYJHvWE0E5X2D5eNgFO/cNALj6rY
	cp5NLlMbN6xZwFnYO+GWffC3cEHPao+Ens1YC+xeUW23OtUmMNi8cH+vXn7Muw1a00j1+Fy4hxP
	ACVTW
X-Google-Smtp-Source: AGHT+IEJIOJiyMJDDmMHLc74buNW9eEFQjpvgj2J4ah7/DbHCd2DHUJMyDhfPoLk1ARALTqqXFgIww==
X-Received: by 2002:a05:6214:451e:b0:6af:5af5:cf63 with SMTP id 6a1803df08f44-6b020320c3emr73595046d6.1.1717679856728;
        Thu, 06 Jun 2024 06:17:36 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6607f5sm6118036d6.31.2024.06.06.06.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:17:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Jun 2024 13:16:40 +0000
Subject: [PATCH v4 06/11] media: venus: Refactor struct
 hfi_uncompressed_format_supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-cocci-flexarray-v4-6-3379ee5eed28@chromium.org>
References: <20240606-cocci-flexarray-v4-0-3379ee5eed28@chromium.org>
In-Reply-To: <20240606-cocci-flexarray-v4-0-3379ee5eed28@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

plane_info is not a typical array, the data is not contiguous:
pinfo = (void *)pinfo + sizeof(*constr) * num_planes +
	2 * sizeof(u32);

Replace the single element array with a single element field.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_helper.h:1009:36-46: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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
2.45.2.505.gda0bf45e8d-goog


