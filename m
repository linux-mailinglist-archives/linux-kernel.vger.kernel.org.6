Return-Path: <linux-kernel+bounces-434575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A19E687A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983F2286187
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA91DE4C7;
	Fri,  6 Dec 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sfxCLlT9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BAF19CCF9;
	Fri,  6 Dec 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472695; cv=none; b=oCbYaL23ml6OsBA5Xq1Qm5JT5AaASrACi627N395VA04qxoN4U67IQVhtN+SGIfleBeRyHdLm4yQpIactr7O2g7YSzMm2gzB/FletF4WX+niJwsqM3P/61D3O1vhHsjeZI0vvzm+lGaX4T9WDaQdyKB8AGu0UYIgk9EYCOv+GWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472695; c=relaxed/simple;
	bh=K2D4K5BGp4Xkbz+HqakrV5Ja1cEWXONUVLEXUilhKdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5dHw2qlkpp+kNGDzaEKE79uuoBMmf0ugcPaAZx4Qs8Pa6kNnCmTaFREQLSLcYzNhJxYu6CXnV3b8hllqLp/HxCp8zgwdc5B0juAauCHGiadNKmxYl2jOwrf8meIMk3rF8xDfUAhybrMKldVP9gTaiIZYzKWbE6AeFjIKuLsI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sfxCLlT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5BCC4CED1;
	Fri,  6 Dec 2024 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733472694;
	bh=K2D4K5BGp4Xkbz+HqakrV5Ja1cEWXONUVLEXUilhKdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfxCLlT9LLuohDpc2cQPB7JhjghniyO9CALoIIjc/sYdQVewEBQhh+GT8+fPnxuSj
	 Opv6B92h+U1UqfYPDslf7ugl6nqBpX+uwNtdcHdMkGStGXEUgIkHJy6ok6rOt/zO2m
	 QhWNLDmQQiGM0y4EdC9c6AZygN6m3EdkH57orRjY=
Date: Fri, 6 Dec 2024 09:11:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 0/5] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <2024120622-unvalued-wriggle-7942@gregkh>
References: <20241205162531.1883859-1-lee@kernel.org>
 <2024120632-hardwired-hardhead-1906@gregkh>
 <20241206074443.GJ8882@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206074443.GJ8882@google.com>

On Fri, Dec 06, 2024 at 07:44:43AM +0000, Lee Jones wrote:
> On Fri, 06 Dec 2024, Greg KH wrote:
> 
> > On Thu, Dec 05, 2024 at 04:25:17PM +0000, Lee Jones wrote:
> > > It has been suggested that the driver should use dev_info() instead of
> > > pr_info() however there is currently no scaffolding to successfully pull
> > > a 'struct device' out from driver data post register().  This is being
> > > worked on and we will convert this over in due course.
> > 
> > But the miscdevice.rs change provides this to you, right?  Or if not,
> > why not?
> 
> This does allow us to pull the 'struct device *` out from `struct
> miscdevice`; however, since this resides in MiscDeviceRegistration,
> which we lose access to after .init, we have no means to call it.
> 
> Alice is going to work on a way to use ThisModule to get the
> MiscDeviceRegistration reference back from anywhere in the module. Until
> that piece lands, we can't call MiscDeviceRegistration::device() outside
> of RustMiscDeviceModule.

That seems crazy, as ThisModule shouldn't be dealing with a static misc
device, what happens for dynamically created ones like all
normal/sane/non-example drivers do?  This should "just" be a dynamic
object that is NOT tied to the module object, or worst case, a "static"
structure that is tied to the module I guess?

Anyway, I'll let you all work it out, good luck!

greg k-h

