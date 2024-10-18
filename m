Return-Path: <linux-kernel+bounces-370874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CEF9A331F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71A71F233B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3240156960;
	Fri, 18 Oct 2024 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ycs27AlH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0352F9B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220443; cv=none; b=DJvRo02b8IQprzQS0PSJYfMvS4aH14wN013Dl/9eV2P8ypSzU7Ma/RcQDc8MZLVKBq5oC/n+RXRlPW7iupVK5RdYxyKWbk+gGyMTyzJKSlY6LWevki9aiPhRIGuRBQ4EZMG4J2S5H74AaHwnNFCamycWLRd1OC7mgecIeLw/4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220443; c=relaxed/simple;
	bh=eBN38igVUpmVxeiTa03c96BwxlapOZr/2lV+Xa8R4EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyBS9TlzlwrCW43Z/38GpKsioiFTryEZ7UtJmXzleylf7aoeX6ZcI9GAL5/jecyLq+RrL0u8sOql8DiP4TW625qOXskpop/S+C5su37JugNMRe5NYUSX/6mggYGNaz4ZaMS4vJdwQIa/VYwWKRGHPmS0ZEq81xWBPJXpu6Mt57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ycs27AlH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729220440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+PqcdpWNS4u7ZHFgo8/hLkbYu5t2LAmdihHzmnrPdo=;
	b=Ycs27AlHHtHvM8ZfaiMiczYrGKD5hMS0/PN5Od2G42D4fbCU/etx175ysntQDhvGBdRKtQ
	WnroIgfN/ZoRyU2FQAvnX0N08fsXnheuC0cp1e+guIalEl16/FlEPxSk27meLAW2jK4Xqo
	lzV+nH67QWUA2LpKIY/tJqCypB0t0kk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-15MAYLMPP6OTtrhbesPwiw-1; Thu,
 17 Oct 2024 23:00:36 -0400
X-MC-Unique: 15MAYLMPP6OTtrhbesPwiw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5F2C195608B;
	Fri, 18 Oct 2024 03:00:32 +0000 (UTC)
Received: from localhost (unknown [10.72.112.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08F5A19560A3;
	Fri, 18 Oct 2024 03:00:29 +0000 (UTC)
Date: Fri, 18 Oct 2024 11:00:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 19/57] crash: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <ZxHPR+Et8VyeD8uI@MiWiFi-R3L-srv>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-19-ryan.roberts@arm.com>
 <Zw3luHGG3LqHge2m@MiWiFi-R3L-srv>
 <2e561511-ab20-4aa9-9b92-bd6ac6678087@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e561511-ab20-4aa9-9b92-bd6ac6678087@arm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/15/24 at 12:13pm, Ryan Roberts wrote:
> On 15/10/2024 04:47, Baoquan He wrote:
> > On 10/14/24 at 11:58am, Ryan Roberts wrote:
> >> To prepare for supporting boot-time page size selection, refactor code
> >> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> >> intended to be equivalent when compile-time page size is active.
> >>
> >> Updated BUILD_BUG_ON() to test against limit.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>
> >> ***NOTE***
> >> Any confused maintainers may want to read the cover note here for context:
> >> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> >>
> >>  kernel/crash_core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >> index 63cf89393c6eb..978c600a47ac8 100644
> >> --- a/kernel/crash_core.c
> >> +++ b/kernel/crash_core.c
> >> @@ -465,7 +465,7 @@ static int __init crash_notes_memory_init(void)
> >>  	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
> >>  	 * definitely will be in 2 pages with that.
> >>  	 */
> >> -	BUILD_BUG_ON(size > PAGE_SIZE);
> >> +	BUILD_BUG_ON(size > PAGE_SIZE_MIN);
> > 
> > This should be OK. While one thing which could happen is if selected size
> > is 64K, PAGE_SIZE_MIN is 4K, it will issue a false-positive warning when
> > compiling while actual it's not a problem during running. 
> 
> PAGE_SIZE can only ever be bigger than PAGE_SIZE_MIN if compiling a "boot-time
> page size" build. And in this case, you need to know that size is small enough
> to work with any of the boot-time selectable page sizes. Since size
> (=sizeof(note_buf_t)) is invariant to PAGE_SIZE, we can do this by checking
> against PAGE_SIZE_MIN.
> 
> So I don't think this could ever lead to a false-positive.

Makes sense, thanks for your explanation.
> 
> 
> Not sure if
> > that could happen on arm64. Anyway, we can check the crash_notes to get
> > why it's so big when it really happens. So,
> > 
> > Acked-by: Baoquan He <bhe@redhat.com>
> 
> Thanks!
> 
> > 
> >>  
> >>  	crash_notes = __alloc_percpu(size, align);
> >>  	if (!crash_notes) {
> >> -- 
> >> 2.43.0
> >>
> >>
> > 
> 


