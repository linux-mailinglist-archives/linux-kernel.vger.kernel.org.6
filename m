Return-Path: <linux-kernel+bounces-387085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1089B4BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AF8B22EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6DC2071E8;
	Tue, 29 Oct 2024 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipBy9Xs2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F732071E3
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210792; cv=none; b=mwrJDryznXZxS1fKVqZEd2YOlPYpJU4Nz1pnqnCe8wep9CnxWEqght0/qXXCO0+HyirmJA5Klz4BGUkN0IzwYkDorQQ00dwU29x5+KFkehMIIYb1L7++TrlroYUWQY9TulpownVrndAm6IDwfgIlW+ZDaZr+9wGvCEoSMnyiH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210792; c=relaxed/simple;
	bh=QEcEUddjgKW2OCmwiHFR8WQFPqf4hkYksxXMXYFUi/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkwTo+nVXSzX47+68EbmtKJlhfzAXR3f4ogIq68qWbeC062OOExfMtYyVbmj8J8plNwamkKJC9ED9FpUcwGDMUezW2kUAwYBGAqjuarfctCRUoka+DAIuLMHYxN8ZXgvJ+LYyFeGlhF6OkTqTaJflArJEeH/qinEbYvmxPazyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipBy9Xs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3122C4CECD;
	Tue, 29 Oct 2024 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730210791;
	bh=QEcEUddjgKW2OCmwiHFR8WQFPqf4hkYksxXMXYFUi/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipBy9Xs2SHYIUaS9h0WT2CNmIQ2scChi0oqVdTCHp8wCsdvD0nNQO3SeOubao8KlP
	 +JK/1mUyICiZMRpVYkEpuS7ebC/NZuZg983TZOtNEfBXIYM/ZdHJXmyO18JaCXGMr4
	 4h/TwoZ19KkTRGHmlYCREFZayjxLXY8AXlnb8xkHTs2sWdhEP19leX15LB897DkK9L
	 C28+TuncT3d+1M4wl8YdQBc3rPTeel0PAb2u97WhU3bpHMRhjF5DkxPEFq93EAhrQs
	 U34vnyZGvCiPjqWvLe+aabYJlspgF8/wQOBg9lDnpvdK4xrOHPau/XxZWkNRi5ekry
	 bXLhZU4k75vOw==
Date: Tue, 29 Oct 2024 15:06:28 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 15/26] signal: Refactor send_sigqueue()
Message-ID: <ZyDr5Bky3Sp9hP1-@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.160940133@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083836.160940133@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:20AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To handle posix timers which have their signal ignored via SIG_IGN properly
> it is required to requeue a ignored signal for delivery when SIG_IGN is
> lifted so the timer gets rearmed.
> 
> Split the required code out of send_sigqueue() so it can be reused in
> context of sigaction().
> 
> While at it rename send_sigqueue() to posixtimer_send_sigqueue() so its
> clear what this is about.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

