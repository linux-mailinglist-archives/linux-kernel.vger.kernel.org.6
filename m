Return-Path: <linux-kernel+bounces-203772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE048FE04B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035531F214A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBE513BC3A;
	Thu,  6 Jun 2024 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRzjJyW4"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924BF13A3EF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660673; cv=none; b=McofNIXNEgfRXAy5wJiXcPj0QrKyaMYMwb3J5Ku+5AHRUcVcNW4EQR4wIireybLJAzQ6B9TvOeCsJ2dpGczK4kiEgpW+CT6MJkZy1tQazKDoBOyMy3N3+KQsqgLrdCOA6aZKhbHhmUW4jhIZ4Y2eZG5M1aqwtLjcEpdFoDjrDNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660673; c=relaxed/simple;
	bh=8ftuWvN4f67ebYtsec+R7qcnXlTP1cIvGoDAWr1UXXY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p6mqlnZnQZ6ScnkfnOsSjUdHhKjGduBpIC70GeMDLN0wjHrK3nvgE3hvF9Je4QFrzB8EPlytPFKYrbuIJ1/UQbL06+5+s89fHe+xaYHZdpEbCPv8BbfoAfHI0Vv+BvUr2dgGaX41DOU3zjEMV7Wn+6LFiPFyOh+gPDdYkzxRswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gRzjJyW4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4215b888eabso49305e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717660670; x=1718265470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lBpAv6C3O+U7a9knE0xgywFkw1MNsJlamzVihT52F+s=;
        b=gRzjJyW4QENf2dHHyYfYXGgHGpxH8+zaqSsjAu6NQqRrL6hc8AE9zkEtPfrL8hUo/v
         4s6giYE5HUq3jA2G1bWJfItc454JV/13zx66WxjB0IY7DYJQo9o4iBd8aRleWkcZcyFS
         LXKS5KRp1eZ8ia+R1N1aSAsFjCUTrMNQiySCEtinzaPgjsu4wuR/znyIn8vMDhr+aNbO
         +OEG5azLpcfXZi8iG7/5LduxRU5IWN+Vr0b9wKRIY/OQQ2OPjhDreFc360XKWSj3Twk6
         AI2BEIlPc/lc3meU9v/K9y//7AjYLdtUG4aibnrDwWshjV+4vtW1h5T48pbRiN4P+cUo
         PIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660670; x=1718265470;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBpAv6C3O+U7a9knE0xgywFkw1MNsJlamzVihT52F+s=;
        b=Br0vOjjysvm3D4SJQTd8an/5507sO4OYnVAuE04TMnHrW7qobf/ivhqHApc9iGh1et
         uRHT9JKjzMmKH7AXJbWeyM3vTvHV7hs61f2PT16m63GWVgjr4BbcmNegwXYBU1ygOQjD
         f11aCX2nze5kzM21OEJjqVPHyIfOkZOYb1OLHVv3iZmIYZwXUNehCxpnLHl5mIL3eUqG
         wS1jeIlcnivfomeW72cD+DDvQHpN9KhCOHVsNSlm8pvd++yR8X/gtsVJic0AaacLLmKL
         W55BX5IBzNW3MuBvvTKoCdHNL6UkaZOFeQRndEYaNGXqAjlrmpopKILSWl4TdE/+A5nF
         Tj5Q==
X-Gm-Message-State: AOJu0YyYfKT/UrqPRfqWgUoTs9yPLtJYD3qvZS+/FCmdcPsjhUWCfQeN
	SutNYJLpUFT+W+mrgv1vXmHXvsPaIg+IdjW2KRPfY/uwecUibJ5CC1nQfvte1HbM5pg8YZmDqJu
	OGG9Nfk3Nu1FuQyn+ELMqnNFgNPG9FoKTCN1A
X-Google-Smtp-Source: AGHT+IGlHWNqaiN4UT7al7+ZwKkCEh6R+OFSo6HizzYhY/uoIbalEuVa9hspJ7ikccXu2exETlSk66FCP72M/i4d9kw=
X-Received: by 2002:a7b:ca4e:0:b0:41b:4c6a:de7a with SMTP id
 5b1f17b1804b1-4215c0da3c3mr1158105e9.3.1717660669562; Thu, 06 Jun 2024
 00:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephane Eranian <eranian@google.com>
Date: Thu, 6 Jun 2024 00:57:35 -0700
Message-ID: <CABPqkBQ3LQ_dXQSQVSrriinvSSXm2fHx4yOms=jRsa2WaXSsog@mail.gmail.com>
Subject: [RFC] perf_events: exclude_guest impact on time_enabled/time_running
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ian Rogers <irogers@google.com>, 
	"Liang, Kan" <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	"Narayan, Ananth" <ananth.narayan@amd.com>, "Bangoria, Ravikumar" <ravi.bangoria@amd.com>, 
	Namhyung Kim <namhyung@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhang Xiong <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

In the context of the new vPMU passthru patch series, we have to look
closer at the definition and implementation of the exclude_guest
filter in the perf_event_attr structure. This filter has been in the
kernel for many years. See patch:
https://lore.kernel.org/all/20240506053020.3911940-8-mizhang@google.com/

The presumed  definition of the filter is that the user does not want
the event to count while the processor is running in guest mode (i.e.,
inside the virtual machine guest OS or guest user code).

The perf tool sets is by default on all core PMU events:
$ perf stat -vv -e cycles sleep 0
------------------------------------------------------------
perf_event_attr:
  size                             112
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------

In the kernel, the way this is treated differs between AMD and Intel because AMD
does provide a hardware filter for guest vs. host in the PMU counters
whereas Intel
does not. For the latter, the  kernel simply disables the event in the
hardware counters,
i.e., the event is not descheduled.  Both approaches produce pretty
much the same
desired effect, the event is not counted while in guest mode.

The issue I would like to raise has to do with the effects on
time_enabled and time_running
for exclude_guest=1 events.

Given the event is not scheduled out while in guest mode, even though
it is stopped, both time_enabled and time_running continue ticking
while in guest mode.  If a measurement is 10s
long but only 5s are in non-guest mode, then time_enabled=10s,
time_running=10s. The count
represents 10s worth of non guest mode, of which only 5s were really
actively monitoring, but
the user has no way of determining this.

If we look at vPMU passthru, the host event must have exclude_guest=1
to avoid going into
an error state on context switch to the vCPU thread (with vPMU
enabled). But this time,
the event is scheduled out, that means that time_enabled keeps
counting, but time_running
stops. On context switch back in, the host event is scheduled again
and time_running restarts
ticking. For a 10s measurement, where 5s here in the guest, the event
will come out with
time_enabled=10s, time_running=5s, and the tool will scale it up
because it thinks the event
was multiplexed, when in fact it was not. This is not the intended
outcome here. The tool should
not scale the count, it was not multiplexed, it was descheduled
because the filter forced it out.
Note that if the event had been multiplexed while running on the host,
then the scaling would be
appropriate.

In that case, I argue, time_running should be updated to cover the
time the event was not running. That would bring us back to the case I
was describing earlier.

It boils down to the exact definition of exclude_guest and expected
impact on time_enabled
and time_running. Then, with or without vPMU passthru, we can fix the
kernel to ensure a
uniform behavior.

What are your thoughts on this problem?

