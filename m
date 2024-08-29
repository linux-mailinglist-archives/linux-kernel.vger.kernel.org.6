Return-Path: <linux-kernel+bounces-307755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52613965272
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7745B1C24754
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B6E1BA270;
	Thu, 29 Aug 2024 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCNwoaNv"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9018A950
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968505; cv=none; b=r2RnvS8HkylC6H8Br8zig/q/w4hd/znzxGdablyApSwQcpW/TXZQO7Lr8R2DhNfTygqCMHKtfeZ5qWQ7Y2F9SDTK/X8yg3LidHWt0f9avqd9pn0wJCXfw0Cikndwfah5zOjrZevpRyiXzAcxfUPaCkephabh0t0gQbAhT96iVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968505; c=relaxed/simple;
	bh=X2J1Zruavdx6XZtyjF3WfuYLy3+4x0oPlle13EcoFtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+OzvOpvgK0jaPM8z6rFAc6CdjD2L9Sgs3DowZpQ4JaVnTWyGkQDSdWPPGA6KhBS8MuisI+Gs0tZgXbdw9JLQ9yDDyoBeaHFald5bZzhBwl83ygv9vZdRGdkAgZVO5Fb6ZXVIdHVO0Pf8QZOwP+KHtjGVq2Qp0RyjABjEYLe64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pCNwoaNv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so3839128a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724968502; x=1725573302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2J1Zruavdx6XZtyjF3WfuYLy3+4x0oPlle13EcoFtA=;
        b=pCNwoaNvvFbEmCawc+MIWpeuoWlwq4VdGmP2ELk36yv4WfFYZ8sTtqqnOkf7n/bdjr
         LIhhd+YVFPuRIe9T2+eaR7xqwGBwuwuaTrbLlkB7d6iBprZjt2WaNOg9IWAYUWZBzJ/V
         2NgFAV5QFjUtVLvJbGc0AeBWGd608vFU8IVh/GLntVObnN0oEsxdO89as+cmI3vseTFW
         Tmy5w+24CAMuECNEcifo8F349rzosQ68fN1ub4qesco3c6mCNfyYAtJ85LYS+YRbfKxh
         /4jdINgCttUtxgZmE2yu/NNcvwMzDDl4cw+APrqBGVgTu8xH5qyE26IIOMj5JuAD0FUR
         3Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968502; x=1725573302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2J1Zruavdx6XZtyjF3WfuYLy3+4x0oPlle13EcoFtA=;
        b=knHS1I4kByfcTQMigJNshyd18LyP/4V8O4K/OwedTvwa9/1ojwbxaXIMJTDvSaDt7+
         VJQVTPEdAR0nnXpZmpxTTjkEy7UJCqxUdtOZtprzb9C81bgkk6RR25zi42v6KolpK2m9
         W59Tvb+uM5BUD9HLMU6dFNoRR/EqAfxyLwLIcyCIgYS3by7hk+Wabyt/3kg1RsU2BPj/
         jv5ZuBr80vJPkjTobSDgPNk68Ovffv1M4LKY1G4oMXP17afJ+Z0lqRwxJiiUs5E9VLzh
         JOQPI5hIdT9nV7NYARCbS1TKHUKOtNtC+ZupkOsWPyY76bfdEBs1X/pwEpxUZOT9XcaU
         Sorw==
X-Forwarded-Encrypted: i=1; AJvYcCWzDLicbnCOIb5RoSGUv3/4GGN5VWtWokbk4RPO7ljP1BLX0hI3fQdyxMm0vgl7iCpgpQVv9bCMwWV4Mp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgv9W7uMg6HrVYJYwFFZ1bZ0cYLBOawW877NnPumRLUh438ouM
	awmNS2u/W+GK2usRrV2F2X9/adhEtxoCTCrQTVsJ22LqGptVVarPxHWMZBw2SIbYEGoysEWgpaS
	81c0fDXkphGmIcNF6/Kad1QNOmZLdvtXf3odo
X-Google-Smtp-Source: AGHT+IH4ZiYY7Gh1I4yhkeVflwkseKNXmSds8HXCeIwpuTOHYtBHBjH+rd6088PWHQ/1mRdQhrMjnIDBUnNE0bVXLxU=
X-Received: by 2002:a17:906:f5aa:b0:a86:96da:afb with SMTP id
 a640c23a62f3a-a89a2584293mr20082666b.10.1724968501505; Thu, 29 Aug 2024
 14:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info> <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com> <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com> <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
 <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com> <CAJD7tkbF2Cx4uRCJAN=EKDLkVC=CApiLAsYt4ZN9YcVUJZp_5g@mail.gmail.com>
 <EE83D424-A546-410D-B5ED-6E9631746ACF@gmail.com>
In-Reply-To: <EE83D424-A546-410D-B5ED-6E9631746ACF@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 29 Aug 2024 14:54:25 -0700
Message-ID: <CAJD7tkZ01PPYMzcTyX_cwr836jGonJT=fwT3ovc4ixW44keRgg@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:51=E2=80=AFAM Piotr Oniszczuk
<piotr.oniszczuk@gmail.com> wrote:
>
>
>
> > Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed <yosryahmed@google.com> =
w dniu 27.08.2024, o godz. 20:48:
> >
> > On Sun, Aug 25, 2024 at 9:24=E2=80=AFAM Piotr Oniszczuk
> > <piotr.oniszczuk@gmail.com> wrote:
> >>
> >>
> >>
> >>> Wiadomo=C5=9B=C4=87 napisana przez Pedro Falcato <pedro.falcato@gmail=
.com> w dniu 25.08.2024, o godz. 17:05:
> >>>
> >>> Also, could you try a memtest86 on your machine, to shake out potenti=
al hardware problems?
> >>
> >>
> >> I found less time consuming way to trigger issue: 12c24t cross compile=
 of llvm with =E2=80=9Eonly 16G=E2=80=9D of ram - as this triggers many hea=
vy swappings (top swap usage gets 8-9G out of 16G swap part)
> >>
> >> With such setup - on 6.9.12 - i=E2=80=99m getting not available system=
 (due cpu soft lockup) just in 1..3h
> >> (usually first or second compile iteration; i wrote simple scrip compi=
ling in loop + counting interations)
> >
> > Are we sure that the soft lockup problem is related to the originally
> > reported problem? It seems like in v6.10 you hit a BUG in zswap
> > (corruption?), and in v6.9 you hit a soft lockup with a zswap lock
> > showing up in the splat. Not sure how they are relevant.
>
> If so then i=E2=80=99m interpreting this as:
>
> a\ 2 different bugs
>
> or
>
> b\ 6.10 issue is result of 6.9 bug
>
> In such case i think we may:
>
> 1. fix 6.9 first (=3Dget it stable for let say 30h continuous compil.)
> 2. apply fix to 6.10 then test stability on 6.10
>
> >
> > Is the soft lockup reproducible in v6.10 as well?
> >
> > Since you have a narrow window (6.8.2 to 6.9) and a reproducer for the
> > soft lockup problem, can you try bisecting?
> >
> > Thanks!
>
>
>
> May you pls help me with reducing amount of work here?
>
> 1. by narrowing # of bisect iternations?

My information about the good (v6.8) and bad (v6.9) versions come from
your report. I am not sure how I can help narrow down the number of
bisect iterations. Do you mind elaborating?

> On my side each iteration is like
> -build arch pkg
> -install on builder
> -compile till first hang (2..3h probably for bad) or 20h (for good)
> this means days and i=E2=80=99m a bit short with time as all this is my h=
obby (so competes with all rest of my life...)
>
> or
>
> 2. Ideally will be to have list of revert 6.9 commit candidates (starting=
 from most probable falling commit)
> i=E2=80=99ll revert and test

Looking at the zswap commits between 6.8 and 6.9, ignoring cleanups
and seemingly irrelevant patches (e.g. swapoff fixups), I think the
some likely candidates could be the following, but this is not really
based on any scientific methodology:

44c7c734a5132 mm/zswap: split zswap rb-tree
c2e2ba770200b mm/zswap: only support zswap_exclusive_loads_enabled
a230c20e63efe mm/zswap: zswap entry doesn't need refcount anymore
8409a385a6b41 mm/zswap: improve with alloc_workqueue() call
0827a1fb143fa mm/zswap: invalidate zswap entry when swap entry free

I also noticed that you are using z3fold as the zpool. Is the problem
reproducible with zsmalloc? I wouldn't be surprised if there's a
z3fold bug somewhere.

>
> i=E2=80=99ll really appreciate help here=E2=80=A6.
>

