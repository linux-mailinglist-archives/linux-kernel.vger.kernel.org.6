Return-Path: <linux-kernel+bounces-286361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3C4951A10
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D561F214D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5121B011E;
	Wed, 14 Aug 2024 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="exnUTxQo"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2331AED44
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635570; cv=none; b=kj0wVqA2E9cRMtZhxMqW60IBIkMbOM0W0iv26aQB5L+zXp9p50fPPTNAsIaEPNPVmkeboflJBi2/JpLwP5Ue3ihqRNHKRaMUAAY5EoAXjgLnZipVLYOjjYsXiZNmkBCL51E9l2XaJtNE8BPLRw+WSC5Mh/VFJClVVLUr4ep4sok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635570; c=relaxed/simple;
	bh=R1PA8oQuTM3Rzjg5+SIhm6Kcapuh62793jx02QTgMY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUp/yVwaIrNFg4bqoTsZQB3nXGVZ9EoCwSnPpGUboA/78FCCuaFspLtEG/Bxb9OAFTRSoFUa6WV81kU3zjmDI31v5Sut8+ajTIy1AUfHuHfnHzgP5pzVn22eyBSTveSbxSUryqPIGafwZPuMlrAVL/ATe26vYz2MRy7JaYYrywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=exnUTxQo; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0e76380433so5774936276.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723635568; x=1724240368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+E5Cp8MkPIwpZAw+YrCVKJ1cqUbJ91RXqLOqVZdLQHE=;
        b=exnUTxQoSCW61Q+un2gAVat7J+3yjd/s1cV8lrIYEA6fhQPZBHWqjSrT3c5ZZKp5fE
         D+e5oTd7k6R9ZHkJ6qhZRGJqcySA240XNT+EjT3t9iuoXY8EokVpe8zjIV8MBxhldHYh
         nKbrQD84NYJ/rMl9JpzL4O5p27uHpzm1HwQ18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635568; x=1724240368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+E5Cp8MkPIwpZAw+YrCVKJ1cqUbJ91RXqLOqVZdLQHE=;
        b=a2NGaiIMI4P6LFUywLAZ+lEXtlVlr62kk5pM568DSOicUjYAGBx/YBmrUPSUIpsKS3
         ODDgYSK8W3LkcQK2ZzHtpmKKEWRYcB8YQNoQ0S7NjJ08huAxPeNxRw00qdh8yLdwb1SC
         KrYYilqaABR2s+6ney8Tcg9UhKHYisPp0ojgiXczVmdl/ybrhccNj+iHGL81pF3hRqEU
         tc2rwmpB2/isjtNTkOOELHZbrJrxOhwhXPv7fcBFXFXJniTR9rtc+6F+PY8kt6POMZDk
         oBqd6KuQu/9IM2A7EyBJulJwBjvAGgsFYVM1sOxRvypsBJn0oa5p35YM7T+BuSNO8yS6
         Y6QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqWz+NPyLNINZvQafaDfUrDbOnQg5nbHVpIfQEk4W5BR3mPldLxvktRkG739NT4SiXaPqM99TcYDWL+f43MBeyCzUw6Zox+InaMqmh
X-Gm-Message-State: AOJu0YxGtyb5TcmayEm5vhZMgtCnCZgduciQqSuou4ll0zMWysNAUDi2
	/bvXDP/egd5/S8wYy7KCaQmVu293H0ZtlVsnvgIZD3+TY6QnCi5fkTG3PAwfwUlxUt/uMvfosV1
	fN0pJ
X-Google-Smtp-Source: AGHT+IH4HRHiY7J0a3dkMQnnmztUnfpAtb+vJO43WbTYlwvIuzF4AM3KwSduHBvZYPZPpJXTBCsLgw==
X-Received: by 2002:a05:6902:2387:b0:e0b:56a7:9a6a with SMTP id 3f1490d57ef6-e1155aad833mr2512251276.23.1723635568084;
        Wed, 14 Aug 2024 04:39:28 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca0daasm42167916d6.68.2024.08.14.04.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:39:27 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 14 Aug 2024 11:39:21 +0000
Subject: [PATCH v7 01/10] media: venus: Use flex array for
 hfi_session_release_buffer_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-cocci-flexarray-v7-1-8a1cc09ae6c4@chromium.org>
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

Replace the old style single element array with a flex array. We do not
allocate this structure, so the size change should not be an issue.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:204:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 20acd412ee7b..42825f07939d 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -227,7 +227,7 @@ struct hfi_session_release_buffer_pkt {
 	u32 extradata_size;
 	u32 response_req;
 	u32 num_buffers;
-	u32 buffer_info[1];
+	u32 buffer_info[];
 };
 
 struct hfi_session_release_resources_pkt {

-- 
2.46.0.76.ge559c4bf1a-goog


