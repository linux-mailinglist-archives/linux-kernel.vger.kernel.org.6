Return-Path: <linux-kernel+bounces-361796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C976099AD25
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F6F1F22A79
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828131CFEB8;
	Fri, 11 Oct 2024 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="A5iIIX2X"
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1D1D0DE2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676569; cv=none; b=M0/UknN5dshHJVM3W1T5q6n0ce/JDPZHGBIxFS9t7bWkuGpmu60sYus4EVg7MYo8E0y3DSmzpH/ZWn0bwqZ2wMDw/UcvLkCjuWoFd1+V0PmXdqYbtrmR8OkAhtDaIXlwW1je9cZlJlQb3WoRnyPVITXg8rdY6AF7UL2HzQddIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676569; c=relaxed/simple;
	bh=mx3sMMxKGe2xb8OFf8LL91dLob2tabSj+zDPejpG1zs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Li/shPjk9WVtlJDtn5cx4RxpqUgt/gb5ZZipl7L5kjZc5ydBizyDQbjqbwOOX4JhdpgdKck+L1vliln8Bs6Mgmrud3AM8iokHM3F+kAF/YmTTYCW/4MSUplu8hAhOV9aUzAKepz1SZky5sGxSsZw7juZVeGB/5RBSY3DfzMYlco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=A5iIIX2X; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jn50dfSRnUNaN22Rf+Z+uGO+Hea50Pj/Ovl77pGLsrI=; b=A5iIIX2XBy+aTtHejKPdealxYB
	fJM6izvIuaQcS3FTTM1PRyH5COneqWcY9iDZEh2x0gR19fIdmAftgr73lo/Tm+4XKZFZlgaea78CW
	VIDyDU7MDYiNKRPEN+Thp5NVl6IWDCRCQEW3wuo3Hb4gLzRsfy1OaD2o7qapNiH80OVQ=;
Received: from [88.117.56.173] (helo=hornet.engleder.at)
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szL4O-0000000039T-13wz;
	Fri, 11 Oct 2024 21:13:00 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH v2 0/8] misc: keba: Add support for additional devices
Date: Fri, 11 Oct 2024 21:12:49 +0200
Message-Id: <20241011191257.19702-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Add SPI controller auxiliary device. The SPI controller driver is not
part of this series, because it should target spi-next and not
char-misc. Additionally a driver for the LAN9252 chip, which is
connected to the SPI controller, is included. This driver only
configures the LAN9252 chip in the right mode and provides no user space
interface.

The main EEPROM of the CP500 devices is divided into two sections by
design/factory. Therefore, provide the two section as separate NVMEM
devices.

Add fan, battery and UART auxiliary devices. Similar to the SPI
controller, this is some prepartion work, because the drivers will
target other branches than char-misc.

The series starts with two small cleanups.

v2:
- separate commits for clean up (Greg KH)
- uninitialized warning in lan9252_probe() for variable ret (kernel test robot)

Gerhard Engleder (8):
  misc: keba: Use variable ret for return values
  misc: keba: Use capital letters for I2C error message
  misc: keba: Add SPI controller device
  misc: keba: Add LAN9252 driver
  misc: keba: Support EEPROM sections as separate devices
  misc: keba: Add fan device
  misc: keba: Add battery device
  misc: keba: Add UART devices

 drivers/misc/keba/Kconfig   |  11 +
 drivers/misc/keba/Makefile  |   1 +
 drivers/misc/keba/cp500.c   | 558 ++++++++++++++++++++++++++++++++++--
 drivers/misc/keba/lan9252.c | 359 +++++++++++++++++++++++
 include/linux/misc/keba.h   |  47 +++
 5 files changed, 955 insertions(+), 21 deletions(-)
 create mode 100644 drivers/misc/keba/lan9252.c

-- 
2.39.2


