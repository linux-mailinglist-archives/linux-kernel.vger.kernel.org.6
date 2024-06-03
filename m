Return-Path: <linux-kernel+bounces-199426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4408D870F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB34B2112A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEEF13665F;
	Mon,  3 Jun 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0chrc6Nv"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52D134415
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431654; cv=none; b=k7+rIN4uVWNhXFcBaFC1Hl+IwYJlD1bRdHI/TUGuhXztDVA2UUxwTy+FUz/2EGmtd5uvKcG7/umInge/wAeHOPjf6dk5QPHx6ZxH6xUiWk4uz1HRmpnbu6KBYJ/Ztrg78xfgkXq9VNHMl/gf69v0q3adjbKWmoZzfzYmCE4QNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431654; c=relaxed/simple;
	bh=T2gNsKce5V5Lv2N/ccwwI2fXXc+DZkZApRpy0OskDH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE1phJ7EDpsgGYNU8WJSLhd9p1oNwhVg4rirfRr8oWQuU9D7qWX66R90KcKBzBITXinQ2rgYZjrhUZtSfBibAEb+eA5d7BxrQdhTcRlZKPe5YmP7xKokkx3vFPOCHue2qBPYu8GWWrpX0XEhJAWKEcKdv3u7tdgp0KHG2YjTzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0chrc6Nv; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-374991c4aa1so231775ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717431652; x=1718036452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MixTtELLiJH8L+d2LmDPMTf5TZnTl8TAimQ8PPeUMRo=;
        b=0chrc6NvO3c1/96ZButz9uSCEwmFy1ArkRHOOHM/vf/tC3C0oqUvtKQNAaoKFcTDw+
         K1P0egJWSUsiIimzmcoLQNRL9V89SDDJMcQz5pqBP6nfBXkuYw7GLrEeeuaXb/mZQtcO
         DH7UykEe96Lv/CmDSRpIhTD1YZ68z6xXgVtmYf+D5BzEfUOa3wi/lGPaqzM5ti/aWaSh
         VuS2UM6sM0vQMPIJ8vIWnUip5s59A+icIzmwPQX8oVsWM9A/Zgk+yhHd8QDiRYEXEgBt
         FrJ8tu7fi3w/OFzZha4m8ka/Xy+icAZQEyJDdGJ1H64v9ukQAQ05fi6XMoyribg+2n+6
         i3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717431652; x=1718036452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MixTtELLiJH8L+d2LmDPMTf5TZnTl8TAimQ8PPeUMRo=;
        b=c4Y7IQI5NWNeOBnl/GgMif/Rp7gxZp3TBwQGSDV3NgRUsStE1Fv+fL27Hx3VF75I7P
         gecyuTXq2m7v8EZGYStxs+57fUqNi8Eu9yrt6Ok4NYUMUG4oqhzC3WEuuFCRj+im6YcK
         X6x4Pm0J+MKu9c7hz0vB9DILW937o07dQ6mH1OOE0JVmvNDf5s3hc6pwnpTkvTUPHnk8
         nyfl4Mubskuae4HcZzszYXeDm6+9qX2rUI0404AX6WX80BVmUa81PWhC1q82VYty7uwi
         UCgVVuJOHy7z02hrb7w/oYVsfwRHYCTdKZQz/OjY94HsSzFmaXsWzF6yz6kfU14QygiI
         8VOg==
X-Forwarded-Encrypted: i=1; AJvYcCUnJRYtY+Id8L9GrQtjpMFuOMYRx25nGSzpZWNjAHd/qvvL0GPn9VrdRicgFJGL7Jk8zPUYjo2IRV16xEN2dwFDPdBEWiHG1S0yVvdO
X-Gm-Message-State: AOJu0Yx98WzN+9Mb/xfxuEdING/KikOgmjlKfTWaEjLURlDvwj/v7+pv
	CZKdOQWBD8+pgAKsG/U1wKWj7hpq2ydQ64W5GGbd20UWkA2ecD4M4rcoV6HWw1AASUZIOUZnJnT
	wJlXCQxGt+R/ggcXiVrmM2TSXZgU+RAepDUUb
X-Google-Smtp-Source: AGHT+IFjSaIwObKyMMLujEN+lZ6Fx2EjPMX8NbkZ3LpQRkc6mjv+m00ZkIgsew9FvkrzvqOj0ZWOO37Q/gb3dyTp9QA=
X-Received: by 2002:a05:6e02:5d1:b0:374:930f:e49b with SMTP id
 e9e14a558f8ab-374930fe61amr4218035ab.24.1717431651802; Mon, 03 Jun 2024
 09:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603092812.46616-1-yangyicong@huawei.com> <20240603092812.46616-3-yangyicong@huawei.com>
In-Reply-To: <20240603092812.46616-3-yangyicong@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Jun 2024 09:20:40 -0700
Message-ID: <CAP-5=fXDPor-WsO-TGB3z6QpSWZOFJC31GJpuwZUA3qz_3WsYQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: arm_pmu: Only show online CPUs in device's
 "cpus" attribute
To: Yicong Yang <yangyicong@huawei.com>
Cc: will@kernel.org, mark.rutland@arm.com, acme@kernel.org, 
	namhyung@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, james.clark@arm.com, dongli.zhang@oracle.com, 
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:33=E2=80=AFAM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> When there're CPUs offline after system booting, perf will failed:
> [root@localhost ~]# /home/yang/perf stat -a -e armv8_pmuv3_0/cycles/
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for e=
vent (cpu-clock).
> /bin/dmesg | grep -i perf may provide additional information.

Thanks for debugging this Yicong! The fact cycles is falling back on
cpu-clock I'm confused by, on ARM the PMU type generally isn't
PERF_TYPE_HARDWARE and so this fallback shouldn't happen:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/evsel.c?h=3Dperf-tools-next#n2900
I note your command line is for system wide event opening rather than
for a process. It is more strange the fallback is giving "No such
device".

> This is due to PMU's "cpus" is not updated and still contains offline
> CPUs and perf will try to open perf event on the offlined CPUs.

The perf tool will try to only open online CPUs. Unfortunately the
naming around this is confusing:

- any - an event may follow a task and schedule on "any" CPU. We
encode this with -1.
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/include/perf/cpumap.h?h=3Dperf-tools-next#n24
- online - the set of online CPU.
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/include/perf/cpumap.h?h=3Dperf-tools-next#n33
- all - I try to avoid this but it may still be in the code, "all"
usually is another name for online. Hopefully when we use this name it
is clearly defined:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/include/internal/evlist.h?h=3Dperf-tools-next#n23

> Make "cpus" attribute only shows online CPUs and introduced a new
> "supported_cpus" where users can get the range of the CPUs this
> PMU supported monitoring.

I don't think this should be necessary as by default the CPUs the perf
tool will use will be the "online" CPUs:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/evlist.c?h=3Dperf-tools-next#n40

Could you create a reproduction of the problem you are encountering?
My expectation is for a core PMU to advertise the online and offline
CPUs it is valid for, and for perf to intersect:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/include/perf/cpumap.h?h=3Dperf-tools-next#n44
those CPUs with the online CPUs so the perf_event_open doesn't fail.

Thanks,
Ian

> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/perf/arm_pmu.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 8458fe2cebb4..acbb0e1d0414 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -558,13 +558,35 @@ static ssize_t cpus_show(struct device *dev,
>                          struct device_attribute *attr, char *buf)
>  {
>         struct arm_pmu *armpmu =3D to_arm_pmu(dev_get_drvdata(dev));
> -       return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus=
);
> +       cpumask_var_t mask;
> +       ssize_t n;
> +
> +       /* If allocation failed then show the supported_cpus */
> +       if (!alloc_cpumask_var(&mask, GFP_KERNEL))
> +               return cpumap_print_to_pagebuf(true, buf, &armpmu->suppor=
ted_cpus);
> +
> +       cpumask_and(mask, &armpmu->supported_cpus, cpu_online_mask);
> +       n =3D cpumap_print_to_pagebuf(true, buf, mask);
> +       free_cpumask_var(mask);
> +
> +       return n;
>  }
>
>  static DEVICE_ATTR_RO(cpus);
>
> +static ssize_t supported_cpus_show(struct device *dev,
> +                                  struct device_attribute *attr, char *b=
uf)
> +{
> +       struct arm_pmu *armpmu =3D to_arm_pmu(dev_get_drvdata(dev));
> +
> +       return cpumap_print_to_pagebuf(true, buf, &armpmu->supported_cpus=
);
> +}
> +
> +static DEVICE_ATTR_RO(supported_cpus);
> +
>  static struct attribute *armpmu_common_attrs[] =3D {
>         &dev_attr_cpus.attr,
> +       &dev_attr_supported_cpus.attr,
>         NULL,
>  };
>
> --
> 2.24.0
>

