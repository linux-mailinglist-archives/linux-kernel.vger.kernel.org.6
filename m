Return-Path: <linux-kernel+bounces-283831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F7294F925
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A43BEB20FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48CF195808;
	Mon, 12 Aug 2024 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PMmIkIhW"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3030B1586D3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499498; cv=none; b=ZXUr/gQ/iODbW0OdwR+Ecbvqz+lMR7z9YOovzZrLBTmoVC25g3FWeqD4yo0dX1A6+QaCybrY1ShO10YbE7n4wvRjGzL5KxzZqi0BlgHf5JvZOJ4mx1TIplCdAWByG9esDEa5HcJK4+eFTc13eJQFMfUbfhK0pKPGwTl3b0sZRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499498; c=relaxed/simple;
	bh=aw1/HfkSBdh3WSDCAWFHn8dEEtZI74TQMpw/dEhww/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GMDUdNJVvENlsfpVU37wBbVUEcEkj//Bx+pPEjGrevrb1La+IcYC5SOI5x/yDprAdCuy25pA844e80srNbCq4d2+x9ZBD38cOd5tYWtTV0a0MCKJ4q8FbPeIcfUukbUa0hH8LET8hwOkbWRklBXlOwJ1wPZL10/vfyn5aWXv+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PMmIkIhW; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723499494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=emftv3NAPMFtQJGOiajAqRPblL8P/mZGsVYvU9uyAIc=;
	b=PMmIkIhWWDdi4zDKw42HWl029qyE0wIogAoj/bzplbR9loRk+VG4HuEfci/WSm5hjrWnlC
	ru008TPonpEEmPg7WDxNy64Q/kMnqPki9KvoatKb1bNhYTvYJVb/RD3iFUTJBHvdVD5mN+
	Ibpf/z44xno1GQl4dyEJFlhiTDsoxtM=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 0/3] arm64: zynqmp: Add thermal zones
Date: Mon, 12 Aug 2024 17:51:25 -0400
Message-Id: <20240812215129.3599832-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

At the moment, the ZynqMP Analog Monitoring System (AMS) is only used
sporadically. As it is built into the SoC and doesn't depend on external
hardware, it can be exposed to userspace for all boards. Additionally,
we can use it to implement thermal zones.


Sean Anderson (3):
  arm64: zynqmp: Enable AMS for all boards
  arm64: zynqmp: Expose AMS to userspace as HWMON
  arm64: zynqmp: Add thermal zones

 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    |  18 ----
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |   4 -
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |   4 -
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |   4 -
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |   4 -
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 101 +++++++++++++++++-
 6 files changed, 100 insertions(+), 35 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


