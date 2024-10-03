Return-Path: <linux-kernel+bounces-348827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4074998EC4F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A6F1F2275E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23865139D07;
	Thu,  3 Oct 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="fN9UA042"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2C3AC2B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947913; cv=none; b=OfESdjkffzUzrf7EY270BDqwQ0de23HdZ151z20l8aHEI5bxw6n3tuup4sh+82j+yUtTXPKGJ4o7HUVYHe5/RjhTfW7LwtfR2eJYS90KTf1WHiRjHIRZqll2cqOuGCMa1Wh+9x54awfRqs8/ufHeEAeSHZmK6YY6KUHtsifzYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947913; c=relaxed/simple;
	bh=6FDz1ieVcunc0jsEC4DOHmtr+NPK1PD+YS5dvYz7Mms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MkuuGhZgIGtYxOWYrMIoe5tnpfsLmafvuJB0wT2r97gAF+23UUOojZIJ+GhlpnYDDnKr/MNumvkUVC9ip3eldFTsPnIRpUsa57FYUh1nXe/sp69G8/f1M61kn1b01lKmhB32SJfXwjqCQFpLIXHuPbP+/GKB5tnOi4Tct7uDB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=fN9UA042; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727947868; x=1728552668; i=efault@gmx.de;
	bh=FuYXqkPOu0Z7mZA8VnhpQOn631I+cxlKBqc0u19fF9w=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fN9UA0429NvAaueWfZy3hGm5gwzGLQWy6K+tTmeAcGagt7ICm2Cx+oxAMUr9yhc1
	 PMAswd1sTEBdwN7olukyu0NrUGDfw9fWCAlgDVDWM+8PzevKO+5qQXfRzDZrjZPMY
	 mbNgVCo+MkSu0wKw5Bpx0TF9AVJGJEjiG0lt1F0u/cEjTyimRGx+5UK2xb/5I8cil
	 kbqNTqHwjIixSpoFyiz0+VleoOIRIlTClPq3zJozxP3PX7/GcjOrlDcskjyDBaeSE
	 7OZ5j6+7UYsJbIL8Mkwr/Y6APpp3UJzGluECl2E8CjNPh+9I7PQbxZIMEnXgfUQve
	 1yToR03t8UGsye5VLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ygO-1sqG1i03rq-0070g1; Thu, 03
 Oct 2024 11:31:08 +0200
Message-ID: <acad4ac6a2daea2884e8ae4d031dfc8ae30fc365.camel@gmx.de>
Subject: Re: sched/fair: Kernel panics in pick_next_entity
From: Mike Galbraith <efault@gmx.de>
To: Benjamin Segall <bsegall@google.com>
Cc: Vishal Chourasia <vishalc@linux.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri
 Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, luis.machado@arm.com
Date: Thu, 03 Oct 2024 11:31:06 +0200
In-Reply-To: <2ffbd642407a2bc51a387b6f89e74f0f9c9f85cf.camel@gmx.de>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
	 <20240930144157.GH5594@noisy.programming.kicks-ass.net>
	 <Zvr2bLBEYyu1gtNz@linux.ibm.com> <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
	 <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>
	 <xm26msjmm91q.fsf@bsegall.svl.corp.google.com>
	 <2ffbd642407a2bc51a387b6f89e74f0f9c9f85cf.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g2kuHNPg2zIISGhSWUyqymCkc5Ev4qG954JU4TO0xNh+sWYmggd
 lmpKEKZbpqEaIDddQ4FiRigOI03oc8nvyPLd2X3L4x7OR4BEAPVztkUgpx1sQDi2TG+uBVJ
 bklau2KhoYLOeIVF8I151buDaYZtZqBfhE02KKPRjWoGRXbC9Rn6mivorlq+cpGy3SR6Q7t
 oZ+YQs2i+ATHQgvJs4EqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F1HqP8dJ+2I=;iqrUemDXRgyT0R4ROIUpMlwmI4d
 8MFwHY+/u7Ba+Dl6xMDTbI3hHmNLuFRXQRav5rZ1ma9TWaNAsPu/svuFc46ZdOczk8ntlxkFp
 nQNZiVlehj7+D2rMILNUoGNilnZ7RxUGpLeTBpvw5z+uBMk+MBi8p/t+v3vx1UiBSReVzp2Jk
 zrwenlZ0/0MIJKfniFA0bSLIZK4ZYuCPdyOFxO29TKLVXcy7QDneJcnnAQ98P9dPpcpU0svnn
 /8xg5N400mzrOV9FyldmiUw/8F4xeBbn9Fu765Alzn3icxW9xwVXt/EnUV41q26Rq3eUYq/7H
 m85TbfQS1OHyDEBmPFFdcTyem5bLL+ogYTLjDtviP201VJ0nwH2lPuInNanotEHc/xmoVlMlU
 QU8HdobrkKg+deOQBPgCgUeHqBRGzAdkkwqB6Rqp/jGsn+j95ikToB4omcrAeAYDVKBcC7E07
 iVkBTclPZyrXN7l/NjCdzJbX9qFWQ1M434+lTsSG7vFLBCUHFYtmH/+JBSzZxg6VsW9vxhrb1
 LrWoN/oazu8cn+Cx/a4fAyLIhPsl9WOPhWvttl2BHwboLtqIppwVBmSgUc64K45SyqLD9yggr
 5aCRd+nOVo2ezm5fcD4lstbKOEDl+QUej1D27GKSGJde8kHX5RI1I2LJqJii0yTrEawXohpnK
 OFs6hFKCg3yK1FIHC0fX++qg2RWldGT8WrXKcI+lHo4bQxngH90nnuk28hd0xw0EY36q419Al
 UHSa+SrXQfVaaIo3nRmimKJUGJ2E+v/eB3BiTELvlYubFl9mrooMW/Zj88H+MGZiEpKfaRtoE
 MtwDvBP7xKc4rIph19iQF63w==

On Thu, 2024-10-03 at 06:41 +0200, Mike Galbraith wrote:
> On Wed, 2024-10-02 at 15:31 -0700, Benjamin Segall wrote:

> > Whether dequeue_entity + enqueue_entity is better or worse than
> > requeue_delayed_entity (+break), I really don't know.
>
> Hm, I'd say requeue_delayed_entity() not only fits better, it using
> less lines gives it an extra brownie point.

Probable not worth any churn or effort, but it is an option.

sched: Clean up sched_delayed handling in unthrottle_cfs_rq()

requeue_delayed_entity() achieves and documents in one line what a less
clear preparatory dequeue facilitates over several, so use it instead,
and remove the superfluous comment.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/sched/fair.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6058,12 +6058,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq =3D cfs_rq_of(se);

-		/* Handle any unfinished DELAY_DEQUEUE business first. */
-		if (se->sched_delayed) {
-			int flags =3D DEQUEUE_SLEEP | DEQUEUE_DELAYED;
-
-			dequeue_entity(qcfs_rq, se, flags);
-		} else if (se->on_rq)
+		if (se->sched_delayed)
+			requeue_delayed_entity(se);
+		if (se->on_rq)
 			break;
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);



