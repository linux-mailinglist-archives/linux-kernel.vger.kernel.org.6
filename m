Return-Path: <linux-kernel+bounces-417707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6489D582D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD20280D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E4514F12F;
	Fri, 22 Nov 2024 02:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpgG1F6d"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD56139D04
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241723; cv=none; b=T5aRifL6tI0wU1RkwCGmna0pk0y+5hRSi6rQ2P2XIw7JWUfTDZSdXeQIsrksTPFhayKuFHHC/9nMV1+bx6XMFC2lUMrtPt+sW8zNecgN1eSxZQl/xrAEfxDYikE1z9M4Q2Ab/m3rbKzYb2F1/czSU9KJ2cx3zXRFdGbETK8J2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241723; c=relaxed/simple;
	bh=AZlunOm/7OmfDB9+2PPiBxhx7aa4gZTaYZt+GywRkrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXyNrnqNrPZXwrAr+U51VnHtPmXtCVFKbXcCZHgg8KUqVMuPgZnpeso10Y2Q/Sx/ZzoruzDnlYJ/7eSbFX6Qfnm1qNvvGj0VwOwFAz+zgSvtyzN+plioFHczk4kTNiy/GgFFtG8lSxMJW7qB8FnLnsp76qyhtNAwAfBEGdkP8Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpgG1F6d; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-514c3c41bafso532616e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732241720; x=1732846520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz6G9SaQxOW9c8C2ra+oDEOFy2SOCb2+x8Bu11EjEus=;
        b=TpgG1F6dhXG47mY8g5ke8IsmPHrSNan2WjyCeBbeYKzlSSZwRDAbRQNodcqgAwQ/5D
         k2OYetPfHUeg0VgMEbT1WIVDSYvuqBvayj/+mfZbC9AOnbAJCSTMCAEpGD3JVgTxLhgI
         Px3UljqQKE/LqM552X7YOi4k54Y2p1sW3HEFcZL0D7BloUmxCjJjNZAP7GZk+z+Dr54Z
         KoYDeKjOQld4IetcO0HEmaGml4UspbN+PpP9x+ZqdN0DIYsTxwIvDbcm39IBo3lMxaJ3
         NxguY0ENvvnOo/oINA7WHWbdt6xH1rAmElscePL0IU2VMWcghG7akqtpEbTvUGTuydMB
         zhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241720; x=1732846520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oz6G9SaQxOW9c8C2ra+oDEOFy2SOCb2+x8Bu11EjEus=;
        b=k9dq/RD0/Lz5wUdn1MYaGc0wUM8ivqedkn7iiHdjk+Rh18ixvBd/uNqgw2zZicGHj8
         O1aVPk5OlqfU5Rt67lydI2zYWNJ2B6+GDc97hmHJsZruVRvLb/5dXWNY60MXdKcadVCp
         mWMQShHxVM/AQEZaG4E9CPBhj09qmlGsCvL+t26YIEMt4EzeO7yjrk6q2GdutbOwOSnS
         OSvq1eAKeISuCe5+7KDul2/qtuqGBIgFguu3ASQOmK6ajgMKDdhIrMv26C7oYcdj4Q17
         0ACyUOoN7ZuHc6dY7e1EiZgHa449eGXCw3NhQG4skkm2J0JGuENmbz6G8E7OrigZuuuu
         ewDw==
X-Forwarded-Encrypted: i=1; AJvYcCUx3GjS90R6FxaxacT8YNO+eFwn6xj+he4Onc5IIKapaJlbv8USIdEaizSC2shVqGlJx0P3Zg9fiFPyuL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxx+Axsvtsi99Jhmu1fsEMuNBM02ZgsfOAa2Yf7VoYgYpsmKEn
	YlQcbs5zfrEqITlDEOvh9sQhb92UnVBIRQZ+YglK9obXFdTG1mmv20k30iZw+n/5gM+T0OYnWmZ
	Z6ncVi0tcYAwdRj+axs+5iucv/sw=
X-Gm-Gg: ASbGncuLU7kfDriPGYQ/dYh18FyveL87qb5lsp/OBSpxkbREId3X83FvfEZUv9lbd0c
	efFH7ok8AaWrTE773FSXArPNZ6bZvxSs=
X-Google-Smtp-Source: AGHT+IHd6I0fQm20fL5MSa+biQ0RvNDMlaU7COJwT/qmitsZsu01W07p8MjzWp44CAEZDiZQykfY81YA6isalbDVU8o=
X-Received: by 2002:a05:6122:91a:b0:50a:12e4:2618 with SMTP id
 71dfb90a1353d-515004ec248mr1438413e0c.2.1732241720222; Thu, 21 Nov 2024
 18:15:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120122858.22190-1-laoar.shao@gmail.com> <0aa9f3bd-b1b6-4089-b9eb-5b72d7a1541a@redhat.com>
 <CALOAHbBMebKtsRnfOFvNKorQk_4KGoCzKd0JcYv2p6pXhJqYbQ@mail.gmail.com>
 <2024112134-theater-jasmine-61f3@gregkh> <056df1ac-3b90-48b8-9bba-ac84305983a6@redhat.com>
In-Reply-To: <056df1ac-3b90-48b8-9bba-ac84305983a6@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 22 Nov 2024 10:14:44 +0800
Message-ID: <CALOAHbCSTZz=FRDRjFW+eqssnpOAyq+UUi+KbYBR0crGHSB7qg@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Add a new parameter strict_devmem to bypass
 strict devmem
To: David Hildenbrand <david@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, mingo@redhat.com, arnd@arndb.de, 
	x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:23=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 21.11.24 16:14, Greg KH wrote:
> > On Thu, Nov 21, 2024 at 10:31:12PM +0800, Yafang Shao wrote:
> >> On Thu, Nov 21, 2024 at 4:51=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 20.11.24 13:28, Yafang Shao wrote:
> >>>> When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to overrid=
e
> >>>> kernel data for debugging purposes is prohibited. This configuration=
 is
> >>>> always enabled on our production servers. However, there are times w=
hen we
> >>>> need to use the crash utility to modify kernel data to analyze compl=
ex
> >>>> issues.
> >>>>
> >>>> As suggested by Ingo, we can add a boot time knob of soft-enabling i=
t.
> >>>> Therefore, a new parameter "strict_devmem=3D" is added. The reuslt a=
re as
> >>>> follows,
> >>>>
> >>>> - Before this change
> >>>>     crash> wr panic_on_oops 0
> >>>>     wr: cannot write to /proc/kcore      <<<< failed
> >>>>
> >>>> - After this change
> >>>>     - default
> >>>>       crash> wr panic_on_oops 0
> >>>>       wr: cannot write to /proc/kcore    <<<< failed
> >>>>
> >>>>     - strict_devmem=3Doff
> >>>>       crash> p panic_on_oops
> >>>>       panic_on_oops =3D $1 =3D 1
> >>>>       crash> wr panic_on_oops 0
> >>>>       crash> p panic_on_oops
> >>>>       panic_on_oops =3D $2 =3D 0            <<<< succeeded
> >>>>
> >>>>     - strict_devmem=3Dinvalid
> >>>>       [    0.230052] Invalid option string for strict_devmem: 'inval=
id'
> >>>>       crash> wr panic_on_oops 0
> >>>>       wr: cannot write to /proc/kcore  <<<< failed
> >>>>
> >>>> Suggested-by: Ingo Molnar <mingo@kernel.org>
> >>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>>> ---
> >>>>    .../admin-guide/kernel-parameters.txt         | 16 ++++++++++++++
> >>>>    drivers/char/mem.c                            | 21 ++++++++++++++=
+++++
> >>>>    2 files changed, 37 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docum=
entation/admin-guide/kernel-parameters.txt
> >>>> index 1518343bbe22..7fe0f66d0dfb 100644
> >>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>> @@ -6563,6 +6563,22 @@
> >>>>                        them frequently to increase the rate of SLB f=
aults
> >>>>                        on kernel addresses.
> >>>>
> >>>> +     strict_devmem=3D
> >>>> +                     [KNL] Under CONFIG_STRICT_DEVMEM, whether stri=
ct devmem
> >>>> +                     is enabled for this boot. Strict devmem checki=
ng is used
> >>>> +                     to protect the userspace (root) access to all =
of memory,
> >>>> +                     including kernel and userspace memory. Acciden=
tal access
> >>>> +                     to this is obviously disastrous, but specific =
access can
> >>>> +                     be used by people debugging the kernel. Note t=
hat with
> >>>> +                     PAT support enabled, even in this case there a=
re
> >>>> +                     restrictions on /dev/mem use due to the cache =
aliasing
> >>>> +                     requirements.
> >>>> +             on      If IO_STRICT_DEVMEM=3Dn, the /dev/mem file onl=
y allows
> >>>> +                     userspace access to PCI space and the BIOS cod=
e and data
> >>>> +                     regions. This is sufficient for dosemu and X a=
nd all
> >>>> +                     common users of /dev/mem. (default)
> >>>> +             off     Disable strict devmem checks.
> >>>> +
> >>>>        sunrpc.min_resvport=3D
> >>>>        sunrpc.max_resvport=3D
> >>>>                        [NFS,SUNRPC]
> >>>
> >>> This will allow to violate EXCLUSIVE_SYSTEM_RAM, and I am afraid I do=
n't
> >>> enjoy seeing devmem handling+config getting more complicated.
> >>
> >> That poses a challenge. Perhaps we should also consider disabling
> >> functions that rely on EXCLUSIVE_SYSTEM_RAM when strict_devmem=3Doff,
> >> but implementing such a change seems overly complex.
> >>
> >> Our primary goal is to temporarily bypass STRICT_DEVMEM for live
> >> kernel debugging. In an earlier version, I proposed making the
> >> fucntion devmem_is_allowed() error-injectable, but Ingo pointed out
> >> that it violates the principles of STRICT_DEVMEM.
> >
> > I think that "primary goal" is the problem here.  We don't want to do
> > that, at all, for all the reasons why we implemented STRICT_DEVMEM and
> > for why people enable it.
>
> +1
>
> >
> > Either you enable it because you want the protection and "security" it
> > provides, or you do not.  Don't try to work around it please.
> >
> >> Do you have any suggestions on enabling write access to /dev/mem in
> >> debugging tools like the crash utility, while maintaining
> >> compatibility with the existing rules?
> >
> > I think you just don't provide write access to /dev/mem for debugging
> > tools as it's a huge security hole that people realized and have plugge=
d
> > up.  If you want to provide access to this for "debugging" then just
> > don't enable that option and live with the risk involved, I don't see
> > how you can have it both ways.
>
> Exactly. And I think a reasonable approach would be to have a debug
> kernel around into which you can boot, and make sure the debug kernel
> has such security features turned off.
>
> If you rely on distros, maybe you could convince the distro to ship the
> debug kernel with STRICT_DEVMEM off. I just checked RHEL9, and it only
> seems to be off in debug kernels on arm64 and s390x (IIUC). Maybe there
> is a reason we don't even want that off on debug kernels on x86_64, or
> nobody requested it so far, because using the crash utility with write
> access on a live system ... is a rather weird ... debugging mechanism in
> 2024 IMHO.

It seems I might be a bit outdated.
Could you share how you typically modify a live system these days? Are
you using live patching, writing kernel modules, or perhaps some
clever tools or techniques I'm not familiar with?

--=20
Regards
Yafang

