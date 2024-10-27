Return-Path: <linux-kernel+bounces-383588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708059B1DA1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D9C1C20E80
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592361552E1;
	Sun, 27 Oct 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cOLKETCh"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6930325765
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730031393; cv=none; b=ZOtrnBcdrnakvGTdsn9gvPlh83RTeAUufQ2D5sDrpVM/Vs1X4QFxMMEUzMj2crqb5JtZxl9WOISzRaCMyurP33ynxjdLpiGgVSLdC+kBDBkL+iFZRVOQl97IiDdtkPyMUp7EfrCYZ5fyzA8G3AXkywm6Vgv7D/GGArxGpUfjnMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730031393; c=relaxed/simple;
	bh=nxuvBBl/Ikz1GUSyAopGwNtoj+wTTYNKUidSHI4Zw3c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLWggdr9cM0t86OG/YAGjEx/jSFt6BFyJfzGj5YipeEEhp+HthN81s6WmArk/gPAwn79BmIHd/uKU1JCL/LHr8P7+EwK8Oooie8ViiT3HKdX65D4JIYlbz4obsb1YEWrqXm5SVAZyECSYKQbC7eBj7mbZJo5R74m0dF3CGCI8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cOLKETCh; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3F7813F2A2
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730031383;
	bh=nxuvBBl/Ikz1GUSyAopGwNtoj+wTTYNKUidSHI4Zw3c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cOLKETChPWegF2Gj202JyGVIBA9x2m5mL0IIQ4F7z6tIlPdKlGGIZ582GF91zbQzQ
	 AvY3uyNm7E2i1Y+U8acTQ6vuP1P3kn0D3uBwsjQcEdD66Ws+I/K5Afx5PFZjuwW5al
	 w06UzVSxpMI1qGaLu3ewpSGqtqV6zHzSNQg7MU1C01Se8O7cR90BH0eSrBmZ88GfpM
	 PzsiijipY8pD4p2OdTLI8xjEqc0vq02hpT8proFNfzIX+4x/jxrQLpyXfJY7k9Uk5D
	 zwD4DQiYSXauEYALxMgU0NYcBoq5C/abZUaTTTgb46YhoevxoDlziEHl5xIupTAUn0
	 mnWlByFrw2oNg==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5ec1e0c88f2so1423060eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 05:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730031382; x=1730636182;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxuvBBl/Ikz1GUSyAopGwNtoj+wTTYNKUidSHI4Zw3c=;
        b=FbPDXbavumvhRpelBVzuUiLoTGu7Mxk+Vf3k+G5E9kbTsoCqj0OvIR5FPQmHS1Ky12
         uB97XpSXBbuQxUidPupdKZrosdSOZHYHsq3ic4o+MB82gSVQEKdhxA9J15QwK2ZnOKld
         FBZRdLq0uK5pqxHFqZ7O/IuNNajZbGYD7U3ZBvoEDOaKXERzfBCw5QEy+YHG+dA388hS
         Kmklpn860fjT58zp+CHhAKTey2h8CAO4PRczfFfzvwh/hIg8+FAisLvh6n/TXL7pYz38
         5rocR5IAbEsICNQvGLTH6Tz64v/eUkqmQC1BrUke7NDeP6qiz2L90OrtzSuGaoBlQWA2
         DTRw==
X-Forwarded-Encrypted: i=1; AJvYcCUKRdwXBXJj0dmKmgVDmmpW39pLg7oY77rgz97qtiCjUi0wI7qtf/GJ4EN0ZHC2tCgfdA22DIZr0oP9GiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZaiNCocpWCxJcllO7abUnc1z7CNWQ2Hct6BPbEeNO2vSsUyOZ
	JiCFimkzIrkayKi819FnaQvyUsCAYELlA59M+w98dUQr9o8/bQDw6ZOd78WxbO4xDvRD50veQ+F
	EeS+b9ZQdwrDaLQjrGXxyfgBWKspRLojEhOrcb+T53kLE1u3Jo3BgWH0L+mxjZ3VnDuIuTS+R03
	4sELwMOgZ3CdJMJ/rOvkXJjg2wL+2e/aQmMVtYMCl3yYhD25ki474S
X-Received: by 2002:a05:6808:6492:b0:3e6:3ab2:3949 with SMTP id 5614622812f47-3e63ab23f2fmr1443467b6e.44.1730031381743;
        Sun, 27 Oct 2024 05:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3/p9UcQsOIF9XDrRaePo4CLioUPmMFOdhHm0S4hnuRvPrmJfiLwq408uv86dDavZhe/zgtp+drnC/1fSJ30k=
X-Received: by 2002:a05:6808:6492:b0:3e6:3ab2:3949 with SMTP id
 5614622812f47-3e63ab23f2fmr1443454b6e.44.1730031381414; Sun, 27 Oct 2024
 05:16:21 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Oct 2024 08:16:20 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAPDyKFoQsf89NeX28ms7FtM0QWNqYQ5xtt2=+G1JNCVi2z9=dg@mail.gmail.com>
References: <20241020142931.138277-1-aurelien@aurel32.net> <CAPDyKFoQsf89NeX28ms7FtM0QWNqYQ5xtt2=+G1JNCVi2z9=dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 27 Oct 2024 08:16:20 -0400
Message-ID: <CAJM55Z_CU5rwMBm7n10jhGk57_T_HWLKYrYaGoc7qvK9irT5yQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: take SWIOTLB memory size limitation into account
To: Ulf Hansson <ulf.hansson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: William Qiu <william.qiu@starfivetech.com>, 
	"open list:RISC-V MISC SOC SUPPORT" <linux-riscv@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, 
	"open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER" <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Ron Economos <re@w6rz.net>, Jing Luo <jing@jing.rocks>, stable@vger.kernel.org, 
	Adam Green <greena88@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, sydarn@proton.me, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Ulf Hansson wrote:
> + Adam, Arnd, Shawn-Lin, sydarn
>
>
> On Sun, 20 Oct 2024 at 16:30, Aurelien Jarno <aurelien@aurel32.net> wrote:
> >
> > The Synopsys DesignWare mmc controller on the JH7110 SoC
> > (dw_mmc-starfive.c driver) is using a 32-bit IDMAC address bus width,
> > and thus requires the use of SWIOTLB.
> >
> > The commit 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages
> > bigger than 4K") increased the max_seq_size, even for 4K pages, causing
> > "swiotlb buffer is full" to happen because swiotlb can only handle a
> > memory size up to 256kB only.
> >
> > Fix the issue, by making sure the dw_mmc driver doesn't use segments
> > bigger than what SWIOTLB can handle.
> >
> > Reported-by: Ron Economos <re@w6rz.net>
> > Reported-by: Jing Luo <jing@jing.rocks>
> > Fixes: 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>
> Thanks for working on this!

+1

> Looks like we have managed to mess things
> up. Besides the issue that you have been working on to fix, apparently
> there seems to be another one too [1].
>
> Unfortunately, $subject patch doesn't seem to fix the problem in [1],
> as has been reported by Adam.
>
> I have looped in some more people to this thread, hopefully we agree
> on how this should be fixed properly. Otherwise, I tend to say that we
> should simply revert the offending commit and start over.

Yes, unfortunately this patch also doesn't fix MMC when running 6.12-rc4 on the
StarFive VisionFive V1 (JH7100 SoC).

/Emil

