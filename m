Return-Path: <linux-kernel+bounces-224989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4532C9129A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0149028775B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039E074079;
	Fri, 21 Jun 2024 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJNLps+8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29D6EB73
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983707; cv=none; b=t2+8eKxTZCojF7ikO7cvQ4E129pDWs6T4Rqn3YKMM3NuxfTZHqH4k7NV56aLx55GllxO5fD+BjeJuy31urZKSWo/rLV+hlHGeKJH+qQ/THwZrLHaw/erXBKtixZKH4CMceUwcCVruLFZDstUZNlPQj3inn0qL35LMNXlha+0HqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983707; c=relaxed/simple;
	bh=0mv8IFw8b8K6O7A8BgSuFjrDOKnhs1Ry/DqvzdlC6N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6yNJTcg9jCPc9En6yhzDszXNc9YZFC3wTUOa0Z4bar1GpnLeT5kbqhmIcogaQgt6G9t5c/tTZzmcy82mRZpJcBpBNIL7UIsJj2Aawrjc7S1ULhTgoUZcFMIrkzUl+MhD8psaDyFDxsajvFkIkRexPzB7dtGdP3DeYaqshzaRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJNLps+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647E7C2BBFC;
	Fri, 21 Jun 2024 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718983706;
	bh=0mv8IFw8b8K6O7A8BgSuFjrDOKnhs1Ry/DqvzdlC6N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJNLps+8lHe865z32Tp8jm+k2p1QE5O8s2pWOyBC7GzwoeF9yCljZ7s94hc7cR2GI
	 2avWXJS7VzYMEcuE6Th1frdilUJGhQWPQcsnNGBDiFkrEWJwMXFTJw57nnY/ndaKO1
	 WDnxQIi2MVHXv5Go7OY4rqJT1eZby3Xv8K4oW+djN/BtDD1Vk2UxGNVlNmGdvMSFbq
	 iVER7+iES7UkYbAKH2FLwfodpIEAp5A6npWMXwsDaQbHtZF+PlX6YIieKmZGENaF94
	 Rkmm2m5OCOVlnB9MZFBgvUVnzvvjXiF9wbTv8YlZ3zpB1ckmucqnfexqfTmeLPYMy5
	 Wr1yjDI8ubsJg==
Date: Fri, 21 Jun 2024 17:28:24 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 07/51] posix-cpu-timers: Split up posix_cpu_timer_get()
Message-ID: <ZnWcGAI8WriA9d5O@localhost.localdomain>
References: <20240610163452.591699700@linutronix.de>
 <20240610164025.906237276@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610164025.906237276@linutronix.de>

Le Mon, Jun 10, 2024 at 06:42:14PM +0200, Thomas Gleixner a écrit :
> In preparation for addressing issues in the timer_get() and timer_set()
> functions of posix CPU timers.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

