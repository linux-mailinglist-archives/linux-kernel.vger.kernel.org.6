Return-Path: <linux-kernel+bounces-427911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BD99E075E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D628285A41
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1C4779D;
	Mon,  2 Dec 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="yRpuJQGm"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2B134AC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154308; cv=none; b=Oxx/hOm/Y1LpuhZ7tDZWQQ6wNz5y+3FswTF02ENaZxFc1n+BVupwxKusePibCmmv6ZWUfdLS6l/B/MsHYbIUUGdDyuwyCiM0yWyt8n7jeo47J3snxnfwV2lb6O09Mq/pNG761kMcKEUbO7GjDptxL2hOkJiPizSokPRXBtBNpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154308; c=relaxed/simple;
	bh=g9aUICujfvbjpqeM4w3JMq2L4/zhb7YLW+mfp8bRqU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UKDMEVz+5uZyc5Ib+rvqGVMGMh/rWdrNNR5rCRQhJ/g/l1o1xWQqt1ggAA6NWjxdtfVnEaKnVMILzgrO5vxtgj8c6FIx1+vXdtg5k2ULGtzZtcP/2woQR72dsYg1RgkFv9Xk1w04v9cg4ngiujBeGwWOrWVRtE7PsWdlFcxPVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=yRpuJQGm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so40942265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1733154304; x=1733759104; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXCuDP180luZ4JePdaAEPqLFzpR2coh76lHb7Z0CuU0=;
        b=yRpuJQGmtPcp/0xj+LTQkGBZ6UtxWROEWBR80euqB8nBcEPVp4ftOh2ElW1Nkq7nhE
         gAUPsTNKLUysXWAOLsFFwJDCvBUlWElLL0KLtWPnsiL3zZgk66MpKWw3lrmWbYwdKzdZ
         O0iQUe1wGUkbglDOeCKGuUUWJ4vYtoPrkI+S67MV7UsYyyFepzMqhnsW6OCBbcuJ4aQ2
         l2I6TR/C7mPi18wvxN7HX/n4L1SreMq3ZJRAdj6ZpUgF+KyeopLtTtVp/8JcDiYXkEKX
         1Ebd8Ennu/olGPWKoA6oo7NSp9+MlQwKGQHqcbYwozdW7vYgBthMylWHs97ArpToVz+9
         IQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154304; x=1733759104;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXCuDP180luZ4JePdaAEPqLFzpR2coh76lHb7Z0CuU0=;
        b=vlJwAtIi/YXIbL6qya6stWSf0qdHG7qmkbARBDxMdXUb4DNFrj7Zp4FTAeKxpoV7K7
         V8Jba4JV2nxheWsLrR/dDH6dFnyu48gUKyQmNirtKW1Y5tZeeDGlcFhOQ4y1AwEU5ji4
         YHqVsmjgdeLfVW4mXz3km1g2wxefWw+yTDCNLnjEKJwHEurv/tlw0+kxsoV6oJU88TCX
         UaVpXSQcV4/qyvwJ5vD7e4GU1JpAc60dkINFJOst42RG7YV3OCMajbfApf6Xw33G14Cu
         mXl5uMv8fG9V69C9QzU409DQwN+X3aP8iNLSlefDzSMjcEGIl5wpg8BNgAME8K37N4+1
         DeXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB0bfXLfEM05mbe8+T6/1iecqyjTV8eFqazq3dUrp8o1D5DXUFIPAxjAhfYGy0xr3PcdDdIndOMvlECa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30wjlPMVwxgV9/JHCxKgPgZdnSab6RzZorCziksu0qdYy9uWI
	TLY0f4NFp1Rfok3BQV/yqJJIdr+LcBeNQm1NfMdrqYjxX2fXBTh3R3OaUFb0unVDezNoxHpEt84
	IFH8=
X-Gm-Gg: ASbGncufboQSTdKxoaa031dFYqLt6IaC6IP5FV7eFfp7RZI0kJhaHffELu1B2sA5FcY
	XorI2ByBaAXsTxh8SmHVbodzOSHamvaLcIlF90Dz9yOUFJjzY8XVQT0sDTJkEarFl2MHssUz+xH
	qkPGgJ8Pw8wkXqZkTUn3a62Dmkgu6+PB8g2BX5Q3ncquSwVEYF+t6GYA1EZ1Qj6a36j3aT1B+Dr
	VXKXZjHNZ2Q5mP2PwV4DlRMaL04V0SKJvWt7bahVsvqJRvoKAPHeHdvWj4AMVXHdBrhtV2rdtJ5
	jRvTAYJ36978YY7EEYmHzkI=
X-Google-Smtp-Source: AGHT+IGgu7NcMFp/eaHdVsUxC15X5VcowG3qWNXAtBMGKtwV64OuR/ITdkzi/tMktSJ0w/eSu83O5Q==
X-Received: by 2002:a05:600c:510c:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-434a9df270fmr189824075e9.20.1733154304558;
        Mon, 02 Dec 2024 07:45:04 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dc63b6sm155711085e9.22.2024.12.02.07.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:45:04 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 02 Dec 2024 16:45:02 +0100
Subject: [PATCH] dt-bindings: power: rpmpd: Fix comment for SM6375
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-rpmpd-sm6375-v1-1-12a4f0182133@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAP3VTWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIKFbVJBbkKJbnGtmbG6qa2BmamGUamhklmKepgTUUlCUmpZZATYuOra
 2FgB4/GQDXgAAAA==
X-Change-ID: 20241202-rpmpd-sm6375-06582e126d7f
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

During an earlier commit, the comment from SM6350 was copied without
modifying. Adjust the comment to reflect the defines.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 include/dt-bindings/power/qcom-rpmpd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index df599bf462207267a412eac8e01634189a696a59..d9b7bac309537cbfd2488e7d4fe21d195c919ef5 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -65,7 +65,7 @@
 #define SM6350_MSS	4
 #define SM6350_MX	5
 
-/* SM6350 Power Domain Indexes */
+/* SM6375 Power Domain Indexes */
 #define SM6375_VDDCX		0
 #define SM6375_VDDCX_AO	1
 #define SM6375_VDDCX_VFL	2

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241202-rpmpd-sm6375-06582e126d7f

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


