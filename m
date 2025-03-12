Return-Path: <linux-kernel+bounces-557719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77294A5DCD8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B507174C90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E16B24339C;
	Wed, 12 Mar 2025 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b="FC72MKj2"
Received: from mail.mixaill.net (mail.mixaill.net [144.76.234.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D924293D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.234.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783210; cv=none; b=PDXWgM51nkL7qH3ZuQT8Zw6yRzYnCoAesZE2Ofp8gwT1UdSM6RX0m8Y0/BB/fkDhOODK0R7xQLqU+8b9Xfn5NYZ3FEAGDPKwuHFY5VFZqFK5AtlPCbvRXnLdgMh5R3fCGhI2UIvC6FdHJOgL2udyIkTXYjj0guiJRg9UAoNodi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783210; c=relaxed/simple;
	bh=8p3wmtvaxpnaXmTnFpm3OTYjLw0zDBsKg9fMzhaO27A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mq5NJgCDYX5p9gKUmUCx5YGXpYvgTl90/aha2c4IOn4+CZlLHEJP2yJlN3ENs8Tii98Xd2x0AX9f1sIhVshFsMy0DKu3lvvTU/Qpsg1VfJFk4AxsxmAqnlrIsBcdAojKSdHThhScJ6RuNT8GCAs3wIOHTTw8BnbqjaRcOKjBsCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net; spf=pass smtp.mailfrom=mixaill.net; dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b=FC72MKj2; arc=none smtp.client-ip=144.76.234.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mixaill.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 481D161630;
	Wed, 12 Mar 2025 12:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mixaill.net; s=dkim;
	t=1741782739; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=fKiS7lKcy8uLNsvd0XZ9yLjcg8QrtSx5yuZNndO+ZrA=;
	b=FC72MKj22sFMpGd2RWIROysi2Zbl/EZJw9qeOy/jJ7ycJWZenr8YkVpKT5eNBju5CgNBvn
	h5yNk0uUzSUy8pk5KAygRgnuXQygK/C+bNZFDIdWIzfOVJoHCsQ854aZNN3Fc7iA8YYZIP
	n+F4LQHSkcQm0+iqhrM+puISWNBCosCsagnOtNe1itcfilYfOG3+49JzBxZ8FgWvKeu/Vc
	OgUTMWAVKkrz1Nir/O4wKVUjGdf+Kt3SnNOK2bOcN4b2k0rCJZG2XZ9ik/YwGoC4uMp65Y
	TZ1vCFSAXUMqcShVMbAxMNjKPrWVGA+ddfKb39ZDXouuuVLJzClM6RzPSY8avQ==
From: Mikhail Paulyshka <me@mixaill.net>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Paulyshka <me@mixaill.net>
Subject: [PATCH 0/2] x86/rdrand: implement sanity check for RDSEED
Date: Wed, 12 Mar 2025 15:31:28 +0300
Message-ID: <20250312123130.8290-1-me@mixaill.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On the AMD Cyan Skillfish (Family 0x17 Model 0x47 Stepping 0x0), which 
is a Zen2-based APU found on the AMD BC-250 board, there is a situation 
where RDRAND works fine, but RDSEED generates FF. This leads to some 
applications that use RDSEED to generate random numbers (such as 
Qt and KDE) into a nearly unusable state.

Although AMD has fixed the Zen2 RDRAND issues in 2019 with a microcode update, 
no such update has been released for the Family 0x17 Model 0x47 core.

This patchset introduces an separate sanity check for RDSEED and hides the
RDSEED and RDRAND from CPUID on AMD platforms in the case of a malfunction.

Mikhail Paulyshka (2):
  x86/rdrand: implement sanity check for RDSEED
  x86/rdrand: hide RDRAND and RDSEED from CPUID in case of a malfunction

 arch/x86/include/asm/archrandom.h      |  1 +
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/common.c           |  1 +
 arch/x86/kernel/cpu/rdrand.c           | 48 ++++++++++++++++++++++++--
 tools/arch/x86/include/asm/msr-index.h |  1 +
 5 files changed, 49 insertions(+), 3 deletions(-)

-- 
2.48.1


