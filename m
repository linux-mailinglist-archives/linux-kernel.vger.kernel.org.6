Return-Path: <linux-kernel+bounces-302145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F3395FA86
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7E11C219CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858FB199EB7;
	Mon, 26 Aug 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lI/hoGPG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lk40V9q8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lI/hoGPG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lk40V9q8"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E7199E81
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703559; cv=none; b=Svc0dVqYEst28o93KIH4wOGk1zeiItU574W2ipJYlatHkNwaj/tejrL/aeg9yCWBuPM0XBN0FTIVj23/e1WyvSSXha4MVojQD3oCx2Q8LGwDcnSIUz6iYZF0q/NlLgO2FzkQCguoZoZMNn51UAjQv+RkfN9oUi/Gxmr+ZsszJNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703559; c=relaxed/simple;
	bh=VaQ3+t399TGQ7Ctu9YaHt4gsUxNzuNbmR1GnQwYIkUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5mq5ofc/QKlkc27fKrLBXXcZqFPAINP4XvCCyttzplUrvsqfLgzwX0zFu/en6/gqSM4d8XPV/nGgkFDThh8MhAZlk31nkVrLyJkpoeyIT7Y/pmaQd+HbLwAl9cpWlrxDu74+6EK7JzA04M64FBv8hii8WarH/uQt6RZKpiM1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lI/hoGPG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lk40V9q8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lI/hoGPG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lk40V9q8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CBB621ADC;
	Mon, 26 Aug 2024 20:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724703555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qsm82HEIIclfzzfbulnPr6ndDlBXDcyN8bM/VrY5ryU=;
	b=lI/hoGPGM1p4KsswyDJY3DM1HY1qOvQeUeXIHsOW3/OaIOGBPBln8Lek581KLubzryZVT2
	UaOn4/UELmOdds/GvEwSl61UftsIxIIOr7twfWP5cpbamyEu5uHjPlfUQ3PEUydxb+7Hlz
	WmuqbcwhcZnkyhLL5KdN2ugDPnkWquE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724703555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qsm82HEIIclfzzfbulnPr6ndDlBXDcyN8bM/VrY5ryU=;
	b=Lk40V9q8vgqME6YrPTTFHe+s0tJUFofrRWefgH27Od+8jqrSnMT5PsA33qUP+ORe3mlBUc
	DS1Y3yXKlz9xEYBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="lI/hoGPG";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Lk40V9q8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724703555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qsm82HEIIclfzzfbulnPr6ndDlBXDcyN8bM/VrY5ryU=;
	b=lI/hoGPGM1p4KsswyDJY3DM1HY1qOvQeUeXIHsOW3/OaIOGBPBln8Lek581KLubzryZVT2
	UaOn4/UELmOdds/GvEwSl61UftsIxIIOr7twfWP5cpbamyEu5uHjPlfUQ3PEUydxb+7Hlz
	WmuqbcwhcZnkyhLL5KdN2ugDPnkWquE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724703555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qsm82HEIIclfzzfbulnPr6ndDlBXDcyN8bM/VrY5ryU=;
	b=Lk40V9q8vgqME6YrPTTFHe+s0tJUFofrRWefgH27Od+8jqrSnMT5PsA33qUP+ORe3mlBUc
	DS1Y3yXKlz9xEYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AF4413724;
	Mon, 26 Aug 2024 20:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ujvmEUPjzGYYRQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Aug 2024 20:19:15 +0000
Message-ID: <c393e02b-65f2-4454-ba53-ae0eab5fb279@suse.cz>
Date: Mon, 26 Aug 2024 22:19:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [kunit, slub] 2377a7d90f:
 WARNING:at_mm/slab_common.c:#kmem_cache_destroy
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org
References: <202408251723.42f3d902-oliver.sang@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <202408251723.42f3d902-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5CBB621ADC
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,intel.com:email,01.org:url];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 8/25/24 11:25, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_mm/slab_common.c:#kmem_cache_destroy" on:
> 
> commit: 2377a7d90f5bb2ccc302b5fb0e6ba4c67cf24ddd ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

Hmm in slub_kunit we generally try to suppress dmesg splats in the kunit
test context so guess I can do that for this warning as well. Thanks.

> [test failed on linux-next/master c79c85875f1af04040fe4492ed94ce37ad729c4d]
> 
> in testcase: kunit
> version: 
> with following parameters:
> 
> 	group: group-00
> 
> 
> 
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408251723.42f3d902-oliver.sang@intel.com
> 
> 
> kern  :warn  : [  402.601850] ------------[ cut here ]------------
> kern :warn : [  402.602683] kmem_cache_destroy TestSlub_kfree_rcu: Slab cache still has objects when called from test_leak_destroy (lib/slub_kunit.c:186) slub_kunit
> kern :warn : [  402.602700] WARNING: CPU: 0 PID: 4936 at mm/slab_common.c:528 kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
> kern  :warn  : [  402.605758] Modules linked in: slub_kunit linear_ranges intel_rapl_msr intel_rapl_common skx_edac_common nfit sd_mod sg libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc32_generic crc32_pclmul ghash_clmulni_intel sha512_ssse3 btrfs blake2b_generic xor raid6_pq libcrc32c snd_soc_avs snd_soc_hda_codec snd_hda_ext_core snd_hda_codec snd_hda_core snd_intel_dspcfg crc32c_intel rapl snd_soc_core snd_compress ahci snd_pcm libahci intel_cstate ipmi_devintf ipmi_msghandler nvme intel_uncore wmi_bmof intel_wmi_thunderbolt mxm_wmi wdat_wdt snd_timer mei_me libata nvme_core snd ioatdma mei soundcore dca wmi binfmt_misc drm fuse loop dm_mod ip_tables cts xts [last unloaded: rational_test]
> kern  :warn  : [  402.613823] CPU: 0 UID: 0 PID: 4936 Comm: kunit_try_catch Tainted: G    B            N 6.11.0-rc2-00008-g2377a7d90f5b #1
> kern  :warn  : [  402.615894] Tainted: [B]=BAD_PAGE, [N]=TEST
> kern  :warn  : [  402.616872] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
> kern :warn : [  402.618338] RIP: 0010:kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
> kern :warn : [ 402.619412] Code: 8c ff c3 cc cc cc cc e8 57 e0 ab ff eb ad 48 8b 53 60 48 8b 4c 24 10 48 c7 c6 20 21 55 84 48 c7 c7 d0 b9 ee 84 e8 a9 d4 8b ff <0f> 0b e9 28 ff ff ff 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> All code
> ========
>    0:	8c ff                	mov    %?,%edi
>    2:	c3                   	retq   
>    3:	cc                   	int3   
>    4:	cc                   	int3   
>    5:	cc                   	int3   
>    6:	cc                   	int3   
>    7:	e8 57 e0 ab ff       	callq  0xffffffffffabe063
>    c:	eb ad                	jmp    0xffffffffffffffbb
>    e:	48 8b 53 60          	mov    0x60(%rbx),%rdx
>   12:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
>   17:	48 c7 c6 20 21 55 84 	mov    $0xffffffff84552120,%rsi
>   1e:	48 c7 c7 d0 b9 ee 84 	mov    $0xffffffff84eeb9d0,%rdi
>   25:	e8 a9 d4 8b ff       	callq  0xffffffffff8bd4d3
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	e9 28 ff ff ff       	jmpq   0xffffffffffffff59
>   31:	66 90                	xchg   %ax,%ax
>   33:	90                   	nop
>   34:	90                   	nop
>   35:	90                   	nop
>   36:	90                   	nop
>   37:	90                   	nop
>   38:	90                   	nop
>   39:	90                   	nop
>   3a:	90                   	nop
>   3b:	90                   	nop
>   3c:	90                   	nop
>   3d:	90                   	nop
>   3e:	90                   	nop
>   3f:	90                   	nop
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	e9 28 ff ff ff       	jmpq   0xffffffffffffff2f
>    7:	66 90                	xchg   %ax,%ax
>    9:	90                   	nop
>    a:	90                   	nop
>    b:	90                   	nop
>    c:	90                   	nop
>    d:	90                   	nop
>    e:	90                   	nop
>    f:	90                   	nop
>   10:	90                   	nop
>   11:	90                   	nop
>   12:	90                   	nop
>   13:	90                   	nop
>   14:	90                   	nop
>   15:	90                   	nop
> kern  :warn  : [  402.622288] RSP: 0018:ffffc9000300fd38 EFLAGS: 00010282
> kern  :warn  : [  402.623454] RAX: 0000000000000000 RBX: ffff8881ac7a88c0 RCX: 0000000000000027
> kern  :warn  : [  402.624796] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff889fc3230b08
> kern  :warn  : [  402.626072] RBP: 0000000000000001 R08: 0000000000000001 R09: ffffed13f8646161
> kern  :warn  : [  402.627396] R10: ffff889fc3230b0b R11: 0000000000000001 R12: ffffc900009877c8
> kern  :warn  : [  402.628741] R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc9000300fe40
> kern  :warn  : [  402.630015] FS:  0000000000000000(0000) GS:ffff889fc3200000(0000) knlGS:0000000000000000
> kern  :warn  : [  402.631431] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kern  :warn  : [  402.632653] CR2: 000056455377c3b0 CR3: 000000209c662004 CR4: 00000000003706f0
> kern  :warn  : [  402.633979] DR0: ffffffff8741b384 DR1: ffffffff8741b385 DR2: ffffffff8741b382
> kern  :warn  : [  402.635257] DR3: ffffffff8741b383 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> kern  :warn  : [  402.636580] Call Trace:
> kern  :warn  : [  402.637518]  <TASK>
> kern :warn : [  402.638397] ? __warn (kernel/panic.c:735) 
> kern :warn : [  402.639368] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
> kern :warn : [  402.640432] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
> kern :warn : [  402.641445] ? handle_bug (arch/x86/kernel/traps.c:239) 
> kern :warn : [  402.642443] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
> kern :warn : [  402.643469] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> kern :warn : [  402.644529] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
> kern :warn : [  402.645601] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
> kern :warn : [  402.646668] test_leak_destroy (lib/slub_kunit.c:186) slub_kunit
> kern :warn : [  402.647868] ? __pfx_test_leak_destroy (lib/slub_kunit.c:179) slub_kunit
> kern :warn : [  402.649054] ? __kunit_add_resource (lib/kunit/resource.c:44) 
> kern :warn : [  402.650182] ? ktime_get_ts64 (kernel/time/timekeeping.c:195 (discriminator 4) kernel/time/timekeeping.c:395 (discriminator 4) kernel/time/timekeeping.c:403 (discriminator 4) kernel/time/timekeeping.c:983 (discriminator 4)) 
> kern :warn : [  402.651224] ? test_init (lib/slub_kunit.c:196) slub_kunit
> kern :warn : [  402.652347] kunit_try_run_case (lib/kunit/test.c:398 lib/kunit/test.c:443) 
> kern :warn : [  402.653447] ? __pfx_kunit_try_run_case (lib/kunit/test.c:430) 
> kern :warn : [  402.654525] ? set_cpus_allowed_ptr (kernel/sched/core.c:3025) 
> kern :warn : [  402.655563] ? __pfx_set_cpus_allowed_ptr (kernel/sched/core.c:3025) 
> kern :warn : [  402.656629] ? __pfx_kunit_try_run_case (lib/kunit/test.c:430) 
> kern :warn : [  402.657662] ? __pfx_kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:26) 
> kern :warn : [  402.658854] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:30) 
> kern :warn : [  402.659920] kthread (kernel/kthread.c:389) 
> kern :warn : [  402.660818] ? __pfx_kthread (kernel/kthread.c:342) 
> kern :warn : [  402.661706] ret_from_fork (arch/x86/kernel/process.c:147) 
> kern :warn : [  402.662601] ? __pfx_kthread (kernel/kthread.c:342) 
> kern :warn : [  402.663457] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> kern  :warn  : [  402.664326]  </TASK>
> kern  :warn  : [  402.665053] ---[ end trace 0000000000000000 ]---
> kern  :info  : [  402.666287]     ok 5 test_leak_destroy
> kern  :info  : [  402.666297] # slub_test: pass:5 fail:0 skip:0 total:5
> kern  :info  : [  402.667126] # Totals: pass:5 fail:0 skip:0 total:5
> kern  :info  : [  402.668029] ok 1 slub_test
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240825/202408251723.42f3d902-oliver.sang@intel.com
> 
> 
> 


