Return-Path: <linux-kernel+bounces-568278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1856A69338
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E1C1B82AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2736C1D5162;
	Wed, 19 Mar 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="MwDyoLAn"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B41CAA8A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396988; cv=none; b=Rj7P+SpmHaodFIiXsZPHZvVrtLuNfU9YvOAGVOqD9Vtr5McZOHN7fC0LvawmqjwTPFlhMfp5TdPl9va5ZnVasqUOR5ujSr543VW3N5BNUkpgxCPLlzSgpENbJGxVAEp8P168mn2US/UVHJICXtuJHx03bebI0yhYq17mmFdejws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396988; c=relaxed/simple;
	bh=QWtbIf9nI04gI+Qaz/Sd2FXRcFGvlhRGVXdc8baSbOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n3TSML29GakcfDb0ik6Y35z706j2F/RxegIksIDT/QaObxVOkt0lPQOVj62oex7fpu9cBY7oscgyeAVFfUd++otxmCONrXXaN1B2g1Bi9kcoGegkiSdgUFyhrtJT8RrUMgD8ea498sI7TQ/8J5wfuDizHZo6SpF+hs4c5wetllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=MwDyoLAn; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b41281b50so186015539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1742396986; x=1743001786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWtbIf9nI04gI+Qaz/Sd2FXRcFGvlhRGVXdc8baSbOc=;
        b=MwDyoLAnc7B1JOeW78uI/s1QEjiFRa5vTPSWUF4Kki8DFtUbmDSl0/cxq1cgHymt+o
         +gR0rXk3ksJmaj2/5ZZPmIBRFneO72CmQ3GoECv7RLE9ckmA6anntp9v21iaWOeBS2cA
         AtbHWP9ttlH2lClyYYsuKC3YSG6UZ5VkbmKTKVWU8ULeK2sjQrV/9AoeqPFaxAivEq+d
         sa4FwbQvWmJzYlxbaj8GlrAuSw4tAIBADY9oJ/BPJFE4GXwgdKmV+mg9chi+MRCtf6Lr
         /bYSeTeY6qt9kCNYBVSaMMr+j7zMxUP+Ha9o0/bx4rC0D3Wkfnp1db93+Sp9jecQ7NBh
         gnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396986; x=1743001786;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWtbIf9nI04gI+Qaz/Sd2FXRcFGvlhRGVXdc8baSbOc=;
        b=S9YFJJHw8pbEHFygAPB0k2LsMJ82yBi6TLaqOd5091FscHbJMZ0jpip8LiqVbr/W4X
         1Qd5dxdFTyowZ5YyyyVxYoUsRYkr7m+ZKBpWJbpg3TNl4h6Yke6Y1ubIHJ2dX3qHqFaJ
         cTZ2lzSbclW2AorMS9LH/rits4h6HKM8DNocHBkHBrCDo6gf7Dl/xj9Xu38LgkL94hU9
         5yelp5PfePFSaWa0lvjeq6GtwBcllqencC6lR5ppxwAKKpEkJ2JTEdkb8dmkl8UH+gUK
         3OxWjZAjtEoIyH8AIZMLtsAuiWBtvFjOQkYaH+MMkBaiuQOF1LJOfeDWJqQ6fs1FYbwx
         h1rw==
X-Forwarded-Encrypted: i=1; AJvYcCXXa7Fjbp+qyInhtrvKeEzbvFKQhi+QSkf2MbpiJiYfJdYKqOXI3yDcT23Hqi13vTzFm9irA4Oqp/XZBFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxexZq0ZBhCFfsLNySAsBCp5U7+VZxOiysUxg+DvWFwoZ1GzDoW
	Qn6WmzoT3gQO2u0AmUX/YJQHHOsfJa+PfMvUbBXECWGnt8sO6+iTLDiKde36PSc=
X-Gm-Gg: ASbGncs6+GeTHBtrQto4OEWwhOpj9+86lu5TO4ymi1PczCVtU5w+iyNYxfLKSdXIR57
	+UUgQLrMUbMevZLbKSEr4SBL+V7EMgyE8ad3iQk7wtSIbKUHOHp4cdKGCAe1ctFo003PLXM+woW
	XqLfeDsB2KC+N+8P/S63Anjp22F96QirH1MC7hA0ead+Tjp8pKHyrMsxABQiogDG0wtcHjDtYXQ
	Fx9e0/UUrbg8SvPNIAZROFrjBUsK4RJzNMdzuqh4J0OLEGv4obAJtrGb+Cw+RNmC6nkj3tddFc6
	5I8a/crOPiB1O2q6HYe5conzvCzgu8q8HcJviLbXgw==
X-Google-Smtp-Source: AGHT+IG4rhQdwit+SFyBcgIAgQKUnvCE7OMOskvLtOW18cJVkS3xyCXAhYUOrG/YWT7S0yEfyhXhsA==
X-Received: by 2002:a05:6602:3991:b0:85b:4afc:11d1 with SMTP id ca18e2360f4ac-85e137bb681mr377336439f.5.1742396985762;
        Wed, 19 Mar 2025 08:09:45 -0700 (PDT)
Received: from kf-m2g5 ([2607:fb90:cf88:74c:d7f4:2d05:3df2:a7d7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637276a8sm3218228173.65.2025.03.19.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:09:45 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:09:42 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 mmikowski@kfocus.org
Subject: /sys/devices/system/cpu/cpu* frequency info different between
 kernels 6.8 and 6.11
Message-ID: <20250319100942.578b815d@kf-m2g5>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I haven't looked super closely into this yet (haven't compiled a
mainline kernel and tested it), but it seems that the CPU frequency
info under /sys/devices/system/cpu/cpu* has changed behavior, at least
on Intel CPUs. In particular, the frequencies shown under
/sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_max_freq used to show the
maximum CPU frequency the hardware supported, even if turbo boost was
turned off in the intel_pstate driver. (This was the behavior in
kernels 6.8 and prior.) In kernel 6.11 however, they show the maximum
CPU frequency the hardware supports in its current turbo mode, meaning
that if turbo boost is turned off, the maximum CPU frequency shown is
much lower than it is when turbo boost is turned on. This is a bit of a
problem, because some userspace tools (for instance Kubuntu Focus's
Power and Fan tool) depend on cpuinfo_max_freq showing the maximum
frequency of the CPU regardless of turbo boost state, and rely on
base_frequency to show the maximum frequency without turbo boost
enabled. Now in order to read the maximum turbo boost frequency, you
have to at least temporarily enable turbo boost, then read the
frequency info.

To illustrate the issue:

=E2=94=8C=E2=94=80=E2=95=B4aaron@kf-m2g5:/sys/devices/system/cpu/cpu0/cpufr=
eq
=E2=94=94=E2=94=80=E2=95=B4$ echo '0' | sudo tee /sys/devices/system/cpu/in=
tel_pstate/no_turbo > /dev/null
=E2=94=8C=E2=94=80=E2=95=B4aaron@kf-m2g5:/sys/devices/system/cpu/cpu0/cpufr=
eq
=E2=94=94=E2=94=80=E2=95=B4$ grep . *
affected_cpus:0
base_frequency:2200000
cpuinfo_max_freq:5600000
cpuinfo_min_freq:800000
cpuinfo_transition_latency:20000
energy_performance_available_preferences:default performance balance_perfor=
mance balance_power power=20
energy_performance_preference:balance_performance
related_cpus:0
scaling_available_governors:conservative ondemand userspace powersave perfo=
rmance schedutil=20
scaling_cur_freq:1458327
scaling_driver:intel_cpufreq
scaling_governor:ondemand
scaling_max_freq:5600000
scaling_min_freq:800000
scaling_setspeed:<unsupported>
=E2=94=8C=E2=94=80=E2=95=B4aaron@kf-m2g5:/sys/devices/system/cpu/cpu0/cpufr=
eq
=E2=94=94=E2=94=80=E2=95=B4$ echo '1' | sudo tee /sys/devices/system/cpu/in=
tel_pstate/no_turbo > /dev/null
=E2=94=8C=E2=94=80=E2=95=B4aaron@kf-m2g5:/sys/devices/system/cpu/cpu0/cpufr=
eq
=E2=94=94=E2=94=80=E2=95=B4$ grep . *
affected_cpus:0
base_frequency:2200000
cpuinfo_max_freq:2200000
cpuinfo_min_freq:800000
cpuinfo_transition_latency:20000
energy_performance_available_preferences:default performance balance_perfor=
mance balance_power power=20
energy_performance_preference:balance_performance
related_cpus:0
scaling_available_governors:conservative ondemand userspace powersave perfo=
rmance schedutil=20
scaling_cur_freq:917829
scaling_driver:intel_cpufreq
scaling_governor:ondemand
scaling_max_freq:2200000
scaling_min_freq:800000
scaling_setspeed:<unsupported>

This is happening on Ubuntu 24.04 using a 6.11.0-series kernel.

Does this seem like a bug? If so, should I try reproduce it with a
mainline kernel and find the commit that introduced it?

Regards,
Aaron

