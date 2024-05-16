Return-Path: <linux-kernel+bounces-181382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD208C7B79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75308B211D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D4F156F38;
	Thu, 16 May 2024 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi7LutoG"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E68156C62
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881452; cv=none; b=jeZ2V8IZL6akEtWysMeQaeHuI417vfxe3jLd/aTWmddAQ/WC+Zrbq0JvK03+uhNpxVkQztibJNP7eLcYskEuEulcl1/b2YOiYN8Pz7wYuoaULBPd5BkxI7AI/eZGRz/XADt2k+qhV8pb8vBkSTaPu6u2HxLMa4VdJNKtdHXii7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881452; c=relaxed/simple;
	bh=X67cgAhG557+M5hfpB/v43+qC4wqGkGaM56PJgCcOGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=okCag4UNHQ5IUVZ2SAHW71TTaJRBDoGAy76Vr4Jdbw12CEaeJZFK5Jjukjg+Cw9Hd7+K2dukvl5AZFZUe4Q7UT20ImqvRd7ipXx4WFOrx6SXtKSmuIciSgm5DJsNGFFB078+i6Q+vOwMvEM30J7cep4lOBn7kJm1M2+M0GCTtEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi7LutoG; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e1b4f96994so66949839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881449; x=1716486249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LoHyVT7WDY3vkqF8Eq1a+UKQFrFlF+k16aI9Zk8fM8c=;
        b=Pi7LutoGOgbArFgPUpEfGm7O/1pann2NURchOl7lpdNaqjZgV9fGhDzTF6ZWh+gRZr
         tDt+/BXlFT2Yze1PGXay4XccvP/oN+bPj0i2AY7/KmFbzpj7DozjoILhkXYhW58BEJPH
         BPXPHUGogx+v0ldn/sphtIbIrAJMZ0Lk6NvNSJTw/CIw37mbSF7PSooV+PogP2fE5aHO
         6Zk8X5+5rtVPelNu2/oPCCI13LVFa3M055bKb/+blim3AE+1Wl86a7p+ybm/uDUu56hw
         X2fRWv2BZLVTl9GuH7oX7IJUV3kxV7ZUYgqU2MHnsTAojVTBWYYQcS2d8Y6sEs5vifdx
         HGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881449; x=1716486249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoHyVT7WDY3vkqF8Eq1a+UKQFrFlF+k16aI9Zk8fM8c=;
        b=a03jBi8sNq2IzbT/6Q6RLgnbkYmM1bpES7sVusguJ7Mmmhgbqwb/qwCaf5bh+iN7gZ
         EFbLplxIKaoP7W6++bstZ6RapRKTuiyIJz8HC+savph0wjIWxZJSwTI5BLCIGwGVnnOM
         HPVALEtOb3AGPl5xlu7OvbKbeaVQW6IsZzRZULEQhFWKyXQWX4EogpyjJVfSA7/zy2/k
         8KUZKgGQYoW3psHkmbEzxy83v2CVoOmIccBVHyRJekRxiY0080h22I/I4daK7f77cXlG
         +IYb6D6VJopgwheRo6ASTH0ghGqIPE8PJbVyYoxChz/sIq0x/vs+lCz8MevxSdf3eH9B
         RVCg==
X-Forwarded-Encrypted: i=1; AJvYcCXjbrRY9unjYRETx8ec+0HqtzYvqH8fMyuGHLxpvR0hXLg9cfEvORkPXTMNOTB45KJV6qxffIE6gMZ2MAJbKDqPHKO6TyjhQcM3zrpg
X-Gm-Message-State: AOJu0YzSJJGmm/MZfpFHTTyTtTVeP9eio0D9LudNo1c1Vt8GyS8C5JQz
	kIfgYxEICwpPCL+He3RcxtU+a+JX27uU1gFcjTLpbTe7MEZ7f/tQ
X-Google-Smtp-Source: AGHT+IHd8Xd8vuqpADIZ4/sz2WlVC5RPINegR1jJWKeqrq7Yc59KCOw7pXyS5/izALhRSg6QiEgWyw==
X-Received: by 2002:a5d:8042:0:b0:7de:d698:32c8 with SMTP id ca18e2360f4ac-7e1b51b0d35mr2098558939f.7.1715881449112;
        Thu, 16 May 2024 10:44:09 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:08 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH v8-RESEND 00/33] Fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y regression
Date: Thu, 16 May 2024 11:43:24 -0600
Message-ID: <20240516174357.26755-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hi Greg, Jason,

This patchset fixes the CONFIG_DRM_USE_DYNAMIC_DEBUG=y regression,
Fixes: bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")

Im calling it v8, to keep consistent with previous labels.
v6 was what got committed, back in 9/2022.
v7 had at least 2 problems that blocked its submission:

 https://lore.kernel.org/lkml/20231101002609.3533731-1-jim.cromie@gmail.com/
 https://patchwork.freedesktop.org/series/125066/

1. missing __align(8) in METATDATA macro, giving too much placement
freedom to linker, caused weird segvs following non-ptr vals, but for
builtin modules only. found by lkp-test.

2. the main patch touched 2 subsystems at once, which would require
special handling.

What was broken about DYNAMIC_DEBUG ?

Booting a modular kernel with drm.debug=0x1ff enabled pr_debugs only
in drm itself, not in the yet-to-be loaded driver + helpers.  Once
loaded, the driver's pr_debugs are properly enabled by:

   echo 0x1ff > /sys/module/drm/parameters/debug  # still worked
   
I had tested with scripts doing lots of modprobes with various
permutations of dyndbg=<> option, and I missed that I didn't test
without them.

The deeper cause was my design error, a violation of the K&R rule:
"define once, refer many times".

DECLARE_DYNDBG_CLASSMAP defined the classmap, and was used everywhere,
re-declaring the same static classmap repeatedly. Jani Nikula actually
picked up on this (iirc shortly after committed), but the problem
hadn't been seen yet in CI.  One patchset across 2 subsystems didn't
help either.

So the revised classmap API "splits" it to def & ref:

DYNDBG_CLASSMAP_DEFINE fixes & updates the busted macro, EXPORTing the
classmap instead.  It gets invoked once per subsystem, by the
parent/builtin, drm.ko for DRM.

DYNDBG_CLASSMAP_USE in drivers and helpers refer to the classmap by
name, which links the 2 modules, (like a driver's dependency on extern
__drm_debug).

These 2 tell dyndbg to map "class FOO" to the defined FOO_ID, which
allows it to make those changes via >control, in both class definer
modules and dependent modules.

DYNDBG_CLASSMAP_PARAM*, defines the controlling kparam, and binds it
to both the _var, and the _DEFINEd classmap.  So drm uses this to bind
the classmap to __drm_debug.

It provides the common control-point for the sub-system; it is applied
to the class'd pr_debugs during modprobe of both _DEFINEr and USErs.
It also enforces the relative nature of LEVEL classmaps, ie V3>V2.

DECLARE_DYNDBG_CLASSMAP is preserved to decouple the DRM patches, so
they can be applied later.  I've included them for anyone who wants to
test against DRM now.

A new struct and elf section contain the _USEs; on modprobe, these are
scanned similarly to the _DEFINEs, but follow the references to their
defining modules, find the kparam wired to the classmap, and apply its
classmap settings to the USEr.  This action is what V1 missed, which
is why drivers failed to enable debug during modprobe.

In order to recapitulate the regression scenario without involving
DRM, the patchset adds test_dynamic_debug_submod, which is a duplicate
of its parent; _submod.c #defines _SUBMOD, and then includes parent.

This puts _DEFINE and _USE close together in the same file, for
obviousness, and to guarantee that the submod always has the same
complement of debug()s, giving consistent output from both when
classmaps are working properly.

Also ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh adds a
turn-key selftest.  I pulled it forward from a dyndbg-to-trace patchset
that I and Lukasz Bartozik have been working out.

It works nicely from virtme-ng:

[jimc@frodo vx]$ vrun_ -- ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
doing: vng --verbose --name v6.9-rc5-34-g2f1ace6e1c68 \
       --user root --cwd ../.. \
       -a dynamic_debug.verbose=2 -p 4 \
       -- ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
virtme: waiting for virtiofsd to start
..
[    3.546739] ip (260) used greatest stack depth: 12368 bytes left
[    3.609288] virtme-init: starting script
test_dynamic_debug_submod not there
test_dynamic_debug not there
# BASIC_TESTS 
..
# Done on: Fri Apr 26 20:45:08 MDT 2024
[    4.765751] virtme-init: script returned {0}
Powering off.
[    4.805790] ACPI: PM: Preparing to enter system sleep state S5
[    4.806223] kvm: exiting hardware virtualization
[    4.806564] reboot: Power down
[jimc@frodo vx]$ 


I've been running the kernel on my x86 desktop & laptop, booting with
drm.debug=0x1f, then turning it all-off after sleep 15.

a few highlights from a bare-metal boot:

here modprobe amdgpu; dyndbg applies last bit/class/category, and
finishes init, then drm and amdgpu start logging as they execute

[    9.019696] gandalf kernel: dyndbg: query 0: "class DRM_UT_ATOMIC +p" mod:amdgpu
[    9.019704] gandalf kernel: dyndbg: class-ref: amdgpu.DRM_UT_ATOMIC  module:amdgpu nd:4754 nc:0 nu:1
[    9.020012] gandalf kernel: dyndbg: processed 1 queries, with 21 matches, 0 errs
[    9.020017] gandalf kernel: dyndbg: bit_4: 21 matches on class: DRM_UT_ATOMIC -> 0x1f
[    9.020021] gandalf kernel: dyndbg: applied bitmap: 0x1f to: 0x0 for amdgpu
[    9.020026] gandalf kernel: dyndbg: attach-client-module:  module:amdgpu nd:4754 nc:0 nu:1
[    9.020031] gandalf kernel: dyndbg: 4754 debug prints in module amdgpu
[    9.055065] gandalf kernel: [drm] amdgpu kernel modesetting enabled.
[    9.055138] gandalf kernel: [drm:amdgpu_acpi_detect [amdgpu]] No matching acpi device found for AMD3000
[    9.055564] gandalf kernel: amdgpu: Virtual CRAT table created for CPU
[    9.055585] gandalf kernel: amdgpu: Topology: Add CPU node
[    9.055752] gandalf kernel: amdgpu 0000:0c:00.0: enabling device (0006 -> 0007)
[    9.055821] gandalf kernel: [drm] initializing kernel modesetting (NAVI10 0x1002:0x731F 0x148C:0x2398 0xC1).
[    9.055835] gandalf kernel: [drm] register mmio base: 0xFCB00000
[    9.055839] gandalf kernel: [drm] register mmio size: 524288
[    9.059148] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgpu]] number of dies: 1
[    9.059387] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgpu]] number of hardware IPs on die0: 39
[    9.059623] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgpu]] ATHUB(35) #0 v2.0.0:
[    9.059856] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgpu]]         0x00000c00
[    9.060096] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgpu]]         0x02408c00
[    9.060328] gandalf kernel: [drm:amdgpu_discovery_set_ip_blocks [amdgpu]] set register base offset for ATHUB

a startup script, after sleep 15, turns off the logging:

  echo 0 > /sys/module/drm/parameters/debug

heres 1st 2 bits/classes/categories being turned off:

[   29.105991] gandalf kernel: [drm:amdgpu_ih_process [amdgpu]] amdgpu_ih_process: rptr 90752, wptr 90784
[   29.118086] gandalf kernel: dyndbg: bits:0x0 > *.debug
[   29.118096] gandalf kernel: dyndbg: apply bitmap: 0x0 to: 0x1f for '*'
[   29.118102] gandalf kernel: dyndbg: query 0: "class DRM_UT_CORE -p" mod:*
[   29.118122] gandalf kernel: dyndbg: good-class: drm.DRM_UT_CORE  module:drm nd:338 nc:1 nu:0
[   29.119548] gandalf kernel: dyndbg: class-ref: drm_kms_helper.DRM_UT_CORE  module:drm_kms_helper nd:93 
nc:0 nu:1
[   29.119552] gandalf kernel: dyndbg: class-ref: drm_display_helper.DRM_UT_CORE  module:drm_display_helper nd:151 nc:0 nu:1
[   29.119737] gandalf kernel: dyndbg: class-ref: amdgpu.DRM_UT_CORE  module:amdgpu nd:4754 nc:0 nu:1
[   29.122181] gandalf kernel: [drm:amdgpu_ih_process [amdgpu]] amdgpu_ih_process: rptr 90784, wptr 90816
[   29.127687] gandalf kernel: dyndbg: processed 1 queries, with 466 matches, 0 errs
[   29.127690] gandalf kernel: dyndbg: bit_0: 466 matches on class: DRM_UT_CORE -> 0x0
[   29.127692] gandalf kernel: dyndbg: query 0: "class DRM_UT_DRIVER -p" mod:*
[   29.127696] gandalf kernel: dyndbg: good-class: drm.DRM_UT_DRIVER  module:drm nd:338 nc:1 nu:0
[   29.127699] gandalf kernel: dyndbg: class-ref: drm_kms_helper.DRM_UT_DRIVER  module:drm_kms_helper nd:93 nc:0 nu:1
[   29.127701] gandalf kernel: dyndbg: class-ref: drm_display_helper.DRM_UT_DRIVER  module:drm_display_helper nd:151 nc:0 nu:1
[   29.127885] gandalf kernel: dyndbg: class-ref: amdgpu.DRM_UT_DRIVER  module:amdgpu nd:4754 nc:0 nu:1
[   29.152925] gandalf kernel: dyndbg: processed 1 queries, with 1384 matches, 0 errs


The resulting journal is ~14.6k lines, written in the 1st 15 (29)
seconds of startup.  I'm unsure what the 15/29 discrepancy might
indicate/betray, besides a lot of logging work.  sleep 15 is not the
best stopwatch.

Recent spins thru lkp-test have also been SUCCESS-ful.

CC: Lukas Bartosik <ukaszb@chromium.org>
CC: Kees Cook <keescook@chromium.org>	# recent selftests/ reviews

Jim Cromie (33):

cleanups & preparations:
  docs/dyndbg: update examples \012 to \n
  test-dyndbg: fixup CLASSMAP usage error
  dyndbg: reword "class unknown," to "class:_UNKNOWN_"
  dyndbg: make ddebug_class_param union members same size
  dyndbg: replace classmap list with a vector
  dyndbg: ddebug_apply_class_bitmap - add module arg, select on it
  dyndbg: split param_set_dyndbg_classes to _module & wrapper fns
  dyndbg: drop NUM_TYPE_ARRAY
  dyndbg: reduce verbose/debug clutter
  dyndbg: silence debugs with no-change updates
  dyndbg: tighten ddebug_class_name() 1st arg type
  dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
  dyndbg: reduce verbose=3 messages in ddebug_add_module
  dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code

core fix & selftests:
  dyndbg-API: fix DECLARE_DYNDBG_CLASSMAP
  selftests-dyndbg: add tools/testing/selftests/dynamic_debug/*
  selftests-dyndbg: exit 127 if no facility
  dyndbg-API: promote DYNDBG_CLASSMAP_PARAM to API
  dyndbg-doc: add classmap info to howto
  dyndbg: treat comma as a token separator
  selftests-dyndbg: add comma_terminator_tests
  dyndbg: split multi-query strings with %
  selftests-dyndbg: test_percent_splitting multi-cmds on module classes
  docs/dyndbg: explain new delimiters: comma, percent
  selftests-dyndbg: add test_mod_submod
  selftests-dyndbg: test dyndbg-to-tracefs
  dyndbg-doc: explain flags parse 1st

DRM parts
  drm+drivers: adapt to use DYNDBG_CLASSMAP_{DEFINE,USE}
  drm-dyndbg: adapt to use DYNDBG_CLASSMAP_PARAM
  drm: use correct ccflags-y spelling
  drm-drivers: DRM_CLASSMAP_USE in 2nd batch of drivers, helpers
  drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
  drm-print: workaround compiler meh

 .../admin-guide/dynamic-debug-howto.rst       |  99 ++-
 MAINTAINERS                                   |   3 +-
 drivers/gpu/drm/Kconfig                       |   3 +-
 drivers/gpu/drm/Makefile                      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +-
 drivers/gpu/drm/display/drm_dp_helper.c       |  12 +-
 drivers/gpu/drm/drm_crtc_helper.c             |  12 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        |   2 +
 drivers/gpu/drm/drm_print.c                   |  38 +-
 drivers/gpu/drm/gud/gud_drv.c                 |   2 +
 drivers/gpu/drm/i915/i915_params.c            |  12 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c         |   2 +
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  12 +-
 drivers/gpu/drm/qxl/qxl_drv.c                 |   2 +
 drivers/gpu/drm/radeon/radeon_drv.c           |   2 +
 drivers/gpu/drm/udl/udl_main.c                |   2 +
 drivers/gpu/drm/vkms/vkms_drv.c               |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |   2 +
 include/asm-generic/vmlinux.lds.h             |   1 +
 include/drm/drm_print.h                       |  10 +
 include/linux/dynamic_debug.h                 | 127 ++-
 kernel/module/main.c                          |   3 +
 lib/Kconfig.debug                             |  24 +-
 lib/Makefile                                  |   3 +
 lib/dynamic_debug.c                           | 435 ++++++----
 lib/test_dynamic_debug.c                      | 131 +--
 lib/test_dynamic_debug_submod.c               |  17 +
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   2 +
 .../dynamic_debug/dyndbg_selftest.sh          | 765 ++++++++++++++++++
 31 files changed, 1391 insertions(+), 359 deletions(-)
 create mode 100644 lib/test_dynamic_debug_submod.c
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

-- 
2.45.0


