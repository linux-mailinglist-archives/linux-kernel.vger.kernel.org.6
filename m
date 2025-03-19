Return-Path: <linux-kernel+bounces-568923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD7A69C20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA4687A7504
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD321C165;
	Wed, 19 Mar 2025 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GudSDk9C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA1421A443
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423693; cv=none; b=Wj2kAYipn+d47tWeb8iU0m1DSi+Pg/GOX3/4FhBOR6LqTXA989JZlY4KoLnBcfBQJgd1UxdmqOzY5qn9duMYOpkRtEtJlL4LCQ8oFJVkx/NQN4xLkMlBIWPzaG512mIzgUCf+usZO44LC8lRadX8t9cNOrpR0LizU1K85+fhlEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423693; c=relaxed/simple;
	bh=xYPas7ZEs9kNht3SijItcSrsHf0Xo+rj62G/VmHmiZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOu+Nrwja//yKoYWDzH1URDMKFSnIMy8H/JuaC+52vltjZZCd58L1DhCgOyo8RfXgvXj4Txti/mE/Vpn63fMwR7Cxxu9iR8RiZjP7RTlEd85j0h+DpGqSRYg31NOLe3In9VwClXxJVNIL5lVXpJ7Z7FGg1uzc0/D67AnJ/3xm7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GudSDk9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96142C4CEE4;
	Wed, 19 Mar 2025 22:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742423692;
	bh=xYPas7ZEs9kNht3SijItcSrsHf0Xo+rj62G/VmHmiZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GudSDk9CgvDLA5Cm86dFS6910YOmmpom/4dFU58Tq+jWIh5TIFy2shL86CF/bz0xz
	 gkkBE8RiBG6hW2lWev749dQScqYOim1lOKrfPyqzkwzyOegfMeeCzmFan7NTQakpf/
	 C/eB4UOvbd/PFeOiTw67ZQ5Pd145T4FeLE2thDcT6XHBxnM5l26eLL3Mu1Hmobifk5
	 wO41axEiGKK+E6gganXkIGtL03eTsKGYfg9sRwVF9ZalhaUlmZhRvB54vhYngWdroW
	 I6XTh2LDPhcYhTWOXZ2bByoz5lRshwe/i1h4PFblgLRirixrNYM/qJP4avoPmSx+xr
	 +2edcJhp6yF/w==
Date: Wed, 19 Mar 2025 23:34:47 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] compiler/gcc: Make asm() templates asm __inline__() by
 default
Message-ID: <Z9tGh0Fa96gACmpQ@gmail.com>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
 <Z9m1rtmlk1PxGIQA@gmail.com>
 <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>
 <Z9m_kUqxqMPfU8Fl@gmail.com>
 <Z9nTfFiPv0-Lxm-_@gmail.com>
 <CAFULd4aFUun7+1izxbDM8nTEEta5PApysyTGsn1hjvQND=2UtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4aFUun7+1izxbDM8nTEEta5PApysyTGsn1hjvQND=2UtQ@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Tue, Mar 18, 2025 at 9:11 PM Ingo Molnar <mingo@kernel.org> wrote:
> 
> >  #ifdef CONFIG_CC_HAS_ASM_INLINE
> >  # define asm_inline __asm__ __inline
> >  # define asm(...) asm_inline(__VA_ARGS__)
> >  #else
> >  # define asm_inline asm
> >  #endif
> >
> > And I fixed up the places where this isn't syntactically correct:
> >
> >  35 files changed, 82 insertions(+), 79 deletions(-)
> >
> > I haven't looked at code generation much yet, but text size changes are
> > minimal:
> >
> >       text         data     bss      dec            hex filename
> >   29429076      7931870 1401196 38762142        24f769e vmlinux.before
> >   29429631      7931870 1401200 38762701        24f78cd vmlinux.after
> >
> > Which is promising, assuming I haven't messed up anywhere.
> 
> Please use bloat-o-meter, it is more precise.

Here's the bloat-o-meter output between vanilla and patched vmlinux:

add/remove: 6/20 grow/shrink: 43/13 up/down: 4245/-2812 (1433)
Function                                     old     new   delta
__ia32_sys_pidfd_send_signal                  21     818    +797
__x64_sys_pidfd_send_signal                   22     818    +796
nl80211_send_wiphy                         11189   11867    +678
icl_update_topdown_event                     473     691    +218
intel_joiner_adjust_timings.isra               -     145    +145
deactivate_locked_super                      148     249    +101
tcp_v4_send_synack                           301     389     +88
kill_anon_super                               53     137     +84
xa_destroy                                   291     371     +80
__xa_set_mark                                135     209     +74
ip_fraglist_prepare                          204     269     +65
store_hwp_dynamic_boost                      136     200     +64
csum_partial                                 239     302     +63
ip_fraglist_init                             155     217     +62
store_max_perf_pct                           252     311     +59
ip_frag_next                                 377     434     +57
ip_do_fragment                              1644    1701     +57
__ip_local_out                               283     340     +57
store_min_perf_pct                           273     329     +56
__udp4_lib_rcv                              2917    2970     +53
freeze_super                                1124    1175     +51
super_wake                                     -      47     +47
ieee80211_parse_tx_radiotap                 1267    1311     +44
ic_bootp_recv                               1333    1371     +38
vlv_compute_watermarks                      2267    2299     +32
intel_atomic_commit_tail                    5423    5455     +32
_g4x_compute_pipe_wm                         397     429     +32
__ieee80211_xmit_fast                       2611    2643     +32
intel_format_info_is_yuv_semiplanar           43      72     +29
skl_main_to_aux_plane                        113     136     +23
ip_auto_config                              4029    4050     +21
__memcpy_flushcache                          369     386     +17
validate_beacon_head                         240     256     +16
tcp_v4_rcv                                  4850    4866     +16
intel_enable_transcoder                     1443    1459     +16
intel_cx0pll_state_verify                   1859    1875     +16
intel_cx0_phy_check_hdmi_link_rate           181     197     +16
inet_gro_receive                             569     585     +16
__pfx_super_wake                               -      16     +16
__pfx_intel_joiner_adjust_timings.isra         -      16     +16
__pfx_intel_cx0_read.constprop                 -      16     +16
intel_fb_is_gen12_ccs_aux_plane.isra          95     107     +12
_intel_modeset_primary_pipes                  79      91     +12
intel_cx0_read.constprop                       -      10     +10
intel_fb_is_ccs_aux_plane                    110     117      +7
intel_crtc_readout_derived_state             513     516      +3
wq_update_node_max_active                    538     540      +2
intel_set_cdclk_pre_plane_update             838     840      +2
intel_sseu_subslice_total                     67      68      +1
intel_crtc_compute_config                    890     889      -1
_intel_modeset_secondary_pipes                50      47      -3
intel_mtl_pll_enable                        7472    7460     -12
bxt_set_cdclk                               1328    1316     -12
vfs_get_tree                                 205     189     -16
intel_fb_modifier_to_tiling                  186     170     -16
__pfx_nl80211_send_iftype_data                16       -     -16
__pfx_lane_mask_to_lane                       16       -     -16
__pfx_kill_super_notify.part                  16       -     -16
__pfx_ip_fast_csum                            16       -     -16
__pfx_intel_pstate_update_policies            16       -     -16
__pfx_intel_joiner_adjust_timings             16       -     -16
__pfx_format_is_yuv_semiplanar.part.isra      16       -     -16
__pfx_cdclk_divider                           16       -     -16
__pfx___icl_update_topdown_event              16       -     -16
__pfx___do_sys_pidfd_send_signal              16       -     -16
intel_c20_sram_read.constprop                173     149     -24
xas_split_alloc                              302     270     -32
nl80211_parse_sched_scan                    3311    3279     -32
kill_litter_super                             70      31     -39
format_is_yuv_semiplanar.part.isra            41       -     -41
lane_mask_to_lane                             44       -     -44
ip_fast_csum                                  48       -     -48
intel_cx0pll_readout_hw_state               1085    1037     -48
intel_pstate_update_policies                  66       -     -66
cdclk_divider                                 69       -     -69
kill_super_notify.part                       111       -    -111
__icl_update_topdown_event                   112       -    -112
intel_joiner_adjust_timings                  140       -    -140
intel_fill_fb_info                          2998    2813    -185
intel_tile_width_bytes                       747     531    -216
nl80211_send_iftype_data                     574       -    -574
__do_sys_pidfd_send_signal                   811       -    -811
Total: Before=22547058, After=22548491, chg +0.01%

A lot fewer functions are affected than I expected from such a 
large-scope change.

> Actually, functions with the most impact (x86 locking functions and
> __arch_hweight) were recently converted to asm_inline, so besides
> __untagged_addr, the remaining have very little impact, if at all
> (c.f. amd_clear_divider() ). There is also no need to convert asm()
> without directives inside.

I did the test with Linus-vanilla (81e4f8d68c66) to maximize the 
potential effect, which doesn't have those changes yet.

See tip:WIP.x86/core.

> My proposal would be to convert the remaining few cases (the remaining
> asms involving ALTERNATIVE and exceptions) "by hand" to asm_inline()
> and stick a rule in checkpatch to use asm_inline() in the code
> involving asm(), like we have the rule with asm volatile.
> 
> I don't think redefining an important C keyword is a good approach, it
> obfuscates its meaning too much. And as has been shown by Ingo's
> experiment, there is a substantial effort to fix false positives.
> Instead of fixing these, we can trivially convert the remaining cases
> to asm_volatile() as well, without obfuscating asm(). Checkpatch can
> take care of future cases.

This would work for me too. The cross-arch impact and churn seems 
substantial.

Thanks,

	Ingo

