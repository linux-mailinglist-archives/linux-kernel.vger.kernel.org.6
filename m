Return-Path: <linux-kernel+bounces-358736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CF9982FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43288B21A60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFB1BDA89;
	Thu, 10 Oct 2024 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YT5jwcCk"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087C19E7D0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554260; cv=none; b=ETWn8OjnYTkhHEXVdosI+RsxfCUNr8luhmweAXiORkJIwZOrao0Nn2zPTF6gkIFRj6Igvnfaz763oAsgO+QPSYqORzZL/zQRkGIzpessUsOKIH8nwWIJCaKybgN0ET4PVZ1T9Jup9WRL58ZZH3JM1AiMybhfTlwwObTTvwr5YMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554260; c=relaxed/simple;
	bh=dJ57paU3yob7a98B5OTRsIY7OeCtfujMFlrYsNqU8PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbCyE4ajafqYnY40E+WuHIzlg0z+wpReRbg50pW8j3HM/LoGvRIvCfYKaQUWbACGyRO5rXxDTx5I0S3e37EvfkHBL/FGbLaDGlAVMG3o/Mx+HHeRbX9Z2niQ6hMe5JhrD2d738aoWxYMfKCoV4WMzh2l4NmiC8UARwmIUkPCIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YT5jwcCk; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e28ea358f65so651199276.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728554258; x=1729159058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2ArA4ZcoREZanu8i6/c0JbOGoOWnzH6250enjQ0frk=;
        b=YT5jwcCkqs8gCzvkaW6EQFS8XxibjtMZnbStmPqAExpyFwzXGZKxcUdX6AB40AWlNx
         HKDS/V+kFwgc2YUStqkKc8+IBLfkNPRW2azad1Sl56Du6MnTTz6k0UkSzzjv1bgYxKuT
         Acu4RW/k9r2tNlt//BEX1moyp8/w2mwtHsG0gw+ozLIlLhLmIjqDVBpOitMhpV0N7N8J
         3yvUif/yPhH+8JR3Ai9OkXv7co7rVrDfMX6LJ85O17stjxBMXQ3BTo0VOhUuo+JVxIcI
         82ovVsrk+2yeGMWHvtsnrtHFcQUfTuY3FcwJ0bXx856/LUKZCaiBG4dFYiAPh9RGj1+b
         lG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728554258; x=1729159058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2ArA4ZcoREZanu8i6/c0JbOGoOWnzH6250enjQ0frk=;
        b=izDRaOOEB7w5bTS0B/ORRYSBsqDKKgCTDqyg0kovToqsT62gA8w13r+EPzfa0xb0CJ
         wlPH7/lE0v+d4mVZ89WZCSPSO/lmtn3pgtj9CpgCfmiG55ihY3AthTPrMkIuvcOPy1Gi
         kYY869LAOJ5GGcRv5OV/VDBI/JM8PhEK6AG7tC2BojOLOJdmepC/J8rWDuYuGPCIfZzN
         ANcpVXqSZqd4QV/PaobrioN1JQrKFj+sCXjJHWQ5ZL3YjVdy8x5wbJVfndUyqLZHnQ1T
         zt19zsliAZq4sNyOae0t4sXn16cVpTwnsoI/fjybmZnmBDFG1pRJPdlNUwMQDHH1Qhqe
         qxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXijtgxg/4tzOmNYiQcRjrquIFUqDFez93wuMYCF1SpFmqeQRtrsxoRdhhFTFgaTcshNec8ERLs+SeRtGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2Uw75pnNgy3/oMnuDwieDs3CvDveihV/GiAJ9QbEZKHMXpCL
	P+CwMIs7iTV9BkdAcDZOvzRhXDphWesqetAFc1JYMgtlNpZ6+jhWllavDf+7O/z8GdoUGPmrr2x
	OchJZsDSD7F0vAgj2RBSGWTRtKpZ06y7R1hJBdw==
X-Google-Smtp-Source: AGHT+IFutXdu1n6F87Ao7/fpG55G3IQ3I7av3UbOLSvXJvC0UI/LJPXg6XG5U7GQSsXzAx+mdlHswYAlQWxtVCzTHio=
X-Received: by 2002:a05:6902:140e:b0:e16:4ca7:7acf with SMTP id
 3f1490d57ef6-e290b7cefa9mr1978248276.10.1728554258022; Thu, 10 Oct 2024
 02:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
 <CAPDyKFoHrRGYkNCu0ev8iF6e8tQV7cbTAxm9jS0CCqvizmoWmw@mail.gmail.com> <CAK00qKAUg5VFkxbrYUeFjRq+3UN2dcOZ0RJFDK2e3tCxKOJNLQ@mail.gmail.com>
In-Reply-To: <CAK00qKAUg5VFkxbrYUeFjRq+3UN2dcOZ0RJFDK2e3tCxKOJNLQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Oct 2024 11:57:00 +0200
Message-ID: <CAPDyKFqhbt-u8qRCfvssSBDT5RUchj6gJj=4a75dEdpp++emdg@mail.gmail.com>
Subject: Re: [PATCH V22 00/22] Add support UHS-II for GL9755 and GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Oct 2024 at 08:20, Victor Shih <victorshihgli@gmail.com> wrote:
>
> On Mon, Oct 7, 2024 at 11:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Fri, 13 Sept 2024 at 12:28, Victor Shih <victorshihgli@gmail.com> wr=
ote:
> > >
> > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > >
> > > Summary
> > > =3D=3D=3D=3D=3D=3D=3D
> > > These patches[1] support UHS-II and fix GL9755 and GL9767
> > > UHS-II compatibility.
> > >
> > > About UHS-II, roughly deal with the following three parts:
> > > 1) A UHS-II detection and initialization:
> > > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> > >   Sequence[2]).
> > > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequen=
ce
> > >   [2]).
> > > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is inclu=
de
> > >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> > >   Setting Register Setup Sequence.
> > >
> > > 2) Send Legacy SD command through SD-TRAN
> > > - Encapsulated SD packets are defined in SD-TRAN in order to ensure L=
egacy
> > >   SD compatibility and preserve Legacy SD infrastructures (Section 7.=
1.1
> > >   Packet Types and Format Overview[3]).
> > > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UH=
S-II
> > >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2=
]).
> > >
> > > 3) UHS-II Interrupt
> > > - Except for UHS-II error interrupts, most interrupts share the origi=
nal
> > >   interrupt registers.
> > >
> > > Patch structure
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > patch#1-#7:  for core
> > > patch#8-#20: for sdhci
> > > patch#21:    for GL9755
> > > patch#22:    for GL9767
> >
> > Patch 1 -> 6 applied for next, with some minor updates to patch2.
> >
> > Patch 7 needs some more work, I will comment on that separately.
> >
> > I am okay with patch 8 -> 22, but since there will be a re-spin for a
> > new version, perhaps you can run a new round of checkpatch.pl to see
> > if some of the warning that it reports can be fixed too.
> >
> > [...]
> >
> > Kind regards
> > Uffe
>
> Hi, Ulf
>
> I really appreciate your reply and I will resend the new series of
> patches before the end of next week.
> Do I need to include patch 1 to patch 6 when re-sending the new series
> of patches?
> Or should patch 7 to patch 22 be sufficient?

Hi Victor,

Patch 7 to 22 is sufficient. Just rebase the series on top of the
mmc-tree's next branch, then you should be good to go.

Kind regards
Uffe

