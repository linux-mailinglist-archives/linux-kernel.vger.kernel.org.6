Return-Path: <linux-kernel+bounces-333916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38B97CFD7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7484328634A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C97B644;
	Fri, 20 Sep 2024 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="T8iX0URH"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D7382
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726798555; cv=none; b=siAS86n3ZEg9EpCyb0sN9UczwTWdiLR6MEmwQF/breMog1tXqI3pi54lL4qkOm40+c5BhU2mWG0UN02eYZDjC5BnyhTAcidmm4kRBgIkIUbsYXkmN+wfZ2Dp1F9Uvx7///ibhrmqUsB2YLy4UDvlWQczoqku8pb4G2fDftXRMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726798555; c=relaxed/simple;
	bh=7HwVPOOdrmP3x9Irjp3mT8I03X18uHtny1AcJWUTtbU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kvAHp6nhlyTFveu37GIc4drM0p0H370hTywxBg2lGsOtlsbzPN/FnKugW9W26cTQF1ejd53tIu+iJhfXXBgYUbev4dRR53UbYuk7ANeSUI1RAQmEZokZgL4VMO25fHWpZUafP/ZegCrLt6cqt/cNP8+LTHXe/E0yi7IeoFs1hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=T8iX0URH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726798532; x=1727403332; i=efault@gmx.de;
	bh=77Gj7np+ZKHtU14T/xiajXIjnpe8O//Izjbw4Cr9qXs=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T8iX0URHXZJE321BPWYXU8NYgVNZIOQ/7qXLLryfXM2gYCvL5JEo0vmHYqcbTZUc
	 mWQBUeE/2wPvQj9IuhP0ADEib1ddNVkkQfJvSS4pQdhYGgO/EsiGZX2/33UwO/vOu
	 zIJtQB/uTJBdotH86FbTqUQUHpF7oyIWLrC4cw+K1MXTSD2CEvx5897q3pmAmsP/J
	 p0hyiuGwlnj0MVKwa7T7rqKtPRJQnNSBJx7BSafHvIRCeQvPaW4Cy65BnJjoaboQL
	 cYI9rwzaHTPEYRH7iljRcfzxQycoteJwYF1gVm70rTyGQEXUcQeeJQ/hAD8JaOj9M
	 A0Pf8lvg+YlTrrcQwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ3n-1sUbFm41Mz-00PLir; Fri, 20
 Sep 2024 04:15:32 +0200
Message-ID: <177646b0c427786c90a8ccb67f5b956a12759d3a.camel@gmx.de>
Subject: Re: [patch] Re: [PowerPC][Linux-next][6.11.0-rc4-next-20240820]
 OOPs while running LTP FS Stress
From: Mike Galbraith <efault@gmx.de>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 peterz@infradead.org, vschneid@redhat.com, mingo@kernel.org,
 sfr@canb.auug.org.au
Date: Fri, 20 Sep 2024 04:15:30 +0200
In-Reply-To: <c8c28050-8c6e-45b1-8b70-06cf5e0921e6@linux.vnet.ibm.com>
References: <82b9c434-a0fd-4488-95be-a45b8cd4b6e6@linux.vnet.ibm.com>
	 <2fb24ab402d9de45e3cf16e6ba0ad23a7843e5c1.camel@gmx.de>
	 <c8c28050-8c6e-45b1-8b70-06cf5e0921e6@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dsBviHucoPVCIAkRArCXYTRRur6moHQ5PlWxYDaBZ/fY83nVrrz
 PpGRUkO2aYEq04jy2P6KV61taffA/FL1dP3Ddl/QYoQQygpZWYXqEjX19bZIlBl9H0vI8Fr
 Bb3X1azisbO0yzKFabdrMc6m9Na0+qdgsngTYcd45yZLLUg+dJMYhdnHSlEvgHTBKam33VV
 0z5mri6YzM0GfjmCJppBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uU4RwNwuQQ4=;HMoPORW2k0gmhOpMNeplNIdw237
 eBC1OeCI5+eqnWE3mlqOHHlOTAz+VgXM4Fz+cTHzgp8W2iKsadEf5blNuwxkns9GCGlOGMW4D
 zMRSS6W322hb6k7ONkrBK1qnoIEnncCgblIjTkSaeEGewqF/BHGgKTRRZ1Ixabvw7FvFpFQm0
 TQ31cBzUe1qssaaLReH3zw3RvmkWJ2JBq+X8kCuYI+48H7/WmL3n+WcYMFs1GM31iocG3KK1y
 ieOb7YgbGLfwYUGzVB46v5IZdDrCslr83zMd9exGZ57iZXagyKAyEZ6oLMHjxerAUUiuaq9cE
 TtLsn/+h5fejeaNousRwFP40lusW7SXFqncCh8mInmCFZT+Lu+8KpVfKsYO6kLn0X6t/5VIQ2
 x7eI0fhTaIwWMb+qWcSihzvK3CF+S1ysTkyqG5yWO5HQLysVqyypghwRT4Mf0t8+I5jn54URI
 jfAzU2UDlAsupTYLwCjjt6KoOquvSngfbqQd6ow9KCtFMyhqXrGTbmVZHaKL7R8IVLV2OfWwe
 ypuxeUUUxhGasTOnpd68plojWvZ/olA882yauajmLtwfK3kc/iIVgb3PWi/rU4D6gws6zw3ME
 YVT81r1525tn5u5XMkIcdZ/RMPRlP0/2FjwVIK5PPXbi3fLeoZivMCfKji8GiJfmVJQSgc/P3
 iIdaoNeJHDErHNqvRfVHcaATudW5Wa3ksvIFIFdBOQCSfxmcgFkVRsWioK0K/P3s7wYSzKDzZ
 E8VWED3HLvjyhhPp5vXqUQnjefyBVpXauOAJnB+Y/cBp57P4AobaKTCFnpgd0P3bg/gvqq77n
 e9WUb8yI7neMw4gy2Y8XK7Cw==

On Thu, 2024-09-19 at 20:09 +0530, Venkat Rao Bagalkote wrote:
>
> Please add the below tags.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>

Sure, and while at it I can brush patchlet's rather scruffy fur.

1. on_rq being implied by sched_delayed, redundant check can go.
2. no tasks anywhere in sight, DEQUEUE_SPECIAL can go.
3. use of unlikely in an unlikely path can also go.
No functional change.  Too bad everything around there fits in 80
characters, or a couple useless diffstat plus signs could go too.

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
@@ -6049,10 +6049,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
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


