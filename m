Return-Path: <linux-kernel+bounces-203054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522C8FD5AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6616B21DE3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC0917559;
	Wed,  5 Jun 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPH/7uys"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724210A1F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611913; cv=none; b=DfRiAaxC3kUmFo/yA1GWNEMLzaSnl8zJbkoHoYcb1MFUCadM1Kd72IVmddP0TWT8jQvdy3prriOUOkejT0KZesAwATWUfVcMmQh4W5L6z0NYJTqfVPTWUZJeZ6p7BVEx4KdO5SKIw0ph7u7ReRROdFjGj9j42HAuVYStBIwslTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611913; c=relaxed/simple;
	bh=IMwUdBLrRm8LKyLiAuB6TGiaYLCpZWO3X31B4ozJMOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRvC4auiuZhG0hCfDxUeBzPzIEANXWq1AYy92sKoMFCIVaJmezKmj5rjM+5TBlHhCw4BkDaU+VZhpJxugxdMgxtSbpFRzMfLZYdQHyrXOIDk9eycSukxUrQ8WrrlhIYHrmQyQ6HbUxlzSy4tZS4wC6zae4gzXFiv/0shYtVmpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPH/7uys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599EBC2BD11;
	Wed,  5 Jun 2024 18:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717611912;
	bh=IMwUdBLrRm8LKyLiAuB6TGiaYLCpZWO3X31B4ozJMOQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hPH/7uysJHP2PVfKDxdgSwLfG83AKLjVkVrndzatKnrCpSP0QxttUizkTZhEpuiiN
	 1foUXN0cNAHkhcvrA1HQwUZ43w1icEpXyp+66TWusAHDquiwcPD55970f4TeQZfspS
	 +bsCSOD25h//8JBSxL5n/CQf4aUga8tf4vDWCj26M+wgpj579GDhmhBKUrzfxOPRZ+
	 KbvZgmoBEMtPKAvV5BTf23yLX5ejqsPkHZPK5zaFWFKFdVaJIW+oq69xql1oXYG0Cj
	 Tlbd0/qQPXF8td5+EXYX/WhsCw6Mbe9Mcq7AgcQ6ZMHOxLUrEnXiv2TAQPMujhSbpN
	 I3B8BK2PMyh1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E68FBCE0A73; Wed,  5 Jun 2024 11:25:11 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:25:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: New locking test for the paulmckrcu/litmus github archive
Message-ID: <df851df5-0e3a-45b1-ae85-9625309766b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a8c06694-098d-4b95-845c-96b40cd3ff2d@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c06694-098d-4b95-845c-96b40cd3ff2d@rowland.harvard.edu>

On Wed, Jun 05, 2024 at 10:47:03AM -0400, Alan Stern wrote:
> Paul:
> 
> Below is a new litmus test for the manual/locked directory in your 
> github archive.  It is based on a suggestion from Andrea Parri, and it 
> demonstrates a bug in the current LKMM lock.cat file.  Patches to fix 
> that file will be sent shortly.
> 
> Alan
> 
> ---
> 
> C islocked+lock+islocked+unlock+islocked.litmus
> 
> (*
>  * Result: Always
>  *
>  * This tests the memory model's implementation of spin_is_locked().
>  *)
> 
> {}
> 
> P0(spinlock_t *x)
> {
>         int r0;
> 	int r1;
> 	int r2;
> 
> 	r0 = spin_is_locked(x);
> 	spin_lock(x);
> 	r1 = spin_is_locked(x);
> 	spin_unlock(x);
> 	r2 = spin_is_locked(x);
> }
> 
> exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)

Thank you both!

I queued and pushed the following commit, please let me know if it
needs adjustment.

							Thanx, Paul

------------------------------------------------------------------------

commit fb65813a7a181cd86c50bb03f9df1f6a398fa22b
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Wed Jun 5 11:20:47 2024 -0700

    manual/locked: Add single-threaded spin_is_locked() test
    
    This new litmus test demonstrates a bug in the current LKMM lock.cat file.
    This bug results in the following output:
    
            Test CoWWW+sil-lock-sil-unlock-sil Allowed
            States 0
            No
            Witnesses
            Positive: 0 Negative: 0
            Condition exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)
            Observation CoWWW+sil-lock-sil-unlock-sil Never 0 0
            Time CoWWW+sil-lock-sil-unlock-sil 0.01
            Hash=cf12d53b4d1afec2e46bf9886af219c8
    
    This is consistent with a deadlock.  After the fix, there should be one
    execution that matches the "exists" clause, hence an "Always" result.
    
    Suggested-by: Andrea Parri <parri.andrea@gmail.com>
    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus b/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus
new file mode 100644
index 00000000..cee5abf4
--- /dev/null
+++ b/manual/locked/CoWWW+sil-lock-sil-unlock-sil.litmus
@@ -0,0 +1,24 @@
+C CoWWW+sil-lock-sil-unlock-sil.litmus
+
+(*
+ * Result: Always
+ *
+ * This tests the memory model's implementation of spin_is_locked().
+ *)
+
+{}
+
+P0(spinlock_t *x)
+{
+        int r0;
+	int r1;
+	int r2;
+
+	r0 = spin_is_locked(x);
+	spin_lock(x);
+	r1 = spin_is_locked(x);
+	spin_unlock(x);
+	r2 = spin_is_locked(x);
+}
+
+exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)

