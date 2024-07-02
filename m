Return-Path: <linux-kernel+bounces-238293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D109247FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7A9286EF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD31C232A;
	Tue,  2 Jul 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AaNi1ra5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF92F46
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947852; cv=none; b=g3Wmbz5x/SYMcwH4OYybQRi3UIQMQrInSAsNXs9wgWNYCV8+9KotZZppwp2tgLE+x9g5BRjTNHOkPa/ELXvMER6cAAJoGakWFknosXdcSvzmflE3Y/PUg5ewJkWVusTkP4PTdWBaMbT79/GH4XSVsYrphTU2ANUiRCNXO6iwUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947852; c=relaxed/simple;
	bh=lHG2Fl5Hk9swj1oNbituaONP5dUGxnsiHYPfF7AemCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtW4pcD+7k7SfmT+3E+C1d/IkB8C2Li5NJOadneyAKYQFJaBA00PiQcjuoHcacHFDpmZ0lJaypQgnjWrySQikEeraVA2NeW1YZk6UjnOmitq6M8bBWBmlX0lKybW8cNfTPJxQy4YfAKv8vkfT4kUWwCm7Jwm4sfyvSkKOqJ8m78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AaNi1ra5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0487CC116B1;
	Tue,  2 Jul 2024 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719947852;
	bh=lHG2Fl5Hk9swj1oNbituaONP5dUGxnsiHYPfF7AemCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AaNi1ra5bzcBbhsNecJ2NgmK62Mr6psH1AD/Pk3gS0t3/2D9547XEJbsINkRS8jAq
	 wUbSzXj5BTEvJZ7NoMUyWICyDf3CjlsyTVakY5B2mQMXdjgjTNkQBEE1r3IPnok5Sx
	 GqTjEOWTzZ3hDkVlkGJb5ivewc68Or4OnnFBJMhI=
Date: Tue, 2 Jul 2024 21:16:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: CVE-2024-39362: i2c: acpi: Unbind mux adapters before delete
Message-ID: <2024070209-tapping-satchel-a949@gregkh>
References: <2024062550-CVE-2024-39362-2d27@gregkh>
 <364518a3a279657815b631e85f3177880b42f4f7.camel@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364518a3a279657815b631e85f3177880b42f4f7.camel@suse.de>

On Tue, Jul 02, 2024 at 07:05:19PM +0200, Jean Delvare wrote:
> Hi all,
> 
> On Tue, 2024-06-25 at 16:22 +0200, Greg Kroah-Hartman wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > i2c: acpi: Unbind mux adapters before delete
> > (...)
> > 
> > The Linux kernel CVE team has assigned CVE-2024-39362 to this issue.
> 
> I would like to dispute this CVE. I don't quite understand how this bug
> qualifies as a security bug, considering that only root can load and
> unload overlay SSDT tables. The bug can't be triggered on purpose by a
> remote or local unprivileged user.
> 
> The bug causes a warning to be dumped to the kernel log, due to trying
> to unbind a companion device which is already unbound, but as far as I
> can see, that's all. acpi_unbind_one() is a best-effort function, it
> returns 0 no matter what. kernfs_remove_by_ame_ns() will gracefully
> return an error code. I can't see any obvious use-after-free happening
> so I see no way an attacker could exploit this bug.
> 
> So I would cancel this CVE.

Now rejected, thanks for the information.

thanks,

greg k-h

