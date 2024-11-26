Return-Path: <linux-kernel+bounces-421901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38A29D91B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B2A164A97
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7287012CDA5;
	Tue, 26 Nov 2024 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2HPONSG"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4084C8E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602257; cv=none; b=eRWz23gfkV6GpmHvgsJlm8pjHIAsdXLPGMcfPShQgXQkUzC7p+fAFtHzV8pSgNLbMjQ68U+MTs4i8qAM8nTW7lYplWInJvniVMLGm935uWnT1G9U4y+pzUcuKkppA+Us2ooWZklr0V8RgDWuDOud34dsQ+9ylNcscqBDXob1T9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602257; c=relaxed/simple;
	bh=/bztXMLqW/9EavRA9zfTMBlZXCrqDsxb209eemfeRjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kkgwEwIUAXQzc/1lMX3UpJpBaHx3DBbUOtjy4z/T/NVPzs82EVn5SIG61WarTbNE14Hv0M42xb+QygB5dZ1Zi4euVOb9knNPXXmBPN1Hx/tKXWDCZh5LbhuZB7sl0jShPoEyZtAeEp8HlzPUtjkEEGX/jXJT1IZ/S/zxbHUeE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2HPONSG; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-724ffe64923so2502269b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732602255; x=1733207055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6gHBca8f3Z5rWdZ74kacOlzBJ0igrkyntLlfRmlqDg=;
        b=e2HPONSGRnqnBBGUckegzXtjvOWScTcYeA9oDXPnsD8CknROHqYc596WwTZfz2lY6x
         4Nfqc8DnrQ4+t4i7FAOgJXNhYh7zLnVCXnngvtb5JYrRQFmObolOyCk/QyyVIBa2IyeW
         MwdzKOsgHhVg+n9g7PQaBT7uQ9E3NKDp94P9Hb7zKRFvTC6yl1x8N4rgAms6TU8AzN98
         fD68FZMete3lPew5nP6mfsz0YfggAHTwBZWuJ+drFJxvH5QCY3ccCwLW/j2yAGGmYZny
         abjrDTnziObYvLdnQP/N0JsVoU9VT1EWyNEUdyoq7HJ5NErSsCb2Ss6YF6TPdTaYgBpY
         1Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732602255; x=1733207055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6gHBca8f3Z5rWdZ74kacOlzBJ0igrkyntLlfRmlqDg=;
        b=XRlg//G95nFxEYcILSbQpnJGxF/b0wcap8Ffv27P66JiSX0SWPfMFmtv/RPljar76e
         qfV9pXywLlldbvwxHjZfMIR+P+3v34egGc2bjYjbH0sVo1jCvoAe7w9hgd4pxkxNyRlb
         qaiP7bR/JeiH/yTlx6gs3Fq4lpKGKYZ+El2Pc/COe0xsdIz+SVprHUQRZiAh09hTMd07
         ODozC5p4Jj93RLp8e4N7K8b4hadbPWH0UNejLMJ8KVlN/Uw62ji3jp77+aaCx4uLbFzb
         07gXb718kk78e2g3oLkQrWtxmHROBNSvHhSdSfimShPgy4vzoLlK+VlZDoKLTLh2zeq8
         tLMQ==
X-Gm-Message-State: AOJu0Yzo477eUuzBXEBy//59uaZNATTJpKa9hsvPsPJ5d0C1to1Eblnv
	go8OjLy2XEJHGZJK7Ed5ZIImRwfNP4p8Sio8WIec2m29cN2VGbvB
X-Gm-Gg: ASbGncshBFPd21KbiU6TBZLMq6OIZn2ybjDVTNgQqllO9Ske8ZIlpFtUA4+12BeUuf7
	awh83OsVsm5kKib5ukb3cZX07tCdGxj46WgGWRCDRX7X/2vXm2d3Kjf/9oNyKLdRbya8yT7DMMH
	0iFT+p5XgAqtbWfSell6Si7on2yhKpOf4xHdSXK5nL3LYrduQqVlsOMobhAqExyyziUM5M7ED20
	ZLjW0bhcDZx2H9vXF6KMwdfHpWRRnf2OJzT2TAzECUTXn0dBw==
X-Google-Smtp-Source: AGHT+IHSKE7jFHl2wfwCaGUvJBKtsmwH7CvUkWLykliS8R3DuHcNCkF1hQNq4HfbyK8elxxHIjsc2g==
X-Received: by 2002:a17:90b:2692:b0:2ea:9309:75b3 with SMTP id 98e67ed59e1d1-2eb0e0201b2mr20381548a91.2.1732602255274;
        Mon, 25 Nov 2024 22:24:15 -0800 (PST)
Received: from localhost.localdomain ([129.227.63.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d048c41sm8876929a91.41.2024.11.25.22.24.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Nov 2024 22:24:14 -0800 (PST)
From: zhouzihan30 <15645113830zzh@gmail.com>
X-Google-Original-From: zhouzihan30 <zhouzihan30@jd.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	zhouzihan30 <zhouzihan30@jd.com>,
	yaozhenguo <yaozhenguo@jd.com>
Subject: [PATCH] sched: Forward deadline for early tick
Date: Tue, 26 Nov 2024 14:23:50 +0800
Message-Id: <20241126062350.88183-1-zhouzihan30@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the problem of tick time accuracy, 
the eevdf scheduler exhibits unexpected behavior.
For example, a machine with sysctl_sched_base_slice=3ms, CONFIG_HZ=1000
 should trigger a tick every 1ms. 
A se (sched_entity) with default weight 1024 should
 theoretically reach its deadline on the third tick. 
However, the tick often arrives a little faster than expected. 
In this case, the se can only wait until the next tick to
 consider that it has reached its deadline, and will run 1ms longer.

vruntime + sysctl_sched_base_slice =     deadline
        |-----------|-----------|-----------|-----------|
             1ms          1ms         1ms         1ms
                   ^           ^           ^           ^
                 tick1       tick2       tick3       tick4(nearly 4ms)

Here is a simple example of this scenario, 
where sysctl_sched_base_slice=3ms, CONFIG_HZ=1000, 
the CPU is Intel(R) Xeon(R) Platinum 8338C CPU @ 2.60GHz, 
and "while :; do :; done &" is run twice with pids 72112 and 72113.
According to the design of eevdf,
both should run for 3ms each, but often they run for 4ms.

         time    cpu  task name      wait time  sch delay   run time
                      [tid/pid]         (msec)     (msec)     (msec)
------------- ------  -------------  ---------  ---------  ---------
 56696.846136 [0001]  perf[72368]        0.000      0.000      0.000
 56696.849378 [0001]  bash[72112]        0.000      0.000      3.241
 56696.852379 [0001]  bash[72113]        0.000      0.000      3.000
 56696.852964 [0001]  sleep[72369]       0.000      6.261      0.584
 56696.856378 [0001]  bash[72112]        3.585      0.000      3.414
 56696.860379 [0001]  bash[72113]        3.999      0.000      4.000
 56696.864379 [0001]  bash[72112]        4.000      0.000      4.000
 56696.868377 [0001]  bash[72113]        4.000      0.000      3.997
 56696.871378 [0001]  bash[72112]        3.997      0.000      3.000
 56696.874377 [0001]  bash[72113]        3.000      0.000      2.999
 56696.877377 [0001]  bash[72112]        2.999      0.000      2.999
 56696.881377 [0001]  bash[72113]        2.999      0.000      3.999

The reason for this problem is that
 the actual time of each tick is less than 1ms.
We believe there are two reasons:
Reason 1:
Hardware error. 
The clock of an ordinary computer cannot guarantee its own accurate time.
Reason 2:
Calculation error.
Many clocks calculate time indirectly through the number of cycles, 
which will definitely have errors and be smaller than the actual value,
 the kernel code is:

clc= ((unsignedlonglong) delta*dev->mult) >>dev->shift;
dev->set_next_event((unsignedlong) clc, dev);

To solve this problem,
we add a sched feature FORWARD_DEADLINE,
consider forwarding the deadline appropriately. 
When vruntime is very close to the deadline,
we consider that the deadline has been reached.
This tolerance is set to vslice/128.
On our machine, the tick error will not be greater than this tolerance,
and an error of less than 1%
 should not affect the fairness of the scheduler.

when open FORWARD_DEADLINE,
 the task will run once every 3ms as designed by eevdf:

         time    cpu  task name         wait time  sch delay   run time
                      [tid/pid]            (msec)     (msec)     (msec)
------------- ------  ----------------  ---------  ---------  ---------
 57110.032369 [0001]  perf[72752]           0.000      0.000      0.000
 57110.035805 [0001]  bash[72112]           0.000      0.000      3.436
 57110.036400 [0001]  sleep[72755]          0.000      3.456      0.594
 57110.039806 [0001]  bash[72113]           0.000      0.000      3.405
 57110.042805 [0001]  bash[72112]           4.000      0.000      2.999
 57110.045811 [0001]  bash[72113]           2.999      0.000      3.005
 57110.045816 [0001]  ksoftirqd/1[98]       0.000      0.001      0.005
 57110.048804 [0001]  bash[72112]           3.010      0.000      2.987
 57110.051805 [0001]  bash[72113]           2.993      0.000      3.001
 57110.054804 [0001]  bash[72112]           3.001      0.000      2.998
 57110.057805 [0001]  bash[72113]           2.998      0.000      3.000
 57110.060804 [0001]  bash[72112]           3.000      0.000      2.999
 57110.063805 [0001]  bash[72113]           2.999      0.000      3.001
 57110.066804 [0001]  bash[72112]           3.001      0.000      2.999
 57110.069805 [0001]  bash[72113]           2.999      0.000      3.000
 57110.072804 [0001]  bash[72112]           3.000      0.000      2.999
---
 kernel/sched/fair.c     | 21 ++++++++++++++++++---
 kernel/sched/features.h |  7 +++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d16c8545c71..ea342ef8db26 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1006,8 +1006,9 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  */
 static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if ((s64)(se->vruntime - se->deadline) < 0)
-		return false;
+
+	u64 vslice;
+	u64 tolerance = 0;
 
 	/*
 	 * For EEVDF the virtual time slope is determined by w_i (iow.
@@ -1016,11 +1017,25 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (!se->custom_slice)
 		se->slice = sysctl_sched_base_slice;
+	vslice = calc_delta_fair(se->slice, se);
+
+
+	/*
+	 * When the deadline is only 1/128 away,
+	 * it is considered to have been reached.
+	 */
+	if (sched_feat(FORWARD_DEADLINE))
+		tolerance = vslice>>7;
+
+
+
+	if ((s64)(se->vruntime + tolerance - se->deadline) < 0)
+		return false;
 
 	/*
 	 * EEVDF: vd_i = ve_i + r_i / w_i
 	 */
-	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
+	se->deadline = se->vruntime + vslice;
 
 	/*
 	 * The task has consumed its request, reschedule.
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 290874079f60..fad8e2bbf4ed 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -24,6 +24,13 @@ SCHED_FEAT(RUN_TO_PARITY, true)
  */
 SCHED_FEAT(PREEMPT_SHORT, true)
 
+/*
+ * For some cases where the tick is faster than expected,
+ * move the deadline forward.
+ */
+SCHED_FEAT(FORWARD_DEADLINE, true)
+
+
 /*
  * Prefer to schedule the task we woke last (assuming it failed
  * wakeup-preemption), since its likely going to consume data we
-- 
2.39.3 (Apple Git-146)
Signed-off-by: zhouzihan30 <zhouzihan30@jd.com>
Signed-off-by: yaozhenguo <yaozhenguo@jd.com>


