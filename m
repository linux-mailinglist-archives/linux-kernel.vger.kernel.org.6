Return-Path: <linux-kernel+bounces-327581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA7977800
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796C51C24481
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B51C6893;
	Fri, 13 Sep 2024 04:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HKygbx7p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451918953E;
	Fri, 13 Sep 2024 04:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726202202; cv=none; b=Z5t80xtU6o/LJhjdlySd0VEJ/6krS3OMdxkecQIcRImxt3j2UQsyO0HHEa4vJyXvRkouli6WMLmYQ1I1t2FXjhpacV5y/vnqI6sF4T/5wwa61VxytTOcSXXTWnv+AQAgUwXi6GQgFQYRNTW6MUw1fPwucsBS3fMgsU1t1fK7nLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726202202; c=relaxed/simple;
	bh=2eC7Z1RoL9KljFmceL5WcldCYI1dfIgwzb2tMgosLkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8n6iDE9G+0EgQ/PCjaepPcdyBK99bb7SWWkvyHocvwTr74tbMNzGY1qo3W0fpC6ze+YJTz3swauwjhc97M6xIhGHW/iA/F8SwsaHR1l2AyFcJItQllaoLArjT++dW3MZEeYZyBa40EHCbwfHjEJVPdM16ComvIAP5CBsu8zryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HKygbx7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAF9C4CEC0;
	Fri, 13 Sep 2024 04:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726202201;
	bh=2eC7Z1RoL9KljFmceL5WcldCYI1dfIgwzb2tMgosLkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKygbx7p6CnW1Irl+XcBK/6LTmBfiMgCuAZNiITJLc09WVDJojpTFUUCKuc6GpyUt
	 Ruz6TPyXynVEa8M9q2FJ28zqNVnNyioxy5uYyHK7qZGUM20Cd1npBYRr2y6kh18kXL
	 PnkVx76mD9LwnlsEgEhlOXHSB6KRglOvybbxTgvE=
Date: Fri, 13 Sep 2024 06:36:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	rafael@kernel.org, yoshihiro.toyama@sony.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] Add framework for user controlled driver probes
Message-ID: <2024091327-repacking-avatar-ec23@gregkh>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>

On Wed, Sep 11, 2024 at 07:53:17PM +0530, Nayeemahmed Badebade wrote:
> Hi,

If Rob hadn't responded, I wouldn't have noticed these as they ended up
in spam for some reason.  You might want to check your email settings...

> This patch series introduces a new framework in the form of a driver
> probe-control, aimed at addressing the need for deferring the probes
> from built-in drivers in kernels where modules are not used.

Wait, why?

> In such scenario, delaying the initialization of certain devices such
> as pcie based devices not needed during boot and giving user the control
> on probing these devices post boot, can help reduce overall boot time.
> This is achieved without modifying the driver code, simply by configuring
> the platform device tree.

PCI devices should not be on the platform device tree.

And what's wrong with async probing?  That was written for this very
issue.

> This patch series includes 2 patches:
> 
> 1) dt-binding document for the probe-control driver
>    This document explains how device tree of a platform can be configured
>    to use probe-control devices for deferring the probes of certain
>    devices.

But what does that have to do with PCI devices?

> 2) probe-control driver implementation
>    This provides actual driver implementation along with relevant ABI
>    documentation for the sys interfaces that driver provides to the user:
>    /sys/kernel/probe_control/trigger - For triggering the probes

What's wrong with the existing userspace api to trigger a probe again?
Why doesn't that work?

I think you need to explain and prove why the existing apis we have that
were designed to resolve stuff like this don't work.

And if you all are abusing platform drivers and the bus there, well, I
hate to say I told you so, but...

thanks,

greg k-h

