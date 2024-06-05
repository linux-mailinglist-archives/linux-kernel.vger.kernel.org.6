Return-Path: <linux-kernel+bounces-203068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ADB8FD5E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6916D1C23D7D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01EA13A87E;
	Wed,  5 Jun 2024 18:40:08 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 543B95C96
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612808; cv=none; b=lcWVfQj8vBcAY6pTR8+jfciT1H6NsU4BSz+jX58r5khMTTRQ8ArHAXSkt6q7D3/mgJk+d7CqGpkh+u542Vv/4rX3ooI2NsOTpD31aty/wjyVQNISc0HvvbymveslG8NOdQFVj5brMx9YJaSGJCXOKa7qmpk/b74OD0Ia5ZtotT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612808; c=relaxed/simple;
	bh=0jI3CUuP5puOjAYBI9zzxgoVgLBurSEEXQshgD7sXEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBZpb+VrXzlOlRliQ2uVZ96H6gMjp11lb0qSXgrbjWKcCuA0dNSPWb9pugg/ZlYXDORa4BmjLpLl/SNT+UsuVFkjjbISZiSsw+4cRH+m47zdV4B+uAnCPhIT1kb8QZFb+9DVFc3Awx2rmHY4kqr2h8efdeDWeLykcb5MYorxu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 205382 invoked by uid 1000); 5 Jun 2024 14:40:05 -0400
Date: Wed, 5 Jun 2024 14:40:05 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: Re: New locking test for the paulmckrcu/litmus github archive
Message-ID: <1d175b42-84b4-4a48-b1fb-ab6fd3566f75@rowland.harvard.edu>
References: <a8c06694-098d-4b95-845c-96b40cd3ff2d@rowland.harvard.edu>
 <df851df5-0e3a-45b1-ae85-9625309766b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df851df5-0e3a-45b1-ae85-9625309766b0@paulmck-laptop>

On Wed, Jun 05, 2024 at 11:25:11AM -0700, Paul E. McKenney wrote:
> Thank you both!
> 
> I queued and pushed the following commit, please let me know if it
> needs adjustment.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit fb65813a7a181cd86c50bb03f9df1f6a398fa22b
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Wed Jun 5 11:20:47 2024 -0700
> 
>     manual/locked: Add single-threaded spin_is_locked() test
>     
>     This new litmus test demonstrates a bug in the current LKMM lock.cat file.
>     This bug results in the following output:
>     
>             Test CoWWW+sil-lock-sil-unlock-sil Allowed
>             States 0
>             No
>             Witnesses
>             Positive: 0 Negative: 0
>             Condition exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)
>             Observation CoWWW+sil-lock-sil-unlock-sil Never 0 0
>             Time CoWWW+sil-lock-sil-unlock-sil 0.01
>             Hash=cf12d53b4d1afec2e46bf9886af219c8
>     
>     This is consistent with a deadlock.  After the fix, there should be one
>     execution that matches the "exists" clause, hence an "Always" result.

The part about being consistent with a deadlock is not very important; 
I'd omit it.  Also, the second sentence is ambiguous; change it to:

	After the fix, there should be one execution that matches the 
	"exists" clause and no executions that don't match, hence an 
	"Always" result.

> diff --git a/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus b/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus
> new file mode 100644
> index 00000000..cee5abf4
> --- /dev/null
> +++ b/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus
> @@ -0,0 +1,24 @@
> +C CoWWW+sil-lock-sil-unlock-sil.litmus

Where does the "CoWWW" part of the name come from?  If it refers to 
coherence order and three writes, I'll point out that the litmus test 
contains only two writes -- which would better be described as a lock 
and an unlock.  (Or are you counting the "write" that sets the lock's 
initial value?)

> +
> +(*
> + * Result: Always
> + *
> + * This tests the memory model's implementation of spin_is_locked().
> + *)
> +
> +{}
> +
> +P0(spinlock_t *x)
> +{
> +        int r0;

Oops!  Apparently I managed not to convert the spaces on that line to a 
tab.  Can you take care of that?

Alan

> +	int r1;
> +	int r2;
> +
> +	r0 = spin_is_locked(x);
> +	spin_lock(x);
> +	r1 = spin_is_locked(x);
> +	spin_unlock(x);
> +	r2 = spin_is_locked(x);
> +}
> +
> +exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)

