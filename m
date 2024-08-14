Return-Path: <linux-kernel+bounces-286805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF6E951F34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642431F22A60
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CFD1B583C;
	Wed, 14 Aug 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o9lAoXbv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876061B5819
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650921; cv=none; b=p97pQJwjX+hrMc7aXj3VF7Co410YTqZJymcDAG/dLFp4BOGkybb12nD/15KhYwILGWkc3SaIfEZfZ0EQyHEwRND3qhSUXgQl6XWf9EiR9xGsLTMNKs110/jbtWA+ZoIANxQKANBq4uArgoNDthzWczEk9d839Yf30ohXs+HdzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650921; c=relaxed/simple;
	bh=3M3wiWnQTSAXkMzacuqW6SeqAEhIrDbX3h51wo5nQhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2ANYedwr7lkO2BTqnhS1i/jWRTXOcsHrXDBpCN5QyzhgPZvDDgKT7kRAskJ044k9zVJoaCKP5erDb4zXDSE/caShF2KiakzVF52xxxr5afAH2z9PHmbu0xNg4wtvvxq47yuHlEnohi5MDvTJvvYDITk+M09AReon9GOIfESZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o9lAoXbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2D5C116B1;
	Wed, 14 Aug 2024 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723650921;
	bh=3M3wiWnQTSAXkMzacuqW6SeqAEhIrDbX3h51wo5nQhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9lAoXbvmyNMiw2tSeW37J6/tffVKTyGtOY3wT8RYgBeROT+bqrCfg3jVA0+nmUmc
	 d/BbzNg8vi2QNam7ZBAJ6I6Knm5c7CwomutfsQF+JR7HYSRrFSKDSA/RXQZjj7DtDu
	 8Vszgc02jYhktfsgOeeMFVUFtoo3ValvG7k/CSyQ=
Date: Wed, 14 Aug 2024 17:55:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>,
	Florian Rommel <mail@florommel.de>,
	Jason Wessel <jason.wessel@windriver.com>,
	Arnd Bergmann <arnd@arndb.de>, kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdbts: fix hw_access_break_test
Message-ID: <2024081410-scrabble-drizzly-3005@gregkh>
References: <20240812085459.291741-1-mail@florommel.de>
 <CAD=FV=VC20PvOPSf9quqghA8SKKkCduadtU7nso4wkSwVKH3jQ@mail.gmail.com>
 <20240814153843.GA168155@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814153843.GA168155@aspen.lan>

On Wed, Aug 14, 2024 at 04:38:43PM +0100, Daniel Thompson wrote:
> On Mon, Aug 12, 2024 at 01:04:22PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Aug 12, 2024 at 1:55 AM Florian Rommel <mail@florommel.de> wrote:
> > >
> > > The test for access watchpoints (hw_access_break_test) was broken
> > > (always failed) because the compiler optimized out the write to the
> > > static helper variable (hw_break_val2), as it is never read anywhere.
> > > This resulted in the target variable (hw_break_val) not being accessed
> > > and thus the breakpoint not being triggered.
> > >
> > > Remove the helper variable (hw_break_val2), and use READ_ONCE to force
> > > reading the target variable (hw_break_val).
> > >
> > > Signed-off-by: Florian Rommel <mail@florommel.de>
> > > ---
> > >  drivers/misc/kgdbts.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> Looks good. I pushed this through kgdbtest and it likes it too. I can
> turn one of the XFAILs off (yay).
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Arnd/Greg: Are you happy to pick this up or should I take it through the kgdb
> tree? FWIW right now there are zero other patches for kgdb this cycle, although
> that could change!

I've already picked it up, thanks!

greg k-h

