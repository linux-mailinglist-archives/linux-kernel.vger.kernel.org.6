Return-Path: <linux-kernel+bounces-175328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8301C8C1E17
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371962829EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4693161319;
	Fri, 10 May 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LZmENFvc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PR7hUigL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D0153BE2
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322536; cv=none; b=NZi/XA+ETUy/0+qkmKEgix//jXos7KFAkypJkQQKswWYnZWPeVGJTFbIhVJsmbScGUp3XzRJ55pOWpin2yrA9FqIZJjqyl0jt9txHYDBXllKHO2bF7JetMhoQ8/Bo+ODswYAKRwTxIr+72yCwLvl8vUSwRiQ+O19lC49RK+nF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322536; c=relaxed/simple;
	bh=jvk7b0LQDo86RhaoPKvODKD7tH5jMXWL2BeqHj+GO3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nss45YE35XpVYzyFnWIFzzPIvQkxgtJmVZSuGnG6m3f0WXtMv0ABQs7HPCWtxrzqVZi2R1+dP3uHAaKUb+uoAAko0myUH9gOaG9raaf8avBbmoN3fHtcGEIAlbVHmj4IXurhpMOmS/+s4t8IGQMnTTeON4m0yn7IATXmRGr8PHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LZmENFvc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PR7hUigL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1sssw5A/ygmjEBxrlSd+7ue0RV3n8+xaY+HzQNbRFGM=;
	b=LZmENFvc4euk2x3YKMDS4vZQ6njaWRRmcZhRv6mhgQDO9hm76yMnLcLAclJllAXzEWI+R8
	DjMXMIQbAuNWUQU6RCme2fe+8LD7SJDor0843GvNcpMwBb9sA10gR33A6RNLBltUFyLQlt
	lKjiK2m6Ogj39GjYZoyhpfijSF4dbf+9rLTNVsC7in6cDBJABquEZBCCWiUZ32OUd6qtHo
	k53H64a5hACVKj3W1eCC8TxXG5DPJVaWvnDRArrrvRJi2mOC8JhxiaUGRLmDCAtk2/P/nd
	zz7c/qo+lPNtYH4bWk6rEBoDWA/SU1RAdM6Mn4T6/KIspEl0mCl5JP29Ao7/tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1sssw5A/ygmjEBxrlSd+7ue0RV3n8+xaY+HzQNbRFGM=;
	b=PR7hUigLr/KX3+deEvAwKob4CebeKY++2BeuPPXpRSX1LmYFaGaHGKwQ9QYnLsI910absd
	h8W+VHwpLEyX2eBg==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/7] remove size limit on XIP kernel
Date: Fri, 10 May 2024 08:28:38 +0200
Message-Id: <cover.1715286093.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

For XIP kernel, the writable data section is always at offset specified in
XIP_OFFSET, which is hard-coded to 32MB.

Unfortunately, this means the read-only section (placed before the
writable section) is restricted in size. This causes build failure if the
kernel gets too large.

This series remove the use of XIP_OFFSET one by one, then remove this
macro entirely at the end, with the goal of lifting this size restriction.

Also some cleanup and documentation along the way.

This series depends on
    https://lore.kernel.org/linux-riscv/20240508191917.2892064-1-namcao@linutronix.de/
to apply cleanly, and also depends on
    https://lore.kernel.org/linux-riscv/20240508173116.2866192-1-namcao@linutronix.de/
which fixes a boot issue.

Best regards,
Nam

Nam Cao (7):
  riscv: cleanup XIP_FIXUP macro
  riscv: replace va_kernel_pa_offset with va_kernel_data_pa_offset on
    XIP
  riscv: drop the use of XIP_OFFSET in XIP_FIXUP_OFFSET
  riscv: drop the use of XIP_OFFSET in XIP_FIXUP_FLASH_OFFSET
  riscv: drop the use of XIP_OFFSET in kernel_mapping_va_to_pa()
  riscv: drop the use of XIP_OFFSET in create_kernel_page_table()
  riscv: remove limit on the size of read-only section for XIP kernel

 arch/riscv/include/asm/page.h       | 25 ++++++++++++++++++------
 arch/riscv/include/asm/pgtable.h    | 18 +++++++----------
 arch/riscv/include/asm/xip_fixup.h  | 30 +++++++++++++++++++++++------
 arch/riscv/kernel/vmlinux-xip.lds.S |  4 ++--
 arch/riscv/mm/init.c                | 11 +++++++----
 5 files changed, 59 insertions(+), 29 deletions(-)

-- 
2.39.2


