Return-Path: <linux-kernel+bounces-279623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A417694BFAD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC94282CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD1718E760;
	Thu,  8 Aug 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO9eczmM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6218CC10
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127370; cv=none; b=pr7zcv/5iXbMH7b/OrJgb1UihYkz6KG2PPNqiWrQ6P8r7d998XcaC0tblPLldoyiNyAUhOenjHu+Tk2JuUShvDHIjnKKrumWANd1zVRmBj+Dl8+V0ahmI/Jeyuj8/2ubwU5J+UEgY/WBEi632NdZW6AZw0PKkfiUFK9vRrTqC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127370; c=relaxed/simple;
	bh=gDND6qNLPtj9Cvnqepa/26hTXzqHsUw/LUV9SpFzEO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L77dsTLIpoqqgMoGGbIUpBGw+3Lq6nRu9Z9pzLYo93reuNyHT/Xn6PZEftO9p2/3VGbIC4yvKBvIqlVn1VHOhmCWFRBwQh9YHFdmXyc/46k8gly9HACzeuRWiCvsZvCow/SRFttFH1ym+/FEX2QxZBUP0BPdzcDrYjn+U1U7c6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO9eczmM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723127367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDND6qNLPtj9Cvnqepa/26hTXzqHsUw/LUV9SpFzEO8=;
	b=CO9eczmMaauMj4OxEY62XxpQnjf8ObtIsnYqhEan/cIkn0mVm3M4OaFRo1jIzc9HmbGce2
	GS0HY2UZEPPvPiwtBB02MYO8DmaFmf5f//5lXdM271dU3KGL/ulDo3mpTVyJT8tDt8Jq1V
	d0Cgj7slwy+3hS3D8BNQnvg8eGRyyJo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-hgslZID_PW2LeFYh0ix_Vw-1; Thu,
 08 Aug 2024 10:29:25 -0400
X-MC-Unique: hgslZID_PW2LeFYh0ix_Vw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 608F119560A3;
	Thu,  8 Aug 2024 14:29:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.189])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3F7AF19560A3;
	Thu,  8 Aug 2024 14:29:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  8 Aug 2024 16:29:21 +0200 (CEST)
Date: Thu, 8 Aug 2024 16:29:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH 7/8] uprobes: perform lockless SRCU-protected
 uprobes_tree lookup
Message-ID: <20240808142916.GF8020@redhat.com>
References: <20240731214256.3588718-1-andrii@kernel.org>
 <20240731214256.3588718-8-andrii@kernel.org>
 <CAEf4BzYbXzt7RXB962OLEd3xoQcPfT1MFw5JcHSmRzPx-Etm_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYbXzt7RXB962OLEd3xoQcPfT1MFw5JcHSmRzPx-Etm_A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 08/07, Andrii Nakryiko wrote:
>
> So, any ideas how we can end up with "corrupted" root on lockless
> lookup with rb_find_rcu()?

I certainly can't help ;) I know ABSOLUTELY NOTHING about rb or any
other tree.

But,

> This seems to be the very first lockless
> RB-tree lookup use case in the tree,

Well, latch_tree_find() is supposed to be rcu-safe afaics, and
__lt_erase() is just rb_erase(). So it is not the 1st use case.

See also the "Notes on lockless lookups" comment in lib/rbtree.c.

So it seems that rb_erase() is supposed to be rcu-safe. However
it uses __rb_change_child(), not __rb_change_child_rcu().

Not that I think this can explain the problem, and on x86
__smp_store_release() is just WRITE_ONCE, but looks confusing...

Oleg.


