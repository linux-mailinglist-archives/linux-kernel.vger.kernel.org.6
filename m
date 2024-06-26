Return-Path: <linux-kernel+bounces-231382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB606919749
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB76B22F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C55192B68;
	Wed, 26 Jun 2024 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WB7LTYKo"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E5E1922C9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429165; cv=none; b=oCNKu9HRt6xUq4/7I9sYuz8+iFi2djDydZvmVofDaMi/k5asL6FL+X4hNdxR62MqOi1bNzFUq+CnjkmRiWB9IAAEVU/9EXb0iP+kWuRX59bKDkJDCFxW0u6Xb35TMGtCFdXKmErXjGZx3ic42WJJfnP6p9CCzAyLjyeN24vIz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429165; c=relaxed/simple;
	bh=Kv1JvM7JT7Hol03PSWbQh3LWWe1hKk6NQDRwutU9nWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1d92H7RdLejQFnp5YuJ/Q01NDNuy1Oa9JAsCX+kR0rti+TeZx7DXmV3eF4d7ZOaMw53zImVF4i71N//KICK/SANahcP3JMsS2xYV6UZ/5aRlogvxprIOTd0igXpQbcaXmGDs2jPlQLwXmkN0P0LdQ56PqRM9wv9ZEmEZpWHZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WB7LTYKo; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so95099771fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719429161; x=1720033961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSKJuXKBkAopBTS+seqTadFlRj007hCjgH7LHZLlyLw=;
        b=WB7LTYKoqfKHeapzK/5YJcQ43rD70xs7esoHC2PDzYIOW6iMSZ1bFVm6ma76qy4Mfw
         HBBzhtcAN7cqXK771qlrUjZyhjhQuOHRG5mmoghJr/ie7X+iW8HDF+rp57IfDb4anY7k
         7DVbmMX6KODR6k9Gr0h3SOopN8wWICYsib3E1JaO7bF7iV+X7pMfIxggIZJkbX3z1UD7
         U7c6ZpRIxWJ3CS2aUSIPQZD58xewEo5p0CO2eDj/cbxCLPr0HuKv6IVw+ETrOyWdC0en
         YMwMMezzzLlmop9dAcmtV65U1NxVLpvJjrWE4jEj6sUslZO/FsiYI398F0QCzXhJ31y7
         FWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719429161; x=1720033961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSKJuXKBkAopBTS+seqTadFlRj007hCjgH7LHZLlyLw=;
        b=Bfa20vZIkKIUVOc4M8IyO1fRBnC3Wztn5+mvD2NHaWxTdJZmmTL4uLaK3kporBQHJU
         f/+g1IH1sjqWJZ39dB6ACaycYety4n6fNU8AD7qzrtqav5TjO6OqBpH/1LnyUHwwWYhs
         LAH3NEKXCkMJL7GA/HVnYjrhW46Xr+b++gO6lt40qKdjbKd1LYiGTPhRws9eds9dcM/o
         WYXb9Y8KJZmTDspxe/VbRxV43s+qPxJNHeNjD2XHpcKBypqPbfgjkFDdsh5O7NhaN6nC
         7Gs1SsyYixofie3AaYgyiWlLDM1DnwSrta6TWBHufPg4em9RsgYfjpxB3Hw5AMwIJTLI
         p9kA==
X-Forwarded-Encrypted: i=1; AJvYcCWY6ttdFM0dRYTd2pGRpxw7Yx1fBO2LN8UkU0o3c4R6T8jwE+jI4GGobpD+BGskjSPKme2MtugC8kcl9qpM87ITQm8Aa25svHba8eFV
X-Gm-Message-State: AOJu0Yw99IUpjxsFeWZHQmoKXFxjUcnjAtW0Wc8RTF+kTSAFDMNrBIWX
	oOrPdv1ocHLEi1O38bulwusWiaTxfwJXPEkkRs+71RucVeE0JODISBqAowFjZZmTx/i9UnugYtJ
	j0+A=
X-Google-Smtp-Source: AGHT+IGFG4sxNqU7DY1MmWTg4jbFwY2LfYMUdwA2VHmpO432N2DCmhqCwOasTEphCyS8gOdCVbOBMA==
X-Received: by 2002:a2e:b058:0:b0:2ec:56b9:2593 with SMTP id 38308e7fff4ca-2ee46479140mr12523021fa.37.1719429161495;
        Wed, 26 Jun 2024 12:12:41 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec5ef9d5fbsm9737091fa.136.2024.06.26.12.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:12:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 26 Jun 2024 22:12:38 +0300
Subject: [PATCH 2/2] remoteproc: qcom: select AUXILIARY_BUS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-qcom-pd-mapper-fix-deps-v1-2-644678dc4663@linaro.org>
References: <20240626-qcom-pd-mapper-fix-deps-v1-0-644678dc4663@linaro.org>
In-Reply-To: <20240626-qcom-pd-mapper-fix-deps-v1-0-644678dc4663@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Chris Lew <quic_clew@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=741;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Kv1JvM7JT7Hol03PSWbQh3LWWe1hKk6NQDRwutU9nWk=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1pNhpr+FN7P7wKdBD/U6U+TF9W/LjnHWPy3iEGlfunfe
 v5DfZKdjMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE8gUBi5OAZjIy1Ps/wz6dj85+m/KjTWy
 Toz9mczBHtnN6S/lzUpuLuz6lF+0rvVoy/Fie13uW5f05ST2BmRbb1iq9jridFSna8zFlsW8bJ+
 sfn7Znrf8e33NfPf8yHlN9rweZ7vSoo293PMcBTvkEn+c+lYpVmn+XHpxoPPOv1/FZr593Tjjje
 8PlxVW7zkDegp4TgkcNDPSeXJKh+9UzvX8sAzLgsf/Za4/zY7U6037Uca5t/q0qEFFsUH/eq4g/
 yqnFru4uriKMzXCBvUlyg+s/zO2f5JlidsdIKArJdJ4/EGBaxlv7Klrq/MP2HVWtvqzPp27SYP5
 g+nV5ze+Hg4xcvx4lqm1Xpi3YI2R7h/FWxI9r69MPAQA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The QCOM_PD_MAPPER implementation made Qualcomm remoteproc drivers use
auxiliary bus for the pd-mapper subdevice. Add necessary dependency.

Reported-by: Mark Brown <broonie@kernel.org>
Fixes: 5b9f51b200dc ("remoteproc: qcom: enable in-kernel PD mapper")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/remoteproc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 48845dc8fa85..dda2ada215b7 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -166,6 +166,7 @@ config QCOM_PIL_INFO
 
 config QCOM_RPROC_COMMON
 	tristate
+	select AUXILIARY_BUS
 
 config QCOM_Q6V5_COMMON
 	tristate

-- 
2.39.2


