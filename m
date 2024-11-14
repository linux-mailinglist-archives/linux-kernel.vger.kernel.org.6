Return-Path: <linux-kernel+bounces-409412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF19C8C74
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C467B35BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CED2C859;
	Thu, 14 Nov 2024 14:00:50 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0B29429
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592850; cv=none; b=gCDVmsha3IZAaNRRjxJpZTgz7Qw5m5tLYF4APjabGGmibdZ71wNkE2s8W3BoNeTJATGAVNQpAJY9UL1vcHwANdKbDX+YvrzhA/wUhR1fEfpJLkSmrroHpijKs+kzFGqqgdE/LOnFvP1GdrUIKNE0FbKLuPB+H5pVzHvaEdkSeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592850; c=relaxed/simple;
	bh=fBExKkfXjIOLlZH6DejtfOKoFw4BgWgmxhVwPFcEdBA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fjDtRNtNBwOiHKBNHr0Wmv1zU0kfGmSwgU1q8Hx5JfjAiXLw78/EF9KXc0w22GClM/V5O7Optun/xoPdD5zNc3OKgX4u+BcXmKCu7sYfm4XIN842HmTC1sBreQl93b6e8HWV0Zvsrcm3NQomy6Ml+hZmz5nTTfDDpRENAdZ+Z9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 4AEE0WtL034856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Thu, 14 Nov 2024 22:00:32 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 22:00:32 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <alexandre.belloni@bootlin.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tim609@andestech.com>
Subject: [PATCH V4 RESEND 0/3] rtc: atcrtc100: Add Andes ATCRTC100 RTC driver
Date: Thu, 14 Nov 2024 22:00:20 +0800
Message-ID: <20241114140023.3534980-1-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 4AEE0WtL034856

The Andes ATCRTC100 module includes a real time counter with alarm.
Add a RTC driver for this module.

CL Wang (3):
  rtc: atcrtc100: Add ATCRTC100 RTC driver
  dt-bindings: rtc: Add support for ATCRTC100 RTC
  MAINTAINERS: Add entry for ATCRTC100 RTC driver

 .../bindings/rtc/andestech,atcrtc100.yaml     |  43 ++
 MAINTAINERS                                   |   6 +
 drivers/rtc/Kconfig                           |  15 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-atcrtc100.c                   | 524 ++++++++++++++++++
 5 files changed, 589 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/andestech,atcrtc100.yaml
 create mode 100644 drivers/rtc/rtc-atcrtc100.c

-- 
2.34.1


