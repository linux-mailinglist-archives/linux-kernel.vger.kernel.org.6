Return-Path: <linux-kernel+bounces-343596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 673CA989D13
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E0CB21212
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EB417C9A3;
	Mon, 30 Sep 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gg0guwVd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQfQ8Gvp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gg0guwVd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pQfQ8Gvp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801217C22A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685772; cv=none; b=a4G6j3GQj1dth/CuUp4J/W3/kFK8gJFSg5wBIFJkpb71X5lITU4v5IOiTL6jl7WBDpMSArPT/KJePV8WlXna1vtjIMqq6iy5W8l2wBe+3cRrQXF/bPfTR+8ka+bcCc6T21eEvCrG2U6SWoQvyQIWmcQo26PrGIH21fJr/J9WHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685772; c=relaxed/simple;
	bh=JlHyvMEltRlbh3M+3uax9iPD2rLoRAQoYRxkWCY8CKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahUPxRB93GeDkTf6wyI5JyGdO7IqcBgCjZ0ja/lEwQjJAzcnPLP58GPKnn4pJXMZrxQKxfoV6CplEQ5mBC5MJKVV5htDwNjtnAV0AXfIF8W1viUfqZNCToURWM9nozrP9IkVq1S0W+DTl+kOLIXI8Qr4e03Rb0zA2jAxLpiDhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gg0guwVd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQfQ8Gvp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gg0guwVd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pQfQ8Gvp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3453D219A4;
	Mon, 30 Sep 2024 08:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727685768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gUodjEKEf+jjW7jxTdoWU4+eU7wL6jszmRfFfKbirkg=;
	b=Gg0guwVd8qOavaW0NFEaU+nMYmNdS6LB63v61aBc2SB9Ic/52qw4GxpE3yUtUjjveptC9s
	Bny+BzWRCSzUF+9+lz70BIXtnVFf+oiraagJcYTNfWwCoaJmusFMpDXAVSIfucwze9z+k0
	qgumb1q31TUXf/p+k2Tz5cjEmeCrL5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727685768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gUodjEKEf+jjW7jxTdoWU4+eU7wL6jszmRfFfKbirkg=;
	b=pQfQ8GvpYCjslBWB64cTNo3u6nYRVDuOyRsf46lG0z1KK5pFOCzySY7ocv/4unDbAm5b6+
	033g0TMoD1L6WzBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727685768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gUodjEKEf+jjW7jxTdoWU4+eU7wL6jszmRfFfKbirkg=;
	b=Gg0guwVd8qOavaW0NFEaU+nMYmNdS6LB63v61aBc2SB9Ic/52qw4GxpE3yUtUjjveptC9s
	Bny+BzWRCSzUF+9+lz70BIXtnVFf+oiraagJcYTNfWwCoaJmusFMpDXAVSIfucwze9z+k0
	qgumb1q31TUXf/p+k2Tz5cjEmeCrL5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727685768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gUodjEKEf+jjW7jxTdoWU4+eU7wL6jszmRfFfKbirkg=;
	b=pQfQ8GvpYCjslBWB64cTNo3u6nYRVDuOyRsf46lG0z1KK5pFOCzySY7ocv/4unDbAm5b6+
	033g0TMoD1L6WzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24C1813A97;
	Mon, 30 Sep 2024 08:42:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wlt/CIhk+mavIAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 30 Sep 2024 08:42:48 +0000
Message-ID: <9b58907e-ed54-48a8-bddc-6febc63ed26e@suse.cz>
Date: Mon, 30 Sep 2024 10:42:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [kunit, slub] 4e1c44b3db:
 WARNING:at_mm/slab_common.c:#kmem_cache_destroy
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
References: <202409292202.ac15a5ad-oliver.sang@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <202409292202.ac15a5ad-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 9/29/24 16:29, kernel test robot wrote:
> 
> hi, Vlastimil Babka,
> 
> we reported
> "[linux-next:master] [kunit, slub] 2377a7d90f: WARNING:at_mm/slab_common.c:#kmem_cache_destroy"
> when this commit is in linux-next/master
> 
> at that time, you mentioned
> "
> Hmm in slub_kunit we generally try to suppress dmesg splats in the kunit
> test context so guess I can do that for this warning as well. Thanks.
> "
> https://lore.kernel.org/all/c393e02b-65f2-4454-ba53-ae0eab5fb279@suse.cz/
> 
> now we noticed the commit is in mainline. we observed same Call Trace so
> just report again FYI. if this is not an issue, please just ignore. if there
> is a follow-up patch and you want us to test, please let us know. thanks!

Yeah thanks, just sent the fix for this:
https://lore.kernel.org/all/20240930-b4-slub-kunit-fix-v1-0-32ca9dbbbc11@suse.cz/

> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_mm/slab_common.c:#kmem_cache_destroy" on:
> 
> commit: 4e1c44b3db79ba910adec32e2e1b920a0e34890a ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      075dbe9f6e3c21596c5245826a4ee1f1c1676eb8]
> [test failed on linux-next/master 40e0c9d414f57d450e3ad03c12765e797fc3fede]
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
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409292202.ac15a5ad-oliver.sang@intel.com
> 
> 
> kern  :warn  : [  127.285267] ------------[ cut here ]------------
> kern :warn : [  127.285361] kmem_cache_destroy TestSlub_kfree_rcu: Slab cache still has objects when called from test_leak_destroy (lib/slub_kunit.c:186) slub_kunit
> kern :warn : [  127.285378] WARNING: CPU: 0 PID: 4079 at mm/slab_common.c:528 kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
> kern  :warn  : [  127.285779] Modules linked in: slub_kunit linear_ranges intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal btrfs intel_powerclamp coretemp kvm_intel kvm blake2b_generic xor raid6_pq libcrc32c crct10dif_pclmul crc32_generic crc32_pclmul crc32c_intel ghash_clmulni_intel sd_mod sg sha512_ssse3 ipmi_devintf rapl ipmi_msghandler intel_cstate i915 ahci libahci libata intel_uncore intel_gtt ttm mei_me drm_display_helper mei drm_kms_helper drm_buddy video wmi fuse drm ip_tables [last unloaded: rational_test]
> kern  :warn  : [  127.286640] CPU: 0 UID: 0 PID: 4079 Comm: kunit_try_catch Tainted: G S  B            N 6.11.0-rc5-00007-g4e1c44b3db79 #1
> kern  :warn  : [  127.286854] Tainted: [S]=CPU_OUT_OF_SPEC, [B]=BAD_PAGE, [N]=TEST
> kern  :warn  : [  127.286982] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
> kern :warn : [  127.287121] RIP: 0010:kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
> kern :warn : [ 127.287224] Code: 8c ff c3 cc cc cc cc e8 97 e4 ab ff eb ad 48 8b 53 60 48 8b 4c 24 10 48 c7 c6 e0 20 55 84 48 c7 c7 68 da ee 84 e8 89 dc 8b ff <0f> 0b e9 28 ff ff ff 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> All code
> ========
>    0:	8c ff                	mov    %?,%edi
>    2:	c3                   	retq   
>    3:	cc                   	int3   
>    4:	cc                   	int3   
>    5:	cc                   	int3   
>    6:	cc                   	int3   
>    7:	e8 97 e4 ab ff       	callq  0xffffffffffabe4a3
>    c:	eb ad                	jmp    0xffffffffffffffbb
>    e:	48 8b 53 60          	mov    0x60(%rbx),%rdx
>   12:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
>   17:	48 c7 c6 e0 20 55 84 	mov    $0xffffffff845520e0,%rsi
>   1e:	48 c7 c7 68 da ee 84 	mov    $0xffffffff84eeda68,%rdi
>   25:	e8 89 dc 8b ff       	callq  0xffffffffff8bdcb3
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
> kern  :warn  : [  127.287539] RSP: 0018:ffffc9000089fd38 EFLAGS: 00010282
> kern  :warn  : [  127.287644] RAX: 0000000000000000 RBX: ffff88816590bb80 RCX: 0000000000000027
> kern  :warn  : [  127.287792] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff8881c0c30b08
> kern  :warn  : [  127.287937] RBP: 0000000000000001 R08: 0000000000000001 R09: ffffed1038186161
> kern  :warn  : [  127.288070] R10: ffff8881c0c30b0b R11: 0000000000000001 R12: ffffc900007bf7b0
> kern  :warn  : [  127.288204] R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc9000089fe40
> kern  :warn  : [  127.288337] FS:  0000000000000000(0000) GS:ffff8881c0c00000(0000) knlGS:0000000000000000
> kern  :warn  : [  127.288486] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kern  :warn  : [  127.288597] CR2: 0000000008082db0 CR3: 0000000124592004 CR4: 00000000001706f0
> kern  :warn  : [  127.288730] DR0: ffffffff87422404 DR1: ffffffff87422405 DR2: ffffffff87422402
> kern  :warn  : [  127.288881] DR3: ffffffff87422403 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> kern  :warn  : [  127.289033] Call Trace:
> kern  :warn  : [  127.289095]  <TASK>
> kern :warn : [  127.289149] ? __warn (kernel/panic.c:741) 
> kern :warn : [  127.289226] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
> kern :warn : [  127.289317] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
> kern :warn : [  127.289399] ? handle_bug (arch/x86/kernel/traps.c:239) 
> kern :warn : [  127.289478] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
> kern :warn : [  127.289561] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> kern :warn : [  127.289651] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
> kern :warn : [  127.289757] ? kmem_cache_destroy (mm/slab_common.c:528 mm/slab_common.c:504) 
> kern :warn : [  127.289864] test_leak_destroy (lib/slub_kunit.c:186) slub_kunit
> kern :warn : [  127.289977] ? __pfx_test_leak_destroy (lib/slub_kunit.c:179) slub_kunit
> kern :warn : [  127.290091] ? __kunit_add_resource (lib/kunit/resource.c:44) 
> kern :warn : [  127.290187] ? __pfx_read_tsc (arch/x86/kernel/tsc.c:1130) 
> kern :warn : [  127.290271] ? ktime_get_ts64 (kernel/time/timekeeping.c:378 (discriminator 4) kernel/time/timekeeping.c:395 (discriminator 4) kernel/time/timekeeping.c:403 (discriminator 4) kernel/time/timekeeping.c:983 (discriminator 4)) 
> kern :warn : [  127.290356] ? test_init (lib/slub_kunit.c:196) slub_kunit
> kern :warn : [  127.290454] kunit_try_run_case (lib/kunit/test.c:400 lib/kunit/test.c:443) 
> kern :warn : [  127.290543] ? __pfx_kunit_try_run_case (lib/kunit/test.c:430) 
> kern :warn : [  127.290640] ? set_cpus_allowed_ptr (kernel/sched/core.c:3025) 
> kern :warn : [  127.290732] ? __pfx_set_cpus_allowed_ptr (kernel/sched/core.c:3025) 
> kern :warn : [  127.290847] ? __pfx_kunit_try_run_case (lib/kunit/test.c:430) 
> kern :warn : [  127.290959] ? __pfx_kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:26) 
> kern :warn : [  127.291087] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:31) 
> kern :warn : [  127.291195] kthread (kernel/kthread.c:389) 
> kern :warn : [  127.291269] ? __pfx_kthread (kernel/kthread.c:342) 
> kern :warn : [  127.291350] ret_from_fork (arch/x86/kernel/process.c:153) 
> kern :warn : [  127.291429] ? __pfx_kthread (kernel/kthread.c:342) 
> kern :warn : [  127.291510] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> kern  :warn  : [  127.291595]  </TASK>
> kern  :warn  : [  127.291650] ---[ end trace 0000000000000000 ]---
> kern  :info  : [  127.292358]     ok 5 test_leak_destroy
> kern  :info  : [  127.292386] # slub_test: pass:5 fail:0 skip:0 total:5
> kern  :info  : [  127.292500] # Totals: pass:5 fail:0 skip:0 total:5
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240929/202409292202.ac15a5ad-oliver.sang@intel.com
> 
> 
> 


