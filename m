Return-Path: <linux-kernel+bounces-273270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF8E9466B5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 03:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810E3282609
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64F6FA8;
	Sat,  3 Aug 2024 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU6oDyu/"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469217BAA
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722648104; cv=none; b=opLcfIMmPx2XzI2dQbSOpXHkUxLTkPIRwfh74xRxvBKmTIe5Yrp0tGYvE7IDT/olRdthD2nYavl/dbXFaja5LtMHPyrzD/UiwJJgrO9Leyut9n6qGLwNF3bpjmyGKzjq6OBIhS9pE+stBZXDNXGkdZWzpG0rJ5shZt/ueLRIK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722648104; c=relaxed/simple;
	bh=uuvDcuy1t0KdUh3/qWC2PvPTKqw4IWXuDvfev1VUH+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qxObBUxFWe12QnTYU3IXguN4hNrXTOs/ID8NTEJZLPdQayddUMiuvkgo56qZRurDzGvxOczNUC9Tkkdrqo+bZ3GxOCHNZgo1GXyPXx5hEJenG/XaBvKMA1mP6MkwrnZmM4RLP8vgTZQS/mpxNk0LY5jrlL3xI9b/ifBl1enWlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OU6oDyu/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7093ba310b0so3524907a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722648102; x=1723252902; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+WnlmaEV3OCASODCfpuDcjv8z8tSi6UN5MagVkugZJk=;
        b=OU6oDyu/+ajYbj6eRl/omsH+jPrF9e65pDvWPA72lzztHorAij5NDTrWaJO4XgFIOR
         mnhoAvMyAYEa/Qvs734Q2CYShPfcJAwEhSBR7MyaV57U41CkMMmwwfEMRZkgg9C/Sz2U
         yN6Jr5GA2DFYT4+d9Y2IPhxxHyjZcKSfyTvh9U65sCK5PirvwieQWEKfa9Ni291z2AI2
         h61xvpYa35Ue1iQ6aZzk/H2YuCLjkRMNGh2xFmk6ZxBqj46sSU7IHoEtYDFsLm2rFq0l
         eVmoPJG/iWf2WryocPUMAWabCbGanSN0Jmj/qzKQ/mPiFB1PRvffETQ7lrHNDiTgwleL
         /wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722648102; x=1723252902;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WnlmaEV3OCASODCfpuDcjv8z8tSi6UN5MagVkugZJk=;
        b=Lhz/VgSEW+pByrFL2qPgx2XxFCtAMG9Inhd5X1uo7I1zAJeJWRUAEisXXAAc+cRGSu
         TCgWTGRTB2SHzdyXhE3gyezg7BYQoXXrDEaB6JtuXBLZBzJ9/KRbwKiHxKwRHuYrHZP4
         8aiRqRl8wyokCGj7YkQ2KHHo8hzRhwCpVV76bAxsuLIV5LHHiUOL3a82sfb+ELczltFz
         7J48fFjbjXO9FM1/BVWnp+/3OuxBhgY7QrMvYIOCsgM4QsM5RGQy/XUwr0hfLvh5XNvA
         0p5cQIf4MnYv7Ibp1fTRgB8f45v+8FeWIbOf5NHPb5sbl8JxwqBtxA2+HNLfX1NZ2iPG
         GtZg==
X-Forwarded-Encrypted: i=1; AJvYcCUIpnlvC6EVGVz8n/IwgFmVV5vU8/uGCONKgiw/sZ+sds1UGVE8wwBP0QFZhENIrLI1g/DO36DWKVFZAx1UG9UEC07ZqX04MuBdbIYu
X-Gm-Message-State: AOJu0YwbnHi1zwZAADvk3+9rRwiD/2XS3lMcvYn+qabyX2bYBwJHBHIS
	aAG5GE8fxeCzv/9kW8LfNn4QhUVy0pdRN91ev2m2JhksmOXO4p4U
X-Google-Smtp-Source: AGHT+IE3k+SPiVQu+kLJbZ7M0hxRG7b4XEWJc1SfnRDEG076oc+mKs7/pvEtZaFSYhW0mryf6rddpg==
X-Received: by 2002:a05:6830:3c89:b0:703:5ccb:85f3 with SMTP id 46e09a7af769-709b996e4f0mr4912711a34.22.1722648101641;
        Fri, 02 Aug 2024 18:21:41 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7654be84esm1908647a12.89.2024.08.02.18.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 18:21:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 2 Aug 2024 15:21:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, David Vernet <void@manifault.com>
Subject: [PATCH tip/sched/core] sched/fair: Make balance_fair() test
 sched_fair_runnable() instead of rq->nr_running
Message-ID: <Zq2GJMEl0nG0DMyX@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

balance_fair() skips newidle balancing if rq->nr_running - there are already
tasks on the rq, so no need to try to pull tasks. However, this doesn't seem
correct when bandwidth throttling is in use. When an entity gets throttled,
rq->nr_running is not decremented, so a CPU could end up in a situation
where rq->nr_running is not zero but there are no runnable tasks.
Theoretically, skipping newidle balance in this condition can lead to
increased latencies although I couldn't come up with a scenario where this
could be demonstrated reliably.

Update balance_fair() to use sched_fair_runnable() which tests
rq->cfs.nr_running which is updated by bandwidth throttling. Note that
pick_next_task_fair() already uses sched_fair_runnable() in its optimized
path for the same purpose.

This also makes put_prev_task_balance() avoid incorrectly skipping lower
priority classes' (such as sched_ext) balance(). When a CPU has only lower
priority class tasks, rq->nr_running would still be positive and
balance_fair() would return 1 even when fair doesn't have any tasks to run.
This makes put_prev_task_balance() skip lower priority classes' balance()
incorrectly which may lead to stalls.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/fair.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8323,7 +8323,7 @@ static void set_cpus_allowed_fair(struct
 static int
 balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	if (rq->nr_running)
+	if (sched_fair_runnable(rq))
 		return 1;
 
 	return sched_balance_newidle(rq, rf) != 0;


