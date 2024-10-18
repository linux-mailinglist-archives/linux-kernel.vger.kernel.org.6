Return-Path: <linux-kernel+bounces-371368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D91B9A3A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D032814D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767531F4FA9;
	Fri, 18 Oct 2024 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ApDJeSYv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A3192B86;
	Fri, 18 Oct 2024 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244143; cv=none; b=ij9wwKoROm6NEWANEr3WY7MVgQWJgnk5XNZEp7v5uv4c3hPEGDXR52OlP0ZelPrU1DwNuOFNvbcPnKml6sDtLsiDxCHxt3MZACMSumiLtHt/g65jUeM2YPuyOkqGHgfi6lA0g/G6MINNKroN9L3lUHMsB0pKv8PfBUK4eu8d9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244143; c=relaxed/simple;
	bh=mBm5UXS147lpNF9ltnx90LerAQQ1hhEWZy44zEqIz7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQM8qHVfi8L36/Ohp9NviNeC+TWz8Vk/6yw/rn4iItDIleUjH+krak7gBIcTEZoO7GCF3XrtN31/GVrtY8biq6+exTK3LSgFrFCqbxoGWaVbck0hFz+2LVHi1Gijy88INuNZBaZhCDrgn5/F552LGdXjnSYTg2Gl1bR5ey2c4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ApDJeSYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A24C4CEC3;
	Fri, 18 Oct 2024 09:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729244143;
	bh=mBm5UXS147lpNF9ltnx90LerAQQ1hhEWZy44zEqIz7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ApDJeSYvkPjavoMwh28gRoFk+8CF9I7jLA06bH95luzsphOalin64zJHkj4YXTJQD
	 KTkV/5Xi8ZtNqcVgi1VyKW4UZJXriI/Pwfcb5OI0Y689YWSDKOsNPlAB9RVfSkT6pJ
	 1yzX8itHvHLDsam1Sjf+gMTWy5iW0CV9ZPX6MBYY=
Date: Fri, 18 Oct 2024 11:35:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v4 5/9] misc: amd-sbi: Add support for mailbox error codes
Message-ID: <2024101854-twister-stem-e3e6@gregkh>
References: <20240912070810.1644621-1-akshay.gupta@amd.com>
 <20240912070810.1644621-6-akshay.gupta@amd.com>
 <2024101351-hash-deflate-b339@gregkh>
 <27148cde-29db-dc77-18af-2fe56dce036e@amd.com>
 <2024101541-domestic-steadily-6451@gregkh>
 <420ab0bf-32cf-cd98-c711-0dacc8bcc161@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420ab0bf-32cf-cd98-c711-0dacc8bcc161@amd.com>

On Fri, Oct 18, 2024 at 02:53:26PM +0530, Gupta, Akshay wrote:
> 
> On 10/15/2024 3:34 PM, Greg KH wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Tue, Oct 15, 2024 at 02:42:08PM +0530, Gupta, Akshay wrote:
> > > On 10/13/2024 8:49 PM, Greg KH wrote:
> > > > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > > > 
> > > > 
> > > > On Thu, Sep 12, 2024 at 07:08:06AM +0000, Akshay Gupta wrote:
> > > > > --- a/include/uapi/misc/amd-apml.h
> > > > > +++ b/include/uapi/misc/amd-apml.h
> > > > > @@ -38,6 +38,10 @@ struct apml_message {
> > > > >                 __u32 mb_in[2];
> > > > >                 __u8 reg_in[8];
> > > > >         } data_in;
> > > > > +     /*
> > > > > +      * Error code is returned in case of soft mailbox
> > > > > +      */
> > > > > +     __u32 fw_ret_code;
> > > > >    } __attribute__((packed));
> > > > You can not just randomly change the size of a user/kernel structure
> > > > like this, what just broke because of this?
> > > > 
> > > > confused,
> > > The changes are not because of anything is broken, we support 3 different
> > > protocol under 1 IOCTL using the same structure. I split the patch to make
> > > it easy to review.
> > > Modification in patch 4, is only for the existing code. This patch (patch 5)
> > > has additional functionality, so we do not want add multiple changes in
> > > single patch (patch 4).
> > > 
> > > The changes done in patches are as follows:
> > > 
> > > Patch 4:
> > > 
> > > - Adding basic structure as per current protocol in upstream kernel
> > So what if we only take the first 4 patches?  Now any changes after that
> > would change the user/kernel api and break things.
> 
> Yes, it will break. We need all the patches to go.

That's not how to submit a patch series.  Please work with the other
kernel developers at your company to do this right before resubmitting.
You shouldn't rely on the community to point out basic engineering
problems like this.  Would you want to review a series like this?

> > Please don't write changes and then "fix them up" later on, that's not
> > how to do stuff as it makes it very difficult to review.  What would you
> > want to see if _you_ had to review this patch series?
> 
> We submitted a single patch in v1, later split the patch based on each
> functionality for ease of review.
> 
> I will squash and submit along with other review comments addressed.

No, don't squash, do it in a patch series, one at a time properly such
that if we were to take any moment in time of the series, all would
still work correctly.  That's the proper way to do any sort of software
engineering, this isn't unique to us at all.

thanks,

greg k-h

