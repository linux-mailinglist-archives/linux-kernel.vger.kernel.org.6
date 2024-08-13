Return-Path: <linux-kernel+bounces-284147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B02194FD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E872E1F23A84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D6E42A93;
	Tue, 13 Aug 2024 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="NYHfQmSj"
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFCB364A4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529108; cv=none; b=o6DG1ai+JLrsbeeN/YiwaXuWWOdHNBIvwSy+sC9A73EGLx7Rzy8RxISFbayWsAC0K9N5PCHiyLW7/3DgK47+aQY21bAjDUS/iSj1aGUyEGije8H3bbNeqGFKpF1b2Es3gmm9yZPK1Z3QLdQAQ6wNmDKnvil/GIUCnJEj3JPwAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529108; c=relaxed/simple;
	bh=xwO4qZm3Gbqbi5R6FcqkiTL12YiVG+Slagrb4NBEdyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9HWZkXpSIi/FLOJr5mzaKtgvlvpIhMGUtmNZ5Zlvr1u1e6MiTiE85LtiNz2l5nMtLzvH0FQb5TPZr2MrfiiUMOrwA7BZC3hFvHNKw5iDFskGGu5Xl/ds/Arubu7rn3CchwcJ8UUaYdpE7AyRS1pwtB2B/TykFqwYhqTgsnxqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=NYHfQmSj; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202408130605012e2041c53ad2c41889
        for <linux-kernel@vger.kernel.org>;
        Tue, 13 Aug 2024 08:05:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nESrF5vTvc0qOhMZmjkHj4ky91fAdlGMxwFql/ii16Q=;
 b=NYHfQmSjhbe7a9WCrV7WcuKchcxXHQCFiyR1MwRd+wn3tYvaelipfjg1PWCY1U3pO6lOby
 JbysP06T37errJhkP2YWE7p2WqKvHZs5f2spGP6qJ7zefYwzNLr48nxiV9DEAesyir4a4fDL
 d5gzsyYoMIz7nsVZE7AOnGNL2GB41IPoHfODgOz8A0Vlk66zppUXXz0TA7W1KAlrF6/gb24H
 pl/8QEI7qDKX56AdYTXoCyAkSgFMAWsX8+vcyjGQAgpfrMy7ezS0c0MK9DvUtSU1/CprNTRk
 MAlYg487drK+1nDSOXB0zI5WErMShT363xeRFu/DhHpmXfFawxM+if5g==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v3 1/3] arm64: dts: ti: k3-am642-evm: Silence schema warning
Date: Tue, 13 Aug 2024 08:04:58 +0200
Message-ID: <202d7ccb9796642c2c05419f77c402ebd6719a84.1723529100.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1723529100.git.jan.kiszka@siemens.com>
References: <cover.1723529100.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The resolves

k3-am642-evm.dtb: adc: 'ti,adc-channels' is a required property
        from schema $id: http://devicetree.org/schemas/iio/adc/ti,am3359-adc.yaml#

As the adc is reserved, thus not used by Linux, this has no practical
impact.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 6bb1ad2e56ec..42015a55e0d3 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -646,6 +646,10 @@ cpsw3g_phy0: ethernet-phy@0 {
 &tscadc0 {
 	/* ADC is reserved for R5 usage */
 	status = "reserved";
+
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
 };
 
 &ospi0 {
-- 
2.43.0


