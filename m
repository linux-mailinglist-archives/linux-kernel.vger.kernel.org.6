Return-Path: <linux-kernel+bounces-283261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB49C94EF47
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559901F224DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2017E46E;
	Mon, 12 Aug 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="nIwz4k7L";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TxdeIOwL"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3A17CA0A;
	Mon, 12 Aug 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472091; cv=none; b=HB/fVyB63Gk7sfa6AQ1CsCOE2FDvR7bl5JSp1ueQUeZXm3BHvH8CK4CUcuzZyPmE8XvcZC2BAPqsnmxMKWkoqM2dbnfCJ5T7hZSeGdsle6Vwv4FSx+UW4+nAv/0IBQERQSjvludQmqKWuxfX9e416FEXvUHTZBVmqkGQN77wntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472091; c=relaxed/simple;
	bh=Eo03XpHG4JjMF6MVNNFsrWZetjP/U/TwDfvhf6VCQ0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iWHuQWMs9xEE2KYO+FDd7ZUxmPxjW6F35OZvI/gJkJM7GIYxcUuh7TLNAE8DEyDKQsD01kGvG4M54GYtSyq+/mEAEb8yGN6hwJUNj3aCqHrUYAL/U2YGYWGyl6KE3kDOXFU3pbPxrAODN7EJHxNlb3aNWn+6ied7TDoB8gDdhaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=nIwz4k7L; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=TxdeIOwL reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723472087; x=1755008087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J7pblquAUvkPr2wiJ3RQohZqntz7DSfWBf0S2wbAQ/A=;
  b=nIwz4k7LRc+jnSwcYGHEStZG2WaUUOo2GAU+TjF3MhWLJuMIyu9CIu7f
   az3+cTftavRHxLVwTP6YJFvbHc9rZXdhC58gPf+pD+0aONzDtPva4RoIQ
   30t5fbuKTb0+EIldJGxz4pY+F28EgxToM2yri+kRrL7mLLHrHiWf0hLx8
   61Y+yjGA6nblfQLRelmeC6GoWniNsjuQQEESN/FFCCxTj7cq9cYAPwwZ4
   1e3cLVHt94DMtH76TzJOgrtw6a/NoHjWHHsiOaYuRXRV7APgvuQ7TZUUJ
   Zv2+ZjdsUN6SUp6apWozeB/mLb0rmX0jSs1IRpjRv9Jb8JSnq1Smt98TK
   w==;
X-CSE-ConnectionGUID: grz1XfrWTBSFP/uWm6GT7A==
X-CSE-MsgGUID: rh8dHD0aTp6Yvox2hP8j4A==
X-IronPort-AV: E=Sophos;i="6.09,283,1716242400"; 
   d="scan'208";a="38365457"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2024 16:14:44 +0200
X-CheckPoint: {66BA18D4-2B-82DA89EF-D38C983A}
X-MAIL-CPID: F628DFE928542C9A54B2CD547C2C3C48_5
X-Control-Analysis: str=0001.0A782F1C.66BA18D4.018D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2EDC160A8F;
	Mon, 12 Aug 2024 16:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723472080; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=J7pblquAUvkPr2wiJ3RQohZqntz7DSfWBf0S2wbAQ/A=;
	b=TxdeIOwLdgIjelL1mC3UCR934fyEMG9/Hg50J8h8BcqInFzapztZ6kO6udhIvCEe8OgBqw
	YSPSlGLFJUa/DaIJCqTJUyaj5ISUzm9bAYT2eI7yMh7zoTnAZWUsbe2smzhGY3MJqL8zvu
	UX08Z5ytbea0EIjrfruH8tdd/Gbp73t6CgRPM5aN8F5qyCYGNOc7uD14IRhzDBw48iPXhU
	7MecIgXoF6wqsbt49K/luWcbE1TKxCc65N31rso1r3BbGD19B2Uc+vsK5LOJlG7xbqm3PI
	+Iztj88+zdqSK91stonlsZkkSWB8siHc6eR/tpWn0Bammss8Xzqan3RzAzht3Q==
From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 0/2] TQMa7x / MBa7x DT improvements
Date: Mon, 12 Aug 2024 16:14:12 +0200
Message-Id: <20240812141414.96334-1-Markus.Niebel@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This series brings two improvements: supporting the i.MX7 ADC paired
with HWMON support and using a more specific compatible for the
mainboard temperature sensor.

Markus Niebel (2):
  arm: dts: imx7-mba7: add iio-hwmon support
  arm: dts: imx7-mba7: improve compatible for LM75 temp sensor

 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.34.1


