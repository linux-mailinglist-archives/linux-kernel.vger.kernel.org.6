Return-Path: <linux-kernel+bounces-342662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A3C989164
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B75F1F21B58
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 20:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB35716C687;
	Sat, 28 Sep 2024 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="UBzmOwSP"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A3158DC0
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727556357; cv=none; b=V+HRibgZSAOAfOswgjSNQKXyPjEwjbpFqmrP01qDmNQRbfBCBlQuNnFNBcv4ILRwDtaITL56kBU2pOOwt4sBNEBeInNr9Ev6s0K5p0Tsa/f7oIR+lu9+71FNLBsPSvD91hKyf0fveQ6jr5ztCmdNqhpb2CMRNghf2lhbjuK4TZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727556357; c=relaxed/simple;
	bh=++L5szp7rHdLiJY+uwC07z9zRCqc0llaxr7Vs9fQq8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoGTroOgHuycfCw0US3AFMsar0998Pa14PDuXrD4BWuNRvXc2F3NlJVX86tGtg0H0D576x79cB77+d1WCNA2wW3guQISKfcwLOAflC4NhkMr52oIBt+b3ygxl4NoOtNqYH2Pw5gdPyKKSe6Gm/9gamD809+aTTlcOQHcwTzdC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=UBzmOwSP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2068acc8b98so34639675ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727556355; x=1728161155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1wN4Mv6KTR3klc618UZyJIvaPfyrd+I69sEqUZILgs=;
        b=UBzmOwSP/YKctCDsjP4uYRZteL4kgfzYxygXMbk5sRIWM7u9ADTibOjXACg8gtSMuo
         VrYUrxprZNCjtKEf7btXU7uozTY3UWkmFxRXiZsLpHuHh8C+GaTclbDrS6NBxtjISICq
         Ja3w2T59/qdaKnytqf0tqUZgNZKmZMB3DAZgEvCFvZSJgfHwQHUAa0q3k5oEY1FGo116
         M08vBzgK9F6/kX4ESMpmHOON/nGegHfp4LW8dBNGj32M4i5uSL2d4vW5OoYsfET8pOGa
         8nTHaA3eJKsQXdgkQ64D9sAi0wr6Do3LxpNlH4gsg+2IJonY05am9R2BKoOn4rcV1BWA
         g3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727556355; x=1728161155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1wN4Mv6KTR3klc618UZyJIvaPfyrd+I69sEqUZILgs=;
        b=jEiJU/nJYk2AQe3jJ+OHzmPHpFGjkI9eTFHLWK/saO6zdzcyJrqBNrAp8F53yYSy1M
         2N47AXQL0TbCa2jFR3sscu+iitz1QuIxbFWOAhAOpf4z4rm8gcOfp3UgueGogdxwRn5p
         i8XXTYGD6HhOP0k31Ar8ZLrOHP4FcaKHb0TTN6FSOha/tg8aS74Jk25AGDHHQtBy4a5V
         +h50CgEzOjV2b83mvr+W+UeWVOxKZGPnmuRhaAwYj1PFfWTOUa26Q+DqCUiD0dg+4Cwd
         6jyNrRUtBKZqmFqK3OkFClZSidY1BQWfGMfewF785cX/i5gs9RN08VMsD7glPYfXZi29
         WrBA==
X-Forwarded-Encrypted: i=1; AJvYcCW31amuOJ8bye+Asm2aLkO2e/M0Z59Z7tgtFwfCycznmJCNZEyBFg6VUFy0FHeaf01KY9A1Tp9HS9akGIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0HEQyPh1wXESgxMTXkeM7ZNyuaF8Isk3nlgxtTHlVYpPMXvq
	7X7TyqT2Y/Ga/EaFfiIUeid4pTIz7bfT+Xz6udk2QtRzZVa409nw68szNgJtYEY=
X-Google-Smtp-Source: AGHT+IHYe5C2dCeMbXLolGkdYVgGv6vaXYzm7QHCg36ZJ1QQJYHSFNwHxNkSM+iWKcxoee+lJlo/DA==
X-Received: by 2002:a17:902:c952:b0:20b:6a57:bf3a with SMTP id d9443c01a7336-20b6a57c137mr21788895ad.1.1727556354766;
        Sat, 28 Sep 2024 13:45:54 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e2f382sm30487635ad.182.2024.09.28.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 13:45:54 -0700 (PDT)
Date: Sat, 28 Sep 2024 13:45:52 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: Add TH1520 ethernet nodes
Message-ID: <ZvhrAFyfvj9mXuuV@x1>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com>
 <CAJM55Z-FLmpFfisNpJi8FP7o_5mwoDa7r18VXW7u7nF0V6oiRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z-FLmpFfisNpJi8FP7o_5mwoDa7r18VXW7u7nF0V6oiRw@mail.gmail.com>

On Fri, Sep 27, 2024 at 05:55:04AM -0700, Emil Renner Berthing wrote:
> Drew Fustini wrote:
> > From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > [drew: change apb registers from syscon to second reg of gmac node]
> > [drew: add phy reset delay properties for beaglev ahead]
> > Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> > ---
> >  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  91 ++++++++++++++
> >  .../boot/dts/thead/th1520-lichee-module-4a.dtsi    | 135 +++++++++++++++++++++
> >  arch/riscv/boot/dts/thead/th1520.dtsi              |  50 ++++++++
> >  3 files changed, 276 insertions(+)
> 
> ...
> 
> > diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > index ca84bc2039ef..d9d2e1f4dc68 100644
> > --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > @@ -11,6 +11,11 @@ / {
> >  	model = "Sipeed Lichee Module 4A";
> >  	compatible = "sipeed,lichee-module-4a", "thead,th1520";
> >
> > +	aliases {
> > +		ethernet0 = &gmac0;
> > +		ethernet1 = &gmac1;
> > +	};
> > +
> >  	memory@0 {
> >  		device_type = "memory";
> >  		reg = <0x0 0x00000000 0x2 0x00000000>;
> > @@ -25,6 +30,16 @@ &osc_32k {
> >  	clock-frequency = <32768>;
> >  };
> >
> > +&dmac0 {
> > +	status = "okay";
> > +};
> > +
> > +&aogpio {
> > +	gpio-line-names = "", "", "",
> > +			  "GPIO00",
> > +			  "GPIO04";
> > +};
> > +
> 
> These GPIO line names does not belong in this patch. They should
> already be included in your other patchset adding the names for the
> other lines.
> 
> /Emil

Thanks, yeah, those sneaked in here.

Drew

