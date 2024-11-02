Return-Path: <linux-kernel+bounces-393082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB779B9BA6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E390E282619
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4745C125;
	Sat,  2 Nov 2024 00:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sF1o8QCD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB7191;
	Sat,  2 Nov 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730508712; cv=none; b=B/W2+GYDIsmvp57rXpZBBugQHdXXxWJvoh7ASyVwfwdwe6w7DIwX66DkVtU5OEXqlGEvFD//7zfvpMlU+ouNXOVv4AYUMpm5KRslltx9yBBkQIf04dHAnZdmHeE/oq4KoddXi7D3+Hi/DMzOdXKZIGNwEJRSa+Nxml9ePn/tXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730508712; c=relaxed/simple;
	bh=OgBB/zwV6vsWYBB2l7iAFye5/JY7YemkzNlubmb/IkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZlT0ybCBpSckzD9KKvRDFMYEQeF4xzGNYYo1c+urLbxMxJnxJzARNFHUt0TzjdAju1SV06Iv+YTw3kE6FlJV4/HdcFv/iVNC8PsrLSRmBoLbZYLiYpcwIiLD6MNQPiro1lLhqsqHklpM9PYs9CRSSTxdH7L4soEmNkK1MY7Q28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sF1o8QCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F718C4CECD;
	Sat,  2 Nov 2024 00:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730508711;
	bh=OgBB/zwV6vsWYBB2l7iAFye5/JY7YemkzNlubmb/IkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sF1o8QCDw56DSnDftwO1+K19bciqly6Ed56HmzC0799kfFR+aZEmN0rnq/wRWF983
	 +RgljEr9tFPtmtALH6fHzK7nm2Z/QI0XgczzlIFzOk6W4IHE0Vnl0YhjkMEWu5lksS
	 FMsoxcGJCprYVoWhHSE/0k+nAvkk8pFkJHuKuP7c=
Date: Sat, 2 Nov 2024 01:51:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, arnd@arndb.de
Subject: Re: [PATCH 0/9] Patch set for gpib staging drivers
Message-ID: <2024110240-wound-quicken-a70c@gregkh>
References: <20241101174705.12682-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101174705.12682-1-dpenkler@gmail.com>

On Fri, Nov 01, 2024 at 06:46:56PM +0100, Dave Penkler wrote:
> Patch 1 is a bug fix
> Patches 2-6 replace custom debug with dev_dbg as well as
>             using dev_xxx for pr_xxx where feasible.
> Patch 7 Corrects some errors in Kconfig
> Patch 8 is a code cleanup
> Patch 9 corrects GPIB behaviour
> 
> Dave Penkler (9):
>   Fix buffer overflow in ni_usb_init
>   Replace custom debug with dev_dbg
>   Update messaging and usb_device refs in ni_usb
>   Update messaging and usb_device refs in agilent_usb
>   Remove GPIB_DEBUG reference and update messaging
>   Use dev_xxx for messaging
>   Fix Kconfig
>   Rationalize lookup tables
>   Correct check for max secondary address

The subject lines for all of these need to have something like:
	staging: gpib: ....
as a prefix, otherwise they don't make much sense when looking at all of
the commits in the whole tree.

Can you fix that up, and the other issues pointed out by people, and
send a v2 series?

thanks,

greg k-h

