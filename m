Return-Path: <linux-kernel+bounces-208814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB54902980
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F3AB23C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AE514F9CD;
	Mon, 10 Jun 2024 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O45D4tvG"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3C1BC39
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048978; cv=none; b=ETtuHIrrVP1qydIR9ToT8PJLKEVscizNDjUUljicucGm0aoCXhSFPf+0E4C7V8YAKITk+sdTosvYABP0B8W1im51/TACKqYly2QrMLJDQg5tPcp1NXjudYzPlZCLf8ODaMPLVFYiUe50rKXrb7GrH7unIdCzGk2v45MLo8gWFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048978; c=relaxed/simple;
	bh=hdn5GYGLjXsiFMhRdZ24HGgJjCYKSsRlg4AMHMAoOiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYUkzHJ5tmL+bYI3yz5GtAMYVcD7Ej8MrGMzBCBrlVlVIebRJcxqVyxelokvlMzDoTcuLGUU0Q5owApmPYWzY++gT1wbpzrIw8eo+zN+ugL3JdJA9/xXnR6mPXpJL1aL8vcuBsrfq7VxZLNGW33Atu9vdcQ+AE6SV5OtNr+uCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O45D4tvG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hdn5GYGLjXsiFMhRdZ24HGgJjCYKSsRlg4AMHMAoOiM=; b=O45D4tvGYU4TSh4on1nSW8gbzi
	CKDjGas3qsIRApcycKD8YlbDIyVw+XxBgR0ezQ+N+ndX8nomsH+OiqabUiK7bXQnRqe18j4Ejxsm/
	Ey9TmXSbuIzpVx6af/5TnFKqQxZ/j6jt3i0OexIvfYYjjdsKblsHDB0hffw4dTIeGTm9AY3xXg+MV
	TtZravpdfvvg2EywPf1sr4nhPcsX2gJ8gzx0Wnkh854HKnez0kZlISZ08yycT9I5xcDajkB2rMRBr
	mCN8kZCCIc2sjExxHThOybvUUD/4IfqFtTW+WH1mBaV7BYE/bH8NxcpCOdkL0fz9Seh19vqibPtLb
	BYrx59Rw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGl16-00000001dTt-13r1;
	Mon, 10 Jun 2024 19:49:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F4239300439; Mon, 10 Jun 2024 21:49:22 +0200 (CEST)
Date: Mon, 10 Jun 2024 21:49:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 00/51] posix-timers: Cure inconsistencies and the
 SIG_IGN mess
Message-ID: <20240610194922.GW8774@noisy.programming.kicks-ass.net>
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610163452.591699700@linutronix.de>


For 7 - 30:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I'll stare at the rest later..

