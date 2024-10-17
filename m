Return-Path: <linux-kernel+bounces-368992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34D39A176F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235A2B251B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F4182D2;
	Thu, 17 Oct 2024 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GtI6jT6q"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672FD225D7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126745; cv=none; b=TyQ6eqv60oxbRV3QtGs/nrCWnwwG0OY5m0JBM76IVdmWW2xHanh7j9SC18cbmgfFy105knrMjsAmnp/Wr06vc7Dv5gmJHdnteJZIPTXg15xNMXrZFzM2JsDZurZbC7N+XDH7hT/dj9k7lXOETvL7MAhM6VTrQg5SZAMxhfPi84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126745; c=relaxed/simple;
	bh=7K2XnUuy0P9E7s03f1J6KqIgknJ/o4Rj/QxnU/BuOfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Nn/aaS+VbRbgAqP5j4GE37t+Mgy6jSLpkWYzunLncuKNW9pnHJMUi/mb4bTTc4mKUDi/z7BTiUVyI8wgBQ6P3G+v4px1jJtKyCfvCXOmgi/dAaHZ3WLL7yI9tXkeOw8ZSQUDs4T5+BDyPC1wy3CKHBCFjJNqXhV10/6lyMOTl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GtI6jT6q; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-288aacaec92so29542fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729126740; x=1729731540; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vVJYK2PYMGKwOP4Lxha8ImE5MYqQ8EQdHVxhSS48hw=;
        b=GtI6jT6qv8Ox8tLdeHWru0Chkmr939qqw8twApAEHGMoI3sPX1r1cvAAyMRyFQVP58
         K5Q1yBC33sG+slYCB7qwePmXujnWNLhdUH1DP1frk+vN4Ta6PyVIw1V7oAxkyKsxB/y9
         hGObUX05LSB11s1HP84Tg2y/4FDnhmJzS/oUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729126740; x=1729731540;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vVJYK2PYMGKwOP4Lxha8ImE5MYqQ8EQdHVxhSS48hw=;
        b=vDwsHkavQSxNAOxlcQQOgmr+KllJ6lwC1crID4vPrybaGd/X6EgFwwfnJPhCfrv9v4
         iq7EBUWViwaTUczLcRofjMhSiAnqrmiCSTVJJZWOSxH3zJ0H9+Yiv7H8LrwrN/vlllw1
         QunUs9c/eDQ2H07LVkfuZj0XrMRZCKy2AZNRSTQEzK7DMa01vFGfvt0/vhawscIIJmc8
         pMMwDlePBD0p9m/yD1Cqs57es1vJGNFi6/SE+5aO/JYMiDgeOL156R57DDLnMuN8csTk
         wi1Qrz2pqAgSZqtN68EIVOXZkO38agbCZ6kzapVXl8zgUY3bE2tGyKsy1tLfB+0/fcu6
         TJKA==
X-Forwarded-Encrypted: i=1; AJvYcCXWP444cZbkNdw7MxvYwLBvL42haZ3cmCydPCD/ILyskhIW2VAz0Bw/5OmMxuwhB0B5UQ7gdAI57Y/t5r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFMDcYbrv1xPQrIsiHGO6jIkAU2LeRfdmPu0ZqTrQy6/Q5LfJQ
	Y/qqwooCMiIgHcACeD+4gRd4Nd0bdLX/0jHPpGyRSAnD/vIlwjAd6OsQhcchs8PY+K0wEvvHdsS
	EfCfQpxa7kEoGPU7Joxglec1HQ/8Y/LbKg/sO
X-Google-Smtp-Source: AGHT+IFkJK5vW7UTiyaQakVeuzZ8LAyOMeE0oL/OgRN/Lgn0cZ0pGepPtXKIgu6x4o4k21vyPhR1shJYcp3eX+BVu+c=
X-Received: by 2002:a05:6870:2012:b0:287:2cbc:6c9 with SMTP id
 586e51a60fabf-2890c6d885cmr432437fac.8.1729126740267; Wed, 16 Oct 2024
 17:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014215022.68530-1-jeffxu@google.com> <2durheir3u7uv7y5d3zsuxgkxbfhyj6gbef6xiktp2nybf7os2@zppt55ut7f57>
In-Reply-To: <2durheir3u7uv7y5d3zsuxgkxbfhyj6gbef6xiktp2nybf7os2@zppt55ut7f57>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 16 Oct 2024 17:58:48 -0700
Message-ID: <CABi2SkX3YjU-soYqRahjV07cAw1bB0ukUNiUFkc-APNN3DvJ6A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 4:18=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [241014 17:50]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing during the life time of the process. For
> > complete descriptions of memory sealing, please see mseal.rst [1].
> >
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization. These mappings
> > are designated as non-writable, and sealing them will prevent them
> > from ever becoming writeable.
>                               ^ or ever removed.
>
> This is a pretty big deal.  Platforms are trying to make it so that vdso
> is the fast path, but if they are removed then things stop using them
> and it's not a problem.  This description is robbing them of the
> information they need to know that, and it's not in your change log
> either.
>
> I had said before that you need to be clear about the inability to
> remove the mappings that are sealed, as the description above heavily
> implies that it is only stopping them from becoming writeable.
>
The mseal.rst has the full description about memory sealing, I don't
see the point to repeat all the blocked operations in the commit
message here.

I don't know why you would think this heavily implies that only
stopping them from becoming writable, There is already reminder: **
For complete descriptions ** of memory sealing, please see mseal.rst

> >
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [2], thus sealable.
> >
> > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > _install_special_mapping() function. As no other mappings utilize this
> > function, it is logical to incorporate sealing logic within
> > _install_special_mapping(). This approach avoids the necessity of
> > modifying code across various architecture-specific implementations.
> >
> > The vsyscall mapping, which has its own initialization function, is
> > sealed in the XONLY case, it seems to be the most common and secure
> > case of using vsyscall.
> >
> > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > alter the mapping of vdso, vvar, and sigpage during restore
> > operations. Consequently, this feature cannot be universally enabled
> > across all systems. To address this, a kernel configuration option has
> > been introduced to enable or disable this functionality. Note, uprobe
> > is always sealed and not controlled by this kernel configuration.
> >
> > I tested CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS,
> > which doesn=E2=80=99t use CHECKPOINT_RESTORE.
> >
> > [1] Documentation/userspace-api/mseal.rst
> > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkR=
kL-NrCZxYAyg@mail.gmail.com/
> >
> > History:
> > V2:
> >   Seal uprobe always (Oleg Nesterov)
> >   Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg N=
esterov)
>
> The only update to the comment I see is the pointer to mseal.rst for a
> complete description?
>
> >   Rebase to linux_main
> >
> > V1:
> > https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/
> >
> > Jeff Xu (1):
> >   exec: seal system mappings
> >
> >  .../admin-guide/kernel-parameters.txt         | 10 ++++
> >  arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
> >  fs/exec.c                                     | 53 +++++++++++++++++++
> >  include/linux/fs.h                            |  1 +
> >  kernel/events/uprobes.c                       |  2 +-
> >  mm/mmap.c                                     |  1 +
> >  security/Kconfig                              | 26 +++++++++
> >  7 files changed, 99 insertions(+), 3 deletions(-)
> >
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >

