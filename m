Return-Path: <linux-kernel+bounces-409647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C571D9C8FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576A01F21748
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF7213D881;
	Thu, 14 Nov 2024 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EwEXAPtt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aWKvklly";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EwEXAPtt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aWKvklly"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F817C7CE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601300; cv=none; b=E0sNLgITwevzMFrrFN3etb9tVTv0po6LlZX8mvv9kcETX8rKG4i1yzdzsP3dgOJeFegP2DhTYiRFqWyLW7/qFe81Uh5akloU1zxEpTzveq1WMtiaWZ2IpiRGkBMsShQV+0TwQPrDyfonIK4YsYfJYVEjR/bbEFLsIHq6ZwyapN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601300; c=relaxed/simple;
	bh=KyA/3lB5Rx7pbNohcIlUOFYN4Quv6XAAMePv9xb8Ies=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M4ixYDxVf+DVnJn7xJkai6XbBchDGDTUWwPR79Hd6P94G4P+4sbwr4RjPE9EZfUXnjQ+xqYWL3eMa34t/dS3r69nwXG8yjP7nj4z5+Lmo+Qt8idbSDvmsPixmGl7E471tRyCDerJM/JjLtNfG82vBvTUxd3Pn31jWzh/YDeFZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EwEXAPtt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aWKvklly; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EwEXAPtt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aWKvklly; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3336C1F37E;
	Thu, 14 Nov 2024 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731601296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aCD8CrqwKQR4PifiZCmjDfzQYnS+YS1KlDUsRCBxRDw=;
	b=EwEXAPttD7Sa7QLIJ6TNDeoi6pZfxlgzFM3tnW3ykz3RFiaEd5J+1Y2GOLKI5nhDcMYoBe
	ximmTRP/Bj0qmPmQZkTu4l8UBL16PUontoQWBBkvazmYcJjuumlvPn47OvNZ/EpNpSqC1p
	9NVqwz7qn0ovbGDmY6WPlhf/re/eaFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731601296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aCD8CrqwKQR4PifiZCmjDfzQYnS+YS1KlDUsRCBxRDw=;
	b=aWKvkllyJBhiX710mMcKs0Ptwk4avYvzQFn+cU6jVPwYe3/f2782YIIWGDDvoeCKstmTwG
	+6AmpVW7pV0MGuDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EwEXAPtt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aWKvklly
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731601296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aCD8CrqwKQR4PifiZCmjDfzQYnS+YS1KlDUsRCBxRDw=;
	b=EwEXAPttD7Sa7QLIJ6TNDeoi6pZfxlgzFM3tnW3ykz3RFiaEd5J+1Y2GOLKI5nhDcMYoBe
	ximmTRP/Bj0qmPmQZkTu4l8UBL16PUontoQWBBkvazmYcJjuumlvPn47OvNZ/EpNpSqC1p
	9NVqwz7qn0ovbGDmY6WPlhf/re/eaFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731601296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aCD8CrqwKQR4PifiZCmjDfzQYnS+YS1KlDUsRCBxRDw=;
	b=aWKvkllyJBhiX710mMcKs0Ptwk4avYvzQFn+cU6jVPwYe3/f2782YIIWGDDvoeCKstmTwG
	+6AmpVW7pV0MGuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F167B13721;
	Thu, 14 Nov 2024 16:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E3OYOo8jNmcTHAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 14 Nov 2024 16:21:35 +0000
Message-ID: <33a7dfd4-1947-41e2-b0b3-7e4ef6ea3209@suse.cz>
Date: Thu, 14 Nov 2024 17:21:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org,
 mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net,
 david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
 paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
 hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com,
 shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-5-surenb@google.com>
 <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz>
 <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>
 <ZzSwM5qwStadOZvv@casper.infradead.org>
 <k26pa6fhn2j6bgfwtcdp6u5vk25mkclitzvqqeqvji77k4lqop@yowwrqusmdyp>
 <CAJuCfpHjuMWCzeONq2YOOkr1JGH=E=xn=BAcjQyo_=P1cz=crA@mail.gmail.com>
 <aa4i3inhnkyi6yazttb55khbm7swt7xq2sklmhp5y63kxw7bsc@i4wlyyzoo7h3>
 <CAJuCfpF_fEVwyDAStueNoEW=MNS5MoLPc1RaQMaOHZxODmw_0A@mail.gmail.com>
 <CAJuCfpFd1-hH=gmzyosZiebp8X=F9h-jTt1dXiMpZovsL8O=rQ@mail.gmail.com>
 <CAJuCfpGMQpHroxzzrR_pwLKRS=znchqNQK7EoWVEudACNnC_Cg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJuCfpGMQpHroxzzrR_pwLKRS=znchqNQK7EoWVEudACNnC_Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3336C1F37E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[google.com,oracle.com,infradead.org,linux-foundation.org,suse.com,cmpxchg.org,gmail.com,intel.com,techsingularity.net,redhat.com,stgolabs.net,kernel.org,sina.com,linux.dev,soleen.com,kvack.org,vger.kernel.org,android.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLk41rrgs15z4i1nmqiwtynpyh)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/14/24 17:18, Suren Baghdasaryan wrote:
> 
> Ok, my vma->detached deprecation effort got to the point that my QEMU
> boots. The change is not pretty and I'm quite sure I did not cover all
> cases yet (like hugepages):
> 
>  arch/arm/kernel/process.c             |   2 +-
>  arch/arm64/kernel/vdso.c              |   4 +-
>  arch/loongarch/kernel/vdso.c          |   2 +-
>  arch/powerpc/kernel/vdso.c            |   2 +-
>  arch/powerpc/platforms/pseries/vas.c  |   2 +-
>  arch/riscv/kernel/vdso.c              |   4 +-
>  arch/s390/kernel/vdso.c               |   2 +-
>  arch/s390/mm/gmap.c                   |   2 +-
>  arch/x86/entry/vdso/vma.c             |   2 +-
>  arch/x86/kernel/cpu/sgx/encl.c        |   2 +-
>  arch/x86/um/mem_32.c                  |   2 +-
>  drivers/android/binder_alloc.c        |   2 +-
>  drivers/gpu/drm/i915/i915_mm.c        |   4 +-
>  drivers/infiniband/core/uverbs_main.c |   4 +-
>  drivers/misc/sgi-gru/grumain.c        |   2 +-
>  fs/exec.c                             |   2 +-
>  fs/hugetlbfs/inode.c                  |   3 +-
>  include/linux/mm.h                    | 111 +++++++++++++++++---------
>  include/linux/mm_types.h              |   6 --
>  kernel/bpf/arena.c                    |   2 +-
>  kernel/fork.c                         |   6 +-
>  mm/debug_vm_pgtable.c                 |   2 +-
>  mm/internal.h                         |   2 +-
>  mm/madvise.c                          |   4 +-
>  mm/memory.c                           |  39 ++++-----
>  mm/mmap.c                             |   9 +--
>  mm/nommu.c                            |   6 +-
>  mm/oom_kill.c                         |   2 +-
>  mm/vma.c                              |  62 +++++++-------
>  mm/vma.h                              |   2 +-
>  net/ipv4/tcp.c                        |   4 +-
>  31 files changed, 164 insertions(+), 136 deletions(-)
> 
> Many of the unmap_* and zap_* functions should get an `mm` parameter
> to make this work.

Ouch, thanks for the attempt!

> So, if we take this route, it should definitely be a separate patch,
> which will likely cause some instability issues for some time until
> all the edge cases are ironed out. I would like to proceed with this
> patch series first before attempting to deprecate vma->detached. Let
> me know if you have objections to this plan.

No objections!

>>
>> >
>> > >
>> > > >
>> > > > >
>> > > > > Either way, we should make it a function so it's easier to reuse for
>> > > > > whatever we need in the future, wdyt?
>> > > > >
>> > > > > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>> > > > >


