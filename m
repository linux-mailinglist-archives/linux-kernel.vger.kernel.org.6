Return-Path: <linux-kernel+bounces-385197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163CB9B33E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BECB20D48
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967AB1DDC3A;
	Mon, 28 Oct 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz7bkbel"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FA33F3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126583; cv=none; b=Gl0Z+wsk+RZbK0hECS4BHr4TXqa0euxI1eo61yT993mh8V8nbyuw4gzlLOTTqk3+QVg8yr89cKMB/tNi/r8Uw/xxAVV4xNaBwMeFuqpyMSNkKeekmEPuiv6LAT1ASIQ8CNoxXE4IINQ2E+1YmKpGk2WrnW+tv0pu0gB0lBTq6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126583; c=relaxed/simple;
	bh=SSv5AI0tkljGUXFr3U5UhnNwSyuIAzaEBF5MefKfPU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF8jLwg2Lydiix+7Giqw8fisxVKFOsEzUzVjHhRxnWQsUXDgajPDelHoBLRZr0a2UXC5CaaO5/bPzskQKbfTirypw8uNdXs0xvHVT26jCpUw+Pkwa9lGmuMXDnIGana0tAuWPmILuR/UWM/z5tvguIjzo7Id7L/ZteERGWSJPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz7bkbel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AA5C4CEC3;
	Mon, 28 Oct 2024 14:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730126582;
	bh=SSv5AI0tkljGUXFr3U5UhnNwSyuIAzaEBF5MefKfPU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pz7bkbelpToGNbobo8K4T0eL486rd/ruaArHRuNFS4hZ0RPUUnlXil1aneHMDTebs
	 rOqJF1S39zrE8aJ1etFS5cFF83iBFPfQH+BdAoDxU8gHLkKVB7zE+mguGhceVcdKjT
	 wqHrA/U9fP1DzyMuXPynMXRcsnV594HzSAawhKKYsG9qgolemHj0We6LyL1f0RZqmt
	 nR9/KVJpJO7GW1CWjMQL8Xf2ksd6436kqZnoAXMIYbw4mauaq1ZdjYWWU4VOcDli3+
	 I10Q6Nuvbo2JxGdUKv6ZYUuvmtifGa8hmLIacZsmlKnwntYOfJKo9tKxXEjFumPN88
	 2rkA3u16j7m2w==
Date: Mon, 28 Oct 2024 15:42:59 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 11/26] posix-timers: Add a refcount to struct k_itimer
Message-ID: <Zx-i89gkab0s8c-J@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.910895102@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.910895102@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:14AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To cure the SIG_IGN handling for posix interval timers, the preallocated
> sigqueue needs to be embedded into struct k_itimer to prevent life time
> races of all sorts.
> 
> To make that work correctly it needs reference counting so that timer
> deletion does not free the timer prematuraly when there is a signal queued
> or delivered concurrently.
> 
> Add a rcuref to the posix timer part.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

