Return-Path: <linux-kernel+bounces-365503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F58299E357
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E18D284190
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B9F1E2031;
	Tue, 15 Oct 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B9/4PfUx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF04C9F;
	Tue, 15 Oct 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986690; cv=none; b=ISHQ8qmFp/4mk7PZtrMc276fSPIpkJBVw1/N4kZOnbIr9PwQiLn0N5JubrXkv6S4N1QqdHHd+NWJZVTNJr2lq/6ruCVGzS/kDi4QN3hafob1iR7rIf/Z4XwXMdaJlEuVr5pPZc6DnxR3o4/FQbahBQ/0Q0ncenpvCn/mDpQ1uds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986690; c=relaxed/simple;
	bh=GKXCda1ZZZ/3cKQwDZh8j/F7Gfw9CYaYKJqzCvd1G80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXJdu4JrO1F16p9q4sO/mhNPW9NiO76JkOZm8wgk1tNr8fF0JX2pRWzWlL2lvh4a6EaW/cxuq7l+cv3cNw8M2CfJDWH/Vc4ZYbXueEm8AS2oQ0LIgkM2k+5oCTIPNj3W4hCWxc38Wn3YLLzdG6Zvv1tw6aufYQpFh9nEiWOlp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B9/4PfUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1972CC4CEC6;
	Tue, 15 Oct 2024 10:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728986689;
	bh=GKXCda1ZZZ/3cKQwDZh8j/F7Gfw9CYaYKJqzCvd1G80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B9/4PfUxf+bmxm7MgTUjzfLoMuFKnBVUHsad56i5jwHf8ewLV2+VRsILxzyfLOtwM
	 CcG8ySCsC5cGu5oXuoeisbSmIWy/Gf3IbAuWAbJYyHlLHJ+024KpiFWetDOrWZVGZO
	 Pih/nes9zNUeU/qgsrFD4BBmbNHMqVA3if5fc40A=
Date: Tue, 15 Oct 2024 12:04:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v4 5/9] misc: amd-sbi: Add support for mailbox error codes
Message-ID: <2024101541-domestic-steadily-6451@gregkh>
References: <20240912070810.1644621-1-akshay.gupta@amd.com>
 <20240912070810.1644621-6-akshay.gupta@amd.com>
 <2024101351-hash-deflate-b339@gregkh>
 <27148cde-29db-dc77-18af-2fe56dce036e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27148cde-29db-dc77-18af-2fe56dce036e@amd.com>

On Tue, Oct 15, 2024 at 02:42:08PM +0530, Gupta, Akshay wrote:
> On 10/13/2024 8:49 PM, Greg KH wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Thu, Sep 12, 2024 at 07:08:06AM +0000, Akshay Gupta wrote:
> > > --- a/include/uapi/misc/amd-apml.h
> > > +++ b/include/uapi/misc/amd-apml.h
> > > @@ -38,6 +38,10 @@ struct apml_message {
> > >                __u32 mb_in[2];
> > >                __u8 reg_in[8];
> > >        } data_in;
> > > +     /*
> > > +      * Error code is returned in case of soft mailbox
> > > +      */
> > > +     __u32 fw_ret_code;
> > >   } __attribute__((packed));
> > You can not just randomly change the size of a user/kernel structure
> > like this, what just broke because of this?
> > 
> > confused,
> 
> The changes are not because of anything is broken, we support 3 different
> protocol under 1 IOCTL using the same structure. I split the patch to make
> it easy to review.
> Modification in patch 4, is only for the existing code. This patch (patch 5)
> has additional functionality, so we do not want add multiple changes in
> single patch (patch 4).
> 
> The changes done in patches are as follows:
> 
> Patch 4:
> 
> - Adding basic structure as per current protocol in upstream kernel

So what if we only take the first 4 patches?  Now any changes after that
would change the user/kernel api and break things.

Please don't write changes and then "fix them up" later on, that's not
how to do stuff as it makes it very difficult to review.  What would you
want to see if _you_ had to review this patch series?

thanks,

greg k-h

