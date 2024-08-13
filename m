Return-Path: <linux-kernel+bounces-284168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF5F94FDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496AEB23340
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB953CF7E;
	Tue, 13 Aug 2024 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CqAzioc7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAF3BBC5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530492; cv=none; b=LyMyc4oNA1JnOrEtFofPYuoGK6N3ugOTeds6g1V1cggnUccRJJAjeWyPm1x76JD9EaLt0JMShcBreAqinvQGN68SKw+1fadLfRv5hfz7r49M5J9XkWI9iVa+4exInmaUOTz75H06RirX2VEuE3l1wGRxkN57IPW7lmJLi2BnyF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530492; c=relaxed/simple;
	bh=derBRRAO0pG76FVV3scLWIoHy4jk/7v1q8+kLjSqkqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0OEuzpeFD3UfIJILcn+lZ+aPdscQCu1yQMl0ysbFG8JPIO+QIUiyEjeNMdvef52JM8N79MuETbuE7eRGv9NPRgCcXaLYDchCA+sg92rNAToNbjIfvnoD1wfeE8eXmypoE+u7p/OgdHv7ArWzbb9kr/2gx+sSn147EnYykfwV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CqAzioc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E447C4AF09;
	Tue, 13 Aug 2024 06:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723530492;
	bh=derBRRAO0pG76FVV3scLWIoHy4jk/7v1q8+kLjSqkqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqAzioc7M91ugJKeoMUaWhhH/w5N9NuQYSiNIQc1A30ZHjIxEIn0b85FXdYg+2pW+
	 kSe25YIJBmeuIPsMj+d0kx1y3sZCHj83KEOvLVhTJCR4i5442REhQ9p2kjYyAADqnd
	 OdB8VolScMqCNYrBIeMveN8W0tdosiUx8/HzbC9Q=
Date: Tue, 13 Aug 2024 08:28:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, devel@driverdev.osuosl.org, brauner@kernel.org,
	kernel-team@android.com, tkjos@android.com, arnd@arndb.de,
	surenb@google.com, masahiroy@kernel.org, cmllamas@google.com,
	linux-kernel@vger.kernel.org, hridya@google.com, arve@android.com,
	smoreland@google.com, joel@joelfernandes.org, maco@android.com
Subject: Re: [PATCH v1] add binder genl for txn report
Message-ID: <2024081350-establish-direness-38ee@gregkh>
References: <20240812211844.4107494-1-dualli@chromium.org>
 <2024081341-egging-custodian-428d@gregkh>
 <CANBPYPjCobjbtyKoFJHAciE3=m0Z_QeDTdD9C=ggCcvaWy0daA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANBPYPjCobjbtyKoFJHAciE3=m0Z_QeDTdD9C=ggCcvaWy0daA@mail.gmail.com>

On Mon, Aug 12, 2024 at 11:16:27PM -0700, Li Li wrote:
> On Mon, Aug 12, 2024 at 10:13 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 12, 2024 at 02:18:44PM -0700, Li Li wrote:
> > > From: Li Li <dualli@google.com>
> >
> > Sorry, but I can not parse your Subject: line at all.  Please use
> > vowels, we don't have a lack of them :)
> >
> > Also look at how other patches are formatted for these files to get an
> > idea of how to create a good subject line.
> 
> Thank you for reviewing the patch!
> 
> Sure, I'll find a more meaningful subject in v2.
> 
> > > To prevent making the already bloated binder.c even bigger, a new source
> > > file binder_genl.c is created to host those generic netlink code.
> >
> > "genl" is a rough abbreviation that is not going to be easy to remember,
> > what's wrong with "binder_netlink.c"?
> 
> It's just because genl has already been used in both of generic netlink
> kernel code (e.g. in linux/include/net/genetlink.h) and user space libraries
> https://man7.org/linux/man-pages/man8/genl.8.html.

Ah, I wasn't aware of the existing names, so that's fine if it is what
the networking world is used to.

Which reminds me, why aren't you asking for their review here as well to
ensure that you are doing things with netlink correctly?

> > What userspace code is now going to use this and require it?  How was it
> > tested?  Where is the test code?  Where is the new user/kernel api that
> > you created here documented?
> 
> As mentioned in the commit message, binder is used in Android OS. But the
> user space administration process can do little to deal with binder transaction
> errors. This is tested with Android. I'll upload the user space code to AOSP.
> If there's a better option to host the test code, e.g. a smaller and
> simpler project
> that uses binder, please let me know.

It needs to be somewhere, otherwise we don't know how any of this is
being used at all.  And there was some binder "test code" somewhere, is
this new functionality added to that also?

> > You added a new ioctl here as well, why not mention that?  Why is it
> > needed?  Why not always emit netlink messages?  How do you turn them
> > off?
> 
> The generic netlink message is a convenient way for the kernel driver to send
> information to user space. Technically it's possible to replace this
> new ioctl with
> a netlink message. But that requires much more unnecessary code parsing the
> raw byte streams and accessing internal binder_proc and other structures from
> netlink layer. It's much more elegant to use an ioctl with only a
> couple lines of
> source code.

Then you need to document that somewhere.

> To turn them off, just call the same ioctl, resetting the flags to 0.
> That said, the
> name of this new ioctl (BINDER_ENABLE_REPORT) isn't good enough.
> What do you think if I change it to BINDER_SET_NETLINK_REPORT?

Yes, the name needs to change if you can both enable and disable reports
from it.

> > And how does this deal with binder namespaces?  Are these messages all
> > now "global" somehow?  Or are they separated properly per namespace?
> 
> The new ioctl BINDER_ENABLE_REPORT (again, it deserves a better name)
> sets the report_flags for its associated binder context. Each binder context has
> its own settings. The messages from all binder contexts are sent to user space
> via the same netlink socket. The user space code can enable the reports for
> each binder context separately and distinguish the netlink messages by the
> name of the binder context.

So userspace will now get all reports and has to do the parsing to
determine what is, and is not, relevant for what they want?  That feels
like a big security hole to me, has this been audited by the Android
security team yet?

> It's also possible to have one netlink socket for each binder context.
> But it seems
> like overkill to me.

Again, think of security issues please.  Do you want all binder
processes in a system to be able to see all other messages?

thanks,

greg k-h

