Return-Path: <linux-kernel+bounces-365063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E4799DCFE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E301F23D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417511714CC;
	Tue, 15 Oct 2024 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STXzvCup"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FE46B8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728964042; cv=none; b=SCLZqMP5R4auCskJLZZhXGiKgl7o/Bq7SLA2Tuw7lXv1YResNd7gkI+6UI3FSMYd9OxAwWa7ADp97wXEOwylyIGI+z1qcO53/iutCTzleKxRJQYbONdY5C4CL+kY4feh06B6H3LluO8o7gcJ9Up6QLBJuhHaRDUdhgo472tKdMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728964042; c=relaxed/simple;
	bh=+BcVhtftxxjodquIf2K4pPv71t8bgmiSroFSbaGWemA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKvUGey2gOeAp+RRk92BiRle9uaGY7Q1WwvXT7F9JbVCTP7TAg4HeQnGoxK4+X1bE3Fg7zKBh+vzCw/TYufYJkzOLD8lqvIBBQAj3KXjtz1e8XU3g9Jtpo3k0nPVqJSvr6w/9qDysXnvrB/dk5XKLkbBy40kgWL3J6JiUPDuTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=STXzvCup; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728964038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8dfHwMGJbsawxs7janPhhHUV4M9LSvsDgTpkLW3bePY=;
	b=STXzvCuplPTx7Dj8sWrev8owqY19SnyibVINJs8uHkuZU6qJo5j+nIU2mDhG+zQaP7ys3Z
	bfYF18LM6c0BoCRyrWR9vDwF9bp+HvJAVbkBnr78wI4j4Nn32AIcqbYTNouUTmH8zB4f8C
	jcGmPlJvPm+QlP3JUCzAlPRYVLxnpR0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-P6e0lCY_PJuFC2ui5jvLjg-1; Mon,
 14 Oct 2024 23:47:15 -0400
X-MC-Unique: P6e0lCY_PJuFC2ui5jvLjg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC24A1956083;
	Tue, 15 Oct 2024 03:47:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.16])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FA781956089;
	Tue, 15 Oct 2024 03:47:08 +0000 (UTC)
Date: Tue, 15 Oct 2024 11:47:04 +0800
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
Message-ID: <Zw3luHGG3LqHge2m@MiWiFi-R3L-srv>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-19-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014105912.3207374-19-ryan.roberts@arm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 10/14/24 at 11:58am, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> Updated BUILD_BUG_ON() to test against limit.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  kernel/crash_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 63cf89393c6eb..978c600a47ac8 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -465,7 +465,7 @@ static int __init crash_notes_memory_init(void)
>  	 * Break compile if size is bigger than PAGE_SIZE since crash_notes
>  	 * definitely will be in 2 pages with that.
>  	 */
> -	BUILD_BUG_ON(size > PAGE_SIZE);
> +	BUILD_BUG_ON(size > PAGE_SIZE_MIN);

This should be OK. While one thing which could happen is if selected size
is 64K, PAGE_SIZE_MIN is 4K, it will issue a false-positive warning when
compiling while actual it's not a problem during running. Not sure if
that could happen on arm64. Anyway, we can check the crash_notes to get
why it's so big when it really happens. So,

Acked-by: Baoquan He <bhe@redhat.com>

>  
>  	crash_notes = __alloc_percpu(size, align);
>  	if (!crash_notes) {
> -- 
> 2.43.0
> 
> 


