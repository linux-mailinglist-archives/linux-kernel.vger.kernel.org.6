Return-Path: <linux-kernel+bounces-571721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF72A6C12F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F670177ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9015322DF83;
	Fri, 21 Mar 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lothappw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215722AE59
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577697; cv=none; b=sw9QPFNwLf/0dty87TqJc/WCFTERsowAu2lcB6252k5hcu7DOUsu7gI1E6xLWOW4SajjBKA7ZCeHKtIJLHT77W5TkVC7H198EEkLwV46QXdveNGWYQVQdL5q/oIifJT4N9HZJxfXxQZ08cZ8xEI9kIUMfA9sWs0/ZPw6wQYTm4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577697; c=relaxed/simple;
	bh=HLxwXs43wFE5cxPYlbDcwMH/wGcXycwv0XhfpIyvi/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni9e9Clbpml1hRUsJ4ubFW1WE/W7Scu3AkKJq/9EQJF7Tf2GJqg+fcX2kEMudztwp8h/x661ReqhMy1P0LAgmQ5L7oiZZHP9QV4NiRAaLuafBaJg+dNF6uoCA1IE0Rpy+w/lNNIx+LFEvprAQA8ZvNAcVroec1/T2wf5FAIJrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lothappw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72F0C4CEE3;
	Fri, 21 Mar 2025 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577696;
	bh=HLxwXs43wFE5cxPYlbDcwMH/wGcXycwv0XhfpIyvi/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lothappwDJCbuD10xQjjyBHUFipSUm6SFLaJXYem4JfDgy5kGTISTBOegfHA32aZG
	 zrKcwbO6MfjKH32QC0TtQufAD6mqwET8VZV1E93rhl18QkURePIrjaM5L7Behkdrf3
	 604a2mqOfX1ccDdXo3wSepU+Trz7WUzB1AbfPHm76TPokiAOU9ZnAEYnqKDTeRBZsQ
	 E3dh3vSbGK1nxMwu4lH5n6UlS2YjCd+NFRpn4A3LV6m4nolUgL/mxEoYmdOkg91+OS
	 18r7whNTYymOtlVrKf+4nLAMRCFi62e5Kn7ysA06eZ6gDnjIZf5gJT4CBHYlIj5COx
	 j5f+wPGxIUNLA==
Date: Fri, 21 Mar 2025 10:21:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing: Disable branch profiling in noinstr code
Message-ID: <g4rdlv4it35nlftf6uyaewe4b52buho6pvnamjmwd2iu5cq5q2@xh4uluvgaqvn>
References: <52a664ec9e14ef53c39c3d4fa400c2f1d29348c0.1742537096.git.jpoimboe@kernel.org>
 <871puq2uop.ffs@tglx>
 <20250321131248.02114dd7@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321131248.02114dd7@batman.local.home>

On Fri, Mar 21, 2025 at 01:12:48PM -0400, Steven Rostedt wrote:
> On Fri, 21 Mar 2025 17:51:50 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Though the real fix would be to rip out this likely/unlikely tracer
> > hackery all together.
> 
> If you want, you could just disable it for all of arch/x86

I *basically* did that, albeit in more of a surgical manner by editing a
lot of the makefiles in arch/x86/*/.

Let me see if I can figure out how to do that more broadly at the
arch/x86 level.

-- 
Josh

