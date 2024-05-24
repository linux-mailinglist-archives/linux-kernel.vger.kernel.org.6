Return-Path: <linux-kernel+bounces-188434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2D38CE1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471AA1F21BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E3D82D9E;
	Fri, 24 May 2024 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VDeVuQHp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qxr6QSOx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VDeVuQHp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qxr6QSOx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753017578
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537783; cv=none; b=TPjeSVSpTFtMC0mQ7WJIvcIibFkDQS9FTGbRbtEdHdgpQLkc5F0tuuvou6URmkkahB1ktqUrELaO64DSaWU5HzGeajtBcVngU4Too/MOY3tyew0JSO9Jj3aq2ZCWf9VFPI7eVdmQgEPtrrSwvWnvseNpS6k4vKlgwm8UCZDVTvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537783; c=relaxed/simple;
	bh=ME3iarCancu1uy9lgQRvEiZEIkkctE1ctopOgIG6dbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mm1P636GgdtK5QYRcAnlAorEPycjTl9cq2BxDTWkgdA25X3slhK87cGXB+oazHG6G/pJYuQi92lvI3WhvqWM+3T15QYkHV2r/3K5bEd1SADsXZeTRvZ2clT55gNSl8JxVodHFgixftktLBGYt4sEO2GQyt0ZmHXkSSJYL7IQ4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VDeVuQHp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qxr6QSOx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VDeVuQHp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qxr6QSOx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 392293395A;
	Fri, 24 May 2024 08:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716537779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V1tJhdXBOLskkFSnzP+gCy9VHQtlZC7pn4ntQcUW37s=;
	b=VDeVuQHpKVG/4QViBL4oWgHv6jbNTqPFRISZ2vq3Isg5ixyTnVbYXUW7itxMZwjMqdaj4J
	d9zCJfHkP3YolDA1RjHc0VMGB+gsUb4kLLs13CvBA8EOIIskklry6ZaMPFyWC0LEJRn0tF
	ydOuRQCQWJUX83+nWHvPb27RkcfJmSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716537779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V1tJhdXBOLskkFSnzP+gCy9VHQtlZC7pn4ntQcUW37s=;
	b=qxr6QSOx4uz9s9y7Wt4/z7hGosLvobD6rqaOtJdkVQE7DOhQr7Dc4CZZpc5WEwfygrd4h8
	KzlUv+FIdHvDG+Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716537779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V1tJhdXBOLskkFSnzP+gCy9VHQtlZC7pn4ntQcUW37s=;
	b=VDeVuQHpKVG/4QViBL4oWgHv6jbNTqPFRISZ2vq3Isg5ixyTnVbYXUW7itxMZwjMqdaj4J
	d9zCJfHkP3YolDA1RjHc0VMGB+gsUb4kLLs13CvBA8EOIIskklry6ZaMPFyWC0LEJRn0tF
	ydOuRQCQWJUX83+nWHvPb27RkcfJmSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716537779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V1tJhdXBOLskkFSnzP+gCy9VHQtlZC7pn4ntQcUW37s=;
	b=qxr6QSOx4uz9s9y7Wt4/z7hGosLvobD6rqaOtJdkVQE7DOhQr7Dc4CZZpc5WEwfygrd4h8
	KzlUv+FIdHvDG+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A0FB13A6B;
	Fri, 24 May 2024 08:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zh0FBrNJUGa0bQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 24 May 2024 08:02:59 +0000
Message-ID: <457e2827-119e-446c-90b3-8e9cc7cd3e5d@suse.cz>
Date: Fri, 24 May 2024 10:02:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] WARNING in flush_cpu_slab
To: Thomas Gleixner <tglx@linutronix.de>,
 syzbot <syzbot+50e25cfa4f917d41749f@syzkaller.appspotmail.com>,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com, x86@kernel.org, linux-mm@kvack.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tejun Heo
 <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Dennis Zhou <dennis@kernel.org>
References: <0000000000008c9d27061915ca9c@google.com> <87v834g6hn.ffs@tglx>
 <2149ee23-5321-4422-808f-e6a9046662fc@suse.cz> <87r0dsdur6.ffs@tglx>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <87r0dsdur6.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[50e25cfa4f917d41749f];
	FREEMAIL_TO(0.00)[linutronix.de,syzkaller.appspotmail.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,redhat.com,googlegroups.com,kernel.org,kvack.org,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SUBJECT_HAS_QUESTION(0.00)[]

On 5/24/24 12:32 AM, Thomas Gleixner wrote:
> On Thu, May 23 2024 at 23:03, Vlastimil Babka wrote:
>> On 5/23/24 12:36 PM, Thomas Gleixner wrote:
>>>> ------------[ cut here ]------------
>>>> DEBUG_LOCKS_WARN_ON(l->owner)
>>>> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
>>>> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 flush_slab mm/slub.c:3088 [inline]
>>>> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 flush_cpu_slab+0x37f/0x410 mm/slub.c:3146
>>
>> I'm puzzled by this. We use local_lock_irqsave() on !PREEMPT_RT everywhere.
>> IIUC this warning says we did the irqsave() and then found out somebody else
>> already set the owner? But that means they also did that irqsave() and set
>> themselves as l->owner. Does that mey there would be a spurious irq enable
>> that didn't go through local_unlock_irqrestore()?
>>
>> Also this particular stack is from the work, which is scheduled by
>> queue_work_on() in flush_all_cpus_locked(), which also has a
>> lockdep_assert_cpus_held() so it should fullfill the "the caller must ensure
>> the cpu doesn't go away" property. But I think even if this ended up on the
>> wrong cpu (for the full duration or migrated while processing the work item)
>> somehow, it wouldn't be able to cause such warning, but rather corrupt
>> something else
> 
> Indeed. There is another report which makes no sense either:
> 
>  https://lore.kernel.org/lkml/000000000000fa09d906191c3ee5@google.com

That looks like slab->next which should contain a valid pointer or NULL,
contains 0x13.
slab->next is initialized in put_cpu_partial() from s->cpu_slab->partial

Here we have corruption inside s->cpu_slab->list_lock

> Both look like data corropution issues caused by whatever...

s->cpu_slab is percpu allocation so possibly another percpu alloc user has a
buffer overflow?

> Thanks,
> 
>         tglx


