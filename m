Return-Path: <linux-kernel+bounces-433073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FD29E53A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD0D1882CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA7206F2E;
	Thu,  5 Dec 2024 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fcS0Y0BI"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AB2066EB
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397596; cv=none; b=n18ZN8DJ7MTYvMbAl4pTc80IvBhsI6idzo9QRmoeNL4ZUj8iBkJDxjeo4/t/7k1FFgS0Eb5INouwy47QHxTrZK432lV5EXDfydwU1lcfAA94czVeuti5A3DIPFjfEt2+djSPgSnJ5NTXFcV+zZzsfa7aVLXDaf6PKcyEnZQ1lQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397596; c=relaxed/simple;
	bh=MWwhsP/1Gq2jtC+XMH/+PSmlpfJmY2R2gm9uwDR4fZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QivakS+zOkEihYpErS6rP74K8fMl10Nq6AK42xAsHGfhbOabmUd2qqPIGfrKu+VnIQ7jFH4Doj34fKkpct+qvPnVR8ToHV4mfuNlWcDk/W09qBXL6IOucgEiBz1PegLjx3mqsu8WB/xGWbOVlGddtATcXCpLko4pP/yi2OyZNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=fcS0Y0BI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d2726c0d45so581288a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397593; x=1734002393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mr8rvSiMKhhr7+g2wBjSbr4ZapMlTY5YRIRH4XPzpek=;
        b=fcS0Y0BIKqUNr9t0AAp4GaldTaG7FXiRH9FCj4RDNobarcJMnJD9KpzGlJQ+KTjnVC
         6Rd4CeKOzavUtnd9ueNtPjISc9nbA0h4Hfkv1WdvcafX0OvsxjUj/RHGBKrN3UmHE3FR
         E9XSRYobWN31ZX+CE3mzADuoK2XbDoGDZYOk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397593; x=1734002393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mr8rvSiMKhhr7+g2wBjSbr4ZapMlTY5YRIRH4XPzpek=;
        b=orY1IKmE0z8Q/pleq8O7TeHzKOWfCG6yL+VlDApSXN1YjdIEg9NuD2VY8I289rV1Bp
         2NrSoPdp/zoQNShXFxrjg2MyvZ8WkTWP8WCWGXf/H9GpYpX3lOQ9tjkc+sj1OOJ/uMn0
         WOM/IGDSH980U4rCd841Tmxfz3vcZ0P4SMGsLWmDKksg867wmhnkWPRxqQf2xDgNO3g6
         26BpIO4x3DksFeeaj7p8Z726zIWtwUNaY0ApyhqXh6FdjgDZpb54dpNJ8YLW2pw1DIjz
         7mn6gNm82QVJCX/aIAhiIcEQYjJAGJ7vick7hE9tOGRhwz8uTfbG+jiEhm0BuPIreTQL
         CKCw==
X-Gm-Message-State: AOJu0YyGdW1sZQBEKrFpoyjSfVr3LtZ5HsLhLcNjctZl7pxZ7NEHCRPt
	jPkvB1b3hQd/RRXCpa3bAV8IXBT+G7dc6OpRHpdQ9Rft9Ry11/f1z5hngxtneCedrrz6tKWejSb
	C
X-Gm-Gg: ASbGncs+YX0iXhRZj7ozpNJuxOGYaHoN0d66DpTBsbOpgUcP28TxzQNfoJIpwbwBj9h
	NeJmYCxgAXyV8ubHMhQ66YDGDOPYYk9Q/owFnyEaPslaXb06Ndvsvp3oZ1gItAtANyQxTMpsI5/
	zk33Ode89TpfgwmgZZtf/ee8rdNGV0zVG+OxUR+jZqQqR3sCz5djMCY6j6FDonp2RGpiE15xJrO
	5z4wVZ2K0mGL1blVYE2md2ciCQhQIa7BpueITgvlvF87me6i99U2+shW3ERbtXMXHIiFuBKWWSF
	icrhfU54ANanBambPu7un1/fr8DcUU6x85FQriSY3GS7/g==
X-Google-Smtp-Source: AGHT+IFlIqOIxRQlaaVKv62iWGPtDqL1DgvwbVPP6DdzsmH7KN4sRitNwb9/Z7vHbZdE5W91O5vUFQ==
X-Received: by 2002:a17:906:9c1:b0:aa6:302b:21e4 with SMTP id a640c23a62f3a-aa6302b2e97mr32793966b.16.1733397593185;
        Thu, 05 Dec 2024 03:19:53 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:19:52 -0800 (PST)
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
Subject: [PATCH v5 07/20] arm64: dts: imx8mn: add anatop clocks
Date: Thu,  5 Dec 2024 12:17:42 +0100
Message-ID: <20241205111939.1796244-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clocks to anatop node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- New

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a5f9cfb46e5d..49be492b5687 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -606,6 +606,8 @@ anatop: clock-controller@30360000 {
 				compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
 				#clock-cells = <1>;
+				clocks = <&osc_32k>, <&osc_24m>;
+				clock-names = "osc_32k", "osc_24m";
 			};
 
 			snvs: snvs@30370000 {
-- 
2.43.0


