Return-Path: <linux-kernel+bounces-308625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E37DF965FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6601F29190
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F21428E2;
	Fri, 30 Aug 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ioY2orQ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9717DFF3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015200; cv=none; b=lRfPCU+wJIbMDuJT+HzDo6/1g5YrNfacnxO+MnqUKMEogKOXoC5OpKP47hjxLnGvAIuFQv3HOyju7te3UjlsxnlKvvXoU9Do8c4f/6C/Xkgx+s5J2XqcZxq/E+VxnK59xq4BllbIGKNIA6dEmMkh60aX8Dju/4/sOvtCvhMv3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015200; c=relaxed/simple;
	bh=wuC/ae7LVc2SZ3hYojSzlrzdwwkplCv9ECq3pWrFmVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsekEyz0c6A0ClFG6WUpOCq7/sp/dVVRcQKBLBkEhdbgVHUuQByjhUCOZrkRNB4Wl/Re8pb/UlQDLT50ECSMd0C9mntzavhCMn5B3cJWFjekOIxr6nOHGjKUfwEjWu+/OuevlbBT8uk22EBjKfOdw00umgl7XdZqYSGgbW8MN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ioY2orQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C788FC4CEC2;
	Fri, 30 Aug 2024 10:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725015200;
	bh=wuC/ae7LVc2SZ3hYojSzlrzdwwkplCv9ECq3pWrFmVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ioY2orQ/cZ9E7KTEgVonjJxRdtbUf48MIrE/LKk4WcRWJFDn9F/I4qHQslyC4/w7v
	 y8fhieCeyoWiFRCpbk6l4LK0jeNfXD2SJ/z28BuIvGPnXNODl40m9TqqtIlFEXFuWz
	 Aeye4atTa72j5LUPiaJyD+QBBxOgwrQfam0NfgLQ=
Date: Fri, 30 Aug 2024 12:53:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: CVE-2024-43910: bpf: add missing check_func_arg_reg_off() to
 prevent out-of-bounds memory accesses
Message-ID: <2024083051-parasite-unsaved-6e19@gregkh>
References: <2024082630-CVE-2024-43910-c6ec@gregkh>
 <glynl6edraeb54cnasnykbnxrmkuujd6i6gfe76ps5voginajd@omnyfrjljyou>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <glynl6edraeb54cnasnykbnxrmkuujd6i6gfe76ps5voginajd@omnyfrjljyou>

On Wed, Aug 28, 2024 at 06:50:32PM +0800, Shung-Hsi Yu wrote:
> On Mon, Aug 26, 2024 at 12:17:18PM GMT, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > bpf: add missing check_func_arg_reg_off() to prevent out-of-bounds memory accesses
> > 
> > Currently, it's possible to pass in a modified CONST_PTR_TO_DYNPTR to
> > a global function as an argument. The adverse effects of this is that
> > BPF helpers can continue to make use of this modified
> > CONST_PTR_TO_DYNPTR from within the context of the global function,
> > which can unintentionally result in out-of-bounds memory accesses and
> > therefore compromise overall system stability i.e.
> > 
> > [  244.157771] BUG: KASAN: slab-out-of-bounds in bpf_dynptr_data+0x137/0x140
> > [  244.161345] Read of size 8 at addr ffff88810914be68 by task test_progs/302
> > [  244.167151] CPU: 0 PID: 302 Comm: test_progs Tainted: G O E 6.10.0-rc3-00131-g66b586715063 #533
> > [  244.174318] Call Trace:
> > [  244.175787]  <TASK>
> > [  244.177356]  dump_stack_lvl+0x66/0xa0
> > [  244.179531]  print_report+0xce/0x670
> > [  244.182314]  ? __virt_addr_valid+0x200/0x3e0
> > [  244.184908]  kasan_report+0xd7/0x110
> > [  244.187408]  ? bpf_dynptr_data+0x137/0x140
> > [  244.189714]  ? bpf_dynptr_data+0x137/0x140
> > [  244.192020]  bpf_dynptr_data+0x137/0x140
> > [  244.194264]  bpf_prog_b02a02fdd2bdc5fa_global_call_bpf_dynptr_data+0x22/0x26
> > [  244.198044]  bpf_prog_b0fe7b9d7dc3abde_callback_adjust_bpf_dynptr_reg_off+0x1f/0x23
> > [  244.202136]  bpf_user_ringbuf_drain+0x2c7/0x570
> > [  244.204744]  ? 0xffffffffc0009e58
> > [  244.206593]  ? __pfx_bpf_user_ringbuf_drain+0x10/0x10
> > [  244.209795]  bpf_prog_33ab33f6a804ba2d_user_ringbuf_callback_const_ptr_to_dynptr_reg_off+0x47/0x4b
> > [  244.215922]  bpf_trampoline_6442502480+0x43/0xe3
> > [  244.218691]  __x64_sys_prlimit64+0x9/0xf0
> > [  244.220912]  do_syscall_64+0xc1/0x1d0
> > [  244.223043]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > [  244.226458] RIP: 0033:0x7ffa3eb8f059
> > [  244.228582] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
> > [  244.241307] RSP: 002b:00007ffa3e9c6eb8 EFLAGS: 00000206 ORIG_RAX: 000000000000012e
> > [  244.246474] RAX: ffffffffffffffda RBX: 00007ffa3e9c7cdc RCX: 00007ffa3eb8f059
> > [  244.250478] RDX: 00007ffa3eb162b4 RSI: 0000000000000000 RDI: 00007ffa3e9c7fb0
> > [  244.255396] RBP: 00007ffa3e9c6ed0 R08: 00007ffa3e9c76c0 R09: 0000000000000000
> > [  244.260195] R10: 0000000000000000 R11: 0000000000000206 R12: ffffffffffffff80
> > [  244.264201] R13: 000000000000001c R14: 00007ffc5d6b4260 R15: 00007ffa3e1c7000
> > [  244.268303]  </TASK>
> > 
> > Add a check_func_arg_reg_off() to the path in which the BPF verifier
> > verifies the arguments of global function arguments, specifically
> > those which take an argument of type ARG_PTR_TO_DYNPTR |
> > MEM_RDONLY. Also, process_dynptr_func() doesn't appear to perform any
> > explicit and strict type matching on the supplied register type, so
> > let's also enforce that a register either type PTR_TO_STACK or
> > CONST_PTR_TO_DYNPTR is by the caller.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-43910 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Fixed in 6.10.5 with commit 13663a7c644b
> > 	Fixed in 6.11-rc1 with commit ec2b9a5e11e5
> 
> I believe the issue of being able to pass modified (i.e. non-zero
> offset) dynptr to global function was introduced with commit
> a64bfe618665 ("bpf: add support for passing dynptr pointer to global
> subprog") in 6.8.

Thanks for the info, I've marked this as the "vulnerable" commit now in
the cve and updated the json record for it.

thanks for the review!

greg k-h

