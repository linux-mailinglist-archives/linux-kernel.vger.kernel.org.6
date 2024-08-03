Return-Path: <linux-kernel+bounces-273387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB69468A4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390FE281F24
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 08:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF414E2E9;
	Sat,  3 Aug 2024 08:13:31 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11617173C
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722672811; cv=none; b=Cq1GWp6spVnR+tMYKMpG7nOerNbfVJ9jWqn96QfZU8SL8grjDH7PKnSPDTeT3t1UfFfiKO/oHVUCqeFjyq+l9KKRd5DRg5XjRezCg4OKH/Yq6qqEDWoCsWUHtqYvhCg6OLkJaJTp+iS3R8h2I18TjBMEp8Bz3XQ3gkE8RvoEZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722672811; c=relaxed/simple;
	bh=HrxnCbsdaVmoeidDEDy7PQl6RTJyNL5zzHzFva/a3Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAabTDrGODE01zbVFMNox6NQefHM3DglDFLSCeibjiZnp0MaLOpnzGpIK3KV6uzamqTC+XEBk04XajbmufzWNwbEpZHMfDssPaE2ifQjGJkCHG37E3VFhVuTzvn9a9wfSMM4SqM5KkLbfl7N3fe1GYZ0nsVXE6URDogeb9HVkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 05631A9DD3;
	Sat,  3 Aug 2024 17:13:28 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PKfo01gvh7Qi; Sat,  3 Aug 2024 17:13:27 +0900 (JST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp [153.220.101.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 96278A9D63;
	Sat,  3 Aug 2024 17:13:27 +0900 (JST)
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
Subject: [PATCH v2 1/2] Handle flushing of CPU backtraces during panic
Date: Sat,  3 Aug 2024 17:12:30 +0900
Message-Id: <20240803081230.223512-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240803080444.221427-1-takakura@valinux.co.jp>
References: <20240803080444.221427-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <takakura@valinux.co.jp>

After panic, non-panicked CPU's has been unable to flush ringbuffer 
while they can still write into it. This can affect CPU backtrace 
triggered in panic only able to write into ringbuffer incapable of 
flushing them.

Fix the issue by letting the panicked CPU handle the flushing of 
ringbuffer right after non-panicked CPUs finished writing their
backtraces.

Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
---
 kernel/panic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 7e2070925..f94923a63 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -252,8 +252,10 @@ void check_panic_on_warn(const char *origin)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
+	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
 		trigger_all_cpu_backtrace();
+		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+	}
 
 	/*
 	 * Note that smp_send_stop() is the usual SMP shutdown function,
-- 
2.34.1


