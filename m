Return-Path: <linux-kernel+bounces-547139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A284A50358
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D201888C43
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5374824EA9A;
	Wed,  5 Mar 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uz6QuXb1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08920B21D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188167; cv=none; b=BK3J67164pl67Br8sBS1HI6YNqay7lf9Yd9/f2+x+E4WlVsk4mLV/aOdT/59dtohbn/L1CA/pCt1sG7HlfBB6EL/4yJBsQFsriViEQVFmaS1CE1MPgMs0neLJ14JkGit0kDoxCkD6tLojc9OrIhsj57tamoiIeAa+NyvB2VFL6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188167; c=relaxed/simple;
	bh=VWigdSJtvf2WxMxfGPfKwCzDKILPSKtbmZRomoBqut8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxwEaWQSJRIkKihCJcZzX/3nz2y8MOZRWGcSg5x1DbneCT5pRv3ys8IRy5sLyKIW8hOV9NFYPNqX4V9vPesbI4NrNcjmhdNnD6yjtOHTxhD5GiNboStMKjmYr/G8P3NVXYndEIn78yuwiTEaznDJmoENZ2rjaHMgPkn5Ux+Bbms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uz6QuXb1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741188159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VWigdSJtvf2WxMxfGPfKwCzDKILPSKtbmZRomoBqut8=;
	b=Uz6QuXb1/EXPWgnFDEEncDDqcJR7miboRi/oKTd+Hqao5S8jRtkpQb63ql2LQ1OTJlm3I0
	WwGiP/GuI88zm7u9SrnanxnEhDJM4Pv8TfkPhz2BDb1mDjkuAKI53NWTOFvZKOhih6XKuK
	LamQxianjDT/z3iNfhNIV9rXHNJrxWI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-23qFcZJ4NrSH5Me2lVeGFg-1; Wed,
 05 Mar 2025 10:21:55 -0500
X-MC-Unique: 23qFcZJ4NrSH5Me2lVeGFg-1
X-Mimecast-MFC-AGG-ID: 23qFcZJ4NrSH5Me2lVeGFg_1741188097
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C55451801A07;
	Wed,  5 Mar 2025 15:21:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.66])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B2E781800266;
	Wed,  5 Mar 2025 15:21:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Mar 2025 16:21:05 +0100 (CET)
Date: Wed, 5 Mar 2025 16:20:55 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Hildenbrand <david@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH -next v1 0/3] kernel/events/uprobes:
 uprobe_write_opcode() rewrite
Message-ID: <20250305152055.GB28112@redhat.com>
References: <20250304154846.1937958-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304154846.1937958-1-david@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/04, David Hildenbrand wrote:
>
> Currently, uprobe_write_opcode() implements COW-breaking manually, which is
> really far from ideal.

To say at least ;)

David, thanks for doing this. I'll try to read 3/3 tomorrow, but I don't
think I can really help. Let me repeat, this code was written many years
ago, I forgot everything, and today my understanding of mm/ is very poor.
But I'll try anyway.

> Are there any uprobe tests / benchmarks that are worth running?

All I know about uprobe tests is that bpf people run a lot of tests which
use uprobes.

Andrii, Jiri, what you advise?

Oleg.


