Return-Path: <linux-kernel+bounces-172481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904198BF29B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B7EB2726A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D3C13A418;
	Tue,  7 May 2024 23:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azqvRIWk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDF183C36;
	Tue,  7 May 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123651; cv=none; b=bscUW59jiQojCvuLMbdfp4ngrXqg2N4YHMcs9yzbpME20q8cUmdqrlZRqSA7fxCdWun1OfDVfdRM0zWipuza6far8Q50bYsLk+dWgEjW6nGE8wUa3b1C5d36hreuDjMNEueUeKcYdAJSFgFp5VqMTgNiP6vgrhqBj5afcPw55hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123651; c=relaxed/simple;
	bh=V9xwPCi2BbHqvXbn+HBOTFHYtgRml7I7/V1s2BHN2qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXoE0+ajgYjZ/gYpFZXbEfGzB4mXvFXyfmZAqgG9z8B7fM92WY2Q09BirM7lAjjt5Uc8coPh1HPZkdnL7pZUtiVdnCv/uCi7jz9erawlpwo1/Kc/ee9DQS/ja1IM6hy1aW0Q9CmhDP9LQ/bjg8pK0zYRfMz8qbY1nMbVCBpjpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azqvRIWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0519C4AF17;
	Tue,  7 May 2024 23:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123650;
	bh=V9xwPCi2BbHqvXbn+HBOTFHYtgRml7I7/V1s2BHN2qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azqvRIWkc5tqT0c/wqFAjTgdSdORR/eK7POTT4E+BEPhGqhh2hwMewDBIedkniqLm
	 TZO744hL/nWT3vPfq6Nf+lXWwM/TpmZ5MPLJSLbQCXe0sF2UwYpSfkTfnOmRmHrX7C
	 rR3hHKdo58fajHToULx9MbgLSFSt7ReU9rh1uvY7j39KfhyxITHVGd456xKpvHvacS
	 y6n9hAjWFYpJWxv+dAGvDJGNNPjBM81bULDu/NctXvrSTLmFtsYQxlCiUFci8HbvQ8
	 IaPvEFR6BoTbkHQ8ExW3WxMxTN1Y6w1/0SvdhpKc7M/1DTUTu7z10fROuSuEchM9OQ
	 m9GUUDp1Omikw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Derek Fang <derek.fang@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/9] ASoC: dt-bindings: rt5645: add cbj sleeve gpio property
Date: Tue,  7 May 2024 19:13:57 -0400
Message-ID: <20240507231406.395123-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231406.395123-1-sashal@kernel.org>
References: <20240507231406.395123-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.216
Content-Transfer-Encoding: 8bit

From: Derek Fang <derek.fang@realtek.com>

[ Upstream commit 306b38e3fa727d22454a148a364123709e356600 ]

Add an optional gpio property to control external CBJ circuits
to avoid some electric noise caused by sleeve/ring2 contacts floating.

Signed-off-by: Derek Fang <derek.fang@realtek.com>

Link: https://msgid.link/r/20240408091057.14165-2-derek.fang@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5645.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
index 41a62fd2ae1ff..c1fa379f5f3ea 100644
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -20,6 +20,11 @@ Optional properties:
   a GPIO spec for the external headphone detect pin. If jd-mode = 0,
   we will get the JD status by getting the value of hp-detect-gpios.
 
+- cbj-sleeve-gpios:
+  a GPIO spec to control the external combo jack circuit to tie the sleeve/ring2
+  contacts to the ground or floating. It could avoid some electric noise from the
+  active speaker jacks.
+
 - realtek,in2-differential
   Boolean. Indicate MIC2 input are differential, rather than single-ended.
 
@@ -68,6 +73,7 @@ codec: rt5650@1a {
 	compatible = "realtek,rt5650";
 	reg = <0x1a>;
 	hp-detect-gpios = <&gpio 19 0>;
+	cbj-sleeve-gpios = <&gpio 20 0>;
 	interrupt-parent = <&gpio>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 	realtek,dmic-en = "true";
-- 
2.43.0


