Return-Path: <linux-kernel+bounces-275428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B696B94857B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741D0281D44
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28B16D33A;
	Mon,  5 Aug 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQSXB0bZ"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729142A9F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722897554; cv=none; b=G6V97Z1bb4BhpuC6JLN0RoMG7vTBp+3z1120aqxy4TufI57guQlGrx7Rq/MroMuwsAS2coI1sh5tGaV8Sbcvf7kpLi84QDvHCNeB8qjKp+hV8v0dYFOyYyfUQerZAzeDU6YRjGC+7K4lcgkcf2g70/Eof8h8MB6bcHiAEEfP+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722897554; c=relaxed/simple;
	bh=UboIftgWi3nGK8nmDvZF+z3s685BVw9P5tjQycYB93M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udOEOd9vgtNsze6hdhNgw/BgV5hDsjcyX9Kr5eveS+UFZC3sTyIT/Z/aIH/oTYGISVd+n0jd3raajwA1G8lFBq5fQ72kIkajiMhRfHSwVo6N81X5z3/EC2i04Pr7qhzv0MpTXVczfLC6aVh2Fopeb3IPY7JcoFIwvnh+Pvei/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQSXB0bZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso9790025b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 15:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722897552; x=1723502352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKTAl2RrmP9M7T4uoI/Lvht0//oeAPPjImqKca0BBgU=;
        b=UQSXB0bZ3CgVVYSR5FjXrLqYvWxRYq8rwm8tILo2Cbz7mO9JIxKg0ci4q+dFYkMkwO
         KEbtJKyad2NJn6kWrCsgto/5JkJ842vow0L38Peui19Di2GJ24Mn40mVsCvr6cNrSuIQ
         TMklKoPn+MD40yfmnKxuzwzIssSXmevbO8w8e2lKXoBYXx8C3uOVv9RDJxKHkh6uIAEb
         fCOnFHIEFi0nd7E3rxlpQzF89DxBEG8f1744NYVlm2KaPi5g2HEg5zKM2DmsmaTkNUqC
         hORX+Bdywu8hAu0cbTd2g22LUJ+T6W2tjEZMZ2og+vg+Cn7VcZSRGRK+ks41s4cD9KOQ
         /5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722897552; x=1723502352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKTAl2RrmP9M7T4uoI/Lvht0//oeAPPjImqKca0BBgU=;
        b=iFtef0KpeiB6FgIQRJ4cALGjQVvf34WLiZjlH6P6kG1lxj2j08gNMsoqVAKStryWqT
         nGvsR2Zr83LB7x5Kh660jd/vfNpAEzf4ZZ7SEb7sp8mt/MIiRiy+QK+tYejSsjNzJiVR
         PgqU9KnnE1wb6e4sz9dZQESn+IQxkJ5ojrZR/PKhkBSm6Dl0hYV3qhRactkpVnbmcot6
         YnJ+/xekI+Wj5sS6RFQ/ZCAdZNxGKFBhD1Kqhr7Mp+7HYb3SK9dLI0ogJcUNxw2t8k5I
         k5omQdjZij0gxJY3UJ1kVAYNI+VkvI4WDjq4GZIiDCtWw9AGjqh3asvvuuaGxzYTGlAt
         7uRg==
X-Forwarded-Encrypted: i=1; AJvYcCXzuvMiem+L/hjmao5lbbZX3wRxVgKf/D2Xkm0lEeLbLKceB4YFMrZw7CEaCgj3s6M7xXhL2ZxHtcvmkPeJH9otEs/nI4BDuUWCasfw
X-Gm-Message-State: AOJu0YxektZT+6O8fr9PC8rIrTbyh7f0IiAARNaJeL/lZtH5CneCYsC3
	EhUKsc3y4kt9Hx/LNCXBSFV7jCyiK46K9JMr7yVcOcsdK+ZVl0JR
X-Google-Smtp-Source: AGHT+IF5CeQerY2gQe2l2C2j2BDQl48A+gwd6xIe910uSDUqPd7f6j1Gp/OMqxmlqb1zKyKxvcdW8Q==
X-Received: by 2002:a05:6a00:1792:b0:70d:2b95:d9cd with SMTP id d2e1a72fcca58-7106cfce6c5mr16077778b3a.16.1722897551871;
        Mon, 05 Aug 2024 15:39:11 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec0bda0sm5874331b3a.8.2024.08.05.15.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 15:39:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Aug 2024 12:39:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, David Vernet <void@manifault.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v2 sched_ext/for-6.12] sched/fair: Make balance_fair() test
 sched_fair_runnable() instead of rq->nr_running
Message-ID: <ZrFUjlCf7x3TNXB8@slm.duckdns.org>
References: <Zq2GJMEl0nG0DMyX@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq2GJMEl0nG0DMyX@slm.duckdns.org>

balance_fair() skips newidle balancing if rq->nr_running - there are already
tasks on the rq, so no need to try to pull tasks. This tests the total
number of queued tasks on the CPU instead of only the fair class, but is
still correct as the rq can currently only have fair class tasks while
balance_fair() is running.

However, with the addition of sched_ext below the fair class, this will not
hold anymore and make put_prev_task_balance() skip sched_ext's balance()
incorrectly as, when a CPU has only lower priority class tasks,
rq->nr_running would still be positive and balance_fair() would return 1
even when fair doesn't have any tasks to run.

Update balance_fair() to use sched_fair_runnable() which tests
rq->cfs.nr_running which is updated by bandwidth throttling. Note that
pick_next_task_fair() already uses sched_fair_runnable() in its optimized
path for the same purpose.

v2: K Prateek Nayak pointed out that the bw control issue described in v1
    was incorrect. Patch description updated. As this makes the patch only
    relevant for sched_ext, I'll carry this through the sched_ext tree
    unless there are objections.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
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

