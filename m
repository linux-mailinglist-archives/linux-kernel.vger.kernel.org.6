Return-Path: <linux-kernel+bounces-187051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FFF8CCC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E940628399C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B4113C672;
	Thu, 23 May 2024 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bl8JF7RO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410B1869;
	Thu, 23 May 2024 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445916; cv=none; b=K2bo35jMM4mH5lYWpdEEcC8smeJukBB4outwOld4waGvJehlCWhB3dckoP3nqEuMVbUecZhBXM75d3B3i4JY2ViPcpANOuZMKOyni259JDKKNIsPiFtsNij43ZFQ2FCVci9YBuCUhXMEby6/f0RvyXtyLgGDg/DWrGoOaMij6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445916; c=relaxed/simple;
	bh=o+/cvrJE76RZcQYv9bvFvctskXTaIx6Tfj38u9fplMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/uh4xlcNFU5/0ZsomEbo52EE1H3u70JNV/f8JD/d+nBh0Wp93ZFIPKZrLyqFMGEnrG7DBqFyStW9EtmJJJaPXyp9H3gVfg8iEzLeaf3NP7kIbh+Dailqh1HWRiuvTvYDWWU68ggWmh7l+PXR7mdM7mmVH9UbGPVJB/FgS1QKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bl8JF7RO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A365BC2BD10;
	Thu, 23 May 2024 06:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716445916;
	bh=o+/cvrJE76RZcQYv9bvFvctskXTaIx6Tfj38u9fplMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bl8JF7ROdvbbOaly//hU3B3zSJy+GOWSaNFEAMjhY87o8cMhHqWwGXTucuejT9gJ3
	 lZpqavbh74Q+Za632mZ82f1dv08YRa63RK4oy0yn/5VAmLoRwrX3Dep1kkyWeKaNts
	 RvpkHISzVC1PNvnWqPzZnXSzj40HEu59YXe0spgM=
Date: Thu, 23 May 2024 08:31:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shichao Lai <phyhac@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: divide error in alauda_transport
Message-ID: <2024052315-dwelled-unframed-db34@gregkh>
References: <CAEk6kZszgHVYN8r-AsPw9YtGGf459j0uDMYLdOoTixhE3YJCKw@mail.gmail.com>
 <2024052224-motion-perish-82cd@gregkh>
 <CAEk6kZt4qcV0xUxHFRp3DTdZ0f_3fLE0q4e_AWHGyjba=19g9g@mail.gmail.com>
 <CAEk6kZsgEJNSmFFe-tdA+RhM=+Pjm=JvHiNJ4QjZONPXHt-gjw@mail.gmail.com>
 <2024052242-hunter-exception-930c@gregkh>
 <CAEk6kZsLqJ5RbWYMrcbB+LkRq8jzRgTm3F8kq8FKB14y8ST2GQ@mail.gmail.com>
 <b82e133a-62a3-4f23-9803-1af79b06b8f4@rowland.harvard.edu>
 <CAEk6kZsgMscqmSgsvt9d=z7e69ZGuJAfLuYOV7E6jXJKr+n3Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEk6kZsgMscqmSgsvt9d=z7e69ZGuJAfLuYOV7E6jXJKr+n3Pg@mail.gmail.com>

On Thu, May 23, 2024 at 11:26:48AM +0800, Shichao Lai wrote:
> 在2024年5月23日星期四 UTC+8 03:59:30<Alan Stern> 写道：
> 
> > On Wed, May 22, 2024 at 06:01:57PM +0800, Shichao Lai wrote:
> > > Thanks for your patience. I am a beginner and initially attempted to
> > report
> > > errors to the community.
> > > However, I have just discovered that the issue mentioned above has
> > already
> > > been proposed in the previous three months of the article, and there is
> > an
> > > ongoing discussion.
> >
> > To call the discussion "ongoing" is optimistic. There hasn't been any
> > reply to my last post, which was made on March 17, more than two months
> > ago.
> >
> > Maybe you can carry out the tests I described in that post. That
> > would be a big help.
> >
> > Alan Stern
> >
> > > I think this post can be closed later.
> > >
> > > https://groups.google.com/g/syzkaller-bugs/c/m8CuxSpLKoQ/m/JfUy1xGnAwAJ
> > >
> > > Greg Kroah-Hartman <gre...@linuxfoundation.org
> > <https://groups.google.com/>> 于2024年5月22日周三 16:59写道：
> > >
> > > > On Wed, May 22, 2024 at 04:22:18PM +0800, Shichao Lai wrote:
> > > > > patch like this:
> > > > > ```c
> > > > > while (sectors > 0) {
> > > > > if (!uzonesize) {
> > > > > return USB_STOR_TRANSPORT_ERROR;
> > > > > }
> > > > > unsigned int zone = lba / uzonesize; /* integer division */
> > > > > unsigned int lba_offset = lba - (zone * uzonesize);
> > > > > unsigned int pages;
> > > > > ```
> > > >
> > > > Please submit this properly and we will be glad to review it.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > >
> 
> 
> 
> Hello Dear Maintainer!
> I found the same divide error yestoday as
> https://groups.google.com/g/syzkaller-bugs/c/m8CuxSpLKoQ
> And I add a patch before drivers/usb/storage/alauda.c:950 in
> alauda_read_data().
> The true cause of this error is that the variable uzonesize may be set to 0.
> Here is my patch:
> ===========
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 115f05a6201a..fb54af37efd5 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -947,6 +947,9 @@ static int alauda_read_data(struct us_data *us,
> unsigned long address,
>         sg = NULL;
> 
>         while (sectors > 0) {
> +               if (!uzonesize) {
> +                       return USB_STOR_TRANSPORT_ERROR;
> +               }
>                 unsigned int zone = lba / uzonesize; /* integer division */
>                 unsigned int lba_offset = lba - (zone * uzonesize);
>                 unsigned int pages;
> 


Great! Can you turn this into a real patch and send it to us so that we
can apply it properly?  Directions for how to do so are in the
Documentation/process/submitting_patches file.

thanks,

greg k-h

