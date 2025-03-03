Return-Path: <linux-kernel+bounces-541343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754E0A4BBBF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E491F3AA685
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89F1F153C;
	Mon,  3 Mar 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o03s5EIn"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DEA1DFD95
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996866; cv=none; b=ibiC58MI6qyGRpD1hGcQV8CJIruvLMIaye3kWknahAwIburAcQoYC9pCIlZ0ec3axYj73d0L4qDRPDMPBy3lXpQtlal/UWXhLlicgcXdoh84/+6KSUtQk2D/iorqtKkjr9bNfX9uOc1A2UyTJuKpDGonFwsKpTEwHEPdywjkRxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996866; c=relaxed/simple;
	bh=G9/uBg00EU1Tmmudo57eJcpVmJYglzFxYsrxNZqg2Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJ0w5AH9gvZAQuuzQgOzWS/hZXs0BnzMPpfo4NT3Ur+DsS86CidrKzzzvpDR43bXycZqUGqdHOuyuwpsjlwI4ICLT1rGCBy1w1DzROHaU4s5V53DZQ15Opb5dNBnQjKGnEpY8bK0NAIsTmuGe5EfRcdrOalvK/WfogGyETd9PI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o03s5EIn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf5358984bso269834066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740996862; x=1741601662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55m0k1ECPOk2V9hGVGAuPJ09oAemXnzHA5pb7QwYfNY=;
        b=o03s5EInCRcewlIhfkgIHdSEYB9+nCw8+Jg0ROGm69ky/2sS7f1lgW5pWlFQg0ViPn
         u5ss/XnFZTtBPkHn2U8G9FhYr2jgEaasFiNEuQng9FWqucFN71YR1CDPqywijoXCHLVH
         q/N3FteIdQTOJAAb5k4pDHaRFw8qSkGAXc025YdZB05Vp2lWD+1nURhaDGaihrFrP+RS
         wAP/UcHu1urjNSMSHpHrKFI//TvSx2VxMTEOs5//m7tIngT5Ji0yCDRkGiwRpEDt/DSB
         eXJwnUwAZDF/sXJkdNNGD/sPRnZbL8zovdR0J8J/b3jTFKlMojmPMD3g22igUsQm2gP+
         in8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996862; x=1741601662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55m0k1ECPOk2V9hGVGAuPJ09oAemXnzHA5pb7QwYfNY=;
        b=mLOqNvTy9QIjglmbrnZw2qX2vwc86O36yhrVHb44aHLeVrnfsGeJhNlOLDP0sKHZyn
         bsI+ho4sTNp/t96a9F5bKLtr778a/C6stCMkupYYHzAEvpkAdnarKf7Mm51rcLtoogVr
         3zQPN9o9ZKrB5ZLMWKI49iSPNaK7dhRGWMb3VWjIU6q2lxf/ee3Z6po1t+NLwnDVUTQm
         NDCxhaR0ASZR+oj58Wt7vZeuEQk8s+4lNzz6HkFgeWG27PZsrdrmiGvtjO+7UpLggk1e
         goJh60qBaDlcBou2Xel/e+RBSjwBGLeFVQrSgpItNWeitPGFcI/4vJNYwhYgP7ZR76lg
         ZkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG2qaO8Ky0KVOgeUtHbuFwIJ3wCeOwFZwU3bzr8QEf28QJm+JRxtoM6cH/5IxunTHPLZbHFq/Vof+gilg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fKOTrSwtFanSLsSmXYelfRvVXfVIaBVMNro1dTQ6GrmBkYEj
	uYGgvW4najH53YHg1V82HPM6P27butu/8idqYGLvbLAFkObQFipPP3tqZT+lmIfz2zDPNTn9PPi
	ujeczw6ZFgQ8T21WRGXmS/RVGC4L49OBEyCc5
X-Gm-Gg: ASbGncsr/qbLZmDEc5TU2CN0pHt2RIK0KelKkhOfqXKOVisDAcW0FeDwCftg1Jeg7OS
	VmF3RHRfLpbFMphJGGDll50RhWoMrPvg1hFLWDPkozABQl+tLWvfXBx+MaJF6u2Ykd9YorrdDs+
	kEOO4ermIx+f5MvMqMKByloCLkBIh+chjjzY/0pF2u8gTOrs4z6o1RZd2V
X-Google-Smtp-Source: AGHT+IEW/AZQiaj2xg+9vFyP6xkhqVZeH17JHEFKLHiUyANtk6MEBcP3jF2mfCG7BnFOqaawgya0NbcrML/K9xn41LM=
X-Received: by 2002:a17:907:980b:b0:ac1:ddaa:2c03 with SMTP id
 a640c23a62f3a-ac1ddaa727dmr171499666b.0.1740996862082; Mon, 03 Mar 2025
 02:14:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228195913.24895-1-james.morse@arm.com>
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>
From: Peter Newman <peternewman@google.com>
Date: Mon, 3 Mar 2025 11:14:10 +0100
X-Gm-Features: AQ5f1JoexOFT4uBmvAQMnsmNvIWesaFcPzCbBfkhoHlPbFxFey3yIMb_6cFvaNc
Message-ID: <CALPaoCjpdJB6GPk13GGHoA-UBgEpPdSMrqonThYObfkS9P7w+g@mail.gmail.com>
Subject: Re: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to /fs/resctrl
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Reinette Chatre <reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, 
	Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com, 
	D Scott Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com, 
	lcherian@marvell.com, bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com, 
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, 
	Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com, amitsinght@marvell.com, 
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, 
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Fri, Feb 28, 2025 at 8:59=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
>
> Changes since v6?:
>  * All the excitement is in patch 37, turns out there are two rmdir() pat=
hs
>    that don't join up.
> The last eight patches are new:
>  * The python script has been replaced with the patch that it generates, =
see
>    the bare branch below if you want to regenerate it.
>  * There have been comments on the followup to the generated patch, those=
 are
>    included here - I suggest they be squashed into the generated patch.
>  * This version includes some checkpatch linting from Dave.
>
> ---
> This series renames functions and moves code around. With the
> exception of invalid configurations for the configurable-events, there sh=
ould
> be no changes in behaviour caused by this series. It is now possible for
> throttle_mode to report 'undefined', but no known platform will do this.
>
> The driving pattern is to make things like struct rdtgroup private to res=
ctrl.
> Features like pseudo-lock aren't going to work on arm64, the ability to d=
isable
> it at compile time is added.
>
> After this, I can start posting the MPAM driver to make use of resctrl on=
 arm64.
> (What's MPAM? See the cover letter of the first series. [1])
>
> This series is based on v6.14-rc3 and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move=
_to_fs/v7
> or for those who want to regnerate the patch that moves all the code:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move=
_to_fs/v7_bare
>
>
> As ever - bugs welcome,
> Thanks,
>
> James
>
> [v6] https://lore.kernel.org/lkml/20250207181823.6378-1-james.morse@arm.c=
om/
> [v5] https://lore.kernel.org/r/20241004180347.19985-1-james.morse@arm.com
> [v4] https://lore.kernel.org/all/20240802172853.22529-1-james.morse@arm.c=
om/
> [v3] https://lore.kernel.org/r/20240614150033.10454-1-james.morse@arm.com
> [v2] https://lore.kernel.org/r/20240426150537.8094-1-Dave.Martin@arm.com
> [v1] https://lore.kernel.org/r/20240321165106.31602-1-james.morse@arm.com
> [1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.=
com/
>
> Amit Singh Tomar (1):
>   x86/resctrl: Remove the limit on the number of CLOSID
>
> Dave Martin (3):
>   x86/resctrl: Squelch whitespace anomalies in resctrl core code
>   x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in rdt_init_fs_context()
>   x86/resctrl: Relax some asm #includes
>
> James Morse (45):
>   x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
>     monitors
>   x86/resctrl: Add a helper to avoid reaching into the arch code
>     resource list
>   x86/resctrl: Remove fflags from struct rdt_resource
>   x86/resctrl: Use schema type to determine how to parse schema values
>   x86/resctrl: Use schema type to determine the schema format string
>   x86/resctrl: Remove data_width and the tabular format
>   x86/resctrl: Add max_bw to struct resctrl_membw
>   x86/resctrl: Generate default_ctrl instead of sharing it
>   x86/resctrl: Add helper for setting CPU default properties
>   x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
>   x86/resctrl: Expose resctrl fs's init function to the rest of the
>     kernel
>   x86/resctrl: Move rdt_find_domain() to be visible to arch and fs code
>   x86/resctrl: Move resctrl types to a separate header
>   x86/resctrl: Add an arch helper to reset one resource
>   x86/resctrl: Move monitor exit work to a resctrl exit call
>   x86/resctrl: Move monitor init work to a resctrl init call
>   x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers
>   x86/resctrl: Move the is_mbm_*_enabled() helpers to asm/resctrl.h
>   x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
>   x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
>   x86/resctrl: Move mba_mbps_default_event init to filesystem code
>   x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
>   x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
>   x86/resctrl: Allow an architecture to disable pseudo lock
>   x86/resctrl: Make prefetch_disable_bits belong to the arch code
>   x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
>   x86/resctrl: Move RFTYPE flags to be managed by resctrl
>   x86/resctrl: Handle throttle_mode for SMBA resources
>   x86/resctrl: Move get_config_index() to a header
>   x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their
>     callers
>   x86/resctrl: Rename resctrl_sched_in() to begin with "resctrl_arch_"
>   x86/resctrl: resctrl_exit() teardown resctrl but leave the mount point
>   x86/resctrl: Drop __init/__exit on assorted symbols
>   x86/resctrl: Move is_mba_sc() out of core.c
>   x86/resctrl: Add end-marker to the resctrl_event_id enum
>   x86/resctrl: Expand the width of dom_id by replacing mon_data_bits
>   x86/resctrl: Remove a newline to avoid confusing the code move script
>   x86/resctrl: Split trace.h
>   fs/resctrl: Add boiler plate for external resctrl code
>   x86/resctrl: Move the filesystem bits to headers visible to fs/resctrl
>   x86,fs/resctrl: Move the resctrl filesystem code to live in
>     /fs/resctrl
>   x86,fs/resctrl: Remove duplicated trace header files
>   fs/resctrl: Remove unnecessary includes
>   fs/resctrl: Change internal.h's header guard macros
>   x86,fs/resctrl: Move resctrl.rst to live under
>     Documentation/filesystems
>
>  Documentation/arch/x86/index.rst              |    1 -
>  Documentation/filesystems/index.rst           |    1 +
>  .../{arch/x86 =3D> filesystems}/resctrl.rst     |    0
>  MAINTAINERS                                   |    4 +-
>  arch/Kconfig                                  |    8 +
>  arch/x86/Kconfig                              |    6 +-
>  arch/x86/include/asm/resctrl.h                |   43 +-
>  arch/x86/kernel/cpu/resctrl/Makefile          |    8 +-
>  arch/x86/kernel/cpu/resctrl/core.c            |  214 +-
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  606 +--
>  arch/x86/kernel/cpu/resctrl/internal.h        |  504 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c         |  863 +---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c     | 1120 +----
>  .../resctrl/{trace.h =3D> pseudo_lock_trace.h}  |   26 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 4031 +--------------
>  arch/x86/kernel/process_32.c                  |    2 +-
>  arch/x86/kernel/process_64.c                  |    2 +-
>  fs/Kconfig                                    |    1 +
>  fs/Makefile                                   |    1 +
>  fs/resctrl/Kconfig                            |   39 +
>  fs/resctrl/Makefile                           |    6 +
>  fs/resctrl/ctrlmondata.c                      |  660 +++
>  fs/resctrl/internal.h                         |  435 ++
>  fs/resctrl/monitor.c                          |  933 ++++
>  fs/resctrl/monitor_trace.h                    |   33 +
>  fs/resctrl/pseudo_lock.c                      | 1104 +++++
>  fs/resctrl/rdtgroup.c                         | 4329 +++++++++++++++++
>  include/linux/resctrl.h                       |  216 +-
>  include/linux/resctrl_types.h                 |   59 +
>  29 files changed, 7992 insertions(+), 7263 deletions(-)
>  rename Documentation/{arch/x86 =3D> filesystems}/resctrl.rst (100%)
>  rename arch/x86/kernel/cpu/resctrl/{trace.h =3D> pseudo_lock_trace.h} (5=
6%)
>  create mode 100644 fs/resctrl/Kconfig
>  create mode 100644 fs/resctrl/Makefile
>  create mode 100644 fs/resctrl/ctrlmondata.c
>  create mode 100644 fs/resctrl/internal.h
>  create mode 100644 fs/resctrl/monitor.c
>  create mode 100644 fs/resctrl/monitor_trace.h
>  create mode 100644 fs/resctrl/pseudo_lock.c
>  create mode 100644 fs/resctrl/rdtgroup.c
>  create mode 100644 include/linux/resctrl_types.h
>
> --
> 2.39.5
>

I applied the series successfully and ran through my usual assortment
of container management-oriented testcases on the following
implementations:

* AMD EPYC 7B12 64-Core Processor
* Intel(R) Xeon(R) Gold 6268CL CPU @ 2.80GHz

Everything looked good.

Tested-by: Peter Newman <peternewman@google.com>

Thanks!
-Peter

