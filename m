Return-Path: <linux-kernel+bounces-360501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8085999BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4E028639C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86BE20898F;
	Fri, 11 Oct 2024 04:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o8s0xxTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322371F4FD8;
	Fri, 11 Oct 2024 04:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621649; cv=none; b=piUkjG4RxVAIPOTh00DaeIewg2LYkhdivSQvd/retXOjPlr28xP8TEuZKGUvGQp61sbU7uwgiMo+xPViWDAmGlIwK/VpHA/61A/GLMVDTHNjHi+wa1xfyfsX3Ko9Fw6uabVir4esXzthxKzN1rpM0T9PGoZA83ODObUWbkPu18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621649; c=relaxed/simple;
	bh=yePM81rOiZPlgcmNUPfiaxBpY3DbgkQviXlB6MJ7lz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cawn51ajSynwthAZUjrIzXppwhzoqSDxfkiKFc1Vn3lrhLTcaonJWR+GwAcQuFpq5J6TwkilZa7NpPY/YbgX89WGiimtq0Z3LtzGGgGBTyne3uvI6frt84R1jodQl6WebH+htgc5P0b1z5nCGqUZBHejoCBYHCf+6BYrxhTXlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o8s0xxTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE86EC4CEC7;
	Fri, 11 Oct 2024 04:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728621649;
	bh=yePM81rOiZPlgcmNUPfiaxBpY3DbgkQviXlB6MJ7lz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8s0xxTy84khdgcZ9B9MJEZr6r5T1++mp/kCMggecpWfxfWGZCXfO8BzXOqfcMwG0
	 jZ8DXXKBwqU/wqNyvf8DUzHBFycf/Vl/3FmoA7aqDEwnuEsmus23pM/7g4aYLas5Ea
	 /PX8EbYf0XEXaoGXbQzyvT0PjYN6WOM07kT0zSvQ=
Date: Fri, 11 Oct 2024 06:39:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5/5] staging: vchiq_core: Locally cache cache_line_size
 information
Message-ID: <2024101136-subsonic-cogwheel-5d7d@gregkh>
References: <20241010102250.236545-1-umang.jain@ideasonboard.com>
 <20241010102250.236545-6-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010102250.236545-6-umang.jain@ideasonboard.com>

On Thu, Oct 10, 2024 at 03:52:49PM +0530, Umang Jain wrote:
> Locally cache 'cache_line_size' information in a variable instead of
> repeatedly accessing it from drv_mgmt->info. This helps to reflow lines
> under 80 columns.
> 
> No functional change intended in this patch.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>

As I didn't take all of the other patches in this series, this one
failed to apply :(

Please rebase and resend it, thanks.

greg k-h

