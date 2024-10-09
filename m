Return-Path: <linux-kernel+bounces-357872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D95E997738
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC07281F5F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A19D1A3BC3;
	Wed,  9 Oct 2024 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="iNUpTRvZ"
Received: from mx08lb.world4you.com (mx08lb.world4you.com [81.19.149.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29040849
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507837; cv=none; b=ZUcidMcVJXADCyGaDlr0+Ixe02zx7NlR9C3lUiucd10WxtlCHr0OMczoiU/w/1kF7hYNR2WzBK1/9GVUKRM/52yq7ZSaL8iI+2/ejN2sHo5N5ranV63QK2yz+FdOVUfhTigTuG4CkXA+ju/X09SQzjG+MAfQW1OU8Wi1gsUiwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507837; c=relaxed/simple;
	bh=ZvVAZAl0Hs/mscWVL+DqzHFLDvmBKU0UGtAtp4y2ffE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uv8gZKqKsiKvjRP79CESffbdHdRGuUG+k0kROSMGzNiJ8rKFCYXgPoZ4P2l3zHDuZzZHTl1xF9loBtsdNjZSyBDiMf660S6CqoW3YmMGV6hbsT1xxc7j5eiHVajdoqJgB3jTTNISZ0Y836OByoiyqiu1hP9AaUgorEydfbhZO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=iNUpTRvZ; arc=none smtp.client-ip=81.19.149.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aihq3F19y15p1nk01UYVKmcSN4f0WNH1LN2I0R+s2zk=; b=iNUpTRvZgcZVoWm5qxz14uRPJy
	HiWK1f/xUbVMKngpfpNWTzNzlna0439lrTr27eA9cur0pbkztRLTKNkXth4zXSXXaUiOBUjNhFCkl
	5ZbTICY9idDL/dZRuzssqDEXOobS0ZwxHYeZmrTmfcw7JJ4POxSOB0ozbsH2cH+Zi6/I=;
Received: from [88.117.56.173] (helo=hornet.engleder.at)
	by mx08lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1sydJm-000000002pc-0FTN;
	Wed, 09 Oct 2024 22:29:58 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH 0/6] misc: keba: Add support for additional devices
Date: Wed,  9 Oct 2024 22:29:43 +0200
Message-Id: <20241009202949.20164-1-gerhard@engleder-embedded.com>
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

Gerhard Engleder (6):
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


