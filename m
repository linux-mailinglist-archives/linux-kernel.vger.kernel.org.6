Return-Path: <linux-kernel+bounces-282666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811F994E71F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64BC1C21574
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22BF1537D2;
	Mon, 12 Aug 2024 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYQeI79b"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049F14F9C9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445331; cv=none; b=sJ2YlJlHBmEDJvXgUGje48oaBhVIJWSZjbyHP3aR1bsGRxvnGaEXiFFIF/VkEszzNEZdzsic+zyQCsRtletdCAm1bPgyM6Ub8NrffsFSVG0d8ju+iLUqTZYv2mSC2Oe5fhou27KiYz1MfkZXPBa70gW/RxOgwHppq1M/hiYovmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445331; c=relaxed/simple;
	bh=dNX4pv0bFcGKYSiBvf6FyvfFPE83R0SaRt9P5rQTGKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JH0GruDBep/grJDaVKAu72QsfyWzK9BtvcUXOvN+ZSJBN+omMSf4FS6Vo2HZyGtw1L3b4oWEDiOjNn4+AyEHiaP56P80Ky1AT+Crvc8zro3xQhCCrzfMa2v7lJ8caSa5aGJvsbjSC/b3hKWJtteCpr9VPppHOyYNqqDR34Y17tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yYQeI79b; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a91cdcc78so114948766b.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723445327; x=1724050127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPaDsB4mgKNtTycoeHnN1LPcfwBltjPwwAHmSUlQ7GM=;
        b=yYQeI79bVfPRuAzv1WyuMFrQO9+1/NWbmxvXov5IBWe+yQjQPmCqJbbiSKtDPvaIUu
         yHvP346oAW3kD7/DJSv+a353DKNaK9+he6tSwKDzdEFQYdMdQ5Q+atCmsNxKgLZ8Y15L
         tlwFBs09VU+zeZEOLAh3eHMuL1ZcxKWHC0DUJy1YIkXBt3hFaWB3CCdbXWwprTcN9WEb
         49GXAP1yJ7tbWTnO6F5pCug6I9e/9MZ/RwkF1RCoDnlylH5AXoISGF8oQURMzQs1vNk8
         /jtyeWof7IqijqJ+l8SsyEG5iIdTUMXL0yt8+ilW+XHFBDcGmA2blYlIcnsrvXBz3gec
         /Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723445327; x=1724050127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPaDsB4mgKNtTycoeHnN1LPcfwBltjPwwAHmSUlQ7GM=;
        b=QTz9z3UWZno3yXbaWPWkm9PTPgjtw4uMYPwFy5gQrRWn2dEH/u+oFSRMQgfSArTgdV
         +xs34YHJB6KM7nPkuVrBpoRZgzfRU/AFzhP6wCNQ06Z8bfqN6zjYHi71jxLcHLc28eww
         9JxIR+unsTFfdvB/Fp3yFQPBvKlH07qx9luJJ4zApPp6V+z5O/EU5tgqCEi6UF+TCMn4
         NxwgmP/wthZeifuLu60L5dBLQEUTPi6RY3R4V8XDtkA5mJum2IBfNsg47n3n4LA2HUbu
         9P74aP+oO+oRCaYMEHk55j0AlyjO04tSlzdGUmfiSc7lYdeE0XzR3zMthbu5VHSH9XjB
         UheQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRm2AUCJTXXCRusC+csb15U5RPUK3pBZedHvZKg3tCg3rKJTy0ftLsQpkyA1VuqqXPbhVY63Rg9mce2KXJ87sZGo64iGkr4QlvVavE
X-Gm-Message-State: AOJu0YxyOcdZa7MUP7yCR39oOX42qgZlz6LqVF9ulgqLdCqT2Vkqz/Bv
	OnRSFmLvwzBMngNb0dgvbYEw8PmJXMGzKLjtSmXCuK6Xo0YDJLaYl4wPWoj57Y4=
X-Google-Smtp-Source: AGHT+IG/hs6hri9F4rxByDFsrSBLvCmLFxDpiqpwrHt7cc+98+r7zdjaPv6vGfE3xIllakw/1bm6BQ==
X-Received: by 2002:a05:6402:2711:b0:5a1:a08a:e08 with SMTP id 4fb4d7f45d1cf-5bd0a53a598mr8325229a12.11.1723445327342;
        Sun, 11 Aug 2024 23:48:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb11b5e6sm204485466b.95.2024.08.11.23.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 23:48:46 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:48:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next 5/6] net: ti: icss-iep: Move icss_iep structure
Message-ID: <7a65afda-814b-4ff3-9f12-f07efc97b234@stanley.mountain>
References: <20240808110800.1281716-1-danishanwar@ti.com>
 <20240808110800.1281716-6-danishanwar@ti.com>
 <6eb3c922-a8c6-4df4-a9ee-ba879e323385@stanley.mountain>
 <3397a020-195c-4ca3-a524-520171db794b@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3397a020-195c-4ca3-a524-520171db794b@ti.com>

On Mon, Aug 12, 2024 at 11:11:21AM +0530, MD Danish Anwar wrote:
> Hi Dan,
> 
> On 10/08/24 1:40 am, Dan Carpenter wrote:
> > On Thu, Aug 08, 2024 at 04:37:59PM +0530, MD Danish Anwar wrote:
> >> -	struct ptp_clock *ptp_clock;
> >> -	struct mutex ptp_clk_mutex;	/* PHC access serializer */
> >> -	u32 def_inc;
> >> -	s16 slow_cmp_inc;
> > 
> > [ cut ]
> > 
> >> +	struct ptp_clock *ptp_clock;
> >> +	struct mutex ptp_clk_mutex;	/* PHC access serializer */
> >> +	spinlock_t irq_lock; /* CMP IRQ vs icss_iep_ptp_enable access */
> >         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > The patch adds this new struct member.  When you're moving code around, please
> > just move the code.  Don't fix checkpatch warnings or do any other cleanups.
> > 
> 
> My bad. I didn't notice this new struct member was introduced. I will
> take care of it.
> 
> Also apart from doing the code movement, this patch also does the
> following change. Instead of hardcoding the value 4, the patch uses
> emac->iep->def_inc. Since the iep->def_inc is now accessible from
> drivers/net/ethernet/ti/icssg/icssg_prueth.c
> 
> @@ -384,7 +384,8 @@ static void prueth_iep_settime(void *clockops_data,
> u64 ns)
>  	sc_desc.cyclecounter0_set = cyclecount & GENMASK(31, 0);
>  	sc_desc.cyclecounter1_set = (cyclecount & GENMASK(63, 32)) >> 32;
>  	sc_desc.iepcount_set = ns % cycletime;
> -	sc_desc.CMP0_current = cycletime - 4; //Count from 0 to (cycle time)-4
> +	/* Count from 0 to (cycle time) - emac->iep->def_inc */
> +	sc_desc.CMP0_current = cycletime - emac->iep->def_inc;
> 
>  	memcpy_toio(sc_descp, &sc_desc, sizeof(sc_desc));
> 
> 
> Should I keep the above change as it is or should I split it into a
> separate patch and make this patch strictly for code movement. I kept
> the above change as part of this patch because it is related with the
> code movement. Moving the iep structure from icss_iep.c to icss_iep.h
> makes it accessible to icssg_prueth.c so I thought keeping them together
> will be a better idea.
> 
> Please let me know if this is okay.
> 

Huh, I saw that the comment had changed but I assumed that was because
checkpatch had complained.  I didn't notice that the 4 changed to
emac->iep->def_inc.  That's the kind of change that we do really want to notice.

Yep.  Please, could you split that out into a separate patch.

regards,
dan carpenter


