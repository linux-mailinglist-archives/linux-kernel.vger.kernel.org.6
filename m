Return-Path: <linux-kernel+bounces-414676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B49D2CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D836B38FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8961D0F49;
	Tue, 19 Nov 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHi89DCS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB21D0BAE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035366; cv=none; b=cb7Mv4sdsvmGVyrRtusfmNkJhbCl0Ta9X0fWLkQqrragKzqtU4bnTwdiESBBh3TWDdtWPDMSzFGCkWfGtCIPCzh44s8uo/WxuZkOlAWQSdYkoo/rj2jmUElfCrtVdlhLrttzXrAjx3b2U6bA+bLYdmHF5f5lSXC543oLqDMx9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035366; c=relaxed/simple;
	bh=1qHk9c9UF1EeKWWeqbF/56RTbbac9fdZn150Ee2pIlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miICZJ4V2rlGvbt5+TfT4G4DhtWln7By1I73srHNQZV6WVDnELHHOF7a+sr3PqJNLVYup9pU2j3PtjDctILbm0ew0dinTd2/gexpRlyXSgqIfljsrJ4sRo62y3sa/k4X83P+oUXoBCmG3Z5o+Moy/N7G13IhUayRdzZcoZ3Uu44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHi89DCS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732035363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eZY2bvI9jRohMLC1MiiilGj8lvWI0aPVX7q2WlrGEVY=;
	b=LHi89DCSTUGGCRJjW0POg5SJzUPXeCDINb22xYnWO2Q9hN9DmRuBE4yk52KbolvPvnqJI6
	RG4RnsQ25vNgZj2EakRbnNOV45cuMIhj2S8vRCbQQcm7M9esZnQaPOis8uoPl+PoJXE2cr
	4KbPojI/O+S/ZF7weS9MFZkpZNS17ks=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-Von8AFHlPcutkbqohtcFAg-1; Tue,
 19 Nov 2024 11:56:00 -0500
X-MC-Unique: Von8AFHlPcutkbqohtcFAg-1
X-Mimecast-MFC-AGG-ID: Von8AFHlPcutkbqohtcFAg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E7A419560AD;
	Tue, 19 Nov 2024 16:55:58 +0000 (UTC)
Received: from localhost (unknown [10.22.89.254])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 933AB1956086;
	Tue, 19 Nov 2024 16:55:56 +0000 (UTC)
Date: Tue, 19 Nov 2024 13:55:55 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] iommu/tegra241-cmdqv: do not call smp_processor_id in
 preemptible context
Message-ID: <ZzzDG6FFprnWPnCj@uudg.org>
References: <ZzvZkMKhwmJESpdM@uudg.org>
 <20241119071510.-6OKEw2q@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119071510.-6OKEw2q@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Nov 19, 2024 at 08:15:10AM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-11-18 21:19:28 [-0300], Luis Claudio R. Goncalves wrote:
> > With PREEMPT_RT enabled some of the calls to tegra241_cmdqv_get_cmdq()
> > during boot will happen in preemptible context. As this function calls
> > smp_processor_id(), these calls will trigger a "BUG: using smp_processor_id()
> > in preemptible" backtrace if DEBUG_PREEMPT is enabled.
> 
> If this is only on PREEMPT_RT, where is the disabled preemption coming
> from on !PREEMPT_RT?

You are correct. This is not exclusive to PREEMPT_RT, also happens with the
stock kernel. I ran more tests and this time I made sure DEBUG_PREEMPT was
enabled. That was enough to reproduce the problem.
 
> > As tegra241_cmdqv_get_cmdq() only calls smp_processor_id() to use the
> > CPU number as a factor to balance out traffic on cmdq usage, it is safe
> > to use raw_smp_processor_id() here.
> > 
> > Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> 
> Sebastian
> 
---end quoted text---


