Return-Path: <linux-kernel+bounces-557587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEFAA5DB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E243A8C40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8F823F36E;
	Wed, 12 Mar 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="gab5QYhm"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B823E35D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778109; cv=none; b=WfXCU7zKi57tCL/PMV6w/sIWWN0vOnlya0bs4HClaq1jas3AHVI2KnnQBJ1utRATtTM+W1NITfPJK0HA1bZY8SZf+cGASDsaXKFH5m3PzY5eXrpw4VBHpdErqylyTon5BBuSpRJE02Ye7bmoC2jnbJygffjAfroeV6FLiaLpkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778109; c=relaxed/simple;
	bh=hzIkYqCNiMo80kaSTJ9vM3Dwk3kxjnW9SITUVTmj8p8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bEfbbOESG6R85382eSNRPRNApr7qzif0ZimALXniNwsRnIhzxBzaqu1W21neQjP2Q5c1oopEIe55MaxYbf+sxSVBMjTbZ3vYLOSXEtgTEb31HVWGAbpgtGyX16TSA+ygEqMF7Np19p7veWQGBKmfrME8yBA8HNoxmyLi07nQmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=gab5QYhm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab771575040so144054066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1741778105; x=1742382905; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lrye5RapocrcbRYwFATS9q/NOK1mFM++X2eM3TdS8l4=;
        b=gab5QYhmj5E6mXJWr6tomW+oQwDECS3Hvb2RRVP6BuILFrh86W76eM4HuYEmwr/VSk
         M78v3ap6W0ZroEbU2K7mFOYg10oYoSKkc9Jl9ASYa0+9NzGDF6x9F9/Dex/PwyOV/PAD
         BJSnyr+ppkgO466FaFyW481xoeJvE340w69yCNznNbNcsSHq9rSeh3MJxYZ7I2+r5Cl7
         Ixs+miYaXBP03jChomiYu74RBLPy5T/qda34b73OrLQRcYNnV4ikdQeiB6+r4ldZrIKO
         d6iLld4i1L2kQTW3Eh9dXffh4Qe4EZh9JpQxWfQC7cJiGFoC3FF3KM+/mcWfo0ITqqi1
         QK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778105; x=1742382905;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lrye5RapocrcbRYwFATS9q/NOK1mFM++X2eM3TdS8l4=;
        b=mnrXkj0siyVhI01WJRsYVHgygw/c9vtDN507IOei98Hr5uN/ltxI8/rVXkGZ9Sxu7E
         C39md2BWVp3UQ9QlSnosbqasOctz+NhpVQ/Bq1Rn33IDCKh4MVBzxe7TaekRe4CYIgdv
         pHHi8Jczr+DMbw/yjj7kmTItqf0rUTPwqit5DsS65LX46LA6TpnA9htxmmKwoHcrYatM
         CCpmzlRrWTkTVPhjBf9qwscVzFQTwcikphQVBlrW0y68A0PhwA2bZADf6KWavxl5JoIG
         M/YxErAUvwAnn8VcCyYPlbsrgDblYxa3ScdhCgYUe2Q+tiTvxJo/bV9t67HxBFURquiB
         EwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfPq57X1enRRFUTu9yibKgnbk/Vd0FnKq4ouw9ZR4cF2nnSdt/8y260MNlmRwOCF/S9KFGLTxKA5n9MFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbAQJ38SsIFFICOBxmxAuW6AMf506RgiT2umIEqIQYEphHOcqQ
	TW4P/In9rB+/B0st/IDkla2bu1AuWfJQFPkuqBG4DNWoc+01eRcYjgE2pRVPVKQ=
X-Gm-Gg: ASbGncuM2EqS2ksDaWvIpkFCLMQcuhSXSfmB9+4kHHwNkztuIoe/9Abd/ZyMjRjBMAH
	Tis9PJKPZCZGT0Ye2gkNTLoPXrbRUEtQ42K554r/V6VWbYAqzaidXbG2yBsgpApIVeD+GlMS5KQ
	HItHoRy9fJ8NmTvB6dY7wjgcMXhoLiLYqkdSTX2FxGCpqsYoQGkzLwAQiMALRnLOBRRpd5B39z7
	GpMj2gKfe76LAADx6/zG80qSsHw5lI017brPK8vBdWPYIteJnVaGPlWqzgATWuQMRBv779Gp33h
	o9RBHely1/cHd8uBrOKrDeWOkdxJrS6SvCYsStHsVlYhukw2UcPSr1LzLzkQ3lKcF6PFZcTPUpD
	kdtfkF2TYHIyyYQiXvg==
X-Google-Smtp-Source: AGHT+IHnclcokenSW0BD2xU3JDOUI3YTaP87OCmSR72jOip2Alz/yxNoSA2D0hIW7QuWvkEWzMqRrQ==
X-Received: by 2002:a17:907:82a0:b0:ac2:3a1:5a81 with SMTP id a640c23a62f3a-ac2ba53c9a5mr744096066b.26.1741778104396;
        Wed, 12 Mar 2025 04:15:04 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a89f381fsm414129666b.169.2025.03.12.04.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 04:15:04 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 12 Mar 2025 12:14:59 +0100
Subject: [PATCH v2] arm64: dts: qcom: qcm6490-fairphone-fp5: Add
 touchscreen node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-fp5-touchscreen-v2-1-4bed270e0065@fairphone.com>
X-B4-Tracking: v=1; b=H4sIALJs0WcC/2WNOw7CMBAFrxJtjZE/SQRUuQdKYdZrvAV2ZIcIF
 OXumFBSzkhv3gqFMlOBS7NCpoULp1hBHxrAYOOdBLvKoKXupJZG+KkTc3piKJiJokDsz71UpnX
 2BnU1ZfL82ovXsXLgMqf83g8W9bW/llHqr7UooUTrTtI6Q63zOHjLeQop0hHTA8Zt2z6Cr18gs
 gAAAA==
X-Change-ID: 20250203-fp5-touchscreen-cc6960134dab
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jens Reidel <adrian@mainlining.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

Add a node for the GT9897 touchscreen found on this smartphone connected
via SPI.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Use interrupts-extended for irq (Konrad)
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20250311-fp5-touchscreen-v1-1-4d80ad3e4dfc@fairphone.com
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 356cee8aeba90e21c11f46df924ed180bfce3160..0f1c83822f66f95b05d851a5d28b418ff048b09d 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -1069,7 +1069,17 @@ &sdhc_2 {
 &spi13 {
 	status = "okay";
 
-	/* Goodix touchscreen @ 0 */
+	touchscreen@0 {
+		compatible = "goodix,gt9897";
+		reg = <0>;
+		interrupts-extended = <&tlmm 81 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 105 GPIO_ACTIVE_LOW>;
+		avdd-supply = <&vreg_l3c>;
+		vddio-supply = <&vreg_l2c>;
+		spi-max-frequency = <1000000>;
+		touchscreen-size-x = <1224>;
+		touchscreen-size-y = <2700>;
+	};
 };
 
 &tlmm {

---
base-commit: 3910363993da7c2a1d31dc247de59e8ca1cf25fa
change-id: 20250203-fp5-touchscreen-cc6960134dab

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


