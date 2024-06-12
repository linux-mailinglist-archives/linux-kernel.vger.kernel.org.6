Return-Path: <linux-kernel+bounces-211523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D6990530B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA6E1C20BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DF3176AD4;
	Wed, 12 Jun 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OadiCEKi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA55176242;
	Wed, 12 Jun 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196975; cv=none; b=a0VD/4dlIEayVs9fM0s2TwJzp3uB0kXIxXS6FfNo7umBcr/AAqYOHWP0cfMXwAxeT7DWlKW0XU5xcESdWRcDn8cyVbHYQCAOatj/KCdTicWDEdSNP0x06xVIseQt2aXtSGVYm069k6j62f2g0/lEnTPAxKrqqH1paQYUv/hueG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196975; c=relaxed/simple;
	bh=vC9PIDpzXrCacBIhJJgdsjD8Um8Uxd7/bCl31OF839E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIeOsHixNauIY5OaAlkqvlK1uPJD4s2rj6gDPxlVGKtj+kqzy2gNfrmmRlhwSz7ELsMAihpwWubAIvwLQn2uAzAVdSrShYaZ57TzW75PZkVB2UrXuwmdmYsTTL84RXvlqpD8v7aEBurhQFhRSjPaciTF9NkCI7zsH704PuYU+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OadiCEKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F60C3277B;
	Wed, 12 Jun 2024 12:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196975;
	bh=vC9PIDpzXrCacBIhJJgdsjD8Um8Uxd7/bCl31OF839E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OadiCEKiy1nMfAnYMcuXaWH/gBTgDvDBGujMq8dCw898nXDbdoxFSZhhWuGc6pseQ
	 EOS3yfJSzX596GINM4CuPqMNWFLpTBWmcPBXM3g02tVh7r9pxpyLErybWbCWUqPXoV
	 NL8jLLNQ5JDfDeh/agrcK/IVWoZBSqyF+mtHPdzo=
Date: Wed, 12 Jun 2024 14:56:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: joswang <joswang1221@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v3, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024061254-oval-womb-a6c1@gregkh>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240611142953.12057-1-joswang1221@gmail.com>
 <2024061219-reroute-strike-7230@gregkh>
 <CAMtoTm2tUDD-CCs4wqigx9ZNqHjWUCA_F080i+v55vubu8wtmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMtoTm2tUDD-CCs4wqigx9ZNqHjWUCA_F080i+v55vubu8wtmQ@mail.gmail.com>

On Wed, Jun 12, 2024 at 08:47:31PM +0800, joswang wrote:
> On Wed, Jun 12, 2024 at 3:58 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 11, 2024 at 10:29:53PM +0800, joswang wrote:
> > > From: Jos Wang <joswang@lenovo.com>
> > >
> > > This is a workaround for STAR 4846132, which only affects
> > > DWC_usb31 version2.00a operating in host mode.
> > >
> > > There is a problem in DWC_usb31 version 2.00a operating
> > > in host mode that would cause a CSR read timeout When CSR
> > > read coincides with RAM Clock Gating Entry. By disable
> > > Clock Gating, sacrificing power consumption for normal
> > > operation.
> > >
> > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > ---
> > > v1 -> v2:
> > > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch
> > > v2 -> v3:
> > > - code refactor
> > > - modify comment, add STAR number, workaround applied in host mode
> > > - modify commit message, add STAR number, workaround applied in host mode
> > > - modify Author Jos Wang
> > > ---
> > >  drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > Where are patches 1/3 and 2/3 of this series?
> >
> > thanks,
> >
> > greg k-h
> 
> Patches 1/3 and 2/3 are other cases. The maintainer is reviewing them
> and has no accurate conclusion yet, so only patches 3/3 are submitted.

How are we supposed to know this?  A patch series should be taken all at
once, right?

confused,

greg k-h

