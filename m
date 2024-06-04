Return-Path: <linux-kernel+bounces-200801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5CC8FB531
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1093EB262F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106E813BAFE;
	Tue,  4 Jun 2024 14:20:41 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B2185131736
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510840; cv=none; b=jshoXkF3gASK2xKsIhPABlL1ecCrZ6d9k2ly2zd658ImiHwEJAiQL7lkNQntNGLw8tGuBVxnlMjTNMgZcYLuA8LufaJJJS+rPqEU+DPus+9+0IAfsukwvbmiYeOEvKGlw1oILPBjkI7nba1YScMBGpAjZnkYye5XJw7nRico6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510840; c=relaxed/simple;
	bh=x9CkWTxGLFPRYVUUOKNEAhRFOItGOxVF5wXD2HSaC14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF4pYFxJ+itNBRGsEg0AVeoAJ0TbbpmKox3Kq9HLXjfJpOcjBfxbT1pnxZRwWnNq/ArgKRwPsuRzrHPV2BtjeAVxLSWpBH3JTCwoMUs2Q72VqBQ6gMHc0rpx2GL4eZUYYyyOtlBDTUkXMCLo6eWs14kQlUuIoqaP2tXeFgcQnjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 158307 invoked by uid 1000); 4 Jun 2024 10:20:31 -0400
Date: Tue, 4 Jun 2024 10:20:31 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Cc: syzbot <syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com>,
  bp@alien8.de, dave.hansen@linux.intel.com, gregkh@linuxfoundation.org,
  hpa@zytor.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
  x86@kernel.org, Matthias Stoeckl <matthias.stoeckl@secunet.com>,
  Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in schedule_timeout (6)
Message-ID: <3e1b188f-2a68-461c-9b7c-a1d85bf8eb31@rowland.harvard.edu>
References: <000000000000f8112e0618995e6e@google.com>
 <46cbe0a914065917ea1024636e864a1e2c982145.camel@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46cbe0a914065917ea1024636e864a1e2c982145.camel@9elements.com>

On Tue, Jun 04, 2024 at 02:05:12PM +0200, Marcello Sylvester Bauer wrote:
> Greetings,
> 
> I'm currently investigating this regression to properly fix it. My
> patch only replaces the corresponding timer API calls without actually
> changing the code. I'm trying to get it to work properly with the
> hrtimer API.
> 
> Any hints on how to accomplish this are welcome.

Start by figuring out what isn't getting executed.  That is, which USB 
(or usb_request) transfer isn't completing.  Once you know that, see 
what timer callbacks do occur (if any) and figure out why they don't 
cause the transfer to complete.

If there are no timer callbacks at all when the hang occurs, make a 
record (printk if nothing else), from the start of the test, of each 
callback and each timer restart, so you can definitively prove to the 
hrtimer maintainers that there's a restart with no later callback.  Then 
it will be up to them to figure out what's going wrong.

Alan Stern

