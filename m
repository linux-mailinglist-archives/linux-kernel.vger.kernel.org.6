Return-Path: <linux-kernel+bounces-574319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0BEA6E3D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E571D16F568
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690581C5490;
	Mon, 24 Mar 2025 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="larxo7Ea"
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8D8634A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845936; cv=none; b=R3rKgn/nJPKVNYZ1H4xMH+x5aGuddmN3vk4KVLXElAMDiiIUxn9EEX1nMJPA1EWirmLDc8evB961A2zZnMuxs67Fh387uyU1qu9ws4zD8bTVdhLUgRqW8+ied77yvtSZkLFvXOj2iQJV7i+7PtDQLF+qMFkny2SYkZ36MriOqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845936; c=relaxed/simple;
	bh=QpOZX/E6S2mq62YojNtEfWKAqZFAYrXgLkXQNmBqv+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzF4Q8jan5kGNLRH7zTTZ0go62ZcZAncAyjKtfj+qmwxwU1Rs7nKLc0WRGrdTpRVSJD+5i7RVN6zlni9XQmg9RMfxhMFgV6JuVzsikdWohGwEMePwyUx7U8PJjYJ8cE3NM2zoXhugXcVQ/H9YjEbbdOo8AYiNpOQ/WY5m2VpoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=larxo7Ea; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 995281C17B7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:51:51 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1742845908; x=
	1743709909; bh=QpOZX/E6S2mq62YojNtEfWKAqZFAYrXgLkXQNmBqv+0=; b=l
	arxo7EawgHrhfkagExWNMhdncYcQvi74riBo83l1DtUo6TmmDVsOyJ9A9w3EmpCx
	RhZXUpoHx1wZAvR/IKoZRpvii762dyQS4tjGPC7VMEvO4fHdv9TX+A9uQ8skyenm
	0wyo++qtbsjmXPtsqRRtFdzL8qbQENxQtHS1LTKQWg=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Uxoeug6BTrbp for <linux-kernel@vger.kernel.org>;
	Mon, 24 Mar 2025 22:51:48 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 996261C179B;
	Mon, 24 Mar 2025 22:51:37 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Juergen Gross <jgross@suse.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.10] static_call: Handle module init failure correctly in static_call_del_module()
Date: Mon, 24 Mar 2025 19:51:27 +0000
Message-ID: <20250324195129.700347-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

commit 4b30051c4864234ec57290c3d142db7c88f10d8a upstream.

Module insertion invokes static_call_add_module() to initialize the static
calls in a module. static_call_add_module() invokes __static_call_init(),
which allocates a struct static_call_mod to either encapsulate the built-in
static call sites of the associated key into it so further modules can be
added or to append the module to the module chain.

If that allocation fails the function returns with an error code and the
module core invokes static_call_del_module() to clean up eventually added
static_call_mod entries.

This works correctly, when all keys used by the module were converted over
to a module chain before the failure. If not then static_call_del_module()
causes a #GP as it blindly assumes that key::mods points to a valid struct
static_call_mod.

The problem is that key::mods is not a individual struct member of struct
static_call_key, it's part of a union to save space:

        union {
                /* bit 0: 0 = mods, 1 = sites */
                unsigned long type;
                struct static_call_mod *mods;
                struct static_call_site *sites;
	};

key::sites is a pointer to the list of built-in usage sites of the static
call. The type of the pointer is differentiated by bit 0. A mods pointer
has the bit clear, the sites pointer has the bit set.

As static_call_del_module() blidly assumes that the pointer is a valid
static_call_mod type, it fails to check for this failure case and
dereferences the pointer to the list of built-in call sites, which is
obviously bogus.

Cure it by checking whether the key has a sites or a mods pointer.

If it's a sites pointer then the key is not to be touched. As the sites are
walked in the same order as in __static_call_init() the site walk can be
terminated because all subsequent sites have not been touched by the init
code due to the error exit.

If it was converted before the allocation fail, then the inner loop which
searches for a module match will find nothing.

A fail in the second allocation in __static_call_init() is harmless and
does not require special treatment. The first allocation succeeded and
converted the key to a module chain. That first entry has mod::mod == NULL
and mod::next == NULL, so the inner loop of static_call_del_module() will
neither find a module match nor a module chain. The next site in the walk
was either already converted, but can't match the module, or it will exit
the outer loop because it has a static_call_site pointer and not a
static_call_mod pointer.

Fixes: 9183c3f ("static_call: Add inline static call infrastructure")
Closes: https://lore.kernel.org/all/20230915082126.4187913-1-ruanjinjie@huawei.com
Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/87zfon6b0s.ffs@tglx
[ Alexey Nepomnyashih: backport fix to static_call.c. ]
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/static_call.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index e9408409eb46..3eaa810ec7b2 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -400,6 +400,17 @@ static void static_call_del_module(struct module *mod)
 
 	for (site = start; site < stop; site++) {
 		key = static_call_key(site);
+
+		/*
+		 * If the key was not updated due to a memory allocation
+		 * failure in __static_call_init() then treating key::sites
+		 * as key::mods in the code below would cause random memory
+		 * access and #GP. In that case all subsequent sites have
+		 * not been touched either, so stop iterating.
+		 */
+		if (!static_call_key_has_mods(key))
+			break;
+
 		if (key == prev_key)
 			continue;
 
-- 
2.43.0


