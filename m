Return-Path: <linux-kernel+bounces-282704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78B94E7A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5F8B239B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73BA1547D4;
	Mon, 12 Aug 2024 07:22:52 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20114B96D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447372; cv=none; b=VMYkqaKIaEaKhMK51RArruUK7qGpZtWfXYX9wiKzI3AevDG4jlYtgOObz4uDC8tfOWZsVsUrQdX25TpeXJzvKjOSJ2vC6BoKQTrlivZGb4PfcMHEcHCuUzKY9do4B3/kyk+FxZHaltpuEelDDeFC7EyhioEhiaTVgbRe6EP8ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447372; c=relaxed/simple;
	bh=FU6N3Rf0swRfXPrzqkBQpuAmILjo3ab29YZmT6L4VEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B4y+ZdCqguB1l/JhyoKleGLv8ulgRF7c6ya9kZy3aUkDppngd/1RfYsvsT6T9g8X6kbYo6xJ/ATv+qBBCWNW6pOCwYMegT2clYzeeht1vvi0KYR5FvpuSbBDvktZsQPb/3REIjHxFSMhtM04N06a8b2FgGKDEXhQEnExtMHfpQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 06D83A9E3D;
	Mon, 12 Aug 2024 16:22:48 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QcT1aMxXj_dx; Mon, 12 Aug 2024 16:22:47 +0900 (JST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp [153.220.101.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 9AFE7A9E38;
	Mon, 12 Aug 2024 16:22:47 +0900 (JST)
From: takakura@valinux.co.jp
To: pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	lukas@wunner.de,
	wangkefeng.wang@huawei.com,
	ubizjak@gmail.com,
	feng.tang@intel.com,
	j.granados@samsung.com,
	stephen.s.brennan@oracle.com
Cc: linux-kernel@vger.kernel.org,
	nishimura@valinux.co.jp,
	taka@valinux.co.jp,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH v3 0/2] printk: CPU backtrace not printing on panic
Date: Mon, 12 Aug 2024 16:21:37 +0900
Message-Id: <20240812072137.339644-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <takakura@valinux.co.jp>

Hi! 

This patchset fixes 2 issues on CPU backtrace during panic. The second 
issue was pointed out by John [1].

(1) CPU backtrace triggered during panic has stopped working since the 
commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing to ringbuffer") 
as it disabled non-panicked cpus writing into ringbuffer after panic.

(2) The usual(non-panic context) flushing of backtraces written into 
ringbuffer does not work during panic as non-panicked CPUs can't do the 
flushing themselves.

Reviewed-by: John Ogness <john.ogness@linutronix.de>

Sincerely,
Ryo Takakura

---

V1:
[1] https://lore.kernel.org/all/20240729114601.176047-1-takakura@valinux.co.jp/T/

Changes since V2:
[2] https://lore.kernel.org/lkml/20240803081649.224627-1-takakura@valinux.co.jp/T/

- Thanks Petr and John for the feedbacks!
- Add reviewed-by. Petr on (1) and John on the series.
- Fix the order of the patches based on their dependency as suggested by John.
- For (2), instead of using console_flush_on_panic() for flushing backtraces, 
introduce a function which can safely do the flushing in panic while non-panic 
CPU's are still online as suggested by Petr.  Note that the new function calls 
is_printk_legacy_deferred() which is not yet in mainline [3].
[3] https://lore.kernel.org/all/20240804005138.3722656-24-john.ogness@linutronix.de/

---

Ryo Takakura (2):
  (1) Allow cpu backtraces to be written into ringbuffer during panic
  (2) Handle flushing of CPU backtraces during panic

 include/linux/console.h |  1 +
 include/linux/panic.h   |  1 +
 kernel/panic.c          |  9 ++++++++-
 kernel/printk/printk.c  | 16 +++++++++++++++-
 4 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.34.1


