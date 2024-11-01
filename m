Return-Path: <linux-kernel+bounces-392339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FDF9B92CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E6B1F23930
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175601A0B16;
	Fri,  1 Nov 2024 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyc9e/3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763D19BBC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469874; cv=none; b=cHegkFJdg7ZkRM8ILMrG9EOX82kmwjSH1J8OgIkso3wLqWVoTJewX9CDP/VOV5J4FPoIApzVeFyBb+ux0brD51qJtzq9PGF1GQexcNBrCM/1/yHO0SYWVutnNzBU3zp7yRB2RPqtAwm9K9fQiMjygph4Jb9a6gIk3Q2znzzIPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469874; c=relaxed/simple;
	bh=MmP17vwC7Ilo3FBahRh2TnMbnoRoJp95aydVJLBVmL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAB/6UL4aIhDezo++GEoZok8RUWODaya3zik3XMmgPlM2JC2SQiPzAOmHeKODzYe5G5CHOfLZVVgvZxvI+DYi/9D5Cj6YwWFVGJvYdk6M5mIRiB9uZXg5cKiHRO/vmRHhtEG0r8Hceu3h9ClCuqO/LZodkLI/noOKlRrTB0DBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyc9e/3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73698C4CECD;
	Fri,  1 Nov 2024 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730469874;
	bh=MmP17vwC7Ilo3FBahRh2TnMbnoRoJp95aydVJLBVmL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyc9e/3A8kdFCvBFAfiTCT1zL5OJqineFxFE9LLMS7Y4uNppoymRjyJwAMT0hXYVc
	 RMGq7rsEoXPv1aJa7DeH9VEca+taVD9NcFXLcLWrI/pCCx9OOlGs/Ce8apxfAyC0jR
	 YCDN0Jc5NY1iddRZA1PA0sCHuj6EEhE6WOuexeIBhHD2xT7ppn3XKUcPfqcJw/FcYg
	 T2IB1Ek9+OEzAihmF3MXfjj8ghnrW1gx5q+VpUbHaqroiCKrb3LDldtww3vf/fLanJ
	 ItOxA5e8nLJqEub3EAQ53Zczysniz1NYZy1DNpvo1XKgbcXyO+gOzPhyvvKf21MrKL
	 DzMkhq1H/xL9Q==
Date: Fri, 1 Nov 2024 15:04:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 16/20] signal: Handle ignored signals in
 do_sigaction(action != SIG_IGN)
Message-ID: <ZyTf7lNNYt8Wjbfq@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.561437034@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031154425.561437034@linutronix.de>

Le Thu, Oct 31, 2024 at 04:46:42PM +0100, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> When a real handler (including SIG_DFL) is installed for a signal, which
> had previously SIG_IGN set, then the list of ignored posix timers has to be
> checked for timers which are affected by this change.
> 
> Add a list walk function which checks for the matching signal number and if
> found requeues the timers signal, so the timer is rearmed on signal
> delivery.
> 
> Rearming the timer right away is not possible because that requires to drop
> sighand lock.
> 
> No functional change as the counter part which queues the timers on the
> ignored list is still missing.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

