Return-Path: <linux-kernel+bounces-222342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A144B90FFFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B9E283DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F9519B3EC;
	Thu, 20 Jun 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/W3sDG0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BFC19AD86
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874594; cv=none; b=X1OdGy125EvLsH186B9IdYztt56rhxgz0hoEFnTOZdd1qlAblTJ0YjxE2tlJjDCO8g3XBOedTAl3ud5Cfwla09cF7mMOcQw8THm3qs1XDFqs5IKH8FSwTLXckizFYS/jxs7JbRZM0qpQXGhedPj5+Qs1kjeX+63F0VSnDP+o41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874594; c=relaxed/simple;
	bh=xcEb/2o51/hhP7L4EQhiwpX6PzDA1AooXoMLV0l0PF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu5bha7OAUe0FKDuiAEzP96BGn19mjNLv1w25RQ1jrwT5yY+lpR6FHBREh1qjUnVYvdvtaItO9KukPnuzpZx0qVoznb/2cKOHsVqD2TlFhhVXXa/uiIUYl7jp7biNYvkmWR94Fr7IUWRSIlqzNJ9/f5aYkXwOS+9EJ91Ixr2sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/W3sDG0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718874591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZSfcZG+KL4h8GQs6NMrIyrvzuT3/K8Q28tO1U3u9w4=;
	b=E/W3sDG0AhBQJakslkRn/qBLZ45xHeuVVr2e+63Z3YmGDEfM4oRDfXc6KjFlqsxSfjajii
	ClESz6xLP6tbebbI5Tq5VbQdqWr5z372Obp6TK5u//zsPOfq4D9bZDlfyN/E6L3rELBcYH
	pt1y6P3CbitCoRBGDA5i1dnjNwNY6+A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-LhuqOdFhOj-bvsFoYhn1oQ-1; Thu,
 20 Jun 2024 05:09:46 -0400
X-MC-Unique: LhuqOdFhOj-bvsFoYhn1oQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6414D19560B1;
	Thu, 20 Jun 2024 09:09:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EF5463000218;
	Thu, 20 Jun 2024 09:09:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Jun 2024 11:08:13 +0200 (CEST)
Date: Thu, 20 Jun 2024 11:08:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hw_breakpoint: Save privilege of access control
 via ptrace
Message-ID: <20240620090807.GC30070@redhat.com>
References: <20240618071010.11214-1-yangtiezhu@loongson.cn>
 <20240619151524.GB24240@redhat.com>
 <9cc6d314-2431-c1b5-3d46-63c0ac80ed4d@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cc6d314-2431-c1b5-3d46-63c0ac80ed4d@loongson.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/20, Tiezhu Yang wrote:
>
> On 06/19/2024 11:15 PM, Oleg Nesterov wrote:
> >>--- a/include/uapi/linux/perf_event.h
> >>+++ b/include/uapi/linux/perf_event.h
> >>@@ -467,6 +467,7 @@ struct perf_event_attr {
> >> 		__u32		wakeup_watermark; /* bytes before wakeup   */
> >> 	};
> >>
> >>+	__u8			bp_priv;
> >> 	__u32			bp_type;
> >
> >Is it safe to add the new member in the middle of uapi struct?
> >This will break userspace...
>
> Let me put the new member "bp_priv" at the end of uapi struct
> perf_event_attr in the next version if you are OK with it.

And add PERF_ATTR_SIZE_VER9 ?

Well, you can safely ignore me, you should ask the maintainers ;)

But to me the very idea of arm64-specific and "kernel only" member in
perf_event_attr looks a bit strange.

Oleg.


