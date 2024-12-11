Return-Path: <linux-kernel+bounces-442300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C19EDA5A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A72E167B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62C31F239A;
	Wed, 11 Dec 2024 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dW0Xyfpw"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D71F2391
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957222; cv=none; b=LltEW9CcA2wNttV8jLXQt8yRuJLrQuQ4upiSq18X1arRU3shozp/0ygYVrrjPu2hHjW87QX5//5QDTTsynG3UdN90G3yRG4JY3jw/88CEwNtIOSkyapvH6c1qPZElbT9I9l24Z0rkeVksSxRPkcFodlIorbVCgXJmFSmCeUxEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957222; c=relaxed/simple;
	bh=MUeOcweFsS8Pfn+9wMD7kP0CT49piC/TvWQQMjPg/qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRq/CJlPf/IEWtR5mZSS/F6XC/1Y0tMIIjUbnBqMOG8/eli8/cg0pG0UCFs8tUpWi3dp0esdDEMTDxsQkFP72uWuMWjuLKArDPTborORrfbwA5NhHch0xvt+I4HWt0BxXY7cTuDZeKOAMTXSPsDi+7XAGEFvddRIRdbggNfWD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dW0Xyfpw; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-29e2bb5f100so1212918fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733957219; x=1734562019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95t+hQrjG4o8vA5zoKM7vBXIQf303T8EyerxMKuzCW0=;
        b=dW0XyfpwLFCaMqU80wexhQmJGtEBOxdUP783RpOF+l715Ti9ccYSUhUVLSmvbmOETC
         cfHURi76bAmYRBnhmj6g5UZ9U2gj2UMwtIIPfc7LOnLW185JL0GRbWsp0dHyBLeK7waQ
         su8Xihkun3sCLktdfl33N2NM7+lerbWxe/GGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957219; x=1734562019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95t+hQrjG4o8vA5zoKM7vBXIQf303T8EyerxMKuzCW0=;
        b=bANem5d3O2AGUd+azzf5MzWPxQiGebM8+sgDo6QT/FyE4iarPyEQGRpmMYZAvfsPZ5
         ariDQuUifalTYD8qPZ2ZGZEGmC9wBBNPV1KsbOvlFmSxnKc4exRqh40C48HPy8UC06Sa
         /xRGMvmGmU3DSqCIQPqMuCEmDyDXnktchu4LVGR7r+0krUBr6KxjODyfAeorYx3TPQiA
         VbsYUP9LcTvRHQrlrVAYALGBUvnnTXL0O5vstwNU+FCCYwELOGUUx/a6N1BcGMGPjwy8
         0kxFK6Pd9XmTmaeMoYyeINjDnbh+BO8rjnN9vPeotL4C1M2rqLFk2KNii9nKKaPUMg/T
         NUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Id5foECZhwuHvcZZTJxss8f5RjHjbOeNECqmJPsn62gzldNx1jojECe75+hLNo7Q+3VX4D2A9GJhdog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyynbI0/ZgsLk0hHUsS0jkMk6wN86ymxSlVziR5bP1QM/GZoSff
	MlK+N7KZ+dJis3CXadOsuaNx5sai/mosQPnHb5uKahkBy/E9Twlj0f683wQqln/PrhTSi9+39QF
	mhnRfIhcF1yL5bQOF9jVHNBAgnPJ0PBmeFKHh
X-Gm-Gg: ASbGncsOKlKF+1TDI5tvSljCsfG5Ae04u3yBRB9/QlHhvv3ZdQtg6ZIbnR9eJ9c5Rvk
	9uvMqaSlb6U85E9IkMu9zI5ZC3Z99S+jvl4ZCl3KGBkoch7FG+u7OeWtjHnh85OFbhqE0
X-Google-Smtp-Source: AGHT+IGGAl854VSncgoC5QYcMwCe/wplU8p9SZbZDX9VPPxk/mMJOrsZauN7UyHwuYU9Xy+TkG+mx2GwsIIFItQ6pkA=
X-Received: by 2002:a05:6870:40c7:b0:277:e512:f280 with SMTP id
 586e51a60fabf-2a012d2c8d2mr906248fac.3.1733957219184; Wed, 11 Dec 2024
 14:46:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <CANaxB-wvHERPBu+17b5GP3pVv7pC8J0dkK9MUG1tSir4PQx=ZQ@mail.gmail.com>
In-Reply-To: <CANaxB-wvHERPBu+17b5GP3pVv7pC8J0dkK9MUG1tSir4PQx=ZQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 11 Dec 2024 14:46:46 -0800
Message-ID: <CABi2SkXgZfTvyPX_rcb8KTKyeHxpZrL9_2Wr+vJ1q3K3_1rwoQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Andrei Vagin <avagin@gmail.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei

Thanks for your email.
I was hoping to get some feedback from CRIU devs, and happy to see you
reaching out..

On Mon, Dec 9, 2024 at 8:12=E2=80=AFPM Andrei Vagin <avagin@gmail.com> wrot=
e:
>
> On Mon, Nov 25, 2024 at 12:49=E2=80=AFPM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing or unmapped during the life time of the process=
.
> > For complete descriptions of memory sealing, please see mseal.rst [1].
> >
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization, and are
> > sealed after creation.
> >
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [2]. It is sealed from creation.
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
> > across all systems.
> >
> ...
> >
> > +config SEAL_SYSTEM_MAPPINGS
> > +       bool "seal system mappings"
> > +       default n
> > +       depends on 64BIT
> > +       depends on ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > +       depends on !CHECKPOINT_RESTORE
>
> Hi Jeff,
>
> I like the idea of this patchset, but I don=E2=80=99t like the idea of
> forcing users to choose between this security feature and
> checkpoint/restore functionality. We need to explore ways to make this
> feature work with checkpoint/restore. Relying on CAP_CHECKPOINT_RESTORE
> is the obvious approach.
>
I agree that forcing users to choose isn't ideal. I'd prefer a
solution where both approaches can be used in some way, depending on
the situation and distributions. Hopefully, with input from CRIU
developers, this can be achieved.

However, it makes sense to unconditionally seal vdso/vvar for systems
like ChromeOS and Android that don't currently use CRIU, so we will
need a KCONFIG for that.

> CRIU just needs to move these mappings, and it doesn't need to change
> their properties or modify their contents. With that in mind, here are
That is an important detail to know, thanks for bringing it up.

> two options:
> * Allow moving sealed mappings for processes with CAP_CHECKPOINT_RESTORE.
We could try to propose this under a new KCONFIG, e.g.
CONFIG_SEAL_SYSTEM_MAPPING_WITH_CAP_CHECK

IIUC, You propose allowing userspace mremap vdso if the process has
CAP_CHECKPOINT_RESTORE. However, I believe this approach raises
security concerns. During the RFC  for mseal, initially, I suggested
sealing mmap, mremap, and munmap individually, but Linus rejected this
proposal, for a good reason, mremap could leave an empty hole in the
address space, thus allowing the attacker to fill it with attacker
controlled content.

Furthermore, CAP_SYSTEM_ADMIN allows setting any capacity,  so this
would become a by-pass for sealing.

> * Allow temporarily "unsealing" mappings for processes with
>   CAP_CHECKPOINT_RESTORE. CRIU could unseal mappings, move them, and
>   then seal them back.
>
We could also try to propose this under CONFIG_SEAL_SYSTEM_MAPPING_FOR_CRIU=
.

It's important to note that temporarily unsealing a mapping from
userspace is not permitted. If a mapping has the capability to be
unsealed, it fundamentally does not provide the sealing property.

Perhaps the intention was for these steps to be carried out within the
kernel? e.g. the userspace could instruct the kernel to relocate the
vdso mapping. Since the kernel can ensure the vdso contents are not
manipulated by an attacker, this approach could offer a viable
solution.

I have been thinking of other alternatives, but those would require
more understanding on CRIU use cases.
One of my questions is: Would CRIU target an individual process? or
entire systems?

If it is an individual process, we could use prctl to opt-in/opt-out
certain processes. There could be two alternatives.
1> Opt-in solution: process must set prctl.seal_criu_mapping, this
needs to be set before execve() because sealing is applied at execve()
call.
2> opt-out solution: The system will by default seal all of the system
mappings, but individual processes can opt-out by setting
prctl.not_seal_criu_mappings. This also needs to be set before
execve() call.

For both cases, we will want to identify what type of mapping CRIU
cares about, i.e. maybe CRIU doesn't care about uprobe and vsyscall ?
and only care about vdso/vvar/sigpage ?

> Another approach might be to make this feature configurable on a
> per-process basis (e.g., via prctl). Once enabled for a process, it
> would be inherited by all its children. It can't be disabled unless a
> process has CAP_CHECKPOINT_RESTORE.
>
> I've added Mike, Dima, and Alex to the thread. They might have
> other ideas.
>
Thanks. Please feel free to chime in, I will also add Mike,Dima and
Alex to the new version of this series as well.

Thanks!
-Jeff



> Thanks,
> Andrei

