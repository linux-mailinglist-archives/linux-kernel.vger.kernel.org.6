Return-Path: <linux-kernel+bounces-375813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498C09A9B24
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA970B21B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3934614EC73;
	Tue, 22 Oct 2024 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6A4EVkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4C1A269;
	Tue, 22 Oct 2024 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582447; cv=none; b=PDFGoVNVhAE5p4Zd6weRxHsxmUQ+yaSWvmliRhIw9+qsVU0Ji7xZDEkM0oToklTYa0iqiX6l1wnr6Hd/VHaJBf/11WOjTlxbfehKj4USDLm6PxxZg2L/psRDWcdA7zBXNAR2jedQukZkF++LX9+AO0sEtI2B623PKA2nyWcYU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582447; c=relaxed/simple;
	bh=WX47FjWdIeFvEZK0bxNuqKxWrqQik5pNCeDee+e/CW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8jmgYY4TXNE+/XvC8qRPPsS3PdvBnJtf6B8AfysGFwGqTDngP/KehQwCFlPv3KXi61gV9lUALIR98VmClSFIXNM7/Z+Mr0FDZ8Q3K/YnY+aE45PNI6CHASjD56OSW3qt5RdZ0fvT+gXzf37CtCCIsJqwyqhCNSDmNsbUOPRcTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6A4EVkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA14AC4CEC3;
	Tue, 22 Oct 2024 07:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729582447;
	bh=WX47FjWdIeFvEZK0bxNuqKxWrqQik5pNCeDee+e/CW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6A4EVkX8RcHfnzQTB0u4BzCHKwQ7jh6oU7r/geHWXMtwq0b+DcSDG0ANwO0+5V5I
	 yMK3YhLf38GR/YgEkUzkrFwCH334tHBsw/hBAmJMXJDi7N6K01fwM0iBWOYP4Pd0Cv
	 vx+P4BFr/0YhoS+knnj0aId75CEVP+lhY3dbhnOJkRt8SXROAjCEEOE9OA6tyeU3TB
	 3N+STdu6aiXXtIzwYadCi544KzOaPP+ammawH0SS1wKzN4XnWF4uehh4LE/THywME+
	 yumrLDgsMvsPVIceX5RuXG48V6kBrtYF4jNGBv1XkX1mUWaYDQq6ssSeY8vSY/EktG
	 AWeGLn60TvULg==
Date: Tue, 22 Oct 2024 08:34:03 +0100
From: Simon Horman <horms@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [net v2] net: ftgmac100:
 refactor getting phy device handle
Message-ID: <20241022073403.GP402847@kernel.org>
References: <20241021023705.2953048-1-jacky_chou@aspeedtech.com>
 <20241022065753.GN402847@kernel.org>
 <SEYPR06MB5134C8206C6BA27BD1F761319D4C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB5134C8206C6BA27BD1F761319D4C2@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Tue, Oct 22, 2024 at 07:13:56AM +0000, Jacky Chou wrote:
> Hi Simon
> 
> Thank you for your reply.
> 
> > > The ftgmac100 supports NC-SI mode, dedicated PHY and fixed-link PHY.
> > > The dedicated PHY is using the phy_handle property to get phy device
> > > handle and the fixed-link phy is using the fixed-link property to
> > > register a fixed-link phy device.
> > >
> > > In of_phy_get_and_connect function, it help driver to get and register
> > > these PHYs handle.
> > > Therefore, here refactors this part by using of_phy_get_and_connect.
> > 
> > Hi Jacky,
> > 
> > I understand the aim of this patch, and I think it is nice that we can drop about
> > 20 lines of code. But I did have some trouble understanding the paragraph
> > above. I wonder if the following is clearer:
> > 
> >   Consolidate the handling of dedicated PHY and fixed-link phy by taking
> >   advantage of logic in of_phy_get_and_connect() which handles both of
> >   these cases, rather than open coding the same logic in ftgmac100_probe().
> >
> 
> Agree. I will change the commit message.
> Thank you for helping me fine-tune this message.
> 
> > >
> > > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> > > ---
> > > v2:
> > >   - enable mac asym pause support for fixed-link PHY
> > >   - remove fixes information
> > 
> > I agree that this is not a fix. And should not have a Fixes tag and so on.
> > But as such it should be targeted at net rather than net-next.
> > 
> >   Subject: [net-next vX] ...
> > 
> > The code themselves changes look good to me. But I think the two points above,
> > in combination, warrant a v3.
> 
> I will send v3 patch to net-next tree.

Great, thanks Jacky.

