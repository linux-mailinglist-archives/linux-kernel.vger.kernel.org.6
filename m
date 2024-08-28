Return-Path: <linux-kernel+bounces-304962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5AD962768
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5EF1C21ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F5181328;
	Wed, 28 Aug 2024 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="ii6SIp7a"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF117C9AC;
	Wed, 28 Aug 2024 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848858; cv=pass; b=rsYt5w36FPo8wJptJbj+oSkGFMMu9KT4WxNOrFnHGp9BeNT7qZUkMrvFPRlunOUGuhwbCfL8qO+X1ZYnD6mznCczbsWHxmQpclvMeQmxYt/CIGKw/l9i7Cr0NLYAb2OGTdmxKywxjfaf9r+pP0ruw5C+i40H5LljSXSxlCqWzjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848858; c=relaxed/simple;
	bh=1UOqS2Dxo8iR9T9B1fLDBZrWdN8+C3Mh5hkvpGIoXa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/0ZlqFlUGkzoxZ71uqPLJl4IYW7jxMt7Kkz/Xo3WICzCCMPFUUPOvCX2BOOgPWSn5VLkKrFYgbSLgyuMlc7oBEP6HXxiRDCZGsG68gbelrD9D+AW4wgn9iUU6n/ew4UaynWvBjjOhHhpgcfIgTDGhvCSbRYkm+kU9y0KGSOkHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=ii6SIp7a; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724848846; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZW+hUkI92G2IJQ6fEhifND3XSgn7CS2EFzlhtkhdHFgGXz9axAAL/oWd/H4EJ6jmxF2Yj0ku4jeC1mpnGmkIwPjnwxY9H4QSurywUs+Jun3l5/08TmoA4GieDMWzAMqqkPuhnyS5VfdpB/G+s6/VSpTb8RdXxfDr3HtK8d9I/T8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724848846; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NHu1lK8y+binnoeFm6Jqz7QKNR4uii4rwsRkUGw9AYA=; 
	b=kaaknCy2IEHiSvOaM6KqXeBd4iMlVkyMhbDMVEkQSABfDO9pQpIWKIb6sU5QqKm7ezGJe4B4nc4iWVMlvjZ8w1rbe7sqQVgzDpurDBvA1XKgdXyY4W15BCu2ou+6iyai1TSTJuYUBSJViBXZWYrQnsb45xc1NxBneTlTJQReBVg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724848846;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=NHu1lK8y+binnoeFm6Jqz7QKNR4uii4rwsRkUGw9AYA=;
	b=ii6SIp7a1cy99fT7eUqJbZ/5IR91DYM8tz0qsmItudWiMd4CVWe40HqAC/JMRQ1F
	PYna+u6PfcMSKbMFC6NHpMR58YYOTJpf7XBS0kwG0HGjS9SPPlnPOiB4exCKRpxZeHt
	VGPTSFKyRoumqIBvdmSbkF5jOZQRb4+fJ0FZ+xBk=
Received: by mx.zohomail.com with SMTPS id 1724848844589312.0136674505112;
	Wed, 28 Aug 2024 05:40:44 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 28 Aug 2024 15:40:09 +0300
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Fix compatibles for RK3588
 VO{0,1}_GRF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-rk3588-vo-grf-compat-v2-2-4db2f791593f@collabora.com>
References: <20240828-rk3588-vo-grf-compat-v2-0-4db2f791593f@collabora.com>
In-Reply-To: <20240828-rk3588-vo-grf-compat-v2-0-4db2f791593f@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

RK3588 VO0 and VO1 GRFs are not identical (though quite similar in terms
of layout) and, therefore, incorrectly shared the compatible string.

Since the related binding document has been updated to use dedicated
strings, update the compatibles for vo{0,1}_grf DT nodes accordingly.

Additionally, for consistency, set the full region size (16KB) for
VO1_GRF.

Reported-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index b6e4df180f0b..ee99166ebd46 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -582,14 +582,14 @@ vop_grf: syscon@fd5a4000 {
 	};
 
 	vo0_grf: syscon@fd5a6000 {
-		compatible = "rockchip,rk3588-vo-grf", "syscon";
+		compatible = "rockchip,rk3588-vo0-grf", "syscon";
 		reg = <0x0 0xfd5a6000 0x0 0x2000>;
 		clocks = <&cru PCLK_VO0GRF>;
 	};
 
 	vo1_grf: syscon@fd5a8000 {
-		compatible = "rockchip,rk3588-vo-grf", "syscon";
-		reg = <0x0 0xfd5a8000 0x0 0x100>;
+		compatible = "rockchip,rk3588-vo1-grf", "syscon";
+		reg = <0x0 0xfd5a8000 0x0 0x4000>;
 		clocks = <&cru PCLK_VO1GRF>;
 	};
 

-- 
2.46.0


