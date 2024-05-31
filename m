Return-Path: <linux-kernel+bounces-197144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8850A8D66C1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AABFB28B17
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2642158D90;
	Fri, 31 May 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKtv8lXf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EE917545
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172729; cv=none; b=nR597s3m9SFGMHYhk5U7nwknmdO7NCsfnWm2/udaOMw12QkJ/1Ch5ifOn8J8X6vDwDCtg+a4KQsg+DgFPxQWd1UtPzGY43R9prz18zfP8kx/xNXwCeAaUKT5y0SaPQgKB3VdUjCw15VeiV7rL26ssUZLs0ffS97vwDbM7sglfXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172729; c=relaxed/simple;
	bh=BnM9CcLm4Sp/dA80cks00HFRImjXT1zleUoSQEfC10U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7hmw08gDAoC8NZJYymU5MAPwdzmeGWVSwn3LnQCaVQ7Yx5BaTJR5xbo9cyg/t5u4LtxEDx36StlLz9ZrgoOTI6JrK3cNxoQdjwIgJHVq+2ZEWYsraY3jS0aaBCxbAj+dpBGFcM/aOW4vqUxDYkaW9Xbu5Qs+fl/2ZBo79/ROo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKtv8lXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92F1C2BD10;
	Fri, 31 May 2024 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717172729;
	bh=BnM9CcLm4Sp/dA80cks00HFRImjXT1zleUoSQEfC10U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKtv8lXfOgAZ0RY4gVbgtsgJ+Xq3ombXoILBWyDcww/Tvnc3ek9m+SVeeXBl/4OpQ
	 YIXY1bzLgaGKecJsK7cHKkLuKvlQi8LoRI9U0B184zUCkpUypo3piqD0UyxGUeLS6n
	 WlGESA1/BaiyGKqLVHgsW/IZ0uiAuT5ePEJ8cbcvcb13Elce+BCg1shh2jSUYlgnz1
	 j0A2fC/ni1s9RizqB/44o9sryRw8J3W+t4X7+EsPbDIObpv+eS271XTjjonEJm/8or
	 H2JVqeWe+Huwlo3stxhkQdC7thrwbvfZKfVaTdW0rfAgFzjkrwlGknjvbmeBGsi3pb
	 H/9NcHGC1/0Uw==
Date: Fri, 31 May 2024 13:25:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4 v3] perf: Fix leaked sigtrap events
Message-ID: <Zln59lKDPwuBT1GZ@x1>
References: <20240516140936.13694-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516140936.13694-1-frederic@kernel.org>

On Thu, May 16, 2024 at 04:09:32PM +0200, Frederic Weisbecker wrote:
> Changes since v2:
> 
> * Simplify the branch condition on [3/4] (peterz)
> * Rebase [4/4] accordingly
> 
> Frederic Weisbecker (4):
>   task_work: s/task_work_cancel()/task_work_cancel_func()/
>   task_work: Introduce task_work_cancel() again
>   perf: Fix event leak upon exit
>   perf: Fix event leak upon exec and file release

Trying this on linux-rt-devel/6.10.y-rt, after reverting Sebastian's
series that has clashes with this patch series:

[acme@nine linux]$ git log --oneline -5
4de7b8e17201 (HEAD -> linux-rt-devel-6.10.y-rt-sigtrap-fix-frederic-v3) Revert "perf: Move irq_work_queue() where the event is prepared."
5efa195af234 Revert "perf: Enqueue SIGTRAP always via task_work."
26ac4dfa180a Revert "perf: Remove perf_swevent_get_recursion_context() from perf_pending_task()."
c2fb5208a68e Revert "perf: Split __perf_pending_irq() out of perf_pending_irq()"
6d20efa57a89 (tag: v6.10-rc1-rt1-rebase, tag: v6.10-rc1-rt1, linux-rt-devel/linux-6.10.y-rt-rebase, linux-rt-devel/linux-6.10.y-rt, linux-rt-devel/for-kbuild-bot/prepare-release, linux-rt-devel/for-kbuild-bot/current-stable) Add localversion for -RT release
[acme@nine linux]$

Testing with the above reverts we're back to:

[   66.513763] BUG: scheduling while atomic: perf/7940/0x00000002
[   66.513763] BUG: scheduling while atomic: perf/7938/0x00000002

[   66.513872] Preemption disabled at:
[   66.513872] Preemption disabled at:
[   66.513872] [<0000000000000000>] 0x0
[   66.513872] [<0000000000000000>] 0x0
[   66.513878] CPU: 1 PID: 7940 Comm: perf Kdump: loaded Not tainted 6.10.0-rc1-rt1+ #1
[   66.513881] Hardware name: LENOVO 427623U/427623U, BIOS 8BET45WW (1.25 ) 05/18/2011
[   66.513882] Call Trace:
[   66.513885]  <TASK>
[   66.513887]  dump_stack_lvl+0x51/0x70
[   66.513893]  __schedule_bug+0x88/0xa0
[   66.513898]  schedule_debug.constprop.0+0xd1/0x120
[   66.513901]  __schedule+0x50/0x680
[   66.513906]  ? __pfx_perf_pmu_nop_int+0x10/0x10
[   66.513910]  ? merge_sched_in+0x202/0x350
[   66.513913]  ? _raw_spin_lock+0x13/0x40
[   66.513917]  schedule_rtlock+0x1d/0x40
[   66.513920]  rtlock_slowlock_locked+0xcd/0x260
[   66.513924]  ? __pfx_perf_pmu_nop_void+0x10/0x10
[   66.513926]  ? perf_ctx_enable+0x55/0x70
[   66.513930]  rt_spin_lock+0x40/0x60
[   66.513933]  do_send_sig_info+0x32/0xb0
[   66.513936]  send_sig_perf+0x6f/0x90
[   66.513939]  perf_pending_task+0x89/0xa0
[   66.513942]  task_work_run+0x58/0x90
[   66.513946]  irqentry_exit_to_user_mode+0x1ce/0x1d0
[   66.513950]  asm_sysvec_irq_work+0x16/0x20
[   66.513955] RIP: 0033:0x4c05af
[   66.513957] Code: 8b 04 25 28 00 00 00 48 89 45 e8 31 c0 e8 39 c0 f4 ff 4c 89 e7 48 89 c3 e8 be d3 f4 ff f0 01 1d 37 e6 85 00 8b 05 39 e6 85 00 <83> f8 01 7e 23 89 d9 31 d2 0f 1f 84 00 00 00 00 00 f0 01 0d 19 e6
[   66.513959] RSP: 002b:00007fcd6cf9bd70 EFLAGS: 00000202
[   66.513961] RAX: 0000000000000bb8 RBX: 0000000000001f04 RCX: 00007fcd6f41fb7a
[   66.513963] RDX: 0000000000000004 RSI: 0000000000000080 RDI: 00007ffe83407af4
[   66.513964] RBP: 00007fcd6cf9bd90 R08: 00007ffe83407af0 R09: 0000000000000004
[   66.513966] R10: 0000000000000000 R11: 0000000000000282 R12: 00007ffe83407af0
[   66.513967] R13: 000000000000000d R14: 00007fcd6f421530 R15: 0000000000000000
[   66.513970]  </TASK>
<SNIP more backtraces>

With Frederic's patchset:

[acme@nine linux]$ b4 am -ctsl --cc-trailers 20240516140936.13694-1-frederic@kernel.org
Grabbing thread from lore.kernel.org/all/20240516140936.13694-1-frederic@kernel.org/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 5 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
<SNIP>
Total patches: 4
---
Cover: ./v3_20240516_frederic_perf_fix_leaked_sigtrap_events.cover
 Link: https://lore.kernel.org/r/20240516140936.13694-1-frederic@kernel.org
 Base: not specified
       git am ./v3_20240516_frederic_perf_fix_leaked_sigtrap_events.mbx
[acme@nine linux]$        git am ./v3_20240516_frederic_perf_fix_leaked_sigtrap_events.mbx
Applying: task_work: s/task_work_cancel()/task_work_cancel_func()/
Applying: task_work: Introduce task_work_cancel() again
Applying: perf: Fix event leak upon exit
Applying: perf: Fix event leak upon exec and file release
[acme@nine linux]$

[acme@nine linux]$ git log --oneline -9
1f88fa6e3adb (HEAD -> linux-rt-devel-6.10.y-rt-sigtrap-fix-frederic-v3) perf: Fix event leak upon exec and file release
44cde14a096c perf: Fix event leak upon exit
512f8f5cbaed task_work: Introduce task_work_cancel() again
e7bee294ec69 task_work: s/task_work_cancel()/task_work_cancel_func()/
4de7b8e17201 Revert "perf: Move irq_work_queue() where the event is prepared."
5efa195af234 Revert "perf: Enqueue SIGTRAP always via task_work."
26ac4dfa180a Revert "perf: Remove perf_swevent_get_recursion_context() from perf_pending_task()."
c2fb5208a68e Revert "perf: Split __perf_pending_irq() out of perf_pending_irq()"
6d20efa57a89 (tag: v6.10-rc1-rt1-rebase, tag: v6.10-rc1-rt1, linux-rt-devel/linux-6.10.y-rt-rebase, linux-rt-devel/linux-6.10.y-rt, linux-rt-devel/for-kbuild-bot/prepare-release, linux-rt-devel/for-kbuild-bot/current-stable) Add localversion for -RT release
[acme@nine linux]$

The workload that is used to do that, as a reminder, is 'perf test sigtrap'.

[  121.217475] BUG: scheduling while atomic: perf/7955/0x00000002
[  121.217478] BUG: scheduling while atomic: perf/7956/0x00000002
<SNIP list of modules>
[  121.217492] BUG: scheduling while atomic: perf/7954/0x00000002
<SNIP list of modules>
[  121.217570] Preemption disabled at:
<SNIP>
[  121.217571] [<0000000000000000>] 0x0
<SNIP>
[  121.217609] Preemption disabled at:
<SNIP>
[  121.217610] [<0000000000000000>] 0x0

Lots of reports mixed up

[  121.217575] CPU: 5 PID: 7955 Comm: perf Kdump: loaded Not tainted 6.10.0-rc1.frederic-rt1+ #3
[  121.217577]  i2c_smbus
[  121.217577]  cec
[  121.217577] Hardware name: LENOVO 427623U/427623U, BIOS 8BET45WW (1.25 ) 05/18/2011
[  121.217578]  firmware_attributes_class
[  121.217577]  i2c_algo_bit
[  121.217579]  snd
[  121.217579]  drm_buddy
[  121.217579] Call Trace:
  121.217580]  wmi_bmof
[  121.217580]  ttm
[  121.217580]  mei_me lpc_ich
[  121.217581]  <TASK>
[  121.217581]  sr_mod
[  121.217582]  mei
[  121.217582]  intel_gtt
[  121.217583]  soundcore sparse_keymap
[  121.217584]  sd_mod cdrom
[  121.217584]  platform_profile rfkill
[  121.217585]  drm_display_helper t10_pi
[  121.217583]  dump_stack_lvl+0x51/0x70
[  121.217586]  joydev xfs
[  121.217587]  sg drm_kms_helper
[  121.217588]  libcrc32c
[  121.217589]  sdhci_pci
[  121.217589]  i915
[  121.217590]  crct10dif_pclmul
[  121.217590]  cec
[  121.217590]  ahci
[  121.217588]  __schedule_bug+0x88/0xa0
[  121.217598]  ghash_clmulni_intel
[  121.217596]  __schedule+0x50/0x680
[  121.217598]  drm_display_helper t10_pi
[  121.217599]  mmc_core e1000e
[  121.217600]  sg
[  121.217601]  video
[  121.217601]  drm_kms_helper sdhci_pci
[  121.217602]  wmi
[  121.217601]  ? _raw_spin_lock+0x13/0x40
[  121.217603]  crct10dif_pclmul
[  121.217603]  serio_raw
[  121.217604]  ahci
[  121.217604]  dm_mirror
[  121.217605]  drm
[  121.217605]  dm_region_hash
[  121.217605]  schedule_rtlock+0x1d/0x40
[  121.217606]  dm_log
[  121.217606]  crc32_pclmul cqhci
[  121.217607]  dm_mod fuse
[  121.217608]  libahci

[  121.217607]  rtlock_slowlock_locked+0xcd/0x260
[  121.217609] Preemption disabled at:
[  121.217609]  crc32c_intel sdhci libata ghash_clmulni_intel
[  121.217610] [<0000000000000000>] 0x0
[  121.217612]  mmc_core
[  121.217612]  rt_spin_lock+0x40/0x60
[  121.217612]  e1000e video wmi serio_raw dm_mirror
[  121.217614]  do_send_sig_info+0x32/0xb0
[  121.217615]  dm_region_hash dm_log dm_mod fuse
[  121.217617]  send_sig_perf+0x6f/0x90

[  121.217619] Preemption disabled at:
[  121.217619] [<0000000000000000>] 0x0
[  121.217619]  perf_pending_task+0x65/0x90
[  121.217624]  task_work_run+0x58/0x90
[  121.217627]  irqentry_exit_to_user_mode+0x1ce/0x1d0
[  121.217629]  asm_sysvec_irq_work+0x16/0x20
[  121.217633] RIP: 0033:0x4c05af
[  121.217634] BUG: scheduling while atomic: perf/7953/0x00000002
[  121.217634] Code: 8b 04 25 28 00 00 00 48 89 45 e8 31 c0 e8 39 c0 f4 ff 4c 89 e7 48 89 c3 e8 be d3 f4 ff f0 01 1d 37 e6 85 00 8b 05 39 e6 85 00 <83> f8 01 7e 23 89 d9 31 d2 0f 1f 84 00 00 00 00 00 f0 01 0d 19 e6
[  121.217636] RSP: 002b:00007fb693ac5d70 EFLAGS: 00000206

<SNIP>
[  121.217653] caller is perf_pending_task+0x29/0x90
[  121.217654]  coretemp snd_hda_codec_conexant kvm_intel snd_hda_codec_generic
[  121.217655]  dump_stack_lvl+0x51/0x70
[  121.217657]  mac80211 kvm snd_hda_intel uvcvideo snd_intel_dspcfg libarc4 snd_intel_sdw_acpi
[  121.217659]  __schedule_bug+0x88/0xa0
[  121.217661]  snd_hda_codec uvc rapl videobuf2_vmalloc mei_wdt snd_hda_core
[  121.217663]  schedule_debug.constprop.0+0xd1/0x120
[  121.217665]  videobuf2_memops btusb videobuf2_v4l2 iwlwifi btrtl snd_hwdep btintel
[  121.217666]  __schedule+0x50/0x680
[  121.217668]  videodev snd_seq btbcm snd_ctl_led snd_seq_device iTCO_wdt btmtk
[  121.217670]  ? _raw_spin_lock+0x13/0x40
[  121.217672]  snd_pcm intel_cstate videobuf2_common iTCO_vendor_support bluetooth cfg80211 thinkpad_acpi snd_timer
[  121.217675]  schedule_rtlock+0x1d/0x40
[  121.217677]  i2c_i801 think_lmi mc intel_uncore pcspkr i2c_smbus
[  121.217678]  rtlock_slowlock_locked+0xcd/0x260
[  121.217680]  firmware_attributes_class snd wmi_bmof mei_me lpc_ich mei soundcore sparse_keymap platform_profile
[  121.217683]  rt_spin_lock+0x40/0x60
[  121.217685]  rfkill joydev xfs libcrc32c i915
[  121.217687]  do_send_sig_info+0x32/0xb0
[  121.217688]  cec i2c_algo_bit drm_buddy ttm sr_mod intel_gtt
[  121.217690]  send_sig_perf+0x6f/0x90
[  121.217691]  sd_mod cdrom drm_display_helper t10_pi sg drm_kms_helper sdhci_pci
[  121.217693]  perf_pending_task+0x65/0x90
[  121.217695]  crct10dif_pclmul ahci drm crc32_pclmul cqhci libahci
[  121.217697]  task_work_run+0x58/0x90
[  121.217698]  crc32c_intel sdhci libata ghash_clmulni_intel mmc_core e1000e
[  121.217700]  irqentry_exit_to_user_mode+0x1ce/0x1d0
[  121.217702]  video wmi serio_raw dm_mirror dm_region_hash dm_log
[  121.217703]  asm_sysvec_irq_work+0x16/0x20
[  121.217705]  dm_mod fuse




