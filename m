Return-Path: <linux-kernel+bounces-274108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7631D94737B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259A21F2132A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC8D13C906;
	Mon,  5 Aug 2024 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjwq58C4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F12BCF7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826577; cv=none; b=qJc7Pxjix/qBFRnPtnkafVVLbI9rhhA1p7aMAai9+ratrdPwSf3X+zlu7QeK8Sl2xBom5Zy7yks6jBUaffNoX+/enGYg5zbQwsph5ilSyMamWISpeZxpWbtlvnWyzagMZAUdiPZVUvDXszTWzWO8rRPnsTrxAt7opqwrnYws0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826577; c=relaxed/simple;
	bh=sjiWFhuSLzRE5JZcn98tMBiAlvf1HQyusSh2SItrHtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+qOrKMEMQG3O1dEL4bONIdAElvVSuu5802dzk1DL2v0r1HMMLDzWjoTbl2xgAyTeK3OA9Sl160ZMUPVmKvLtUeZ5rBhhntZ7zR63BNKHb+NQrG9aqM8SNzHKot3rqK1Vkw6G9Ekb5zXV6i3LSqEK+yVAkamODTZcPp7b54NOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjwq58C4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722826574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yrwIVSFERGwwt6j0moOGiSqtU4uf4f8TDmlxeI81KFs=;
	b=bjwq58C4JG2FRqDGFAgLtV7u42qdH3JrsisJLtGJZ1TJkL9eXKuC6Bgt6k0nhjkNeeNF2U
	Sq9JL0Va+oX5y8wW6tuMJvZqOhqRu6hsMBFAibGu43vuote1fYPC72fcI6O4We5ici2PlC
	wHCziBvTBKidIhGK9OQP0ItPeLmpUdA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-R5UQGAO3PwCsK9yP1GNeqg-1; Sun,
 04 Aug 2024 22:56:10 -0400
X-MC-Unique: R5UQGAO3PwCsK9yP1GNeqg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F6CA1955D42;
	Mon,  5 Aug 2024 02:56:08 +0000 (UTC)
Received: from localhost (unknown [10.72.112.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E74019560AA;
	Mon,  5 Aug 2024 02:56:06 +0000 (UTC)
Date: Mon, 5 Aug 2024 10:56:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ARM: Support allocating crashkernel above 4G for LPAE
Message-ID: <ZrA/QWAy2iXl/Oc4@MiWiFi-R3L-srv>
References: <20240802092510.3915986-1-ruanjinjie@huawei.com>
 <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk>
 <6c0a45c3-08a2-f889-9e66-ab8aff66ae8c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c0a45c3-08a2-f889-9e66-ab8aff66ae8c@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/05/24 at 09:23am, Jinjie Ruan wrote:
> 
> 
> On 2024/8/2 19:01, Russell King (Oracle) wrote:
> > On Fri, Aug 02, 2024 at 05:25:10PM +0800, Jinjie Ruan wrote:
> >> As ARM LPAE feature support accessing memory beyond the 4G limit, define
> >> HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH macro to support reserving crash
> >> memory above 4G for ARM32 LPAE.
> >>
> >> No test because there is no LPAE ARM32 hardware.
> > 
> > Why are you submitting patches for features you can't test?
> > 
> > I'm not going to apply this without it being properly tested, because I
> > don't believe that this will work in the generic case.
> > 
> > If the crash kernel is located in memory outside of the lower 4GiB of
> > address space, and there is no alias within physical address space
> > for that memory, then there is *no* *way* for such a kernel to boot.
> 
> I'm sorry that I released this patch without testing it. I actually
> intended to bring up this issue for discussion. If anyone has the
> environment to test it, that would be great. In the meantime, we could
> have a discussion on the significance and relevance of this approach.

I don't know arm32 and its LPAE. I know a little about x86_32 where
crashkernel can only be reserved below 896M because of the virtual
memory layout, and all memory above that is high memory which can't be
used as kernel memory directly. So from this patch, arm32 is different
than x86_32.

> 
> > 
> > So, right now I believe this patch to be *fundamentally* wrong.
> > 
> 


