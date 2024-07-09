Return-Path: <linux-kernel+bounces-245996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A202592BC7B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4A4280E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B79018C325;
	Tue,  9 Jul 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpaOzP05"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A857257D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534027; cv=none; b=omRePOiJftqVXJYwhAtubE05wuQBESfY6lWOqXSQCz+4F+qXD9AefbjlULRhNGa94JoSKoBI7sxazP0pKJc8Wt9rRkt2Fj6P1uO91lHz7rsMErMPaC+5duNW7JaKGP5tS/oqfJLD4KoRxMqilHKk5ZTExzZMQwtYgKcRNHDeaiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534027; c=relaxed/simple;
	bh=t6JT6FrSnzv8XklnrYODeF0tSvh6kmlSctN4+IJkZHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIAXZL/VSlaiAZXHVAY1d6PAVtyP8k2smOBytoFMpFIJVHYGSu6nfaYn2G3k2LzZU+JtjoGLfSifcQn6p6/yOrtf1maIvUZ1dkmdNdvdxAmTH0Hoj+JUr9lhBhOVXZ9GFj/1CsL7XA1zxFR4YAZi79uF3TGqZt8FWLiWNKAko3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpaOzP05; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720534025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1OvITzQjJfVx93jTak0ogpbPRj+PPTTq5u2++xH/IGU=;
	b=CpaOzP05Gyj27lzMyQPHi8xoM/Z+rBcRxKs19/OHvfMQ77B0LHVk5n0XD2mrUD982NKDNz
	gfm0dugSX0ooLKufWhHkYD/bQFv6ize0C4t/VMgX9glVrcvWkORogL8aPODhCpdMr9j/6t
	+H5dcq+uN4P4WV60qo9lb7LqdB+7aBI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-vAVNTGRxNn6VOLqt5XrmoQ-1; Tue,
 09 Jul 2024 10:06:59 -0400
X-MC-Unique: vAVNTGRxNn6VOLqt5XrmoQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEAF81958B3D;
	Tue,  9 Jul 2024 14:06:52 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 810AF1955E70;
	Tue,  9 Jul 2024 14:06:50 +0000 (UTC)
Date: Tue, 9 Jul 2024 22:06:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, vgoyal@redhat.com, dyoung@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	rmk+kernel@armlinux.org.uk, linus.walleij@linaro.org,
	eric.devolder@oracle.com, gregkh@linuxfoundation.org, deller@gmx.de,
	javierm@redhat.com, robh@kernel.org, thunder.leizhen@huawei.com,
	austindh.kim@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] ARM: Use generic interface to simplify crashkernel
 reservation
Message-ID: <Zo1D9sB0UTOIrApP@MiWiFi-R3L-srv>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
 <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
 <3157befe-431f-69ac-b9d3-7a8685ba3a4d@huawei.com>
 <Zo0TbmSnHbiz5YQn@MiWiFi-R3L-srv>
 <01869981-b1de-32cb-bd25-d6ea09752b3d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01869981-b1de-32cb-bd25-d6ea09752b3d@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/09/24 at 07:06pm, Jinjie Ruan wrote:
> 
> 
> On 2024/7/9 18:39, Baoquan He wrote:
> > On 07/09/24 at 05:50pm, Jinjie Ruan wrote:
> >>
> >>
> >> On 2024/7/9 17:29, Baoquan He wrote:
> >>> On 07/08/24 at 09:33pm, Jinjie Ruan wrote:
> >>>> Currently, x86, arm64, riscv and loongarch has been switched to generic
> >>>> crashkernel reservation. Also use generic interface to simplify crashkernel
> >>>> reservation for arm32, and fix two bugs by the way.
> >>>
> >>> I am not sure if this is a good idea. I added the generic reservation
> >>> itnerfaces for ARCH which support crashkernel=,high|low and normal
> >>> crashkernel reservation, with this, the code can be simplified a lot.
> >>> However, arm32 doesn't support crashkernel=,high, I am not sure if it's
> >>> worth taking the change, most importantly, if it will cause
> >>> misunderstanding or misoperation.
> >>
> >> Yes, arm32 doesn't support crashkernel=,high.
> >>
> >> However, a little enhancement to the generic code (please see the first
> >> patch), the generic reservation interfaces can also be applicable to
> >> architectures that do not support "high" such as arm32, and it can also
> >> simplify the code (please see the third patch).
> > 
> > Yeah, I can see the code is simplified. When you specified
> > 'crashkernel=xM,high', do you think what should be warn out? Because
> > it's an unsupported syntax on arm32, we should do something to print out
> > appropriate message.
> 
> Yes, you are right! In this patch it will print "crashkernel high memory
> reservation failed." message and out for arm32 if you specify

That message may mislead people to believe crashkernel=,high is
supported but reservation is failed, then a bug need be filed for this?
We may expect a message telling this syntax is not supported on this
ARCH.

> 'crashkernel=xM,high because "CRASH_ADDR_LOW_MAX" and
> "CRASH_ADDR_HIGH_MAX" is identical for arm32. And it should also warn
> out for other similar architecture.
> 
> 
> > 
> > 
> 


