Return-Path: <linux-kernel+bounces-309095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309BC966625
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953EEB213A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CA31B78F6;
	Fri, 30 Aug 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rdxNaA2e"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E061F1B653A;
	Fri, 30 Aug 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033224; cv=none; b=EGKzhp23hY/2hDzxE9YDiIW5s1OrBzAS5r8a3tVAirWLSOZKOo5MXwvkvljVu8XbvFV169hj0bXtJZTOUJv2hnSGtG69ssyi7Y3ecIpI4+nHooWaWWzAwtWq8Tl9b2PAx5Dn47VpbdFB6RBCScNPViFP353s6ZCFXZ1QV1/vJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033224; c=relaxed/simple;
	bh=L6qzfFeZ2s8hkmqa5FbxHyttz/W2Lpaa/LvWiahn0v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MRcFUtU4sd9PCVjCd4yKlfxWX3XWwNYpGhrEMvacajul5rGRA0OUsaXsGcGss0lpVVd5neO9pPbO4Ta0d7o+napHeezawYbMUjCEqS1TX9UW9oJKu+KDmSmtNclfq99qUk9571zwfCEJwk1D0aesSjpRlc0aKiWPWDhVInQ/jOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rdxNaA2e; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725033221; x=1756569221;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L6qzfFeZ2s8hkmqa5FbxHyttz/W2Lpaa/LvWiahn0v4=;
  b=rdxNaA2eg04v1YiPrlYZamzjsph5FZT0qICBXNUGHIPFhUyJVwiOn9Va
   sgE4vgmldKjTyRGE/lLeQYjEqpy6Hg5zGqdkrEKDqVzD3pKvTbdLRG4Y6
   Jon6/TynagivO0dDW7PzEyzj+Jmi3UHcPN55TyEMYJZGR8NeH6COUw1Ve
   YBJ76L3vfNOVApWLrwMJ0bH8kF0JOQO2FgALztIlwNKlrlPgT85prToCn
   IqD97LzG7JBtb3+BQSpvFYcmZcN0K7gzM0F1Io5IydMrsmUhhotxOaopU
   NCfcIra3wLOEZZa6Y9ZUSVzgT+Qb4xYZ6DeERTYu7W1d+2d8rg68j8Y66
   g==;
X-CSE-ConnectionGUID: /Y93KtjZSYed2Fvm7dD/eA==
X-CSE-MsgGUID: 4M/IeVpiT4KdcoQoi4MgGg==
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="198544578"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 08:53:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 08:53:04 -0700
Received: from [10.159.224.217] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 30 Aug 2024 08:53:02 -0700
Message-ID: <ab0bd71b-d2f3-4815-9905-decf7c449fc0@microchip.com>
Date: Fri, 30 Aug 2024 17:53:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] clk: at91: add sama7d65 clock support
Content-Language: en-US, fr-FR
To: <Ryan.Wanner@microchip.com>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1724948760.git.Ryan.Wanner@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <cover.1724948760.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 29/08/2024 at 18:42, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Hello,
> 
> This series adds clock support for the SAMA7D65 SoC. There are also
> changes to the master clock driver and PLL driver in order to account for
> the increased amount of clocks being supported in this new SoC.
> 
> Trying to account for all the updates happening in this system, this
> patch set is based off of the most recent updates to at91-next branch.
> 
> Ryan Wanner (3):
>    clk: at91: sama7d65: add sama7d65 pmc driver
>    clk: at91: clk-master: increase maximum number of clocks
>    clk: at91: clk-sam9x60-pll: increase maximum amount of plls

For the whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> 
>   drivers/clk/at91/Makefile          |    1 +
>   drivers/clk/at91/clk-master.c      |    2 +-
>   drivers/clk/at91/clk-sam9x60-pll.c |    2 +-
>   drivers/clk/at91/pmc.c             |    1 +
>   drivers/clk/at91/sama7d65.c        | 1372 ++++++++++++++++++++++++++++
>   5 files changed, 1376 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/clk/at91/sama7d65.c
> 


