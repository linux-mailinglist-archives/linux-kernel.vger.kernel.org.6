Return-Path: <linux-kernel+bounces-400494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1739C0E59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915F91F21867
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB55D217F30;
	Thu,  7 Nov 2024 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOQ7B6H3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B662178EE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006325; cv=none; b=I6YvNT41hBToyL1blR3YWzrNmJPGJhEKd2aZrdwtnjtXQ8Gton7Y4TIC3iLIba6yHu90mVefcTu0R6komocw5oONlsPM+RUu7IyR4SM1Njqz3ZMMRxUBWdtAh3F+JOi0iD/wAn1bv3iWc+f+11KWMpBGGUCI0w6x0SzUk2pVI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006325; c=relaxed/simple;
	bh=IlKW0bQV48GPZXQy02azarZM17Ab9LhIjmdiEMxjmVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zga7VVDfHCD84/vCNXuARW79gJBqSW1/0vWURBDtkfJZ+YesVmakmJi8xGsQNaw0BWSyS3XFQCaHhDvQSSrDdV2JvNm95w5huNO7tPAcjD7zftqI5f61zromifo6JN5AkVbcQG4YXUsY0nKXc9Ljru6lI6vYMI6Y1ZjLWB2bMfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOQ7B6H3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8117C4CECC;
	Thu,  7 Nov 2024 19:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731006324;
	bh=IlKW0bQV48GPZXQy02azarZM17Ab9LhIjmdiEMxjmVY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dOQ7B6H38D+12zdpRzJGtCETNx4Ll/iLP+vrRK0g/+6zjKTBZNn9XIkqNpo9FaOCn
	 EZtH1Vr/s0J5PGqjxgECo0zjkyKuOA+A/iK4Jk/S6zMqqrhEmvfV2jVtSHpzZQw/Cu
	 ZrGGVNy0K5iycchclOhmto77cJSMDIYRxgECUH7WiOx7Qi5EY2HSOVT3Aenp9rICSY
	 pMCu/txRO5kOCrwSmhl6pp6LHAsY2IKijkyJNIHCcU82m9+RRbhaKWpd6zjRIVqALa
	 FK5je29FCc3WhriiXYcitmi9+lWtat+RhxMsQvSR3ZSfm3P2xtIht4m8rBtGnI/zis
	 +q5PNrvOM1oIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50512CE0886; Thu,  7 Nov 2024 11:05:24 -0800 (PST)
Date: Thu, 7 Nov 2024 11:05:24 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Boqun Feng <boqun.feng@gmail.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	cl@linux.com, iamjoonsoo.kim@lge.com, longman@redhat.com,
	penberg@kernel.org, rientjes@google.com, sfr@canb.auug.org.au
Subject: Re: [PATCH v2 0/3] scftorture: Avoid kfree from IRQ context.
Message-ID: <b9079817-72bf-4f6f-ad4a-b423a7d2e0b4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241107111821.3417762-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107111821.3417762-1-bigeasy@linutronix.de>

On Thu, Nov 07, 2024 at 12:13:05PM +0100, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> Paul reported kfree from IRQ context in scftorture which is noticed by
> lockdep since the recent PROVE_RAW_LOCK_NESTING switch.
> 
> The last patch in this series adresses the issues, the other things
> happened on the way.

For the series:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> v1…v2:
>   - Remove kfree_bulk(). I get more invocations per report without it.
>   - Pass `cpu' to scf_cleanup_free_list in scftorture_invoker() instead
>     of scfp->cpu. The latter is the thread number which can be larger
>     than the number CPUs leading to a crash in such a case. Reported by
>     Boqun Feng.
>   - Clean up the per-CPU lists on module exit. Reported by Boqun Feng.
> 
> Sebastian
> 

