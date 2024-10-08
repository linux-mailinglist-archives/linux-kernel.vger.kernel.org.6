Return-Path: <linux-kernel+bounces-355940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F26995979
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383B31C21CFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD61215026;
	Tue,  8 Oct 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rxq824CP"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C96185923;
	Tue,  8 Oct 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424691; cv=none; b=QYjnY9fb4ZEH0dyW1yvqgt8hFDx3vVgEkg0rUS5SWtvh2cgUjR76Sl8Vvv/R69bTsnP6p0wRBPGXqmH8DH87GhxFQEuHBAmp9Q05VIqD9zVWOfauZYfpY77lzj7bUFSqRGS3HHn8jdIOyRCIqPJM/gvVzdALc4dFjqcM69OoAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424691; c=relaxed/simple;
	bh=xCkhWr4L99Mc/IQW1K6PzQOytJMgYvq3ru5wDNf8phI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwkFMj8vN3znE7yqNrNQJiiJTMj0YhKIOOkfSrNKCzubeFMywHUdGKFn+OMO8j0pgY4nlTrTtyGwQvW5O4OOq5o7bY3j6EX+3vanw4iHBWdnBn8UGJHCV9/YB2wUHS6LrXF3v55+8LRKDe2jIFR0PpNvEQ5THaCW9oJC/RQ4mxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rxq824CP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ol6xCRDeAcUBSBVtOuCb1imrILBrc3i/1kc8nU/d/wM=; b=Rxq824CPUR3hYn+96FXudWGxMh
	Eb4KrySC7FbCtVscNmEUyMB6nZ9KKrQKqO6jhvTd2t665+fLW/OIWL/wDR9KC5/tFo8tmhke8SC6n
	yLlMmeLgQMPWYcdI0en8RwE3saNCIYa1rrCAbYGvI7n5iHWXk8XiKOc/xXH7eqPnWYOQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syIDQ-009Pvi-IE; Tue, 08 Oct 2024 23:58:00 +0200
Date: Tue, 8 Oct 2024 23:58:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v3] clk: mvebu: Prevent division by zero in
 clk_double_div_recalc_rate()
Message-ID: <a79dda0a-258d-4567-b473-44aabe81b649@lunn.ch>
References: <20240917132201.17513-1-adiupina@astralinux.ru>
 <af7dc028ced22413210701a5e2e05990.sboyd@kernel.org>
 <d05d9ebd-f954-482b-878b-9dcb422821a8@astralinux.ru>
 <c2250a7cd0e2af5077ade91279567c3b.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2250a7cd0e2af5077ade91279567c3b.sboyd@kernel.org>

On Mon, Oct 07, 2024 at 03:56:29PM -0700, Stephen Boyd wrote:
> Quoting Alexandra Diupina (2024-09-24 06:14:44)
> > >> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> > >> index 8701a58a5804..b32c6d4d7ee5 100644
> > >> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> > >> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> > >> @@ -343,7 +343,12 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
> > >>          div = get_div(double_div->reg1, double_div->shift1);
> > >>          div *= get_div(double_div->reg2, double_div->shift2);
> > >>   
> > >> -       return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> > >> +       if (!div) {
> > >> +               pr_err("Can't recalculate the rate of clock %s\n", hw->init->name);
> > > hw->init is set to NULL after registration (see clk_register() code). If
> > > div is 0 what does the hardware do?
> > 
> > Thanks for noticing the error. Yes, hw->init is set to zero,
> > I will replace that code with clk_hw_get_name(hw).
> > If the value of div is 0, should I return 0 as stated in the
> > comment for .recalc_rate (in struct clk_ops) or should I
> > return parent_rate as in some other similar rate recalculation
> > functions (in some other drivers)?
> 
> It depends on what the hardware does. Does the hardware pass on the
> parent rate if the divider is zero? If so, then return parent_rate. Or
> does it turn off completely? If so, return zero.

I don't think anybody knows what the hardware does in this
condition. I also suspect it has never happened, or if it has, nobody
has complained.

I would say, let is divide by 0, so there is an obvious kernel stack
trace and hopefully a report of the issue. It can then be investigated
in a way we can then find out what the hardware actually is doing.

   Andrew

