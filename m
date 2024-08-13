Return-Path: <linux-kernel+bounces-285391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C07DF950CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5C6B26678
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5C21A3BDD;
	Tue, 13 Aug 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAXiuORq"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5719D8AC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576174; cv=none; b=tnUYYnY+q/OOr8SPIzrXQUadUhDbUOHGSQRqsDUElfzf5PwyTnj0kZXpy/61pZ+xjJjuQn2d5K38RHAXK6IbGFn5xP3wjFLVLU4AS3pIc+TGpyl8uFQIBbZZXPzFSCmHIhMX3oEeaVCkZnYfLbyNNIj/GPASTcQpU4JMy4tl9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576174; c=relaxed/simple;
	bh=RCtodvQjuMm9uAcgAwQXW1ikeZzlZUdeEUkgYEFBlYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhN3Tqh+7yberjGO5nnLOV6FqnSYwWw02YZSS723fc0TgBUDPhRfmdVlb7HsXxgNaMEm3kuiP0yOUsZPL5qdgwoLhn0jc6gY5X4/p9RYgksl4FmsQMdlSXUen2JRSgzOZPKq6fzQxQdEopCsZgBgigpMdGdlo5VKzh2iiBQfd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAXiuORq; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-26fd5a65057so609757fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723576170; x=1724180970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hV6G2dR5McwnXMeXWSf3h9d8r3MeDDaCslj0WDtn2tk=;
        b=OAXiuORqYoKltc/qGKkMfjxY6mr/oLUDaPZ6whver/xL6rk6uHEnewSbr/Dr6dluUr
         mw/u5osce8Yq001E7HGvRXq2V+Yuh9/P1Xm18oB+b1dpx3p0AuYuFDXg2WbHuCCQY9iU
         VT0MSc+t/j4YfQheza+0rw7QUYBWdOeJhECcE1giPy0bnW8DciI0+D5M4FLtkMs0eanq
         hKAgARLkO/o1VDwstAYTdl2tsTS2hq7CRnVgWMApNoOxd98LFsgpy9ZM6EPndCYJ+nEF
         AEIFpwJF56CHHx97VAqUOW6nG8GYr55whmJsIqTIQ2eyJBBUqL6Aq9ZQ8qGMHxumOLFb
         t8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576170; x=1724180970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hV6G2dR5McwnXMeXWSf3h9d8r3MeDDaCslj0WDtn2tk=;
        b=cSFz0k347JKctMQa+V44IjeAwHlcma+A7qU5k9SX+MkxnfFILWdsWlNI8FBLSD08yQ
         +ZjUXcmt8LaeeIm3ez6mMxnBtzQjimGiM+3ERETZPBlbZDE+zByIwNJ+690LAiXgg0LL
         87Ffj1f3x/fClcXAyyQVd9m2j2ybt2w/yn6LdfLpFKVdGnFxIDdqFLytNMBRj/j5zJQc
         d5IJcL1j4K8WSIKWR6freEYRdN3N6K8DZiyQB3XYcpD4uFMcjCg7i8FGZp95SaKk8RVs
         74A6KDT75OANM/nUK2E2ygtZ2dIKupJ7CsHbSR9JUR0kXGSuveWw0LOaCbDQFHzj8pX0
         XUFw==
X-Gm-Message-State: AOJu0Yy7vVY/e4RVAgRrd0W2eBo04C9GPuIK2upJz0XPih60VYsoPAW4
	X3+qdzkkS+BNQqB6Ae/zyDIFnkwQyPgjCFcn1rRZ1C6d2916B/nN
X-Google-Smtp-Source: AGHT+IGot+Io3uGpvSAT3t8Jt+HvgE48glqfMZzoDOwqBlq4o45xgaWFm1mwODhGSw9dWbngalRjWw==
X-Received: by 2002:a05:6870:6586:b0:260:ee93:f388 with SMTP id 586e51a60fabf-26fe5bdffb9mr687939fac.32.1723576169630;
        Tue, 13 Aug 2024 12:09:29 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6979d3eb1sm1817653a12.12.2024.08.13.12.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:09:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Aug 2024 09:09:27 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RESEND sched_ext/for-6.12] sched_ext: Don't use double
 locking to migrate tasks across CPUs
Message-ID: <ZruvZ4jVMQ-5hfjk@slm.duckdns.org>
References: <ZrP_zUjrTcrfdHDe@slm.duckdns.org>
 <ZrQAB_d1WSqgYQmB@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrQAB_d1WSqgYQmB@slm.duckdns.org>

On Wed, Aug 07, 2024 at 01:15:19PM -1000, Tejun Heo wrote:
> consume_remote_task() and dispatch_to_local_dsq() use
> move_task_to_local_dsq() to migrate the task to the target CPU. Currently,
> move_task_to_local_dsq() expects the caller to lock both the source and
> destination rq's. While this may save a few lock operations while the rq's
> are not contended, under contention, the double locking can exacerbate the
> situation significantly (refer to the linked message below).
> 
> Update the migration path so that double locking is not used.
> move_task_to_local_dsq() now expects the caller to be locking the source rq,
> drops it and then acquires the destination rq lock. Code is simpler this way
> and, on a 2-way NUMA machine w/ Xeon Gold 6138, 'hackbench 100 thread 5000`
> shows ~3% improvement with scx_simple.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Link: http://lkml.kernel.org/r/20240806082716.GP37996@noisy.programming.kicks-ass.net

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

