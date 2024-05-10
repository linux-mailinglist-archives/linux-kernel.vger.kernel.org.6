Return-Path: <linux-kernel+bounces-175737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8518C243F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18801C241AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2692817556F;
	Fri, 10 May 2024 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJlAuFmr"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577016F28B
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342393; cv=none; b=TiT/lujX9Xc7in8yqV+c2HIOww/grc9kuf4uK/uV6mvBMKBsh4t6S8O1qVIjUThlCKn98WvmQcHEZB+U1by5tu6CpWnZuhYR2pupCtB2fGieT5LLv+Eqix941v/HFpehxJMSyScf9yPt1xyAqREZtwBHsbJsYMzYAZS8Wi1Z0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342393; c=relaxed/simple;
	bh=+CdMPbiwbbjdeKsF9NqrWPUhULSbuF01TG2LlGUmcnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MPJ26rL/YTD/Oq9XtJH4VS8vEou1zeWlJF4Q/sh8EkkjpZGxq3GmAQ+pZ/rQ3TF205Lw8aWID8+0QDVMBbPQhFk+qupHnwgSdrhWKnNtDNhJ7odkY/x9Rr8nqaTSqWis8ssQI6RbzP/UdnCuDVBZMRFcBr2hc4kzkB6gWEb72AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zJlAuFmr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a599c55055dso500682366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342390; x=1715947190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNNJNlN4O78cbvwEGVWQ779Rtq56UYusx6zOZKbAlxM=;
        b=zJlAuFmrOBQnSGHQHhZD9SCaKUgcUjbvY27sqZj+m9ypmtoZjywxUAPe3IMi9S/lXl
         hyxd8Jf5wvAjfqMRS1NlZdfzmNADVX5UeDaxaQf3FpWWnlHWfMbaVj5S7/38dphr4Sqx
         bmM/eGb7W4zJJQETDKyceiZANIXPMpSHNrhlPuWZjK07clgatwjTh9vGW4UUBahGVegN
         ejs0YAP/BDubU2sk2QFq8P3yaRobiv/Q6/keDDCTGSo1Zxya+3VVw0pNzu4E2PLHD4Bp
         CgrixSkKkW+ykGx6v2iVnVd/8YW8JwoLBQXoGHO/c5Zsr+PZ04NAGS0bTwt+B/d9uASy
         25hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342390; x=1715947190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNNJNlN4O78cbvwEGVWQ779Rtq56UYusx6zOZKbAlxM=;
        b=cgg1Re5uFCBfaKhpD8lIZRQ2tqjmszTdQBPYhrEZW1U3/Tw2qEdUofKUHMLqukVVF9
         llaQYQ5AzBDPMtU3/DdWTR0J39b7Pa5iry6PEedpwNp7FO8cG5MEYvm37TfHgPU7Zf/A
         i8QxuUFeQaJsnXBE44YDYzYAPbmmLxplNFMlud1EXamRTuqp9NeIAz8nUZgjPSH6qoEI
         0AVErr981Ovn93WUT7s9ru911FQHoKddFxEyG0my2P/mxM7PNvWPD1Efi3eJl9t0Pfzr
         abs+ie446JkQiK98v3jV+kARxCT3wSAYiNbYGlLPgjkkqW9NtYEzE695Ju4VLShrSbT1
         waaw==
X-Forwarded-Encrypted: i=1; AJvYcCUlH3/nrrS60tqMCFob957sy2d/YXqfSdJ1BKEuVHKyCCMHvKu5w5e6UVpAvs9UP0MRLpMWh6Y3a9YxIJeqs1/1gzbdZkploEI18M6F
X-Gm-Message-State: AOJu0YzV4cF4nvTOkL6GaMNnpyoAqXvXN1wd7AHDZfO7ysAeLzcLRjyN
	w/6IDWL19bwHG2GKJsSQdc2tiMl4XO57JMLEwSG3mfm6zM57Ui2V7rERBuoZGss=
X-Google-Smtp-Source: AGHT+IHBeuIuLf/v7qb4NswUzx44DTuej3GIrw6ndeVLe5C0aMjVQKsCUA7aDAjnIPX3C4bwb14Tjg==
X-Received: by 2002:a17:906:f592:b0:a5a:1562:518d with SMTP id a640c23a62f3a-a5a2d53b998mr207336566b.14.1715342390419;
        Fri, 10 May 2024 04:59:50 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:50 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:35 +0200
Subject: [PATCH v2 12/31] arm64: dts: qcom: pmx75: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-12-436ca4218da2@linaro.org>
References: <20240510-topic-msm-polling-cleanup-v2-0-436ca4218da2@linaro.org>
In-Reply-To: <20240510-topic-msm-polling-cleanup-v2-0-436ca4218da2@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

All of the thermal zone suppliers are interrupt-driven, remove the
bogus and unnecessary polling that only wastes CPU time.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmx75.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmx75.dtsi b/arch/arm64/boot/dts/qcom/pmx75.dtsi
index 373e45f63dff..2e61b7849c92 100644
--- a/arch/arm64/boot/dts/qcom/pmx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmx75.dtsi
@@ -10,7 +10,6 @@ / {
 	thermal-zones {
 		pmx75-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pmx75_temp_alarm>;
 

-- 
2.40.1


