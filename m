Return-Path: <linux-kernel+bounces-445202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B2B9F12A2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500B7163940
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857C81F2396;
	Fri, 13 Dec 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvgAJ8+M"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F41F12F7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108324; cv=none; b=ipzTrM4ptbKQVGe00Zjm9+6Dfj+I+KgslWLo56gajUPdB9+PL+Sgx3QSAPBBpDPZp8Juu5p+ZnLkp7GcZyzM5kTuhvnbUaq9RYwTl9ElfumGmpomAYPZSmhJ9wjYchESzyqiMYR3lNvRXJY3sHYq+AuFGl3B4ntTrBNUL2i2COs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108324; c=relaxed/simple;
	bh=uO4wHh5R6umt3vpek5lvClXZRvrRF8v6hmmxWJa+U7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkZRdwDXyqiq9xitoTgg1HA3u/MxZGnI3QhSuqk1edTBZRRB7i9hPvGiaNevF+7iwnV/SCHRfNFPt6hhnF6Ky7yhHJG4qw9ST3AxIzDqfhf/x4tZQ6R2Xb1I216xmuzqtw6wVGUv7mFupMw9jzssdCrNOQtgfacbPl8p7v4eAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tvgAJ8+M; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso4455625e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734108321; x=1734713121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97bdRnaBdJfe74YUb9Rv1xkiswutq43yZJvms06fez0=;
        b=tvgAJ8+MrXmsreVMUcHKrmwkCbdR8JqEiRz7BpX7+7qv4jMBUzdAnORlPcw1aD0+5C
         qNHPMsxwUTXe4dThBsjIK2gMhADrlDpBr9V1Y1m30vMdfcuobeDtPMpz65tLTYEIDzC4
         Ftiazg4m3ASXTdOlni6B0sp7bGi5dvMinzp4dF8094BK2A/mJpgxxnCV+86xoypWTMos
         Zoyx+3Q32excqjiSrog1twxgQzh6Z8BWcDw0TDxKKxr52IK9e8F8glwxKIDk0yjhDnIK
         ZhvdwqSnuSchl0sIVzK6xZRYOC2XXUyqjxArndwRLcTzkHx/RtHeOk6Z8SKtELJD6tEq
         mXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734108321; x=1734713121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97bdRnaBdJfe74YUb9Rv1xkiswutq43yZJvms06fez0=;
        b=pDazH4wxM3wx3+y90TBZlWLOa9Y3MV+xxNk65HDNQsuQUMGcWfUoBXU/2+HKaGLBRn
         bHLRP7F3QP/o2ZzpQHBJQ8jSIVGe1KbzTP2Bi524hs5eFvNevN6B23v6/Kyz0e4mBtCP
         k6JyQDALmd7YOlWRNNQw7QfEAEVMwyhTo4hinGIDZ6WYWSC157aflZ/Y8gsITBv+PA8K
         88/H/eRAfkfxJDSAuYaBIPr2IBXq30GtVq//bMVsWzyVA54JnsTyd8ERKIeZsGxaUzTC
         k+EvUpTKhKZ+JJ9XdrnvgyDiuJCDk+bs0zFExyeU92aSEsIONdMau0Uqt8/p3T4H+MXT
         670w==
X-Forwarded-Encrypted: i=1; AJvYcCVLKJMsLcGdFoIGNRnaemeQUQQdiAyQqDsN1/cW0qiVl9I2LVF8V09BKjkhWmJcYIIWSpnAGj6f5mKaJik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHGhykyHmKWhuYxX6wcyyWi+uSxmhCUgqhoRzurXbttjiLoktB
	uQhtq4Gmr2U80zOE70XEI7nYtwffv/Zhm3JEecaqnOOP0En3oTnISKEEbyQ8R3By5e8Tono0jno
	p
X-Gm-Gg: ASbGncs7W1vML1s2Uca3dfVZjn5serK2P7KocuXC3QOYk962mAoZFnrDI0e24c99U4C
	xbRF6CvZAkE1UzytL1gUR+3cqkBQk2pKARuU9N1oej8p5mdtFBqfVl7Sl/ziJpRmXpDiz9XSjo1
	yxqD2fPcb6HnZsLHURBRcny4Xl+KH266pQIcYp5HrnWysEjxesOqqtljakjV+77qUhqq3O1+Bcc
	kXkSBu87CjvSMhnmuDl7C50iC0a+kyhFMwGg+CIzTVt3bxDl1ayELEHU+OLNIwnTFGkG78Q2TBf
	3Jx7GcR1vg==
X-Google-Smtp-Source: AGHT+IGZWqjtdOdT/tpdS6VIYY/OsEpMo2zR5ORrDSrlvnH3vBH19ZJ4OkOJsfs9LUuPR/6YXntcCA==
X-Received: by 2002:a05:6000:4024:b0:385:e38f:8cc with SMTP id ffacd0b85a97d-3888e0b8718mr2672697f8f.38.1734108321100;
        Fri, 13 Dec 2024 08:45:21 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.66.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625550523sm53900665e9.7.2024.12.13.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 08:45:20 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 13 Dec 2024 16:44:40 +0000
Subject: [PATCH 3/4] arm64: dts: exynos: gs101: add pmu-intr-gen regs to
 the PMU node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-3-c72978f63713@linaro.org>
References: <20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-0-c72978f63713@linaro.org>
In-Reply-To: <20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-0-c72978f63713@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=878;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=uO4wHh5R6umt3vpek5lvClXZRvrRF8v6hmmxWJa+U7s=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnXGSaf/9i9t3N75PN25j2i/ydlMAkKuaeaexK7
 X0Egk2OrE6JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ1xkmgAKCRDO6LjWAjRy
 ukK5D/9ome5x888y6BKVVMDwfE02V/42kZwdnreejxJI4o2iiOpAA5D3FCwK+Q/V/Y3V/91Nf9c
 OiOdQUPD4v9K6WOZrdBDhW64QCkwKTegdIqhstPvsfyZw9XfYKVOEd0Y4aA3BONUbmU1dUeP04p
 52RV1al+IlZmf3YiQSLLo/2HalaZWvRDCuaVlVCTmW15BktT2ufzOlUZzJPpNZgVdv/l0c+0j+n
 WlBYj5camPsEuEwsP9XPIUz1/UMvBiabRwioX0tGYCJQOpQvPs+IKqb0XYmME9FTcHgelXLzhwv
 yzboFdNLxPpf42K/H+cENSmc14/DJt/sB0W2mfQJJHqOsgskZa0hg/v/locl6Mgns/96CIkRB6y
 MrgbqRf0KZgnZQSKCt/cAIHiZX2IHzAb8sCVR85UGVyL1Bx/SrxhqoAO6GGgKt3qeWTbu2T1IUX
 CLhnVBdSJQo8TUcuHouJ0/lA/sfEuSQjSpbNwEThH+CJtDj6Ag9hY5SAomTR9I8qXZfEM75rtrq
 VCas+ueobtMbBPtmzoer1GLD3rM2VaJV44aICHQ01Nq/go3UVF9iSF1JBxoGN6sAXPaaXIrIUdd
 vzLYYzTBbpT1ngkisIkNwYApUPQeqlGndS6669BwRZtorUIloclr5HNJkow01vRLi44BnyezzVW
 0v3RehT7gH+35Pw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

These registers are required for cpu hotplug.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 302c5beb224a..93db14e16246 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1393,7 +1393,9 @@ sysreg_apm: syscon@174204e0 {
 
 		pmu_system_controller: system-controller@17460000 {
 			compatible = "google,gs101-pmu", "syscon";
-			reg = <0x17460000 0x10000>;
+			reg = <0x17460000 0x10000>,
+			      <0x17470000 0x10000>;
+			reg-names = "pmu", "pmu-intr-gen";
 
 			poweroff: syscon-poweroff {
 				compatible = "syscon-poweroff";

-- 
2.47.1.613.gc27f4b7a9f-goog


