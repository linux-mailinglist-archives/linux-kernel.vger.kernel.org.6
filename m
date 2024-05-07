Return-Path: <linux-kernel+bounces-171813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9648BE905
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4E01C23EA8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2A717279E;
	Tue,  7 May 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W00zVTc9"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D316EC0E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099245; cv=none; b=JfJLvB+SRlzzEZXUlkdfdKhEbJ2jncrNUYs7m5NAZrtOJjWP4a8SuEMS/jcVOc3hvsgKszz6aPlpQlWu/5hKEJn8Q/u3vZo6d2Zyw0XXJm0drMOwsUM6GX9ySOn+gvGsw9DKl4HK0efLnZMmjAXplhDyf4+fjr0b36pFtBXrtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099245; c=relaxed/simple;
	bh=NAI8v6owc4vhrxHrnDBAOrLbBtSLWdHrs5V1XLgw6yE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Maek1+H6pLkGICRIVGjihmYU4cB1oprA+E0C5lhYW52FiSOvTG5LQJSkLqqVBa1CSjLglsA3IPJsvQ7w7+JAY7n3FGgVJIPQms77/78mV3btJLq8nvMnpKPIlYQrJxx75134PCtQfz8BJI29NgHXNDLNyXF/ZZCHj9oYwKbFpCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W00zVTc9; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c861a87d6dso2191536b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715099243; x=1715704043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksOWhtvDjU4SOAc5LYb/tmHPugkENGAwplW75xl0q6I=;
        b=W00zVTc9aMERGDSydzmCMFZRwcnm7aUra8kagSRdRTv8THCXr/AiIc7K81+Ciy7IEv
         i21FIFrJDTB1jBhQOJf7uuV0ngZwZ14aTFeeB6Ey7VIaTr1TKvfBwPdJ/vyHIu8Plgko
         Hbv98E4ThhatFk1snKI4i2Dgw+vUS4ICR9ZTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099243; x=1715704043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksOWhtvDjU4SOAc5LYb/tmHPugkENGAwplW75xl0q6I=;
        b=OqkWazJWIh7w67PEpfIiomGrbrVviv/6K+EKKyyW0MOm7oULiXOXZg0qV17qSNKhqe
         7KebSpJrhgbOX+0aRLkTrupbGrLiMSbOMnFuINvmDqOwrQ/9zekwSlWb1Gurm8jYnOG0
         RolELHYLckaBSU3NhWE1+oMPpJ5HDRdLNzOiVN38+gRJFdKVUd58dD8Q3cki99rI7tI2
         GqYMo5xtlrt8AVisBR81wd6TIy2Pa/Xvt3DbEic2CUPmY1uhlMFLPa0OPT7wVd14p/V0
         21QoY0fXM4VnhVNmY7z0uTX8tMTdAgGumHxArtCAeARVLw6NqVhU8T1njjZ8salO3bEa
         st7w==
X-Forwarded-Encrypted: i=1; AJvYcCXghPsvoFVLhtOax13k8tIRj+S1Z+BXIpn3h6zjBaRV2yE+OLq8pw4PpfeiJF61UjlheE3EWOVN2Q8qs/vgbGUnifgVE4UfcTvDiDZP
X-Gm-Message-State: AOJu0YwNwQEG+A8gG9IA9e67Shh5ETNnh/OUZo7Gycgzg9xs5Rmp5ZIe
	v28UuvXc6OwBsS9efTfM3Bn1tskDnvBffRssyAXyWwuJhm0uNS7OEv45Xu373w==
X-Google-Smtp-Source: AGHT+IHvsozzVLWdoiBjQEoTd85TRkr6VfUZ3BRsJ3jAW62XAs6ZO3NhOM6uPqcyccfc0QM2jKHKrQ==
X-Received: by 2002:a05:6870:c392:b0:23f:eea9:ae74 with SMTP id 586e51a60fabf-2409915a7e1mr57362fac.46.1715099242010;
        Tue, 07 May 2024 09:27:22 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id hf23-20020a05622a609700b0043d1fc9b7d9sm4160597qtb.48.2024.05.07.09.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:27:21 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 16:27:20 +0000
Subject: [PATCH v2 15/18] media: venus: Refactor
 hfi_session_empty_buffer_compressed_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v2-15-7aea262cf065@chromium.org>
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

The single element array data[1] is never used. Replace it with a
padding field of the same size.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:146:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 15271b3f2b49..02e9a073d0c1 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -143,7 +143,7 @@ struct hfi_session_empty_buffer_compressed_pkt {
 	u32 input_tag;
 	u32 packet_buffer;
 	u32 extradata_buffer;
-	u32 data[1];
+	u32 padding;
 };
 
 struct hfi_session_empty_buffer_uncompressed_plane0_pkt {

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


