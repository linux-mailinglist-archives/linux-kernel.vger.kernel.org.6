Return-Path: <linux-kernel+bounces-524601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC781A3E509
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04B5421AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E56263F45;
	Thu, 20 Feb 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="UVAQw/A9"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB6214A71
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079817; cv=none; b=ePi05eoWs6Ewm5bGQlAhAHTZqxktGn5POvblo5l8TRj1caJq6OF38+vmD++HmDoLsnZgU9DBsICI4zP9tL/lTJTYFuka4iIiMrKPIsWMj1OgGz+6Jde7BPlNgp1rEjkeKRzTjw+GSpvx0nJeAu7YpS7+QM91s0lVzxOXG8voXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079817; c=relaxed/simple;
	bh=dJWPLnJj21wCkBU29uSZIaQFMB0QkeAeIIcb/URACOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzjI8Si47c8HT4koVSFnUPjMcMTLdcYXVdklCzYscWplWnff59/YOxOPgRLp5TTITKuLt9FLPEIpkq0DS9aRaywT7KhpOWyCXFELAIa6CFs8lPnfG0xJJa0QC0/79zy7XwgJKqrGBkhV4kd4A9AYHyYzdlNGTwaDxy3YGHVxvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=UVAQw/A9; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LaebbR1fCHrbWS1c8WrqBMyWgAWMf7qIWq68odFW7yE=; b=UVAQw/A9FTJCao5zNaaYOlbV4+
	kkiCgbk79XfFh/bm18zaH+B+jaCi8GkjSaRn4ovKfID/mJyFSPpbYv68uSaDjhiKYcTXJYoWjvDh7
	x4pLp12iVSkrafmM1/eq8ynlVSCGWoVMThCsq0QR1WgvbwzVsyGvCMvY+vR4s5+MDdOfpi2J3TEz0
	lHQFRylqHNnnueqVCU5o93VlmOBdetq1BWjO3MjjjHv5gpxUqbWpnft9x9bWJ+i4Bz686lPsoaSbp
	i47k/slOYBycwRt7ycqXvOn5/DxSbgaV2bD4kh+T5WyFkLzY1KguQGnJSHJ3s61CD6jceZ2D3l2IW
	RZrqz+zA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tlCFO-00HTga-2f;
	Thu, 20 Feb 2025 13:30:14 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 wine-devel@winehq.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ntsync: Check wait count based on byte size.
Date: Thu, 20 Feb 2025 13:30:10 -0600
Message-ID: <2297779.iZASKD2KPV@camazotz>
In-Reply-To: <2025021906-retainer-trustless-bd1d@gregkh>
References:
 <20250219001920.210847-1-zfigura@codeweavers.com>
 <2025021906-retainer-trustless-bd1d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Wednesday, 19 February 2025 08:25:27 CST Greg Kroah-Hartman wrote:
> On Tue, Feb 18, 2025 at 06:19:20PM -0600, Elizabeth Figura wrote:
> > GCC versions below 13 incorrectly detect the copy size as being static and too
> > small to fit in the "fds" array. Work around this by explicitly calculating the
> > size and returning EINVAL based on that, instead of based on the object count.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202502072019.LYoCR9bF-lkp@intel.com/
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > --
> > 
> > Suggested-by as per Arnd's request, but the only thing I changed was preserving
> > array_size() [as noted by Geert in the linked thread]. I tested and found no
> > regressions.
> 
> You forgot to sign-off on this commit :(
> 
> Can you resend it please with that fixed?

Done, thanks. I used to have format.signOff=true but lost that somewhere...



