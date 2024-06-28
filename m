Return-Path: <linux-kernel+bounces-234125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3A91C27B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B48E1F24A61
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AA61C8FD0;
	Fri, 28 Jun 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh4PM90K"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01461C9EAC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587971; cv=none; b=Wuos31lt4nTofH57/KEGo8cbAs8KobzkV7I3c9rxaG9kpwgMGoxaBlMl4cw0JzFlHCaq2SxqAZO2rWxadv7DIjmyof2iXsgmLCQsBlURHCF7KFauUPLFLu7bQLjC3NImQQ+u6Cd8N2q5icapL6QL70XBmlKEbhwz1ozXrQcjE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587971; c=relaxed/simple;
	bh=Pmjri7yaLe7QXW9juAdGl9QopQ/cO6H/4cwPORHxTGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhFl1tSsrRVx+z99oBtilSoxeBBHYQeFA6bxW3CNuNz7wz6TovmIk3+TrhubJnORb0Q4WQKBzosg7Nh/q/R8aHilfEY2Kfftotjuhg1K6Xfp800dYynQwDCvq9gMcS14uhNvlPgjNHtHGRlvdIOFAkf8yWrcZyhrQqrAFyq+9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh4PM90K; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c7bf925764so547307a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587969; x=1720192769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmjri7yaLe7QXW9juAdGl9QopQ/cO6H/4cwPORHxTGQ=;
        b=Zh4PM90K8Os5aOk5d1RmK6q4pOMGMHqg1JfzJDVYIfpiCxI3jVen/8BZcR5ao/sHHc
         bRXdImGjZG6dP+iPZ4gVfLze0YV5NraThdIq1h+yuyXcAY3iFyT1jtozk9XlvhrJebR3
         ayHg7Bet05N1L+zkh67lbTsLqc5F1wb84/SniBX+8L1jIeEUN00PUrrGxvbcgVR2nnFU
         x7fCL/3GGRNtx8wz7o38zehA8lfuRZiMSo54XUjIsudz5Y28JRM8doaO8p4WVf7sMw8S
         yVDq/WhvgbTrpbk0au4BcYq+ETq8lm0hvJNYisg8GfBCuf2kLwpipKO0Oc7MbXEBJehz
         W9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587969; x=1720192769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmjri7yaLe7QXW9juAdGl9QopQ/cO6H/4cwPORHxTGQ=;
        b=BENey3l4wvHy56ZjHqfYVdBD73WDNvOPvWKqLAx7hW9nZvzaEyrYajOnuWvI7OPoo9
         RBSlqh6Ps0dezgzUG4LZYzBlCwTbn9m7nw+sTQzo0hX6CsXlG0/3Y1wWxtw4aAl96qsC
         dSAGBmA7L8Gkij74Z/hXOf23r0CaHVHEmfJqAefqNN31uEt7KRdH5Gg8lYfuPqJKEQ1X
         8YOQ0RZi1JtGepnMbC0+ownic8JwSCgun9dYW30TQez2WRHQbWtPU/Hx9oXAKudfSBkw
         Ig2KYMh24yLvOmEyMdlqhmHg79h7IDatT7LJJLlBmw9OTWgrYJtl8wiD+u8Zer9B3cQx
         jPqA==
X-Forwarded-Encrypted: i=1; AJvYcCWiHTL5wlMR0yQt6ZJtdzhrqsQAUF7OWG+uRDzjjJp/IpUKJacGWq5gBijC8cZDF67PzzeUjsioAHINFwUhPvec0OEz22B+abVsnu8l
X-Gm-Message-State: AOJu0YwEQSAiIQLNJK7QUagVy6z6spFUlwvbrDxYkCrvQ8NNrOB9K45Q
	t9W/Q4+tywN1jbtJRz8PkmLRD4Wttvpuu3cmdUGeTiCCTSyIYWo1QbFA+BeSAaTB9VsNb2bCNJY
	h8x4/HN2fLoUkAfzmvyA7176sOzo=
X-Google-Smtp-Source: AGHT+IFl/ePdhUfWsByY453UJoZtJx+hjy/QQ0/MmsxXqE51xtMz7GT1s16IgCAaFz1nVwJbQE6MR1Er5Iz8x1FG1QA=
X-Received: by 2002:a17:90a:6885:b0:2c7:e24d:f695 with SMTP id
 98e67ed59e1d1-2c861246b47mr15446562a91.12.1719587968869; Fri, 28 Jun 2024
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
 <CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com>
 <CABXGCsNN9LwHc2x2AAEH=5UNwpvkWkBqRYz3OP8MZ6Woy+HDXA@mail.gmail.com>
 <b6c440ca-e63e-429b-af41-5f27d4b8b2a2@leemhuis.info> <CABXGCsNoFfMn7LaqqFgEPg-ECyUPN=f=SXVrFi=GZk6c69-Gqw@mail.gmail.com>
In-Reply-To: <CABXGCsNoFfMn7LaqqFgEPg-ECyUPN=f=SXVrFi=GZk6c69-Gqw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Jun 2024 11:19:16 -0400
Message-ID: <CADnq5_PDSkr4hOHJmb1J30UC0a7sXsm5-TPkEmjzffMK_A+7ug@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac
 cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Rodrigo.Siqueira@amd.com, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 6:45=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Fri, Jun 21, 2024 at 12:56=E2=80=AFPM Linux regression tracking (Thors=
ten
> Leemhuis) <regressions@leemhuis.info> wrote:
> > Hmmm, I might have missed something, but it looks like nothing happened
> > here since then. What's the status? Is the issue still happening?
>
> Yes. Tested on e5b3efbe1ab1.
>
> I spotted that the problem disappears after forcing the TV to sleep
> (activate screensaver <Super> + <L>) and then wake it up by pressing
> any button and entering a password.
> Hope this information can't help figure out how to fix it.

@Siqueira, Rodrigo @Mahfooz, Hamza any ideas?

Alex

