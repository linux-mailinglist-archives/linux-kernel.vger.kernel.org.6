Return-Path: <linux-kernel+bounces-204343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1A28FE777
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCAD1C23F2B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A77196D81;
	Thu,  6 Jun 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q8dS9Jfh"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246DC195FD9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679855; cv=none; b=d9wIDCYlCgRtMbLbe/0Hf76C5cGmYG0CrCLEGoNIYhnfMgpwTkxcjqd4ilXBwTZ14FI3UDLZ8zlPmoIIrRqeWJbgElCPIOn48fjvdukfraXNWJk/rHaRqQwIa4BZd2+zefCHs3FlCCXQwYhpzIhqvI+pTN+0tB9K9BVwt/CFt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679855; c=relaxed/simple;
	bh=LKep9+SsMgXIw7N/wwAo5L/YSHeXN3o1qd6elsENQvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cvsl39WeOc+YqQenszPPcLhEjLZPA8+Qb3RNKEw+XTvXUO2nk1/1CV1a9q9iKZs5EVm17EAHWC9nPJg/Dy3T7JNIinlNFdDfEC3u/7eBvZCKTOFUUg6kugb3fHR2YB6J9T7qsk9Jq60lNQTYsvCzcP7oJpLdq0Pthml0qnrcfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q8dS9Jfh; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b970e90ab8so506613eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717679852; x=1718284652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZZh27lvax1pQKtebKo1tSyfI2/RfGD2+tRBLkwHpFg=;
        b=Q8dS9JfhUN0JBhPQ2Pc+v0JQqNI9KiQVlEXPQ4YhjjMFO4vefxSidC2dXIJ2fMT41b
         6rUYMQCj/lQSwE5Tmx6gtNRVdD4pkx7Hg5Ex9J8uuMl76DnLrYLyKPulvDvDWrkcFSQ9
         WxbuomJvMde3Xv92dEN+InNMT0gFjt8sqnSd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679852; x=1718284652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZZh27lvax1pQKtebKo1tSyfI2/RfGD2+tRBLkwHpFg=;
        b=UjAAdulxcqof575dxKpYhEeZz1lqh0eYI2iCBEZQEB8XWmBKyvpsjWJii7aAM6Hff9
         nZp42R7VZbk6mBi35zD4wOuG21dAqkCsEuPAd1zPRoD2lyzvk0aVSff1AodBcOSorzkW
         LGxaW+pjQ4h+Yk+wVnwT0mTDlzF1x+RloOZsiuKuhDvM6hal8M98yMO3u1fuPlxvqk6v
         tY01Z1XLg9zuXLHW9VFN7wn/m8Q30xWkrXFYBknS3L8zwK7OBGKRKW9v8bWP0Ns/vJbC
         ryGgShIVAFENNgntTqXTjT1iBX4exGGfNCFK36x1Eh/eLuuRGJkaOUKnvQ3IM72ZF/z6
         U1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb4tiQNszIjaOVbzEf4FmrwEZFIbflVLN99xQonXiwPDZOGwIZTW6G0wAXSATA1Rb31MyLEbMYyn9JVrCVMoXDm74vKNiOT8S4I/r2
X-Gm-Message-State: AOJu0Yw+pkn3JAh/i7flhh+hWqsQZkcTpMiGnAE6YxN/Ehcan38/ZiA6
	hkDiOSbA1gvEiBQrE3LySSae6BlrStcJa60LUl0XXuyPzs7Ct9sM0x/SJMQ5mQ==
X-Google-Smtp-Source: AGHT+IGNI9HGZGYM1bs7kXBQ+Gzd7oXjy4+AygNfoD1Lq7a40uZ9nWHXC95xkS7mtZToVDJBYIlggA==
X-Received: by 2002:a05:6358:9985:b0:19e:e402:4d17 with SMTP id e5c5f4694b2df-19ee4025007mr233623255d.7.1717679852165;
        Thu, 06 Jun 2024 06:17:32 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6607f5sm6118036d6.31.2024.06.06.06.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:17:31 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Jun 2024 13:16:37 +0000
Subject: [PATCH v4 03/11] media: venus: Use flex array for
 hfi_session_release_buffer_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-cocci-flexarray-v4-3-3379ee5eed28@chromium.org>
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

Replace the old style single element array with a flex array. We do not
allocate this structure, so the size change should not be an issue.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:204:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 41f765eac4d9..6dff949c4402 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -201,7 +201,7 @@ struct hfi_session_release_buffer_pkt {
 	u32 extradata_size;
 	u32 response_req;
 	u32 num_buffers;
-	u32 buffer_info[1];
+	u32 buffer_info[];
 };
 
 struct hfi_session_release_resources_pkt {

-- 
2.45.2.505.gda0bf45e8d-goog


