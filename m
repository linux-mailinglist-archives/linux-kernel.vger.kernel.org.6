Return-Path: <linux-kernel+bounces-180906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0D8C74A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04081F221D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E985143C41;
	Thu, 16 May 2024 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVnLRMNM"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E68143895
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855255; cv=none; b=bYX80h1Ogha08ZqQeGktCyiHlWDfsJHabCUptFi8K2BMH3LzATsAoyXsAqAFPigU/LR35opJCnZ/c14Aw3ggBIUssiJnSmNnjLJFc3lkZQ874A65PkKUA/fEMiqtdU0+PIOceSkihDCjfermBbZP/HMGgprSqTyMM1wwclag0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855255; c=relaxed/simple;
	bh=kBASHLh2eyH3I0mizgz8GzGzaOda0gqP4B/VWaD/CaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+rIFvopDrMByzW/FJ2AMrqPSnaUuXQHvdVQGrGHRBMYVLim9nlJYT0bgbkd8uCr/vnFv1GGQzs6PaMqZIQ3n21nQT4/cIlkkT9MIUBbAq5kIikrVzmPDMCietS3EIRxsWdNpsNjh7Y4CQ+25MA3HED69JxDKz8u/AQ0V6QV6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IVnLRMNM; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7f919bc2e1cso3866244241.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715855253; x=1716460053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr/BX8NF3zifG/NDTQUbMR51wrpA+K5HDZ0+1mCSbgg=;
        b=IVnLRMNMadF/4dU0qEl+RlajbVlNal3GHavEfSz1MQ8n4ZNMwk3j79ajhAVG8jDCqd
         Dexo2TcApqG1AhwshoNiQMlpm54ZuT/7N0RxxXD8wZIVDZuhwvQt8buPgvZukeq5nklb
         MvM6JBZqz685Qdb6awErt5lNWsaaGv++kAQ6nfAaurRkpFt3VzEECK8KhBMCVmn1mouX
         GIoCynCCxX95iF54oN8BjOy2JkrVDP5MfFCJp256nsWJxeBreSwPpKJQq1wur+Ij2jV3
         PzrvIMaNfz7wSESFNBMGKfRIVB9QX7PcgyJaTf25+GAKikUIcU+ZL6lGILkOb9cAHHDv
         0BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715855253; x=1716460053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wr/BX8NF3zifG/NDTQUbMR51wrpA+K5HDZ0+1mCSbgg=;
        b=wVLxVIkeI7s9wdZj9h+gXB3ixtrBbm7kjuGUyfm/pchkX/WXEoBcqdpRFyPDRRZUYf
         o58fmX2pqV1Dp0MT/XP17YMvjCn3i/G53XzB4+pWnbXReEIEjVujuTJTRwCg5DgV7XfF
         Z+ELIJ7xnRFIDH+DzNgi88stHG5TqfCzsHlos9Lk82NfhVUGSeJdy+tKMJXyorONd5as
         anxvIkMA2tuhka3ocMiAp1rn47myveMM06O/hWuWNVC2U76QdvcyQnXbiSqoDYrT3FjU
         9FpvZNdIia6R9raojTbmd7m1Bjv+zY4mrnR5rPVzUvi/1dGZFRtFL5aFyyH5/JoeD2Fl
         N8KA==
X-Forwarded-Encrypted: i=1; AJvYcCXSwMHnmrID135Y8Bl8K5z6K3d+CtLzd/gXV39FHVz4nd+7DcOTgRFFpR87UjF+z1lA2LW/kNLSS4YG/c61Ka7whqU19yizTmIapwcU
X-Gm-Message-State: AOJu0YyKCNHzfIY1iR1TpgCMrSCJKDoQnK7fJqMMYXo4WhLyzwRKzs6B
	H4E5m43Cpsw8baewcv9XOFxFhc468W2vvdcxEMlM24QonO0toM4boUarcshv65BjIThUAKWYJYL
	UfGxgCloPUi6ZJhwOH7JYv6u9ucrBO+sUtefAB09XmqBhtePJkdGUzQ==
X-Google-Smtp-Source: AGHT+IGWpVZvSMUt20NSMuau/tfLKHpp/+EepllazSc5v5QmheoZd7J0sjLY5dmSCxrLYl3d79vmIUTSg2jw7h7stwc=
X-Received: by 2002:a05:6102:117b:b0:47c:254:2919 with SMTP id
 ada2fe7eead31-47fb6c62c31mr15440141137.13.1715855252928; Thu, 16 May 2024
 03:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com>
 <11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com> <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
 <ZkUgqzUn1EmjrPdl@shell.armlinux.org.uk>
In-Reply-To: <ZkUgqzUn1EmjrPdl@shell.armlinux.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 May 2024 12:27:20 +0200
Message-ID: <CA+G9fYurPNaW=u2E+h+segnXhY3cfWo3BJpfYDJxKRFPY4epsQ@mail.gmail.com>
Subject: Re: clkdev: report over-sized strings when creating clkdev entries
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	open list <linux-kernel@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 22:53, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, May 07, 2024 at 01:26:17PM -0700, Stephen Boyd wrote:
> > Quoting Arnd Bergmann (2024-05-07 00:44:15)
> > > On Tue, May 7, 2024, at 09:20, Naresh Kamboju wrote:
> > > > The WinLink E850-96 board boot failed with Linux next-20240506 but there
> > > > is no kernel crash log on the serial [1].
> > > >
> > > > Anders bisection results pointing to this commit,
> > > > # first bad commit:
> > > >   [4d11c62ca8d77cb1f79054844b598e0f4e92dabe]
> > > >   clkdev: report over-sized strings when creating clkdev entrie
> > > >
> > > > After reverting the above patch the boot test passed [2].
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
> >
> > There are two fixes on the list: [1] and [2]. Perhaps one of those
> > resolves this?
> >
> > [1] https://lore.kernel.org/r/20240507065317.3214186-1-m.szyprowski@samsung.com
>
> This one has (I think) ended up in the patch system last week, but it's
> not clkdev, it's only related. I'm also not Cc'd on its posting, and
> it's not posted to any mailing list that I'm a part of. So I've not
> been following any discussion on it.
>
> Digging in to the discussion, I see various attributations, and a final
> message reporting an unused variable, and a promise to send v2. So,
> I'm guessing that
> http://www.home.armlinux.org.uk/developer/patches/viewpatch.php?id=9397/1

I do not have access to this link ^.

> is now superseded in some way... I wouldn't have known without locating
> this email and checking the links.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

- Naresh

