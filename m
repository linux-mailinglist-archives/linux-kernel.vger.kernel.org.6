Return-Path: <linux-kernel+bounces-229196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCEC916CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF67288895
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD7B17A938;
	Tue, 25 Jun 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd0VBIai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB70117107C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328419; cv=none; b=XDRd8QhucuBSmgBx3WgCiCsb1mk7b5akfVH0uiFRpR5jbcXhjUkysvyoGpqKLWsN5YS/aiLDr2rrr/OsYWB7Y9gYO+Q9ZERQ29rlgsJp4aggka0sExxQXatcrFfA72mc9IqwD3icSI3ASg8xVfyCArcPpTGG8uYYesrlAvfoofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328419; c=relaxed/simple;
	bh=oyT9TwhitNUvfhSSaJE4Ik0Q5EHCs81ZbpFUsKo6lQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2WYBscHqR1QCdocuHr4yEihcgDkZuRZKUVf51z5qtIc0bavdhOOQ4zs478LUnDimKe+ZbRrg5rQLByrloEWWjjR4ehxSADSE9szTCZLsGUnZ1yK6PrPFjWf4770luAej72LOJTEIk2ErCX14S9qIgo6KZfAe87fnKX9/D2hxgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd0VBIai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05829C4AF09;
	Tue, 25 Jun 2024 15:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719328419;
	bh=oyT9TwhitNUvfhSSaJE4Ik0Q5EHCs81ZbpFUsKo6lQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zd0VBIaiUlCV1Fn00rwFghRtQNm4ysi1Mz/eiVu38DjQ+ybnwB+s5ILdDcgkaV792
	 y3JyQzNs0sEE+Nv1pR00j5TRaxiPpLjGddpj9ytW9ITLGDq91X1tGquVekR0rYKAuO
	 5NeidnEUNGjLbpo1Saq/GABHmgp0rQaU7TZvG/YfpnktBIae7/gmxzfKuT8FwKrDjI
	 s/ZztFWTkKkwg+cILVvgC25y4/YagizoAJubEsnOk9sZr8zgWZPYQkp2ClZNR+I9oz
	 yHtiCnqKjafZWm7VFtp9bgsgAeY5ZiPpO/7bapk2VJIJ6WwPxmAZ3TGX3Cg64YyJts
	 ZD0LRG6IaUSCA==
Date: Tue, 25 Jun 2024 17:13:36 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 17/51] posix-timers: Retrieve interval in common
 timer_settime() code
Message-ID: <ZnreoF5fZmTFgGUm@localhost.localdomain>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.552899255@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610164026.552899255@linutronix.de>

Le Mon, Jun 10, 2024 at 06:42:26PM +0200, Thomas Gleixner a écrit :
> No point in doing this all over the place.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

