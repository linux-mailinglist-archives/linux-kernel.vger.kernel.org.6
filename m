Return-Path: <linux-kernel+bounces-187577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1253F8CD4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445211C212D5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142A14A0B2;
	Thu, 23 May 2024 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lP/xqI9e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38833224FA;
	Thu, 23 May 2024 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471066; cv=none; b=OLMfVLOW93dsH3t6yww9AdcKXfKiQw2IMat+0LoJZHBuG/ETwKuhZxQluDrPWOLosrnZatcUq01Q3NXPFTVAMzdkAg6QSuWWURNOo+TApvBwlqHVo0rtHzd1XOaU0KRKo+VuyiON8SC/3yEY+jRiBLK9kWlh3SJrf3ULsG+pmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471066; c=relaxed/simple;
	bh=sAJj67FsAJsaSk4s8mN5GuG+0++iDgcYQY2HCWnVDzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r19XCNlu7Nd4Ftrd0wXA6HiTLsiLtgt1McA7uA8zGCb5c1UWmCezYKT3tyfPrmRj1EztE0pdxvztS662CieJV0g6Wa7f+4s7j4HmydpWut9Y8zxOG05tAmIh/e5Tn1le1ZttKqo4HQFIaAVfn7aY7Uq5lvXd+VerxhUrXyjUi7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lP/xqI9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCD6C2BD10;
	Thu, 23 May 2024 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716471065;
	bh=sAJj67FsAJsaSk4s8mN5GuG+0++iDgcYQY2HCWnVDzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lP/xqI9eVD56TTz4HOGPicH5FJAyHRDjZD0s7dD3Jgi0LUTPxRnRGEED0zWe1I1eU
	 XWvcxzQrx/N3x6bew1UWaV8QUJg/mituKS0s6ngrfUSfEeIhHenecDx38GHDssSDSW
	 peN3FA7Xr/OVjp9s69H+q99ow1+zNDifPMvhaUyg=
Date: Thu, 23 May 2024 15:31:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2021-47326: x86/signal: Detect and prevent an alternate
 signal stack overflow
Message-ID: <2024052322-outage-grit-a4fe@gregkh>
References: <2024052133-CVE-2021-47326-fd53@gregkh>
 <06570587-dc49-4885-83da-7a386f012106@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06570587-dc49-4885-83da-7a386f012106@suse.com>

On Thu, May 23, 2024 at 01:19:17PM +0300, Nikolay Borisov wrote:
> 
> 
> On 21.05.24 г. 17:36 ч., Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > x86/signal: Detect and prevent an alternate signal stack overflow
> > 
> > The kernel pushes context on to the userspace stack to prepare for the
> > user's signal handler. When the user has supplied an alternate signal
> > stack, via sigaltstack(2), it is easy for the kernel to verify that the
> > stack size is sufficient for the current hardware context.
> > 
> > Check if writing the hardware context to the alternate stack will exceed
> > it's size. If yes, then instead of corrupting user-data and proceeding with
> > the original signal handler, an immediate SIGSEGV signal is delivered.
> > 
> > Refactor the stack pointer check code from on_sig_stack() and use the new
> > helper.
> > 
> > While the kernel allows new source code to discover and use a sufficient
> > alternate signal stack size, this check is still necessary to protect
> > binaries with insufficient alternate signal stack size from data
> > corruption.
> > 
> > The Linux kernel CVE team has assigned CVE-2021-47326 to this issue.
> 
> 
> I'd like to dispute this CVE. Basically a process can pass in a
> wrongly-sized stack which will cause its own stack to be corrupted. If
> anything this affects the process rather than the kernel.

Ah, good catch, thanks, I'll go revoke this CVE now.

Thanks for the review, much appreciated!

greg k-h

