Return-Path: <linux-kernel+bounces-446057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAA69F1F58
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1002E166677
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 14:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E866918FC79;
	Sat, 14 Dec 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPVZbAN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B1946C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734186665; cv=none; b=HdKZwbGj8CdBw9u7XHxB7P8iEGM7DlhvEzQ5U04mXI+6iuBtMVFznJ5T0KiTbNfUjVjcTE4tgfjT5xSrtVS575Ls5KbfpVjrONcjUaCyC6oyOaNyztl69Vu9Ii+Wg67CSZOonwzSKejlUGFk1TL8sysPcIQD3JOnQ/I+/nnjFic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734186665; c=relaxed/simple;
	bh=CzrZn5L9YhOeV72hzspAP9gbjArVBFbBjsIn4pkcg1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iad6NBxihTQLZnxb5bOSBUuQ2mL5cfkrcjMnVH7C023nI6UI/eFs68X3NovijhEqIRR9RAfgREQO79rwg0kmMvudqbxua52tbl4JWI0PmA53hGUS3p5tklJAWtZoDC7+s/ev4y/3qy5kytNcIn3UwSEg/dw2038T/3rmZtJF6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPVZbAN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E75C4CED1;
	Sat, 14 Dec 2024 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734186664;
	bh=CzrZn5L9YhOeV72hzspAP9gbjArVBFbBjsIn4pkcg1I=;
	h=From:To:Cc:Subject:Date:From;
	b=bPVZbAN0NOxgjlPbF6Ixw4QRuh2sv7aJXCB667zU383IGBXj7o+1WI96jJJl+ZlUV
	 Ogpj1IXmspyPXmiCSm40rSSxvj3dyxBJF22l1st+knus7tItb7lDtopxoGCd3/1JA4
	 OdQTZUS9Gr1XoU3F0r9zkL1InHDKSSmVAPiOP/nFXH/DLhbauibRjq8Ax7g3kKulNa
	 Jc/isyTX7jesOIgtqVJTg8xcQr1FD3JRwWZV9e4syIUIETIR4RzX6+0akRoiVPiGAc
	 OLr/xU+eWc8SmKjMaAhhP6e8hIA+hU+Y9ZVzQoXHTQe+SDYnDWHTimaBADpKSE6iwn
	 2ipULs1Cb1StA==
From: guoren@kernel.org
To: guoren@kernel.org,
	conor@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	bjorn@rivosinc.com,
	leobras@redhat.com,
	corbet@lwn.net,
	peterlin@andestech.com,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 0/2] riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
Date: Sat, 14 Dec 2024 09:30:37 -0500
Message-Id: <20241214143039.4139398-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

The early version of T-Head C9xx cores has a store merge buffer
delay problem. The store merge buffer could improve the store queue
performance by merging multi-store requests, but when there are not
continued store requests, the prior single store request would be
waiting in the store queue for a long time. That would cause
significant problems for communication between multi-cores. This
problem was found on sg2042 & th1520 platforms with the qspinlock
lock torture test.

The orignal patch is from:
https://lore.kernel.org/linux-riscv/20231225125847.2778638-5-guoren@kernel.org/

Guo Ren (2):
  riscv: Move vendor errata definitions into vendorid_list.h
  riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup

 arch/riscv/Kconfig.errata              | 19 +++++++++++++++
 arch/riscv/errata/thead/errata.c       | 20 ++++++++++++++++
 arch/riscv/include/asm/errata_list.h   | 17 -------------
 arch/riscv/include/asm/rwonce.h        | 33 ++++++++++++++++++++++++++
 arch/riscv/include/asm/vendorid_list.h | 18 ++++++++++++++
 include/asm-generic/rwonce.h           |  2 ++
 6 files changed, 92 insertions(+), 17 deletions(-)
 create mode 100644 arch/riscv/include/asm/rwonce.h

-- 
2.40.1


