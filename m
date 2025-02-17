Return-Path: <linux-kernel+bounces-518059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 984DAA3893C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678D716979B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617F226182;
	Mon, 17 Feb 2025 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmprIQuS"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659D1531DC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810022; cv=none; b=YJ0GgYOVQvBXJocKlED+/0W5iCsdVL1q+n8xBDdlVC2CKrfdhCPSb+/oFDpaGDzmjgf3GXOAVkFljmnGwfewal0o93eARFlaoOLSv4di/5ww5cLr9thoLigk6FmQcTaJaZ8Rl634oobBlTMKajunJ/WKECNcytbAlGu7lbRXUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810022; c=relaxed/simple;
	bh=MOFMpyIIla6kcWU4sBn71wT1zgg+fBI5dj5FKc/I1/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dG9b5/W4l38NsZ4FuY/TEbUjMF1JxHuNirG3xatZd6KqLCN3poGIqDymbGKU5opOMwwOqFsDrCvleaAfJ+lOw2h2PD0G4zrlA97IzPACsdHY12775KdYUO6aDU9zcZPEL6yFGUTahO14d6nRtwUabqXzta8SwTxZWl8zO6VhU34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YmprIQuS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30918c29da2so35702871fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810019; x=1740414819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEQXbQX6osNEgwYD9EicH6/Mssg7LMg+ZTYyPxgpyYU=;
        b=YmprIQuSfmYQvy62uhUyzBjhwq/x+JeHk4QaB5Mn100FO4uerHBxPfeAWI2ARKJBsC
         strufSV1K+79je/5y3rqrtVaWZKnfrEKKEr4rOMT5H2gFTgpt0vOui+YL71MR5AxZqB+
         hsb30ckb9Kz16rteSm1/go3VXviahRX0SPZov+BVKK9TWfAMXQflVK77wdWchV0/Ud33
         FjSJ4ejl1pcTflH+inoTRq16H0dki+ChOs+nrZIWfYUQOi/a9Lwu4NjBLsXJzZhcLl/5
         55eUepaF9wRhSSJGE3iGIkUehli1vx17caK9UdUVFRSyNRe49gDCbmWmGbPqpuTp+t8s
         9Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810019; x=1740414819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEQXbQX6osNEgwYD9EicH6/Mssg7LMg+ZTYyPxgpyYU=;
        b=pyLeiQgyaX/xxFvaJDS/8RlJRMQoJWwdbyQrdXkbsq+F9sX5bOnJm1R4MX4bUT5Wng
         lrfNtVkxQr72hjkvQGL8du5A4DnF8vCtkQ1+qpvbHuszZDmrpirFGtWLDN66UOTZYMtH
         24H1hZzR/gIlNl/ObmaiqyoDhXbM7Ja90UyINWorb5Q0Q+8NG6MDZdcaiCvAh20xnvAB
         6kcBhFMV06OlALAzxkPpnBNPwPHmJzoGWDZgAM7RelT+7LOZ060MdvXWOEYyOj2gg49X
         5HMukSyRuYo3Q5OtNUW87mIQNSIdchjOaVk6D6aANkaP/iy9LlDjXMKxVMG+Bs1LX+Y2
         EkHg==
X-Forwarded-Encrypted: i=1; AJvYcCXKH83VvP3Ev93mdO7eKG548RtsjFve5WZT5KFKBT3MaE0V/xQhyKxLif4lbE+L4d8uuYnSG3wt+VMvb/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaalXDWYTV/G0XoDyyxkgaPoLAvwvg4Crs4Zd1XLXEWN7ydYPv
	wOp+N9EiHMVXG1N/LlA8guGU+ZttMYSqs3mqNZMQb3mnGWOCW/z5+yW+iGnYEGM=
X-Gm-Gg: ASbGncse/qsCxAjVw0tT1saEcYXfUODEQak6jyo5PSDUD/v4R+3GrHqIgpd0VVXYeGm
	48KTpLNx77/WABc2Io5c304Qbz3Al4btDjYyBSKLxmHKq7L63siCaN/5Wc8WUWcnSdKrbH5+Qzz
	cnkNc91uelJH+9xpY2DfRH4ujVLRgfmxDc5nOMbx846UGBD5N+dVkV68fjXGbvSgJRd/1tNGJBm
	DXQFqzeUVN9/ORF3SQqlvx838UsgHsyYD4guw5qQc7Ku+EbgnPDz1F6NZFZZUoUPqe6MJczK/cd
	x8vj+GSuzHrSHGoMrH/1OBG7ZkY7mFORLzb14e/HYb6/uspsRCLt29m89Dc=
X-Google-Smtp-Source: AGHT+IHjQA/NzRILMMzlk+y3sSbn+JaPpaVa4aNPG3LAUfe/Dz90G0frgA8Ua4KuSchQq/KSOSbRlg==
X-Received: by 2002:a2e:b608:0:b0:309:1ec5:fcbe with SMTP id 38308e7fff4ca-30927a704b4mr30801911fa.22.1739810012362;
        Mon, 17 Feb 2025 08:33:32 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2cef18d1sm5695991fa.76.2025.02.17.08.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:33:31 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 17 Feb 2025 18:33:21 +0200
Subject: [PATCH v5 4/5] nvmem: core: update raw_len if the bit reading is
 required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sar2130p-nvmem-v5-4-2f01049d1eea@linaro.org>
References: <20250217-sar2130p-nvmem-v5-0-2f01049d1eea@linaro.org>
In-Reply-To: <20250217-sar2130p-nvmem-v5-0-2f01049d1eea@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=988;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=MOFMpyIIla6kcWU4sBn71wT1zgg+fBI5dj5FKc/I1/4=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBns2TRvppiN62qcS+vSPo2KVQ6Rpm0nglgR9wyS
 +QRblUbotyJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7Nk0QAKCRAU23LtvoBl
 uAA0EAC8YtN615UyWbdr/bLDmW6iTKU2h7QvjDshKnKd7+6bK7RBt6hLoYMVq6n7dda1CVYZhCN
 0sBuNEMcyecjNQEttanIqLWTNU/TVMf7v961zhayTEckt7ZirFdewsDXsUIrepug/P3QkFdfI/U
 0yavyX4HsW+yazaPWIhwRZvisdGGEGFS0oINdfvT9WjJoqqGFcYhIQKFey+fmbi0z5Q/nSwz0UD
 It52TwaLDKlAnXykCuBodD2X46rrNuks53dpe7K24znmH5L3B8FuUbVCBkDVijXJPyLqPuT6M1u
 mOeslyGCV7UG+/uSyyXJRJ962trYh+7DIy+QSi5cMV0gu6i1lx6b2kZadrpE5z6/mPlfMJksUkV
 1F33D3UlKMkqmqrHskzqPPmHoae/6BSZT8bdQiJZy5DtGpEJne5jeapaALuldIYisD78otwVgac
 qUAHMGoWKBaj8daJ+w/iVRBGUjVQ6/PWiKP8OZeJ4MMKnRV7xglbUWkj4sym+ZJeOV6EG3UvNa4
 77ECpERsXrB7sIQrIXPjrGOXR4I98PRzG9KVpuXB77204/8d9GPB/Ue2obHCBUThEcdb4pTLcj1
 0CvoDrCzVpSrZFBEVBj+zT3yoMWkqMrCC61zF7d3zR0BC98HK/HbF+LlnhHJNbqNIcQJUGU9ytP
 r+e40/zkWLURg4A==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If NVMEM cell uses bit offset or specifies bit truncation, update
raw_len manually (following the cell->bytes update), ensuring that the
NVMEM access is still word-aligned.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ad9b716e8123537fb5fcef724a684e6db3c1de8e..b6f8544fd9662cff0a04e292bb536418564f0368 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -594,9 +594,11 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->nbits = info->nbits;
 	cell->np = info->np;
 
-	if (cell->nbits)
+	if (cell->nbits) {
 		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
 					   BITS_PER_BYTE);
+		cell->raw_len = ALIGN(cell->bytes, nvmem->word_size);
+	}
 
 	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
 		dev_err(&nvmem->dev,

-- 
2.39.5


