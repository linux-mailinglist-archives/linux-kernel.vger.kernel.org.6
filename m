Return-Path: <linux-kernel+bounces-197607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B88D6D03
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F991F26E46
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F7912FB27;
	Fri, 31 May 2024 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VZZYs8IA"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74FD79DC7
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717199420; cv=none; b=joYA187BysaVAohfTt/YhDPJgo4D+dUGzsCKlTy5lvRXaWTsOpvk5Xyep4qw+7YMjEDoIMkWJJCHHkNbbkFPRREjoq6QWDHQfhFmeG+tarjCZ6XYqcxpk7xoV2bZcP6ji3LATDl/ujInVZzHtHM0KwmkFjziqnuFLxVH7Ms2CCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717199420; c=relaxed/simple;
	bh=dZ7ulaDL1L2Ln+oRixcSBYL60i42q924rAbH5hzLhbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV5VjT6SJKZaPOPyWLPXSwfQZSNXB3GrqHDErmKQHFzZ6GhVI5w/F86Gkk7Was2DEVyLEJ/qLGkdj9Vf64+NAXIxkXBm43X1h3qAvEgyro1h1iNwEy2pY4DlqrAT4Xr4wNVbfmNeOdKlw1nyF7OX1erscpGItcqYyjdxxALwi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VZZYs8IA; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717199416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OOzuz+/J94mPHKcym5sz7qWGkxJUxusMsJxo0OWXA48=;
	b=VZZYs8IAXHU6CDmJjarLjJsXvhN8jM9uiQvKBToynuQEa8o1avQIzeaqUnTzdhZ9zKuNxU
	O6yvG6sRdeRcoieO77vPyOTnuteFJMbfS+DqkRWuzyCIhFKxPHHZU/66DtrUdFmwhr4mUb
	DlGemm0en859BbplOObWVKtDfyn4FJ0=
X-Envelope-To: akinobu.mita@gmail.com
X-Envelope-To: cl@linux.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: naveen.n.rao@linux.ibm.com
X-Envelope-To: anil.s.keshavamurthy@intel.com
X-Envelope-To: davem@davemloft.net
X-Envelope-To: mhiramat@kernel.org
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: mark.rutland@arm.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Date: Fri, 31 May 2024 16:50:11 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] mm, page_alloc: add static key for
 should_fail_alloc_page()
Message-ID: <ZlpiMx96XRHU9508@P9FQF9L96D.corp.robot.car>
References: <20240531-fault-injection-statickeys-v1-0-a513fd0a9614@suse.cz>
 <20240531-fault-injection-statickeys-v1-4-a513fd0a9614@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-fault-injection-statickeys-v1-4-a513fd0a9614@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, May 31, 2024 at 11:33:35AM +0200, Vlastimil Babka wrote:
> Similarly to should_failslab(), remove the overhead of calling the
> noinline function should_fail_alloc_page() with a static key that guards
> the allocation hotpath callsite and is controlled by the fault and error
> injection frameworks.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

