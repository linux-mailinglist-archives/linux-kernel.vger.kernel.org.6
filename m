Return-Path: <linux-kernel+bounces-286370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CCD951A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8CC1C20A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C21B3F05;
	Wed, 14 Aug 2024 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dl+QfuuJ"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20701B32B8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635580; cv=none; b=hPayiQbvmLcdFw2L2ndf5XJriBT3OdM/TR4/UuR2gZwDFuw7h7G1T/RVsgBtQLAOI384etEVmZ2N5h1CbO6nTLqYflUR68RmwmJkSfMS59zns99qoldjwxIc1Z/CkoNnFIxKqocjdhh7CJBLS3C2814T8W01YEA8LUEp8e2Ccj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635580; c=relaxed/simple;
	bh=+CaEvMFtp6+vW8dd+4vdYR7UCy2/V+0eTuF+Ay8On5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WU0Na6BiUlO1ic3qe8OBT3SW5UFSnwwCw9qcv+7EkRACYrwpiS5oCnwrPOu7LLpB8hd8zvwX88hhKz1rceKJzE0jU/qHD65bSSyeMTn0oTeQL5482CF85htubi4Hn1Errc8B99GqTT/hanzNKfXV4uMLQOeI8v1Gw9Gm2hmLzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dl+QfuuJ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70949118d26so4804230a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723635577; x=1724240377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GH6hs7TBxxS/YEw6+1SJGhyHiJvtnJuQXXY87tDn62g=;
        b=dl+QfuuJiepA0A96RA/13tNw9Gls+s5+sJNv8SvpTJQTw6dnpKwNgMSkbFEbUlPpyR
         aYvoWDSB7nGyf9LbgZ4GaFgDJDdaOZmfUvPDO/M/rGc254ywYRd5pvI3+dDMJ3Q2w88T
         yJumYIb4YDlfz/RtTDucpvHmITPnBYiIu/rb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635577; x=1724240377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH6hs7TBxxS/YEw6+1SJGhyHiJvtnJuQXXY87tDn62g=;
        b=h8qeGILq0oNQ1EbNT7DdvwUSIoiu7umV4JcDa0sRyZp8Vcy7EdjGCed1QkEBQULhNG
         GJaL09wxvWzeV8QlqkMJLslckp/VtdUapvY0hKM8EgXkY62qtbJgYJn0aVeSQwyl3Mft
         qo9ONvoa+HS+5iyQ+vNWf7A1qhvOIimmxdcg5x+wzqRJDZv7Le0BJOPiUS99SUu/jmN/
         /cJ52uyupyG+QKPMzgmmdwd+dQqGp8iXkyh93gSMqVTIgo2vU3zfHOW7iGw8T4lxShdK
         UPHB81i+4Liwtyof2U4BxZuBirZQHp8CmUh8s6FfM6SwMFkRU77ixYNoykaEvlGL1PFH
         7hLw==
X-Forwarded-Encrypted: i=1; AJvYcCV6zXrAQVfEBwAyoWWm8mOBhEASee2iBRLuEc2QaPhBLNEijU3tDL5qFI5j+CyyYZoJ7ULfEj5jjp72Xr76DM1XjZoD8xcEKVfxn/OU
X-Gm-Message-State: AOJu0Ywxk1iwHl4P5eMI+J0trS0SznZHd1Rh+O/2MLWgpjZsr6CF7M5z
	8mYC9PXSK+k0aDQTPqxHVukgycqt1k3M9QAnh3NLCJgx4zyTju7VweuXJpJw2w==
X-Google-Smtp-Source: AGHT+IEtMdN3+LLVZ8wsdeGDjt8+c2zo2szF4F9XAwgyc+ibeBZWZn4V0pAfv9GBu2VgPAmVm/URKw==
X-Received: by 2002:a05:6359:410d:b0:1a5:dca5:a902 with SMTP id e5c5f4694b2df-1b1aab85aabmr281649655d.17.1723635576908;
        Wed, 14 Aug 2024 04:39:36 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca0daasm42167916d6.68.2024.08.14.04.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:39:36 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 14 Aug 2024 11:39:30 +0000
Subject: [PATCH v7 10/10] media: venus: Convert one-element-arrays to
 flex-arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-cocci-flexarray-v7-10-8a1cc09ae6c4@chromium.org>
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

This structures are not used, and have a single element array at the end
of them.

This fix the following cocci warnings:
drivers/media/platform/qcom/venus/hfi_helper.h:764:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1041:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1088:39-51: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1093:5-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1144:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1239:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_helper.h:1272:4-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:85:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:180:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/media/platform/qcom/venus/hfi_cmds.h:189:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.h   |  6 +++---
 drivers/media/platform/qcom/venus/hfi_helper.h | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 63b93a34f609..1cd1b5e2d056 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -82,7 +82,7 @@ struct hfi_sys_set_buffers_pkt {
 	u32 buffer_type;
 	u32 buffer_size;
 	u32 num_buffers;
-	u32 buffer_addr[1];
+	u32 buffer_addr[];
 };
 
 struct hfi_sys_ping_pkt {
@@ -177,7 +177,7 @@ struct hfi_session_empty_buffer_uncompressed_plane1_pkt {
 	u32 filled_len;
 	u32 offset;
 	u32 packet_buffer2;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_session_empty_buffer_uncompressed_plane2_pkt {
@@ -186,7 +186,7 @@ struct hfi_session_empty_buffer_uncompressed_plane2_pkt {
 	u32 filled_len;
 	u32 offset;
 	u32 packet_buffer3;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_session_fill_buffer_pkt {
diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index 755aabcd8048..f44059f19505 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -761,7 +761,7 @@ struct hfi_multi_stream_3x {
 
 struct hfi_multi_view_format {
 	u32 views;
-	u32 view_order[1];
+	u32 view_order[];
 };
 
 #define HFI_MULTI_SLICE_OFF			0x1
@@ -1038,7 +1038,7 @@ struct hfi_codec_supported {
 
 struct hfi_properties_supported {
 	u32 num_properties;
-	u32 properties[1];
+	u32 properties[];
 };
 
 struct hfi_max_sessions_supported {
@@ -1085,12 +1085,12 @@ struct hfi_resource_ocmem_requirement {
 
 struct hfi_resource_ocmem_requirement_info {
 	u32 num_entries;
-	struct hfi_resource_ocmem_requirement requirements[1];
+	struct hfi_resource_ocmem_requirement requirements[];
 };
 
 struct hfi_property_sys_image_version_info_type {
 	u32 string_size;
-	u8  str_image_version[1];
+	u8  str_image_version[];
 };
 
 struct hfi_codec_mask_supported {
@@ -1141,7 +1141,7 @@ struct hfi_extradata_header {
 	u32 port_index;
 	u32 type;
 	u32 data_size;
-	u8 data[1];
+	u8 data[];
 };
 
 struct hfi_batch_info {
@@ -1236,7 +1236,7 @@ static inline void hfi_bufreq_set_count_min_host(struct hfi_buffer_requirements
 
 struct hfi_data_payload {
 	u32 size;
-	u8 data[1];
+	u8 data[];
 };
 
 struct hfi_enable_picture {
@@ -1269,7 +1269,7 @@ struct hfi_buffer_alloc_mode_supported {
 
 struct hfi_mb_error_map {
 	u32 error_map_size;
-	u8 error_map[1];
+	u8 error_map[];
 };
 
 struct hfi_metadata_pass_through {

-- 
2.46.0.76.ge559c4bf1a-goog


