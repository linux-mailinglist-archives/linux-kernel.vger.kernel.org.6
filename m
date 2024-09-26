Return-Path: <linux-kernel+bounces-340446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26941987386
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB80828265E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4790C17DFE3;
	Thu, 26 Sep 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HBVkRqJ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8975214B94F;
	Thu, 26 Sep 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353515; cv=none; b=bfIwT7VbXjzmsTVQnXYFxa0gutoatlm7LONLVH4XLFz6yZ0bQl/FyT9b8EfELg9EurSKfq62sNU5qnPIk3xQK6JUz/0KGPvISlQFcek5qrcvewkLLQ+Tm3O7zGBC2/p5M8ldGEq9ubNzUmuElldSlz9ov7LhuZIrOTxr1ifNS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353515; c=relaxed/simple;
	bh=ptQLa6NUscyq7HMtCZsIPnYiLZ2+UzgxKck4gLzgMcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZH1wrpxIF0Ivv8BdqeF23YRDg2/7vuCvaBngueKAvBe+sZxpNhBfibK1nrmP8xZyFIWTqFCKqbXoJDhYNHBR2oEX/WpkdH2oS7jQL13eCgorBeb4KmSUmFwFZ28UkLeEDaLsjbamNPqA9jJl56jnRW2ic4ht4bDTNjsmoqdJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HBVkRqJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D125C4CEC5;
	Thu, 26 Sep 2024 12:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727353515;
	bh=ptQLa6NUscyq7HMtCZsIPnYiLZ2+UzgxKck4gLzgMcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBVkRqJ5MGHkZlqaVer1kujjAiU5Huvu1ajepO6A0gpXOHB9glcdvF+fl+Z+UvHCC
	 Vwq+7jzO4sj7VqLjcLOAEHPSkIph6o4qyCoszL6BYsAITQy+JneWevTTJJ8Qm1USx3
	 DK/KyeMB6hj1DOasxze3ZKSL7gSC1wX5QRdAJIS4=
Date: Thu, 26 Sep 2024 14:25:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hubert =?utf-8?Q?Buczy=C5=84ski?= <hubert.buczynski94@gmail.com>
Cc: Prashanth K <quic_prashk@quicinc.com>, balbi@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	"hubert.buczynski" <Hubert.Buczynski.ext@feig.de>
Subject: Re: [PATCH] usb: gadget: u_serial: fix null-ptr-deref in gs_start_io
Message-ID: <2024092656-retorted-shelter-e7b1@gregkh>
References: <20240926064910.17429-1-hubert.buczynski94@gmail.com>
 <47689c2e-505e-461c-88dd-d178a7fdd087@quicinc.com>
 <CAJUMw3uOsSQfiPfn8iW-+TkbcsN21fpM0WNp_xy-6QJPktf4sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJUMw3uOsSQfiPfn8iW-+TkbcsN21fpM0WNp_xy-6QJPktf4sg@mail.gmail.com>

On Thu, Sep 26, 2024 at 01:17:53PM +0200, Hubert Buczyński wrote:
> > Commit ffd603f21423 ("usb: gadget: u_serial: Add null pointer check in
> > gs_start_io") fixed this issue. Please try adding it into your builds.
> >
> > Regards,
> > Prashanth K
> 
> Thanks for the quick response. Indeed, the commit ffd603f21423
> ("usb: gadget: u_serial: Add null pointer check in gs_start_io")
> solves the problem. Sorry for not checking the newest version.
> 
> I wonder whether it should also be applied to the LTS v5.15.167.
> The bug is still present there.

Then submit it for inclusion as per the stable kernel rules!

thanks,

greg k-h

