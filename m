Return-Path: <linux-kernel+bounces-537260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 496C3A489C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4879A7A7F80
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2A271281;
	Thu, 27 Feb 2025 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ulKFegk0"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD7270EA2;
	Thu, 27 Feb 2025 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687759; cv=none; b=PtHzyxajgNCm8i4Z4QNQJ/kHfkWZUdGDlvBIr+Ee6HJkDKgj33fEv7n7+XXJd0x1qsYGu6g/SVW+hDb1elwuFYZcuykmhkDx3rkxagoaw6jXhMtS/vPbXt8vZWIKmf5b6HrS64KjgU5YLGZsTDSte3hLO8YR+XbyqApJmBX+aT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687759; c=relaxed/simple;
	bh=00EyoF7vLNdQs2Bueq0tXZ0zNlhxqmJVVGmT+wmYoog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VkWus7kEFMJsF0LZHXpAmXQrc+sRf14HKIblW6v/xbR8KCeL7K0OgURm92yjWjHtsCwdRGk+OIdT4HwhHP7hLU6yRT4lQ7KRi1voNzLTfnJpO7z8vVnSLPmtt0ekOTE8xUafddqd14XMd/y8qfDL6Ss5MsNRp7FaTafHkvtuNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ulKFegk0; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51RKMA8T1857064
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 14:22:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740687730;
	bh=GM37aq73FdzPHGYyhr84uUQgWksltpyBB1YERc+sLzU=;
	h=From:To:CC:Subject:Date;
	b=ulKFegk0lCBSojZvYYHxSldD/Ny8gqnpZCSAZsrnZjgfoUJsWJ9Weg0VDAS6b5QXO
	 uhdYJKibZUEgrqNH0MY/UMMpFVG48MKB3v9xH6mjkwxglJAsmGACySpGVqvuukXqak
	 0TkHEW01zZyE3xutXwKjoc1Qo0JsiFnfIB63fAwo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51RKMAbR017795
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Feb 2025 14:22:10 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 14:22:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 14:22:09 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RKM9oD112735;
	Thu, 27 Feb 2025 14:22:09 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Peter Rosin
	<peda@axentia.se>,
        <tglx@linutronix.de>, <gregkh@linuxfoundation.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <c-vankar@ti.com>
Subject: [RFC PATCH 0/2] Extend mmio-mux driver to configure mux with
Date: Fri, 28 Feb 2025 01:52:04 +0530
Message-ID: <20250227202206.2551305-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series extends mmio-mux driver's capability to configure driver in
with extended property.

In current driver implementation, driver is parsing register's offset,
mask and value from two different device tree property which makes it
complex to specify a specific register or set of registers. Introducing
mux-reg-masks-states will make it easier to specify the same values for
particular register or set of registers.

This series is based on linux next tagged next-20250227.

Chintan Vankar (2):
  devicetree: bindings: mux: reg-mux: Update bindings for reg-mux for
    new property
  mux: mmio: Extend mmio-mux driver to configure mux with new DT
    property

 .../devicetree/bindings/mux/reg-mux.yaml      |  29 +++-
 drivers/mux/mmio.c                            | 148 +++++++++++++++---
 2 files changed, 149 insertions(+), 28 deletions(-)

-- 
2.34.1


