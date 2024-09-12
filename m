Return-Path: <linux-kernel+bounces-326664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37923976B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F330F287AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99F1AD257;
	Thu, 12 Sep 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="L/tJUptG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KTtKNDJY"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2F1D52B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149897; cv=none; b=O7/55g8ZsuLXwpbc88Zi3gtXJToVjtQDc7BMLSh6NL0c0WgOaMYtGd5GYXNa3XfXSrsnaa4KoXKU3mILJOj8Of2TAqvuY1QTTvyT6yGqB5F8l1daVyW4bIyhfNUYkP8uPFk2zeSYo5fFNCO8xpQ4eYW4r1dsG36e+GFKeG46h2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149897; c=relaxed/simple;
	bh=8NRqnxAgcU+lTuaGzIZNW8DkOTwwZf1Z5J9up86rQB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XGWvkfQ1m49spgRL5g89CvEN64xlPqxNCT+KxQibh0x4YBQXxBaWOy7sj19eNlso1cd7sjE8QRbhzBHLYR0ILPMbnhK/xTFgFR4gW3acUlZKZO60MF0IDq/613guIxFOn96tcAUzp3YnCfh0rJ7ILYgZ/GYH/U962EfQzLDtZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=L/tJUptG; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KTtKNDJY reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726149893; x=1757685893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2ZWthQzZ9hRO9cPTmZym6gNG892ZdcTRooa6vJ3UqT4=;
  b=L/tJUptGDUrZLWWKRj3eyIg/toqbg8QGOAp+3ZgMCrTsNoTjP/Sm6UVN
   NVZ2BlqJkAjt7EUMK+rbrzoj/bhE3v1v/GWCy46JPexpctU9seRAY8MGC
   Uv9L1eTF77J+tKU7r0ADpHmt4uF1wSpnjcCQczq11DTes3sFPsnu16PxU
   hQN63kFHqY6MZ8D0g23VSZGu+JvOQw8gQlSOyChxz4Xhhsr+DFWeNPvV1
   +3gt6kMVWEqWXzhys4QfgAr7bPIX21/6PeB91rdzWLF0O9LV8zdg5ICxE
   OejZm8C5Lgjn3Hi4unHsHpa09gHCqHAoPZLj5U3YFRevslGm9VsechoeQ
   Q==;
X-CSE-ConnectionGUID: 9u7sm4eUQYC2zTD0qKztSg==
X-CSE-MsgGUID: SeC/3FQ0RcaIdZhztOXf0g==
X-IronPort-AV: E=Sophos;i="6.10,223,1719871200"; 
   d="scan'208";a="38915412"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Sep 2024 16:04:45 +0200
X-CheckPoint: {66E2F4FD-A-5FF8EC80-F6CEE9F8}
X-MAIL-CPID: 54349E444A2433D7591725AFC8DDCD4C_0
X-Control-Analysis: str=0001.0A782F1C.66E2F4FD.007D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99514160A99;
	Thu, 12 Sep 2024 16:04:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726149880;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2ZWthQzZ9hRO9cPTmZym6gNG892ZdcTRooa6vJ3UqT4=;
	b=KTtKNDJYHu9bQb6okUYY31r5ldQ3o+PI1cFFKYCoYvmwAUV3S70+oSqsYU+FaOCGbUp/kW
	nVnAhfWm6cPr7nPz1XuZ6ht21QIJrU9XGC6k8yeAtNr9LaJapmh7VrY1mUV4FuJdNnQR6d
	G2T469hI2/GS2zojlhfP98wlQ0FpiQQbwCGin3xZm1vpGD0MR+q4KIkOXGBQQRGWPd7A+a
	6BIVlFLRlJNVBsyTkR6XPSWSgwZV/W42rcrdSX1iV+Mt9mpooN2bzSg7ctnpArHtZg54wO
	o3P7Yufvb8WfeFY5HJoyp/p6XStVI2Z2XVNo6C/cka7RgVLI7vSLwtgkVC8rtA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 0/5] mfd: tqmx86: new hardware and GPIO/I2C IRQ improvements/additions
Date: Thu, 12 Sep 2024 16:04:07 +0200
Message-ID: <cover.1726148801.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Patch 1 adds support for 3 new TQMx86 COMs. GPIO support on SMARC
modules is currently limited (not all GPIOs can be controlled, pins use
incorrect default directions, IRQ configuration is handled incorrectly),
however this is a preexisting issue also effecting the TQMxE39S and
TQMxE40S, not only the new TQMxE41S. This will be addressed by a future
patch series involving both the TQMx86 MFD and GPIO drivers.

Patches 2-5 improve module parameter description and error handling of
GPIO IRQ configuration and add support for configuring an IRQ for the
TQMx86's OpenCores I2C controller in the same way.

Changelog:

v2: improve module parameter description (new patch 2, adjusted patch 5)
v3: replace IRQ 0 resource entries with empty placeholders to simplify
    error handling (patches 4 and 5)

Gregor Herburger (1):
  mfd: tqmx86: add I2C IRQ support

Matthias Schiffer (4):
  mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and
    TQMxE41S
  mfd: tqmx86: improve gpio_irq module parameter description
  mfd: tqmx86: refactor GPIO IRQ setup
  mfd: tqmx86: make IRQ setup errors non-fatal

 drivers/mfd/tqmx86.c | 122 +++++++++++++++++++++++++++++--------------
 1 file changed, 83 insertions(+), 39 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

