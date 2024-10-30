Return-Path: <linux-kernel+bounces-388187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3429B5BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC6A284417
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CCD19DF95;
	Wed, 30 Oct 2024 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="iBt/CG11"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279E17996
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730269831; cv=none; b=abSjmo0IT94tr5dB8+GT7PUvjhnXhxHm/erm+4IEgFWdMs0Ewu6CQF7xDmDQ2HiCxmYPMfArQNz8f7+lcJkxUCnWnzID442yF39dogxOH0x/KjJRculXCLDztjG9bX8pikVqPg5Yoq1nO3WtNiS9cMG22HwOFsYnH8c9Kd83szU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730269831; c=relaxed/simple;
	bh=uNVBmJWUvavQT91MvneBZBCJhNW4tIU0pWqZ+3uqi9I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TOR9ImFiBDE5HeTzEKW66w/RO2fJGafMK5VT6aHeUSQKL3XkocirD5I/bkCbBeTJyGa4HesCq0G/1yOtaw1AAMQ0OFkZzMfHuN6yuXiQUsOCfx1V969UIGzHtlyFoWgNgBDJoVXXAynYTvfXUB2nOIbbhCJVXXMH11ZLV9+mqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=iBt/CG11; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730269825; x=1730874625; i=efault@gmx.de;
	bh=glsVwdX8HiadQS6WYSIKYvD8/B0U9fUdOhxwFm/yWWQ=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iBt/CG11qvkmNqddAvR9tU3ptlhpxp00fH/f42TunE7Dcfrh1GHmEzIwUsmv65z/
	 rmKxf/Lgh1100IQCm6hVeL5w7BOzvb+q3PY+tgUh/RAWDiPBAm0fvW9zLMW92Of5r
	 7u/2Zmwl8rCA36kDGwvGK1RHztOhCzKY9aWZ1xL/PTsdkmVSjEdC7pPUk24Xc09v3
	 sB72o4HE88yEXQE54XAN/hMluyk7jngCsRzGJij757VM1k4s9npD2mZ9Sbx497rGu
	 tp0SwXrgC7fnMNfoOuvMth0TqeI4ogufxKYnh0DshYrFRVfFvgChHmN84hpD67VyY
	 RIThBEejs/YQBOaCaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1tfMuI1OHD-00fSKv; Wed, 30
 Oct 2024 07:30:25 +0100
Message-ID: <fda44f45fe5aea109ccc3e20c7e583b4b649a728.camel@gmx.de>
Subject: Re: regression: mm: vmscan:  -  size XL irqoff time increase v6.10+
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Date: Wed, 30 Oct 2024 07:30:24 +0100
In-Reply-To: <88ae633aa910c7e320b89e5f4779d472f7cffffb.camel@gmx.de>
References: <88ae633aa910c7e320b89e5f4779d472f7cffffb.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RlNjx33EzOchBH3gnRG39zrzvE7EfsQiRS5ZltKZVWG8azHM5kc
 vTRqJcBiP+WQGCXrDePB94XIKF1uFai5OheFCYKHQpwZ5fhDfo3bm8Icb0ilzZdeUm3UCu6
 k9TNGcrERC7CLfWL+i0ReqFB4j+/v5TKjMvCby2cEjXm5X3+rFHXdUR6HavAdMnTCv5T7JW
 saOl1nj6HeALw5IkCGayw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Its+Z6y3OmE=;T95pdACs8D5H5BX5PmTavqU8BMx
 bMfD1+QDVJ4IUebisaRBgpCH/jbCDm27zmeIZt6Jpr1yLQ+cnjylbp8uBULrPlK8S0p5zuoNQ
 VYXiB4lDhEyjf7+mKfDiDgC2HBpENjUyG2H5JDHR367zMsCAYVFrJm4ANONsnE12lduVqqQ02
 6hFsyDmlGCoZJqlEuEKNx+fiAYI8P0NN1jXofnBc2DiVy8iq1DyZhHXKwPzAjb7gOVSxz6dg0
 3CjxaYOQ3TRFGtwrM4/XNnPypufs2wlUWyQwoTufmMh/2F8BMJr6maTnxngQ2XuefKVlPYvYz
 DU5PzIPx9ruOux2T5OLKq9T1HRfMi9rJkib8q8zw8s3QlcJD39SvVXy23neOjosRT3s7AS5YM
 Q9OQYtO6usH8E/OfP2FqU+bE6ZrfRSbg+AGpVK3x9Z27c1EbfUw9yHnNvyQlzA3GjFhkEwqoh
 7oxHwvLRfm2UOG5NjeGgj7Oz7/uQHddWdMihl67vIUi41tFkBFcuHwEQu6VhO6Up0c0SQ4fBw
 p3HBLvkD0EoAPEWbJ3vZjVcDKYRxc7ctpNOm27cbj5qoXU2OooMxFcJUXOnRwl0+CjKKkTYUv
 DuC4Tavy1v7xS9+AEe1Gnav9hnUHgs6Qwl7BUNr4vp0HHgVSxR7+vC0tGj48i5nb20D5NWaQc
 ADymaCWsPiEJpVSU/c4nN/w0/rw42tX2hIiM4iJWk1exzxs0uR4lUWcqgy97ORjbYkhCpoy9o
 4uFhhaTImwSiEBbzErNzZ4ysXWpp+W3/AJLji1VP8PVnr/lKN3IHo+vfkJEaqNNWy56sqwExo
 HBs/hV+xw0iQTH7EXFTwW2YA==

On Tue, 2024-10-29 at 13:03 +0100, Mike Galbraith wrote:
> Greetings,
>
> I've noticed size XL cyclictest -Smp99 wakeup latency spikes for some
> time now, but due to bandwidth etc (ie laziness), never got around to
> taking a peek until today.

isolate_lru_folios() dropped off the irqsoff radar with the below.

mm: vmscan: Limit isolate_lru_folios() IRQ holdoff latency impact.

While examining an RT latency regression beginning at v6.10, it was
discovered that isolate_lru_folios() runtimes could cause IRQ holdoff
to easily span several ticks.

Given it's called with IRQs disabled, cap its runtme to around a ms.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 mm/vmscan.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

=2D-- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -63,6 +63,7 @@
 #include <linux/swapops.h>
 #include <linux/balloon_compaction.h>
 #include <linux/sched/sysctl.h>
+#include <linux/sched/clock.h>

 #include "internal.h"
 #include "swap.h"
@@ -1656,6 +1657,8 @@ static unsigned long isolate_lru_folios(
 	unsigned long nr_skipped[MAX_NR_ZONES] =3D { 0, };
 	unsigned long skipped =3D 0;
 	unsigned long scan, total_scan, nr_pages;
+	int cpu =3D raw_smp_processor_id(), iter =3D 0;
+	u64 then =3D cpu_clock(cpu);
 	LIST_HEAD(folios_skipped);

 	total_scan =3D 0;
@@ -1709,6 +1712,15 @@ static unsigned long isolate_lru_folios(
 		move_to =3D dst;
 move:
 		list_move(&folio->lru, move_to);
+
+		/*
+		 * IRQs are disabled, cap holdoff at a millisecond or so.
+		 */
+		if (iter++ < 1000)
+			continue;
+		if (cpu_clock(cpu) - then > NSEC_PER_MSEC)
+			break;
+		iter =3D 0;
 	}

 	/*


