Return-Path: <linux-kernel+bounces-325050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5725097543A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899AD1C22AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0860319E970;
	Wed, 11 Sep 2024 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BwV6i4SP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83826AC1;
	Wed, 11 Sep 2024 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061848; cv=none; b=VORbhWH/Ujofsi70+D7U9rJNNmbQ0/yPgfmzYLwCEQVbPAaRVxUx6KQdUdGpv5HXGHL4YGk1ZDCFTv7q5WZOHKdaTWoByqb4oSRj+HWAa5MhCr6UwPUU1ZYmUHSBfV3INklhlAH7A6SetcYaG8/aIRFWmzAovyp/ap/Lt3hLNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061848; c=relaxed/simple;
	bh=/5IXdQxAagGO8BlbHVY6pj4+XODBeSm3L4HavkX4dlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOx+B/LLGtIi0+V4zAgdRcHWGf05h6WMvIi9ErsNzwpFpUKlf6HIlDOU6lOp//I0eKI0RStVT6HNR9Kqp+XLl+pn8I4BBbMwHdgHdUO0vkbVXTs70PtApH+AGDYCJdP1T9+UwGALbwmNFfWFXR/jCgRNWwsbe4MH5YKLvKvV6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BwV6i4SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87920C4CEC5;
	Wed, 11 Sep 2024 13:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726061847;
	bh=/5IXdQxAagGO8BlbHVY6pj4+XODBeSm3L4HavkX4dlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwV6i4SPqUki7IZr0hQueEIXdBUKx2QRrY2Pplpt6PW8WkUX9uSkiNTvaiuiY8dR6
	 MDc5vo82ZEi9lgnWFS3A90oGiFTKMUJHMKCH5HqwzRzj7zZZ80tT332Bv0v88Jr5+5
	 /sxqb+GKv9ZzvQOI7Wwp9ahW5OvVmoH6JkQ09dJ4=
Date: Wed, 11 Sep 2024 15:37:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v4] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <2024091156-astronomy-licorice-5569@gregkh>
References: <20240906065853.637205-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906065853.637205-1-lk@c--e.de>

On Fri, Sep 06, 2024 at 08:58:53AM +0200, Christian A. Ehrhardt wrote:
> If the busy indicator is set, all other fields in CCI should be
> clear according to the spec. However, some UCSI implementations do
> not follow this rule and report bogus data in CCI along with the
> busy indicator. Ignore the contents of CCI if the busy indicator is
> set.
> 
> If a command timeout is hit it is possible that the EVENT_PENDING
> bit is cleared while connector work is still scheduled which can
> cause the EVENT_PENDING bit to go out of sync with scheduled connector
> work. Check and set the EVENT_PENDING bit on entry to
> ucsi_handle_connector_change() to fix this.
> 
> Finally, check UCSI_CCI_BUSY before the return code of ->sync_control.
> This ensures that the command is cancelled even if ->sync_control
> returns an error (most likely -ETIMEDOUT).
> 
> Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> Bisected-by: Christian Heusel <christian@heusel.eu>
> Tested-by: Anurag Bijea <icaliberdev@gmail.com>
> Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Does not apply to my usb-next branch :(

Can you rebase and resend this?  Or wait until -rc1 is out and rebase
and resend then?

thanks,

greg k-h

