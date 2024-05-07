Return-Path: <linux-kernel+bounces-171802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816458BE8E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3DE2821C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392E16D4ED;
	Tue,  7 May 2024 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XAmU4MYL"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2A16C867
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099235; cv=none; b=uCLDV//AMVi45nTiNU//2tupJVYJlMWCuhr19O/AKB6SXHN8TZRfVLSmvy47rjbtK2HIftDVkNuwX7yftlvE2Pd+jyBdIkePRN9IOXQMs03Esl1FqWclQvpZsoZizIO2M8Dd1UXxgnUITrXMJr+aOeGDdbOSYNxCfxhfTJWooUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099235; c=relaxed/simple;
	bh=OkrWWOrUN5GNEWioxP3gYdPUo0/0BfsqCVC0RCoziIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYsnMtiz/oi15lRYBKvkhGPzHTzdj4B3O6XslC+CLaebBiX0gU2aGsE51VRC8GP4Lhp1KaE7ym/sK3MDkaB6DyaAGSwekT+tkxGEH4ivQ2xMvT+wGv8BhauPqTaPhW7AwC6AD1LYm1XZ9q5RpP4z3jOGYqNmVc+nZDZSlE5UpJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XAmU4MYL; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43d2b4d4d3eso11665851cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715099233; x=1715704033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/P1ujR64RjpeY3CCEbW1xPPMvUuqlT7weCmbLOLgyg=;
        b=XAmU4MYLi02oAxX+z7YpNhFUitd+z+s2/ZOhYAy6yaVetxmgXSpGURekWjjgAUa6jG
         VIm0RbDfmm7P0O5j9sHsPbV++h8J/7OD874thrmLJyGM9oeyexdvAe20zb52YWmfPcCe
         mQeE8LW6y4KVyL9iTrbV68gBhmLkSUAkRijBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099233; x=1715704033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/P1ujR64RjpeY3CCEbW1xPPMvUuqlT7weCmbLOLgyg=;
        b=X1PwMNSP6OO5UIJlfPEpAKohxk+pUZ0FT4gVmvPMNckGJf5jvYh4d/2W8O+GH1gXxm
         KJxupZmDTdu0Pc34y88O7UD1YUmS4IWIyNsgcM5Ya7TwlvEaCiTYa0Q9S1bRT3CW6mn1
         uvu/7dAuV7nQw/XlKZRuQYaS4gPR7GuzgYoqXm79xFyhwpTTMtc6A8brtvrETG0jUWM4
         3ntMijwHpgn6KmaBMCDVx3y0G2uxOj84xMn62shPR07XLYZz6NjWJwtWnTu/snP1/ml+
         UiApW0HVITrD837A1QEVvtYwfqDCo8+2/GZFLJ9WEWGEeE3aDL/bbv2kxBeoHdCSjekF
         ll9g==
X-Forwarded-Encrypted: i=1; AJvYcCUV99bKRlicgFjQ2Lr2gjWTzcHwPSQsqRP9X11nKpSURP8sCuQj2IU53iVhK7EQFtA4uJD8ew2hw4gWhU5twIGcIilhyRcHcD6+SI6g
X-Gm-Message-State: AOJu0YzqjRFkPI0Hfrgqa0bDjyuXznjdo5jm8xULzRgeibQM+yIhXqo4
	DG1KoiP7RZISTJ+Sfpt7nVNwX4WcQCw7jjshW5CUcPYpLDaMCFo1OkRjHaDYjg==
X-Google-Smtp-Source: AGHT+IF13hjL17rg1ksLknz8RID4/qPhKnOZgs0TD68SX8wPAxraoJfg23Be6Og+r0EAzRQ8G/LBRw==
X-Received: by 2002:a05:622a:2994:b0:43c:748f:6e96 with SMTP id d75a77b69052e-43dbf622550mr1868001cf.39.1715099233022;
        Tue, 07 May 2024 09:27:13 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id hf23-20020a05622a609700b0043d1fc9b7d9sm4160597qtb.48.2024.05.07.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:27:12 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 16:27:09 +0000
Subject: [PATCH v2 04/18] media: dvb-frontend/mxl5xx: Use flex array for
 MBIN_SEGMENT_T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v2-4-7aea262cf065@chromium.org>
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

Replace the older style one-element array with a flexible array member.
There does not seem to be any allocation for this struct in the code, so
no more code changes are required.

The following cocci warning is fixed:
drivers/media/dvb-frontends/mxl5xx_defs.h:182:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-frontends/mxl5xx_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/mxl5xx_defs.h b/drivers/media/dvb-frontends/mxl5xx_defs.h
index 3c5d75ed8fea..512ec979f96f 100644
--- a/drivers/media/dvb-frontends/mxl5xx_defs.h
+++ b/drivers/media/dvb-frontends/mxl5xx_defs.h
@@ -179,7 +179,7 @@ struct MBIN_SEGMENT_HEADER_T {
 
 struct MBIN_SEGMENT_T {
 	struct MBIN_SEGMENT_HEADER_T header;
-	u8 data[1];
+	u8 data[];
 };
 
 enum MXL_CMD_TYPE_E { MXL_CMD_WRITE = 0, MXL_CMD_READ };

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


