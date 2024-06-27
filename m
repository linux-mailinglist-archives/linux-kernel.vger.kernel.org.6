Return-Path: <linux-kernel+bounces-232068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD891A29F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EBC287D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D31913A24B;
	Thu, 27 Jun 2024 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFSjNX1m"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62E23BE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719480374; cv=none; b=ljRGvhDaAc+nCCI5PPOI/vkSR4tHFnVJfQftQSYvB0UNxPS6SoDtLLG5EluQEZ8ach+mgxyb7BTnIq/mmtcMS3LskjYKjhzagg9eOHDUrQMdNHWQNxFG25kNZ51/cc3Y+E0g05tBToQF1dyDNstUeadWQr0u82rkXuzEwKZaEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719480374; c=relaxed/simple;
	bh=kyJIqEBFqCE73xAtIS/XSDXfiGRU0COC5zBe7ni5tWI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=g6uChWEmBfswmNZPvvNRNaOZ1Xgc4YFecoGAwjesq61L3Kr9MHU7wMvWS+bK6tS10rsJ2LH/5qzlN2jRGjeyPnJr2uqmlS+XjijZW+rZs0EwME0He060etR+hyQHXIwZA8mL4c6KDoexNC+91sskb5SNSk7ClJSWF3hvymo/Gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFSjNX1m; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-362f62ae4c5so931238f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719480371; x=1720085171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R4AIU2iNAtfRic0+Eegq0bnHeJbQdaU45cRQfxQBrJ0=;
        b=QFSjNX1mix8OWRqNnw/ivad/y1Y/4RiYkCMKBRrDM1Fm8iw6zMWwoEh4pjjxMcYuIx
         rTc0Bs/7IFkS0isd1y7Tzr2kbPGpkY2OvPpKMYPRkXIljfhhkom5254e4AKqIgYdhrAF
         f8r8SuQh60auOCXlae5DONNXUs2pePDmapPoqxgr6ArVpLiSOu22bcf0fC6VDu+9+6y1
         rOeB26APxw6pNXmkTwfKJL1Akmfk6iZJ1mtaMgJ66CxArgeyv6lxonwjwGP5UHAhtxHV
         c5DYxI3Zb3641tG5LHCOLjy8DWa4lIKxOJjN5pHxEZ2ESn9EbVCJXaSf2JHcyOzk20Vj
         +knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719480371; x=1720085171;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R4AIU2iNAtfRic0+Eegq0bnHeJbQdaU45cRQfxQBrJ0=;
        b=eqNXriBLy1TycV4Z++gS49FN/uLUd2AlscME4w7TF4ZZZjDUD0cO49YrT6PqZxRMx4
         6/WOz4VOe3rFOK56TBxPAI/NRslM2Pr1oSYrj2LqECKKTJC80tt42faK/r2xcWkJM5ZW
         iBuF8bLlbp/BJdmzrInLO/Hn44ntZvWe2ZfkbOMcZZAO9PHxRfSjH7Y/T8HUpJQGvu8S
         xPgV/3Z/Eq4Hc91MXqLJBBqR9Zx6ksWk/rZnqOAbhiib5fO8bjeyeDZMJ9+89pPQzSZy
         c/oeJytG5/ZFS4HyklywGSWyOEwUqxulVCDCKbpOdBXcFfHqwaJla8V1xdYHicMCB5Q/
         i0UQ==
X-Gm-Message-State: AOJu0Yy0+0p4wZ13IULZMn7uPNRByLH0AD0uKn707yJUAfwBAn5J8ENI
	5cTFcaepBDYJWvi8+2a7fhQ/gW9zzRwzrW0DJ8oZgI+XY85JHE3cwZKAH3mZit5eUuT7DgVOrRu
	voH6x8kfitwfWnLH0asof+CFtDLdYwFSo
X-Google-Smtp-Source: AGHT+IGrN1xg3fLUmiqmNBFhsyiyjMeXOWpRHJ4fVF/nna1GJR9kemCPcAh3dREc/TZXewZy3z4NLG1SVAww1xk7r9Y=
X-Received: by 2002:a5d:4648:0:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-3673cc93496mr1864461f8f.30.1719480371320; Thu, 27 Jun 2024
 02:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: richard clark <richard.xnu.clark@gmail.com>
Date: Thu, 27 Jun 2024 17:26:05 +0800
Message-ID: <CAJNi4rMfRmWoYdsyH6ibNKN8DSCL_DO8Wa08mWbe8t7vH21Dpw@mail.gmail.com>
Subject: Will smp_call_function_single(cpu, ...) broadcast IPI to all other cpus?
To: Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, will@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi,
There's a smp_call_function_single(10, ipi_cb_func, &data_info, 1)
called by the init function of my kmod, then I ipi traces this
smp_call_function_single(...) with below cmdline:

# echo 0 > /sys/kernel/debug/tracing/tracing_on; echo >
/sys/kernel/debug/tracing/trace; echo 'reason=="Function call
interrupts"' > /sys/kernel/debug/tracing/events/ipi/filter; echo 1 >
/sys/kernel/debug/tracing/events/ipi/ipi_raise/enable; echo 1 >
/sys/kernel/debug/tracing/events/ipi/ipi_entry/enable; echo 1 >
/sys/kernel/debug/tracing/tracing_on; taskset -c 0 insmod
/kmods/ipi_test.ko; echo 0 > /sys/kernel/debug/tracing/tracing_on;
echo 0 > /sys/kernel/debug/tracing/events/ipi/ipi_raise/enable; echo 0
> /sys/kernel/debug/tracing/events/ipi/ipi_entry/enable; echo >
/sys/kernel/debug/tracing/events/ipi/filter; cat
/sys/kernel/debug/tracing/trace

The trace output as below:

# tracer: nop
#
# entries-in-buffer/entries-written: 28/28   #P:12
#
#                                _-------=> irqs-off/BH-disabled
#                               / _------=> need-resched
#                              | / _-----=> need-resched-lazy
#                              || / _----=> hardirq/softirq
#                              ||| / _---=> preempt-depth
#                              |||| / _--=> preempt-lazy-depth
#                              ||||| / _-=> migrate-disable
#                              |||||| /     delay
#           TASK-PID     CPU#  |||||||  TIMESTAMP  FUNCTION
#              | |         |   |||||||      |         |

          <idle>-0       [009] dn.h2..   555.400822: ipi_raise:
target_mask=00000000,00000002 (Function call interrupts)
          <idle>-0       [001] d..h1..   555.400832: ipi_entry:
(Function call interrupts)
          insmod-1644    [000] ....1..   555.401628: ipi_raise:
target_mask=00000000,00000ffe (Function call interrupts)
          <idle>-0       [001] d..h1..   555.401630: ipi_entry:
(Function call interrupts)
          <idle>-0       [009] d..h1..   555.401631: ipi_entry:
(Function call interrupts)
          <idle>-0       [011] d..h1..   555.401633: ipi_entry:
(Function call interrupts)
          <idle>-0       [003] d..h1..   555.401633: ipi_entry:
(Function call interrupts)
          <idle>-0       [008] d..h1..   555.401633: ipi_entry:
(Function call interrupts)
          <idle>-0       [002] d..h1..   555.401634: ipi_entry:
(Function call interrupts)
          <idle>-0       [010] d..h1..   555.401634: ipi_entry:
(Function call interrupts)
          <idle>-0       [004] d..h1..   555.401635: ipi_entry:
(Function call interrupts)
          <idle>-0       [005] d..h1..   555.401635: ipi_entry:
(Function call interrupts)
          <idle>-0       [006] d..h1..   555.401635: ipi_entry:
(Function call interrupts)
          <idle>-0       [007] d..h1..   555.401635: ipi_entry:
(Function call interrupts)
          insmod-1644    [000] ....1..   555.401643: ipi_raise:
target_mask=00000000,00000ffe (Function call interrupts)
          <idle>-0       [001] d..h1..   555.401644: ipi_entry:
(Function call interrupts)
          <idle>-0       [002] d..h1..   555.401645: ipi_entry:
(Function call interrupts)
          <idle>-0       [003] d..h1..   555.401645: ipi_entry:
(Function call interrupts)
          <idle>-0       [004] d..h1..   555.401645: ipi_entry:
(Function call interrupts)
          <idle>-0       [006] d..h1..   555.401645: ipi_entry:
(Function call interrupts)
          <idle>-0       [005] d..h1..   555.401645: ipi_entry:
(Function call interrupts)
          <idle>-0       [007] d..h1..   555.401645: ipi_entry:
(Function call interrupts)
          <idle>-0       [008] d..h1..   555.401645: ipi_entry:
(Function call interrupts)
          <idle>-0       [009] d..h1..   555.401645: ipi_entry:
(Function call interrupts)
          <idle>-0       [010] d..h1..   555.401645: ipi_entry:
(Function call interrupts)
          <idle>-0       [011] d..h1..   555.401646: ipi_entry:
(Function call interrupts)
          insmod-1644    [000] ....1..   555.401908: ipi_raise:
target_mask=00000000,00000400 (Function call interrupts)
          <idle>-0       [010] d..h1..   555.401911: ipi_entry:
(Function call interrupts)

I am curious why there're two IPI broadcasts to all the other
cpus(1-11) before the real smp_call_function_single(10) trace
event(the last two lines of the above trace output), any comments
about that?

