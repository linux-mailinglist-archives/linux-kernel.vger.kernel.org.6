Return-Path: <linux-kernel+bounces-359077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F7D998722
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1C51C239DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FD21C9EA6;
	Thu, 10 Oct 2024 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WEZg5zkt"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C61C1ABE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565645; cv=none; b=NOAwKDLBIjcYatHOiqPDaR+ct+CU6XF0FdFSLkXq0aKQg8Wn475Qt7jwo8DZ996qztweUdHoZeDxPxGGfXeS06lT9snVnTn2iT1Ef6YkBhgZvjJu+0jpt4sSg0G60NQzOVsKQ9NuJfLetwJEDK8eySdH8Jep/5wA4jyE6TBwuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565645; c=relaxed/simple;
	bh=jGIDhOgbBBnvGGws+4ezzx3fHtN8cTFB8fAxoxJmHeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/ftpdEwojI7UEXHcWh6JXLG/js+icJ8OW0TCBmVnJLXkdiBTJWgHRboQhVakHB6aZKAt+rWe+9pGgIUmn3xo6tz9RFeRKR/rQAMtdx7uqq7cj2hRgWZ5Y4zOmqLbPpQvrOvlQL601KdCUCY4lnXIDQo5Vkc6X7et/adEi83hns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WEZg5zkt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3At5dVj4t33J4waOW38XOA4KtkhXoc0tdeqH/X13qaw=; b=WEZg5zkty+Hus1IYYJ/ieHqlnq
	hT2akM7MI42YBu3nQRcUocW+A5gY/JAoT7Vj+ktinyn2hY4FUA2cIQtcx/ZEDa7lHz+uU7QXgagN7
	BrW2fxW00LTkrHnKwWOZ+Bk9i38rCVYcZUdWnAxwO29qpsCaPePr3R2h1+Wk7ba75MwYUTB7y0MSd
	1Bj7cjBxzkPzKqx3P4pI1skS/o/u3ErvInKOXifZ8d472rqwfg5w2tgYQ6C12oaIy5neNazYOPxDR
	TfvjO+9RiFwEreg0loBnf/AGXd5Btel/+OnPzdBi/6+9L83Audp/OmmHNxrZ44kcsnNfqY0stgLOZ
	hgPcmHtA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56804)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syssw-0002Qq-1f;
	Thu, 10 Oct 2024 14:07:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sysss-0007KE-0u;
	Thu, 10 Oct 2024 14:07:14 +0100
Date: Thu, 10 Oct 2024 14:07:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ardb@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 00/28] ARM: Switch to generic entry
Message-ID: <ZwfRglFliZ8_bLHU@shell.armlinux.org.uk>
References: <20241010-arm-generic-entry-v1-0-b94f451d087b@linaro.org>
 <ZwfAtJfNm95sXgo8@shell.armlinux.org.uk>
 <CACRpkdYPmqXQrt4r5pxCUugHWHkBVF4qPSkvU5X09QB=1sscjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYPmqXQrt4r5pxCUugHWHkBVF4qPSkvU5X09QB=1sscjA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 10, 2024 at 02:11:09PM +0200, Linus Walleij wrote:
> On Thu, Oct 10, 2024 at 1:55 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> 
> > I haven't looked at the series yet, but I guess we're throwing away
> > all the effort I put in to make stuff like syscalls as fast as
> > possible.
> >
> > So the question is... do we want performance, or do we want generic
> > (and slower) code?
> 
> Yes, the very same question that came to me as I was working on it, we
> need to reach some conclusion here. Al Viro also put some nice
> assembly optimizations in the syscall restart that just go out the
> window as well.
> 
> Some of the C interpersing relates to the RCU context tracking that
> really likes to be called at every single IRQ, FIQ or SWI, and where ARM32
> is one of the few last users of the user_exit_callable()/user_enter_callable()
> API which is obviously less intrusive as it only needs to get called
> at transitions to/from userspace, while these calls are marked
> with big block letters as obsolete in the context tracker.
> 
> > It seems insane to me that we spend time micro-optimising things like
> > memcpy, memset, divide routines, but then go and throw away performance
> > that applications actually rely upon, such as syscall performance.
> 
> Yes, this series is a real RFC in the true sense of the word.

I think we need to quantify what the effect is on performance by making
these changes, and I think we need to do more than just syscall entry/
exit performance, but the overall performance impact on userspace when
the system is under a certain interrupt load.

One of the things we have to remember is that applications like to
endlessly get system time. Many of these other architectures that have
been converted to this generic code support VDSO. However, 32-bit ARM
generally does not have VDSO to avoid the syscall over head for
e.g. gettimeofday().

So, we also need to time real workloads as well to properly understand
what the effect of making these changes is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

