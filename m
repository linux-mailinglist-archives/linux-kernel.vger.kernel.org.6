Return-Path: <linux-kernel+bounces-369211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C799A1A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD89B1C21487
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0098F18562F;
	Thu, 17 Oct 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rns/YnTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB717580;
	Thu, 17 Oct 2024 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144880; cv=none; b=ORXekI5iIV8akp+2j+m+9xAlNvXQGVRX3mIg72O6M1G5HXrG5toS46we6xUg3NILnAcQvJk/qdvbyPmDDxL4WjYTb7mPY5rq/L29d5+yeW/xXEkYIyVDZG/CZ+6S1KPl2JFO3vk5vUAkzDcSydiYYlNO9hhNglIH7uTwzs28ItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144880; c=relaxed/simple;
	bh=K5Hm/Zu/1gdRfg+T828oIpOrJ7LwddBypXCFr+jRQ7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmN6XYmpZE7CCorWX4xL9uOAU7LPvQrmp/2igz1KsHxRQqClw2VGcIIFuxtLe5y3WNV3jVpWTN315RQhcEw8r1zxW+NNvJFkvwvhaYuIBEBtnihj1fLkujyb62Bs1is083EfevPuU6qNvKx1xKP1OPIEmhdsEv6xkN6XeuEp6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rns/YnTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B931C4CECD;
	Thu, 17 Oct 2024 06:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729144878;
	bh=K5Hm/Zu/1gdRfg+T828oIpOrJ7LwddBypXCFr+jRQ7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rns/YnTyogXVCiVqMFu81EgESBYSW7q/OH9sNhPmbGy1g/ZgPoCrJBGy96qu79HdY
	 svSpXwh8Ay1vEiOou2H61xQ5cpjfh/a4MMG6rPxoKSwJRHhUOwQsXTpDCc1Ox1yf72
	 4kgGwj9MawNlyQgdEBrCybmwyXY2mc2cIpyXgVYw=
Date: Thu, 17 Oct 2024 08:01:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: dpenkler@gmail.com, skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] staging: gpib: Remove a dead condition in if statement
Message-ID: <2024101749-refocus-making-51b2@gregkh>
References: <20241016075319.4092-1-everestkc@everestkc.com.np>
 <2024101654-jasmine-ransack-7190@gregkh>
 <CAEO-vhGuJUdbBhchbga33TNWvZXTXHWbd4=M8xeWkHAi1rnw2g@mail.gmail.com>
 <2024101625-activate-gluten-3547@gregkh>
 <CAEO-vhGM8_x4Teqt7D8d=3KJcLPAgd2rWpkEDsZw=h0cS_7BLQ@mail.gmail.com>
 <CAEO-vhFtFu806Ls8p3vZhVP9yE-B23Lkht65ghHHojCcumBWSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEO-vhFtFu806Ls8p3vZhVP9yE-B23Lkht65ghHHojCcumBWSg@mail.gmail.com>

On Wed, Oct 16, 2024 at 10:42:03PM -0600, Everest K.C. wrote:
> On Wed, Oct 16, 2024 at 8:50 PM Everest K.C. <everestkc@everestkc.com.np> wrote:
> >
> > On Wed, Oct 16, 2024 at 9:12 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 06:54:00AM -0600, Everest K.C. wrote:
> > > > On Wed, Oct 16, 2024 at 2:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, Oct 16, 2024 at 01:53:18AM -0600, Everest K.C. wrote:
> > > > > > The variable `residue` is an unsigned int, also the function
> > > > > > `fluke_get_dma_residue` returns an unsigned int. The value of
> > > > > > an unsigned int can only be 0 at minimum.
> > > > > > The less-than-zero comparison can never be true.
> > > > > > Fix it by removing the dead condition in the if statement.
> > > > > >
> > > > > > This issue was reported by Coverity Scan.
> > > > > > Report:
> > > > > > CID 1600782: (#1 of 1): Macro compares unsigned to 0 (NO_EFFECT)
> > > > > > unsigned_compare: This less-than-zero comparison of an unsigned value
> > > > > > is never true. residue < 0U.
> > > > > >
> > > > > > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > > > > > ---
> > > > > > V1 -> V2: - Fixed typo of comparison in changelog
> > > > > >           - Removed Fixes tag
> > > > > >
> > > > > >  drivers/staging/gpib/eastwood/fluke_gpib.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > > > > index f9f149db222d..51b4f9891a34 100644
> > > > > > --- a/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > > > > +++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
> > > > > > @@ -644,7 +644,7 @@ static int fluke_dma_read(gpib_board_t *board, uint8_t *buffer,
> > > > > >        */
> > > > > >       usleep_range(10, 15);
> > > > > >       residue = fluke_get_dma_residue(e_priv->dma_channel, dma_cookie);
> > > > > > -     if (WARN_ON_ONCE(residue > length || residue < 0))
> > > > > > +     if (WARN_ON_ONCE(residue > length))
> > > > >
> > > > > No, this is incorrect, now we never notice is the call to
> > > > > fluke_get_dma_residue() has failed.  Please fix that bug instead (hint,
> > > > > Covertity is giving you a pointer to where something might be wrong, but
> > > > > this change is NOT how to fix it.)
> > > > I need a little guidance here.
> > > > My best guess to fix the bug would be to make fluke_get_dma_residue()
> > > > return an int instead of unsigned int or size_t. But theoretically the
> > > > maximum value of residue can be UINT_MAX, and casting it to int will
> > > > result in a negative number, which in turn will cause  the error check
> > > > condition to evaluate to true.
> > >
> > > Look at the code to see what it does.
> > >
> > > > The best solution I see would be to make fluke_get_dma_residue() return
> > > > an int (-1 for error and 0 for success). Then pass the address of residue
> > > > reference to fluke_get_dma_residue() to be updated.
> > > > Am I on the right track ?
> > >
> > > Close, yes.  "-1" is not a valid error, so that needs to be fixed at the
> > > least here, as it's obviously not returning an error that gets caught
> > > today :)
> > Noted. Thank you very much.
> > I have a question though. Since, the file I had previously fixed (which
> > was incorrect) and the file I now need to fix are different. Should I create
> > a new patch that would be of version 1, or should I send a V2 ?
> Oops, it's in the same file but my question still stands, should I send a new
> patch or V2 revision ?

Probably a new patch if it has a totally different subject line.

thanks,

greg k-h

