Return-Path: <linux-kernel+bounces-371719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD359A3F23
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6B8281E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C364618CBF1;
	Fri, 18 Oct 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmG/v0ND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF62433B5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729256759; cv=none; b=jb4t/WC8shzWre2ylOP2CkiuvcH4jxF+Fx4kZrjfY7wJnIEfw9qagbr1c0If+pP3dKKTfCFyzE6smj7Tq3WDNt8lCRvcKAdJB8QQ8UXxpH+cz48shiIrejJhUPiHYiat8TBkPpMIFb8f+dNRLxwY+U/AFzICyc3EvUTRH+mnI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729256759; c=relaxed/simple;
	bh=GeYLBtAmYdkUd3emR0lPNU0LgyT6qXuMZaa2p5YRHbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW7yWnACLSltyAZRCmXYW1UztGtZKTbYwHzKNEPdPIoIXt620eGg4DhB7qav8l11CRztmf7ECpnnME7i68eyORjIC86l1nlY+1CZ3yphp+ESQPf2R9OFMfrLQ+CmCbzLP1ISAOvsM5vzAmcZK9XzhTl1QENphloIA5QrAPVr0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmG/v0ND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632C5C4CEC3;
	Fri, 18 Oct 2024 13:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729256758;
	bh=GeYLBtAmYdkUd3emR0lPNU0LgyT6qXuMZaa2p5YRHbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmG/v0ND6CRbyCLGXFDBz7QfzXB+nnxxBYPvCoXpIHit89FRYBX3tUrmeGARclAfp
	 UMgsHyEHs145/6W43cJg5TT9aVGfBMKEZcoFOFZgBbWRWMhzmDYrXjV7rFlW7ljt55
	 dPUm5BWlueI/YnR4dnZKmiKEtKIVyEBrZ7jLYf/S4Itk6GQT8Ykqy3vIA6CbPYIYrI
	 +VAk+0wsopHqzbrkkwY9SHjWzKGOK7AUR3zFFansNn0BE10uSDoDOcaBoKya3bqoT1
	 N4Z21Di/3TkVW3wzALMklE75h/vCWBPBNhIoOFGx67N+J2m+FDpR8JaHrUqcsTFz+m
	 bwClKBU/0cLgg==
Date: Fri, 18 Oct 2024 15:05:55 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 02/26] signal: Cleanup flush_sigqueue_mask()
Message-ID: <ZxJdM96j2BHaQe9-@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.374933959@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.374933959@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:02AM +0200, Thomas Gleixner a écrit :
> Mop up the stale return value comment and add a lockdep check instead of
> commenting on the locking requirement.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

