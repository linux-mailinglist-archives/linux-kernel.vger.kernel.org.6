Return-Path: <linux-kernel+bounces-171394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9B8BE3C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFED02891E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B7516D32E;
	Tue,  7 May 2024 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bv7ZuYR1"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E020416C696
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087917; cv=none; b=R5v6PNSKwv1kdT2jK2tSPDC8HzMBHxmVjpIdXKG5086XBeCrhUL7U3caBNUXiWQCpGDWSiFaqgjRlin7eTwLAT0YpJvpRMhGsA42n4XoIKzgShzpWRAtmzUVoT0oDXeg8DSVbZfxtLCG5FRqdSwplH42JgEu4WLNqBV3lz5MZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087917; c=relaxed/simple;
	bh=OkrWWOrUN5GNEWioxP3gYdPUo0/0BfsqCVC0RCoziIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EXPRKvYbkp6WIlDrA0gF9wPNe0vuAdSfNbpqS8sCSo2AKE60Uz96x7yyv47l4YvMIl3CsFxLJNcyOgjWaqvSznxI1ighwl4wNOlmzx0trIZAW0Me7RhhoGaf4ng8eyTtxjmEqdkvfYAFNoN6AOAchJKD0pAj86nLw2BA7ROesUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bv7ZuYR1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b514d3cf4so42886196d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715087914; x=1715692714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/P1ujR64RjpeY3CCEbW1xPPMvUuqlT7weCmbLOLgyg=;
        b=bv7ZuYR1JSua4HN2zGrac6dR80LTnt3qfwi0LYYW10A4oCkGiy/9dj0lr5csx0dB6D
         pvlzvvBoE+0oi9e+NvhdD9hOkpm6ee2zH/O2Z6mYkRvD0/IXdVRgYf/BMt2TPxpheY4M
         pTXKYP+wd8A6lTiRyokt7qJNrZpmL3F7X+B1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087914; x=1715692714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/P1ujR64RjpeY3CCEbW1xPPMvUuqlT7weCmbLOLgyg=;
        b=CVxaFyrJtxgy54UOhyRFQXQw/F+UsW4P4G3sGQp9yvPkHs0XYJUMm/hxJ+QNgKwzNt
         IpchyzP2U8SIotOLXloxTiCCsImFepcAIkeJDhvsD7SjaPvVEbfVye7rF2GdcY5Vmwde
         miZkQ49M984Csb+4z8yHt+bkVoeBg4S/aOyCyirKPUsWYsiK5JF7kRl8kV4qg50Hw5tJ
         1bJscr+xAQ5vslmfo52bnoHmocxP8ohEgZqThP8DKp05nUJmHcM114PfIxZBsp0VAZeX
         9mfJep6knUxSPlUwG8MUTyUvk97XRrJTgSjQAvWABP+SIOLR4fJRYPPmaY6D2jPDARSE
         NsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmfK4NGJCkmEhWEpSpVm5xHB0xJ9injPRlghH0CPTasSb/T4I5XG4meab3zeWf5TNC5FoTinckBp7umdr2/GheRVoUiLUQ1NRNMZpM
X-Gm-Message-State: AOJu0YyQ0VUJoKGPuY7XYLPp4pgt8mrR13tpPhh92bJ2bTPQv5wfLzcv
	syoQnidKFZlzfTmz4sCod4U/EGjc2hbTLVWOwXp+yikWn7yULO6kDi2g7v/hGQ==
X-Google-Smtp-Source: AGHT+IEHmgR44JJkt0kGIzW7NOaECWfdPMcTxHBijYkMDjUQ//6R0gtSxgRSvy3DiBlPMd5HBstr/Q==
X-Received: by 2002:ad4:576b:0:b0:6a0:6545:2306 with SMTP id r11-20020ad4576b000000b006a065452306mr15355570qvx.28.1715087913906;
        Tue, 07 May 2024 06:18:33 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id t15-20020a05621405cf00b006a0d19c3139sm4655105qvz.118.2024.05.07.06.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:18:33 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 13:18:30 +0000
Subject: [PATCH 04/18] media: dvb-frontend/mxl5xx: Use flex array for
 MBIN_SEGMENT_T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v1-4-4a421c21fd06@chromium.org>
References: <20240507-cocci-flexarray-v1-0-4a421c21fd06@chromium.org>
In-Reply-To: <20240507-cocci-flexarray-v1-0-4a421c21fd06@chromium.org>
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


