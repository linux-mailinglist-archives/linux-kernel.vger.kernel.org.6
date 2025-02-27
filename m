Return-Path: <linux-kernel+bounces-535258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B9A470A8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E2416D5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D8114A8B;
	Thu, 27 Feb 2025 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TkDiiZd0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524554670;
	Thu, 27 Feb 2025 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618212; cv=none; b=Wq+BdJfdgNJ4ARHUxV58tT4JuQIcBCxEH+p+E/Cm6LHMfql3+P08obwJFOIWpddgzad/UnM00j+fjclVAHKGOvga9o+upbW6sNgu78XDRs7pUyiX7TMkJ7og8Phz3z1CV2oIZlO6gzq1EASx98ePKyU540ZCmPX6gcgmRT25EN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618212; c=relaxed/simple;
	bh=FTPMAncBAzZfObxBDvtwhNrMKEuph+iFW9LdgJdI6ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifBX7d1s85iDN0mIF3zJlO3xCgrz1+pKwzTsqnK2Li1WML18jPLBFaPAbgb99m7bWA12he5phZzHRX4Why29G8T2K84CFvzw/pjfVTa3ZveR6dblmalUfK18yidivwW05ZFbdsxdEmzTY7RRKuJbXrH0LiguO6xtr+6qVzlyC78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TkDiiZd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21925C4CED6;
	Thu, 27 Feb 2025 01:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740618212;
	bh=FTPMAncBAzZfObxBDvtwhNrMKEuph+iFW9LdgJdI6ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkDiiZd0yabeKBUfXZTVFwtg6jdjGZZPQpwod4kGqxUa1vDdFmu3lIrfCD4TN6UX1
	 Dd8R07piDH4YyhTXUqPgiTQY210uHXGPVZvttfTy7TTjWZaR2UJEJ/uJ9I1VDqwGz+
	 0Ydz8gkdTWJdd8C6mRQp1+4AH+2legHQxpSxJeb4=
Date: Wed, 26 Feb 2025 17:02:23 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <2025022644-fleshed-petite-a944@gregkh>
References: <2f062199-8d69-48a2-baa6-abb755479a16@nvidia.com>
 <Z73rP4secPlUMIoS@cassiopeiae>
 <20250225210228.GA1801922@joelnvbox>
 <20250225225756.GA4959@nvidia.com>
 <Z75WKSRlUVEqpysJ@cassiopeiae>
 <20250226004916.GB4959@nvidia.com>
 <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com>
 <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226234730.GC39591@nvidia.com>

On Wed, Feb 26, 2025 at 07:47:30PM -0400, Jason Gunthorpe wrote:
> The way misc device works you can't unload the module until all the
> FDs are closed and the misc code directly handles races with opening
> new FDs while modules are unloading. It is quite a different scheme
> than discussed in this thread.

And I would argue that is it the _right_ scheme to be following overall
here.  Removing modules with in-flight devices/drivers is to me is odd,
and only good for developers doing work, not for real systems, right?

Yes, networking did add that functionality to allow modules to be
unloaded with network connections open, and I'm guessing RDMA followed
that, but really, why?

What is the requirement that means that you have to do this for function
pointers?  I can understand the disconnect issue between devices and
drivers and open file handles (or sockets), as that is a normal thing,
but not removing code from the system, that is not normal.

thanks,

greg k-h

