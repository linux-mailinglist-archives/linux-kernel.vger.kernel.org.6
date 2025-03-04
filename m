Return-Path: <linux-kernel+bounces-543081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C98EA4D13F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4118A3AD967
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBF41494DB;
	Tue,  4 Mar 2025 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qHoI4P66"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098F86328
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053195; cv=none; b=lYNOIYpugwSwFYSWBvQ6haQ6rzJDKWS+x7Kk/Js89yXha+ArLCKB33G7BhTEPOw2tGMHDwLv0R2l2Fl1NzAZ9pYLtdyhsEDv+AbtFnMm9obVDiy7bvqB3I7eiyAbN/x84qj+iwSk/m5N0ZF4vG9r/Hc2xKn3P4mxjlmwCeTe82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053195; c=relaxed/simple;
	bh=/ZguSDY3nlHQc3sfkxqyJohvWfUs1zsj8ApDONhyQig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epMZvV9meI/XXVcZyuXKP1pKMNI+pDZCMnsNYkfaFy0ZtVb05zypEoYLmu9oAUlIhwss2ygifG0P+fkdJsS3NYxdcidz8mGBfhmURzxRNfDtfzdUdPL9Q4IezBkzUN8aYU8D/n7wBVUoREDwfQJ7D+keNX9VBQyWKB6K/VjdVD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=qHoI4P66; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 94E672C09DD;
	Tue,  4 Mar 2025 14:53:02 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1741053182;
	bh=9cVdqmAxnsQrsbWJCU2FebU0qpancQ5/MUf6RxqYKME=;
	h=From:To:Cc:Subject:Date:From;
	b=qHoI4P66Z88aeUL5NkPgJDeYObGy35oRS5udDiOQY0s1ut8rA+/96rwnQuG+EiYd9
	 ySavj6+emKOQXt6Q/p4Xjo6vCsu85dY4q3D6CePeKR3wwghCeN3Y04/Je5hAwzU6M8
	 F9bdBa5X6qTPadSveU2BggJg7spFuWgjtdKCKcUaoGdii0ACRAjoQDQqGOG14TCoLl
	 6/oRnxKBCVGkldBvI/1fzuU3pwlj4kdukVXl54FkZVsnvdVeSBG4kAMAYN3PVTXtL/
	 85Mm4HE4EEccNorm3DXjyZVt1VK92+nK7J/f439cSLZL+eDXnP3lG5F1u+wnwibAZa
	 7w+ushQob2u5Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67c65cfe0000>; Tue, 04 Mar 2025 14:53:02 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 691E013EE4B;
	Tue,  4 Mar 2025 14:53:02 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 68E002803F8; Tue,  4 Mar 2025 14:53:02 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sander@svanheule.net,
	markus.stockhausen@gmx.de
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [RESEND PATCH net-next v8 0/1] RTL9300 MDIO driver
Date: Tue,  4 Mar 2025 14:52:57 +1300
Message-ID: <20250304015258.386485-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ccpxrWDM c=1 sm=1 tr=0 ts=67c65cfe a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=Vs1iUdzkB0EA:10 a=H2aqgZpJBgBZoEMRn60A:9 a=3ZKOabzyN94A:10 a=zZCYzV9kfG8A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

This series adds a driver for the MDIO controller on the RTL9300 family
of devices. The controller is a little unique in that we can't access the=
 SMI
interfaces directly. This means we need to use the hardware description f=
rom
the DTS to compute a mapping of switch port to mdio bus/address.

The dt-bindings have been applied to net-next.

I've dropped the linux-mips patches at Jakub's request so this can go int=
o
net-next indpendently.

Chris Packham (1):
  net: mdio: Add RTL9300 MDIO driver

 drivers/net/mdio/Kconfig                |   7 +
 drivers/net/mdio/Makefile               |   1 +
 drivers/net/mdio/mdio-realtek-rtl9300.c | 475 ++++++++++++++++++++++++
 4 files changed, 516 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-realtek-rtl9300.c

--=20
2.48.1


