Return-Path: <linux-kernel+bounces-390508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441F49B7AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11A8B22ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D411A01D4;
	Thu, 31 Oct 2024 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="QCcmYDL6"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AEC19E97A;
	Thu, 31 Oct 2024 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378199; cv=none; b=tZkVWvNDQnBT2NRUwoO6bXD3cQCAp7KErDGilsT1IWuDdrMNADoV5LUkwj/6IupAR17Cjl7NJNdk7OPISfu4DvyPtERjT5I/sUnqufXOuISz+F7kDdzTYScT7kzKSI9FgXze9L5HrpbUNNxeuz0wuQwhg4jVsG91y4NdJ3N95kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378199; c=relaxed/simple;
	bh=o8uExKqB5qYo54a2nVBhqm5tJs6jO0jYNm2MbZM9eVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnpsW0QDQ7NzXr5C2r3+Byjt/PS8BF0WDCh78f4H5zH/EfgoK0xkkJGcLX6i+foFADhYPsoP0CcHoZ8jfBPzf7rsAJRbqPE85MIj3b/3kqPnIjo+IIqVMYTT9sd1LyI/3irZSr/wlbiLSkgX4Np/qH2sv8VrG6eoEP1pOIjbOEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=QCcmYDL6; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 44144A03F3;
	Thu, 31 Oct 2024 13:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ZZCQu8PNGzbUydOutitt
	bytVy0ecwKj8suiZ8x5X5G4=; b=QCcmYDL6+v9xdH2YXHTS7Zqz/CItscCRXo7A
	U31p5LHGEfDle6PKu1dvjJyOg+Nu3Y6wcj1P2gg5jzB28PH0XQHA7l6rpE0icTpi
	p/Gal6rddtTEREjAqZg0UeU3JBu+XiDeJ8DXx6aQi5YS2y+gJs3nxmTjfnEqas6i
	f+869DVnKhzTwNxJZoeJ9sj9yjXTd0NxLh1scTR2yrXz/6RPEeN7zYV44AbzJVnt
	4Rgnz3NTS0ECoIoYRP+go+slK+Ng7ANLP4iEQosE5GInaKUfJz8PtdiHkozTIVnS
	KucnLC76yvihT9vsdNCvtvNke1a64ORY+8SkMGxr/P4axIuZHHtnfNaa5lgnsDE9
	Phm44+r2xGmUjea+j/J2nXZ0nTaipj1TqUSIUPtdZ8sQzf3884qW/3pd7TXv8rpi
	Q1GOZ7Or71GCg2ZOdCHPCL5UOcaYinW/DrlGPNzAAnXg6Ss/G3eXaJ3zpCLvMcSY
	ygd3dY1D1StnLbu/SHKyGGSOBMc2uqKhcYSDi8HAgAopmi0mFSxqsseSb2y790Qb
	eiZ6zBnuWpuJeu9kz4VM7m3txxq5aEKgiuANX4H1CLhww7v3YgyU3Hmy71s2oVGh
	/N6SY6ZJ9Rm/4Pr+SBbWQDW3HYsedhG4c7z0eK9lGPlIKtwgj7Pq3Mzzq7tsHmhF
	aTDPnqA=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 10/10] ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano
Date: Thu, 31 Oct 2024 13:35:36 +0100
Message-ID: <20241031123538.2582675-10-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031123538.2582675-1-csokas.bence@prolan.hu>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730378195;VERSION=7979;MC=2596984542;ID=207190;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667667

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s now has basic audio codec support. Activate it
for Lichee Pi Nano board.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Moved and fixed conflict ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 .../boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts
index 43896723a994..472ded0aafcf 100644
--- a/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts
+++ b/arch/arm/boot/dts/allwinner/suniv-f1c100s-licheepi-nano.dts
@@ -62,6 +62,14 @@ &uart0 {
 	status = "okay";
 };
 
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Headphone", "HPCOM",
+		"MIC", "Mic";
+	status = "okay";
+};
+
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.34.1



