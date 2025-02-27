Return-Path: <linux-kernel+bounces-536145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A045A47C18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD2B1894C08
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84022B8A6;
	Thu, 27 Feb 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dze0FuYM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9860226CF0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655284; cv=none; b=TMKQ6MYi3sybzPvny2wShPMjLLpKSA0NUgc+Lqwhkz/rDjW1X6C9IQKDNEFtKMHNU6BARrzqPSEgSjc+nmxGoQdLQkF8xw3uwHENTMeO/MI0WEifhLADEmYSu2RnJ2nHaOlFVbVkKJb5S67y7zN89u1XqtomANXp7C7euZ63vEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655284; c=relaxed/simple;
	bh=bF3bvoCvsJ6ElRLIsgG+zyDMBrm+a5kCvyQlSQ6eyZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKpVjyO4GHyxkN6xeeT4GbbVEiQG7gxvo3Qb0JlbNglr7b/P0P/+kOb0jalVv+bIvb1WZtyCG7rkfEp9XCoJp92H5wmpQJvI64T9gQ8OPu15w6RRaWeKFPx7cPbK9LrreAs27qqv07RBEs4tnS6uD7PcghJgRP6UQ9VjsNNE0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dze0FuYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D8AC4CEDD;
	Thu, 27 Feb 2025 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740655284;
	bh=bF3bvoCvsJ6ElRLIsgG+zyDMBrm+a5kCvyQlSQ6eyZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dze0FuYMlh2Qw4IBL6eaaSz99/fEsu8+R2Dh5+adaYZ1fzvLz93L0RVRVFpxjwAYi
	 qBsQlWRl3br84j5sOMTUT0GKX0720eIB8lP+AWI5rUbqGrv9OwaRrSYJZmmNoOZTVr
	 WEYVo650sBdfFOwpkJX9vvW/wMAhS2zOm4RYQP7o=
Date: Thu, 27 Feb 2025 03:20:15 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: rafael@kernel.org, dakr@kernel.org, hjc@rock-chips.com,
	andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, quentin.schulz@cherry.de
Subject: Re: [PATCH 1/2] drivers: base: component: add function to query the
 bound status
Message-ID: <2025022705-boat-overhaul-0ed3@gregkh>
References: <20250220234141.2788785-1-heiko@sntech.de>
 <20250220234141.2788785-2-heiko@sntech.de>
 <2025022153-outdoors-snugly-3967@gregkh>
 <12995210.iMDcRRXYNz@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12995210.iMDcRRXYNz@diego>

On Thu, Feb 27, 2025 at 09:44:23AM +0100, Heiko Stübner wrote:
> Hi Greg,
> 
> Am Freitag, 21. Februar 2025, 07:14:07 MEZ schrieb Greg KH:
> > On Fri, Feb 21, 2025 at 12:41:40AM +0100, Heiko Stuebner wrote:
> > > The component helpers already expose the bound status in debugfs, but at
> > > times it might be necessary to also check that state in the kernel and
> > > act differently depending on the result.
> > > 
> > > For example the shutdown handler of a drm-driver might need to stop
> > > a whole output pipeline if the drm device is up and running, but may
> > > run into problems if that drm-device has never been set up before,
> > > for example because the binding deferred.
> > > 
> > > So add a little helper that returns the bound status for a componet
> > > device.
> > > 
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  drivers/base/component.c  | 14 ++++++++++++++
> > >  include/linux/component.h |  4 +++-
> > >  2 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> just for safety and not stepping on people's toes, does the Acked-by mean
> that this patch can go together with its user through the drm-misc tree?

Yup, merge away!

