Return-Path: <linux-kernel+bounces-246961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8892C95A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3F91F241D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55083BBD8;
	Wed, 10 Jul 2024 03:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsorQ4sk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD46482D8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582839; cv=none; b=tua8FvqYQiMm7GUQXJCkNk/9SfUWCin1bmAcRCF2D1yLXO1cE+M/X/jlzAfSYFOo/B0j6/D2XMdVKTFpwwOeCmijusCH2nBU0LbiARi78WrO7R2YunSibvQO/uvA8+qWvr0e2eaNPVk5Punbl8VAbxvmBXJdSEHLzWCZC64Mgsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582839; c=relaxed/simple;
	bh=599OQloIs27iSA5C5IQnRs9s17+cjBMwfJ++8cZE6ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJTp+t1seV1zgd/0HfNT46TKka3yPIAMbcVmVvjeaqkoI7fNx9tzpJ/K5ypzTpHOiG6ZbcLcvtekI+q4wTYI4DHHNYYC/PVSOb5a2txk+S7LfwN9enqtVbGtIb04cpF/s/kYg+RX9a+c8DCifdPaqtP4qJcAfooeVPYJv7Rv7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsorQ4sk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720582835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TDO9TiwXKhQArR/husLC6W35eQMaOfa6OJltOm3NtHE=;
	b=QsorQ4skeG1LPvE1zZ1ZzueyiRgtKWaV5KrNYww48luf8KMjt3qZwH3rHbo807GuIJsRC3
	fq2J+greB3+NJ+Cy9Ozv39vUZnDFl2GKyZp6+be3ltMNVtLwa+1yCuDMqLspmXhiXhynR8
	JKpjZAE2nnATc8HQ2gK8atp6fnpby4o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-evszWIkEP4igK3S0oBR-Zw-1; Tue,
 09 Jul 2024 23:40:28 -0400
X-MC-Unique: evszWIkEP4igK3S0oBR-Zw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05811195609E;
	Wed, 10 Jul 2024 03:40:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36E751955F40;
	Wed, 10 Jul 2024 03:40:21 +0000 (UTC)
Date: Wed, 10 Jul 2024 11:40:15 +0800
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
Message-ID: <Zo4CnwD28TbiknVy@MiWiFi-R3L-srv>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
 <Zo0DCVXvCryDr7WN@MiWiFi-R3L-srv>
 <3157befe-431f-69ac-b9d3-7a8685ba3a4d@huawei.com>
 <Zo0TbmSnHbiz5YQn@MiWiFi-R3L-srv>
 <01869981-b1de-32cb-bd25-d6ea09752b3d@huawei.com>
 <Zo1D9sB0UTOIrApP@MiWiFi-R3L-srv>
 <8aed5c59-090b-ea7e-020c-dd2785ee3d7e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aed5c59-090b-ea7e-020c-dd2785ee3d7e@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/10/24 at 09:52am, Jinjie Ruan wrote:
> 
> 
> On 2024/7/9 22:06, Baoquan He wrote:
> > On 07/09/24 at 07:06pm, Jinjie Ruan wrote:
> >>
> >>
> >> On 2024/7/9 18:39, Baoquan He wrote:
> >>> On 07/09/24 at 05:50pm, Jinjie Ruan wrote:
> >>>>
> >>>>
> >>>> On 2024/7/9 17:29, Baoquan He wrote:
> >>>>> On 07/08/24 at 09:33pm, Jinjie Ruan wrote:
> >>>>>> Currently, x86, arm64, riscv and loongarch has been switched to generic
> >>>>>> crashkernel reservation. Also use generic interface to simplify crashkernel
> >>>>>> reservation for arm32, and fix two bugs by the way.
> >>>>>
> >>>>> I am not sure if this is a good idea. I added the generic reservation
> >>>>> itnerfaces for ARCH which support crashkernel=,high|low and normal
> >>>>> crashkernel reservation, with this, the code can be simplified a lot.
> >>>>> However, arm32 doesn't support crashkernel=,high, I am not sure if it's
> >>>>> worth taking the change, most importantly, if it will cause
> >>>>> misunderstanding or misoperation.
> >>>>
> >>>> Yes, arm32 doesn't support crashkernel=,high.
> >>>>
> >>>> However, a little enhancement to the generic code (please see the first
> >>>> patch), the generic reservation interfaces can also be applicable to
> >>>> architectures that do not support "high" such as arm32, and it can also
> >>>> simplify the code (please see the third patch).
> >>>
> >>> Yeah, I can see the code is simplified. When you specified
> >>> 'crashkernel=xM,high', do you think what should be warn out? Because
> >>> it's an unsupported syntax on arm32, we should do something to print out
> >>> appropriate message.
> >>
> >> Yes, you are right! In this patch it will print "crashkernel high memory
> >> reservation failed." message and out for arm32 if you specify
> > 
> > That message may mislead people to believe crashkernel=,high is
> > supported but reservation is failed, then a bug need be filed for this?
> > We may expect a message telling this syntax is not supported on this
> > ARCH.
> 
> "CRASH_ADDR_LOW_MAX >= CRASH_ADDR_HIGH_MAX" indicate that the arm32 does
> not support "crashkernel=,high", I wonder if this is generic for similar

Imagine you are a testing engineer or a distros user, how do you know
if "CRASH_ADDR_LOW_MAX >= CRASH_ADDR_HIGH_MAX" when you test
'crashkernel=,high' and see the failure message?

> architecture. If so, the first patch can print such as
> "crashkernel=,high is not supported on this ARCH" message.

Please consider conprehensively if this is doable, you can paste
draft code here to prove it.

> 
> > 
> >> 'crashkernel=xM,high because "CRASH_ADDR_LOW_MAX" and
> >> "CRASH_ADDR_HIGH_MAX" is identical for arm32. And it should also warn
> >> out for other similar architecture.
> >>
> >>
> >>>
> >>>
> >>
> > 
> > 
> 


