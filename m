Return-Path: <linux-kernel+bounces-527916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB47A41139
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A133B782E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6401C84B2;
	Sun, 23 Feb 2025 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTfoB6Oy"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53BB188713
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337205; cv=none; b=e/FCYmznJ8dbjk/KYnOpI7Ji3hna9m3gX3ihmQr+9dDfvYOiT8kkq5z6N3ZQmY0NIyO6CuxoG0EmmiIVJF6bVHBhOHfmG8N6CeMlVlkT8i7ClDNuv0BFNg0mY7X5FFQ2yb9O/nagLFZR9z2VyD8u3bTP24cioERYo5LrXWDTWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337205; c=relaxed/simple;
	bh=lm1tTg6fgZkLuzj0lcqLFz7/axZWpbV5ZSXjlkBxjSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIZ4+aihK653Y5w4sp72506s1NehlytZYXy5HIeQmhOpLGm5pCSZHMXm9MeCAxVGVOl9HXRXAOFc+8yfmPZKZQ5X4rOMe8K+66MA40NLbgdmWbgAwkfhIrtcEAlFVh2voO+3j/sOZFot4uWAYqFzOixR1Xy9uTyUIDgAdslsDMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTfoB6Oy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fbf77b2b64so7596290a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740337199; x=1740941999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XT9v8I+Jg1sL9w3140WG9QGwr+oOSUFNnTBeMkLROiY=;
        b=OTfoB6Oyob8R/eywdgHM/2Tg1eRD0fRfChHIUkXiYlB0e4M/HuGR4qX4excgnXRMB4
         VL6io9FjjtMP8g5cFcqVofCEpgqicwueJL+dm22RwY+FCLDMHJpBZcVWBIVGb90/cri2
         V9iwenFPeoBrhl+L1bcaKXw+HpYc3dgJK1fHDywBXLdZBT8HxZQCXri0CNzTHeRa8TsX
         9gCKhfwzYvreTIM3k+kLjLO0l25C00awZGZRsp+XpAJPZNSDJ2hIE6UpJz7J6nB9gb3A
         zLaB/MS74V6yffFKm22OSL3OVmfBqIXAbVq4gSeZWDkchOBEsZfdsnJZMKGriVXrD4hw
         5PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337199; x=1740941999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XT9v8I+Jg1sL9w3140WG9QGwr+oOSUFNnTBeMkLROiY=;
        b=fmHlfAQ5I/jtFM9iinU8U442yfRiafxk5rsAtlYpmg6YMPYJAZnLR8FGZm6v6CNMbR
         zh65zqUOCstZs8Vq1DM/fRDZrRkkHFT8lZCjVOej+H9ravtG9/TwZAZ0RbIETeLQfAWl
         +5KTkdKgynqr8Y5bR9qvaG1+nglAxhp3dijns/dGkYu2f5DGROhsf0IryieYIGlSzCIa
         SBVTy7cVeJ1SQQSeT/+6GDJRJa+umGuZKYIOLDlIJ1IqHLQfyPMjt7OK57Q8KSOYCK0Y
         dAKDq26VEHM4tQBAyIaTXmTaFN4oWQp1pVxXIHuUaXJoT+Q8Im919kvnHCEhrabh8rZO
         Zs6w==
X-Forwarded-Encrypted: i=1; AJvYcCVa1tgXPVFVozKCooc7dBvNV6c9bNRZQxHTYFCJn+69n69tlWdwMtOwgP1/bIjIqsjkEEPtTvNRPast/Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzWMxsc9hz5LxqNk3XpOBtHOegJAfEWMANGk+8grvLT3L6Udyd
	fYhunPjzXUwaKyGGl6yl/cSbgjRLsjVz2EQSZpAx0JJUZlbsPst1
X-Gm-Gg: ASbGnctcp98W0bQepaouKXGhfeylxkX5Qh0ylYRNUZd5V16kowxbJ0ns7mX+gzc5Nrm
	gbOyQgWuMNmfjp6wBMOVfTRXbIrPqMFDDMsq+/rS5im5znqzKaOkBNxKf/lCqNchil7lslNZl5x
	ZC6PS+r1/9RKqIjaAdGpG0qQdq9aWG6xkmBEFbck2sz8NQPJNRgY1a3rqhShqsf9jdewPAB3thL
	hIR6bwI/vAi+LUBDCtX+A56HPJVESjJjeZFPXqhR7zwoK+hDzelwfb2iVTkwgwEfMFD3S6rWJ9g
	7DfPwHj3JZ2ZZ6s+gZod4bFCI7JQ7GjrSWpQQQueP9U=
X-Google-Smtp-Source: AGHT+IGoOyyKiflzWcsiLvp8TEAqHPa0b7Hi2wklwn8YPEAqguysgAp3eyFTSW0Vv2mofYxYo/mhMQ==
X-Received: by 2002:a05:6a20:3d87:b0:1ee:ab62:c24 with SMTP id adf61e73a8af0-1eef3dd06cemr19571180637.41.1740337198522;
        Sun, 23 Feb 2025 10:59:58 -0800 (PST)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:8f01:f01c:b79d:a991])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732511dfd9esm18035721b3a.67.2025.02.23.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:56 -0800 (PST)
Date: Mon, 24 Feb 2025 02:59:51 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: anshuman.khandual@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, skhan@linuxfoundation.org, mka@chromium.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v2] uapi: Revert "bitops: avoid integer overflow in
 GENMASK(_ULL)"
Message-ID: <Z7twJwvMT-Qvinaj@vaxr-BM6660-BM6360>
References: <20250221074208.832153-1-richard120310@gmail.com>
 <Z7i8Yf-Ic7DDYxOk@vaxr-BM6660-BM6360>
 <Z7jN6FpqVIpeiipl@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7jN6FpqVIpeiipl@thinkpad>

On Fri, Feb 21, 2025 at 02:03:04PM -0500, Yury Norov wrote:
> On Sat, Feb 22, 2025 at 01:48:17AM +0800, I Hsin Cheng wrote:
> > On Fri, Feb 21, 2025 at 03:41:49PM +0800, I Hsin Cheng wrote:
> > > This patch reverts 'commit c32ee3d9abd2("bitops: avoid integer overflow in
> > >  GENMASK(_ULL)")'.
> > > 
> > > The code generation can be shrink by over 1k by reverting the commit.
> > > Orginally the commit claims that clang will emit warnings using the
> > > implementation at that time.
> > > 
> > > Numerous tests are done to verify the code size shrink result and
> > > whether the warnings are emitted.
> > > 
> > > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > > ---
> > > Tests performed on ubuntu 24.04 with AMD Ryzen 7 5700X3D 8-Core
> > > Processor on x86_64 with kernel version v6.14.0-rc1.
> > > 
> > > Test compilation with gcc-13, gcc-12, gcc-11, gcc cross compiler,
> > > clang-17, clang-18 and clang-19. No warnings are emitted for W=1 and
> > > W=2. However, with W=0, many errors and warnings will pop out.
> > > 
> > > For gcc-13 with W=0:
> > > In file included from <command-line>:
> > > ./include/linux/rwsem.h: In function ‘rwsem_assert_held_write_nolockdep’:
> > > ././include/linux/compiler_types.h:477:20: error: ‘asm’ operand 2 probably does not match constraints [-Werror]
> > >   477 | #define asm_inline asm __inline
> > > ...
> > > 
> > > For clang-19 with W=0:
> > > ./arch/x86/include/asm/jump_label.h:36:11: error: invalid operand for inline asm constraint 'i'
> > >    36 |         asm goto(ARCH_STATIC_BRANCH_ASM("%c0 + %c1", "%l[l_yes]")
> > >       |                  ^
> > > ./arch/x86/include/asm/jump_label.h:26:2: note: expanded from macro 'ARCH_STATIC_BRANCH_ASM'
> > >    26 |         "1: jmp " label " # objtool NOPs this \n\t"     \
> > > ...
> > > 
> > > However, these errors already exists before applying the change, I don't
> > > think this patch has anything to do with these errors. I'll send other
> > > patches to fix these errors.
> > > 
> > > The following section shows the result of code size shrinking for
> > > different compilers, architectures and NR_CPUS. Additionally, I use QEMU
> > > to run an arm64 VM and perform some cpu-heavy workload to make sure no
> > > side effect or crashes will happen.
> > > 
> > > * Code size shrinking ( gcc-13 for x86_64 NR_CPUS=64 ):
> > > 
> > > x$ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> > > add/remove: 0/2 grow/shrink: 46/510 up/down: 464/-1733 (-1269)
> > > Function                                     old     new   delta
> > > store_min_perf_pct                           275     368     +93
> > > store_hwp_dynamic_boost                      138     225     +87
> > > store_max_perf_pct                           253     336     +83
> > > rcu_exp_wait_wake                           2620    2651     +31
> > > hybrid_update_cpu_capacity_scaling           311     332     +21
> > > cpuset_mem_spread_node                       283     297     +14
> > > perf_assign_events                           901     914     +13
> > > xt_init                                      297     305      +8
> > > partition_sched_domains_locked              1126    1134      +8
> > > srcu_torture_stats_print                     534     541      +7
> > > sock_prot_inuse_get                          121     128      +7
> > > ring_buffer_empty                            271     278      +7
> > > numa_policy_init                             602     609      +7
> > > gnet_stats_add_basic                         183     190      +7
> > > rcu_init                                    2383    2389      +6
> > > amd_uncore_ctx_move                          286     292      +6
> > > vmalloc_init                                1058    1062      +4
> > > reclaim_throttle                             756     760      +4
> > > kstat_irqs_desc                              118     122      +4
> > > hidinput_connect                           20926   20930      +4
> > > dev_change_proto_down_reason                 164     168      +4
> > > cgroup_propagate_control                     403     407      +4
> > > tracing_total_entries_read                   346     349      +3
> > > remove_siblinginfo                          1038    1041      +3
> > > perf_event_init                              838     841      +3
> > > qdisc_alloc                                  472     474      +2
> > > probes_profile_seq_show                      387     389      +2
> > > clocksource_verify_percpu.part              1065    1067      +2
> > > blk_mq_init_allocated_queue                  976     978      +2
> > > __lru_add_drain_all                          502     504      +2
> > > zone_reclaimable_pages                       692     693      +1
> > > tcp_orphan_count_sum                         107     108      +1
> > > sock_inuse_get                               102     103      +1
> > > sched_balance_rq                            3745    3746      +1
> > > proc_nr_inodes                               173     174      +1
> > > percpu_ref_switch_to_atomic_rcu              375     376      +1
> > > nr_processes                                 102     103      +1
> > > netdev_refcnt_read                           102     103      +1
> > > mq_dump_class_stats                          234     235      +1
> > > mnt_get_writers                               96      97      +1
> > > mnt_get_count                                 99     100      +1
> > > get_nr_inodes                                106     107      +1
> > > get_nr_dirty_inodes                          153     154      +1
> > > allow_direct_reclaim                         318     319      +1
> > > alloc_fd                                     376     377      +1
> > > __is_kernel_percpu_address                   177     178      +1
> > > zoneinfo_show                                823     822      -1
> > > zhaoxin_pmu_handle_irq                       772     771      -1
> > > zhaoxin_arch_events_quirk                    137     136      -1
> > > workqueue_init                               927     926      -1
> > > wake_up_all_idle_cpus                        142     141      -1
> > > uprobe_buffer_disable                        165     164      -1
> > > update_per_cpu_data_slice_size               216     215      -1
> > > unregister_netdevice_many_notify            2299    2298      -1
> > > uncore_pmu_hrtimer                           261     260      -1
> > > uncore_event_cpu_offline                     344     343      -1
> > > uncore_device_to_die                         163     162      -1
> > > tsc_store_and_check_tsc_adjust               507     506      -1
> > > tsc_restore_sched_clock_state                223     222      -1
> > > tsc_refine_calibration_work                  938     937      -1
> > > try_to_unmap_one                            2473    2472      -1
> > > try_to_migrate_one                          2166    2165      -1
> > > trace_total_entries                          192     191      -1
> > > trace_buffered_event_enable                  347     346      -1
> > > tmigr_cpu_offline                            404     403      -1
> > > timer_list_start                             159     158      -1
> > > tick_handle_oneshot_broadcast                380     379      -1
> > > tick_clock_notify                            109     108      -1
> > > tick_broadcast_setup_oneshot                 288     287      -1
> > > thaw_secondary_cpus                          424     423      -1
> > > tcp_sigpool_alloc_ahash                      885     884      -1
> > > tc_fill_qdisc                               1125    1124      -1
> > > sysctl_vm_numa_stat_handler                  456     455      -1
> > > sync_runqueues_membarrier_state              319     318      -1
> > > sw_perf_event_destroy                        133     132      -1
> > > svc_create_pooled                            799     798      -1
> > > sugov_stop                                   141     140      -1
> > > store_no_turbo                               641     640      -1
> > > snmp_fold_field                              113     112      -1
> > > smp_call_function_any                        261     260      -1
> > > show_stat                                   2323    2322      -1
> > > setup_swap_info                              235     234      -1
> > > sched_update_numa                            424     423      -1
> > > sbitmap_init_node                            498     497      -1
> > > rto_next_cpu                                 137     136      -1
> > > rtm_new_nexthop                             5249    5248      -1
> > > rt6_disable_ip                               716     715      -1
> > > relay_reset                                  198     197      -1
> > > relay_flush                                  198     197      -1
> > > relay_close                                  358     357      -1
> > > reclaim_and_purge_vmap_areas                 450     449      -1
> > > rdmacg_resource_set_max                      892     891      -1
> > > rcu_tasks_trace_pregp_step                  1143    1142      -1
> > > rcu_spawn_gp_kthread                         645     644      -1
> > > rcu_spawn_exp_par_gp_kworker                 387     386      -1
> > > rcu_report_exp_cpu_mult                      175     174      -1
> > > rcu_barrier_tasks_generic                    437     436      -1
> > > rcu_barrier                                  874     873      -1
> > > pull_dl_task                                 845     844      -1
> > > pti_init                                     554     553      -1
> > > print_ICs                                    299     298      -1
> > > pfifo_fast_reset                             349     348      -1
> > > perf_trace_event_init                        728     727      -1
> > > perf_reboot                                  106     105      -1
> > > perf_event_print_debug                      1227    1226      -1
> > > percpu_counter_set                           127     126      -1
> > > pcpu_setup_first_chunk                      2020    2019      -1
> > > pcpu_depopulate_chunk                        412     411      -1
> > > pcpu_alloc_noprof                           1948    1947      -1
> > > p4_pmu_handle_irq                            631     630      -1
> > > od_set_powersave_bias                        216     215      -1
> > > node_dev_init                                189     188      -1
> > > nh_fill_node                                2439    2438      -1
> > > nfs_show_stats                              1147    1146      -1
> > > neightbl_fill_info.constprop                1064    1063      -1
> > > native_stop_other_cpus                       455     454      -1
> > > mm_init.isra                                 898     897      -1
> > > memory_tier_late_init                       1762    1761      -1
> > > mem_init                                     520     519      -1
> > > kswapd_init                                  110     109      -1
> > > kmem_cache_init                              369     368      -1
> > > kcompactd_init                               242     241      -1
> > > irq_alloc_matrix                             247     246      -1
> > > ipv6_add_dev                                1303    1302      -1
> > > ipv4_mib_init_net                            509     508      -1
> > > ip_rt_init                                   589     588      -1
> > > ip6_route_init                               563     562      -1
> > > iova_domain_init_rcaches                     458     457      -1
> > > iommu_put_dma_cookie                        1044    1043      -1
> > > ioc_timer_fn                                4908    4907      -1
> > > intel_pstate_driver_cleanup                  223     222      -1
> > > intel_gt_mcr_init                            886     885      -1
> > > intel_get_event_constraints                  846     845      -1
> > > intel_arch_events_quirk                      137     136      -1
> > > input_leds_connect                           720     719      -1
> > > init_sched_rt_class                          101     100      -1
> > > init_sched_dl_class                          101     100      -1
> > > init_gi_nodes                                132     131      -1
> > > inet6_net_init                               644     643      -1
> > > i915_pmu_cpu_offline                         230     229      -1
> > > hybrid_set_capacity_of_cpus                  137     136      -1
> > > housekeeping_init                            124     123      -1
> > > group_cpus_evenly                            439     438      -1
> > > gnet_stats_add_queue                         213     212      -1
> > > get_total_entries                            199     198      -1
> > > get_nohz_timer_target                        317     316      -1
> > > gen11_gt_irq_handler                         924     923      -1
> > > free_acpi_perf_data                           75      74      -1
> > > fpu__init_system_xstate                     3179    3178      -1
> > > fold_vm_zone_numa_events                     232     231      -1
> > > flow_limit_cpu_sysctl                        525     524      -1
> > > filelock_init                                396     395      -1
> > > ext4_mb_new_blocks                          4028    4027      -1
> > > elf_coredump_extra_notes_size                107     106      -1
> > > ehci_hrtimer_func                            233     232      -1
> > > dst_cache_reset_now                          163     162      -1
> > > do_migrate_pages                             807     806      -1
> > > dm_stats_init                                195     194      -1
> > > dl_bw_cpus                                   136     135      -1
> > > disable_freq_invariance_workfn               118     117      -1
> > > default_send_IPI_mask_allbutself_phys        287     286      -1
> > > crash_prepare_elf64_headers                  566     565      -1
> > > cpupri_init                                  182     181      -1
> > > cpupri_find_fitness                          416     415      -1
> > > cpuhp_sysfs_init                             265     264      -1
> > > cpuhp_smt_disable                            213     212      -1
> > > cpuhp_rollback_install                       186     185      -1
> > > cpufreq_set_policy                           801     800      -1
> > > cpufreq_policy_free                          385     384      -1
> > > cpufreq_online                              2578    2577      -1
> > > cpufreq_notify_transition                    281     280      -1
> > > cpufreq_driver_fast_switch                   207     206      -1
> > > cpufreq_dbs_governor_start                   443     442      -1
> > > cpufreq_dbs_governor_init                    681     680      -1
> > > cpudl_init                                   159     158      -1
> > > cpuacct_stats_show                           380     379      -1
> > > cpu_map_shared_cache                         260     259      -1
> > > cpu_dev_init                                 228     227      -1
> > > cpc_write_ffh                                167     166      -1
> > > compaction_zonelist_suitable                 329     328      -1
> > > clock_was_set                                561     560      -1
> > > cgroup_subtree_control_write                1008    1007      -1
> > > cgroup_rstat_init                            168     167      -1
> > > cgroup_rstat_boot                            105     104      -1
> > > cgroup_post_fork                             634     633      -1
> > > cgroup_base_stat_cputime_show                760     759      -1
> > > can_migrate_task                             519     518      -1
> > > call_function_init                           171     170      -1
> > > calibrate_delay_is_known                     237     236      -1
> > > build_all_zonelists_init                     277     276      -1
> > > bpf_prog_alloc                               166     165      -1
> > > blkg_alloc                                   481     480      -1
> > > blkcg_print_stat                             880     879      -1
> > > blkcg_iolatency_done_bio                    1775    1774      -1
> > > blkcg_css_alloc                              568     567      -1
> > > blk_stat_timer_fn                            378     377      -1
> > > blk_stat_add_callback                        244     243      -1
> > > blk_mq_sysfs_deinit                          123     122      -1
> > > blk_mq_map_hw_queues                         175     174      -1
> > > blk_mq_init                                  358     357      -1
> > > blk_iocost_init                              620     619      -1
> > > begin_new_exec                              2857    2856      -1
> > > asym_cpu_capacity_scan                       642     641      -1
> > > amd_uncore_umc_ctx_init                      871     870      -1
> > > amd_pstate_change_mode_without_dvr_change     133     132      -1
> > > amd_pmu_v2_handle_irq                       1053    1052      -1
> > > alloc_iova_fast                              680     679      -1
> > > alloc_desc                                   492     491      -1
> > > addrconf_disable_policy_idev                 322     321      -1
> > > add_to_avail_list                            310     309      -1
> > > acpi_cpc_valid                               130     129      -1
> > > _vm_unmap_aliases                            646     645      -1
> > > __snmp6_fill_stats64.constprop               282     281      -1
> > > __percpu_ref_switch_mode                     543     542      -1
> > > __i915_gem_object_set_pages                  547     546      -1
> > > __ftrace_clear_event_pids                    593     592      -1
> > > __drain_swap_slots_cache                      90      89      -1
> > > __drain_all_pages                            449     448      -1
> > > __copy_xstate_to_uabi_buf                   2416    2415      -1
> > > __alloc_frozen_pages_noprof                 3930    3929      -1
> > > ___gnet_stats_copy_basic.isra                387     386      -1
> > > zone_pcp_enable                              127     125      -2
> > > xhci_bus_resume                             1011    1009      -2
> > > xfrm_input_init                              230     228      -2
> > > xfeature_get_offset                          137     135      -2
> > > x86_release_hardware                         322     320      -2
> > > workqueue_online_cpu                         750     748      -2
> > > workqueue_offline_cpu                        550     548      -2
> > > weighted_interleave_nodes                    331     329      -2
> > > vmalloc_info_show                           1000     998      -2
> > > update_or_create_fnhe                        910     908      -2
> > > update_group_capacity                        556     554      -2
> > > tsc_init                                     882     880      -2
> > > try_to_generate_entropy                      629     627      -2
> > > tracing_set_cpumask                          284     282      -2
> > > tracing_release                              336     334      -2
> > > tracing_entries_read                         453     451      -2
> > > trace_rb_cpu_prepare                         213     211      -2
> > > toggle_bp_slot.constprop                    2861    2859      -2
> > > timekeeping_get_mg_floor_swaps               111     109      -2
> > > tcf_idr_create                               639     637      -2
> > > task_non_contending                          837     835      -2
> > > task_mm_cid_work                             498     496      -2
> > > srcu_readers_active                          128     126      -2
> > > srcu_barrier                                 515     513      -2
> > > softirq_init                                 150     148      -2
> > > snmp_seq_show_ipstats.isra                   374     372      -2
> > > snmp6_seq_show_item64.constprop              264     262      -2
> > > snapshot_write_next                         2486    2484      -2
> > > snapshot_read_next                           626     624      -2
> > > smp_prepare_cpus_common                      339     337      -2
> > > skx_pmu_get_topology                         313     311      -2
> > > show_slab_objects                           1071    1069      -2
> > > show_numa_map                                980     978      -2
> > > show_interrupts                              817     815      -2
> > > shmem_cppc_enable                            225     223      -2
> > > setup_zone_pageset                           327     325      -2
> > > setup_per_cpu_pageset                        266     264      -2
> > > set_cpus_allowed_dl                          276     274      -2
> > > set_cpu_sibling_map                         1693    1691      -2
> > > set_buffer_entries                            93      91      -2
> > > seq_hlist_start_percpu                       131     129      -2
> > > seq_hlist_next_percpu                        202     200      -2
> > > send_pcc_cmd                                 656     654      -2
> > > select_task_rq_fair                         4420    4418      -2
> > > scsi_show_rq                                 800     798      -2
> > > schedule_on_each_cpu                         335     333      -2
> > > s_start                                      865     863      -2
> > > ring_buffer_subbuf_order_set                1200    1198      -2
> > > ring_buffer_overruns                         107     105      -2
> > > ring_buffer_entries                          124     122      -2
> > > recalc_bh_state.part                         122     120      -2
> > > rcu_gp_cleanup                              1556    1554      -2
> > > rcu_check_boost_fail                         467     465      -2
> > > rcec_assoc_rciep.isra                        116     114      -2
> > > pt_init                                      981     979      -2
> > > process_srcu                                1676    1674      -2
> > > phys_package_first_cpu                       122     120      -2
> > > perf_output_sample_regs                      181     179      -2
> > > perf_event_mux_interval_ms_store             365     363      -2
> > > percpu_is_read_locked                        126     124      -2
> > > per_cpu_ptr_to_phys                          266     264      -2
> > > part_stat_read_all                           193     191      -2
> > > part_inflight_show                           308     306      -2
> > > part_in_flight                               133     131      -2
> > > padata_do_serial                             237     235      -2
> > > padata_do_multithreaded                      877     875      -2
> > > padata_alloc_pd                              482     480      -2
> > > p4_pmu_enable_all                            132     130      -2
> > > numa_nearest_node                            210     208      -2
> > > nr_iowait                                    105     103      -2
> > > nr_context_switches                          112     110      -2
> > > node_read_distance                           234     232      -2
> > > netif_get_num_default_rss_queues             157     155      -2
> > > native_smp_cpus_done                         657     655      -2
> > > metadata_dst_alloc_percpu                    370     368      -2
> > > memcpy_count_show                            176     174      -2
> > > membarrier_global_expedited                  330     328      -2
> > > mce_read_aux                                 394     392      -2
> > > loopback_get_stats64                         145     143      -2
> > > kyber_timer_fn                               599     597      -2
> > > kvm_flush_tlb_multi                          149     147      -2
> > > kfree_rcu_shrink_count                       157     155      -2
> > > kcore_update_ram.isra                        783     781      -2
> > > iommu_dma_init_fq                            450     448      -2
> > > iolatency_pd_init                            495     493      -2
> > > interleave_nodes                             166     164      -2
> > > interleave_nid                               217     215      -2
> > > intel_pmu_init                             14167   14165      -2
> > > intel_pmu_drain_pebs_icl                     866     864      -2
> > > intel_gt_init_workarounds                   4139    4137      -2
> > > input_register_device                       1348    1346      -2
> > > init_sched_fair_class                        213     211      -2
> > > init_cpu_to_node                             284     282      -2
> > > inactive_task_timer                          967     965      -2
> > > ieee80211_sta_last_active                    147     145      -2
> > > ieee80211_rx_mgmt_beacon                    5755    5753      -2
> > > ieee80211_add_rx_radiotap_header            2267    2265      -2
> > > idle_threads_init                            181     179      -2
> > > icl_display_core_init                       2347    2345      -2
> > > hw_breakpoint_is_used                        210     208      -2
> > > gro_cells_destroy                            342     340      -2
> > > ftrace_dump_one                              731     729      -2
> > > free_policy_dbs_info                         124     122      -2
> > > free_iova_rcaches                            285     283      -2
> > > free_area_init                              4062    4060      -2
> > > fq_flush_timeout                             234     232      -2
> > > flush_tlb_mm_range                           427     425      -2
> > > ext4_update_super                            942     940      -2
> > > ext4_mb_init                                1965    1963      -2
> > > ext4_journal_commit_callback                 470     468      -2
> > > ext4_fill_super                            12856   12854      -2
> > > drv_change_sta_links                         621     619      -2
> > > drop_slab                                    223     221      -2
> > > do_ipt_set_ctl                              1565    1563      -2
> > > do_ip6t_set_ctl                             1589    1587      -2
> > > dma_channel_table_init                       279     277      -2
> > > dm_wait_for_completion                       409     407      -2
> > > dm_stats_message                            4382    4380      -2
> > > dl_cpuset_cpumask_can_shrink                 268     266      -2
> > > dl_clear_root_domain                         176     174      -2
> > > dl_add_task_root_domain                      337     335      -2
> > > dev_lstats_read                              137     135      -2
> > > dev_fetch_sw_netstats                        179     177      -2
> > > detect_cache_attributes                      795     793      -2
> > > del_gendisk                                  849     847      -2
> > > default_hugepagesz_setup                     454     452      -2
> > > cpuusage_write                               199     197      -2
> > > cpuusage_user_read                           120     118      -2
> > > cpuusage_sys_read                            125     123      -2
> > > cpuusage_read                                111     109      -2
> > > cpuidle_driver_state_disabled                234     232      -2
> > > cpufreq_show_cpus                            172     170      -2
> > > cpuacct_all_seq_show                         292     290      -2
> > > cpu_stop_init                                178     176      -2
> > > cpu_rmap_copy_neigh                          140     138      -2
> > > cpu_init_debugfs                             277     275      -2
> > > cppc_allow_fast_switch                       133     131      -2
> > > core_pmu_enable_all                          399     397      -2
> > > cleanup_srcu_struct                          424     422      -2
> > > cgroup_rstat_exit                            191     189      -2
> > > cgroup_release                               302     300      -2
> > > cgroup_exit                                  416     414      -2
> > > cgroup_can_fork                             1282    1280      -2
> > > bytes_transferred_show                       177     175      -2
> > > blkcg_reset_stats                            481     479      -2
> > > blk_mq_update_queue_map                      192     190      -2
> > > blk_mq_sysfs_init                            158     156      -2
> > > blk_mq_hw_sysfs_cpus_show                    289     287      -2
> > > arch_tlbbatch_flush                          248     246      -2
> > > arch_enable_hybrid_capacity_scale            241     239      -2
> > > apply_wqattrs_prepare                        502     500      -2
> > > apply_wqattrs_commit                         408     406      -2
> > > amd_uncore_ctx_init                          516     514      -2
> > > amd_pmu_enable_all                           132     130      -2
> > > amd_pmu_cpu_prepare                          340     338      -2
> > > amd_pmu_check_overflow                       177     175      -2
> > > amd_numa_init                                901     899      -2
> > > amd_detect_prefcore                          306     304      -2
> > > alloc_pages_bulk_mempolicy_noprof           1530    1528      -2
> > > alloc_cpu_rmap                               200     198      -2
> > > all_vm_events                                180     178      -2
> > > ahci_reset_controller                        301     299      -2
> > > add_del_listener                             565     563      -2
> > > acpi_processor_power_state_has_changed       418     416      -2
> > > acpi_map_cpuid                               147     145      -2
> > > acpi_get_psd_map                             367     365      -2
> > > acpi_cpufreq_probe                           490     488      -2
> > > _ieee80211_set_active_links                 1341    1339      -2
> > > __zone_set_pageset_high_and_batch            104     102      -2
> > > __sync_rcu_exp_select_node_cpus              954     952      -2
> > > __sched_clock_work                           261     259      -2
> > > __percpu_counter_sum                         136     134      -2
> > > __log_error                                  494     492      -2
> > > __dm_stat_init_temporary_percpu_totals       443     441      -2
> > > slabs_cpu_partial_show                       326     323      -3
> > > show_rcu_tasks_generic_gp_kthread            473     470      -3
> > > show_free_areas                             2871    2868      -3
> > > sched_balance_trigger                        923     920      -3
> > > ring_buffer_reset_online_cpus                323     320      -3
> > > relay_open                                   667     664      -3
> > > register_netdevice                          2022    2019      -3
> > > refresh_zone_stat_thresholds                 372     369      -3
> > > rebind_subsystems                           1264    1261      -3
> > > page_alloc_init_late                         754     751      -3
> > > out_of_memory                               1780    1777      -3
> > > mgts_show                                    328     325      -3
> > > init_mm_internals                            689     686      -3
> > > ieee80211_subif_start_xmit                  1121    1118      -3
> > > hugetlb_init                                1602    1599      -3
> > > hugetlb_acct_memory.part                    1112    1109      -3
> > > dm_stat_free                                 247     244      -3
> > > crypto_scomp_init_tfm                        261     258      -3
> > > blk_mq_map_queues                            213     210      -3
> > > blk_mq_hw_queue_to_node                      123     120      -3
> > > amd_pmu_cpu_starting                         379     376      -3
> > > update_qos_request                           250     246      -4
> > > tracing_open                                 955     951      -4
> > > snmp6_seq_show_item                          369     365      -4
> > > shrink_dcache_sb                             327     323      -4
> > > show_rcu_gp_kthreads                         834     830      -4
> > > set_pgdat_percpu_threshold                   182     178      -4
> > > select_fallback_rq                           718     714      -4
> > > sched_dl_do_global                           347     343      -4
> > > sbitmap_queue_show                           405     401      -4
> > > ring_buffer_reset                            230     226      -4
> > > rcu_tasks_kthread                            191     187      -4
> > > probe_event_enable                           862     858      -4
> > > perf_swevent_init                            492     488      -4
> > > pcpu_populate_chunk                         1017    1013      -4
> > > netstat_seq_show                             717     713      -4
> > > mce_end                                      651     647      -4
> > > intel_psr_invalidate                         667     663      -4
> > > intel_pmu_cpu_starting                      1706    1702      -4
> > > intel_dp_compute_link_config                1317    1313      -4
> > > ieee80211_vif_update_links                  2562    2558      -4
> > > hpet_open                                    491     487      -4
> > > housekeeping_setup                           617     613      -4
> > > ext4_attr_show                              1006    1002      -4
> > > elf_coredump_extra_notes_write               453     449      -4
> > > cpc_read_ffh                                  89      85      -4
> > > apply_wqattrs_cleanup.part                   233     229      -4
> > > zone_pcp_reset                               178     173      -5
> > > xt_free_table_info                           134     129      -5
> > > x86_pmu_enable_all                           377     372      -5
> > > wq_affn_dfl_set                              253     248      -5
> > > workqueue_init_topology                      271     266      -5
> > > try_check_zero                               438     433      -5
> > > swapfile_init                                220     215      -5
> > > start_kernel                                1996    1991      -5
> > > sta_get_last_rx_stats                        124     119      -5
> > > smpboot_register_percpu_thread               233     228      -5
> > > ring_buffer_free                             145     140      -5
> > > release_callchain_buffers_rcu                111     106      -5
> > > rcu_dump_cpu_stacks                          433     428      -5
> > > padata_do_parallel                           532     527      -5
> > > load_module                                 9704    9699      -5
> > > kvm_alloc_cpumask                            177     172      -5
> > > kvfree_rcu_init                              571     566      -5
> > > gro_cells_init                               257     252      -5
> > > free_fair_sched_group                        162     157      -5
> > > dst_cache_destroy                            141     136      -5
> > > cpuhp_smt_enable                             243     238      -5
> > > cgroup_print_ss_mask                         182     177      -5
> > > alloc_buffer                                1345    1340      -5
> > > __list_lru_init                              179     174      -5
> > > __group_cpus_evenly                         1254    1249      -5
> > > __fib6_drop_pcpu_from.part                   209     204      -5
> > > x86_pmu_disable_all                          411     405      -6
> > > trace_empty                                  233     227      -6
> > > tcp_v4_init                                  273     267      -6
> > > svc_seq_show                                 328     322      -6
> > > snmp_seq_show_tcp_udp.isra                   942     936      -6
> > > schedstat_next                               131     125      -6
> > > ring_buffer_wake_waiters                     191     185      -6
> > > perf_event_exit_cpu_context                  600     594      -6
> > > percpu_down_write                            400     394      -6
> > > pcpu_free_pages.isra                         169     163      -6
> > > pcpu_build_alloc_info                       1307    1301      -6
> > > packet_read_pending.isra                     105      99      -6
> > > nv_get_stats64                               402     396      -6
> > > net_dev_init                                 795     789      -6
> > > kvm_smp_send_call_func_ipi                   100      94      -6
> > > irq_migrate_all_off_this_cpu                 722     716      -6
> > > intel_engines_init_mmio                     3432    3426      -6
> > > init_timers                                  170     164      -6
> > > icmpv6_init                                  289     283      -6
> > > dma_channel_rebalance                        788     782      -6
> > > dl_bw_manage                                 805     799      -6
> > > cpufreq_dbs_governor_stop                    142     136      -6
> > > blk_mq_map_swqueue                          1057    1051      -6
> > > acpi_processor_throttling_init               788     782      -6
> > > __percpu_counter_limited_add                 481     475      -6
> > > __do_sys_swapon                             4260    4254      -6
> > > __cpuacct_percpu_seq_show                    163     157      -6
> > > wq_update_node_max_active                    529     522      -7
> > > sysrq_timer_list_show                        277     270      -7
> > > smpboot_destroy_threads                      150     143      -7
> > > smp_call_function_many_cond                 1320    1313      -7
> > > setup_cpu_entry_areas                        932     925      -7
> > > regmap_field_init                            122     115      -7
> > > mst_stream_compute_config                   1659    1652      -7
> > > lpit_read_residency_counter_us               309     302      -7
> > > free_node_nr_active                          165     158      -7
> > > dl_server_apply_params                       972     965      -7
> > > cpu_down_maps_locked                         203     196      -7
> > > alloc_workqueue                             2078    2071      -7
> > > __is_module_percpu_address                   283     276      -7
> > > sta_set_sinfo                               3014    3006      -8
> > > show_softirqs                                334     326      -8
> > > populate_cache_leaves                       1389    1381      -8
> > > is_mddev_idle                                471     463      -8
> > > irq_matrix_reserve_managed                   350     342      -8
> > > intel_psr_flush                              982     974      -8
> > > get_callchain_buffers                        414     406      -8
> > > find_next_best_node                          275     267      -8
> > > drv_change_vif_links                         635     627      -8
> > > core_guest_get_msrs                          347     339      -8
> > > check_hw_exists                             1074    1066      -8
> > > __do_sys_swapoff                            3766    3758      -8
> > > __dl_server_attach_root                      238     230      -8
> > > x86_reserve_hardware                         680     671      -9
> > > smp_shutdown_nonboot_cpus                    198     189      -9
> > > schedstat_start                              125     116      -9
> > > do_kmem_cache_create                        1252    1243      -9
> > > cache_shared_cpu_map_remove                  340     331      -9
> > > bioset_exit                                  381     372      -9
> > > reserve_ds_buffers                          1595    1585     -10
> > > hugetlb_cgroup_free                          127     117     -10
> > > flush_all_cpus_locked                        349     339     -10
> > > cpu_rmap_update                              573     563     -10
> > > compaction_proactiveness_sysctl_handler      298     288     -10
> > > ahci_save_initial_config                    1170    1160     -10
> > > __build_all_zonelists                        229     219     -10
> > > numa_set_distance                            578     567     -11
> > > init_pod_type                                588     577     -11
> > > del_from_avail_list                          220     209     -11
> > > weighted_interleave_nid                      385     373     -12
> > > sched_dl_overflow                           1326    1314     -12
> > > rcu_sched_clock_irq                         4343    4331     -12
> > > icmp_init                                    286     274     -12
> > > hugetlb_cgroup_read_numa_stat                607     595     -12
> > > acpi_processor_preregister_performance      1174    1162     -12
> > > sysctl_compaction_handler                    196     183     -13
> > > release_ds_buffers                           310     297     -13
> > > mempolicy_sysfs_init                         664     651     -13
> > > intel_drrs_activate                          392     379     -13
> > > cgroup_migrate_execute                      1151    1138     -13
> > > sched_init_numa                             1916    1902     -14
> > > dev_get_stats                                816     802     -14
> > > __reserve_bp_slot                            679     664     -15
> > > dl_task_timer                               1511    1495     -16
> > > __pfx_intel_pstate_update_policies            16       -     -16
> > > numa_init                                    729     712     -17
> > > __acpi_processor_set_throttling             1132    1112     -20
> > > ring_buffer_resize                          1319    1292     -27
> > > cppc_perf_ctrs_in_pcc                        309     276     -33
> > > intel_pstate_update_policies                  90       -     -90
> > > Total: Before=22438085, After=22436816, chg -0.01%
> > > 
> > > * Code size shrkinking ( gcc-12 for x86_64 NR_CPUS=64 ):
> > > 
> > > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new 
> > > add/remove: 4/4 grow/shrink: 57/500 up/down: 1026/-2028 (-1002)
> > > Function                                     old     new   delta
> > > lpit_read_residency_counter_us                 -     302    +302
> > > trace_total_entries                          107     208    +101
> > > get_total_entries_cpu                          -     101    +101
> > > store_min_perf_pct                           275     368     +93
> > > store_hwp_dynamic_boost                      138     225     +87
> > > store_max_perf_pct                           253     336     +83
> > > alloc_pages_bulk_mempolicy_noprof           1556    1589     +33
> > > rcu_exp_wait_wake                           2620    2651     +31
> > > hybrid_update_cpu_capacity_scaling           311     332     +21
> > > __pfx_lpit_read_residency_counter_us           -      16     +16
> > > __pfx_get_total_entries_cpu                    -      16     +16
> > > get_total_entries                            203     215     +12
> > > apply_wqattrs_prepare                        516     524      +8
> > > sock_prot_inuse_get                          121     128      +7
> > > ring_buffer_empty                            271     278      +7
> > > numa_policy_init                             602     609      +7
> > > gnet_stats_add_basic                         183     190      +7
> > > amd_uncore_ctx_move                          286     292      +6
> > > rebind_subsystems                           1261    1266      +5
> > > blk_mq_flush_busy_ctxs                       463     468      +5
> > > __i915_gem_object_set_pages                  545     550      +5
> > > select_task_rq_fair                         4447    4451      +4
> > > reclaim_throttle                             756     760      +4
> > > rcu_init                                    2387    2391      +4
> > > kstat_irqs_desc                              118     122      +4
> > > dev_change_proto_down_reason                 164     168      +4
> > > calibrate_delay_is_known                     237     241      +4
> > > x86_reserve_hardware                         648     651      +3
> > > tracing_total_entries_read                   346     349      +3
> > > remove_siblinginfo                          1038    1041      +3
> > > cpuset_mem_spread_node                       297     300      +3
> > > qdisc_alloc                                  472     474      +2
> > > probes_profile_seq_show                      387     389      +2
> > > low_power_idle_cpu_residency_us_show         100     102      +2
> > > clocksource_verify_percpu.part              1071    1073      +2
> > > cgroup_propagate_control                     405     407      +2
> > > blk_mq_init_allocated_queue                  976     978      +2
> > > __lru_add_drain_all                          502     504      +2
> > > zone_reclaimable_pages                       692     693      +1
> > > tcp_orphan_count_sum                         107     108      +1
> > > srcu_torture_stats_print                     537     538      +1
> > > sock_inuse_get                               102     103      +1
> > > sched_balance_rq                            3682    3683      +1
> > > proc_nr_inodes                               173     174      +1
> > > percpu_ref_switch_to_atomic_rcu              370     371      +1
> > > nr_processes                                 102     103      +1
> > > netdev_refcnt_read                           102     103      +1
> > > mq_dump_class_stats                          234     235      +1
> > > mnt_get_writers                               96      97      +1
> > > mnt_get_count                                 99     100      +1
> > > intel_engines_init_mmio                     3389    3390      +1
> > > input_register_device                       1291    1292      +1
> > > ieee80211_rx_mgmt_beacon                    6109    6110      +1
> > > hpet_open                                    491     492      +1
> > > get_nr_inodes                                106     107      +1
> > > get_nr_dirty_inodes                          153     154      +1
> > > cache_shared_cpu_map_remove                  297     298      +1
> > > allow_direct_reclaim                         318     319      +1
> > > alloc_fd                                     376     377      +1
> > > acpi_extract_apple_properties                973     974      +1
> > > __is_kernel_percpu_address                   177     178      +1
> > > zoneinfo_show                                823     822      -1
> > > zhaoxin_pmu_handle_irq                       776     775      -1
> > > zhaoxin_arch_events_quirk                    137     136      -1
> > > xt_init                                      297     296      -1
> > > x86_pmu_handle_irq                           484     483      -1
> > > x86_pmu_enable_all                           382     381      -1
> > > wake_up_all_idle_cpus                        142     141      -1
> > > uprobe_buffer_disable                        165     164      -1
> > > update_per_cpu_data_slice_size               216     215      -1
> > > unregister_netdevice_many_notify            2299    2298      -1
> > > uncore_pmu_hrtimer                           261     260      -1
> > > uncore_event_cpu_offline                     349     348      -1
> > > uncore_device_to_die                         163     162      -1
> > > tsc_store_and_check_tsc_adjust               507     506      -1
> > > tsc_restore_sched_clock_state                223     222      -1
> > > tsc_refine_calibration_work                  938     937      -1
> > > try_to_unmap_one                            2485    2484      -1
> > > try_to_migrate_one                          2162    2161      -1
> > > trace_buffered_event_enable                  347     346      -1
> > > tmigr_cpu_offline                            404     403      -1
> > > timer_list_start                             159     158      -1
> > > tick_handle_oneshot_broadcast                380     379      -1
> > > tick_clock_notify                            109     108      -1
> > > tick_broadcast_setup_oneshot                 288     287      -1
> > > thaw_secondary_cpus                          424     423      -1
> > > tcp_sigpool_alloc_ahash                      934     933      -1
> > > tc_fill_qdisc                               1125    1124      -1
> > > sysctl_vm_numa_stat_handler                  456     455      -1
> > > sync_runqueues_membarrier_state              319     318      -1
> > > sw_perf_event_destroy                        133     132      -1
> > > svc_create_pooled                            807     806      -1
> > > sugov_stop                                   141     140      -1
> > > store_no_turbo                               653     652      -1
> > > snmp_fold_field                              113     112      -1
> > > smp_call_function_any                        261     260      -1
> > > show_stat                                   2316    2315      -1
> > > show_rcu_tasks_generic_gp_kthread            455     454      -1
> > > setup_swap_info                              235     234      -1
> > > sched_update_numa                            426     425      -1
> > > sbitmap_init_node                            498     497      -1
> > > rto_next_cpu                                 137     136      -1
> > > rtm_new_nexthop                             5400    5399      -1
> > > rt6_disable_ip                               716     715      -1
> > > relay_reset                                  198     197      -1
> > > relay_flush                                  198     197      -1
> > > relay_close                                  358     357      -1
> > > reclaim_and_purge_vmap_areas                 450     449      -1
> > > rdmacg_resource_set_max                      894     893      -1
> > > rcu_tasks_trace_pregp_step                  1143    1142      -1
> > > rcu_spawn_gp_kthread                         645     644      -1
> > > rcu_spawn_exp_par_gp_kworker                 387     386      -1
> > > rcu_report_exp_cpu_mult                      175     174      -1
> > > rcu_barrier_tasks_generic                    463     462      -1
> > > rcu_barrier                                  874     873      -1
> > > pull_dl_task                                 845     844      -1
> > > pti_init                                     535     534      -1
> > > print_ICs                                    299     298      -1
> > > pfifo_fast_reset                             349     348      -1
> > > perf_trace_event_init                        735     734      -1
> > > perf_reboot                                  106     105      -1
> > > perf_event_print_debug                      1219    1218      -1
> > > percpu_counter_set                           127     126      -1
> > > pcpu_setup_first_chunk                      1989    1988      -1
> > > pcpu_free_pages.constprop                    176     175      -1
> > > pcpu_depopulate_chunk                        412     411      -1
> > > pcpu_alloc_noprof                           1945    1944      -1
> > > partition_sched_domains_locked              1127    1126      -1
> > > p4_pmu_handle_irq                            682     681      -1
> > > od_set_powersave_bias                        216     215      -1
> > > node_dev_init                                189     188      -1
> > > nh_fill_node                                2439    2438      -1
> > > nfs_show_stats                              1147    1146      -1
> > > netstat_seq_show                             720     719      -1
> > > neightbl_fill_info.constprop                1064    1063      -1
> > > native_stop_other_cpus                       421     420      -1
> > > mm_init.constprop                            898     897      -1
> > > memory_tier_late_init                       1763    1762      -1
> > > mem_init                                     520     519      -1
> > > kswapd_init                                  110     109      -1
> > > kmem_cache_init                              369     368      -1
> > > kcompactd_init                               242     241      -1
> > > irq_alloc_matrix                             247     246      -1
> > > ipv6_add_dev                                1303    1302      -1
> > > ipv4_mib_init_net                            509     508      -1
> > > ip_rt_init                                   589     588      -1
> > > ip6_route_init                               563     562      -1
> > > iova_domain_init_rcaches                     458     457      -1
> > > intel_pstate_driver_cleanup                  223     222      -1
> > > intel_gt_mcr_init                            886     885      -1
> > > intel_get_event_constraints                  846     845      -1
> > > intel_arch_events_quirk                      137     136      -1
> > > input_leds_connect                           724     723      -1
> > > init_sched_rt_class                          101     100      -1
> > > init_sched_dl_class                          101     100      -1
> > > init_gi_nodes                                132     131      -1
> > > inet6_net_init                               651     650      -1
> > > ieee80211_subif_start_xmit                  1127    1126      -1
> > > i915_pmu_cpu_offline                         230     229      -1
> > > hybrid_set_capacity_of_cpus                  137     136      -1
> > > housekeeping_init                            124     123      -1
> > > group_cpus_evenly                            430     429      -1
> > > gnet_stats_add_queue                         213     212      -1
> > > gen11_gt_irq_handler                         911     910      -1
> > > free_acpi_perf_data                           75      74      -1
> > > fold_vm_zone_numa_events                     232     231      -1
> > > flow_limit_cpu_sysctl                        525     524      -1
> > > filelock_init                                396     395      -1
> > > elf_coredump_extra_notes_size                107     106      -1
> > > dst_cache_reset_now                          163     162      -1
> > > do_migrate_pages                             807     806      -1
> > > dm_stats_init                                195     194      -1
> > > dl_cpuset_cpumask_can_shrink                 267     266      -1
> > > dl_bw_cpus                                   136     135      -1
> > > disable_freq_invariance_workfn               118     117      -1
> > > default_send_IPI_mask_allbutself_phys        287     286      -1
> > > crash_prepare_elf64_headers                  566     565      -1
> > > cpupri_init                                  182     181      -1
> > > cpupri_find_fitness                          416     415      -1
> > > cpuhp_sysfs_init                             265     264      -1
> > > cpuhp_smt_disable                            213     212      -1
> > > cpuhp_rollback_install                       186     185      -1
> > > cpufreq_set_policy                           801     800      -1
> > > cpufreq_policy_free                          385     384      -1
> > > cpufreq_online                              2578    2577      -1
> > > cpufreq_dbs_governor_start                   443     442      -1
> > > cpufreq_dbs_governor_init                    681     680      -1
> > > cpudl_init                                   159     158      -1
> > > cpuacct_stats_show                           380     379      -1
> > > cpu_map_shared_cache                         260     259      -1
> > > cpu_dev_init                                 228     227      -1
> > > cpc_write_ffh                                167     166      -1
> > > compaction_zonelist_suitable                 329     328      -1
> > > clock_was_set                                561     560      -1
> > > cgroup_subtree_control_write                 997     996      -1
> > > cgroup_rstat_init                            168     167      -1
> > > cgroup_rstat_boot                            105     104      -1
> > > cgroup_print_ss_mask                         182     181      -1
> > > cgroup_post_fork                             614     613      -1
> > > cgroup_base_stat_cputime_show                760     759      -1
> > > can_migrate_task                             519     518      -1
> > > call_function_init                           171     170      -1
> > > build_all_zonelists_init                     277     276      -1
> > > bpf_prog_alloc                               166     165      -1
> > > blkg_alloc                                   481     480      -1
> > > blkcg_print_stat                             880     879      -1
> > > blkcg_iolatency_done_bio                    1826    1825      -1
> > > blkcg_css_alloc                              568     567      -1
> > > blk_stat_timer_fn                            372     371      -1
> > > blk_stat_add_callback                        249     248      -1
> > > blk_mq_sysfs_deinit                          123     122      -1
> > > blk_mq_map_hw_queues                         175     174      -1
> > > blk_mq_init                                  358     357      -1
> > > blk_iocost_init                              621     620      -1
> > > begin_new_exec                              2860    2859      -1
> > > asym_cpu_capacity_scan                       605     604      -1
> > > amd_uncore_umc_ctx_init                      896     895      -1
> > > amd_pstate_change_mode_without_dvr_change     133     132      -1
> > > amd_pmu_v2_handle_irq                       1101    1100      -1
> > > amd_pmu_enable_all                           139     138      -1
> > > alloc_iova_fast                              680     679      -1
> > > alloc_desc                                   492     491      -1
> > > ahci_save_initial_config                    1164    1163      -1
> > > addrconf_disable_policy_idev                 322     321      -1
> > > add_to_avail_list                            310     309      -1
> > > acpi_cpc_valid                               130     129      -1
> > > _vm_unmap_aliases                            647     646      -1
> > > __percpu_ref_switch_mode                     543     542      -1
> > > __ftrace_clear_event_pids                    605     604      -1
> > > __drain_swap_slots_cache                      90      89      -1
> > > __drain_all_pages                            449     448      -1
> > > __dm_stat_init_temporary_percpu_totals       442     441      -1
> > > __copy_xstate_to_uabi_buf                   2457    2456      -1
> > > __alloc_frozen_pages_noprof                 4020    4019      -1
> > > ___gnet_stats_copy_basic.isra                387     386      -1
> > > zone_pcp_enable                              127     125      -2
> > > xhci_bus_resume                             1011    1009      -2
> > > xfrm_input_init                              230     228      -2
> > > xfeature_get_offset                          137     135      -2
> > > x86_release_hardware                         289     287      -2
> > > workqueue_online_cpu                         756     754      -2
> > > workqueue_offline_cpu                        550     548      -2
> > > weighted_interleave_nodes                    311     309      -2
> > > vmalloc_init                                1064    1062      -2
> > > vmalloc_info_show                           1000     998      -2
> > > update_or_create_fnhe                        902     900      -2
> > > update_group_capacity                        556     554      -2
> > > tsc_init                                     882     880      -2
> > > try_to_generate_entropy                      633     631      -2
> > > tracing_set_cpumask                          284     282      -2
> > > tracing_release                              336     334      -2
> > > tracing_entries_read                         453     451      -2
> > > trace_rb_cpu_prepare                         213     211      -2
> > > toggle_bp_slot.constprop                    2625    2623      -2
> > > timekeeping_get_mg_floor_swaps               111     109      -2
> > > tcf_idr_create                               639     637      -2
> > > task_non_contending                          829     827      -2
> > > task_mm_cid_work                             498     496      -2
> > > srcu_readers_active                          128     126      -2
> > > srcu_barrier                                 515     513      -2
> > > softirq_init                                 150     148      -2
> > > snmp_seq_show_ipstats.constprop.isra         374     372      -2
> > > snmp6_seq_show_item64.constprop              264     262      -2
> > > snapshot_write_next                         2486    2484      -2
> > > snapshot_read_next                           626     624      -2
> > > smp_prepare_cpus_common                      339     337      -2
> > > skx_pmu_get_topology                         313     311      -2
> > > show_slab_objects                           1071    1069      -2
> > > show_numa_map                                980     978      -2
> > > show_interrupts                              817     815      -2
> > > shmem_cppc_enable                            225     223      -2
> > > setup_zone_pageset                           327     325      -2
> > > setup_per_cpu_pageset                        266     264      -2
> > > set_cpus_allowed_dl                          276     274      -2
> > > set_cpu_sibling_map                         1693    1691      -2
> > > set_buffer_entries                            93      91      -2
> > > seq_hlist_next_percpu                        202     200      -2
> > > send_pcc_cmd                                 656     654      -2
> > > scsi_show_rq                                 800     798      -2
> > > schedule_on_each_cpu                         335     333      -2
> > > s_start                                      865     863      -2
> > > ring_buffer_subbuf_order_set                1229    1227      -2
> > > ring_buffer_overruns                         107     105      -2
> > > ring_buffer_entries                          124     122      -2
> > > recalc_bh_state.part                         122     120      -2
> > > rcu_gp_cleanup                              1556    1554      -2
> > > rcu_dump_cpu_stacks                          370     368      -2
> > > rcu_check_boost_fail                         467     465      -2
> > > rcec_assoc_rciep.isra                        116     114      -2
> > > pt_init                                      981     979      -2
> > > process_srcu                                1679    1677      -2
> > > phys_package_first_cpu                       122     120      -2
> > > perf_output_sample_regs                      181     179      -2
> > > perf_event_mux_interval_ms_store             365     363      -2
> > > percpu_is_read_locked                        126     124      -2
> > > per_cpu_ptr_to_phys                          266     264      -2
> > > part_stat_read_all                           193     191      -2
> > > part_inflight_show                           308     306      -2
> > > part_in_flight                               133     131      -2
> > > padata_do_serial                             225     223      -2
> > > padata_do_multithreaded                      867     865      -2
> > > padata_alloc_pd                              482     480      -2
> > > p4_pmu_enable_all                            139     137      -2
> > > numa_nearest_node                            210     208      -2
> > > nr_iowait                                    105     103      -2
> > > nr_context_switches                          112     110      -2
> > > node_read_distance                           234     232      -2
> > > netif_get_num_default_rss_queues             157     155      -2
> > > net_dev_init                                 795     793      -2
> > > native_smp_cpus_done                         657     655      -2
> > > metadata_dst_alloc_percpu                    370     368      -2
> > > memcpy_count_show                            176     174      -2
> > > membarrier_global_expedited                  330     328      -2
> > > mce_read_aux                                 394     392      -2
> > > loopback_get_stats64                         145     143      -2
> > > kyber_timer_fn                               596     594      -2
> > > kvm_flush_tlb_multi                          149     147      -2
> > > kfree_rcu_shrink_count                       157     155      -2
> > > kcore_update_ram.isra                        783     781      -2
> > > iommu_dma_init_fq                            500     498      -2
> > > iolatency_pd_init                            495     493      -2
> > > interleave_nodes                             163     161      -2
> > > interleave_nid                               217     215      -2
> > > intel_pmu_drain_pebs_icl                     866     864      -2
> > > intel_gt_init_workarounds                   4160    4158      -2
> > > init_timers                                  173     171      -2
> > > init_sched_fair_class                        213     211      -2
> > > init_cpu_to_node                             284     282      -2
> > > inactive_task_timer                          971     969      -2
> > > ieee80211_sta_last_active                    152     150      -2
> > > ieee80211_add_rx_radiotap_header            2290    2288      -2
> > > idle_threads_init                            181     179      -2
> > > icl_display_core_init                       2340    2338      -2
> > > hw_breakpoint_is_used                        207     205      -2
> > > get_nohz_timer_target                        317     315      -2
> > > ftrace_dump_one                              731     729      -2
> > > free_policy_dbs_info                         124     122      -2
> > > free_iova_rcaches                            285     283      -2
> > > free_area_init                              3984    3982      -2
> > > fq_flush_timeout                             234     232      -2
> > > flush_tlb_mm_range                           427     425      -2
> > > ext4_update_super                            942     940      -2
> > > ext4_mb_init                                1965    1963      -2
> > > ext4_journal_commit_callback                 470     468      -2
> > > ext4_fill_super                            13081   13079      -2
> > > drv_change_sta_links                         621     619      -2
> > > drop_slab                                    223     221      -2
> > > do_ipt_set_ctl                              1559    1557      -2
> > > do_ip6t_set_ctl                             1583    1581      -2
> > > dma_channel_table_init                       279     277      -2
> > > dm_wait_for_completion                       409     407      -2
> > > dl_clear_root_domain                         176     174      -2
> > > dl_add_task_root_domain                      337     335      -2
> > > dev_lstats_read                              137     135      -2
> > > dev_fetch_sw_netstats                        179     177      -2
> > > detect_cache_attributes                      756     754      -2
> > > del_gendisk                                  849     847      -2
> > > default_hugepagesz_setup                     454     452      -2
> > > cpuusage_write                               199     197      -2
> > > cpuusage_user_read                           120     118      -2
> > > cpuusage_sys_read                            125     123      -2
> > > cpuusage_read                                111     109      -2
> > > cpuidle_driver_state_disabled                234     232      -2
> > > cpufreq_show_cpus                            172     170      -2
> > > cpufreq_notify_transition                    281     279      -2
> > > cpufreq_driver_fast_switch                   220     218      -2
> > > cpuacct_all_seq_show                         292     290      -2
> > > cpu_stop_init                                178     176      -2
> > > cpu_rmap_copy_neigh                          140     138      -2
> > > cpu_init_debugfs                             277     275      -2
> > > cppc_allow_fast_switch                       133     131      -2
> > > cleanup_srcu_struct                          424     422      -2
> > > cgroup_rstat_exit                            191     189      -2
> > > cgroup_release                               302     300      -2
> > > cgroup_exit                                  416     414      -2
> > > cgroup_can_fork                             1277    1275      -2
> > > bytes_transferred_show                       177     175      -2
> > > blkcg_reset_stats                            481     479      -2
> > > blk_mq_update_queue_map                      192     190      -2
> > > blk_mq_sysfs_init                            158     156      -2
> > > blk_mq_hw_sysfs_cpus_show                    289     287      -2
> > > arch_tlbbatch_flush                          253     251      -2
> > > arch_enable_hybrid_capacity_scale            245     243      -2
> > > apply_wqattrs_commit                         408     406      -2
> > > amd_uncore_ctx_init                          516     514      -2
> > > amd_pmu_cpu_prepare                          340     338      -2
> > > amd_pmu_check_overflow                       173     171      -2
> > > amd_numa_init                                892     890      -2
> > > alloc_cpu_rmap                               200     198      -2
> > > all_vm_events                                180     178      -2
> > > add_del_listener                             565     563      -2
> > > acpi_processor_power_state_has_changed       418     416      -2
> > > acpi_map_cpuid                               147     145      -2
> > > acpi_get_psd_map                             367     365      -2
> > > acpi_cpufreq_probe                           493     491      -2
> > > _ieee80211_set_active_links                 1341    1339      -2
> > > __zone_set_pageset_high_and_batch            104     102      -2
> > > __sync_rcu_exp_select_node_cpus              954     952      -2
> > > __sched_clock_work                           261     259      -2
> > > __percpu_counter_sum                         136     134      -2
> > > __log_error                                  494     492      -2
> > > __do_sys_swapon                             4497    4495      -2
> > > smp_call_function_many_cond                 1320    1317      -3
> > > slabs_cpu_partial_show                       326     323      -3
> > > show_free_areas                             2826    2823      -3
> > > ring_buffer_reset_online_cpus                323     320      -3
> > > relay_open                                   667     664      -3
> > > register_netdevice                          2041    2038      -3
> > > refresh_zone_stat_thresholds                 372     369      -3
> > > perf_event_init                              841     838      -3
> > > page_alloc_init_late                         754     751      -3
> > > out_of_memory                               1759    1756      -3
> > > netdev_rx_queue_set_rps_mask                 292     289      -3
> > > mgts_show                                    328     325      -3
> > > ioc_timer_fn                                4933    4930      -3
> > > init_mm_internals                            689     686      -3
> > > ieee80211_vif_update_links                  2506    2503      -3
> > > hugetlb_init                                1565    1562      -3
> > > hugetlb_acct_memory.part                    1112    1109      -3
> > > dm_stat_free                                 247     244      -3
> > > crypto_scomp_init_tfm                        261     258      -3
> > > blk_mq_map_queues                            204     201      -3
> > > blk_mq_hw_queue_to_node                      123     120      -3
> > > amd_pmu_cpu_starting                         379     376      -3
> > > workqueue_init                               930     926      -4
> > > update_qos_request                           250     246      -4
> > > tracing_open                                 972     968      -4
> > > snmp6_seq_show_item                          369     365      -4
> > > shrink_dcache_sb                             327     323      -4
> > > show_rcu_gp_kthreads                         834     830      -4
> > > set_pgdat_percpu_threshold                   182     178      -4
> > > select_fallback_rq                           718     714      -4
> > > sched_dl_do_global                           347     343      -4
> > > sbitmap_queue_show                           405     401      -4
> > > ring_buffer_reset                            230     226      -4
> > > rcu_tasks_kthread                            191     187      -4
> > > perf_swevent_init                            492     488      -4
> > > mce_end                                      651     647      -4
> > > intel_pmu_cpu_starting                      1721    1717      -4
> > > intel_dp_compute_link_config                1331    1327      -4
> > > housekeeping_setup                           617     613      -4
> > > ext4_mb_new_blocks                          3703    3699      -4
> > > ext4_attr_show                              1011    1007      -4
> > > elf_coredump_extra_notes_write               453     449      -4
> > > cpc_read_ffh                                  89      85      -4
> > > apply_wqattrs_cleanup.part                   233     229      -4
> > > zone_pcp_reset                               178     173      -5
> > > xt_free_table_info                           134     129      -5
> > > wq_affn_dfl_set                              253     248      -5
> > > workqueue_init_topology                      271     266      -5
> > > try_check_zero                               438     433      -5
> > > swapfile_init                                220     215      -5
> > > start_kernel                                1994    1989      -5
> > > sta_get_last_rx_stats                        124     119      -5
> > > smpboot_register_percpu_thread               233     228      -5
> > > ring_buffer_free                             145     140      -5
> > > release_callchain_buffers_rcu                111     106      -5
> > > probe_event_enable                           872     867      -5
> > > pcpu_populate_chunk                         1088    1083      -5
> > > padata_do_parallel                           520     515      -5
> > > kvm_alloc_cpumask                            177     172      -5
> > > kvfree_rcu_init                              571     566      -5
> > > init_pod_type                                586     581      -5
> > > gro_cells_init                               257     252      -5
> > > gro_cells_destroy                            342     337      -5
> > > free_fair_sched_group                        162     157      -5
> > > dst_cache_destroy                            141     136      -5
> > > cpuhp_smt_enable                             243     238      -5
> > > amd_detect_prefcore                          304     299      -5
> > > alloc_buffer                                1352    1347      -5
> > > __list_lru_init                              179     174      -5
> > > __fib6_drop_pcpu_from.part                   209     204      -5
> > > __acpi_processor_set_throttling             1117    1112      -5
> > > trace_empty                                  233     227      -6
> > > tcp_v4_init                                  273     267      -6
> > > svc_seq_show                                 331     325      -6
> > > snmp_seq_show_tcp_udp.constprop.isra         942     936      -6
> > > seq_hlist_start_percpu                       138     132      -6
> > > schedstat_next                               131     125      -6
> > > ring_buffer_wake_waiters                     191     185      -6
> > > perf_event_exit_cpu_context                  593     587      -6
> > > percpu_down_write                            400     394      -6
> > > pcpu_build_alloc_info                       1315    1309      -6
> > > packet_read_pending.isra                     105      99      -6
> > > nv_get_stats64                               402     396      -6
> > > kvm_smp_send_call_func_ipi                   100      94      -6
> > > irq_migrate_all_off_this_cpu                 722     716      -6
> > > icmpv6_init                                  289     283      -6
> > > dl_bw_manage                                 785     779      -6
> > > cpufreq_dbs_governor_stop                    142     136      -6
> > > blk_mq_map_swqueue                          1057    1051      -6
> > > ahci_reset_controller                        308     302      -6
> > > acpi_processor_throttling_init               788     782      -6
> > > __cpuacct_percpu_seq_show                    163     157      -6
> > > wq_update_node_max_active                    529     522      -7
> > > sysrq_timer_list_show                        277     270      -7
> > > smpboot_destroy_threads                      150     143      -7
> > > setup_cpu_entry_areas                        932     925      -7
> > > regmap_field_init                            135     128      -7
> > > mst_stream_compute_config                   1659    1652      -7
> > > free_node_nr_active                          165     158      -7
> > > drv_change_vif_links                         635     628      -7
> > > do_ipt_get_ctl                              1181    1174      -7
> > > cpu_down_maps_locked                         203     196      -7
> > > core_guest_get_msrs                          374     367      -7
> > > alloc_workqueue                             1929    1922      -7
> > > __is_module_percpu_address                   283     276      -7
> > > sta_set_sinfo                               3023    3015      -8
> > > show_softirqs                                334     326      -8
> > > populate_cache_leaves                       1389    1381      -8
> > > is_mddev_idle                                471     463      -8
> > > irq_matrix_reserve_managed                   350     342      -8
> > > intel_psr_flush                              985     977      -8
> > > get_callchain_buffers                        414     406      -8
> > > find_next_best_node                          276     268      -8
> > > core_pmu_enable_all                          402     394      -8
> > > __percpu_counter_limited_add                 435     427      -8
> > > __do_sys_swapoff                            3799    3791      -8
> > > __dl_server_attach_root                      238     230      -8
> > > smp_shutdown_nonboot_cpus                    198     189      -9
> > > schedstat_start                              125     116      -9
> > > reserve_ds_buffers                          1597    1588      -9
> > > do_kmem_cache_create                        1239    1230      -9
> > > dma_channel_rebalance                        761     752      -9
> > > bioset_exit                                  381     372      -9
> > > __group_cpus_evenly                         1264    1255      -9
> > > sched_balance_trigger                        900     890     -10
> > > hugetlb_cgroup_free                          127     117     -10
> > > flush_all_cpus_locked                        349     339     -10
> > > dl_server_apply_params                       976     966     -10
> > > compaction_proactiveness_sysctl_handler      301     291     -10
> > > __build_all_zonelists                        229     219     -10
> > > numa_set_distance                            578     567     -11
> > > do_ip6t_get_ctl                             1206    1195     -11
> > > del_from_avail_list                          220     209     -11
> > > cpu_rmap_update                              623     612     -11
> > > x86_pmu_disable_all                          422     410     -12
> > > weighted_interleave_nid                      385     373     -12
> > > rcu_sched_clock_irq                         4324    4312     -12
> > > icmp_init                                    286     274     -12
> > > hugetlb_cgroup_read_numa_stat                607     595     -12
> > > check_hw_exists                             1060    1048     -12
> > > cgroup_migrate_execute                      1136    1124     -12
> > > acpi_processor_preregister_performance      1174    1162     -12
> > > __reserve_bp_slot                            593     581     -12
> > > sysctl_compaction_handler                    196     183     -13
> > > sched_dl_overflow                           1308    1295     -13
> > > release_ds_buffers                           310     297     -13
> > > mempolicy_sysfs_init                         664     651     -13
> > > intel_drrs_activate                          392     379     -13
> > > sched_init_numa                             1874    1860     -14
> > > dev_get_stats                                816     802     -14
> > > perf_assign_events                           927     912     -15
> > > dl_task_timer                               1540    1524     -16
> > > __pfx_lpit_read_residency_counter_us.part      16       -     -16
> > > __pfx_intel_pstate_update_policies            16       -     -16
> > > numa_init                                    739     722     -17
> > > dm_stats_message                            4430    4410     -20
> > > fpu__init_system_xstate                     3798    3774     -24
> > > low_power_idle_system_residency_us_show      130     105     -25
> > > ring_buffer_resize                          1319    1292     -27
> > > cppc_perf_ctrs_in_pcc                        309     276     -33
> > > load_module                                 9691    9631     -60
> > > intel_pstate_update_policies                  90       -     -90
> > > lpit_read_residency_counter_us.part          191       -    -191
> > > Total: Before=22453915, After=22452913, chg -0.00%
> > > 
> > > * Code size shrinking ( gcc-11 for x86_64 NR_CPUS=64 ):
> > > 
> > > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new 
> > > add/remove: 0/2 grow/shrink: 36/518 up/down: 564/-1771 (-1207)
> > > Function                                     old     new   delta
> > > metadata_dst_free_percpu                     165     276    +111
> > > store_min_perf_pct                           267     371    +104
> > > store_max_perf_pct                           245     345    +100
> > > store_hwp_dynamic_boost                      130     223     +93
> > > intel_psr_invalidate                         645     662     +17
> > > hybrid_update_cpu_capacity_scaling           291     307     +16
> > > proc_nr_dentry                               387     402     +15
> > > __alloc_frozen_pages_noprof                 4069    4084     +15
> > > show_slab_objects                           1067    1081     +14
> > > pcpu_build_alloc_info                       1336    1348     +12
> > > tracing_total_entries_read                   364     371      +7
> > > sbitmap_queue_show                           406     412      +6
> > > ieee80211_subif_start_xmit                  1124    1129      +5
> > > ieee80211_rx_mgmt_beacon                    6008    6013      +5
> > > __i915_gem_object_set_pages                  567     572      +5
> > > rcu_init                                    2429    2433      +4
> > > tracing_set_cpumask                          284     287      +3
> > > numa_policy_init                             569     572      +3
> > > can_migrate_task                             537     540      +3
> > > amd_uncore_ctx_move                          323     326      +3
> > > unregister_fair_sched_group                  546     548      +2
> > > tsc_store_and_check_tsc_adjust               503     505      +2
> > > sched_dl_overflow                           1309    1311      +2
> > > part_stat_read_all                           254     256      +2
> > > intel_engines_init_mmio                     3368    3370      +2
> > > gnet_stats_add_queue                         212     214      +2
> > > cpc_write_ffh                                157     159      +2
> > > workqueue_init                               881     882      +1
> > > snmp6_seq_show_item64.constprop              261     262      +1
> > > seq_hlist_next_percpu                        196     197      +1
> > > reclaim_throttle                             763     764      +1
> > > hswep_uncore_sbox_msr_init_box               192     193      +1
> > > dev_change_proto_down_reason                 153     154      +1
> > > cleanup_srcu_struct                          409     410      +1
> > > alloc_fd                                     411     412      +1
> > > __snmp6_fill_stats64.constprop               304     305      +1
> > > zoneinfo_show                                853     852      -1
> > > zone_watermark_ok_safe                       175     174      -1
> > > zone_pcp_reset                               181     180      -1
> > > zhaoxin_arch_events_quirk                    139     138      -1
> > > xt_init                                      317     316      -1
> > > x86_pmu_enable_all                           380     379      -1
> > > wq_affn_dfl_set                              266     265      -1
> > > wake_up_all_idle_cpus                        144     143      -1
> > > uprobe_buffer_disable                        167     166      -1
> > > uncore_event_cpu_offline                     395     394      -1
> > > tsc_refine_calibration_work                  886     885      -1
> > > try_to_unmap_one                            2424    2423      -1
> > > try_to_migrate_one                          2138    2137      -1
> > > try_check_zero                               399     398      -1
> > > tracing_entries_read                         461     460      -1
> > > trace_empty                                  233     232      -1
> > > tmigr_cpu_offline                            398     397      -1
> > > timer_list_start                             180     179      -1
> > > timekeeping_get_mg_floor_swaps               106     105      -1
> > > tick_handle_oneshot_broadcast                401     400      -1
> > > tick_clock_notify                            109     108      -1
> > > tick_broadcast_setup_oneshot                 304     303      -1
> > > thaw_secondary_cpus                          421     420      -1
> > > tcp_sigpool_alloc_ahash                      954     953      -1
> > > tc_fill_qdisc                               1103    1102      -1
> > > sysctl_vm_numa_stat_handler                  448     447      -1
> > > sysctl_compaction_handler                    201     200      -1
> > > sw_perf_event_destroy                        135     134      -1
> > > sugov_stop                                   143     142      -1
> > > store_no_turbo                               652     651      -1
> > > sta_get_last_rx_stats                        122     121      -1
> > > srcu_torture_stats_print                     542     541      -1
> > > sock_inuse_get                               106     105      -1
> > > snmp_fold_field                              108     107      -1
> > > smpboot_destroy_threads                      143     142      -1
> > > smp_call_function_any                        265     264      -1
> > > show_stat                                   2330    2329      -1
> > > show_rcu_tasks_generic_gp_kthread            447     446      -1
> > > setup_swap_info                              234     233      -1
> > > sched_update_numa                            426     425      -1
> > > sched_balance_rq                            3651    3650      -1
> > > rto_next_cpu                                 144     143      -1
> > > ring_buffer_overruns                         102     101      -1
> > > ring_buffer_free                             148     147      -1
> > > ring_buffer_entries                          119     118      -1
> > > reserve_lbr_buffers                          209     208      -1
> > > release_callchain_buffers_rcu                109     108      -1
> > > relay_close                                  367     366      -1
> > > reclaim_and_purge_vmap_areas                 452     451      -1
> > > rebind_subsystems                           1310    1309      -1
> > > rdmacg_resource_set_max                      867     866      -1
> > > rcu_tasks_kthread                            202     201      -1
> > > rcu_spawn_gp_kthread                         644     643      -1
> > > rcu_spawn_exp_par_gp_kworker                 382     381      -1
> > > rcu_report_exp_cpu_mult                      176     175      -1
> > > rcu_gp_cleanup                              1551    1550      -1
> > > rcu_barrier_tasks_generic                    465     464      -1
> > > pull_dl_task                                 795     794      -1
> > > pti_init                                     537     536      -1
> > > pt_init                                     1015    1014      -1
> > > process_srcu                                1537    1536      -1
> > > pfifo_fast_reset                             338     337      -1
> > > perf_trace_event_init                        753     752      -1
> > > perf_reboot                                  108     107      -1
> > > perf_event_exit_cpu_context                  577     576      -1
> > > percpu_counter_set                           140     139      -1
> > > pcpu_setup_first_chunk                      1991    1990      -1
> > > pcpu_free_pages.constprop                    176     175      -1
> > > pcpu_depopulate_chunk                        412     411      -1
> > > part_inflight_show                           323     322      -1
> > > packet_read_pending.isra                     111     110      -1
> > > p4_pmu_enable_all                            136     135      -1
> > > od_set_powersave_bias                        216     215      -1
> > > nr_processes                                 106     105      -1
> > > nr_context_switches                          107     106      -1
> > > node_dev_init                                191     190      -1
> > > nh_fill_node                                2443    2442      -1
> > > nfs_show_stats                              1187    1186      -1
> > > netdev_refcnt_read                           106     105      -1
> > > neightbl_fill_info.constprop                1091    1090      -1
> > > native_stop_other_cpus                       429     428      -1
> > > mnt_get_writers                              100      99      -1
> > > mnt_get_count                                103     102      -1
> > > mm_init.constprop                            878     877      -1
> > > metadata_dst_alloc_percpu                    374     373      -1
> > > memory_tier_late_init                       1929    1928      -1
> > > membarrier_private_expedited                 640     639      -1
> > > mem_init                                     533     532      -1
> > > kvm_alloc_cpumask                            188     187      -1
> > > kswapd_init                                  112     111      -1
> > > kstat_irqs_desc                              123     122      -1
> > > knc_pmu_handle_irq                           650     649      -1
> > > kmem_cache_init                              384     383      -1
> > > kcompactd_init                               244     243      -1
> > > ipv6_add_dev                                1375    1374      -1
> > > ipv4_mib_init_net                            523     522      -1
> > > ip_rt_init                                   605     604      -1
> > > ip6_route_init                               571     570      -1
> > > intel_pmu_handle_irq                        1508    1507      -1
> > > intel_gt_mcr_init                            909     908      -1
> > > intel_arch_events_quirk                      139     138      -1
> > > input_leds_connect                           736     735      -1
> > > init_sched_rt_class                          101     100      -1
> > > init_sched_dl_class                          101     100      -1
> > > init_gi_nodes                                137     136      -1
> > > init_cpu_to_node                             284     283      -1
> > > inet6_net_init                               661     660      -1
> > > icl_display_core_init                       2329    2328      -1
> > > i915_pmu_cpu_offline                         268     267      -1
> > > hybrid_set_capacity_of_cpus                  139     138      -1
> > > hugetlb_cgroup_free                          120     119      -1
> > > housekeeping_init                            126     125      -1
> > > group_cpus_evenly                            431     430      -1
> > > gov_update_cpu_data                          263     262      -1
> > > free_iova_rcaches                            266     265      -1
> > > free_fair_sched_group                        164     163      -1
> > > free_acpi_perf_data                           80      79      -1
> > > fpu__init_system_xstate                     3089    3088      -1
> > > fold_vm_zone_numa_events                     218     217      -1
> > > flush_all_cpus_locked                        320     319      -1
> > > flow_limit_cpu_sysctl                        519     518      -1
> > > filelock_init                                377     376      -1
> > > ext4_mb_new_blocks                          3688    3687      -1
> > > do_migrate_pages                             826     825      -1
> > > do_ipt_set_ctl                              1501    1500      -1
> > > do_ip6t_set_ctl                             1525    1524      -1
> > > dm_stats_init                                195     194      -1
> > > dl_cpuset_cpumask_can_shrink                 274     273      -1
> > > dl_clear_root_domain                         175     174      -1
> > > dl_bw_cpus                                   135     134      -1
> > > disable_freq_invariance_workfn               118     117      -1
> > > dev_fetch_sw_netstats                        177     176      -1
> > > default_send_IPI_mask_allbutself_phys        267     266      -1
> > > crash_prepare_elf64_headers                  584     583      -1
> > > cpupri_init                                  182     181      -1
> > > cpupri_find_fitness                          298     297      -1
> > > cpuhp_sysfs_init                             273     272      -1
> > > cpuhp_smt_enable                             252     251      -1
> > > cpuhp_smt_disable                            225     224      -1
> > > cpufreq_set_policy                           802     801      -1
> > > cpufreq_policy_free                          403     402      -1
> > > cpufreq_driver_fast_switch                   243     242      -1
> > > cpufreq_dbs_governor_start                   449     448      -1
> > > cpufreq_dbs_governor_init                    689     688      -1
> > > cpudl_init                                   159     158      -1
> > > cpudl_find                                   349     348      -1
> > > cpu_map_shared_cache.part                    284     283      -1
> > > cpu_down_maps_locked                         200     199      -1
> > > cpu_dev_init                                 230     229      -1
> > > cppc_allow_fast_switch                       135     134      -1
> > > core_guest_get_msrs                          369     368      -1
> > > clocksource_verify_percpu.part              1015    1014      -1
> > > cgroup_subtree_control_write                1023    1022      -1
> > > cgroup_rstat_init                            170     169      -1
> > > cgroup_rstat_exit                            177     176      -1
> > > cgroup_rstat_boot                            105     104      -1
> > > cgroup_release                               319     318      -1
> > > cgroup_exit                                  429     428      -1
> > > cgroup_base_stat_cputime_show                792     791      -1
> > > call_function_init                           115     114      -1
> > > build_all_zonelists_init                     280     279      -1
> > > bpf_prog_alloc                               175     174      -1
> > > blkg_alloc                                   446     445      -1
> > > blkcg_reset_stats                            491     490      -1
> > > blkcg_css_alloc                              569     568      -1
> > > blk_stat_add_callback                        251     250      -1
> > > blk_mq_sysfs_deinit                          123     122      -1
> > > blk_mq_init_allocated_queue                 1010    1009      -1
> > > bioset_exit                                  396     395      -1
> > > begin_new_exec                              2881    2880      -1
> > > apply_wqattrs_commit                         417     416      -1
> > > amd_uncore_umc_ctx_init                      853     852      -1
> > > amd_pstate_change_mode_without_dvr_change     133     132      -1
> > > alloc_desc                                   503     502      -1
> > > alloc_buffer                                1380    1379      -1
> > > ahci_save_initial_config                    1139    1138      -1
> > > ahci_reset_controller                        338     337      -1
> > > add_to_avail_list                            320     319      -1
> > > acpi_cpc_valid                               132     131      -1
> > > _vm_unmap_aliases                            615     614      -1
> > > __sched_clock_work                           271     270      -1
> > > __purge_vmap_area_lazy                       869     868      -1
> > > __percpu_ref_switch_mode                     500     499      -1
> > > __percpu_counter_sum                         139     138      -1
> > > __ftrace_clear_event_pids                    563     562      -1
> > > __drain_swap_slots_cache                      92      91      -1
> > > __dm_stat_init_temporary_percpu_totals       442     441      -1
> > > xhci_bus_resume                             1011    1009      -2
> > > xfrm_input_init                              232     230      -2
> > > xfeature_get_offset                          144     142      -2
> > > x86_release_hardware                         312     310      -2
> > > weighted_interleave_nid                      458     456      -2
> > > vmalloc_init                                1017    1015      -2
> > > vmalloc_info_show                           1003    1001      -2
> > > update_per_cpu_data_slice_size               222     220      -2
> > > update_group_capacity                        546     544      -2
> > > uncore_pmu_hrtimer                           264     262      -2
> > > uncore_device_to_die                         158     156      -2
> > > tsc_restore_sched_clock_state                229     227      -2
> > > tsc_init                                     862     860      -2
> > > try_to_generate_entropy                      592     590      -2
> > > trace_rb_cpu_prepare                         219     217      -2
> > > trace_buffered_event_enable                  353     351      -2
> > > tcp_orphan_count_sum                         109     107      -2
> > > tcf_idr_create                               671     669      -2
> > > task_mm_cid_work                             510     508      -2
> > > svc_seq_show                                 332     330      -2
> > > svc_create_pooled                            815     813      -2
> > > start_kernel                                1989    1987      -2
> > > srcu_readers_active                          130     128      -2
> > > speculative_store_bypass_ht_init             202     200      -2
> > > softirq_init                                 152     150      -2
> > > sock_prot_inuse_get                          124     122      -2
> > > snmp_seq_show_ipstats.constprop.isra         382     380      -2
> > > snmp6_seq_show_item.part                     268     266      -2
> > > snapshot_read_next                           628     626      -2
> > > smp_call_function_many_cond                 1282    1280      -2
> > > show_numa_map                                979     977      -2
> > > setup_zone_pageset                           328     326      -2
> > > setup_per_cpu_pageset                        269     267      -2
> > > set_pgdat_percpu_threshold                   185     183      -2
> > > set_buffer_entries                            96      94      -2
> > > seq_hlist_start_percpu                       135     133      -2
> > > send_pcc_cmd                                 655     653      -2
> > > scsi_show_rq                                 793     791      -2
> > > schedule_on_each_cpu                         318     316      -2
> > > sbitmap_init_node                            506     504      -2
> > > rtm_new_nexthop                             5429    5427      -2
> > > ring_buffer_subbuf_order_set                1162    1160      -2
> > > relay_open                                   704     702      -2
> > > recalc_bh_state.part                         123     121      -2
> > > rcu_barrier                                  875     873      -2
> > > rcec_assoc_rciep.isra                        116     114      -2
> > > proc_nr_inodes                               177     175      -2
> > > probe_event_enable                           874     872      -2
> > > perf_event_print_debug                      1273    1271      -2
> > > percpu_ref_switch_to_atomic_rcu              380     378      -2
> > > percpu_is_read_locked                        136     134      -2
> > > percpu_down_write                            405     403      -2
> > > per_cpu_ptr_to_phys                          267     265      -2
> > > pcpu_alloc_noprof                           1904    1902      -2
> > > partition_sched_domains_locked              1068    1066      -2
> > > part_in_flight                               135     133      -2
> > > page_alloc_init_late                         771     769      -2
> > > padata_do_serial                             225     223      -2
> > > padata_do_parallel                           534     532      -2
> > > padata_do_multithreaded                      856     854      -2
> > > padata_alloc_pd                              521     519      -2
> > > out_of_memory                               1699    1697      -2
> > > nv_get_stats64                               404     402      -2
> > > numa_nearest_node                            210     208      -2
> > > nr_running                                   103     101      -2
> > > nr_iowait                                    110     108      -2
> > > node_read_distance                           236     234      -2
> > > netif_get_num_default_rss_queues             170     168      -2
> > > net_dev_init                                 808     806      -2
> > > native_smp_cpus_done                         667     665      -2
> > > mq_dump_class_stats                          239     237      -2
> > > memcpy_count_show                            174     172      -2
> > > membarrier_global_expedited                  322     320      -2
> > > mce_read_aux                                 394     392      -2
> > > kyber_timer_fn                               583     581      -2
> > > kvm_flush_tlb_multi                          151     149      -2
> > > kvfree_rcu_barrier                           341     339      -2
> > > kcore_update_ram.isra                        781     779      -2
> > > irq_migrate_all_off_this_cpu                 797     795      -2
> > > irq_matrix_alloc_managed                     370     368      -2
> > > irq_matrix_alloc                             334     332      -2
> > > irq_alloc_matrix                             259     257      -2
> > > interleave_nodes                             188     186      -2
> > > interleave_nid                               209     207      -2
> > > input_register_device                       1248    1246      -2
> > > init_timers                                  179     177      -2
> > > init_sched_fair_class                        215     213      -2
> > > inactive_task_timer                          975     973      -2
> > > ieee80211_add_rx_radiotap_header            2252    2250      -2
> > > idle_threads_init                            177     175      -2
> > > hw_breakpoint_is_used                        206     204      -2
> > > hpet_open                                    500     498      -2
> > > gnet_stats_add_basic                         183     181      -2
> > > get_total_entries                            196     194      -2
> > > get_nr_inodes                                108     106      -2
> > > get_nr_dirty_inodes                          141     139      -2
> > > get_nohz_timer_target                        315     313      -2
> > > gen11_gt_irq_handler                         867     865      -2
> > > ftrace_dump_one                              771     769      -2
> > > free_policy_dbs_info                         126     124      -2
> > > free_area_init                              3826    3824      -2
> > > force_qs_rnp                                 764     762      -2
> > > flush_tlb_mm_range                           400     398      -2
> > > ext4_update_super                            997     995      -2
> > > ext4_mb_init                                1958    1956      -2
> > > ext4_fill_super                            13483   13481      -2
> > > elf_coredump_extra_notes_size                107     105      -2
> > > drv_change_vif_links                         639     637      -2
> > > drv_change_sta_links                         606     604      -2
> > > drop_slab                                    209     207      -2
> > > dma_channel_table_init                       286     284      -2
> > > dm_wait_for_completion                       399     397      -2
> > > dev_lstats_read                              137     135      -2
> > > detect_cache_attributes                      729     727      -2
> > > del_gendisk                                  822     820      -2
> > > default_hugepagesz_setup                     456     454      -2
> > > cpuusage_write                               198     196      -2
> > > cpumask_next_wrap                            110     108      -2
> > > cpuidle_driver_state_disabled                238     236      -2
> > > cpufreq_online                              2582    2580      -2
> > > cpu_stop_init                                184     182      -2
> > > cpu_rmap_copy_neigh                          151     149      -2
> > > cpu_init_debugfs                             251     249      -2
> > > core_pmu_enable_all                          399     397      -2
> > > compaction_zonelist_suitable                 392     390      -2
> > > clock_was_set                                551     549      -2
> > > cgroup_post_fork                             662     660      -2
> > > cgroup_can_fork                             1397    1395      -2
> > > cfg80211_any_usable_channels                 166     164      -2
> > > calibrate_delay_is_known                     250     248      -2
> > > cache_shared_cpu_map_remove                  313     311      -2
> > > bytes_transferred_show                       175     173      -2
> > > blk_stat_timer_fn                            369     367      -2
> > > blk_mq_update_queue_map                      204     202      -2
> > > blk_mq_map_hw_queues                         188     186      -2
> > > blk_mq_init                                  364     362      -2
> > > blk_mq_hw_queue_to_node                      131     129      -2
> > > blk_mq_delay_run_hw_queue                    411     409      -2
> > > arch_tlbbatch_flush                          246     244      -2
> > > arch_enable_hybrid_capacity_scale            252     250      -2
> > > apply_wqattrs_prepare                        586     584      -2
> > > amd_uncore_ctx_init.part                     524     522      -2
> > > amd_put_event_constraints                    151     149      -2
> > > amd_pmu_cpu_starting                         382     380      -2
> > > amd_pmu_cpu_prepare                          353     351      -2
> > > amd_pmu_check_overflow                       171     169      -2
> > > amd_numa_init                                891     889      -2
> > > amd_detect_prefcore                          341     339      -2
> > > alloc_pages_bulk_mempolicy_noprof           1553    1551      -2
> > > alloc_iova_fast                              666     664      -2
> > > alloc_cpu_rmap                               206     204      -2
> > > all_vm_events                                193     191      -2
> > > addrconf_disable_policy_idev                 337     335      -2
> > > add_del_listener                             583     581      -2
> > > acpi_get_psd_map                             352     350      -2
> > > acpi_cpufreq_probe                           486     484      -2
> > > __zone_set_pageset_high_and_batch            104     102      -2
> > > __sync_rcu_exp_select_node_cpus              961     959      -2
> > > __percpu_counter_limited_add                 483     481      -2
> > > __log_error                                  476     474      -2
> > > __is_module_percpu_address                   281     279      -2
> > > __is_kernel_percpu_address                   184     182      -2
> > > __do_sys_swapon                             4491    4489      -2
> > > __do_sys_swapoff                            3463    3461      -2
> > > __dl_server_attach_root                      239     237      -2
> > > ___gnet_stats_copy_basic.isra                399     397      -2
> > > x86_reserve_hardware                         668     665      -3
> > > update_or_create_fnhe                        921     918      -3
> > > smp_prepare_cpus_common                      314     311      -3
> > > select_task_rq_fair                         4362    4359      -3
> > > reserve_ds_buffers                          1607    1604      -3
> > > register_netdevice                          2057    2054      -3
> > > refresh_zone_stat_thresholds                 399     396      -3
> > > rcu_tasks_trace_pregp_step                  1171    1168      -3
> > > pcpu_populate_chunk                         1058    1055      -3
> > > numa_init                                    697     694      -3
> > > mgts_show                                    347     344      -3
> > > irq_matrix_reserve_managed                   362     359      -3
> > > ioc_timer_fn                                4929    4926      -3
> > > intel_dp_compute_link_config                1224    1221      -3
> > > init_mm_internals                            716     713      -3
> > > ieee80211_vif_update_links                  2023    2020      -3
> > > hugetlb_init                                1468    1465      -3
> > > dst_cache_destroy                            150     147      -3
> > > dl_server_apply_params                       963     960      -3
> > > cpufreq_show_cpus                            175     172      -3
> > > cpu_rmap_update                              507     504      -3
> > > cppc_perf_ctrs_in_pcc                        315     312      -3
> > > blk_mq_map_queues                            206     203      -3
> > > workqueue_offline_cpu                        531     527      -4
> > > workqueue_init_topology                      282     278      -4
> > > update_qos_request                           249     245      -4
> > > unregister_netdevice_many_notify            2229    2225      -4
> > > tracing_release                              342     338      -4
> > > toggle_bp_slot.constprop                    2658    2654      -4
> > > sync_runqueues_membarrier_state.part         270     266      -4
> > > smpboot_register_percpu_thread               274     270      -4
> > > shrink_dcache_sb                             344     340      -4
> > > show_rcu_gp_kthreads                         823     819      -4
> > > show_free_areas                             2755    2751      -4
> > > set_cpus_allowed_dl                          278     274      -4
> > > set_cpu_sibling_map                         1600    1596      -4
> > > select_fallback_rq                           627     623      -4
> > > s_start                                      857     853      -4
> > > release_ds_buffers                           305     301      -4
> > > qdisc_alloc                                  521     517      -4
> > > probes_profile_seq_show                      369     365      -4
> > > phys_package_first_cpu                       126     122      -4
> > > perf_swevent_init                            575     571      -4
> > > netstat_seq_show                             768     764      -4
> > > kvm_smp_send_call_func_ipi                   102      98      -4
> > > intel_pmu_cpu_starting                      1713    1709      -4
> > > hw_breakpoint_arch_parse                     659     655      -4
> > > hugetlb_acct_memory.part                    1113    1109      -4
> > > fq_flush_timeout                             236     232      -4
> > > ext4_attr_show                               991     987      -4
> > > elf_coredump_extra_notes_write               435     431      -4
> > > dst_cache_reset_now                          163     159      -4
> > > cpc_read_ffh                                  89      85      -4
> > > alloc_workqueue                             1971    1967      -4
> > > _ieee80211_set_active_links                 1298    1294      -4
> > > __drain_all_pages                            429     425      -4
> > > xt_free_table_info                           136     131      -5
> > > tcp_v4_init                                  261     256      -5
> > > swapfile_init                                224     219      -5
> > > srcu_barrier                                 519     514      -5
> > > slabs_cpu_partial_show                       348     343      -5
> > > show_interrupts                              871     866      -5
> > > ring_buffer_reset_online_cpus                338     333      -5
> > > relay_reset                                  195     190      -5
> > > relay_flush                                  195     190      -5
> > > rcu_check_boost_fail                         459     454      -5
> > > perf_event_mux_interval_ms_store             352     347      -5
> > > mce_end                                      666     661      -5
> > > kvfree_rcu_init                              579     574      -5
> > > iommu_dma_init_fq                            494     489      -5
> > > intel_pstate_driver_cleanup                  223     218      -5
> > > icmpv6_init                                  285     280      -5
> > > housekeeping_setup                           645     640      -5
> > > gro_cells_destroy                            342     337      -5
> > > get_callchain_buffers                        430     425      -5
> > > dm_stats_message                            4299    4294      -5
> > > dm_stat_free                                 290     285      -5
> > > dl_add_task_root_domain                      334     329      -5
> > > cpufreq_dbs_governor_stop                    144     139      -5
> > > cpuacct_stats_show                           374     369      -5
> > > cgroup_propagate_control                     342     337      -5
> > > cgroup_print_ss_mask                         186     181      -5
> > > blkcg_print_stat                             816     811      -5
> > > blk_mq_sysfs_init                            160     155      -5
> > > apply_wqattrs_cleanup.part                   232     227      -5
> > > amd_pmu_enable_all                           140     135      -5
> > > __list_lru_init                              179     174      -5
> > > __group_cpus_evenly                         1298    1293      -5
> > > __blkg_release                               276     271      -5
> > > weighted_interleave_nodes                    326     320      -6
> > > snmp_seq_show_tcp_udp.constprop.isra        1005     999      -6
> > > setup_cpu_entry_areas                       1159    1153      -6
> > > schedstat_next                               131     125      -6
> > > sched_dl_do_global                           349     343      -6
> > > sched_balance_trigger                        943     937      -6
> > > ring_buffer_wake_waiters                     191     185      -6
> > > ring_buffer_reset                            238     232      -6
> > > rcu_sched_clock_irq                         4063    4057      -6
> > > print_ICs                                    302     296      -6
> > > perf_output_sample_regs                      172     166      -6
> > > netdev_rx_queue_set_rps_mask                 313     307      -6
> > > kfree_rcu_shrink_count                       172     166      -6
> > > iova_domain_init_rcaches                     454     448      -6
> > > iolatency_pd_init                            519     513      -6
> > > init_pod_type                                546     540      -6
> > > gro_cells_init                               260     254      -6
> > > crypto_scomp_init_tfm                        261     255      -6
> > > cpuacct_all_seq_show                         294     288      -6
> > > cgroup_migrate_execute                      1179    1173      -6
> > > allow_direct_reclaim.part                    308     302      -6
> > > __cpuusage_read                              127     121      -6
> > > __cpuacct_percpu_seq_show                    165     159      -6
> > > wq_update_node_max_active                    536     529      -7
> > > sysrq_timer_list_show                        285     278      -7
> > > sta_set_sinfo                               3039    3032      -7
> > > regmap_field_init                            129     122      -7
> > > populate_cache_leaves                       1347    1340      -7
> > > mst_stream_compute_config                   1599    1592      -7
> > > lpit_read_residency_counter_us               309     302      -7
> > > is_mddev_idle                                525     518      -7
> > > free_node_nr_active                          167     160      -7
> > > check_hw_exists                             1041    1034      -7
> > > blk_mq_map_swqueue                          1090    1083      -7
> > > acpi_processor_throttling_init               775     768      -7
> > > zone_reclaimable_pages                       808     800      -8
> > > ring_buffer_empty                            280     272      -8
> > > perf_assign_events                           838     830      -8
> > > intel_pmu_init                             14230   14222      -8
> > > dma_channel_rebalance                        752     744      -8
> > > cpufreq_notify_transition                    302     294      -8
> > > __reserve_bp_slot                            599     591      -8
> > > snapshot_write_next                         2467    2458      -9
> > > smp_shutdown_nonboot_cpus                    213     204      -9
> > > skx_pmu_get_topology                         338     329      -9
> > > schedstat_start                              125     116      -9
> > > intel_psr_flush                              976     967      -9
> > > icmp_init                                    276     267      -9
> > > find_next_best_node                          291     282      -9
> > > tracing_open                                 986     976     -10
> > > remove_siblinginfo                           807     797     -10
> > > dl_task_timer                               1557    1547     -10
> > > compaction_proactiveness_sysctl_handler      299     289     -10
> > > show_softirqs                                362     351     -11
> > > hugetlb_cgroup_read_numa_stat                634     623     -11
> > > dev_get_stats                                818     807     -11
> > > del_from_avail_list                          241     230     -11
> > > acpi_processor_power_state_has_changed       447     436     -11
> > > acpi_map_cpuid                               157     146     -11
> > > numa_set_distance                            601     589     -12
> > > intel_drrs_activate                          376     364     -12
> > > task_non_contending                          840     827     -13
> > > dl_bw_manage                                 837     823     -14
> > > intel_get_event_constraints                  870     855     -15
> > > do_kmem_cache_create                        1245    1230     -15
> > > acpi_processor_preregister_performance      1131    1116     -15
> > > __build_all_zonelists                        241     226     -15
> > > ring_buffer_resize                          1325    1309     -16
> > > __pfx_intel_pstate_update_policies            16       -     -16
> > > sched_init_numa                             1951    1932     -19
> > > intel_gt_init_workarounds                   4277    4257     -20
> > > workqueue_online_cpu                         746     724     -22
> > > blk_iocost_init                              650     628     -22
> > > __acpi_processor_set_throttling             1056    1031     -25
> > > build_sched_domains                         5361    5335     -26
> > > amd_pmu_v2_handle_irq                       1018     989     -29
> > > load_module                                 8010    7973     -37
> > > intel_pstate_update_policies                  96       -     -96
> > > Total: Before=22302033, After=22300826, chg -0.01%
> > > 
> > > * Code size shrinking ( gcc-13 for x86_64 with NR_CPUS=1024 ):
> > > 
> > > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> > > add/remove: 0/0 grow/shrink: 9/132 up/down: 51/-503 (-452)
> > > Function                                     old     new   delta
> > > cpuset_mem_spread_node                       283     297     +14
> > > perf_assign_events                           901     914     +13
> > > numa_policy_init                             602     609      +7
> > > hidinput_connect                           20926   20930      +4
> > > dev_change_proto_down_reason                 164     168      +4
> > > cgroup_propagate_control                     403     407      +4
> > > ext4_fill_super                            12742   12745      +3
> > > alloc_fd                                     376     377      +1
> > > alloc_buffer                                1357    1358      +1
> > > zhaoxin_pmu_handle_irq                       772     771      -1
> > > zhaoxin_arch_events_quirk                    137     136      -1
> > > wq_update_node_max_active                    618     617      -1
> > > uncore_pmu_hrtimer                           261     260      -1
> > > svc_create_pooled                            772     771      -1
> > > show_free_areas                             2802    2801      -1
> > > setup_swap_info                              235     234      -1
> > > sched_update_numa                            433     432      -1
> > > rdmacg_resource_set_max                      892     891      -1
> > > rcu_report_exp_cpu_mult                      175     174      -1
> > > perf_event_print_debug                      1227    1226      -1
> > > p4_pmu_handle_irq                            631     630      -1
> > > node_dev_init                                189     188      -1
> > > memory_tier_late_init                       1762    1761      -1
> > > mem_init                                     520     519      -1
> > > kswapd_init                                  110     109      -1
> > > kmem_cache_init                              369     368      -1
> > > kcompactd_init                               242     241      -1
> > > intel_gt_mcr_init                            886     885      -1
> > > intel_get_event_constraints                  846     845      -1
> > > intel_arch_events_quirk                      137     136      -1
> > > input_leds_connect                           720     719      -1
> > > init_mm_internals                            654     653      -1
> > > init_gi_nodes                                132     131      -1
> > > housekeeping_init                            153     152      -1
> > > gen11_gt_irq_handler                         924     923      -1
> > > fpu__init_system_xstate                     3179    3178      -1
> > > elf_coredump_extra_notes_size                107     106      -1
> > > ehci_hrtimer_func                            233     232      -1
> > > do_migrate_pages                             807     806      -1
> > > cpc_write_ffh                                167     166      -1
> > > cgroup_subtree_control_write                1008    1007      -1
> > > cgroup_post_fork                             634     633      -1
> > > amd_pmu_v2_handle_irq                       1053    1052      -1
> > > add_to_avail_list                            310     309      -1
> > > __i915_gem_object_set_pages                  547     546      -1
> > > __do_sys_swapon                             4230    4229      -1
> > > __copy_xstate_to_uabi_buf                   2416    2415      -1
> > > xhci_bus_resume                             1011    1009      -2
> > > xfeature_get_offset                          137     135      -2
> > > x86_release_hardware                         322     320      -2
> > > weighted_interleave_nodes                    331     329      -2
> > > vmalloc_info_show                           1000     998      -2
> > > snapshot_write_next                         2486    2484      -2
> > > snapshot_read_next                           626     624      -2
> > > show_numa_map                                980     978      -2
> > > scsi_show_rq                                 800     798      -2
> > > rcu_gp_cleanup                              1556    1554      -2
> > > rcec_assoc_rciep.isra                        116     114      -2
> > > perf_output_sample_regs                      181     179      -2
> > > padata_do_multithreaded                      877     875      -2
> > > p4_pmu_enable_all                            132     130      -2
> > > numa_nearest_node                            210     208      -2
> > > node_read_distance                           234     232      -2
> > > mce_read_aux                                 394     392      -2
> > > kcore_update_ram.isra                        783     781      -2
> > > interleave_nodes                             166     164      -2
> > > interleave_nid                               217     215      -2
> > > intel_pmu_init                             14167   14165      -2
> > > intel_pmu_drain_pebs_icl                     866     864      -2
> > > intel_gt_init_workarounds                   4139    4137      -2
> > > input_register_device                       1348    1346      -2
> > > ieee80211_rx_mgmt_beacon                    5755    5753      -2
> > > ieee80211_add_rx_radiotap_header            2267    2265      -2
> > > icl_display_core_init                       2347    2345      -2
> > > free_area_init                              4062    4060      -2
> > > drv_change_sta_links                         621     619      -2
> > > drop_slab                                    223     221      -2
> > > dma_channel_table_init                       279     277      -2
> > > default_hugepagesz_setup                     454     452      -2
> > > core_pmu_enable_all                          399     397      -2
> > > cgroup_release                               302     300      -2
> > > cgroup_exit                                  416     414      -2
> > > cgroup_can_fork                             1282    1280      -2
> > > amd_pmu_enable_all                           132     130      -2
> > > amd_pmu_cpu_prepare                          340     338      -2
> > > amd_pmu_check_overflow                       177     175      -2
> > > amd_numa_init                                901     899      -2
> > > alloc_workqueue                             1964    1962      -2
> > > alloc_pages_bulk_mempolicy_noprof           1530    1528      -2
> > > ahci_reset_controller                        301     299      -2
> > > _ieee80211_set_active_links                 1341    1339      -2
> > > __sync_rcu_exp_select_node_cpus              954     952      -2
> > > __log_error                                  494     492      -2
> > > rebind_subsystems                           1264    1261      -3
> > > page_alloc_init_late                         754     751      -3
> > > out_of_memory                               1780    1777      -3
> > > ieee80211_subif_start_xmit                  1121    1118      -3
> > > hugetlb_init                                1608    1605      -3
> > > hugetlb_acct_memory.part                    1112    1109      -3
> > > housekeeping_setup                           764     761      -3
> > > __group_cpus_evenly                         1372    1369      -3
> > > shrink_dcache_sb                             327     323      -4
> > > intel_psr_invalidate                         667     663      -4
> > > intel_dp_compute_link_config                1317    1313      -4
> > > ieee80211_vif_update_links                  2562    2558      -4
> > > hpet_open                                    491     487      -4
> > > elf_coredump_extra_notes_write               453     449      -4
> > > cpc_read_ffh                                  89      85      -4
> > > x86_pmu_enable_all                           377     372      -5
> > > swapfile_init                                220     215      -5
> > > cgroup_print_ss_mask                         182     177      -5
> > > __list_lru_init                              179     174      -5
> > > x86_pmu_disable_all                          411     405      -6
> > > intel_engines_init_mmio                     3432    3426      -6
> > > regmap_field_init                            122     115      -7
> > > mst_stream_compute_config                   1659    1652      -7
> > > lpit_read_residency_counter_us               309     302      -7
> > > free_node_nr_active                          165     158      -7
> > > intel_psr_flush                              982     974      -8
> > > drv_change_vif_links                         635     627      -8
> > > do_kmem_cache_create                        1217    1209      -8
> > > core_guest_get_msrs                          347     339      -8
> > > check_hw_exists                             1074    1066      -8
> > > __do_sys_swapoff                            3766    3758      -8
> > > x86_reserve_hardware                         680     671      -9
> > > hugetlb_cgroup_free                          127     117     -10
> > > compaction_proactiveness_sysctl_handler      298     288     -10
> > > ahci_save_initial_config                    1170    1160     -10
> > > __build_all_zonelists                        229     219     -10
> > > numa_set_distance                            578     567     -11
> > > del_from_avail_list                          220     209     -11
> > > weighted_interleave_nid                      385     373     -12
> > > hugetlb_cgroup_read_numa_stat                607     595     -12
> > > sysctl_compaction_handler                    196     183     -13
> > > mempolicy_sysfs_init                         664     651     -13
> > > intel_drrs_activate                          392     379     -13
> > > find_next_best_node                          313     300     -13
> > > cgroup_migrate_execute                      1151    1138     -13
> > > sched_init_numa                             1926    1910     -16
> > > numa_init                                    729     712     -17
> > > rtm_new_nexthop                             5805    5785     -20
> > > Total: Before=22493682, After=22493230, chg -0.00%
> > > 
> > > * Code size shrinking ( gcc-12 for x86_64 with NR_CPUS=1024 ):
> > > 
> > > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> > > add/remove: 2/2 grow/shrink: 17/124 up/down: 396/-721 (-325)
> > > Function                                     old     new   delta
> > > lpit_read_residency_counter_us                 -     302    +302
> > > alloc_pages_bulk_mempolicy_noprof           1556    1589     +33
> > > __pfx_lpit_read_residency_counter_us           -      16     +16
> > > numa_policy_init                             602     609      +7
> > > rebind_subsystems                           1261    1266      +5
> > > blk_mq_flush_busy_ctxs                       463     468      +5
> > > __i915_gem_object_set_pages                  545     550      +5
> > > dev_change_proto_down_reason                 164     168      +4
> > > x86_reserve_hardware                         648     651      +3
> > > netstat_seq_show                             662     665      +3
> > > cpuset_mem_spread_node                       297     300      +3
> > > low_power_idle_cpu_residency_us_show         100     102      +2
> > > cgroup_propagate_control                     405     407      +2
> > > intel_engines_init_mmio                     3389    3390      +1
> > > input_register_device                       1291    1292      +1
> > > ieee80211_rx_mgmt_beacon                    6109    6110      +1
> > > hpet_open                                    491     492      +1
> > > alloc_fd                                     376     377      +1
> > > acpi_extract_apple_properties                973     974      +1
> > > zhaoxin_pmu_handle_irq                       776     775      -1
> > > zhaoxin_arch_events_quirk                    137     136      -1
> > > x86_pmu_handle_irq                           484     483      -1
> > > x86_pmu_enable_all                           382     381      -1
> > > wq_update_node_max_active                    607     606      -1
> > > uncore_pmu_hrtimer                           261     260      -1
> > > svc_create_pooled                            790     789      -1
> > > show_free_areas                             2757    2756      -1
> > > setup_swap_info                              235     234      -1
> > > sched_update_numa                            435     434      -1
> > > rdmacg_resource_set_max                      894     893      -1
> > > rcu_report_exp_cpu_mult                      175     174      -1
> > > perf_event_print_debug                      1219    1218      -1
> > > p4_pmu_handle_irq                            682     681      -1
> > > node_dev_init                                189     188      -1
> > > memory_tier_late_init                       1763    1762      -1
> > > mem_init                                     520     519      -1
> > > kswapd_init                                  110     109      -1
> > > kmem_cache_init                              369     368      -1
> > > kcompactd_init                               242     241      -1
> > > intel_gt_mcr_init                            886     885      -1
> > > intel_get_event_constraints                  846     845      -1
> > > intel_arch_events_quirk                      137     136      -1
> > > input_leds_connect                           724     723      -1
> > > init_mm_internals                            654     653      -1
> > > init_gi_nodes                                132     131      -1
> > > ieee80211_subif_start_xmit                  1127    1126      -1
> > > housekeeping_init                            153     152      -1
> > > gen11_gt_irq_handler                         911     910      -1
> > > elf_coredump_extra_notes_size                107     106      -1
> > > do_migrate_pages                             807     806      -1
> > > cpc_write_ffh                                167     166      -1
> > > cgroup_subtree_control_write                 997     996      -1
> > > cgroup_print_ss_mask                         182     181      -1
> > > cgroup_post_fork                             614     613      -1
> > > amd_pmu_v2_handle_irq                       1101    1100      -1
> > > amd_pmu_enable_all                           139     138      -1
> > > alloc_buffer                                1358    1357      -1
> > > ahci_save_initial_config                    1164    1163      -1
> > > add_to_avail_list                            310     309      -1
> > > __copy_xstate_to_uabi_buf                   2457    2456      -1
> > > xhci_bus_resume                             1011    1009      -2
> > > xfeature_get_offset                          137     135      -2
> > > x86_release_hardware                         289     287      -2
> > > weighted_interleave_nodes                    311     309      -2
> > > vmalloc_info_show                           1000     998      -2
> > > snapshot_write_next                         2486    2484      -2
> > > snapshot_read_next                           626     624      -2
> > > show_numa_map                                980     978      -2
> > > scsi_show_rq                                 800     798      -2
> > > rcu_gp_cleanup                              1556    1554      -2
> > > rcec_assoc_rciep.isra                        116     114      -2
> > > perf_output_sample_regs                      181     179      -2
> > > padata_do_multithreaded                      867     865      -2
> > > p4_pmu_enable_all                            139     137      -2
> > > numa_nearest_node                            210     208      -2
> > > node_read_distance                           234     232      -2
> > > mce_read_aux                                 394     392      -2
> > > kcore_update_ram.isra                        783     781      -2
> > > interleave_nodes                             163     161      -2
> > > interleave_nid                               217     215      -2
> > > intel_pmu_drain_pebs_icl                     866     864      -2
> > > intel_gt_init_workarounds                   4160    4158      -2
> > > ieee80211_add_rx_radiotap_header            2290    2288      -2
> > > icl_display_core_init                       2340    2338      -2
> > > free_area_init                              3984    3982      -2
> > > drv_change_sta_links                         621     619      -2
> > > drop_slab                                    223     221      -2
> > > dma_channel_table_init                       279     277      -2
> > > default_hugepagesz_setup                     454     452      -2
> > > cgroup_release                               302     300      -2
> > > cgroup_exit                                  416     414      -2
> > > cgroup_can_fork                             1277    1275      -2
> > > amd_pmu_cpu_prepare                          340     338      -2
> > > amd_pmu_check_overflow                       173     171      -2
> > > amd_numa_init                                892     890      -2
> > > alloc_workqueue                             1792    1790      -2
> > > _ieee80211_set_active_links                 1341    1339      -2
> > > __sync_rcu_exp_select_node_cpus              954     952      -2
> > > __log_error                                  494     492      -2
> > > __group_cpus_evenly                         1378    1376      -2
> > > page_alloc_init_late                         754     751      -3
> > > out_of_memory                               1759    1756      -3
> > > ieee80211_vif_update_links                  2506    2503      -3
> > > hugetlb_init                                1571    1568      -3
> > > hugetlb_acct_memory.part                    1112    1109      -3
> > > housekeeping_setup                           764     761      -3
> > > shrink_dcache_sb                             327     323      -4
> > > intel_dp_compute_link_config                1331    1327      -4
> > > elf_coredump_extra_notes_write               453     449      -4
> > > cpc_read_ffh                                  89      85      -4
> > > __do_sys_swapon                             4497    4493      -4
> > > swapfile_init                                220     215      -5
> > > __list_lru_init                              179     174      -5
> > > ahci_reset_controller                        308     302      -6
> > > regmap_field_init                            135     128      -7
> > > mst_stream_compute_config                   1659    1652      -7
> > > free_node_nr_active                          165     158      -7
> > > drv_change_vif_links                         635     628      -7
> > > core_guest_get_msrs                          374     367      -7
> > > intel_psr_flush                              985     977      -8
> > > do_kmem_cache_create                        1208    1200      -8
> > > core_pmu_enable_all                          402     394      -8
> > > __do_sys_swapoff                            3799    3791      -8
> > > hugetlb_cgroup_free                          127     117     -10
> > > compaction_proactiveness_sysctl_handler      301     291     -10
> > > __build_all_zonelists                        229     219     -10
> > > numa_set_distance                            578     567     -11
> > > ext4_fill_super                            12858   12847     -11
> > > del_from_avail_list                          220     209     -11
> > > x86_pmu_disable_all                          422     410     -12
> > > weighted_interleave_nid                      385     373     -12
> > > hugetlb_cgroup_read_numa_stat                607     595     -12
> > > check_hw_exists                             1060    1048     -12
> > > cgroup_migrate_execute                      1136    1124     -12
> > > sysctl_compaction_handler                    196     183     -13
> > > mempolicy_sysfs_init                         664     651     -13
> > > intel_drrs_activate                          392     379     -13
> > > find_next_best_node                          316     303     -13
> > > perf_assign_events                           927     912     -15
> > > sched_init_numa                             1884    1868     -16
> > > __pfx_lpit_read_residency_counter_us.part      16       -     -16
> > > numa_init                                    739     722     -17
> > > fpu__init_system_xstate                     3798    3774     -24
> > > low_power_idle_system_residency_us_show      130     105     -25
> > > lpit_read_residency_counter_us.part          191       -    -191
> > > Total: Before=22509812, After=22509487, chg -0.00%
> > > 
> > > 
> > > * Code size shrinking ( gcc-11 for x86_64 with NR_CPUS=1024 ):
> > > 
> > > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> > > add/remove: 0/0 grow/shrink: 11/126 up/down: 64/-475 (-411)
> > > Function                                     old     new   delta
> > > alloc_buffer                                1386    1408     +22
> > > intel_psr_invalidate                         645     662     +17
> > > ieee80211_subif_start_xmit                  1124    1129      +5
> > > ieee80211_rx_mgmt_beacon                    6008    6013      +5
> > > __i915_gem_object_set_pages                  567     572      +5
> > > numa_policy_init                             569     572      +3
> > > intel_engines_init_mmio                     3368    3370      +2
> > > cpc_write_ffh                                157     159      +2
> > > hswep_uncore_sbox_msr_init_box               192     193      +1
> > > dev_change_proto_down_reason                 153     154      +1
> > > alloc_fd                                     411     412      +1
> > > zhaoxin_arch_events_quirk                    139     138      -1
> > > x86_pmu_enable_all                           380     379      -1
> > > wq_update_node_max_active                    631     630      -1
> > > sysctl_compaction_handler                    201     200      -1
> > > svc_create_pooled                            786     785      -1
> > > show_free_areas                             2661    2660      -1
> > > setup_swap_info                              234     233      -1
> > > sched_update_numa                            435     434      -1
> > > rebind_subsystems                           1310    1309      -1
> > > rdmacg_resource_set_max                      867     866      -1
> > > rcu_report_exp_cpu_mult                      176     175      -1
> > > rcu_gp_cleanup                              1551    1550      -1
> > > p4_pmu_enable_all                            136     135      -1
> > > node_dev_init                                191     190      -1
> > > memory_tier_late_init                       1929    1928      -1
> > > mem_init                                     533     532      -1
> > > kswapd_init                                  112     111      -1
> > > knc_pmu_handle_irq                           650     649      -1
> > > kmem_cache_init                              384     383      -1
> > > kcompactd_init                               244     243      -1
> > > intel_pmu_handle_irq                        1508    1507      -1
> > > intel_gt_mcr_init                            909     908      -1
> > > intel_arch_events_quirk                      139     138      -1
> > > input_leds_connect                           736     735      -1
> > > init_mm_internals                            678     677      -1
> > > init_gi_nodes                                137     136      -1
> > > icl_display_core_init                       2329    2328      -1
> > > hugetlb_cgroup_free                          120     119      -1
> > > housekeeping_init                            155     154      -1
> > > fpu__init_system_xstate                     3089    3088      -1
> > > do_migrate_pages                             826     825      -1
> > > core_guest_get_msrs                          369     368      -1
> > > cgroup_subtree_control_write                1023    1022      -1
> > > cgroup_release                               319     318      -1
> > > cgroup_exit                                  429     428      -1
> > > alloc_workqueue                             1850    1849      -1
> > > ahci_save_initial_config                    1139    1138      -1
> > > ahci_reset_controller                        338     337      -1
> > > add_to_avail_list                            320     319      -1
> > > __do_sys_swapon                             4503    4502      -1
> > > xhci_bus_resume                             1011    1009      -2
> > > xfeature_get_offset                          144     142      -2
> > > x86_release_hardware                         312     310      -2
> > > weighted_interleave_nid                      458     456      -2
> > > vmalloc_info_show                           1003    1001      -2
> > > uncore_pmu_hrtimer                           264     262      -2
> > > snapshot_read_next                           628     626      -2
> > > show_numa_map                                979     977      -2
> > > scsi_show_rq                                 793     791      -2
> > > rcec_assoc_rciep.isra                        116     114      -2
> > > perf_event_print_debug                      1273    1271      -2
> > > page_alloc_init_late                         771     769      -2
> > > padata_do_multithreaded                      856     854      -2
> > > out_of_memory                               1699    1697      -2
> > > numa_nearest_node                            210     208      -2
> > > node_read_distance                           236     234      -2
> > > mce_read_aux                                 394     392      -2
> > > kcore_update_ram.isra                        781     779      -2
> > > interleave_nodes                             188     186      -2
> > > interleave_nid                               209     207      -2
> > > input_register_device                       1248    1246      -2
> > > ieee80211_add_rx_radiotap_header            2252    2250      -2
> > > hpet_open                                    500     498      -2
> > > gen11_gt_irq_handler                         867     865      -2
> > > free_area_init                              3826    3824      -2
> > > force_qs_rnp                                 764     762      -2
> > > elf_coredump_extra_notes_size                107     105      -2
> > > drv_change_vif_links                         639     637      -2
> > > drv_change_sta_links                         606     604      -2
> > > drop_slab                                    209     207      -2
> > > dma_channel_table_init                       286     284      -2
> > > default_hugepagesz_setup                     456     454      -2
> > > core_pmu_enable_all                          399     397      -2
> > > cgroup_post_fork                             662     660      -2
> > > cgroup_can_fork                             1397    1395      -2
> > > cfg80211_any_usable_channels                 166     164      -2
> > > amd_put_event_constraints                    151     149      -2
> > > amd_pmu_cpu_prepare                          353     351      -2
> > > amd_pmu_check_overflow                       171     169      -2
> > > amd_numa_init                                891     889      -2
> > > alloc_pages_bulk_mempolicy_noprof           1553    1551      -2
> > > __sync_rcu_exp_select_node_cpus              961     959      -2
> > > __log_error                                  476     474      -2
> > > __do_sys_swapoff                            3463    3461      -2
> > > x86_reserve_hardware                         668     665      -3
> > > numa_init                                    697     694      -3
> > > intel_dp_compute_link_config                1224    1221      -3
> > > ieee80211_vif_update_links                  2023    2020      -3
> > > hugetlb_init                                1474    1471      -3
> > > shrink_dcache_sb                             344     340      -4
> > > hugetlb_acct_memory.part                    1113    1109      -4
> > > ext4_fill_super                            14258   14254      -4
> > > elf_coredump_extra_notes_write               435     431      -4
> > > cpc_read_ffh                                  89      85      -4
> > > _ieee80211_set_active_links                 1298    1294      -4
> > > swapfile_init                                224     219      -5
> > > cgroup_propagate_control                     342     337      -5
> > > cgroup_print_ss_mask                         186     181      -5
> > > amd_pmu_enable_all                           140     135      -5
> > > __list_lru_init                              179     174      -5
> > > weighted_interleave_nodes                    326     320      -6
> > > perf_output_sample_regs                      172     166      -6
> > > housekeeping_setup                           756     750      -6
> > > cgroup_migrate_execute                      1179    1173      -6
> > > regmap_field_init                            129     122      -7
> > > mst_stream_compute_config                   1599    1592      -7
> > > lpit_read_residency_counter_us               309     302      -7
> > > free_node_nr_active                          167     160      -7
> > > check_hw_exists                             1041    1034      -7
> > > perf_assign_events                           838     830      -8
> > > intel_pmu_init                             14230   14222      -8
> > > snapshot_write_next                         2467    2458      -9
> > > intel_psr_flush                              976     967      -9
> > > compaction_proactiveness_sysctl_handler      299     289     -10
> > > __group_cpus_evenly                         1355    1345     -10
> > > hugetlb_cgroup_read_numa_stat                634     623     -11
> > > del_from_avail_list                          241     230     -11
> > > numa_set_distance                            601     589     -12
> > > intel_drrs_activate                          376     364     -12
> > > find_next_best_node                          328     316     -12
> > > do_kmem_cache_create                        1219    1205     -14
> > > intel_get_event_constraints                  870     855     -15
> > > __build_all_zonelists                        241     226     -15
> > > sched_init_numa                             2010    1991     -19
> > > intel_gt_init_workarounds                   4277    4257     -20
> > > amd_pmu_v2_handle_irq                       1018     989     -29
> > > Total: Before=22357661, After=22357250, chg -0.00%
> > > 
> > > 
> > > * Code size shrinking ( clang-19 for x86_64 ):
> > > 
> > > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new 
> > > add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
> > > Function                                     old     new   delta
> > > Total: Before=23144745, After=23144745, chg +0.00%
> > > 
> > > * Code size shrinking ( clang-18 for x86_64 ):
> > > 
> > > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new 
> > > add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
> > > Function                                     old     new   delta
> > > Total: Before=23106698, After=23106698, chg +0.00%
> > > 
> > > * Code size shrinking ( clang-17 for x86_64 ):
> > > 
> > > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new 
> > > add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
> > > Function                                     old     new   delta
> > > Total: Before=23106698, After=23106698, chg +0.00%
> > > 
> > > * Code size shrinking ( gcc cross compiler for arm64 ):
> > > 
> > > $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> > > add/remove: 3/4 grow/shrink: 80/256 up/down: 832/-2776 (-1944)
> > > Function                                     old     new   delta
> > > perf_output_sample                          2180    2340    +160
> > > devlink_reload                               640     720     +80
> > > devlink_remote_reload_actions_performed       72     132     +60
> > > __mark_chain_precision                      4080    4124     +44
> > > force_qs_rnp                                 836     872     +36
> > > __perf_event_task_sched_in                   548     580     +32
> > > sched_update_numa                            428     452     +24
> > > numa_nearest_node                            260     284     +24
> > > iproc_gpio_irq_handler                       612     628     +16
> > > at803x_cable_test_get_status                 472     488     +16
> > > rockchip_usb2phy_otg_sm_work                 824     836     +12
> > > armv8pmu_handle_irq                          368     380     +12
> > > vf610_gpio_irq_handler                       280     288      +8
> > > rtm_new_nexthop                             4632    4640      +8
> > > rtd_gpio_irq_handle                          580     588      +8
> > > e843419@0bb0_0000e55c_6b0                      -       8      +8
> > > e843419@03b5_00004868_19f8                     -       8      +8
> > > e843419@0353_000040f7_173c                     -       8      +8
> > > aqr_phy_led_polarity_set                     208     216      +8
> > > alloc_charge_folio                           680     688      +8
> > > wait_for_completion_interruptible_timeout     352     356      +4
> > > vgic_v3_set_redist_base                      756     760      +4
> > > tegra_xhci_id_notify                         164     168      +4
> > > tcs_tx_done                                  436     440      +4
> > > sunxi_sram_show                              568     572      +4
> > > stm32_pmx_set_mux                            208     212      +4
> > > states_equal                                1352    1356      +4
> > > snapshot_write_next                         2488    2492      +4
> > > shrink_lruvec                               2752    2756      +4
> > > sched_domains_numa_masks_set                 312     316      +4
> > > rpmh_rsc_invalidate                          192     196      +4
> > > rockchip_gpio_probe                         2648    2652      +4
> > > rcu_gp_fqs_loop                             1224    1228      +4
> > > qcom_mpm_init                               1368    1372      +4
> > > phylink_create                              2304    2308      +4
> > > pfifo_fast_dequeue                          1024    1028      +4
> > > perf_pending_task                            336     340      +4
> > > owl_gpio_direction_input                     236     240      +4
> > > numa_policy_init                             680     684      +4
> > > numa_init                                    608     612      +4
> > > node_map_pfn_alignment                       360     364      +4
> > > nand_maximize_ecc                            412     416      +4
> > > mvpp2_flow_set_hek_fields                    308     312      +4
> > > mvpp22_rss_context_create.isra               212     216      +4
> > > mtk_clk_register_plls                        420     424      +4
> > > msm_config_group_get                         560     564      +4
> > > mpc8xxx_probe                                876     880      +4
> > > migrate_folio_add                            276     280      +4
> > > max77620_gpio_irq_init_hw                    156     160      +4
> > > list_lru_destroy                             428     432      +4
> > > kvm_walk_nested_s2                          1180    1184      +4
> > > kvm_pmu_nested_transition                    264     268      +4
> > > kvm_arm_pmu_v3_set_attr                     1092    1096      +4
> > > kvm_apply_hyp_relocations                    152     156      +4
> > > ksz9031_of_load_skew_values.isra             400     404      +4
> > > kcompactd                                    784     788      +4
> > > its_create_device                            944     948      +4
> > > init_mm_internals                            796     800      +4
> > > hugetlb_vm_op_close                          472     476      +4
> > > hugetlb_cma_reserve                          724     728      +4
> > > hugetlb_cgroup_css_offline                   400     404      +4
> > > hmat_register_target                         360     364      +4
> > > hclge_clear_fd_rules_in_list                 360     364      +4
> > > group_cpus_evenly                            788     792      +4
> > > dwapb_gpio_resume                            980     984      +4
> > > do_migrate_pages                             800     804      +4
> > > devm_regmap_field_bulk_alloc                 288     292      +4
> > > cgroup_apply_control_enable                  784     788      +4
> > > ccu_nkmp_round_rate                          404     408      +4
> > > ccu_nk_round_rate                            232     236      +4
> > > ccu_mp_round_rate                            632     636      +4
> > > build_overlap_sched_groups                  1196    1200      +4
> > > bcm2835_gpio_irq_handler                     368     372      +4
> > > asym_cpu_capacity_scan                       904     908      +4
> > > armv8pmu_read_counter                        216     220      +4
> > > aer_recover_work_func                        316     320      +4
> > > __update_idle_core                           312     316      +4
> > > __reset_isolation_pfn                        524     528      +4
> > > __regmap_init                               3208    3212      +4
> > > __netdev_update_lower_level                  132     136      +4
> > > __hugetlb_cgroup_charge_cgroup               648     652      +4
> > > __enqueue_entity                             496     500      +4
> > > __arm64_sys_process_mrelease                 588     592      +4
> > > wq_update_node_max_active                    624     620      -4
> > > weighted_interleave_nodes                    308     304      -4
> > > wait_for_completion_state                    492     488      -4
> > > update_64bit_reg                              76      72      -4
> > > unregister_node                              264     260      -4
> > > uniphier_u3ssphy_init                        528     524      -4
> > > tegra_xusb_mbox_thread                      1152    1148      -4
> > > tegra_gpio_irq_handler                       692     688      -4
> > > tegra186_pmc_wake_syscore_suspend            932     928      -4
> > > tegra186_pmc_wake_syscore_resume             360     356      -4
> > > sysctl_compaction_handler                    272     268      -4
> > > sync_rcu_exp_select_cpus                     676     672      -4
> > > swapfile_init                                232     228      -4
> > > svc_process_common                          1456    1452      -4
> > > sunxi_sram_claim                             336     332      -4
> > > sunxi_pmx_request                            904     900      -4
> > > sunxi_pinctrl_irq_handler                    384     380      -4
> > > stm32_pconf_dbg_show                         900     896      -4
> > > snapshot_read_next                           568     564      -4
> > > smsm_intr                                    296     292      -4
> > > show_free_areas                             2716    2712      -4
> > > sh_pfc_register_pinctrl                      392     388      -4
> > > sh_pfc_pinconf_set                           788     784      -4
> > > rockchip_usb2phy_probe                      2520    2516      -4
> > > rockchip_usb2phy_power_off                   200     196      -4
> > > rockchip_pcie_intx_handler                   260     256      -4
> > > rockchip_irq_demux                           432     428      -4
> > > remove_pool_hugetlb_folio                    288     284      -4
> > > relax_cpu_ftr_reg                            144     140      -4
> > > regmap_field_alloc                           188     184      -4
> > > regmap_exit                                  372     368      -4
> > > rcu_report_exp_cpu_mult                      228     224      -4
> > > rcec_assoc_rciep.isra                        108     104      -4
> > > qh_urb_transaction                          1164    1160      -4
> > > qcom_mpm_handler                             284     280      -4
> > > qcom_l3_cache__handle_irq                    188     184      -4
> > > phylink_validate_mask                        288     284      -4
> > > pfifo_fast_reset                             344     340      -4
> > > owl_gpio_irq_unmask                          280     276      -4
> > > out_of_memory                               1408    1404      -4
> > > node_read_distance                           276     272      -4
> > > nand_extract_bits                            184     180      -4
> > > mvpp2_ethtool_rxfh_get                       628     624      -4
> > > mvpp22_port_rss_init                         320     316      -4
> > > mvebu_sei_handle_cascade_irq                 324     320      -4
> > > mvebu_pic_handle_cascade_irq                 236     232      -4
> > > mtk_smi_larb_config_port_gen2_general        476     472      -4
> > > mtk_pll_set_rate                             416     412      -4
> > > msm_pinmux_set_mux                          1132    1128      -4
> > > mpc8xxx_gpio_irq_cascade                     160     156      -4
> > > mobiveil_pcie_isr                            576     572      -4
> > > mobiveil_pcie_host_probe                    1120    1116      -4
> > > meson_vclk_gate_is_enabled                   156     152      -4
> > > meson_vclk_div_recalc_rate                   196     192      -4
> > > meson_vclk_div_is_enabled                    156     152      -4
> > > meson_clk_cpu_dyndiv_recalc_rate             196     192      -4
> > > memory_numa_stat_show                        444     440      -4
> > > memcg_reparent_list_lrus                     612     608      -4
> > > mem_cgroup_css_released                       68      64      -4
> > > max77620_gpio_irqhandler                     256     252      -4
> > > kvm_vcpu_pmu_enable_el0                      164     160      -4
> > > kvm_vcpu_pmu_disable_el0                     172     168      -4
> > > kvm_pmu_hyp_counter_mask                     188     184      -4
> > > kvm_pmu_handle_pmcr                          340     336      -4
> > > kvm_pmu_create_perf_event                    800     796      -4
> > > kvm_compute_layout                           364     360      -4
> > > kvm_auth_eretax                              908     904      -4
> > > ksz9x31_cable_test_get_status                924     920      -4
> > > its_vpe_irq_domain_deactivate                312     308      -4
> > > ipi_mux_process                              176     172      -4
> > > interleave_nid                               264     260      -4
> > > init_cgroup_housekeeping                     252     248      -4
> > > imx_pgc_power_up                             864     860      -4
> > > imx_pgc_power_down                           876     872      -4
> > > imx_irqsteer_resume                          228     224      -4
> > > imx_irqsteer_irq_handler                     440     436      -4
> > > imx_intmux_runtime_resume                    204     200      -4
> > > imx_intmux_irq_handler                       288     284      -4
> > > iio_free_chan_devattr_list                   148     144      -4
> > > iio_device_add_info_mask_type                352     348      -4
> > > idle_cull_fn                                 428     424      -4
> > > hugetlb_init                                1504    1500      -4
> > > hugetlb_cgroup_read_numa_stat                620     616      -4
> > > hugetlb_cgroup_css_alloc                     432     428      -4
> > > hugetlb_acct_memory.part                    1104    1100      -4
> > > housekeeping_init                            192     188      -4
> > > hmat_parse_subtable                         2152    2148      -4
> > > hmat_init                                   1000     996      -4
> > > hclge_config_key.constprop                   772     768      -4
> > > get_reg_by_id                                200     196      -4
> > > free_shrinker_info                           240     236      -4
> > > free_area_init                              3816    3812      -4
> > > fmt_stack_mask.constprop                     192     188      -4
> > > fmt_reg_mask.constprop                       188     184      -4
> > > fdget                                        312     308      -4
> > > enetc_msix                                   248     244      -4
> > > enetc_alloc_rx_resources                     356     352      -4
> > > ehci_hrtimer_func                            284     280      -4
> > > dwapb_do_irq                                 316     312      -4
> > > drop_slab                                    284     280      -4
> > > devm_regmap_field_alloc                      180     176      -4
> > > demote_store                                1656    1652      -4
> > > default_hugepagesz_setup                     504     500      -4
> > > current_objcg_update                         484     480      -4
> > > cpu_pm_pmu_setup                             228     224      -4
> > > cpc_read_ffh                                 256     252      -4
> > > compute_tlb_inval_range                      512     508      -4
> > > compaction_proactiveness_sysctl_handler      264     260      -4
> > > cgroup_setup_root                            760     756      -4
> > > cgroup_propagate_control                     388     384      -4
> > > cgroup_print_ss_mask                         180     176      -4
> > > brcmstb_gpio_irq_handler                     456     452      -4
> > > bcmasp_netfilt_suspend                      1144    1140      -4
> > > bcm7120_l2_intc_irq_handle                   396     392      -4
> > > bcm7038_l1_irq_handle                        360     356      -4
> > > bcm2835_gpio_irq_handle_bank                 168     164      -4
> > > armpmu_request_irq                           728     724      -4
> > > arm_smmu_probe_device                       2000    1996      -4
> > > aqr107_config_init                           556     552      -4
> > > alloc_workqueue                             1840    1836      -4
> > > alloc_pool_huge_folio                        324     320      -4
> > > alloc_gigantic_folio.isra                    612     608      -4
> > > alloc_fd                                     476     472      -4
> > > ahci_save_initial_config                    1080    1076      -4
> > > ahci_reset_controller                        392     388      -4
> > > add_reservation_in_range                     872     868      -4
> > > _regmap_raw_multi_reg_write                  384     380      -4
> > > __show_mem                                   244     240      -4
> > > __pi___parse_cmdline                         968     964      -4
> > > __nvmem_cell_entry_write                     824     820      -4
> > > __netdev_update_upper_level                  136     132      -4
> > > __mem_cgroup_free                            228     224      -4
> > > __list_lru_init                              288     284      -4
> > > __invalidate_reclaim_iterators               144     140      -4
> > > __hmat_register_target_initiators.constprop     172     168      -4
> > > __group_cpus_evenly                         1532    1528      -4
> > > __arm64_sys_swapon                          4148    4144      -4
> > > __arm64_sys_swapoff                         3676    3672      -4
> > > __aer_print_error                            524     520      -4
> > > vmalloc_info_show                           1080    1072      -8
> > > vgic_v3_dispatch_sgi                         348     340      -8
> > > trans_pgd_idmap_page                         436     428      -8
> > > task_numa_migrate.isra                      1980    1972      -8
> > > stm32_pconf_set_speed                        272     264      -8
> > > stm32_pconf_set_bias                         272     264      -8
> > > stm32_pconf_get_speed                        132     124      -8
> > > sprd_mux_helper_set_parent                   216     208      -8
> > > sprd_div_helper_set_rate                     244     236      -8
> > > shrink_slab                                 1128    1120      -8
> > > setup_swap_info                              252     244      -8
> > > sdhci_arasan_syscon_write.isra               196     188      -8
> > > scsi_show_rq                                 776     768      -8
> > > rockchip_usb2phy_power_on                    348     340      -8
> > > rockchip_usb2phy_clk480m_unprepare           108     100      -8
> > > rockchip_usb2phy_clk480m_prepared            208     200      -8
> > > rcu_gp_cleanup                              1428    1420      -8
> > > rcar_gen4_cpg_clk_register                  1196    1188      -8
> > > owl_mux_set_parent                           192     184      -8
> > > owl_mux_helper_set_parent                    204     196      -8
> > > owl_divider_helper_set_rate                  232     224      -8
> > > numa_set_distance                            540     532      -8
> > > mux_set_parent                               200     192      -8
> > > musb_interrupt                              3540    3532      -8
> > > meson_vclk_gate_disable                       96      88      -8
> > > meson_vclk_div_set_rate                      152     144      -8
> > > memory_tier_late_init                        220     212      -8
> > > memcg_list_lru_alloc                         692     684      -8
> > > kvm_pmu_vcpu_reset                           196     188      -8
> > > ksz886x_cable_test_get_status                996     988      -8
> > > kswapd_init                                  152     144      -8
> > > input_dev_toggle                             388     380      -8
> > > hugetlb_cgroup_free                          168     160      -8
> > > housekeeping_setup                           820     812      -8
> > > gic_set_affinity                             912     904      -8
> > > free_node_nr_active                          196     188      -8
> > > establish_demotion_targets                  1060    1052      -8
> > > e843419@02b9_000035b8_450                      8       -      -8
> > > e843419@01d3_000023a7_1870                     8       -      -8
> > > dw_handle_msi_irq                            220     212      -8
> > > dma_channel_table_init                       412     404      -8
> > > del_from_avail_list                          348     340      -8
> > > check_update_ftr_reg                         388     380      -8
> > > cgroup_release                               300     292      -8
> > > cgroup_exit                                  372     364      -8
> > > cgroup_can_fork                             1144    1136      -8
> > > ccu_phase_set_phase                          284     276      -8
> > > ccu_mux_helper_set_parent                    216     208      -8
> > > ccu_mult_set_rate                            396     388      -8
> > > ccu_div_set_rate                             236     228      -8
> > > bcm2835_clock_choose_div                     148     140      -8
> > > balloon_init                                 596     588      -8
> > > alloc_shrinker_info                          476     468      -8
> > > alloc_pages_bulk_mempolicy_noprof           1304    1296      -8
> > > add_to_avail_list                            392     384      -8
> > > __cpg_z_clk_register                         340     332      -8
> > > __clk_lucid_pll_postdiv_set_rate             368     360      -8
> > > xhci_bus_resume                             1204    1192     -12
> > > task_scan_start                              340     328     -12
> > > stm32_pmx_set_mode                           376     364     -12
> > > stm32_pmx_get_mode                           240     228     -12
> > > set_max_huge_pages                          1016    1004     -12
> > > set_id_reg                                   804     792     -12
> > > sched_init_numa                             2024    2012     -12
> > > rockchip_usb2phy_bvalid_irq                  284     272     -12
> > > rebind_subsystems                           1136    1124     -12
> > > pll_get_refin                                280     268     -12
> > > mpll_recalc_rate                             288     276     -12
> > > meson_vid_pll_div_recalc_rate                352     340     -12
> > > meson_clk_pll_recalc_rate                    412     400     -12
> > > init_cpu_ftr_reg                             620     608     -12
> > > i2c_dw_handle_tx_abort                       304     292     -12
> > > ccu_nk_set_rate                              488     476     -12
> > > ccu_mp_set_rate                              464     452     -12
> > > bcmasp_netfilt_wr_m_wake.part.isra           576     564     -12
> > > __pack                                       488     476     -12
> > > weighted_interleave_nid                      416     400     -16
> > > walk_s1                                      844     828     -16
> > > uniphier_u3hsphy_init                        952     936     -16
> > > task_scan_max                                356     340     -16
> > > shrink_dcache_sb                             408     392     -16
> > > rtd_pconf_parse_conf                        1232    1216     -16
> > > rockchip_usb2phy_otg_mux_irq                 308     292     -16
> > > rockchip_usb2phy_clk480m_prepare             316     300     -16
> > > rockchip_muxgrf_set_parent                   128     112     -16
> > > regmap_field_bulk_alloc                      304     288     -16
> > > mvpp2_probe                                 3912    3896     -16
> > > meson_vclk_gate_enable                       252     236     -16
> > > meson_vclk_div_enable                        188     172     -16
> > > meson_vclk_div_disable                       184     168     -16
> > > meson_clk_pll_is_enabled                     372     356     -16
> > > meson_clk_pll_init                           284     268     -16
> > > meson_clk_pcie_pll_enable                    284     268     -16
> > > meson_clk_cpu_dyndiv_set_rate                276     260     -16
> > > cgroup_migrate_execute                      1064    1048     -16
> > > ccu_nkm_set_rate                             560     544     -16
> > > __unpack                                     412     396     -16
> > > __sync_rcu_exp_select_node_cpus              932     916     -16
> > > mpll_set_rate                                280     260     -20
> > > sprd_pll_set_rate                           1312    1288     -24
> > > rockchip_usb2phy_sm_work                     580     556     -24
> > > rockchip_usb2phy_linestate_irq               404     380     -24
> > > meson_clk_pll_set_rate                       644     620     -24
> > > meson_clk_dualdiv_set_rate                   440     416     -24
> > > ccu_nm_set_rate                              920     896     -24
> > > sprd_pll_recalc_rate                         936     908     -28
> > > meson_clk_dualdiv_recalc_rate                540     512     -28
> > > ccu_nkmp_set_rate                            784     756     -28
> > > __arm_smmu_cmdq_poll_set_valid_map           324     296     -28
> > > mpll_init                                    344     312     -32
> > > meson_clk_pll_disable                        300     268     -32
> > > select_task_rq_fair                         5956    5916     -40
> > > rockchip_usb2phy_init                       1040    1000     -40
> > > svc_create_pooled                            812     768     -44
> > > rockchip_usb2phy_id_irq                      716     668     -48
> > > meson_clk_pll_enable                         764     700     -64
> > > rockchip_usb2phy_irq                        1204    1128     -76
> > > task_numa_fault                             3760    3676     -84
> > > __devlink_reload_stats_update                116       -    -116
> > > rockchip_chg_detect_work                    1684    1564    -120
> > > perf_output_sample_regs                      212       -    -212
> > > Total: Before=31660668, After=31658724, chg -0.01%
> > > 
> > > 
> > > Every compiler, architectures combinations above can shrink the code
> > > size around 1k, except clang, which doesn't change anything before and
> > > after the change.
> > > 
> > > Analyzation of multiple functions of gcc-13 on x86_64 are performed,
> > > trying to summarize what's the positive/negative effect of this change.
> > > 
> > > * free_acpi_perf_data
> > > From bloat-o-meter, we can see the function has been shrink by 1 byte.
> > > ...
> > > free_acpi_perf_data                           75      74      -1
> > > ...
> > > 
> > > Disasembly it using
> > > $ objdump --disassemble=free_acpi_perf_data vmlinux_old > free_acpi_perf_data.old
> > > ...
> > > ffffffff81d632c3:	74 1a                	je     ffffffff81d632df <free_acpi_perf_data+0x3f>
> > > ffffffff81d632c5:	48 89 f8             	mov    %rdi,%rax
> > > ffffffff81d632c8:	48 d3 e0             	shl    %cl,%rax
> > > ffffffff81d632cb:	48 f7 d8             	neg    %rax
> > > ffffffff81d632ce:	48 21 d0             	and    %rdx,%rax
> > > ffffffff81d632d1:	74 0c                	je     ffffffff81d632df <free_acpi_perf_data+0x3f>
> > > ...
> > > 
> > > $ objdump --disassemble=free_acpi_perf_data vmlinux_new > free_acpi_perf_data.new
> > > ...
> > > ffffffff81d62ec5:	74 17                	je     ffffffff81d62ede <free_acpi_perf_data+0x3e>
> > > ffffffff81d62ec7:	48 89 fa             	mov    %rdi,%rdx
> > > ffffffff81d62eca:	48 d3 e2             	shl    %cl,%rdx
> > > ffffffff81d62ecd:	48 21 c2             	and    %rax,%rdx
> > > ffffffff81d62ed0:	74 0c                	je     ffffffff81d62ede <free_acpi_perf_data+0x3e>
> > > ...
> > > 
> > > Revert GENMASK() saves one negation here.
> > > 
> > > * tick_clock_notify
> > > From bloat-o-meter, the shrink size is
> > > ...
> > > tick_clock_notify                            109     108      -1
> > > ...
> > > 
> > > $ objdump --disassemble=tick_clock_notify vmlinux_old > tick_clock_notify.old
> > > ...
> > > ffffffff81360694:	48 8b 05 05 fc 4d 01 	mov    0x14dfc05(%rip),%rax        # ffffffff828402a0 <__cpu_possible_mask>
> > > ffffffff8136069b:	48 85 c0             	test   %rax,%rax
> > > ffffffff8136069e:	74 58                	je     ffffffff813606f8 <tick_clock_notify+0x68>
> > > ffffffff813606a0:	f3 48 0f bc c0       	tzcnt  %rax,%rax
> > > ffffffff813606a5:	89 c1                	mov    %eax,%ecx
> > > ffffffff813606a7:	83 f8 3f             	cmp    $0x3f,%eax
> > > ffffffff813606aa:	77 4c                	ja     ffffffff813606f8 <tick_clock_notify+0x68>
> > > ffffffff813606ac:	be 01 00 00 00       	mov    $0x1,%esi
> > > ffffffff813606b1:	48 c7 c2 c0 0a 02 00 	mov    $0x20ac0,%rdx
> > > ffffffff813606b8:	48 63 c1             	movslq %ecx,%rax
> > > ffffffff813606bb:	48 8b 3c c5 a0 fb 83 	mov    -0x7d7c0460(,%rax,8),%rdi
> > > ffffffff813606c2:	82 
> > > ffffffff813606c3:	48 01 d7             	add    %rdx,%rdi
> > > ffffffff813606c6:	f0 80 8f e0 00 00 00 	lock orb $0x1,0xe0(%rdi)
> > > ffffffff813606cd:	01 
> > > ffffffff813606ce:	83 c1 01             	add    $0x1,%ecx
> > > ffffffff813606d1:	48 63 c1             	movslq %ecx,%rax
> > > ffffffff813606d4:	48 83 f8 3f          	cmp    $0x3f,%rax
> > > ffffffff813606d8:	77 1e                	ja     ffffffff813606f8 <tick_clock_notify+0x68>
> > > ffffffff813606da:	48 89 f0             	mov    %rsi,%rax
> > > ffffffff813606dd:	48 d3 e0             	shl    %cl,%rax
> > > ffffffff813606e0:	48 f7 d8             	neg    %rax
> > > ffffffff813606e3:	48 23 05 b6 fb 4d 01 	and    0x14dfbb6(%rip),%rax        # ffffffff828402a0 <__cpu_possible_mask>
> > > ...
> > > 
> > > $ objdump --disassemble=tick_clock_notify vmlinux_new > tick_clock_notify.new
> > > ...
> > > ffffffff81360564:	48 8b 05 35 fd 4d 01 	mov    0x14dfd35(%rip),%rax        # ffffffff828402a0 <__cpu_possible_mask>
> > > ffffffff8136056b:	48 85 c0             	test   %rax,%rax
> > > ffffffff8136056e:	74 57                	je     ffffffff813605c7 <tick_clock_notify+0x67>
> > > ffffffff81360570:	f3 48 0f bc c0       	tzcnt  %rax,%rax
> > > ffffffff81360575:	89 c1                	mov    %eax,%ecx
> > > ffffffff81360577:	83 f8 3f             	cmp    $0x3f,%eax
> > > ffffffff8136057a:	77 4b                	ja     ffffffff813605c7 <tick_clock_notify+0x67>
> > > ffffffff8136057c:	48 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%rsi
> > > ffffffff81360583:	48 c7 c2 c0 0a 02 00 	mov    $0x20ac0,%rdx
> > > ffffffff8136058a:	48 63 c1             	movslq %ecx,%rax
> > > ffffffff8136058d:	48 8b 3c c5 a0 fb 83 	mov    -0x7d7c0460(,%rax,8),%rdi
> > > ffffffff81360594:	82 
> > > ffffffff81360595:	48 01 d7             	add    %rdx,%rdi
> > > ffffffff81360598:	f0 80 8f e0 00 00 00 	lock orb $0x1,0xe0(%rdi)
> > > ffffffff8136059f:	01 
> > > ffffffff813605a0:	83 c1 01             	add    $0x1,%ecx
> > > ffffffff813605a3:	48 63 c1             	movslq %ecx,%rax
> > > ffffffff813605a6:	48 83 f8 3f          	cmp    $0x3f,%rax
> > > ffffffff813605aa:	77 1b                	ja     ffffffff813605c7 <tick_clock_notify+0x67>
> > > ffffffff813605ac:	48 89 f0             	mov    %rsi,%rax
> > > ffffffff813605af:	48 d3 e0             	shl    %cl,%rax
> > > ffffffff813605b2:	48 23 05 e7 fc 4d 01 	and    0x14dfce7(%rip),%rax        # ffffffff828402a0 <__cpu_possible_mask>
> > > ...
> > > 
> > > One negation is saved here, I also try to reproduce it on godbolt, the
> > > link is https://godbolt.org/z/ac4h1ov7f .
> > > 
> > > For negative impact, we pick the following function
> > > 
> > > * kstat_irqs_desc
> > > ...
> > > kstat_irqs_desc                              118     122      +4
> > > ...
> > > 
> > > $ objdump --disassemble=kstat_irqs_desc vmlinux_old > kstat_irqs_desc.old
> > > ...
> > > Disassembly of section .text:
> > > 
> > > ffffffff8130c320 <kstat_irqs_desc>:
> > > ffffffff8130c320:	f3 0f 1e fa          	endbr64
> > > ffffffff8130c324:	f7 47 78 00 02 02 00 	testl  $0x20200,0x78(%rdi)
> > > ffffffff8130c32b:	74 5b                	je     ffffffff8130c388 <kstat_irqs_desc+0x68>
> > > ffffffff8130c32d:	48 8b 36             	mov    (%rsi),%rsi
> > > ffffffff8130c330:	31 d2                	xor    %edx,%edx
> > > ffffffff8130c332:	48 85 f6             	test   %rsi,%rsi
> > > ffffffff8130c335:	74 4a                	je     ffffffff8130c381 <kstat_irqs_desc+0x61>
> > > ffffffff8130c337:	f3 48 0f bc c6       	tzcnt  %rsi,%rax
> > > ffffffff8130c33c:	89 c1                	mov    %eax,%ecx
> > > ffffffff8130c33e:	83 f8 3f             	cmp    $0x3f,%eax
> > > ffffffff8130c341:	77 3e                	ja     ffffffff8130c381 <kstat_irqs_desc+0x61>
> > > ffffffff8130c343:	41 b8 01 00 00 00    	mov    $0x1,%r8d
> > > ffffffff8130c349:	48 8b 7f 60          	mov    0x60(%rdi),%rdi
> > > ffffffff8130c34d:	48 63 c1             	movslq %ecx,%rax
> > > ffffffff8130c350:	83 c1 01             	add    $0x1,%ecx
> > > ffffffff8130c353:	48 8b 04 c5 a0 fb 83 	mov    -0x7d7c0460(,%rax,8),%rax
> > > ffffffff8130c35a:	82 
> > > ffffffff8130c35b:	03 14 38             	add    (%rax,%rdi,1),%edx
> > > ffffffff8130c35e:	48 63 c1             	movslq %ecx,%rax
> > > ffffffff8130c361:	48 83 f8 3f          	cmp    $0x3f,%rax
> > > ffffffff8130c365:	77 1a                	ja     ffffffff8130c381 <kstat_irqs_desc+0x61>
> > > ffffffff8130c367:	4c 89 c0             	mov    %r8,%rax
> > > ffffffff8130c36a:	48 d3 e0             	shl    %cl,%rax
> > > ffffffff8130c36d:	48 f7 d8             	neg    %rax
> > > ffffffff8130c370:	48 21 f0             	and    %rsi,%rax
> > > ffffffff8130c373:	74 0c                	je     ffffffff8130c381 <kstat_irqs_desc+0x61>
> > > ffffffff8130c375:	f3 48 0f bc c0       	tzcnt  %rax,%rax
> > > ffffffff8130c37a:	89 c1                	mov    %eax,%ecx
> > > ffffffff8130c37c:	83 f8 3f             	cmp    $0x3f,%eax
> > > ffffffff8130c37f:	76 cc                	jbe    ffffffff8130c34d <kstat_irqs_desc+0x2d>
> > > ffffffff8130c381:	89 d0                	mov    %edx,%eax
> > > ffffffff8130c383:	e9 58 93 e8 00       	jmp    ffffffff821956e0 <__x86_return_thunk>
> > > ffffffff8130c388:	f6 47 7d 20          	testb  $0x20,0x7d(%rdi)
> > > ffffffff8130c38c:	75 9f                	jne    ffffffff8130c32d <kstat_irqs_desc+0xd>
> > > ffffffff8130c38e:	8b 97 88 00 00 00    	mov    0x88(%rdi),%edx
> > > ffffffff8130c394:	eb eb                	jmp    ffffffff8130c381 <kstat_irqs_desc+0x61>
> > > ...
> > > 
> > > $ objdump --disassemble=kstat_irqs_desc vmlinux_new >
> > > kstat_irqs_desc.new
> > > ...
> > > Disassembly of section .text:
> > > 
> > > ffffffff8130c240 <kstat_irqs_desc>:
> > > ffffffff8130c240:	f3 0f 1e fa          	endbr64
> > > ffffffff8130c244:	f7 47 78 00 02 02 00 	testl  $0x20200,0x78(%rdi)
> > > ffffffff8130c24b:	74 57                	je     ffffffff8130c2a4 <kstat_irqs_desc+0x64>
> > > ffffffff8130c24d:	48 8b 36             	mov    (%rsi),%rsi
> > > ffffffff8130c250:	31 c0                	xor    %eax,%eax
> > > ffffffff8130c252:	48 85 f6             	test   %rsi,%rsi
> > > ffffffff8130c255:	74 48                	je     ffffffff8130c29f <kstat_irqs_desc+0x5f>
> > > ffffffff8130c257:	f3 48 0f bc d6       	tzcnt  %rsi,%rdx
> > > ffffffff8130c25c:	89 d1                	mov    %edx,%ecx
> > > ffffffff8130c25e:	83 fa 3f             	cmp    $0x3f,%edx
> > > ffffffff8130c261:	77 52                	ja     ffffffff8130c2b5 <kstat_irqs_desc+0x75>
> > > ffffffff8130c263:	49 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%r8
> > > ffffffff8130c26a:	48 8b 7f 60          	mov    0x60(%rdi),%rdi
> > > ffffffff8130c26e:	48 63 d1             	movslq %ecx,%rdx
> > > ffffffff8130c271:	83 c1 01             	add    $0x1,%ecx
> > > ffffffff8130c274:	48 8b 14 d5 a0 fb 83 	mov    -0x7d7c0460(,%rdx,8),%rdx
> > > ffffffff8130c27b:	82 
> > > ffffffff8130c27c:	03 04 3a             	add    (%rdx,%rdi,1),%eax
> > > ffffffff8130c27f:	48 63 d1             	movslq %ecx,%rdx
> > > ffffffff8130c282:	48 83 fa 3f          	cmp    $0x3f,%rdx
> > > ffffffff8130c286:	77 17                	ja     ffffffff8130c29f <kstat_irqs_desc+0x5f>
> > > ffffffff8130c288:	4c 89 c2             	mov    %r8,%rdx
> > > ffffffff8130c28b:	48 d3 e2             	shl    %cl,%rdx
> > > ffffffff8130c28e:	48 21 f2             	and    %rsi,%rdx
> > > ffffffff8130c291:	74 0c                	je     ffffffff8130c29f <kstat_irqs_desc+0x5f>
> > > ffffffff8130c293:	f3 48 0f bc d2       	tzcnt  %rdx,%rdx
> > > ffffffff8130c298:	89 d1                	mov    %edx,%ecx
> > > ffffffff8130c29a:	83 fa 3f             	cmp    $0x3f,%edx
> > > ffffffff8130c29d:	76 cf                	jbe    ffffffff8130c26e <kstat_irqs_desc+0x2e>
> > > ffffffff8130c29f:	e9 3c 94 e8 00       	jmp    ffffffff821956e0 <__x86_return_thunk>
> > > ffffffff8130c2a4:	f6 47 7d 20          	testb  $0x20,0x7d(%rdi)
> > > ffffffff8130c2a8:	75 a3                	jne    ffffffff8130c24d <kstat_irqs_desc+0xd>
> > > ffffffff8130c2aa:	8b 87 88 00 00 00    	mov    0x88(%rdi),%eax
> > > ffffffff8130c2b0:	e9 2b 94 e8 00       	jmp    ffffffff821956e0 <__x86_return_thunk>
> > > ffffffff8130c2b5:	e9 26 94 e8 00       	jmp    ffffffff821956e0 <__x86_return_thunk>
> > > ...
> > > 
> > > We can find that GENMASK() indeed saves 1 negation and one "mov", but at
> > > thee same time it generate one more "jmp" and make another "jmp"
> > > instruction become "e9 2b 94 e8 00" instead of "eb eb".
> > > 
> > > * nr_processes
> > > $ objdump --disassemble=nr_processes vmlinux_old > nr_processes.old
> > > ...
> > > ffffffff812873c3:	77 1a                	ja     ffffffff812873df <nr_processes+0x5f>
> > > ffffffff812873c5:	4c 89 c0             	mov    %r8,%rax
> > > ffffffff812873c8:	48 d3 e0             	shl    %cl,%rax
> > > ffffffff812873cb:	48 f7 d8             	neg    %rax
> > > ffffffff812873ce:	48 21 d0             	and    %rdx,%rax
> > > ffffffff812873d1:	74 0c                	je     ffffffff812873df <nr_processes+0x5f>
> > > ffffffff812873d3:	f3 48 0f bc c0       	tzcnt  %rax,%rax
> > > ffffffff812873d8:	89 c1                	mov    %eax,%ecx
> > > ffffffff812873da:	83 f8 3f             	cmp    $0x3f,%eax
> > > ffffffff812873dd:	76 cc                	jbe    ffffffff812873ab <nr_processes+0x2b>
> > > ffffffff812873df:	89 f0                	mov    %esi,%eax
> > > ffffffff812873e1:	e9 fa e2 f0 00       	jmp    ffffffff821956e0 <__x86_return_thunk>
> > > ...
> > > 
> > > $ objdump --disassemble=nr_processes vmlinux_new > nr_processes.new
> > > ...
> > > ffffffff812873c4:	77 1a                	ja     ffffffff812873e0 <nr_processes+0x60>
> > > ffffffff812873c6:	4c 89 c6             	mov    %r8,%rsi
> > > ffffffff812873c9:	48 d3 e6             	shl    %cl,%rsi
> > > ffffffff812873cc:	48 89 f1             	mov    %rsi,%rcx
> > > ffffffff812873cf:	48 21 c1             	and    %rax,%rcx
> > > ffffffff812873d2:	74 0c                	je     ffffffff812873e0 <nr_processes+0x60>
> > > ffffffff812873d4:	f3 48 0f bc f1       	tzcnt  %rcx,%rsi
> > > ffffffff812873d9:	89 f1                	mov    %esi,%ecx
> > > ffffffff812873db:	83 fe 3f             	cmp    $0x3f,%esi
> > > ffffffff812873de:	76 cc                	jbe    ffffffff812873ac <nr_processes+0x2c>
> > > ffffffff812873e0:	89 d0                	mov    %edx,%eax
> > > ffffffff812873e2:	e9 f9 e2 f0 00       	jmp    ffffffff821956e0 <__x86_return_thunk>
> > > ...
> > > 
> > > GENMASK() can save 1 negation but generate 1 more "mov" thus adds 1 more
> > > register to use.
> > > 
> > > In summary, GENMASK() can elimate 1 negation for almost every use cases,
> > > but some use cases may generate additional "mov" or register in use.
> > > The use of "~_UL(0) << (l)" may even result in use of %r* registers instead of
> > > using $e* which is 32 bits registers, because compiler can't make
> > > assumption that the higher bits are zeroes. ( I'm not super sure whether
> > > it's the true cause, let me know if anything needs to be corrected or
> > > need more tests, thanks. )
> > > 
> > > v1 -> v2:
> > > 	- Refer the patch explicitly as a revert of commit c32ee3d
> > > 	- Squash commits into 1 commit
> > > 	- Perform compilation for numerous compilers, architectures and
> > > 	  compare code size shrink for each of them
> > > 	- Perform cpu-heavy workload test inside x86_64 VM and ARM64 VM
> > > 	- Analyze the result of disassembly of several small use cases
> > > 
> > > ---
> > >  include/uapi/linux/bits.h | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
> > > index 5ee30f882736..39e344a1227e 100644
> > > --- a/include/uapi/linux/bits.h
> > > +++ b/include/uapi/linux/bits.h
> > > @@ -5,12 +5,10 @@
> > >  #define _UAPI_LINUX_BITS_H
> > >  
> > >  #define __GENMASK(h, l) \
> > > -        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
> > > -         (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
> > > +(((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
> > >  
> > >  #define __GENMASK_ULL(h, l) \
> > > -        (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
> > > -         (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
> > > +(((~_ULL(0)) << (l)) & (~_ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
> > >  
> > >  #define __GENMASK_U128(h, l) \
> > >  	((_BIT128((h)) << 1) - (_BIT128(l)))
> > > -- 
> > > 2.43.0
> > >
> > 
> > So I ammend the part for different warning levels. I test against
> > gcc-11, gcc-12, gcc-13, clang-17, clang-18 and clang-19.
> > 
> > For every version of gcc, no warnings or errors will be emitted for
> > -W=0,-W=1,-W=2.
> > 
> > For clang-17, clang-18, clang-19 with -W=0, the following warning will
> > be emitted. The compilation can be completed.
> 
> Disable CONFIG_WERROR to complete it.
>  
> > vmlinux.o: warning: objtool: .discard.annotate_insn: dodgy linker, sh_entsize != 8
> > 
> > However, it already exists before this patch is applied.
> > 
> > For clang-17, clang-18, clang-19 with -W=1, the following warnings and
> > errors will be emitted. The compilation can't be completed.
> > 
> > sound/core/seq/seq_clientmgr.c:2611:22: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
> >  2611 |         snd_iprintf(buffer, msg);
> > 
> > mm/backing-dev.c:1094:58: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
> >  1094 |         dev = device_create(&bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
> > 
> > 
> > drivers/gpu/drm/i915/display/intel_display.c:5298:47: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
> >  5298 |         pipe_config_mismatch(p, fastset, crtc, name, chipname);
> > 
> > And even more, generally most of them complains about format string
> > isn't a string literal, and these errors and warnings will be emitted
> > before the patch is applied.
> 
> So if it's pre-existing, I don't care.
> 
> > Fpr clang-17, clang-18 and clang-19 with -W=2, the following errors will
> > be emitted. The compilation can't be completed.
> > 
> > ./include/linux/kcsan-checks.h:189:62: error: unused parameter 'ptr' [-Werror,-Wunused-parameter]
> >   189 | static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
> >       |                                                              ^
> > ./include/linux/kcsan-checks.h:189:74: error: unused parameter 'size' [-Werror,-Wunused-parameter]
> >   189 | static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
> >       |                                                                          ^
> > ./include/linux/kcsan-checks.h:190:10: error: unused parameter 'type' [-Werror,-Wunused-parameter]
> >   190 |                                         int type) { }
> >       |                                             ^
> > ./include/linux/kcsan-checks.h:203:42: error: unused parameter 'n' [-Werror,-Wunused-parameter]
> >   203 | static inline void kcsan_atomic_next(int n)             { }
> >       |                                          ^
> > ./include/linux/kcsan-checks.h:204:56: error: unused parameter 'mask' [-Werror,-Wunused-parameter]
> >   204 | static inline void kcsan_set_access_mask(unsigned long mask) { }
> >       |                                                        ^
> > ./include/linux/kcsan-checks.h:209:48: error: unused parameter 'ptr' [-Werror,-Wunused-parameter]
> >   209 | kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
> >       |                                                ^
> > ./include/linux/kcsan-checks.h:209:60: error: unused parameter 'size' [-Werror,-Wunused-parameter]
> >   209 | kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
> >       |                                                            ^
> > ./include/linux/kcsan-checks.h:209:70: error: unused parameter 'type' [-Werror,-Wunused-parameter]
> >   209 | kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
> >       |                                                                      ^
> > ./include/linux/kcsan-checks.h:211:72: error: unused parameter 'sa' [-Werror,-Wunused-parameter]
> >   211 | static inline void kcsan_end_scoped_access(struct kcsan_scoped_access *sa) { }
> >       |                                                                        ^
> > ./include/linux/kcsan-checks.h:229:60: error: unused parameter 'ptr' [-Werror,-Wunused-parameter]
> >   229 | static inline void kcsan_check_access(const volatile void *ptr, size_t size,
> >       |                                                            ^
> > ./include/linux/kcsan-checks.h:229:72: error: unused parameter 'size' [-Werror,-Wunused-parameter]
> >   229 | static inline void kcsan_check_access(const volatile void *ptr, size_t size,
> >       |                                                                        ^
> > fatal error: too many errors emitted, stopping now [-ferror-limit=]
> > 
> > Same as above, these errors already exists before the patch is applied.
> > In summary, none of these errors and warnings are caused by this patch.
> > 
> > I'll send other patches to fix those errors and warnings above, I don't
> > think they relate to this patch so I don't include them here, let me
> > know if they should be included, thanks!
> 
> Now I'm lost. Does it mean that clang doesn't complain anymore? Can
> you run it with CONFIG_WERROR unset and make sure?
>

Hi Yury,

Thanks for you patience and review, sorry I thought you would want
every detail so I paste everything here.

No problem I'll run with CONFIG_WERROR disabled to make sure whether
clang complains on this patch, now I've test it with clang-18 and
clang-19, it doesn't complain on it. I'll test the rest compilers
tomorrow.

I guess we should leave the thread here, it's too big I'm really sorry
for the inconvenience, I'll send v3 with a better summarized table.

Best regards,
I Hsin Cheng.


