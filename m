Return-Path: <linux-kernel+bounces-332613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D745B97BBE7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162BA1C2168E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775AC189B85;
	Wed, 18 Sep 2024 12:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="fJGR88IZ"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C0C18594F;
	Wed, 18 Sep 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661285; cv=none; b=iTHYkwxxHUtAR13M2hrvfZLrRnXWXonxPgRI+CX+iLBfrxsbIoMfEuf62JohsjZjaFf6L6ugBH/pGeORrlpmTfidw9to+k0ZOuMvnZsTNjFa+Fua4h7TyriiWzLKYNt2XmhyINAX3WthluMQxaR6g/s1iwq8Dd4DsyKOpsYS1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661285; c=relaxed/simple;
	bh=MgAyRkoPeQs3asZKPyIYU49eCWNdqwX8FK64BQW2xz4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LJBznWPBr5nSzIZbB+lKSM1CRsyi9p3QIAC/rH7bZzW98tAiadSDbdFg7w8Okp9ShzglAxUjHbJHtOfMxkwUfEK8q//Zf0qeqePGgMrSFhheThxVgpJcoN20lef4qDlPktb+Af/R7BFwG4FdFi3c7KQjnX11JY8VT6WYhjMmCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=fJGR88IZ; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=zmP6BauGH3tayD8wgBpksCktuzWRZslvxTu5varfluE=; b=fJ
	GR88IZ5TAaDn35bhGfGYSjQDpUo/xgWYyo5KavtjU2P+5+/MWc89aOPHEg6KN996Q8/KtuEC7qzQG
	rmbkLsxgwu8nXatXnUWUFztN5EtrHCbn6nTiONNot8toXrJpG570ZWfPqhL+tuEvJ31ovJe7LCjbu
	5BpxnTrRjEUl10znJXF+5wVRvctS+Of8Fd9weFR4iCfSPCTPwsp8FfNEUo4ybSdRKSA2MN48yaLY7
	Y/0Z3bhZztqLHplzqM0iE0rN5X5gDFSEGHbGo6/mdxzen5dTEnSL2Tl1EPbYZoFb1B5JKxq2o7FUW
	Az99ddb87syAg2Mb23uolaDtunHXIU/Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sqtTE-000Nl4-On; Wed, 18 Sep 2024 14:07:44 +0200
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sqtTE-000Fv4-2b;
	Wed, 18 Sep 2024 14:07:44 +0200
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 0/2] ARM: dts: nxp: imx6ul*: add uart dma support
Date: Wed, 18 Sep 2024 14:07:41 +0200
Message-Id: <20240918-imx6ul-sdma-v1-0-d25abd56e65c@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3C6mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0ML3czcCrPSHN3ilNxEXcsUM0tzo0QLyyQzMyWgjoKi1LTMCrBp0bG
 1tQAO7CNUXQAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.13.0
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27402/Wed Sep 18 12:32:17 2024)

Add dma support for all 8 uarts.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Sean Nyekjaer (2):
      ARM: dts: nxp: imx6ul: add dma support for all uarts
      ARM: dts: nxp: imx6ull: add dma support for uart8

 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi  | 16 ++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6ull.dtsi |  2 ++
 2 files changed, 18 insertions(+)
---
base-commit: 79e1b8171ca476abb9b8eceef81cd1b6f58b75e9
change-id: 20240918-imx6ul-sdma-9d6972a89b66

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


