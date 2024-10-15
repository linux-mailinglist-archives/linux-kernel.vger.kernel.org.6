Return-Path: <linux-kernel+bounces-365183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B9899DEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084B31C21861
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4226718BBAB;
	Tue, 15 Oct 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0kEBBViw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4E189BBF;
	Tue, 15 Oct 2024 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974890; cv=none; b=GVUqRCtWMPuhymz5eDjmlu86leJnJtKSz+3CVN3xM7H/dlsTGeg+8NdPqgNsyCIRzEl/sRxPciIxGMH/Yv17qNQc3TQ67JntuyT8YuAT5R2G5TqJ5JuhoW0MSidkTQ93oGRHqXJbAbcFiNCAAV9kPxE808zys3OXJUotnhoF+dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974890; c=relaxed/simple;
	bh=Mciw6yhCANdXF5sjQVXRJKl08/eUKEIsu2jyoWqK8uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT8q8dwrtX7MXFTFJgK2xeNGajCi2r8Fa3ythU7r6/jOqfFMK/BnLyMC7hk67qS6LpThG05FGldX6S2hw4QL16N67jUxME/FjFiXjkKKozJMyFW7jQXqe1fzjoKNe0Vtejy59g8tfduUu4fDBM8NQ+aV0U8PD5TdUDUZs9FsjwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0kEBBViw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3A5C4CEC7;
	Tue, 15 Oct 2024 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728974890;
	bh=Mciw6yhCANdXF5sjQVXRJKl08/eUKEIsu2jyoWqK8uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0kEBBViwGucY+T//4KaFg6XYuQDpM4aKae1jn7orluthv9c7oKjAbFco858au0N6b
	 1MKPdTl8j+RRpoPHCyOCt+yBv+KFWJ/KSgrg6xg5MMSHsRxbWys/ZDfucBzpAGmK+n
	 v+zomLwruUhm3W5X07H1gtzInHO7T1kBgLsDOF0E=
Date: Tue, 15 Oct 2024 08:48:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hui Guo <guohui.study@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Alex Elder <elder@kernel.org>,
	Aditya Garg <gargaditya08@live.com>,
	Grant Grundler <grundler@chromium.org>,
	Kerem Karabay <kekrby@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Oliver Neukum <oneukum@suse.com>, Yajun Deng <yajun.deng@linux.dev>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: refcount bug in put_device
Message-ID: <2024101515-helmet-stoic-1c97@gregkh>
References: <CAHOo4gL5BYS53rd2bJiKmL1XSg94hn0u4yCPut7NqZ0XZMNf3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHOo4gL5BYS53rd2bJiKmL1XSg94hn0u4yCPut7NqZ0XZMNf3A@mail.gmail.com>

On Tue, Oct 15, 2024 at 02:37:47PM +0800, Hui Guo wrote:
> Hi Kernel Maintainers,
> we found a crash "WARNING: refcount bug in put_device" in upstream, we
> also have successfully reproduced it manually:
> 
> HEAD Commit: 9852d85ec9d492ebef56dc5f229416c925758edc(tag 'v6.12-rc1')
> kernel config: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/6.12.config
> 
> console output:
> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/83e10c2b482009dbb3b32ece907dcc361978f9b9/log0
> repro report: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/83e10c2b482009dbb3b32ece907dcc361978f9b9/repro.report
> syz reproducer:
> https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/83e10c2b482009dbb3b32ece907dcc361978f9b9/repro.prog
> c reproducer: https://raw.githubusercontent.com/androidAppGuard/KernelBugs/main/9852d85ec9d492ebef56dc5f229416c925758edc/83e10c2b482009dbb3b32ece907dcc361978f9b9/repro.cprog

As this is using a "fake" yealink device, odds are there's some
reference counting bug on the disconnect path that you have found.  Care
to send a patch to fix it up as you can test it easily?

thanks,

greg k-h

