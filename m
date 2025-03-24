Return-Path: <linux-kernel+bounces-574381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3638DA6E4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC444188E1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629251DE2BF;
	Mon, 24 Mar 2025 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUD+5/k5"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267051C84A7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849720; cv=none; b=WSAewxeOotROOpJdnEvBqh6vN88wMRjlP1AwUV3sXD9QquCX8swUx42010rghGygbTNGUhzOFWIC9VWfIy1QHXk+RNokiIY/Buv36hMtmoHTMerKlWHjjH56+Clrxx3fLdEFf2gQewJPfVl2Dkv2B3XskmyYX0THMN+r1eA5D28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849720; c=relaxed/simple;
	bh=aTnt6nWsETFhBBSVKRRXj3/n0KPLXXXZj+A79wXAp+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRXmH5cua9w64u4Em7m2hhgWavv4i/tlakeGk/FeepFlbknOARxvFXwnTignaR3rOEMWsLdJJMa7ew+l9BlYjrqbhuTOQn9Wv7VVDwkR5gUuEcM5DwvYfZkZHrxBX6e59OqOUqeVFLRxDBw6WXHGZ/KJ8BhiqAPsnvvBhvwuU2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUD+5/k5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2263428c8baso22105ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742849718; x=1743454518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJZAWyK702yp/+V6xWF6Iyjy9VYZ5Ycm2xG91/mZwmw=;
        b=hUD+5/k56uIYlpMFUazDKDs39OM0AlWK4lenNMJhfDyneSIQfxp284kMWTxQ2b5MWL
         rFHVVxGAPbAjkiKWGjqsy1mo2psMxKaOcIMrADLo0WEPVBUtZ2r8mKDttqQyJun5/PpY
         1g3pJod0s00wt+9Fe2xK4sOVe4RYqBoA9YFfvTCGzY1FaNUeYvEp+AJTSXwUb713RUje
         1cSZUWyNs4Z6+7jZDEkKhJ3qu+6W8GEkANiaOpuo9VEEEft1rsjOiLdIhyIHp+EAnu8H
         jxDCNBZIZ3sf4Wa0Q58K8Q0yNpvqRwTdM6XWaF3LDPAvhYcpTG/EkcFyTjMaPKHjNiGz
         b/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849718; x=1743454518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJZAWyK702yp/+V6xWF6Iyjy9VYZ5Ycm2xG91/mZwmw=;
        b=usPqSnOPHntfUVjJpKJMcrwXhI94KY8HZOolJPht7PFLMHhhV2pnI+7URUIyWkVqr8
         gkcHGEdtZtm2pX/wmARpqsgg/SRQc8KpxgIq3FgHXk19YJt1RwBpw79euV1zr+uJamKg
         saG78upPtyyg9dQKk8wrxYnPgRXZ4mchPBK46mj8fEVpnjRN2czFJ3Hc2BKgvnQwNYjX
         k5Fgq1x1FogyqW5eck2/1n+n5PYdioqO3CpuTSKq/TuPYW3H7ArY6sEqgMeikcrKr3Zo
         Cd5NV4+i33FinXiAfTefb29Ul3MPqeVfe54iN6pMzClTaju/mJbNuGKXUAdVgwSbpdGP
         +hJw==
X-Forwarded-Encrypted: i=1; AJvYcCU7QyRl99rgqIR+iVEfcXytdeDwJIN8hv4QvdQmmZoet3penoEO7ey5nbNgrvJDqF+K3p0W3V3ztDR5ijs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtuILbfAU7m/zoXxL/Fk6eLbqoBkEPoL3oyClSRAIOlY7+2Qln
	bXpc2kZZ+C0pZu87IKruWVPghmVHj6a9LBmPOrhrQpX/n/35rddfoQSkrdrleg==
X-Gm-Gg: ASbGncuuFks1ocGZxH+3ps2MkbPsiNJKDrio1Zv7IcsulwC3jZRO7RaiWIbvOH2FnHJ
	ww1NYKhnXkZ/77Rrs4VXmqwQnwQopzgpeLUsJEp/P9S1rB3S9NuynqwFE2H7yU/pn8FQdMy6BtU
	M9N9xbH4Yp0AR6M/Vs6jDnbhuuOurGxw+6xwnBuXqVFqf/jMpNf8LwTTxaTVyPXjXryBniNAgbB
	BKbVGuEbGlS4UTVNxwY8boyxdfeyyBUKs1q35cZ9K0ShmoBnNG7hMtMKrAJweWACJrgPAq+XCAT
	xx5gtlsJJd55o57uIDm2ic1Kxu8h2G//NeJ4kmrCSNtgIBiD6UGLjTEoUsDou4rrStMQk/Fz2+c
	sRKbU
X-Google-Smtp-Source: AGHT+IG9F5PSLKvrsG/1+/C/YXn/gqK0GsTfyBZXASZovMKJOL7OLRG2t86OvLD2uJ5lbIdwZOrGPw==
X-Received: by 2002:a17:903:230f:b0:223:4b4f:160c with SMTP id d9443c01a7336-22799f80d15mr4372205ad.27.1742849717826;
        Mon, 24 Mar 2025 13:55:17 -0700 (PDT)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611bd23sm8770464b3a.96.2025.03.24.13.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:55:17 -0700 (PDT)
Date: Mon, 24 Mar 2025 20:55:12 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com
Subject: Re: [PATCH] binder: fix use-after-free in binderfs_evict_inode()
Message-ID: <Z-HGsNgNGS2OwAZV@google.com>
References: <20250324132427.922495-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324132427.922495-1-dmantipov@yandex.ru>

On Mon, Mar 24, 2025 at 04:24:27PM +0300, Dmitry Antipov wrote:
> Running 'stress-ng --binderfs 16 --timeout 300' under KASAN-enabled
> kernel, I've noticed the following:
> 
> BUG: KASAN: slab-use-after-free in binderfs_evict_inode+0x1de/0x2d0
> Write of size 8 at addr ffff88807379bc08 by task stress-ng-binde/1699
> 
> CPU: 0 UID: 0 PID: 1699 Comm: stress-ng-binde Not tainted 6.14.0-rc7-g586de92313fc-dirty #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x1c2/0x2a0
>  ? __pfx_dump_stack_lvl+0x10/0x10
>  ? __pfx__printk+0x10/0x10
>  ? __pfx_lock_release+0x10/0x10
>  ? __virt_addr_valid+0x18c/0x540
>  ? __virt_addr_valid+0x469/0x540
>  print_report+0x155/0x840
>  ? __virt_addr_valid+0x18c/0x540
>  ? __virt_addr_valid+0x469/0x540
>  ? __phys_addr+0xba/0x170
>  ? binderfs_evict_inode+0x1de/0x2d0
>  kasan_report+0x147/0x180
>  ? binderfs_evict_inode+0x1de/0x2d0
>  binderfs_evict_inode+0x1de/0x2d0
>  ? __pfx_binderfs_evict_inode+0x10/0x10
>  evict+0x524/0x9f0
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_evict+0x10/0x10
>  ? do_raw_spin_unlock+0x4d/0x210
>  ? _raw_spin_unlock+0x28/0x50
>  ? iput+0x697/0x9b0
>  __dentry_kill+0x209/0x660
>  ? shrink_kill+0x8d/0x2c0
>  shrink_kill+0xa9/0x2c0
>  shrink_dentry_list+0x2e0/0x5e0
>  shrink_dcache_parent+0xa2/0x2c0
>  ? __pfx_shrink_dcache_parent+0x10/0x10
>  ? __pfx_lock_release+0x10/0x10
>  ? __pfx_do_raw_spin_lock+0x10/0x10
>  do_one_tree+0x23/0xe0
>  shrink_dcache_for_umount+0xa0/0x170
>  generic_shutdown_super+0x67/0x390
>  kill_litter_super+0x76/0xb0
>  binderfs_kill_super+0x44/0x90
>  deactivate_locked_super+0xb9/0x130
>  cleanup_mnt+0x422/0x4c0
>  ? lockdep_hardirqs_on+0x9d/0x150
>  task_work_run+0x1d2/0x260
>  ? __pfx_task_work_run+0x10/0x10
>  resume_user_mode_work+0x52/0x60
>  syscall_exit_to_user_mode+0x9a/0x120
>  do_syscall_64+0x103/0x210
>  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0xcac57b
> Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8
> RSP: 002b:00007ffecf4226a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 00007ffecf422720 RCX: 0000000000cac57b
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffecf422850
> RBP: 00007ffecf422850 R08: 0000000028d06ab1 R09: 7fffffffffffffff
> R10: 3fffffffffffffff R11: 0000000000000246 R12: 00007ffecf422718
> R13: 00007ffecf422710 R14: 00007f478f87b658 R15: 00007ffecf422830
>  </TASK>
> 
> Allocated by task 1705:
>  kasan_save_track+0x3e/0x80
>  __kasan_kmalloc+0x8f/0xa0
>  __kmalloc_cache_noprof+0x213/0x3e0
>  binderfs_binder_device_create+0x183/0xa80
>  binder_ctl_ioctl+0x138/0x190
>  __x64_sys_ioctl+0x120/0x1b0
>  do_syscall_64+0xf6/0x210
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 1705:
>  kasan_save_track+0x3e/0x80
>  kasan_save_free_info+0x46/0x50
>  __kasan_slab_free+0x62/0x70
>  kfree+0x194/0x440
>  evict+0x524/0x9f0
>  do_unlinkat+0x390/0x5b0
>  __x64_sys_unlink+0x47/0x50
>  do_syscall_64+0xf6/0x210
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> This 'stress-ng' workload causes the concurrent deletions from
> 'binder_devices' and so requires full-featured synchronization
> to prevent list corruption.
> 
> I've found this issue independently but pretty sure that syzbot did
> the same, so Reported-by: and Closes: should be applicable here as well.
> 
> Reported-by: syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=353d7b75658a95aa955a
> Fixes: e77aff5528a18 ("binderfs: fix use-after-free in binder_devices")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---

Thanks Dmitry, I was just running an almost identical fix. :)

Acked-by: Carlos Llamas <cmllamas@google.com>

