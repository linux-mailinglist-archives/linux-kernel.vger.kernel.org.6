Return-Path: <linux-kernel+bounces-313817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F3496AA3A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC891F25C27
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B34126BFB;
	Tue,  3 Sep 2024 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zoSBVz8a"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B0126BE7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399201; cv=none; b=DDlirvoyxhFheUxsFzJChtX3lrQmfQtFbTHfCLUJv8mALqNbInV6lVIGT4DgE8jwVrBz/haUCqWITLA8wYecP4/ugTYNPoH+dzjSoPZjetrk3Y1UHCIZo3KVep+UGmw3umfVTzFy2XPFM/7LuikMKHG2f++YOybkbfhL385UvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399201; c=relaxed/simple;
	bh=fXFPk+uVSuss+cmpNceVkVhsvHXSHh4eqMSVeXPE+VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuG6KKwfgGNOSNG93Qv4HXJvYE2mpgum2Zxfa3I6KRddc9FOclg1RlQxL/HsU0NDDAT0uK+klz56vN2Vp5FWlS6zwT1HPHMELGU6k59ty4+uIEW3bUpEnvf1CV66Y7tst49wLs7jTTQ51jN7Y5wy8BdXgkBgUiGaGbpuRVWCKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zoSBVz8a; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c2443b2581so2120a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725399198; x=1726003998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvexyChv8+VbQKUf6s8t3yt1eg56MReCvDrDYUOsr2M=;
        b=zoSBVz8avvpMSWpUksmINlj2J81eb96XAKzsjpRAVBaypnpyGL6M8cGi7pvo27W0Yx
         Y/neJ8YinquI8UvL91vUf3/4nsdZKwK8inaZVINO86cs5G2MP/hiqTK48mk5+qZzm2mG
         qf6jKbDPzl0n1VbU50AHn/ci8FkZaTchNG3wZoiZhrlheUCwIcCXig4zTjSzHL9qrAaT
         6Db52/88TWs0Q20+bKviN/z6pj7kYJmOiTvun7ffGvQPxnrZcWKXzuKp8WFMyTRT8g6f
         7H8J0tnXaHJffhBSFL7TDEVoQSFRQZ6MTYBzVzNY8XFe9lFFUOBcRa/AkK5llCDW3uJo
         g5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725399198; x=1726003998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvexyChv8+VbQKUf6s8t3yt1eg56MReCvDrDYUOsr2M=;
        b=o7+fkAm0y8KzdAbPYFa1D6ZHdhRGN2TkGOSxkMVKSXdZT0IyPNVcUpN2MWaWLDMaQp
         5jCoIJZ3lXXP8rPHDWcRetSw6HV9wWOh1RQde054Uivk7VKRlTPXP/NOx2INfYdyxfun
         KmJZdiTL9gN7KTiyX/zetVk9+jKNy589DItEJFJXb2kF0ZReKhe5MYfkXWTNqBIbmBDj
         cKoAS1saZCrgGh61bz9rLvY1oAXwPskvE7Z6JroVSA+NIWJ+/+BFpaj2OkuSSSD7Lb3c
         9E9AqcstH0Rv+76S7XzmmXyg9FF3HBKxlw1jI0saD7tZIh+7GgXXZ296nLm9b/Gq276R
         E0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUtwY2JKLWadhqRZJRpdhMg+hHyddepA80OD27SSKsSgEyt7AY6JNBzz7lHkkwHdASYaNsrXB7BYlF9jcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRy7WtmhtP4i8KHW0RgSpquse3190iaaE+dG+oT8T8hyRl1b8A
	qI/noibOHJMwP/SI1E6fD47zLTFlLhc5qKYHksKUgHi0XNK9YkTfDoz1AI8jed5eOX6d+2OOEL3
	3cdxcUIV2uBWvK0yak8OQ+/85lWGaQFvX598v
X-Google-Smtp-Source: AGHT+IHXeInquumjL4kZu6UrHvf5/qJd9AjRfS3dzoZc2kmvRE7E2X8TQrxgcw+euxeDaTHsJYfZLkdEAnEk+xPmgOw=
X-Received: by 2002:a05:6402:358d:b0:5c2:5cf5:c34c with SMTP id
 4fb4d7f45d1cf-5c32f00003fmr17326a12.5.1725399198200; Tue, 03 Sep 2024
 14:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829220427.2764399-1-joshdon@google.com> <e915c024-9a53-4736-9194-988e5cdd06a3@linux.ibm.com>
In-Reply-To: <e915c024-9a53-4736-9194-988e5cdd06a3@linux.ibm.com>
From: Josh Don <joshdon@google.com>
Date: Tue, 3 Sep 2024 14:33:05 -0700
Message-ID: <CABk29Nsx3cX=GmO0OSH5N_Ggqyi7iUxtVxU+yhHDKJW6y7h9JQ@mail.gmail.com>
Subject: Re: [PATCH] sched: fix warning in sched_setaffinity
To: 20240829220427.2764399-1-joshdon@google.com
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Madadi,

On Sun, Sep 1, 2024 at 7:25=E2=80=AFAM Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
>
> Hi Josh Don,
>
> On 30/08/24 03:34, Josh Don wrote:
> > Commit 8f9ea86fdf99b added some logic to sched_setaffinity that include=
d
> > a WARN when a per-task affinity assignment races with a cpuset update.
> >
> > Specifically, we can have a race where a cpuset update results in the
> > task affinity no longer being a subset of the cpuset. That's fine; we
> > have a fallback to instead use the cpuset mask. However, we have a WARN
> > set up that will trigger if the cpuset mask has no overlap at all with
> > the requested task affinity. This shouldn't be a warning condition; its
> > trivial to create this condition.
> >
> > Reproduced the warning by the following setup:
> >
> > - $PID inside a cpuset cgroup
> > - another thread repeatedly switching the cpuset cpus from 1-2 to just =
1
> > - another thread repeatedly setting the $PID affinity (via taskset) to =
2
> >
>
> I was testing the patch using the following two scripts run concurrently:
>
> Script 1:
> while true; do
>     echo 1 > /sys/fs/cgroup/test_group/cpuset.cpus;
>     echo 1-2 > /sys/fs/cgroup/test_group/cpuset.cpus;
> done
>
> Script 2:
> while true; do
>     sudo taskset -p 0x2 $$;
> done
>
> However, I am unable to trigger the warning in dmesg on the unpatched ker=
nel.
> I was expecting to see the warning as described, but it doesn't seem to a=
ppear.
>
> Additionally, I also tried the following script to increase the chances o=
f
> triggering the race condition:
>
> while true; do
>     echo 1 > /sys/fs/cgroup/test_group/cpuset.cpus;
>     sudo taskset -p 0x2 $$;
>     sleep 0.1;
>     echo 1-2 > /sys/fs/cgroup/test_group/cpuset.cpus;
> done
>
> Despite this, the warning still does not appear in dmesg.
>
> Am I missing something in my testing approach, or is there a different se=
tup
> required to reproduce the issue?

taskset -p 0x2 $$ will affine to cpu 1 :)

I'd recommend using the '-c' arg to specify the mask as a cpulist, as
it is easier to validate.

taskset -c -p 2 $$

>
> Thanks and Regards
> Madadi Vineeth Reddy
>
> > Fixes: 8f9ea86fdf99b ("sched: Always preserve the user requested cpumas=
k")
> > Signed-off-by: Josh Don <joshdon@google.com>
>

Best,
Josh

