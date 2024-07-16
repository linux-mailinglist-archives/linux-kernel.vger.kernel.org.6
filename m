Return-Path: <linux-kernel+bounces-254254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B879330D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1491C22CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792821A01C7;
	Tue, 16 Jul 2024 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="galDNX9v"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DD31C6B7;
	Tue, 16 Jul 2024 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156302; cv=none; b=rAcRAJbrmOHRbBxI5L11v448tIGUVBWPvfoRY7X5JOmrWD3bdp2slgjC/H9SLXPN/SG1fYygsOSTi/LWKdVZmmJr0pAY8JevHYaLTSA3xXVmG0SflTz82qejDGaIdlFNUxZvOdvp13mVbPGRMvYE/WsAlC1gIiUZugwacT9JiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156302; c=relaxed/simple;
	bh=vIU7YeMzWaIKfd7XIzbgZsC24xjbtun0Hhllvp5bI+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3ycl+iFAwlKxOQ7+VCwt4CWRR3kOYhiK0hMtff316P1MbT1lyeyKJ/vnQe4gTIlHCyuHsR8RB5LQVU6G3xhPa1a2vs0t2eM/xfYOXcxCcqaIuOzclxlDqisPHgDksC8iBKxgTAAFeawdmSOUNN0l75S6Ff9HnLUFiuo0kgfcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=galDNX9v; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7fedb09357aso5189839f.2;
        Tue, 16 Jul 2024 11:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156299; x=1721761099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nlztxyqzny/TyO2WM7QyucD/nlp0xYLyh6K3VL682ic=;
        b=galDNX9vakEKOZtUkyGnptglQpwbGQfzL6Ui2BbBEv4/sLao+w1CtQe7qnnEcYeaXk
         Ks1sReEErpsL2cnfYpW4GM55FcjTY8XUTMnTgFWFbX8Zx43gqXCMJgx3Hlc6KbyXLyD6
         Et4YGKnolIu/VeRjcxycfMktqYzTnzUjfyOX3TijCHzWWLqXRKG6IF47pxjh+cPn12L6
         4t/92LxBgsesUUZRsbKbxrMgqJuCObWj60BsSiQUCvS0vhzOuXGP5bLs6ofIXF/Bb4bt
         gEzjL/+izv2e2w+vx9/3qqWKrGxBF9Kgta0vIWJETSH0O/spDlYBrIuo+s7EzYhsFayi
         TRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156299; x=1721761099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlztxyqzny/TyO2WM7QyucD/nlp0xYLyh6K3VL682ic=;
        b=rhsZyfhlxnG7lBFeCuKEd1LMnCaymI7ZoCwbQ8vR6/VzgDejSAOXWFoTdJKDXdiN8A
         eNPCeT8saXd3LFETSdDHmkNg1QVxQS63AoTD+seJGK8yINbNkVIOn2mW00KFK0pwcUCW
         FPFzhdwQymRvzLa3gxs+YXkXUl1Dr+3KGVFlEwLzPV486W0n0dO9mXovHTIi5zAaENcg
         jQWUe8WdLpQAnWIsiIUSajkVVUX/40pJ8KddFaOv8hzOxvcsPDDb662peBJpRUIK7Sf9
         Y8ys6E+AYolNNxpFT/aA60SlycOEfnGV+BNW5V32O0+TlZ8qQ/YYZkQrf1bOMJpnmfUk
         Ch3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYm2ZtUn/ZdlcaQLK6vHTJMcSXl7gWOoQVXnJmk4FqArlye2DpuepdiBwaBt6cyzptJhJz1/fShVj0IMQQadjxgCC/mnQCoQxJ
X-Gm-Message-State: AOJu0YyQDkqRfjNQTI0gV9m76pXY3xLvvE+uvGxrLZOlk+IplaSS26JQ
	rn1KnKSsTpHZE5gquiOZj1+qjLRzT80DSDNFINTVasgbXM2ZjfqSmQR351Ak
X-Google-Smtp-Source: AGHT+IGqD4UErL2c3SLwT2T9Uga4T0UYfQhPSEGK41Z0mb7vRe2ND0RK5V+VparwgfEXegXEafzTwg==
X-Received: by 2002:a05:6602:1602:b0:807:aebc:3bdd with SMTP id ca18e2360f4ac-816c2fe92e3mr41273039f.5.1721156299176;
        Tue, 16 Jul 2024 11:58:19 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:18 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 00/54] fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y
Date: Tue, 16 Jul 2024 12:57:12 -0600
Message-ID: <20240716185806.1572048-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

resending to fix double-copies of a dozen patches.
added 2 squash-ins to address Ville's designated-initializer comment.

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

DRM is the only current classmaps user, and is not actually using it,
so if you think DRM could benefit from zero-off-cost debugs based on
static-keys, please test.

There is also a no-DRM-involved selftest script:

 [root@v6 b0-dd]# V=0 ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh 
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

HISTORY

9/4/22  - ee879be38bc8..ace7c4bbb240 commited - classmaps-v1 dyndbg parts
9/11/22 - 0406faf25fb1..16deeb8e18ca commited - classmaps-v1 drm parts

https://lore.kernel.org/lkml/Y3XUrOGAV4I7bB3M@kroah.com/
greg k-h says:
This should go through the drm tree now.  The rest probably should also
go that way and not through my tree as well.

https://lore.kernel.org/lkml/20221206003424.592078-1-jim.cromie@gmail.com/
v1- RFC adds DYNDBG_CLASSMAP_DEFINE + test-submod to recap DRM failure

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

drm.debug:

is ~5000 invocations of debug-macros across core, drivers, helpers;
each in 1 of 10 exclusive categories: DRM_UT_*, kept in an enum/int,
and passed in 1st macro-arg, as a builtin-constant.

The 10 categories are all controlled together, by bits 0..9 in a sysfs
knob.

  drm.debug=0x1ff  # bootarg
  echo 0x4 > /sys/module/drm/parameters/debug  # run-time setting

Keeping all that unchanged was a firm design requirement for classmaps.

Below the sysfs interface, classmaps are exposed in the >control
grammar with a new "class" keyword.  This is mostly like the other
selector keywords, differing by:

a- classnames are client/subsystem/domain defined, not code-name-structural.
   the classnames are global, across system
   IOW: "class DRM_UT_CORE" selects on any module which knows the class

b- classes are protected from unqualified modification.

   # cannot disable any DRM (or other) classes without saying so
   echo -p > /proc/dynamic_debug/control

c- because b, modules must opt-in so dyndbg knows their classnames.
   without names, dyndbg cannot lookup the classid & change the class.

d- classes don't have wildcards - add if needed.
   DRM uses "${SUBSYS}_${CATNAME}"
   probably more useful with "${TOP}_${MID}_${LOW}" classnames
   nobody's sure what _UT_ is.

API in use:

DYNDBG_CLASSMAP_* macros are all file-scope declarators.

1. DYNDBG_CLASSMAP_DEFINE(drm_debug_classes, ...);
2. DYNDBG_CLASSMAP_USE(drm_debug_classes);

Classmaps get DEFINEd once (in drm.ko for core) and USEd (in drivers
and helpers), these declarations 1. define and export a classmap (in
core module), and 2. refer to the exported class-struct from the other
modules.

They both tell dynamic-debug that the module has some of these class'd
pr_debugs, so dyndbg can use the classmap's names to validate >control
inputs and change the callsites.  This is the opt-in.

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

In drm_print.c we have: (theres room for better words...)

/* classnames must match value-symbols of enum drm_debug_category */
DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
                    DRM_UT_CORE, // _base
		    /* this effectively names the bits in drm.debug */
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
other _bases allow sharing the per-module 0..62 class-id space.
(63 is default/unclassed/common prdbg).

Only complete, linear maps are recommended.  This suits DRM.

DYNDBG_CLASSMAP_PARAM_REF() creates the sysfs-kparam classbits knob,
binding the extern'd long-int/bitvec to the classmap.  The extern
insures that old users of __drm_debug can still check its value.

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

A selftest script is included:
  :#> ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

It recapitulates the DRM regression scenario using the 2 test modules.
The test verifies that the dependent module is initialized properly
from the parent's classmap kparam, and the classed prdbgs get enabled.

This latest rev fixes the test for the various CONFIG_DYNAMIC_DEBUG*
build combos, by skipping some subtests where the expected counts are
wrong. Lukasz Bartosik caught this - thanks.
CC: ukaszb@chromium.org

And 2 tweaks to kdoc & howto, to steer api users away from using
designated initializers to _DEFINE the classmap.


2- DRM fixes - use new api.

a. update core/drivers to invoke DRM_CLASSMAP_DEFINE/_USE
b. wrap DYNDBG_CLASSMAP_* with DRM_CLASSMAP_* - hide ifdef

c. now with separate +DRM_CLASSMAP_USE patches for each driver/helper: 
d. and defer dropping DECLARE_DYNDBG_CLASSMAP til later

Maybe theres a single place to invoke DRM_CLASSMAP_USE just once,
perhaps from a client library c-file. I poked a little, didn't find it.
It would be a bit obscured for an opt-in style declaration.

Patches are against v6.10
theyre also at:
tree/branch: https://github.com/jimc/linux.git dd-fix-9d
and lkp-robot told me:
[jimc:dd-fix-9d] BUILD SUCCESS 7c38f1d94f9919fec887113b620b83d60061c035


Finally, classmaps are in a meta-stable state right now; some governor
might yet walk it over to the gravel pit out back.

Tested-bys would help greatly, help get it off the fence it straddles.
Please specify your test method: selftest or drm.debug=0x1ff boot.

Next Im gonna try to haul this over to the freedesktop DRM-CI river,
presuming I can find the way (accts,etc)

Also entertaining Reviewed-bys :-}

Jim Cromie (54):

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

added in -resend (will squash back in):

  dyndbg: tighten up kdoc about DYNDBG_CLASSMAP_* macros
  docs-dyndbg: improve howto classmaps api section

 .../admin-guide/dynamic-debug-howto.rst       | 113 ++++-
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
 include/linux/dynamic_debug.h                 | 145 ++++--
 kernel/module/main.c                          |   3 +
 lib/Kconfig.debug                             |  24 +-
 lib/Makefile                                  |   3 +
 lib/dynamic_debug.c                           | 436 +++++++++++-------
 lib/test_dynamic_debug.c                      | 131 +++---
 lib/test_dynamic_debug_submod.c               |  17 +
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   2 +
 .../dynamic_debug/dyndbg_selftest.sh          | 375 +++++++++++++++
 37 files changed, 1042 insertions(+), 363 deletions(-)
 create mode 100644 lib/test_dynamic_debug_submod.c
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

-- 
2.45.2


