Return-Path: <linux-kernel+bounces-321290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ACB971810
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C031C21F19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66D31B5EA4;
	Mon,  9 Sep 2024 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ki2Tz3sG"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C71B533B;
	Mon,  9 Sep 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881958; cv=none; b=gq/NyvTEzJ5SG35ZGpshpPR2B3W+6vVAV7tnHJsJpHgKxTC0oSiGsQ80cszUvMaAGWfa+TEXqqSKAxn2IdLgUEUDueHGpAPZ/nxHWB770N2OnVBOPDV0DSiqNlobH9S//gNymDpe7tO/tbwlYrkzi3oYY7UbWTY7ZtXiSvSxIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881958; c=relaxed/simple;
	bh=kggfsNTCZhvoiaY0CpNYztQnwK0ju67Soie53btb2iw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qTDpQuOcIZt4DHqE0QvI48abw/G00FKGPJkuAaZG/fM4DHeUZAiGqU5KVwIx6xAAgja3Fps7M+C4i2Gp3PJmZlxTomlwCV+fcsNF9i0dzuQQg2k5xSYWKDIjGuKWcdlivfACZDXbFUCqHShCZwCxcBRKe5pgk3GNX2sn/McdMFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ki2Tz3sG; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 13C6B88D1F;
	Mon,  9 Sep 2024 13:39:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725881954;
	bh=8CR2aDii7smh/tqc1g8mB9eAQqyrlVh29TmUpt45vTE=;
	h=From:To:Cc:Subject:Date:From;
	b=ki2Tz3sGZjcVdNyebmUuo0faz1vJCgVzN61ghmAKxDePv8xfNhWVX6z9TwaKaYrdh
	 if9YlPzpr99y3Lbq9Khy3KVQuG09nKvXW2A7djhloaKJE/NXz/SwTonokeyhzo6Mz3
	 M2dhgoYTMyyVthRBXrAtQYRwD46DdwHzC8S6D4wIms8nSDbJt93n2sqnmhp0N5JW2O
	 tsshiWZOKdBbsKTfLn29ChNTfwhMu6A0YAvDaV5Cr06ggn5cV9mokoz12qki+P1Err
	 kIWLeMAfjbhBo70ZmlJdmQWZqa3CQ6neZ6hyBF61RJ5oHS/ZO6h4ZZzdBJU1/BVbt6
	 0dhMpWPAx9e2w==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Michael Walle <mwalle@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] dt-bindings: arm: Document the btt3 i.MX28 based board
Date: Mon,  9 Sep 2024 13:38:58 +0200
Message-Id: <20240909113858.359112-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The imx287 based btt3 board is very similar to xea in terms of used SOM
module.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 80747d79418a..f290c824a91b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -97,6 +97,7 @@ properties:
               - i2se,duckbill
               - i2se,duckbill-2
               - karo,tx28                 # Ka-Ro electronics TX28 module
+              - lwn,imx28-btt3
               - lwn,imx28-xea
               - msr,m28cu3                # M28 SoM with custom base board
               - schulercontrol,imx28-sps1
-- 
2.39.2


