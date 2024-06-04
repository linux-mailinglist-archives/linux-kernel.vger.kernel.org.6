Return-Path: <linux-kernel+bounces-200141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E378FABA9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3071C2138C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5913E88B;
	Tue,  4 Jun 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Z0Seid78"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD83372
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485407; cv=none; b=fjSw4HUPhafIVoTAuD92aspCfMNaqkcFu8nxVFkue0dNBiaf6KkPqeDr0LDa5FKeT8q2pfPROnlNreDFhXbnbwXltvotroJH3E7+k6XDnwN00ozAkm6VTLicsiyC0y+ebrgBp42CM3swd7VyY4mavFtgYM+wfWE+/QkHBCnp1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485407; c=relaxed/simple;
	bh=SSHp8bcgTpYjd7WUeRnHbZD2iwivFkh/GoxEtOLHF3I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=d6GmHPeQtIc9S51RTayZyFEnlGQqplD/6AHjSkR+PQ4DWyNKXijeJM55Fqdlf8IX1cmZYSk/pA4IVfj7o2uqJ8UAOqtklnfHpF4ZI7WPNsEZrT5DFfk2WRQd2h51B1cDFrf5fatsX6BaXA0I6ga5pITNzuPYjV2Emcv/t/3RfJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Z0Seid78; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6265d48ec3so545546366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 00:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717485403; x=1718090203; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5fiGzyt6U1DvtZABjI1WEbvyTI1XSXmtITKe1nhJLbw=;
        b=Z0Seid7810YWhGtXjeitefNISEJQ08D0H/R3m5Je0kTaNRuiKddtrne19qI+V4hSUl
         nHjfJR24qjt+6IQodg3gM/jqoijmRdTvsxMZg5n9OaUvO+rasEFVHHnepOcONegF82tz
         /p+HcmBGMFrc4LsJFged3TG3dqWHXdq+/Ai/AGMB9Rvpa8kFhZMzmQFwHRgmZB+62w5L
         UKI/YI2umwCTKoxRUHcrNDB9CARLMcDb/KSia7G0SwmQ8F0FzKybgPq6DMjhLLfoLSmo
         ogySLqJdtUKYPNegrms/1o/6HsEK/Q4EV3wx3tpahZtjUtOnsL0wJsS4o8/zTpBEqH9u
         IFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717485403; x=1718090203;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fiGzyt6U1DvtZABjI1WEbvyTI1XSXmtITKe1nhJLbw=;
        b=MCIT5NmC5RDQ/d8mxnxMospRRTbinVymkf/hXl+CnBAXxuNuSkgFNn4x6x0NpBBhwg
         A1RPsPbE5Rq/l1R5AXC3JIkuI2ojDdxjB8qLyWmlDPfjwfT/xXe8yiJB2rNicVlhK78x
         aAwNuu65oV2jtTIK6J0RkQsVu+eaADV4Vn33bVYiNmo07qIPEenq6F1Ztm4x6yKuRDs5
         rjQa9l+cL6QWkqQJLTn/mp5bMDsEW9B4CWta9asxGYdyKq7/1r74KJU+ut7kBQyXAAAN
         1vWFMMalMpyUiiHxP2R90MAXK7+oofl+g0jdcl5jvrHxm3mbO37e3I1ovZzWr64UTs5Z
         Hd/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrf9CdHL0EHOnkyyhcEOcYKTB/G5UxZCgvhL9LjAF/dQC3B10wuBdjfZeDaHoGXoaBGhzK2vq+umJ2FT+5m/ewFbxAjhufrT5K/IOQ
X-Gm-Message-State: AOJu0Yy7kKcmkp0KTQHKiSuuJJdi74+iSHx2elV4xGYsnj5ON/9drvw2
	Vghuyz1uh1dx6kO21d/U8qJYJpkIPD8ublt5Etb6GUjwN0NIjv52WlPUlAw1GUDEaiPGD2rLLeX
	E58r7mfzNMNvOPIerv+4RsqtcRQ2yG5q19wiabA==
X-Google-Smtp-Source: AGHT+IHeLMrB7kFD7fY+kEcfLU701b+D88C5q6WDLjkKTnKnvo53RWt2bB2eBRKTfs3qrHa2XZefNg8PEIA27flJZxU=
X-Received: by 2002:a17:906:799:b0:a68:e70f:c715 with SMTP id
 a640c23a62f3a-a68e70fc9dcmr420193566b.68.1717485402790; Tue, 04 Jun 2024
 00:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 4 Jun 2024 09:16:32 +0200
Message-ID: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
Subject: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Johannes Weiner <hannes@cmpxchg.org>, surenb@google.com, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi kernel people,
I have a problem that I have been trying to debug for a few days, but
I got lost in the depths of the scheduler code; I'm stuck and I need
your help.
We have several servers which show a constant memory.pressure value of
30 to 100 (or more), even when the server is idle. I tracked this down
to psi_group_cpu.tasks[NR_MEMSTALL]==1 even though no such process
exists, but I can't figure out why the kernel thinks there is still
one task stuck in memstall. I tried to track down all the code paths
that lead to psi_group_change(), but found nothing conclusive, and
failed to reproduce it on a test machine with kernel patches injecting
delays (trying to cause data race bugs that may have caused this
problem).

This happened on servers that were very busy and indeed were in
memstall often due to going over memory.high frequently. We have one
"main" cgroup with memory.high configured, and all the workload
processes live in sub-cgroups, of which we always have a few thousand.
When memory.events gets triggered, our process manager stops a bunch
of idle processes to free up memory, which then deletes the sub-cgroup
they belong to. In other words: sub-cgroups get created and deleted
very often, and they get deleted when there is indeed memory stall
happening. My theory was that there could be a data race bug that
forgets to decrement tasks[NR_MEMSTALL], maybe when a stalled child
cgroup gets deleted.
On our Grafana, I can easily track the beginning of this bug to a
point two weeks ago; in the system log, I can see that hundreds of
processes needed to be terminated due to memory pressure at that time.

The affected servers run kernel 6.8.7 with a few custom patches, but
none of these patches affect the scheduler or cgroups; they're about
unrelated things like denying access to Ceph snapshots and adjusting
debugfs permissions. (I submitted most of those patches to LKML long
ago but nobody cared.)
Newer kernels don't seem to have fixes for my problem; the relevant
parts of the code are unchanged.

One of the servers is still running with this problem, and I can
access it with gdb on /proc/kcore. I'll keep it that way for some more
time, so if you have any idea what to look for, let me know.

This is the psi_group of the "main" cgroup:

 $1 = {parent = 0xffff9de707287800, enabled = true, avgs_lock = {owner
= {counter = 0}, wait_lock = {raw_lock = {{val = {counter = 0},
{locked = 0 '\000', pending = 0 '\000'}, {locked_pending = 0, tail =
0}}}}, osq = {tail = {
        counter = 0}}, wait_list = {next = 0xffff9de70f772820, prev =
0xffff9de70f772820}}, pcpu = 0x3fb640033900, avg_total =
{6133960836647, 5923217690044, 615319825665255, 595479374843164,
19259777147170, 12847590051880},
  avg_last_update = 1606208471280060, avg_next_update =
1606210394507082, avgs_work = {work = {data = {counter = 321}, entry =
{next = 0xffff9de70f772880, prev = 0xffff9de70f772880}, func =
0xffffffff880dcc00}, timer = {entry = {
        next = 0x0 <fixed_percpu_data>, pprev = 0xffff9e05bef5bc48},
expires = 4455558105, function = 0xffffffff880a1ca0, flags =
522190853}, wq = 0xffff9de700051400, cpu = 64}, avg_triggers = {next =
0xffff9de70f7728d0,
    prev = 0xffff9de70f7728d0}, avg_nr_triggers = {0, 0, 0, 0, 0, 0},
total = {{6133960836647, 5923217690044, 615328415599847,
595487964777756, 19281251983650, 12869064888360}, {6092994926,
5559819737, 105947464151, 100672353730,
      8196529519, 7678536634}}, avg = {{0, 0, 0}, {0, 0, 0}, {203596,
203716, 198499}, {203596, 203716, 198288}, {0, 0, 60}, {0, 0, 0}},
rtpoll_task = 0x0 <fixed_percpu_data>, rtpoll_timer = {entry = {next =
0xdead000000000122,
      pprev = 0x0 <fixed_percpu_data>}, expires = 4405010639, function
= 0xffffffff880dac50, flags = 67108868}, rtpoll_wait = {lock = {{rlock
= {raw_lock = {{val = {counter = 0}, {locked = 0 '\000', pending = 0
'\000'}, {
                locked_pending = 0, tail = 0}}}}}}, head = {next =
0xffff9de70f772a20, prev = 0xffff9de70f772a20}}, rtpoll_wakeup =
{counter = 0}, rtpoll_scheduled = {counter = 0}, rtpoll_trigger_lock =
{owner = {counter = 0},
    wait_lock = {raw_lock = {{val = {counter = 0}, {locked = 0 '\000',
pending = 0 '\000'}, {locked_pending = 0, tail = 0}}}}, osq = {tail =
{counter = 0}}, wait_list = {next = 0xffff9de70f772a48, prev =
0xffff9de70f772a48}},
  rtpoll_triggers = {next = 0xffff9de70f772a58, prev =
0xffff9de70f772a58}, rtpoll_nr_triggers = {0, 0, 0, 0, 0, 0},
rtpoll_states = 0, rtpoll_min_period = 18446744073709551615,
rtpoll_total = {6092994926, 5559819737, 105947464151,
    100672353730, 8196529519, 7678536634}, rtpoll_next_update =
1100738436720135, rtpoll_until = 0}

This is a summary of all psi_group_pcpu for the 32 CPU cores (on the
way, I wrote a small gdb script to dump interesting details like these
but that went nowhere):

  state_mask 0 = 0x0 tasks {0, 0, 0, 0}
  state_mask 1 = 0x0 tasks {0, 0, 0, 0}
  state_mask 2 = 0x0 tasks {0, 0, 0, 0}
  state_mask 3 = 0x0 tasks {0, 0, 0, 0}
  state_mask 4 = 0x0 tasks {0, 0, 0, 0}
  state_mask 5 = 0x0 tasks {0, 0, 0, 0}
  state_mask 6 = 0x0 tasks {0, 0, 0, 0}
  state_mask 7 = 0x0 tasks {0, 0, 0, 0}
  state_mask 8 = 0x0 tasks {0, 0, 0, 0}
  state_mask 9 = 0x0 tasks {0, 0, 0, 0}
  state_mask 10 = 0x0 tasks {0, 0, 0, 0}
  state_mask 11 = 0x0 tasks {0, 0, 0, 0}
  state_mask 12 = 0x0 tasks {0, 0, 0, 0}
  state_mask 13 = 0x0 tasks {0, 0, 0, 0}
  state_mask 14 = 0x0 tasks {0, 0, 0, 0}
  state_mask 15 = 0x0 tasks {0, 0, 0, 0}
  state_mask 16 = 0x0 tasks {0, 0, 0, 0}
  state_mask 17 = 0x0 tasks {0, 0, 0, 0}
  state_mask 18 = 0x0 tasks {0, 0, 0, 0}
  state_mask 19 = 0x0 tasks {0, 0, 0, 0}
  state_mask 20 = 0x0 tasks {0, 0, 0, 0}
  state_mask 21 = 0x0 tasks {0, 0, 0, 0}
  state_mask 22 = 0x0 tasks {0, 0, 0, 0}
  state_mask 23 = 0x0 tasks {0, 0, 0, 0}
  state_mask 24 = 0x0 tasks {0, 0, 0, 0}
  state_mask 25 = 0x0 tasks {0, 0, 0, 0}
  state_mask 26 = 0x0 tasks {0, 0, 0, 0}
  state_mask 27 = 0x0 tasks {0, 0, 0, 0}
  state_mask 28 = 0x0 tasks {0, 0, 0, 0}
  state_mask 29 = 0x0 tasks {0, 0, 0, 0}
  state_mask 30 = 0x4c tasks {0, 1, 0, 0}
  state_mask 31 = 0x0 tasks {0, 0, 0, 0}

CPU core 30 is stuck with this bogus value. state_mask 0x4c =
PSI_MEM_SOME|PSI_MEM_FULL|PSI_NONIDLE.

The memory pressure at the time of this writing:

 # cat /sys/fs/cgroup/system.slice/system-cm4all.slice/bp-spawn.scope/memory.pressure
 some avg10=99.22 avg60=99.39 avg300=97.62 total=615423620626
 full avg10=99.22 avg60=99.39 avg300=97.54 total=595583169804
 # cat /sys/fs/cgroup/system.slice/system-cm4all.slice/bp-spawn.scope/_/memory.pressure
 some avg10=0.00 avg60=0.00 avg300=0.00 total=0
 full avg10=0.00 avg60=0.00 avg300=0.00 total=0
 # cat /sys/fs/cgroup/system.slice/system-cm4all.slice/bp-spawn.scope/cgroup.stat
 nr_descendants 1
 nr_dying_descendants 2224

There is currently no worker process; there is only one idle dummy
process in a single sub-cgroup called "_", only there to keep the
systemd scope populated. It should therefore be impossible to have
memory.pressure when the only leaf cgroup has pressure=0.

(nr_dying_descendants is decremented extremely slowly; I deactivated
the server shortly before collecting these numbers, to make sure it's
really idle and there are really no processes left to cause this
pressure. I don't think nr_dying_descendants is relevant for this
problem; even after two days of full idle, the counter and the
pressure didn't go back to zero.)

Please help :-)

Max

