Return-Path: <linux-kernel+bounces-204347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8863E8FE784
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162D2285CF9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846AE197A75;
	Thu,  6 Jun 2024 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ntd/dDPP"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A221195F24
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679860; cv=none; b=IMIwOIZ/EQ32mtQ7vcCvu/4USHzam0VArYWkmJSywesPruOYhogCM+2uKY1GJOW8Gpj7EUk7YUyWhz7S432QYY+NEtNBVwApZqI/545Cfst1yN/HmT6x+7Xdrp14iU9Tq71vld4oJZKFRjzS2KSwwYlcp1FLzBstQgIOP2lwSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679860; c=relaxed/simple;
	bh=rr+ZAD9eEY9wxQwSyBHAujNTY1n691T+07WEbe4AI+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1gr8oqRaZRcU1lO6iHx7niMIlVqFxtUuEJ+8QHZFwBHDM/5VGdYeeR7KppMqVLuyznIWy5egfM/IDlqHUPlh2MfCJXSn6zhaNsycOasx4n9BMV7ArWprTd7E9RG5j9kghoWxmyvlHodneMS/hho1um6CUE7kOzeKr8WUUjFX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ntd/dDPP; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6adc63c2ee0so3109406d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717679858; x=1718284658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rV++zhXkLm63xkLNQev5FMXGRPhSAuf2+6p1s7sOLOM=;
        b=ntd/dDPPjOuAXrysYvbBo83QdWpNwlilfdrgAUQYRbdE0RAfoenU+qfyECYt2/kU5r
         4TStcYC0Gs8kNraSTw6Fie4A8jMmytxs6UO4DHIJDDCdQgKIsqfClLQkP6jtmko+q/OV
         A73vOxGemKnuZQYGGsJ8PrIZ3h6uygmC/JDOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679858; x=1718284658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV++zhXkLm63xkLNQev5FMXGRPhSAuf2+6p1s7sOLOM=;
        b=oJ5zmaC1krGPZ0u3+gIKGaFLfxMrT3f9PitWxwPE0svawB4EV0RNcMpXgtLVvnWjFa
         ujg5F/gmRtQ0pe+PIHjCbL+SqMRiNaAIZ5ussA78/vcL98ExZNmOna3EeUmf8La7PDRX
         6VXmFkWzd5XkIwQpXdSCz6TN/l1opY5s69GrZh6l7/jer/mnVCHZ7C6DMUubEPtoTKP9
         6KKCUUQVECcrru7ZxX2d7u6JI4s1ZdD/bSlKbIzA9JtqCQEWpQwkVZyOlyjenXp+6tNn
         dBkaeSmt7WWN0lqtD/+2+OlPi1zotd2ghzS/GJwCNBzwin7ekxPJnc9kMF+LnoWMUwT5
         Vhmw==
X-Forwarded-Encrypted: i=1; AJvYcCWtUUxMBrEUtFM9fcVUkgF0WwtC04JcZdek9qz8kfXyu8fXHSCAtgl9pOcrYlZuXBq2vX49+HCW2BpqTPQlcxT2ybnCY30/ABMKFMH8
X-Gm-Message-State: AOJu0Yyj47fzy3v6rKxZGs1qCRvgSt7T56QLTXHLZiF9LBALrly1rt6E
	TLf491ubZ8rL3N24vkRUu8EAs3+U+YlSag5pm1bQB5oTP211TB+b4XgCUnY53g==
X-Google-Smtp-Source: AGHT+IFEbhMVQzLzMehFBZ5O1a5UQYgBDvAL87jiyZxeXK49H/vAmDrzba4DetgTJ+cq2bB+dcgNzQ==
X-Received: by 2002:a05:6214:3c8e:b0:6af:b8b3:338e with SMTP id 6a1803df08f44-6b04aeb2647mr34544096d6.53.1717679857474;
        Thu, 06 Jun 2024 06:17:37 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6607f5sm6118036d6.31.2024.06.06.06.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:17:37 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Jun 2024 13:16:41 +0000
Subject: [PATCH v4 07/11] media: venus: Refactor
 hfi_session_empty_buffer_uncompressed_plane0_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-cocci-flexarray-v4-7-3379ee5eed28@chromium.org>
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

The single element array data[1] is never used. Replace it whit a
padding field of the same size.

This fixes the following cocci error:
drivers/media/platform/qcom/venus/hfi_cmds.h:163:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

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
2.45.2.505.gda0bf45e8d-goog


