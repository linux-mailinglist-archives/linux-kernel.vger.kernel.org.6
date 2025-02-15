Return-Path: <linux-kernel+bounces-516435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACAFA37160
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EDB3B072E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349791FCF6B;
	Sat, 15 Feb 2025 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="GYo6xfTY"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2D1FE444;
	Sat, 15 Feb 2025 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739663716; cv=pass; b=LxZxJkrhN393AgLI1GPgqZWjRCfkjGTal2RQostl0+4NT8PvGTBvOHL01B9EL/I644pQvKh0e8QvgOg/w75i+QIgHN6UyiaLw9N2qgxl54f0CrJXlKxUEwMPEd41Yajp4rmvg3cxPpv6XuHnTO+1UpdhTXJzdp9Q3Eti+ETlTuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739663716; c=relaxed/simple;
	bh=XdBLsGtN/7xOlNbFtrN52dU7LE5bMVG+nKHZ4Fs5sTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0tOIN7yPDa8Rcl9Qw/KbM0SO+yUYXPiZM+TLYJj0HRvlpFxwulZ3JkUgxum7JpZ3z/k2STkxfS7ylmfJnezfgnvrmt92GLc3R+KTlLJ0ERQO+x6xzGd+BaOXUk/tqc1ZvX+TU+aIbiJ9OnGJkvMBZhAenuu7wUL1C4iQ9JJcCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=GYo6xfTY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739663692; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HhXDMQpra6W+3UXNuLbuAQzVukz2AnpaULYHdn7SHlffKEvcXDIlmpOnwK7l38SkXTvGF33igzqOpfPMHcVRGCwpWyD9c696ldWAskNmUBS8oyIbZia94MMyLQ7SKG//8Hiu7Q0HQXPG/F9g/jCCw0IyYZTNrUsB6yucdUVcxZI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739663692; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bk824fFEtJ4JFX/2FTI1e4/t7fqz6XFoNQNdiEacVVk=; 
	b=JL3BWw6LOrN84w5R7wVuSNoF8Cl+DMYFv7Bnzrkzu4Nr5PIksC/iUgKEgBorCH1E6BlDrKU9sQ6TCtXiZ4dgURqngLwe07R+o1O0G8+vmkjXNZl9Juy32BLtEOtqKdZmHz6zBId73qOyI9GRA5M8dB6Lwgd7PP69V7TCxkh+tTw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739663692;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bk824fFEtJ4JFX/2FTI1e4/t7fqz6XFoNQNdiEacVVk=;
	b=GYo6xfTYrndfSuf258+c3emT8CQjDptqxGrCFuLS4dqC474pjK3whe0zTeaGrTxv
	3usimKIFYP4BtsPuSSel8iUvjr4L3iC0rXUJu/UexPGUKLomfHN4yPTwvN/+73IeuE3
	qmVzp1bLYqmMxprIy2oeYMNpzKaFo9W5hd5DTxTE=
Received: by mx.zohomail.com with SMTPS id 1739663691563809.1510485476141;
	Sat, 15 Feb 2025 15:54:51 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kever Yang <kever.yang@rock-chips.com>,
	XiaoDong Huang <derrick.huang@rock-chips.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	kernel@collabora.com
Subject: [PATCH v1 3/4] arm64: dts: rockchip: rk356x: Add MSI controller node
Date: Sun, 16 Feb 2025 02:54:30 +0300
Message-ID: <20250215235431.143138-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215235431.143138-1-dmitry.osipenko@collabora.com>
References: <20250215235431.143138-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Rockchip 356x SoC's GIC has two hardware integration issues that
affect MSI functionality of the GIC. Previously, both these GIC
limitations were worked around by using MBI for MSI instead of ITS
because kernel GIC driver didn't have necessary quirks.

The first limitation is about RK356x GIC not supporting programmable
shareability. Rockchip assigned Errata ID #3568001 for this issue.

Second limitation is about GIC AXI master interface addressing only
first 4GB of DRAM. Rockchip assigned Errata ID #3568002 for this issue.

Now that kernel supports quirks for both of the erratums, add
MSI controller node to RK356x device-tree.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 28be38b7182e..423185686600 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -284,7 +284,18 @@ gic: interrupt-controller@fd400000 {
 		mbi-alias = <0x0 0xfd410000>;
 		mbi-ranges = <296 24>;
 		msi-controller;
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		dma-noncoherent;
+
+		its: msi-controller@fd440000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0x0 0xfd440000 0 0x20000>;
+			dma-noncoherent;
+			msi-controller;
+			#msi-cells = <1>;
+		};
 	};
 
 	usb_host0_ehci: usb@fd800000 {
-- 
2.48.1


