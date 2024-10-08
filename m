Return-Path: <linux-kernel+bounces-354965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CFD994547
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E421F243AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1FE19409C;
	Tue,  8 Oct 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q+DdWF5+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rc3uv1i7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q+DdWF5+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rc3uv1i7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BAD18B464
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383137; cv=none; b=qqHNy/EWn27ZRiO9LwLjsEDzSDaBp0NYkQ8ct4hzkAZaB8HZYLUFmlxVs9ZWKPk0fxL7zDE4NoytRJ2Io/c9/Uq3iwSjK0w7Eoe3N8gLd54j8xT47NBlFCtF36LTzuZy6xvJvTJalciKLAYAljxY5QlpQDU3BbKSS9KPSB5Xz1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383137; c=relaxed/simple;
	bh=1MoLyrzimlztuzTL2qgc8gAFnKP8aA9h8Gy1buE9sTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhQJ8COMzfWgQDNSFniqurpce1WGIq1VBI8Fn3QHio58jIqJHfC++CsPtanyTYfNUWWB5ZDzuaiIZuHZIjqG9PanqVjo5oFGpr372iqb2EF/gAwPzFQ/ODSaijyD8esZcVd30EIYPeVfohP7jcoBKIAKIwziy9Y23pxKe2Cuwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q+DdWF5+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rc3uv1i7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q+DdWF5+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rc3uv1i7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 460DC1F7A5;
	Tue,  8 Oct 2024 10:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728383133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bs+wB4ARjzJ6DuArhuiBMRFt2CgFM4qsZXVRe6iWT6Y=;
	b=q+DdWF5+BXM1SLm7aO2Ftz8bpNmP+Tv0Fa/G2yoHA8VVlOOkmm1cljw2l8/h/zJB8Wkm9h
	da8/9ycCmu6jIQB+w4cIIoqOQvmdQ0a+kPKgrUQMzs1oiDnQWcu8KzYVhZzGHr7PR901+n
	OB1iL/TsBoa3/zEIr1z9bcyuDsaD5fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728383133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bs+wB4ARjzJ6DuArhuiBMRFt2CgFM4qsZXVRe6iWT6Y=;
	b=Rc3uv1i7oO1oHW17xDmL5XmTRNFpWAk0OtzxQnDVxpGqNySJbBifZq/8LfchcWMIStqPxt
	UX8EIRX4+LGtVPBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q+DdWF5+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Rc3uv1i7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728383133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bs+wB4ARjzJ6DuArhuiBMRFt2CgFM4qsZXVRe6iWT6Y=;
	b=q+DdWF5+BXM1SLm7aO2Ftz8bpNmP+Tv0Fa/G2yoHA8VVlOOkmm1cljw2l8/h/zJB8Wkm9h
	da8/9ycCmu6jIQB+w4cIIoqOQvmdQ0a+kPKgrUQMzs1oiDnQWcu8KzYVhZzGHr7PR901+n
	OB1iL/TsBoa3/zEIr1z9bcyuDsaD5fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728383133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bs+wB4ARjzJ6DuArhuiBMRFt2CgFM4qsZXVRe6iWT6Y=;
	b=Rc3uv1i7oO1oHW17xDmL5XmTRNFpWAk0OtzxQnDVxpGqNySJbBifZq/8LfchcWMIStqPxt
	UX8EIRX4+LGtVPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24861137CF;
	Tue,  8 Oct 2024 10:25:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yySPCJ0IBWcnSwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 08 Oct 2024 10:25:33 +0000
Message-ID: <b48aa984-04a3-47e1-a8be-2a58d48a7b69@suse.cz>
Date: Tue, 8 Oct 2024 12:25:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slub: Avoid list corruption when removing a slab
 from the full list
Content-Language: en-US
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: "yuan.gao" <yuan.gao@ucloud.cn>, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241007091850.16959-1-yuan.gao@ucloud.cn>
 <b304fe39-4fcc-4b2b-a95f-1bb476c94a01@suse.cz>
 <CAB=+i9T4nGJAQGpYSbAvyyfgceLmO6ih=gS7bPpvCdMMetTurw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAB=+i9T4nGJAQGpYSbAvyyfgceLmO6ih=gS7bPpvCdMMetTurw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 460DC1F7A5
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 10/7/24 17:03, Hyeonggon Yoo wrote:
> On Mon, Oct 7, 2024 at 11:29 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 10/7/24 11:18 AM, yuan.gao wrote:
>> > boot with slub_debug=UFPZ.
>> >
>> > If allocated object failed in alloc_consistency_checks, all objects of
>> > the slab will be marked as used, and then the slab will be removed from
>> > the partial list.
>> >
>> > When an object belonging to the slab got freed later, the remove_full()
>> > function is called. Because the slab is neither on the partial list nor
>> > on the full list, it eventually lead to a list corruption.
>> >
>> > So we need to add the slab to full list in this case.
>> >
>> > [ 4277.385669] list_del corruption, ffffea00044b3e50->next is LIST_POISON1 (dead000000000100)
>> > [ 4277.387023] ------------[ cut here ]------------
>> > [ 4277.387880] kernel BUG at lib/list_debug.c:56!
>> > [ 4277.388680] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>> > [ 4277.389562] CPU: 5 PID: 90 Comm: kworker/5:1 Kdump: loaded Tainted: G           OE      6.6.1-1 #1
>> > [ 4277.392113] Workqueue: xfs-inodegc/vda1 xfs_inodegc_worker [xfs]
>> > [ 4277.393551] RIP: 0010:__list_del_entry_valid_or_report+0x7b/0xc0
>> > [ 4277.394518] Code: 48 91 82 e8 37 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 28 49 91 82 e8 26 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 58 49 91
>> > [ 4277.397292] RSP: 0018:ffffc90000333b38 EFLAGS: 00010082
>> > [ 4277.398202] RAX: 000000000000004e RBX: ffffea00044b3e50 RCX: 0000000000000000
>> > [ 4277.399340] RDX: 0000000000000002 RSI: ffffffff828f8715 RDI: 00000000ffffffff
>> > [ 4277.400545] RBP: ffffea00044b3e40 R08: 0000000000000000 R09: ffffc900003339f0
>> > [ 4277.401710] R10: 0000000000000003 R11: ffffffff82d44088 R12: ffff888112cf9910
>> > [ 4277.402887] R13: 0000000000000001 R14: 0000000000000001 R15: ffff8881000424c0
>> > [ 4277.404049] FS:  0000000000000000(0000) GS:ffff88842fd40000(0000) knlGS:0000000000000000
>> > [ 4277.405357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [ 4277.406389] CR2: 00007f2ad0b24000 CR3: 0000000102a3a006 CR4: 00000000007706e0
>> > [ 4277.407589] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> > [ 4277.408780] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> > [ 4277.410000] PKRU: 55555554
>> > [ 4277.410645] Call Trace:
>> > [ 4277.411234]  <TASK>
>> > [ 4277.411777]  ? die+0x32/0x80
>> > [ 4277.412439]  ? do_trap+0xd6/0x100
>> > [ 4277.413150]  ? __list_del_entry_valid_or_report+0x7b/0xc0
>> > [ 4277.414158]  ? do_error_trap+0x6a/0x90
>> > [ 4277.414948]  ? __list_del_entry_valid_or_report+0x7b/0xc0
>> > [ 4277.415915]  ? exc_invalid_op+0x4c/0x60
>> > [ 4277.416710]  ? __list_del_entry_valid_or_report+0x7b/0xc0
>> > [ 4277.417675]  ? asm_exc_invalid_op+0x16/0x20
>> > [ 4277.418482]  ? __list_del_entry_valid_or_report+0x7b/0xc0
>> > [ 4277.419466]  ? __list_del_entry_valid_or_report+0x7b/0xc0
>> > [ 4277.420410]  free_to_partial_list+0x515/0x5e0
>> > [ 4277.421242]  ? xfs_iext_remove+0x41a/0xa10 [xfs]
>> > [ 4277.422298]  xfs_iext_remove+0x41a/0xa10 [xfs]
>> > [ 4277.423316]  ? xfs_inodegc_worker+0xb4/0x1a0 [xfs]
>> > [ 4277.424383]  xfs_bmap_del_extent_delay+0x4fe/0x7d0 [xfs]
>> > [ 4277.425490]  __xfs_bunmapi+0x50d/0x840 [xfs]
>> > [ 4277.426445]  xfs_itruncate_extents_flags+0x13a/0x490 [xfs]
>> > [ 4277.427553]  xfs_inactive_truncate+0xa3/0x120 [xfs]
>> > [ 4277.428567]  xfs_inactive+0x22d/0x290 [xfs]
>> > [ 4277.429500]  xfs_inodegc_worker+0xb4/0x1a0 [xfs]
>> > [ 4277.430479]  process_one_work+0x171/0x340
>> > [ 4277.431227]  worker_thread+0x277/0x390
>> > [ 4277.431962]  ? __pfx_worker_thread+0x10/0x10
>> > [ 4277.432752]  kthread+0xf0/0x120
>> > [ 4277.433382]  ? __pfx_kthread+0x10/0x10
>> > [ 4277.434134]  ret_from_fork+0x2d/0x50
>> > [ 4277.434837]  ? __pfx_kthread+0x10/0x10
>> > [ 4277.435566]  ret_from_fork_asm+0x1b/0x30
>> > [ 4277.436280]  </TASK>
>> >
>> > v2:
>> > * Call remove_partial() and add_full() only for slab folios.
>> >
>> > v1:
>> > https://lore.kernel.org/linux-mm/20241006044755.79634-1-yuan.gao@ucloud.cn/
>> >
>> > Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
>>
>> Is it possible to determine which commit introduced this issue, for a
>> stable cc?
> 
> By code inspection I suspect it's around when SLUB's first introduced in 2007,
> more specifically commit 643b113849d8 ("slub: enable tracking of full slabs").
> Even v2.6 kernels do not seem to handle this case correctly.
> 
>> Also in addition to what Hyeonggon proposed, we should perhaps mark
>> these consistency-failed slabs in a way that further freeing of objects
>> in them will also don't actually free anything, and thus not move the
>> slab back from full to partial list for further reuse.
> 
> Yeah I was thinking of that too.
> 
> If that is feasible Yuan you may use one bit from (in mm/slab.h)
> struct slab's 'inuse' field
> and change it to 15 bits to mark consistency-failed slabs.
> 
> IIUC 'inuse' doesn't have to be 16 bits and 'objects' is already 15
> bits, so I think it should be fine.

AFAICS we are in a rather comfortable position for the debug caches which
avoid all the fastpaths, and we could simply reuse the frozen bit or invent
a special value for slab->freelist?

Either way it should boil down to free_debug_processing() detecting such a
slab (or perhaps in check_slab()) and returning false/0 immediately which
would avoid further actions on the slab.

If it was done in check_slab() then free_debug_processing() would at least
report which of the objects in a broken slab were attempted to be freed
after it was marked broken, which could perhaps be useful:

   slab_fix(s, "Object at 0x%p not freed", object);

Vlastimil

>> Right now the
>> (understandable) attempt to not use the corrupted slab further is only
>> partially successful.
> 
> Best,
> Hyeonggon
> 
>> > ---
>> >  mm/slub.c | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/mm/slub.c b/mm/slub.c
>> > index 21f71cb6cc06..2992388c00f4 100644
>> > --- a/mm/slub.c
>> > +++ b/mm/slub.c
>> > @@ -2745,7 +2745,10 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
>> >       slab->inuse++;
>> >
>> >       if (!alloc_debug_processing(s, slab, object, orig_size)) {
>> > -             remove_partial(n, slab);
>> > +             if (folio_test_slab(slab_folio(slab))) {
>> > +                     remove_partial(n, slab);
>> > +                     add_full(s, n, slab);
>> > +             }
>> >               return NULL;
>> >       }
>> >


