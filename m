Return-Path: <linux-kernel+bounces-305772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B306A963403
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC4E1F214C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5411ABEBB;
	Wed, 28 Aug 2024 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S9rnW2mH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545715ADB3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881141; cv=none; b=B/Lb6DRLRA6Zbpdc8Lqo3U++CjTZzJ8DzzRCAYAwjNGztV8n0B2xkCj6WI9/TSOQM84MWbi2ZIwWVrAxmv3OXRyDJz32lOPW9v0at+ysBfuIRmoDcUqV9aW4K24OUd/1lmvwjEYt82CD/3HA2vBOf8DiZf2l7rWugPduRZ2/XpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881141; c=relaxed/simple;
	bh=U5j/HWff1z275j88K6HFf95DiUEX3WN4z1hCAhIWKAg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DFUKWrhn13WwClwT5WGQLI0YdF7r7JLnKPbKLyCMzIjxkr+BtCMkX5ece/I0cxl3w1YUCoMnmmjvo/mplWwYRGi7cUHL1Pd5qinH1YSgwAQ+ynWMVGOGfwKhCcaWtedKajHevUlb5TK05OtxkSbhdPuksXrkr0vDUTrhD9bVPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S9rnW2mH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F199CC4CEC0;
	Wed, 28 Aug 2024 21:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724881141;
	bh=U5j/HWff1z275j88K6HFf95DiUEX3WN4z1hCAhIWKAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S9rnW2mHUcO8y2TKZ76XmYVkyK+PeEXVG+F9BeaT8lqElFH6D3JFksiBU1ELRGvH2
	 rl1d7CX3P/WTZhcCQ0wxeVfmZW18DNhz74Op6Q/ZUyW53hj6zgiCcYOkZ34z7ln9VB
	 0e2+gQLgz5AXf7gRk5xUJdGeXyJRVkXl6Hc0zUQE=
Date: Wed, 28 Aug 2024 14:39:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: muchun.song@linux.dev, dave@stgolabs.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] mm/hugetlb: sort out global lock annotations
Message-Id: <20240828143900.d0fe36a6c05982159607fd3d@linux-foundation.org>
In-Reply-To: <CAGudoHH3hFu=7_ouHz+HY8djBxZj3-Zw30gE-F0H_2t1=sv_0A@mail.gmail.com>
References: <20240828160704.1425767-1-mjguzik@gmail.com>
	<20240828124929.db332259c2afad1e9e545b1f@linux-foundation.org>
	<CAGudoHE73o5oK77iOFKqH4D4Cz6t9TAu4882+_F9vHH7muNH-A@mail.gmail.com>
	<20240828134435.443d7f7ec65eba1db4436434@linux-foundation.org>
	<CAGudoHH3hFu=7_ouHz+HY8djBxZj3-Zw30gE-F0H_2t1=sv_0A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 23:02:39 +0200 Mateusz Guzik <mjguzik@gmail.com> wrote:

> > We'd need a new DEFINE_SPINLOCK_ALIGNED() or something.
> >
> > Ho hum, I'll fix.
> 
> that would be a nice addition
> 
> so as is this triviality grew to 3 patches which I consider rather
> extreme, and the middle one breaks the build
> 
> In the vfs land this would get squashed into one commit with a
> maintainer note that some tweaking was performed, which I would
> suggest here

Yep.  In mm land they get piled up as base+fix+fix-2 etc and then
squashed before being moved into mm.git's non-rebasing mm-stable
branch.

> alternatively, given the trivial nature of the entire thing, if you
> add DEFINE_SPINLOCK_ALIGNED and do the annotation tweak, you may as
> well commit this as your own patch. I don't need any credit

eh, it's very minor.

