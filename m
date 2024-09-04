Return-Path: <linux-kernel+bounces-314002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B996AD88
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36941C23FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4527517FD;
	Wed,  4 Sep 2024 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS8iyWu5"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0B39B;
	Wed,  4 Sep 2024 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725411454; cv=none; b=fZCCqykurcnbvktlZtnyJ/vLF2p68uQlvgv9B8OsOGrayHLvhYaXH7E3YkCfzuJo8UzQI97VGzTiP4Qp4nyficwZgTmLr19TYVGdhmWpflN2h6iE1d0Eh0/3RaQQUKRWydl2e1vgf3vWb20rl1kzQPxfJ4tbnTXGXpAYXUcN7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725411454; c=relaxed/simple;
	bh=8JvvfwcxoZGT5zbfnSHoqeDfuTlwgxPyBi8lhPLLp8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uF+BSn9KGsTLmim3PODOt4bnkiIq7XrrCwHtloNxYtJO6jv91fSz6KJc7qfzj3ErNmaT8eF1Cuw5N8ZVl7Cz3UCURshi06lAcGSenBLZa5BIQRg2Nnl8dQozGMhglJJg6BB3ybjwE9095GgwZYFxlQYuz/mXtw7PjTvuM9q4JUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS8iyWu5; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5de8b17db8dso3574633eaf.2;
        Tue, 03 Sep 2024 17:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725411452; x=1726016252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gdWZihFLmXnMT6aCYKGEU34zWd8T6tn0I3DQDEBdks=;
        b=CS8iyWu5V65nwVZInmTjaj089uNmQz+16rnbP2jRXeDa1uRyE9FflJCHWxybPL2WSc
         WcQ4faVxgxYe45ViVhG5kQzNimshlw5ipAWhHYyIQXr3PuyIDgUJbzyZwaIgiHfqhRdB
         68FnE5UXkH328M0wEjIngO4WyCqEnbOhSIiZ2Zs7kgCDuk3ySUjE/0Cw0NPObKYmcaOJ
         l1NrD4/Dbdr8pHL6MXDU80DJeRl/ekul07Mhrc5PslGcvbbaysZMuWEDj4l56Az8324R
         p1UOVXiAyM840UVooLGTAS2o/NOn7ydZQhSdU/hjKAc06QkXb/SYXDEYr67zc0627cKr
         ps9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725411452; x=1726016252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gdWZihFLmXnMT6aCYKGEU34zWd8T6tn0I3DQDEBdks=;
        b=sg0alAXDAfaJfxMCmtrYK+Q+keTrQvx5ctlsEftX07yNBO6U8KLmxaTaM29jtxxdF/
         ceMmuuL8wPnwNuuhQfAuGCprxHhlvRa+HleM8Vl8InykArGl2SUCx4zrvEq2WzQyp3e1
         rE1idQFipbAlREA+dPeAvp21HA3wwg6itRrHt4o7RKXw5DqIpVmUyRxaJoseV5LVhkOm
         cTW4EfN1sVxxmsA/uVb+c0p9UPMMKq/z0+TOD0a+cVeejp+G/lEF77Feyd/WQhE7e6N6
         nhF2i7Apnhlsxh9RHRmYJ5dl2OV7X9Xt3oMGtRTWC7DJ7GdUNnTLTdGJBDs85V5/luw9
         jz4w==
X-Forwarded-Encrypted: i=1; AJvYcCUjRV4cDANIuWvyRiAJu6UXQ70k+5gWOD3B9PL8Ce1t6wRs6wRUzyYdChCqE5xHl4dqtQnWyeWqIyE=@vger.kernel.org, AJvYcCUtFvqJfOgNrOSsp3cRMeRkGNl22QuxxWZI49fcouytjpmouFcijhVyvp/gheFJI7yUr41WYNJNoXmAWnCx@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ/s+sEKjDSz+N24KUjhOZqcMn9/AssoDDrLZTQNQgXIJoYIS7
	gQ/9x7CStVOdg/rdTOl5v/a/JlyPCmJP9t7rma0LCVJ5RCIyXWQ6DwgqimrB4QaEHZpse6nRukx
	mqEyNkBIwyxOO6jPqLsaqdMNWaUE=
X-Google-Smtp-Source: AGHT+IH8LhzXuBDtphoV66oRGm71mpDc1Mo8k86cqV9gx9VexIPPk0UFLHgoaLEjrPALjrLNXfGVRqtzHKIpE5LtVW8=
X-Received: by 2002:a05:6871:8ab:b0:270:1f1e:e3ea with SMTP id
 586e51a60fabf-2779013e567mr23407349fac.28.1725411452015; Tue, 03 Sep 2024
 17:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725174632.23803-1-tttturtleruss@hust.edu.cn>
 <a6285062-4e36-431e-b902-48f4bee620e0@hust.edu.cn> <CANpmjNOiMFUM8KxV8Gj_LTSbC_qLYSh+34Ma8gC1LFCgjtPRsA@mail.gmail.com>
 <bd647428-f74d-4f89-acd2-0a96c7f0478a@hust.edu.cn> <CANpmjNMHsbr=1+obzwGHcHT86fqpdPXOs-VayPmB8f2t=AmBbA@mail.gmail.com>
 <241be3d1-2630-471f-9c04-3b4004b5d832@hust.edu.cn>
In-Reply-To: <241be3d1-2630-471f-9c04-3b4004b5d832@hust.edu.cn>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Wed, 4 Sep 2024 08:57:05 +0800
Message-ID: <CAD-N9QXVY8iKd6uMakpvfvRNSiKec+GtjJ9k3sic8GyqEMXe-w@mail.gmail.com>
Subject: Re: [PATCH] docs: update dev-tools/kcsan.rst url about KTSAN
To: Jonathan Corbet <corbet@lwn.net>
Cc: Marco Elver <elver@google.com>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Dmitry Vyukov <dvyukov@google.com>, Haoyang Liu <tttturtleruss@hust.edu.cn>, 
	hust-os-kernel-patches@googlegroups.com, kasan-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:05=E2=80=AFAM Haoyang Liu <tttturtleruss@hust.edu.=
cn> wrote:
>
>
> =E5=9C=A8 2024/9/4 2:01, Marco Elver =E5=86=99=E9=81=93:
> > On Tue, 3 Sept 2024 at 19:58, Haoyang Liu <tttturtleruss@hust.edu.cn> w=
rote:
> >>
> >> =E5=9C=A8 2024/7/26 16:38, Marco Elver =E5=86=99=E9=81=93:
> >>> On Fri, 26 Jul 2024 at 03:36, Dongliang Mu <dzm91@hust.edu.cn> wrote:
> >>>> On 2024/7/26 01:46, Haoyang Liu wrote:
> >>>>> The KTSAN doc has moved to
> >>>>> https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md.
> >>>>> Update the url in kcsan.rst accordingly.
> >>>>>
> >>>>> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> >>>> Although the old link is still accessible, I agree to use the newer =
one.
> >>>>
> >>>> If this patch is merged, you need to change your Chinese version to
> >>>> catch up.
> >>>>
> >>>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> >>>>
> >>>>> ---
> >>>>>     Documentation/dev-tools/kcsan.rst | 3 ++-
> >>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-=
tools/kcsan.rst
> >>>>> index 02143f060b22..d81c42d1063e 100644
> >>>>> --- a/Documentation/dev-tools/kcsan.rst
> >>>>> +++ b/Documentation/dev-tools/kcsan.rst
> >>>>> @@ -361,7 +361,8 @@ Alternatives Considered
> >>>>>     -----------------------
> >>>>>
> >>>>>     An alternative data race detection approach for the kernel can =
be found in the
> >>>>> -`Kernel Thread Sanitizer (KTSAN) <https://github.com/google/ktsan/=
wiki>`_.
> >>>>> +`Kernel Thread Sanitizer (KTSAN)
> >>>>> +<https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md>=
`_.
> >>>>>     KTSAN is a happens-before data race detector, which explicitly =
establishes the
> >>>>>     happens-before order between memory operations, which can then =
be used to
> >>>>>     determine data races as defined in `Data Races`_.
> >>> Acked-by: Marco Elver <elver@google.com>
> >>>
> >>> Do you have a tree to take your other patch ("docs/zh_CN: Add
> >>> dev-tools/kcsan Chinese translation") through? If so, I would suggest
> >>> that you ask that maintainer to take both patches, this and the
> >>> Chinese translation patch. (Otherwise, I will queue this patch to be
> >>> remembered but it'll be a while until it reaches mainline.)
> >> Hi, Marco.
> >>
> >>
> >> The patch "docs/zh_CN: Add dev-tools/kcsan Chinese translation" has be=
en
> >> applied, but they didn't take this one. How about you take it into you=
r
> >> tree?
> > I don't have a tree.
> >
> > Since this is purely documentation changes, could Jon take it into the
> > Documentation tree?
> > Otherwise we have to ask Paul to take it into -rcu.
> >
> > Thanks,
> > -- Marco
>
> Ok, I will send this patch to Jon and see if he can take it.

Hi Jon,

Could you please take this patch to lwn tree maintained by you?

P.S., it seems Jon is in the cc list previously.

>
>
> Thanks,
>
> Haoyang
>
>

