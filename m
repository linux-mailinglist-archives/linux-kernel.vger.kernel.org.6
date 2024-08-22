Return-Path: <linux-kernel+bounces-296657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28CB95AD4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6070D2865B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC06213667E;
	Thu, 22 Aug 2024 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrZpW736"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E6E5674D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307408; cv=none; b=F6wCIRMCMi6tSHDiZduUudgi9n07pHc1yogEiXAz7vNuhMl434TKwW/AjkHmypCT/yyhAhzEzpf5jE0+UumM4xGLlB0s4tyqzyJkr3r8LYVah884XpRwyFFgD1DdSlGAPk4Xe78fyjAvu7iNXt2Xqt0mROd2gVYsb/Ei90E2Otc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307408; c=relaxed/simple;
	bh=ZRtpR6qW3kByodhkp2S63DBeP13jYPrOQcX6IMWTzn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+JwDwGwKmxHNSBk86HoSifMVXyW8NTM7MPi7gqRqsvFK8MB2s1MrrTe8ud1uyRpIh8xB3wIYV59eHB+zKGf0mmS3Val7gBL4aF7fogQCNPAYYC2EGvcEXvy7JpjhX95msvJf2LlYxXlUV28Oah0MBzTMgXbNepAjGvwxLHcS0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PrZpW736; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724307405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSahsupX5qbmfW5OFxsv4IPaJH74ypJqJsCg65c2Ydw=;
	b=PrZpW736NM2/X3G5iA5yJdIlxsBUrEDCPqkilGlHCwr0OV7sz0MAxqK/Qu5JF5IV9DnIkG
	MDKYYSYxKqRGQLAqD/ngvQn8TBn5mJazXFJyhO5jd7mOyBvy1g/1mdS6of6jG1zVPpZrOC
	kigKvtgW8WODiuEDCdGMyvwt0PsDG+g=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-gLMCdFMiM9uDhKpC1nutIQ-1; Thu, 22 Aug 2024 02:16:42 -0400
X-MC-Unique: gLMCdFMiM9uDhKpC1nutIQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d3325ba79so4634755ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724307401; x=1724912201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSahsupX5qbmfW5OFxsv4IPaJH74ypJqJsCg65c2Ydw=;
        b=ZL7pyRkB39m+M8Ijamnwn7/MuNnr8z1PghuP/gaih/RsLF02mjyyawEZxfUQfIBUqw
         wd9djLq9+lO6BuSuXduErNqGGApicCTDFYWUsy/yn5GD5yrZz+F6FmkeEJkOW6Jl4iPq
         iGB6iY+nAGGS9YmHyTjrBKC2YPaFGzxeCJirDk5P7IC4ryVzSZe994Pq0q8wdzEBThQa
         WNPTFYvZkXapbMa/LKY3iZxkG+WNeo3o/n3WDRCWM6LbwFOTTJ6B5ntZFOsC3GzJIYCq
         ZnmdADOCXtqDyNtbSfXqfBpOZMGdVibhRcwASpHphWHF+OQKMFOhBEwgcVelwTTVREJ5
         YyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtaVaS2XuQ2/OI9B+1SEse2bg4raZACXJ7TYh1/X9VAvmY1oMLhpw75RSB1UVyQcmETjJW2kDK6MN1jq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkx6qfO8K1a1rdVBLUYxveOHBd+3+tsO7mFgh7Pe3FzQRsCxGX
	VeEk2CM3ozGPR+8ZLQncoSGGJyndk6o6UTgc9UIR+Z2/9wXGWk199Z/lhItHHLTT8jbVa9CEFGH
	egMUtKbu0dtwDOmH5OkiZufPFcCrYE4vY7HT50KBZzWjViXzhFLy1shmKs0+2eWVx4mtMLip+pG
	5tKAO1Y3KvtEp2tV7qCLolCfAsjsmUYjEKW3IH
X-Received: by 2002:a92:b745:0:b0:39b:3b8f:d181 with SMTP id e9e14a558f8ab-39d6c38a977mr47438595ab.16.1724307401346;
        Wed, 21 Aug 2024 23:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH45XUtslNPtqySBkEnjHv7Gr46zrLG1FE2KFfoX7jWbSc0uq7wXAjET+a9wR5jjhVYDVE5eNfqaZtKRehaTE8=
X-Received: by 2002:a92:b745:0:b0:39b:3b8f:d181 with SMTP id
 e9e14a558f8ab-39d6c38a977mr47438355ab.16.1724307400980; Wed, 21 Aug 2024
 23:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
In-Reply-To: <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 22 Aug 2024 14:16:52 +0800
Message-ID: <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Pingfan Liu <piliu@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Aug 2024 at 13:42, Pingfan Liu <piliu@redhat.com> wrote:
>
> On Wed, Aug 21, 2024 at 10:27=E2=80=AFPM Lennart Poettering
> <mzxreary@0pointer.de> wrote:
> >
> > On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:
> >
> > > *** Background ***
> > >
> > > As more PE format kernel images are introduced, it post challenge to =
kexec to
> > > cope with the new format.
> > >
> > > In my attempt to add support for arm64 zboot image in the kernel [1],
> > > Ard suggested using an emulator to tackle this issue.  Last year, whe=
n
> > > Jan tried to introduce UKI support in the kernel [2], Ard mentioned t=
he
> > > emulator approach again [3]
> >
> > Hmm, systemd's systemd-stub code tries to load certain "side-car"
> > files placed next to the UKI, via the UEFI file system APIs. What's
> > your intention with the UEFI emulator regarding that? The sidecars are
> > somewhat important, because that's how we parameterize otherwise
> > strictly sealed, immutable UKIs.
> >
> IIUC, you are referring to UKI addons.
>
> > Hence, what's the story there? implement some form of fs driver (for
> > what fs precisely?) in the emulator too?
> >
> As for addon, that is a missing part in this series. I have overlooked
> this issue. Originally, I thought that there was no need to implement
> a disk driver and vfat file system, just preload them into memory, and
> finally present them through the uefi API. I will take a closer look
> at it and chew on it.
>

Hi Pingfan,

If more and more stuff needs coming in,  not only the limited boot
services then it will be way too complicated and hard to maintain and
debug,  also the two kexec code paths are duplicated somehow. It is
really bad..

I forgot why we can not just extract the kernel from UKI and then load
it directly,  if the embedded kernel is also signed it should be good?

Thanks
Dave


