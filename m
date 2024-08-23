Return-Path: <linux-kernel+bounces-299483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4495095D567
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747271C214E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62973191F62;
	Fri, 23 Aug 2024 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uat72JGq"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964918DF81
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438580; cv=none; b=SEcnf9UboKTG3lHfsF5xkrvHIkuJUMpPaz/0fPT66BrnDACAk4Vw3L/ec+b+TUnLUJyoG9+uH+HUgmIdglKpccoChp6B1RUWwCKaRypwYIsa8BIHsws4b/FjguMGVV4En7KzcpJVW6Xy9It06+0hnJZRvC2hdY8xTCAcW7ZrcLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438580; c=relaxed/simple;
	bh=vDPsqzAoxenIzuwcubdWFxYwhXNsFjnpCK8a2v37uUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmFCEn58M+1GLq4CN8VDZy24dqmyA4hTuTWFkOwzegPOIY8SntMGLwBcaOG9Diu501y3fs9kivcogVUwsgMIqz2oC0JVTWKh+ppBurJUhFKCAkACMquZO51V4dW5fvlChyb6og5zNomI3GsgJk9eEMKXNOEz/z1DqA/ExXPhOas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uat72JGq; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso2289055276.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724438578; x=1725043378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDPsqzAoxenIzuwcubdWFxYwhXNsFjnpCK8a2v37uUA=;
        b=Uat72JGqv46cTdWnDSsnkvLy0/FFPFy+L8QFzM/qXkQnlrIiJ+aHxYVk8+q8RINwYo
         U4HHF2/0kMN6sKQEDVHrW+Z0ElaxJbKw76HLzWgFYfexuB3EbNiQlP7rSU0LC9sGaGV+
         QRxkOXPXXDbo/izOqNnN19vUTX/Ys5wXKc4Je6NOA5CaVmYIBByK23CcgVpdqBrq3Uw8
         4TY+7HRgQw5IByyJ7MUU1n8BP2dc19V65qoIfUstKdfbePPD3RImRze9fjy4e9rEaoHa
         EFJANQNrOsKZMWLCSul3B11Hkoh6Ql17Hvc6K4pvag12H94XjOzKXsIEJRig1N42idSZ
         AEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724438578; x=1725043378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDPsqzAoxenIzuwcubdWFxYwhXNsFjnpCK8a2v37uUA=;
        b=bXKvhZ8M8mskioyoYoHmmm49q1OxPiGitrl51azSNSmD7YFtN2CcPTWH8rEOPVnuId
         VM6b8Prc10ciZEH4/cDGw2nrRPu2RxdVgxr9rbDEy1cIar7x/6AbSyXisq9y3DXtdydu
         pS+mbSTcxqwFUPX6tL1AB9VLhdGPFpyPvSOT9ATXTbtYzUt+WjIgjN+6k0ih0R7L3WHH
         Ep95NA4HPlIy70n+aDtZeWXjDmO1wuZiY7io72fCgwYbJDNAUgWB9/nMCsTCKHV1aSuS
         lCvUJSL6w7hehWb1jtaC7pif0ttYRxvVbixKhKAhkvre73FLwa0OHkFc8QNbSsCOc/ed
         m+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCW08TY25UlMD1xcVdOle8f9E/R1vK2vhRcShnB6CtuSYJG8Oo5J9wU9wzkRtc4P1jD0L03xHCqMemV0g0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwblGYkbb/KJif9JrXbWeRZqvmfRHvFm2nefcR5X+5Xpju4F1kx
	P8UPMQliSgnHeIEqambmsRabKDem9xfJ06sah2xkmUSf0hwYGPszomvRIvyyvAdgn3eSerWkcOZ
	20BDYvvE7GKnh7Elny3A57mpWaAc=
X-Google-Smtp-Source: AGHT+IGP5XOWs22Ob+Od8cQep7S+t0IxbSv28R6vyQfhdmlVTie8ZZ9QOHt1cMUuQWZzMD4Z85T69CYO082JM6cj92s=
X-Received: by 2002:a05:6902:1501:b0:e13:c854:2a2 with SMTP id
 3f1490d57ef6-e17a83b28d3mr4049002276.11.1724438577951; Fri, 23 Aug 2024
 11:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info> <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
In-Reply-To: <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Sat, 24 Aug 2024 03:42:47 +0900
Message-ID: <CAPpoddere2g=kkMzrxuJ1KCG=0Hg1-1v=ppg4dON9wK=pKq2uQ@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Nhat Pham <nphamcs@gmail.com>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B48=E6=9C=8824=E6=97=A5(=E5=9C=9F) 0:07 Piotr Oniszczuk <piotr.o=
niszczuk@gmail.com>:
>
>
>
> > Wiadomo=C5=9B=C4=87 napisana przez Matthew Wilcox <willy@infradead.org>=
 w dniu 23.08.2024, o godz. 15:13:
> >
> > I wouldn't be surprised if this were dodgy ram.
>
>
> Well - that was my initial hypothesis.
>
> in fact i had few of them. Ranked (and ordered) like this:
> 1. downstream kernel patches
> 2. hw (ram) issue
> 3. kernel bug
>
> So full history was:
> -build myself archlinux 6.10.2 kernel; upgrade builder OS (only kernel; n=
othing else)
> -run normal devel process and (to my surprise) discover interrupted CI/CD=
 builds by kernel oops
> -downgrade to 6.8.2 and done 4 full builds (full takes 8..9h of constant =
12c/24/t compile). all good.
> -prepare vanilla 6.10.6 (to exclude potential downstream (ArchLinux) root=
 causes)
> -run normal devel process and still discover oops
> -make sure hw is ok by week of test with 6.8.2 (recompiling for 3 archite=
ctures on 4 OS (3 in kvm). This was almost 5 full days of 12c/24 compiling.=
 All good
> -because last steep was all good - decide to go to you :-)
>
> sure - this is possible that 6.8.2 had luck with my ram and 6.10.6 had no=
 luck=E2=80=A6.but i personally don=E2=80=99t believe this is a case=E2=80=
=A6.
>
> btw: we can go with elimination strategy.
> So what i need to change/disable to be closer to finding root cause?
> swap?
> now it is swapfile on system nvme
>
>

Hello,

I=E2=80=99m encountering a similar crash and trace in the issue I posted on=
 Bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=3D219154

If this is the same issue caused by virtio_net corrupting memory, you
should be able to reproduce the crash by sending data to the VM over
virtio interface while it is actively allocating memory (e.g., using
iperf3 -s on the VM and running iperf -c from another host).

In my case, as Thorsten suggested, reverting bisected commit
f9dac92ba908 (virtio_ring: enable premapped mode regardless of
use_dma_api) along with two related commits in this series resolved
the issue:
https://lore.kernel.org/all/7774ac707743ad8ce3afeacbd4bee63ac96dd927.172361=
7902.git.mst@redhat.com/

