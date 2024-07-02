Return-Path: <linux-kernel+bounces-238420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E2924A44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B49E286E08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFD7205E1F;
	Tue,  2 Jul 2024 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmkUP769"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BF201270
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957496; cv=none; b=oEx26surYoeew9+IEjgKmT8FxKRbRs4GY3WP9AB77xw65/iHq2wsAD7Jiay1hGnjSFzkXbNRIJcnyZ0+Pkzk/F2lwqb+7igjjYiph8V/N9heCUyew62Atdlmu9167qqlaaDy8gVDAYAdbbSLdwR4Ii9MjahdLNPuIr5ypVxvfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957496; c=relaxed/simple;
	bh=lP/cKbWF3sKBojvGG07Z1gG985K0E+2pIPH3bpAlnG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MBlHEuPM/Ea9sN5bLuRCyw2Rm3S2zdNo9ksMzxpQ5lCDOgrOJe7vHZgJCFp04NoDOTzrNsb1dHNuWMCqwxTs2SM5Iw6+6nsgxr4BT9OgQjm34iVYbvRZ5Ck/Fu3RtXc061NlzDZ2Jv7N0/rmaW86iPuDG8eXnbUgSJzqZlbhA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmkUP769; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7f649f7868dso113894739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957494; x=1720562294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fl2FF9Ma/I8h3PqNjR+deguiV1BjKiYak4AQnpA/EpA=;
        b=cmkUP769SoQO0e+7iJDQ+KCc92dT9lZdD7hc6hef/fKNen8JKvvYpKtw7zJwQALJGb
         tB6u+P8N80nJjdg71cZUwEAuRD0UELB4uPt0VUkYieqv4NhP8FCDJvRNXZITe3epUjVA
         gDu9MXB47jwUEkhSdR9DO1mvWsiZVbR0snlITjzOkKqAb0HqFcDV0o7a/rOzkegwlQNN
         QvePj8KUDaiuJ4Cbvc01+LsWyZHNr90PziTpFhDxkToERedCkNk6mmU/Lcqih/ulk3f+
         Zx+lWwemZO8FjbOqGmPp4g1GWhU+zppGu4Wu9KQMWH7XuWWOy+tUI4uoG/hnw21nhSQv
         D7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957494; x=1720562294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fl2FF9Ma/I8h3PqNjR+deguiV1BjKiYak4AQnpA/EpA=;
        b=PC+HJnhf9+h5fDY06nnqs6ZRgAakFVWxe9m/AcfUEtu2+T9BiJlu/M/cbv6baPmrzj
         hpR9lFKW3LVEnqyAoNAUioGGVIAoFRUn4t3nLWyZQ0egkFJ0LXrIvpvj22jHjkr8NxdP
         7WdDwkQY3pwalW3exOnaV3E2yih7vD/O348hL+2WzGPT1eWS1yEJylJOyVNE29q0Lveg
         lu63fL8g+XhRj+AXqPIoyEQ0BqrIITcg2FLpDx9iELCRJnqEWeNKwXAESanSzThE2PKl
         pT4Oc7rLP2qRPaGF6/bda6ACfbmnmkKApnVo5JpY39sm75bbTyToAYHChibjEahcTF8H
         OtzQ==
X-Gm-Message-State: AOJu0Yxq7SSmERedksGK1rQGL9gIWTrN8rX4OcmipKXIQ0msDi4Z/+01
	zxRpW4+p1OrzrxAFpZhm5fr3g1OHq1Se2fiaCytKgdbfsbCp0RJb
X-Google-Smtp-Source: AGHT+IGaEXgYKgGRee2GarLYqwSUqyegplLELGXvlNn9MGuEctJXOEfcGJyWIGJ/hUK31AN85K/RRQ==
X-Received: by 2002:a05:6602:15c2:b0:7f6:19b9:3a3b with SMTP id ca18e2360f4ac-7f62edfe2e9mr1312922239f.1.1719957493878;
        Tue, 02 Jul 2024 14:58:13 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:13 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 00/53] fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y
Date: Tue,  2 Jul 2024 15:56:50 -0600
Message-ID: <20240702215804.2201271-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixes dynamic-debug support for DRM.debug, added via classmaps.
commit bb2ff6c27bc9 (drm: Disable dynamic debug as broken)

CONFIG_DRM_USE_DYNAMIC_DEBUG=y was marked broken because drm.debug=val
was applied when drm.ko was modprobed; too early for the yet-to-load
drivers, which thus missed the enablement.  My testing with
/etc/modprobe.d/ entries and modprobes with dyndbg=$querycmd options
obscured this omission.

The fix is to replace invocations of DECLARE_DYNDBG_CLASSMAP with
DYNDBG_CLASSMAP_DEFINE for core, and DYNDBG_CLASSMAP_USE for drivers.
The distinction allows dyndbg to also handle the users properly.

DRM is the only current classmaps user, and is not really using it,
so if you think DRM could benefit from zero-off-cost debugs based on
static-keys, please test.

HISTORY

9/4/22  - ee879be38bc8..ace7c4bbb240 commited - classmaps-v1 dyndbg parts
9/11/22 - 0406faf25fb1..16deeb8e18ca commited - classmaps-v1 drm parts

https://lore.kernel.org/lkml/Y3XUrOGAV4I7bB3M@kroah.com/
greg k-h says:
This should go through the drm tree now.  The rest probably should also
go that way and not through my tree as well.

https://lore.kernel.org/lkml/20221206003424.592078-1-jim.cromie@gmail.com/
v1- RFC. adds DYNDBG_CLASSMAP_DEFINE + test-submod to recap DRM failure

https://lore.kernel.org/lkml/20230113193016.749791-1-jim.cromie@gmail.com/
v2- w RFC on "tolerate toggled state"

https://lore.kernel.org/lkml/Y8aNMxHpvZ8qecSc@hirez.programming.kicks-ass.net/
- PeterZ - nacks tolerance of insane/uninit static-key state

https://lore.kernel.org/lkml/8ca08fba-1120-ca86-6129-0b33afb4a1da@akamai.com/
- JasonB diagnoses prob - set jump-label b4 init

7deabd674988 dyndbg: use the module notifier callbacks
- JasonB lands fix for my problem
  he moves dyndbg to use notifiers to do init, like & after jump-labels

https://lore.kernel.org/lkml/20230125203743.564009-20-jim.cromie@gmail.com/
v3- probing, workaround-ish

https://lore.kernel.org/lkml/20230713163626.31338-1-jim.cromie@gmail.com/
v4 - 7/13/23
- had extra/unused __UNIQUE_ID warnings/errs on lkp-tested arches
  due to unmatched __used marks
- RandyD doc fixes, thx.

https://lore.kernel.org/lkml/20230801170255.163237-1-jim.cromie@gmail.com/
v5 - 8/1/23
- lkp-test reported panics-on-boot
  https://lore.kernel.org/lkml/202308031432.fcb4197-oliver.sang@intel.com/
- DRM=y in apply-params
- missing align(8) in init-macro, failed only for builtin modules

https://lore.kernel.org/lkml/20230911230838.14461-1-jim.cromie@gmail.com/
v6 - 9/11/23 - no feedback

v7[a-d] - attempts to get into/thru DRM patchwork CI..
- "jenius" struck, I preserved DECLARE_DYNDBG_CLASSMAP til later

v8[a-i] - added tools/testing/selftests/dynamic_debug/*

- now turnkey testable without DRM


CLASSMAPS FROM THE TOP

dynamic-debug classmap's primary goal was to bring zero-off-cost
debugs, via static-keys, to DRM.

drm.debug: is ~5000 debugs across core, drivers, helpers; each in 1 of
10 exclusive categories, all controlled by bits in a sysfs knob.

  drm.debug=0x1ff  # bootarg
  echo 0x4 > /sys/module/drm/parameters/debug  # run-time setting

Below the sysfs interface, classmaps are exposed in the >control
grammar with a new "class" keyword.  This is mostly like the other
keywords, differing by:

a- classnames are client/subsystem/domain defined, not code-name-structural.
   the classnames are global, across system
   IOW: "class DRM_UT_CORE" selects on any module which knows the class

b- classes are protected from unqualified modification.

   # cannot disable any DRM (or other) classes
   echo -p > /proc/dynamic_debug/control

c- classes don't have wildcards - add if needed.
   DRM uses "${SUBSYS}_${CATNAME}"
   probably more useful with "${TOP}_${MID}_${LOW}" classnames

API in use:

DRM defines its categories with an enum-type, the obvious thing to do
was to copy/emulate that for classmaps; this also preserves the
__pr_dbg_class(DRM_UT_CORE, "core stuff") style already used in drm's
~5000 drm_dbg_* macro calls.

DYNDBG_CLASSMAP_DEFINE(drm_debug_classes, ...);
DYNDBG_CLASSMAP_USE(drm_debug_classes);

Classmaps get DEFINEd once (in drm.ko for core) and USEd (in drivers
and helpers), these 2 declarations respectively define and export a
classmap (in core), and refer to the exported class-struct from the
modules.

They both tell dynamic-debug that the module has some of these class'd
pr_debugs, so dyndbg uses the classmap's names to validate >control inputs.

The distinction allows USErs to act differently than the DEFINEr; they
have to follow the ref back to the DEFINEing module, find the kparam
connected to the classmap, and lookup and apply its modprobed value.
(this is the bug-fix).

Dyndbg uses the classnames to validate "class FOO" >control inputs,
and apply the changes to each module that has DEFINEd or USEd the
classmap.

This makes classmaps opt-in: modules must _DEFINE or _USE a classmap
for their class'd pr_debug()s to be >control'd.

NOTE: __pr_dbg_class(1, "const-int unreachable class 1"); is legal,
but not controllable unless the const 1 has been mapped to a _DEFINE'd
classname.

NB: and __pr_dbg_class(i++, "undeclared class") is illegal.

In drm_print.c we have:

/* classnames must match value-symbols of enum drm_debug_category */
DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
                    DRM_UT_CORE,
                    "DRM_UT_CORE",
                    "DRM_UT_DRIVER",
                    "DRM_UT_KMS",
                    "DRM_UT_PRIME",
                    "DRM_UT_ATOMIC",
                    "DRM_UT_VBL",
                    "DRM_UT_STATE",
                    "DRM_UT_LEASE",
                    "DRM_UT_DP",
                    "DRM_UT_DRMRES");

This maps the sequence of "classnames" to ints starting with DRM_UT_CORE.
other offsets allow sharing the per-module 0..63 class-id space
  
Only complete, linear maps are recommended.

An APPLY_FN(__stringify, __VA_ARGS__) would fix the "string-indirection"
I have one written, but didnt want to overload this submission.

DYNDBG_CLASSMAP_PARAM_REF() creates the sysfs-kparam classbits knob,
binding the extern'd long-int/bitvec to the classmap.

DRM's categories are independent of each other.  The other possible
classmap-type/behavior is "related", ie somehow "ordered": V3>V2.  The
relatedness of classes in a classmap is enforced at the kparam, where
they are all set together, not at the >control interface.

THE PATCHSET has 2 halves:

1- dynamic-debug fix - API change

The root cause was DECLARE_DYNDBG_CLASSMAP tried to do too much, and
its use in both core and drivers, helpers couldnt sort the difference.

The fix is to replace it with DYNDBG_CLASSMAP_DEFINE in core, and
DYNDBG_CLASSMAP_USE in drivers,helpers. The 1st differs from -v1 by
exporting the classmap, allowing 2nd to ref it.  They respectively add
records to 2 ELF sections in the module.

Now, dyndbg's on-modprobe handler follows the _USE/refs to the owning
module, finds the controlling kparam: drm.debug, and applies its value
thru the classmap, to the module's pr_debugs.

Recent revs of this patchset added a selftest for dyndbg, which
recapitulates the DRM regression scenario using the 2 test modules.
The test verifies that the dependent module is initialized properly
from the parent's classmap kparam.

So it gives a basic turnkey selftest:

 [root@v6 b0-dd-drm]# V=0 ../../tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh 
 # consulting KCONFIG_CONFIG: .config
 # BASIC_TESTS 
 : 0 matches on =p
 : 14 matches on =p
 : 0 matches on =p
 : 21 matches on =mf
 : 0 matches on =ml
 : 6 matches on =mfl
 ...
 # Done on: Sun Jun 30 10:34:24 PM MDT 2024
	 
This latest rev fixes the test for the various CONFIG_DYNAMIC_DEBUG*
build combos, by skipping some subtests where the expected counts are
wrong. Lukasz Bartosik caught this - thanks.
CC: ukaszb@chromium.org


2- DRM fixes - use new api.

These are largely unchanged since -v1 above:

a. update core to invoke DRM_CLASSMAP_DEFINE
b. wrap DYNDBG_CLASSMAP_* with DRM_CLASSMAP_* - hide ifdef

c. now with separate +DRM_CLASSMAP_USE patches for each driver/helper: 
d. and defer dropping DECLARE_DYNDBG_CLASSMAP til later

Maybe theres a single place to invoke DRM_CLASSMAP_USE just once,
perhaps from a client library c-file. I poked a little, didn't find it.

Patches are against v6.9
theyre also at:
tree/branch: https://github.com/jimc/linux.git dd-classmap-fix-8i
branch HEAD: dd31011435409a5bd70cc92bfd846407f6f1a2d8  drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN


Finally, classmaps are in a meta-stable state right now; some governor
might walk it over to the gravel pit out back.

Tested-bys would help greatly, get it off the fence it straddles.
Please specify method: selftest or drm.debug=0x1ff boot.

Also entertaining Reviewed-bys :-}


Jim Cromie (52):

DYNAMIC-DEBUG parts:

cleanup:
  docs/dyndbg: update examples \012 to \n
  test-dyndbg: fixup CLASSMAP usage error
  dyndbg: reword "class unknown," to "class:_UNKNOWN_"
  dyndbg: make ddebug_class_param union members same size
  dyndbg: replace classmap list with a vector

prep:
  dyndbg: ddebug_apply_class_bitmap - add module arg, select on it
  dyndbg: split param_set_dyndbg_classes to _module & wrapper fns
  dyndbg: drop NUM_TYPE_ARRAY
  dyndbg: reduce verbose/debug clutter
  dyndbg: silence debugs with no-change updates
  dyndbg: tighten ddebug_class_name() 1st arg type
  dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
  dyndbg: reduce verbose=3 messages in ddebug_add_module

API changes & selftest:  
  dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
  dyndbg-API: fix DECLARE_DYNDBG_CLASSMAP
  selftests-dyndbg: add tools/testing/selftests/dynamic_debug/*
  dyndbg-API: promote DYNDBG_CLASSMAP_PARAM to API
  dyndbg-doc: add classmap info to howto
  dyndbg: treat comma as a token separator
  selftests-dyndbg: add comma_terminator_tests
  dyndbg: split multi-query strings with %
  selftests-dyndbg: test_percent_splitting
  docs/dyndbg: explain new delimiters: comma, percent
  selftests-dyndbg: add test_mod_submod
  dyndbg-doc: explain flags parse 1st
  dyndbg: change __dynamic_func_call_cls* macros into expressions
  selftests-dyndbg: check KCONFIG_CONFIG to avoid silly fails
  dyndbg-selftest: reduce default verbosity

DRM-parts:

  drm: use correct ccflags-y spelling
  drm-dyndbg: adapt drm core to use dyndbg classmaps-v2
  drm-dyndbg: adapt DRM to invoke DYNDBG_CLASSMAP_PARAM
  drm-dyndbg: DRM_CLASSMAP_USE in amdgpu driver
  drm-dyndbg: DRM_CLASSMAP_USE in i915 driver
  drm-dyndbg: DRM_CLASSMAP_USE in drm_crtc_helper
  drm-dyndbg: DRM_CLASSMAP_USE in drm_dp_helper
  drm-dyndbg: DRM_CLASSMAP_USE in nouveau
  drm-print: workaround unused variable compiler meh
  drm-dyndbg: add DRM_CLASSMAP_USE to Xe driver
  drm-dyndbg: add DRM_CLASSMAP_USE to virtio_gpu
  drm-dyndbg: add DRM_CLASSMAP_USE to simpledrm
  drm-dyndbg: add DRM_CLASSMAP_USE to bochs
  drm-dyndbg: add DRM_CLASSMAP_USE to etnaviv
  drm-dyndbg: add DRM_CLASSMAP_USE to gma500 driver
  drm-dyndbg: add DRM_CLASSMAP_USE to radeon
  drm-dyndbg: add DRM_CLASSMAP_USE to vmwgfx driver
  drm-dyndbg: add DRM_CLASSMAP_USE to vkms driver
  drm-dyndbg: add DRM_CLASSMAP_USE to udl driver
  drm-dyndbg: add DRM_CLASSMAP_USE to mgag200 driver
  drm-dyndbg: add DRM_CLASSMAP_USE to the gud driver
  drm-dyndbg: add DRM_CLASSMAP_USE to the qxl driver
  drm-dyndbg: add DRM_CLASSMAP_USE to the drm_gem_shmem_helper driver
  drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN

 .../admin-guide/dynamic-debug-howto.rst       |  99 ++-
 MAINTAINERS                                   |   3 +-
 drivers/gpu/drm/Kconfig                       |   3 +-
 drivers/gpu/drm/Makefile                      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +-
 drivers/gpu/drm/display/drm_dp_helper.c       |  12 +-
 drivers/gpu/drm/drm_crtc_helper.c             |  12 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        |   2 +
 drivers/gpu/drm/drm_print.c                   |  38 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c         |   2 +
 drivers/gpu/drm/gma500/psb_drv.c              |   2 +
 drivers/gpu/drm/gud/gud_drv.c                 |   2 +
 drivers/gpu/drm/i915/i915_params.c            |  12 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c         |   2 +
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  12 +-
 drivers/gpu/drm/qxl/qxl_drv.c                 |   2 +
 drivers/gpu/drm/radeon/radeon_drv.c           |   2 +
 drivers/gpu/drm/tiny/bochs.c                  |   2 +
 drivers/gpu/drm/tiny/simpledrm.c              |   2 +
 drivers/gpu/drm/udl/udl_main.c                |   2 +
 drivers/gpu/drm/virtio/virtgpu_drv.c          |   2 +
 drivers/gpu/drm/vkms/vkms_drv.c               |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |   2 +
 drivers/gpu/drm/xe/xe_drm_client.c            |   2 +
 include/asm-generic/vmlinux.lds.h             |   1 +
 include/drm/drm_print.h                       |  10 +
 include/linux/dynamic_debug.h                 | 135 ++-
 kernel/module/main.c                          |   3 +
 lib/Kconfig.debug                             |  24 +-
 lib/Makefile                                  |   3 +
 lib/dynamic_debug.c                           | 436 ++++++----
 lib/test_dynamic_debug.c                      | 131 +--
 lib/test_dynamic_debug_submod.c               |  17 +
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   2 +
 .../dynamic_debug/dyndbg_selftest.sh          | 810 ++++++++++++++++++
 37 files changed, 1453 insertions(+), 363 deletions(-)
 create mode 100644 lib/test_dynamic_debug_submod.c
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

-- 
2.45.2


