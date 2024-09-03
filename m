Return-Path: <linux-kernel+bounces-312483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9CE969737
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7671F24D3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD242139DB;
	Tue,  3 Sep 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mVVsaAFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B911C62A5;
	Tue,  3 Sep 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352544; cv=none; b=aKAJfBPpyoQ3tG48ANt2Nke+sY7ttjKGjHrXrOHUMyqXDNT3pJxb1UeFiPv1GfjY9/FBDZIMnxgkq/Gljrv/ga4maXrPPWvmp/NxEdHme50b8zcCHKdv28BXuGAX8ia56K6a/92vYikGa2yhpIB+l0XJ2fgXn/m2sOfbRCT3oIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352544; c=relaxed/simple;
	bh=eMX34s/UN22vBqEF5qgq9vrGs2Bmo42wLbjPlzo0Fsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n31UJmi4gzqr4BW8qEfsOXwhJACzfUYyimMkr33nxlCcEyzv+ZdusZa57Pvf915lXCOIrk6kik2Wjkpy/foUwpyuI3nq0hNOOcZhVj/cc30upIYzbWuHDyvaRUpdZhtQBF8bMnS92+arX8/9hhzu8duyRH9UyNjtfW2+L9y350M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mVVsaAFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B3FC4CEC5;
	Tue,  3 Sep 2024 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725352543;
	bh=eMX34s/UN22vBqEF5qgq9vrGs2Bmo42wLbjPlzo0Fsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVVsaAFxrDBvavaOskaEEDzguZgbyat2NktSTvPpuFlh0kOAmx7H4/ibK9t3rHWT1
	 IHgKhSfQmWyoGqXmeIXksqlBOZ5f5dCEUeVtHSd8fysVs8eChgQYvEeOl1DzD7mGyU
	 ncSYg5Kgkcf/tq8AFoe7rk3FI01FPP/8q4YUwXgo=
Date: Tue, 3 Sep 2024 10:35:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: changed geoid data type from int to
 u32
Message-ID: <2024090325-amusing-sauna-1a74@gregkh>
References: <20240830051807.4397-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830051807.4397-1-riyandhiman14@gmail.com>

On Fri, Aug 30, 2024 at 10:48:07AM +0530, Riyan Dhiman wrote:
> Geoid is a module parameter which is set by root user.
> Its valid values are between 0 and VME_MAX_SLOTS. So, changing data type
> of geoid from int to u32 since it will always be positive.
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
>  drivers/staging/vme_user/vme_fake.c   | 6 +++---
>  drivers/staging/vme_user/vme_tsi148.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

