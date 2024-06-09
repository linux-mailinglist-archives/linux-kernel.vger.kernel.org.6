Return-Path: <linux-kernel+bounces-207434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8890170E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 18:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A311F211B5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E450647F59;
	Sun,  9 Jun 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PXHRcjgd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zCYX5cs1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1DB63C7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717952178; cv=none; b=XFgI0PtXkrHZrVsWWrFi93GvGj/J5hxHHJhQ0YmzhrrQmDtnl01VT1Z6aeY7ajtEXgkmy0Sdd0FpF2oWkY730DA2WKOe/xMstYu+Qz6uG6+fBJaIcGh/xfsDLisBjyfBAHB3O1mbyWgg+HcDup/oxFallWONgW3op+4hWF8WE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717952178; c=relaxed/simple;
	bh=QVRDcudzq+SxuxGLiSNE6jrKkkJUQNIjX703RDFrUM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YC88AJXXKvtG+H/lQ/woZioCh6i69nANTmmZr+MKVmJQf257gyo3YsolMYzOMpeUK8Zleoe2PT9PoBy239/F2HEbAsjSHUt6TK+13HuzCmro1gm/xcuzK0Ug9cHbdOPCeRF/dgiat9Vw+3jMH1hAdzW1wPe6ba1nvykFoxWyA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PXHRcjgd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zCYX5cs1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717952175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2BfnhShkMx76spM67lpVd99C3roozhsXHPVJTgEobwM=;
	b=PXHRcjgd4omUMqVA20w1Qyn/t4cjCl0oj5c8JdjBAA3qZF68g2wDcvab8V1P8neWFEcRtd
	nEnRV7j+YjIGU2dkfkwK5HZ0xqydB0xNaIhKCeZQOTQMOXQAyfX/pIj/TenhkAzRo/tkV8
	UwA97Y2K5+nXV+Kc2gnbU3wl+l9Ugxfi6Nsvioigr0V/IwBBSVps4nRdwhUPefD8gAs1jD
	hcoLTPebNInOFfdHjObHl/uOV2lfznYPy5QVnmn86YDsI+L88Mfs+MlsIMqBSHZyNWLpkz
	fBr/C5K/0C0lX0+7bvH9Fh4Ync/++VNf0YIlzvEqjCZUQcG7GURkYC8BZcCoaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717952175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2BfnhShkMx76spM67lpVd99C3roozhsXHPVJTgEobwM=;
	b=zCYX5cs1LwLmwMr0V6KwDwpuptYlwCTrCGyHfrX9h80Y0rvp8vz12MjJGaBgj69cHEVDzW
	WObTgUpuulR8zxAg==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, syzkaller-bugs@googlegroups.com, peterz@infradead.org,
 jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org, mingo@redhat.com,
 Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
 hpa@zytor.com, xrivendell7@gmail.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [Linux kernel bug] WARNING in static_key_slow_inc_cpuslocked
In-Reply-To: <87le3exfx2.ffs@tglx>
References: <20240609090431.3af238bc@gandalf.local.home>
 <87o78axlbm.ffs@tglx> <20240609102530.0a292b07@rorschach.local.home>
 <87le3exfx2.ffs@tglx>
Date: Sun, 09 Jun 2024 18:56:14 +0200
Message-ID: <87h6e2xdg1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 09 2024 at 18:02, Thomas Gleixner wrote:
> On Sun, Jun 09 2024 at 10:25, Steven Rostedt wrote:
> Well the bug is there to detect inconsistency and that clearly works :)
>
> But I clearly can't read, because the jump label operations are
> serialized via jump_label_mutex. Hrm...

Ok. Now I found if for real. It's in the jump label core:

CPU0                            CPU1

static_key_slow_dec()
 static_key_slow_try_dec()

   key->enabled == 1
   val = atomic_fetch_add_unless(&key->enabled, -1, 1);
   if (val == 1)
   	return false;

   jump_label_lock();
   if (atomic_dec_and_test(&key->enabled)) {
      --> key->enabled == 0
      __jump_label_update()

                                static_key_slow_dec()
                                 static_key_slow_try_dec()

                                    key->enabled == 0
                                    val = atomic_fetch_add_unless(&key->enabled, -1, 1);

                                    --> key->enabled == -1 <- FAIL

static_key_slow_try_dec() is buggy. It needs similar logic as
static_key_slow_try_inc() to work correctly.

It's not only the 0, key->enabled can be -1 when the other CPU is in the
slow path of enabling it.

I'll send a patch after testing it.

Thanks,

        tglx

