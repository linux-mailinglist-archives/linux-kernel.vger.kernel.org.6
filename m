Return-Path: <linux-kernel+bounces-246113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AAD92BDB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2368D28A766
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F9219CCEC;
	Tue,  9 Jul 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eRop9ww4"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41A15B999
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537334; cv=none; b=jCciliNnc6XKhrVREjz4ZfJ862qu4Qwprtgj/0k3euPMhchFjJMarqEH0pfC6x5YyTcbge4PQ3hkH6RNbwa1qcv6MPEMGNAuAIT/jMk85KiBvthMpcwDJJ2XYa/Vnf47AHiByg+6e2corR5uSNqZGHis5vm3lpYYJQJgpBs9YIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537334; c=relaxed/simple;
	bh=vxstvNPq8f5VUg4HXbDfADhhT0UnJeyEtWzDWR7am0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxktCYYlwbZdpZPoz1PdUxyC/ERw4IOSx4J5KumxPVNvhC3ZN8TxhiIdYbzY1kCOv5ecXFjgQGUUIuUX5LqC1Y1xrw2qBQmYdcwAYoJ/EiGomuVppFK5VEyVZUI3gUBoltCQWsiXX7SSEBFtZC3OGv+d6CqJOAKcWuxxE/bBGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eRop9ww4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vxstvNPq8f5VUg4HXbDfADhhT0UnJeyEtWzDWR7am0Y=; b=eRop9ww4ibMWKQNeA36L9eOZ9i
	9d8KaUDJv8pvjJd4Ibrnmln7iBBX59flb6cCGiW6MwyvsBbuIUnY6Wfhysyj7OpeQmV05OZMR0BLu
	o5DiJauGr9xR2Y49p5zJ4XRsAyKR+yp3/FLog+V5VEdT5lTCCphSCWwNwiM7Lt2zP/FIL6St2f/+d
	x0f8KdXgtrf9Qe/gancUqAxwoiipgpk0/QKUEOzCHDQTbdrFvpxLBhGbIQuNlWTDD/LKrerUuKRIA
	6HMPsjLutcEE9gk01pMwvWCyGlSLTkP1dLUxHBOhEQKs+DBE2ezeVbZjl/eDCtTKT9RI6LcW3hGgW
	nqOtFAPg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCM2-00000000lL1-08Ht;
	Tue, 09 Jul 2024 15:02:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6ADBE3006B7; Tue,  9 Jul 2024 17:02:05 +0200 (CEST)
Date: Tue, 9 Jul 2024 17:02:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 04/10] perf/uprobe: RCU-ify find_uprobe()
Message-ID: <20240709150205.GO27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.579623285@infradead.org>
 <20240708163545.GB18761@redhat.com>
 <20240708180837.GC27299@noisy.programming.kicks-ass.net>
 <20240709143255.GD28495@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709143255.GD28495@redhat.com>

On Tue, Jul 09, 2024 at 04:32:55PM +0200, Oleg Nesterov wrote:

> Once guard(srcu)(&uprobes_srcu) in handle_swbp() drops the uprobes_srcu lock,
> utask->active_uprobe can be freed.

Yeah, I've fixed all those already. It's a bit of churn, adding
inc_not_zero all over the place and then removing it again, but yeah, it
makes the individual patches better.

Let me finish the complete set and I'll push out.

