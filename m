Return-Path: <linux-kernel+bounces-294111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D9D95894E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE681F21A86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0FF18E756;
	Tue, 20 Aug 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJGjefGn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F201B813
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164225; cv=none; b=L4l5UZnTxkk8s6EWZ+jRo33q63qre3d95JqA+ib2NGk606BWTiNBOIRPPZhAPyatTfmgR/PIB5e/1MmcUkpY0ub+GS8kFJINLp9TnzmjbVTQMr/mAz/rQyIK4LTUHWKxDAreiEtaDnLPbgm8uOnUwQlIrJsTnu3878N9/lWrd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164225; c=relaxed/simple;
	bh=OhSWmWXP2uaD0O00jUY8HYyAlZyRHhdwKauRjsmZSE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiMBeLHVU5s2R8Vz81GdLB3Ci21/HviQNYzkG9StVuEaveMRY1WZZbVJfd3vFlwFoBw692qKr1YHQtsWHgR8z0/CX5H8APp0a9Jvq4396a7+P7CY6kzALs/V7tcNPvbpjg7LphoQ8JquEbm+WAj4lJ2oqTgmUzY12BSZnlOuhFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJGjefGn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724164223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L8LusOgz8Q5Vcit1THkmHm5dyFGoPNQpRq9rxAnuUqk=;
	b=FJGjefGnJq+BdxfdsDeQ6Cm+34o1JcKw8uGYrGT4HXICIGsuVySdvGaGFvABLq5kQV/V0H
	Y1BCHkKUdQ5aKGVG3DXZnjEZQwfOZJ6IJC/9ezDgH4NTyMAhMlOSb9HyQ79TVlaA4O0DJu
	nhXmEITxHN0krX9HRFVGS2MwQ2mkkmI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-z0sCsKhPNXOQLNQr5QzbJQ-1; Tue,
 20 Aug 2024 10:30:18 -0400
X-MC-Unique: z0sCsKhPNXOQLNQr5QzbJQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C58AA19300FC;
	Tue, 20 Aug 2024 14:30:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.99])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 17B233001FF1;
	Tue, 20 Aug 2024 14:30:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 20 Aug 2024 16:30:09 +0200 (CEST)
Date: Tue, 20 Aug 2024 16:30:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] uprobe: fix comment of uprobe_apply()
Message-ID: <20240820143001.GC12400@redhat.com>
References: <20240820135232.1913-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820135232.1913-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/20, Zhen Lei wrote:
>
> Depending on the argument 'add', uprobe_apply() may be registering or
> unregistering a probe.

...

>  /*
> - * uprobe_apply - unregister an already registered probe.
> - * @inode: the file in which the probe has to be removed.
> + * uprobe_apply - register a probe or unregister an already registered probe.

Not really.

See the commit 3c83a9ad0295eb63bd ("uprobes: make uprobe_register() return struct uprobe *")
in tip/perf/core which changed this description

	* uprobe_apply - add or remove the breakpoints according to @uc->filter

still looks confusing, yes...

Oleg.


