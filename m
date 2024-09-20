Return-Path: <linux-kernel+bounces-334248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B4897D486
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A39B1C224B1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF51313E04C;
	Fri, 20 Sep 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xu64s7aN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363F39FF2
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726830205; cv=none; b=NtUiNAmGNhpBVKnO1trhWIx4Bto0q48/rhfOYt/1kSTM3E5PXAPcJvRsNCpocl1305T085khv/qOpq3xSI5Cs9wx22hlT/SVOVNzUw1aAYWLqSHf1+1+ZUyNSbk1E9gGGPnVPGs34J1/msBFJv41HkdLfVteQ9GAElU4uUmFkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726830205; c=relaxed/simple;
	bh=t6PyiaU+q5uLSGJpe7i/vY50/CfRtYLyGpxj/y9mOkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuL93o0co9deu1ctahbfYLAwgQ/DsLgV1MSgzWQmqCc5QScT9Ui/IEcyAbljN16tQutKQnh+g6P/yut9nX7NJqoQKGi5NPUnjH5xDXvLQVdNsbBzi5py2awT7xMR8MkxjThZ6Nbl6b5SJFbXX09zJ69w2TrEj0ImIF7MliZoyF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xu64s7aN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726830202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pdqIvSPYWLb/TIk+26OrGjim3sMahhGwrllbas8MQY=;
	b=Xu64s7aNP6qGyOQTBkVprOZA1iu2mbe4qXThBej+F7UAAogWTTj5m2SthdWpbbbhVdeRdl
	SLamTzympBX2zJVUInq7gVxRCtYzQ2QiDbX8aNgly0n42iv9kFhqsWjMPNvufCks/nInV4
	qB9Z1T1MgzMEjYI4zyHBNKijOU2naPM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-4iI78YvhOFmvGhS3JrhF-A-1; Fri,
 20 Sep 2024 07:03:20 -0400
X-MC-Unique: 4iI78YvhOFmvGhS3JrhF-A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64F1E192DE09;
	Fri, 20 Sep 2024 11:03:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.115])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8B7C819560AA;
	Fri, 20 Sep 2024 11:03:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 20 Sep 2024 13:03:07 +0200 (CEST)
Date: Fri, 20 Sep 2024 13:03:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <20240920110301.GB15795@redhat.com>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/20, Liao, Chang wrote:
>
> 在 2024/9/19 22:18, Oleg Nesterov 写道:
> > On 09/19, Liao Chang wrote:
> >>
> >> --- a/arch/arm64/kernel/probes/uprobes.c
> >> +++ b/arch/arm64/kernel/probes/uprobes.c
> >> @@ -17,12 +17,16 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> >>  	void *xol_page_kaddr = kmap_atomic(page);
> >>  	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
> >>
> >> +	if (!memcmp(dst, src, len))
> >> +		goto done;
> >
> > can't really comment, I know nothing about arm64...
> >
> > but don't we need to change __create_xol_area()
> >
> > 	-	area->page = alloc_page(GFP_HIGHUSER);
> > 	+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> >
> > to avoid the false positives?
>
> Indeed, it would be safer.
>
> Could we tolerate these false positives? Even if the page are not reset
> to zero bits, if the existing bits are the same as the instruction being
> copied, it still can execute the correct instruction.

OK, agreed, the task should the same data after page fault.

Oleg.


