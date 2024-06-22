Return-Path: <linux-kernel+bounces-225606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4859132D3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B96C1F226A3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C414B946;
	Sat, 22 Jun 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDZj0YEq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD0B748E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719047082; cv=none; b=qf1yGutpoWoj4TEQeZ+eULhOZA4s/HbB/tPL8r7uQ1UgIOEvf1uvQAzCbUNc+5Qf1VJcVBa6SjYxdmpW+Dq3957TpYu7u1X8wOX037sX9fUUyKi52WIGoo5zcrrnHC+XAiSL/a3B0fkx/tUiLDNYzKo+ya+khh9o0e0GDrbQHuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719047082; c=relaxed/simple;
	bh=UU7JsnSaz9dFPja35kRkTIpRcpxJ89GB0bKn+zNzzZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwImgtpuxJKkSMjr708u9KCZw6h6b8jJKZ5t+dNSgjBEhkIkXz7lgeMqpTKcVGFgsr/dcqCMshMB2UGvWrdqxWvevW8+5POf/R2ubP9GdTxpRap9JB5OCrm4PLMpCVnsDUv4TwqOI2/30jaJVm0BgF52urdiH4RWWcphvsNbfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDZj0YEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DBDC32781;
	Sat, 22 Jun 2024 09:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719047081;
	bh=UU7JsnSaz9dFPja35kRkTIpRcpxJ89GB0bKn+zNzzZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDZj0YEq3aW2aAOWLF8l5c3G6edqjT01VAnR9uhEu7j3cy2Hi/8g5iLioRTj+oQ4Y
	 S9c6nJ7jdooGHpESYJnoYQo75on6Ojru6lquxx7tY0AMUd93tN5aPNYaAUN+o1MzH/
	 UgMzg2jfAB6GFnnyTFm7xyIjQrpfYoHe9x6L1WzYdZer4sDLroHcdklwCSl4cpXooC
	 MAOsCvF5DfY3ZWifVUOX7WS1hyNdQBBazt1ObbStyMHTjvVBaahztgqHc0pBzMTbkk
	 n0cjFtzyJdmLFxT181/w4FRjg1KX4bUlmCKJIdOg35lTK2XDZ9nlOnASRox/dAmLrk
	 +5L0Cw5hCUqMg==
Date: Sat, 22 Jun 2024 11:04:38 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 09/51] posix-cpu-timers: Handle interval timers
 correctly in timer_get()
Message-ID: <ZnaTplDOun-QPCH8@pavilion.home>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.036097741@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610164026.036097741@linutronix.de>

Le Mon, Jun 10, 2024 at 06:42:16PM +0200, Thomas Gleixner a écrit :
> timer_gettime() must return the remaining time to the next expiry of a
> timer or 0 if the timer is not armed and no signal pending, but posix CPU
> timers fail to forward a timer which is already expired.
> 
> Add the required logic to address that.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

