Return-Path: <linux-kernel+bounces-207382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB4C901657
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFD42816FE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE843AC4;
	Sun,  9 Jun 2024 14:25:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0A2233A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717943116; cv=none; b=gkojatleMxmlNJ9I3H8JO73PJDqU8j2zRc4YyXNnATrzD9HpRSMwmn1oc2Uv/s5P9TrM41jtZYjxgVlWXTplCzgT0DZOl4E4zjWYMFIHq0knvL0f9INu6qjSbrMguGyhBU8GqnIhE8wk2qTABQYCBt7RbDt8gFGPp08QjHGXWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717943116; c=relaxed/simple;
	bh=4DAeBNRuP/ZxcrO8Rw9fTCFAb9nXpRMGSiRThrAiwAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6UWrlBv0zjY02i2v+0QOzeXfVA6Wpm8FwtSfscsr2UfBmwxKlqmQD79VaBHJ3TtvinH9P61qEKhRLSkYicUDfvhOOefY+61uasraaRzh0ugKiFh+bivJkUkLbNkvo0TxHwWaMCkI7Q0i+irPqO5x7vjOkznZlv4XWlYm8Q+TBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABCBC2BD10;
	Sun,  9 Jun 2024 14:25:12 +0000 (UTC)
Date: Sun, 9 Jun 2024 10:25:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, syzkaller-bugs@googlegroups.com, peterz@infradead.org,
 jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org, mingo@redhat.com,
 Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com, hpa@zytor.com,
 xrivendell7@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tejun Heo <tj@kernel.org>
Subject: Re: [Linux kernel bug] WARNING in static_key_slow_inc_cpuslocked
Message-ID: <20240609102530.0a292b07@rorschach.local.home>
In-Reply-To: <87o78axlbm.ffs@tglx>
References: <20240609090431.3af238bc@gandalf.local.home>
	<87o78axlbm.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 09 Jun 2024 16:06:05 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, Jun 09 2024 at 09:04, Steven Rostedt wrote:
> > On Sun, 9 Jun 2024 14:33:01 +0800
> > Sam Sun <samsun1006219@gmail.com> wrote:  
> >> [   82.310798][ T8020] ------------[ cut here ]------------
> >> [   82.311236][ T8020] kernel BUG at arch/x86/kernel/jump_label.c:73!  
> >
> > This is not a bug with jump labels. It's a bug with whatever is using jump
> > labels. Looks like something tried to modify a jump label that no longer
> > exists.  
> 
> The jump label exists.

Ah, I missed the set_attr_rdpmc() as something not with a "?" in front :-p

> 
> >> [   82.331873][ T8020]  set_attr_rdpmc+0x193/0x270
> >> [   82.332179][ T8020]  ? get_attr_rdpmc+0x30/0x30
> >> [   82.332511][ T8020]  ? sysfs_kf_write+0x18d/0x2b0
> >> [   82.332832][ T8020]  ? sysfs_kf_read+0x370/0x370
> >> [   82.333159][ T8020]  kernfs_fop_write_iter+0x3ab/0x500  
> >
> > So, something in kernfs modified a jump label location that was freed?  
> 
> No. What happens is:
> 
> CPU 0                           	CPU 1
> 
> kernfs_fop_write_iter()			kernfs_fop_write_iter()
>   set_attr_rdpmc()		  	  set_attr_rdpmc()
>     arch_jump_label_transform_queue()       arch_jump_label_transform_queue()
>      mutex_lock(text_mutex)                   mutex_lock(text_mutex)
>      __jump_label_patch()
>      text_poke_queue()
>      mutex_unlokc(text_mutex)
>                                               __jump_label_patch()
> 
> CPU 1 sees the original text and not the expected because CPU 0 did not
> yet invoke arch_jump_label_transform_apply().
> 
> So clearly set_attr_rdpmc() lacks serialization, no?
> 

Hmm, but should jump labels fail when that happens? Or should it catch
it, and not cause a BUG?

-- Steve

