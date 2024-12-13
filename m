Return-Path: <linux-kernel+bounces-444477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6D9F0776
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB071885790
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B8E1ABEDC;
	Fri, 13 Dec 2024 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="os/MRBon"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC017BEC5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081379; cv=none; b=YqUdRVMousRE/k/VP8ndyDEnu+uuSyRWXO5C815zjml3s6vShDMr5+WMm/b67i0PDLGOJI0ARhYeuMQysKWF1JWCQZrGrHgVlIn27UMbLmbBIYpFroaOvnNZBVwANsFrLV7mAYgua1efMTkJtQpGTRy5wzLZY8KfoEUoiLv7pMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081379; c=relaxed/simple;
	bh=orAvRKd5debjo38JorEBYiQZaT/qKXMqUnOBE+hCMhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1+3vFc4wp2+Dn0f3CJcJlJ5qkUn2UVc13/HpyZtmGlXMyX7rPikM/CxaMTSUqqsatP886mWR1H2n0Pr1SKRSnSuvXm6ROXCHeSBhmiudJF5aHZoh48nvpQoVh7dpVi74O6OaX3YM7X7Me5t4Cso0XxNuTRPtW533pEHw3gLfVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=os/MRBon; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8JcDDp9DV5D1o/wNZyOrDHJfyBMo9Auzi2NXqnStmMc=; b=os/MRBonjwQQ18DwRzspznV8lk
	BDCM+be4SxK6h0GT5Avth7O3fDOusKJSuz75JOpzn3P4shLYIptpQqz95X45nTcDuiYf/hipC0RSW
	0o2+dTmLdNJAx/Jy9Hc7PpbymrUbzRTjLs9uCgqVZZdt3XRMUDsrvr2eLpkLw+octeFDC/M2TzR7a
	JfSuw0pnvhwsPcOJabEJCmWDWbDt8QMg0SDPHI7oiACFoQBtK/VeBeRyv05QOl/tI2ADQI4xYAaqf
	tGrFk2eH7qCKbGYjzm2/cKqyZAK9D5dIAtMEzdqICUOj9s/Sz1wE3IkDHgtv3Fhi4uEkUxe9RZFxs
	6cOYR8Iw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM1mJ-0000000BoBn-2e3s;
	Fri, 13 Dec 2024 09:16:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 262E030049D; Fri, 13 Dec 2024 10:16:07 +0100 (CET)
Date: Fri, 13 Dec 2024 10:16:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH 3/8] x86/itmt: Move the "sched_itmt_enabled" sysctl to
 debugfs
Message-ID: <20241213091607.GD21636@noisy.programming.kicks-ass.net>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
 <20241211185552.4553-4-kprateek.nayak@amd.com>
 <527d53cded892aea8f36b498ccd42f1bed0a347b.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527d53cded892aea8f36b498ccd42f1bed0a347b.camel@linux.intel.com>

On Thu, Dec 12, 2024 at 11:15:43AM -0800, Tim Chen wrote:
> On Wed, 2024-12-11 at 18:55 +0000, K Prateek Nayak wrote:
> > "sched_itmt_enabled" was only introduced as a debug toggle for any funky
> > ITMT behavior. Move the sysctl controlled from
> > "/proc/sys/kernel/sched_itmt_enabled" to debugfs at
> > "/sys/kernel/debug/x86/sched_itmt_enabled" with a notable change that a
> > cat on the file will return "Y" or "N" instead of "1" or "0" to
> > indicate that feature is enabled or disabled respectively.
> > 
> 
> Valid values of setting "sched_itmt_enabled" likewise change from "1" or "0"
> to "Y" or "N". 

Nope, kstrtobool() accepts a ton of options, very much including 1,0.
It's just the print side that has to pick one and went with the Y,N
thing.

Look at the function and marvel how you can even write: oNcology,oFficious

