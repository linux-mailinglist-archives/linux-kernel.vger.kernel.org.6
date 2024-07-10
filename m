Return-Path: <linux-kernel+bounces-247684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5E092D300
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907C81C21260
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88345192B95;
	Wed, 10 Jul 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NRf+JlPe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF1A1DDC5;
	Wed, 10 Jul 2024 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618860; cv=none; b=Tq2Pftd2B8tEQaki7gv3IN89qekIr0tvVmliaj0V1pObLAYSrR+qjBjoqeRjh34hMoYWFYiiVUvcsWJJsrSeZPn8pTgYnMSQqz/pelG/+f1Tq5FQfMJRxR7rVuHdYBphigG0R5RSIPtGCgf+HdGp0/5X/XJ+bxXPrs105kOQmeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618860; c=relaxed/simple;
	bh=vTbKL04w3i37qu8dEFKYaIUhWj6ebXHTd3S1c+PVmOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmii5AAiXocgy/B6iZQqTXZF+E8RlL98lT1urq0AclmeScfSzSL6VmFhaGYF57CcSAcNPMPACT9XTEF4scDS63ZdJe6DORnXklZ8+xsBtDk/6odztVvytBzNWF5t/MPlB3JcYJNUCwjOF9iy+91tgG+X0nWgro/5GXcL+6o3YiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NRf+JlPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D8BC32782;
	Wed, 10 Jul 2024 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720618860;
	bh=vTbKL04w3i37qu8dEFKYaIUhWj6ebXHTd3S1c+PVmOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRf+JlPeGW8kMoLvRrlVl03rodOdAfIyN8pD3UKnpiyM5vuvQmAqK/wkyzGDFI9BH
	 gs97kSYY1gLnAi6CFHUOaRqZyn6TPTXyTdqh4uDa/DzdiWlifs7tyNH50iFR6vBYrg
	 zCL/1u7Yr4OuKXJGF390XQ6hV9JNVOyxnCDCX+Ow=
Date: Wed, 10 Jul 2024 15:40:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_uac2: fix non-newline-terminated function
 name
Message-ID: <2024071048-science-footprint-ee8e@gregkh>
References: <20240708142553.3995022-1-jkeeping@inmusicbrands.com>
 <2024071022-exemplary-zipping-1f34@gregkh>
 <Zo6M2RntMo6Qnx3B-jkeeping@inmusicbrands.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6M2RntMo6Qnx3B-jkeeping@inmusicbrands.com>

On Wed, Jul 10, 2024 at 02:30:01PM +0100, John Keeping wrote:
> On Wed, Jul 10, 2024 at 01:53:22PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 08, 2024 at 03:25:53PM +0100, John Keeping wrote:
> > > Most writes to configfs handle an optional newline, but do not require
> > > it.  By using the number of bytes written as the limit for scnprintf()
> > > it is guaranteed that the final character in the buffer will be
> > > overwritten.
> > > 
> > > This is expected if it is a newline but is undesirable when a string is
> > > written "as-is" (as libusbgx does, for example).
> > 
> > So we are changing kernel functionality because a userspace program does
> > not work?  Why not fix the userspace program?
> 
> This file behaves differently from every other sysfs/debugfs/configfs
> file AFAICT.  In most places the behaviour of the following two commands
> is equivalent:
> 
> 	$ echo foo >file
> 
> 	$ printf foo >file
> 
> But for this function_name the result is that the final character is
> dropped unconditionally, so the name reported in the USB descriptors
> will be "fo" in the second case.
> 
> > > Update the store function to strip an optional newline, matching the
> > > behaviour of usb_string_copy().
> > 
> > This changes the behaviour of a lot of configfs files right?  What will
> > break if this happens?
> 
> No, this is just one file in f_uac2.
> 
> I can't see any scenario where a newline in a USB string descriptor
> makes sense so it's unlikely to break any existing use cases.
> 
> This brings the audio function name more in line with other string
> descriptors for the device manufacturer/product or configuration name
> which use usb_string_copy() and strip a trailing newline if it's
> present.

Ok, thanks for the added info, now applied.

greg k-h

