Return-Path: <linux-kernel+bounces-247547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380CA92D10C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0585B24227
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC59190688;
	Wed, 10 Jul 2024 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CJNgXHKh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20B18FA39;
	Wed, 10 Jul 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612405; cv=none; b=svjsbxPCPj4czcR5yGKgA+w1ArP9z54mHfgFOIUC78g3QziqeLmDj2wPG5IOwrZHWw2l6ZOUOHK874xO89GUezcsrNmlSwNP/CGRbiCG5CFUq3rvNQLEk2UBSgo2CNINK9lJ5WWToyJhLv6ROrfwVxwLv3Xj5+NfmlJzQwehZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612405; c=relaxed/simple;
	bh=GBMfT1rAcVrjpxbrTdRxior8kzD06WhIOhpG/mnRcrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNgFNfmirojEB+/vIJpn8R4Z5xLDRvymhS1444atDYSkDefgP3kjPqNslR74Ef06N3ARH1opxbi0jPcM8T6EaYtZRzWPIwMlxyc5hnpr2ct24gKJbihkhiZeVRcjvCmK3BL0FNuNFdP4DGzano5wBwCj4IKbqzvNfql0JYuBJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CJNgXHKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2236C32781;
	Wed, 10 Jul 2024 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720612405;
	bh=GBMfT1rAcVrjpxbrTdRxior8kzD06WhIOhpG/mnRcrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJNgXHKhpNvFlr+7RkhyTEjJNaamk6CkiaBZ5FsLlw6FFTOXmYmNJPqDp3PU7krAn
	 qN/MoRcFJpbygN+ATpDOqp/SrMQJAkYAeG7jb5micWlroxcvFmbYk+5APKpRhxvyTl
	 1PFGQpwGsvJvSHMVOqE9p0YtAq5AGtXo1ZV+edG0=
Date: Wed, 10 Jul 2024 13:53:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_uac2: fix non-newline-terminated function
 name
Message-ID: <2024071022-exemplary-zipping-1f34@gregkh>
References: <20240708142553.3995022-1-jkeeping@inmusicbrands.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708142553.3995022-1-jkeeping@inmusicbrands.com>

On Mon, Jul 08, 2024 at 03:25:53PM +0100, John Keeping wrote:
> Most writes to configfs handle an optional newline, but do not require
> it.  By using the number of bytes written as the limit for scnprintf()
> it is guaranteed that the final character in the buffer will be
> overwritten.
> 
> This is expected if it is a newline but is undesirable when a string is
> written "as-is" (as libusbgx does, for example).

So we are changing kernel functionality because a userspace program does
not work?  Why not fix the userspace program?

> Update the store function to strip an optional newline, matching the
> behaviour of usb_string_copy().

This changes the behaviour of a lot of configfs files right?  What will
break if this happens?

thanks,

greg k-h

