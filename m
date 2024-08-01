Return-Path: <linux-kernel+bounces-271059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98619448FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93114282E8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF8183CA3;
	Thu,  1 Aug 2024 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjDTrCnM"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77542AD25
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506797; cv=none; b=u/jIElexd1+g55Swao2Fv4fG2pKwhvu3KmSGlJ87t/v2v5+KpVA0kDufy8Ig2cSiT3libBPjReywIn/Ky5NIG1X3sIs9Il6WrdhpFFpsr4DUNJnbl4mStcVkG65pCzlniqGfAbkns1uVcD+L8Loy36az2F9k1qI1+bWbum/HoOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506797; c=relaxed/simple;
	bh=z+38KfQbcX75M09p1A5JOCVuDxFT9dHGHNtlhKcrH2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtslFKq9O/aRX+9g0EdYC5/qXLI9/r5YHpHcOjozBpzuc9vC602vwWGNEUp1i9g0jY90CkTi1YHLyPLx8b9hK6kzRbBBqAPTAhOgxzB4WH5HDVgVVWY7BHBp/aD7RQgbQfV1v/2cBDDYmpr0xbfQqQK+Pg0lCKy0z3Pa+tHKvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjDTrCnM; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef25511ba9so15514211fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722506794; x=1723111594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9H4p7SX3GBcUrgM4jrD6G3JkbOOCNZRQrjrvId9xpo=;
        b=CjDTrCnMj/iTpO3r1858F53jfALAQqtHsmW5CJXzU7AhOrd9WYORQux8QIPplda+LC
         VlGAXog/0+UFgg5SVH9d4gf+ILOO02k48Z9vw3Xb8eAKTdxoeItZW0k5nRSXzrjPXXoV
         mL9eoQerDZqUfcEpgqretvbcX8ox4nmUrkbCyQqQRsgdbUtzlCJzcVCDtd7JSjNgAz+u
         sMfsuJsHIYqGD2oYceKwYWg12Eb8gRJvLW5GaSI3WN96Ig4RZO68y3nSsCbUHbAW4wIx
         TfSwkwS3sO3EFwGC3kDwGcZLKjTa5QHTQr4PB72lgUsN5oje6WY2gi5yAFN2zJmwRQiq
         TMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722506794; x=1723111594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9H4p7SX3GBcUrgM4jrD6G3JkbOOCNZRQrjrvId9xpo=;
        b=KnRGVS0jcqLOk6LnvCL5+g+xx+R+E6EyGN77qfs8Qp3nPEgH0joduBu0V2MJwLv6JI
         6fjsjl5n7wg1Oa9ZOzo93ySzeICQnM7zKg0WfiP+BlcJR3Hiqud0iWkwRz/xiId9E1FM
         fCc4bCEcJUHAY3d9pOoi+omjc+rqlt/MVZJbcXXf7UfTJg/gTwcIzDBQYBZwGmVnYfZG
         dk316LJik+KFAh1MVsxJrtj298jhS36plJZPZ/GPAo1mFKz7lF02IMgCm66OD7o1zYvc
         09cTnYEFlDQ0PCjZXeSCMXvQTdkHxNY8g7XPmEfeJsKcvQBJ5qGrJH0qQKMUHS+aSKz/
         iSYA==
X-Forwarded-Encrypted: i=1; AJvYcCX5l+aAut2lznC/lMcBbE+KiRsJL/u6JNdRa+qZkWm0f6vd02mI80rpIaudVCE/zNbJzgFlS7XAsEO641HvBBq9rdUF0TBXJL3GOnCU
X-Gm-Message-State: AOJu0Yz4a5GgHn1NMPl0uJqzWwJk8j5Ek1FxaOqJIELndimwHvLh7Cng
	yRhqsC7f+yYQl2FDoEHu/lGnw7P//AWO8s0lTWas80EGuzKZ/UJRTyt+HfNGOJGbrorWCNyiRmk
	kff22oPN12Cif+PEwq7yl6r7zuWQ=
X-Google-Smtp-Source: AGHT+IHMAXL2mMQWuMoPOPqvgr1kp3DLO1F5BJ6JI3Iyw5DgPG5lsY4Jb7+69+dYUbBLCUbXRUA7WA8c+T+bmPuxkk4=
X-Received: by 2002:a05:6512:1308:b0:52b:faa1:7c74 with SMTP id
 2adb3069b0e04-530b8cf905bmr292255e87.5.1722506793489; Thu, 01 Aug 2024
 03:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
 <3c79021a-e9a0-4669-a4e7-7060edf12d58@redhat.com> <CAMgjq7CWwK75_2Zi5P40K08pk9iqOcuWKL6khu=x4Yg_nXaQag@mail.gmail.com>
In-Reply-To: <CAMgjq7CWwK75_2Zi5P40K08pk9iqOcuWKL6khu=x4Yg_nXaQag@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 1 Aug 2024 18:06:16 +0800
Message-ID: <CAMgjq7Dtw1+aKk3gJkcRL5BXYZHmav_T28aPbZew5qZ87VRHdA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mm: swap: mTHP swap allocator base on swap cluster order
To: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 5:59=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Thu, Aug 1, 2024 at 5:15=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 31.07.24 08:49, Chris Li wrote:
> > > This is the short term solutions "swap cluster order" listed
> > > in my "Swap Abstraction" discussion slice 8 in the recent
> > > LSF/MM conference.
> > >
> >
> > Running the cow.c selftest on mm/mm-unstable, I get:
>
> Hi David, thanks very much for the test and report!
>
> >
> > # [RUN] Basic COW after fork() with mprotect() optimization ... with sw=
apped-out, PTE-mapped THP (1024 kB)
> > [   51.865309] Oops: general protection fault, probably for non-canonic=
al address 0xdead000000000108: 0000 [#1] PREEMPT SMP NOPTI
> > [   51.867738] CPU: 21 UID: 0 PID: 282 Comm: kworker/21:1 Not tainted 6=
.11.0-rc1+ #11
> > [   51.869566] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.16.3-2.fc40 04/01/2014
> > [   51.871298] Workqueue: events swap_discard_work
> > [   51.872211] RIP: 0010:__free_cluster+0x27/0x90
> > [   51.873101] Code: 90 90 90 0f 1f 44 00 00 8b 0d 8d 95 96 01 55 48 89=
 fd 53 48 89 f3 85 c9 75 3a 48 8b 43 50 48 8b 4b 48 48 8d 53 48 48 83 c5 60=
 <48> 89 41 08 48 89 08 48 8b 45 08 48 89 55 08 48 89 43 50 48 89 6b
> > [   51.876720] RSP: 0018:ffffa3dcc0aafdc8 EFLAGS: 00010286
> > [   51.877752] RAX: dead000000000122 RBX: ffff8e7ed9686e00 RCX: dead000=
000000100
> > [   51.879186] RDX: ffff8e7ed9686e48 RSI: ffff8e7ed9686e18 RDI: ffff8e7=
ec37831c0
> > [   51.880577] RBP: ffff8e7ec5d10860 R08: 0000000000000001 R09: 0000000=
000000028
> > [   51.881972] R10: 0000000000000200 R11: 00000000000004cb R12: ffff8e7=
ed9686e00
> > [   51.883393] R13: 0000000000028200 R14: 0000000000028000 R15: 0000000=
000000000
> > [   51.884827] FS:  0000000000000000(0000) GS:ffff8e822f480000(0000) kn=
lGS:0000000000000000
> > [   51.886412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   51.887532] CR2: 00007f37d7e17840 CR3: 0000000335a3a001 CR4: 0000000=
000770ef0
> > [   51.888931] PKRU: 55555554
> > [   51.889471] Call Trace:
> > [   51.889964]  <TASK>
> > [   51.890391]  ? __die_body.cold+0x19/0x27
> > [   51.891174]  ? die_addr+0x3c/0x60
> > [   51.891824]  ? exc_general_protection+0x14f/0x430
> > [   51.892754]  ? asm_exc_general_protection+0x26/0x30
> > [   51.893717]  ? __free_cluster+0x27/0x90
> > [   51.894483]  ? __free_cluster+0x7e/0x90
> > [   51.895245]  swap_do_scheduled_discard+0x142/0x1b0
> > [   51.896189]  swap_discard_work+0x26/0x30
> > [   51.896958]  process_one_work+0x211/0x5a0
> > [   51.897750]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   51.898693]  worker_thread+0x1c9/0x3c0
> > [   51.899438]  ? __pfx_worker_thread+0x10/0x10
> > [   51.900287]  kthread+0xe3/0x110
> > [   51.900913]  ? __pfx_kthread+0x10/0x10
> > [   51.901656]  ret_from_fork+0x34/0x50
> > [   51.902377]  ? __pfx_kthread+0x10/0x10
> > [   51.903114]  ret_from_fork_asm+0x1a/0x30
> > [   51.903896]  </TASK>
> >
> >
> > Maybe related to this series?
>
> Right, I can reproduce your problem and I believe this patch can fix
> it, see the attachment.
>
> Hi Andrew, can you pick this patch too?

This issue is caused by my PATCH 9/9 and this attachment patch can be
squashed into it, very sorry for the problem.

