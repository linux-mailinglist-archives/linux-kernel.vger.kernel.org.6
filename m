Return-Path: <linux-kernel+bounces-241572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0A9927CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387A31F218FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0655113848A;
	Thu,  4 Jul 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="FkKLwZUH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8673458
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115606; cv=none; b=o++7/Wu90IJDrcYVLtV9wSzXEMww4c7hlh/CoO3z3IsRL01ptM4xdhAHseMq0e/X8pTOzey8sNQEW/nM874hz8KSC3Rvcen4eXDtqNSxhim/e1/cQFRx5Wi59f3re2BtJoMPXk4OnWDN5I3c1pbpUiGB4UB2QnQoYhovT/+UsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115606; c=relaxed/simple;
	bh=l1uxIG0dbpQ3vxd8XuFSAJOOykrgwtWmdtGyfes2CDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcEv8s+V0s8EjvsncDZBkFDe6UQJ7Fewy3ClyvtGwlg4izDcVU2l0sgSp4dQKddyenxYmJD0VoupCzaVWCKk76z+dEjMi54btQsM0G7pJx90m61B6bkwZz+cLcz5ZwsnHSt+rlKC6KtSyuzj6Y+mEfWBuh49zxn4BHLiVdh533g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=FkKLwZUH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4c7b022f8so5536845ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1720115603; x=1720720403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uryZ79GMK3Hbevhm1GUwmInwdQUDjClI1eiCDdIwGw=;
        b=FkKLwZUHYrqqT/KTWdrSJ82iX7uPO5AUF2mxxnc+SoMCak83WJg9PUB/UzDytTK+xg
         N4Q4FC9anjKKv8fkkfN4fn6/oETpAfrlLE2ci5wDeddEsGh4jNpFIDFtGDAOofn1SiIn
         9kZT5aeFF2fAhHnrj1gZ6AExEp5Fpc57pf3QJMJu6KhCyO9jZ/tWBfm2pMqvNc8lsqNT
         ORPQxy+sytZolrHWF83Rd2Zhb4WST+mFb/7oj5/sJyxKfTQ5xqueb3aUbk099PTkHBU1
         tfs5KN1qTxgHA7QMVKG688LwtbFko1TMjzkl1oDamGDvfOEf1m8b9rPU/k86Ylre8Nks
         cMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115603; x=1720720403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uryZ79GMK3Hbevhm1GUwmInwdQUDjClI1eiCDdIwGw=;
        b=AsZLLqMkxaHLTVBeIiCUQf/8kZhTmhxKjBLaeZBNKM7328+bXq1KMGS2IbDvi/PTsp
         Ikoo9rzb1unVeVgRwmq3gDc+p9k8KpPxE52dq8ZSqatJ4f2PpawhrYSNYJ/r/UBpGmyf
         5N+yia/N88H1CEslBnWMbd+dse67XDU+3mZFRSgq/O8AtWOW2rDQUFNeA9sjGyq5z7Fk
         NBZSicG8mG1qgkXi36AR3Y2FkRDPemodn2WjfY7Yn0467XmKBv+acUoGZc0ECiWU7qWs
         mw0iJlsn96DwfqhBcMkXgNVPDSz9T1S8jawNyMXLLpjPC9NO+bVD1hisWHTzjFQLxnkw
         W2fw==
X-Forwarded-Encrypted: i=1; AJvYcCXjOSef4iiEVPC43dBiVo1SWoTjWp7dK5CVZ2tlKUJhjBLbhD33pY007B20v1pO4HWxF82w7+5yGhmfg6q8GbILyvQNwdQ8OaVpAUWh
X-Gm-Message-State: AOJu0Yylsd+hL7NsFUv+BB6ppvgstrJFcMuHAYcLOTa3fP8JtJ1HFC61
	P49gGTDuedoA3tjsw2LQ+tOxtFQdmKOv+dyvVK61dvBpX3x9zZxJUWkuw0RwqBA=
X-Google-Smtp-Source: AGHT+IHr2Ly4uGxHjqpvelPSNVZYUdi1gXcvcSsc8YvBTQFpKVrUUJwR8TdaP1EKvh1cnQR14j81oQ==
X-Received: by 2002:a17:903:192:b0:1fa:cec7:9a9d with SMTP id d9443c01a7336-1fb33e0de4cmr17233465ad.15.1720115603590;
        Thu, 04 Jul 2024 10:53:23 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:8756:5e46:4951:e2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb3dbd7dcdsm10711545ad.157.2024.07.04.10.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:53:23 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:53:21 -0700
From: Drew Fustini <drew@pdp7.com>
To: Drew Fustini <pdp7pdp7@gmail.com>
Cc: Conor Dooley <conor@kernel.org>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: add basic spi node
Message-ID: <Zobhkf5qr13rKcWH@x1>
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-5-kanakshilledar@gmail.com>
 <20240703-juice-refreeze-62c468a56ea5@spud>
 <ZobU6K/R3pfHrK9c@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZobU6K/R3pfHrK9c@x1>

On Thu, Jul 04, 2024 at 09:59:20AM -0700, Drew Fustini wrote:
> On Wed, Jul 03, 2024 at 03:45:37PM +0100, Conor Dooley wrote:
> > Kanak, Drew,
> > 
> > On Mon, Jul 01, 2024 at 05:43:54PM +0530, Kanak Shilledar wrote:
> > > created spi0 node with fixed clock. the spi0 node
> > > uses synopsis designware driver and has the following
> > > compatible "snps,dw-apb-ssi". the spi0 node is connected
> > > to a SPI NOR flash pad which is left unpopulated on the back
> > > side of the board.
> > > 
> > > Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Separated from a single patch file
> > > ---
> > >  .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
> > >  .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
> > >  .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts |  5 +++++
> > 
> > Didn't you say there was a flash on one of these two boards?
> > 
> > >  arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++++
> > >  4 files changed, 34 insertions(+)
> > > 
> > > diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > index d9b4de9e4757..3103b74e0288 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > @@ -17,6 +17,7 @@ aliases {
> > >  		gpio1 = &gpio1;
> > >  		gpio2 = &gpio2;
> > >  		gpio3 = &gpio3;
> > > +		spi0 = &spi0;
> > 
> > "spi" would sort after "serial".
> > 
> > >  		serial0 = &uart0;
> > >  		serial1 = &uart1;
> > >  		serial2 = &uart2;
> > > @@ -52,6 +53,10 @@ &sdhci_clk {
> > >  	clock-frequency = <198000000>;
> > >  };
> > >  
> > > +&spi_clk {
> > > +	clock-frequency = <396000000>;
> > > +};
> > 
> > I'm pretty sceptical about adding more of these fixed clocks, rather
> > than waiting for the clock driver. Drew, what do you think? Should we
> > just add one more to your fixup list or would you rather delay? Guess it
> > depends on how long more you think that clock driver is likely to take.
> 
> I think the clk driver [1] is in good shape but it has not been reviewed
> by the clk maintainer yet. Thus it is hard to predict any timeline for
> it getting merged.
> 
> SPI support doesn't require any driver changes so I'd be inclined to
> allow the fixed clock in this case. It will be simple to change it over
> to a real clock once the clk driver is upstream.
> 
> Acked-by: Drew Fustini <drew@pdp7.com>
> 
> Thanks,
> Drew

Sorry, I meant to include the link to the most recent clk series:
https://lore.kernel.org/linux-riscv/20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com/

-Drew

