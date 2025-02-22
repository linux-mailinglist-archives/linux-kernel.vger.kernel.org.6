Return-Path: <linux-kernel+bounces-526930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA896A40541
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A5770077A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 03:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A571DFDA1;
	Sat, 22 Feb 2025 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc0TDl5u"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A4EEDE
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740193380; cv=none; b=CDtrhoRqfAX9iJV/IZcP9aaPxnG1sMxvTVDb/Q8pC2sSKjTixKVMTjt6bZN29uFK9Y0Fu5oSux4r6saCQdiaaUTdlVZmJLALPH8xXnIQ+DXtmDKPAV/pu9ixCVv7gLwjCpNJknAqnnWCvABfHwcvaIsQk/mxzZuPDhCrSDEtZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740193380; c=relaxed/simple;
	bh=myAZB5W39T1AP6rSuDccy6ZFkkn5pIjiu9NnCep86eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYT/AOaV2micJauFuD21vDQxSi96s02Z+UojuwXWD/FxopJ322ycVe0jVPmkT7XM6dYt+jO11PZ1+G74CjvGY9EQ0HAhSyVk0qPpOe7ubb4c8II1Ge+a3nOjq28o8ZSzNghf37lFpnZQRXajjy7nEkakArg8GFCxWqsBndF1AZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kc0TDl5u; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22185cddbffso61991885ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740193378; x=1740798178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqnHgIoi7Z71nwSnRtncvODqoC3/oikyHrsrESzDGJ0=;
        b=kc0TDl5uiZNVw+dqpz06PodAvPKHsRw66oKW957eJi5Qr6dDXvqizvhAZhPKmMYt6M
         5PFuXD4CJX0DLCjFUviGS/Zsram89FDwE+fksEr3JZL768+0l6Dyomv2NVFfdTJ8+Vm6
         XfhDJPcQZeoIH0R3CSEggSEZKN2Qb50vzC9bNGt0XupHtmnSSYeXDP4+G64TDWy8nnWZ
         dyU/7s26B3uV8ThwIhbBJXE/1gxRPOMacGxfstlhsM9A2fYNFXmf9GuJvuWhdzvPsJJG
         5fimPrJYxsg06a72NPNfyGIr2ToMDK8pNmVDnIwHe+tBsHHvFldPK0gk3Y8qwXI5lntj
         XfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740193378; x=1740798178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqnHgIoi7Z71nwSnRtncvODqoC3/oikyHrsrESzDGJ0=;
        b=QFR+EyYeZY1jT1BjTQDGRGO0oan8D8SHkghNZtP1iMUIfY7fqITymJoR9yxc1Lwthe
         laxIasOtm+aUJ04z1DzrBYzHwaGMzMpamtY362JzTzsg5R62LgG9mzYjhCxfmguYOuV6
         Wuf9jrL2e+DHrOwrgrjI+IH5qrJuV08UL8OBZnmq0UyB1TZhxzKql9xhgNAxTm2x2yTI
         5zktO2GnWK4EI5R3WTHkdHSrcUnC/BAttD9dzXzrHbmEWFV7LFQS+fRtfrg+9WMvDxfo
         srVmtchBOL5fP8rkx6Fdtj5Wr/vIY1ULC5+AGup/5AUYcEmBPPWan04SFt/ad7Et4f1s
         SB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW06Cn5JHWVTaSZ5fDUG63lK8NQ5de+mm6IoLsLIS+MJzx3AbLjJltgVPapNx3SBHbXh1Cohdoy1dFKsyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwITiLEZCPkGhzmD+IDmAr0YV3vp6aUaHP8Q+QEHlHGFSmG1Gvm
	Cinxo/7779Ap46W3PairzT5RB9c7a7ecee9MQFfffIaeJXXEAr+y
X-Gm-Gg: ASbGncuLY6AXNEIeJgUbWW+gTzvhK0pmtxtWVSUKq9IhZkpeA/Q+qV3sikRu9T47KMj
	0S0+sa/cF/7JPjLDYjwaSeLPso0JhUtuViBU7yPbUblnxyG4pzLGOmoyYjSa+se8OqN4w0hPoPi
	aZNucG9W7VGvbY+vfUqPZjKZ8TGwfNwBxJQBZrce+osy5BMR5iNnZbe44HnEL46gy0fRORdgCqx
	/PZPro1EmezdgM1eBnpCGGVZKP+p+rUHy56qftFRpJRKkYLcEjVW1hRokpPN/9YUWJRVLsimS35
	mbHWopogZFo2LAKX/reWj+zgRR/T+6JrpA==
X-Google-Smtp-Source: AGHT+IFHWI58QmmxNdzrVaA9/0a37Egg+Ekpw1MBeYMSrrJsmfNn2BmL7ZhgRL6+gc2dkiZI9ZInMg==
X-Received: by 2002:a05:6a20:7f9c:b0:1ee:a410:4aa5 with SMTP id adf61e73a8af0-1eef3dd0e8bmr8183850637.17.1740193378123;
        Fri, 21 Feb 2025 19:02:58 -0800 (PST)
Received: from localhost.localdomain ([129.227.63.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73274a11a0bsm11184675b3a.123.2025.02.21.19.02.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 19:02:57 -0800 (PST)
From: zihan zhou <15645113830zzh@gmail.com>
To: kprateek.nayak@amd.com
Cc: 15645113830zzh@gmail.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	gautham.shenoy@amd.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH V3 1/2] sched: Reduce the default slice to avoid tasks getting an extra tick
Date: Sat, 22 Feb 2025 11:02:22 +0800
Message-Id: <20250222030221.63120-1-15645113830zzh@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <ce4f4f7a-6033-4354-972e-2a066f8d5190@amd.com>
References: <ce4f4f7a-6033-4354-972e-2a066f8d5190@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your reply, thank you for providing such a detailed test,
which also let me learn a lot.

> Hello Zhou,
> 
> I'll leave some testing data below but overall, in my testing with
> CONFIG_HZ=250 and CONFIG_HZ=10000, I cannot see any major regressions
> (at least not for any stable data point) There are few small regressions
> probably as a result of grater opportunity for wakeup preemption since
> RUN_TO_PARITY will work for a slightly shorter duration now but I
> haven't dug deeper to confirm if they are run to run variation or a
> result of the larger number of wakeup preemption.
> 
> Since most servers run with CONFIG_HZ=250, and the tick is anyways 4ms
> and with default base slice currently at 3ms, I don't think there will
> be any discernible difference in most workloads (fingers crossed)
> 
> Please find full data below.


This should be CONFIG_HZ=250 and CONFIG_HZ=1000, is it wrong?

It seems that no performance difference is good news. This change will not
affect performance. This problem was first found in the openeuler 6.6
kernel. If one task runs all the time and the other runs for 3ms and then
sleeps for 1us, the running time of the two tasks will become 4:3, but 1:1
on orig cfs. This problem has disappeared in the mainline kernel.

> o Benchmark results (CONFIG_HZ=1000)
> 
> ==================================================================
> Test          : hackbench
> Units         : Normalized time in seconds
> Interpretation: Lower is better
> Statistic     : AMean
> ==================================================================
> Case:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>   1-groups     1.00 [ -0.00]( 8.66)     1.05 [ -5.30](16.73)
>   2-groups     1.00 [ -0.00]( 5.02)     1.07 [ -6.54]( 7.29)
>   4-groups     1.00 [ -0.00]( 1.27)     1.02 [ -1.67]( 3.74)
>   8-groups     1.00 [ -0.00]( 2.75)     0.99 [  0.78]( 2.61)
> 16-groups     1.00 [ -0.00]( 2.02)     0.97 [  2.97]( 1.19)
> 
> 
> ==================================================================
> Test          : tbench
> Units         : Normalized throughput
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> Clients:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>      1     1.00 [  0.00]( 0.40)     1.00 [ -0.44]( 0.47)
>      2     1.00 [  0.00]( 0.49)     0.99 [ -0.65]( 1.39)
>      4     1.00 [  0.00]( 0.94)     1.00 [ -0.34]( 0.09)
>      8     1.00 [  0.00]( 0.64)     0.99 [ -0.77]( 1.57)
>     16     1.00 [  0.00]( 1.04)     0.98 [ -2.00]( 0.98)
>     32     1.00 [  0.00]( 1.13)     1.00 [  0.34]( 1.31)
>     64     1.00 [  0.00]( 0.58)     1.00 [ -0.28]( 0.80)
>    128     1.00 [  0.00]( 1.40)     0.99 [ -0.91]( 0.51)
>    256     1.00 [  0.00]( 1.14)     0.99 [ -1.48]( 1.17)
>    512     1.00 [  0.00]( 0.51)     1.00 [ -0.25]( 0.66)
>   1024     1.00 [  0.00]( 0.62)     0.99 [ -0.79]( 0.40)
> 
> 
> ==================================================================
> Test          : stream-10
> Units         : Normalized Bandwidth, MB/s
> Interpretation: Higher is better
> Statistic     : HMean
> ==================================================================
> Test:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>   Copy     1.00 [  0.00](16.03)     0.98 [ -2.33](17.69)
> Scale     1.00 [  0.00]( 6.26)     0.99 [ -0.60]( 7.94)
>    Add     1.00 [  0.00]( 8.35)     1.01 [  0.50](11.49)
> Triad     1.00 [  0.00]( 9.56)     1.01 [  0.66]( 9.25)
> 
> 
> ==================================================================
> Test          : stream-100
> Units         : Normalized Bandwidth, MB/s
> Interpretation: Higher is better
> Statistic     : HMean
> ==================================================================
> Test:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>   Copy     1.00 [  0.00]( 6.03)     1.02 [  1.58]( 2.27)
> Scale     1.00 [  0.00]( 5.78)     1.02 [  1.64]( 4.50)
>    Add     1.00 [  0.00]( 5.25)     1.01 [  1.37]( 4.17)
> Triad     1.00 [  0.00]( 5.25)     1.03 [  3.35]( 1.18)
> 
> 
> ==================================================================
> Test          : netperf
> Units         : Normalized Througput
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> Clients:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>   1-clients     1.00 [  0.00]( 0.06)     1.01 [  0.66]( 0.75)
>   2-clients     1.00 [  0.00]( 0.80)     1.01 [  0.79]( 0.31)
>   4-clients     1.00 [  0.00]( 0.65)     1.01 [  0.56]( 0.73)
>   8-clients     1.00 [  0.00]( 0.82)     1.01 [  0.70]( 0.59)
> 16-clients     1.00 [  0.00]( 0.68)     1.01 [  0.63]( 0.77)
> 32-clients     1.00 [  0.00]( 0.95)     1.01 [  0.87]( 1.06)
> 64-clients     1.00 [  0.00]( 1.55)     1.01 [  0.66]( 1.60)
> 128-clients     1.00 [  0.00]( 1.23)     1.00 [ -0.28]( 1.58)
> 256-clients     1.00 [  0.00]( 4.92)     1.00 [  0.25]( 4.47)
> 512-clients     1.00 [  0.00](57.12)     1.00 [  0.24](62.52)
> 
> 
> ==================================================================
> Test          : schbench
> Units         : Normalized 99th percentile latency in us
> Interpretation: Lower is better
> Statistic     : Median
> ==================================================================
> #workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>    1     1.00 [ -0.00](27.55)     0.81 [ 19.35](31.80)
>    2     1.00 [ -0.00](19.98)     0.87 [ 12.82]( 9.17)
>    4     1.00 [ -0.00](10.66)     1.09 [ -9.09]( 6.45)
>    8     1.00 [ -0.00]( 4.06)     0.90 [  9.62]( 6.38)
>   16     1.00 [ -0.00]( 5.33)     0.98 [  1.69]( 1.97)
>   32     1.00 [ -0.00]( 8.92)     0.97 [  3.16]( 1.09)
>   64     1.00 [ -0.00]( 6.06)     0.97 [  3.30]( 2.97)
> 128     1.00 [ -0.00](10.15)     1.05 [ -5.47]( 4.75)
> 256     1.00 [ -0.00](27.12)     1.00 [ -0.20](13.52)
> 512     1.00 [ -0.00]( 2.54)     0.80 [ 19.75]( 0.40)
> 
> 
> ==================================================================
> Test          : new-schbench-requests-per-second
> Units         : Normalized Requests per second
> Interpretation: Higher is better
> Statistic     : Median
> ==================================================================
> #workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>    1     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.46)
>    2     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.15)
>    4     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.15)
>    8     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.15)
>   16     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)
>   32     1.00 [  0.00]( 0.43)     1.01 [  0.63]( 0.28)
>   64     1.00 [  0.00]( 1.17)     1.00 [  0.00]( 0.20)
> 128     1.00 [  0.00]( 0.20)     1.00 [  0.00]( 0.20)
> 256     1.00 [  0.00]( 0.27)     1.00 [  0.00]( 1.69)
> 512     1.00 [  0.00]( 0.21)     0.95 [ -4.70]( 0.34)
> 
> 
> ==================================================================
> Test          : new-schbench-wakeup-latency
> Units         : Normalized 99th percentile latency in us
> Interpretation: Lower is better
> Statistic     : Median
> ==================================================================
> #workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>    1     1.00 [ -0.00](11.08)     1.33 [-33.33](15.78)
>    2     1.00 [ -0.00]( 4.08)     1.08 [ -7.69](10.00)
>    4     1.00 [ -0.00]( 6.39)     1.21 [-21.43](22.13)
>    8     1.00 [ -0.00]( 6.88)     1.15 [-15.38](11.93)
>   16     1.00 [ -0.00](13.62)     1.08 [ -7.69](10.33)
>   32     1.00 [ -0.00]( 0.00)     1.00 [ -0.00]( 3.87)
>   64     1.00 [ -0.00]( 8.13)     1.00 [ -0.00]( 2.38)
> 128     1.00 [ -0.00]( 5.26)     0.98 [  2.11]( 1.92)
> 256     1.00 [ -0.00]( 1.00)     0.78 [ 22.36](14.65)
> 512     1.00 [ -0.00]( 0.48)     0.73 [ 27.15]( 6.75)
> 
> 
> ==================================================================
> Test          : new-schbench-request-latency
> Units         : Normalized 99th percentile latency in us
> Interpretation: Lower is better
> Statistic     : Median
> ==================================================================
> #workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>    1     1.00 [ -0.00]( 1.53)     1.00 [ -0.00]( 1.77)
>    2     1.00 [ -0.00]( 0.50)     1.01 [ -1.35]( 1.19)
>    4     1.00 [ -0.00]( 0.14)     1.00 [ -0.00]( 0.42)
>    8     1.00 [ -0.00]( 0.24)     1.00 [ -0.27]( 1.37)
>   16     1.00 [ -0.00]( 0.00)     1.00 [  0.27]( 0.14)
>   32     1.00 [ -0.00]( 0.66)     1.01 [ -1.48]( 2.65)
>   64     1.00 [ -0.00]( 5.72)     0.96 [  4.32]( 5.64)
> 128     1.00 [ -0.00]( 0.10)     1.00 [ -0.20]( 0.18)
> 256     1.00 [ -0.00]( 2.52)     0.96 [  4.04]( 9.70)
> 512     1.00 [ -0.00]( 0.68)     1.06 [ -5.52]( 0.36)
> 
> 
> ==================================================================
> Test          : longer running benchmarks
> Units         : Normalized throughput
> Interpretation: Higher is better
> Statistic     : Median
> ==================================================================
> Benchmark		pct imp
> ycsb-cassandra          -0.64%
> ycsb-mongodb             0.56%
> deathstarbench-1x        0.30%
> deathstarbench-2x        3.21%
> deathstarbench-3x        2.18%
> deathstarbench-6x       -0.40%
> mysql-hammerdb-64VU     -0.63%
> ---

It seems that new_base_slice has made some progress in high load/latency
and regressed a bit on low load.

It seems that slice should not only be related to the number of cpus, but
also to the corresponding relationship between the overall load and the
number of cpus. The load is relatively heavy, so the slice should be
smaller. The load is relatively light, so the slice should be larger.
Fixing it to a value may not be the optimal solution.

> With that overwhelming amount of data out of the way, please feel free
> to add:
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

I think you're worth it, but it seems a bit late. I have received the email
of tip-bot2, I am not sure if there can still add it.

Your email made me realize that I should establish a systematic testing
method. Can you give me some useful projects?

Thanks!

