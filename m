Return-Path: <linux-kernel+bounces-399596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5639C015F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAE01F23959
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC311DFE37;
	Thu,  7 Nov 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="kpuJ00vw"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D9372
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972898; cv=none; b=YH2Uh+iKWwAlpNuZCL++AO/1sR+GNKPLsuLz/wH2D9HfIMlDMjHGvMA2QEsJoBUxVQKfeKV8MiUI6uzY/wsc0VKcLSgrgkeJZG7nuxygSF/yp2o3WNjY4C45i6t6DmJAnwSL8DIfofeYNVZAXxaXGHP30k3jZy23VirMBzYJDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972898; c=relaxed/simple;
	bh=iVgbH+lAvaG2pNt7F7N+EDHBA3qvrz7NPoPIAPRDDDA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MLFHzvYPT74cEfShyNA/P6B8uFXPAUKk1dQc9ykwK0LlkV4B65bgwXR5Bz7dCHos8jCNuhBqktTd5eUneR7BajheT2K0GZ7s2HJ+RIMd9J1kXEqYWOWVF2TJdFHBmzwu9D4Z+QFcbIwKMQlCr7Ti7WUAI3lQ6/w4BtAQwotj75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=kpuJ00vw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730972815; x=1731577615; i=efault@gmx.de;
	bh=APsGBx91vrDSd/CB+epRMT4hkZnKIgwf4feNwSI5O8o=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kpuJ00vwSylAFUj21BBvDxyrRr18vWO2CMCTzVCK9seafcy3d5FPkrJAR1TeeMPh
	 d9F4Ew2q1H9lWkh2iYmjAbPkXqmiBLoIEigDqdUtX8HjwnWddmrg98EMX6TxeVgFl
	 boTi5eyrS41Bp8tmVWmTy5N9AfhVh4FvjPShF6K9WSppWM2gKwIB4ZO1sitG3pvwm
	 zmql3mc7s8KnfbJdv2xqKewu6d5EYVJ4m4bImuptVQrPm1yoOIlIJAI2SEdetUoFg
	 9Rw108CMPD2XacNAzcz3fMejuAvlrtDEI/qViRWjfSsQ2SrEV8/wTFYRsqg5mhpTu
	 nq0W6flOGHuGkzCTOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.61]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6qp-1tcJeO2rKV-00cCmV; Thu, 07
 Nov 2024 10:46:55 +0100
Message-ID: <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,  youssefesmat@chromium.org, tglx@linutronix.de
Date: Thu, 07 Nov 2024 10:46:53 +0100
In-Reply-To: <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
References: <20241101125659.GY14555@noisy.programming.kicks-ass.net>
	 <20241101133822.GC689589@pauld.westford.csb>
	 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
	 <20241101144225.GD689589@pauld.westford.csb>
	 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
	 <20241101200704.GE689589@pauld.westford.csb>
	 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
	 <20241104130515.GB749675@pauld.westford.csb>
	 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
	 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
	 <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
	 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
	 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qfoUNMzbyNDru2pP55rsiVV6EwDf6ffCCFkJH3pWFAI7aPe4MD6
 WF+l5cJNYegJxMl2Lv78Ns/aB9bEkT7jbsln2pdrDR4lsEaZvYSm+HwfeRvdkfto6DjOi3M
 MfCblHmlQwMHGgoiIqis0/Fxuhlkzjoe3wNpKS6kGGCPVhN4KW+Q8sr84RxThcBn/3GvUwQ
 gvw/HUBM2CZdXkTX48c4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tquZ7aVLoh4=;lfNMr4oDIWoNqhms1gFPJBMl9Sx
 v0z0LPmVIP0WNge9X4R+y7Uc+lWYsQYfEYiJP7SUCD1kc+dCie5071MDe0IFz73b+YGEBjM+1
 1Mj1S3uuIT1q2CVeHCxVlwY3TylbOqkAjxifOHqU9467NrWXguar9tgK+SgYrDfyLeFnYZbYa
 Wix4Kx52v6DzjM5JfN2VaGxRNSqXAkbx2PsyX45xLJir32vS20ALI7209+MMeYeLzOG8qoU8Z
 WhLWKe6y1XdxUMIg3yr6vUwvhfpMJz7RBDTLfshKRolH+GJDykvxvhZRfSnL3zq11CQG5EliI
 KZDmenPrLp2Bk9LjBqXay6hHPcO0Ce5xJ4ajpAFQ2l7QlA5JYWtgHPeMzcaoDsXnPgtbtHsGC
 aUUjDnWRxXnnIIyRtouHB574IcTMwKRFDis22/yT0jUcgLhDDxkjQa8Am+EFVgG80N+P01k3r
 7gMY348hOrcl50oYce7FLf0jx70GG2Crdn0zYOe/HSXbgHFY16wvBT0cTKWJoYDc82rRLZdDp
 wrODIIS/EjxCa6lpJ78kqPo0HT6nwMpkFem8OJIE+fI0dk6j0e17YBCIi2oW7/2HyT14k2SKW
 1YgCs0ZaCwcOKFS2dRZblCgjuTFs6ksYz1GJPLy5QTrIEWDAxglFhRVUXt063dQ5DVRe2Cnte
 gRuj3YCSEuuOntpvx9sn8vLGr28v4MlxP3AfwjRAa4ttdsxAe/4Nq5e17CCtxmxYlbZHdoRNO
 KW7hBwSw0ZXD4iUCoHWwm35kh0beWEMg6xSGu5FbvWx/HCw6pRI8R7k+a2OUjT8L7D/uzMy62
 G6i/gaNjwsqZ8bJHQ9voijSw==

On Thu, 2024-11-07 at 05:03 +0100, Mike Galbraith wrote:
>
> I built that patch out of curiosity, and yeah, set_next_task_fair()
> finding a cfs_rq->curr ends play time pretty quickly.

The below improved uptime, and trace_printk() says it's doing the
intended, so I suppose I'll add a feature and see what falls out.

=2D--
 kernel/sched/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

=2D-- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3794,7 +3794,7 @@ static int ttwu_runnable(struct task_str
 		int queue_flags =3D DEQUEUE_NOCLOCK;

 		if (p->se.sched_delayed)
-			queue_flags |=3D DEQUEUE_DELAYED;
+			queue_flags |=3D (DEQUEUE_DELAYED | DEQUEUE_SLEEP);

 		/*
 		 * Since we're not current anywhere *AND* hold pi_lock, dequeue
@@ -3802,7 +3802,7 @@ static int ttwu_runnable(struct task_str
 		 * case further along the ttwu() path.
 		 */
 		if (rq->nr_running > 1 && p->nr_cpus_allowed > 1) {
-			dequeue_task(rq, p, DEQUEUE_SLEEP | queue_flags);
+			dequeue_task(rq, p, queue_flags);
 			return 0;
 		}





