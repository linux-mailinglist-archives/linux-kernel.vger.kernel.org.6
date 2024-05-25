Return-Path: <linux-kernel+bounces-189295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF468CEE15
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 08:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7408F2821AE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 06:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03381CA7A;
	Sat, 25 May 2024 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="sZnIxoFc"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C7168A8
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716619329; cv=none; b=VMwr3CvE2aYSgz1TnKEuTJ2YQpvRYdxMImx5w7rIu11clwnv/uBqfoXgL/YcGDn4e4vOAbplQNQGJWTfUSk2hAjZG6OEC9rR1U+IqQf5m+5R+jUV6ZQb+Z8dp2yRn9tuJQ53QDi0ar/JxjY/nLre7r72WXk5WQu1bIZRPgk/KmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716619329; c=relaxed/simple;
	bh=NVYTG1KelWlZ3U/zjHd+3dkdgqx8s3SXiVjfpb+XxP0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vGueQaxcOk8Ha4w5+kNXPjjPT/qOwXCju4PYhka+C5hDms0QEoXXDjJgUWh5Np/pFXS6tB9D9zyTcL4xFg7nLD/tqiVNZiPwBhOP7V1UOvzcCoUAB6Tex43JU3soK6ephp/oNsQNAdIKjLrYwn5Vg4g6JTAjObkexm7WYvZ/RMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=sZnIxoFc; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716619290; x=1717224090; i=efault@gmx.de;
	bh=ErbBimvCy1bCr6p/ayJoAb+oHSOlcaNDbpSKcAN0Ptc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sZnIxoFcDh7uA5NYOHec93mg7BZSNIyMhqJ6GwQhyyzv7iL3HTF0b5uZX55Vkh8T
	 sU5n9WuON0q3jg8bx8rrUKpkowbX4o0tLEYjapHDe0x7MnmTMoV67bzscK06TnGad
	 wcFUa/joYs+EtgSUyOJ5YsR8x7ox8OMyVMjO+n252c8KGMUsboTF1EIbOqZjVLHoA
	 pXPkroT40V/jcZHToTyWhF2egdLNcSOs5DRV4GGBLU2DjMOBCSpXvrm1s8x2YJ+u3
	 w6YBTqgEIF6Dj9Em6rZG4oI/MlCUKlb7Gw1+ukey0+zXrG7s302FWCfuWzU1SZA6r
	 WykHFYrmrgRxDWCjWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.218.78]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5rO-1roqWP3v6G-00PJ1R; Sat, 25
 May 2024 08:41:30 +0200
Message-ID: <e17d3d90440997b970067fe9eaf088903c65f41d.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
From: Mike Galbraith <efault@gmx.de>
To: Chunxin Zang <spring.cxz@gmail.com>, mingo@redhat.com,
 peterz@infradead.org,  juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, yu.c.chen@intel.com, yangchen11@lixiang.com, 
	zhouchunhua@lixiang.com, zangchunxin@lixiang.com
Date: Sat, 25 May 2024 08:41:28 +0200
In-Reply-To: <20240524134011.270861-1-spring.cxz@gmail.com>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F8+ucXL8zD15xrGySnVifZdwv9cUEwVOKZrCFHTKqDuWDSl5m5Z
 I5MmD1wlyZvpxZam7ZszIexTqlv5u24xfJZJjwhGyKpG8472LsIojMzAKUvqk37UUJeAzU6
 U4mc8CiSYzj57rmHpNucpyoTi7IoU7tQqAy+cn07YqKP+pRXdmbaGzMZxYwLlx+aE6MCQOF
 jVlkbCgGu2KXAASsABNmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U9fMDJrsvB8=;KCf9KHGJOT/v7EVej5/fMdOOwFJ
 2C21HoYSrOFG+M1fxcRYZhMI3gy/VsWUwAYdXaUzE2z9kmEA1NHGD8Cq65+Ty1TSyanzTaeuy
 9yY+0X1seomsF9FetK5PQ6H6P34eajGbnBE0gp2BzKYg5L+RahUrJ5kr++LXXT1KRV2vNvjsS
 VX9hjD1kd8ZbPnIlqw2cVuP13f2IFgRGUNRDFUYy11UQAFkf7VtMuIuuU+2OQApN+i+yO61El
 IE6NStuhQLfgeViO9nI7xKCggZcqT20WgD7h23fu+MF/oKw7xgA1ckFvamRTg6M4NmnninO2N
 o3PtYa/vE2pa0HbAdFSOaPoIRokNlrGt/PMGfFWB8JROcIzllYJbzlgPI6U8dmK+S+lqkBRXT
 RQEs+w5ltAywssNi0S/yhui+nSRxl97gh1iD3evG8g6ytJkVFwGsvH9rURjY02vbqlsLZ04E7
 NLkWjS/CDGgrojMQRjsV5ZcCGaJdLINZzXqJ6iP5ADipf8wfz+g1rAa4aoRSTS2P6yHJHTaA7
 LVnIRC/MO9bsokEPQQghM3gd0bNqbu2CATP0rl4IwHlsFMgcC8wSCDOYHbRjww6rYuVtN+ZQF
 Q6MnSiAEig0Y0rRPLmHoIXxp5ByZwtmm+CFtoMj002OA3Z23PNOSnHUxS0rJ+/X1tEQcxmUzI
 XpBaJ7ioUeWRqsZqjaGa15I7gblDt8MXAUR84U9snGUjqgID98pk467n0bx1NYwyVrXwXtNxH
 t4eccqcMjg2KNlnWbWJ57Y1Ac51xkZ8YAblTnVZYcRkxbqMkJiwsGwWqKT42R/iOClO0tAHt2
 VciOoOoqbgHjEADXoPrTtpHDYMHjwFWv5XIV0ky5UCSOo=

On Fri, 2024-05-24 at 21:40 +0800, Chunxin Zang wrote:
> I found that some tasks have been running for a long enough time and
> have become illegal, but they are still not releasing the CPU. This
> will increase the scheduling delay of other processes. Therefore, I
> tried checking the current process in wakeup_preempt and entity_tick,
> and if it is illegal, reschedule that cfs queue.

My box gave making the XXX below reality a two thumbs up when fiddling
with the original unfettered and a bit harsh RUN_TO_PARITY.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..922834f172b0 100644
=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8413,12 +8413,13 @@ static void check_preempt_wakeup_fair(struct rq *r=
q, struct task_struct *p, int
 	update_curr(cfs_rq);

 	/*
-	 * XXX pick_eevdf(cfs_rq) !=3D se ?
+	 * Run @curr until it is no longer our best option.  Basing the preempt
+	 * decision on @curr reselection puts any previous decisions back on the
+	 * table in context "now", including granularity preservation decisions
+	 * by RUN_TO_PARITY.
 	 */
-	if (pick_eevdf(cfs_rq) =3D=3D pse)
-		goto preempt;
-
-	return;
+	if (pick_eevdf(cfs_rq) =3D=3D se)
+		return;

 preempt:
 	resched_curr(rq);


