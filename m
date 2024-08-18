Return-Path: <linux-kernel+bounces-290901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E82955AFD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0369FB210D8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 05:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC6E947A;
	Sun, 18 Aug 2024 05:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gB8LQCYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C05442C
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723957982; cv=none; b=YRIKbjUHX9EynSKb/ml21uTejJIT0AkIAjOTF2g31GFwEkSAR6Y7zB+1LX9H/SSlbndn8I9cFiSvithoGp7y3i6iX6RegRguCXkH4v9EDcH8IYCZEguPIcDHxyNgrwB8egHewIWNDtuGIFCG+K5vgT8JiUrjJwhof1OgACHasR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723957982; c=relaxed/simple;
	bh=eKgnAm4KSSYPDXAsF1ZEVtdLYW6zbqKZuZo5KjZEwdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvfK69/wjFoFuOh6afFh7ca9BXBxe0j3qD02ZPL10OrYkaZgidhW+Zt9Za0WrWTFZiAmaOd7C+oXkfsErqGzZpDMjkhPsv+EseRgLAmHAcmgXIlIS/ZYDYyI4p7m2sf+RusIcYpbtw334nS6aObERVmj0kYMQ2P2PKb4OlEEyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gB8LQCYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC37C32786;
	Sun, 18 Aug 2024 05:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723957981;
	bh=eKgnAm4KSSYPDXAsF1ZEVtdLYW6zbqKZuZo5KjZEwdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gB8LQCYIZQDrrtQSuGRL3HSh52U3WNmavQdEV5P9v44k7d4hhMhXOXi90Lm17L4ri
	 8hLKLEC2DxrenRbZjbgQ/1BN/h771Y51sE2isdK6yX6tqDmzfRCywKCNus2P/w+crB
	 6DmRYRqLCxioasKDVPTPCdRo3KNYp9aOUBaopGeI=
Date: Sun, 18 Aug 2024 07:12:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: nerdopolis <bluescreen_avenger@verizon.net>
Cc: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, tglx@linutronix.de, tony@atomide.com,
	linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: VT-less kernels, and /dev/console on x86
Message-ID: <2024081821-taps-briskly-c23f@gregkh>
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
 <2669238.7s5MMGUR32@nerdopolis2>
 <ZsFJSYI3EVjC8p5W@archie.me>
 <4805768.rnE6jSC6OK@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4805768.rnE6jSC6OK@nerdopolis2>

On Sat, Aug 17, 2024 at 10:31:17PM -0400, nerdopolis wrote:
> The thought is that when distributions eventually decide to go VT-less they are
> not going to want to change the kernel boot options in the bootloader config to
> force console=ttynull, and might want this to happen automatically.

If/when they want to do this, odds are a command line will be fine, or
they will build in ttynull properly into their kernels.

thanks,

greg k-h

