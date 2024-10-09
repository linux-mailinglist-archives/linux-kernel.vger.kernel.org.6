Return-Path: <linux-kernel+bounces-356630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7766C996459
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02140B2617A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D918A959;
	Wed,  9 Oct 2024 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Uhrm+oI+"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07671166F00;
	Wed,  9 Oct 2024 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464526; cv=none; b=DqGiWdYaWsARClssfP68Zt2g4HxQVXyKRb7AQGf9vqLK8RQahkhUcJVkz5fGEZtdpgZkLsvT+TB8mKOGlZ1ayW+lPDoEt4pgR6qDzXcdF3QH40kvKk8VG6C4lkGwOUZ/3Zj83mQPUDqLYgyWcGymKxiHb4IJUWIBdtnmR524fqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464526; c=relaxed/simple;
	bh=ESDpBhZRaGB14XgN7tzB2HQ8mkUIV3izuk6EsszNpc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ls/7t40Hg/y4txaFVcmgxuJUbp2NVwoPNyux9z5L9wKI83WR4eaT95a3kApEjUUUzHslE9VKmJOpIQe0o27x7wPr+nLgtHTQsYszV8EtQxgKsfW5ZhFpOlnFuv0lDB4Gg4Xn+enNrVhTKFgTIWIMyF67vU9rztZOXsP2XzjIB+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Uhrm+oI+; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.14])
	by mail.ispras.ru (Postfix) with ESMTPSA id F41F440B2786;
	Wed,  9 Oct 2024 09:01:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F41F440B2786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1728464515;
	bh=0tBlbvTpMjEqfjlFsN9StBxwVE8haftHBQAgLVgyA/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uhrm+oI+Y9xZzVZUh7+xdeLE6G2fr5xo3ziwvAT9SJePQNWwM2b1WgS1I95IB6+Yp
	 9pUT/TbEC+igKD/12/XK08TTI5RK+0TXTL2AyZfi+CkpAVqXX7dplqhELc0cHWn8bG
	 lMfGEU1mrp51lxkAC4luddzLdLYE8ai5Z1+k5k1E=
Date: Wed, 9 Oct 2024 12:01:51 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stephen Boyd <sboyd@kernel.org>, lvc-project@linuxtesting.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Gregory Clement <gregory.clement@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [lvc-project] [PATCH v3] clk: mvebu: Prevent division by zero in
 clk_double_div_recalc_rate()
Message-ID: <20241009-29749473966747300f3d1d3b-pchelkin@ispras.ru>
References: <20240917132201.17513-1-adiupina@astralinux.ru>
 <af7dc028ced22413210701a5e2e05990.sboyd@kernel.org>
 <d05d9ebd-f954-482b-878b-9dcb422821a8@astralinux.ru>
 <c2250a7cd0e2af5077ade91279567c3b.sboyd@kernel.org>
 <a79dda0a-258d-4567-b473-44aabe81b649@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a79dda0a-258d-4567-b473-44aabe81b649@lunn.ch>

Hi Andrew,

On Tue, 08. Oct 23:58, Andrew Lunn wrote:
> On Mon, Oct 07, 2024 at 03:56:29PM -0700, Stephen Boyd wrote:
> > Quoting Alexandra Diupina (2024-09-24 06:14:44)
> > > >> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> > > >> index 8701a58a5804..b32c6d4d7ee5 100644
> > > >> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> > > >> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> > > >> @@ -343,7 +343,12 @@ static unsigned long clk_double_div_recalc_rate(struct clk_hw *hw,
> > > >>          div = get_div(double_div->reg1, double_div->shift1);
> > > >>          div *= get_div(double_div->reg2, double_div->shift2);
> > > >>   
> > > >> -       return DIV_ROUND_UP_ULL((u64)parent_rate, div);
> > > >> +       if (!div) {
> > > >> +               pr_err("Can't recalculate the rate of clock %s\n", hw->init->name);
> > > > hw->init is set to NULL after registration (see clk_register() code). If
> > > > div is 0 what does the hardware do?
> > > 
> > > Thanks for noticing the error. Yes, hw->init is set to zero,
> > > I will replace that code with clk_hw_get_name(hw).
> > > If the value of div is 0, should I return 0 as stated in the
> > > comment for .recalc_rate (in struct clk_ops) or should I
> > > return parent_rate as in some other similar rate recalculation
> > > functions (in some other drivers)?
> > 
> > It depends on what the hardware does. Does the hardware pass on the
> > parent rate if the divider is zero? If so, then return parent_rate. Or
> > does it turn off completely? If so, return zero.
> 
> I don't think anybody knows what the hardware does in this
> condition. I also suspect it has never happened, or if it has, nobody
> has complained.
> 
> I would say, let is divide by 0, so there is an obvious kernel stack
> trace and hopefully a report of the issue. It can then be investigated
> in a way we can then find out what the hardware actually is doing.

Is it worth adding some kind of WARN assertions? Or actually just leave it
for now as is?

