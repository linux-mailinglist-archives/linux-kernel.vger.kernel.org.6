Return-Path: <linux-kernel+bounces-171806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5168A8BE8F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081841F21CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCC516EBE5;
	Tue,  7 May 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d2fw3tcx"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14516D9DA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099239; cv=none; b=lQgvOgk0Mi2Gq3fpXK5n6LaaRciOj0j2QtKAEQ8WFeHyqILEvPL2KRaldVxZ+FwXgznoax2xH4QY2i3M3/AjqcVA7Rm55EC4gwKL6I1aqIQ/JjJWUma+Oa8voIvVkwrunZVp4CTscHdZXJVlkxoiUxiZu217biuXgjC7j5OHaaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099239; c=relaxed/simple;
	bh=3FQmdzC7rLah5bHXqxL1pjRWMb/l2vnOq/dIwPsVxiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A02zBcZV6QwJ8Fk3nVCRvKhdf+d72YEypMmsAym7xinq1nUFLlgRCcbvpzlrS07TpwANPRwgyZLVut00772QY1ZBJNyoU0I0klQgIOSx3SQTZ8Ew5yxRSh293mrsP2ckSvNOkiQp4bosOz8lncnHnYz/oABxgui3emyGVfIPkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d2fw3tcx; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c96a298d5aso1550486b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715099237; x=1715704037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKfhOSoHE1VqyRhgB0xYInvnK6a8zz5LZUqmCULZe+M=;
        b=d2fw3tcx8B7ebQuzRheafY/HF13lspqh3qU2RkyjcthAncGKEa7QeIed+ec4X3NLv+
         7MRi9U7Vt1ATwL/dQIezPReprvccyBX5OKfVejS+EvZkeUxmu2MNo64kczGvQNqe8DUg
         G3RX+SjTHmVUCLghqdzIK6J3gbIowcPupJR3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099237; x=1715704037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKfhOSoHE1VqyRhgB0xYInvnK6a8zz5LZUqmCULZe+M=;
        b=mCpeJh8IeiQaTJTwCFxow2jdHzn3cn+So0/N44A5oLkmpt5NFx/BtQAm0sEE07rJKe
         B3+MzCpZ5Y9e+0gO1hfEAE97p5o4oV7PxepqAPIfUH2nwcu5a82gysHShM1lVjCu5cf2
         Ku3+MLWyMlkoFu2q7SYCdqGzSpU20cqL8fQHS6MqiiXOyr4Zi3SGEOy2QHr9NH78+28b
         Jvm+GawZnNEI/mZt8AaAFqaOkAHLGas0emgpSNBbSAfPQvs/u9sN/Mhi3OyiHuNG4l1i
         UjJovPkluYfr3uFAd+Tk7CLccPOudyNHRcvsqMV93nhDMQH7MtM0FhV8frHSOqzMSv9p
         /3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVcN7FRBeWl4EwykLFLZXyZi2R50VZJEPpjsTs3idIw2iDrkkTwn3DxUVv0yIvfe4RCnzd6NnNMi9u/rBwKQLfo4uN6hTPc2M2DvwS4
X-Gm-Message-State: AOJu0YzikxG+sUBN1rEzzx7XndnE8L/zWoT+iX9PBA9bdwfn8F5hFY5p
	YaLlRk1ZJZ8F81gNwJBvim1U9Cy1Hj21t8f6WvWNbOaw61nwydPjUz++26qYaw==
X-Google-Smtp-Source: AGHT+IH1n5rgepkFv+DmmmLViOZnDel/iUrOgLICLSZETgB3GeR4REJxlmdXw7sr6mA1VqvgfFFkzw==
X-Received: by 2002:a05:6808:1990:b0:3c8:665e:1e57 with SMTP id 5614622812f47-3c9852c99fdmr89999b6e.25.1715099236642;
        Tue, 07 May 2024 09:27:16 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id hf23-20020a05622a609700b0043d1fc9b7d9sm4160597qtb.48.2024.05.07.09.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:27:16 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 16:27:13 +0000
Subject: [PATCH v2 08/18] media: siano: Use flex arrays for sms_firmware
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v2-8-7aea262cf065@chromium.org>
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

Replace old style single array member, with flex array.

The struct is allocated, but it seems like there was an over allocation
error:

fw_buf = kmalloc(ALIGN(fw->size + sizeof(struct sms_firmware),
		SMS_ALLOC_ALIGNMENT), GFP_KERNEL | coredev->gfp_buf_flags);

This change fixes this cocci warning:
drivers/media/common/siano/smscoreapi.h:669:6-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/common/siano/smscoreapi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/siano/smscoreapi.h b/drivers/media/common/siano/smscoreapi.h
index bc61bc8b9ea9..82d9f8a64d99 100644
--- a/drivers/media/common/siano/smscoreapi.h
+++ b/drivers/media/common/siano/smscoreapi.h
@@ -666,7 +666,7 @@ struct sms_firmware {
 	u32			check_sum;
 	u32			length;
 	u32			start_address;
-	u8			payload[1];
+	u8			payload[];
 };
 
 /* statistics information returned as response for

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


