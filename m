Return-Path: <linux-kernel+bounces-367699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A19A058A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851642871C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CF0205E35;
	Wed, 16 Oct 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="d7Xb7Dli"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288C205E18;
	Wed, 16 Oct 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070931; cv=none; b=kJhj+AxtI8RkRjPb1PQV8fFop5lrQn2jy/OJMER6dyjtFlGSRiv/PtIE4y9bFGsYSWrRt530xcgf2JYVBFAcZcRQrWgSTEnYgHsG+dkCedmAvhXIpYY7sInl8g+PjhuHLOubypWaSNtsGbkJ6GZ8Eex+/MhhHGZK4M/DyLYeDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070931; c=relaxed/simple;
	bh=O1kWFCZVu4cIck+41kxW1UnJbhZsamVbVsoXsyy6tyQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leO1meIBl/21HnJ8kVxYJzMLAH3pzmxIsXqvyg0LljEfARlGuanR3CeO/brQGNAVIRc+qZmKmbCi4TzUWLDPffg4W9ePn3DtDbwWcJZ4wiQSV4viHDQQBNoR6Y7uinbsLdz9UjSby+74ujTerILTGYV60BJaG4U7OHtK+9s39eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=d7Xb7Dli; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G98hLn024826;
	Wed, 16 Oct 2024 02:28:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=qvJeG+3puWZNOw4EoVKASrFiQ
	Vr/41GLUz8ZTzD/8io=; b=d7Xb7DliKRNlvAGL8HXdfp5mHBb/py63z4EomHzM3
	bj67uvqLbZc8RvHsUHVCK1C8hJWY1Y1TLXZaa76Efl/LlKiEfPqRbVPoZnTJbj32
	nGgRZzvZfKTdQsTOJiIRTRvpMdUChcbjhKUBlsL/5wS96jot10Am5lYvjHKy7vIA
	SSuA5Y8Te7gHQD7tgOP1rLpH8UCygfnqVM7t5g3/gW9OTVTzZ5FYYwpRMDZC6F5z
	ne3yEm9zu/kVAqPhrN8xbG8asjMVcAt1MIOA+ry6DVUJT1ZEDR/raIrF/eD7qX7L
	T398MXa2dwQTbxl/tWVEJIfOUNRtgTnf9ZN0unsx/sGfQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42aaker1g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 02:28:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 02:28:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 02:28:35 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 09D4D5B696D;
	Wed, 16 Oct 2024 02:28:30 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:58:29 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
CC: <mike.leach@linaro.org>, <james.clark@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>
Subject: Re: [PATCH v10 8/8] Documentation: coresight: Panic support
Message-ID: <20241016092829.GA896339@hyd1403.caveonetworks.com>
References: <20240916103437.226816-1-lcherian@marvell.com>
 <20240916103437.226816-9-lcherian@marvell.com>
 <2ca82e7c-a7b1-4027-9773-416ed7200cf8@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ca82e7c-a7b1-4027-9773-416ed7200cf8@arm.com>
X-Proofpoint-GUID: WzjDFLvD0X9cohbJY0uqwppvCo8mOPa9
X-Proofpoint-ORIG-GUID: WzjDFLvD0X9cohbJY0uqwppvCo8mOPa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

On 2024-10-03 at 19:13:10, Suzuki K Poulose (suzuki.poulose@arm.com) wrote:
> Hi Linu
> 
> On 16/09/2024 11:34, Linu Cherian wrote:
> > Add documentation on using coresight during panic
> > and watchdog.
> 
> Thank you so much for the documentation, this will be quite useful !
> 
> Some minor comments below.
> 
> > 
> > Signed-off-by: Linu Cherian <lcherian@marvell.com>
> > ---
> > Changelog from v9:
> > This patch has been newly introduced.
> > 
> >   Documentation/trace/coresight/panic.rst | 356 ++++++++++++++++++++++++
> >   1 file changed, 356 insertions(+)
> >   create mode 100644 Documentation/trace/coresight/panic.rst
> > 
> > diff --git a/Documentation/trace/coresight/panic.rst b/Documentation/trace/coresight/panic.rst
> > new file mode 100644
> > index 000000000000..3b53d91cace8
> > --- /dev/null
> > +++ b/Documentation/trace/coresight/panic.rst
> > @@ -0,0 +1,356 @@
> > +===================================================
> > +Using Coresight for Kernel panic and Watchdog reset
> > +===================================================
> > +
> > +Introduction
> > +------------
> > +This documentation is about using Linux coresight trace support to
> > +debug kernel panic and watchdog reset scenarios.
> > +
> > +Coresight trace during Kernel panic
> > +-----------------------------------
> > +From the coresight driver point of view, addressing the kernel panic
> > +situation has four main requirements.
> > +
> > +a. Support for allocation of trace buffer pages from reserved memory area.
> > +   Platform can advertise this using a new device tree property added to
> > +   relevant coresight nodes.
> > +
> > +b. Support for stopping coresight blocks at the time of panic
> > +
> > +c. Saving required metadata in the specified format
> > +
> > +d. Support for reading trace data captured at the time of panic
> > +
> > +Allocation of trace buffer pages from reserved RAM
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +A new optional device tree property "memory-region" is added to the
> > +ETR/ETF device nodes, that would give the base address and size of trace
> 
> ETR/ETF => CoreSight TMC

Ack.

> 
> > +buffer.
> > +
> > +Static allocation of trace buffers would ensure that both IOMMU enabled
> > +and disabled cases are handled. Also, platforms that support persistent
> > +RAM will allow users to read trace data in the subsequent boot without
> > +booting the crashdump kernel.
> > +
> > +Note:
> > +For ETR sink devices, this reserved region will be used for both trace
> > +capture and trace data retrieval.
> > +For ETF sink devices, internal SRAM would be used for trace capture,
> > +and they would be synced to reserved region for retrieval.
> > +
> > +
> > +Disabling coresight blocks at the time of panic
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +In order to avoid the situation of losing relevant trace data after a
> > +kernel panic, it would be desirable to stop the coresight blocks at the
> > +time of panic.
> > +
> > +This can be achieved by configuring the comparator, CTI and sink
> > +devices as below::
> > +
> > +           Trigger on panic
> > +    Comparator --->External out --->CTI -->External In---->ETR/ETF stop
> > +
> > +Saving metadata at the time of kernel panic
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +Coresight metadata involves all additional data that are required for a
> > +successful trace decode in addition to the trace data. This involves
> > +ETR/ETF, ETE register snapshot etc.
> 
> s/ETE/ETB ?

Ack.

> 
> > +
> > +A new optional device property "memory-region" is added to
> > +the ETR/ETF/ETE device nodes for this.
> 
> same here ^^

Ack.

> 
> 
> > +
> > +Reading trace data captured at the time of panic
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +Trace data captured at the time of panic, can be read from rebooted kernel
> > +or from crashdump kernel using a special device file /dev/crash_tmc_xxx.
> > +This device file is created only when there is a valid crashdata available.
> > +
> > +General flow of trace capture and decode incase of kernel panic
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +1. Enable source and sink on all the cores using the sysfs interface.
> > +   ETR sinks should have trace buffers allocated from reserved memory,
> > +   by selecting "resrv" buffer mode from sysfs.
> > +
> > +2. Run relevant tests.
> > +
> > +3. On a kernel panic, all coresight blocks are disabled, necessary
> > +   metadata is synced by kernel panic handler.
> > +
> > +   System would eventually reboot or boot a crashdump kernel.
> > +
> > +4. For  platforms that supports crashdump kernel, raw trace data can be
> > +   dumped using the coresight sysfs interface from the crashdump kernel
> > +   itself. Persistent RAM is not a requirement in this case.
> > +
> > +5. For platforms that supports persistent RAM, trace data can be dumped
> > +   using the coresight sysfs interface in the subsequent Linux boot.
> > +   Crashdump kernel is not a requirement in this case. Persistent RAM
> > +   ensures that trace data is intact across reboot.
> > +
> > +Coresight trace during Watchdog reset
> > +-------------------------------------
> > +The main difference between addressing the watchdog reset and kernel panic
> > +case are below,
> > +
> > +a. Saving coresight metadata need to be taken care by the
> > +   SCP(system control processor) firmware in the specified format,
> > +   instead of kernel.
> > +
> > +b. Reserved memory region given by firmware for trace buffer and metadata
> > +   has to be in persistent RAM.
> > +   Note: This is a requirement for watchdog reset case but optional
> > +   in kernel panic case.
> > +
> > +Watchdog reset can be supported only on platforms that meet the above
> > +two requirements.
> > +
> > +Sample commands for testing a Kernel panic case with ETR sink
> > +-------------------------------------------------------------
> > +
> > +1. Boot Linux kernel with "crash_kexec_post_notifiers" added to the kernel
> > +   bootargs. This is mandatory if the user would like to read the tracedata
> > +   from the crashdump kernel.
> > +
> > +2. Enable the preloaded ETM configuration
> > +
> > +    #echo 1 > /sys/kernel/config/cs-syscfg/configurations/panicstop/enable
> > +
> > +3. Configure CTI using sysfs interface::
> > +
> > +    #./cti_setup.sh
> > +
> > +    #cat cti_setup.sh
> > +
> > +
> > +    cd /sys/bus/coresight/devices/
> > +
> > +    ap_cti_config () {
> > +      #ETM trig out[0] trigger to Channel 0
> > +      echo 0 4 > channels/trigin_attach
> > +    }
> > +
> > +    etf_cti_config () {
> > +      #ETF Flush in trigger from Channel 0
> > +      echo 0 1 > channels/trigout_attach
> > +      echo 1 > channels/trig_filter_enable
> > +    }
> > +
> > +    etr_cti_config () {
> > +      #ETR Flush in from Channel 0
> > +      echo 0 1 > channels/trigout_attach
> > +      echo 1 > channels/trig_filter_enable
> > +    }
> > +
> > +    ctidevs=`find . -name "cti*"`
> > +
> > +    for i in $ctidevs
> > +    do
> > +            cd $i
> > +
> > +            connection=`find . -name "ete*"`
> 
> minor nit: this could be ete or etm

Ack.

> 
> > +            if [ ! -z "$connection" ]
> > +            then
> > +                    echo "AP CTI config for $i"
> > +                    ap_cti_config
> > +            fi
> > +
> > +            connection=`find . -name "tmc_etf*"`
> > +            if [ ! -z "$connection" ]
> > +            then
> > +                    echo "ETF CTI config for $i"
> > +                    etf_cti_config
> > +            fi
> > +
> > +            connection=`find . -name "tmc_etr*"`
> > +            if [ ! -z "$connection" ]
> > +            then
> > +                    echo "ETR CTI config for $i"
> > +                    etr_cti_config
> > +            fi
> > +
> > +            cd ..
> > +    done
> > +
> > +Note: CTI connections are SOC specific and hence the above script is
> > +added just for reference.
> > +
> > +4. Choose reserved buffer mode for ETR buffer
> > +    #echo "resrv" > /sys/bus/coresight/devices/tmc_etr0/buf_mode_preferred
> > +
> > +5. Enable stop on flush trigger configuration
> > +    #echo 1 > /sys/bus/coresight/devices/tmc_etr0/stop_on_flush
> > +
> > +6. Start Coresight tracing on cores 1 and 2 using sysfs interface
> > +
> > +7. Run some application on core 1
> > +    #taskset -c 1 dd if=/dev/urandom of=/dev/null &
> > +
> > +8. Invoke kernel panic on core 2
> > +    #echo 1 > /proc/sys/kernel/panic
> > +    #taskset -c 2 echo c > /proc/sysrq-trigger
> > +
> > +9. From rebooted kernel or crashdump kernel, read crashdata
> > +
> > +    #dd if=/dev/crash_tmc_etr0 of=/trace/cstrace.bin
> > +
> > +10. Run opencsd decoder tools/scripts to generate the instruction trace.
> > +
> > +Sample instruction trace dump
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Core1 dump::
> > +
> > +    A                                  etm4_enable_hw: ffff800008ae1dd4
> > +    CONTEXT EL2                        etm4_enable_hw: ffff800008ae1dd4
> > +    I                                  etm4_enable_hw: ffff800008ae1dd4:
> > +    d503201f   nop
> > +    I                                  etm4_enable_hw: ffff800008ae1dd8:
> > +    d503201f   nop
> > +    I                                  etm4_enable_hw: ffff800008ae1ddc:
> > +    d503201f   nop
> > +    I                                  etm4_enable_hw: ffff800008ae1de0:
> > +    d503201f   nop
> > +    I                                  etm4_enable_hw: ffff800008ae1de4:
> > +    d503201f   nop
> > +    I                                  etm4_enable_hw: ffff800008ae1de8:
> > +    d503233f   paciasp
> > +    I                                  etm4_enable_hw: ffff800008ae1dec:
> > +    a9be7bfd   stp     x29, x30, [sp, #-32]!
> > +    I                                  etm4_enable_hw: ffff800008ae1df0:
> > +    910003fd   mov     x29, sp
> > +    I                                  etm4_enable_hw: ffff800008ae1df4:
> > +    a90153f3   stp     x19, x20, [sp, #16]
> > +    I                                  etm4_enable_hw: ffff800008ae1df8:
> > +    2a0003f4   mov     w20, w0
> > +    I                                  etm4_enable_hw: ffff800008ae1dfc:
> > +    900085b3   adrp    x19, ffff800009b95000 <reserved_mem+0xc48>
> > +    I                                  etm4_enable_hw: ffff800008ae1e00:
> > +    910f4273   add     x19, x19, #0x3d0
> > +    I                                  etm4_enable_hw: ffff800008ae1e04:
> > +    f8747a60   ldr     x0, [x19, x20, lsl #3]
> > +    E                                  etm4_enable_hw: ffff800008ae1e08:
> > +    b4000140   cbz     x0, ffff800008ae1e30 <etm4_starting_cpu+0x50>
> > +    I    149.039572921                 etm4_enable_hw: ffff800008ae1e30:
> > +    a94153f3   ldp     x19, x20, [sp, #16]
> > +    I    149.039572921                 etm4_enable_hw: ffff800008ae1e34:
> > +    52800000   mov     w0, #0x0                        // #0
> > +    I    149.039572921                 etm4_enable_hw: ffff800008ae1e38:
> > +    a8c27bfd   ldp     x29, x30, [sp], #32
> > +
> > +    ..snip
> > +
> > +        149.052324811           chacha_block_generic: ffff800008642d80:
> > +    9100a3e0   add     x0,
> > +    I    149.052324811           chacha_block_generic: ffff800008642d84:
> > +    b86178a2   ldr     w2, [x5, x1, lsl #2]
> > +    I    149.052324811           chacha_block_generic: ffff800008642d88:
> > +    8b010803   add     x3, x0, x1, lsl #2
> > +    I    149.052324811           chacha_block_generic: ffff800008642d8c:
> > +    b85fc063   ldur    w3, [x3, #-4]
> > +    I    149.052324811           chacha_block_generic: ffff800008642d90:
> > +    0b030042   add     w2, w2, w3
> > +    I    149.052324811           chacha_block_generic: ffff800008642d94:
> > +    b8217882   str     w2, [x4, x1, lsl #2]
> > +    I    149.052324811           chacha_block_generic: ffff800008642d98:
> > +    91000421   add     x1, x1, #0x1
> > +    I    149.052324811           chacha_block_generic: ffff800008642d9c:
> > +    f100443f   cmp     x1, #0x11
> > +
> > +
> > +Core 2 dump::
> > +
> > +    A                                  etm4_enable_hw: ffff800008ae1dd4
> > +    CONTEXT EL2                        etm4_enable_hw: ffff800008ae1dd4
> > +    I                                  etm4_enable_hw: ffff800008ae1dd4:
> > +    d503201f   nop
> > +    I                                  etm4_enable_hw: ffff800008ae1dd8:
> > +    d503201f   nop
> > +    I                                  etm4_enable_hw: ffff800008ae1ddc:
> > +    d503201f   nop
> > +    I                                  etm4_enable_hw: ffff800008ae1de0:
> > +    d503201f   nop
> > +    I                                  etm4_enable_hw: ffff800008ae1de4:
> > +    d503201f   nop
> > +    I                                  etm4_enable_hw: ffff800008ae1de8:
> > +    d503233f   paciasp
> > +    I                                  etm4_enable_hw: ffff800008ae1dec:
> > +    a9be7bfd   stp     x29, x30, [sp, #-32]!
> > +    I                                  etm4_enable_hw: ffff800008ae1df0:
> > +    910003fd   mov     x29, sp
> > +    I                                  etm4_enable_hw: ffff800008ae1df4:
> > +    a90153f3   stp     x19, x20, [sp, #16]
> > +    I                                  etm4_enable_hw: ffff800008ae1df8:
> > +    2a0003f4   mov     w20, w0
> > +    I                                  etm4_enable_hw: ffff800008ae1dfc:
> > +    900085b3   adrp    x19, ffff800009b95000 <reserved_mem+0xc48>
> > +    I                                  etm4_enable_hw: ffff800008ae1e00:
> > +    910f4273   add     x19, x19, #0x3d0
> > +    I                                  etm4_enable_hw: ffff800008ae1e04:
> > +    f8747a60   ldr     x0, [x19, x20, lsl #3]
> > +    E                                  etm4_enable_hw: ffff800008ae1e08:
> > +    b4000140   cbz     x0, ffff800008ae1e30 <etm4_starting_cpu+0x50>
> > +    I    149.046243445                 etm4_enable_hw: ffff800008ae1e30:
> > +    a94153f3   ldp     x19, x20, [sp, #16]
> > +    I    149.046243445                 etm4_enable_hw: ffff800008ae1e34:
> > +    52800000   mov     w0, #0x0                        // #0
> > +    I    149.046243445                 etm4_enable_hw: ffff800008ae1e38:
> > +    a8c27bfd   ldp     x29, x30, [sp], #32
> > +    I    149.046243445                 etm4_enable_hw: ffff800008ae1e3c:
> > +    d50323bf   autiasp
> > +    E    149.046243445                 etm4_enable_hw: ffff800008ae1e40:
> > +    d65f03c0   ret
> > +    A                                ete_sysreg_write: ffff800008adfa18
> > +
> > +    ..snip
> > +
> > +    I     149.05422547                          panic: ffff800008096300:
> > +    a90363f7   stp     x23, x24, [sp, #48]
> > +    I     149.05422547                          panic: ffff800008096304:
> > +    6b00003f   cmp     w1, w0
> > +    I     149.05422547                          panic: ffff800008096308:
> > +    3a411804   ccmn    w0, #0x1, #0x4, ne  // ne = any
> > +    N     149.05422547                          panic: ffff80000809630c:
> > +    540001e0   b.eq    ffff800008096348 <panic+0xe0>  // b.none
> > +    I     149.05422547                          panic: ffff800008096310:
> > +    f90023f9   str     x25, [sp, #64]
> > +    E     149.05422547                          panic: ffff800008096314:
> > +    97fe44ef   bl      ffff8000080276d0 <panic_smp_self_stop>
> > +    A                                           panic: ffff80000809634c
> > +    I     149.05422547                          panic: ffff80000809634c:
> > +    910102d5   add     x21, x22, #0x40
> > +    I     149.05422547                          panic: ffff800008096350:
> > +    52800020   mov     w0, #0x1                        // #1
> > +    E     149.05422547                          panic: ffff800008096354:
> > +    94166b8b   bl      ffff800008631180 <bust_spinlocks>
> > +    N    149.054225518                 bust_spinlocks: ffff800008631180:
> > +    340000c0   cbz     w0, ffff800008631198 <bust_spinlocks+0x18>
> > +    I    149.054225518                 bust_spinlocks: ffff800008631184:
> > +    f000a321   adrp    x1, ffff800009a98000 <pbufs.0+0xbb8>
> > +    I    149.054225518                 bust_spinlocks: ffff800008631188:
> > +    b9405c20   ldr     w0, [x1, #92]
> > +    I    149.054225518                 bust_spinlocks: ffff80000863118c:
> > +    11000400   add     w0, w0, #0x1
> > +    I    149.054225518                 bust_spinlocks: ffff800008631190:
> > +    b9005c20   str     w0, [x1, #92]
> > +    E    149.054225518                 bust_spinlocks: ffff800008631194:
> > +    d65f03c0   ret
> > +    A                                           panic: ffff800008096358
> > +
> > +Perf based testing
> > +------------------
> > +
> > +Starting perf session
> > +~~~~~~~~~~~~~~~~~~~~~
> > +ETF:
> > +perf record -e cs_etm/panicstop,@tmc_etf1/ -C 1
> > +perf record -e cs_etm/panicstop,@tmc_etf2/ -C 2
> > +
> > +ETR:
> > +perf record -e cs_etm/panicstop,@tmc_etr0/ -C 1,2
> > +
> > +Reading trace data after panic
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +Same sysfs based method explained above can be used to retrieve and
> > +decode the trace data after the reboot on kernel panic.
> 
> 


Linu Cherian


