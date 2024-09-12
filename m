Return-Path: <linux-kernel+bounces-326001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D3976107
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8013FB2245E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EDE1891D9;
	Thu, 12 Sep 2024 06:09:03 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E097654765;
	Thu, 12 Sep 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121342; cv=none; b=ISts4dylt0/HnWkk5gIxJijIjWibcOGKMYI4gXlw1Nhfe9I3nCpkHks2Wl0YWvzwwotDtqSoKTRxY6UQ3Rij4ELx4FKCgmCbu8WBzqRCG8CcYv4JwmI5jAQRwL18tf17NEg+BJqqUIIK6p2oGMaGUDhwdF2Dd903Xm7BLxfcIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121342; c=relaxed/simple;
	bh=FevOhKzsugQid8HT0NPGQLEbvHyB/3ayhZVlDswm1dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5ySjBAiUHXpZqfZ3fNd/xnlzM5hBMHjp/dR4RwJavb3GeV0QBu920wpWWDkSqx1JpkJYcCvmGB7z7RboELzT4YHcmjE/b/PxCLEv3qoXtJTvBOlSFj4ZH8mIqBxH66HcXrsxNqQgX9bFcS0R65tl65hxg8nRQqvkbk72m9dEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 28D3C140553; Thu, 12 Sep 2024 08:08:58 +0200 (CEST)
Date: Thu, 12 Sep 2024 08:08:58 +0200
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v4] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <ZuKFetxhrQY1L5fQ@cae.in-ulm.de>
References: <20240906065853.637205-1-lk@c--e.de>
 <2024091156-astronomy-licorice-5569@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091156-astronomy-licorice-5569@gregkh>


Hi,

On Wed, Sep 11, 2024 at 03:37:25PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 06, 2024 at 08:58:53AM +0200, Christian A. Ehrhardt wrote:
> > If the busy indicator is set, all other fields in CCI should be
> > clear according to the spec. However, some UCSI implementations do
> > not follow this rule and report bogus data in CCI along with the
> > busy indicator. Ignore the contents of CCI if the busy indicator is
> > set.
> > 
> > If a command timeout is hit it is possible that the EVENT_PENDING
> > bit is cleared while connector work is still scheduled which can
> > cause the EVENT_PENDING bit to go out of sync with scheduled connector
> > work. Check and set the EVENT_PENDING bit on entry to
> > ucsi_handle_connector_change() to fix this.
> > 
> > Finally, check UCSI_CCI_BUSY before the return code of ->sync_control.
> > This ensures that the command is cancelled even if ->sync_control
> > returns an error (most likely -ETIMEDOUT).
> > 
> > Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> > Bisected-by: Christian Heusel <christian@heusel.eu>
> > Tested-by: Anurag Bijea <icaliberdev@gmail.com>
> > Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> Does not apply to my usb-next branch :(
> 
> Can you rebase and resend this?  Or wait until -rc1 is out and rebase
> and resend then?

I sent a v5 rebased onto usb-next.

Best regards,
Christian

