Return-Path: <linux-kernel+bounces-535008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDE9A46DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8771887319
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993A925C719;
	Wed, 26 Feb 2025 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoiMJGWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23B02745E;
	Wed, 26 Feb 2025 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606161; cv=none; b=rRvrvru0q+Qqyf/021QsNzilNhdrad+eiO89w65mcOafiKoY9BliYPuHW0B1s7XYZinQmQlNiCP7t3ncT3b9yqm3tEwpTlwss8ELRi4K2FFc4MzX+s+zemp/6bhyLekJBmYtXtHMITyNGrUPFTnDnA62jICpvXDQcztQdWFqkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606161; c=relaxed/simple;
	bh=TXESE3y/uVZkCVUR0FMjwv9PdpKlu/oA6RS3xIrLSf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JS/KCFuT3vZk2gjGLqgP4pCLfTTmdjJHgjUDCBsdmaMDFlgZCH2vjrKlKKCRri3BTpHSlbbmO0gzTyer1RiMN1n6zhXGdTLTsj56SfNCOthLJzuvBGnulS9nvxe08z6qA4Cyk4mmh+y5kpTKuYfa1rrJ8VGOnN5tCZqHVumq1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoiMJGWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFFFC4CED6;
	Wed, 26 Feb 2025 21:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740606160;
	bh=TXESE3y/uVZkCVUR0FMjwv9PdpKlu/oA6RS3xIrLSf8=;
	h=From:To:Cc:Subject:Date:From;
	b=KoiMJGWzzj0xFLE7biKJZ3mVFN2NCgJ+0PERBPYD7CTEDcpvEC4HeftUczhbywWfZ
	 eseN5/A7HNNZg3PFlD8H4Qb05cgTFt9oT1NfUPIK7M4N0rQjRfL8t6ClIxLjRgS51W
	 o9K0wRjHAEmd+qUPltNY7Xk69ONaoEzGezrizTqbYGjFYqkkS54zb/YN+S1Vj3Jsk5
	 FLNU0gvQgSjzTn2ktNA2a8fotuPETIosmFix29rZCMa42in7CvkNytPz6Q8KACO7VS
	 8lTgZLwGsE33gUqOyP8Wr7GpkxSv1G3RCSSYDrOpg090IqVPrHIDS0PYEStwwlBMQX
	 7sK+AJ3+ZmoFg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: generic-xhci: Allow dma-coherent
Date: Wed, 26 Feb 2025 15:42:31 -0600
Message-ID: <20250226214231.3745400-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms like Marvell are cache coherent, so allow the
"dma-coherent" property.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/generic-xhci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-xhci.yaml b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
index 6ceafa4af292..a2b94a138999 100644
--- a/Documentation/devicetree/bindings/usb/generic-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-xhci.yaml
@@ -51,6 +51,8 @@ properties:
       - const: core
       - const: reg
 
+  dma-coherent: true
+
   power-domains:
     maxItems: 1
 
-- 
2.47.2


