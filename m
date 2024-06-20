Return-Path: <linux-kernel+bounces-222351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE23691002F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A57C281CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24DA19EED6;
	Thu, 20 Jun 2024 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A8lSwfkC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18F19DFB4;
	Thu, 20 Jun 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875317; cv=none; b=DE+vdpxaBUITtaD7ujbJzenL58IDCt8DtUVyG5vxHsfF4mAD8a+VYnZ1GIyDb3JxLzzd8onngAlmCRj5qHI9Swzokyc2mta7Zm6ZYO8Mmi5ULiSlQhQcsTLqHeomOWBIZZdY3fDUUxUe4yCn2xqEXxkcyNplNLeo4QLFJUjShIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875317; c=relaxed/simple;
	bh=MOwveM+TrPvabeAJp2eFYTM8sdaud1M16GSHRHxzgr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgVEytbCBfuP7yT+DZHeXoNin+EFv3pckimooybcNxKv7/YVBjpP2wW+A3vgqgianyjDFgjLLShn23r17JxaEWZ7M7346ZWdfC7nimWEr2Ni3GBGDjZPcEZOgN3ZGlx/TX69kAetpQ1nIoEw675k0XPeQXqKqIHLfS1PCkq6QMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A8lSwfkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A87CC2BD10;
	Thu, 20 Jun 2024 09:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718875316;
	bh=MOwveM+TrPvabeAJp2eFYTM8sdaud1M16GSHRHxzgr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8lSwfkC/C8LP3k7XcJSqgF56bxklW+OH5E/J6S2tNgS2uAFyId6mn8p4U2Ikda5t
	 Tvl/YCKfaa8l3+aIJX/w+412iWVXn8JrBzG6SYw2+23jISo5gfI/Zg7IpLznGfQN0N
	 I8iMAxFCSvXUxkTQ0J3DRa/JDL7yN+BuP9hRc1s4=
Date: Thu, 20 Jun 2024 11:21:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: Re: [linus:master] [workqueue]  5df9197edd:
 BUG:soft_lockup-CPU##stuck_for#s![swapper:#]
Message-ID: <2024062023-enslave-baffling-8198@gregkh>
References: <202406201623.d1a3b599-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406201623.d1a3b599-lkp@intel.com>

On Thu, Jun 20, 2024 at 04:46:37PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![swapper:#]" on:
> 
> commit: 5df9197edd731a44682444631d68c2384f381bf1 ("workqueue: make wq_subsys const")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

I strongly doubt that this specific commit id caused any problems, it's
just a const change, no logic changed at all :)

thanks,

greg k-h

