Return-Path: <linux-kernel+bounces-353556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA886992F6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5268E1F22F94
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950051D90CA;
	Mon,  7 Oct 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hm+CZYXv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DdhsUgkI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hm+CZYXv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DdhsUgkI"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED651D6DB7
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311386; cv=none; b=O0eghwByhgkSzTtYcBpZteNs+Gzphvbus3m04hY6IVZeRfl/0kZb9zrSGdPpXBbfmGTaJbDPOrTKG72P5AOVpnyP7yEUb6ryZn0mrnqUICpLOMnLa5MQfWaOFmqKlvfOzHCqBnbosynZOEPcyWO1wBXM9aEj5Gs5/N3iqx8u10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311386; c=relaxed/simple;
	bh=9nfrcwi0dAfrqY3Psg8p6wnDb2OB29ylyJW2LSkiEVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tntmswsu5QSTn7h1fh/XDeRXYODnfeVzCH2OKWihuf/AjbWzUX0hKPqLvLoOFsB8rTnu0OMEf8EFxyAA1XzdWdhtqbeZU1ie6dw43A+agcIvbq4E7VDYDGHfYuuRmvnWWH3fxpWJMzLm5kPj1J3zB2hWwGoOXQdXqCzDLeDoYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hm+CZYXv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DdhsUgkI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hm+CZYXv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DdhsUgkI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22B4821B48;
	Mon,  7 Oct 2024 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728311382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqeC6yRLIByxwptzrSPfkFVxBUecAj5DsHrdwlhB7uM=;
	b=Hm+CZYXv08sNWelqASawDnTBI7hZp5+Ya9Lm4XxlqdaWxwKMF2ZYmPCTjAzx71F2SS2m7/
	2iuwLycolFXi+pnlu5qbLsiowgcf+UwzcA1AqRC80f/yHL94emKJ0wv6LTpA0Nuge0Rusk
	VqgoBcVeJQlQUMKhFZok6lzQduhLgXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728311382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqeC6yRLIByxwptzrSPfkFVxBUecAj5DsHrdwlhB7uM=;
	b=DdhsUgkICybHapFuvYMU9c4iAIZogz1b2yOBrPni5Szb18WtOXzCJtsJL08F3CFhsTmZ+E
	JekHg1ExM1ckjZBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728311382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqeC6yRLIByxwptzrSPfkFVxBUecAj5DsHrdwlhB7uM=;
	b=Hm+CZYXv08sNWelqASawDnTBI7hZp5+Ya9Lm4XxlqdaWxwKMF2ZYmPCTjAzx71F2SS2m7/
	2iuwLycolFXi+pnlu5qbLsiowgcf+UwzcA1AqRC80f/yHL94emKJ0wv6LTpA0Nuge0Rusk
	VqgoBcVeJQlQUMKhFZok6lzQduhLgXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728311382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqeC6yRLIByxwptzrSPfkFVxBUecAj5DsHrdwlhB7uM=;
	b=DdhsUgkICybHapFuvYMU9c4iAIZogz1b2yOBrPni5Szb18WtOXzCJtsJL08F3CFhsTmZ+E
	JekHg1ExM1ckjZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D1CE13786;
	Mon,  7 Oct 2024 14:29:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8dBYAlbwA2etegAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 07 Oct 2024 14:29:42 +0000
Message-ID: <b304fe39-4fcc-4b2b-a95f-1bb476c94a01@suse.cz>
Date: Mon, 7 Oct 2024 16:29:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slub: Avoid list corruption when removing a slab
 from the full list
To: "yuan.gao" <yuan.gao@ucloud.cn>, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241007091850.16959-1-yuan.gao@ucloud.cn>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20241007091850.16959-1-yuan.gao@ucloud.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_TO(0.00)[ucloud.cn,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/7/24 11:18 AM, yuan.gao wrote:
> boot with slub_debug=UFPZ.
> 
> If allocated object failed in alloc_consistency_checks, all objects of
> the slab will be marked as used, and then the slab will be removed from
> the partial list.
> 
> When an object belonging to the slab got freed later, the remove_full()
> function is called. Because the slab is neither on the partial list nor
> on the full list, it eventually lead to a list corruption.
> 
> So we need to add the slab to full list in this case.
> 
> [ 4277.385669] list_del corruption, ffffea00044b3e50->next is LIST_POISON1 (dead000000000100)
> [ 4277.387023] ------------[ cut here ]------------
> [ 4277.387880] kernel BUG at lib/list_debug.c:56!
> [ 4277.388680] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [ 4277.389562] CPU: 5 PID: 90 Comm: kworker/5:1 Kdump: loaded Tainted: G           OE      6.6.1-1 #1
> [ 4277.392113] Workqueue: xfs-inodegc/vda1 xfs_inodegc_worker [xfs]
> [ 4277.393551] RIP: 0010:__list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.394518] Code: 48 91 82 e8 37 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 28 49 91 82 e8 26 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 58 49 91
> [ 4277.397292] RSP: 0018:ffffc90000333b38 EFLAGS: 00010082
> [ 4277.398202] RAX: 000000000000004e RBX: ffffea00044b3e50 RCX: 0000000000000000
> [ 4277.399340] RDX: 0000000000000002 RSI: ffffffff828f8715 RDI: 00000000ffffffff
> [ 4277.400545] RBP: ffffea00044b3e40 R08: 0000000000000000 R09: ffffc900003339f0
> [ 4277.401710] R10: 0000000000000003 R11: ffffffff82d44088 R12: ffff888112cf9910
> [ 4277.402887] R13: 0000000000000001 R14: 0000000000000001 R15: ffff8881000424c0
> [ 4277.404049] FS:  0000000000000000(0000) GS:ffff88842fd40000(0000) knlGS:0000000000000000
> [ 4277.405357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4277.406389] CR2: 00007f2ad0b24000 CR3: 0000000102a3a006 CR4: 00000000007706e0
> [ 4277.407589] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 4277.408780] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 4277.410000] PKRU: 55555554
> [ 4277.410645] Call Trace:
> [ 4277.411234]  <TASK>
> [ 4277.411777]  ? die+0x32/0x80
> [ 4277.412439]  ? do_trap+0xd6/0x100
> [ 4277.413150]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.414158]  ? do_error_trap+0x6a/0x90
> [ 4277.414948]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.415915]  ? exc_invalid_op+0x4c/0x60
> [ 4277.416710]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.417675]  ? asm_exc_invalid_op+0x16/0x20
> [ 4277.418482]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.419466]  ? __list_del_entry_valid_or_report+0x7b/0xc0
> [ 4277.420410]  free_to_partial_list+0x515/0x5e0
> [ 4277.421242]  ? xfs_iext_remove+0x41a/0xa10 [xfs]
> [ 4277.422298]  xfs_iext_remove+0x41a/0xa10 [xfs]
> [ 4277.423316]  ? xfs_inodegc_worker+0xb4/0x1a0 [xfs]
> [ 4277.424383]  xfs_bmap_del_extent_delay+0x4fe/0x7d0 [xfs]
> [ 4277.425490]  __xfs_bunmapi+0x50d/0x840 [xfs]
> [ 4277.426445]  xfs_itruncate_extents_flags+0x13a/0x490 [xfs]
> [ 4277.427553]  xfs_inactive_truncate+0xa3/0x120 [xfs]
> [ 4277.428567]  xfs_inactive+0x22d/0x290 [xfs]
> [ 4277.429500]  xfs_inodegc_worker+0xb4/0x1a0 [xfs]
> [ 4277.430479]  process_one_work+0x171/0x340
> [ 4277.431227]  worker_thread+0x277/0x390
> [ 4277.431962]  ? __pfx_worker_thread+0x10/0x10
> [ 4277.432752]  kthread+0xf0/0x120
> [ 4277.433382]  ? __pfx_kthread+0x10/0x10
> [ 4277.434134]  ret_from_fork+0x2d/0x50
> [ 4277.434837]  ? __pfx_kthread+0x10/0x10
> [ 4277.435566]  ret_from_fork_asm+0x1b/0x30
> [ 4277.436280]  </TASK>
> 
> v2:
> * Call remove_partial() and add_full() only for slab folios.
> 
> v1:
> https://lore.kernel.org/linux-mm/20241006044755.79634-1-yuan.gao@ucloud.cn/
> 
> Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>

Is it possible to determine which commit introduced this issue, for a
stable cc?

Also in addition to what Hyeonggon proposed, we should perhaps mark
these consistency-failed slabs in a way that further freeing of objects
in them will also don't actually free anything, and thus not move the
slab back from full to partial list for further reuse. Right now the
(understandable) attempt to not use the corrupted slab further is only
partially successful.

> ---
>  mm/slub.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 21f71cb6cc06..2992388c00f4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2745,7 +2745,10 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
>  	slab->inuse++;
>  
>  	if (!alloc_debug_processing(s, slab, object, orig_size)) {
> -		remove_partial(n, slab);
> +		if (folio_test_slab(slab_folio(slab))) {
> +			remove_partial(n, slab);
> +			add_full(s, n, slab);
> +		}
>  		return NULL;
>  	}
>  

