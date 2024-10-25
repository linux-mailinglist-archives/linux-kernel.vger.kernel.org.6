Return-Path: <linux-kernel+bounces-382496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E309B0EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7741C23D32
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51B120D508;
	Fri, 25 Oct 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhunUdbf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217C10A0E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884489; cv=none; b=YSWuPoohXJjOf6XnEDH0xXbPpKEYYdVhi6lhgVzKEimo9/ECtuQNR0CmryejD/KXSzZG3kOdKg1hDtKxWfJgyF9uhxsdgqpv/sf2juRn4zrycLCUDoDJu03L6qDplcB0z643e40lnGMCmzzvPknHjeV/uKxF6Zf2N3DcLAa597k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884489; c=relaxed/simple;
	bh=iI0rca7l7j1Uckw+q9845Ct8al7dFAbdQk1MZrJYbs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1S8NEU+7lrv/8BIJ1icPaSCvcYCxcEhpybPZvPKZ6rET1eIiKdrOIjpPVceRCGFU18N3MQ0nPrC1jTny8G9jYiUwPJoF/7kkdP+bI2w+usNTC6IIN1fJ6hQpfDJvs/rrRinN2AEKR/J8xI3641SXtqUxa4//yVhG1INmjY2/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhunUdbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5928C4CEC3;
	Fri, 25 Oct 2024 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729884489;
	bh=iI0rca7l7j1Uckw+q9845Ct8al7dFAbdQk1MZrJYbs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhunUdbf70euKkg2cnyLgKfRXXZfZ3wBnFpnUXMp225n4lqY0AZtzLzVpOEzCr7Bc
	 8dalsNufCHXbixzKhNn6yiYn6npvffvjmJfWcmwq5O9F0roa5H7Hya6GmguNauDAgs
	 i/ondIqKi3zS5CVis//1e6CfNTAUXKS06NDILkh9GPWJXl96kpnYWhUp0gN4QAql6h
	 s2w8lBeKiSFjGkVs45OBW25okE2uC1jCiqgsAFrlAGIB3d1fzwulzviAZmFRGJ6Zes
	 KaD9SrJ2By1545H3Z9kCvpWvT4rt/wTC/i8y7yS2vK3h7Aq0375hz/G6lVHF1+ptyQ
	 RhZY1jhFWNMDg==
Date: Fri, 25 Oct 2024 09:28:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: peterz@infradead.org, void@manifault.com, vincent.guittot@linaro.org,
	juri.lelli@redhat.com, mingo@redhat.com, bsegall@google.com,
	rostedt@goodmis.org, dietmar.eggemann@arm.com, vschneid@redhat.com,
	mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Pass correct scheduling policy to
 __setscheduler_class
Message-ID: <ZxvxR32TQ1UIVLtS@slm.duckdns.org>
References: <20241025185020.277143-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025185020.277143-1-aboorvad@linux.ibm.com>

On Sat, Oct 26, 2024 at 12:20:20AM +0530, Aboorva Devarajan wrote:
> The function __setscheduler_class determines the appropriate
> sched_class based on the scheduling policy and priority. Previously,
> the function used the task's pointer to retrieve the scheduling policy,
> which could lead to incorrect decisions if the task's struct had an
> outdated policy. This behaviour where the task pointer may reference an
> outdated policy when __setscheduler_class is called, was introduced in
> commit 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
> 
> To resolve this, corresponding scheduling policy is passed directly
> to __setscheduler_class instead of relying on the task pointer's cached
> policy. This ensures that the correct policy is always used when
> determining the scheduling class.
> 
> -------------------------------------------------------
> Before Patch:
> -------------------------------------------------------
> 
> ```
> sched_ext # ./runner -t init_enable_count
> ===== START =====
> TEST: init_enable_count
> DESCRIPTION: Verify we do the correct amount of counting of init,
>              enable, etc callbacks.
> OUTPUT:
> ERR: init_enable_count.c:132
> Expected skel->bss->enable_cnt == num_children (3 == 5)
> not ok 1 init_enable_count #
> =====  END  =====
> 
> =============================
> 
> RESULTS:
> 
> PASSED:  0
> SKIPPED: 0
> FAILED:  1
> ```
> -------------------------------------------------------
> After Patch:
> -------------------------------------------------------
> 
> ```
> sched-ext # ./runner -t init_enable_count
> ===== START =====
> TEST: init_enable_count
> DESCRIPTION: Verify we do the correct amount of counting of init,
>              enable, etc callbacks.
> OUTPUT:
> ok 1 init_enable_count #
> =====  END  =====
> 
> =============================
> 
> RESULTS:
> 
> PASSED:  1
> SKIPPED: 0
> FAILED:  0
> ```
> 
> Fixes: 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Acked-by: Tejun Heo <tj@kernel.org>

Peter, do you want me to route this patch or would tip be better?

Thanks.

-- 
tejun

