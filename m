Return-Path: <linux-kernel+bounces-191436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9149C8D0F25
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34651C213BB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8D16C69D;
	Mon, 27 May 2024 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dhfcfbng"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7F16B720
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844149; cv=none; b=ApDujj+6AFXDfQz9eiYLSXmAfs6qVaM3GW0JYG9QOvDjdrJAddfznoKZxjMsy77PIp3al0OYHzFy870B0J+/vOM9X+R20R2GarAASBV1C790pVnJI7OEFhxuFKkYyBrOYvAmFNXz115kr04ofltGEJPLban+G8GpVLW1RkRU94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844149; c=relaxed/simple;
	bh=SkYzkaG0dYFUzqixrUpSplhPbKC3wytiTj/w+GTRMzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1ZDyy5x7iW2dbt77kwQg0ZdL2zhSwuwq5t0rrpEv9253n+j8MRcSezJOJgMxkIwenmfiKrATZgki61XOp/xScED7eAppiIPvTBT9ss0aTeHV7IfoEx7iiZkbTKy46Z3kQokN8QDCt5jC7F1/BKdkB67IOBnFesQCmRx3tzPMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dhfcfbng; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d1c077b9baso105076b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716844147; x=1717448947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbbB0QGbRD56aYsaD+Y+ZEPd95SUig7FuxMvDlZcWEM=;
        b=dhfcfbngqy3w7ZU6o0dA7/r0jv2M6iVSPLaa+2fDViiuo2A8b+eeSWEX3hVJMLjnLV
         cCZ7AyecobAJdsIspop+ywAs/NgrJo7xowUm1QJwYpFNEIrRBBqbrnH6OwyPkLpyQfpu
         9vm3+RVjW7n1z1vJmjf2qIxWaVWPwKBNeumgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716844147; x=1717448947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbbB0QGbRD56aYsaD+Y+ZEPd95SUig7FuxMvDlZcWEM=;
        b=fUNW/njJwMm1ulJ8lPVo9QrgzDh0zA/JuKEp4O663QDgby2i48NsoU7b2ABxZ75m/Y
         7Nm+7E+CfPmnZPsFfjf77XCKfWF41FgS8hykXBdHiDva0avb8LcFnSgWD4r7qK5SLffP
         Amo4LWYSQbTiqCLyKYLbAB+HUUBUCm3QIVLzHYunQ1v+Q2ScjdaMwJ1gr/7HymVj5vf2
         d65P7zRMXYOZl2HUz7vvaZUUfyDFCkBlNiNjMf9T9RpoR3luoXxd9p4UfBiSb69zhf5R
         tqXgeEHihLfL4eA2woHRM+Vm2x2Yhw9GpEbaOrWqYRQ1kIOQzKew6Tf297vX3mFgI8Pd
         GQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpn9O6fXuWYaNuwKGeuto7gO3Dj/QUzTJEOS94cLsryQl2wkO0NKvZxhy9hSmMN8YLU64Ls8otBAKJj+FW43N9fWvjuneiW2LC1MYI
X-Gm-Message-State: AOJu0YwFolAkWv4LRzK4nZ52eI2wDsWMu4quXriexxDBoFLvhntnViI2
	tczrWr3V2IP0e2xGXSWLXoR1jXlZoj3H4qTIcsljOjtCq8swekKGxCq3dazM0w==
X-Google-Smtp-Source: AGHT+IEnIyO0WIHMxuiEtYRurphYM/ASsB5F423fmVs+Mw1AhNj6jPPmJvmyuQNG+kiC5cStpK/OGg==
X-Received: by 2002:a54:449a:0:b0:3c9:7a7b:a7cd with SMTP id 5614622812f47-3d1a91908d4mr10056024b6e.51.1716844147133;
        Mon, 27 May 2024 14:09:07 -0700 (PDT)
Received: from denia.c.googlers.com (125.135.86.34.bc.googleusercontent.com. [34.86.135.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad850a6dc7sm9511866d6.93.2024.05.27.14.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 14:09:06 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 27 May 2024 21:09:02 +0000
Subject: [PATCH v3 12/18] media: venus: Refactor struct
 hfi_session_get_property_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-cocci-flexarray-v3-12-cda09c535816@chromium.org>
References: <20240527-cocci-flexarray-v3-0-cda09c535816@chromium.org>
In-Reply-To: <20240527-cocci-flexarray-v3-0-cda09c535816@chromium.org>
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

The struct hfi_session_get_property_pkt is always used to fectch a
single property. Make that explicit in the code and avoid a single
element array at the end of the struct.

This change fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:194:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 4 ++--
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 3418d2dd9371..75f4a3d3e748 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -402,7 +402,7 @@ static int pkt_session_get_property_1x(struct hfi_session_get_property_pkt *pkt,
 	pkt->shdr.hdr.pkt_type = HFI_CMD_SESSION_GET_PROPERTY;
 	pkt->shdr.session_id = hash32_ptr(cookie);
 	pkt->num_properties = 1;
-	pkt->data[0] = ptype;
+	pkt->data = ptype;
 
 	return 0;
 }
@@ -1110,7 +1110,7 @@ pkt_session_get_property_3xx(struct hfi_session_get_property_pkt *pkt,
 
 	switch (ptype) {
 	case HFI_PROPERTY_CONFIG_VDEC_ENTROPY:
-		pkt->data[0] = HFI_PROPERTY_CONFIG_VDEC_ENTROPY;
+		pkt->data = HFI_PROPERTY_CONFIG_VDEC_ENTROPY;
 		break;
 	default:
 		ret = pkt_session_get_property_1x(pkt, cookie, ptype);
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 6dff949c4402..f5708fdfb197 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -191,7 +191,7 @@ struct hfi_session_resume_pkt {
 struct hfi_session_get_property_pkt {
 	struct hfi_session_hdr_pkt shdr;
 	u32 num_properties;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_session_release_buffer_pkt {

-- 
2.45.1.288.g0e0cd299f1-goog


