Return-Path: <linux-kernel+bounces-207421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333489016EF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 18:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8249B216B5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736874653C;
	Sun,  9 Jun 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CTZKdYdm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H2U8an1E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0EE14265
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948974; cv=none; b=UO7txSfyrqNSMxjM3BWBc2k7dtKsBvC5lcnzk2CT6IPd2Bbk1StZjLOfTu5PtlBelKUsFrGIbM6s7KSzjXm+XKQ65N/WBVT8cpn6AnnjlB0NOmnFQa65OUnx5ndpNe04jPK88PJerjLziOGI5AxPrPjUFyFpzf2SX34FWAIpuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948974; c=relaxed/simple;
	bh=DodAw0CDZw5lGkogUtyvn5PgD3gDcFWLPYOSKVO/WY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RsHLEssCl224QcNBdTM9ZyiW43Sj2q/ZR9IOZfB1rfszpE4wprcTr4OzNpWWBYjlddRHBbOoytoJ61ycpRMzCe5vrjLZSKVcyVCM2vfVHJ3ppZZgNyUZPE3YBTpv4BChGjyECsVNyoO3JLYFlpYfns7rfvEdMFDq63gI+a2vYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CTZKdYdm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H2U8an1E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717948969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8se/4P0/1yragouupDZnLHlKNeIFgaBBOQWyoffwNL4=;
	b=CTZKdYdmMLDCxIjW2mxknSapv9GGe+FNMmuvsGInIeuTFWdb7UoNdyRQVapAgGoU26Kd7C
	dUdqYB33C2xGdjoP5S/1Y4jMDICyND7OhCHxd5SM/cmEs+Z+7NdBBfFFjcH+F1QJCbhe+O
	ArcfyuurbSNz9wwOUYMigzrdx34NsukV7Ms0e1MK8Nsrpx3+L5j/hU3qxwttqp5lxkRjFm
	QzizGZS+f15grs06C+36XV5f2pRBO2cbs3vrNAoYksH5z5612pDKidq4k6ffd3bK2vQnuq
	zstYR3qKWz2HU1ySzYDlZtKimbTyFOlU5DYz2QEe3IFnDDW1/QOFwIkeKRIwfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717948969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8se/4P0/1yragouupDZnLHlKNeIFgaBBOQWyoffwNL4=;
	b=H2U8an1ECedYXsKy/t3EEa9F/MWxsDkNELjppneZE0Gg2z/NWuh0SxF6V9G1ZeJlI3c2Ke
	c+rcL4lm7ftQljCA==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, syzkaller-bugs@googlegroups.com, peterz@infradead.org,
 jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org, mingo@redhat.com,
 Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
 hpa@zytor.com, xrivendell7@gmail.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [Linux kernel bug] WARNING in static_key_slow_inc_cpuslocked
In-Reply-To: <20240609102530.0a292b07@rorschach.local.home>
References: <20240609090431.3af238bc@gandalf.local.home>
 <87o78axlbm.ffs@tglx> <20240609102530.0a292b07@rorschach.local.home>
Date: Sun, 09 Jun 2024 18:02:49 +0200
Message-ID: <87le3exfx2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 09 2024 at 10:25, Steven Rostedt wrote:
> On Sun, 09 Jun 2024 16:06:05 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> CPU 0                           	CPU 1
>> 
>> kernfs_fop_write_iter()			kernfs_fop_write_iter()
>>   set_attr_rdpmc()		  	  set_attr_rdpmc()
>>     arch_jump_label_transform_queue()       arch_jump_label_transform_queue()
>>      mutex_lock(text_mutex)                   mutex_lock(text_mutex)
>>      __jump_label_patch()
>>      text_poke_queue()
>>      mutex_unlokc(text_mutex)
>>                                               __jump_label_patch()
>> 
>> CPU 1 sees the original text and not the expected because CPU 0 did not
>> yet invoke arch_jump_label_transform_apply().
>> 
>> So clearly set_attr_rdpmc() lacks serialization, no?
>> 
> Hmm, but should jump labels fail when that happens? Or should it catch
> it, and not cause a BUG?

Well the bug is there to detect inconsistency and that clearly works :)

But I clearly can't read, because the jump label operations are
serialized via jump_label_mutex. Hrm...

