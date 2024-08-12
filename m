Return-Path: <linux-kernel+bounces-283649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DEE94F753
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623801F20FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C780218F2DD;
	Mon, 12 Aug 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stonybrook.edu header.i=@stonybrook.edu header.b="XEqt1fd9"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26710186E59
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489835; cv=none; b=ag1TSKlpW+M1aVY3AVxqDI5t2eyG0rRYa+iJRxv+H0c3sE4ULo7XttlzTV55VbbMNP171QY3VKbwCENaXCX9GvweFaWHOfW6CPZB2hqtoIFnsBd2mYXXJPjc9pDUHgWSUaLd84sOVHtxkffhikgBjG1nkvHhDNsiKvOIeYluhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489835; c=relaxed/simple;
	bh=WZmX/42vN7PZcTyViZ1i3mIgy8A0PQtkrdgCeayGXHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkVSaAGHY5BU8gAonsSgWUkNj+WN/kcUmPZxY1NrxNTlyOYSb8PhL7VpoGc6nTMgybaK3qx3UCyY0GOQPpAV4AhnuxrbXlk/WlQmKyvRZ3qYvJOOr3EG3V0s2fKWPqlBq3eucFqrIMMaVnDUDflZs/PYMK/VzG5C7GfT+QZCG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.stonybrook.edu; spf=pass smtp.mailfrom=cs.stonybrook.edu; dkim=pass (1024-bit key) header.d=stonybrook.edu header.i=@stonybrook.edu header.b=XEqt1fd9; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.stonybrook.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stonybrook.edu
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d1c1fb5cafso3046586a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stonybrook.edu; s=sbu-gmail; t=1723489832; x=1724094632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAybD63eQpUcBZDB+2Uv0hi2NCAa95tCs8g5bwaFtdc=;
        b=XEqt1fd9jHTLGCA4oTtMQ4RxRz+TuIOe1ihlnrnnxKBc7WqhMRpbwKPJnZtGZLCwFh
         xL3apxHV6PSk9HHDPetx6iSOnjiD+6Ic4yRRNkUPfPJDUXhaf1d+fE8HJa0GRhHK8QZV
         SqOiCpFVKy40Kk4g+qIid0M7roNhATodNbIG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489832; x=1724094632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAybD63eQpUcBZDB+2Uv0hi2NCAa95tCs8g5bwaFtdc=;
        b=T4dG1287XkwGYnYaZBHowQdVLj78053ovqHzmVrAQXHktUbVwhiFVLv3fgsfmSmPvK
         Bpe6Fjga7pR4XZLPFza83MuGj6it0YinenKXAQQLep2eZi5tHLcHFPVgQrDF9KdLLMQx
         svVUTySbm2aqiDdRoDoGim0KB77daTbEFUa2ZMfVjN1IPRti2H29xSj7qlFpNqKzfrMj
         zb3YG8OMj0s3zadaoMYu02OxOCbNHi8NL4qiq/+avhgjAwc4jFgGFoTSyAIbhA8OA8Dw
         gf5mLbDEqk7u1nL6YkYWJqWxvUtbDYkuIHDgYZi18KoUu7ZfGDAHjjR1ZvuEat0WZuFa
         05CA==
X-Forwarded-Encrypted: i=1; AJvYcCWn5A77GJoqFzuBExvHSOsoyikz35wvQhxjWR/Ez+vbG7x4rZrZZv4ngzQUhVA9mW0ABAlSynNP7BAipaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxIGV2m3iXJxk61YamuINvIxusMVA+Rj/vVpXuq1tI6FjyAS6
	9Nrp8hKtAM11G858Oj09NgYfjNdiQP0VsxdDvxGJcnmu3TyOKH8pTXlgnEFBgow/GLaXZ+LIFnE
	Ty0lZGxOIA/DDw9r987GUfvue3meBfBa9FUJ8iw==
X-Google-Smtp-Source: AGHT+IG4PMx1iyOT+CYHuf/PA+OKKs1Kkap4NEvL7LlHf6xklz2PAhJHGvdYZNQnZbyszw/PXe3DiHipbxMH5PmEZFk=
X-Received: by 2002:a17:90a:bf0c:b0:2c9:73ff:6a0c with SMTP id
 98e67ed59e1d1-2d392551e0fmr1250600a91.20.1723489832192; Mon, 12 Aug 2024
 12:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXmgOG=E7Yk+j7KY5w_OVMFQ5S69XX+0BkW_V0kZngCTkj54g@mail.gmail.com>
 <4c9d4c00-1811-4100-89e7-5064e8bdc0ab@oracle.com> <CALXmgOG9-uyQaELJQwkAajrtMpJezLbPYpKnwnFOiA6rjZzC1w@mail.gmail.com>
In-Reply-To: <CALXmgOG9-uyQaELJQwkAajrtMpJezLbPYpKnwnFOiA6rjZzC1w@mail.gmail.com>
From: Divyaank Tiwari <dtiwari@cs.stonybrook.edu>
Date: Mon, 12 Aug 2024 15:10:21 -0400
Message-ID: <CALXmgOHKehy2__WfzsybTYhB9QGL+jxQk3DbWY8Kbzj+Y5Fk3Q@mail.gmail.com>
Subject: Re: fs/jfs: Reproduction of kernel oops bug in JFS
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, axboe@kernel.dk, jinpu.wang@ionos.com, 
	dchinner@redhat.com, lizhi.xu@windriver.com, johannes.thumshirn@wdc.com, 
	Yifei Liu <yifeliu@cs.stonybrook.edu>, Erez Zadok <ezk@cs.stonybrook.edu>, 
	Scott Smolka <sas@cs.stonybrook.edu>, Geoff Kuenning <geoff@cs.hmc.edu>, shaggy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Dave.

We see that the JFS Mailing List is active with fixes etc. So we hope
someone could help us fix the bug we discovered. I wanted to follow up
on our proposal to provide you with VMs pre-installed with our
Replayer to assist in debugging the kernel oops bug. Could you let us
know if you have the bandwidth to investigate this bug once the VM is
available?

Additionally, do you have any security concerns regarding downloading
or accessing a large VM? Also, please let us know your preferred
VM/Hypervisor and the preferred method of access.

Thank you again for your continued support.

Best regards,

File systems and Storage Lab (FSL)
Stony Brook University


On Fri, Jul 5, 2024 at 12:04=E2=80=AFPM Divyaank Tiwari
<dtiwari@cs.stonybrook.edu> wrote:
>
> Thank you for your prompt response, Dave.
>
> We understand that you may not have the necessary bandwidth to
> investigate this immediately, and we appreciate your acknowledgment of
> the issue. To assist in debugging, our group can provide you with VMs
> pre-installed with our Replayer for testing, among other resources.
> While our previous patch, which swapped the order of kfree and
> mutex_unlock, may not be a definitive fix as you indicated, we hope it
> can at least offer some insight into the nature of the bug.
>
> Thank you once again for your response and your continued support.
>
> Best regards,
>
> File Systems and Storage Lab (FSL)
> Stony Brook University
>
> On Mon, Jul 1, 2024 at 4:40=E2=80=AFPM Dave Kleikamp <dave.kleikamp@oracl=
e.com> wrote:
> >
> > I appreciate the time and effort you've put into this so far.
> >
> > Though I'm the only maintainer of jfs, I still don't have a lot of time
> > right now to put into investigating this. I will keep track of the issu=
e
> > and try to find the time to look into it, but I can't promise how soon
> > that will be.
> >
> > Again, thanks! I do appreciate the effort.
> >
> > Shaggy
> >
> > On 7/1/24 2:54PM, Divyaank Tiwari wrote:
> > > On 10th April, 2024 we submitted a patch to the JFS mailing list for
> > > the lmLogOpen() function in the jfs_logmgr.c file. The patch moved a
> > > NULL pointer dereference of a log pointer in the txEnd() function in
> > > jfs_txnmgr.c, from being before a mutex_unlock to after the
> > > mutex_unlock, effectively postponing a kernel oops. This was confirme=
d
> > > by us through our file system Model Checking tool, Metis (Link:
> > > https://github.com/sbu-fsl/Metis). (Reference to our older patch:
> > > https://lkml.org/lkml/2024/4/10/1396.)
> > >
> > > In response to that patch, Dave Kleikamp informed us that while the
> > > above patch looked completely safe, it was unclear whether it fixed
> > > anything, as releasing the lock shouldn't leave any references to the
> > > sbi->log data structure. (We noted that all other instances of kfree
> > > of that log pointer happened before the mutex unlock; hence we felt
> > > our patch was at least partially =E2=80=9Ccorrect.=E2=80=9D) He clari=
fied that calling
> > > kfree() is unrelated to the value of sbi->log (which would be the
> > > cause of the NULL dereference issue). Lastly, the patch might only
> > > alter the timing by holding the lock longer, but since nothing should
> > > reference the log anymore, holding the lock while calling kfree() may
> > > not prevent a use-after-free issue. Regarding Dave's previous inquiry
> > > about our experiments, we confirmed that we are not using an external
> > > journal for JFS, nor does any file system share a journal.
> > >
> > > Although we have still not been able to pinpoint the exact source of
> > > the aforementioned bug, we have developed a program that can reproduc=
e
> > > it with high probability on the latest release of Linux Kernel
> > > (v6.9.4). This program, which we call a  Replayer, is open-sourced,
> > > and we have extensively documented its usage. (Link to the repository=
:
> > > https://github.com/sbu-fsl/Metis-Replayer/tree/main.)
> > >
> > > To briefly summarize our Replayer: from an execution of Metis that
> > > caused a kernel oops in JFS, we first extracted two logs=E2=80=94one
> > > containing a sequence of all operations up to that point and the othe=
r
> > > listing the relative paths of the initial files and directories in th=
e
> > > mounted file system. We wrote a simple script, setup_jfs.sh, to creat=
e
> > > a JFS file system on a 16 MiB ramdisk. (A ramdisk has a much faster
> > > I/O rate than a regular device.)  Our Replayer (replay.c), implemente=
d
> > > in about 700 lines of C code, pre-populates the files and directories
> > > and then executes each operation from the sequence log
> > > (jfs_op_sequence.log) line by line.
> > >
> > > We suspect the bug is a race of sorts.  Specifically, the Replayer
> > > always unmounts and remounts JFS in between EACH file system operatio=
n
> > > (present in the sequence file generated by Metis, while model checkin=
g
> > > a file system).    We are unable to reproduce this bug without the
> > > pair of unmount+mount in between each file system operation.  Hence
> > > our suspicion is that the bug is a race between (1) some file system
> > > operation adding a record to the log, while (2) the file system is
> > > being unmounted and the txn log is being shut-down.
> > >
> > > Due to the bug's nondeterministic nature, we have found that running
> > > all operations (823,178 in total) from the log file in a loop for 500
> > > iterations, results in a high probability of reproducing the bug
> > > within a day. In our experiments, we encountered the bug after about
> > > 60-300 iterations. Correspondingly, the time taken to trigger the bug
> > > ranged from about 9 to 75 hours (on our VM). For reference, our
> > > repository includes a dmesg trace (dmesg_jfs_kernel_oops_trace.txt,
> > > reproduced below) captured when the kernel crash was triggered during
> > > one of our experiments using our replayer.
> > >
> > > Jun 22 03:56:08 hostname kernel: BUG: kernel NULL pointer dereference=
,
> > > address: 00000000000000a4
> > > Jun 22 03:56:08 hostname kernel: #PF: supervisor write access in kern=
el mode
> > > Jun 22 03:56:08 hostname kernel: #PF: error_code(0x0002) - not-presen=
t page
> > > Jun 22 03:56:08 hostname kernel: PGD 0 P4D 0
> > > Jun 22 03:56:08 hostname kernel: Oops: 0002 [#1] PREEMPT SMP NOPTI
> > > Jun 22 03:56:08 hostname kernel: CPU: 3 PID: 582 Comm: jfsCommit Not
> > > tainted 6.9.4 #1
> > > Jun 22 03:56:08 hostname kernel: Hardware name: VMware, Inc. VMware
> > > Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00
> > > 11/12/2020
> > > Jun 22 03:56:08 hostname kernel: RIP: 0010:txEnd+0x8d/0x1e0 [jfs]
> > > Jun 22 03:56:08 hostname kernel: Code: 03 01 0f 85 88 00 00 00 83 3d
> > > ae af 00 00 03 7f 6a 66 83 7b 28 00 0f 85 3b 01 00 00 8b 05 bb 16 01
> > > 00 66 89 43 28 41 0f b7 c5 <41> 83 ac 24 a4 00 00 00 01 89 05 a4 16 0=
1
> > > 00 75 14 f0 41 80 64 24
> > > Jun 22 03:56:08 hostname kernel: RSP: 0018:ffffaf9300adbe50 EFLAGS: 0=
0010246
> > > Jun 22 03:56:08 hostname kernel: RAX: 0000000000000008 RBX:
> > > ffffaf9301213500 RCX: 0000000000000000
> > > Jun 22 03:56:08 hostname kernel: RDX: 0000000000000000 RSI:
> > > 0000000000000246 RDI: ffffaf9301213530
> > > Jun 22 03:56:08 hostname kernel: RBP: ffffaf9300adbe68 R08:
> > > 0000000000000000 R09: ffff94c3ffba3640
> > > Jun 22 03:56:08 hostname kernel: R10: 0000000000000001 R11:
> > > 0000000000000000 R12: 0000000000000000
> > > Jun 22 03:56:08 hostname kernel: R13: 0000000000000008 R14:
> > > ffff9485d28cbcf0 R15: ffffaf9301213500
> > > Jun 22 03:56:08 hostname kernel: FS:  0000000000000000(0000)
> > > GS:ffff94c3ffb80000(0000) knlGS:0000000000000000
> > > Jun 22 03:56:08 hostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> > > 0000000080050033
> > > Jun 22 03:56:08 hostname kernel: CR2: 00000000000000a4 CR3:
> > > 00000001d7f1c004 CR4: 0000000000770ef0
> > > Jun 22 03:56:08 hostname kernel: PKRU: 55555554
> > > Jun 22 03:56:08 hostname kernel: Call Trace:
> > > Jun 22 03:56:08 hostname kernel:  <TASK>
> > > Jun 22 03:56:08 hostname kernel:  ? show_regs+0x6d/0x80
> > > Jun 22 03:56:08 hostname kernel:  ? __die+0x29/0x70
> > > Jun 22 03:56:08 hostname kernel:  ? page_fault_oops+0x151/0x520
> > > Jun 22 03:56:08 hostname kernel:  ? do_user_addr_fault+0x325/0x6b0
> > > Jun 22 03:56:08 hostname kernel:  ? exc_page_fault+0x7c/0x190
> > > Jun 22 03:56:08 hostname kernel:  ? asm_exc_page_fault+0x2b/0x30
> > > Jun 22 03:56:08 hostname kernel:  ? txEnd+0x8d/0x1e0 [jfs]
> > > Jun 22 03:56:08 hostname kernel:  jfs_lazycommit+0x292/0x380 [jfs]
> > > Jun 22 03:56:08 hostname kernel:  ? __pfx_default_wake_function+0x10/=
0x10
> > > Jun 22 03:56:08 hostname kernel:  ? __pfx_jfs_lazycommit+0x10/0x10 [j=
fs]
> > > Jun 22 03:56:08 hostname kernel:  kthread+0xf5/0x130
> > > Jun 22 03:56:08 hostname kernel:  ? __pfx_kthread+0x10/0x10
> > > Jun 22 03:56:08 hostname kernel:  ret_from_fork+0x3d/0x60
> > > Jun 22 03:56:08 hostname kernel:  ? __pfx_kthread+0x10/0x10
> > > Jun 22 03:56:08 hostname kernel:  ret_from_fork_asm+0x1a/0x30
> > > Jun 22 03:56:08 hostname kernel:  </TASK>
> > > Jun 22 03:56:08 hostname kernel: Modules linked in: tls brd
> > > vsock_loopback vmw_vsock_virtio_transport_common intel_rapl_msr
> > > intel_rapl_common vmw_vsock_vmci_transport vsock sunrpc
> > > intel_uncore_frequency_common binfmt_misc nfit rapl vmw_balloon joyde=
v
> > > input_leds serio_raw vmw_vmci mac_hid sch_fq_codel dm_multipath
> > > scsi_dh_rdac scsi_dh_emc jfs scsi_dh_alua nls_ucs2_utils msr
> > > efi_pstore ip_tables x_tables autofs4 btrfs blake2b_generic raid10
> > > raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xo=
r
> > > raid6_pq libcrc32c raid1 raid0 vmwgfx drm_ttm_helper ttm
> > > drm_kms_helper crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
> > > sha512_ssse3 sha256_ssse3 drm sha1_ssse3 ahci mptspi psmouse mptscsih
> > > mptbase vmxnet3 i2c_piix4 libahci scsi_transport_spi pata_acpi
> > > aesni_intel crypto_simd cryptd [last unloaded: brd]
> > > Jun 22 03:56:08 hostname kernel: CR2: 00000000000000a4
> > > Jun 22 03:56:08 hostname kernel: ---[ end trace 0000000000000000 ]---
> > > Jun 22 03:56:08 hostname kernel: RIP: 0010:txEnd+0x8d/0x1e0 [jfs]
> > > Jun 22 03:56:08 hostname kernel: Code: 03 01 0f 85 88 00 00 00 83 3d
> > > ae af 00 00 03 7f 6a 66 83 7b 28 00 0f 85 3b 01 00 00 8b 05 bb 16 01
> > > 00 66 89 43 28 41 0f b7 c5 <41> 83 ac 24 a4 00 00 00 01 89 05 a4 16 0=
1
> > > 00 75 14 f0 41 80 64 24
> > > Jun 22 03:56:08 hostname kernel: RSP: 0018:ffffaf9300adbe50 EFLAGS: 0=
0010246
> > > Jun 22 03:56:08 hostname kernel: RAX: 0000000000000008 RBX:
> > > ffffaf9301213500 RCX: 0000000000000000
> > > Jun 22 03:56:08 hostname kernel: RDX: 0000000000000000 RSI:
> > > 0000000000000246 RDI: ffffaf9301213530
> > > Jun 22 03:56:08 hostname kernel: RBP: ffffaf9300adbe68 R08:
> > > 0000000000000000 R09: ffff94c3ffba3640
> > > Jun 22 03:56:08 hostname kernel: R10: 0000000000000001 R11:
> > > 0000000000000000 R12: 0000000000000000
> > > Jun 22 03:56:08 hostname kernel: R13: 0000000000000008 R14:
> > > ffff9485d28cbcf0 R15: ffffaf9301213500
> > > Jun 22 03:56:08 hostname kernel: FS:  0000000000000000(0000)
> > > GS:ffff94c3ffb80000(0000) knlGS:0000000000000000
> > > Jun 22 03:56:08 hostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> > > 0000000080050033
> > > Jun 22 03:56:08 hostname kernel: CR2: 00000000000000a4 CR3:
> > > 00000001d7f1c004 CR4: 0000000000770ef0
> > > Jun 22 03:56:08 hostname kernel: PKRU: 55555554
> > > Jun 22 03:56:08 hostname kernel: note: jfsCommit[582] exited with irq=
s disabled
> > > Jun 22 03:56:08 hostname kernel: note: jfsCommit[582] exited with
> > > preempt_count 1
> > > Jun 22 03:56:32 hostname kernel: watchdog: BUG: soft lockup - CPU#6
> > > stuck for 26s! [replay:257577]
> > >
> > > Further details about setting up the environment and conducting the
> > > experiment are available in our repository=E2=80=99s README. We hope =
that our
> > > replayer will assist the JFS maintainers in debugging and resolving
> > > this kernel oops bug.
> > >
> > > Note: All of our experiments were performed on Linux kernels v6.6.1 a=
nd v6.9.4
> > >
> > > Signed-off-by: Divyaank Tiwari <dtiwari@cs.stonybrook.edu>
> > > Signed-off-by: Yifei Liu <yifeliu@cs.stonybrook.edu>
> > > Signed-off-by: Erez Zadok <ezk@cs.stonybrook.edu>
> > > Signed-off-by: Scott Smolka <sas@cs.stonybrook.edu>
> > > Signed-off-by: Geoff Kuenning <geoff@cs.hmc.edu>

