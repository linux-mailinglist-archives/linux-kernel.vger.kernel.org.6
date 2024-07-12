Return-Path: <linux-kernel+bounces-250224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEF592F569
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97ABA1F22EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD2613D509;
	Fri, 12 Jul 2024 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="TZpNPtny"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408617BBE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765291; cv=none; b=k10p1v51VCfeObaMqeU+uzLC7x0Vt/57TheCXjdGVHkyMCg44POYKbYGJgjZhpw/yJXqeJI/HAKge7yV0rkplANMq3c1D+fv0dPvNv75MfrVCxz3ksXBO8sW8jUuC4gZqypaBcZdF0zpgGdOMjIIapbNVp3cYzplZXhOWSnQN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765291; c=relaxed/simple;
	bh=3l2vyFj9grafGJhTdnx1p3eNHlGipP7REmqRycbtBeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EojSDlQSMKr1+YL/6jAwKJXsOh3ocFeWjGItzg4DZQOsEZUK8XktIb1NPq7kmFgVEFhW/sAxq0Btn7xjH1S9z9yWmwz4T+uEc5v0clC7MpJzqBuBE69GpAoyLmOdmB64rarddnDJlbtCh/q8aNkNsPmm+nKJxJh/LWSODEiEcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=TZpNPtny; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 387C01E26F4;
	Fri, 12 Jul 2024 08:21:25 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1720765285; bh=DgpmFySixGr7lDzA9N2iWV+kFeyL/lu8IgeDM3NaEMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TZpNPtnyuY7O0L5P4z38T+jj4SJt/80D7JNFmou983gl3PHQ3B4OkCwRAHkF2nLT1
	 a6kUHehAZtihhma31k28QT8BgMvfIYkmgkJ0GZWtyKL/UaCfxLlI4I3sDWfuiOTgHF
	 Aujh+qx4HW7a0sRD7SzPxt6N4zHsAYLUJdI92lxjrZnmugfgbFwi8Mnj89oUF2N3L6
	 VoVH73mLXzYhtJ1BOMf46qTv7XYeolE+6LDjBZm3WOqqJALXQC9enlszJ8zy1VtAa3
	 wPclulW5q1myW/TgnY+YmjImxDztYNX5aU2Tq750ajm8w7VyT37tdTWxrLN31J/6wS
	 lcD1LwwnCT+sg==
Date: Fri, 12 Jul 2024 08:21:24 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Petr Tesarik
 <ptesarik@suse.com>
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
Message-ID: <20240712082124.272e079f@meshulam.tesarici.cz>
In-Reply-To: <59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
	<59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 10:00:09 +0530
Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> Hello Petr,
> 
> Just want to mentioned few points about the commit message. No strong
> opinion on changing the commit message.
> 
> On 11/07/24 16:04, Petr Tesarik wrote:
> > From: Petr Tesarik <ptesarik@suse.com>
> >
> > There is no reason to restrict access to this attribute, as it merely
> > reports whether crash elfcorehdr is automatically updated on CPU hot
> > plug/unplug and/or online/offline events.  
> 
> Now, it is not just elfcorehdr; there could be multiple kexec segments 
> based on the architecture's needs.
> For example, on PowerPC, it is elfcorehdr and FDT.

Right. I am even working with a PowerVM LPAR on an L922 system now. ;-)

OTOH I was just too lazy to invent my own description, so I took it
from Documentation/ABI/testing/sysfs-devices-system-cpu. That one
could be improved. And a couple of other places... Expect a patch.

> >
> > Note that since commit 79365026f8694 ("crash: add a new kexec flag
> > for hotplug support"), this maps to the same flag which is
> > world-accessible through /sys/devices/system/memory/crash_hotplug.  
> 
> The previous comment is more relevant for the kexec_load system call.
> 
> For the kexec_file_load system call, the kexec flag introduced in the 
> commit message
> mentioned above is irrelevant. Building kernel with
> CONFIG_CRASH_HOTPLUG is enough.

Yes, but then this sysfs attribute always reads "1".

> > Signedoff-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >   drivers/base/cpu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index c61ecb0c2ae2..73d69791d0d3 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -308,7 +308,7 @@ static ssize_t crash_hotplug_show(struct device
> > *dev, {
> >   	return sysfs_emit(buf, "%d\n",
> > crash_check_hotplug_support()); }
> > -static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
> > +static DEVICE_ATTR_RO(crash_hotplug);  
> 
> I agree, it doesn't have to be readable by admin only.
> 
> Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thank you!

Petr T

