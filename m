Return-Path: <linux-kernel+bounces-225382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47273912FF9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686651C23DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612517BB32;
	Fri, 21 Jun 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFrszEXo"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30217B513
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007426; cv=none; b=CZtcfjTvQ3JMUDh+NGmh0qPUKHFr1hOfDVburzPkMNT2k+PkS/dpnc4su9QMZIX8ol13LbMwHx8UCjWqooWgHOrUYADKcuW65SBer2U7z4NnssIkN2CLrt5ZQYZx+c5KQTo2uSvN+z2PeJVcecDN+khb31MKeY5oFpibEZzy/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007426; c=relaxed/simple;
	bh=o+gx8ILXpHmQrY3hS69wj9rdB32kl/S4l9jYP4yB3OM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kx62xklAwPo6+GiUw+2K3gChxIYRJQmolcdLddl5pC8g/pwANYqi9U/zk/IPsmYes6c2z4Hn/+SF7lzEPVDpZ14PLKGx5j5VI2rn9JfiLPe3sf7GZOIsHLh3Oc9u1yqux8C/U29TcuXulJLoThfnDuZPrYXVPTkaQmmu/5rZAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFrszEXo; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bbf73f334so2177336e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719007423; x=1719612223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gszlMdIl+DK+QVxWQsfn7F7rQEWMac70wmjigcpxok=;
        b=iFrszEXofCeM2GipYTU1yyY/hDaSTYUp7R4F/WB1PM5s43EX/P5mIIGd0dQwYHUK64
         LpXDEycWooeo6LhvMSGwfjKSvYNCk+VB5T2lyWoXCA7HC3ao0xJT5kCKAyoKZGnOoAoO
         pJoKv9gjxtaK+M1/uV/pW3FnmqIt0bC0PODE/WyidPF0wKoIwE1jh1plNDf/2RbyfUzC
         jAfiH4zMjARaDrz4KfOC2Ufm8UdQRm8IVU2Yv7veAln+YHLZYqEMbG/f0YwGhou/Mupe
         fpHzPpc1KZRo+Sbtl5qhbPWinGpzXlY1Rjy5BbWBIS31xhQ3D28UZ7bGgPaiMlpoh2LY
         3ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007423; x=1719612223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gszlMdIl+DK+QVxWQsfn7F7rQEWMac70wmjigcpxok=;
        b=VwUZrvzF5M0gcskmGAzqrKZiQwrOP+94qOqgVjx15MJ50YwZ4cbEDuRnnVCKLTvP6L
         7e0nHcMn5nV1Two33eF4Lgamepr1tOqRDJzeRWvzi2wOrYFg1C+GxFX+bSntLiTOhaOi
         qVlgKRlqF26yGBAUlzEqPx0vrk65TiBo0ckL17R/dM2QQ62I48oneKDepMnOOAiPXbTv
         xDR/Ou/AMtJ0kpG3Ao9/esbnXRFmBvYPwjZF7cDi67V4vsnBMNf9NPjq8q0hncTAXcM1
         CyPS6mVjuIiHSpUu3TrStMZheT2nAW2mmU7RBOKEHvpOPM1rI8fz1s5jzcnyZQKX366Y
         0aew==
X-Forwarded-Encrypted: i=1; AJvYcCXWW0KfZfhAblH6MdR5ddwzsTU2KCry5D3Dyij1hjOwEEYiZnNoyI1VL6+ClOrabMLxwOVTgtP5wxmi5dSTsoL8vQSbMJB6WQ8FAODR
X-Gm-Message-State: AOJu0YyAintfn0Avh2IPfClbgQ0k2/ex4ap5BvEl1tcgXrqzrZUijOWn
	BE3zAPGk7dYfSBMRTFPZ1PQQBe/WWBEqo+nrjBcIUPqZh19yfY/4tEqzQFG7ick=
X-Google-Smtp-Source: AGHT+IHvW+3v8z0Yp0ftzL/UluX1GQe8vqRpsAn2LgNmOED+WRMUc4OvvEdIRhxCVI+Y0ZXaI27nQg==
X-Received: by 2002:ac2:58f8:0:b0:52c:da8d:799 with SMTP id 2adb3069b0e04-52cda8d09aamr1211968e87.55.1719007422830;
        Fri, 21 Jun 2024 15:03:42 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd6431fcdsm318293e87.210.2024.06.21.15.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:03:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 22 Jun 2024 01:03:41 +0300
Subject: [PATCH v9 2/5] soc: qcom: pdr: fix parsing of domains lists
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240622-qcom-pd-mapper-v9-2-a84ee3591c8e@linaro.org>
References: <20240622-qcom-pd-mapper-v9-0-a84ee3591c8e@linaro.org>
In-Reply-To: <20240622-qcom-pd-mapper-v9-0-a84ee3591c8e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 Xilin Wu <wuxilin123@gmail.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Steev Klimaszewski <steev@kali.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Chris Lew <quic_clew@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=o+gx8ILXpHmQrY3hS69wj9rdB32kl/S4l9jYP4yB3OM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmdfi8hD94fmJVB26WNxDvQQ7UAWLsrx2iZ1fdV
 8XDVqsVrliJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnX4vAAKCRCLPIo+Aiko
 1WJKCACSwkAc3GmQ9Ix30j5YR6YWZ96IjFdHFsmavMBz4EBPL6rb3pTssgtVjAV6W20d9EHX5fk
 73Ya7lVSIkN+kA2aKTcONBD7W8kOrO7xd9l+0WyKmytmrgyGAiGEuNLiwwXvtCg8LyuTdTuKQzl
 9FmCYAHzpyjRvDrLnq/wJVC3flxscSGnA1YEzSbJr6hJ0FqfAx7cem4EBZ+OLEd1PVdWleZ8bZK
 71TZXZX2U9vxA9wctHlf2/pV7iu0yQ7ziDfZb8i3lcDyzRXjM3fIxce0ejTy09S8/HzMQASex/M
 EP0UYAqyzMY4FaQ5gXPISFTBsDKd/a3m5Y7IcBPUo9SUkqBh
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

While parsing the domains list, start offsets from 0 rather than from
domains_read. The domains_read is equal to the total count of the
domains we have seen, while the domains list in the message starts from
offset 0.

Fixes: fbe639b44a82 ("soc: qcom: Introduce Protection Domain Restart helpers")
Tested-by: Steev Klimaszewski <steev@kali.org>
Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
Reviewed-by: Chris Lew <quic_clew@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/soc/qcom/pdr_interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 76a62c2ecc58..216166e98fae 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -417,7 +417,7 @@ static int pdr_locate_service(struct pdr_handle *pdr, struct pdr_service *pds)
 		if (ret < 0)
 			goto out;
 
-		for (i = domains_read; i < resp->domain_list_len; i++) {
+		for (i = 0; i < resp->domain_list_len; i++) {
 			entry = &resp->domain_list[i];
 
 			if (strnlen(entry->name, sizeof(entry->name)) == sizeof(entry->name))

-- 
2.39.2


