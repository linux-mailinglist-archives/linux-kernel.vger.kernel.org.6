Return-Path: <linux-kernel+bounces-184215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6908CA46F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6337A281C95
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07E53D57A;
	Mon, 20 May 2024 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSWUVzZs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2302D05D;
	Mon, 20 May 2024 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716244044; cv=none; b=WpNMCChw1eSXS12/g+QMcwPKDPd3qN2jDY34Vzg3XHAizmsqVWFLgdvmDnUYofRBYwjy9HHYpu+t3Ob/5OVCTNGjI7d0U0p7GpqRsFUyhIPahOGmS2gl3XNn7yIZVeHTAAGPBLsDoOa6+gnLgY1/svTWDOOAV0z11FcSuY0WRNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716244044; c=relaxed/simple;
	bh=A4335sSIXxSmnvWq25uzN3eOtMetrX9olnAwnD6I3O8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DE9mAXixIlq6kZBixKL5ZWJD5VIA74KJEh4v49oL2oZqg2HoUaPPfgclXhoSNJy3vaAANJJq/RmEpF/+hbXfBd4SScO5TMU3DFRYDrsXMuiPKpAJ3eox2QiUoHJlsGmSwQE+M744IFmEkI3UPuyhq3eQVn5iKmhbClYfUuacmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSWUVzZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B863C32786;
	Mon, 20 May 2024 22:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716244043;
	bh=A4335sSIXxSmnvWq25uzN3eOtMetrX9olnAwnD6I3O8=;
	h=From:To:Cc:Subject:Date:From;
	b=jSWUVzZsOzzfjNNR6COy5iu43SEw9an/h08K3UwU44Y8aVHFtKBEliBun26ei13rR
	 Fks3mR3dWTpbxbCJpAkbW2+ORuu2WsixgPMnQfErAm0C32EBNFgffeGp+naaJDq3Lk
	 3IZltRLT0E4TSBsXggeBVzqhI84BB6B6IqkMpukjqeAVp6pP2PunWg0j/UFy+x8uNR
	 bDUbyXUbWQN9T0UTLNz+vJezXrmSTZ9baBQ6NU156HgcqQJVif7yTnPyUOzGhHd3ZM
	 R3ppI4db2qLhDkviAeXGdQH2LGTMjzrUstRk0AmDM+6ciPpDCL0o7lK2ZiP6B8BWCL
	 Ic8GCXrXq+IKQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: stm32: Ensure compatible pattern matches whole string
Date: Mon, 20 May 2024 17:27:05 -0500
Message-ID: <20240520222705.1742367-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compatible pattern "st,stm32-sai-sub-[ab]" is missing starting and
ending anchors, so any prefix and/or suffix would still be valid.

This also fixes a warning on the example:

Documentation/devicetree/bindings/sound/st,stm32-sai.example.dtb: /example-0/sai@4400b000/audio-controller@4400b004: failed to match any schema with compatible: ['st,stm32-sai-sub-a']

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
index 59df8a832310..f555ccd6b00a 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
@@ -68,7 +68,7 @@ patternProperties:
     properties:
       compatible:
         description: Compatible for SAI sub-block A or B.
-        pattern: "st,stm32-sai-sub-[ab]"
+        pattern: "^st,stm32-sai-sub-[ab]$"
 
       "#sound-dai-cells":
         const: 0
-- 
2.43.0


