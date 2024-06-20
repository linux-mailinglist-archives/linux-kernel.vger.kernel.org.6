Return-Path: <linux-kernel+bounces-222268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265DA90FF09
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B05BB2416F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032DB1990DB;
	Thu, 20 Jun 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="okV6M69A"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0643EDB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872701; cv=none; b=szTKjeMvkx7PELuwzISOKrSfkD0wMYrg2dtA0wnkAIOR9nIytWapbnh/ImFVy59380YAPuF0yTsIEyGDQu4WRPYT8ArnqYEsfGho1SkEux4Bh/y5kzdqXrPZH5D2XHi3wZ2jmotXKm6dr7UJ3VE0gEoEktcmW+AdYrZ4ARaJ5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872701; c=relaxed/simple;
	bh=YatbP/rpuMXT6L6GJHjgLkwaTAWRQvcruhriNB8jUF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP1DIGOgqQeIOTIEq0U3lLxHLbqPi8XnUwkkhzM5zN3VM5t2J+0MULO0DqH9Bnq3mnIV+0YBu7ENRqsnlpuJXUdymSrhatGEAcAMBJteVroboayToLSHO3cgF2PcQTw+OdfhV/AJy8aNqLYfbPG1GdwwbxowpD4TDeM7mI+qZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=okV6M69A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=svnI81lpribeRxyXyvj49VwpBoZjrXVUY99kCqPylyE=; b=okV6M69AznHArFpvRBl0OxSut6
	ht/EWA4feYYNYKPgJA1KoeBTBOzIfK3JKOxW+IxOBcBp5sneFW8nzhEJuYV7uY0RhTNi5Tpc6R28f
	/jrPPziyylI4dzsCqLfUqPwvnCHuMqEr5Ep/ULlMmDkF2q42c9AB+Bha2mpKI7fuejdBzxOvLFWJj
	kIzquQl+oSHOJ1c7gAn1EdaJ9BYxoFBobhoh8YayqCbKrtpu/Zb/UIdrqjcbozeywMm+cOE2Rzag4
	iXSoH3t/mWfjfr/moOyizIZjIuqVd6y2d5DbZ4SXKERBXl5CndwutWuh6Uj8ceQfn2UA0A7msab9s
	PSl3cuLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKDJ7-00000005qTf-3MtC;
	Thu, 20 Jun 2024 08:38:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 317F3300CB9; Thu, 20 Jun 2024 10:38:10 +0200 (CEST)
Date: Thu, 20 Jun 2024 10:38:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com,
	Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	silviazhao <silviazhao-oc@zhaoxin.com>,
	CodyYao-oc <CodyYao-oc@zhaoxin.com>
Subject: Re: [RESEND PATCH 08/12] perf/x86: Extend event update interface
Message-ID: <20240620083810.GU31592@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-9-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618151044.1318612-9-kan.liang@linux.intel.com>

On Tue, Jun 18, 2024 at 08:10:40AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The current event update interface directly reads the values from the
> counter, but the values may not be the accurate ones users require. For
> example, the sample read feature wants the counter value of the member
> events when the leader event is overflow. But with the current
> implementation, the read (event update) actually happens in the NMI
> handler. There may be a small gap between the overflow and the NMI
> handler. The new Intel PEBS counters snapshotting feature can provide
> the accurate counter value in the overflow. The event update interface
> has to be updated to apply the given accurate values.
> 
> Pass the accurate values via the event update interface. If the value is
> not available, still directly read the counter.
> 
> For some cases, e.g., intel_update_topdown_event, there could be more
> than one counter/register are read. Using u64 * rather than u64 as the
> new parameter.

The stronger argument is that there is no special value to distinguish
between there begin an argument and there not being one. You cannot have
!val, because 0 might be a valid rdpmc() value.



