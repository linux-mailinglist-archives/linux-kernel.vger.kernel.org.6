Return-Path: <linux-kernel+bounces-244634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BAC92A72E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD23E1F21E60
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FC146A63;
	Mon,  8 Jul 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uspd2PDQ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A61EEE3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455748; cv=none; b=PPGcm3uOxIG6gRSD2gURvrEXnD9XSE+59csUBI5dc7wyPZnXY9oscgn2dDYq7C0c0QH2TKFYHVaeuHKjIUUkxcV7wjfBhqPyxhMOFBuM+3zf1Sn+YTh97+dDAsnIdMjngDfS1OipLaVK4SkVDtze2GvNUJWBbf+dtp7CHR+dnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455748; c=relaxed/simple;
	bh=6TJHDA3SIllyH+U2xBuj/WZtoP9qYDg5QH6CQbuSeWk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o2p8XD6VnRYTESR4tU88huwvOo+cKhJ2Ar7kYoCq5W7VHp3Xq6+RBzlufoKHH5FTsya9ka/M1Liwg1cL4jVQAU/KuRk+RdyEZxpqnQDN02oYcTowbXUvneB/352D1BUefL18Fgk8E9g7GsDlC8+woNTLJgRIZ21Scrs/RoiDwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uspd2PDQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4266bb98b4aso7802935e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720455745; x=1721060545; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1FxBG1EvKBwY+c5hmtTh7jVqnApc5CzlyUJlhLYsWs=;
        b=uspd2PDQXY7fv3loRXo+mVPAB9nlsQLiAkoeM2aZy2enHmChHxK05I0j0AHuiOjFcx
         Zo0U2Si/oyUYZJ8tnZkEIofWPfg4pPsmQUB1xQRoWRjPYS3SJLkC0XsIf0f1fvbWClEn
         RkX28K0XCSVAhamd/I3xfZYmiIv2snttJYlvMxU7IPzbP0clc4J/VMXeUhEM6qKdlNJy
         J+5hRScShdOuTwihoPXEGHse1CVQbobE9Mg6Jn5SsfX0yBMBPsqZZWck5pGWTX2thdpe
         iDslJ73obCWRKj6BRBsOziy9XT9nxt0OTRF/0K1pU4F/eq/YduwPm+FG6goNq77z9AZo
         4jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455745; x=1721060545;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1FxBG1EvKBwY+c5hmtTh7jVqnApc5CzlyUJlhLYsWs=;
        b=AV3EGjIoPm/8yUA7JLndRFEE5HGFUHmUqY7CyVNz6myldiqOuNNdRJZ5e3fewrObvC
         DPd+aBpGZVr0c3ub3U/XDUKTAGsSf2qtR7fIdJcFjWS/EvjT+mZR4kT/6Ai15MW7IHzj
         gDOu7ShIv6XUZ3K6fjf9h7coWXoW1XhrFz8LttBsXV8CPSbH7kGNBIpBH++fyEjr6s8I
         7ZUCcMKctDy1fLQPHPg9CQZUASScD9DBKvm0SpmvR31xIjq4iXuy7S4RjRTCkLs04fag
         v3SX5I2o9z7tshEsxMF4EggIMGUkhURpqRm91ypK3kZydCp7TvobRmj1XCHEK0kwXbeP
         Z0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0C/PhdyvPaj6EEC0a8AWxxWOaSxhDSN8+NVolpgwpWcMH67CGpGG25IrXLKC9SVG8jU22UHdsFpEDBHBzLVM7qNBJA/WwXZcOnEAp
X-Gm-Message-State: AOJu0Yw4V8bMi3JMOriSgxh8TplGwgY5vb66yMHz88K40a8SN75IE1Cy
	xDgAoAGajPjz/Wj7CYq/TnuSYNfZcizBU9DlQaznt8UkwX2lan07tY8ku5zctRc=
X-Google-Smtp-Source: AGHT+IEZZuQE5zM8pKkwTk6FpH9huXGia3asCPL6PECgs74RyjegcnWdg49kpQ2C6aW3CsglyV0n7w==
X-Received: by 2002:a05:600c:2206:b0:426:6822:5aa8 with SMTP id 5b1f17b1804b1-426707da4eemr830815e9.18.1720455745123;
        Mon, 08 Jul 2024 09:22:25 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:d237:f5ca:52b6:108c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e0b6bsm4466875e9.3.2024.07.08.09.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:22:24 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 0/2] soc: qcom: pd_mapper: Add X1E80100 and older platforms
Date: Mon, 08 Jul 2024 18:22:08 +0200
Message-Id: <20240708-x1e80100-pd-mapper-v1-0-854386af4cf5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADASjGYC/x3MMQqAMAxA0atIZgNpFQxeRRxqGzWDtbQggnh3i
 +Mb/n+gSFYpMDYPZLm06BkrTNuA313cBDVUgyXb00CMtxEmQ4Qp4OFSkozWdcYyy8LeQQ1TllX
 vfzrN7/sBAPQdn2QAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.13.0

Add X1E80100 to the in-kernel pd-mapper to avoid having to run the
userspace daemon for charging and audio functionality. Also add entries for
some missing older platforms without protection domains.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (2):
      soc: qcom: pd_mapper: Add X1E80100
      soc: qcom: pd_mapper: Add more older platforms without domains

 drivers/soc/qcom/qcom_pd_mapper.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
---
base-commit: e01314c6936b0ab08d4c661e2f68852bfe1003f8
change-id: 20240708-x1e80100-pd-mapper-2a31288eb8ca

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


