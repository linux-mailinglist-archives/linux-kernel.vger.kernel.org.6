Return-Path: <linux-kernel+bounces-361127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C0C99A3ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9781F23A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F8720CCC5;
	Fri, 11 Oct 2024 12:32:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E511CDFA6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649965; cv=none; b=LMH+sXviQ/ErJ+H98EoJ2/18tMiqni2ThkFhTpXB06h4A8Ws0USoaNoZE6uuTaR79ZDfgUpdkPDHj88jMwDRZLC9lU06JWiJqVBGeZKigqGaBPdNcyBEqSsIPZFCD0X2ABb9TWznk8/jJW6Sq3kG8CzPY9Yzy4U9XFOlID3hQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649965; c=relaxed/simple;
	bh=xsRnhspyn2u1DdrIFl2nshsotVewX46s7D2dMn0VMEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hMVDIIRe4/5omhpe5g8hYasmlMkaeeosuI7TcnjtIGt//NunWbIqQNzZNiH3Zh1O93BLRs2Y9X7dbNcmbQkIkwzbghRZ4j29EZ9Zs4TM5rNgdp+TJCbU/Dmh4waK3N0SHOZwl8Csg4RK45CPBr4yB3XSW8NDF2YI3MtPDC4icCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5AF0497;
	Fri, 11 Oct 2024 05:33:11 -0700 (PDT)
Received: from e126645.arm.com (e126645.nice.arm.com [10.34.129.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F55D3F64C;
	Fri, 11 Oct 2024 05:32:39 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Hongyan Xia <hongyan.xia2@arm.com>,
	Chritian Loehle <christian.loehle@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 0/1] sched/fair: Update blocked averages on tick
Date: Fri, 11 Oct 2024 14:32:21 +0200
Message-Id: <20241011123222.1282936-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch below was tested on a Pixel6 based on v6.8. The patch was
then ported to v6.12-rc2. The energy consumption of the Pixel6 is:
- measured using the phone's energy counters
- estimated using util signals, cluster frequency and the Energy Model

An rt-app workload runs during 20s, 5 iterations. 'count' tasks are created
with a utilization of 'util'%. Task's period is 16ms.

Measured energy:
+-------------+------+-------+-----------+------------+------------+
| granularity | util | count | base      | with patch | ratio      |
+-------------+------+-------+-----------+------------+------------+
| 0           | 5    | 8     |  5703.759 |  5624.371  | - 1.391    |
| 0           | 5    | 16    | 15021.425 | 14540.839  | - 3.199    |
| 0           | 5    | 24    | 30018.226 | 27046.899  | - 9.898    |
| 0           | 10   | 8     | 12843.869 | 12346.898  | - 3.869    |
| 0           | 10   | 16    | 45925.643 | 43081.072  | - 6.193    |
| 2           | 5    | 8     |  6288.044 |  6174.609  | - 1.803    |
| 2           | 5    | 16    | 15657.632 | 15037.596  | - 3.959    |
| 2           | 5    | 24    | 31483.032 | 27205.665  | -13.58     |
| 2           | 10   | 8     | 14003.121 | 12675.037  | - 9.484    |
| 2           | 10   | 16    | 45005.382 | 42088.515  | - 6.481    |
+-------------+------+-------+-----------+------------+------------+

Computed energy:
+-------------+------+-------+-----------+------------+---------+
| granularity | util | count | base      | with patch | ratio   |
+-------------+------+-------+-----------+------------+---------+
| 0           | 5    | 8     | 2.5764e10 | 2.4581e10  | - 4.591 |
| 0           | 5    | 16    | 7.0705e10 | 6.2580e10  | -11.490 |
| 0           | 5    | 24    | 1.5034e11 | 1.1889e11  | -20.916 |
| 0           | 10   | 8     | 4.7312e10 | 4.1573e10  | -12.131 |
| 0           | 10   | 16    | 1.7860e11 | 1.4748e11  | -17.423 |
| 2           | 5    | 8     | 3.0811e10 | 2.8950e10  | - 6.040 |
| 2           | 5    | 16    | 8.3871e10 | 7.1320e10  | -14.963 |
| 2           | 5    | 24    | 1.3414e11 | 1.2771e11  | - 4.788 |
| 2           | 10   | 8     | 5.8014e10 | 4.5861e10  | -20.949 |
| 2           | 10   | 16    | 1.8283e11 | 1.6708e11  | - 8.613 |
+-------------+------+-------+-----------+------------+---------+

Pierre Gondois (1):
  sched/fair: Update blocked averages on tick

 kernel/sched/fair.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.25.1


