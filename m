Return-Path: <linux-kernel+bounces-345498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF58398B6FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17446B21F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184019B5B1;
	Tue,  1 Oct 2024 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="oVY5PQHn"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6519DFA2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771453; cv=none; b=TkivPTn86O0cE8v/5WeVGdNQszRDV/ToZ4LJa95ZTQTViGIpimMg9DKmfoqSqTDjurRqhLKoVp0w+0qhniBPExCseW9n1LpVG30zqjwMlgH3ihx7EX6x3AORNFyZjxHDQQ9rwPqCbWCg0x5jTUCWek0q6rAE070UYAB4JAil9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771453; c=relaxed/simple;
	bh=tiHqxQ6Pl0fjMwM1zhM+LZDXYK+ZpX9X33lTIsoPbfo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZT/945gUJaCln+gM6DJCUZuX5ZtlM/7OcC6IeUT39Led8yj6vyrUJxH13ebY+dGmTWGvNvCrzApaf/+2jbFP6c3gOhlp9iudEOHUEVBbyqQf+o1xhqvkBeD2ZVrA6DLg2XlhzeAHzmQmUqAb3Q7KTuJGur94Z8kTddTuRWMT5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=oVY5PQHn; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727771428; x=1728376228; i=efault@gmx.de;
	bh=Rqx366fc/HD2TZtQGI9Rb+70OvLHFpNSokA+yCh9vik=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oVY5PQHndVZ5Dv7I2C2AkMGPTN2M2ZXoeLp2BJb1WEMkrlXdZlnLLWIF8Ke4OZY/
	 rZSFCmq5M0mD8F6C9+hhLYJrskcSPiTHu2ky9YhNcLdDAU3TzIULpXmW4jWLzxTkv
	 0UpjZGs4vsQPKLREbO5c7YDrI+1Wf+qKc1aT6UBqZ4y8tD2QEidqAp5uuXi360SaR
	 0w/ewL3EzYkoE5oK+tggNb8PmgqapP1dVRS+kIy/PszXYqQn67pYHAB+sFPw6rkvA
	 SFM1n8ppcnKxzE8Br6IfbPpsLUEDU1N1O4NQVmOTNz1THRWAvXUbyHO23/M8rEghG
	 HG2llpY71Y667DLPew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.56]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1sBBxj3m00-00qm4p; Tue, 01
 Oct 2024 10:30:28 +0200
Message-ID: <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>
Subject: Re: sched/fair: Kernel panics in pick_next_entity
From: Mike Galbraith <efault@gmx.de>
To: Vishal Chourasia <vishalc@linux.ibm.com>, Peter Zijlstra
	 <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 luis.machado@arm.com
Date: Tue, 01 Oct 2024 10:30:26 +0200
In-Reply-To: <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
	 <20240930144157.GH5594@noisy.programming.kicks-ass.net>
	 <Zvr2bLBEYyu1gtNz@linux.ibm.com> <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ApGsSqdkOr2DMIeHPuz4J8bHbc45joxPiKiQi9jFjpQJ1HwAD4m
 X8WfFCtWZEsSLtRkic8W220DSROLppP2J1CxkYjuQb4109ugXrDh45dut1GrOHgnGca2dI1
 WxsxOZbwDIXdIGPS7bvzxM03B/bcWyoG2olMFOZYU2lvnaGJJbrMQJpZQ3/3ZuwhtnTKjGM
 AcJ7Prso/6AwKZQbLHUrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Uzaewp3MbrI=;qI+m1nU9rooYvscarW3emixLxRO
 bi5JQ2MPTJI8OgI2wpVHcxP9HNgqeNSLM2l5WQhFfS6ERTCbJ/5JTZrBhu9kGJMqWmaof78eD
 /k3ijPrpwwR1OsR5G5WjMIW5yjT/1vDF/shpLbCH2C6Idm6u+S4pQd1y3iWIl8Om8j3pZXCqI
 hJJaYWgXSpkPpbedufIWCcW7EuIK5Gihr/6IvBNy8VYYuHLdwAmFmC0gxmO8RnF/9ZTrvg6Yi
 +v8ZX/UoiQWQyKTe43qNbTNzp0fgt1vAZs3axogMNn11UtiMVSTbDcf17OyIeZDgLBo73vV5V
 QMNZOI+k0jdqaFOfOgMyPPdWoThpPhycON1F6Wa3RbpNe+sT9EA08GV9zDVwjYjQ9+dA842Mn
 5N1g1EtekbCupxMqJX8uNIgvNG978/IqgfXkeLNpiHSiirwVbrFWQU7mr32mwtQxcd5RVsn8n
 fpixVVLUgLVnHLddgfH60yfuvOmf7NBwZ7rIDBjyTWficY9kH/PRFByxt+ctkYanNuo+sUaLs
 FbtIpdnx+L7zeFrjX9W/gig2N9ZjQLvR8sXXcr3J+aJeshteKrYsLeYVsR6qersL6RWIlGcHx
 UU+bG7Mk7HLwSoYgtPX9YXMWO1d8NOC1VxRO/ONw3Sn+zmlzul+ICym230CgBEvB+Dwzn3mm5
 708ScUNp+09qeoOiH2WBBP6jMLk3hDisATjDjEbmW3yZJIy5fxKDvhXc1nyhTNVGe/03yTBxa
 g7vJAgCAjA/ga1NUaoBkvRGp+LUvtUgfTNQaBHrjqiz1ArRkc26pOM7mh4gagC+3DliB6zAsk
 PgmcoakeO+DC8tk1MtkZK82Q==

On Tue, 2024-10-01 at 00:45 +0530, Vishal Chourasia wrote:
> >
> for sanity, I ran the workload (kernel compilation) on the base commit
> where the kernel panic was initially observed, which resulted in a
> kernel panic, along with it couple of warnings where also printed on the
> console, and a circular locking dependency warning with it.
>
> Kernel 6.11.0-kp-base-10547-g684a64bf32b6 on an ppc64le
>
> ------------[ cut here ]------------
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.11.0-kp-base-10547-g684a64bf32b6 #69 Not tainted
> ------------------------------------------------------

...

> --- interrupt: 900
> se->sched_delayed
> WARNING: CPU: 1 PID: 27867 at kernel/sched/fair.c:6062 unthrottle_cfs_rq=
+0x644/0x660

...that warning also spells eventual doom for the box, here it does
anyway, running LTPs cfs_bandwidth01 testcase and hackbench together,
box grinds to a halt in pretty short order.

With the patchlet below (submitted), I can beat on box to my hearts
content without meeting throttle/unthrottle woes.

sched: Fix sched_delayed vs cfs_bandwidth

Meeting an unfinished DELAY_DEQUEUE treated entity in unthrottle_cfs_rq()
leads to a couple terminal scenarios.  Finish it first, so ENQUEUE_WAKEUP
can proceed as it would have sans DELAY_DEQUEUE treatment.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/sched/fair.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6058,10 +6058,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq =3D cfs_rq_of(se);

-		if (se->on_rq) {
-			SCHED_WARN_ON(se->sched_delayed);
+		/* Handle any unfinished DELAY_DEQUEUE business first. */
+		if (se->sched_delayed) {
+			int flags =3D DEQUEUE_SLEEP | DEQUEUE_DELAYED;
+
+			dequeue_entity(qcfs_rq, se, flags);
+		} else if (se->on_rq)
 			break;
-		}
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);

 		if (cfs_rq_is_idle(group_cfs_rq(se)))


