Return-Path: <linux-kernel+bounces-179475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314D08C604C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C461C1F21BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34903B7AC;
	Wed, 15 May 2024 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o/bOdpdC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lYMY5V7K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D03A1CA
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752252; cv=none; b=YsfONrFap37dYjLMAgOQ0kpVJJKgIVvdfGsQevhiCRqjrohONSKtQkFMVn0j2mWITO8xdFc/8aIBf4XDsQ/J4bkG9TbVrRk+eVNBYrlrMIHaMPKLnKgwqCLfA7D4W14YTJv9uDxQZQ0IqN9tedkbO2p0grl46e+nGahjze5EcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752252; c=relaxed/simple;
	bh=bAhNtYpeytHIayczbtI9m47isJ2hviPgeSm8Ha+G1DA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qaaEr8SRVm/p3VQTeSFBKrJv9voWnoe7q0KkfBinFOjrBFkS/kJKMtJPMzpmmZMpmVG3Rfq6olAqOznO/FmRMpV861KqClvkn+Ounlh0Qd3ANjdE8pDwCp5ZuuEYfxmmT0HSz0z9bv00zsdobCo56IxmBB9gUoHlMTjYBMzaFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o/bOdpdC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lYMY5V7K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715752248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p2pxGrHqcjpgn9i44FUKrB0I06kYBSdcJdo4aSs08Lg=;
	b=o/bOdpdCDquB2BlFy1SOm8ptdjQk1Wy0EJxJU10EVxhf/3zddi8KYBjen+BJft7tspUzz+
	3TXyQ1tD9gIdLSxQWq5yLiLaHxmW6Gfbik5S8LjQ2d+4SEr+EoYJBRWsTx3oM3kAQOFtzU
	/NajR4h76N+T2SM0/I4Y5CAQhDSRus+mpiKRxsA5UQ8zq617yWUJEfktC/XkfLoqq6vJtX
	VV+YF6ooh4gYzOwEqbhpubpYIJP1D6rn4Ih+LAC1xsh9PA+UNwVOGWaJe8C7iLEvOZInMy
	EjvzsNY4KDpcVCenBLH1JTJO+zkaSD30UYlf5xeF0Ptejdhr0m3kiE21tl3P0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715752248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p2pxGrHqcjpgn9i44FUKrB0I06kYBSdcJdo4aSs08Lg=;
	b=lYMY5V7KUQISQ2HASD43vvZqJJHHtRBbloeGv92BmKsbcn9ty5ajUkzdhTFvsbAQojHY+e
	JlbaGrUKwJH2R3Dg==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] riscv: fix debug_pagealloc
Date: Wed, 15 May 2024 07:50:38 +0200
Message-Id: <cover.1715750938.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debug_pagealloc feature is not functional on RISCV. With this feature
enabled (CONFIG_DEBUG_PAGEALLOC=y and debug_pagealloc=on), kernel crashes
early during boot.

QEMU command that can reproduce this problem:
   qemu-system-riscv64 -machine virt \
   -kernel Image \
   -append "console=ttyS0 root=/dev/vda debug_pagealloc=on" \
   -nographic \
   -drive "file=root.img,format=raw,id=hd0" \
   -device virtio-blk-device,drive=hd0 \
   -m 4G \

This series makes debug_pagealloc functional.

Nam Cao (2):
  riscv: force PAGE_SIZE linear mapping if debug_pagealloc is enabled
  riscv: rewrite __kernel_map_pages() to fix sleeping in invalid context

 arch/riscv/mm/init.c     |  3 +++
 arch/riscv/mm/pageattr.c | 28 ++++++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.39.2


