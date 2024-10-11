Return-Path: <linux-kernel+bounces-361359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAA499A72F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB341C21564
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E651946CD;
	Fri, 11 Oct 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSEcO6D7"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD3198A30;
	Fri, 11 Oct 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659166; cv=none; b=nafwldxliZkXA4X7WSxU84UsYLWaqSgkgQZqivMCPWLN4WSWrXaaNe3M60EM5wNwdcNUwpHjhX1UE7ovIfgh9BXlJouwc15BquiwU23D53MFmepQkE8f+a4kUIGgocxktb/FbjSLhjdsrQB9fRp/+k5Sh0XzKCl9PBisE1UPhrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659166; c=relaxed/simple;
	bh=p+Z1nDTHR3VSfxUEsfjfEreyzByYrV8byWoxxGPV0LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UP49imk+HshHZSLDZiG3NR3sqr0Y/gtblcG7gWV4l+qNCjvr4H3uHYgPl/9YrCxcgxh978Q1LnMlY5z2jrfjwC5C/hdm1cnQWnJmpfvqh4i0X3ub+Pfrn9HsYNeLr1555qvQ0sOB2nznZ96ri9X5PoXiitkOOEJqmc923Et8FM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSEcO6D7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a994ecf79e7so343050566b.0;
        Fri, 11 Oct 2024 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728659163; x=1729263963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoqSFxBQ8OghEwfmeYsld4v/qGzAAXjDzimzS+scfuY=;
        b=bSEcO6D7ibawMiNDBvvQasUAdwApHueS/U7JhA5VwCCyvbO4xuM+S9uyyICGGzauEo
         +ZmzEu/THmxT29qU5cob3v5pQdar5OfAPYxiXVYkGhKw4nW3breYOELRAHr89U1T6MDD
         8NZ3swOlOxkh4AqBZtZ1XlGbHugJBYemqquG3EkyqpCnT4bomB3Y0ymfCa18mARG41AR
         un3nDmXUOBtHQ9JWJeyew4jC7TJRJvPDgxS5VXnr8QRpbniUJD5H7Lq2MASqCE8FrMvY
         5hRTD1FN+CACePfHq4uOoJFVx5oprtoppccRBY9jC5Y3s7dU2Ck9SNTA9FfNNHmyxefq
         v9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659163; x=1729263963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoqSFxBQ8OghEwfmeYsld4v/qGzAAXjDzimzS+scfuY=;
        b=p58lI1nLQo4KUGzeCOPKSKYwoeKOuXGv7kb0Zy5t+Bi4ZJa3Tyj5NUsRrQrsq+vfhC
         0BBnSAb6R8tolimVlsF7SLDHvUHNWD2JbVDKeFX9UwDfiugtb7CUONrZILy4ty7Zkaao
         CEzNGuT/Zy7fEETEYQHUuR60zIyyj1Tr83Vbi8mZ54CuJraWuECpigsw4fzGM218RnTr
         l4n1xA98TSD3fnkBdYSeua//5j6CvS84HMz55zEaxuQPvnfBsXcx19Ds4VV6bSJG1ODb
         sF9c/4YZP3n4mS+qeuAFoIoy5rSg3yapTH2Lzp9IUyi6E7G+btwWx+uEN0E7qxm1AtF1
         0nvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVjm/W1A1mBPSfWW5uy3MHXd8LSEiugkxlq+bh/I71Ol1mesuR40jsWxJa64EfEfI+BVSYVfFph14YT8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9BaDDMxYVUDyupd815WlaSCxQwuOksjwQM3OKNYq4syHzTXq
	wmHeb3fYIS9I0DrUjlyFI3Y2FGqND2uR9aApDRWEF6MOZMq9eFxj
X-Google-Smtp-Source: AGHT+IEBK2JXyYwVGn8UlFDP/Iu5LT0dm/NXZvW4eFkGnwV5w9jD8Oxv31hD5Iaue0TJQGy9tV1srA==
X-Received: by 2002:a17:907:f1d3:b0:a99:4058:67d5 with SMTP id a640c23a62f3a-a99b95849cbmr257504166b.34.1728659163222;
        Fri, 11 Oct 2024 08:06:03 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5b0b5sm220879366b.94.2024.10.11.08.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:06:02 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/6] arm64: dts: imx8qm-mek: enable dsp node for rproc usage
Date: Fri, 11 Oct 2024 11:04:39 -0400
Message-Id: <20241011150439.4027-7-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
References: <20241011150439.4027-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Set the status of the dsp node to "okay" and assign and add
its reserved memory regions.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 62203eed6a6c..d51da3b6b3aa 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -92,6 +92,27 @@ vdevbuffer: memory@90400000 {
 			reg = <0 0x90400000 0 0x100000>;
 			no-map;
 		};
+
+		dsp_reserved: memory@92400000 {
+			reg = <0 0x92400000 0 0x1000000>;
+			no-map;
+		};
+
+		dsp_vdev0vring0: memory@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0vring1: memory@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0buffer: memory@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	lvds_backlight0: backlight-lvds0 {
@@ -640,6 +661,12 @@ &sai7 {
 	status = "okay";
 };
 
+&vpu_dsp {
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
2.34.1


