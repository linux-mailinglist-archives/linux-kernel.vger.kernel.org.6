Return-Path: <linux-kernel+bounces-541257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 837BBA4BA9A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24111887E08
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7931EBFF9;
	Mon,  3 Mar 2025 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WqR/f+8y"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D4AD27
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993424; cv=none; b=Y1DuYHcmxfBOKr3RtvHBI5nM6CtAbzV8RUZy02L4W+rGOdYxmFDenpI3Zbfr5IZV+a/b0TAVndmZQE8am1my2TodDCQ2fk6+cmsc7VdH9qioGtRyfvYv3TJUMrqpsAFbFRxrDgt5f3yB1pjehHUybe8k8jPEi6Lp6DmEk+G7KBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993424; c=relaxed/simple;
	bh=Ou7Y63+CI5DwBsLRl5e2lZoxI9DINPhNLob6ipvMuA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY5eA6kXQRbu2vmSlu0zBE0GorylWOc0ZPuZw701eboGkiU9TTQimXMiWjCo3qWGja13Z0WMiH7d/QFQ/DaN19ArsbVuAV/x7GAL2SaBle9rt9929vpa0jZ68TuBbCiem2EPpiuzTlwCuY9SojSE7GmuwAcglaT857sxqmCkO+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WqR/f+8y; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L7ER3kfEHOXX6cDuxh+ff4vPRxcI/hsCirhEy+fkf0I=; b=WqR/f+8yCP2GGnE8x10pH2YHkM
	J7/2g4D+uzZsY7yJTtfetooDlHdb8pujqG51zJd9nj6G4xk8kt8sVF/OQZ5XxWiqzWSzsmUJSDYj4
	/3mMjoDsgto4zMyKqmGpCk7q+8+kQ3T9B+EZ+sCYa5SW4uuJlJhKt5yXoXj2tfCkfk2SBCay6Fn0L
	IUwU2cSmdldCrEEPj+29bQ5ANT8f/sXKE/AvDuECWPptF6/B5glQNn/oqGPHtaoL0Unha1woclIgM
	B8fWVZXFAIdOlGfmdTsghNEqL8d5bbVgge0ULKbgkBfmwhrkTC3BCIuirtpiXvZph0+AMosSnKd0h
	NCiHQOpQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tp1v0-00000004Wp9-3ekQ;
	Mon, 03 Mar 2025 09:16:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1796830049D; Mon,  3 Mar 2025 10:16:58 +0100 (CET)
Date: Mon, 3 Mar 2025 10:16:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH 00/19] perf: Make perf_pmu_unregister() usable
Message-ID: <20250303091658.GG5880@noisy.programming.kicks-ass.net>
References: <20241104133909.669111662@infradead.org>
 <Z8NnVdo8wB-YcrAs@gmail.com>
 <fd86431f-d373-4ec8-9089-09eea843fae0@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd86431f-d373-4ec8-9089-09eea843fae0@amd.com>

On Mon, Mar 03, 2025 at 08:55:06AM +0530, Ravi Bangoria wrote:
> Hi Ingo,
> 
> >> Lucas convinced me that perf_pmu_unregister() is a trainwreck; after
> >> considering a few options I was like, how hard could it be..
> >>
> >> So find here a few patches that clean things up in preparation and then a final
> >> patch that makes unregistering a PMU work by introducing a new event state
> >> (REVOKED) and ensuring that any event in such a state will never get to using
> >> it's PMU methods ever again.
> > 
> > So it looks like this series first got lost in the usual end-of-year 
> > fog of holidays, then it has become somewhat bitrotten due to other 
> > perf changes interacting and creating conflicts. I cannot find these 
> > patches in queue.git anymore, other than the somewhat stale 4+ months 
> > old perf/pmu-unregister branch from October 2024.
> 
> Peter posted V2:
> https://lore.kernel.org/r/20250205102120.531585416@infradead.org
> 
> Same was pushed in Peter's queue repo (2025-02-03):
> https://web.git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/pmu-unregister

Right, I need to get back to this.. I have a bunch of changes from v2
already accumulated, but haven't gotten around to looking at Ravi's
latest feedback :/

