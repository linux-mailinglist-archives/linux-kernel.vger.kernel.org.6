Return-Path: <linux-kernel+bounces-199456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B8B8D8768
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEF1C2184E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28FD1369A7;
	Mon,  3 Jun 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1KBklAZ"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DC7E8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432945; cv=none; b=uaVCKwRuc8CevjQsVxL406NCbDgHhfVC+NPS4aHTcXZPi1a7oUB/kDY0Aj3xRH76VmOZiITelmH4XM6p0T3+bBsTbWtDhGDZ2j+5+zBnFHdX8tzEyWnXsxRyrfBBNDvZCy97hT9j2670WyT2PV/8yLOJWrXV93EcQL8yrAjrFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432945; c=relaxed/simple;
	bh=rCO/0WLOENkK+IPJAT6qBe/hoq8l0TjQG4SW4fVkGBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYPQJB+9zJwfBOIyfjXvrUy3S41mWvQj/VM9YLDgMug0MYHwVnbjXhB3mW9/KJExi8lSfEWevq71at26zsGU9KbYZcDo73wMF1eJZGO60E2VZ7wJK6pro7X+nW0f28Z9CyRswjwLVnucejL/mPbq4wodkgFzbjIDrVvfHX+y2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1KBklAZ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43dfe020675so6141cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717432942; x=1718037742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiMgs6ofu68NCD36BOAr5OSNcCuY8Lq+ii+XETURtvY=;
        b=e1KBklAZtq+1ZUq5+qOO+0iWld8E49DV1RHeYGk+H8E1+y+TWzlSv2kHv8ksnCu2pV
         VCFMTK64ZduNmKSJEhPwrFhRE8ihWoZ200+pI3fwfn2Q0Dvx+sg5gpGZBC9MT/BcOfpq
         r6XOJwNIHf98kE7aLTr0iaPPoLOxVFK/uTZAQM5QOMltJ7OzzwkwQg/XQt9e7eYKAqzQ
         FDbBGagEFfkds/vZogxSzrP8Ghbdz4wy+TBfXYw55y+G6KzR5/JeVb1aigpbXggzmKl5
         ph0nutb5PSn8tvt8+Y/6FgVcLJ+mOIxUGOYOjSKoxN790fKm6Pv7Up0ccuu0dtf21wWg
         zFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717432942; x=1718037742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiMgs6ofu68NCD36BOAr5OSNcCuY8Lq+ii+XETURtvY=;
        b=l6x1pqo7sBlFJicYj/mar3vyJSo5Rwc6euKC/586J/tuYATVDU5YWZSRnnGR9vS95k
         ov8FJpzUp3vJjIoNvxfcniYBQ26xjDquiQBO9CPz5JogtN5d/XVEB5j8WW7GszcV/tEg
         4xT+X1aJ7/U2E6MMzV4QxwEv4ksh23WxzdQ78EsDeWUZ8mwc1VG29Dn4QlRVhUVZkawS
         7dEXwOcRVI8d9cp28jBDnLHyGyQRrADxfPLf3iiuNShT/93hgf0sTUhytSTz/4v4eyd9
         P2E9FCNj2hx27hMqwcdp5uvkf3hJT1j4BDdRcT2Yz0f2GHYzgj6PigwR5nfgOOslY4Be
         lIDg==
X-Forwarded-Encrypted: i=1; AJvYcCV92YBIMK0P5B5oh6o3I4Lm/t2CoESxEwrEuZRoZVXehSTRz2PMis3G1OC59PFmQcUGABIydbs9uRI38d87qQjgwFi+xyMd1nhk2vNI
X-Gm-Message-State: AOJu0YyzAQmTRqQLuiWOLrvfVj4vt1Efw4p0b1JpdlcBm77exobH++jy
	OBnOHKDzVY5Zvo9vB/CzJiIOnIqndDUWvz8GMElx+f/1Ic5Qkfj9KbpG2vJpiMeIdbYXHQ7BGDj
	aM9T5eZ2J/7jwFl5U9xr3ZCTXFr82ehrPP4/w
X-Google-Smtp-Source: AGHT+IH6QLcAlf5vaH+UWsvJQZ3C5XzA8iLHk/IQp/niw6y6V1UZ6rx7vSOE8qRJ8e53gphDMK4TwxshkC6hAh95HlA=
X-Received: by 2002:a05:622a:5509:b0:43a:db0c:ed9c with SMTP id
 d75a77b69052e-43fff375484mr5104801cf.15.1717432942271; Mon, 03 Jun 2024
 09:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603092812.46616-1-yangyicong@huawei.com>
In-Reply-To: <20240603092812.46616-1-yangyicong@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Jun 2024 09:42:10 -0700
Message-ID: <CAP-5=fXw0=dHORC-kObYFiAco64PGP4_uFr__f9YmVctWtGSfA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Perf avoid opening events on offline CPUs
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
> If user doesn't specify the CPUs, perf will try to open events on CPUs
> of the PMU which is initialized from the PMU's "cpumask" or "cpus" sysfs
> attributes if provided. But we doesn't check whether the CPUs provided
> by the PMU are all online. So we may open events on offline CPUs if PMU
> driver provide offline CPUs and then we'll be rejected by the kernel:
>
> [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online

Generally Linux won't let you take CPU0 off line, I'm not able to
follow this step on x86 Linux. Fwiw, I routinely run perf with the
core hyperthread siblings offline.

Thanks,
Ian

> [root@localhost yang]# ./perf_static stat -e armv8_pmuv3_0/cycles/ --time=
out 100
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for e=
vent (cpu-clock).
> /bin/dmesg | grep -i perf may provide additional information.
>
> This patchset tries to avoid this case by:
> - Double check the PMU's cpumask in the perf tool and only include online=
 CPUs
> - Trying to make the PMU drivers only export online CPUs in its "cpus" or=
 "cpumask"
>   attributes
>
> Previously discussion can be found at [1]. Will suggested to do it in use=
rspace.
> I think it makes sense to do a double check in the perf tool in case the =
driver
> doesn't do this. So PATCH 1/3 is added in this version.
>
> [1] https://lore.kernel.org/linux-arm-kernel/20240410095833.63934-1-yangy=
icong@huawei.com/
>
> Yicong Yang (3):
>   perf pmu: Limit PMU cpumask to online CPUs
>   perf: arm_pmu: Only show online CPUs in device's "cpus" attribute
>   perf: arm_spe: Only show online CPUs in device's "cpumask" attribute
>
>  drivers/perf/arm_pmu.c     | 24 +++++++++++++++++++++++-
>  drivers/perf/arm_spe_pmu.c | 22 +++++++++++++++++++++-
>  tools/perf/util/pmu.c      | 13 +++++++++++--
>  3 files changed, 55 insertions(+), 4 deletions(-)
>
> --
> 2.24.0
>

