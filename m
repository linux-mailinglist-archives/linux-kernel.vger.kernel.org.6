Return-Path: <linux-kernel+bounces-191870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F48D155A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB2BB232E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F0973468;
	Tue, 28 May 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cGh1gdaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0A4501E;
	Tue, 28 May 2024 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716881358; cv=none; b=X4iYAF2+jR9KwKG6TFwGmYUy8WqSPJJ5sAt4bhm5bxn9F08tv2K/rjn7ubOFYISrVuwth1iJZfyrV9XRr9AA5BHBfgFk086KfgDwkn0NZyl8iU8ycjfNl7MCY0nVeSl0TMp/MmzXV85UZy/i94psEmt++qW7M+UmvDqTbPQF6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716881358; c=relaxed/simple;
	bh=X/8zpPCm5I0TYQsZiJfTi5mbUCxFnwt/N5kmtRnuSMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0GTmSvXp0zTgxY5XnPRzwAyS8/sTSxs+7j7fSByhnqzrPipoh6VKhRAvOGpILeoqDtaOISHv2zaFsd8B7x89Xgi2oCaqObM6l7oqh3r0okTu9Oaxw5Hob1cdFI4+7n/kgX0cNnpBCoamkKmaA5wUwbYrxDORIGAbVJ+04PvE7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cGh1gdaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D3BC3277B;
	Tue, 28 May 2024 07:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716881357;
	bh=X/8zpPCm5I0TYQsZiJfTi5mbUCxFnwt/N5kmtRnuSMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGh1gdaZqqQ/junK22Dm8ftUhJz4cLAk3xMG95BlD84KsRZ4DM4gXbJ0oHRUgeADf
	 bfC9XwDjI6RXXk+pwOwDhlxGTRq7BdsrMMMtLLvyfTuse5ILHbZpTVtrtMIQDpZRD5
	 2UenzAeHZ0AlA+aiJ4Bj0HVaafRsHaKxfkm1pbTI=
Date: Tue, 28 May 2024 09:29:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daehwan Jung <dh10.jung@samsung.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	"open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH] usb: host: Add a quirk for writing ERST in high-low order
Message-ID: <2024052845-unwatched-sprig-b0e1@gregkh>
References: <CGME20240528055659epcas2p4f86642d6647855747cea35b04f8a46cc@epcas2p4.samsung.com>
 <1716875836-186791-1-git-send-email-dh10.jung@samsung.com>
 <2024052814-exponent-domestic-6da2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052814-exponent-domestic-6da2@gregkh>

On Tue, May 28, 2024 at 09:23:43AM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 28, 2024 at 02:57:16PM +0900, Daehwan Jung wrote:
> > [Synopsys]- The host controller was design to support ERST setting
> > during the RUN state. But since there is a limitation in controller
> > in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> > It is supported when the ERSTBA is programmed in 64bit,
> > or in 32 bit mode ERSTBA_HI before ERSTBA_LO
> > 
> > [Synopsys]- The internal initialization of event ring fetches
> > the "Event Ring Segment Table Entry" based on the indication of
> > ERSTBA_LO written.

Also, what is the "[Synopsys]-" stuff?  That's not normally in our
changelogs or documentation for how to write a changelog text, is it?

thanks,

greg k-h

