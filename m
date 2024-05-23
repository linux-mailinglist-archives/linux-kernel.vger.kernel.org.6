Return-Path: <linux-kernel+bounces-187480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B58CD25C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCE41F2135B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9961148835;
	Thu, 23 May 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KcGE+YTA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E314532F;
	Thu, 23 May 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467841; cv=none; b=S4fMVWAsXA8OyuIoegjMynLaJixQnIYM/8QSNi4QI1dRyYTl8NSxVA9jifSXLqlwig6rb2+7BgQZP5ifcieS22aemiSSR3Zy8VzQkPlCd8dM/njKULisvn91DUPvj9Yo5AqXL9OO4///TunKOTaAOg5LTxF9Jy7g+F8FjN/uKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467841; c=relaxed/simple;
	bh=o+cIsFagOQT2Q33MTrnnLdxWh5QXIRSFcQAPjiLDD0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzdDESExPY4S4RtqG6tbnGwJiCdC+/Hz3G7Lv9o7MS6heRzS8Lc85e413ztpzoLOGofZbs1PQOHsQ+YNpkYpRVy5OgShM91S0arCBwPUDMi8MEd/TTC7eRarD2gjC6d25x/eK1LEv2zzylQ1PXsbJnDrbc2NvKo0LfKfXuuOFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KcGE+YTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9ECC2BD10;
	Thu, 23 May 2024 12:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716467840;
	bh=o+cIsFagOQT2Q33MTrnnLdxWh5QXIRSFcQAPjiLDD0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcGE+YTAH4DiNSX1KL56t0ozxuwvELpqo4VkZZaTeDQBO44KZfSn0Q979gtVmbVFB
	 NX73obibt80jeLyvLB7MieFgC+hOKMDeVdIEPZd6OKaC8T2G18B9m4/nutHTNsjLy8
	 12xmviuwtED6AiOFESaXpBnHJmPScUqT6uI5hUCk=
Date: Thu, 23 May 2024 14:37:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: shichao lai <shichaorai@gmail.com>
Cc: oneukum@suse.com, stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v2] usb-storage: Check whether divisor is non-zero before
 division
Message-ID: <2024052354-snorkel-drainer-d328@gregkh>
References: <20240523113410.983875-1-shichaorai@gmail.com>
 <2024052351-demote-gangly-74b0@gregkh>
 <CACjpba7k2+GS3c+NGgOeP=9=DU8Mh1DFEGUB_WAkX_VFKBBtrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACjpba7k2+GS3c+NGgOeP=9=DU8Mh1DFEGUB_WAkX_VFKBBtrA@mail.gmail.com>

On Thu, May 23, 2024 at 08:23:57PM +0800, shichao lai wrote:
> On Thu, May 23, 2024 at 7:47 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, May 23, 2024 at 07:34:10PM +0800, Shichao Lai wrote:
> > > Since uzonesize may be zero, so judgements for non-zero
> > > are necessary in both place.
> > >
> > > Changes since v1:
> > > - Add one more check in alauda_write_lba().
> > > - Move check ahead of loop in alauda_read_data().
> >
> > Nit, this changes list should go below the --- line, as the
> > documentation asks for.
> 
> Sorry for my inexperience. I have read the document and found some
> examples but I am still a little confused about this.
> I guess this is what you mean?
> 
> Since uzonesize may be zero ... (context)
> 
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Signed-off-by: Shichao Lai <shichaorai@gmail.com>
> ---
> Changes since v1:
> - Add one more check in alauda_write_lba().
> - Move check ahead of loop in alauda_read_data().

Yes.

> 
>  drivers/usb/storage/alauda.c | 4 ++++
>  1 file changed, 4 insertions(+)
> ...
> 
> 
> 
> > Check after the list of variables please, not in the middle of them.  I
> > think checkpatch will complain about this, right?
> 
> In fact this script doesn't warn about these problems, but I will
> adjust my code style later.
> But the check in alauda_write_lba() is due to some variable like
> lba_offset and zone will perform modulo and divide operations,
> which may throw divide errors when uzonesize is 0.
> So I think I prefer to adjust the order of the variable list later.
> Changes like this.
> ```c
> unsigned int uzonesize = MEDIA_INFO(us).uzonesize;
> unsigned int zonesize = MEDIA_INFO(us).zonesize;
> unsigned int pagesize = MEDIA_INFO(us).pagesize;
> unsigned int blocksize = MEDIA_INFO(us).blocksize;
> unsigned int new_pba_offset;
> if (!uzonesize)
>     return USB_STOR_TRANSPORT_ERROR;
> unsigned int lba_offset = lba % uzonesize;
> unsigned int zone = lba / uzonesize;
> ```
> If it's ok, I will post the patch v3 soon.

That works, thanks!

greg k-h

