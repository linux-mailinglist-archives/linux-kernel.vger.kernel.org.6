Return-Path: <linux-kernel+bounces-532481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A98FAA44E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC127AC39A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37220D513;
	Tue, 25 Feb 2025 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe7Sdg3x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D3DF59;
	Tue, 25 Feb 2025 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517405; cv=none; b=SSAOyK0VRgwn6PIjAgCCG5iWVW9/JJKNjfKXxx8Tn9K7WeryupdDlqDrn7c/7URf3V22aILgZyjl2SDBMSrEufey58wrUW+Mrtsms5hNCC51GOSFd31E0gNitcVHyJ3dptO/v/9yR3ljQyQ9icDr7xTj+87t7zzQFEI31XeOKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517405; c=relaxed/simple;
	bh=5QLha3LU54q2eJpH1rlZ9gtOA95sAt4D3nlp+ptlssw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GFxz0pA+zCVi8LNuGgaIsqzAPW/Tls5jGZ0Uc3xmLbBs7tnakrmnnpsKEJ7spmddSrTI3A5YbL2ntNvLw7Wzi62vmBHlM1kHQhccADWtPsklQpjwgseAwApetG0S92vHEwH62gCm+GISwUynYyhBAvXeqvkJF9N41ikgEOfRWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe7Sdg3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC64AC4CEDD;
	Tue, 25 Feb 2025 21:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740517405;
	bh=5QLha3LU54q2eJpH1rlZ9gtOA95sAt4D3nlp+ptlssw=;
	h=From:To:Cc:Subject:Date:From;
	b=Xe7Sdg3xqnC0ijDR2xEdQS7iYEc+HPkaF1a9tFadBkRzPT846RidLssoY6DTJgZxA
	 coepeyFbfaVDzTulWQ0lA13JXpv+uh6JUEWizvSAoboMJ/7JxoJ2KrdEWCDqjgtp2m
	 pGLkCjdLj49kd+CvYR/7oEv6uZLfCnudVGeXAhLnxwMXSVoQ5wzBX3UzFyJnsr3PoF
	 9nJhDz8tmi4GSGDCjBetKYGf0sjhgUeMSur+LGXTYBFPiU+ORsvVWP5A6ab9YnOGWT
	 OoZ/cA2n5aM7xoVJlQXGU8nO0MdVi7gdP5pVy4XCc//syfWLLGDHvXL80Mpmx/J83R
	 UM2f+Y0+GvaaQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: mitsubishi,aa104xd12: Allow jeida-18 for data-mapping
Date: Tue, 25 Feb 2025 15:03:14 -0600
Message-ID: <20250225210316.3043357-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's both a user and the datasheet[1] indicate that 6-bpp is supported
as well.

[1] https://agdisplays.com/pub/media/catalog/datasheet/Mitsubishi/AA104XD12.pdf

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/display/panel/mitsubishi,aa104xd12.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
index 3623ffa6518d..2c92d81caaaf 100644
--- a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
+++ b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
@@ -33,7 +33,9 @@ properties:
     description: Reference to the regulator powering the panel VCC pins.
 
   data-mapping:
-    const: jeida-24
+    enum:
+      - jeida-18
+      - jeida-24
 
   width-mm:
     const: 210
-- 
2.47.2


