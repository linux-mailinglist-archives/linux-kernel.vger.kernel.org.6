Return-Path: <linux-kernel+bounces-197127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AD08D6685
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340F81F26388
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3117D373;
	Fri, 31 May 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FCtpd2Dn"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8317D349
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172046; cv=none; b=FBJ98lprJx1D+JUFBAkwFfsQ77VmgAfBKaG9S7Hd5kzzl+rcWMh+RVdkw9A2L454T+vBu5Zxkvyon8BS6UngHJ1y20R1YJF4lDBqj4KK7KDlSvY4sLyYfR03WMyR9HXWgduPXgSdXSVUxleSf7OXZ9Uyg7GGZLqkdjIy3PR1G5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172046; c=relaxed/simple;
	bh=jvMliZyp5b79r8W0ZhbR9tXovMVqI+2d9dyyz9g1J6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOM0ZwzWd879t+TRaE0DV4fh7jq9yn+WtyX0wiEjOlZGkk8kHq0XoYuBrMMn0pXDDaVhj4IInW/v3S/DIDiSCF15IFjQJ8US29mOFjTQuTogpAjA25pXRUYFrpyp1kFtuUq/XkQ1obr7EMbejiaW2KoOvU4IkSweHgU2kMOwt7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FCtpd2Dn; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lpieralisi@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717172043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBzV40mF6T/nwZNSQ5a6icyFUiLmHUNqTXGAGDGS/rc=;
	b=FCtpd2DnZG48NvYC7vXKziYauy2VKSnj/rKz8ZxgLAwf4iCYIZVccOujIp/xCW1+hykLnt
	YdeuUSw/31GZ6RtLZAdGc9T0kd2IKA+tXFJ9//TqcLD3N9I6hgsaK6SVsY80MJ34WxlZaU
	lFShJXqNzDYFtjuBVxYqR4/Jgm3e7KQ=
X-Envelope-To: kw@linux.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: thippeswamy.havalige@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: markus.elfring@web.de
X-Envelope-To: dan.carpenter@linaro.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v4 7/7] arm64: zynqmp: Add PCIe phys
Date: Fri, 31 May 2024 12:13:37 -0400
Message-Id: <20240531161337.864994-8-sean.anderson@linux.dev>
In-Reply-To: <20240531161337.864994-1-sean.anderson@linux.dev>
References: <20240531161337.864994-1-sean.anderson@linux.dev>
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

(no changes since v2)

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


