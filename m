Return-Path: <linux-kernel+bounces-194822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0688D4286
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401811F24560
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42A417588;
	Thu, 30 May 2024 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tL3KgM8U"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492012E71
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030285; cv=none; b=Nt6LdON00rLGpH96l80vyFWaBRnV6BZng6lIcF7b/pi3kZAkdTiOWet6j26RGirvKoJO4KpOnAD52sYgkSJYK5I2W2de5kxs8XeQ6CIvFitFiR+Z+8BpMUx8Up3kPSnpVMNN6chkIwkTcBVqNf8KXuM0NuCeBra07LbBODKYuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030285; c=relaxed/simple;
	bh=uBjpRROAGGhAYySTps1Z1DH7fMokpKs/t6oNoXzZcRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CY8XEPmnOXR1vZ943GEe4ZfXFWl9a8C3gVXpgNdWNEgrdmuUzKuE5eIRP+ZWyeRyatbR/est4wuedW3Yzb5/yr3P5FY2MTujNJp9csp260uNbM+C+YNXC3rQym2tyggNSby8zxgPUPqlXnJhFOvT1NSnWGHSlB+pFxMrsZtfTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tL3KgM8U; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52962423ed8so387155e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717030281; x=1717635081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5e/r5RMn9m16zlatVHzqiL2Yg0qN4c5NCpFRCLCIA8=;
        b=tL3KgM8UbS1VkkWSxhtwLYp3wE8IhJW7ARg1azLAtT+PEYCPzqKUfUmB+6UOsiZHwi
         zeHSsient+cu0TWRC/DjSUHs8draa+rsj/V8WIEqRKonOouJ/xj/1XIyZy7t+Dg5ZlfH
         Wi9hvbEgPGu4BUGvXOSSFFoaE3kE/k/ws0YDPx1pmqXN8mvkVVjHoX9YoN6FSk+1LGFC
         maB+G4/D/Er+m6w3wDdItSg3SVjtx9Wv1kdRCE5c/q7+V5KWyEBZ7KNjGtPbnL4Jl8Hx
         S4/cr1xPr1qam3nJWMQYKk+dazbg/NGmrB4SAi/x3pMVlU3VLx2o683UlI7PM21eb4GE
         caMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717030281; x=1717635081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5e/r5RMn9m16zlatVHzqiL2Yg0qN4c5NCpFRCLCIA8=;
        b=qe8jjQ8AgKKFGrQ+RTK0v+At4/QV52tRK4woGCaNunnkqDldkR7WvbZpUP5K/9wf6B
         hIB/Lz62BnLVXbZbNFVTRGdC1Ehc92IVgFc0bFWB7Kq3qJLKN8Oydau2tKNM/UBgWlCn
         42cBTcX4F+YpuL0agMCxlGrDuuF/0dSjypkAumz+yn0UruDuYctKL/FhnOiMRj9lkX4/
         rRwaaV4IuFvuZCcKsEUFW0PjVyva9Y9Si0HydW4tErJUhaO4JCvei0A8p1NEs1+uuILm
         gkz0GJk6Vs5GG9RLhmBrZ8bl+tztK81v4ZwVxyToI0ANKPQslF3HaX2i48g/nG0bjnp9
         ZRJA==
X-Forwarded-Encrypted: i=1; AJvYcCUKunAV6G1V2geg2ctBzapviYGXtUVk7dM7GZEomRF6SKzhgG9aY9qU1fbFAKGSCZ00XDLQ+9YIog80PFqbrXxOQg69CmV5gsFQ8Mps
X-Gm-Message-State: AOJu0YyVB27n0t/IjgTKz/5YXXCk/cVv+XjO6tg7k51q+fbIYQSzYJxG
	V3rK2CCjIyj4RQHs/Ulqgs+AiBOwTQKOr3f/IO5lv2NgrkV1kC0DD7ZHDOoauQM=
X-Google-Smtp-Source: AGHT+IFwWnMHVzQWB8b1FZCKBCdwEQSHT+JYvAAE6iaI8jw7Hm6calf+iUbpHFmDBPNDGPDvknHjpA==
X-Received: by 2002:a05:6512:b8c:b0:52a:feb2:72ea with SMTP id 2adb3069b0e04-52b7d47ac74mr543501e87.55.1717030281530;
        Wed, 29 May 2024 17:51:21 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b233sm1396534e87.135.2024.05.29.17.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:51:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 30 May 2024 03:51:13 +0300
Subject: [PATCH 1/2] arm64: defconfig: enable CONFIG_SM_GPUCC_8350
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-8350-config-v1-1-d6e871236ed4@linaro.org>
References: <20240530-8350-config-v1-0-d6e871236ed4@linaro.org>
In-Reply-To: <20240530-8350-config-v1-0-d6e871236ed4@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=722;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=uBjpRROAGGhAYySTps1Z1DH7fMokpKs/t6oNoXzZcRQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmV82HebzneriVMwImdOWiB3mso9XrDBshYsbe1
 in/4fteBTaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlfNhwAKCRCLPIo+Aiko
 1bB0B/4rrgK07tUTadnJoHd63UKKNU0UkaUJvXlsaAmslXY4nzr8PZbV85bTAKjhusEpedFoIeJ
 Pn0pad0Q+eipmJuG6UCEUdriZUxaWFo1+dhCYToVof3yLawXNOb/AtHMVeYTI+drZeMBKG0BL7K
 G5LV6Xs4bc47PtqdMtbOTi0q623J1J7sScBVpHwgVM3sIiAjryslqir6Ksvj5oJiyfv4MzUXkzQ
 OMrilvhLNpra3smBD7NIJgBE74okk7z4AcFlTK+b1Ydh/Ba4YuoCgzPeOX4bE9HJ3ImSDjINw9T
 QIio5nVtaH312Ews1vcqZKEs+EDhC8tP/XK/m0mzd3BE5MD+
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable support for the GPU Clock Controller for the Qualcomm SM8350
platform. This enables the GPU on Qualcomm SM8350 HDK and other devices
using this SoC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dfad1cb8a072..63a8e9335efb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1336,6 +1336,7 @@ CONFIG_SM_GCC_8650=y
 CONFIG_SM_GPUCC_6115=m
 CONFIG_SM_GPUCC_8150=y
 CONFIG_SM_GPUCC_8250=y
+CONFIG_SM_GPUCC_8350=m
 CONFIG_SM_GPUCC_8450=m
 CONFIG_SM_GPUCC_8550=m
 CONFIG_SM_GPUCC_8650=m

-- 
2.39.2


