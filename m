Return-Path: <linux-kernel+bounces-570191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92074A6AD58
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41461897623
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6BB227B94;
	Thu, 20 Mar 2025 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mveQkzEd"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92F1DEFE4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496775; cv=none; b=tLRd3+f2xfbUp0E1zpLvj3aseGt7xxbpAokqKH9lSzWFj9R2zae2LNncGEhOEMJJMuoavZiBYkVaefOfFhD6y2WGX0XtWPkW0IJAZJ5eGgrrLSGsxTike4M4a1fe52ZKks//xVPZSVbvAxc8UvC6vPujXtJp110bNg0ACj0jFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496775; c=relaxed/simple;
	bh=zcWM9Bk/yNvq2YX+Rg8TH1YKyVQdFCkmtVdMoPaw4pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uOWCt8+GgMU1nxH+LwdxDJfuVaULwEA3mI6CnsnwCa8+SmAq2XGIlXCsKAUTCAVDC1xgR3ciMau3TCC0Ld9E0vcSvYnCDzWpRn404zSLcwyVdIac3YdcrfS9yvNoK410BWh8eDol38Jy9HhbUBb3aNS1izwZB0XyHdWuc0BU/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mveQkzEd; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85b5e49615aso98754339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496771; x=1743101571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu40/8xrKy3ybFqnjhxnpBEwPXrJGJya+7FhcPKlJkY=;
        b=mveQkzEde9yFiq/K0MdjyBxFfT7CE9LmmGgv1FyDNJeyuxVv3XykylSz9HYDn4akCn
         naNiPu7dnqP1n311py1pWLWFqaCw5LdnF3HVHsVL3KCR0r9YRHxPo5mWDbEybzU1J7t5
         KqhaNPf4Xg3I7+Gyr81rVzCaSbDJPmKCMDumQ2w1pmwIIoN+mzYsd9S1moHzA0gVLmYu
         UkBNSVtIAPoe9SzrfCob59PJgKeTDaVrAuuHHZK87dY+DqyQ26QMu+UX1Jsd5iTKsvqR
         xSNkgvhk0LtinGS28jI3YRjjxd5gEBLdQUXlQKQ+H9Pphei8jScClUAKR/4ZNzbizOT4
         9+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496771; x=1743101571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hu40/8xrKy3ybFqnjhxnpBEwPXrJGJya+7FhcPKlJkY=;
        b=dxTm1TONgasEaTvMOv8vKEky6sOzHz38kQh3ZkMv7gZkRpjbAJj2zUFGeqXbrBKlFs
         F3mv1Fp64lsRCS7l5uyGjrz1rqTM0u/oHqniPSBZucqVdloab/Wyk0H2w8f3xm7DK10N
         ED/gybdOHqN1mvQ3f5ElqMKM3TSZ9Ox4OSdMPEbNJTH0RRINJDKyHiD3/lqIny1hA587
         5rWnlUf9uqZZCu9Z2EVHAqysNK/vXWEkv9swOR0BqyhzRhjRwzfdeat7hbGMh72crhHY
         Mt0IEQNThm9EHPVx8nOguSg/oAzqeEqSSha4IJARD2c+H37Ko9bocMbKNaUtKUnjMv5E
         qVyA==
X-Gm-Message-State: AOJu0YwRy4HhHbRzzFpJfqEGeaJV5AimOiQKNxzQtwf57ZHTkCHjoUoc
	zSEJz/76/KBJ4Yfw9NljgoEBPEiiARuD8/bERks3GCuYPVpsc4C+FWNnIHOC
X-Gm-Gg: ASbGnct5qeVTuw+o3nDpqG6gFS0w74DgNPmjKCqeTIuWrwLEFjUAgElIfD3YE2B7I9T
	wNrqCI3m/JreYgxnGQClwqJUAoB6uDBjTAcdI84bsenaQ47eR9KM4VJnky8DH34ij1u4cHyIgRD
	S9D4xdYYQfGFYSSQYQIsxb60Vg+s6MhKtJ+ErJaYm2auC2ExGYAHCsLkmoCMMIM7+Z2lcv3w2Ic
	WI1HHJkDvsfpmZ6QTZZL1KzzP4xOuCih1T36dlY7XkbWeTWlhF3dPP9PlUT8SdkCBmDHGh6yTyp
	m5wlO+x/kMV/fvKgGW1xBB7NXbNG9DENYGXJA0TZ3Os05q6IpQ4SYYalOaBFic/wtpfOVhHK5qR
	akA==
X-Google-Smtp-Source: AGHT+IFejL3Eb5kNmESOTMYZvjLufYJJ+QsWlU+j6U/jyfqDrjtj6mmmDpCmVg7Js6NBhayqbz23HA==
X-Received: by 2002:a05:6602:3807:b0:85e:17c5:bb94 with SMTP id ca18e2360f4ac-85e2ca35542mr48104539f.1.1742496771210;
        Thu, 20 Mar 2025 11:52:51 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:52:50 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 00/59] Fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y
Date: Thu, 20 Mar 2025 12:51:38 -0600
Message-ID: <20250320185238.447458-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes dynamic-debug's support for DRM debug-categories.
Classmaps-v1 evaded full review, and got committed in 2 chunks:

  b7b4eebdba7b..6ea3bf466ac6	# core dyndbg changes
  0406faf25fb1..ee7d633f2dfb	# drm adoption

Then DRM-CI found a regression when booting with drm.debug=<initval>;
the pr_debug callsites' static-keys under the drm-dbgs in drm.ko got
enabled, but those in drivers & helpers did not, since they weren't
yet modprobed, and didn't yet exist.

Design Review / Restatemment:

My primary design goal for dyndbg-classmaps was DIRECT support of DRM,
with NO api changes, starting with the enum drm_debug_category typing,
and keeping as much of the existing macro stack as unaltered as possible.

Some UUID-ish thing was OO-scope; pessimizing unseen optimizations on
compile-time constant ints (that could fit in a byte), across DRM's
macro stack, with ~5k expansions, would be ungood.

Immediate consequences:

= unique integers are *hard* to coordinate across the whole kernel.

= 0 is not special - DRM_UT_CORE is already used.
  other users probably want it too
  
= 0..N are special - they're exposed in sysfs knobs.
  ie: echo 0x1ff > /sys/module/drm/parameters/debug
  all classmap-param users get 0..N on their knob.

= DRM_UT_<*> has only 10 categories/classes
  small enough for DIRECT storage inside the _ddebug descriptor

= DRM's enum gives us both class-names and class/category values.
  classnames === stringified DRM_UT_<*>
  class_ids  === bare DRM_UT_<*>
  all future classmap users are expected to follow this model.
  
We need to "privatize" the class_id's, per module.
We can do this in a few steps:

= modules declare their map: classnames => Ids.
  author defined, user oriented
  classnames/strings is wide, expressive interface
  2-levels used, DRM_UT_*, no 3-levels yet;
  _UT could vary, but has no meaning now.

We can use the known (and desired) ordering/contiguity of the 0..Ns
here, and of the array of classnames, to simplify the specification of
the map:

  _CLASSMAP_DEFINE (_base-ID/start-of-range, list-of-classnames)

no sparse maps, no reorder-maps, nothing extra to think about.
Just classnames to manipulate class_ids/categories.

= dyndbg refuses direct selection by class_ids.
  this privatizes them
  "speak my class-name if you expect a response".

= dyndbg requires "grammar access only"
  ie: "class DRM_UT_CORE +p" >control
  ie: "name the class to change it"
  class-param handler feeds cmd-strings thru ddebug_query().

= classname --> class_id lookup "validates" the user.
  unknown classnames can be discarded, per module.
  other modules get the same,
  no other class-user would accidentally know "DRM_UT_CORE"

= with private class_ids per module.
  a small 0..N range is enough.
  32 is a practical limit for a single classmap,
  if you think "echo 0x12345678 > $sysknob" is practical.
  16 is more practical, DRM has 10.
  we have 63. this allows..

= multiple classmaps are supported
  as long as the mapped class_ids dont conflict.
  a fair requirement for a narrow, future use-case.
  this is now verified in this patchset.
  7x 8-bit classes is workable (if you'd like)

= "legacy" class.
  all existing (un-class'd) pr_debugs.
  class_id is a 6-bit integer,
  so all existing pr_debugs need a default.
  63 = 2^6-1 is our _DFLT
  0..62 is then available for named classes. (0 is not special)
  63 is "legacy".


And now on to the nascent disagreement between Jason and myself:
classmaps-v1 "protected" new classes from changes by legacy/_DFLT
queries.  Jason saw this as a "special-case" conferred on the class
keyword; all other keywords have no selectivity until they're queried.

After realizing this was unsettled, I found a technical fix: split the
class-mismatch case to queried-class-mismatch (not special, so skip)
OR class'd-site-vs-DFLT-query.  Now we can make a policy decision,
named: ddebug_client_module_protects_classes().

IIRC @DVetter expressed unconcern about protecting DRM_UT_* classes
from unintended alteration, so the above macro is set false, per
Jason's preference.

Should dispositions change, we could perhaps just set the macro true,
since DRM is the only classmap usage so far.  Or perhaps make it the
using module's choice, with a flag in _ddebug_info, and maybe a new
DD_CLASSMAP_TYPE to convey it to dyndbg wo api tweaks.

Previous Rev(s):

https://lore.kernel.org/lkml/20250125064619.8305-1-jim.cromie@gmail.com/
Ive incorporated the Reviewed-by:s and Tested-by:s offered there.

DRM-CI runs:

https://patchwork.freedesktop.org/series/135669/
https://patchwork.freedesktop.org/series/139147/

Changes since:

= one more mea-culpa fix
= squash 3 verbose-tweak patches together
= lots of cleanup/refactoring patches brought forward
  or squashed, reducing churn.

= regularize section names & linker symbols.
  any naming conventions I missed ?

= new _DPRINTK flags for LOOKUP, CACHED_PREFIX
  use LOOKUP to refine dynamic_emit_prefix()

= cleanup most spurious name variances:
  s/\bdd_|\bddebug_/_ddebug_/g
  most of s/DYNDBG/DYNAMIC_DEBUG/.
  
= moved doc patches to back of dydnbg-core part.
  more wordsmithing / bikeshedding chances
  the classmaps-info might be over-specifying

= one trailing RFC patch for DRM to consider
  attempt to link in a drm_dbg_client.o classmap-user everwhere
  _CLASSMAP_USE at a distance.

Jim Cromie (59):
  vmlinux.lds.h: fixup HEADERED_SECTION{,_BY} macros
  docs/dyndbg: update examples \012 to \n
  test-dyndbg: fixup CLASSMAP usage error
  dyndbg: reword "class unknown," to "class:_UNKNOWN_"
  dyndbg: make ddebug_class_param union members same size
  dyndbg: drop NUM_TYPE_ARRAY
  dyndbg: reduce verbose/debug clutter
  dyndbg: refactor param_set_dyndbg_classes and below
  dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
  dyndbg: replace classmap list with a vector
  dyndbg: macrofy a 2-index for-loop pattern
  dyndbg,module: make proper substructs in _ddebug_info
  dyndbg: add 2 new _DPRINTK_FLAGS_: INCL_LOOKUP, PREFIX_CACHED
  dyndbg: split _emit_lookup() out of dynamic_emit_prefix()
  dyndbg: hoist classmap-filter-by-modname up to ddebug_add_module
  dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
  dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
  selftests-dyndbg: add tools/testing/selftests/dynamic_debug/*
  dyndbg: detect class_id reservation conflicts
  dyndbg: check DYNDBG_CLASSMAP_DEFINE args at compile-time
  dyndbg-test: change do_prints testpoint to accept a loopct
  dyndbg-API: promote DYNAMIC_DEBUG_CLASSMAP_PARAM to API
  dyndbg: move .mod_name from/to structs ddebug_table/_ddebug_info
  dyndbg: treat comma as a token separator
  selftests-dyndbg: add comma_terminator_tests
  dyndbg: split multi-query strings with %
  selftests-dyndbg: test_percent_splitting
  selftests-dyndbg: add test_mod_submod
  dyndbg: change __dynamic_func_call_cls* macros into expressions
  dyndbg: drop "protection" of class'd pr_debugs from legacy queries
  docs/dyndbg: explain new delimiters: comma, percent
  docs/dyndbg: explain flags parse 1st
  docs/dyndbg: add classmap info to howto (TBD)
  checkpatch: dont warn about unused macro arg on empty body
  drm: use correct ccflags-y spelling
  drm-dyndbg: adapt drm core to use dyndbg classmaps-v2
  drm-dyndbg: adapt DRM to invoke DYNAMIC_DEBUG_CLASSMAP_PARAM
  drm-print: fix config-dependent unused variable
  drm-dyndbg: DRM_CLASSMAP_USE in amdgpu driver
  drm-dyndbg: DRM_CLASSMAP_USE in i915 driver
  drm-dyndbg: DRM_CLASSMAP_USE in drm_crtc_helper
  drm-dyndbg: DRM_CLASSMAP_USE in drm_dp_helper
  drm-dyndbg: DRM_CLASSMAP_USE in nouveau
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
  drm: RFC - make drm_dyndbg_user.o for drm-*_helpers, drivers

 .../admin-guide/dynamic-debug-howto.rst       | 127 +++-
 MAINTAINERS                                   |   3 +-
 drivers/gpu/drm/Kconfig                       |   3 +-
 drivers/gpu/drm/Makefile                      |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +-
 drivers/gpu/drm/display/drm_dp_helper.c       |  12 +-
 drivers/gpu/drm/drm_crtc_helper.c             |  12 +-
 drivers/gpu/drm/drm_dyndbg_user.c             |  11 +
 drivers/gpu/drm/drm_gem_shmem_helper.c        |   1 +
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
 include/asm-generic/vmlinux.lds.h             |  12 +-
 include/drm/drm_print.h                       |  12 +
 include/linux/dynamic_debug.h                 | 225 ++++--
 kernel/module/main.c                          |  15 +-
 lib/Kconfig.debug                             |  24 +-
 lib/Makefile                                  |   3 +
 lib/dynamic_debug.c                           | 656 +++++++++++-------
 lib/test_dynamic_debug.c                      | 203 ++++--
 lib/test_dynamic_debug_submod.c               |  21 +
 scripts/checkpatch.pl                         |   2 +-
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   2 +
 .../dynamic_debug/dyndbg_selftest.sh          | 364 ++++++++++
 39 files changed, 1329 insertions(+), 501 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_dyndbg_user.c
 create mode 100644 lib/test_dynamic_debug_submod.c
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

-- 
2.48.1


