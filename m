Return-Path: <linux-kernel+bounces-198649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABBC8D7BAF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D15B21613
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299622C859;
	Mon,  3 Jun 2024 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="ELqibcfm"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA892942A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396734; cv=none; b=oNBPHdIpOeFpkeOJM/zH2BP6EJ4qBN8Nd+2e5Y171nuXVfwCnwe4AQKkAkrH/hjGInzn1UVBEfBxMT1BlvfX/3NBbUYH0r7muV+kH09Rg9UDOcy5GFu5pJnWq9gIVjv+zzyzl0FtITACmqFsECKQatm6NHzN1A7dyzxXKAILN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396734; c=relaxed/simple;
	bh=yibBB4lOxd9vur4SNzElTohzttt2uGk9m3X60fKMBOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkjNTXjuBn/GeEjZk4ZgpFw+F5Nkjaw5xroAjKFzX1zdbystzg7xaBz0sg+RBUaqtUJVGJvpdm7oELANmlHQ1mPEU5yT89uT+8XQRseA23UwWrAN9P5GsnNveyWHvQeeWsE5KDcSbXcYWUc62YaIn5R6EXkAyC3Qrb0MV1TkwTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=ELqibcfm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Vt3w843L9z9sjN;
	Mon,  3 Jun 2024 08:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717396728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5oSTVWW+H1Kox75DhQW50O5IADS4+f1wVfp/EM0Cd5Q=;
	b=ELqibcfmUUMwKNXGnPXIjv4XG443YVpasOMeWUyq0b5jYyVlDtpzF0P8xGhKVgUB0yttLi
	dur7rsI42KOx7pLNWwLp/MtE9806W+HUGXDSq2O4PK7onuFQ8Cba/KKhShSGVDnXYijx8B
	CulpmeSWEo1Vz9NFSCJ5x3EKchm1lBWfncKd4l7LE0ZsJxfvUuys376w0vI4lFRW6kOZoU
	/hJzu7a4TeCPEJKRR33Vjn+Gd6XofH93JWHSEA7F2s7dC9JP8VDaEYbyCyjAW/zEtgS46a
	lO5cSazTfOLXBZ+NpChflWmtCvtwy3I2FBdNQGt3ZLM6ndqMXGMfwPRrEFJPwg==
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
Subject: [PATCH v2 0/5] platform/chrome: Fix MEC concurrency problems for Framework Laptop
Date: Mon,  3 Jun 2024 07:38:29 +0100
Message-ID: <20240603063834.5580-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vt3w843L9z9sjN

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

Changes in v2:

  * Put ACPI id in a quirk, not the acpi_match_table.
  * Add return code check for mutex unlock.
  * Remove "in_range" check which belongs in a separate patch.
  * Use "ret" not "sum" variable (same value but clearer).
  * Remove excessive error logging.
  * Rebase to latest ChromeOS for-next branch.

Ben Walsh (5):
  platform/chrome: cros_ec_lpc: MEC access can return error code
  platform/chrome: cros_ec_lpc: MEC access can use an AML mutex
  platform/chrome: cros_ec_lpc: Add a new quirk for ACPI id
  platform/chrome: cros_ec_lpc: Add a new quirk for AML mutex
  platform/chrome: cros_ec_lpc: Add quirks for Framework Laptop

 drivers/platform/chrome/cros_ec_lpc.c      | 210 +++++++++++++++------
 drivers/platform/chrome/cros_ec_lpc_mec.c  |  87 ++++++++-
 drivers/platform/chrome/cros_ec_lpc_mec.h  |  18 +-
 drivers/platform/chrome/wilco_ec/mailbox.c |  22 ++-
 4 files changed, 264 insertions(+), 73 deletions(-)


base-commit: bc3e45258096f2ea2116302abefde4b1cb9bc3c1
-- 
2.45.1


