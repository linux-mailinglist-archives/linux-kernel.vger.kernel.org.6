Return-Path: <linux-kernel+bounces-556985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B9A5D1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8596F189D030
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F1264A8C;
	Tue, 11 Mar 2025 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkerrTjG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D81EEA42
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729454; cv=none; b=d3THvq9XDQy+4UwK+jZhm0zYGjKySBD65gwyYV8fmezg7v0b6caVhG4uSwwOPQMsQcn7/K64RPt/kYlhMdkOXwPtJ/pXKZU6VMbiK7JXq5IWHO0Xvc1M+S5/ZxKqyCaZ3j6bJHudYnkJ7btpHkHhsXdO5eYRQapJqByT+idLNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729454; c=relaxed/simple;
	bh=T883aEVy7ja7ZOD24XICeZ5bNC0afNkIH4NQ+qNk+Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toNXLbQ/6NgIYNYjg5SkTOkMViRryqg+Nz2ttu5U83HlfRAIQCcr1Bg2evw0GJXAiPdM9x4rQxNl6hgNTliNxwfhJlrycyu7UZ4EsCjhFjWTtKG+E2V1bRAuVSgn4GVypvssw7m+NZbGjPwnRhopWFYlXATlJ/Z+Dl3uqccAVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkerrTjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E402FC4CEE9;
	Tue, 11 Mar 2025 21:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741729454;
	bh=T883aEVy7ja7ZOD24XICeZ5bNC0afNkIH4NQ+qNk+Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkerrTjGOlEpRxThOkUw70b+bMsLsvaYcubcidI/B6wT5PclNnZyiSNEdcwhwM7e2
	 +nhwFvnlgf3btwnLBFY3oOolZdudSUSgY+B/HQkLQ4kZNEol/afMxmoBntNxrT4C1j
	 F5WtlpgiVI4knS6stdK85vOychun1+1aNKXJ8dj287JiGfvUPiDlbLVtBKtjQPhgPi
	 LdJ+E1gyz5NlbkD7xwxC5MjlM3tzOAzSDDBf54LDNwjeE8RExfIlxtzYix2rg+Fx6g
	 YnrkCPgbuVddc0U7I5XUvPvxqa4CysgONRJzhTp+ZR0G8B2jysoc4JafcNr1mbYNAb
	 Rh+3GDKkxpR1g==
Date: Tue, 11 Mar 2025 22:44:11 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3a 18/18] selftests/timers/posix-timers: Add a test for
 exact allocation mode
Message-ID: <Z9Cuq9t_LxMBtu0h@pavilion.home>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.590144807@linutronix.de>
 <8734fl2tkx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734fl2tkx.ffs@tglx>

Le Mon, Mar 10, 2025 at 09:11:42AM +0100, Thomas Gleixner a écrit :
> The exact timer ID allocation mode is used by CRIU to restore timers with a
> given ID. Add a test case for it.
> 
> It's skipped on older kernels when the prctl() fails.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

