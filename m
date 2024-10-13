Return-Path: <linux-kernel+bounces-362794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF18599B958
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 14:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D561C20AE8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A33A140360;
	Sun, 13 Oct 2024 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dFhLa2Eq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17F13D89D
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728821656; cv=none; b=LqSFR8dD4wksiLvc+wEYQC+yQj885ngjdX9IfEOoxs4aT25KZSpqxVSuuiWsvWihgFcXmLk2h7jmNn+XsF54JnO8JY+8VKiyaYfOpRUEyzjrtsPQEKP4kYRLshEHPRZo+S2gIMqrofk19ln4xyURJCNzwvLC8LsQsPQC5kYT/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728821656; c=relaxed/simple;
	bh=U08OR/iLY0KeIsejOyZ8U7fhp2ijcfrP2jngReqqUZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzRD4msm7s1/TV9JIME305P0h7f2C0yvFvojX+/zvsj2F9Qynsp3iP02+WOW38GMojLhTNDFjLUIzf1gIJ1RRmFnq1MTCjQg/RWQGlr/IAvpK4IlfANyirg6XeMyMHB1c48q64izqEA1EKYNyejdIs2U5jFHtPv8apbPFpx6y2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dFhLa2Eq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E0CC4CEC5;
	Sun, 13 Oct 2024 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728821655;
	bh=U08OR/iLY0KeIsejOyZ8U7fhp2ijcfrP2jngReqqUZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFhLa2EqIhSkRz0oMA85pGiK+WYEAQcahUp4ZtDmQgSGcf73L+9E9vc+9Ss1FA59K
	 0/U+JewQzd/pr+Db7Q9nb1tQYChfpeaGpJ/0FLQMO0KZoLP7dsEjuwGeBnUlVRD7EE
	 oa7Vtkaj7vniz4q+PV5fVryyud/KW+GCUV5Ahb7M=
Date: Sun, 13 Oct 2024 14:14:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Oren Weil <oren.jer.weil@intel.com>, Tomas Winkler <tomasw@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next] mei: use kvmalloc for read buffer
Message-ID: <2024101343-proposal-gatherer-8c43@gregkh>
References: <20241013115314.1290051-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013115314.1290051-1-alexander.usyskin@intel.com>

On Sun, Oct 13, 2024 at 02:53:14PM +0300, Alexander Usyskin wrote:
> Read buffer is allocated according to max message size,
> reported by the firmware and may reach 64K in systems
> with pxp client.
> Contiguous 64k allocation may fail under memory pressure.
> Read buffer is used as in-driver message storage and
> not required to be contiguous.
> Use kvmalloc to allow kernel to allocate non-contiguous
> memory in this case.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/misc/mei/client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What about this thread:
	https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar@chromium.org/

No attribution for the reporter?  Does it solve their problem?

And why such a short line-length in the changelog?

Also, where is this memory pressure coming from, what is the root cause
and what commit does this fix?  Stable backports needed?  Anything else?

And who inside Intel reviewed this before sending this out?  Why are
they not credited here properly?

thanks,

greg k-h

