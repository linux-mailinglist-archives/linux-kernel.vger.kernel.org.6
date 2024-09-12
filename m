Return-Path: <linux-kernel+bounces-327169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D77797716A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9817B23648
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF171C1746;
	Thu, 12 Sep 2024 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OW/JjxU/"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF351C172C;
	Thu, 12 Sep 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168770; cv=none; b=ZEzjfnLSzjYyX4QnwCOgMX32HHTqZlukZyScM2BA+h4UF6dy0kqxjVSGLAjSOQ8jvoiPfSMM6WtcyJtC6PWQzcn/CCdP1fIcc+LiX+CVm/6Zwiz0aOXcXNrX49QUQaPAyw7AEnRhMw6OTx2htmYk6sa+O0+62tApHy3rXHf4tIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168770; c=relaxed/simple;
	bh=pSRSbbCaoVGe7HmH3q/bfk+SXi7th06IJQJ3A/RsFqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjNeSvuUPLpCdlw9c7DSEtsT0RcXjqorqnkniL732dbqU/6fr5bYeeacUU0WmZdTLlrRx5xq/GvPxGab4j6GtV33nq+thLnfEP5jX5urAQ675Ouhouki+wspVSv9dzlTFygrW0F8kMkjeQvElCzudqFcVbi+G/Ygvu5G9Hvyo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OW/JjxU/; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6db449f274fso1267347b3.2;
        Thu, 12 Sep 2024 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726168768; x=1726773568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pSRSbbCaoVGe7HmH3q/bfk+SXi7th06IJQJ3A/RsFqs=;
        b=OW/JjxU/5YwIB6EaqSGXe6BgtsqYRHnWXAedirvcL7nEUpIMWQul4wgQCxj/GisLGu
         VQahYOfUxsF2clUN/5yl9wEpPC2qQ0qHnTTNzF7uy3latzKF8g45z/yi6G7ONEIaefoC
         K7Y9Bcf5l68SjCiaMbeXzxImkP92mk6B2euPdY1aSd92gxTX0TBu0ds9NINVMCjRIR8A
         nwcyHHjGbEoJd2CjZtsf2i8vvti5DFSSgNBBDjGKurJBwxEE5aMMXTSGv/2fPHHSisGV
         WfvruKDioGpwWb34i3kDhwqtLezETi0gfaaZClktZHykDm9fbeTm6TWorIO9i6uBvqrc
         aRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726168768; x=1726773568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSRSbbCaoVGe7HmH3q/bfk+SXi7th06IJQJ3A/RsFqs=;
        b=SYPAdkRQMN4fzZO+Y4AvmuhvKAZsvSQ/9M4AL7pKuaYu6eMMxslNQORF5UQ72fGlRz
         RJ+sPS8W962xfLM9vJydOvzu1ywecJXygZsOp4G4V8Gad2fvWQz+IEwKpH5S+YWVqXXc
         aJe3BlnFfG21naaC7/1WC6n7c8xG7F8Un39LJZkw++voHFTUEGZ5kVMZbTRQPv3/7zVE
         Bm1UL/9NM1/1CVfupQDoV+9NOEdcqmrBEYGenzs3IpLXMNvJKiYX3b4ANj7eux/kHtjX
         BwSjoLFra3mbRNGyfzT3GGkksRM9kzWGaW6H60SvMVWpszcI+qY+UAhAfC74YnzNmBa3
         IHKg==
X-Forwarded-Encrypted: i=1; AJvYcCU9B4NtwvcXR9MyOYmLEEHuyULU05fddHuWZTCTraYgOejNHGfa93928BJk5RGb+1ycm9kXnRMn5XCp@vger.kernel.org, AJvYcCVMfIculgRjFP5tPJay3OgrMzKZYIs6DEk+epxve48aTjU9t1cvIR9z8Aaq4Vg5XLtr4ni2CuM41SND@vger.kernel.org, AJvYcCVQCVNdtec+oVrr0JmwyZ6KWxITFC7a/uZ5wfHZvhlfYoMQXDcvOaKDhyX1rvBlhrU+PnGDu67vzKSF9jOq@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQ2OG0QSyrtBxzcNasYk4Cg31XCzkt7CVnJwqQjaa/iI9Z5CO
	VHXhnuFmVcBXZqDeyoXQF+NrO0vJ/o0SmXaUmbTBbkzoJBBmcVe73wDuTHk4hk6LWokLIHit5+H
	LDdbp/zd57ghHngxFfdU7wmJ+45E=
X-Google-Smtp-Source: AGHT+IHDzg+zuesi6uutLUgvzvlW5QWSMXu094bH44N/ZMJx/iOCNtDk078OF3doxaKoeYS0g5VOwuKnwoA7hDXn6II=
X-Received: by 2002:a05:690c:4f04:b0:6ae:614e:cbb with SMTP id
 00721157ae682-6dbcc59b514mr3673117b3.42.1726168768270; Thu, 12 Sep 2024
 12:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815150255.3996258-1-tmaimon77@gmail.com> <2f21322a2412684c6aa7bb7d817e861c.sboyd@kernel.org>
 <CAP6Zq1hxwb3eWakPJecWXbt6_JqOmph-72bRn6pztxy1KiuF+Q@mail.gmail.com>
In-Reply-To: <CAP6Zq1hxwb3eWakPJecWXbt6_JqOmph-72bRn6pztxy1KiuF+Q@mail.gmail.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 12 Sep 2024 22:19:17 +0300
Message-ID: <CAP6Zq1jFg5Ex3OA32MjKp50XJQizhBD-sGe04DW0RD6VPCxfzQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v27 0/3] Introduce Nuvoton Arbel NPCM8XX BMC SoC
To: Stephen Boyd <sboyd@kernel.org>
Cc: benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, p.zabel@pengutronix.de, robh+dt@kernel.org, 
	tali.perry1@gmail.com, venture@google.com, yuenn@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Philipp approved the reset patch with the minor changes; these minor
changes are already addressed in V28 that sent few minutes ago.

So the clock patchset could be applied :-)

Appreciate your efforts and guidance.

Best regards,

Tomer

On Thu, 29 Aug 2024 at 11:07, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Stephen,
>
> Sure.
>
> Thanks a lot,
>
> Tomer
>
> On Wed, 28 Aug 2024 at 23:54, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Tomer Maimon (2024-08-15 08:02:52)
> > > This patchset adds clock support for the Nuvoton
> > > Arbel NPCM8XX Board Management controller (BMC) SoC family.
> > >
> > > The NPCM8xx clock controller is created using the auxiliary device framework
> > > and set up in the npcm reset driver since the NPCM8xx clock is using the
> > > same register region.
> > >
> > > This patchset cover letter is based from the initial support for NPCM8xx BMC to
> > > keep tracking the version history.
> > >
> > > This patchset was tested on the Arbel NPCM8XX evaluation board.
> > >
> > > No changes since version 26, only tested in kernel 6.11.rc1
> >
> > Thanks for working on this! I'm waiting for Philipp to review/ack the
> > reset driver part. Until then I don't think I can apply this series to
> > the clk tree. I'll add a review tag to the clk driver patch in case that
> > helps.

