Return-Path: <linux-kernel+bounces-179478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E078C6055
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A60B2127E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100653B290;
	Wed, 15 May 2024 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="IlnHUtuN"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B083838F
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752604; cv=none; b=H7UNEpY9iec4eeJn2dgSsptO7k7L5bYUJN0s39kZLvFLlAYaooF3Zj+QHQyUral7R67ZgvTF0/WR40k/jnGO8xU6rmvb6nKgGZZKE6NR5mOKeoCWoLQZNSxvZ3gcPfbUYSHmX8HsSwzIyNqPAWum6AWcj8vKqxF4+ljHyq2csNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752604; c=relaxed/simple;
	bh=9Hl91SIEd+s34idGW5CgOFE3Rr6Y6mx8V9dIfdZbL6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KnmEEg1kBlyxW/Ymei7vrkVacBu/a0eGW8SYg5N8RyxyZahpX4f6cvCk/WG2di6bravZfJLPPbUgCCvB4jWotSzI8hBXccRJzGkoGsMAJp610vaIYpL1STdMMVihfNwcc8wbMBrspgp+UZMM9G3oP8pQJgGIS5pQyoj5iLmHKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=IlnHUtuN; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VfMtC24D6z9sxM;
	Wed, 15 May 2024 07:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1715752595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SAAnJB39oETaobvjyNLVzZbiebH8e/Lpq7MQVzYIcpA=;
	b=IlnHUtuNMpAwt104OSGNFknvLXGajo744vCksNh5dSdEyJJ5Q7qTFMyN7iWK+foRs2g3xX
	wIWh4ikjMl8trMNoestn6Z3w8x4GPEDdsTVAhgtSTab2h1R5tsbgjmOgqXQB7yqOqRkja4
	XwiHUFArDF3wHJQbm2UJIWOE2Pj7SgQdy89UnMyj9BPPUSfZ3FRtArVj/yQ/JBakmyMzYy
	y/DOn/BEsWPCRr7zVREsV0bx0FTKD5TFwPFYf6P60NR00iRHZl4kRPXTm/meG5abQlSDov
	ik4PeuTXu/9Ck+idGyMU7GSrDiYhlePZsS3m0/Tvn7BeQH1LT5CLBTQLwJ/q+Q==
From: Ben Walsh <ben@jubnut.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	"Dustin L. Howett" <dustin@howett.net>,
	Kieran Levin <ktl@frame.work>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Ben Walsh <ben@jubnut.com>
Subject: [PATCH 0/6] Fix MEC concurrency problems for Framework Laptop
Date: Wed, 15 May 2024 06:56:25 +0100
Message-ID: <20240515055631.5775-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Framework Laptops with the Microchip EC have a problem where the EC
"stops working" after a while. Symptoms include the Fn key not
working, and "bad packet checksum" errors appearing in the system log.

The problem is caused by ACPI code which accesses the Microchip EC
(MEC) memory using the Microchip EMI protocol. It uses an AML mutex to
prevent concurrent access. But the cros_ec_lpc driver is not aware of
this mutex. The ACPI code and LPC driver both attempt to talk to the
EC at the same time, messing up communication with the EC.

The solution is to have the cros_ec_lpc_mec code find and use the AML
mutex. But to make it all work we have to do a few more things:

  * Allow the cros_ec_lpc_mec code to return error codes in case it
    can't lock the mutex.

  * Have the cros_ec_lpc code find the correct ACPI device (PNP0C09)
    and then the AML mutex itself.

  * Use the quirks mechanism to specify the AML mutex name.

The code has been tested on an 11th-generation Intel Framework Laptop
(with Microchip EC) and an AMD Framework Laptop (without Microchip
EC). It has _not_ been tested on any Chromebook devices.

Ben Walsh (6):
  platform/chrome: cros_ec_lpc: MEC access can return error code
  platform/chrome: cros_ec_lpc: MEC access can use an AML mutex
  platform/chrome: cros_ec_lpc: Pass driver_data in static variable
  platform/chrome: cros_ec_lpc: Add a new quirk for AML mutex
  platform/chrome: cros_ec_lpc: Correct ACPI name for Framework Laptop
  platform/chrome: cros_ec_lpc: Add AML mutex for Framework Laptop

 drivers/platform/chrome/cros_ec_lpc.c      | 232 ++++++++++++++-------
 drivers/platform/chrome/cros_ec_lpc_mec.c  |  89 +++++++-
 drivers/platform/chrome/cros_ec_lpc_mec.h  |  18 +-
 drivers/platform/chrome/wilco_ec/mailbox.c |  22 +-
 4 files changed, 272 insertions(+), 89 deletions(-)


base-commit: 2fbe479c0024e1c6b992184a799055e19932aa48
-- 
2.45.0


