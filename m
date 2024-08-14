Return-Path: <linux-kernel+bounces-286369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C398E951A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F918B2141B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ECC1B3F01;
	Wed, 14 Aug 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WtSgc2N6"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2731B29DB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635580; cv=none; b=J+hoKM36f1WYeCtKWv2QG2+yb7aQS2wMVrlmfg/yFkTJHhpD1jUJ0yXMapuw3Ylh7mde/QLSy7tWuJks3cu0BI4rSSxDnQcBY/mviTNLlyMWjiban9p6Z4w43yjAheTIEZg1CrIICe3rhEt+lRjbOy2dYtQ5clhTQmyfnrGLGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635580; c=relaxed/simple;
	bh=RUkSvotJiUicAjr125zoqk67Yg0Rr4Z0u5b8fZH4uhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lkm3SXDcxt7e5iXadrf+ecGvhkr+mFmGu66lMFvlMFZkBV0PLJOyxJvnAWF3vW8Ex0OnAor9yMY7HGH9SNoTWphnSQ2Iy6RByJsUqeg6lrEYnvVyL2U8q3GaVpMdqrqt96hQ+HgPC1pZv/pkxba8ZH1iB5OX7wmpTfCi7zkfETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WtSgc2N6; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-709346604a7so2833633a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723635576; x=1724240376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RN7Dnd0r7pjMqaCAE+J4vLBmG7zkz8JhaZ76ns/e/WE=;
        b=WtSgc2N6Lp5Fl+Grd8i857ttdZESlfUR3gycn4LSWe9mgJO5RleWN/SDlvDQFFaKTS
         66ca51LN954cVM1yzs2dQaL0kta7EzRXYt3ZdzafFGHckK1YJkZmaNB49P5Tw6aAjIED
         ph0J44PeYGW93g3Krf3LrNhL31cveht7AlS8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635576; x=1724240376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RN7Dnd0r7pjMqaCAE+J4vLBmG7zkz8JhaZ76ns/e/WE=;
        b=nYEFtB7iuqfMe9Kv0tibDfOEbER4x9P32HRDOZ1SlszEu5vfQKyTD2o9ZpuNbKZbeG
         KjwfpmkLMDgEXZ6t6AgptT967VaiHErkgZG673zcJw3nb5SfL7CQ+qc2Wbz2TS9V2Eze
         o8p0uKKIw7JnGElWNRC6BLx9wA1kgh2So6MD+R2SLbYI16boPmELVsFNuz4jrcIpI8yP
         I4HVzESFU4re2nO7Cq3AFq204jtRYsq1BSpv+09BSqZPA+vIIsw321cBRW/cdUL/RCV9
         gZAUnlUL4HKERBCl0qKInUuI9cO7mLgLhMiaJ59VOJlcNinZ6fFP8bT6GdNWs2AS+aJ3
         2tLw==
X-Forwarded-Encrypted: i=1; AJvYcCUiB9CpI6oNq8uE3Wfqgz8VrtWmkjzwUbaYZ1nmF7TLnIO/+q/TwvEjj7s1B6lSpWaVRk51VhuTDwTMwe3GhyQVsfCgFQJ6BaCqYWyP
X-Gm-Message-State: AOJu0YwUNvOMHmAJFTaEKWWi5wqtZI0BnqDqHFcKzVcP4htpNbAmFRK7
	6t+KzJPUMdKwrFRHSKoCeom/rGt3lQBP6k0C2hQR3TF9/IiGIFz5aWnezdLGgA==
X-Google-Smtp-Source: AGHT+IGw4C+RCNiH4eerEXg4HBAuopT+VKBys5fIpTb7JFfXnmm4MV/gGIeWJWYBjoI+aevyYEu96w==
X-Received: by 2002:a05:6359:410d:b0:19f:2c7e:a226 with SMTP id e5c5f4694b2df-1b1aab1a74cmr270917155d.5.1723635576040;
        Wed, 14 Aug 2024 04:39:36 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca0daasm42167916d6.68.2024.08.14.04.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:39:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 14 Aug 2024 11:39:29 +0000
Subject: [PATCH v7 09/10] media: venus: Refactor
 hfi_buffer_alloc_mode_supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-cocci-flexarray-v7-9-8a1cc09ae6c4@chromium.org>
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

Replace the old style single element array at the end of the struct with
a flex array.

The code does not allocate this structure, so the size change should not
be a problem.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_helper.h:1233:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index 3edefa4edeb9..755aabcd8048 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1264,7 +1264,7 @@ struct hfi_interlace_format_supported {
 struct hfi_buffer_alloc_mode_supported {
 	u32 buffer_type;
 	u32 num_entries;
-	u32 data[1];
+	u32 data[];
 };
 
 struct hfi_mb_error_map {

-- 
2.46.0.76.ge559c4bf1a-goog


