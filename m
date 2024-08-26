Return-Path: <linux-kernel+bounces-302389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D524695FDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 01:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A5A282F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0118A19B3ED;
	Mon, 26 Aug 2024 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="J3KyELAD"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC5487A5;
	Mon, 26 Aug 2024 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713665; cv=pass; b=XGW1qvxLsFv7JUTicrvjRbFCVRKlO5qYSvDEvIp3BhrJLBRTTtBT1z8e9z5kA3NAKln6X1MCbrDvoH7YGbaCXuYzQVSZ0pJ0cz6kGTLqb4MFtiB0TGqmyOcmdhLZzEr3t70aAARfVf3TqbBsJTcZiPuhRPdxQWPAwxL6nzsSHoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713665; c=relaxed/simple;
	bh=TruLQF+gTpevnihSsxReHdrZcxOI3HJkS8I51OoL4y4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JHHkBwLVVu3HTf4Fx8DzHemFr5q6ZW1garvPIey4bKl+UDEGXs5DvFeyycbBV3XxDG+hU1EekNIrHXD1UtTyPRsCD81j7PZCd1jiZDVifsFyGP+KKZnESbsQu/VQSyllSUSiqgZ9LYHFCIcT379/50seZHote3EV4nyzwhurTO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=J3KyELAD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724713648; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C9IHZ8gRUJHQEjPa3DWNImYwv5b7A5bqNh/zuZVYddWHi/iamz1esQW7PVpDqs5kFhZxuepA26jy+72nczNP4b0+QjVaLzeeuNrW95UY4M0nAcUwj289TXqjCiIaaSqYcNL22l92sES/h6PXs5IvqczCCSL2z85ykiGMBn+0kmA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724713648; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O4UgvPlxUIocUclKtFW+PPXZ5p2TpKUAXhxXfnHWxSA=; 
	b=epQ1jqub8wIGQXeXOv5a1HmWNU3wQqqUpNcd2XbNamvNN8YOoIck1Fyuj0d5O8pWfjJk/GTiVNsqeMPTKPBXzHCYHCPGNeK3GOaRTXs5RaUB0yrbcEkr2EkM+ldjyopl6Ur4A7luDJ6WqY57RClMzdnn4oHDYS+OA0IQGtZs2e8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724713648;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=O4UgvPlxUIocUclKtFW+PPXZ5p2TpKUAXhxXfnHWxSA=;
	b=J3KyELADNktUDvd59M2fuuGLX6fl3YXdlgXiW3q3HAYqXQFbTWiThuCTISEhBgFo
	oGpS1gNHGH3mCOYyIP5T6/DHkc9grjKbnDhGEe+kbDrPMkS58VA36Hdx2nNl8rWPIpJ
	2PnY08RJFudIQ+ILx1z52m/VfeCnfZYeDGPJODrY=
Received: by mx.zohomail.com with SMTPS id 1724713645980482.61635936819255;
	Mon, 26 Aug 2024 16:07:25 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/2] Fix compatibles for RK3588 VO{0,1}_GRF
Date: Tue, 27 Aug 2024 02:06:49 +0300
Message-Id: <20240827-rk3588-vo-grf-compat-v1-0-d4a18acf951a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIkKzWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNz3aJsY1MLC92yfN30ojTd5PzcgsQSXZMUo2QLk5RkcwujJCWg1oK
 i1LTMCrCx0bG1tQBVm0zRZgAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

As Conor noticed recently [1], RK3588 VO0 & VO1 GRFs incorrectly share
the compatible string, since they are not identical (though quite
similar in terms of layout).

Provide dedicated compatible strings, as a follow-up.

[1] https://lore.kernel.org/lkml/20240821-stretch-scam-09d7adc08a4c@spud/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (2):
      dt-bindings: soc: rockchip: Fix compatibles for RK3588 VO{0,1}_GRF
      arm64: dts: rockchip: Fix compatibles for RK3588 VO{0,1}_GRF

 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 6 ++++--
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi           | 6 +++---
 2 files changed, 7 insertions(+), 5 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240827-rk3588-vo-grf-compat-4d2c84dc782b


