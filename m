Return-Path: <linux-kernel+bounces-426690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BFA9DF6B7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57262B21AA4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188C1D934C;
	Sun,  1 Dec 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gEDtk9Vn"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2A1D9329
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075250; cv=none; b=OQt2crmJ7+nSSB+JpQk863JjV9LfKt9op+luxKWAwrY+ffxNovjtVMB6PiWrklUc7zjFpn3Hb5RwILvKDUC0LFdk7MU5NK+37UUoCrLtTPOSewnHTtXSgJ4RuXbmPc6/ElY1Du0BaRNPkTXNllNjZVbYip9maFHH2Df6PLJQCS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075250; c=relaxed/simple;
	bh=SAZvMBJQuptH86PltCTHVI2tDobwe7nMav/Upl/Cf2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJI4OOgmiXSQwTPOxl4IWCr11znWnNJ95EGyPP0hWnWdhHV8JmDf/AOsoOjy6jSu6es3ygZHQkybhTf875OVmP+QaZkGvUQg9IbqswN3V8ZrG6CQFGGNxnAmX2+ivp3tff4AV1HyS/eh01w4BlUoP1cCz5gVVk6xlYdxfpR/doI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=gEDtk9Vn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0bdeb0374so2280363a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075245; x=1733680045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdCZTLlLc9wAxF7wv9T8uwvI64qeiIyF1MUa7CbWwfE=;
        b=gEDtk9VnBvuQX6Fb42ZIWmLdDpPgPbVjgzqAnFs8nMsLhkhNfgDGdz6qPdS3GIKVK8
         +Xcu4071JjXATRAZUH3068lyINgoPXOP9i1zza6PW/XcQ+GYmBwWltWu3Mwb3weV5v1x
         a4/SZtFoGmphwicsI08RIMeqiAx1Vvz7RuDoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075245; x=1733680045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdCZTLlLc9wAxF7wv9T8uwvI64qeiIyF1MUa7CbWwfE=;
        b=ZIwtLHeEaoeIiB4kUTAw+8p4fxqM66B6A9qqotnMWh4YEnvOwlYfPy42XVmYiFUKa2
         FnGoAzu5bDb31VHgCSt/jfWXxNa+7J5Ct3XzqWhDt8Ubt4dE3SAAAozYoy19OJYH0vV2
         sRXtjy9gtOLwe/aEgtoDZuxAvWKmyCUPmPbFaDgNUosG1KSELrarFrjw2/lsXbIGBROm
         vv5tskpGowHW3PFIalxS8WBADS0lam7J9i0RsqEKlogT2NGmxizM77sUgd41BVnYCaLa
         cGMbj1NAfj3mJDz7c+veHGz4XKPHlxG+T5jedFOwpfEDzF6O/Aj+RS05aBFT/8ELS4EQ
         Li/g==
X-Gm-Message-State: AOJu0Yz6cpjN3rJtWm9fxhX2VngmEdYsnnkJDG2wf6OghGgkqi0c5sVK
	pAMUgeRUl+TOmJPjT6qxC1AmUEBTYXpG+dg2vJ5/SGuefcPtc8tf+NTXogVhlNCnFqT5LvfYLpm
	Q
X-Gm-Gg: ASbGncvvsqIpYxDgGzEMtjmCV5ZD8amcOHQ7c7XywJocStzXShMvUUfweaQJDiYXMXr
	QTU06n3FtLViTcsJomImQDF9VtMrS0wV7GuRxurtTWea9UrsAIa6BxrsZfLT2cfCpN02qKG7Axi
	/pXYMaN+g9QCL6132fjIHdeEqpRpX52CnHobbVURr6OadPojv11oIwQR08ol9Kexodf1Qc0dtvT
	vJNzWvMOjwsHWnxhO9seNJaazD+Ame0T5oQLQWK6gfMw8rZa4E6j4AX9+NyZFqyRu5jToNu0wJd
	Q6UY3lT3hBvNB8I6/+PBes9F4XvhEtHBlnPBPpdNYaAyVO+pi8E4KFhRbFy7lfhHBlJtthsZPK4
	hF3LpjiYzRdlL55hK
X-Google-Smtp-Source: AGHT+IF3ozv+j8XMyBjfOQVkJHdfyEzrE1dxQCNDxUlGdrVm5RNwVlOhcKaS/di184NLxV0j1TYOVA==
X-Received: by 2002:a17:906:2922:b0:aa5:639d:7cdb with SMTP id a640c23a62f3a-aa580f0ddfcmr1431249666b.22.1733075244684;
        Sun, 01 Dec 2024 09:47:24 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:23 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 04/18] arm64: dts: imx8mm: add anatop clocks
Date: Sun,  1 Dec 2024 18:46:04 +0100
Message-ID: <20241201174639.742000-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
References: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clocks to anatop node.

Add the bindings definitions for the anatop node. The patch is
preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

 - Added in v4

---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 4de3bf22902b..597041a05073 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -600,6 +600,8 @@ anatop: clock-controller@30360000 {
 				compatible = "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
 				#clock-cells = <1>;
+				clocks = <&osc_32k>, <&osc_24m>;
+				clock-names = "osc_32k", "osc_24m";
 			};
 
 			snvs: snvs@30370000 {
-- 
2.43.0


