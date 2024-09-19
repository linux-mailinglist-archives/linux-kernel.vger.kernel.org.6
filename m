Return-Path: <linux-kernel+bounces-333479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B995E97C95D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0B12846A4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347919DF82;
	Thu, 19 Sep 2024 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="oPe/FfHh"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C419D894;
	Thu, 19 Sep 2024 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749595; cv=none; b=Vwk4eosJivM1WOCs8XrqwT57f2T9+aKAYJYRsGPXcso1KgHebDwXXj0tPVoiyOF9jsdMKsAHYFZw11avY53stYaMPvliATJSWRFpw26FM8+XqOz9GH6ppwrQje2R03N28xIyao6nsdZIo0DI6OJ9V2FmtobQYuDSQlCLw9th0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749595; c=relaxed/simple;
	bh=iT/z+gt7N6FCrIsgjLpdKSk3oGQDEb+Vb2nnmn2Yo5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2cdDPbQqH3159tLKjNstdr1454MioHNnCcyPhFVdP9kKP7LceDfESPaAUL6eGUZTTsgMe7PhkOD2YhAM6kvMdIlJNEa6B7IUbwwbo5E+Jw/y4nsLQW3Dw8IK41pY0dZmgGwJ/g68Kjxy7ajK3Jvxz1dpV79yuG5c6PI5J5FRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=oPe/FfHh; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 786EF14858E0;
	Thu, 19 Sep 2024 14:39:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1726749584; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=UBmm9nbuKx5Az853ydHco1hV3oceAC7ff+CGGG7c6PU=;
	b=oPe/FfHh+kitawSCJxXOgsPXhXaYJ8QQyigAOrqiMEIuoCyJPR0RWMcUjLMycD+FaE+pVA
	oFC1AyMeBNONTzV0FXu3GIQUjm5TCrphFzMYWFV74/WLLyuSjjP0evNpg8kIW4ZauVes75
	q3bNFAuOd1WzniHiyFtOfzRAocbnPcyAZyB4t+9DC4d5qi6EKOU7t22zzT/Sj+xkLqLJPo
	MG2zIMyy0ufJ+kO0+aGgYUp6JBOuU0MgKirc/x8Ey47HmNKD2s6gXhI+SoTSGuhtyAZ1z2
	f7F5FdEgKzVbNsPkTnZDyWat7rNrfTYWx9lcn9Ore08B1YOaK6xSZNG5LSCRgg==
Date: Thu, 19 Sep 2024 14:39:40 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 09/12] clk: at91: sam9x60: Allow enabling main_rc_osc
 through DT
Message-ID: <20240919-outsider-extending-e0a926bd23fa@thorsis.com>
Mail-Followup-To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Christian Melki <christian.melki@t2data.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-10-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821105943.230281-10-ada@thorsis.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

after being busy with other things, I'm back looking at this series.
As Nicolas pointed out [1], we need three clocks for the OTPC to work,
quote:

  "for all the products, the main RC oscillator, the OTPC peripheral
  clock and the MCKx clocks associated to OTP must be enabled."

I have a problem with making the main_rc_osc accessible for both
SAM9X60 and SAMA7G5 here, see below.

Am Wed, Aug 21, 2024 at 12:59:40PM +0200 schrieb Alexander Dahl:
> SAM9X60 Datasheet (DS60001579G) Section "23.4 Product Dependencies"
> says:
> 
>     "The OTPC is clocked through the Power Management Controller (PMC).
>     The user must power on the main RC oscillator and enable the
>     peripheral clock of the OTPC prior to reading or writing the OTP
>     memory."
> 
> The code for enabling/disabling that clock is already present, it was
> just not possible to hook into DT anymore, after at91 clk devicetree
> binding rework back in 2018 for kernel v4.19.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/clk/at91/sam9x60.c       | 3 ++-
>  include/dt-bindings/clock/at91.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index e309cbf3cb9a..4d5ee20b8fc4 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -207,7 +207,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>  	if (IS_ERR(regmap))
>  		return;
>  
> -	sam9x60_pmc = pmc_data_allocate(PMC_PLLACK + 1,
> +	sam9x60_pmc = pmc_data_allocate(PMC_MAIN_RC + 1,
>  					nck(sam9x60_systemck),
>  					nck(sam9x60_periphck),
>  					nck(sam9x60_gck), 8);
> @@ -218,6 +218,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>  					   50000000);
>  	if (IS_ERR(hw))
>  		goto err_free;
> +	sam9x60_pmc->chws[PMC_MAIN_RC] = hw;
>  
>  	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL, 0);
>  	if (IS_ERR(hw))
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> index 3e3972a814c1..f957625cb3ac 100644
> --- a/include/dt-bindings/clock/at91.h
> +++ b/include/dt-bindings/clock/at91.h
> @@ -25,6 +25,7 @@
>  #define PMC_PLLBCK		8
>  #define PMC_AUDIOPLLCK		9
>  #define PMC_AUDIOPINCK		10
> +#define PMC_MAIN_RC		11
>  
>  /* SAMA7G5 */
>  #define PMC_CPUPLL		(PMC_MAIN + 1)

There are IDs defined in the devicetree bindings here, which are used
both in dts and in driver code as array indexes.  In v1 of the patch
series I just added a new last element in the end of the generic list
and used that for SAM9X60.

For SAMA7G5 those IDs are branched of from PMC_MAIN in between, making
SAMA7G5 using a different last element, and different values after
PMC_MAIN.

Now we need a new ID for main rc osc, but not only for SAM9X60, but
also for SAMA7G5.  I'm not sure what the implications would be, if the
new ID would be added in between before PMC_MAIN, so all values would
change?  Adding it to the end of the lists would probably be safe, but
then you would need a diffently named variant for SAMA7G5's different
IDs.  I find the current status somewhat unfortunate for future
extensions.  How should this new ID be added here?  What would be the
way forward?

Greets
Alex

[1] https://lore.kernel.org/linux-clk/ec34efc2-2051-4b8a-b5d8-6e2fd5e08c28@microchip.com/T/#u

> -- 
> 2.39.2
> 
> 

