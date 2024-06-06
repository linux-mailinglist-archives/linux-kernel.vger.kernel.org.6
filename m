Return-Path: <linux-kernel+bounces-203704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2398FDF48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8AF1F24AE2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC1F13AD0D;
	Thu,  6 Jun 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SE8UQjt"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7778213A896
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657507; cv=none; b=asEijppGExFI4bcDJ5x7AglbaNaCYCUFSYsc6xbJPfpMiXXgFlD0KvkVR20+1AL1rhmGpd3jJMlKyo6ukPKYYNoNFY9k3ZEUhn2wilMh33i6zNEwJvKrM6owUWn0U4hChlrXfMmklP8o4TSdQP0DZpI7K/YdlhVj+OFowZY5IPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657507; c=relaxed/simple;
	bh=lLbPi6PEtx7mcrA74H59gkeJ2Vj+bCUKyXS/pK0obXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imsmFQy/FYTla8JwB0YlaMGP71K5ISb/YKD8X8gCFXd0YogCcZy4i/ZGs0zz+L0dBm5eDMKH4FynPHW+O8Y5keVKnJOPXDBN59u2Q+9RJAHhkcxKpmrVAH10+wgmkyk2XoKnC4u4/cb3ChcColIuAmSgPhM6JVNBKzUrgDT2bLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SE8UQjt; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3748a185da1so74235ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 00:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717657504; x=1718262304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbGdl+80JsgZCzp3psor20iOdoziZwxzCaIswtJY5jk=;
        b=0SE8UQjtcdLXSac2dOqqHjopUll3AWsouvM6ijlWsMd4HZ3w2D83gxwQx5afQX7+xp
         8ON5PpNqLhxzPrI0zedeFsZSsQY79tJ3xdaqdo4LyK0HuhQrkfS45XgwgUGtAIHqEQUG
         2wR3yKZnpOIUADP9ZZQ0TelqR11Eeg0Y5xhnsd7ICTZPimbzwJwZmZlBl/I6Q9AxCIdq
         vOsMXgrttOXqHdDamnINgP/tWjLJ1fZx5ba6JFHs7wDePy3xQ21yus4BB14rXKTPVD8S
         SMVFxcgkdYin1r+dAzSN+lduTgviUPhau2SYaFrIYQZ59AYQtnwH8DBXekLWgP6wlszg
         hOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717657504; x=1718262304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbGdl+80JsgZCzp3psor20iOdoziZwxzCaIswtJY5jk=;
        b=pPKPVpu9E3I146mtp/aHoulPWRQDTLgbFBlwHQ7ZoIST9qOz5HDTwRbgTzav+GWzop
         7TWhsNmKGMi5LNjzY2l+LCGqhoWzd2r/PBMDtMmAPZVOy00Y2cXceOVr7B7u7BRvJfYg
         KpSK087e85j20pSNlZdL29oHqgXwMM61SyWfQUNTQMBmoNCPp9egqkTA1pS2EWRDXQ1+
         m+S3dp8ayT00D6vbretFNkQfs0N2vS3d2IqLKRZIZtvB5Y4dDDRnFakimOVbFhpyfcCD
         BMAykchV0VRHOttCqZTJcDbvenkkln8eB4ccZtfX7iLl8GUl3gO4f9boxTmcWV0ruBaM
         R34A==
X-Forwarded-Encrypted: i=1; AJvYcCVPoJBSR6ewYgM+lNRonp+irBii56cqIzLPcMfjYTuFhSUVgxVBFHOdAnSlY4OTtYPkuTcRAPZImwumTYacQA3pzcRyIs73EvRxw9J0
X-Gm-Message-State: AOJu0Yx9Bggdk4vDjNTB7v7Cq5iaCXYpK32e/6bviTrEBUVw9K75sgA2
	zaP8j/vpshhFpVeW7PB2tAuJruekWeMGxUTe+RBV2zFx3+eSYXj4757FK+GfzJ/gXgXuO5zCBvk
	bcdcdOjLcM0u1qItHK0Ri3L1sr69CcmJdajdO
X-Google-Smtp-Source: AGHT+IHq+uj/5GSwZtHD9DsLDpdeqv/Osc7fiQ3uXZR8SK9wgzoiJMMqTITEcXpxCbgTKoPzuvi+2CNpKDTqVM1bDDw=
X-Received: by 2002:a92:50b:0:b0:374:930f:e49b with SMTP id
 e9e14a558f8ab-374ba8c21f1mr2074375ab.24.1717657504452; Thu, 06 Jun 2024
 00:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603092812.46616-1-yangyicong@huawei.com> <CAP-5=fXw0=dHORC-kObYFiAco64PGP4_uFr__f9YmVctWtGSfA@mail.gmail.com>
 <3f43ecf1-ae3c-3418-9798-9f1aa0dcc3d2@huawei.com>
In-Reply-To: <3f43ecf1-ae3c-3418-9798-9f1aa0dcc3d2@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Jun 2024 00:04:51 -0700
Message-ID: <CAP-5=fXw60RL=FBP4znRCCwvjmajcf2QpY_70Uf1J-ozutWVng@mail.gmail.com>
Subject: Re: [PATCH 0/3] Perf avoid opening events on offline CPUs
To: Yicong Yang <yangyicong@huawei.com>
Cc: yangyicong@hisilicon.com, will@kernel.org, mark.rutland@arm.com, 
	acme@kernel.org, namhyung@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, james.clark@arm.com, dongli.zhang@oracle.com, 
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 1:04=E2=80=AFAM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> On 2024/6/4 0:42, Ian Rogers wrote:
> > On Mon, Jun 3, 2024 at 2:33=E2=80=AFAM Yicong Yang <yangyicong@huawei.c=
om> wrote:
> >>
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >>
> >> If user doesn't specify the CPUs, perf will try to open events on CPUs
> >> of the PMU which is initialized from the PMU's "cpumask" or "cpus" sys=
fs
> >> attributes if provided. But we doesn't check whether the CPUs provided
> >> by the PMU are all online. So we may open events on offline CPUs if PM=
U
> >> driver provide offline CPUs and then we'll be rejected by the kernel:
> >>
> >> [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
> >
> > Generally Linux won't let you take CPU0 off line, I'm not able to
> > follow this step on x86 Linux. Fwiw, I routinely run perf with the
> > core hyperthread siblings offline.
> >
>
> It doesn't matter if it's the CPU0 offline or other CPUs. There's no rest=
riction
> for CPU0 can go offline or not on arm64 and I just use this for example.
>
> I cannot reproduce it on x86. I think it may because we're initializing t=
he
> pmu->cpus in different routines in pmu_cpumask(). There's no "cpus"
> for x86's core pmu on my x86 machine:
> root@ubuntu204:~# ls /sys/bus/event_source/devices/cpu/
> allow_tsx_force_abort  caps  events  format  freeze_on_smi  perf_event_mu=
x_interval_ms  power  rdpmc  subsystem  type  uevent
>
> So pmu_cpumask() will infer it as an core pmu and initialize the cpus
> with online CPUs [1]. For arm64 there lies a "cpus" sysfs attributes
> so pmu->cpus are initialized from the "cpus" without checking each
> CPUs is online or not. That's what proposed in Patch 1/3.
>
> There's a "cpus" sysfs for x86's hybrid machine, reading from the code [2=
].
> And it seems always reflect the online CPUs supported by that PMU.

Thanks Yicong, looking on a hybrid machine and taking cpu1 offline I
see the PMU's "cpus" not containing the offline CPU. I think this
supports that the PMU driver should be fixed for ARM, but we'll also
need a workaround in the perf tool for older kernels.

Thanks,
Ian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n779
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree//arch/x86/events/intel/core.c#n5736
>
> Thanks.

