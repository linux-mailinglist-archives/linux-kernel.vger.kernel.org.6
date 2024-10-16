Return-Path: <linux-kernel+bounces-368332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FF49A0E67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A988DB26F87
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6992020E02C;
	Wed, 16 Oct 2024 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0FudREGR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6820F5BE;
	Wed, 16 Oct 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092894; cv=none; b=C2MRXkbdDDKSz4uoC7Lmvk05liR+A9PDWTGZsylhw19DZQrzLrovL9Bruvf2k99GxbQYwsoL7iYVxrnbRFIkxnDV42RAgvPpilhTwvWXZQI0ECUafqdyTT53VUMtUynL4WRPrzXlxtazd7Hefrt0vB3Y+MXHSPOGXMujNX0tEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092894; c=relaxed/simple;
	bh=ldDxxE0u4rnmPAX0/IHxWMliMSqQw0VIqdD/1UiKJT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpCDAsc5yjxY6FQ6sOk4Kd3+NSqFgmSSBMf9Zz3bbTweOCzM/W069fhoU7Fv/jPLgXrKj1N1jzPJyA+K362tmItDI6p/kjxZU/my8kZcQMLop1YKVvJdzXtJA96fbSiOlahcWTl0Wp+IDe44IYPpWdYFpZAHCSUXGTxdYoQhTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0FudREGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E54C4CECF;
	Wed, 16 Oct 2024 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729092894;
	bh=ldDxxE0u4rnmPAX0/IHxWMliMSqQw0VIqdD/1UiKJT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0FudREGRUd2rzyPN0/5W970s6LK11z9ifkNqs34QxtbmMbG1YdYTPOLLAkCsBDinY
	 NRl934RdVUFnjctnG8J33OJHQh98L94zP/Z6KNrpLrR4IgfW/PAByYbnTTceoMEaDF
	 y3IPEQZz+muP3qz9AwFqbQw3D8ka3ePA/FBN3RGU=
Date: Wed, 16 Oct 2024 17:34:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: oneukum@suse.com, colin.i.king@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: using mutex lock and supporting O_NONBLOCK flag
 in iowarrior_read()
Message-ID: <2024101654-kebab-pastrami-a6b8@gregkh>
References: <20240919103403.3986-1-aha310510@gmail.com>
 <CAO9qdTHgSwtaVfwzUYgSNX_3Yx=hmyYQnUb-OpP6k2u_gRZVGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9qdTHgSwtaVfwzUYgSNX_3Yx=hmyYQnUb-OpP6k2u_gRZVGg@mail.gmail.com>

On Wed, Oct 16, 2024 at 11:52:47PM +0900, Jeongjun Park wrote:
> Jeongjun Park <aha310510@gmail.com> wrote:
> >
> > iowarrior_read() uses the iowarrior dev structure, but does not use any
> > lock on the structure. This can cause various bugs including data-races,
> > so it is more appropriate to use a mutex lock to safely protect the
> > iowarrior dev structure. When using a mutex lock, you should split the
> > branch to prevent blocking when the O_NONBLOCK flag is set.
> >
> > In addition, it is unnecessary to check for NULL on the iowarrior dev
> > structure obtained by reading file->private_data. Therefore, it is
> > better to remove the check.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> 
> I think this patch should be moved to the usb-linus tree to be applied in the
> next rc version. iowarrior_read() is very vulnerable to a data-race because it
> reads a struct iowarrior without a mutex_lock. I think this almost certainly
> leads to a data-race, so I think this function should be moved to the
> usb-linus tree to be fixed as soon as possible.
> 
> I would appreciate it if you could review this.

Do you have this hardware to test this with?  What type of data race
will happen for a normal user of it?  What systems that have this
hardware allow untrusted users to operate this hardware?

thanks,

greg k-h

