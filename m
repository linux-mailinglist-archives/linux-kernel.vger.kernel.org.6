Return-Path: <linux-kernel+bounces-307651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279469650C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8ABB2136E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BDE1BAED8;
	Thu, 29 Aug 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="NZydtRyF";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="KvZwoxBm"
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3875524B28
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963351; cv=none; b=oUg1xmQqtfp5oUCrpog53hje+Ezo7R2osxAwPnZwETE/EWgNZEigFH3aLHtCTFkHOFAQuY4GvKV+MCSVBPbbPwj75Zy7Z/1LEr67w0I0ybuu0ZJMe6fvn5/JQpTr4u4+m536sBNak0PloXNFWDTEs97seNZyAfxzm8E2phiMc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963351; c=relaxed/simple;
	bh=849volckYMWkz8XfZeWLz51T1AB/VyL8ul5AhPBn++k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSfqZx2Xo0jyyjzs6rUUcfIkst+oK8FqV8cMxujRIXHYtwig4j33vVyY8eIh2QHZQ5U5G/kD7qv7EHFPat7YzdAK5jeV1RjSSsG7pkqBp3ClXK/gXXgRXUWjnGQWA0/rCM70AZqWzCjOr+YVNChMuuUI5wCKweDgAis3oG13l8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=NZydtRyF; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=KvZwoxBm; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724963349; x=1756499349;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=849volckYMWkz8XfZeWLz51T1AB/VyL8ul5AhPBn++k=;
  b=NZydtRyFB7uYpFV8SdNY8SIPUFTcCDUJhHRHSFagsYIsSc1Bywc3yZAA
   1XvChxlo6bLUogRz8SFFwdtscRgrSFS/1EWj6YcFMO4+ReJ6gxnw7/nw7
   sE9tkjqnk+bBbh1IVJNPEFtynrWgvk7vA0cBGdF4uW1UcfPPk2GKwgCR4
   kvWo6Y7LdyiP87o0CgL9q64ouCCz2MrklAoU9nPyPCi8V7fNN0TVxHUX+
   Jm4CiTt2RB5+RFpp9ckXrWFxX42DlOP+niaHQouQqHRv73WMYvFlsejmY
   ch//5wOuyN/L4UMJaHH2fNPo9TTZgXmWeaXGLUNIZBFW+mhGN0FMxoKEp
   w==;
X-CSE-ConnectionGUID: AWqySWcrTsij2WK8vh+sGQ==
X-CSE-MsgGUID: 11GwzaXXR+GK0G4CgguccA==
Received: from mail-io1-f70.google.com ([209.85.166.70])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Aug 2024 13:29:08 -0700
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso120870239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724963347; x=1725568147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=849volckYMWkz8XfZeWLz51T1AB/VyL8ul5AhPBn++k=;
        b=KvZwoxBmvT5XXJHfGY3dY6uENEmxpL6qscG7/gmbdNEGL/Ul8PnYN+9h2hQmioIaZ0
         0bbWWuPECVfPbthIFbwaff9cDSfTE7QZiiqZgIgSrdKbTJKYNa5BqGY9/N5j+fWOGppM
         SuzNM25u1Bhe70nK5bq9eOkmfJ8LbnGwUX888=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724963347; x=1725568147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=849volckYMWkz8XfZeWLz51T1AB/VyL8ul5AhPBn++k=;
        b=a4cRI7g6E4qLfeZV5U53hmpbOi0UcNQnFfX0y02kknCrDxkBX/WUPleCz66CgPUf/W
         dvdt32NUFGPp8WvppXGMTCMSnPTPCR5aFHSHB9/y1X1wLKxqz6dKWLtMRAr4wV4fJR9b
         aj0SNQ65Ex3TnAZtKqcKJakYl0OPlqJ3qBBTLO2npXY0yPIQTUNiD8yQty7YyCiTUrS0
         J3TJIn1o8avVTe3SvsTfiRUX1Sy4iKOfqZu05ZH8KOvoW8pAsz5p5PV6LiF+PK00Pj3P
         JsCN9nErpg3mbO8hBPpAAHFtKUYFoiXWNxTeFsSPKHylVg7IE63K7g1hH5zfGxJHmFDc
         2wcg==
X-Forwarded-Encrypted: i=1; AJvYcCUS8OBUF4Bu8jm9BvXhciD3lToGroj0R/XjIUpqqlfU0+dqIrWnGrrzLoc5qyk1WXZbNDv/pSeC3f7PVPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFcH5WHtcghEKxxPo5O4hjOT2WmoscVd+uqTyuiAzCwxqq3+zo
	ZTwNDtfjw33PL7hViwYlNAL0lwrglYCMuBIK4MTk1e4zORZdqLz8miSjdr8I3hLViNQiAbcvT/g
	eqFRv7KSmDtiZ8OWytBqPQbuwMD5bhzGx2KjCr8wNfqbQl1XcN0b6RKbM9xuKPfBmniFOUcaJbP
	NKAoKEj9C4DohfOT1j53oTQyP4DKEBromrDagpvg==
X-Received: by 2002:a05:6602:619a:b0:804:1579:182c with SMTP id ca18e2360f4ac-82a11011423mr490623039f.5.1724963347537;
        Thu, 29 Aug 2024 13:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE83jaTbymcBM8pIekmJUAAq30TW8KLn0Sslp6myqI8EisD5YCEbb4Xmx1iGNWzKslrwL+WV+35ICmn7wQKwDc=
X-Received: by 2002:a05:6602:619a:b0:804:1579:182c with SMTP id
 ca18e2360f4ac-82a11011423mr490621539f.5.1724963347200; Thu, 29 Aug 2024
 13:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANikGpf0OmGMSkksH_ihW9_yXVAL25xKD4CBy8d1gpKj0inPjQ@mail.gmail.com>
 <CAG48ez3b-FCz7+4MH=CmhbhmSfTT4FTrDAJfbL5UvufRut7ixg@mail.gmail.com>
In-Reply-To: <CAG48ez3b-FCz7+4MH=CmhbhmSfTT4FTrDAJfbL5UvufRut7ixg@mail.gmail.com>
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Thu, 29 Aug 2024 13:28:55 -0700
Message-ID: <CANikGpcNj6P1jH8v0NjZJeQdn2=FbPr71CJ8W8GE+OeiCMgucA@mail.gmail.com>
Subject: Re: BUG: kernel panic: corrupted stack end in worker_thread
To: Jann Horn <jannh@google.com>
Cc: Juefei Pu <juefei.pu@email.ucr.edu>, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jann,

I checked the kernel configuration we used and I found that we did
enable CONFIG_KASAN_VMALLOC and CONFIG_VMAP_STACK during fuzzing.
I've uploaded the full configuration to
https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd

On Thu, Aug 29, 2024 at 1:23=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Aug 28, 2024 at 1:49=E2=80=AFAM Juefei Pu <juefei.pu@email.ucr.ed=
u> wrote:
> > Hello,
> > We found the following issue using syzkaller on Linux v6.10.
> > The PoC generated by Syzkaller can have the kernel panic.
> > The full report including the Syzkaller reproducer:
> > https://gist.github.com/TomAPU/a96f6ccff8be688eb2870a71ef4d035d
> >
> > The brief report is below:
> >
> > Syzkaller hit 'kernel panic: corrupted stack end in worker_thread' bug.
> >
> > Kernel panic - not syncing: corrupted stack end detected inside schedul=
er
>
> I assume you're fuzzing without CONFIG_VMAP_STACK? Please make sure to
> set CONFIG_VMAP_STACK=3Dy in your kernel config, that will give much
> better diagnostics when you hit a stack overrun like this, instead of
> causing random corruption and running into the corrupted stack end
> detection.
>
> (Note that if you're using KASAN, you have to enable
> CONFIG_KASAN_VMALLOC in order for CONFIG_VMAP_STACK to work.)

