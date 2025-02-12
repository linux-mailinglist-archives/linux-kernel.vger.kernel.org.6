Return-Path: <linux-kernel+bounces-511221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF49A327F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6E81885185
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503AB20E334;
	Wed, 12 Feb 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2pvPnPs"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA13D97A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368880; cv=none; b=ZJot9vBHvQw2IiwFmEvIwKaDstgY+WV7E1YLs0O82P7/lnj5SVWrsJ0k1epNSiIJCfh0vlTcpO7y5pl+ZCJZIqVbgiijoHniXbx5jiOAaKTjPKPR1Rvm7OPQpF7gOj4PGEt+DG+veNsPf6p4vm/9JC1llmr1/OHFkmxbuXjTsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368880; c=relaxed/simple;
	bh=GrioqqQOuqPWe807jOlWCPk03eg6E/LE53jqbsgazJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKhdx2r4vP9RUeeW4MogYzaXxSvzFj2hupTDgNzFlhwV0w7QaV3QhAEWwTWFtmsSwxhxLYwbXM7Lv/1AlpCiseVbFGCJZm8zd1dYGbJuHmZb4IJ03FX4yFtJBRBnFNmpGCBKZNk+CB/qEe4HVpkwwa6C0cgHJhFf7CPHxBGUSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2pvPnPs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f710c17baso76345025ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739368878; x=1739973678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2tC6DcAraabdZZslOtS6Zv4RJb7ZivSjAGlnAHjL4U=;
        b=e2pvPnPsu9KQrZKxkmN9cD0xcZeaCf/RQ7WD8+bdrTv6y74LORSScvXSwJ4/bgVzz+
         X4HHJPeu+/mtnDgmfZcA0xzfOYr/cYp2Jk1F470+nqLrelMA4NnoI09zkKo5oAizdoxL
         447Sry0uxcJkPe3l1kPP4AbQwfkn7mIuWXPFcmsgoo7pizEVRxfzKLUKNt8OAc79+TTk
         7DP0Jl4sUFfTl9D46wBMlBoY4Q7yJOgrJLl3qkieR9lPT81P9pNnMPYBt79zpYVUmXeR
         hR709TrcRQn3F4nTJfKKQ4COb+M2r145zVCdMLgJQMXHjgJlpv135qIR5wHeYEYGKHcj
         Sm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368878; x=1739973678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2tC6DcAraabdZZslOtS6Zv4RJb7ZivSjAGlnAHjL4U=;
        b=AGf4fOkDwopZZVB0L8rvZCeQL/Hv4T2p9yE95dmyztsBESHedB+uyn0hCBRq62qMnz
         Fc/TwZT3MGvwNxnQnoWuiMbd+nvYxUWnAK2LK05sDXpuLj7Lhyaoa9JWS0niWsBUzwuR
         Kq1YdqSzi9UGgRM7AzZvPmwuN6O/6ipYYhnQIgoyOTz5nkyZXaK87xIhR4dCjarwyIst
         9ioxmU0bcc83Sk9fLVIds7zbBgJfTo9aeuRRI3ATELKTaMTdvvEmfN5A2gYNOLYfMtHh
         s938piDZf54w5C3xmNeCwaCG6BF4s3muI5V8I17i6/+XRvV1/YR7p2Q3OwNpFtnf/xrG
         lb7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6AK3Y7wJtLfK+99etoXkcdCO4kcydmPDTkL2YMHd87WymYb4a+M5qLAuEr5ipL3NWl9eCmD0cZbet/fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFisx/TsSCUEfFSkiUv3lAWNgZqgHX4VFjxSWCN4MDd1d4+Lo
	rUrrK2OduYqz/v7Q11UULi1xIoNpO/lMs87SWQmO4UCVWFKbR3Ft
X-Gm-Gg: ASbGncsWVsW6FbEdEMG6qzymMhVXVbYPLRBK/9h+oLts53Bzmg++c62kMY+Kqy2EhK7
	/xZAIG0LYbmGBTWqX1b0H+7RVFTsDFodmlvUept6Fa9Nx/NF2ezkHj8jbnvsxzJteVnq9iFbV0a
	wdqCHIcE+FItRiyK3t0/JH8oe5lPVCxTGlwhW8VRXQW+lXvWQaMfMZsYNVKYPqzyVO5x2C/qjpY
	AbrhVUj+Xcs39g2riaJtQkwvgKcVtF1dSE7DSjVjzzNa+AGfl0FE/+sOzR+t/Twi7YuBMA8Y2Ul
	5AMDLf+gziCiwXw0UFs5gntf+JuCr9k=
X-Google-Smtp-Source: AGHT+IEUJ7zTpwgKG86ZJzNuP8t7OW21BksLGTIu10gWwUmrC4FjBAVTxONLY+pyOVBxGKSXRf7Csw==
X-Received: by 2002:a17:902:e948:b0:215:b058:289c with SMTP id d9443c01a7336-220bbab33e1mr46975545ad.8.1739368877299;
        Wed, 12 Feb 2025 06:01:17 -0800 (PST)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:bc75:3c8b:62e:1d7d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368b6badsm113767135ad.232.2025.02.12.06.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:01:16 -0800 (PST)
Date: Wed, 12 Feb 2025 22:01:12 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: anshuman.khandual@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, skhan@linuxfoundation.org
Subject: Re: [PATCH 1/2] uapi: Refactor __GENMASK() for speed-up
Message-ID: <Z6ypqCN_KI2gaSJ4@vaxr-BM6660-BM6360>
References: <20250211162412.477655-1-richard120310@gmail.com>
 <20250211162412.477655-2-richard120310@gmail.com>
 <Z6uZZPpQ9YYfrL-I@thinkpad>
 <Z6uaW9XzaKjSrWYC@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6uaW9XzaKjSrWYC@thinkpad>

On Tue, Feb 11, 2025 at 01:44:18PM -0500, Yury Norov wrote:
> On Tue, Feb 11, 2025 at 01:39:34PM -0500, Yury Norov wrote:
> > On Wed, Feb 12, 2025 at 12:24:11AM +0800, I Hsin Cheng wrote:
> > > The calculation of "((~_UL(0)) - (_UL(1) << (l)) + 1)" is to generate a
> > > bitmask with "l" trailing zeroes, which is equivalent to
> > > "(~_UL(0) << (l))".
> > 
> > I used to think that GENMASK() is a compile-time macro. __GENMASK() is
> > not, but it has very limited usage through the kernel, all in the uapi.
> >  
> > > Refactor the calculation so the number of arithmetic instruction will be
> > > reduced from 3 to 1.
> > 
> > I'd like to look at it! Please share disassembly.
> > 
> > > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> > > ---
> > > Test is done to show the speed-up we can get from reducing the number of
> > > instruction. The test machine runs with 6.9.0-0-generic kernel on x86_64
> > > architecture with processor AMD Ryzen 7 5700X3D 8-Core Processor.
> > 
> > So you CC arm maintainers and provide tests against x86_64. Are your
> > improvements consistent for arm, power and other arches?
> > 
> > Can you run bloat-o-meter against your change?
> 
> Ah, sorry, overlooked you bloat-o-meter results in cover letter.
> Anyways, can you provide it for each patch individually?

Oh ok, let me paste them here first, I'll attach them along with v2 as
well.

In the section below, vmlinux_old uses old version of GENMASK() and
GENMASK_ULL(), vmlinux_p1 use new version of GENMASK() and old version
of GENMASK_ULL(), vmlinux_p2 use new version of GENMASK() and new
version of GENMASK_ULL().

$ ./scripts/bloat-o-meter vmlinux_old vmlinux_p1
add/remove: 0/2 grow/shrink: 46/505 up/down: 464/-1717 (-1253)
Function                                     old     new   delta
store_min_perf_pct                           275     368     +93
store_hwp_dynamic_boost                      138     225     +87
store_max_perf_pct                           253     336     +83
rcu_exp_wait_wake                           2620    2651     +31
hybrid_update_cpu_capacity_scaling           311     332     +21
cpuset_mem_spread_node                       283     297     +14
perf_assign_events                           901     914     +13
xt_init                                      297     305      +8
partition_sched_domains_locked              1126    1134      +8
srcu_torture_stats_print                     534     541      +7
sock_prot_inuse_get                          121     128      +7
ring_buffer_empty                            271     278      +7
numa_policy_init                             602     609      +7
gnet_stats_add_basic                         183     190      +7
rcu_init                                    2383    2389      +6
amd_uncore_ctx_move                          286     292      +6
vmalloc_init                                1058    1062      +4
reclaim_throttle                             756     760      +4
kstat_irqs_desc                              118     122      +4
hidinput_connect                           20926   20930      +4
dev_change_proto_down_reason                 164     168      +4
cgroup_propagate_control                     403     407      +4
tracing_total_entries_read                   346     349      +3
remove_siblinginfo                          1038    1041      +3
perf_event_init                              838     841      +3
qdisc_alloc                                  472     474      +2
probes_profile_seq_show                      387     389      +2
clocksource_verify_percpu.part              1065    1067      +2
blk_mq_init_allocated_queue                  976     978      +2
__lru_add_drain_all                          502     504      +2
zone_reclaimable_pages                       692     693      +1
tcp_orphan_count_sum                         107     108      +1
sock_inuse_get                               102     103      +1
sched_balance_rq                            3745    3746      +1
proc_nr_inodes                               173     174      +1
percpu_ref_switch_to_atomic_rcu              375     376      +1
nr_processes                                 102     103      +1
netdev_refcnt_read                           102     103      +1
mq_dump_class_stats                          234     235      +1
mnt_get_writers                               96      97      +1
mnt_get_count                                 99     100      +1
get_nr_inodes                                106     107      +1
get_nr_dirty_inodes                          153     154      +1
allow_direct_reclaim                         318     319      +1
alloc_fd                                     376     377      +1
__is_kernel_percpu_address                   177     178      +1
zoneinfo_show                                823     822      -1
zhaoxin_pmu_handle_irq                       772     771      -1
zhaoxin_arch_events_quirk                    137     136      -1
workqueue_init                               927     926      -1
wake_up_all_idle_cpus                        142     141      -1
uprobe_buffer_disable                        165     164      -1
update_per_cpu_data_slice_size               216     215      -1
unregister_netdevice_many_notify            2299    2298      -1
uncore_pmu_hrtimer                           261     260      -1
uncore_event_cpu_offline                     344     343      -1
uncore_device_to_die                         163     162      -1
tsc_store_and_check_tsc_adjust               507     506      -1
tsc_restore_sched_clock_state                223     222      -1
tsc_refine_calibration_work                  938     937      -1
try_to_unmap_one                            2473    2472      -1
try_to_migrate_one                          2166    2165      -1
trace_total_entries                          192     191      -1
trace_buffered_event_enable                  347     346      -1
tmigr_cpu_offline                            404     403      -1
timer_list_start                             159     158      -1
tick_handle_oneshot_broadcast                380     379      -1
tick_clock_notify                            109     108      -1
tick_broadcast_setup_oneshot                 288     287      -1
thaw_secondary_cpus                          424     423      -1
tcp_sigpool_alloc_ahash                      885     884      -1
tc_fill_qdisc                               1125    1124      -1
sysctl_vm_numa_stat_handler                  456     455      -1
sync_runqueues_membarrier_state              319     318      -1
sw_perf_event_destroy                        133     132      -1
svc_create_pooled                            799     798      -1
sugov_stop                                   141     140      -1
store_no_turbo                               641     640      -1
snmp_fold_field                              113     112      -1
smp_call_function_any                        261     260      -1
show_stat                                   2323    2322      -1
setup_swap_info                              235     234      -1
sched_update_numa                            424     423      -1
sbitmap_init_node                            498     497      -1
rto_next_cpu                                 137     136      -1
rtm_new_nexthop                             5249    5248      -1
rt6_disable_ip                               716     715      -1
relay_reset                                  198     197      -1
relay_flush                                  198     197      -1
relay_close                                  358     357      -1
reclaim_and_purge_vmap_areas                 450     449      -1
rdmacg_resource_set_max                      892     891      -1
rcu_tasks_trace_pregp_step                  1143    1142      -1
rcu_spawn_gp_kthread                         645     644      -1
rcu_spawn_exp_par_gp_kworker                 387     386      -1
rcu_report_exp_cpu_mult                      175     174      -1
rcu_barrier_tasks_generic                    437     436      -1
rcu_barrier                                  874     873      -1
pull_dl_task                                 845     844      -1
pti_init                                     554     553      -1
print_ICs                                    299     298      -1
pfifo_fast_reset                             349     348      -1
perf_trace_event_init                        728     727      -1
perf_reboot                                  106     105      -1
perf_event_print_debug                      1227    1226      -1
percpu_counter_set                           127     126      -1
pcpu_setup_first_chunk                      2020    2019      -1
pcpu_depopulate_chunk                        412     411      -1
pcpu_alloc_noprof                           1948    1947      -1
p4_pmu_handle_irq                            631     630      -1
od_set_powersave_bias                        216     215      -1
node_dev_init                                189     188      -1
nh_fill_node                                2439    2438      -1
nfs_show_stats                              1147    1146      -1
neightbl_fill_info.constprop                1064    1063      -1
native_stop_other_cpus                       455     454      -1
mm_init.isra                                 898     897      -1
memory_tier_late_init                       1762    1761      -1
mem_init                                     520     519      -1
kswapd_init                                  110     109      -1
kmem_cache_init                              369     368      -1
kcompactd_init                               242     241      -1
irq_alloc_matrix                             247     246      -1
ipv6_add_dev                                1303    1302      -1
ipv4_mib_init_net                            509     508      -1
ip_rt_init                                   589     588      -1
ip6_route_init                               563     562      -1
iova_domain_init_rcaches                     458     457      -1
iommu_put_dma_cookie                        1044    1043      -1
ioc_timer_fn                                4908    4907      -1
intel_pstate_driver_cleanup                  223     222      -1
intel_gt_mcr_init                            886     885      -1
intel_get_event_constraints                  846     845      -1
intel_arch_events_quirk                      137     136      -1
input_leds_connect                           720     719      -1
init_sched_rt_class                          101     100      -1
init_sched_dl_class                          101     100      -1
init_gi_nodes                                132     131      -1
inet6_net_init                               644     643      -1
i915_pmu_cpu_offline                         230     229      -1
hybrid_set_capacity_of_cpus                  137     136      -1
housekeeping_init                            124     123      -1
group_cpus_evenly                            439     438      -1
gnet_stats_add_queue                         213     212      -1
get_total_entries                            199     198      -1
get_nohz_timer_target                        317     316      -1
gen11_gt_irq_handler                         924     923      -1
free_acpi_perf_data                           75      74      -1
fpu__init_system_xstate                     3179    3178      -1
fold_vm_zone_numa_events                     232     231      -1
flow_limit_cpu_sysctl                        525     524      -1
filelock_init                                396     395      -1
ext4_mb_new_blocks                          4028    4027      -1
elf_coredump_extra_notes_size                107     106      -1
ehci_hrtimer_func                            233     232      -1
dst_cache_reset_now                          163     162      -1
do_migrate_pages                             807     806      -1
dm_stats_init                                195     194      -1
dl_bw_cpus                                   136     135      -1
disable_freq_invariance_workfn               118     117      -1
default_send_IPI_mask_allbutself_phys        287     286      -1
crash_prepare_elf64_headers                  566     565      -1
cpupri_init                                  182     181      -1
cpupri_find_fitness                          416     415      -1
cpuhp_sysfs_init                             265     264      -1
cpuhp_smt_disable                            213     212      -1
cpuhp_rollback_install                       186     185      -1
cpufreq_set_policy                           801     800      -1
cpufreq_policy_free                          385     384      -1
cpufreq_online                              2578    2577      -1
cpufreq_notify_transition                    281     280      -1
cpufreq_driver_fast_switch                   207     206      -1
cpufreq_dbs_governor_start                   443     442      -1
cpufreq_dbs_governor_init                    681     680      -1
cpudl_init                                   159     158      -1
cpuacct_stats_show                           380     379      -1
cpu_map_shared_cache                         260     259      -1
cpu_dev_init                                 228     227      -1
compaction_zonelist_suitable                 329     328      -1
clock_was_set                                561     560      -1
cgroup_subtree_control_write                1008    1007      -1
cgroup_rstat_init                            168     167      -1
cgroup_rstat_boot                            105     104      -1
cgroup_post_fork                             634     633      -1
cgroup_base_stat_cputime_show                760     759      -1
can_migrate_task                             519     518      -1
call_function_init                           171     170      -1
calibrate_delay_is_known                     237     236      -1
build_all_zonelists_init                     277     276      -1
bpf_prog_alloc                               166     165      -1
blkg_alloc                                   481     480      -1
blkcg_print_stat                             880     879      -1
blkcg_iolatency_done_bio                    1775    1774      -1
blkcg_css_alloc                              568     567      -1
blk_stat_timer_fn                            378     377      -1
blk_stat_add_callback                        244     243      -1
blk_mq_sysfs_deinit                          123     122      -1
blk_mq_map_hw_queues                         175     174      -1
blk_mq_init                                  358     357      -1
blk_iocost_init                              620     619      -1
begin_new_exec                              2857    2856      -1
asym_cpu_capacity_scan                       642     641      -1
amd_uncore_umc_ctx_init                      871     870      -1
amd_pstate_change_mode_without_dvr_change     133     132      -1
amd_pmu_v2_handle_irq                       1053    1052      -1
alloc_iova_fast                              680     679      -1
alloc_desc                                   492     491      -1
addrconf_disable_policy_idev                 322     321      -1
add_to_avail_list                            310     309      -1
acpi_cpc_valid                               130     129      -1
_vm_unmap_aliases                            646     645      -1
__snmp6_fill_stats64.constprop               282     281      -1
__percpu_ref_switch_mode                     543     542      -1
__i915_gem_object_set_pages                  547     546      -1
__ftrace_clear_event_pids                    593     592      -1
__drain_swap_slots_cache                      90      89      -1
__drain_all_pages                            449     448      -1
__copy_xstate_to_uabi_buf                   2416    2415      -1
__alloc_frozen_pages_noprof                 3930    3929      -1
___gnet_stats_copy_basic.isra                387     386      -1
zone_pcp_enable                              127     125      -2
xhci_bus_resume                             1011    1009      -2
xfrm_input_init                              230     228      -2
xfeature_get_offset                          137     135      -2
x86_release_hardware                         322     320      -2
workqueue_online_cpu                         750     748      -2
workqueue_offline_cpu                        550     548      -2
weighted_interleave_nodes                    331     329      -2
vmalloc_info_show                           1000     998      -2
update_or_create_fnhe                        910     908      -2
update_group_capacity                        556     554      -2
tsc_init                                     882     880      -2
try_to_generate_entropy                      629     627      -2
tracing_set_cpumask                          284     282      -2
tracing_release                              336     334      -2
tracing_entries_read                         453     451      -2
trace_rb_cpu_prepare                         213     211      -2
toggle_bp_slot.constprop                    2861    2859      -2
timekeeping_get_mg_floor_swaps               111     109      -2
tcf_idr_create                               639     637      -2
task_non_contending                          837     835      -2
task_mm_cid_work                             498     496      -2
srcu_readers_active                          128     126      -2
srcu_barrier                                 515     513      -2
softirq_init                                 150     148      -2
snmp_seq_show_ipstats.isra                   374     372      -2
snmp6_seq_show_item64.constprop              264     262      -2
snapshot_write_next                         2486    2484      -2
snapshot_read_next                           626     624      -2
smp_prepare_cpus_common                      339     337      -2
skx_pmu_get_topology                         313     311      -2
show_slab_objects                           1071    1069      -2
show_numa_map                                980     978      -2
show_interrupts                              817     815      -2
shmem_cppc_enable                            225     223      -2
setup_zone_pageset                           327     325      -2
setup_per_cpu_pageset                        266     264      -2
set_cpus_allowed_dl                          276     274      -2
set_cpu_sibling_map                         1693    1691      -2
set_buffer_entries                            93      91      -2
seq_hlist_start_percpu                       131     129      -2
seq_hlist_next_percpu                        202     200      -2
send_pcc_cmd                                 656     654      -2
select_task_rq_fair                         4420    4418      -2
scsi_show_rq                                 800     798      -2
schedule_on_each_cpu                         335     333      -2
s_start                                      865     863      -2
ring_buffer_subbuf_order_set                1200    1198      -2
ring_buffer_overruns                         107     105      -2
ring_buffer_entries                          124     122      -2
recalc_bh_state.part                         122     120      -2
rcu_gp_cleanup                              1556    1554      -2
rcu_check_boost_fail                         467     465      -2
rcec_assoc_rciep.isra                        116     114      -2
pt_init                                      981     979      -2
process_srcu                                1676    1674      -2
phys_package_first_cpu                       122     120      -2
perf_output_sample_regs                      181     179      -2
perf_event_mux_interval_ms_store             365     363      -2
percpu_is_read_locked                        126     124      -2
per_cpu_ptr_to_phys                          266     264      -2
part_stat_read_all                           193     191      -2
part_inflight_show                           308     306      -2
part_in_flight                               133     131      -2
padata_do_serial                             237     235      -2
padata_do_multithreaded                      877     875      -2
padata_alloc_pd                              482     480      -2
p4_pmu_enable_all                            132     130      -2
numa_nearest_node                            210     208      -2
nr_iowait                                    105     103      -2
nr_context_switches                          112     110      -2
node_read_distance                           234     232      -2
netif_get_num_default_rss_queues             157     155      -2
native_smp_cpus_done                         657     655      -2
metadata_dst_alloc_percpu                    370     368      -2
memcpy_count_show                            176     174      -2
membarrier_global_expedited                  330     328      -2
loopback_get_stats64                         145     143      -2
kyber_timer_fn                               599     597      -2
kvm_flush_tlb_multi                          149     147      -2
kfree_rcu_shrink_count                       157     155      -2
kcore_update_ram.isra                        783     781      -2
iommu_dma_init_fq                            450     448      -2
iolatency_pd_init                            495     493      -2
interleave_nodes                             166     164      -2
interleave_nid                               217     215      -2
intel_pmu_init                             14167   14165      -2
intel_pmu_drain_pebs_icl                     866     864      -2
intel_gt_init_workarounds                   4139    4137      -2
input_register_device                       1348    1346      -2
init_sched_fair_class                        213     211      -2
init_cpu_to_node                             284     282      -2
inactive_task_timer                          967     965      -2
ieee80211_sta_last_active                    147     145      -2
ieee80211_rx_mgmt_beacon                    5755    5753      -2
ieee80211_add_rx_radiotap_header            2267    2265      -2
idle_threads_init                            181     179      -2
icl_display_core_init                       2347    2345      -2
hw_breakpoint_is_used                        210     208      -2
gro_cells_destroy                            342     340      -2
ftrace_dump_one                              731     729      -2
free_policy_dbs_info                         124     122      -2
free_iova_rcaches                            285     283      -2
free_area_init                              4062    4060      -2
fq_flush_timeout                             234     232      -2
flush_tlb_mm_range                           427     425      -2
ext4_update_super                            942     940      -2
ext4_mb_init                                1965    1963      -2
ext4_journal_commit_callback                 470     468      -2
ext4_fill_super                            12856   12854      -2
drv_change_sta_links                         621     619      -2
drop_slab                                    223     221      -2
do_ipt_set_ctl                              1565    1563      -2
do_ip6t_set_ctl                             1589    1587      -2
dma_channel_table_init                       279     277      -2
dm_wait_for_completion                       409     407      -2
dm_stats_message                            4382    4380      -2
dl_cpuset_cpumask_can_shrink                 268     266      -2
dl_clear_root_domain                         176     174      -2
dl_add_task_root_domain                      337     335      -2
dev_lstats_read                              137     135      -2
dev_fetch_sw_netstats                        179     177      -2
detect_cache_attributes                      795     793      -2
del_gendisk                                  849     847      -2
default_hugepagesz_setup                     454     452      -2
cpuusage_write                               199     197      -2
cpuusage_user_read                           120     118      -2
cpuusage_sys_read                            125     123      -2
cpuusage_read                                111     109      -2
cpuidle_driver_state_disabled                234     232      -2
cpufreq_show_cpus                            172     170      -2
cpuacct_all_seq_show                         292     290      -2
cpu_stop_init                                178     176      -2
cpu_rmap_copy_neigh                          140     138      -2
cpu_init_debugfs                             277     275      -2
cppc_allow_fast_switch                       133     131      -2
core_pmu_enable_all                          399     397      -2
cleanup_srcu_struct                          424     422      -2
cgroup_rstat_exit                            191     189      -2
cgroup_release                               302     300      -2
cgroup_exit                                  416     414      -2
cgroup_can_fork                             1282    1280      -2
bytes_transferred_show                       177     175      -2
blkcg_reset_stats                            481     479      -2
blk_mq_update_queue_map                      192     190      -2
blk_mq_sysfs_init                            158     156      -2
blk_mq_hw_sysfs_cpus_show                    289     287      -2
arch_tlbbatch_flush                          248     246      -2
arch_enable_hybrid_capacity_scale            241     239      -2
apply_wqattrs_prepare                        502     500      -2
apply_wqattrs_commit                         408     406      -2
amd_uncore_ctx_init                          516     514      -2
amd_pmu_enable_all                           132     130      -2
amd_pmu_cpu_prepare                          340     338      -2
amd_pmu_check_overflow                       177     175      -2
amd_numa_init                                901     899      -2
amd_detect_prefcore                          306     304      -2
alloc_pages_bulk_mempolicy_noprof           1530    1528      -2
alloc_cpu_rmap                               200     198      -2
all_vm_events                                180     178      -2
ahci_reset_controller                        301     299      -2
add_del_listener                             565     563      -2
acpi_processor_power_state_has_changed       418     416      -2
acpi_map_cpuid                               147     145      -2
acpi_get_psd_map                             367     365      -2
acpi_cpufreq_probe                           490     488      -2
_ieee80211_set_active_links                 1341    1339      -2
__zone_set_pageset_high_and_batch            104     102      -2
__sync_rcu_exp_select_node_cpus              954     952      -2
__sched_clock_work                           261     259      -2
__percpu_counter_sum                         136     134      -2
__dm_stat_init_temporary_percpu_totals       443     441      -2
slabs_cpu_partial_show                       326     323      -3
show_rcu_tasks_generic_gp_kthread            473     470      -3
show_free_areas                             2871    2868      -3
sched_balance_trigger                        923     920      -3
ring_buffer_reset_online_cpus                323     320      -3
relay_open                                   667     664      -3
register_netdevice                          2022    2019      -3
refresh_zone_stat_thresholds                 372     369      -3
rebind_subsystems                           1264    1261      -3
page_alloc_init_late                         754     751      -3
out_of_memory                               1780    1777      -3
mgts_show                                    328     325      -3
init_mm_internals                            689     686      -3
ieee80211_subif_start_xmit                  1121    1118      -3
hugetlb_init                                1602    1599      -3
hugetlb_acct_memory.part                    1112    1109      -3
dm_stat_free                                 247     244      -3
crypto_scomp_init_tfm                        261     258      -3
blk_mq_map_queues                            213     210      -3
blk_mq_hw_queue_to_node                      123     120      -3
amd_pmu_cpu_starting                         379     376      -3
update_qos_request                           250     246      -4
tracing_open                                 955     951      -4
snmp6_seq_show_item                          369     365      -4
shrink_dcache_sb                             327     323      -4
show_rcu_gp_kthreads                         834     830      -4
set_pgdat_percpu_threshold                   182     178      -4
select_fallback_rq                           718     714      -4
sched_dl_do_global                           347     343      -4
sbitmap_queue_show                           405     401      -4
ring_buffer_reset                            230     226      -4
rcu_tasks_kthread                            191     187      -4
probe_event_enable                           862     858      -4
perf_swevent_init                            492     488      -4
pcpu_populate_chunk                         1017    1013      -4
netstat_seq_show                             717     713      -4
mce_end                                      651     647      -4
intel_psr_invalidate                         667     663      -4
intel_pmu_cpu_starting                      1706    1702      -4
intel_dp_compute_link_config                1317    1313      -4
ieee80211_vif_update_links                  2562    2558      -4
hpet_open                                    491     487      -4
housekeeping_setup                           617     613      -4
ext4_attr_show                              1006    1002      -4
elf_coredump_extra_notes_write               453     449      -4
apply_wqattrs_cleanup.part                   233     229      -4
zone_pcp_reset                               178     173      -5
xt_free_table_info                           134     129      -5
x86_pmu_enable_all                           377     372      -5
wq_affn_dfl_set                              253     248      -5
workqueue_init_topology                      271     266      -5
try_check_zero                               438     433      -5
swapfile_init                                220     215      -5
start_kernel                                1996    1991      -5
sta_get_last_rx_stats                        124     119      -5
smpboot_register_percpu_thread               233     228      -5
ring_buffer_free                             145     140      -5
release_callchain_buffers_rcu                111     106      -5
rcu_dump_cpu_stacks                          433     428      -5
padata_do_parallel                           532     527      -5
load_module                                 9704    9699      -5
kvm_alloc_cpumask                            177     172      -5
kvfree_rcu_init                              571     566      -5
gro_cells_init                               257     252      -5
free_fair_sched_group                        162     157      -5
dst_cache_destroy                            141     136      -5
cpuhp_smt_enable                             243     238      -5
cgroup_print_ss_mask                         182     177      -5
alloc_buffer                                1345    1340      -5
__list_lru_init                              179     174      -5
__group_cpus_evenly                         1254    1249      -5
__fib6_drop_pcpu_from.part                   209     204      -5
x86_pmu_disable_all                          411     405      -6
trace_empty                                  233     227      -6
tcp_v4_init                                  273     267      -6
svc_seq_show                                 328     322      -6
snmp_seq_show_tcp_udp.isra                   942     936      -6
schedstat_next                               131     125      -6
ring_buffer_wake_waiters                     191     185      -6
perf_event_exit_cpu_context                  600     594      -6
percpu_down_write                            400     394      -6
pcpu_free_pages.isra                         169     163      -6
pcpu_build_alloc_info                       1307    1301      -6
packet_read_pending.isra                     105      99      -6
nv_get_stats64                               402     396      -6
net_dev_init                                 795     789      -6
kvm_smp_send_call_func_ipi                   100      94      -6
irq_migrate_all_off_this_cpu                 722     716      -6
intel_engines_init_mmio                     3432    3426      -6
init_timers                                  170     164      -6
icmpv6_init                                  289     283      -6
dma_channel_rebalance                        788     782      -6
dl_bw_manage                                 805     799      -6
cpufreq_dbs_governor_stop                    142     136      -6
blk_mq_map_swqueue                          1057    1051      -6
acpi_processor_throttling_init               788     782      -6
__percpu_counter_limited_add                 481     475      -6
__do_sys_swapon                             4260    4254      -6
__cpuacct_percpu_seq_show                    163     157      -6
wq_update_node_max_active                    529     522      -7
sysrq_timer_list_show                        277     270      -7
smpboot_destroy_threads                      150     143      -7
smp_call_function_many_cond                 1320    1313      -7
setup_cpu_entry_areas                        932     925      -7
regmap_field_init                            122     115      -7
mst_stream_compute_config                   1659    1652      -7
free_node_nr_active                          165     158      -7
dl_server_apply_params                       972     965      -7
cpu_down_maps_locked                         203     196      -7
alloc_workqueue                             2078    2071      -7
__is_module_percpu_address                   283     276      -7
sta_set_sinfo                               3014    3006      -8
show_softirqs                                334     326      -8
populate_cache_leaves                       1389    1381      -8
is_mddev_idle                                471     463      -8
irq_matrix_reserve_managed                   350     342      -8
intel_psr_flush                              982     974      -8
get_callchain_buffers                        414     406      -8
find_next_best_node                          275     267      -8
drv_change_vif_links                         635     627      -8
core_guest_get_msrs                          347     339      -8
check_hw_exists                             1074    1066      -8
__do_sys_swapoff                            3766    3758      -8
__dl_server_attach_root                      238     230      -8
x86_reserve_hardware                         680     671      -9
smp_shutdown_nonboot_cpus                    198     189      -9
schedstat_start                              125     116      -9
do_kmem_cache_create                        1252    1243      -9
cache_shared_cpu_map_remove                  340     331      -9
bioset_exit                                  381     372      -9
reserve_ds_buffers                          1595    1585     -10
hugetlb_cgroup_free                          127     117     -10
flush_all_cpus_locked                        349     339     -10
cpu_rmap_update                              573     563     -10
compaction_proactiveness_sysctl_handler      298     288     -10
ahci_save_initial_config                    1170    1160     -10
__build_all_zonelists                        229     219     -10
numa_set_distance                            578     567     -11
init_pod_type                                588     577     -11
del_from_avail_list                          220     209     -11
weighted_interleave_nid                      385     373     -12
sched_dl_overflow                           1326    1314     -12
rcu_sched_clock_irq                         4343    4331     -12
icmp_init                                    286     274     -12
hugetlb_cgroup_read_numa_stat                607     595     -12
acpi_processor_preregister_performance      1174    1162     -12
sysctl_compaction_handler                    196     183     -13
release_ds_buffers                           310     297     -13
mempolicy_sysfs_init                         664     651     -13
intel_drrs_activate                          392     379     -13
cgroup_migrate_execute                      1151    1138     -13
sched_init_numa                             1916    1902     -14
dev_get_stats                                816     802     -14
__reserve_bp_slot                            679     664     -15
dl_task_timer                               1511    1495     -16
__pfx_intel_pstate_update_policies            16       -     -16
numa_init                                    729     712     -17
__acpi_processor_set_throttling             1132    1112     -20
ring_buffer_resize                          1319    1292     -27
cppc_perf_ctrs_in_pcc                        309     276     -33
intel_pstate_update_policies                  90       -     -90
Total: Before=22438085, After=22436832, chg -0.01%


$ ./scripts/bloat-o-meter vmlinux_p1 vmlinux_p2 
add/remove: 0/0 grow/shrink: 0/5 up/down: 0/-16 (-16)
Function                                     old     new   delta
cpc_write_ffh                                167     166      -1
mce_read_aux                                 394     392      -2
__log_error                                  494     492      -2
cpc_read_ffh                                  89      85      -4
lpit_read_residency_counter_us               309     302      -7
Total: Before=22436832, After=22436816, chg -0.00%

I think this is everything bloat-o-meter generated, it really contains
many lines so I didn't paste everything in the cover letter, I'll paste
them individually in v2.

Best regards,
I Hsin Cheng




