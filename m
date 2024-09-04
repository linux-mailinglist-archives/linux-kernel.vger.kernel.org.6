Return-Path: <linux-kernel+bounces-314631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C50A96B611
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2AB1F25B98
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F11CCB5A;
	Wed,  4 Sep 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B0KoNA7I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+6sRqbEO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E31CC89C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440951; cv=none; b=ljj/eojV8XPWay6kRnOAQB9yxImbtgTG5x7N8rjK1cDADbKUaUrkSj9v1SD1r0figNE3bX9b6HnPk3B+rFPAkVU+2+YwyJL6/hgxuiMN2KVffSnSCtZYjeuCBWity+bLZUbqTV2FOUSOJmKPz5vdYBcJDHYOVymvkSbaGclHOP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440951; c=relaxed/simple;
	bh=LoKx0oaCUTXH3B+1AUszpMqORUwiEB7WE+BQRHfoaIc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CfVis2HQoy4rOVgsfXtguqcV9fNGaXw0/klzaXFxmougkYNO5iQ5F5EOIAf+kWY6+hnCzqngCnWpW3jmO90+dDZSXYYwxkZaHJup+wUQLtg/SkY8JbFcvswTCp+qwwupYRk6c7o6hloiVZzBYpp40w5ChW8NM6OHKKHpPdLvbqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B0KoNA7I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+6sRqbEO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725440948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLtYYDfEOf4gZfiXkvhWBoDh0abmzZ5+yYCKTxZk0VM=;
	b=B0KoNA7IlisQuJtKFWDTg3ysJf9hroW97dY/zktfuzKmWALrlqoZguvtygH6gZYMxun1DS
	c9wTP5v/9bPa8/Hf1NTEtZKR3xSievExIJONKQHOWHWOFyDMQBGlmpoIGTucNGuOXkyT3X
	q6eM5aXcKICmSMI99qX5Tm9OLpgsONgFN7j+7A4lTocjgApazlc2NvpfkYZj0A2ofCvi7r
	kRPSp+MblnYWtHB2VrA1UMAxuNI8witoHY9ZhVGeW06PZjWu9y8naXVD0A2oWFVPgmlNFK
	fykXMr2BSmv0qNKwgqFDFcS6/H4N4hmQ+uXjsv7BBMhusK5++bRoUbV01724Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725440948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLtYYDfEOf4gZfiXkvhWBoDh0abmzZ5+yYCKTxZk0VM=;
	b=+6sRqbEOoBql5POIt6NQc8vmo2+lDcFgFnjhjnIoBhSEQ3Q71LoIbb0GTmrT/w7lxGXLBD
	B5fwKhvHNCsFLbDw==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH v2] static_call: Handle module init failure correctly in
 static_call_del_module()
In-Reply-To: <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com>
References: <87cylj7v6x.ffs@tglx>
 <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com>
Date: Wed, 04 Sep 2024 11:09:07 +0200
Message-ID: <87zfon6b0s.ffs@tglx>
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

Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/all/20230915082126.4187913-1-ruanjinjie@huawei.com
---
V2: Use static_call_key_has_mods() instead
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
+		if (!static_call_key_has_mods(key))
+			break;
+
 		if (key == prev_key)
 			continue;
 

