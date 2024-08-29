Return-Path: <linux-kernel+bounces-306430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D539D963EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101BE1C24347
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6073E18C03F;
	Thu, 29 Aug 2024 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UtP2Ozji"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA334A00
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921239; cv=none; b=fwK9XfoRYQzC4SQgJzOnmE8ScMCm4PotYmsXuMJktwBzSMW8Ghc3quS8Wm6g7EKRCrCbB5ZQFF7qCcBvL6UECKGHNonGaqwpI7G/aDCkLPwGZh+htpsSnI9isxvvL4nlzCvLEZgeRVSn3WR71P/EelnpVRyhgQxLfjjxp0OnEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921239; c=relaxed/simple;
	bh=DE5eD6fBGtl09HSN1M4cY+wEm2tkos4cgqP558LNINc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqdHCW2x7jojg7Grvw83BLBzieLbz0bz3k6f2i1ITS5SHSVKllZ1+esFTbfsvua7cgVAIJtsy2jb0DbQxleKD5HNjKQeBO1d0PHYIB4YTAIABUTAOaJsgQV01+GRcD8cz6sfVp/4waNnmwJEBU3tVgi9aj1ul30wHK3oGuZyTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UtP2Ozji; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3719753d365so289333f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724921235; x=1725526035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pV88tQPYEjmTGdra4jfjErhOhEutScS5mgpOhtY7sAw=;
        b=UtP2OzjiLlZz9jX9IRIcJPBk5MCYpfIzUxHuM/PzQGm5rTbvRUfLz5XaDcuA6RvKqo
         9l3qmzCpi8i1LThg9SbHTo1Gi/0HDPpU9Lp0Fl7ixovgf5Z7EeVcGsnVeRGCrXE8jgh/
         hnjYf41FoJtoS8g4tm6NsnCb/prHOa7uATWnLXZiTMtDEAlxBLiAtOdipdpLg2gwSE3X
         14A0Nmileuk+ljFSPILUw/VxqDa+zLnjCHvrtjfo69h/WCAnUfyhcb42p0OtVXqnOp5F
         nMiIyOUMrjbuXL6fOCs32FO9F0A6m2ShXolZI+1fdTEGmD7XM3ineP1nkQvpwn0JhnHi
         LAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921235; x=1725526035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV88tQPYEjmTGdra4jfjErhOhEutScS5mgpOhtY7sAw=;
        b=kMlPT3A2dk6Egq09bKoqePVpLohkI9HABEicwaOsQFrE4YH1Mx5wfsAA8obCcLIVA3
         72kYLqZeZndM/z99Xg5QMVaUSjHpF3XPz907FxMa+uo5ZOuhjZaZYCcet57sZTrbSvhV
         MfARuxVDLojZvkiOeFsSu2JLiPd+2pQRm6XAZhBZXgcRt0IHA6+bU/6LEcX1Ya5fH/aF
         SF9ddpP4T6MF8+XQGrh+nJ8V7S59eRz73eHJoW2nxJ+evi6oO83Fi5uxi93l8ENDF62a
         0flkKj2ylY/CJAVlBePxHRYLsDusbF3+ZXtMpAmmf6DBrDlre5jQClLbJQH2raix7r6G
         Y1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7XI/UgNLXCc7yRL7Zrdi+pRPK3vwgglLFimeBDBhcO594cv0meyRJRWsGJ0gG360drlrxwC+S5F4lOUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvS7ApBHS5+l2GahLiWQdWcMY0M0wSDgHJ56rfwLsSQSBFnd/K
	1M+qZMwJQJC0LAKkUT0ERJkYTPUOMgl3ru4ysR//7mkDNKUJhnko3A8LNvxma6c=
X-Google-Smtp-Source: AGHT+IHa1l1ogCO5wxXtuxGcwpTgRvNDt3KxZijBrqo1yk38aHa5tWESUd9a63ASwkmO09IzlVpSng==
X-Received: by 2002:adf:e5d1:0:b0:368:5858:826e with SMTP id ffacd0b85a97d-3749b585ab4mr1408154f8f.59.1724921234763;
        Thu, 29 Aug 2024 01:47:14 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:802f:3a47:b29:5530:28a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee40d3csm848957f8f.2.2024.08.29.01.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:47:14 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:47:13 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, 
	Akashdeep Kaur <a-kaur@ti.com>
Subject: Re: [PATCH v10 3/4] firmware: ti_sci: Introduce Power Management Ops
Message-ID: <rowimkyghjzuwt5hmwgl24oyyyjpth2zpvljc2mnyp5h5o7fyg@tdsdtsvwxfbx>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
 <20240814-lpm-constraints-firmware-msp-v10-3-bee4314bbdc8@baylibre.com>
 <20240826164346.e73vfvd4jzezlbc7@cherisher>
 <56kmiba5cr7re6rdzak5g72pprwfgvme5v4tq6rovrxrd6kefe@5mx5xxdfs7dp>
 <20240829032423.ou3hqw2sq5wj2ue6@oversight>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829032423.ou3hqw2sq5wj2ue6@oversight>

Hi Nishanth,

On Wed, Aug 28, 2024 at 10:24:23PM GMT, Nishanth Menon wrote:
> On 21:54-20240828, Markus Schneider-Pargmann wrote:
> > Hi Nishanth,
> > 
> > thanks for your review. I will integrate fixes for all your comments
> > into the next version.
> > 
> > On Mon, Aug 26, 2024 at 11:43:46AM GMT, Nishanth Menon wrote:
> > > On 08:39-20240814, Kevin Hilman wrote:
> > > [...]
> > > > diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> > > > index 1f1871e23f76..4ba9e520a28f 100644
> > > > --- a/include/linux/soc/ti/ti_sci_protocol.h
> > > > +++ b/include/linux/soc/ti/ti_sci_protocol.h
> > > > @@ -199,6 +199,47 @@ struct ti_sci_clk_ops {
> > > >  #define TISCI_MSG_VALUE_IO_ENABLE			1
> > > >  #define TISCI_MSG_VALUE_IO_DISABLE			0
> > > >  
> > > > +/* TISCI LPM wake up sources */
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_I2C0	0x00
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_UART0	0x10
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_GPIO0	0x20
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_ICEMELTER0	0x30
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER0	0x40
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER1	0x41
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_RTC0	0x50
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_RESET		0x60
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB0		0x70
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB1		0x71
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MAIN_IO		0x80
> > > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_IO		0x81
> > > 
> > > ^^ I assume these are daisy chain sources. - will these remain OR do we
> > > have to consider the wake sources SoC dependent? If so, the
> > > sci_protocol.h will be SoC agnostic..
> > 
> > These are all wakeup sources from LPM for the AM62 family of SoCs, not
> > only daisy chain sources. The currently defined wakeup sources are
> > relevant for am62x/a/p but will also be reused for others where
> > possible. Otherwise these can be extended in the future for other wakeup
> > sources.
> > 
> 
> OK -> I should have been clear, but, I think you also caught on it
> when you said am62x/a/p extended for future wakeup sources - sure..
> with 32 bits you can indeed reach a large range.. BUT:
> 
> MAIN_DOMAIN, MCU_DOMAIN are specific to a SoC part architecture, it is
> not a generic K3 SoC family architecture concept - the power domains
> will vary depending on device - same with the list of peripherals used
> as wakeup source - is WKUP_I2C0 always present in all devices with
> wakeup, Do all K3 devices have USB0 and 1 always? We should not bet on
> that.
> 
> ti_sci_protocol.h is meant as a generic SoC family level header. I see
> these as possibly hardware specific description.
> 
> Lastly, I do not see the macros used either in the patch series.. I
> understand the ti_sci_protocol.h is meant to standardize stuff in
> other driver (I tried searching to see if some other series used
> it[1], but I could not find a reference)..
> 
> So, wondering: Is DT the right place for that - With a DT header ABI
> header that is shared between driver and dt? I don't understand the
> modelling of how wakeup_reason is getting used from this series, so I
> cannot comment better..

Thanks for explaining. So should I add the header already with this
series although it is unused right now, or should we add it together
with the first actual user later on, so there is no unused header in the
meantime?

Best
Markus

> 
> [1] https://lore.kernel.org/all/?q=TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MAIN_IO
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

