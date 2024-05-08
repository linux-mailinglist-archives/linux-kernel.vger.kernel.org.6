Return-Path: <linux-kernel+bounces-173370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E500C8BFF8A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A070328231A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F6579B9D;
	Wed,  8 May 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="i6WjQrfV"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357841A2C11
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176406; cv=none; b=lUydPIKVlXg3enP3ezO8CUXdVFU0VDSqfETIgxqXIEO7aIFWRPbOSoSCcALA0YhYketyjW4WwmMHihio//JUV51YqxKkQlSiSuyFOAyHJzlrzvFHT1hZ4NyJKbH8w/q/bnjxVXSy9uGMjzOxfYq+7NRV9+v9FL22LtQBYwT3YFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176406; c=relaxed/simple;
	bh=rnyl7Xp77+0HYhwPE1QmPfKmC2U78gvaTg519sdiZps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G3LLQFzbxmmGSNK0Af3AcKCoKSfo60w59RkH3Kp7A+9Cu1Fbd6Plzn6y18Ox2IWoPmk8hJhbb+qtgCIzD2dfeEevMDMbP2K3SyZLB+SMBGoBJNxs5WAmVaXjardkCa8GMChMRjWBemnHC33Hbzte3zZHIL6W9vffPHxXMiYzlUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=i6WjQrfV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715176354; x=1715781154; i=efault@gmx.de;
	bh=xvqbbAqfc9EOFpvqcHsYsOBw5lY+DntkMAAWorfeO9k=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i6WjQrfV8G+HPtES47TSJrYXpXqh39+3re9yMZEbLp5+jbDrYsQfI9IMRCdtvseL
	 /2wehND6/dQRZuJlc96UjAjzZOvvoo7ZNFa3LrzzQdbMb3KgRHAGZttn+1CtfUReD
	 GG06Vu89g847q5CGRi4rbLVdJTzvqNiYXCz4XWokw5KFdkXumymKaBRXNz6fGLHn/
	 4jrGZPYAPJk08+ebm8LeRCHX7F1bGUmb/zautqM59j6CG8AmLw5ibfaHKe+njzinD
	 ZlubZm6O6p4pfLG6dL6KliUjt5pBdWV9y9aIXhHGqqedrqugc8SahpFdXh/c9QuM3
	 0dLwpoU/S4pbPQcqnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.151.210]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRjt-1sbIS30yVN-00aTHr; Wed, 08
 May 2024 15:52:34 +0200
Message-ID: <9c360c0d337b124c71095f06889d1c69279a7c06.camel@gmx.de>
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime
 to set request/slice suggestion
From: Mike Galbraith <efault@gmx.de>
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de,  bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org,  kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de,  tim.c.chen@intel.com,
 yu.c.chen.y@gmail.com
Date: Wed, 08 May 2024 15:52:32 +0200
In-Reply-To: <ZjpFruUiBiNi6VSO@chenyu5-mobl2>
References: <20240405102754.435410987@infradead.org>
	 <20240405110010.934104715@infradead.org> <ZjpFruUiBiNi6VSO@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QOMj/JfgW6fn2tFkYIe4JeP8d426H3XoSY9KW474SzmxWwbOFw3
 RiUmwVfp+uMryE8sSrJErI71zbU9UCiFJ10U+hd3HTTzSr0OSPRonuHNaL2KleuiBN+3b0X
 5AqW41ZXh9tSa2HdiATI05QR+EC1s8Rtdi50UbyWryQtiHQsMUvp1G2mmW+58rGbu0P3/5i
 gJ3jloKo37Ufk116+uw6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Gw5PYY1ZB6A=;glpYNK6WATXwgcaY+mtwtEf9zcF
 dbiCPUTF4MqtFS5zKu+feso2oXsKh4BAdc74sv8kN4qsRgK0OLWOusV1KCqONK5LnLRfJY2gX
 LdAsYXHfW2V3RkCBAPZ1wcW+m+XkODqWR1VVhYYWelIy9+PA+W9sxfmg7XdntzP/4T35NRUln
 IGg2t0bQIewyMEbB2QgbjcLAgz30+1alN+UNw3yr/JPgBLb6h3XVJhjO+7+9kPYY+LUB5CJZH
 NnwNF0eLY1kglS27cAxaR/y8CuWzh0BHZGnGta3PaSykI8AmOCBapswR9Rea86i4sMwNCqUtO
 lK03uX2P8jmXl/c6vNfAJCDcGGI2IJMINn95JSvSDk8p0LmZq75dwjNFOVU6ut266BQ2YYTdF
 gkcD+qv+iubZyt8FZCK8Gn2O2X7CKpuG2L/fAjAulAdnnTf0YiBL6puQMbWi5gMZYWhVNoY3Z
 XJSrTp4R80edO/od2tIkhKi8CxxXnopUu4eu1GPtv39Yzz8FLaeGNaPdNjJlPLKn/yZ8Wnvyf
 kU/Wwys87H9pzNxVoCKBrRk8nACoWdrE8VtNmANPhUPqpyilVZVQnc+LwaC8XQDwJptIua3uL
 YdtNt9r64WtujyxXOzFnmhQOm7awXnGyqBAw4wv+eEpaX1g4hI+S6ztd8HEs42ayCbNZqqfTQ
 kViMcEYnkq2BnOwEBbgUQThiR8fWAS5xptpfw4iFzTqDXpUq+JFGY0kfjgaDMSUv+kxusz8Ii
 AMCGVOy/E6aUnFvavYMzfwxOnZmLWe/iCxAHIbK2uyRyMYyCiFRrnH4hHyZBQGYHkDN7UMeH5
 NM/ToSEBjm4//SYx8V2EBJuXk21JMLKNW8/G/8zI5MdLI=

On Tue, 2024-05-07 at 23:15 +0800, Chen Yu wrote:
> On 2024-04-05 at 12:28:04 +0200, Peter Zijlstra wrote:
> > Allow applications to directly set a suggested request/slice length us=
ing
> > sched_attr::sched_runtime.
> >
> > The implementation clamps the value to: 0.1[ms] <=3D slice <=3D 100[ms=
]
> > which is 1/10 the size of HZ=3D1000 and 10 times the size of HZ=3D100.
> >
> > Applications should strive to use their periodic runtime at a high
> > confidence interval (95%+) as the target slice. Using a smaller slice
> > will introduce undue preemptions, while using a larger value will
> > increase latency.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
>
> Is it possible to leverage this task slice to do better task wakeup plac=
ement?

Slice being unrelated to placement makes its use in a placement related
knob look wrong.  Even the smallest possible slice is orders of
magnitude larger than the cycle time of TCP_RR, making slice nearly
irrelevant to the issue being demonstrating via TCP_RR.  Even for that
huge socket box, it won't take long as cycle time increases toward that
smallest possible slice for the cost of needless wait to bury placement
decision costs.

> The idea is that, the smaller the slice the wakee has, the less idle CPU=
 it
> should scan. This can reduce wake latency and inhibit costly task migrat=
ion,
> especially on large systems.

Sure, this is an age old issue that's scaled up to size extra ugly in
that huge socket box.  Any solution needs to scale as well methinks, a
simple fixed yardstick won't work, as the costs being mitigated vary
wildly with platform size/shape.

	-Mike

