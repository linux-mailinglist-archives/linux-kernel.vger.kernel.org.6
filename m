Return-Path: <linux-kernel+bounces-334573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABA697D908
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE361F23663
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51A376E0;
	Fri, 20 Sep 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFSmcUO1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAE821105
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853569; cv=none; b=RIibrxNtNnHoGIJ9+bk0eqcUdg+8ZWbmyosasXrAResy59OTfWARjiFvz9OIFC2HUAGRHvyCB56eBKX0cwRd9Ox/ku3ATGy2GQD7K6huU06jS71Ve74XumjLmZ8faBwUhSzc0lxtO7M/R3XuuUEmoYESPYeAozkganQBxBUtDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853569; c=relaxed/simple;
	bh=VEMpxWKzfKVy8D0+ohQWN27Wtze7JoMQcOiTLAsu9qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6h+qa7CsEXnMj3ML7LFddzokndV3+2wBTrV1FGsfLR2nbcMpWNwDaQ3UdBqjZNScIJOmpDHvbrGbM5nEdMIblPrULJMHyDOLq4weTdC9ty94iXmh6nYEoTkX4VXkRgcEZh8w/aTINSQxQANVlJxw3X8PznYDTNPJEIXIJ1SD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFSmcUO1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726853566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/hU5VF1cO4T3RIP1MdFKCZVhDgcxj/ZDnEgQY7FIoc=;
	b=TFSmcUO1vyRl0HIKCB/hqD4h1nIOkWIreNosgy1tUYnukrZ0WKUO1tPz8pdZkMF4m42Zsq
	TU06VrC601E9FzpSz82sJw19h1eKK2zLyzd+xA9IvcT5Kwvv7uKqiebi4AJgem5nS/byfK
	WijHkdFMrcs9kQmZJ9tyNfYGxXe6TCA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-EzfZuDM7NsKxkSODO1mfEQ-1; Fri,
 20 Sep 2024 13:32:43 -0400
X-MC-Unique: EzfZuDM7NsKxkSODO1mfEQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 015A319300FB;
	Fri, 20 Sep 2024 17:32:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.115])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 141BC19560AA;
	Fri, 20 Sep 2024 17:32:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 20 Sep 2024 19:32:28 +0200 (CEST)
Date: Fri, 20 Sep 2024 19:32:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Liao, Chang" <liaochang1@huawei.com>, mhiramat@kernel.org,
	peterz@infradead.org, will@kernel.org, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Message-ID: <20240920173223.GA20847@redhat.com>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
 <Zu2VdYrLWTJbVOAt@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zu2VdYrLWTJbVOAt@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 09/20, Catalin Marinas wrote:
>
> On Fri, Sep 20, 2024 at 04:58:31PM +0800, Liao, Chang wrote:
> >
> >
> > 在 2024/9/19 22:18, Oleg Nesterov 写道:
> > > On 09/19, Liao Chang wrote:
> > >>
> > >> --- a/arch/arm64/kernel/probes/uprobes.c
> > >> +++ b/arch/arm64/kernel/probes/uprobes.c
> > >> @@ -17,12 +17,16 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> > >>  	void *xol_page_kaddr = kmap_atomic(page);
> > >>  	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
> > >>
> > >> +	if (!memcmp(dst, src, len))
> > >> +		goto done;
> > >
> > > can't really comment, I know nothing about arm64...
> > >
> > > but don't we need to change __create_xol_area()
> > >
> > > 	-	area->page = alloc_page(GFP_HIGHUSER);
> > > 	+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> > >
> > > to avoid the false positives?
> >
> > Indeed, it would be safer.
> >
> > Could we tolerate these false positives? Even if the page are not reset
> > to zero bits, if the existing bits are the same as the instruction being
> > copied, it still can execute the correct instruction.
>
> Not if the I-cache has stale data. If alloc_page() returns a page with
> some random data that resembles a valid instruction but there was never
> a cache flush (sync_icache_aliases() on arm64), it's irrelevant whether
> the compare (on the D-cache side) succeeds or not.

But shouldn't the page fault paths on arm64 flush I-cache ?

If alloc_page() returns a page with some random data that resembles a valid
instruction, user-space can't execute this instruction until
special_mapping_fault() installs the page allocated in __create_xol_area().

Again, I know nothing about arm64/icache/etc, I am just curious and trying
to understand...

Oleg.


