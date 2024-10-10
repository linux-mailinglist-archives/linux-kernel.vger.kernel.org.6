Return-Path: <linux-kernel+bounces-358867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7079984E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CDEB258D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7AD1C32E1;
	Thu, 10 Oct 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iP+8ZDg5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2041C244F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559468; cv=none; b=hqgYyIStHNBAPfNS3wuJcI8lBvPyAmCnY5yfshSAYEi6Md9wNGEneaaNU31QSB8ofavWFxq+3PrOO1DkBKSrNtDTNKXx0LBuXHRFDiXJzK4aTjmwH7M5J1LddHd+ZW3mbS+9zZ9Vb4LloX1uPqZrMvzeJ0WPGy8ICEppsfocDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559468; c=relaxed/simple;
	bh=dwloSO3zc/oQIrf41SPMH/Y+ahNgp8HN5eh51Mbhn4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fi8y59ibI0jSZ2psFGQ+ueIzk/Gz0mQMK6hGBYtMEPhTJdS/tv9krELb0HyU2e1IYUgZHZDEOOqNL3p6EAbdUdWk4orRzP6QBYMiVCbFRCz5Rgd/GplLxfiI26qXWLPaTpdHMSCKLYHRr8MhvN6MJu29UnNwx55pyQgmpL8b9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iP+8ZDg5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xWRMaq4FmXBkT0ki+hy9vdRkKTeIRV3Vbjx2gFloAZ0=;
	b=iP+8ZDg5EFSRM/WB7Tkk1oxR/HU/XqKcxRnTra6Sc8HNn73fmXWO/fSKhgkwntP5/gI5+/
	PKEGX/AhHRLQQt6FEGt3izN2aTQZqcFNqJvMPUIUDjoHZhoFud4Qx5h03oNwmfRp8IrSs3
	9VPkRj34FJ+KVXEK6F7hpq9FKZOzlaQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-hfKqQAvbM9-68yuihrAC3A-1; Thu, 10 Oct 2024 07:24:24 -0400
X-MC-Unique: hfKqQAvbM9-68yuihrAC3A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a996be26171so213220366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728559463; x=1729164263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWRMaq4FmXBkT0ki+hy9vdRkKTeIRV3Vbjx2gFloAZ0=;
        b=DPIS0LpsEGbM75cKcAogZ7o0uKO4AIIOWldLoI/c/cLVoQjpEcsJKTCAkXyoi0ddBN
         dGGgE+rUvHyK8bIr9PJzwh+uEV+HDS0KsbsI2PwgDdukGGrGgaTTNQT69B5vreZ++uX2
         mrRNmHfWcnqRAlz4dtOP81Ep/RiIrmUHiRPaE4tb+abVply+n+xznA4qlLmA1E117LDZ
         LHkKxdpVPPOMp2xqp1kaG1GpfTMY6kI9wWxf6szB524JjmeA4Jlbo6UgCVBtpPVG6eOx
         seXTC7uoReydtnl1TkC2QUUqAsluA4w/cLMjCoQ5aaufzUMZFSB4I5hgOjfTiHtM44oF
         hMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPrG7wdGC+BA6oDHaG1SqRLCCz03o7me/4fplEqKfH1BDxejZz2s1gkP+tg7ByWrY+c8ilGc17oM/Any4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSu9akH6QSGnx7ur5Tr0u5ag2m+729vi6exW5d3wd082Kr04A2
	kVPvOYjUdQ1Fmbyk3k6n6sB28iUJQJLX6OggoJFtr+8g4P6AhaXh2SxECq9aMTxAZRpBlBCPB4n
	nFaPRRB6KZRZ4GW3pUKS7NCTW6MylNHqNcErWIt73KTT3PiH+VwCTAueuFQz4gV3CdnyzoflMUZ
	Hn1iU201nHGPBm1m3AR93tyTTjupVoaKT7yv9d
X-Received: by 2002:a17:907:3f89:b0:a8a:7884:c491 with SMTP id a640c23a62f3a-a99a1109154mr249450866b.17.1728559462921;
        Thu, 10 Oct 2024 04:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkiuf/DgOS8UCjIjLoyr2Ba+uvEmY5SMvf3V2zxB0tFIiBZ5C3ebnTj0Wad8DNA3S1hujxPPCp/XNur92/DJc=
X-Received: by 2002:a17:907:3f89:b0:a8a:7884:c491 with SMTP id
 a640c23a62f3a-a99a1109154mr249448966b.17.1728559462539; Thu, 10 Oct 2024
 04:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xhsmh1q27o2us.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <cc537207-68a3-4dda-a8ec-6dda2fc1985d@paulmck-laptop> <250cde11-650f-4689-9c36-816406f1b9b8@paulmck-laptop>
 <182ef9c6-63a4-4608-98de-22ef4d35be07@paulmck-laptop> <xhsmh34m38pdl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ac93f995-09bc-4d2c-8159-6afbfbac0598@paulmck-laptop> <43d513c5-7620-481b-ab7e-30e76babbc80@paulmck-laptop>
 <xhsmhed50vplj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d6033378-d716-4848-b7a5-dcf1a6b14669@paulmck-laptop> <xhsmhbk04ugru.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <64e92332-09c7-4cae-ac63-e1701b3f3814@paulmck-laptop> <CAP4=nvTtOB+0LVPQ=nA3=XdGLhDiwLjcLAb8YmQ+YqR9L+050Q@mail.gmail.com>
In-Reply-To: <CAP4=nvTtOB+0LVPQ=nA3=XdGLhDiwLjcLAb8YmQ+YqR9L+050Q@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 10 Oct 2024 13:24:11 +0200
Message-ID: <CAP4=nvTeawTjhWR0jKNGweeQFvcTr8S=bNiLsSbaKiz=od+EOA@mail.gmail.com>
Subject: Re: [BUG almost bisected] Splat in dequeue_rt_stack() and build error
To: paulmck@kernel.org
Cc: Valentin Schneider <vschneid@redhat.com>, Chen Yu <yu.c.chen@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, 
	linux-next@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 2. 10. 2024 v 11:01 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com> na=
psal:
>
> FYI I have managed to reproduce the bug on our infrastructure after 21
> hours of 7*TREE03 and I will continue with trying to reproduce it with
> the tracers we want.
>
> Tomas

I successfully reproduced the bug also with the tracers active after a
few 8-hour test runs on our infrastructure:

[    0.000000] Linux version 6.11.0-g2004cef11ea0-dirty (...) #1 SMP
PREEMPT_DYNAMIC Wed Oct  9 12:13:40 EDT 2024
[    0.000000] Command line: debug_boot_weak_hash panic=3D-1 selinux=3D0
initcall_debug debug console=3DttyS0 rcutorture.n_barrier_cbs=3D4
rcutorture.stat_interval=3D15 rcutorture.shutdown_secs=3D25200
rcutorture.test_no_idle_hz=3D1 rcutorture.verbose=3D1
rcutorture.onoff_interval=3D200 rcutorture.onoff_holdoff=3D30
rcutree.gp_preinit_delay=3D12 rcutree.gp_init_delay=3D3
rcutree.gp_cleanup_delay=3D3 rcutree.kthread_prio=3D2 threadirqs
rcutree.use_softirq=3D0
trace_event=3Dsched:sched_switch,sched:sched_wakeup
ftrace_filter=3Ddl_server_start,dl_server_stop trace_buf_size=3D2k
ftrace=3Dfunction torture.ftrace_dump_at_shutdown=3D1
...
[13550.127541] WARNING: CPU: 1 PID: 155 at
kernel/sched/deadline.c:1971 enqueue_dl_entity+0x554/0x5d0
[13550.128982] Modules linked in:
[13550.129528] CPU: 1 UID: 0 PID: 155 Comm: rcu_torture_rea Tainted: G
       W          6.11.0-g2004cef11ea0-dirty #1
[13550.131419] Tainted: [W]=3DWARN
[13550.131979] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.3-2.el9 04/01/201=
4
[13550.133230] RIP: 0010:enqueue_dl_entity+0x554/0x5d0
...
[13550.151286] Call Trace:
[13550.151749]  <TASK>
[13550.152141]  ? __warn+0x88/0x130
[13550.152717]  ? enqueue_dl_entity+0x554/0x5d0
[13550.153485]  ? report_bug+0x18e/0x1a0
[13550.154149]  ? handle_bug+0x54/0x90
[13550.154792]  ? exc_invalid_op+0x18/0x70
[13550.155484]  ? asm_exc_invalid_op+0x1a/0x20
[13550.156249]  ? enqueue_dl_entity+0x554/0x5d0
[13550.157055]  dl_server_start+0x36/0xf0
[13550.157709]  enqueue_task_fair+0x220/0x6b0
[13550.158447]  activate_task+0x26/0x60
[13550.159131]  attach_task+0x35/0x50
[13550.159756]  sched_balance_rq+0x663/0xe00
[13550.160511]  sched_balance_newidle.constprop.0+0x1a5/0x360
[13550.161520]  pick_next_task_fair+0x2f/0x340
[13550.162290]  __schedule+0x203/0x900
[13550.162958]  ? enqueue_hrtimer+0x35/0x90
[13550.163703]  schedule+0x27/0xd0
[13550.164299]  schedule_hrtimeout_range_clock+0x99/0x120
[13550.165239]  ? __pfx_hrtimer_wakeup+0x10/0x10
[13550.165954]  torture_hrtimeout_us+0x7b/0xe0
[13550.166624]  rcu_torture_reader+0x139/0x200
[13550.167284]  ? __pfx_rcu_torture_timer+0x10/0x10
[13550.168019]  ? __pfx_rcu_torture_reader+0x10/0x10
[13550.168764]  kthread+0xd6/0x100
[13550.169262]  ? __pfx_kthread+0x10/0x10
[13550.169860]  ret_from_fork+0x34/0x50
[13550.170424]  ? __pfx_kthread+0x10/0x10
[13550.171020]  ret_from_fork_asm+0x1a/0x30
[13550.171657]  </TASK>

Unfortunately, the following rcu stalls appear to have resulted in
abnormal termination of the VM, which led to the ftrace buffer not
being dumped into the console. Currently re-running the same test with
the addition of "ftrace_dump_on_oops panic_on_warn=3D1" and hoping for
the best.

Tomas


