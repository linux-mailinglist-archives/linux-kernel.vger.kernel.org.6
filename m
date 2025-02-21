Return-Path: <linux-kernel+bounces-525355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B31CA3EEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380033A7AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80068201246;
	Fri, 21 Feb 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7D3t3hb"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9FB2010E3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127502; cv=none; b=fjwrS8uemM5PV2s6cnfwf+SHQvv3nz+H+HAOwNqCSNtWEO73WX9ePQxK7Giot72oaKVijWF3qFiPOcRQ1OWqOaYXfojH0k0O9qBigpqOLVlTXjs9RrKF+QjwunES6IbSQ+sihYyjvBIPlqKAXe2yocGUB3uW/ZM92aimSDKVinA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127502; c=relaxed/simple;
	bh=lLT1PsTxhagaQpn7A+gkGEB9wV9n8hynndSOSuMAtTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=q8ZrKOkFzvNjV2+30eOuekXsX49J4uurS6DqmdJyvXAa3Y5lqWH0PCLmmlI055mY65z6D7d7KMlGZakt1o/C7As1t6w0m/lVjCTZuRmLWHiiaL1MFwvUs1/fCuwo7etYLccOLE8XGFg6YtVSAAvqDG5+/D18PjDg6a6ZQs5eZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7D3t3hb; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-220ec47991aso24397055ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740127500; x=1740732300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LxzmFhiq725Vc+Km6timKNw3y3UtVeTzCzEuoi1T3f0=;
        b=J7D3t3hbr3TdueujmJJArj67m7r3r/Odm7y2furZNG28XR4zam3KIIE4NYIeoIBb13
         N3BSAH+GRfgvJUT8fD0Pso+2R5WRywB04ZbO16YnEF+e8tkd+lYW7WMdb7R5Gic7AQDc
         63Y5j6kZFTX+1DQh1WNk+nG/c4Tdx9dnuOqLSfz3NWLRR7N6hgwRXx3YUjo8lHJK3eTs
         ajvCzq2E788JYYGgoyE6zeyVgT8D63bm4+M5gOIjC+ueC1bx8OkjpJzcg0zPobjXTOGf
         hflr8Gchhlz3stK7gVs694uzkY86EQGZ+KKu8+o0eSucc31mRPmx91AMnbTW/LLn+NG6
         fy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740127500; x=1740732300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxzmFhiq725Vc+Km6timKNw3y3UtVeTzCzEuoi1T3f0=;
        b=WJMpftdZ6/aKHFPjbvsvojbd/23x835mI8TdHGbzUwapnoDqClEDfLEt8zavsl1Z1+
         peeyg/f/HNMuw48J5FMle8IQi3Ae416XUXpQEqhUeU/UKadbEhxKbzDCeHRl5F793yq4
         zQY9poEk8sJf/nXyGYhUTZJRtaspncv37j7oP3pBcRGPARrgUFfUvMpfsfDyFr3ox9g6
         701FRZ7qhkI2ILL+uvIkSaJG2InnYNxMj3vrPmlaSi1EQoankMcE0vF9x6dvhsHpw/Yy
         +Ia86O/awO951vp4SmHTAKfxP+lYIc72o6VeboJMAsLYT0Mhc6FHQ+nonpeNZfGKFN/m
         b3+Q==
X-Gm-Message-State: AOJu0Yx60kkIubsZtXYd0SacXFgsBmOJyC11wHVM+WzMNzgdOQjAVh2M
	2hsvwRombXpgLnDx+TUQJ9G08QPefTAeHcPDU5CQo0gxbTxKgZlD
X-Gm-Gg: ASbGnctKIZS0YBCCLATSohA8G1NL1JVmaQHrqi0Cqp4XgqbBsOTRYEo7t9+WaiD2BUT
	VHEpUnMs2ExJAwEdUVLjdE3j4lcxtlinkLPCFfjiza5PNFk2ttp0zQA4q+kCjfdLvoWin2/gh2t
	oKasuJbwASj+tBiN/1c2zr6hymJtBQS+X0DxeUzRAGrW+4XQ/HM1imz7NNtGu3mkFSs+UkoOyAz
	LHUwSHpqyiLaZUVtjC20OeaNpo8ES1vecj7YlGEvFUdwIzb7pmc8wjpwVATUC3SuqNBpASvbWir
	bU/kB1XhBViM3YHSmYDgyPjK2QwD6vllPQ==
X-Google-Smtp-Source: AGHT+IEozFw7Sb2KrtttFjw5vk4spLYbpu2gKbjhmTkleaXon0SY6+VWo3UXveWxffzvPbqtcvFrpg==
X-Received: by 2002:a05:6a20:72a3:b0:1ee:6b39:c386 with SMTP id adf61e73a8af0-1eef3c77081mr4660869637.13.1740127500318;
        Fri, 21 Feb 2025 00:45:00 -0800 (PST)
Received: from localhost.localdomain ([129.227.63.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5aa216f2sm13920955a12.69.2025.02.21.00.44.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 00:44:59 -0800 (PST)
From: zihan zhou <15645113830zzh@gmail.com>
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
	zihan zhou <15645113830zzh@gmail.com>
Subject: [PATCH V1 0/4] sched: Predict load based on conditional probability
Date: Fri, 21 Feb 2025 16:44:38 +0800
Message-Id: <20250221084437.31284-1-15645113830zzh@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The work of this patch is to predict the load after a period of time in
the future based on the conditional probability, so as to optimize the
load balancing, wake-up preemption, cpu frequency adjustment or other
tasks. PATCH 4/4 is a simple example of optimizing wake-up preemption,
which can improve the performance of the hackbench a little.

I am optimistic about the potential of this patch, but my ability and my
time are limited. I sincerely hope that more kind people can join in and
help me...

In the kernel, pelt works very well, but I think it is not perfect. For
example, there is a task 1 that sleeps for 10s, and then runs for 10s. In
this scenario, it is likely to make the wrong choice in load balancing.

Suppose we currently have two cpus (or said rqs). The load of cpu 0 is 0,
and the load of cpu 1 is 512 with a task 2:

cpu 0 (0)       cpu 1 (512)
                task 2 (512)

After task 1 wakes up, it will select cpu 0 because of the lower load,
while task 1 has a load of 0 due to long sleep, so the next time, the load
of cpus will still be like this:

cpu 0 (0)       cpu 1 (512)
task 1 (0)      task 2 (512)

At this time, there is a task 3 that wants select a cpu. Since the load of
cpu 0 is lower than cpu 1, it will choose cpu 0 to compete with a high
load task 1:

cpu 0 (128)       cpu 1 (512)
task 1 (0)      task 2 (512)
task 3 (128)

After a while, the load of two cpus is unbalanced, and the task can only be
migrated again:

cpu 0 (1152)       cpu 1 (512)
task 1 (1024)      task 2 (512)
task 3 (128)

This scenario is a fantasy of mine, there may be some wrong guesses. I
just want to illustrate my point through this example: if we can accurately
predict the future load of the task, then we can optimize many things on
the scheduler.

My idea is to predict the load when dequeue based on the load when enqueue.
This algorithm is based on conditional probability:
p(A|B) = p(AB) / p(B)

To do it, we need to count the load of tasks when they enter or leave the
rq, if we need detailed statistics, we need to use a two-dimensional array
to record:

  record_load_array[load_when_enqueue][load_when_dequeue] = count;

When enqueue, the most likely load2 when dequeue can be predicted through
the load1, where

  record_load_array[load1][load2] == max(record_load_array[load1])

Regardless of special circumstances, the maximum load is 1024, which
requires 1024*1024*8b = 1MB,

Considering that every se will maintain such a two-dimensional array, the
cost is unacceptable, and given the complexity of the actual scene, the
probability of accurately predicting the load with this array is probably
small.

So I made two optimizations:
The first optimization is to normalize the load to 0~1024 (the maximum
value of se->avg.load_avg is related to its weight), and then offset it to
the right LOAD_GRAN_SHIFT (4), so that it represents a range of 16.

For example, if the load is 893, then 893 >> 4 = 55, 55 << 4 = 880, so it
means the load from 880 to 896 (880 + (1<<4)).
For a normal process, se_weight=1024, the load change per 1ms is about
1024*1000 / 47742 = 21 < 16. Theoretically, the statistical error will not
exceed 1ms.

The second optimization is use Boyer–Moore majority vote algorithm, to
record the maximum possible dequeue load. For details, refer to the
implementation of record_predict_load_data().

Through these two optimizations, each record_load_array only needs 128B of
memory. With some other data structures included, a total of 176B of memory
is needed. My machine uses about 3MB memory:

[root@test tip]# cat /proc/slabinfo | grep predict_load_data
predict_load_data  14652  18584    176   ...

According to the experiment, the accuracy of load prediction is about
50%~70%, which is not so good, but we can already try to do something with
it!

zihan zhou (4):
  kconfig: Add kconfig of predict load.
  sched: do predict load.
  sched/debug: add debug for predict load.
  sched/fair: add sched feature PREDICT_NO_PREEMPT.

---
 fs/proc/base.c              |  39 ++++++
 include/linux/sched.h       |  46 +++++++
 include/linux/sched/debug.h |   5 +
 include/linux/sched/task.h  |   2 +-
 init/Kconfig                |  10 ++
 init/init_task.c            |   3 +
 kernel/fork.c               |   6 +-
 kernel/sched/core.c         |  15 ++-
 kernel/sched/debug.c        |  39 ++++++
 kernel/sched/fair.c         | 240 +++++++++++++++++++++++++++++++++++-
 kernel/sched/features.h     |   4 +
 kernel/sched/sched.h        |   2 +
 lib/Kconfig.debug           |  12 ++
 13 files changed, 414 insertions(+), 9 deletions(-)

-- 
2.33.0


