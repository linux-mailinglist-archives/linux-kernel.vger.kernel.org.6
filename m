Return-Path: <linux-kernel+bounces-207377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC8F90164D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D50F1C209B2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4055D433DF;
	Sun,  9 Jun 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJ8bfMbH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YdJgnW/4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131C5258
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717941975; cv=none; b=DEggallDxpjVION/YHtd3JaIs4EY4YQFRF4sbL8VZCaI+nitEFTYS5z+m03uNT6J9I8SslRiVGnTtS9S6japr1ELuzQSpe6DXf1e8bBw62iPja8bOKwlAXf2sZqjNYSgzd2p4qVQEfWrPx1hHg8GGEMglDWT9TZcY8dzXzynTHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717941975; c=relaxed/simple;
	bh=6QVgF/8COzoVrtWePYt2nKdMT6SVy0blal0ckZNuez8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=rKW7+netH6Gl7BJ45dcPIQYFmHVJqcGDW135vgACI/619qhGdAPZY5mjZCWqLtoqpowRwBfuY3Gk6JzVE0PkycVtGshwXmpuIOP/sdYKfz8Ga9nd2dUVYZiuH20865ZalPxLtoqkpIVggknn1GY6t7QtCdn6+FjS5YqujTgTwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJ8bfMbH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YdJgnW/4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717941966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=MdK2zU1xqNbST/UF9ZI3uh8ZHJQkTJnk5XC1SoB0iQo=;
	b=wJ8bfMbHDbGEDHsvrp99UfMga4Xgzh0XrQ01OnGNVfJkSp7X5K38+/pTszobVdJU1hHJ6z
	T7+yDwg3zHoBVzzBMz52qXHiy/Ua8wUgpFDW/aBB7gFWaf/lhdRY2RhA0HkTon7aTrwhFB
	leHoOown417Hkgp4zXwyd2aIsuy8X+MT6R/0jJKyf7U5tczHTCE86OzT4Bdg/0GSsvNJCT
	2DAhFFkbPiKCmYGJqJCjphLPfWswn0vnlrE0aVO3CVFf8ANxC7X6zgp7PxuGM7HE0qzAg0
	U6XjyBbSYeAnhI+FBZewagL/wmXtooVdGBgvHd35opQfyvn1JmajxvQsnP8srA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717941966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=MdK2zU1xqNbST/UF9ZI3uh8ZHJQkTJnk5XC1SoB0iQo=;
	b=YdJgnW/4qSsyqca8bqzAqhmLHZGAo15QGtIqPKvwqbehoBQ6wu30GVCX96ATHHDSluD7q9
	AuaHyh7RsfPaW3DQ==
To: Steven Rostedt <rostedt@goodmis.org>, Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 syzkaller-bugs@googlegroups.com, peterz@infradead.org,
 jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org, mingo@redhat.com,
 Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
 hpa@zytor.com, xrivendell7@gmail.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [Linux kernel bug] WARNING in static_key_slow_inc_cpuslocked
In-Reply-To: <20240609090431.3af238bc@gandalf.local.home>
Date: Sun, 09 Jun 2024 16:06:05 +0200
Message-ID: <87o78axlbm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 09 2024 at 09:04, Steven Rostedt wrote:
> On Sun, 9 Jun 2024 14:33:01 +0800
> Sam Sun <samsun1006219@gmail.com> wrote:
>> [   82.310798][ T8020] ------------[ cut here ]------------
>> [   82.311236][ T8020] kernel BUG at arch/x86/kernel/jump_label.c:73!
>
> This is not a bug with jump labels. It's a bug with whatever is using jump
> labels. Looks like something tried to modify a jump label that no longer
> exists.

The jump label exists.

>> [   82.331873][ T8020]  set_attr_rdpmc+0x193/0x270
>> [   82.332179][ T8020]  ? get_attr_rdpmc+0x30/0x30
>> [   82.332511][ T8020]  ? sysfs_kf_write+0x18d/0x2b0
>> [   82.332832][ T8020]  ? sysfs_kf_read+0x370/0x370
>> [   82.333159][ T8020]  kernfs_fop_write_iter+0x3ab/0x500
>
> So, something in kernfs modified a jump label location that was freed?

No. What happens is:

CPU 0                           	CPU 1

kernfs_fop_write_iter()			kernfs_fop_write_iter()
  set_attr_rdpmc()		  	  set_attr_rdpmc()
    arch_jump_label_transform_queue()       arch_jump_label_transform_queue()
     mutex_lock(text_mutex)                   mutex_lock(text_mutex)
     __jump_label_patch()
     text_poke_queue()
     mutex_unlokc(text_mutex)
                                              __jump_label_patch()

CPU 1 sees the original text and not the expected because CPU 0 did not
yet invoke arch_jump_label_transform_apply().

So clearly set_attr_rdpmc() lacks serialization, no?

Thanks,

        tglx


