Return-Path: <linux-kernel+bounces-297103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F895B324
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29B71F21E38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFBC17F4EC;
	Thu, 22 Aug 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtrMJJac"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04214A086
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323554; cv=none; b=k0QrCo+Uu/oQcGRbfFihFBIXxfZIHxbK/QVF7DDDUw9jmOcCxaHaCS3qsCeGW14wlWmyK6i5uT99odKbUkE59e/9p7ay8US+OihnyUoek499rjrPjm4JcArmsAKRcp23ylxxcK1tmpji2/hzHkqe5VXVoG5ixJnMHxLTNp7wHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323554; c=relaxed/simple;
	bh=Wocgy9mWm5Al1pCnBkdgVtr0QQyRxnroK8DSq3J9Mio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mM/NSi+AKqStTEqgzbMdfBHvTk7A7xy4Ly3lAMxkOJ0zCKpX5wpT4qkpYVuRlUk4BctEht6seqhcwdD0H0T2tttb6ilTwwWQBFMGkUxbTHC67oRxU/toeIcDCr2Fz0i+WaBmGlmjwBtnjGIAHSR7TfT4Ee1KgT5sL/mad80Kcxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dtrMJJac; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724323551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mpnb3SemwFliUZ4/dS7d4EoXv878E5NLpOTu5i7vK3A=;
	b=dtrMJJacDsM6/+davMe/iSafYtkviH34QvnzxUqkVjHlj/v6V5ibwaFnxcEDVPg4l6SIQt
	Xz+tnjfCh8vzxChg6vskpJHPhgEsMD4y7n4kYjuNfr8HYf4ibYMfqAZ9v+Ad4zHadZuk+D
	QSKPWcR2coojJ2khrbBqHbhnAkBUWDg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-hoDsUrm8P3iY80xpu99H8g-1; Thu, 22 Aug 2024 06:45:50 -0400
X-MC-Unique: hoDsUrm8P3iY80xpu99H8g-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6c1610cd159so13064026d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724323550; x=1724928350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mpnb3SemwFliUZ4/dS7d4EoXv878E5NLpOTu5i7vK3A=;
        b=dVNl1THDzj3oJBg15ursX0T7pcajd8DGSpem5Qw0gcN8dP3ukS2t+/OhE2gR8jgHm2
         efku0vZ+DRewn9OsswGQThzGSTBVrTe97SPP2g7oNXDYmlG/kdF/2IXsqiP2BkpibIY6
         hGKyKNpw4gGzvWQbYeD8rqFVABXsGuFgey0Q3ioyUQ+ppRWqefBP4lZwouS9r/lgRA2K
         JKF0KzYAplr6WCyxaskzWS9HadWZ6IYNZNn6LPP2nflgUUGmZdESdzvEjnvAK0UWcVWJ
         965IXLoxlVfX35Woplg8Zt0TmxF2WylEjceF0D+gJM5i0d+qRut1nhZVKGPT+b+wr+Gz
         ajcg==
X-Forwarded-Encrypted: i=1; AJvYcCVyMQGHSt8IkqZwHOe5Uf4zx1AAnc5Zx8yBkHFu5eu8dIeiMkaZcUVXNiWsiBdIDXYYdxuSx6que8mhUnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrYIHBJfCX2aftArhSo1BMW6VcTV6JuT7JolRPsE61D3uxAI1C
	l/N48msZNe6jwNchKmAiyYhj5XEDSD2NyyKHL8JD+mk2gFwn0QsO5LiYI9o3MadtnJVpLNsbwbC
	vYdrzWErRW3SNQj3ZL7aiZlx22FPCq8CGv/LamszZ/kAldoVyDrVkliFf900cbb5dSs1U4OCZzH
	RBOnmHXGrpizdFMuKs53ivUqYGJDM0J0AxkOKL
X-Received: by 2002:a05:6214:2b93:b0:6bf:60b8:d4d7 with SMTP id 6a1803df08f44-6c160c71354mr52485466d6.15.1724323549902;
        Thu, 22 Aug 2024 03:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHDpqdsRgZKmZj2LlYLuSKDF48ze2sPIDVJNwTHfTXpNGLbI9DbeX+bnNBTGnZjFpbQMzRQrZC/Ggb2z0yJ5U=
X-Received: by 2002:a05:6214:2b93:b0:6bf:60b8:d4d7 with SMTP id
 6a1803df08f44-6c160c71354mr52485196d6.15.1724323549541; Thu, 22 Aug 2024
 03:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com> <Zsb1isJ2cYRp2jpj@gardel-login>
In-Reply-To: <Zsb1isJ2cYRp2jpj@gardel-login>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 22 Aug 2024 18:45:38 +0800
Message-ID: <CAF+s44TauSXk-gDgRHn=6CsQrAv8Q-QyGXkDJO+_sTh_yKde5w@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 4:23=E2=80=AFPM Lennart Poettering <mzxreary@0point=
er.de> wrote:
>
> On Do, 22.08.24 13:42, Pingfan Liu (piliu@redhat.com) wrote:
>
>  > On Wed, Aug 21, 2024 at 10:27=E2=80=AFPM Lennart Poettering
> > <mzxreary@0pointer.de> wrote:
> > >
> > > On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:
> > >
> > > > *** Background ***
> > > >
> > > > As more PE format kernel images are introduced, it post challenge t=
o kexec to
> > > > cope with the new format.
> > > >
> > > > In my attempt to add support for arm64 zboot image in the kernel [1=
],
> > > > Ard suggested using an emulator to tackle this issue.  Last year, w=
hen
> > > > Jan tried to introduce UKI support in the kernel [2], Ard mentioned=
 the
> > > > emulator approach again [3]
> > >
> > > Hmm, systemd's systemd-stub code tries to load certain "side-car"
> > > files placed next to the UKI, via the UEFI file system APIs. What's
> > > your intention with the UEFI emulator regarding that? The sidecars ar=
e
> > > somewhat important, because that's how we parameterize otherwise
> > > strictly sealed, immutable UKIs.
> > >
> > IIUC, you are referring to UKI addons.
>
> Yeah, UKI addons, as well as credential files, and sysext/confext
> DDIs.
>
> The addons are the most interesting btw, because we load them into
> memory as PE files, and ask the UEFI to authenticate them.
>
> > > Hence, what's the story there? implement some form of fs driver (for
> > > what fs precisely?) in the emulator too?
> > >
> > As for addon, that is a missing part in this series. I have overlooked
> > this issue. Originally, I thought that there was no need to implement
> > a disk driver and vfat file system, just preload them into memory, and
> > finally present them through the uefi API. I will take a closer look
> > at it and chew on it.
>
> It doesn't have to be VFAT btw. It just has to be something. For
> example, it might suffice to take these files, pack them up as cpio or
> so and pass them along with the UEFI execution. The UEFI emulator
> would then have to expose them as a file system then.
>
> We are not talking of a bazillion of files here, it's mostly a
> smallish number of sidecar files I'd expect.
>
Yes, I think about using <key, value>, where key is the file path,
value is the file content.

> > > And regarding tpm? tpms require drivers and i guess at the moment uef=
i
> > > emulator would run those aren't available anymore? but we really
> > > should do a separator measurement then. (also there needs to be some
> > > way to pass over measurement log of that measurement?)
> >
> > It is a pity that it is a common issue persistent with kexec-reboot
> > kernel nowadays.
> > I am not familiar with TPM and have no clear idea for the time being.
> > (emulating Platform Configuration Registers ?).  But since this
> > emulator is held inside a linux kernel image, and the UKI's signature
> > is checked during kexec_file_load. All of them are safe from
> > modification, this security is not an urgent issue.
>
> Hmm, I'd really think about this with some priority. The measurement
> stuff should not be an afterthought, it typically has major
> implications on how you design your transitions, because measurements
> of some component always need to happen *before* you pass control to
> it, otherwise they are pointless.
>

OK, I will look into the details of TPM to see how to bail out.

Thanks,

Pingfan


