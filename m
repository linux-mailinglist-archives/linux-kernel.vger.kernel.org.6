Return-Path: <linux-kernel+bounces-553661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500BCA58D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FACC169859
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E9B221F02;
	Mon, 10 Mar 2025 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bORrUA4e"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C59221541
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592482; cv=none; b=CvHIRomudGjErLpCcoAoT3VpX7jWdIA6e+WrNvFBQHgseUe2tszSg2ezNfgCKrjzKtvuZh8s+INziM/UjqC+Ae/ZFva5b0pHC6tSffrjti9Pt4Vcv3djRu5sVE6po73QxxGGymC12MUBXjEaUE5jFsCBhbn6IXNmFgDpaeqlu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592482; c=relaxed/simple;
	bh=6vlkNLt2wNyzgoZ31HBZaGaKN/AYI9na+E8aX3yPJjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ty9BnE1Yx7Folqqba475nw/yYsiJGTtmXW6vh3FLJ4k4xtq3oHGSqvNZmmhMXhx6q2K7MY1krEFNUenFhIVuhBhzhv1+YLBDsSfrFa8eM+HeI/2sZj6TXI3iWDMtp5cDN27rVkmX8kV+0eMskQFu+EMbj5VLBEjSaCs2L3Iza7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bORrUA4e; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224104a9230so6729335ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741592480; x=1742197280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33/QyKRQnnhIEj3uXq/x7qASVRIRp5tCMAk2Yb5EEBY=;
        b=bORrUA4eu9u/hYFST3n0+cIXuyByDRUoZfGgMH9s5WxTBUYJrDkFf1MzAGJa+E/+t2
         I7gk13npNFYyKa1Jv0fus/tsko4Pkfp9rCWiYugRTzd4/iQepvzBq1TtBqtNYlV4uV68
         JpcwnpDFo/2+CRRgJXfyLg9+gf9O7AQGm0k8A/WwzECP7n6Wi4KJZ7UqBfZJpKrtEz1x
         RSBzikGAqSvteVKpLblI09h/a3cck5Ahx/Vgj5T7uto2EmsmV2jv9vPufVNgNWO1EaDv
         gMTFVyRSBnqFI8k3poyOVs8ADlyhCbQupiMJ32dehIGZsq44wpYctR98YvMKuKsLqbAW
         fGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592480; x=1742197280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33/QyKRQnnhIEj3uXq/x7qASVRIRp5tCMAk2Yb5EEBY=;
        b=HCPdUhv+GtzUmxE9Hurany2cViyoPvewKPmpEELPWl96pwLWwBq6auar0l8ISgQVr8
         JA0cayqusm3hR4uJD4LPTRSaX6Zet37fJu5+uGHro7cTMwLhNsQT2BHEDxiQm5A/FB3t
         zWZI1uRbzZq3zAlyQFv9y/wr9aHvTx4r+p7OlICaCDx+3esrTArJ98b03IuV6bbzYQof
         aJf6G0JZzxLcrP9zRt0YZ7CJp7GnxLE+9mBWVR8dr6dctBOlcL3IpFsZZZd5Qg1mK46J
         GN4K6xUty6bEixZulf1fRhHZMuNjD10WAv5Pm+hrmEiX1aZCe2XxiFqwbUteHsCNV67v
         mjPA==
X-Forwarded-Encrypted: i=1; AJvYcCXL3VG9VICzE7DDd+B+L4rpORQxugUNMg/P1BL8h16pJwWurAvCX6jN56Fu0OjSINuVXU8ImdoSVeeWkRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAiFneaLhszfU6hauXblcS+OP05j1XCLE1oagooQKexYTAjQCD
	BtQdblSmyFca9H3Fy4AmrZqRYq5u2bzMcoC8cm4GYUQKIU79j4wgfF30AkapBZo=
X-Gm-Gg: ASbGncs8ytqitGKEKFo70+HZ+h9hRgBFI2O3YqmMkT+O79vkN4Mw8SC3cnACaY6bD8L
	tk8VOkwnkNXTFHNdUrhY3fqbnEVucs7rgBEJK7ROO8GqYRT5h++n8o1z95NdCS1WYA8kLgnbhxS
	rFLEEDpWtIHaCkS/u2oKqXSUDUn9TpwsrI5bUIBat74q862WdIKEJjiWF8WoTOxSLjwPAHBWaxU
	bJdzKawaThW18r9vqGz602o6Z0rBflk3LWE7CsLKBygDlBOrBt7U8LS7KvIyEBRvS2984DQeI+Z
	IhH25XBYXite8NWpfYVwmO98DMerj4Q3iFe8Ec/4Q13BfScg4inphjlZ5DvBAIs1VRPyaAOot7m
	YrEAZAtZ0XRK7nPUGpgvfyuM=
X-Google-Smtp-Source: AGHT+IEXDvUU9C+runxcNDE1EjSSzaOhCy8SB4ThcUMkGrLj0GyJujy0MMt6MRMMAoseTC1QUt4+JA==
X-Received: by 2002:a17:903:40ce:b0:221:7854:7618 with SMTP id d9443c01a7336-22541efb708mr44497305ad.8.1741592479537;
        Mon, 10 Mar 2025 00:41:19 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f8b6sm70965225ad.136.2025.03.10.00.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:41:18 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [RFC PATCH 0/2] Prioritize idle cpus over SCHED_IDLE ones
Date: Mon, 10 Mar 2025 15:40:40 +0800
Message-Id: <20250310074044.3656-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit

  17346452b25b ("sched/fair: Make sched-idle CPU selection consistent")

the SCHED_IDLE cpus are given equal or more preference over idle ones in
fast- and slow-path of select_task_rq_fair(). This works well in flattened
cgroup hierarchy, e.g. all tasks running inside root cgroup, but may not
ideal in a deeper hierarchy where SCHED_IDLE doesn't mean anything between
entities whose parents are different. Hence a SCHED_IDLE cpu does NOT
necessarily implies any of the following:

 - It is a less loaded cpu (since the parent of its topmost idle
   ancestor could be a 'giant' entity with large cpu.weight).

 - It can be expected to be preempted by a newly woken task soon
   enough (which actually depends on their ancestors who have
   common parent).

As a less loaded cpu probably has better ability to serve the newly
woken task, which also applies to the SCHED_IDLE cpus that less loaded
SCHED_IDLE cpu might be easier and faster preempted, let's not special
case SCHED_IDLE cpus at least in slowpath when selecting.

  [ Plan to try the same in SIS, that is selecting a less loaded cpu
    and get rid of ambiguous sched_idle_cpu(). Comments and suggests
    are really appreciated. ]

Some benchmarks are tested in a Intel(R) Xeon(R) CPU E5-2650 v4 machine
based on tip/master ec3106906cbf, and are tested in following two setup:

		(t1)			(t2)
		root			root
		/  \\			/  \
	benchmark   noise	benchmark   X
					     \\
					     noise

where noise comes from a SCHED_IDLE cgroup. I didn't see an obvious diff
in hackbench or tbench, but not schbench.

				vanilla-t1	       patched-t1
Lat 50.0th-qrtle-1         8.00 (   0.00%)        8.00 (   0.00%)
Lat 90.0th-qrtle-1        13.00 (   0.00%)       13.00 (   0.00%)
Lat 99.0th-qrtle-1        19.00 (   0.00%)       18.00 (   5.26%)
Lat 99.9th-qrtle-1        22.00 (   0.00%)       22.00 (   0.00%)
Lat 20.0th-qrtle-1       257.00 (   0.00%)      259.00 (  -0.78%)
Lat 50.0th-qrtle-2         8.00 (   0.00%)        9.00 ( -12.50%)
Lat 90.0th-qrtle-2        13.00 (   0.00%)       13.00 (   0.00%)
Lat 99.0th-qrtle-2        19.00 (   0.00%)       19.00 (   0.00%)
Lat 99.9th-qrtle-2        23.00 (   0.00%)       24.00 (  -4.35%)
Lat 20.0th-qrtle-2       484.00 (   0.00%)      434.00 (  10.33%)
Lat 50.0th-qrtle-4         9.00 (   0.00%)        9.00 (   0.00%)
Lat 90.0th-qrtle-4        14.00 (   0.00%)       14.00 (   0.00%)
Lat 99.0th-qrtle-4        19.00 (   0.00%)       19.00 (   0.00%)
Lat 99.9th-qrtle-4        25.00 (   0.00%)       24.00 (   4.00%)
Lat 20.0th-qrtle-4       877.00 (   0.00%)      857.00 (   2.28%)
Lat 50.0th-qrtle-8         9.00 (   0.00%)        9.00 (   0.00%)
Lat 90.0th-qrtle-8        14.00 (   0.00%)       15.00 (  -7.14%)
Lat 99.0th-qrtle-8        20.00 (   0.00%)       21.00 (  -5.00%)
Lat 99.9th-qrtle-8        26.00 (   0.00%)       26.00 (   0.00%)
Lat 20.0th-qrtle-8      1698.00 (   0.00%)     1598.00 (   5.89%)
Lat 50.0th-qrtle-16       10.00 (   0.00%)       10.00 (   0.00%)
Lat 90.0th-qrtle-16       15.00 (   0.00%)       15.00 (   0.00%)
Lat 99.0th-qrtle-16       20.00 (   0.00%)       20.00 (   0.00%)
Lat 99.9th-qrtle-16       28.00 (   0.00%)       27.00 (   3.57%)
Lat 20.0th-qrtle-16     2900.00 (   0.00%)     2860.00 (   1.38%)
Lat 50.0th-qrtle-23        9.00 (   0.00%)        9.00 (   0.00%)
Lat 90.0th-qrtle-23       15.00 (   0.00%)       15.00 (   0.00%)
Lat 99.0th-qrtle-23       49.00 (   0.00%)       28.00 (  42.86%)
Lat 99.9th-qrtle-23     1602.00 (   0.00%)     1458.00 (   8.99%)
Lat 20.0th-qrtle-23     3796.00 (   0.00%)     3804.00 (  -0.21%)

				vanilla-t2	       patched-t2
Lat 50.0th-qrtle-1        10.00 (   0.00%)        9.00 (  10.00%)
Lat 90.0th-qrtle-1       271.00 (   0.00%)      272.00 (  -0.37%)
Lat 99.0th-qrtle-1      1013.00 (   0.00%)      793.00 (  21.72%)
Lat 99.9th-qrtle-1      1998.00 (   0.00%)     1642.00 (  17.82%)
Lat 20.0th-qrtle-1       262.00 (   0.00%)      262.00 (   0.00%)
Lat 50.0th-qrtle-2        10.00 (   0.00%)        9.00 (  10.00%)
Lat 90.0th-qrtle-2       531.00 (   0.00%)      510.00 (   3.95%)
Lat 99.0th-qrtle-2      1034.00 (   0.00%)      933.00 (   9.77%)
Lat 99.9th-qrtle-2      1846.00 (   0.00%)     1614.00 (  12.57%)
Lat 20.0th-qrtle-2       517.00 (   0.00%)      517.00 (   0.00%)
Lat 50.0th-qrtle-4        10.00 (   0.00%)       10.00 (   0.00%)
Lat 90.0th-qrtle-4       523.00 (   0.00%)      494.00 (   5.54%)
Lat 99.0th-qrtle-4       973.00 (   0.00%)      901.00 (   7.40%)
Lat 99.9th-qrtle-4      1618.00 (   0.00%)     1606.00 (   0.74%)
Lat 20.0th-qrtle-4      1015.00 (   0.00%)     1001.00 (   1.38%)
Lat 50.0th-qrtle-8        11.00 (   0.00%)       10.00 (   9.09%)
Lat 90.0th-qrtle-8       527.00 (   0.00%)      454.00 (  13.85%)
Lat 99.0th-qrtle-8       931.00 (   0.00%)      901.00 (   3.22%)
Lat 99.9th-qrtle-8      1598.00 (   0.00%)     1582.00 (   1.00%)
Lat 20.0th-qrtle-8      1738.00 (   0.00%)     1666.00 (   4.14%)
Lat 50.0th-qrtle-16        9.00 (   0.00%)        9.00 (   0.00%)
Lat 90.0th-qrtle-16      410.00 (   0.00%)      243.00 (  40.73%)
Lat 99.0th-qrtle-16      979.00 (   0.00%)      891.00 (   8.99%)
Lat 99.9th-qrtle-16     1486.00 (   0.00%)     1470.00 (   1.08%)
Lat 20.0th-qrtle-16     2708.00 (   0.00%)     2708.00 (   0.00%)
Lat 50.0th-qrtle-23        8.00 (   0.00%)        9.00 ( -12.50%)
Lat 90.0th-qrtle-23      454.00 (   0.00%)      303.00 (  33.26%)
Lat 99.0th-qrtle-23     3228.00 (   0.00%)     2564.00 (  20.57%)
Lat 99.9th-qrtle-23     5496.00 (   0.00%)     5304.00 (   3.49%)
Lat 20.0th-qrtle-23     3132.00 (   0.00%)     3156.00 (  -0.77%)

Abel Wu (2):
  Revert "sched/fair: Make sched-idle CPU selection consistent throughout"
  sched/fair: Do not specialcase SCHED_IDLE cpus in select slowpath

 kernel/sched/fair.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
2.37.3


