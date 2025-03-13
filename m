Return-Path: <linux-kernel+bounces-558989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DD2A5EE10
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA877189F68F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4417230BC2;
	Thu, 13 Mar 2025 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eIqfnsjR"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D5F2AD22
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854681; cv=none; b=JWWc71cc/vGTz5lUKybT0yj4fXNrhwQ8XZFCaf9cL3Ay83St28hNvg+hGLZiFH64UmgKpqYGiqgVVJznNsm92isk6/LfII43GCn1CjDLXMMyAKAqGelKtv7430iU6gfwWLfhgAEm4ScVLn9MDSzjszcfw8Nmtf/IxZlqgKF0aAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854681; c=relaxed/simple;
	bh=xP+UIduKgLqsiaFIOWyn+CLVZCZlrx/JOSsJVRffH3Q=;
	h=From:References:Mime-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIMSQFf5fbezl8J92nOs7byhgFESqht0XHVW5X+TR3XC/pao4VTu6V904QHHIVuD4hlsKk/4RxpN67J6CNnyF7S7o/SLFpI249lC+CePlN/m6xSGKeK7TS+xNkVUkajJaJ5CjEzckgLx1Cx4U/Yv8b9J0dukGZdsjV1mrA9wDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eIqfnsjR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so861773a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741854677; x=1742459477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JzZEFr5AJGv65/xqrdfpS/zmTm939A4Bar0S2y41nS8=;
        b=eIqfnsjRs5OzsSWB4mQktbSUVvITNdpa2y0YnqYiD3HGjaPjas67EapgjcCrPlqDtI
         CbA/bnl0JC5knBbsJm8E+OGX20eMbg/s9bEczL8Px5w+s3kvSRgZ3TwC9dcjAbvdHPZ1
         HQ8mIXVNvjpHcGtaKCOAy0/MYUV3WR3D95mt5Mo15yAW3BKirJBil8zP3UrqjCoITeNY
         c9K68blUPjsy8K/JQ0wBEC52KuWJun29m5xDHK0UYzbICrVEGZiLSXo0Jze9H0Kt5pfI
         Gc+rrGsbDftGfzaP5nn1Auu0opgW/FfSpl0Kqy1YojTI4YsjccLfLM/88Tq4picoXGXm
         zMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741854677; x=1742459477;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzZEFr5AJGv65/xqrdfpS/zmTm939A4Bar0S2y41nS8=;
        b=IuI2qIvuOhnI/IcAMUBdWpWz1MMcnp/DCsLZgBtIQXQj/0//GBBk1eYmHM/IMAX6KO
         57IZuGKzzmzcaDyWQY43Z5SnTcDyiIcUhcmPTDDZfpaV3P9sAnbWshhuaLBuHCUAUWEN
         PlmlNQI9tkrYmUHOLQnyjhZ8sLZIUZKlNnnDsVp8gGM9BmHHPP5gUIsjewVBxLDMvgNs
         xxVKlONlkUnvWre3HLovfH7uQc7xYCugY7qquKI+PDoWIe8B6oFAc9dPbF83wDXaQeLW
         0EL47ZUbSTsPdZ16KIPHbGYE2YVa/TV3gSei7+JXF46mFyNe33jWKB3uooQgYVOowFhS
         nkUQ==
X-Gm-Message-State: AOJu0YzGD+wYk1RSA76dUwWcouGY8lm0aBCXNGPUb9jltnjcRBut+RqW
	oo60Q2nZvy34yYGfFOoEEGeJD/voCMEkOkxw0dnyMNpjto73Y5pFFgYa13cAOpgD1E0fBMQRsKf
	7nU6Uy38J75Eo//dtfXDyF79/gN0ojnbdu6j2
X-Gm-Gg: ASbGncvZqOWs/HUUg7UHHFX1orv5rEm9Sv22gSHzDTg6g1BEwNdor0oixFQUVVbcQlU
	PapT4W+j2Y9InXQWyhWXNDeDsnQSmo4+HhzpHedKvBV4bW5DRkqhc4qWo89QxSWRytaUNAhHrRm
	/T2qQduUpaMy1C2I604jrh7bGSOyg=
X-Google-Smtp-Source: AGHT+IGjHYgoaKge4gmbxZEVJocvCSL4WjU6zx9IMgtWnibGLUnZxsWfFQkIRBJVMMXXNaOUiTt6M2bXdyox8kKbD4U=
X-Received: by 2002:a05:6402:268c:b0:5e6:17fb:d3c6 with SMTP id
 4fb4d7f45d1cf-5e617fbd730mr24630494a12.25.1741854677194; Thu, 13 Mar 2025
 01:31:17 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Mar 2025 01:31:16 -0700
From: Aaron Lu <ziqianlu@bytedance.com>
References: <CANCG0Gfn-BENDNqJmWC2BCxXLA8pQWrAwNibx22Dv_yUzyNV5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
In-Reply-To: <CANCG0Gfn-BENDNqJmWC2BCxXLA8pQWrAwNibx22Dv_yUzyNV5g@mail.gmail.com>
Date: Thu, 13 Mar 2025 01:31:16 -0700
X-Gm-Features: AQ5f1JoLNCLegHWoXyHhuFbbpfeRbUbj2h9b52i85emc5NJBVWEPj-dUuBceXX4
Message-ID: <CANCG0GdOwS7WO0k5Fb+hMd8R-4J_exPTt2aS3-0fAMUC5pVD8g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Defer throttle when task exits to user
To: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

It appears this mail's message-id is changed and becomes a separate
thread, I'll check what is going wrong, sorry about this.

On Thu, Mar 13, 2025 at 02:20:59AM -0500, Aaron Lu wrote:
> Tests:
> - A basic test to verify functionality like limit cgroup cpu time and
>   change task group, affinity etc.

Here is the basic test script:

pid=$$
CG_PATH1=/sys/fs/cgroup/1
CG_PATH2=/sys/fs/cgroup/2

[ -d $CG_PATH1 ] && sudo rmdir $CG_PATH1
[ -d $CG_PATH2 ] && sudo rmdir $CG_PATH2

sudo mkdir -p $CG_PATH1
sudo mkdir -p $CG_PATH2

sudo sh -c "echo $pid > $CG_PATH1/cgroup.procs"

echo "start nop"
~/src/misc/nop &
nop_pid=$!
cat /proc/$nop_pid/cgroup
pidstat -p $nop_pid 1 &
sleep 5

echo "limit $CG_PATH1 to 1/10"
sudo sh -c "echo 10000 100000 > $CG_PATH1/cpu.max"
sleep 5

echo "limit $CG_PATH1 to 5/10"
sudo sh -c "echo 50000 100000 > $CG_PATH1/cpu.max"
sleep 5

echo "move to $CG_PATH2"
sudo sh -c "echo $nop_pid > $CG_PATH2/cgroup.procs"
sleep 5

echo "limit $CG_PATH2 to 5/10"
sudo sh -c "echo 50000 100000 > $CG_PATH2/cpu.max"
sleep 5

echo "limit $CG_PATH2 to 1/10"
sudo sh -c "echo 10000 100000 > $CG_PATH2/cpu.max"
sleep 5

echo "set affinity to cpu3"
taskset -p 0x8 $nop_pid
sleep 5

echo "set affinity to cpu10"
taskset -p 0x400 $nop_pid
sleep 5

echo "unlimit $CG_PATH2"
sudo sh -c "echo max 100000 > $CG_PATH2/cpu.max"
sleep 5

echo "move to $CG_PATH1"
sudo sh -c "echo $nop_pid > $CG_PATH1/cgroup.procs"
sleep 5

echo "change to rr with priority 10"
sudo chrt -r -p 10 $nop_pid
sleep 5

echo "change to fifo with priority 10"
sudo chrt -f -p 10 $nop_pid
sleep 5

echo "change back to fair"
sudo chrt -o -p 0 $nop_pid
sleep 5

echo "unlimit $CG_PATH1"
sudo sh -c "echo max 100000 > $CG_PATH1/cpu.max"
sleep 5

kill $nop_pid

note: nop is a cpu hog that does: while (1) spin();

> - A script that tried to mimic a large cgroup setup is used to see how
>   bad it is to unthrottle cfs_rqs and enqueue back large number of tasks
>   in hrtime context.

Here are the test scripts:

CG_ROOT=/sys/fs/cgroup

nr_level1=2
nr_level2=100
nr_level3=10

for i in `seq $nr_level1`; do
	CG_LEVEL1=$CG_ROOT/$i
	echo "cg_level1: $CG_LEVEL1"
	[ -d $CG_LEVEL1 ] || sudo mkdir -p $CG_LEVEL1
	sudo sh -c "echo +cpu > $CG_LEVEL1/cgroup.subtree_control"

	for j in `seq $nr_level2`; do
		CG_LEVEL2=$CG_LEVEL1/${i}_$j
		echo "cg_level2: $CG_LEVEL2"
		[ -d $CG_LEVEL2 ] || sudo mkdir -p $CG_LEVEL2
		sudo sh -c "echo +cpu > $CG_LEVEL2/cgroup.subtree_control"

		for k in `seq $nr_level3`; do
			CG_LEVEL3=$CG_LEVEL2/${i}_${j}_$k
			[ -d $CG_LEVEL3 ] || sudo mkdir -p $CG_LEVEL3
			~/test/run_in_cg.sh $CG_LEVEL3
		done
	done
done

function set_quota()
{
	quota=$1

	for i in `seq $nr_level1`; do
		CG_LEVEL1=$CG_ROOT/$i
		sudo sh -c "echo $quota 100000 > $CG_LEVEL1/cpu.max"
		echo "$CG_LEVEL1: `cat $CG_LEVEL1/cpu.max`"
	done
}

while true; do
	echo "sleep 20"
	sleep 20

	echo "set 20cpu quota to first level cgroups"
	set_quota 2000000
	echo "sleep 20"
	sleep 20

	echo "set 10cpu quota to first level cgroups"
	set_quota 1000000
	echo "sleep 20"
	sleep 20

	echo "set 5cpu quota to first level cgroups"
	set_quota 500000
	echo "sleep 20"
	sleep 20

	echo "unlimit first level cgroups"
	set_quota max
done

run_in_cg.sh:

set -e

CG_PATH=$1
[ -z "$CG_PATH" ] && {
	echo "need cgroup path"
	exit
}

echo "CG_PATH: $CG_PATH"

sudo sh -c "echo $$ > $CG_PATH/cgroup.procs"

for i in `seq 10`; do
	~/src/misc/nop &
done

>   The test was done on a 2sockets/384threads AMD CPU with the following
>   cgroup setup: 2 first level cgroups with quota setting, each has 100
>   child cgroups and each child cgroup has 10 leaf child cgroups, with a
>   total number of 2000 cgroups. In each leaf child cgroup, 10 cpu hog
>   tasks are created there. Below is the durations of
>   distribute_cfs_runtime() during a 1 minute window:

@durations:
[8K, 16K)            274 |@@@@@@@@@@@@@@@@@@@@@                               |
[16K, 32K)           132 |@@@@@@@@@@                                          |
[32K, 64K)             6 |                                                    |
[64K, 128K)            0 |                                                    |
[128K, 256K)           2 |                                                    |
[256K, 512K)           0 |                                                    |
[512K, 1M)           117 |@@@@@@@@@                                           |
[1M, 2M)             665 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2M, 4M)              10 |                                                    |

The bpftrace script used to capture this:

kfunc:distribute_cfs_runtime
{
	@start[args->cfs_b] = nsecs;
}

kretfunc:distribute_cfs_runtime
{
	if (@start[args->cfs_b]) {
		$duration = nsecs - @start[args->cfs_b];
		@durations = hist($duration);
		delete(@start[args->cfs_b]);
	}
}

interval:s:60
{
	exit();
}

>   So the biggest duration is in 2-4ms range in this hrtime context. How
>   bad is this number? I think it is acceptable but maybe the setup I
>   created is not complex enough?
>   In older kernels where async unthrottle is not available, the largest
>   time range can be about 100ms+.

