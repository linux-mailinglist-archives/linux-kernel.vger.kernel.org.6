Return-Path: <linux-kernel+bounces-322480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4CE97296D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D061C23CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291D17622D;
	Tue, 10 Sep 2024 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FLXHgQnQ"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B716F27E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949261; cv=none; b=VXOrmi/9tkZvVMXsDaL8LK6AEAH5b6CBoD10w2B4mTtr90WA9NUMJr2s6kbvm065kPL6fX+UkI3cjKqgkLS9NBgT0ZU4yA3SW38DrWdmA2J45WPEOlgZxhC98kvYMcZ9hAMD1cKIWaPlFoY7UjtgYFdKsdkdJ+sGXoasAA/ZKlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949261; c=relaxed/simple;
	bh=hFD+h+g3Qn5O1IluP2Jlz3i4TTvagOIPayb1NIcvVfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IMEe0RnAXLVo61LkX7Q4hW+MQNAmKOE3p56kQpVHa/6mPxHSO/XVox0BdDoOQoiiUIIX59A+qVGqevgAKM5S9Ccx7fSta/+k6g4UwIyftt4b+rH7CMWdZx2gyuL6hvir46BMuYux/TLc5/89Jlp30hehMa7BAwXADWXqLa6Db3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FLXHgQnQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3311423a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 23:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725949259; x=1726554059; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NAqLSzfiTKu9/ujNb6PjoEVWXdaDlFqYoM8Sol5284=;
        b=FLXHgQnQ2uxLU6zrU32LP9vKQLwytBFZKxW2UDpnnngF6lU0qDdTtdHQQiHdMl1ps2
         aystXOe3pu88NpMqpIH0+U0QUiK+Cw6Kq5oT+N6MK8xg4MSy4KpBJroK4+2QL6tQ7ESI
         MpNVQKC8ceM0oxPMnG5ronvYj/tox4rU3P5OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725949259; x=1726554059;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NAqLSzfiTKu9/ujNb6PjoEVWXdaDlFqYoM8Sol5284=;
        b=KWrTjUHSgUhhXZWQhL+b2GuZBF61GeMgQPwFVItNB9Tp78WsdJ2UJtNg/mGWElJaGa
         dq/FLmylPY7jM26aCyQY/OoZl3xYuhJYQ03ClOoP8MmUjJn3aRVz1fpihq7Z/LoWsO2v
         vHqFuX8oQO9waq5Ket2ynKYpGZMFPaDW9mkzdc22wquFRae1eI0F9u3Vx7LYFQKCX28E
         lf0kZuQ02C75VYvpIWIBXCXvTEsny+g8VOrt2gaImoTOBSknwH9Ry1Gsqtj5pWZYmPJO
         Xun4iQyAhvLcnyNHBb6DMkMV6ROFGaf3IrSE+DfzeJXJRpKzeADKjy0KbV9nNZoXToUI
         Wudg==
X-Forwarded-Encrypted: i=1; AJvYcCVl96azg708ttK7m1Ve0KmtzuhxYJFAe3aLWQVBiV4mCMdC4arpwRP5gW3rDGNkZyuHsF9kc94Ic63X3GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAw5iRLc/RoniH8zkpMjZp/eE0lbE0O928UoN3QaW7BjqJnz66
	aJtaoNYR1ADxgFSM/yq4SJL66hLdB6vLzhane7/jpSqa+lSXoM/ONeszgm+0IA==
X-Google-Smtp-Source: AGHT+IEbJWi/XiTXkjvEqBmFZgc8Mp05CZ7p6lurFZhANudU33VAWtc+4cYuapG1rcW6R1YeF9lrEg==
X-Received: by 2002:a05:6a20:6f08:b0:1c4:9ef6:499b with SMTP id adf61e73a8af0-1cf1d13337amr13713739637.29.1725949259296;
        Mon, 09 Sep 2024 23:20:59 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (30.191.80.34.bc.googleusercontent.com. [34.80.191.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090b0397sm675188b3a.154.2024.09.09.23.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 23:20:58 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Tue, 10 Sep 2024 06:20:55 +0000
Subject: [PATCH] arm64: dts: mt8183: Add encoder node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-venc-v1-1-d17dfd931dc8@chromium.org>
X-B4-Tracking: v=1; b=H4sIAEbl32YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNL3bLUvGRdE3MD02TztLQ00xQzJaDSgqLUtMwKsDHRsbW1AAWLZWl
 WAAAA
X-Change-ID: 20240909-venc-4705c7fff5d6
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

Add encoder node.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
According to
https://lore.kernel.org/all/184d895c-239e-3f23-970e-6a9563235cd9@gmail.com/,
the encoder node of MT8183 should be added only after its dependency has
been accepted. Add the encoder node in this patch.
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index fbf145639b8c90b2c69da1cb4bac4f61ca7a1c9e..d24c89e4e13b0c74f549e638e97e0729052909a7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1965,6 +1965,24 @@ larb4: larb@17010000 {
 			power-domains = <&spm MT8183_POWER_DOMAIN_VENC>;
 		};
 
+		vcodec_enc: vcodec@17020000 {
+			compatible = "mediatek,mt8183-vcodec-enc";
+			reg = <0 0x17020000 0 0x1000>,
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larb = <&larb4>;
+			iommus = <&iommu M4U_PORT_VENC_REC>,
+				 <&iommu M4U_PORT_VENC_BSDMA>,
+				 <&iommu M4U_PORT_VENC_RD_COMV>,
+				 <&iommu M4U_PORT_VENC_CUR_LUMA>,
+				 <&iommu M4U_PORT_VENC_CUR_CHROMA>,
+				 <&iommu M4U_PORT_VENC_REF_LUMA>,
+				 <&iommu M4U_PORT_VENC_REF_CHROMA>;
+			mediatek,scp = <&scp>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_VENC>;
+			clocks = <&vencsys CLK_VENC_VENC>;
+			clock-names = "MT_CG_VENC";
+		};
+
 		venc_jpg: jpeg-encoder@17030000 {
 			compatible = "mediatek,mt8183-jpgenc", "mediatek,mtk-jpgenc";
 			reg = <0 0x17030000 0 0x1000>;

---
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240909-venc-4705c7fff5d6

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


