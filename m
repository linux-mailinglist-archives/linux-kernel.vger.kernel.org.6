Return-Path: <linux-kernel+bounces-186728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65AA8CC815
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3CF1F21DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3361420D4;
	Wed, 22 May 2024 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkPz2dB7"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5676048
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412719; cv=none; b=FvmD7EFmM0wtKFs3BRqcGo3fZI9mLEOJtjSrSgGJInRkahmE0LtpOvahPqxYghTQj8Ja1qGQ+Ya3pd4FFtNYyiH8bdARLxX3b6KwTGFV0ksnZzM2ApwFXy1h/P0jNAGULererKbGM5nrYLT8rIfjbj3HCJSB+7MaY4WDDmzAufU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412719; c=relaxed/simple;
	bh=h1du3Ar30jmBXtd+6JExR7IE+3FzKfDKF8z+kfLk3wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLc4X2UPVysvDSlbYUvN1Nw6ny/NcOPtZdZ8OnE1a8PDNt+dVcvT7rh8TtSpmlyxsppzgjFr3fkljlwECG3Lr0vwEQD0jzXp1HsqSm9PNwgGLwkWqx1RxChNKrsx5Z288AVFZdJ1HRmpZjiC5UXVaCVagmHtnXImiFnwUKvgJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkPz2dB7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-354de97586cso1352636f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716412714; x=1717017514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPFBmLMrXmmvr6J+GTuOCF+VbCYwsLvpCyRM6XYnE9o=;
        b=mkPz2dB7SiB3oergsH0vEvgHIcIX/pZqR1F4wQE0TUSOOlBQ9UW85yI8sxXqHfX55z
         n7r0J10bML+66rdbeUtxRMkIAK9aetCa2Ayvm2wK/KOCiZSSUC8iE2X6Fku6o/AmxJE7
         O+ySyhnAsy0MrdBWswpXsi1gJdOapgpUdRvHBxJbfYmybtzQGm8PKEvMa9P/XMB8ge62
         Mh+l5+CP/XUGndsLLu0rf68YtSjG4jDqsVQSM6dzSsCQLNshZF//PHBulfDU48O61xuR
         x8R+4VLeC8FXQlGZ/oYSPNUs8NEQ5iyeZv8IcqKVeFzDtoAYLsFQArLRMLa2DpWMOhi8
         bwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716412714; x=1717017514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPFBmLMrXmmvr6J+GTuOCF+VbCYwsLvpCyRM6XYnE9o=;
        b=TQ39FBZM88Hnnvy6eHG/Hxha7vU5ukgy9sONT0dwq+t1XEzb3kyH4OomNyWslCeY5E
         wfhVSZC6/GwDU4LDF5HAFVYyqHu2V9C24fYU8sC2Wa7XmO6UjlDmQmAJZMvNs1ibw3t5
         jJzf4Cml0rEXHl0x4jizYPaM/ZbpgLLvUekKy9V/OJ+ylf/63Ii+JbAQ9FEsgLA+ZGsU
         LABm+pXnwz8BLHSxIOSKDEpyXPhcYT8/0yb/nWA87ieP2wbJ06ESrLobViNlM/wNsldM
         YllM4AdfF0SzHAADEuEv7tQnGukHeQ6UCs9gecUoBEwDK+ql8vsivbmwhIHyIsgwyrzX
         NK7w==
X-Forwarded-Encrypted: i=1; AJvYcCVZvLFVwyeGG/MHyr9xBsSbAlaIUHewLPELZhwNI2Iu5zaN2667uz7z5RSDoSNk495ihJbqkM79dxSnIdv0By0y4YLu7O2tHJDQX7qS
X-Gm-Message-State: AOJu0Yw88ws0NC6G4pySGWP9j1Vjq7sfz+d1K79KELWaaPYrjKe8P/4Z
	JSgpu77xMFAPw977RW+NZH2Q55ex2zmtUo+yIzKFCkWmIiyH30ZP
X-Google-Smtp-Source: AGHT+IG0LdNWuJZ1ltYpuD0k+A5ABTbklxoeAIOSGNw9XhOK2ynbOESExj8haYzXA6n8ue9WeSxYLQ==
X-Received: by 2002:a5d:638d:0:b0:349:eb59:c188 with SMTP id ffacd0b85a97d-354d8c7428fmr2719584f8f.5.1716412713944;
        Wed, 22 May 2024 14:18:33 -0700 (PDT)
Received: from debian.local (host-92-13-19-4.as13285.net. [92.13.19.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a25f0d2a9sm1804494266b.60.2024.05.22.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 14:18:33 -0700 (PDT)
Date: Wed, 22 May 2024 22:18:30 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: regressions@lists.linux.dev, vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com, jgg@nvidia.com, jroedel@suse.de,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	amd-gfx list <amd-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: 6.10/regression/bisected commit c4cb23111103 causes sleeping
 function called from invalid context at kernel/locking/mutex.c:585
Message-ID: <Zk5hJrY_lGmuW1G9@debian.local>
References: <CABXGCsN1z2gj99zSdhQWynpTXBymrqHejDfF8axxxoiZ_0g_-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsN1z2gj99zSdhQWynpTXBymrqHejDfF8axxxoiZ_0g_-g@mail.gmail.com>

On Tue, May 21, 2024 at 02:39:06PM +0500, Mikhail Gavrilov wrote:
> Hi,
> Yesterday on the fresh kernel snapshot
> I spotted a new bug message with follow stacktrace:
> [    4.307097] BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:585
> [    4.307135] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:
> 1, name: swapper/0
> [    4.307150] preempt_count: 3, expected: 0
> [    4.307159] RCU nest depth: 0, expected: 0
> [    4.307168] 4 locks held by swapper/0/1:
> [    4.307176]  #0: ffff8881080ba920 (&group->mutex){+.+.}-{3:3}, at:
> bus_iommu_probe+0xf6/0x4c0
> [    4.307203]  #1: ffff88811654c1b8 (&domain->lock){....}-{2:2}, at:
> amd_iommu_attach_device+0x1ad/0x1e80
> [    4.307227]  #2: ffff888113518c18 (&dev_data->lock){....}-{2:2},
> at: amd_iommu_attach_device+0x213/0x1e80
> [    4.307243]  #3: ffff888108393030 (&iommu->lock){....}-{2:2}, at:
> amd_iommu_iopf_add_device+0x69/0x140
> [    4.307243] irq event stamp: 1021718
> [    4.307243] hardirqs last  enabled at (1021717):
> [<ffffffff9cc35f2e>] kasan_quarantine_put+0x12e/0x250
> [    4.307243] hardirqs last disabled at (1021718):
> [<ffffffff9f46895c>] _raw_spin_lock_irqsave+0x7c/0xa0
> [    4.307243] softirqs last  enabled at (1020154):
> [<ffffffff9c2721fb>] __irq_exit_rcu+0xbb/0x1c0
> [    4.307243] softirqs last disabled at (1020147):
> [<ffffffff9c2721fb>] __irq_exit_rcu+0xbb/0x1c0
> [    4.307243] Preemption disabled at:
> [    4.307243] [<0000000000000000>] 0x0
> [    4.307243] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.10.0-0.rc0.20240520giteb6a9339efeb.9.fc41.x86_64+debug #1
> [    4.307243] Hardware name: ASUS System Product Name/ROG STRIX
> B650E-I GAMING WIFI, BIOS 2611 04/07/2024
> [    4.307243] Call Trace:
> [    4.307243]  <TASK>
> [    4.307243]  dump_stack_lvl+0x84/0xd0
> [    4.307243]  __might_resched.cold+0x1f7/0x23d
> [    4.307243]  ? __pfx___might_resched+0x10/0x10
> [    4.307243]  __mutex_lock+0xf3/0x13f0
> [    4.307243]  ? iopf_queue_add_device+0xd2/0x5d0
> [    4.307243]  ? __pfx___mutex_lock+0x10/0x10
> [    4.307243]  ? find_held_lock+0x34/0x120
> [    4.307243]  ? __pfx_lock_acquired+0x10/0x10
> [    4.307243]  ? iopf_queue_add_device+0xd2/0x5d0
> [    4.307243]  iopf_queue_add_device+0xd2/0x5d0
> [    4.307243]  amd_iommu_iopf_add_device+0xcd/0x140
> [    4.307243]  amd_iommu_attach_device+0xdc8/0x1e80
> [    4.307243]  ? iommu_create_device_direct_mappings+0x571/0x7d0
> [    4.307243]  __iommu_attach_device+0x64/0x250
> [    4.307243]  __iommu_device_set_domain+0x122/0x1c0
> [    4.307243]  __iommu_group_set_domain_internal+0xfa/0x2d0
> [    4.307243]  iommu_setup_default_domain+0x918/0xcd0
> [    4.307243]  bus_iommu_probe+0x1ad/0x4c0
> [    4.307243]  ? __pfx_bus_iommu_probe+0x10/0x10
> [    4.307243]  iommu_device_register+0x184/0x230
> [    4.307243]  ? amd_iommu_iopf_init+0xfd/0x170
> [    4.307243]  iommu_go_to_state+0xf87/0x3890
> [    4.307243]  ? __pfx_iommu_go_to_state+0x10/0x10
> [    4.307243]  ? lockdep_hardirqs_on+0x7c/0x100
> [    4.307243]  ? _raw_spin_unlock_irqrestore+0x4f/0x80
> [    4.307243]  ? add_device_randomness+0xb8/0xf0
> [    4.307243]  ? __pfx_add_device_randomness+0x10/0x10
> [    4.307243]  ? __pfx_pci_iommu_init+0x10/0x10
> [    4.307243]  amd_iommu_init+0x21/0x60
> [    4.307243]  ? __pfx_pci_iommu_init+0x10/0x10
> [    4.307243]  pci_iommu_init+0x38/0x60
> [    4.307243]  do_one_initcall+0xd6/0x460
> [    4.307243]  ? __pfx_do_one_initcall+0x10/0x10
> [    4.307243]  ? kernel_init_freeable+0x4cb/0x750
> [    4.307243]  ? kasan_unpoison+0x44/0x70
> [    4.307243]  kernel_init_freeable+0x6b4/0x750
> [    4.307243]  ? __pfx_kernel_init_freeable+0x10/0x10
> [    4.307243]  ? __pfx_kernel_init+0x10/0x10
> [    4.307243]  ? __pfx_kernel_init+0x10/0x10
> [    4.307243]  kernel_init+0x1c/0x150
> [    4.307243]  ? __pfx_kernel_init+0x10/0x10
> [    4.307243]  ret_from_fork+0x31/0x70
> [    4.307243]  ? __pfx_kernel_init+0x10/0x10
> [    4.307243]  ret_from_fork_asm+0x1a/0x30
> [    4.307243]  </TASK>
> 
> [    4.307243] =============================
> [    4.307243] [ BUG: Invalid wait context ]
> [    4.307243] 6.10.0-0.rc0.20240520giteb6a9339efeb.9.fc41.x86_64+debug
> #1 Tainted: G        W         -------  ---
> [    4.307243] -----------------------------
> [    4.307243] swapper/0/1 is trying to lock:
> [    4.307243] ffff88810de2fa88 (&queue->lock){....}-{3:3}, at:
> iopf_queue_add_device+0xd2/0x5d0
> [    4.307243] other info that might help us debug this:
> [    4.307243] context-{4:4}
> [    4.307243] 4 locks held by swapper/0/1:
> [    4.307243]  #0: ffff8881080ba920 (&group->mutex){+.+.}-{3:3}, at:
> bus_iommu_probe+0xf6/0x4c0
> [    4.307243]  #1: ffff88811654c1b8 (&domain->lock){....}-{2:2}, at:
> amd_iommu_attach_device+0x1ad/0x1e80
> [    4.307243]  #2: ffff888113518c18 (&dev_data->lock){....}-{2:2},
> at: amd_iommu_attach_device+0x213/0x1e80
> [    4.307243]  #3: ffff888108393030 (&iommu->lock){....}-{2:2}, at:
> amd_iommu_iopf_add_device+0x69/0x140
> [    4.307243] stack backtrace:
> [    4.307243] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
>   -------  ---
> 6.10.0-0.rc0.20240520giteb6a9339efeb.9.fc41.x86_64+debug #1
> [    4.307243] Hardware name: ASUS System Product Name/ROG STRIX
> B650E-I GAMING WIFI, BIOS 2611 04/07/2024
> [    4.307243] Call Trace:
> [    4.307243]  <TASK>
> [    4.307243]  dump_stack_lvl+0x84/0xd0
> [    4.307243]  __lock_acquire.cold+0x1fe/0x2a0
> [    4.307243]  ? __pfx___lock_acquire+0x10/0x10
> [    4.307243]  ? ret_from_fork_asm+0x1a/0x30
> [    4.307243]  lock_acquire+0x1ae/0x540
> [    4.307243]  ? iopf_queue_add_device+0xd2/0x5d0
> [    4.307243]  ? __pfx_lock_acquire+0x10/0x10
> [    4.307243]  ? __printk_cpu_sync_put+0x35/0x60
> [    4.307243]  ? add_taint+0x2a/0x70
> [    4.307243]  ? __might_resched.cold+0x203/0x23d
> [    4.307243]  ? __pfx___might_resched+0x10/0x10
> [    4.307243]  __mutex_lock+0x189/0x13f0
> [    4.307243]  ? iopf_queue_add_device+0xd2/0x5d0
> [    4.307243]  ? iopf_queue_add_device+0xd2/0x5d0
> [    4.307243]  ? __pfx___mutex_lock+0x10/0x10
> [    4.307243]  ? find_held_lock+0x34/0x120
> [    4.307243]  ? __pfx_lock_acquired+0x10/0x10
> [    4.307243]  ? iopf_queue_add_device+0xd2/0x5d0
> [    4.307243]  iopf_queue_add_device+0xd2/0x5d0
> [    4.307243]  amd_iommu_iopf_add_device+0xcd/0x140
> [    4.307243]  amd_iommu_attach_device+0xdc8/0x1e80
> [    4.307243]  ? iommu_create_device_direct_mappings+0x571/0x7d0
> [    4.307243]  __iommu_attach_device+0x64/0x250
> [    4.307243]  __iommu_device_set_domain+0x122/0x1c0
> [    4.307243]  __iommu_group_set_domain_internal+0xfa/0x2d0
> [    4.307243]  iommu_setup_default_domain+0x918/0xcd0
> [    4.307243]  bus_iommu_probe+0x1ad/0x4c0
> [    4.307243]  ? __pfx_bus_iommu_probe+0x10/0x10
> [    4.307243]  iommu_device_register+0x184/0x230
> [    4.307243]  ? amd_iommu_iopf_init+0xfd/0x170
> [    4.307243]  iommu_go_to_state+0xf87/0x3890
> [    4.307243]  ? __pfx_iommu_go_to_state+0x10/0x10
> [    4.307243]  ? lockdep_hardirqs_on+0x7c/0x100
> [    4.307243]  ? _raw_spin_unlock_irqrestore+0x4f/0x80
> [    4.307243]  ? add_device_randomness+0xb8/0xf0
> [    4.307243]  ? __pfx_add_device_randomness+0x10/0x10
> [    4.307243]  ? __pfx_pci_iommu_init+0x10/0x10
> [    4.307243]  amd_iommu_init+0x21/0x60
> [    4.307243]  ? __pfx_pci_iommu_init+0x10/0x10
> [    4.307243]  pci_iommu_init+0x38/0x60
> [    4.307243]  do_one_initcall+0xd6/0x460
> [    4.307243]  ? __pfx_do_one_initcall+0x10/0x10
> [    4.307243]  ? kernel_init_freeable+0x4cb/0x750
> [    4.307243]  ? kasan_unpoison+0x44/0x70
> [    4.307243]  kernel_init_freeable+0x6b4/0x750
> [    4.307243]  ? __pfx_kernel_init_freeable+0x10/0x10
> [    4.307243]  ? __pfx_kernel_init+0x10/0x10
> [    4.307243]  ? __pfx_kernel_init+0x10/0x10
> [    4.307243]  kernel_init+0x1c/0x150
> [    4.307243]  ? __pfx_kernel_init+0x10/0x10
> [    4.307243]  ret_from_fork+0x31/0x70
> [    4.307243]  ? __pfx_kernel_init+0x10/0x10
> [    4.307243]  ret_from_fork_asm+0x1a/0x30
> [    4.307243]  </TASK>
> [    4.311628] AMD-Vi: Extended features (0x246577efa2254afa, 0x0):
> PPR NX GT [5] IA GA PC GA_vAPIC
> [    4.311639] AMD-Vi: Interrupt remapping enabled
> [    4.366191] AMD-Vi: Virtual APIC enabled
> 
> Bisect pointed to commit:
> commit c4cb23111103a841c2df30058597398443bcad5f (HEAD)
> Author: Vasant Hegde <vasant.hegde@amd.com>
> Date:   Thu Apr 18 10:33:57 2024 +0000
> 
>     iommu/amd: Add support for enable/disable IOPF
> 
>     Return success from enable_feature(IOPF) path as this interface is going
>     away. Instead we will enable/disable IOPF support in attach/detach device
>     path.
> 
>     In attach device path, if device is capable of PRI, then we will add it to
>     per IOMMU IOPF queue and enable PPR support in IOMMU. Also it will
>     attach device to domain even if it fails to enable PRI or add device to
>     IOPF queue as device can continue to work without PRI support.
> 
>     In detach device patch it follows following sequence:
>       - Flush the queue for the given device
>       - Disable PPR support in DTE[devid]
>       - Remove device from IOPF queue
>       - Disable device PRI
> 
>     Also add IOMMU_IOPF as dependency to AMD_IOMMU driver.
> 
>     Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>     Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>     Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>     Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>     Link: https://lore.kernel.org/r/20240418103400.6229-13-vasant.hegde@amd.com
>     Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
>  drivers/iommu/amd/Kconfig     |  1 +
>  drivers/iommu/amd/amd_iommu.h |  4 ++++
>  drivers/iommu/amd/iommu.c     | 39 +++++++++++++++++++++++++++++++--------
>  drivers/iommu/amd/ppr.c       | 41 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 77 insertions(+), 8 deletions(-)
> 
> 
> Unfortunately I can't check revert c4cb23111103 due to conflicts:
> > git revert -n c4cb23111103a841c2df30058597398443bcad5f
> Auto-merging drivers/iommu/amd/Kconfig
> CONFLICT (content): Merge conflict in drivers/iommu/amd/Kconfig
> Auto-merging drivers/iommu/amd/amd_iommu.h
> Auto-merging drivers/iommu/amd/iommu.c
> CONFLICT (content): Merge conflict in drivers/iommu/amd/iommu.c
> Auto-merging drivers/iommu/amd/ppr.c
> error: could not revert c4cb23111103... iommu/amd: Add support for
> enable/disable IOPF
> 
> 
> I also attach below a full kernel log and build config.
> 
> My hardware specs: https://linux-hardware.org/?probe=ca80d0a307
> 
> Vasant or anyone else from the AMD team can you look please.
> 
> -- 
> Best Regards,
> Mike Gavrilov.

I am also getting this error on every boot. Decoded stacktrace:

[    0.395553] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:283
[    0.395560] fbcon: Taking over console
[    0.395564] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
[    0.395569] preempt_count: 3, expected: 0
[    0.395573] RCU nest depth: 0, expected: 0
[    0.395578] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-11198-gf3033eb79136 #897
[    0.395581] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.12 04/11/2023
[    0.395582] Call Trace:
[    0.395584]  <TASK>
[    0.395587] dump_stack_lvl (lib/dump_stack.c:117 (discriminator 1))
[    0.395595] dump_stack (lib/dump_stack.c:124)
[    0.395597] __might_resched (kernel/sched/core.c:10197)
[    0.395602] __might_sleep (kernel/sched/core.c:10126 (discriminator 17))
[    0.395605] mutex_lock (./include/linux/kernel.h:73 kernel/locking/mutex.c:283)
[    0.395610] iopf_queue_add_device (drivers/iommu/io-pgfault.c:341)
[    0.395616] amd_iommu_iopf_add_device (drivers/iommu/amd/ppr.c:265)
[    0.395621] amd_iommu_attach_device (drivers/iommu/amd/iommu.c:2064 drivers/iommu/amd/iommu.c:2123 drivers/iommu/amd/iommu.c:2509)
[    0.395626] __iommu_attach_device (drivers/iommu/iommu.c:2069)
[    0.395630] __iommu_device_set_domain (drivers/iommu/iommu.c:2257)
[    0.395633] __iommu_group_set_domain_internal (drivers/iommu/iommu.c:2313)
[    0.395637] iommu_setup_default_domain (drivers/iommu/iommu.c:2976)
[    0.395640] bus_iommu_probe (drivers/iommu/iommu.c:1828)
[    0.395644] iommu_device_register (drivers/iommu/iommu.c:267 (discriminator 3))
[    0.395646] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)
[    0.395650] state_next (drivers/iommu/amd/init.c:2121 drivers/iommu/amd/init.c:2167 drivers/iommu/amd/init.c:3258)
[    0.395655] amd_iommu_init (drivers/iommu/amd/init.c:3305 drivers/iommu/amd/init.c:3373)
[    0.395657] ? __pfx_pci_iommu_init (arch/x86/kernel/pci-dma.c:177)
[    0.395661] pci_iommu_init (arch/x86/kernel/pci-dma.c:182)
[    0.395663] ? __pfx_pci_iommu_init (arch/x86/kernel/pci-dma.c:177)
[    0.395665] do_one_initcall (init/main.c:1267)
[    0.395671] kernel_init_freeable (init/main.c:1328 init/main.c:1345 init/main.c:1364 init/main.c:1578)
[    0.395675] ? __pfx_kernel_init (init/main.c:1459)
[    0.395679] kernel_init (init/main.c:1469)
[    0.395681] ret_from_fork (arch/x86/kernel/process.c:153)
[    0.395684] ? __pfx_kernel_init (init/main.c:1459)
[    0.395686] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
[    0.395691]  </TASK>

#regzbot ^introduced c4cb23111103a841c2df30058597398443bcad5f

