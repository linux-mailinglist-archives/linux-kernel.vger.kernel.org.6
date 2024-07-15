Return-Path: <linux-kernel+bounces-252949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A55931A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F401C214AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE40F74BED;
	Mon, 15 Jul 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4r54cAh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FED18B1A;
	Mon, 15 Jul 2024 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068767; cv=none; b=pCgU/lerbTX3OqrRsOstAZkVdpzfa4lDVFTCHMsF10iX0VAwkPH0yYxSGh7sbuYjChKri+RwUlHHdVSqlldrL+Uz84IQQ4v0PQoruGd3nKA+i44QY81097yAgAA/MLCId0PtUyFQDcZDvW9ouFHZxZi8xgx54tyTs5dacQxaIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068767; c=relaxed/simple;
	bh=1cjxxXmWx1kVKV08hjeEzZPWLZBDKu/qdcCDr9soM7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsz1YHAbCUbNpYY+fCnYYeudvYrTc0qjKe64z0sUuWRF1gTB+ryLTDd742pUJYc6fYR60KPHUlgzB1Ccj1br/RavICaEpPpf+n6agDqZK567CRJS9Qh/aq3Ez76E4BR7cr5BSvDTi7FqrhtDBvX3ego7TRy0kMcSb1IY8FQG3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4r54cAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CCDC4AF0D;
	Mon, 15 Jul 2024 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721068766;
	bh=1cjxxXmWx1kVKV08hjeEzZPWLZBDKu/qdcCDr9soM7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4r54cAhTdjc26P34/QXDj/bCJDUthDIDjG3rUA7TdlnhChgz566iGZMosvvzWBlJ
	 noms/2AvrMr63mmF7+bUtKiMtRasaxopEyAPzJF7jj9KELNzQnDsS7T2ByzzOpLmyx
	 +K2YH0p4GM8GHj/pmZtrTiTQk2sjUg3LCZGi8E7fh+ZFJ/Y/Ab82u3bmLucA4GHBGT
	 maWxQGnSsn84O79LiiK24mAYswQNcPFyPR22x2ooAN3nFGvu+yXKHM4KWnaK/FQkNQ
	 fcUa2rnTbdMxEKh6OstkQ/JJ395/trccPszmbY60EXQQoE/gsZyzVwvqODVieVhZg5
	 rZaBm4OFuXhLg==
Date: Mon, 15 Jul 2024 19:39:22 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, marcin.s.wojtas@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvpp2: Improve data types and use min()
Message-ID: <20240715183922.GA263242@kernel.org>
References: <20240711154741.174745-1-thorsten.blum@toblux.com>
 <ZpVDVHXh4FTZnmUv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpVDVHXh4FTZnmUv@shell.armlinux.org.uk>

On Mon, Jul 15, 2024 at 04:44:01PM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 11, 2024 at 05:47:43PM +0200, Thorsten Blum wrote:
> > Change the data type of the variable freq in mvpp2_rx_time_coal_set()
> > and mvpp2_tx_time_coal_set() to u32 because port->priv->tclk also has
> > the data type u32.
> > 
> > Change the data type of the function parameter clk_hz in
> > mvpp2_usec_to_cycles() and mvpp2_cycles_to_usec() to u32 accordingly
> > and remove the following Coccinelle/coccicheck warning reported by
> > do_div.cocci:
> > 
> >   WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead
> > 
> > Use min() to simplify the code and improve its readability.
> > 
> > Compile-tested only.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> 
> I'm still on holiday, but it's a wet day today. Don't expect replies
> from me to be regular.
> 
> I don't think this is a good idea.
> 
> priv->tclk comes from clk_get_rate() which returns an unsigned long.
> tclk should _also_ be an unsigned long, not a u32, so that the range
> of values clk_get_rate() returns can be represented without being
> truncted.
> 
> Thus the use of unsigned long elsewhere where tclk is passed into is
> actually correct.
> 
> If we need to limit tclk to values that u32 can represent, then that
> needs to be done here:
> 
>                 priv->tclk = clk_get_rate(priv->pp_clk);
> 
> by assigning the return value to an unsigned long local variable,
> then checking its upper liit before assigning it to priv->tclk.

Sorry, I thought that I had checked the types.
But clearly I wasn't nearly careful enough.

