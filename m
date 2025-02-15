Return-Path: <linux-kernel+bounces-516436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905EA37163
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 00:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DBE1893D68
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17021FECAE;
	Sat, 15 Feb 2025 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Si9LycLk"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F281FE461;
	Sat, 15 Feb 2025 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739663719; cv=pass; b=LcixMskgDJf7mKs8RtmwhZlGM3otrhJJ1/pn6fdWHq8BzzqSJFg44hZy9ZRVH2srqlNeqqIAd7SREYjZJYOmET6NyMOUmsZy21c1xt0l/oEjbxBrrLKB3xpHoRfy+XZhJHM7c5tGGX3Py9vEoSXKfJceg4L4KfvA0wq0IWJSyEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739663719; c=relaxed/simple;
	bh=wHJhwOeaSpNNbgCYMkjjG1GNlz5YxerPhIo6B14rw9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pg324PDkABlBH2FMWEPK4aJgEdiwuo/Mlzrx5v6gEuKiFQoP3QXdkwkhkOc3/15rauH8gq23kh2XvMe4alYOwMpFeZgrR1wpt/ZanftTu6jaPf3Y9MtLqTyxfb/TJWdlBQ5VE8Vi/G0TN+JB7qwvGtW3pzlqfplIM2n+f/Ybq00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Si9LycLk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739663696; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gLhnrwRSLi5R7ujJmVzMeXJmPP8k8tkWee4mL7go0EbBbOrUGumzNeFaAHB8340uQOwV/JO5TvRtQvIPCk2z27ZpVLlXIr6yeYUm9jfKRwsLg0K7W3pjVIWp1N8cr422X5kPuqYapwedZgbrJijGQoj8QX0MB7mJrU6zJgQip6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739663696; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oCI25TPhy4Id7iRyjm7K0b1dudwW2Ibox3w9+UV2UCs=; 
	b=cTm0yelkmBY4uupScKR8q6FfLKheJWmHHb/Nzs0dW93VdNfa7PhAUjY6rhoWwCmyb55by7XbBkOVAatYK+h9xZ2FRwPxBqtHyRA+NyQ5Q5GXGtSuLN37ajI5Oy6wCHdcgvy1xxodGD37Prdo1hRKIOxgYHtbPQ2mw/hMB0roNNQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739663696;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oCI25TPhy4Id7iRyjm7K0b1dudwW2Ibox3w9+UV2UCs=;
	b=Si9LycLkUtDucdpOcJ/0DnsD9jaQx+sTn83slTa5IcmbpMjAAie5J3XlhuuXWF6I
	6glwzBB+8ZWm3Waf6nwCKqrbQERL1kCP7BvjFNxr5hjhdXx2y4SMAy0Uj2Sj/PNZwrK
	rXFmUyVMw1bKiYvc+RWgSNlW2/mLi69G/glZElZM=
Received: by mx.zohomail.com with SMTPS id 1739663695195447.98223907006513;
	Sat, 15 Feb 2025 15:54:55 -0800 (PST)
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
Subject: [PATCH v1 4/4] arm64: dts: rockchip: rk356x: Move PCIe MSI to use GIC ITS instead of MBI
Date: Sun, 16 Feb 2025 02:54:31 +0300
Message-ID: <20250215235431.143138-5-dmitry.osipenko@collabora.com>
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

Rockchip 356x device-tree now supports GIC ITS. Move PCIe controller's
MSI to use ITS instead of MBI. This removes extra CPU overhead of handling
PCIe MBIs by letting GIC's ITS to serve the PCIe MSIs.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 423185686600..4f11141ea146 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -969,7 +969,7 @@ pcie2x1: pcie@fe260000 {
 		num-ib-windows = <6>;
 		num-ob-windows = <2>;
 		max-link-speed = <2>;
-		msi-map = <0x0 &gic 0x0 0x1000>;
+		msi-map = <0x0 &its 0x0 0x1000>;
 		num-lanes = <1>;
 		phys = <&combphy2 PHY_TYPE_PCIE>;
 		phy-names = "pcie-phy";
-- 
2.48.1


