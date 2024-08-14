Return-Path: <linux-kernel+bounces-286912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E4C952054
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D7D1C2293A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1E1B9B5C;
	Wed, 14 Aug 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="lKUb5hDO"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8801B32C1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653976; cv=none; b=JaT38JAhASCvSVup/N+kMwJru4Wkm/mb+jh2SaO/yh2Ip52qq8xYQPNKgVM6EWp5F9mmwtknUDCXs55CZSR36OLdD7jeVzAjGUhhyCDU8pL1C4WWyGW6yLOWI8mafhieKjbCbKS3bW8uby1aquOmezci62fLNiSTQK68uzM1AQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653976; c=relaxed/simple;
	bh=2j8W6pogQxHvBnWGOy1ygt1i+Idpkez5yfZ+YZqh404=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oXZvlS0Z4bLq+ykKE+IVUjygXRrtPwj/t1vcVrAZCoogi1VYLFxrdCxX6x+x8f57Dx6K3Tz4+awj1yCOeNGDI+nL2Q4FekUOrl3YjLRsmCgyWDWI0Y06pmxDGZiN1eWqMe5X2S0pMlNrain6VvGJKFBexBXsUMP89mtOgvEIiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=lKUb5hDO; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723653919; x=1724258719; i=efault@gmx.de;
	bh=gDH0NO9yMjo+hDvfJkTwFxk83PfYIMAaXvuSfpY6R/k=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lKUb5hDOozekd0GQxjlc20sdVVxYMTllR4N3sAKhtInORdhHCpEnGeJbuJ269gnU
	 AYY+mehY4HzNwGmanFklnOGN1ecNrud7I98iECygVyAk6upovfkzv204TjO5tJPnv
	 X4M/vlhItvmCVwnyFC4NzT2o2bolTV9Ys7+0auWeNNotIU4O4Y07k3U8I1/J7ffa+
	 LjxbpbUgB/85u+WqNOt5U+3anAZmlgkwiCUPJ88fYDV4syAmwcovGuuc79bdTjcGg
	 r6zrjOI6baq5okcYpV4QACHdixfUZ97ZNlXJ8OL3FEWhKvIUQwFDElbZDid0WQuMS
	 LQZiuYZd0CJXN0iqDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.61]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KUd-1s7M2A1qg5-016bVO; Wed, 14
 Aug 2024 18:45:19 +0200
Message-ID: <1572d0f2646312767a3ef8b72f740c9033163bf3.camel@gmx.de>
Subject: Re: [PATCH 00/24] Complete EEVDF
From: Mike Galbraith <efault@gmx.de>
To: Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	 <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com,  linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,  youssefesmat@chromium.org, tglx@linutronix.de
Date: Wed, 14 Aug 2024 18:45:17 +0200
In-Reply-To: <CAKfTPtALe942tjoyq1RqSYyM40PG+tfEY8skRDxRM1daWLSKUg@mail.gmail.com>
References: <20240727102732.960974693@infradead.org>
	 <CAKfTPtALe942tjoyq1RqSYyM40PG+tfEY8skRDxRM1daWLSKUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U6uHhhrl/+GrVz4qpI0I/Ys2ikoGABF/g616D0PygtvxeH/ATii
 fQQUOu6viPPo2E+7qMPizWud4RmxJH/EQii0ttkRAcgogAPa1bA6WdlpzzeG1cS0FVoNO1Y
 Yp4AJQfC1WoCXsPAwwQPrriYoYJP1MWUoX5RyAcBVR/iJ31ALAc/EaQ1M01qzC4dYXf1Z1N
 7nxIvZBJING7n0TFojZcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dBz8LJCl0/U=;P6cOozAJBoSJ9kodP1l2U+8bSy9
 zsZAuTqzcjqCnLnC2XCyhytY/Ff6WB9xBiTGD6c+DlpgqjzFWCnRkm4XYDko0RwUzdTK2RMk8
 doZlCLI5CQO/tcKzDVI/bc2Mq9WBUYqjhoMzIm15W78P7LJ17SS72wf1dDazM4kusrjeqjTxu
 etu9X0B5egTzHtTufjfmeCPLxOwbfFOekIck5OWJzz5e2DG6jB2PkOr1nhZWLDSILOjUl6kj8
 9LP2TqeQClfiyceAnvvjH0KnuOGbOzrNF8YSwDYHdrEXE1wiecrTbIKhjrzKn6PscCaPYKs5L
 bi3+63O8Wqp6vLS/f3kvLMK77T+HYKj0QIb/aeek4mKLoXfbFw3r6HOvPatZsb9fe/JMiSRr9
 fGKW/5G3UtpYaluehivl7Io+BqY4tAdGyE95EisfEn2L3G6hd+Ko83xgsTVy3quSFLVNd1rKZ
 4Fm7yC5ld2D0ll+d3+hEr0wEYZVkfXbJumwDlVBYe8monOkVj4e0Y/OUOSm97Bsx+n2trBI8b
 WAgzel8ZwwVGUzftUoJSfOZeERjMKRQgRe6nMN0Ej2mu7lITr+p0izxNKZBGkmbbUuZSSGLcg
 c7kokZ7wznZsvwmjenGS/wq11dyIIk92ML7DsRW/6MpkIn40tiBnyenoHwHjyGo73sTe4zr9y
 abVhUuT5vAyqj2XNL9c+XRn6sIJgbAsbEfVzIJzzeye+RrMSVW7CwlQdUJ4zg+rbuT6lgaWY9
 Z3/P+OdPO5w5kQd9bhqAnHqSOVBwreer0VNiEn6t3JoZqDkxh8MW83svyEfV5lHBw0EkwyA5G
 vT2dv4dAhOqfzqf301o4CiLA==

On Wed, 2024-08-14 at 16:34 +0200, Vincent Guittot wrote:
>
> While trying to test what would be the impact of delayed dequeue on
> load_avg, I noticed something strange with the running slice. I have a
> simple test with 2 always running threads on 1 CPU and the each thread
> runs around 100ms continuously before switching to the other one
> whereas I was expecting 3ms (the sysctl_sched_base_slice on my system)
> between 2 context swicthes
>
> I'm using your sched/core branch. Is it the correct one ?

Hm, building that branch, I see the expected tick granularity (4ms).

	-Mike

