Return-Path: <linux-kernel+bounces-387173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F26B9B4D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503AA1C21B50
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94237192B83;
	Tue, 29 Oct 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmWsqU9+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E99191F98
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214516; cv=none; b=LMtMRDaN+W6BOP9atzIttRaeumZO65GGtuxKAjLxhXO3oHQYgLpyls3weTKHCFqBJOsUCe1TDicA3vn/RLZlgQtEjY4LHRLSqe7vrlKXIU/0gQjeyfkkhoAob6+LFqe9wHENHYzUdgJhrB08oByWODt74+FxYV064QVH7uPLNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214516; c=relaxed/simple;
	bh=QtJl8SpImb0PzLseIecf9y9DBnR3aHQ8oF8HpmGvpTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY7H2eO7HkdB3yXokzMnFL80lgbRqxtf9eERYG9pqeM1QamR6z13ThETptfCwL1o37wWSr/DaB1jPEAxk90ilLLhPeYLNCp0yEek8LjA9fLJKYpTG+4Y+MWdi88kYdn+6wgn8bOi6NcR9PsB4CTGswxjMqQWdlxnxvBLF8JCeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmWsqU9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329BAC4CECD;
	Tue, 29 Oct 2024 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730214514;
	bh=QtJl8SpImb0PzLseIecf9y9DBnR3aHQ8oF8HpmGvpTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fmWsqU9+Rkop2pA/G+DgvFFVkgkg4rSEHB/GYlzn98WA6fPMOvgNH8lhY4bEq3s+U
	 mU0qszy6P4Dy7z7w/1Tu9SDBi6wmPkAaR24Jt16kNEj+nOfQAt2AwwKsGdLQuf/qRZ
	 6uk+GPN2GP0+O0Sgvvj9/AFvSLhExpD7cTgh+4FSkBsyqtedBMm+FiUXWKlgotIKmV
	 VZxAfJFcSjR7WOpcpDJBwMDiA3xjtcMsQw2gTfuJELF1Md2EhayY8LPFL8lHwXXetp
	 2z5GGuE3t9IZg1bzHY5RhRXFHgsA+s6WocJlGgNkiMBBy0T9K9TaccOOxGkh6uwh29
	 +kUDvXVz0Bz+Q==
Date: Tue, 29 Oct 2024 16:08:31 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 16/26] signal: Replace resched_timer logic
Message-ID: <ZyD6bypT8bQunXoZ@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.220867629@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083836.220867629@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:21AM +0200, Thomas Gleixner a écrit :
> In preparation for handling ignored posix timer signals correctly and
> embedding the sigqueue struct into struct k_itimer, hand down a pointer to
> the sigqueue struct into posix_timer_deliver_signal() instead of just
> having a boolean flag.
> 
> No functional change.
> 
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

