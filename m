Return-Path: <linux-kernel+bounces-313938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A386796AC93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572C01F2476A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E60D1D6C78;
	Tue,  3 Sep 2024 22:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E/u8PHsu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zc1syU3g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DFA1D5CF0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725404337; cv=none; b=Nqzenxo3BgufG5JYQWcq+JtOtPm/X98/2lffG8RnUULLkQTeHN/qU07AQGEFIsNbX4AIwJoi4B0mQdLYnTelY7YnVCaIa+AMBzInEfWfUG2sxSXWldu4Goj40ffK+3mMiGyvWIYkW89b6WX0HlvfuJf10S7D8vtyQ5IKb1CUU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725404337; c=relaxed/simple;
	bh=tY9z0iuOaHgPdmSvWfpv3NIEqKWguTzQEkSC2c4utGQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YYkrGk+KurelCH4p/rQVCxFa1ZOG+t8O+UaZSHtCvrComDJNPfJoMz8/orpkhZUgtwwFDb4MPkj+sM++SYnH2VfdM0TVY7J48G4xwaiZYummjvWqTcmZdU6d5wDPU6DQ+dFu0cLw8Tr9vGXRUhA1U1vLWaTT1untl2D7CioVDPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E/u8PHsu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zc1syU3g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725404333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCwLf2O0aBlkjv9rxZ4C5f/reOYiobZgyiO+NPOZX5c=;
	b=E/u8PHsuqa8D5dTQKGYOosbjr4i6n5QPNfuTSaLLaWhBjxG2hOj4YgwH6UzVjnScODbQbl
	J+NtVwuZG8MWsNti3WeNc3G+NE6OE5MCM9cFUEjgWXM/yOXDGD5obKFaoDC0u78TA+RpO2
	tOGc/RJr7EroxURwX9WJKFI0MJl8yQj/sShctL09ADWK+DgsbuGAf6r9RAE0Q9RHconjVB
	hy7TYaJvimV2WgG7kI7GV/TgfL51OHxE4u7zFz5oBnT9u/iYCC0fE4q4JgnnB/RjhkXoMD
	gFhaNwwxRn1HDDncvUebZgw9hNJkU5kvHOWMc6AHv3CM5xQFXwGXK0qEUIG2KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725404333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCwLf2O0aBlkjv9rxZ4C5f/reOYiobZgyiO+NPOZX5c=;
	b=Zc1syU3gQd9WRVbLtaE4VnPXXmqzckp6b9z7qU7+uWNHe+owCndQgZCvvvZweyrzYsuTDD
	mmO8naI1UAIKMABg==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
In-Reply-To: <87y1487bh2.ffs@tglx>
References: <87y1487bh2.ffs@tglx>
Date: Wed, 04 Sep 2024 00:58:52 +0200
Message-ID: <87msko739v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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

As static_call_del_module() blindly assumes that the pointer is a valid
static_call_mod type, it fails to check for this failure case and
dereferences the pointer to the list of built-in call sites, which is
obviously bogus.

Cure it by checking whether the key has a sites or a mods pointer. 

If it is a sites pointer then the key is not to be touched. As the sites
are walked in the same order as in __static_call_init() the site walk
can be terminated because all subsequent sites have not been touched by
the init code due to the error exit.

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

Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/20230915082126.4187913-1-ruanjinjie@huawei.com
---
 kernel/static_call_inline.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -411,6 +411,17 @@ static void static_call_del_module(struc
 
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
+		if (static_call_key_sites(key))
+			break;
+
 		if (key == prev_key)
 			continue;
 

