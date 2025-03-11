Return-Path: <linux-kernel+bounces-556131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598B5A5C152
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D02162610
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE344255E37;
	Tue, 11 Mar 2025 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2W6bMNv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3280256C9F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696412; cv=none; b=oM9NZj1jz7YtQILQjr1DWJIjtZlZOyjt5F5JeQIG+4S6m+9/f244QpLUGTqO3ZvGPuiR7kk1GbPzNrmWoqpV0xVbWlYxFuqLX1FhNLoWqFbrmcvsZ5kk5FmkzC9F0ZQEQwXaFBGN0umCh8kJ9YLwFSnncZYAU+7zIc3mivQS5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696412; c=relaxed/simple;
	bh=vi8EgugFTqTZ8tDsE6qvQo8nr/UAfZcnC/Vx0pB+yZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njL7g3pxrDUF4ghGb9Y48ZeFTsGBJKTjPIm67fUeuMhOIrGqKBVj1pa07KQ/pcwXTerCSCegxMn/9dgwpbNNCjRB0/n+OdvzeJ6S086J7IKwW1eMiTC7PCmGEdUoZba6RnxwHNxY0lwc/F5zft6PLspcibgTuAwiVRy2mLWoUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2W6bMNv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741696409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=palKyBcsgnYyLT7TccByqHvOUnQeIY6hqkQdRDklSI4=;
	b=P2W6bMNv/LRqxn4GYSJk0Lt+DWLBKxRHr+YrokdpSqN6lrslp9V4aiZdMLb/PTDcP5Cqyi
	ClioTEM3TBmMaGLwjEMoVC6NkTCTu5d030h2Kps3O8aJTln9UzmJLVKl62fq8te8yHzoDf
	AtBq7XYjt12tl7ue+0nY8ihmgGc36LM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-hD9d9DKnN-OKC5JK0gX1hQ-1; Tue,
 11 Mar 2025 08:33:26 -0400
X-MC-Unique: hD9d9DKnN-OKC5JK0gX1hQ-1
X-Mimecast-MFC-AGG-ID: hD9d9DKnN-OKC5JK0gX1hQ_1741696404
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7D2C180AF5E;
	Tue, 11 Mar 2025 12:33:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.22.90.58])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5616F180094A;
	Tue, 11 Mar 2025 12:33:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Mar 2025 13:32:51 +0100 (CET)
Date: Tue, 11 Mar 2025 13:32:42 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Hildenbrand <david@redhat.com>
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
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH -next v1 3/3] kernel/events/uprobes:
 uprobe_write_opcode() rewrite
Message-ID: <20250311123241.GB3493@redhat.com>
References: <20250304154846.1937958-1-david@redhat.com>
 <20250304154846.1937958-4-david@redhat.com>
 <20250310170320.GC26382@redhat.com>
 <79ec5aa9-1937-436e-8cf4-436746142f7b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79ec5aa9-1937-436e-8cf4-436746142f7b@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/11, David Hildenbrand wrote:
>
> Regarding both questions, the code is fairly racy. Nothing would stop user
> space from (a) modifying that memory

Yes, but we don't really care. uprobes.c assumes that user-space won't play
with the probed memory.

Note that if is_register is false, then vma can be even writable. Hmm, why?
Perhaps valid_vma() should ignore is_register and nack VM_MAYWRITE ? But
this doesn't really matter, say, gdb can change this memory anyway. Again,
we don't really care.

> >do something like
> >
> >	/* Walk the page tables again, to perform the actual update. */
> >	ret = -EAGAIN;
> >	folio = folio_walk_start(&fw, vma, vaddr, 0);
> >	if (folio) {
> >		if (fw.page == page) {
> >			WARN_ON(is_register && !folio_test_anon(folio));
>
> Yes, that would work (we could leave the WARN_ON in __uprobe_write_opcode),
> but I am not sure if the end result is better better. No strong opinion on
> the details though.

Will, this way __uprobe_write_opcode() will look a little bit simpler...

But I won't insist, please do what you think is better.

Oleg.


