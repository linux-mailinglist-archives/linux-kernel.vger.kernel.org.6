Return-Path: <linux-kernel+bounces-275849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34968948AF3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6583E1C22516
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E98C1BC9F0;
	Tue,  6 Aug 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIELLrZd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF4A165F1A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931911; cv=none; b=OXEjUFqAUDt5YTts5mEWE5eyTdvIJWeVVvurASTrjtYB6bfY4SSi2A6ce+FgLgfNW9JnI5z4EyAgjW2Ej1UJTL4aK6eokSm7ngqCya5URF9ySoDbZH/mh++B1ahCpStR529vocW+QVwC6GRw+gpPYQIwcQ3qGLG+S+Y1rY2vTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931911; c=relaxed/simple;
	bh=fFvXSn7y8QAzhWry964V1uO9InM4O4VG8JD6isaPz38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNQozBQ6/kRx3hXgpJtrBISVJiKVJ7BcoM+QWEfAGbgTnBXZbDj+vgB1ToTRxOetOxQQ2aspZzDO1qnxbKiRrpZtGUQ1nxC09flLFRc+tJz5RuVI/0Q6gW7iIybYinbZVd3uXyW7cZkYXXM2hXDhMokQP/UipvHMGLDLgDmQsd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIELLrZd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722931908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHO1YRd7Z5qSKKfdGtZUE/raKHBQn9k3mnGPYA/b5zE=;
	b=MIELLrZdiiJDUb6dMAP6Fr3rPlY6cxq50v7a8v/PJ8DtppCdq0DWL7w1807GPf9+gIoJhv
	ytzJ0RiHO8oL2pKAlRn4hY6rvXB1urZEydma26j5SUsoPKYl2kHDIBFmMgDkIDZ84uktgD
	H5JhEsy8+Zjs2l720+kV7WgF55lPJ/A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-yesapWGmOAuHxFvULAbdHg-1; Tue,
 06 Aug 2024 04:11:44 -0400
X-MC-Unique: yesapWGmOAuHxFvULAbdHg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 500631955BFC;
	Tue,  6 Aug 2024 08:11:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3B011956046;
	Tue,  6 Aug 2024 08:11:40 +0000 (UTC)
Date: Tue, 6 Aug 2024 16:11:30 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: Support allocating crashkernel above 4G for LPAE
Message-ID: <ZrHasuAXM2Ph9V5p@MiWiFi-R3L-srv>
References: <20240802092510.3915986-1-ruanjinjie@huawei.com>
 <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk>
 <6c0a45c3-08a2-f889-9e66-ab8aff66ae8c@huawei.com>
 <ZrA/QWAy2iXl/Oc4@MiWiFi-R3L-srv>
 <8f051483-46be-87b6-03bb-5e0d145a2ac3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f051483-46be-87b6-03bb-5e0d145a2ac3@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/06/24 at 10:46am, Jinjie Ruan wrote:
> 
> 
> On 2024/8/5 10:56, Baoquan He wrote:
> > On 08/05/24 at 09:23am, Jinjie Ruan wrote:
> >>
> >>
> >> On 2024/8/2 19:01, Russell King (Oracle) wrote:
> >>> On Fri, Aug 02, 2024 at 05:25:10PM +0800, Jinjie Ruan wrote:
> >>>> As ARM LPAE feature support accessing memory beyond the 4G limit, define
> >>>> HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH macro to support reserving crash
> >>>> memory above 4G for ARM32 LPAE.
> >>>>
> >>>> No test because there is no LPAE ARM32 hardware.
> >>>
> >>> Why are you submitting patches for features you can't test?
> >>>
> >>> I'm not going to apply this without it being properly tested, because I
> >>> don't believe that this will work in the generic case.
> >>>
> >>> If the crash kernel is located in memory outside of the lower 4GiB of
> >>> address space, and there is no alias within physical address space
> >>> for that memory, then there is *no* *way* for such a kernel to boot.
> >>
> >> I'm sorry that I released this patch without testing it. I actually
> >> intended to bring up this issue for discussion. If anyone has the
> >> environment to test it, that would be great. In the meantime, we could
> >> have a discussion on the significance and relevance of this approach.
> > 
> > I don't know arm32 and its LPAE. I know a little about x86_32 where
> > crashkernel can only be reserved below 896M because of the virtual
> > memory layout, and all memory above that is high memory which can't be
> > used as kernel memory directly. So from this patch, arm32 is different
> > than x86_32.
> 
> Hi，Baoquan
> 
> Does the following code make sense? Now parse_crashkernel() use
> HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH macro to parse "high", but use
> CONFIG_64BIT when reserving "low" memory in reserve_crashkernel_low().

I am fine with it. BUT have you addressed Russell's concern, e.g how to
test it actually?

> 
> And when LPAE is enabled in ARM32, and "high" is reserved,
> reserve_crashkernel_low() need also function ok.
> 
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -354,7 +354,7 @@ early_param("crashkernel", parse_crashkernel_dummy);
>  #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>  static int __init reserve_crashkernel_low(unsigned long long low_size)
>  {
> -#ifdef CONFIG_64BIT
> +#ifdef HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
>         unsigned long long low_base;
> 
> 
> > 
> >>
> >>>
> >>> So, right now I believe this patch to be *fundamentally* wrong.
> >>>
> >>
> > 
> > 
> 


