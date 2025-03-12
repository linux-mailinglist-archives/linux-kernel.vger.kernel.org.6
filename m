Return-Path: <linux-kernel+bounces-557668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D5A5DC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DA91742CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B1E241672;
	Wed, 12 Mar 2025 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHYya5RA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D82405E8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781011; cv=none; b=S0kAiQc+qXKwIE6UWIfXdd9lYE6E35HInBGz7WajVcsROo0NNKRatuFz6JNrRexXA+dL434oMkyvNvELRkBmhsRZ9A6uqCpazysKWBBLO7TxiKmPk2oJQL0gnRlBt+qMW0Dz9pekG40JD3QBIlW3g97TcTNPl3yfKN9tGpO7mt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781011; c=relaxed/simple;
	bh=xaWsNN1cs0HzDj9R320RuBTYp1Ti2MBG4Pn6SIigU9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h32Wt4i3mNt5/jNNpMyfRYj8mjsVMxCppgWWLiONfx6NuZjwocoyg3UP/h/RxSNxxUj5XZXTP0ciu3m5tA6BwC9eDCXRmoIfgm9sebwYYs17y9cZx7Kweub+A7pT1PeuF5Q6txU5c2vDc5L5iX6MGiZWEVFtEkGKfGOiXIrYYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHYya5RA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741781009; x=1773317009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xaWsNN1cs0HzDj9R320RuBTYp1Ti2MBG4Pn6SIigU9E=;
  b=cHYya5RAhU1bEqSPyxiqoLj6L0/sJtiFPtfrg10yuzvu1TyUdf2q9KZ5
   KB5/tBlLZXa/bIVLxg7gVw8WkhroiYrCtAGszv3V2oYpWZrzi8pN95fU+
   O43Dw6sa8SZto/2/TtWvy//IFPDjt+kLbT5gNZZZLLceMc9LaFn1L1RAJ
   txxY4EtKqpy68/4hYEUJabaYsMZq5q9P77Pa9+JPjM6jPjaWaeBi7tDQe
   oLqhPyEGHpfXT0sQb7vPceQI+WjMWEIVDLgA+wNs5U3Fg7B5YP2Jzzu1Q
   +EZyMVq2qRL9I2TMIVXwY/uiVbpnEuj+BDZNhVsnCvNMEiVMkoTaH83D0
   Q==;
X-CSE-ConnectionGUID: 2/75K305QlCcuPg8bv36xA==
X-CSE-MsgGUID: JNrzKiKRR2+TDECNaJjPjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="60256941"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="60256941"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 05:03:26 -0700
X-CSE-ConnectionGUID: EOLlO30hSXG4eXfejVwstw==
X-CSE-MsgGUID: c6hH1Cm/TvycB4FVprr3vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="151428269"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 12 Mar 2025 05:03:23 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsKnt-0008Vc-1Q;
	Wed, 12 Mar 2025 12:03:18 +0000
Date: Wed, 12 Mar 2025 20:02:44 +0800
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
Message-ID: <202503121909.5IeaFEUt-lkp@intel.com>
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
config: x86_64-randconfig-004-20250312 (https://download.01.org/0day-ci/archive/20250312/202503121909.5IeaFEUt-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503121909.5IeaFEUt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503121909.5IeaFEUt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/drm/drm_kunit_helpers.h:10,
                    from drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:14:
   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c: In function 'drm_test_check_max_tmds_rate_bpc_fallback_yuv420':
>> include/kunit/test.h:776:29: error: SSE register return with SSE disabled
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
--
   In file included from include/drm/drm_kunit_helpers.h:10,
                    from drm_hdmi_state_helper_test.c:14:
   drm_hdmi_state_helper_test.c: In function 'drm_test_check_max_tmds_rate_bpc_fallback_yuv420':
>> include/kunit/test.h:776:29: error: SSE register return with SSE disabled
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

