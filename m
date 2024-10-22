Return-Path: <linux-kernel+bounces-376467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6189AB202
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D87F1C218C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538A01A3A8A;
	Tue, 22 Oct 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QhOtbnlq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UMJYZj24";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QhOtbnlq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UMJYZj24"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472291A3049
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610842; cv=none; b=OiOKTptO5y1XudC9//9/K0c03ADsTSxj/Dvc64KZPvUXfNFvOTpYwmS4AT4AS2o0Woup4XBJRIWGPl7Dt6vIf43QGpvBTKTlNi+/2AIkdOYAbTYnudCPHtqtdpHhLbKxIm8hkDo5Zm/o3100XeR7qIxgGjWwWeozpy6FoXwYg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610842; c=relaxed/simple;
	bh=i+HcDautwzBYRHvEDRrj8t/bvzvaeqSojEXgpRpoiOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byBwH3Z1PIwqBDt1DTO9MJ8mXZPIYJ/mBRd+MpVMEwvB1cOO0KE0Xs7byMB7DV5oIz+PX22PzfmSy0ccd8EjFxvFqmPdDhjOHQxwdqgb/FFvDw/CskVZ8VGr5wTZGSQDcY2X0J+M/mQbTAolux35iz8wdACLZAzN5diTrLeovn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QhOtbnlq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UMJYZj24; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QhOtbnlq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UMJYZj24; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7634A1F846;
	Tue, 22 Oct 2024 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729610838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=stTIChELFY3z5GVoRuIx6yVNYuSgd3TT7IKngk4wdmQ=;
	b=QhOtbnlqe2CLaNaV+CDN/0x7YbH7b8/1LNdfqx3AZV3e2yU9M3nGq+B16fiU8CDTC0LgH9
	iCC4W1z/Lc0otX0UagkvZJcWkzO214sHMq7doHn3hKwOxmaYyNJxp18qVWAMQK3tNWe0xU
	qvGV5BBsd+gA0WiHsx3dNcWLTCfMEXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729610838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=stTIChELFY3z5GVoRuIx6yVNYuSgd3TT7IKngk4wdmQ=;
	b=UMJYZj24WBfxYlJRSzDDdWpiW388NKS8TMtzb6L9aaQqvR0CLxXMGBThj4U9fumOIESv+9
	6Dam6W7wXAPLtVCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729610838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=stTIChELFY3z5GVoRuIx6yVNYuSgd3TT7IKngk4wdmQ=;
	b=QhOtbnlqe2CLaNaV+CDN/0x7YbH7b8/1LNdfqx3AZV3e2yU9M3nGq+B16fiU8CDTC0LgH9
	iCC4W1z/Lc0otX0UagkvZJcWkzO214sHMq7doHn3hKwOxmaYyNJxp18qVWAMQK3tNWe0xU
	qvGV5BBsd+gA0WiHsx3dNcWLTCfMEXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729610838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=stTIChELFY3z5GVoRuIx6yVNYuSgd3TT7IKngk4wdmQ=;
	b=UMJYZj24WBfxYlJRSzDDdWpiW388NKS8TMtzb6L9aaQqvR0CLxXMGBThj4U9fumOIESv+9
	6Dam6W7wXAPLtVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EA5213AC9;
	Tue, 22 Oct 2024 15:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7IV7FlbEF2eCBgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 22 Oct 2024 15:27:18 +0000
Message-ID: <e283001d-c6f4-49f8-aca6-4e9826d45c9a@suse.cz>
Date: Tue, 22 Oct 2024 17:27:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub/slub_kunit:fix a panic due to __kmalloc_cache_noprof
 incorretly use
Content-Language: en-US
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 xiaopeitux@foxmail.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, xiaopei01@kylinos.cn,
 gehao@kylinso.cn, xiongxin@kylinos.cn
References: <tencent_C1486E2FA393F0B97DD7D308336E262A3407@qq.com>
 <CAJuCfpEpxa=jPAZiu5OP=jwQw0awiYDv6x5sz6-BAmAK40iJ6w@mail.gmail.com>
 <f2b0d4a1-6603-4f46-79bf-5edf40429d4b@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <f2b0d4a1-6603-4f46-79bf-5edf40429d4b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[linux.dev,google.com,foxmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[foxmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 10/22/24 04:19, Hao Ge wrote:
> 
> On 10/22/24 01:42, Suren Baghdasaryan wrote:
>> On Sun, Oct 20, 2024 at 11:59 PM <xiaopeitux@foxmail.com> wrote:
>>> From: Pei Xiao <xiaopei01@kylinos.cn>
>>>
>>> 'modprobe slub_kunit',will have a panic.The root cause is that
>>> __kmalloc_cache_noprof was directly ,which resulted in no alloc_tag
>>> being allocated.This caused current->alloc_tag to be null,leading to
>>> a null pointer dereference in alloc_tag_ref_set.
>> I think the root cause of this crash is the bug that is fixed by
>> https://lore.kernel.org/all/20241020070819.307944-1-hao.ge@linux.dev/.
>> Do you get this crash if you apply that fix?
> Yes, this patch has resolved the panic issue.
>>> Here is the log for the panic:
>>> [   74.779373][ T2158] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
>>> [   74.780130][ T2158] Mem abort info:
>>> [   74.780406][ T2158]   ESR = 0x0000000096000004
>>> [   74.780756][ T2158]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [   74.781225][ T2158]   SET = 0, FnV = 0
>>> [   74.781529][ T2158]   EA = 0, S1PTW = 0
>>> [   74.781836][ T2158]   FSC = 0x04: level 0 translation fault
>>> [   74.782288][ T2158] Data abort info:
>>> [   74.782577][ T2158]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>> [   74.783068][ T2158]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>> [   74.783533][ T2158]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>> [   74.784010][ T2158] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000105f34000
>>> [   74.784586][ T2158] [0000000000000020] pgd=0000000000000000, p4d=0000000000000000
>>> [   74.785293][ T2158] Internal error: Oops: 0000000096000004 [#1] SMP
>>> [   74.785805][ T2158] Modules linked in: slub_kunit kunit ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_mangle 4
>>> [   74.790661][ T2158] CPU: 0 UID: 0 PID: 2158 Comm: kunit_try_catch Kdump: loaded Tainted: G        W        N 6.12.0-rc3+ #2
>>> [   74.791535][ T2158] Tainted: [W]=WARN, [N]=TEST
>>> [   74.791889][ T2158] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>>> [   74.792479][ T2158] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [   74.793101][ T2158] pc : alloc_tagging_slab_alloc_hook+0x120/0x270
>>> [   74.793607][ T2158] lr : alloc_tagging_slab_alloc_hook+0x120/0x270
>>>
>>> [   74.794095][ T2158] sp : ffff800084d33cd0
>>> [   74.794418][ T2158] x29: ffff800084d33cd0 x28: 0000000000000000 x27: 0000000000000000
>>> [   74.795095][ T2158] x26: 0000000000000000 x25: 0000000000000012 x24: ffff80007b30e314
>>> [   74.795822][ T2158] x23: ffff000390ff6f10 x22: 0000000000000000 x21: 0000000000000088
>>> [   74.796555][ T2158] x20: ffff000390285840 x19: fffffd7fc3ef7830 x18: ffffffffffffffff
>>> [   74.797283][ T2158] x17: ffff8000800e63b4 x16: ffff80007b33afc4 x15: ffff800081654c00
>>> [   74.798011][ T2158] x14: 0000000000000000 x13: 205d383531325420 x12: 5b5d383734363537
>>> [   74.798744][ T2158] x11: ffff800084d337e0 x10: 000000000000005d x9 : 00000000ffffffd0
>>> [   74.799476][ T2158] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008219d188 x6 : c0000000ffff7fff
>>> [   74.800206][ T2158] x5 : ffff0003fdbc9208 x4 : ffff800081edd188 x3 : 0000000000000001
>>> [   74.800932][ T2158] x2 : 0beaa6dee1ac5a00 x1 : 0beaa6dee1ac5a00 x0 : ffff80037c2cb000
>>> [   74.801656][ T2158] Call trace:
>>> [   74.801954][ T2158]  alloc_tagging_slab_alloc_hook+0x120/0x270
>>> [   74.802494][ T2158]  __kmalloc_cache_noprof+0x148/0x33c
>>> [   74.802976][ T2158]  test_kmalloc_redzone_access+0x4c/0x104 [slub_kunit]
>>> [   74.803607][ T2158]  kunit_try_run_case+0x70/0x17c [kunit]
>>> [   74.804124][ T2158]  kunit_generic_run_threadfn_adapter+0x2c/0x4c [kunit]
>>> [   74.804768][ T2158]  kthread+0x10c/0x118
>>> [   74.805141][ T2158]  ret_from_fork+0x10/0x20
>>> [   74.805540][ T2158] Code: b9400a80 11000400 b9000a80 97ffd858 (f94012d3)
>>> [   74.806176][ T2158] SMP: stopping secondary CPUs
>>> [   74.808130][ T2158] Starting crashdump kernel...
>>>
>> CC'ing Vlastimil.
>> This patch essentially reverts Vlastimil's "mm, slab: don't wrap
>> internal functions with alloc_hooks()" change. Please check why that
>> change was needed before proceeding.
>> If this change is indeed needed, please add:
> 
> Hi Suren and Vlastimil
> 
> In fact, besides the panic, there is also a warning here due to directly 
> invoking__kmalloc_cache_noprof
> 
> Regarding this, do you have any suggestions?
> 
> [58162.947016] WARNING: CPU: 2 PID: 6210 at 
> ./include/linux/alloc_tag.h:125 alloc_tagging_slab_alloc_hook+0x268/0x27c
> [58162.957721] Call trace:
> [58162.957919]  alloc_tagging_slab_alloc_hook+0x268/0x27c
> [58162.958286]  __kmalloc_cache_noprof+0x14c/0x344
> [58162.958615]  test_kmalloc_redzone_access+0x50/0x10c [slub_kunit]
> [58162.959045]  kunit_try_run_case+0x74/0x184 [kunit]
> [58162.959401]  kunit_generic_run_threadfn_adapter+0x2c/0x4c [kunit]
> [58162.959841]  kthread+0x10c/0x118
> [58162.960093]  ret_from_fork+0x10/0x20
> [58162.960363] ---[ end trace 0000000000000000 ]---

I see.
The kunit test is the only user of __kmalloc_cache_noprof outside of kmalloc()
itself so it's not worth defining again a wrapper for everyone, how about just
wrapping the two callsites?

--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -141,7 +141,7 @@ static void test_kmalloc_redzone_access(struct kunit *test)
 {
        struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
                                SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
-       u8 *p = __kmalloc_cache_noprof(s, GFP_KERNEL, 18);
+       u8 *p = alloc_hooks(__kmalloc_cache_noprof(s, GFP_KERNEL, 18));
 
        kasan_disable_current();
 
@@ -199,7 +199,7 @@ static void test_krealloc_redzone_zeroing(struct kunit *test)
        struct kmem_cache *s = test_kmem_cache_create("TestSlub_krealloc", 64,
                                SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
 
-       p = __kmalloc_cache_noprof(s, GFP_KERNEL, 48);
+       p = alloc_hooks(__kmalloc_cache_noprof(s, GFP_KERNEL, 48));
        memset(p, 0xff, 48);
 
        kasan_disable_current();


