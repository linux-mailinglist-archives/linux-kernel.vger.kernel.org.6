Return-Path: <linux-kernel+bounces-326055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CE59761E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337D41F232C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1218BBBC;
	Thu, 12 Sep 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kPN8iEtc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CAE41C6A;
	Thu, 12 Sep 2024 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124027; cv=none; b=YiUE0h0IGo68JW/bmtoq1T0dhY/O2S23skXT5K+ejtwI8KWXgOQ/9uWLCIIvS3bo+a8KigriT/WkTYpLzq2GuyXOifD9ZSWl5zeU4A1EGxNySIoqjhzsEUnNrmD4JLqmTyP6q0c6KJDHCOmUXNXh98pY9wy7paPjoQ7eO1Y5JUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124027; c=relaxed/simple;
	bh=G3WchTtge4g6NnY60rIEF0UBsEDbkw6ExHhLMU1LGp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7H3DsS3qxG5cu75Fum3DqGZ+wa8eDD8C1x5bfyFAVo43g8VKHfJ+L/NQ/dXr1AwERwpD18WtALWYQDLY9qJKCdFWaEDbGgAMyV+cHC939O6jpfFpTX+n9+DSRLSGLkmyNkWpMGzivgHZPW5Os4ewWsHmgRqSGcLqXs9uhej0zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kPN8iEtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC75CC4CEC6;
	Thu, 12 Sep 2024 06:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726124027;
	bh=G3WchTtge4g6NnY60rIEF0UBsEDbkw6ExHhLMU1LGp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kPN8iEtcJi4JgkGvsD6Jzew7s1wgeT052p++QMBbNTZY8FoU5E3tC6jTOcRzf34hb
	 uUb3LGFnLHndlTq/doqyFf2yUnqdRH0RiN3tZxNfmHtJMEILPTPtxifHedUt017mI2
	 GZKgSUvzwKaSEGxdzF4VbAtG9CFk4kk4dOBgdves=
Date: Thu, 12 Sep 2024 08:53:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v4] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <2024091231-unarmored-deploy-c950@gregkh>
References: <20240906065853.637205-1-lk@c--e.de>
 <2024091156-astronomy-licorice-5569@gregkh>
 <ZuKFetxhrQY1L5fQ@cae.in-ulm.de>
 <CAA8EJpp3KMkZc3pArrgLcue-GbqLQjeOZ+9XWQDL0NeJxnfR+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpp3KMkZc3pArrgLcue-GbqLQjeOZ+9XWQDL0NeJxnfR+g@mail.gmail.com>

On Thu, Sep 12, 2024 at 09:21:39AM +0300, Dmitry Baryshkov wrote:
> On Thu, 12 Sept 2024 at 09:08, Christian A. Ehrhardt <lk@c--e.de> wrote:
> >
> >
> > Hi,
> >
> > On Wed, Sep 11, 2024 at 03:37:25PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Sep 06, 2024 at 08:58:53AM +0200, Christian A. Ehrhardt wrote:
> > > > If the busy indicator is set, all other fields in CCI should be
> > > > clear according to the spec. However, some UCSI implementations do
> > > > not follow this rule and report bogus data in CCI along with the
> > > > busy indicator. Ignore the contents of CCI if the busy indicator is
> > > > set.
> > > >
> > > > If a command timeout is hit it is possible that the EVENT_PENDING
> > > > bit is cleared while connector work is still scheduled which can
> > > > cause the EVENT_PENDING bit to go out of sync with scheduled connector
> > > > work. Check and set the EVENT_PENDING bit on entry to
> > > > ucsi_handle_connector_change() to fix this.
> > > >
> > > > Finally, check UCSI_CCI_BUSY before the return code of ->sync_control.
> > > > This ensures that the command is cancelled even if ->sync_control
> > > > returns an error (most likely -ETIMEDOUT).
> > > >
> > > > Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> > > > Bisected-by: Christian Heusel <christian@heusel.eu>
> > > > Tested-by: Anurag Bijea <icaliberdev@gmail.com>
> > > > Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > > > ---
> > > >  drivers/usb/typec/ucsi/ucsi.c | 18 ++++++++++++------
> > > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > >
> > > Does not apply to my usb-next branch :(
> > >
> > > Can you rebase and resend this?  Or wait until -rc1 is out and rebase
> > > and resend then?
> >
> > I sent a v5 rebased onto usb-next.
> 
> Note, it wasn't marked as v5, it didn't contain a changelog, etc.
> Please consider using the `b4` tool to send patches. It automates
> versioning, changelog generation, etc.

Yes, this needs to be properly marked as such, my patch-bot already
noticed that :(

