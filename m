Return-Path: <linux-kernel+bounces-266690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE7B940554
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07251C20FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC32A1D5;
	Tue, 30 Jul 2024 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="blNb7v2e"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679F138E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722307014; cv=none; b=k30XG+v/g1xjudc7dNj6Bz5lh3oezx9cbSKPpnSWbMz/CjvSGmAZfV7a7i/xSNd9cBcT0PM1cdzUPwzPxGOv1A7fCx4qdsFKDE0HXqGrjiyVD92TXrDxkdxVlBtz3Y0F4E8GmqfBxTkjLAvPXLHRAmRfJa3nD0FcfDlfyVNvZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722307014; c=relaxed/simple;
	bh=g1yZH1V46FcktRKSAGE4Rt1Xtgl+3khSNZh029A5l2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6edcPUsLnvTW4On0Yg7ZlYLX2yfvPADBHUg1WtNU8tr91MLKUVncikPeDoy2gXIDi1W3NeFEhRIx6dyXk7b0+fzxzYvId1W91GDg4eH0DBRaZQtJaD8//AFAzdUzt8UgFTf84mE/sxhiYIP9exOVkLrEehXZy1v/613rEQAoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=blNb7v2e; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0365588ab8so2434964276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722307011; x=1722911811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O26GKDhtv591gra4JQQ34BTo4tc5eigPOf2lGXgMa24=;
        b=blNb7v2e0S3Kg5PVM3CuOU7Gvbw6tM9oa7UsUY4y7EXrGRBOR8fAXgJeCOcOn/9Voa
         w9r5bXs3tc4QG69I+/AnOp1n7GEEyf0d/eh5fyc7OMPwMckIc2TTTRR9t6erQDRqrIpJ
         MtauUT4FxV0f982P6WMDQ/SCWNZqKltMQ6Sx7j4/9ni+T4XAPxd4VkTmiBKUi/Tb6sLe
         NmBhYSvOsP28NAH8FeADJT5V2Z8c+5ZbKycs97VZVNEILLpXOUcvrWL6X1lqUZ+LvIX3
         UCUTwz9TpKoQNNso4x6YVRHASRX4epIbfCCavR7iOwgzQQuZ+ceOG0CU7YWGeM0y0skv
         Hm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722307011; x=1722911811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O26GKDhtv591gra4JQQ34BTo4tc5eigPOf2lGXgMa24=;
        b=Tv34/B7yaMzT/pazdFD2CI8qJeJuL588/tQoqZeGgf9LRQByfzKdGap/4VOnmXO3Qa
         7lLz8kz2JWZyhXNzKnnA9xbia92y1mpVZWuy6KRZx56kWV3WDXiMKq2guSCXZwLwyMFg
         LHxordPKfewmREO3UWkSZ0rzXMO/2Dwz80XCjg7I+IYR5OiIycE2rRgDf30wb4ClS4Nr
         7AWQGlo2O5RDK3aewRCTWszFJaiRCsVlZ1I7KNXso6zhRxuZapiPv7mhbzlshuh02Ho0
         9kbObyMiVwT7XAnTjChDjyFdb0iKF/EDJHdDGkBERXX6uH176b4MYV2PSbABDOftu0d/
         UayQ==
X-Gm-Message-State: AOJu0YxgHmMmqGHIJ3OCLJQuv+To35CfqBsDCS0ACs7fmuzUyG3JBFqL
	U6zVIfAMCwj/mpNIe7PTjWI7lXOP2e1TUEjsnZyUG/AaiSwmMNh76PhfCMFieXJEKNlQ9Jo5KsK
	/gr+PegK5xwFGWCJZGkIoSIjB1/SlWleqy/4lR9gthPTc1uY=
X-Google-Smtp-Source: AGHT+IEgs6DHlLgJ+nYRlIUc5X5fI8YJ+RjXhIJ4st65C4LVEnzb/AdD74OgH7JD/QTDsJRmyfPztttMx092rHJM9zI=
X-Received: by 2002:a05:6902:1509:b0:e08:631a:742c with SMTP id
 3f1490d57ef6-e0b544ef022mr9626002276.16.1722307011343; Mon, 29 Jul 2024
 19:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ae7e78f8-e2ed-4406-b9ee-87ff255bae63.bugreport@valiantsec.com>
In-Reply-To: <ae7e78f8-e2ed-4406-b9ee-87ff255bae63.bugreport@valiantsec.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jul 2024 22:36:40 -0400
Message-ID: <CAHC9VhQ763vGOhBbyQtCZJ4Sj=dhdKBCzosk29kjg=xGQo=BNg@mail.gmail.com>
Subject: Re: WARNING in hashtab_init
To: Ubisectech Sirius <bugreport@valiantsec.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jmorris <jmorris@namei.org>, 
	serge <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 10:49=E2=80=AFPM Ubisectech Sirius
<bugreport@valiantsec.com> wrote:
>
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec.=
 Recently, our team has discovered a issue in Linux kernel 6.8. Attached to=
 the email were a PoC file of the issue.
>
> Stack dump:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 10493 at mm/page_alloc.c:4545 __alloc_pages+0x402/0x=
21b0 mm/page_alloc.c:4545
> Modules linked in:
> CPU: 0 PID: 10493 Comm: syz.3.141 Not tainted 6.8.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:__alloc_pages+0x402/0x21b0 mm/page_alloc.c:4545
> Code: ff 00 0f 84 15 fe ff ff 80 ce 01 e9 0d fe ff ff 83 fe 0a 0f 86 0e f=
d ff ff 80 3d c7 cf 6a 0d 00 75 0b c6 05 be cf 6a 0d 01 90 <0f> 0b 90 45 31=
 e4 e9 87 fe ff ff e8 5e 3e 9b ff 84 c0 0f 85 7a fe
> RSP: 0018:ffffc90001b37428 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff92000366e98
> RDX: 0000000000000000 RSI: 0000000000000016 RDI: 0000000000040dc0
> RBP: ffffc90001b376d8 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000000 R11: 656c6c616b7a7973 R12: 0000000400000000
> R13: 0000000000000016 R14: 0000000000040dc0 R15: 0000000000000016
> FS:  00007f10c4184640(0000) GS:ffff88802c600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f10c4163658 CR3: 000000001bb8e000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  __alloc_pages_node include/linux/gfp.h:238 [inline]
>  alloc_pages_node include/linux/gfp.h:261 [inline]
>  __kmalloc_large_node+0x88/0x1a0 mm/slub.c:3926
>  __do_kmalloc_node mm/slub.c:3969 [inline]
>  __kmalloc+0x370/0x480 mm/slub.c:3994
>  kmalloc_array include/linux/slab.h:627 [inline]
>  kcalloc include/linux/slab.h:658 [inline]
>  hashtab_init+0x10a/0x270 security/selinux/ss/hashtab.c:42
>  class_read+0x1e4/0xa10 security/selinux/ss/policydb.c:1331
>  policydb_read+0x9b6/0x3850 security/selinux/ss/policydb.c:2565
>  security_load_policy+0x15d/0x12b0 security/selinux/ss/services.c:2269
>  sel_write_load+0x313/0x1b60 security/selinux/selinuxfs.c:600
>  vfs_write+0x2b2/0x1090 fs/read_write.c:588
>  ksys_write+0x122/0x250 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f10c33958cd
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f10c4183fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f10c3534038 RCX: 00007f10c33958cd
> RDX: 0000000000002000 RSI: 0000000020000000 RDI: 0000000000000005
> RBP: 00007f10c341bb06 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f10c3534038 R15: 00007f10c4164000
>  </TASK>
>
> Thank you for taking the time to read this email and we look forward to w=
orking with you further.

It looks like you've enabled panic_on_warn and the warning/panic above
is generated by __alloc_pages in response to loading a large and/or
bogus SELinux policy.  With panic_on_warn disabled, the policy load
should fail gracefully and the system should continue to run.  Have
you done any testing with panic_on_warn disabled and noticed any
unexpected behavior?

--=20
paul-moore.com

