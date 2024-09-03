Return-Path: <linux-kernel+bounces-313478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0375F96A5E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E681F25B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD39018F2C3;
	Tue,  3 Sep 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjPudkq8"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A318C90C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385989; cv=none; b=ouOtlgI9IFFn+TrVhZUCVrwl9GVfsAisoKhsgn7DVLndOndTkoldLtkEmp3sliSquuZRxJAGUyvMKe7bb77LDK1NtOLhKdg/xhA4bq48bUtcvovmSrT9x1kTsxkOjuoPz1uxazZ78GKt/2+BR0BEjaBpund3mNl72BHhvG3a/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385989; c=relaxed/simple;
	bh=qsklfgnd5UqEXIqfQQCBwtoJQ4EBSLZoYc9fW2DMEyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdkJtHW84+zO5iXSKYiHFeNQaysxM5r9/zjwaAmTtk1OmC1Q1RbbI1+zAE1bFvFQLEHDpGlCMAhpsYNP8N31ULr43bWQ0xPHWIpKE7Qlv0tIx11CDjXG8Vs71kNqMQ+9QEopkxBbJUQ9Lj2SUReoowtcWzU5rD0Djqicba/RH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jjPudkq8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8695cc91c8so562888166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725385986; x=1725990786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsklfgnd5UqEXIqfQQCBwtoJQ4EBSLZoYc9fW2DMEyY=;
        b=jjPudkq8fThwvr/rWxL/WsMIPzu7XGkUm00x1j21noPPP6r+TUTbLCPkZoyEEW2znq
         DJAWN5CdAp6+k+K5aXtV4nGb6A4QXKmGbvXC6ByNamjPkxGYOCo8WnkgR76cYrO6+g4m
         o5tJbHz4p/ft0PIxmUv/p75Ph/u3OwwhAvGBm+H6oaMIlCpnMj+I+cGMaxSv22UM01mh
         v+kiqqQWWY9R/5ZzZ30RKmFQwLoWkWl2Ay8m+kOSqbPEtpBmXZ1FGOpbqTWf7kKRK0zv
         t6gwm2tI/vXpN5A8ouSzMsgPa7f3tSiA7nNf0F1oyTOCff6tIXSi+F6joScTJ2mPM66e
         ZiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385986; x=1725990786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsklfgnd5UqEXIqfQQCBwtoJQ4EBSLZoYc9fW2DMEyY=;
        b=jm9zolsV0BttGQ+blOgO9jhlaInBp4PzCCA/WOGxqrpchmCxtVy9kA+pKa0TEiWdMY
         utWdgjpdl5zNhodir2lqv97sgoqswTdhCuKNY0Tnt5yOmRdvo2AVE9hhXQM3RKJmqDSp
         sT5PZxFT3keitI5bCYLVpx7ik9v+5h0boGGBVxTrMF7NCJ8I2pqLyoHWfCskazhjlXp7
         hZ/uyFOeFX+vEAq7VRPI/ojuIIr8qfI95GDqOvTWUraxCDcY++YeAA6e+zyGL8FrOM0B
         wCCJiOPsMV5i4B3fhVW1nIg3Oc71vfO7qXTLuVQH4pNBV/UVPGhStt5/AFrmwyI/WtD6
         QuTg==
X-Forwarded-Encrypted: i=1; AJvYcCW/GgNjqGVO1qVWzqk/wPSdArQl/tOdUGkP6SUjx1+fpXwRWIuddksUgL2sRuXSTp6PjRLBKaYFzDXn1Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkyTKRWPjBLjjxSPzU0CqQnFTMofcEiwd4fQCLe4P4LBWZNmo
	D2/dFInF/4MWeLlxV+ZguxEEpQMa+PSRc66DFZu0t7qJ55Ciu8e2hFdS5/2YsWb8dhrKLTyP/VB
	ty08v+PGztwwIFcL5PVThkTIeufKae/Artk4W
X-Google-Smtp-Source: AGHT+IHvumS/WZFiMMvTc4vCSVDsRaX79qV4ow/vMV/gQtuqKssFxn5rlH+WDp6OH5yqrFkTK6AYR0DyHlPMNFDvDys=
X-Received: by 2002:a17:907:7251:b0:a86:7c5d:1856 with SMTP id
 a640c23a62f3a-a897fa744a8mr1602475166b.46.1725385985198; Tue, 03 Sep 2024
 10:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info> <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com> <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com> <27594ee6-41dd-4951-b4cc-31577c9466db@amd.com>
In-Reply-To: <27594ee6-41dd-4951-b4cc-31577c9466db@amd.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 3 Sep 2024 10:52:29 -0700
Message-ID: <CAJD7tkbO8J+2KfRnCPPoxmPzDHnpnbWfjHx9YJe_PtJ9S_yLPw@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: "Aithal, Srikanth" <sraithal@amd.com>
Cc: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 1:31=E2=80=AFAM Aithal, Srikanth <sraithal@amd.com> =
wrote:
>
> On 8/25/2024 11:25 AM, Piotr Oniszczuk wrote:
> >
> >
> >> Wiadomo=C5=9B=C4=87 napisana przez Nhat Pham <nphamcs@gmail.com> w dni=
u 23.08.2024, o godz. 18:16:
> >>
> >>
> >> Have you tried with 6.9 yet? IIRC, there are two major changes to
> >> zswap architecture in recent versions.
> >>
> >> 1. In 6.9, we range-partition zswap's rbtrees to reduce lock contentio=
n.
> >>
> >
> > Ok - after 32h of continuous compilation also on 6.9.12 I got series of=
 oops (see below).
> >
> I hit similar soft lockup with linuxnext-20240902 build, but I was not
> running anything for that long. Once I hit it while kexecing on
> linuxnext-20240902 and other time was during linuxnext-20240902 boot up.
> I have attached the logs here, I am trying to see if I can recreate it
> on todays linux-next build.

This doesn't look like the same problem to me. I do not see any zswap
functions in the backtrace, I see fuse stuff. Please send a separate
bug report to the relevant mailing lists (probably
linux-fsdevel@vger.kernel.org).

