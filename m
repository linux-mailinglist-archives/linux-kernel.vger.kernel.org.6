Return-Path: <linux-kernel+bounces-213026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5750906A02
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3887028444C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0772A142651;
	Thu, 13 Jun 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="obFwPiPi"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A684A56;
	Thu, 13 Jun 2024 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274574; cv=none; b=cgMR4649mePrp/SCtg3RldYtawikt1irwDT22CymsIE/yCX39t0fE/lxDeIPDDzEj9cYH08oaeBVta7xOxxUFu+uQuVceLbhZzsVEoCa/bZ1QpMVinN8xym4TPZsDS+l18lRtvm1QXF63xAvwn3A58ziIb21QfzywA7jF/+qqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274574; c=relaxed/simple;
	bh=o2/NoIJIDufEDFkWKvK9KpEa5l2ut1wt4/+5mV9dJAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HP/NYt54YjvbxZW4eE0Gl0zv30ESyayy8yS2RIY4z1b8x39VrFLWWo1jL+jRr/Isg4HmZjxP26d+Yi4UaFJAHvm3mty+XxR6HmP8A1Yya5Mcx1kgeJcAMux11csliwO3sCj4z+MQC0rv/8Bl82uZw0uiYiDRu0Ifbk63wl8ayo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=obFwPiPi; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3AE0D1F921;
	Thu, 13 Jun 2024 12:29:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1718274561;
	bh=JRgajXleaJodVRi5Ndki23FdgEua+qf/vKYpg0gClnw=; h=From:To:Subject;
	b=obFwPiPiIk+HNdKs2MEw4+7e98sLdhXb6qEmdguT30V1hHcLkcpDra1HNgkXKIfqq
	 e4QF1QuD8PxQ1sDHKFi2HEs80T97dYh7qAUcOUQ+ApBqC3wpbyWgl3JQiVQwuTBJrr
	 m/cyxOCl83tMSwWDWqEzhHVY95lTmj9eLbpiiHTHCLi6wiGsKCMzW1EHs4ORmdUqWm
	 Tf3nQM0WESgdVsIjMn5+SbO3/3xKNMxQj69tjJcsWdwPWM+XYUHDUlR3FE0yqBMl5I
	 cDZUdgMaeQMpoDSx9T6MqV368O96LikwlqL33eoQo03u5Vf3ytp0bMUKPte28+sCzg
	 c7jkNsaDVAiPw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2] dt-bindings: usb: gpio-sbu-mux: Add an entry for TMUXHS4212
Date: Thu, 13 Jun 2024 12:29:13 +0200
Message-Id: <20240613102913.15714-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parth Pancholi <parth.pancholi@toradex.com>

Add a compatible entry for the TI TMUXHS4212 GPIO-based
bidirectional 2:1 mux/1:2 demux which can be used for
switching orientation of the SBU lines in USB Type-C
applications.

TMUXHS4212 datasheet: https://www.ti.com/lit/ds/symlink/tmuxhs4212.pdf

Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: Add Krzysztof Acked-by
v1: https://lore.kernel.org/all/20240517111140.859677-1-parth105105@gmail.com/
---
 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
index 30edcce82f97..8a5f837eff94 100644
--- a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
+++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
@@ -22,6 +22,7 @@ properties:
           - nxp,cbdtu02043
           - onnn,fsusb43l10x
           - pericom,pi3usb102
+          - ti,tmuxhs4212
       - const: gpio-sbu-mux
 
   enable-gpios:
-- 
2.39.2


