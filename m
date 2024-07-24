Return-Path: <linux-kernel+bounces-260530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E7593AA93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EAB282263
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E15479F0;
	Wed, 24 Jul 2024 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0pDgxPx"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE2522A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784434; cv=none; b=mosJsP+fnT4U0ud2mulgS+UPdArF54z5mSzTak2IY+OnvE9h5NhYTBcjEGx9WtoM/s/Pk/hR4gXFu4G1ywgob4BWBD02cifyMILxJDu/Q2SHM4t38tdc8DnAa207D5LAWCrYyScrlXaSkOl3TkR+7fnN9qYHuA/kJcHXrmjxctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784434; c=relaxed/simple;
	bh=QOeOiHuqWOZpEz5Xb3qDmTG2vxbB6T7QVE3SQW5YPUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mwzd6n4KKNC43jFpuYdoKsdUgn8YKQq1QiL56pCQq5o+0NIP0yxgPJpF8xa6euZALR72Z78Etpx/jEWVL81L3TDaBegdO/zukGP8cafL+FrDz/X0DCLr00127t8slMWqLC/heenzcKuM/++icgeBRFKOEOvdn56DJF6FIRDL19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0pDgxPx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd7509397bso104035ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721784432; x=1722389232; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RF3dFY/LyunryryiKzK/JX9hMFUdtuG285TonZDXYtY=;
        b=f0pDgxPxuMK6kuc5Gvzt8TIKRd4hQnwf1rLEDEobONiXC/t/vjY6kWaQI6n1c84dF5
         7oHDvIF06K8d6ThTubn8P0be39Vh4UkUNhvv/QLobtUhRQl42Yronv7IyI8AAWxaxL6t
         bctCYmo7moyU/RxJVSPEvrPDq7aM6PWcG0TZz7sXC7OvScWNYN5YB+lUEYieWzPWA8Sr
         0t+IT3g95EvGD/5597+bpJ9qh+lTDGSNkDU1HR3NrmtmfDUyOCD3F+ccfD6bGD7SZSR8
         1ViKhNF6FS0R51aQW07orKYsZJQndLw0B3w/mbZ6OIYLEDJD383wC0cK4BLKM2tJ9Q8H
         +u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721784432; x=1722389232;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF3dFY/LyunryryiKzK/JX9hMFUdtuG285TonZDXYtY=;
        b=uUdV7kFfezSO0EISBCGfZM7V1LN3iAkDph0xe6T0ZZJwYIMSToQd9KC4NcQFCVPMcP
         wgsojb8pJp04zc2qPxA9BTxvOPSYlpQAcY+CnmrznIU/5Z7Kq7p4qmm/RfZWzDn5dqoV
         jxb+t454oxyX6hfbGNaRuM4ufN4Yigy05RckImrowEIEqwXj0SPor/T4rILqwBn/TbBn
         3SSimjFrMWu8StN0Qsozvssz/RGz1nnvnxcRe76jW0p3EJ3s8eytdh6SuhFocr81ujT0
         AYP9er37eHy/Jb0cb0wRhfSMCW0T0BKvIhQ2jvGilzJ6aKQ5sf15k66/rvVek+kfTmui
         bIag==
X-Forwarded-Encrypted: i=1; AJvYcCWkh0Wv9xwW665s7v+vN4Wz7M2IEEYjBhGjGmHqiMBmGwj7ix+gWUJes8Ue/vI88Gv+qxS7h2fZi+KwhqUkCy2leTxgn/YJ6WblJQa2
X-Gm-Message-State: AOJu0Yyup6C/lW5Qo5m8P7DW/qHs4uuRDT2e2ggL0xah9ZaMQB1XMRMI
	anvAUuvRhBVaV5RB09dPaky1Inm8+TDqqH7I7d6wRP3dTC1UPm5ioaJKl3ao0Q==
X-Google-Smtp-Source: AGHT+IGt7Yj17oIOfXoIRXm//jQ7Y91iybzeUPc+6hWZ/9bvK6+8AJy2ioE+aLY8CJaQu4pXYrzhjA==
X-Received: by 2002:a17:902:d4cc:b0:1f8:5767:b114 with SMTP id d9443c01a7336-1fdd3902ef5mr1934975ad.0.1721784432168;
        Tue, 23 Jul 2024 18:27:12 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb746347bsm289432a91.35.2024.07.23.18.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 18:27:11 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com,  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  mgorman@suse.de,  vschneid@redhat.com,
  chengming.zhou@linux.dev,  linux-kernel@vger.kernel.org,
  joshdon@google.com
Subject: Re: [PATCH v2 2/2] sched/core: Avoid unnecessary update in
 tg_set_cfs_bandwidth
In-Reply-To: <20240723122006.47053-3-zhouchuyi@bytedance.com> (Chuyi Zhou's
	message of "Tue, 23 Jul 2024 20:20:06 +0800")
References: <20240723122006.47053-1-zhouchuyi@bytedance.com>
	<20240723122006.47053-3-zhouchuyi@bytedance.com>
Date: Tue, 23 Jul 2024 18:27:10 -0700
Message-ID: <xm26h6cfzij5.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chuyi Zhou <zhouchuyi@bytedance.com> writes:

> In the kubernetes production environment, we have observed a high
> frequency of writes to cpu.max, approximately every 2~4 seconds for each
> cgroup, with the same value being written each time. This can result in
> unnecessary overhead, especially on machines with a large number of CPUs
> and cgroups.
>
> This is because kubelet and runc attempt to persist resource
> configurations through frequent updates with same value in this manner.
> While optimizations can be made to kubelet and runc to avoid such
> overhead(e.g. check the current value of cpu request/limit before writing
> to cpu.max), it is still worth to bail out from tg_set_cfs_bandwidth() if
> we attempt to update with the same value.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Reviewed-by: Ben Segall <bsegall@google.com>

> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7720d34bd71b..0cc564f45511 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9090,6 +9090,9 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>  	guard(cpus_read_lock)();
>  	guard(mutex)(&cfs_constraints_mutex);
>  
> +	if (cfs_b->period == ns_to_ktime(period) && cfs_b->quota == quota && cfs_b->burst == burst)
> +		return 0;
> +
>  	ret = __cfs_schedulable(tg, period, quota);
>  	if (ret)
>  		return ret;

