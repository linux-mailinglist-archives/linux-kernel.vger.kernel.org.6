Return-Path: <linux-kernel+bounces-304816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FBA962544
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF8A28196E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F88916BE37;
	Wed, 28 Aug 2024 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g6BR9m7D"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660885A79B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842246; cv=none; b=MqATHW6qD2JyZahnrvtDfJ5DiyxE3c6kQUqku5mU+pgJnlozSx9qbTCnA5yjAPODinV1gMH63CfzAej4a28U6NqB2lYTJ/c4WWz/mqpSIHjFCEz4FgvgfSWpQc64S5fj4cKAuqlysumf3IN936fnaeyXLfFUMtdqWmDLoQD5rZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842246; c=relaxed/simple;
	bh=aDGTHtaUj4ri0WThOoC44vFHT9BHmNA/5jo9zb7myZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKbj4LwbshJgRBmQB13iVPR7NS28nUF4pYwwA7jNHFs96vfZPjSdbfN0GnL0TaaIWard/dMYeNylyg1WjlwnWjhIYq4AJP9QiQTWCrtqaarKDxnW6rUeN+Vw3gmI6sgDYv3Dx7HZv+on8xpQEcda7R3q7BRgZ/X0ZUhdQwqqdU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g6BR9m7D; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37196229343so4025102f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724842243; x=1725447043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4MZlWOxs4t4Z8hZxMqFP3tSUD9osypaAs+e9wc0G0ks=;
        b=g6BR9m7D5MofiPlW7uII7VEHL+yzXNyfVR4DK+38RzUwwGBGxlsezq7TXtOs35MPVE
         XH/BQAKXz4NYN2AgZ3sXOAaKm9QNCBm3uuo2slDfd2uT34PoXl1usn2c7tCAy0l+q82i
         j2ofYQyD1id9xZuSH/rITCayssq2iQI8Kdey4eln62X7EYOOrR0QQLZz8FAqtS6D/yFR
         r5P5Hqvrqtr6k5utzz4REmvOiRpzaxkpzb8Bzujh3PoPvfJpxikPgo9zTG686Gldw14w
         bmE3ODD/ZLmE7hwyOrWq8oVgzQxmahaGTBiWJJHAcfZNgf8u3XTmCjzZQzTAbQk19Vll
         jnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724842243; x=1725447043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MZlWOxs4t4Z8hZxMqFP3tSUD9osypaAs+e9wc0G0ks=;
        b=wYdATVmeEKxA4fT3ISSkx1tAgNhM1GYBDeHpmIUHX7hwVMBbnvYfdqgmaM68eDUp1Q
         M0huicuUBzZVwTr7RSQrln+i94DaPNHKeZMTSeVK6AU5SqI2j/ATQqvvwGFrdPmivAc5
         Zra/34qS+iK6QTDZkm87r7R39DnpqlHjObtenTtcnmF7zV6EoN1FwDRHbqaWVMcB1ML3
         PoVCqBGxLpZ7jxdrKi8tTWocqH4kncIziu2L4+KFW8LkwV4gWBZi/yuRFcwe0N7COVl4
         oLlF6Ciexbnxg5JkWxx8uwOQYQgoZx3Vsbsr4MnIsmKKFAMgVm0L8T27kAgpslR582hw
         BArQ==
X-Gm-Message-State: AOJu0YyUyaMhq5tcjNTQ8UxSNDeVZr+pbXXTeq6kgPFMZCVAEKBgF0eH
	8QkHqCDz1dOivkwlU6uW+RdjIS1zT/WfsosNH6S/wXMyaTBNDIysjzsP+gwFxL4=
X-Google-Smtp-Source: AGHT+IF8G4t4TzmGQiC0XVK9SVftT1F7UDU7Ot8DlJdl1AIGiKhqBQIW+kJHNKUGH8+EUorKOtQbGQ==
X-Received: by 2002:a05:6000:1842:b0:368:3751:de3 with SMTP id ffacd0b85a97d-3731187d275mr11222603f8f.31.1724842242520;
        Wed, 28 Aug 2024 03:50:42 -0700 (PDT)
Received: from u94a ([2401:e180:8810:6eb3:b405:49d7:f2bd:52a0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0a28sm9873372b3a.116.2024.08.28.03.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 03:50:42 -0700 (PDT)
Date: Wed, 28 Aug 2024 18:50:32 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: cve@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: CVE-2024-43910: bpf: add missing check_func_arg_reg_off() to
 prevent out-of-bounds memory accesses
Message-ID: <glynl6edraeb54cnasnykbnxrmkuujd6i6gfe76ps5voginajd@omnyfrjljyou>
References: <2024082630-CVE-2024-43910-c6ec@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024082630-CVE-2024-43910-c6ec@gregkh>

On Mon, Aug 26, 2024 at 12:17:18PM GMT, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> bpf: add missing check_func_arg_reg_off() to prevent out-of-bounds memory accesses
> 
> Currently, it's possible to pass in a modified CONST_PTR_TO_DYNPTR to
> a global function as an argument. The adverse effects of this is that
> BPF helpers can continue to make use of this modified
> CONST_PTR_TO_DYNPTR from within the context of the global function,
> which can unintentionally result in out-of-bounds memory accesses and
> therefore compromise overall system stability i.e.
> 
> [  244.157771] BUG: KASAN: slab-out-of-bounds in bpf_dynptr_data+0x137/0x140
> [  244.161345] Read of size 8 at addr ffff88810914be68 by task test_progs/302
> [  244.167151] CPU: 0 PID: 302 Comm: test_progs Tainted: G O E 6.10.0-rc3-00131-g66b586715063 #533
> [  244.174318] Call Trace:
> [  244.175787]  <TASK>
> [  244.177356]  dump_stack_lvl+0x66/0xa0
> [  244.179531]  print_report+0xce/0x670
> [  244.182314]  ? __virt_addr_valid+0x200/0x3e0
> [  244.184908]  kasan_report+0xd7/0x110
> [  244.187408]  ? bpf_dynptr_data+0x137/0x140
> [  244.189714]  ? bpf_dynptr_data+0x137/0x140
> [  244.192020]  bpf_dynptr_data+0x137/0x140
> [  244.194264]  bpf_prog_b02a02fdd2bdc5fa_global_call_bpf_dynptr_data+0x22/0x26
> [  244.198044]  bpf_prog_b0fe7b9d7dc3abde_callback_adjust_bpf_dynptr_reg_off+0x1f/0x23
> [  244.202136]  bpf_user_ringbuf_drain+0x2c7/0x570
> [  244.204744]  ? 0xffffffffc0009e58
> [  244.206593]  ? __pfx_bpf_user_ringbuf_drain+0x10/0x10
> [  244.209795]  bpf_prog_33ab33f6a804ba2d_user_ringbuf_callback_const_ptr_to_dynptr_reg_off+0x47/0x4b
> [  244.215922]  bpf_trampoline_6442502480+0x43/0xe3
> [  244.218691]  __x64_sys_prlimit64+0x9/0xf0
> [  244.220912]  do_syscall_64+0xc1/0x1d0
> [  244.223043]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  244.226458] RIP: 0033:0x7ffa3eb8f059
> [  244.228582] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8f 1d 0d 00 f7 d8 64 89 01 48
> [  244.241307] RSP: 002b:00007ffa3e9c6eb8 EFLAGS: 00000206 ORIG_RAX: 000000000000012e
> [  244.246474] RAX: ffffffffffffffda RBX: 00007ffa3e9c7cdc RCX: 00007ffa3eb8f059
> [  244.250478] RDX: 00007ffa3eb162b4 RSI: 0000000000000000 RDI: 00007ffa3e9c7fb0
> [  244.255396] RBP: 00007ffa3e9c6ed0 R08: 00007ffa3e9c76c0 R09: 0000000000000000
> [  244.260195] R10: 0000000000000000 R11: 0000000000000206 R12: ffffffffffffff80
> [  244.264201] R13: 000000000000001c R14: 00007ffc5d6b4260 R15: 00007ffa3e1c7000
> [  244.268303]  </TASK>
> 
> Add a check_func_arg_reg_off() to the path in which the BPF verifier
> verifies the arguments of global function arguments, specifically
> those which take an argument of type ARG_PTR_TO_DYNPTR |
> MEM_RDONLY. Also, process_dynptr_func() doesn't appear to perform any
> explicit and strict type matching on the supplied register type, so
> let's also enforce that a register either type PTR_TO_STACK or
> CONST_PTR_TO_DYNPTR is by the caller.
> 
> The Linux kernel CVE team has assigned CVE-2024-43910 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 6.10.5 with commit 13663a7c644b
> 	Fixed in 6.11-rc1 with commit ec2b9a5e11e5

I believe the issue of being able to pass modified (i.e. non-zero
offset) dynptr to global function was introduced with commit
a64bfe618665 ("bpf: add support for passing dynptr pointer to global
subprog") in 6.8.

[...]

