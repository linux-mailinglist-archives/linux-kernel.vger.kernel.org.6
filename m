Return-Path: <linux-kernel+bounces-418194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD1D9D5E73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64A21F21376
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6720A1DC05D;
	Fri, 22 Nov 2024 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie20bLj+"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6E3524F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276569; cv=none; b=PDX6lIO9ZUplElyITmvw1L4+bzFZCyEu0rWlntlmxl3SoB5FsiHlBfjLMVsLmyelWDTs3LcZ6CGI39vyP/qTIOdbhanrAGOFCOKeKyGpquA7Cr4Rh9Zz2wg1jx3X9oAyPeW1h1vTLXQb+KkX1mmThaTpxx+zHOKSheXVOZZHP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276569; c=relaxed/simple;
	bh=Yp9I0cMdE308gxoIMo8bmjvI8iMApht2gFSo9Ginnys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+0iGk37A72U6SNCH2+FQ80YUcFh2Rl31GNkF3nXRosWj0pUlDDSApczgyAda5hUaTiu6p7Plz+FuIBM3H13jjGSS3jRvd/ZdvelbUkiCEfuwcCaGTVpU2vr70FSK7BYJlo0voFYkrLp7654jUeRYYURWVx4pk/OI6mYCL5JPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie20bLj+; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6eea47d51aeso20218397b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732276567; x=1732881367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuK6HB6c/rs1/EX/wx9Zf6k+Y1qrex+okV/NoHAom6w=;
        b=Ie20bLj+3Y/4ya67Q5kDarQ8hd2Rsn0Jj5WQVEEn6oJNY+/a0zP9u1fw06Fr2X3HT7
         ANbZTWqfyXix/9vDzqmxnZL+74W7uSboquhUB9z1aRzdzJc7rzKb6sEXV5NzcaYeuIJF
         gYAfzBCvTIqyhCeilFObLZfIXoHJ2Wu15eTAQJP/7++xWDDFuT4kjaJtl30ASl3oxT78
         Uqh0mvsqc6N4sq/vYby6sA746zKxSxJvTyodEEXaADgKpDHjtZzNeJfhook4z/c20kHa
         enHMuFAO1dgZPQPdcRrqyzwdWGPISJMIH7gaAd4JbuI6vJRAt4PnO/Nw8W/d/i1NcGAJ
         +jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732276567; x=1732881367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuK6HB6c/rs1/EX/wx9Zf6k+Y1qrex+okV/NoHAom6w=;
        b=HpJQxhAGkZ3Z+U3WdlzmfYXIRdk0nNbbLdsXYtWQSag+U9AVLDrx0w4tZPf4tnWkqV
         kVh1eeBslku+vuUML+sNs3311sWTMUNBbkS74lIdhSKACNbotzbk3JLm/VctOcsuVaJ0
         ib9u592GF8CCkc4VHGaD5KFzEQ2KWp9+dm3cn84By5ke0VICArtnO/MftDU6fH0u3ork
         slCpOua/HeZhoTcjCxCNGBVeHn/CcT8npj49+P1zRb45axd4nta04ve00JcPE5oich56
         fXMtLxE1h0+kkE9vzGf9/08kUAazfdgCZfyYn9x4qe2LQV9cXVuLuYkeOdgzdQYBJZCp
         yJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTD/bL08QrxSdbo74KbGLKNQ1xJhiL7EEp+2IFQdco1fn7ZLsfM1bHPKhCmK5fRLMbtpc3Zs5sRNOjwh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsIJcQuZNwyOObUMWI1Hw0s+MqaE1Fq6wwbTINokZGEHbsn6b
	CiA8rrpFOEjhyihMUpFtLwJzvX+ecXzEuNcUBDYk37fWuwdWz8z5BUb9QOSizFJvpAXzOSn1rwf
	GtJxdxNhmHem2T9RFbN3v8diuCag=
X-Gm-Gg: ASbGncuanQNpBFR+ng2QjP+iRfM3AcUHcRx7SD7S3dJOKFIsJY6ZfPGm/OPACbHqXzN
	uePm8s/yw7wt3MLN+Ij50S8HDT7htHRdY
X-Google-Smtp-Source: AGHT+IFKyCjPeak1CHD2k5uOo/XZLw+oNvUZjaw/d76r5kbMouYjVToT0b0Uq+VazVjzGlXNw0nUUnmLFZu1yl5ojGw=
X-Received: by 2002:a05:690c:6189:b0:6ea:6e41:1a9a with SMTP id
 00721157ae682-6eee08ec77bmr32363887b3.25.1732276566934; Fri, 22 Nov 2024
 03:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120122858.22190-1-laoar.shao@gmail.com> <0aa9f3bd-b1b6-4089-b9eb-5b72d7a1541a@redhat.com>
 <CALOAHbBMebKtsRnfOFvNKorQk_4KGoCzKd0JcYv2p6pXhJqYbQ@mail.gmail.com>
 <2024112134-theater-jasmine-61f3@gregkh> <CALOAHbCGH6_n2v65SMzpXf44EvKcr4AZCjOMaDRHUynNPZNksA@mail.gmail.com>
 <bab52d30-8e47-4501-b0b1-0d26cc395898@redhat.com>
In-Reply-To: <bab52d30-8e47-4501-b0b1-0d26cc395898@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 22 Nov 2024 19:55:30 +0800
Message-ID: <CALOAHbBFjiPhD5cX7JymJueG1Gi4Vq_CPPfxrEC201fBQ5exHw@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Add a new parameter strict_devmem to bypass
 strict devmem
To: David Hildenbrand <david@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, mingo@redhat.com, arnd@arndb.de, 
	x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 7:00=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 22.11.24 03:26, Yafang Shao wrote:
> > On Thu, Nov 21, 2024 at 11:15=E2=80=AFPM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> >>
> >> On Thu, Nov 21, 2024 at 10:31:12PM +0800, Yafang Shao wrote:
> >>> On Thu, Nov 21, 2024 at 4:51=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>> On 20.11.24 13:28, Yafang Shao wrote:
> >>>>> When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to overri=
de
> >>>>> kernel data for debugging purposes is prohibited. This configuratio=
n is
> >>>>> always enabled on our production servers. However, there are times =
when we
> >>>>> need to use the crash utility to modify kernel data to analyze comp=
lex
> >>>>> issues.
> >>>>>
> >>>>> As suggested by Ingo, we can add a boot time knob of soft-enabling =
it.
> >>>>> Therefore, a new parameter "strict_devmem=3D" is added. The reuslt =
are as
> >>>>> follows,
> >>>>>
> >>>>> - Before this change
> >>>>>     crash> wr panic_on_oops 0
> >>>>>     wr: cannot write to /proc/kcore      <<<< failed
> >>>>>
> >>>>> - After this change
> >>>>>     - default
> >>>>>       crash> wr panic_on_oops 0
> >>>>>       wr: cannot write to /proc/kcore    <<<< failed
> >>>>>
> >>>>>     - strict_devmem=3Doff
> >>>>>       crash> p panic_on_oops
> >>>>>       panic_on_oops =3D $1 =3D 1
> >>>>>       crash> wr panic_on_oops 0
> >>>>>       crash> p panic_on_oops
> >>>>>       panic_on_oops =3D $2 =3D 0            <<<< succeeded
> >>>>>
> >>>>>     - strict_devmem=3Dinvalid
> >>>>>       [    0.230052] Invalid option string for strict_devmem: 'inva=
lid'
> >>>>>       crash> wr panic_on_oops 0
> >>>>>       wr: cannot write to /proc/kcore  <<<< failed
> >>>>>
> >>>>> Suggested-by: Ingo Molnar <mingo@kernel.org>
> >>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>>>> ---
> >>>>>    .../admin-guide/kernel-parameters.txt         | 16 +++++++++++++=
+
> >>>>>    drivers/char/mem.c                            | 21 +++++++++++++=
++++++
> >>>>>    2 files changed, 37 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docu=
mentation/admin-guide/kernel-parameters.txt
> >>>>> index 1518343bbe22..7fe0f66d0dfb 100644
> >>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>>> @@ -6563,6 +6563,22 @@
> >>>>>                        them frequently to increase the rate of SLB =
faults
> >>>>>                        on kernel addresses.
> >>>>>
> >>>>> +     strict_devmem=3D
> >>>>> +                     [KNL] Under CONFIG_STRICT_DEVMEM, whether str=
ict devmem
> >>>>> +                     is enabled for this boot. Strict devmem check=
ing is used
> >>>>> +                     to protect the userspace (root) access to all=
 of memory,
> >>>>> +                     including kernel and userspace memory. Accide=
ntal access
> >>>>> +                     to this is obviously disastrous, but specific=
 access can
> >>>>> +                     be used by people debugging the kernel. Note =
that with
> >>>>> +                     PAT support enabled, even in this case there =
are
> >>>>> +                     restrictions on /dev/mem use due to the cache=
 aliasing
> >>>>> +                     requirements.
> >>>>> +             on      If IO_STRICT_DEVMEM=3Dn, the /dev/mem file on=
ly allows
> >>>>> +                     userspace access to PCI space and the BIOS co=
de and data
> >>>>> +                     regions. This is sufficient for dosemu and X =
and all
> >>>>> +                     common users of /dev/mem. (default)
> >>>>> +             off     Disable strict devmem checks.
> >>>>> +
> >>>>>        sunrpc.min_resvport=3D
> >>>>>        sunrpc.max_resvport=3D
> >>>>>                        [NFS,SUNRPC]
> >>>>
> >>>> This will allow to violate EXCLUSIVE_SYSTEM_RAM, and I am afraid I d=
on't
> >>>> enjoy seeing devmem handling+config getting more complicated.
> >>>
> >>> That poses a challenge. Perhaps we should also consider disabling
> >>> functions that rely on EXCLUSIVE_SYSTEM_RAM when strict_devmem=3Doff,
> >>> but implementing such a change seems overly complex.
> >>>
> >>> Our primary goal is to temporarily bypass STRICT_DEVMEM for live
> >>> kernel debugging. In an earlier version, I proposed making the
> >>> fucntion devmem_is_allowed() error-injectable, but Ingo pointed out
> >>> that it violates the principles of STRICT_DEVMEM.
> >>
> >> I think that "primary goal" is the problem here.  We don't want to do
> >> that, at all, for all the reasons why we implemented STRICT_DEVMEM and
> >> for why people enable it.
> >>
> >> Either you enable it because you want the protection and "security" it
> >> provides, or you do not.  Don't try to work around it please.
> >>
> >>> Do you have any suggestions on enabling write access to /dev/mem in
> >>> debugging tools like the crash utility, while maintaining
> >>> compatibility with the existing rules?
> >>
> >> I think you just don't provide write access to /dev/mem for debugging
> >> tools as it's a huge security hole that people realized and have plugg=
ed
> >> up.  If you want to provide access to this for "debugging" then just
> >> don't enable that option and live with the risk involved, I don't see
> >> how you can have it both ways.
> >
> > I don=E2=80=99t quite see how STRICT_DEVMEM could pose a significant se=
curity
> > concern. If you=E2=80=99re root, you already have the ability to do wha=
tever
> > you want on the system if you=E2=80=99re determined to. This option pri=
marily
> > serves to prevent reckless or accidental writes to kernel memory.
> >
> > As I understand it, STRICT_DEVMEM is more about enabling functionality
> > for features like page table checking and virtio_mem than about
> > enforcing security.
>
> If you look at the history, there were all mechanisms added way after
> STRICT_DEVMEM.
>
> I mean, just take a look at who relies on STRICT_DEVMEM.
>
> HARDENED_USERCOPY in security/Kconfig ..

At the very least, there=E2=80=99s the =E2=80=9Chardened_usercopy=3D=E2=80=
=9D option available for users.

--=20
Regards
Yafang

