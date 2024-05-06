Return-Path: <linux-kernel+bounces-170141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C98BD258
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C9AB23DD2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64DF158842;
	Mon,  6 May 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UpPf7Ox7"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5860158219
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012144; cv=none; b=RzkG6MLjdlgw56d+Zp64Rm/34m/e7T+lWIxUTXg8IdPYSjs2lPSFRy5S/EllBsySJwUh44Gfvt4U2Wll58nLX83tvM24ZVU56SoVfEnOc63V4BGs5GkFXsjvY7ikAavBtBxGD4kgK4Etu+vCDND4XKzU+LV7TTd71RwW++d3ZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012144; c=relaxed/simple;
	bh=T1+Rbt7S+pNf5q3CRHOo4VcokJLF+gGx7h9sjDgMKpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0+mErOB+SNEsq2OR4NCrmOESAJE98CIcO1Bh1D2cqQgIbFcZHobpdpxaKIVo1A1btQCaBNp6t8WyjQ8wo2XAi0DsDG/xblsmjpQ92iyAPBzJx6wxhkpDs6DwpMWL53gxd+cY+eZkn60VHIQkBDpgn3Kg0RxmrKaqVhvVWPN1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UpPf7Ox7; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715012140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ck8JgZysAqiIqlF+N+8+WdMTAZK/jkIRufdhwHxvwE4=;
	b=UpPf7Ox7SFE6/WLTzUKvDVSsuy/M5WEJuFj+ZO70agQ5WPL0K2MGVALnPQTfs09ZEJGbEd
	HprA8xSjWt++oRwyvMRXQ7ULv9gX/siwXF8ZJJVJlLmBIpKTYbsCyhsWl7B0YtmMuNkDIM
	yQxX3tO1Qfr0Tvl43E3cmXJ0c8Fm38U=
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2 7/7] arm64: zynqmp: Add PCIe phys
Date: Mon,  6 May 2024 12:15:10 -0400
Message-Id: <20240506161510.2841755-8-sean.anderson@linux.dev>
In-Reply-To: <20240506161510.2841755-1-sean.anderson@linux.dev>
References: <20240506161510.2841755-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add PCIe phy bindings for the ZCU102.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Tested-by: thippeswamy.havalige@amd.com
---

Changes in v2:
- Remove phy-names

 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index ad8f23a0ec67..d2175f3dd099 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -941,6 +941,7 @@ conf-pull-none {
 
 &pcie {
 	status = "okay";
+	phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
 };
 
 &psgtr {
-- 
2.35.1.1320.gc452695387.dirty


