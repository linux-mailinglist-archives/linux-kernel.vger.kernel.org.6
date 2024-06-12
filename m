Return-Path: <linux-kernel+bounces-211600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A66905437
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99B61F2556F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8AC17E464;
	Wed, 12 Jun 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XItuXSJ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320D17D8BC;
	Wed, 12 Jun 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200356; cv=none; b=UJg6vV7F6dIQeTOCBIuVCVCrFV+fvF9tWG8G/pKgza4g96brJa1Wisw6Lj7vpnzidqWHRBSWoxZmHixGx4PLfV7m/TGNe7/q9macB6++SHQLgD5fC1RFPoeOxdTTTB7nuh3HIJpKJdZj0WrZ2c79IV+pK8Zkgd9SpKQx6gUk+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200356; c=relaxed/simple;
	bh=v5+9aEh/+pFUL2JW5D8sLUBK0VBMLPjRr38po5B++UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T84A6Kl61Hy89kL9gQ6lybRFamh6vq1+oc5VF67tAsCuXdeKQJscK8/y+deNqXXBGHXrieUxgMaE6ijppzG0FVNW1po2voXnP9A/qKsHdLPNT0Av9FmHdVsWptVBvNCgl0wdd1cvmHiNCMwgP2i9VSP8LlOd/4KG0ZNVA9xglZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XItuXSJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35057C116B1;
	Wed, 12 Jun 2024 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718200355;
	bh=v5+9aEh/+pFUL2JW5D8sLUBK0VBMLPjRr38po5B++UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XItuXSJ9bGwNqyhVtOBhCc5LBIb1n4LqefzkJQKBy5gBrW+Mu+krOsztJH4dcV2Xq
	 TYpP1nEiKIkrT7/E4UzqSd0jX2T8kYRy9vigtrrjTMbAShBYlaQF4M8+QvO2NPAWav
	 iMUPZ3lD0FyvWuW9doXTLbib/w5p2HmKrtj7MChw=
Date: Wed, 12 Jun 2024 15:52:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: joswang <joswang1221@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v3, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024061226-luminous-veneering-904d@gregkh>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240611142953.12057-1-joswang1221@gmail.com>
 <2024061219-reroute-strike-7230@gregkh>
 <CAMtoTm2tUDD-CCs4wqigx9ZNqHjWUCA_F080i+v55vubu8wtmQ@mail.gmail.com>
 <2024061254-oval-womb-a6c1@gregkh>
 <CAMtoTm0DtH=pi_20UibBjea1P5OkfKP3eY3G5s_Ta4pks0M3Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMtoTm0DtH=pi_20UibBjea1P5OkfKP3eY3G5s_Ta4pks0M3Lw@mail.gmail.com>

On Wed, Jun 12, 2024 at 09:39:47PM +0800, joswang wrote:
> On Wed, Jun 12, 2024 at 8:56 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 12, 2024 at 08:47:31PM +0800, joswang wrote:
> > > On Wed, Jun 12, 2024 at 3:58 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Jun 11, 2024 at 10:29:53PM +0800, joswang wrote:
> > > > > From: Jos Wang <joswang@lenovo.com>
> > > > >
> > > > > This is a workaround for STAR 4846132, which only affects
> > > > > DWC_usb31 version2.00a operating in host mode.
> > > > >
> > > > > There is a problem in DWC_usb31 version 2.00a operating
> > > > > in host mode that would cause a CSR read timeout When CSR
> > > > > read coincides with RAM Clock Gating Entry. By disable
> > > > > Clock Gating, sacrificing power consumption for normal
> > > > > operation.
> > > > >
> > > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > > > ---
> > > > > v1 -> v2:
> > > > > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch
> > > > > v2 -> v3:
> > > > > - code refactor
> > > > > - modify comment, add STAR number, workaround applied in host mode
> > > > > - modify commit message, add STAR number, workaround applied in host mode
> > > > > - modify Author Jos Wang
> > > > > ---
> > > > >  drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
> > > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > >
> > > > Where are patches 1/3 and 2/3 of this series?
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > Patches 1/3 and 2/3 are other cases. The maintainer is reviewing them
> > > and has no accurate conclusion yet, so only patches 3/3 are submitted.
> >
> > How are we supposed to know this?  A patch series should be taken all at
> > once, right?
> >
> > confused,
> >
> > greg k-h
> 
> I am very sorry, I misunderstood the patch series before. How should I
> deal with this patch now? Should Patches 1/3 and 2/3 also be
> submitted?

Yes please.

