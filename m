Return-Path: <linux-kernel+bounces-428472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA079E0EF0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC54F1656C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6301DF748;
	Mon,  2 Dec 2024 22:31:24 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FEC7346F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178684; cv=none; b=udovqgHptBPB24jtLQIMclcaQvfmew/uN/hKjxzkn/es6j+eOBz7PsC/9KDseaqNn1pjuaFFGZQJIzVxzhvWtGNjR5IIO9sO9MJo/rIsLQK/rDp3kDiUDy52c2dgAg6k5HPL3yimpczFiLfgtUMpOEeavtF2F10+L/LnbV/Eq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178684; c=relaxed/simple;
	bh=NoVp15dvRtJu53H7DuhtvcrC5EwpZxTsIpZNGNnrsIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4fSm249Lu4IoEoK/TYH21v8YmMVyulaYPMR1s9XSQT9gYWUEmbDFyOW59IlP+yVjf9OJq4s0Xb/zg9Z56e0JCJ8FGswLxBzWvCsSqwyilbM4lBlJWVrWWlBEc/ubhDdyLlT2Muv7XwnDe7QUn2B5PAX8oR9VLbkfLZng2HA3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 3FBE572C8FB;
	Tue,  3 Dec 2024 01:31:19 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id 33FBF36D0178;
	Tue,  3 Dec 2024 01:31:19 +0300 (MSK)
Date: Tue, 3 Dec 2024 01:31:19 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, james.morse@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, oliver.upton@linux.dev,
	mark.rutland@arm.com
Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Message-ID: <20241202223119.k3uod4ksnlf7gqh2@altlinux.org>
References: <20241202045830.e4yy3nkvxtzaybxk@altlinux.org>
 <20241202153618.GA6834@willie-the-truck>
 <86ttbmt71k.wl-maz@kernel.org>
 <20241202155940.p267a3tz5ypj4sog@altlinux.org>
 <86ser6t6fs.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <86ser6t6fs.wl-maz@kernel.org>

Marc,

On Mon, Dec 02, 2024 at 04:07:03PM +0000, Marc Zyngier wrote:
> On Mon, 02 Dec 2024 15:59:40 +0000,
> Vitaly Chikunov <vt@altlinux.org> wrote:
> > 
> > Marc,
> > 
> > On Mon, Dec 02, 2024 at 03:53:59PM +0000, Marc Zyngier wrote:
> > >
> > > What the log doesn't say is what the host is. Is it 6.13-rc1 as well?
> > 
> > No, host is 6.6.60.
> 
> Right. I wouldn't be surprised if:
> 
> - this v6.6 kernel doesn't hide the MPAM feature as it should (and
>   that's proably something we should backport)

How to confirm this? Currently I cannot find any (case-insensitive)
"MPAM" files in /sys, nor mpam string in /proc/cpuinfo, nor MPAM strings
in `strace -v` (as it decodes some KVM ioctls) of qemu process.

> 
> - you get a nastygram in the host log telling you that the guest has
>   executed something it shouldn't (you'll get the encoding of the
>   instruction)

I requested admins of the box for dmesg output since I don't have root
access myself and nowadays dmesg is not accessible for a user.

> 
> Can you confirm these two things?

Also, I tried to reproduce on another Kunpeng box with slightly
different HiSilicon CPU (presenting to the system as Cortex-A72) and the
problem is not reproducible there.

While things are not resolved, is it possible to workaround the problem
with some QEMU option, kernel command line, config option, or a patch?

Thanks,

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

