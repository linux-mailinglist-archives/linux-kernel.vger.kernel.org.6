Return-Path: <linux-kernel+bounces-433859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DBA9E5E11
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1419F286F76
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B406227B96;
	Thu,  5 Dec 2024 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="UbaugdLO"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BE422579F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422315; cv=none; b=dyMP5qLuIx4PVeI0EMI+ZyKt4UXqVttEBiCsIsJNaAsxKLe90gANzL4Zq3SerriSNQij+808DFnzwb5N7PGRoNzWOctH0rW0WlwNsUTNHbTTKy6TbWfEEdkUCUlku6frdBRMHCyGX/Kj8WAUyhQYFLOL6VKA7cHdabHvJtdokFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422315; c=relaxed/simple;
	bh=1ZxSWeTtz1xYfbYIhQuSzJz0Yo0FouTjzbyq21H8PSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0aFR6hN3jA/zqgp1rrQsbsyI+LpoXGYiAVrIEdaL2vpYlC9npvXY+r5Z3D2IOxYJ9FN1g5a5yweDPC2WhPqRPUxPb4vNTBNSo/8ZLI2w3gUhMYHGS00P+avFk9dZoANYhdTuneOEzUxyYpU/JPaiiajjL0zLDSR8ah8vPi8i5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=UbaugdLO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7250c199602so1331790b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 10:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1733422313; x=1734027113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MUjUIXHE2bJtGuB7BkRXXqw/hOym15VxRARXET8bls=;
        b=UbaugdLO0GYyPYUpIpeUbCugGBhx78w4t0eFOH+35kSTeUT3G/fSmhCjsotEO8pTLe
         KYx8fCY8vE6ApGefxzuBGmw+xA7N/slUQbL5ZzX77qAFHneruHGoPRfD9NQYRv8Htrxx
         K1sY9RnPRfycJ+lZXwndSPbfw6sEVp/mQ2f7lWj3K/LIAaYKcx+SOGx/jveNs3jwPMod
         sNmdyfH1ZrfvBq6uphs3GiToIhfvQua1aKrK7IyPx2Lqo262kp+Pavyji9OqMkV2Omhn
         n8g60wwZtHLRapyqy5g/kZ4tKBUufh7BjfXEw91C+QXrXFkqSSYwuirwCwDAq2IRQiYi
         +rmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733422313; x=1734027113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MUjUIXHE2bJtGuB7BkRXXqw/hOym15VxRARXET8bls=;
        b=piJ4e2zxAhAypB5r9Mue/kB/AghKN0clvrc4Gwzz1M+dr3v6Ym/2js5v51Lwp/fKGV
         3zLN6N49tC+5XxE2zs3LkXbXec+LVA3iPRlo9oLgd4oRCIsFs9BOQRZb7oJvHaQZeyMV
         s9i85bxqaQSqeACRbwI5cQK0wC/O8PNb226msZa021i1aYQA/NUP1U9P4ZwaCFeZuh96
         GQG4P1zAf5qptbBHQ5LxgD/OpB2rwYclXxNTYRUbfYj+zek8Q3kElCCqgva7kamqBRHS
         rjGuGcHBiQ+XWfRNuEg/sQ24DrMu3oV5zcS/cIIjS+aMbcZ643PlEBmGKpkYo3EIHMxd
         3SkA==
X-Forwarded-Encrypted: i=1; AJvYcCVvK7ypQg3SsbnEjKKKhCXrwfkUENoJnSp9Gbac0PswxVNssygjO7PCdgWfFgcngRHAOMUhsWniE0LzDBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqE9gV+ICfVc6udUBgxNMMIcvO02hWP2NMsNofCv1uOfzw2nY+
	7F2HUv5+7Tq1U65Ti/3w5vSWn3iHO/qIs4NGjJyZq88Zh+J+ZvQpINWoEFkM6xY=
X-Gm-Gg: ASbGncua8LmpwSTKjlRfyBh4Sp+ms/jdUh4n3gGUSvu/Gc/BKGvWIsdzY+V4LTd78rl
	x7P6Isjk//fLAf03WInIfNLtspF5S1XbarX0d4DA3VFXrWDfGvTlyXvF4qQ3yLZQZWmRfHtpHhF
	qtC9DGIuUl0Vkn3YU1+a7s/cirq6isiHufTooZCRmarcDEQiyxmFMu31xi4INn/pEMPAIrbjjOx
	IN36/F/r9HP6GHDAsNHwGWUf+9F8Tk=
X-Google-Smtp-Source: AGHT+IH9Qxre7SaXJmwLVox5H0UwU/C+KDg/si4WFNP6RN/USaZJmdrSMdvHNGZqEVGV0+rIUHI/aw==
X-Received: by 2002:a17:90b:5448:b0:2ef:2d9f:8e58 with SMTP id 98e67ed59e1d1-2ef6ab29c49mr113446a91.34.1733422313419;
        Thu, 05 Dec 2024 10:11:53 -0800 (PST)
Received: from x1 ([192.210.17.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ffb6f5sm3584572a91.6.2024.12.05.10.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:11:53 -0800 (PST)
Date: Thu, 5 Dec 2024 10:11:50 -0800
From: Drew Fustini <drew@pdp7.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: bigunclemax@gmail.com, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: thead: Fix TH1520 emmc and shdci clock
 rate
Message-ID: <Z1Hs5smgFV4C6c90@x1>
References: <20241204111424.263055-1-bigunclemax@gmail.com>
 <CAJM55Z-YAMtRN=K5KxCH1+++Xw4uMM_c49z8tGzi3snU+-KrYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z-YAMtRN=K5KxCH1+++Xw4uMM_c49z8tGzi3snU+-KrYA@mail.gmail.com>

On Wed, Dec 04, 2024 at 03:19:28PM +0000, Emil Renner Berthing wrote:
> bigunclemax@ wrote:
> > From: Maksim Kiselev <bigunclemax@gmail.com>
> >
> > In accordance with LicheePi 4A BSP the clock that comes to emmc/sdhci
> > is 198Mhz.
> >
> > But changing from fixed-clock to CLK_EMMC_SDIO leads to increasing input
> > clock from 198Mhz to 792Mhz. Because the CLK_EMMC_SDIO is actually 792Mhz.
> >
> > Therefore calculation of output SDCLK is incorrect now.
> > The mmc driver sets the divisor to 4 times larger than it should be
> > and emmc/sd works 4 times slower.
> >
> > This can be confirmed with fio test:
> > Sequential read of emmc with fixed 198Mz clock:
> > READ: bw=289MiB/s (303MB/s)
> >
> > Sequential read with CLK_EMMC_SDIO clock:
> > READ: bw=82.6MiB/s (86.6MB/s)
> >
> > Let's fix this issue by providing fixed-factor-clock that divides
> > CLK_EMMC_SDIO by 4 for emmc/sd nodes.
> 
> Thanks for finding this bug!
> 
> However, this feels like a work-around for a bug in the clock driver, and even
> if there is a fixed factor divider somewhere this should probably be modelled
> by the clock driver. Did you look into the documentation[1] and try to figure
> out where eMMC clock comes from and where the /4 is missing?
> 
> There is also a vendor tree somewhere with a much more complete clock driver.
> Drew do you remember where it is? Maybe it's worth looking at how that driver
> models the eMMC clocks.

Sorry for the delay, I'm travelling until tomorrow.

Maksim, thanks for finding this issue and sending a patch.

That is a good point about checking the thead vendor kernel. I normally
look at revy's thead-kernel repo [1] which is 5.10. revy also has a 6.6
lts branch in th1520-linux-kernel [2].

https://github.com/revyos/thead-kernel/tree/lpi4a/drivers/clk/thead


Looking at line 454 in drivers/clk/thead/clk-light-fm.c [3]:

  clks[EMMC_SDIO_REF_CLK] =
  thead_light_clk_fixed_factor("emmc_sdio_ref_clk",
                               "video_pll_foutpostdiv", 1, 4)
                               /* Note: base clk is div 4 to 198M*/

Which derives from line 373:

  clks[VIDEO_PLL_FOUTPOSTDIV] =
  thead_clk_fixed("video_pll_foutpostdiv", 792000000);

Thanks,
Drew

[1] https://github.com/revyos/thead-kernel
[2] https://github.com/revyos/th1520-linux-kernel
[3] https://github.com/revyos/thead-kernel/blob/lpi4a/drivers/clk/thead/clk-light-fm.c

