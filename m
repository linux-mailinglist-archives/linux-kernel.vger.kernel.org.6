Return-Path: <linux-kernel+bounces-304092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A8961A20
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17FF1F24656
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 22:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9989D1D4165;
	Tue, 27 Aug 2024 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdKCj9jL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447564A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798900; cv=none; b=RaUZ+19aY/M/OFWogSKq4vmq0kv7eqhYCkgtdRqsbfFGwsfQIEeEa9Htl6wI8sRqc2fPRA/3nsI8LwJirou3Gwiz3pOMTvDRS4rb7fUlzbLInS1jQGK4jqaXW8VJUK+4cnqv/G5/2mL/qIL+MyxkskaWKjO24gV6f6sBeHaUU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798900; c=relaxed/simple;
	bh=YVsPg1Uls31LjJoW/mvo+XDMvkOEypGxK8mPperORbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAMdv+9ZiHPCbywrsCZ/at57qeq4+ncRs3EmVM84ticrMR+F0cCJyf2FltAule/rUEVpEWWnZ7HSIDk0wkYM3nenLF21E+xRDohf458d53329WW2i8I9Cd61uARil1pHGqdcux5stZxDNsK7T0Ihhsw/VgmC1DR1qmHI81GLJX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdKCj9jL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724798896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVWzv4d3wS++awPAHCsT183EQ2Vo8jOynbbMBJW0NUY=;
	b=VdKCj9jLtt6t+0mArfENWFGYZG4J1JJ9AO7X7VHUsKhAQatunReflzpQ822m23e3KGliVL
	KejDAouzlko4MNIenDjQb+NQxYUAQ8m0Q026DVWL+fSWNgDuej3TvgERwZZrYCSC5unGUT
	iDcElz4CP7tViyV+I/GvqV7jNdgZaDo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-M6HYJC8xM8-rvrkCJ4lelQ-1; Tue,
 27 Aug 2024 18:48:13 -0400
X-MC-Unique: M6HYJC8xM8-rvrkCJ4lelQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A89DC19560B0;
	Tue, 27 Aug 2024 22:48:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F1161955D8C;
	Tue, 27 Aug 2024 22:48:07 +0000 (UTC)
Date: Wed, 28 Aug 2024 06:48:03 +0800
From: Baoquan He <bhe@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: k-hagio-ab@nec.com, lijiang@redhat.com,
	Kuan-Ying Lee <kuan-ying.lee@canonical.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ardb@kernel.org
Subject: Re: [PATCH] arm64/vmcore: Add pgtable_l5_enabled information in
 vmcoreinfo
Message-ID: <Zs5Xo5eVUvGMbtSv@MiWiFi-R3L-srv>
References: <20240826065219.305963-1-kuan-ying.lee@canonical.com>
 <20240827122459.GA4679@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827122459.GA4679@willie-the-truck>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/27/24 at 01:24pm, Will Deacon wrote:
> On Mon, Aug 26, 2024 at 02:52:02PM +0800, Kuan-Ying Lee wrote:
> > Since arm64 supports 5-level page tables, we need to add this
> > information to vmcoreinfo to make debug tools know if 5-level
> > page table is enabled or not.
> > 
> > Missing this information will break the debug tool like crash [1].
> > 
> > [1] https://github.com/crash-utility/crash
> > 
> > Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
> > ---
> >  Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
> >  arch/arm64/kernel/vmcore_info.c                | 3 +++
> >  2 files changed, 9 insertions(+)
> 
> In which case, wouldn't you also want to know about pgtable_l4_enabled()?

That is a good question. I guess it's deduced in code, mostly needed for
different PAGE_OFFSET, how to transfer virtual addr to physical addr,
etc.

Add Crash utility experts here.


