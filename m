Return-Path: <linux-kernel+bounces-184888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6B08CAD7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA37B1F23386
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403B757E5;
	Tue, 21 May 2024 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WdE0qYBw"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B874F605
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291673; cv=none; b=D5IzCPZcxErSquHgvpCZBy4X6p7EVjLG3O3RD5llCKOglxBQsEjM1Yyzc6B465of/+gf8m84LziR5JmPmfvysrzXZaGhVEgOi+LOEIuhnzH9CCvj7InBNpfpGwDp+sarUnyw54JBeX91bbjiNW0oGd4utJvg8fCgG41dmaoW++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291673; c=relaxed/simple;
	bh=xNDNAInKtKf3bpxoZoh9ts+5fujxrEUimPAx2sT0zek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqqX2orSvDQBjhfIAxxCdEhu935IjZ7FjH6fIGTZerzKbhVr8OqVa1QbHC9c+kpLBRP8gSoAtbKMQt/iJRUhDo9UGhacdookt894KXhV9kPKXe12F4z8Z8sXJmit8jXVGzWuKbk0DaKXqsHCEX4NZFgdF7UP7VsJUoQs87HANFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WdE0qYBw; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so24256081fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716291669; x=1716896469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI07XfQSMC9cK6MuT3daLAZeRaw+OvGlzW7lVVb4+Os=;
        b=WdE0qYBw8zty2TEMyBuzIRELbf9QHhO6Vj3m+QdteJHgQ7MW0zHRLpQkzO5O5xpMtb
         RfO+YCRXjtqYxsTjaYKl4ZyO80qLbNxqPoySLmD/0tI49NE5tV7pJf6R0wCO8/7xpTHK
         mzT2d26X1gBlgHfNdzKEiRMS0uca/J2F2LWNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716291669; x=1716896469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI07XfQSMC9cK6MuT3daLAZeRaw+OvGlzW7lVVb4+Os=;
        b=ir1kdU0uwCB429eNnK3pW9xd3FLEoUJw/e57jvgwcj7DU7zkT98vaoC0I7bFi/6VhG
         uj9CBhmOW/IR3hJw3C1mmwzLX7ctiiOvkWY1NEl4AaWiL3oy7wZ88FGlcFCW7qnSeoqh
         pXdhFa5pCUP0zLIUt41U1A8yK6epSiCTCX3nu778Ijh8cpapLkPKTnhmb9SPn+x+WqCI
         klzpY5B/3F+xDVTi+EgxeHaIYIqaHLXDpdRJYseyLLEMV5z7JmsffZmMKHMAiiG7ztj0
         GvfOKffI4mPYoqZE0tOIRyHT5EozyPlyAjUlIOnR3TXUnbgdQ5XO7eFySJ1POOR/f7wT
         CV5w==
X-Forwarded-Encrypted: i=1; AJvYcCUV6gk8LGYAKwC35yXWiIuhB3YbgJd9ZDWwZ5Lv6knE6rXV9o4SfVWTm45sD+en3Xus8Ki7yqyP9h8k+QW51cRaV8nHnjF6sNAsL5yb
X-Gm-Message-State: AOJu0YwRH3J624dC5zRL0PxENrCz+X19xEHkepqt3t6NUCDNDnvn2MDd
	hsLD0aW+hM6Q6MpoyR028RIadREPyo6hZ7joxhz2NHPOnH5bkzZTM0aysjFkTiFwWk8wIJLlABy
	7yeGg6Dl6YnY5OobrAY3clf33VxwR1EM0JfI=
X-Google-Smtp-Source: AGHT+IEhxXeeBbh2BOrKt6m6KghXOqvhjkFZ7zNFHHtfRL1E0MbpSuxJv5t0rqeQbX3xq026W8m12QyudaOdOlK/Vj8=
X-Received: by 2002:a2e:9e51:0:b0:2e2:1a8b:e2f with SMTP id
 38308e7fff4ca-2e71cf38a32mr48907571fa.2.1716291669301; Tue, 21 May 2024
 04:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com>
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Tue, 21 May 2024 13:40:56 +0200
Message-ID: <CALwA+NZxiapXe-BBY6CvpqT-Z1h_YyMQr=JBwybY55TWtDNiBA@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 00/33] Fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y regression
To: Jim Cromie <jim.cromie@gmail.com>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 7:44=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com> w=
rote:
>
> hi Greg, Jason,
>
> This patchset fixes the CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy regression,
> Fixes: bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")
>
> Im calling it v8, to keep consistent with previous labels.
> v6 was what got committed, back in 9/2022.
> v7 had at least 2 problems that blocked its submission:
>
>  https://lore.kernel.org/lkml/20231101002609.3533731-1-jim.cromie@gmail.c=
om/
>  https://patchwork.freedesktop.org/series/125066/
>
> 1. missing __align(8) in METATDATA macro, giving too much placement
> freedom to linker, caused weird segvs following non-ptr vals, but for
> builtin modules only. found by lkp-test.
>
> 2. the main patch touched 2 subsystems at once, which would require
> special handling.
>
> What was broken about DYNAMIC_DEBUG ?
>
> Booting a modular kernel with drm.debug=3D0x1ff enabled pr_debugs only
> in drm itself, not in the yet-to-be loaded driver + helpers.  Once
> loaded, the driver's pr_debugs are properly enabled by:
>
>    echo 0x1ff > /sys/module/drm/parameters/debug  # still worked
>
> I had tested with scripts doing lots of modprobes with various
> permutations of dyndbg=3D<> option, and I missed that I didn't test
> without them.
>
> The deeper cause was my design error, a violation of the K&R rule:
> "define once, refer many times".
>
> DECLARE_DYNDBG_CLASSMAP defined the classmap, and was used everywhere,
> re-declaring the same static classmap repeatedly. Jani Nikula actually
> picked up on this (iirc shortly after committed), but the problem
> hadn't been seen yet in CI.  One patchset across 2 subsystems didn't
> help either.
>

Could  you summarize classmaps from the beginning ?


> So the revised classmap API "splits" it to def & ref:
>
> DYNDBG_CLASSMAP_DEFINE fixes & updates the busted macro, EXPORTing the
> classmap instead.  It gets invoked once per subsystem, by the
> parent/builtin, drm.ko for DRM.
>
> DYNDBG_CLASSMAP_USE in drivers and helpers refer to the classmap by
> name, which links the 2 modules, (like a driver's dependency on extern
> __drm_debug).
>
> These 2 tell dyndbg to map "class FOO" to the defined FOO_ID, which
> allows it to make those changes via >control, in both class definer
> modules and dependent modules.
>
> DYNDBG_CLASSMAP_PARAM*, defines the controlling kparam, and binds it
> to both the _var, and the _DEFINEd classmap.  So drm uses this to bind
> the classmap to __drm_debug.
>
> It provides the common control-point for the sub-system; it is applied
> to the class'd pr_debugs during modprobe of both _DEFINEr and USErs.
> It also enforces the relative nature of LEVEL classmaps, ie V3>V2.
>
> DECLARE_DYNDBG_CLASSMAP is preserved to decouple the DRM patches, so
> they can be applied later.  I've included them for anyone who wants to
> test against DRM now.
>
> A new struct and elf section contain the _USEs; on modprobe, these are
> scanned similarly to the _DEFINEs, but follow the references to their
> defining modules, find the kparam wired to the classmap, and apply its
> classmap settings to the USEr.  This action is what V1 missed, which
> is why drivers failed to enable debug during modprobe.
>
> In order to recapitulate the regression scenario without involving
> DRM, the patchset adds test_dynamic_debug_submod, which is a duplicate
> of its parent; _submod.c #defines _SUBMOD, and then includes parent.
>
> This puts _DEFINE and _USE close together in the same file, for
> obviousness, and to guarantee that the submod always has the same
> complement of debug()s, giving consistent output from both when
> classmaps are working properly.
>
> Also ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh adds a
> turn-key selftest.  I pulled it forward from a dyndbg-to-trace patchset
> that I and Lukasz Bartozik have been working out.
>
> It works nicely from virtme-ng:
>
> [jimc@frodo vx]$ vrun_ -- ./tools/testing/selftests/dynamic_debug/dyndbg_=
selftest.sh
> doing: vng --verbose --name v6.9-rc5-34-g2f1ace6e1c68 \
>        --user root --cwd ../.. \
>        -a dynamic_debug.verbose=3D2 -p 4 \
>        -- ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> virtme: waiting for virtiofsd to start
> ...
> [    3.546739] ip (260) used greatest stack depth: 12368 bytes left
> [    3.609288] virtme-init: starting script
> test_dynamic_debug_submod not there
> test_dynamic_debug not there
> # BASIC_TESTS
> ...
> # Done on: Fri Apr 26 20:45:08 MDT 2024
> [    4.765751] virtme-init: script returned {0}
> Powering off.
> [    4.805790] ACPI: PM: Preparing to enter system sleep state S5
> [    4.806223] kvm: exiting hardware virtualization
> [    4.806564] reboot: Power down
> [jimc@frodo vx]$
>
>
> I've been running the kernel on my x86 desktop & laptop, booting with
> drm.debug=3D0x1f, then turning it all-off after sleep 15.
>
> a few highlights from a bare-metal boot:
>
> here modprobe amdgpu; dyndbg applies last bit/class/category, and
> finishes init, then drm and amdgpu start logging as they execute
>
> [    9.019696] gandalf kernel: dyndbg: query 0: "class DRM_UT_ATOMIC +p" =
mod:amdgpu
> [    9.019704] gandalf kernel: dyndbg: class-ref: amdgpu.DRM_UT_ATOMIC  m=
odule:amdgpu nd:4754 nc:0 nu:1
> [    9.020012] gandalf kernel: dyndbg: processed 1 queries, with 21 match=
es, 0 errs
> [    9.020017] gandalf kernel: dyndbg: bit_4: 21 matches on class: DRM_UT=
_ATOMIC -> 0x1f
> [    9.020021] gandalf kernel: dyndbg: applied bitmap: 0x1f to: 0x0 for a=
mdgpu
> [    9.020026] gandalf kernel: dyndbg: attach-client-module:  module:amdg=
pu nd:4754 nc:0 nu:1
> [    9.020031] gandalf kernel: dyndbg: 4754 debug prints in module amdgpu
> [    9.055065] gandalf kernel: [drm] amdgpu kernel modesetting enabled.
> [    9.055138] gandalf kernel: [drm:amdgpu_acpi_detect [amdgpu]] No match=
ing acpi device found for AMD3000
> [    9.055564] gandalf kernel: amdgpu: Virtual CRAT table created for CPU
> [    9.055585] gandalf kernel: amdgpu: Topology: Add CPU node
> [    9.055752] gandalf kernel: amdgpu 0000:0c:00.0: enabling device (0006=
 -> 0007)
> [    9.055821] gandalf kernel: [drm] initializing kernel modesetting (NAV=
I10 0x1002:0x731F 0x148C:0x2398 0xC1).
> [    9.055835] gandalf kernel: [drm] register mmio base: 0xFCB00000
> [    9.055839] gandalf kernel: [drm] register mmio size: 524288
> [    9.059148] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgp=
u]] number of dies: 1
> [    9.059387] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgp=
u]] number of hardware IPs on die0: 39
> [    9.059623] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgp=
u]] ATHUB(35) #0 v2.0.0:
> [    9.059856] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgp=
u]]         0x00000c00
> [    9.060096] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgp=
u]]         0x02408c00
> [    9.060328] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgp=
u]] set register base offset for ATHUB
>
> a startup script, after sleep 15, turns off the logging:
>
>   echo 0 > /sys/module/drm/parameters/debug
>
> heres 1st 2 bits/classes/categories being turned off:
>
> [   29.105991] gandalf kernel: [drm:amdgpu_ih_process [amdgpu]] amdgpu_ih=
_process: rptr 90752, wptr 90784
> [   29.118086] gandalf kernel: dyndbg: bits:0x0 > *.debug
> [   29.118096] gandalf kernel: dyndbg: apply bitmap: 0x0 to: 0x1f for '*'
> [   29.118102] gandalf kernel: dyndbg: query 0: "class DRM_UT_CORE -p" mo=
d:*
> [   29.118122] gandalf kernel: dyndbg: good-class: drm.DRM_UT_CORE  modul=
e:drm nd:338 nc:1 nu:0
> [   29.119548] gandalf kernel: dyndbg: class-ref: drm_kms_helper.DRM_UT_C=
ORE  module:drm_kms_helper nd:93
> nc:0 nu:1
> [   29.119552] gandalf kernel: dyndbg: class-ref: drm_display_helper.DRM_=
UT_CORE  module:drm_display_helper nd:151 nc:0 nu:1
> [   29.119737] gandalf kernel: dyndbg: class-ref: amdgpu.DRM_UT_CORE  mod=
ule:amdgpu nd:4754 nc:0 nu:1
> [   29.122181] gandalf kernel: [drm:amdgpu_ih_process [amdgpu]] amdgpu_ih=
_process: rptr 90784, wptr 90816
> [   29.127687] gandalf kernel: dyndbg: processed 1 queries, with 466 matc=
hes, 0 errs
> [   29.127690] gandalf kernel: dyndbg: bit_0: 466 matches on class: DRM_U=
T_CORE -> 0x0
> [   29.127692] gandalf kernel: dyndbg: query 0: "class DRM_UT_DRIVER -p" =
mod:*
> [   29.127696] gandalf kernel: dyndbg: good-class: drm.DRM_UT_DRIVER  mod=
ule:drm nd:338 nc:1 nu:0
> [   29.127699] gandalf kernel: dyndbg: class-ref: drm_kms_helper.DRM_UT_D=
RIVER  module:drm_kms_helper nd:93 nc:0 nu:1
> [   29.127701] gandalf kernel: dyndbg: class-ref: drm_display_helper.DRM_=
UT_DRIVER  module:drm_display_helper nd:151 nc:0 nu:1
> [   29.127885] gandalf kernel: dyndbg: class-ref: amdgpu.DRM_UT_DRIVER  m=
odule:amdgpu nd:4754 nc:0 nu:1
> [   29.152925] gandalf kernel: dyndbg: processed 1 queries, with 1384 mat=
ches, 0 errs
>
>
> The resulting journal is ~14.6k lines, written in the 1st 15 (29)
> seconds of startup.  I'm unsure what the 15/29 discrepancy might
> indicate/betray, besides a lot of logging work.  sleep 15 is not the
> best stopwatch.
>
> Recent spins thru lkp-test have also been SUCCESS-ful.
>
> CC: Lukas Bartosik <ukaszb@chromium.org>
> CC: Kees Cook <keescook@chromium.org>   # recent selftests/ reviews
>
> Jim Cromie (33):
>
> cleanups & preparations:
>   docs/dyndbg: update examples \012 to \n
>   test-dyndbg: fixup CLASSMAP usage error
>   dyndbg: reword "class unknown," to "class:_UNKNOWN_"
>   dyndbg: make ddebug_class_param union members same size
>   dyndbg: replace classmap list with a vector
>   dyndbg: ddebug_apply_class_bitmap - add module arg, select on it
>   dyndbg: split param_set_dyndbg_classes to _module & wrapper fns
>   dyndbg: drop NUM_TYPE_ARRAY
>   dyndbg: reduce verbose/debug clutter
>   dyndbg: silence debugs with no-change updates
>   dyndbg: tighten ddebug_class_name() 1st arg type
>   dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
>   dyndbg: reduce verbose=3D3 messages in ddebug_add_module
>   dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
>
> core fix & selftests:
>   dyndbg-API: fix DECLARE_DYNDBG_CLASSMAP
>   selftests-dyndbg: add tools/testing/selftests/dynamic_debug/*
>   selftests-dyndbg: exit 127 if no facility
>   dyndbg-API: promote DYNDBG_CLASSMAP_PARAM to API
>   dyndbg-doc: add classmap info to howto
>   dyndbg: treat comma as a token separator
>   selftests-dyndbg: add comma_terminator_tests
>   dyndbg: split multi-query strings with %
>   selftests-dyndbg: test_percent_splitting multi-cmds on module classes
>   docs/dyndbg: explain new delimiters: comma, percent
>   selftests-dyndbg: add test_mod_submod
>   selftests-dyndbg: test dyndbg-to-tracefs
>   dyndbg-doc: explain flags parse 1st
>
> DRM parts
>   drm+drivers: adapt to use DYNDBG_CLASSMAP_{DEFINE,USE}
>   drm-dyndbg: adapt to use DYNDBG_CLASSMAP_PARAM
>   drm: use correct ccflags-y spelling
>   drm-drivers: DRM_CLASSMAP_USE in 2nd batch of drivers, helpers
>   drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
>   drm-print: workaround compiler meh
>
>  .../admin-guide/dynamic-debug-howto.rst       |  99 ++-
>  MAINTAINERS                                   |   3 +-
>  drivers/gpu/drm/Kconfig                       |   3 +-
>  drivers/gpu/drm/Makefile                      |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +-
>  drivers/gpu/drm/display/drm_dp_helper.c       |  12 +-
>  drivers/gpu/drm/drm_crtc_helper.c             |  12 +-
>  drivers/gpu/drm/drm_gem_shmem_helper.c        |   2 +
>  drivers/gpu/drm/drm_print.c                   |  38 +-
>  drivers/gpu/drm/gud/gud_drv.c                 |   2 +
>  drivers/gpu/drm/i915/i915_params.c            |  12 +-
>  drivers/gpu/drm/mgag200/mgag200_drv.c         |   2 +
>  drivers/gpu/drm/nouveau/nouveau_drm.c         |  12 +-
>  drivers/gpu/drm/qxl/qxl_drv.c                 |   2 +
>  drivers/gpu/drm/radeon/radeon_drv.c           |   2 +
>  drivers/gpu/drm/udl/udl_main.c                |   2 +
>  drivers/gpu/drm/vkms/vkms_drv.c               |   2 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |   2 +
>  include/asm-generic/vmlinux.lds.h             |   1 +
>  include/drm/drm_print.h                       |  10 +
>  include/linux/dynamic_debug.h                 | 127 ++-
>  kernel/module/main.c                          |   3 +
>  lib/Kconfig.debug                             |  24 +-
>  lib/Makefile                                  |   3 +
>  lib/dynamic_debug.c                           | 435 ++++++----
>  lib/test_dynamic_debug.c                      | 131 +--
>  lib/test_dynamic_debug_submod.c               |  17 +
>  tools/testing/selftests/Makefile              |   1 +
>  .../testing/selftests/dynamic_debug/Makefile  |   9 +
>  tools/testing/selftests/dynamic_debug/config  |   2 +
>  .../dynamic_debug/dyndbg_selftest.sh          | 765 ++++++++++++++++++
>  31 files changed, 1391 insertions(+), 359 deletions(-)
>  create mode 100644 lib/test_dynamic_debug_submod.c
>  create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
>  create mode 100644 tools/testing/selftests/dynamic_debug/config
>  create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest=
sh
>
> --
> 2.45.0
>

