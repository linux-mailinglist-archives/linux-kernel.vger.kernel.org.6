Return-Path: <linux-kernel+bounces-558256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB44A5E386
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5CF17C13D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484B8256C6F;
	Wed, 12 Mar 2025 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neKq0sj7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF024FC1F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803283; cv=none; b=AXm4w9CJIX9uGWJGTzWbsaq5SDnPmhPhKIGYJxUHBBWUqeMCAmVCPwreXp+94Ep+1RetTm18Hwx3kD6waaBnT5pKW+8mSJzG6WSSFrVfaxYQKE5GRHZTWNt0JGZRvGtoCI9nKJmRf5hOS6lO3oZwQdwU7Oyox7VUH/ZyRAzKU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803283; c=relaxed/simple;
	bh=9kjQH4sGg87IcCx2WB1l0OZBwhYAGZZt8rrEWQiq4fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agWTR99/MBtw9WiiOIX262MUFo/2WCOKXS0BlCMfy4NIYqM0H5AgzFe2TWNJidfymU04z2THrn8ON0AOej246s9lUZXfbRqvVMHzXzmwKXwJdGvC/bmCskaDxORGfWfTag/dnNayrbGEa6nEff9V7W0DY+2uhZ/H+tssQ21r1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neKq0sj7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741803280; x=1773339280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9kjQH4sGg87IcCx2WB1l0OZBwhYAGZZt8rrEWQiq4fc=;
  b=neKq0sj7J9wMeBSBFmEUFjhYLombcwR3I3umoPkVDHGCfExscwAZxrUr
   MrY3Ot3Za2YzbyDEnMgBZP5zwyGKdbQloqFmrbPzFJe01pPo0VyTKNDly
   1U0jDQGEk/s9HuUS58ewE71FOQ+tWm3x+0ZrW8/ltI23O/+AORnSdmhgz
   hbXysB0vK5Q8KE3a6JwVjpyTzTNsOllhIllHIlbvMTAx45TzqTx/eKtWh
   x3quOOVUSWRSBGwaBNQS5xuFL+nsrGKR2+rw3PNIY458PessWrzWJZzsD
   JC/uKSk7moAvi1dksz3RCVp54rDEaVLpfZbpzKzNUIqAvYX2pa8WSjXAv
   g==;
X-CSE-ConnectionGUID: kX4pwyvwQI6QW7xr3nwJCw==
X-CSE-MsgGUID: mpvFBlAISIiz4g7lIENXzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42758717"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42758717"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 11:14:40 -0700
X-CSE-ConnectionGUID: ArMBUZBASp2di21Tm6cZYw==
X-CSE-MsgGUID: qsz5pRh4RYqQTZfK2hIcFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="143906828"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 12 Mar 2025 11:14:36 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsQbC-0008nQ-0c;
	Wed, 12 Mar 2025 18:14:34 +0000
Date: Thu, 13 Mar 2025 02:14:30 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] drm/tests: hdmi: Add max TMDS rate fallback tests
 for YUV420 mode
Message-ID: <202503130136.AnTvw0Cj-lkp@intel.com>
References: <20250311-hdmi-conn-yuv-v2-7-fbdb94f02562@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311-hdmi-conn-yuv-v2-7-fbdb94f02562@collabora.com>

Hi Cristian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4423e607ff50157aaf088854b145936cbab4d560]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Ciocaltea/drm-connector-hdmi-Evaluate-limited-range-after-computing-format/20250311-190150
base:   4423e607ff50157aaf088854b145936cbab4d560
patch link:    https://lore.kernel.org/r/20250311-hdmi-conn-yuv-v2-7-fbdb94f02562%40collabora.com
patch subject: [PATCH v2 7/7] drm/tests: hdmi: Add max TMDS rate fallback tests for YUV420 mode
config: arm64-randconfig-004-20250312 (https://download.01.org/0day-ci/archive/20250313/202503130136.AnTvw0Cj-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503130136.AnTvw0Cj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503130136.AnTvw0Cj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/drm/drm_kunit_helpers.h:10,
                    from drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:14:
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c: In function 'drm_test_check_max_tmds_rate_bpc_fallback_yuv420':
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
   In file included from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:56,
                    from include/drm/drm_crtc.h:28,
                    from include/drm/drm_atomic.h:31,
                    from drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:7:
>> include/linux/compiler.h:32:35: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
      32 |                         ______r = __builtin_expect(!!(x), expect);      \
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:44:26: note: in expansion of macro '__branch_check__'
      44 | #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/kunit/test.h:784:13: note: in expansion of macro 'likely'
     784 |         if (likely(__left op __right))                                         \
         |             ^~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
   include/kunit/test.h:670:35: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     670 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                   ^~~~~~~~~~~
   include/kunit/test.h:787:9: note: in expansion of macro '_KUNIT_FAILED'
     787 |         _KUNIT_FAILED(test,                                                    \
         |         ^~~~~~~~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
   include/kunit/test.h:670:35: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     670 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                   ^~~~~~~~~~~
   include/kunit/test.h:787:9: note: in expansion of macro '_KUNIT_FAILED'
     787 |         _KUNIT_FAILED(test,                                                    \
         |         ^~~~~~~~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
--
   In file included from include/drm/drm_kunit_helpers.h:10,
                    from drm_hdmi_state_helper_test.c:14:
   drm_hdmi_state_helper_test.c: In function 'drm_test_check_max_tmds_rate_bpc_fallback_yuv420':
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
>> include/kunit/test.h:776:29: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     776 |         const typeof(right) __right = (right);                                 \
         |                             ^~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
   In file included from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:56,
                    from include/drm/drm_crtc.h:28,
                    from include/drm/drm_atomic.h:31,
                    from drm_hdmi_state_helper_test.c:7:
>> include/linux/compiler.h:32:35: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
      32 |                         ______r = __builtin_expect(!!(x), expect);      \
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:44:26: note: in expansion of macro '__branch_check__'
      44 | #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/kunit/test.h:784:13: note: in expansion of macro 'likely'
     784 |         if (likely(__left op __right))                                         \
         |             ^~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
   include/kunit/test.h:670:35: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     670 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                   ^~~~~~~~~~~
   include/kunit/test.h:787:9: note: in expansion of macro '_KUNIT_FAILED'
     787 |         _KUNIT_FAILED(test,                                                    \
         |         ^~~~~~~~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~
   include/kunit/test.h:670:35: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
     670 |         const struct assert_class __assertion = INITIALIZER;                   \
         |                                   ^~~~~~~~~~~
   include/kunit/test.h:787:9: note: in expansion of macro '_KUNIT_FAILED'
     787 |         _KUNIT_FAILED(test,                                                    \
         |         ^~~~~~~~~~~~~
   include/kunit/test.h:805:9: note: in expansion of macro 'KUNIT_BASE_BINARY_ASSERTION'
     805 |         KUNIT_BASE_BINARY_ASSERTION(test,                                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:971:9: note: in expansion of macro 'KUNIT_BINARY_INT_ASSERTION'
     971 |         KUNIT_BINARY_INT_ASSERTION(test,                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:968:9: note: in expansion of macro 'KUNIT_EXPECT_EQ_MSG'
     968 |         KUNIT_EXPECT_EQ_MSG(test, left, right, NULL)
         |         ^~~~~~~~~~~~~~~~~~~
   drm_hdmi_state_helper_test.c:1337:9: note: in expansion of macro 'KUNIT_EXPECT_EQ'
    1337 |         KUNIT_EXPECT_EQ(test, conn_state->hdmi.tmds_char_rate,
         |         ^~~~~~~~~~~~~~~


vim +776 include/kunit/test.h

73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  734  
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  735  #define KUNIT_TRUE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  736  	KUNIT_UNARY_ASSERTION(test,					       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  737  			      assert_type,				       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  738  			      condition,				       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  739  			      true,					       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  740  			      fmt,					       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  741  			      ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  742  
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  743  #define KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, fmt, ...)      \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  744  	KUNIT_UNARY_ASSERTION(test,					       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  745  			      assert_type,				       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  746  			      condition,				       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  747  			      false,					       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  748  			      fmt,					       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  749  			      ##__VA_ARGS__)
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  750  
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  751  /*
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  752   * A factory macro for defining the assertions and expectations for the basic
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  753   * comparisons defined for the built in types.
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  754   *
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  755   * Unfortunately, there is no common type that all types can be promoted to for
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  756   * which all the binary operators behave the same way as for the actual types
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  757   * (for example, there is no type that long long and unsigned long long can
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  758   * both be cast to where the comparison result is preserved for all values). So
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  759   * the best we can do is do the comparison in the original types and then coerce
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  760   * everything to long long for printing; this way, the comparison behaves
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  761   * correctly and the printed out value usually makes sense without
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  762   * interpretation, but can always be interpreted to figure out the actual
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  763   * value.
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  764   */
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  765  #define KUNIT_BASE_BINARY_ASSERTION(test,				       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  766  				    assert_class,			       \
064ff292aca500d Daniel Latypov  2022-01-25  767  				    format_func,			       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  768  				    assert_type,			       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  769  				    left,				       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  770  				    op,					       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  771  				    right,				       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  772  				    fmt,				       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  773  				    ...)				       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  774  do {									       \
c2741453478badf Daniel Latypov  2022-01-27  775  	const typeof(left) __left = (left);				       \
c2741453478badf Daniel Latypov  2022-01-27 @776  	const typeof(right) __right = (right);				       \
2b6861e2372bac6 Daniel Latypov  2022-01-25  777  	static const struct kunit_binary_assert_text __text = {		       \
2b6861e2372bac6 Daniel Latypov  2022-01-25  778  		.operation = #op,					       \
2b6861e2372bac6 Daniel Latypov  2022-01-25  779  		.left_text = #left,					       \
2b6861e2372bac6 Daniel Latypov  2022-01-25  780  		.right_text = #right,					       \
2b6861e2372bac6 Daniel Latypov  2022-01-25  781  	};								       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  782  									       \
8bd5d74babc9255 Mickaël Salaün  2024-04-08  783  	_KUNIT_SAVE_LOC(test);						       \
97d453bc4007d4a Daniel Latypov  2022-09-30  784  	if (likely(__left op __right))					       \
97d453bc4007d4a Daniel Latypov  2022-09-30  785  		break;							       \
97d453bc4007d4a Daniel Latypov  2022-09-30  786  									       \
97d453bc4007d4a Daniel Latypov  2022-09-30  787  	_KUNIT_FAILED(test,						       \
21957f90b28f6bc Daniel Latypov  2022-01-13  788  		      assert_type,					       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  789  		      assert_class,					       \
a8495ad8e973cb6 Daniel Latypov  2022-09-30  790  		      format_func,					       \
697365c08679137 Daniel Latypov  2022-09-30  791  		      KUNIT_INIT_ASSERT(.text = &__text,		       \
697365c08679137 Daniel Latypov  2022-09-30  792  					.left_value = __left,		       \
697365c08679137 Daniel Latypov  2022-09-30  793  					.right_value = __right),	       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  794  		      fmt,						       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  795  		      ##__VA_ARGS__);					       \
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  796  } while (0)
73cda7bb8bfb1d4 Brendan Higgins 2019-09-23  797  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

