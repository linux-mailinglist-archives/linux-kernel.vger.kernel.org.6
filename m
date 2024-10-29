Return-Path: <linux-kernel+bounces-389537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D8F9B6E29
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965191F21AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC9F1EC016;
	Wed, 30 Oct 2024 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="H9gO+xdx"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076311DDA2D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321702; cv=none; b=FtjGPH0pF3Vz4ZCURW3aGHlEhpjLzB/bK3pzaaac1pF0dVCSK8CE49By0N26jvPUmScZCk58MNAxgPlAi+ncnw5N6tbQKN3TeVb1f8b3ESssnvNgchB3ctSlJFsyvaV3sG35GjnO2ahK5SmqufmtB3i5YJcS/quIzsoq9vcRHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321702; c=relaxed/simple;
	bh=+tuAXi9plOZ5JZi3D9gHq46vf1wXP9imDLf0+TDmEqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7sB6zNKYLvcSKWZ3XA+VZ5XVZ7kcc354je3Q+NnsNJEchm7d1VNMRflynf5Rb4MhjrlCDi6TQINb7KDwk/ovudWKBe+rZnFAo+Pxj1ZVLL8grXE029go9GeWjwmr2kpFrFqB6sXnJyTnlrGvWf9g4eMybmf848wDAw7G0lbNC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=H9gO+xdx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (guestnat-104-133-8-96.corp.google.com [104.133.8.96] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49UKqMLU019949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 16:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730321547; bh=brOYbFAwxfDkgTcA38Rp6WdwgOwmILxsA43HsQIqOOo=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=H9gO+xdxZvUG0VZxbGccFGsrBacihazewaecbsIK1wdx3xbsLs4UfWDiJ0OcQhaOm
	 i1DY4yobeJk+Fx4D+so4Gs2cKbHvMLDyGj2HOKtMlYIbuwNgI4qj2Na5jeKhGn89gQ
	 puIUPianNwWkX0qClESY+e76eaohyCkAo3SCEslDASHuFEUR+fCwEWqVvyoxjJvDDf
	 l8a806vvdhn1CmQoqyrMlMEUwH3tv/984VXsOz/BYn8RQSmLxtE+t9CmOnyvpq/T+D
	 WOQOuXpR4QhnpzNPkHSFgyrYXQ694vKre+Isgs0Qe6tIE9xF+FEHOyzSAcDEKR2Nss
	 BUi/HQTnM7e7w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 3B8783404ED; Mon, 28 Oct 2024 21:33:28 -0700 (PDT)
Date: Mon, 28 Oct 2024 21:33:28 -0700
From: "Theodore Ts'o" <tytso@mit.edu>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox <willy@infradead.org>, Arnd Bergmann <arnd@kernel.org>,
        Tyler Hicks <code@tyhicks.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ecryptfs is unmaintained and untested
Message-ID: <20241029043328.GB3213@mit.edu>
References: <20241028141955.639633-1-arnd@kernel.org>
 <Zx-ndBo7wpYSHWPK@casper.infradead.org>
 <ef98d985-6153-416d-9d5e-9a8a8595461a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef98d985-6153-416d-9d5e-9a8a8595461a@app.fastmail.com>

On Mon, Oct 28, 2024 at 09:50:37PM +0000, Arnd Bergmann wrote:
> On Mon, Oct 28, 2024, at 15:02, Matthew Wilcox wrote:
> >
> > This comment has been there since June 2021, so I think we can just
> > delete ecryptfs now?
> 
> I have no opinion on removing ecryptfs, but I don't how possibly
> removing it is related to the patch I sent, as far as I can tell
> it just means it relies on both CONFIG_BLOCK and CONFIG_BUFFER_HEAD
> then.
> 
> Is there any indication that the last users that had files on
> ecryptfs are unable to update their kernels?

Debian is still shipping ecryptfs-utils and is building and including
the ecryptfs kernel module in their distro kernel.`

So it seems likely that there are probably a non-zero (although
probably relatively small) number of ecryptfs users out there.

	 	    	   	     	      - Ted

