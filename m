Return-Path: <linux-kernel+bounces-191607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D655E8D1167
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1281F21A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3B1946F;
	Tue, 28 May 2024 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="z2OJSaO1"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5E15BB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716859276; cv=none; b=AURnbjwq3nT6RLrsQd6djcXmYkCvRHp1nagPH4vnINqdfdzXap4OFU+sM7lOihYBLOLhKAq7L3zZJW6LMQicJDQr6dKcwoTL9bHeLw+haxS/j+tpj3Tn8r3d7ixy2JgL2YTYdQ0xoXmqkserlYC40vcA9uwJZBCD0eGxHSHWXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716859276; c=relaxed/simple;
	bh=8XlrUCWHsCgexU34BG4NhbVRXPWg9AEJn4cAmb+cBuM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LcKRkMHY2Dfse+8qjXWzbCM9xfAKQReCzn7isAlRORb863B6sJQln3dvW0qQi/3iNnuebL/slvZX2c1DEBpl/TTaSwOwpKSB/SxpnN/p2iiyparFZWMLB2Ca61/OHOwPFo9yplezDabXHjZrEiCo/SE9CYsAnJr0YwGDSZgK98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=z2OJSaO1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354cd8da8b9so276400f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 18:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716859273; x=1717464073; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+rSjKpwIeS1N0EKrWLoorJzB9v8f2v2oQNKeq1QE8c=;
        b=z2OJSaO1ezz8gk/RvgwM3fv4K2wpDyW8bbjElXtIXBPu+Qcv8wosFyXBjGjaeqe9I4
         Zg/MzWrhBn4rRdjLzllqF+CZmA6D31RyEVBtgCfIKFwJKVimzFDmZcB+cmh5MryL4IJc
         GoJJ1xWz/CPkewT0Qj/7OhgyS5mZQPpC96nev/xkorh8S27ZFCqRIrreoJegbY8yuwsM
         q7v3FMSIKiWk6ntdwsQmAqZtvP5Fwx2TneUZo6RSvtoVTDtjfjdSHDDhkkqV+2Kkkj8b
         Qd5pMaku0gcTIIkJIc/WT8dkAfAUGIwJI3ebKzjYxNKcJf7QPz6HRMOd0ygruq94o17a
         uboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716859273; x=1717464073;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+rSjKpwIeS1N0EKrWLoorJzB9v8f2v2oQNKeq1QE8c=;
        b=gS/5ksnnh9vXfV3hu4m9UJTXfJG7uWABcawhCvbThq94OU4TFlcidyapCue35ITcWa
         9se4/YkY9SztyhMshuW2q76fn6AJEEVJcDpEoiVkFuPbBK1qZhfY0HOoZsIx03KmWVid
         YgfLOGX0QBGRpSxCjl0c8lVS4E6vQS7WtR//T4R+SHYu3d0CotfWf4g/hhgmyyoL1Kh9
         L0RFt2ldGJDjw5uRhO1pMoIC6KfEdvRNZrf2gYdkWjfDePTUGo1iwuE+ZxcktfSPezsO
         z0mPotu+Zc2RWEfqf/vCaeZ4yjr+eU+yEGQMT0I1q382n3ULIoRNiBMXsoktJx3aDH44
         Kl5g==
X-Gm-Message-State: AOJu0YyLmPTENDPqA/a1YCfN2RYKH/aCoeuhVF5JIkZEdPDV8wFL7Ovo
	YEhGhZClhDz2kf4zgA4klgyYmbE3mJKzUmby2M1i1S7hSq6pK7lvlNS+8VdJKHI=
X-Google-Smtp-Source: AGHT+IHxiSrspGb+FegyzUgFXXisAjJGpfkByxVt2IbbOf+YSxpmCL+Vnf9CtK2abC/3GmP86faDvA==
X-Received: by 2002:adf:ee0e:0:b0:354:fce5:e5d with SMTP id ffacd0b85a97d-35522166276mr7205990f8f.4.1716859272824;
        Mon, 27 May 2024 18:21:12 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9570sm10191874f8f.68.2024.05.27.18.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 18:21:12 -0700 (PDT)
Date: Tue, 28 May 2024 02:21:10 +0100
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Questions about transition latency and LATENCY_MULTIPLIER
Message-ID: <20240528012110.n6se3mapwxgqa3r2@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi

I am trying to understanding the reason behind the usage of LATENCY_MULTIPLIER
to create transition_delay_us. It is set to 1000 by default and when I tried to
dig into the history I couldn't reach the original commit as the code has gone
through many transformations and I gave up finding the first commit that
introduced it.

Generally I am seeing that rate_limit_us in schedutil (which is largely
influenced by this multiplier on most/all systems I am working on) is too high
compared to the cpuinfo_transition_latency reported by the driver

For example on my M1 mac mini I get 50 and 56us. rate_limit_us is 10ms (on 6.8
kernel, should become 2ms after my fix)

	$ grep . /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_transition_latency
	/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:50000
	/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_transition_latency:56000

AMD Ryzen it reads 0, and end up with LATENCY_MULTIPLIER (1000 = 1ms) as
the rate_limit_us.

On Intel I5 I get 20us but rate_limit is 5ms which is requested explicitly by
intel_pstate driver

	$ grep . /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_transition_latency
	/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
	/sys/devices/system/cpu/cpufreq/policy1/cpuinfo_transition_latency:20000
	/sys/devices/system/cpu/cpufreq/policy2/cpuinfo_transition_latency:20000
	/sys/devices/system/cpu/cpufreq/policy3/cpuinfo_transition_latency:20000
	/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_transition_latency:20000
	/sys/devices/system/cpu/cpufreq/policy5/cpuinfo_transition_latency:20000
	/sys/devices/system/cpu/cpufreq/policy6/cpuinfo_transition_latency:20000
	/sys/devices/system/cpu/cpufreq/policy7/cpuinfo_transition_latency:20000

The question I have is that why so high? If hardware got so good, why can't we
leverage the hardware's fast ability to change frequencies more often?

This is important because due to uclamp usage, we can end up with less gradual
transition between frequencies and we can jump up and down more often. And the
smaller this value is, this means the better we can handle fast transition to
boost or cap frequencies based on task's requirements when it context switches.
But the rate limit generally is too high for the hardware and wanted to
understand if this is pure historical or we still have reasons to worry about?

From what I've seen so far, it seems to me this higher rate limit is helping
performance as bursty tasks are more likely to find the CPU running at higher
frequencies due to this behavior. I think this is something I can help these
bursty tasks with without relying accidentally on this being higher.

Is there any worry on using cpuinfo_transition_latency as is if the driver
doesn't provide transition_delay_us?

And does the kernel/driver contract need to cater for errors in driver's
ability to serve the request? Can our request silently be ignored by the
hardware? Not necessarily due to rate limit being ignored, but for any other
reason? It is important for Linux to know what frequency we're actually running
at. Some hardware gives the ability to read a counter to discover that. But
a lot of systems rely on the fact that the request we sent is actually
honoured. But failures can mean things like EAS will misbehave.


Thanks!

--
Qais Yousef

