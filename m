Return-Path: <linux-kernel+bounces-268325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221E7942334
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51531B23D99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74501191F88;
	Tue, 30 Jul 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="pWFyzLcH"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D118DF6A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380707; cv=none; b=C5vSI9A/fy/ScE3Z9C5kzAE0Gbo5Xe/QiP5Aqc0SYUDf7ZZWgRicdy1yUHXc8O53uKfCMz735Npi7Lef0zZL3RagrLrD7d9ZVDVu/UfF+Kshk1sDOvzW5I7aNIuyqExP/p/wnow6kn0fLqap/2Ny6BD/67XvW4v1ezhxMy1f67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380707; c=relaxed/simple;
	bh=G2ZrxaOWGOWO3TvbZHx3gMXdmw/MeENGpCr7Ho3BAxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1GJFiATdZgW9Rk2BlbDElgHjsOdzSh/2aDmOsfH9/NWDRrxB/erNpJdztkkn59crFTiujdWggETY5Wd8Fj71oksFWAgep9+Whhjh1bHBKbRw2ZgpbVAGK1jSO/acBVv5PixqelbFlAj2jG4Xf5nW7VU+hAa7WcxRB9Z8NJ2tZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=pWFyzLcH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc5549788eso38364705ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1722380705; x=1722985505; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nnXntQdX862gVyIztKO/l+KuxZoqT2mA4f4VoFTiDGg=;
        b=pWFyzLcHS2nrtZK4eveaan30gpXNMwl8vRsfjXVSI8y3vFoXSNUrSLw+pMvmsT8fpe
         M/NwX6DGjo8G7fkHkJV4csufYvRBq+wxkwwBTh7jkyhxGdB6CPMFjpEnDv9NvwOouW2M
         HtOZd7+eaSbY17hnaGkJzzCRtoDVwiUAFZzShrfjyJQzQ2Plqe5WGyTsSbHw5jfYU+sD
         f2YcS1rHqYocgzQIgv7ZONceUfoZpl9rFvX222r+0s6WhX0nSS316U5UXXWVNoFqfGPQ
         S2NJgNLauRl4yiQMA7MueMaadyZpUPYnmyKRSdrSfkhNmhuWmbwoofXmlflOfVKwbmnY
         CpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722380705; x=1722985505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnXntQdX862gVyIztKO/l+KuxZoqT2mA4f4VoFTiDGg=;
        b=kfKxkLVwrdP1cp4IZ97LZpqIFUPkqASrOxU+13JDs5lEpT6zSKyJpBSXzmr7h3QVu7
         2GokZmgbJba/L8byhOgr7bGqZXwhzoa2e5JAf+QNbcU23rHHGySgVkt/slCl46DF0yEr
         pMl1LPFCObdV6JcPW24swcJJO2xLyLtQ5MzAzFWaG7GDr48uQqUsur1IPN8ovC9JFX15
         aAE6u39VN2ri3/CYuaZ8DNS9baMd5fuod6B2637KsGp1zXZyG7XiJ/DIlfKB+3V17T6W
         WSTfZDsC9YZ3yLbF8fEwhVxUbG4EWA6UVhTMh3v/8TwqFsV1j3XzkMnKSrIwm8+biN7p
         l+hg==
X-Forwarded-Encrypted: i=1; AJvYcCUhU7bC9t71OsEJv5lnXPq7Wm5ehKpGE47JljB1S376jf92+x1jaIdj2AQDPW+wqgS70uUqagJ0zfkjD38R+h0BUwGIgoyWiu37hx9P
X-Gm-Message-State: AOJu0YwNivcRAWjRdrfQG3n1oLx2dGp2OlHO1z2MoWgGIAx2pm+xmxK5
	GShm3uCkVFwfJ6IO7AcGtpifG6xs32MHLrPnkgsPVCATdv9aNDord/h68QZPR3Y=
X-Google-Smtp-Source: AGHT+IG8Q55ATj4Ez7sYYAJur1LedubizP92VmcH7tRbhAlzb2pARJxM591+mQYc6UeoR1S4yD8eoA==
X-Received: by 2002:a17:902:e5cf:b0:1fd:9135:64e with SMTP id d9443c01a7336-1ff048a048emr150282655ad.50.1722380705274;
        Tue, 30 Jul 2024 16:05:05 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:4520:8165:b9e7:a203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f94ba7sm107791025ad.248.2024.07.30.16.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 16:05:04 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:05:02 -0700
From: Drew Fustini <drew@pdp7.com>
To: Icenowy Zheng <uwu@icenowy.me>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <dfustini@tenstorrent.com>, Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Yangtao Li <frank.li@vivo.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: clock: Document T-Head TH1520
 AP_SUBSYS controller
Message-ID: <ZqlxnlKH60KXi8P0@x1>
References: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com>
 <20240623-th1520-clk-v2-1-ad8d6432d9fb@tenstorrent.com>
 <57ef2eef45f2de15e6607da266b37b2a.sboyd@kernel.org>
 <CAJM55Z8iF8yV5JK5v6ZtQqS5AaWwCZ7uwhSYb7hdxh0juDFdqg@mail.gmail.com>
 <ZqPQ8X51S6PrzQxI@x1>
 <2375ff5fb664d8de9627e76788bd40b5d8eabf35.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2375ff5fb664d8de9627e76788bd40b5d8eabf35.camel@icenowy.me>

On Sat, Jul 27, 2024 at 01:21:39PM +0800, Icenowy Zheng wrote:
> 在 2024-07-26星期五的 09:38 -0700，Drew Fustini写道：
> > On Fri, Jul 26, 2024 at 03:45:36AM -0500, Emil Renner Berthing wrote:
> > > Stephen Boyd wrote:
> > > > Quoting Drew Fustini (2024-06-23 19:12:31)
> > > > > Document bindings for the T-Head TH1520 AP sub-system clock
> > > > > controller.
> > > > > 
> > > > > Link:
> > > > > https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
> > > > > Co-developed-by: Yangtao Li <frank.li@vivo.com>
> > > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> > > > > ---
> > > > 
> > > > Applied to clk-next
> > > 
> > > Thanks, but this driver seems a bit incomplete. With this applied
> > > the Lichee Pi
> > > 4A no longer boots without the clk_ignore_unused kernel parameter.
> > > 
> > > /Emil
> > 
> > Is this the case when you apply the dts patches from this series?
> > 
> > The dts patches won't go in until 6.12 so I don't think the presence
> > of
> > the clk-th1520-ap.c itself in 6.11 would break existing systems.
> > 
> > That said, I have been using clk_ignore_unused. I had been thinking
> > that
> > made sense because the full set of clock controller drivers like
> > AON_SUBSYS (always on), AUDIO_SUBSYS, DSP_SUBSYS, etc, are not
> > present
> > yet in mainline. However, the T-Head vendor kernel does have drivers
> > for
> > all those clock controllers and I was suprised to see that the vendor
> > kernel fails to boot when I just tested removing clk_ignore_unused.
> > 
> > As for clk-th1520-ap.c in mainline, I'll investigate further which
> > clk
> > disables seem to causing the boot failure when using the dts from
> > this
> > series. I suspect I may need to add nodes that will cause the
> > necessary
> > clks to be enabled by their respective drivers.
> 
> If disabling the clock just leads to system hang, setting
> CLK_IS_CRITICAL should be useful (and needed) here.

Thank you for the suggestion about CLK_IS_CRITICAL.

I have found through process of elimination that the "emmc-sdio" clock
(CLK_EMMC_SDIO) fails to work after the "vp-axi" clock (CLK_VP_AXI) is
disabled. I added the CLK_IGNORE_UNUSED flag to "vp-axi" and the system
is able to boot correctly. I think in that case CLK_IS_CRITICAL is not
needed.

I've been reviewing the TH1520 System User Manual [1] and I am uncertain
why the state of "vp-axi" would affect "emmc-sdio":

  - EMMC_SDIO_REF_CLK_EN is bit 30 in PERI_CLK_CFG (offset 0x204). 
  - VPSYS_AXI_ACLK_EN is bit 15 in VPSYS_CLK_CFG (offsset 0x1e0).

I don't see any linkage between them in the public documentation.
Regardless, the addition of the CLK_IGNORE_UNUSED flag to "vp-axi" fixes
the boot failure, so I will post a patch to that effect.

Thanks,
Drew

[1] https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf

