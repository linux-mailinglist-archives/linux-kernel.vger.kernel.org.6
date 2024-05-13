Return-Path: <linux-kernel+bounces-177219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627C58C3B90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852341C20EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E11465AD;
	Mon, 13 May 2024 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKCbKcYr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B54B50291;
	Mon, 13 May 2024 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582694; cv=none; b=t+Yr4MF6r8VOn8qp3MR9FFbbSXV3HipyShdsLvY7AlmsA+IqMpndQRLWrU0jhT3od1/auqkCW5/hyci96BJlQm52ZAOYHHtj6wTxdXxaLUTjzNtMnEN2jX4f3goeAGQYzoqaX2kwpfAFJodq/hd+1euS6ScBbADf9LtakpQMlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582694; c=relaxed/simple;
	bh=nXq7taxxO3JmxhnRidgrhbb405e2XuxFNsxB6fFsriY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqsZ9qFhRwXT+WNoe9Z41ELgCI16E9B7f2vXVv0q1w8qd6NoUXTycZAe0Rpv1EO8F8URaiQwz/pDb+eImUlAKoi4JhM/b0F7fmODTr66/JzV4+bJruj6+WcI1ruJzwc/GA0rNDzLguTURJb+at61kPEFbEDemoReR0gS2wawkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKCbKcYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF37CC113CC;
	Mon, 13 May 2024 06:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715582693;
	bh=nXq7taxxO3JmxhnRidgrhbb405e2XuxFNsxB6fFsriY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKCbKcYrka4uQS8xXY9NIsNwsvYa6QRq1rM0f9hGVe+APSUp4f8uRHNeqSb06WyI2
	 kdC2JK1B43GqJ5HiTc/p0gErpql+V4iVLNeuOY20M7VFzBY1HdT/kBWjZnxcQG1KSx
	 +OVF6ntJZSwM5OHCSBeIYW/FHIhvEt7aKHfTgaieYM+tHTbCL+eJlM6LLA30phoum8
	 AHBHyZXWt2zrEVaPBpbCjTWptGANEUvN/6gGdzIYRCxbH1FkqQZHWp8zoy+d+2fL2n
	 WmTjI062s62za9GlXtAQLYAb7DxyS2QrEHQp9d3H3bHvXxm3nA99EjwzAuaYD+ERBu
	 TvmGonECdSI3w==
Date: Sun, 12 May 2024 23:44:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] soc: ti: knav_qmss_queue: do device_node auto cleanup
Message-ID: <20240513064451.GB652533@thelio-3990X>
References: <20240510071432.62913-3-five231003@gmail.com>
 <202405111846.3m9z398l-lkp@intel.com>
 <ZkCZTv0Gci3xxKtw@five231003>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkCZTv0Gci3xxKtw@five231003>

On Sun, May 12, 2024 at 03:56:22PM +0530, Kousik Sanagavarapu wrote:
> On Sat, May 11, 2024 at 06:12:39PM +0800, kernel test robot wrote:
> > Hi Kousik,
> > 
> > kernel test robot noticed the following build errors:
> > 
> 
> [...]
> 
> > All errors (new ones prefixed by >>):
> > 
> > >> drivers/soc/ti/knav_qmss_queue.c:1853:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1840:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1835:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1831:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1822:4: error: cannot jump from this goto statement to its label
> >                            goto err;
> >                            ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *queue_pools __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1818:4: error: cannot jump from this goto statement to its label
> >                            goto err;
> >                            ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *queue_pools __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1810:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *queue_pools __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *pdsps __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1806:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *queue_pools __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *pdsps __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1795:3: error: cannot jump from this goto statement to its label
> >                    goto err;
> >                    ^
> >    drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *regions __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *queue_pools __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *pdsps __free(device_node) =
> >                                ^
> >    drivers/soc/ti/knav_qmss_queue.c:1801:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
> >            struct device_node *qmgrs __free(device_node) =
> >                                ^
> >    9 errors generated.
> 
> Seems like gcc didn't catch this when I compiled locally.

FWIW, you may notice this as you do more conversions. The fact that GCC
does not warn at all is a GCC bug as far as I am aware (i.e., clang's
error is correct):

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91951

which has come up in other places:

https://lore.kernel.org/20240425174732.GA270911@dev-arch.thelio-3990X/

Cheers,
Nathan

