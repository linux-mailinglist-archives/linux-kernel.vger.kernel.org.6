Return-Path: <linux-kernel+bounces-235121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04EA91D071
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985612819F5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69F3B2BB;
	Sun, 30 Jun 2024 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZwpQrOI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FAD29A5
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719733975; cv=none; b=HNUA5oNasCdeZpCmF33kpXSbgLQ9UcUIeyBLKkDzoLK7sjvFexv1Uq+ldINrZMN3Va/b4ZTBwCInlL+85ck/tKQfGmunW0PSgJbtMYfZsffOWuXm1FADyA9kXSgyIz57QPm2CHt4/lepItrJ3VsVuKc5TOI5ypoW9uQ4Ud8K0wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719733975; c=relaxed/simple;
	bh=co2cDdEmeFvRbcDXmr6Da/FYXLjdSoyoirwb23eTC64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVPRzj3aHZEOVQFDIH2A9aa6H+A4aIhFQTbSwYeQ4A87k4Ly+xam30MGMhIR/fPK6rMpV3gevXAuXDi2vpP1TVqBO2xpVAuBjanfwJP6SYHr9cWPXtPgNVyfKeqz8rLFeoonYlC4HSLG0jcPxjUo3a8G4CgfIk5A8zlli4pBwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZwpQrOI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719733972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DAkRwCM7glIAXTawIDqCJu0+fM8r538qrsEC+Kd6Gmk=;
	b=YZwpQrOIuRWh0ro/dvD+oj1KqEJ2t3k1+qzwyp/VjadIne9VZRfTm0M1CFAHrqe0/E2q89
	7PgPTvrnuJ4T9E+ccdjMxo0yAjWX8gtctlTURSUZnUqowmsSXuc0FjizM4Enx5BRHyNuQ7
	pbF7adpIb99OAjlRNmk3s2hnFvKVxTI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-klhzVdvfPRibwqjM9vTEtQ-1; Sun,
 30 Jun 2024 03:52:44 -0400
X-MC-Unique: klhzVdvfPRibwqjM9vTEtQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FDDF195609D;
	Sun, 30 Jun 2024 07:52:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 245511956056;
	Sun, 30 Jun 2024 07:52:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 30 Jun 2024 09:51:08 +0200 (CEST)
Date: Sun, 30 Jun 2024 09:51:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, mjguzik@gmail.com,
	tandersen@netflix.com, linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] kernel/fork.c: get totalram_pages from memblock to
 calculate max_threads
Message-ID: <20240630075103.GB11898@redhat.com>
References: <20240630062214.31707-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630062214.31707-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 06/30, Wei Yang wrote:
>
>  static void set_max_threads(unsigned int max_threads_suggested)
>  {
>  	u64 threads;
> -	unsigned long nr_pages = totalram_pages();
> +	unsigned long nr_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());

Can't comment, I don't understand this patch.

but if you change set_max_threads, perhaps you can mark it as __init
for consistency?

Oleg.


