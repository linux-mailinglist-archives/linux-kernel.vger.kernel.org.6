Return-Path: <linux-kernel+bounces-571327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE5A6BBCA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3D6188C9A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCE422B8CF;
	Fri, 21 Mar 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1r9TSgs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0DC22A7F4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564097; cv=none; b=n48hQTSplqDNM2buzwRqVnUkDlUmUTgAD1k3mtDIEFV2ddY17cA7P9r59Jm1wrQ4sJI3BrVt/oCoydegY3mEowgIZKrXQrUKCvDVmkUEBnOtjAwEVUyz+qN+pgOZYE979idwj5VxZeiatJCj2MzmiR2FZhnwuZjWG1qRmxZgt+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564097; c=relaxed/simple;
	bh=rUggPb1dSqtWKpCSaWvzk+ZaY1JpEPBJvNpui/xayDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKCridDtj0LSU9pxv9c/v2Xc9EPsfzo0MGTtYLhWvEKzwlSDo8/hRYGGyyaFimk0fejSnyMbwOHl0BfMLodFT/WN3lIgB+370+zLPhFnnBaOH27VzoulH10ysDkdJlzleHdfDJtpORKhqgPPJ1rsjlA0LwehyXPpLbgQbvCbGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1r9TSgs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742564095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rUggPb1dSqtWKpCSaWvzk+ZaY1JpEPBJvNpui/xayDA=;
	b=G1r9TSgs9zlWFetoc2kF/vbkNVc3PG2/MAD1Wc9ijjBhf+IHEecZUQETRawrizVrJSazru
	PC1E2mxa7VL1dVrQM5p6GFBaWkqv5BVVGj1NBrCnYJn7ue+ihbMVYzsuQpdQMV2WmpNM2V
	TbTZkGEOZe1vmEan/Qdq7CWAckdCdAw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-ECMoH-jOMhmJiYnN0c7W3g-1; Fri,
 21 Mar 2025 09:34:49 -0400
X-MC-Unique: ECMoH-jOMhmJiYnN0c7W3g-1
X-Mimecast-MFC-AGG-ID: ECMoH-jOMhmJiYnN0c7W3g_1742564086
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D01FB1800EC5;
	Fri, 21 Mar 2025 13:34:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.60])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0D4B019560AF;
	Fri, 21 Mar 2025 13:34:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 21 Mar 2025 14:34:12 +0100 (CET)
Date: Fri, 21 Mar 2025 14:34:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH v3 0/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
Message-ID: <20250321133401.GB4776@redhat.com>
References: <20250321113713.204682-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321113713.204682-1-david@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 03/21, David Hildenbrand wrote:
>
> Based on mm/unstable.

which has another fix from David in __replace_page() plus the fix from
Tong in uprobe_write_opcode().

So, Andrew, could you take this series as well? Peter, will you agree?

> Currently, uprobe_write_opcode() implements COW-breaking manually, which is
> really far from ideal.

It was never ideal, but today it is simply horrible ;)
Thanks again for your work.

Oleg.


