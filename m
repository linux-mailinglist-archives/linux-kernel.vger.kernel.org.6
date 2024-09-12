Return-Path: <linux-kernel+bounces-326655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4734B976B63
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52CF8B210B4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721E11A0BE6;
	Thu, 12 Sep 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="rt6yjlyK"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66018028
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149678; cv=none; b=GWOdEqO4v8C6Beru2FWum8gqys0hBrRMiJJBObl25f5B8ClZDQd7IeFoxwUKKMjiYoeqtc5Lb56NlXr5ujDiP8j5i+zPXwV4LJhqFjgx+N1CHE1UFGiNmEWlTkXO+kQUOj2+sn00lwRgRQwsPjuIEU+FWauzwPuQUPlh7xkZJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149678; c=relaxed/simple;
	bh=OxtDdQAwPa1mZYaULCE1jgAEURU8cGPB4sr1U5tTMSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eemGyMrfBZCoffVlwff5qH/YzPTXU3UIYgljhrC6yALbnSsFdoOXOK4nPy7n6HFxeEryl3EI7vgObwtU8NpbLkklGP4qoaUUmSlL5/8fpxV+DjV2I7I8i+XSSFs/rzEUscOOF2wx9jmAxeNueQa9ORaKrLZcPi8LoFjTnF68mQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=rt6yjlyK; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726149628; x=1726754428; i=efault@gmx.de;
	bh=0Iya3rFvOS31FyVSmVsrwsXuxpHOwt00/py5cQiIDDc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rt6yjlyKQvKdS8YCuGTVhTdVgTY+hI+E4ljSDjU6F8VSpo0EfZfJBEVbCJePA6P0
	 rrhc2qPPfQmmKlCT0wogYuACQObABUHW7esuk3sZUXx17K1L5MvDAbCuMU4XLake/
	 035Pz6zxr6uLx0gDUFptrFYIzkGgBc4HylZ0msrxfh8Ey9WXEFGIJlUukSXHvZVb7
	 Klxt18MA8y0YGpahGJ0cEMa/Zq+XC8cS5TuOzaj1SZy5gmd29Ae+fSENnVf1vj7Dr
	 7Ki8Dn72lBiCnCr3F7Hr8qXTPQPMKXne7Fl5esDtkFyum/trCJgVbg72xb3F8iqzU
	 6tc10RvyroKFi8K0/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.6]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7K3i-1swRSy0GSK-00EfiO; Thu, 12
 Sep 2024 16:00:28 +0200
Message-ID: <a96858374fb06ba38dd5eea5561cc7542220416e.camel@gmx.de>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Luis Machado <luis.machado@arm.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
 Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com,
 juri.lelli@redhat.com, rostedt@goodmis.org,  bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Thu, 12 Sep 2024 16:00:25 +0200
In-Reply-To: <2030b198180259eede6384cc6a6bc9bc9f64f874.camel@gmx.de>
References: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
	 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
	 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
	 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
	 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
	 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
	 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
	 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
	 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
	 <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>
	 <20240911091328.GM4723@noisy.programming.kicks-ass.net>
	 <2030b198180259eede6384cc6a6bc9bc9f64f874.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1K290jvP65IYvL1JtOTguLUktMIRIWVNSNmVt+3ouGcaYrM0C9z
 F6eyGrhoE6i7VRYOfMIkxR5mNQcd3KoYr/ctyuNACGIc387Rnr1Lh+Hzo2cYWwfUu8+IGkZ
 FE94PMll1XGLMn3li0ucMK8TrMKCRsfbr2sQfqocUPFSYBxhDfBszJrydBJaYGntYzemG/j
 3b1UkvAJSfQTX3DUdByPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DqjGzs8Nd28=;/8Rvfdd+/+um0GuaW5+8WH9QnII
 Xq7/h0e6SJ0SlGP1LNxradj6uOaLorHm0aI0pAQL4OA30/LpeFVCeTlGsfec3OYmk8bYrrBvX
 Xuex5O7HJjDfTFuSNGkC9fhl7cJcRQMQaZ+xqEuXX1CmNSRJNcMelZ9h3sr6cMg/jnRZm7Pt5
 iVOK9vFhn3edefonO6wkpL9G049zIkEF6Zd+U01THr0uzfp9Y8f/805IsCrOV8Edm8XDwiPWA
 0aljsDluNbhguc3/XgFZd6OQ8Ko7Rn3nvaGoZkgapIWx6p6cFLj1+TPQx1pHILDY9QiFT78vM
 32QlGIbJ9tCFGtyvXNkzuDsRv0ZOz+0PgPILYdtjT2OCS9XOMQo+MqqMZ5lgpA2GmXzCJch/z
 OIg0Pk3M1j9h48lly3tjOQiZCGsSCBEfWMbos3N21f984depeN+8JjNEMZ+1iK5LI/hoXgTdy
 zu80IHK8DN6WcjDsm8VDo6YJ3uh4AkglTrekgcgjCP9R7nXj54yfZ8yaiuIbYq/pYV5OPaWfA
 eAE0s2MmyJoEtPNSVS3rCcWMxD6AwtDVfyrOp/Pu4B88QLG5isFXLw+rzV6KfJJ52NcKx7Xpp
 ViGeAxrA2AeMHieTfp//U9PtcKd6+QUNW6gL9OHw1wwxB4b3oboxor3a4Ak96dHs4FM2Pec55
 C3XTMapGgV86GkPjZHhuZ8K5nDkdMvEa051byQxB04Ymp8WktjaP0wevuFiTARG2yalS8V1PE
 /kOwr9Y/VK51LuiwEvuySB69M9VlSZ3c5B77kS/4yWmHoJmingpHrA4S0qMoU4/+ElLyV6vVb
 r/0hkepvI6ZCLu56MgRvXFMw==

On Wed, 2024-09-11 at 11:27 +0200, Mike Galbraith wrote:
> On Wed, 2024-09-11 at 11:13 +0200, Peter Zijlstra wrote:
> > On Wed, Sep 11, 2024 at 11:10:26AM +0200, Mike Galbraith wrote:
> > >
> > > Hm, would be interesting to know how the heck he's triggering that.
> > >
> > > My x86_64 box refuses to produce any such artifacts with anything I'=
ve
> > > tossed at it, including full LTP with enterprise RT and !RT configs,
> > > both in master and my local SLE15-SP7 branch.=C2=A0 Hohum.
> >
> > Yeah, my hackbench runs also didn't show that. Perhaps something funny
> > with cgroups. I didn't test cgroup bandwidth for exanple.
>
> That's all on in enterprise configs tested with LTP, so hypothetically
> got some testing.=C2=A0 I also turned on AUTOGROUP in !RT configs so cgr=
oups
> would get some exercise no matter what I'm mucking about with.

Oho, I just hit a pick_eevdf() returns NULL in pick_next_entity() and
we deref it bug in tip that I recall having seen someone else mention
them having hit.  LTP was chugging away doing lord knows what when
evolution apparently decided to check accounts, which didn't go well.

state=3DTASK_WAKING(?), on_rq=3D0, on_cpu=3D1, cfs_rq.nr_running=3D0

crash> bt -sx
PID: 29024    TASK: ffff9118b7583300  CPU: 1    COMMAND: "pool-evolution"
 #0 [ffffa939dfd0f930] machine_kexec+0x1a0 at ffffffffab886cc0
 #1 [ffffa939dfd0f990] __crash_kexec+0x6a at ffffffffab99496a
 #2 [ffffa939dfd0fa50] crash_kexec+0x23 at ffffffffab994e33
 #3 [ffffa939dfd0fa60] oops_end+0xbe at ffffffffab844b4e
 #4 [ffffa939dfd0fa80] page_fault_oops+0x151 at ffffffffab898fc1
 #5 [ffffa939dfd0fb08] exc_page_fault+0x6b at ffffffffac3a410b
 #6 [ffffa939dfd0fb30] asm_exc_page_fault+0x22 at ffffffffac400ac2
    [exception RIP: pick_task_fair+113]
    RIP: ffffffffab8fb471  RSP: ffffa939dfd0fbe0  RFLAGS: 00010046
    RAX: 0000000000000000  RBX: ffff91180735ee00  RCX: 000b709eab0437d5
    RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff91180735ee00
    RBP: ffff91180735f400   R8: 00000000000001d9   R9: 0000000000000000
    R10: ffff911a8ecb9380  R11: 0000000000000000  R12: ffff911a8eab89c0
    R13: ffff911a8eab8a40  R14: ffffffffacafc373  R15: ffff9118b7583300
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffffa939dfd0fc08] pick_next_task_fair+0x48 at ffffffffab9013b8
 #8 [ffffa939dfd0fc48] __schedule+0x1d9 at ffffffffac3aab39
 #9 [ffffa939dfd0fcf8] schedule+0x24 at ffffffffac3ac084
#10 [ffffa939dfd0fd10] futex_wait_queue+0x63 at ffffffffab98e353
#11 [ffffa939dfd0fd38] __futex_wait+0x139 at ffffffffab98e989
#12 [ffffa939dfd0fdf0] futex_wait+0x6a at ffffffffab98ea5a
#13 [ffffa939dfd0fe80] do_futex+0x88 at ffffffffab98a9f8
#14 [ffffa939dfd0fe90] __x64_sys_futex+0x5e at ffffffffab98ab0e
#15 [ffffa939dfd0ff00] do_syscall_64+0x74 at ffffffffac39ce44
#16 [ffffa939dfd0ff40] entry_SYSCALL_64_after_hwframe+0x4b at ffffffffac40=
00ac
    RIP: 00007fd6b991a849  RSP: 00007fd6813ff6e8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000000000a6c  RCX: 00007fd6b991a849
    RDX: 0000000000000a6c  RSI: 0000000000000080  RDI: 00005631abf620c0
    RBP: 00005631abf620b8   R8: 00007fd6bad0a080   R9: 00000000000015fe
    R10: 00007fd6813ff700  R11: 0000000000000246  R12: 00005631abf620b0
    R13: 00005631abf620b0  R14: 00005631abf620b8  R15: 0000000000000000
    ORIG_RAX: 00000000000000ca  CS: 0033  SS: 002b
crash> dis pick_task_fair+113
0xffffffffab8fb471 <pick_task_fair+113>:        cmpb   $0x0,0x51(%rax)
crash> gdb list *pick_task_fair+113
0xffffffffab8fb471 is in pick_task_fair (kernel/sched/fair.c:5639).
5634			SCHED_WARN_ON(cfs_rq->next->sched_delayed);
5635			return cfs_rq->next;
5636		}
5637
5638		struct sched_entity *se =3D pick_eevdf(cfs_rq);
5639		if (se->sched_delayed) {
5640			dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
5641			SCHED_WARN_ON(se->sched_delayed);
5642			SCHED_WARN_ON(se->on_rq);
5643			return NULL;
crash> task_struct -x 0xffff9118b7583300 | grep "__state =3D"
  __state =3D 0x200,
crash> task_struct -x 0xffff9118b7583300 | grep rq
  on_rq =3D 0x0,
    on_rq =3D 0x0,
    cfs_rq =3D 0xffff9117e81a3e00,
    on_rq =3D 0x0,
    rq =3D 0x0,
crash> task_struct -xo | grep sched_entity
    [0x80] struct sched_entity se
crash> sched_entity 0xffff9118b7583380
struct sched_entity {
  load =3D {
    weight =3D 1048576,
    inv_weight =3D 4194304
  },
  run_node =3D {
    __rb_parent_color =3D 1,
    rb_right =3D 0x0,
    rb_left =3D 0x0
  },
  deadline =3D 5788784166,
  min_vruntime =3D 5785784166,
  min_slice =3D 3000000,
  group_node =3D {
    next =3D 0xffff9118b75833c0,
    prev =3D 0xffff9118b75833c0
  },
  on_rq =3D 0 '\000',
  sched_delayed =3D 0 '\000',
  rel_deadline =3D 0 '\000',
  custom_slice =3D 0 '\000',
  exec_start =3D 5630407844294,
  sum_exec_runtime =3D 5031478,
  prev_sum_exec_runtime =3D 5004139,
  vruntime =3D 5785811505,
  vlag =3D 0,
  slice =3D 3000000,
  nr_migrations =3D 0,
  depth =3D 1,
  parent =3D 0xffff9117e81a0600,
  cfs_rq =3D 0xffff9117e81a3e00,
  my_q =3D 0x0,
  runnable_weight =3D 0,
  avg =3D {
    last_update_time =3D 5630386353152,
    load_sum =3D 2555,
    runnable_sum =3D 2617274,
    util_sum =3D 83342,
    period_contrib =3D 877,
    load_avg =3D 39,
    runnable_avg =3D 39,
    util_avg =3D 1,
    util_est =3D 2147483760
  }
}
crash> cfs_rq 0xffff9117e81a3e00
struct cfs_rq {
  load =3D {
    weight =3D 0,
    inv_weight =3D 0
  },
  nr_running =3D 0,
  h_nr_running =3D 0,
  idle_nr_running =3D 0,
  idle_h_nr_running =3D 0,
  h_nr_delayed =3D 0,
  avg_vruntime =3D 0,
  avg_load =3D 0,
  min_vruntime =3D 5785811505,
  forceidle_seq =3D 0,
  min_vruntime_fi =3D 0,
  tasks_timeline =3D {
    rb_root =3D {
      rb_node =3D 0x0
    },
    rb_leftmost =3D 0x0
  },
  curr =3D 0xffff9118b7583380,
  next =3D 0x0,
  avg =3D {
    last_update_time =3D 5630386353152,
    load_sum =3D 2617381,
    runnable_sum =3D 2617379,
    util_sum =3D 83417,
    period_contrib =3D 877,
    load_avg =3D 39,
    runnable_avg =3D 39,
    util_avg =3D 1,
    util_est =3D 0
  },
  removed =3D {
    lock =3D {
      raw_lock =3D {
        {
          val =3D {
            counter =3D 0
          },
          {
            locked =3D 0 '\000',
            pending =3D 0 '\000'
          },
          {
            locked_pending =3D 0,
            tail =3D 0
          }
        }
      }
    },
    nr =3D 0,
    load_avg =3D 0,
    util_avg =3D 0,
    runnable_avg =3D 0
  },
  last_update_tg_load_avg =3D 5630407057919,
  tg_load_avg_contrib =3D 39,
  propagate =3D 0,
  prop_runnable_sum =3D 0,
  h_load =3D 0,
  last_h_load_update =3D 4296299815,
  h_load_next =3D 0x0,
  rq =3D 0xffff911a8eab89c0,
  on_list =3D 1,
  leaf_cfs_rq_list =3D {
    next =3D 0xffff911794a2d348,
    prev =3D 0xffff9119ebe62148
  },
  tg =3D 0xffff91178434a080,
  idle =3D 0,
  runtime_enabled =3D 0,
  runtime_remaining =3D 0,
  throttled_pelt_idle =3D 0,
  throttled_clock =3D 0,
  throttled_clock_pelt =3D 0,
  throttled_clock_pelt_time =3D 0,
  throttled_clock_self =3D 0,
  throttled_clock_self_time =3D 0,
  throttled =3D 0,
  throttle_count =3D 0,
  throttled_list =3D {
    next =3D 0xffff9117e81a3fa8,
    prev =3D 0xffff9117e81a3fa8
  },
  throttled_csd_list =3D {
    next =3D 0xffff9117e81a3fb8,
    prev =3D 0xffff9117e81a3fb8
  }
}
crash>


