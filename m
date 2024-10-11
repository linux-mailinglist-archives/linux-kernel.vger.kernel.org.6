Return-Path: <linux-kernel+bounces-360772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4183999F53
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52902287713
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120320C47D;
	Fri, 11 Oct 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XX3tEEVm"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3B20ADE4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636736; cv=none; b=HLyIOEuYb/SgdDIr7a5VC2BPWwaI85vurFMZZkrL/+TCf9z+rKTLjBnUs3QFBegEwziq9HmFVWog0h9JnBsYu5tnwmA7x24EKXgvDhUSJg2LRmIldY0JsLaNHbcNWh2ksHUytdstsM5izdsDtxpy96iVRD6F6eFpWRQVeEbQgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636736; c=relaxed/simple;
	bh=upmVzJ9gjVfXs2ROzF7vcG7wDgAsGosonijbpss3TCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHr1qYpj+nJPEb/ICvhptk1obZ2FLVdaOeEv5pSMIFCgESZacepU/QGgPQs2KnGMN6ZolkMV7N0CxS3NRe412NW+oHHRL1eHzzI2hOqn2j6JfCnzvfDlqo0hx9cuYR/knHuCuMmVgoOaaxOjpOd9a9F3gfQATlWSbjAREJSN7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XX3tEEVm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gEggDx+qqkot51kSb68zOP3SYNMgw7OxwK3vHbK/Wv4=; b=XX3tEEVmWoAqLEaAmisxHztVTp
	p2Ayss58pAIs1yzbofeAAbdv4rjZxU2L9Rceb2xkNWwyxVW7X2xN894ur4WFKE4wGeuPtYSk2Oiz8
	lw1mMUN/BeFnwCOxuoeMCEU0juk/SaOlVXUNXbxLR6rKLVUzRTWaYbvlKziVrh+8R2n2cFuqrOJe+
	Yvqw0SnVe9TluAKBcuD0KoE7ZilVLvkUynNfgMhDunBoprroFhyt78eYkk5Ntc229QZgnFtG4yNrM
	jBrqyp/Wuv5LjQTGkogxkifI/tUZNR89ukRt4OU8a9xLAahFWLmbDlA1wdO0iAI9oKB+nZFJaJhlI
	6UVlszPg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1szBNR-0000000AJfy-2NID;
	Fri, 11 Oct 2024 08:52:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B7833300642; Fri, 11 Oct 2024 10:52:01 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:52:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xavier <xavier_qy@163.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, yu.c.chen@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/eevdf: Reduce the computation frequency of
 avg_vruntime
Message-ID: <20241011085201.GM17263@noisy.programming.kicks-ass.net>
References: <20240912091454.801033-1-xavier_qy@163.com>
 <20241011062449.998696-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011062449.998696-1-xavier_qy@163.com>

On Fri, Oct 11, 2024 at 02:24:49PM +0800, Xavier wrote:
> The current code subtracts the value of curr from avg_vruntime and avg_load
> during runtime. Then, every time avg_vruntime() is called, it adds the
> value of curr to the avg_vruntime and avg_load. Afterward, it divides these
> and adds min_vruntime to obtain the actual avg_vruntime.
> 
> Analysis of the code indicates that avg_vruntime only changes significantly
> during update_curr(), update_min_vruntime(), and when tasks are enqueued or
> dequeued. Therefore, it is sufficient to recalculate and store avg_vruntime
> only in these specific scenarios. This optimization ensures that accessing
> avg_vruntime() does not necessitate a recalculation each time, thereby
> enhancing the efficiency of the code.
> 
> There is no need to subtract curr’s load from avg_load during runtime.
> Instead, we only need to calculate the incremental change and update
> avg_vruntime whenever curr’s time is updated.
> 
> To better represent their functions, rename the original avg_vruntime and
> avg_load to tot_vruntime and tot_load, respectively, which more accurately
> describes their roles in the computation.
> 
> Signed-off-by: Xavier <xavier_qy@163.com>

This makes the code more complicated for no shown benefit.

