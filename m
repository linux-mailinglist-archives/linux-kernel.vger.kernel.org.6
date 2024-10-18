Return-Path: <linux-kernel+bounces-371701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4434F9A3ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05033287447
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE0B18E351;
	Fri, 18 Oct 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNMoWV7D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBBE1C3F10
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255804; cv=none; b=crFQGtXx5LdmFpzg76QgDrzeTzhrw9jPu/qicmtUdCMdhNWM/jUY14oaMfx4n0wOpyGFjn/ABarekabUkFD+cO7OWD4DqVVCeGFn+LgIE7ORZjB0DTgqhAEriuFBH9Tw0t+lNkiPh/8zRg6MD5ciEIc8Z9oupYWeDyWjAnzXNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255804; c=relaxed/simple;
	bh=YKcYsgz2cEC+p+dAxSEovZsS/0h5TZYw+0KD5M6FqG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLRHRSPvw4gcffWnjIBhVI1IP9dxcbCUSY2Yvo0In4EzVYIicKRYIszrEUxQjkGZO/bc7Ma8Y/leUzCfYXzbAFch60PkUxTBK3v1hAl/kuTQ0osfIyAze62YQflMEtNgWMCoUTBeRPi3NWNODiMY8bNMIBu28lXM6qWz+U8Ou7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNMoWV7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316DCC4CEC3;
	Fri, 18 Oct 2024 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729255803;
	bh=YKcYsgz2cEC+p+dAxSEovZsS/0h5TZYw+0KD5M6FqG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNMoWV7D4HCC9q4qwKXdxrxez45xwkvuRdPUDXr04sH03aClHKnE/OzBV/Z1HQBin
	 TMuqLxCU1UIldy8KrMq3yWHFtBcNyyOuJdpuPzi3PwhfIk8EuPNxo0axXcglWdoeV7
	 8QY13wXU6FLz52t8b0C/chlXHPw3RvW8gN5mGbFJK1aOgo8vtlolAxcsrKy7aBZBa0
	 UyQV1uj8TKODqfWe3ZZ6KResNtWfPs5RgSVMMrpORLg777nWmWXmjORzyqQSnWyxNb
	 mVWcOujcJYPhmL/quzgYb/Za+otINW2EvjzixOU/Eqqsx6aB96Id5VE73dWfk1+REZ
	 Q0YCGsX2Ic7BQ==
Date: Fri, 18 Oct 2024 14:50:00 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 01/26] signal: Confine POSIX_TIMERS properly
Message-ID: <ZxJZeDlbqVMlaFps@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.314100569@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.314100569@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:00AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Move the itimer rearming out of the signal code and consolidate all posix
> timer related functions in the signal code under one ifdef.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I assume nothing has changed on this one? If so I reiterate:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

