Return-Path: <linux-kernel+bounces-377733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C755B9AC336
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DF21C2295B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1262197A68;
	Wed, 23 Oct 2024 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=direct2internet-com.20230601.gappssmtp.com header.i=@direct2internet-com.20230601.gappssmtp.com header.b="Wzrabw00"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24A0198A1B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674810; cv=none; b=eyht3FVFS7Kx4Ng2jm9atXUXUmgMKKWvnNPBFTWu2MzdChg5ECrowZLt1hpmmHVRfrGQH1EG5kk9XN7afC/iDibtJb8SI9D0kqlVy0c+9mS41uUSOVMB2/edL+AGl+s8x0qIfaB9qshF2f+ljLe2ZH1wcLi2gRAAl1U0GRCHHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674810; c=relaxed/simple;
	bh=l83gk1Q2NObWtSC/fBNnsEHlEY5tkWPemo7kLVuqOmI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=s8hOqBJklNnnI5jejDEIvk1COicFkYr8bq2ccbaw7pzE9OHg6wF8UsgU3sH7DH3LGXoT+K/YKBopAjn5OuoIzYld7ALIEGc1R1rvhcbb1ORMdmUxtcWDnKiIJHjD9awRxLw5AY+H/fZdl3z5NeMr01tJ8Itt9yyGNza5lwBC/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=direct2internet.com; spf=fail smtp.mailfrom=direct2internet.com; dkim=pass (2048-bit key) header.d=direct2internet-com.20230601.gappssmtp.com header.i=@direct2internet-com.20230601.gappssmtp.com header.b=Wzrabw00; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=direct2internet.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=direct2internet.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460b2e4c50fso32260411cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=direct2internet-com.20230601.gappssmtp.com; s=20230601; t=1729674806; x=1730279606; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lti3qy1E85rECkSb/d1EV+A5C9qwd/3M4OdA3YrbzYM=;
        b=Wzrabw00a+tZhVnMlqAiikBgpXu+xusFB3kbrAbGBfhMy0gVqjRX4BTCjjDO8V9u11
         TOs68wAsq8xh0DSXfJU9t4ON9NuO1xHrTe4/8I7L4x9pXSGRyY2Ybz3dWApE19jQyCAG
         AT0d0ye/EPYi6M5tYwjV97QqShKsIblB+/QS3uLXAzInRJzvzZ7fPBO/R15C6iF1pnxv
         xTXpd2tUaJqR5OQwZhJnKqUx1QaXpsA1eXmsnkTyUVbWGLVV8sg1/u9ymJlrUeIuBEf1
         dm5YL08hdwVgMdH20vt1/UWEJ33JqDwfVHiGzGcTDjMeD/kkUQaZGjdKeczoMoBUrkWj
         qsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674806; x=1730279606;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lti3qy1E85rECkSb/d1EV+A5C9qwd/3M4OdA3YrbzYM=;
        b=Pa2CDYgNpjWZmuINlJgKPfqTRPweTT9cQx8snrx3fcTLnFW6cbsali/urhLzokAo8J
         BiyYtg9rky49Ljre7MFq7hGK0YVD0Hc7Evjz4HoOIFtZkwF1iu9lFWf4Tyf6gEfxCVZE
         otNNJR9Oaj0jGpbifOtzPo6hMv0D6oTNMSUt3qeHJGcepWkKW3F3YI7XRRVQler8nGZW
         m9ShMGnJY6E4a44HWNVzeD/ESE9Km9U2YtDWGXhYIxqhSWCQKNKS+6iSV+/tH0goiFFL
         HW48RkfXSdJ0kc4B/KAWySWuspLLG53KgFFYyvt9Vs3o2hyswCmwTvMxtUbA65tt/je1
         CsLg==
X-Gm-Message-State: AOJu0Yz+y/eYK6NEqX2/xbxHdMCK+UGLH0rqfni/t/Ph3YYPLkkX36Zh
	G/Dtp7yUtQf8s8gYM4x1eQKOs3vbbhBeB+sjEpCrrKxIFOYarzzolHyqdtExifbuhkDiuooV/LU
	fiu1KZGcs3abS5KKZtpKW6FDdJFRJXP8uRQw1JvkT0krfLv9R5Oc=
X-Google-Smtp-Source: AGHT+IEZIQu0pE7nzpeTrcgZhP+3n8Kj0BAurwvs/FD9thN1cZ/cPWiUtGZhyNKtguMUK4qWwiW80HmX5siAyoMmtNM=
X-Received: by 2002:a05:622a:15c9:b0:460:b93f:e2d9 with SMTP id
 d75a77b69052e-461147270dbmr22113561cf.52.1729674806340; Wed, 23 Oct 2024
 02:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rolf Stenholm <rolf.stenholm@direct2internet.com>
Date: Wed, 23 Oct 2024 11:13:15 +0200
Message-ID: <CAMdjFop0uzmi__Jx979sQEVviPNSZBpKUBdcQYnVgycsuwYL+g@mail.gmail.com>
Subject: Issue: measure /proc/loadavg is inaccurate and missing proper documentation
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Issue        : critical measure /proc/loadavg is inaccurate and
missing proper documentation
Kernel Files : kernel/sched/loadavg.c, include/linux/sched/loadavg.h
Version      : Any kernal before 2024 october, from
https://github.com/torvalds/linux 6.12-rc4 the issue is exist
               since the first linux kernels from the 90s.
Reproduce    : sample from /proc/loadavg while creating load on the machine
               (type "openssl speed -multi $(grep -ci processor
/proc/cpuinfo)" for creating 100% load and
                 "watch -n 1 'cat /proc/loadavg >> /tmp/loadavg.txt' "
to create a 'CSV' file to get statistics )
               or use a math package to examine the quality of the
algorithm (or lack thereof)
Desciption   : Measure /proc/loadavg is critical for administrators
everywhere. The measure has inaccurate
               documentation and output is inaccurate. This is a bug
report to try to at least improve documentation
               and in the future improve the accuracy of /proc/loadavg
values. You cannot understand the measure
               unless you actually read the kernel source code and
then only if you know similar of types of
               methods used for similar problems. Comments like 'Its a
silly number but people think its important.'
               are not helpful as loadavg is important for admins
everywhere to understand if the system is
               overloaded.


Load avg in /proc/loadavg is thouroughly discussed online but often
wihtout undestanding the measure ,for instance
a good article about loadavg is (which includes history and background)
https://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html
The article misses some critical ideas behind the calculation but
shows accuracy issues with current loadavg and
that the documentation of loadavg is lacking. The kernel code shows no
understanding of the original reason
for the measurment, therefore the following text can fill the gap one
the measure and why it was created.

The purpose of the calculation loadavg that dates back to the 70s can
be summed up in the following sentence
(Linux loadavg includes some idle processes in loadavg that are not
CPU related).
     Approximate the average cpu load over 1 min, 5 min, 15 min.
     (for linux this is approximate average load over 1 min, 5 min, 15 min).

Old 70s TENEX system (see link above) needed a cheap way to calculate
a loadavg without a large computation
footprint and memory footprint. The solutions was to approximate
normal average load (T1 + T2 .. TN)/N with the
differential equation

     ApproxAvg[N+1] = ApproxAvg[N] * C1 + Load[N] * C2

The idea is that it will roughly replicate the load average over time
with correct constants C1 and C2,
however it should be noted that when a system goes from no load to
full load the 1 minute measure is at 0.62
at 60 seconds and above 0.9 after 150 seconds making the measure quite
inaccurate.
There is a dangerous belief that the measure is exponential and indeed
there is an exponential constant in the
code, this does not make the actual diff equation exponential. The
TENEX code used C1 = EXP(-T/C), C2 = 1 -C1
where T is 5 seconds and C is 60, 300, 900 which are stored as
constants in the original code.
Why C1 = (C-T) / C was not used is not documented from the 70s TENEX
code but the taylor polynomial for the
C1 TENEX constant is E = 1-T/C+T^2/(C^2*2)... which is roughly the
same as C1 = (C-T)/C.
Because loadavg is an approximation of actual mean it is possibly to
create an easy least square error measure of
loadavg to quickly evalute other loadavg alternatives methods, the
equation is simply

  Square( (ApproxAvg[N+1]-Avg[N+1])*(ApproxAvg[N+1]-Avg[N+1]) + ...
(ApproxAvg[1]-Avg[1])*(ApproxAvg[1]-Avg[1]) )

With this measure we can get some alt calulations using 100 measuring
points where load goes from
0 to 1 instantly and we only include points where the actual average
goes from 0 to 100.

Examples:
C1=99/100, C2=1/100                        , E = 12.4
C1=69/70 ,  C2=1/70                        , E =  6.98
C1=exp(-1/100), C2=1-exp(-1/100)           , E = 12.57
C1=69/70 , C2=1/70 avg over last 10 values , E =  5.23

Which shows that current constants used in the calculation are not
optimal and can be improved. Using additional
datapoints will improve the measure but only slowly. If there is no
memory considerations for storing
all load samples for a given timeframe an integer queue with a stored
sum could be used, where sum is updated on
dequeue and enqueue of the queue allowing constant time calulation of
the actual average.

It can be noted that in the current code loadavg.c that:

- Function fixed_power_int calculates exponential despite the metric
not benefiting from this
- There is a distributed summation over CPU which generally isn't
required in a differential equation
- The code comments are "funny" but not very helpful to understand the
metric and this metric is important

And that in loadavg.h that:

-- The EXP_1, EXP_5, EXP_15 all look like copies of the 70s TENEX
system, the values could be improved

Because loadavg is critical measure for many admins and not understood
it would be good to document what loadavg
is trying to calculate and how it can be improved in later kernel
versions. Improvement of loadavg could save quite
a bit of resources for certain admins and data centers.
The exact solution may depend on how easy alternatives are to
implement but allowing loadavg to be sample from
another loaded kernel module or read from a user space application to
replace current values could help admins
everywhere to get a better customized measurement point with the aim
to improve the measurement loadavg. For
instance the kernal could read from a mounted device file like
/dev/myloadavg and use that as loadavg measure
based on hardware measure or clever algorithms.

