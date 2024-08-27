Return-Path: <linux-kernel+bounces-303611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DE89610F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C37282B73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F02C1C8719;
	Tue, 27 Aug 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EFnWGKfO"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2371C689C;
	Tue, 27 Aug 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771657; cv=none; b=bnsEOOlnAhWuRcumZxkyR2DI70papvda87gaEMly/JcerbvS/h/inr8wevRMmw1ZSeutXpiKEOcgYIDILYE0C9/fgBWZ+LHYXZTXoQijxXhfUFLaFIxNCbCMtnXU0SHTjgVVZFpvT21Y3yW7JpH827fAEMLIlKtLpKQ+RrRHP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771657; c=relaxed/simple;
	bh=95SlD4dn+/5CsHJRj4HNVqOYvAFGvFfl2S0kRyvBYOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U03aTD+kDT7NQO9udv4rRE6i5S6CW3hfW4nh9/sZdc8tV8aEf5cEZE5Xez2+zPTyJSTKya8flizKvLRBjJbdeB+UiYmeZG+q54R6DLlnGM8V6L9MXHF3O6OZ+o1K1/dagEHV2DMBX25GovbF7W1Pmp7WsRCQRjDB7ur+CVt0bb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EFnWGKfO; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 448ED8895E;
	Tue, 27 Aug 2024 17:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724771654;
	bh=DkzZT4L9MeLYi2VtqgyxVPPWOOVKWL4TWD4Qxs6VKcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFnWGKfO3J7kOoBGKrJbZklzIa2KSN63qQi5+XCgqgzzVknUcKMcLREfybC7ECKyO
	 QCvPvwjASKgGYLfC8UIseiYf0A3C0i97mQ/AG7IrKh1T6wvYpJ1wldVUA+JeOoxd08
	 05Pn+k2WQ+2vJNjG9H+hS/LL/1adwa4Ia31NoPjmQhuyBzcC/vHjpgplLsecENbFwv
	 0MAY8tFi39pKzSUYb3dJXH30GMeWgDzdi4fBfFQpYfqgUwGKmTsnqys0v5zwazkPys
	 htLbFvG8e8BRt0AOe/+lefPwi76p3jAVX2+0S4/+5t0wYXARyTDVVJfMvas8rI8oJH
	 NNawgoBkJcNow==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] arm: dts: mxs: Fix dt-schema warning for pinctrl compatible (imx28)
Date: Tue, 27 Aug 2024 17:14:02 +0200
Message-Id: <20240827151402.2255708-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827151402.2255708-1-lukma@denx.de>
References: <20240827151402.2255708-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This change fixes following error:
pinctrl@80018000: compatible: ['fsl,imx28-pinctrl', 'simple-bus'] is too long

as the "simple-bus" is not required.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
index 9655403b7f90..73ca903b8723 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
@@ -160,7 +160,7 @@ ssp3: spi@80016000 {
 			pinctrl: pinctrl@80018000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fsl,imx28-pinctrl", "simple-bus";
+				compatible = "fsl,imx28-pinctrl";
 				reg = <0x80018000 0x2000>;
 
 				gpio0: gpio@0 {
-- 
2.39.2


