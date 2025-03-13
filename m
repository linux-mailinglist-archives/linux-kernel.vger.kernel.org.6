Return-Path: <linux-kernel+bounces-558740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AADA5EA57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DD91783FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFEB12F399;
	Thu, 13 Mar 2025 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbN+8JIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558C3E47B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741838135; cv=none; b=jAzRsjHlNpCn+RT8CA/AJgTBEQbivdBA5sFrCl3otLp18cXyc7g/Rymqzf2oTOWPfa+REzHAqYFJ3J3NDs5dSQeKwid/jUEeU1z7RF0c8CXr2Mgc1CnNF/hBIE4ifbOYHmSE3dLh9wnWTCbCNkU9J/MiSbBODxNv/KN2VejXduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741838135; c=relaxed/simple;
	bh=7cxHtaT6Y72yczCbQqVuKIgAfGERa/LIEYbsR4mJDLQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vv3Ikr5Od4sgMVx1yUs1oJbdnNtxyWa64/akezbobKzxORP2qfmMQolgDz5r0mmI0jKOq3+xTvEO7H5TdVsY6pITsQ8gv0GiKEa+LKF8ZN+Y0dNGDmkm29VxjAWSZGlpAtdHD/VZ5adQwvxmjeyrV71nUsX1XVpzX1Xfa05nLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbN+8JIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E7BC4CEDD;
	Thu, 13 Mar 2025 03:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741838134;
	bh=7cxHtaT6Y72yczCbQqVuKIgAfGERa/LIEYbsR4mJDLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tbN+8JIZ6Js0xx2NXPmyPgo72dCWnJIz9K8/HjtL8HHirL24A5cE7byy/87PKVOxH
	 lUVEEv15DGFCSIPf38HTi/+wFvx38PVD7Z/fhlZ4sEHjIaRVs/LFHLOLBFOz/fUzaC
	 6VjAL2HWc8z++NZ6byX92crILpw+cwWw51b8aHAusXe6YEHI4Hn0P7yAjGoUmkEWFg
	 EgbN12LUvSD4ZMF7o4oyPj1RiqEQVTME2AplWj+TRbP4mKW2TPrXhFIPOlucqwHT/e
	 Fy6gKlQpA3OzGW589/M0lS5jYSTmXhgqCY3MkOF3yHk0wRbvjpuk7O40Ox3tIzVRKa
	 kigKBbPDV6Nyw==
Date: Thu, 13 Mar 2025 12:55:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>, Anna
 Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa
 <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-Id: <20250313125530.47e75ba67df5198c7adefe7f@kernel.org>
In-Reply-To: <e4b69082-bd23-4447-82f8-cb2a86c47690@redhat.com>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
	<174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
	<21a692ce-3fa4-48f2-8d1c-5542c1cfb15c@redhat.com>
	<20250306113236.aa39a5928c8106c13144df4d@kernel.org>
	<5f7bc403-be75-4ae3-b6ff-5ff0673847f9@redhat.com>
	<e4b69082-bd23-4447-82f8-cb2a86c47690@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 22:10:10 -0500
Waiman Long <llong@redhat.com> wrote:

> On 3/5/25 10:07 PM, Waiman Long wrote:
> >
> >
> > On 3/5/25 9:32 PM, Masami Hiramatsu (Google) wrote:
> >>>> +config DETECT_HUNG_TASK_BLOCKER
> >>>> +	bool "Dump Hung Tasks Blocker"
> >>>> +	depends on DETECT_HUNG_TASK
> >>>> +	depends on !PREEMPT_RT
> >>>> +	default y
> >>>> +	help
> >>>> +	  Say Y here to show the blocker task's stacktrace who acquires
> >>>> +	  the mutex lock which "hung tasks" are waiting.
> >>>> +	  This will add overhead a bit but shows suspicious tasks and
> >>>> +	  call trace if it comes from waiting a mutex.
> >>>> +
> >>>>    config WQ_WATCHDOG
> >>>>    	bool "Detect Workqueue Stalls"
> >>>>    	depends on DEBUG_KERNEL
> >>>>
> >>> Reviewed-by: Waiman Long<longman@redhat.com>
> >>>
> >> Thanks Waiman! BTW, who will pick this patch?
> >> Andrew, could you pick this series?
> >
> > Peter, do you mind routing this patch via Andrew?

Gently ping.

Thank you,

> >
> Resend as plain text.
> 
> Regards,
> Longman
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

