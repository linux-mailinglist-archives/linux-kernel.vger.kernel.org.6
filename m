Return-Path: <linux-kernel+bounces-435716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E229E7B59
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD36188273B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1668A1BFE06;
	Fri,  6 Dec 2024 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duvv9IbC"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083B22C6F4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522636; cv=none; b=ioJlG9qdWfl8MrOAA0qoHeIcZZuUpwel33IU/NnFs0V0zGv3DFZdQGybKsJ+b79q3p99amkrCkUtTimS9gFsUD5LOLp38apPHPdmhbDpC4jcuVobBWCaOmloX/3tGYo3mSf/YS2XddHrtBnOlWMqj5UFCuSS73ZIQUKKknC2cUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522636; c=relaxed/simple;
	bh=0Gg9ObrhTNZZotL+GjJTIdmdvOHgz1liKSCI3mgx8O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDYUmaOOj9d9jNt1yhtbXu+fuyTd5jizvYIVPdYngSb/vFgk9kZ/1h7TsYsr66CYBOycmKz91SEoU1J404gWJaJns2dQscs7DJOHp+tDAgkC8lVCc6A4sMtIUZQJuChZ9tsGhlmrR1Z0CqFYvJGAAdARUaVbv8ijZjsTN8Ghg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=duvv9IbC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4674c22c4afso4921cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 14:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733522634; x=1734127434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onm4snD36fzsHNPwYxAviAUr6L5BVBha014kBYGdlXI=;
        b=duvv9IbCu6bBNNTq8h8i3lj/AiOcUUP7BUtkCFjEnuSke4aJ3KS/i4jZOkMGNtjkBq
         XEHiLQ0VSxI4nI5tBloGfdSTBqzbG/GTjVclDCt4Y7gCW2d8ku1BpIEhbWmyt/n3CZIM
         K+pxOUUKBzu2Vfy/V9S9Qvz5GMwadlReCsceSfk1k8Gf5w27Y/g8iB/ZkWrGrXiAqBoj
         NdphPkSflINydqegTlDeBkSnHhEmQ86DEp+PdUcJKPjbzK66nHNnXyra/8WIjKmv/qRB
         KDy3xNoCrbqBkv98OYHe2HkE/TFfR5Wk8L5EauM95mipiyXecfH0vYY7hn5phGZH9MR/
         QxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733522634; x=1734127434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onm4snD36fzsHNPwYxAviAUr6L5BVBha014kBYGdlXI=;
        b=Usc0YrIFS5BZyhg9vIWsqehsQZ0wUYIHy/2vBPVlW5i3KDAz3iBRQ+XHocN6C9OD+5
         vQ15e0bSZ1kiwaBkuU9pBxirlYjOKiICmoyoqjYSu/BnWHpe5MP7JZo5jqsa0dKPejfp
         7TMmtT+Vk4fVb7ciwUmRPGGKEmaEtQ70YZ7rkq+PzDCirJFa54/FDHM+MLGBM9d12mAf
         HnYhcm1etTdAyI7cLj8hnRftM3Lfh1T7TJOlNY3mky/Jd/IFM9fb9VwFsTf/0UvGaQf6
         oJYPpaWd2Dd0/WFdyPd0kqp1739RG131Tow9PVCav7U8+NEjMM2AfXUQsJBwr06o11Gw
         QeLg==
X-Gm-Message-State: AOJu0Yx+TqVMQuLHR2Kf6Jit22ZqJnD0eLkDNT7+3HBEOz7t2suZN2dE
	FXX8YRJ0snP0yR6cc8xCwFgx9HE9iojduiWEdTzdWzxg8faRLqzB2KvC6FP5sguWDZOAbiAhyRe
	29U7eq6gioCQwKscR1bVfegNi4LyzhDnPVcp4hw8sdj1xEXKawpV2KkrG4Q==
X-Gm-Gg: ASbGncuNcPirkL3ot+uhr8nZQdN8UkvyG1bI+7c5OJQDYpqVmmRbEuY9/0I/5QunUE4
	eUAtS5i4O4SOePtnlRDi0DcgZp+UR6PA=
X-Google-Smtp-Source: AGHT+IGyxF9YDQOVl6x9AYQu7vEDhsDS9dogaW3dMuK/sFSUzrxiFpNkCyoZQ742cTLcnP36bp5agtDd5u6t74YCfyA=
X-Received: by 2002:a05:622a:40cc:b0:466:97d6:b245 with SMTP id
 d75a77b69052e-467476987a5mr829081cf.22.1733522633328; Fri, 06 Dec 2024
 14:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ba0cc57-e2ed-caa2-1241-aa5615bee01f@candelatech.com>
In-Reply-To: <1ba0cc57-e2ed-caa2-1241-aa5615bee01f@candelatech.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 6 Dec 2024 14:03:42 -0800
Message-ID: <CAJuCfpGk6kyAAEUakMTNvJWmo98Gfbrk22+yZNEwO0eMbRc1Og@mail.gmail.com>
Subject: Re: BISECTED: 'alloc_tag: populate memory for module tags as needed'
 crashes on boot.
To: Ben Greear <greearb@candelatech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 1:50=E2=80=AFPM Ben Greear <greearb@candelatech.com>=
 wrote:
>
> Hello Suren,
>
> My system crashes on bootup, and I bisected to this commit.
>
> 0f9b685626daa2f8e19a9788625c9b624c223e45 is the first bad commit
> commit 0f9b685626daa2f8e19a9788625c9b624c223e45
> Author: Suren Baghdasaryan <surenb@google.com>
> Date:   Wed Oct 23 10:07:57 2024 -0700
>
>      alloc_tag: populate memory for module tags as needed
>
>      The memory reserved for module tags does not need to be backed by ph=
ysical
>      pages until there are tags to store there.  Change the way we reserv=
e this
>      memory to allocate only virtual area for the tags and populate it wi=
th
>      physical pages as needed when we load a module.
>
> The crash looks like this:
>
> BUG: unable to handle page fault for address: fffffbfff4041000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 44d0e7067 P4D 44d0e7067 PUD 44d0e3067 PMD 10bb38067 PTE 0
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 UID: 0 PID: 319 Comm: systemd-udevd Not tainted 6.12.0-rc6+ #21
> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
> RIP: 0010:kasan_check_range+0xa5/0x190
> Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 ce 00 00 00 45 89 d=
b 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 d0 0f 84 b29
> RSP: 0018:ffff88812c26f980 EFLAGS: 00010206
> RAX: fffffbfff4041000 RBX: fffffbfff404101e RCX: ffffffff814ec29b
> [  OK  DX: fffffbfff4041018 RSI: 00000000000000f0 RDI: ffffffffa0208000
> 0m] Finished BP: fffffbfff4041000 R08: 0000000000000001 R09: fffffbfff404=
101d
> ;1;39msystemd-udR10: ffffffffa02080ef R11: 0000000000000003 R12: ffffffff=
a0208000
> ev-trig=E2=80=A6e R13: ffffc90000dac7c8 R14: ffffc90000dac7e8 R15: dffffc=
0000000000
> - Coldplug All uFS:  00007fe869216b40(0000) GS:ffff88841da00000(0000) knl=
GS:0000000000000000
> dev Devices.
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffbfff4041000 CR3: 0000000121e86002 CR4: 00000000003706f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
> [  OK  ? __die+0x1f/0x60
> 0m] Reached targ ? page_fault_oops+0x258/0x910
> et sysi ? dump_pagetable+0x690/0x690
> nit.target - ? search_bpf_extables+0x22/0x250
>   System Initiali ? trace_page_fault_kernel+0x120/0x120
> zation.
>   ? search_bpf_extables+0x164/0x250
>   ? kasan_check_range+0xa5/0x190
>   ? fixup_exception+0x4d/0xc70
>   ? exc_page_fault+0xe1/0xf0
> [  OK  ? asm_exc_page_fault+0x22/0x30
> 0m] Reached targ ? load_module+0x3d7b/0x7560
> et netw ? kasan_check_range+0xa5/0x190
> ork.target - __asan_memcpy+0x38/0x60
>   Network.
>   load_module+0x3d7b/0x7560
>   ? module_frob_arch_sections+0x30/0x30
>   ? lockdep_lock+0xbe/0x1b0
>   ? rw_verify_area+0x18d/0x5e0
>   ? kernel_read_file+0x246/0x870
>   ? __x64_sys_fspick+0x290/0x290
>   ? init_module_from_file+0xd1/0x130
>   init_module_from_file+0xd1/0x130
>   ? __ia32_sys_init_module+0xa0/0xa0
>   ? lock_acquire+0x2d/0xb0
>   ? idempotent_init_module+0x116/0x790
>   ? do_raw_spin_unlock+0x54/0x220
>   idempotent_init_module+0x226/0x790
>   ? init_module_from_file+0x130/0x130
>   ? vm_mmap_pgoff+0x203/0x2e0
>   __x64_sys_finit_module+0xba/0x130
>   do_syscall_64+0x69/0x160
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7fe869de327d
> Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 248
> RSP: 002b:00007ffe34a828d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 0000557fa8f3f3f0 RCX: 00007fe869de327d
> RDX: 0000000000000000 RSI: 00007fe869f4943c RDI: 0000000000000006
> RBP: 00007fe869f4943c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
> R13: 0000557fa8f3f030 R14: 0000000000000000 R15: 0000557fa8f3d110
>   </TASK>
> Modules linked in:
> CR2: fffffbfff4041000
> ---[ end trace 0000000000000000 ]---
>
> I suspect you only hit this with an unlucky amount of debugging enabled. =
 The kernel config I used
> is found here:
>
> http://www.candelatech.com/downloads/cfg-kasan-crash-regression.config
>
> I will be happy to test fixes.

Hi Ben,
Thanks for reporting the issue. Do you have these recent fixes in your tree=
:

https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google.com/
https://lore.kernel.org/all/20241205170528.81000-1-hao.ge@linux.dev/

If not, couple you please apply them and see if the issue is still happenin=
g?
Thanks,
Suren.


>
> Thanks,
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>

