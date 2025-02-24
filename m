Return-Path: <linux-kernel+bounces-529405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F44A42509
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A3D7AB3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B461319ADA6;
	Mon, 24 Feb 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="VqJ8XJQo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ltmyAaFQ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759171624D9;
	Mon, 24 Feb 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409233; cv=none; b=FochtMOTulWj1EoiiNo6K4rnNOa8DUrgdRDDjvFcp4TxnjSbnX2SpN3tm5dNpMaYbImEfpqCf69tQOftxrTlGWemC5CZNV9zYbWM7IagWfWkvao4TJl3033zil8SZAEwSOTFSWS7oJL5akDUu3Qe5S0o8Wy6yoagZ/RC2vYaBFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409233; c=relaxed/simple;
	bh=t6+T9VaQ19kUcPOlVUcf9eAWwa3jHSUeOlk51/iGR4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl7wRsB6mSvRGT6ukc679CCXdVw41Uqt0M5oi31ZFFxQCHHRzqGpA4rkpFM/h8A2+LC4a2OG6kV0EyIs+BuKDorarg4pBTIvR1QdHZIf1DZaR4O/VODTEkeaDRrQLoxafO9N7zmPkG3dHLF1XDfmPgsIYCsYVaFLnN4lnpbGzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=VqJ8XJQo; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ltmyAaFQ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740409230; x=1771945230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e8/ydxRgcdYRL7f64fKb27vbnom2TzUpJVder2TaeJE=;
  b=VqJ8XJQoApmpDc22FBVUt3aVnedP8OUAkXEP+nBu44R3Ni8f9WW8aC2S
   B3khQAQrYHAAZ1oMIP9wn82AnMmikLLSqeBkzbZwP1IO9t1LeahNe3nvu
   1R3XEjAKceIC7Joa9YfW0TfLaGJOfULUZ6Ga3yUU/AHK0rp85gFKmdsti
   xBAftNYqHnGJ9hQpcCZCKiqoSWU+THPAC5bXld1MypAOcgMonXHNln6G4
   IRa1vk5DXy2zv/VOyI4UCJSs4nLtlgEWKVN50X4LstCLADajoxqtCRJvr
   BepTx74BIhVNEReAXmYoUlvXjtESi2sTjSsTy2LhhUcf+sClFh4reBnDR
   w==;
X-CSE-ConnectionGUID: GtB3/u73ThO5yGqLUAfFVg==
X-CSE-MsgGUID: u8ZSgRgVQRiTH9FfvFtmtQ==
X-IronPort-AV: E=Sophos;i="6.13,309,1732575600"; 
   d="scan'208";a="42043008"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Feb 2025 16:00:29 +0100
X-CheckPoint: {67BC898D-59-F75C4246-F0BD6D90}
X-MAIL-CPID: 061B8945113C4A86B8FEABC2A0018200_3
X-Control-Analysis: str=0001.0A002117.67BC898C.007E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A53BD166E70;
	Mon, 24 Feb 2025 16:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740409225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8/ydxRgcdYRL7f64fKb27vbnom2TzUpJVder2TaeJE=;
	b=ltmyAaFQZ7yPxaTU7F0jRIPKVy7zPrZh0mMUK5o4Ly+IYj6cgVXUNGoO1e5fkFDmN+um6a
	8ZeD3YC6P8EKnpLca8+gkhE7mIdDP7HrZbqZ8PtI7LRlfu0YkG5At5MDmjI9DPhz2CMny5
	Wo1z1tmVdw8fZvPqD6gX/smaUc8eJITpt8/wz9Z06sAgPnWHs+dFR0qtJN6SvFK9YIYCp6
	lrmxfDJsAbQ6SFi9N2VZPoxuNoq4dj9XkulULQojMWjhblM1t7+7lvD2KLpErLXIchqy8g
	VobIKQpah4fNk7xb2ZhBkj2Gm2pdNZYnb1fioxoTJKXffcR8iUUCS4XP8loC0w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 2/2] arm64: dts: mba8mx: change sound card model name
Date: Mon, 24 Feb 2025 16:00:15 +0100
Message-ID: <20250224150016.499055-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224150016.499055-1-alexander.stein@ew.tq-group.com>
References: <20250224150016.499055-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The card name for ALSA is generated from the model name string and
is limited to 16 characters. Use a shorter name to prevent cutting the
name.

Since nearly all starter kit mainboards for i.MX based SoM by TQ-Systems
use the same codec with the same routing on board it is a good idea to
use the same model name for the sound card. This allows sharing a default
asound.conf in BSP over all the kits.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/mba8mx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index 58e3865c28895..7ee1228a50f4f 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -138,7 +138,7 @@ reg_vcc_3v3: regulator-3v3 {
 
 	sound {
 		compatible = "fsl,imx-audio-tlv320aic32x4";
-		model = "imx-audio-tlv320aic32x4";
+		model = "tqm-tlv320aic32";
 		ssi-controller = <&sai3>;
 		audio-codec = <&tlv320aic3x04>;
 	};
-- 
2.43.0


