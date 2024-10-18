Return-Path: <linux-kernel+bounces-372065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B209A43FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FCF1C20F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B253202F9F;
	Fri, 18 Oct 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPlEruck"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5D20371D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269690; cv=none; b=kQFg/yNQpy27oQV+3+ITw85AjM5yq1UQTxvEX/QGPvlPUs2hDHJzNX128eYGrPiolJnJkFj1ujGSuRCuch0IkJSbloOAqFmuLEZSFfjlHAiRRawmqiGMZu4eLiyJYkhCon5q+L1BCMdpv8/+WOrdsDdP84IUAvOc9ZbXQR2YJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269690; c=relaxed/simple;
	bh=slE2uqtFzPyn/ppGD0xcZ7NY0c0d+kFHBGm4TrvMrJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i8fQ0kLoBQ7G9ESxyZWgHMTqfu09tKwZqNFeP9pp3VmAL15Lkxaw5vYv9RScmdMQFa7vVjFlapr7WI8XF0j54rf/otvEcWE5RXI4HO1TzgaYkc6TdtrSE9F1pGfAGk5bPld8MJU2ASQeXb9evd76GbrI993pcJuMc+/amX5C39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPlEruck; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb561f273eso25120431fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729269686; x=1729874486; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fgkgp+Y+TtjrV790qUB8MXr2pVx4CxRwBMGP4K422CE=;
        b=cPlEruckboFpJFN/T/OUt5PoVjn/JPFcgcDvy4kO44FeHvV6lPbub/tZ17IdjIWX0y
         e70d7kCsQBh0nm8GM3qcPqSyG3RlOZpWNAyVqF0FL/4gJNlKRyaxAHukaNrBMKtAcAOp
         KbdYpLKkE6y1JUnJsKHSbsmsX1fMk+4YAVGUxC/NudDiopSd1y9TFnxSNTPYbiFW596e
         04EtorkCNePHWwhDzXjMudAHowRvhqHX4mY5O6bdQMb+4BJLcGjAP81l7cGgG0kBkXm3
         zoLCNZ1iwNMqwH4ToErnuxl1HMGx3oe/g+YaUssjXgkfG+0RKrnDSdCZmRgfOl2t3BEQ
         afgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729269686; x=1729874486;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fgkgp+Y+TtjrV790qUB8MXr2pVx4CxRwBMGP4K422CE=;
        b=D2TPWWac9Mpd7PbsjHXeqlCO8BcmzCn/ZVR8TiREuBmZj2p1Z/eUfud1VF2MpoiVmV
         I8DJ4vZCAMfCUNKlsPmbdKEcRLQwsZmMb6c94RO3XjH02tvvJ/3QXqPQN/hHwuU6KZcy
         Ag9WVSw3jz2U7RH0XM5Hn78kkhdb95enspT40cfc0wyvMnJjI7TInKrcvsOLtMJ3dE4W
         fTtfsRgt8mvDk2WUtFkKbx2ckX/cbObjYz0qQevvr5t/Hx+PTUYYxuVtbSwy115hk24l
         +6Xgb/7VaurwIjJL2xElcb9uaWyaJ16Wldb/ceb8ZKo6PiKoCmay7h8Ix+tNwjcVSfYk
         d9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXuvQ8XiUdNtPnEDJ5JXGDr81Uii71lrQa/rhB4f4FaG2HUBiPZrccvk3H+VvSaYuTqWlTZuySq121QXCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IQaqQUvwShNwnS4PSR82rQQI56N/EabI+dUx0YrsRNFGC2nD
	9nmQSZ9j+ADTYnz96m7JVI+3R0XY5qozVvokGFg8HjSYHsXSP4m9uIx5uGipGIE=
X-Google-Smtp-Source: AGHT+IFFs5iNbJpTNH8ttbNV1wdfH7PRz8uQHbVsYMtlg+K3St/aJPmHNAFBBNjDD03OkpRXSEuHiw==
X-Received: by 2002:a2e:be26:0:b0:2fb:4c5c:3f7d with SMTP id 38308e7fff4ca-2fb82e948ebmr17489121fa.5.1729269686448;
        Fri, 18 Oct 2024 09:41:26 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809b21e2sm2483901fa.32.2024.10.18.09.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:41:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 19:41:23 +0300
Subject: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SAR2130P
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-sar2130p-cpufreq-v1-1-822e00b9a663@linaro.org>
X-B4-Tracking: v=1; b=H4sIALKPEmcC/x3MQQqAIBBA0avErBMci6SuEi0sx5pN2UgRSHdPW
 r7F/xkSCVOCocogdHPiYy/AuoJlc/tKin0xGG1a1GhVcmKw0VEt8QpCp/J2dh2a4HtvoWRRKPD
 zL8fpfT+Dax6kYgAAAA==
X-Change-ID: 20241017-sar2130p-cpufreq-d7ba612fd9d7
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=slE2uqtFzPyn/ppGD0xcZ7NY0c0d+kFHBGm4TrvMrJ4=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEo+z1oNg4lZAW2ySrmFj1Gyz8DlKjVpzL9Krh
 bgNM6PTEvOJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxKPswAKCRAU23LtvoBl
 uFwED/9n11ULaxlEVKCMmbKsncK4bERrRvch4dl8uHeJqQdxzzq0EdEP/1STkXXsKLHV6Xuydg6
 fuUYfTMzdI7OPVKweDFBrKpbyxLyAeT1Fl6oPDnDJvUXSHMTsA1CQOiLgTJLHN5yib7748gKwCM
 XXTS28SmzFQh1yPAHu2W2Tew5f13ozRQ5uKBC7DpUbwbMx5BB1EVvcm1p/Ru7a3O86cdV9FlM/5
 MIx+NLFjOeu3+Mr3YMj0456rhg4FlG0njKk6jxDl4H5A7CW8muUA/plF0a+ZNBe0iPjqog+7zKV
 kQ6a9Hb2GV8f86QWqcs1EnHxXKhBFlgi9U0DjFYKhxCu/SGJrYZkltj54yoLDztVlhsMZKYI5QV
 MqeMmdF0aIObOChkDZuvWANcLHA2JXT0pwQYZeKAxTED93Vrr7v2DaVNwjcXUiURtDsdooFcCTo
 ngLe5mpQq/+7GWJbTAgguIBJ99/rF6Vi9F/Be0iMDfDqjHv4I9J4aTZqf1G85WnR8qxkCvpR+wV
 TIRrhqsp9/91kSvGAoSrg7RxqKdqau4k1IxNUGsh9CPtqpMQGbA0u8LU0rmdk7Fgs/WBBFrB2yd
 +3HqCYYq5IEKvM4hQ+MFj68CZQh/oiUJD+dsnpN0LQzYgpSVePcVj0N6bYtDoFUvv2lF/CbQ/Zg
 0pIotTgdJCd3xkQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for cpufreq hardware on Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 1d1f8637bc03f0322f5e749761171de1ce886968..729f68c1f81d32e54e170879c4f7dd91c0d7c80a 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -36,6 +36,7 @@ properties:
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8255p-cpufreq-epss
               - qcom,sa8775p-cpufreq-epss
+              - qcom,sar2130p-cpufreq-epss
               - qcom,sc7280-cpufreq-epss
               - qcom,sc8280xp-cpufreq-epss
               - qcom,sdx75-cpufreq-epss
@@ -108,6 +109,7 @@ allOf:
           contains:
             enum:
               - qcom,qcm2290-cpufreq-hw
+              - qcom,sar2130p-cpufreq-epss
     then:
       properties:
         reg:

---
base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
change-id: 20241017-sar2130p-cpufreq-d7ba612fd9d7

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


