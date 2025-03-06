Return-Path: <linux-kernel+bounces-548809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955BCA5499C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8031751C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D00227E8A;
	Thu,  6 Mar 2025 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEI/2yVX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E6221F2F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260667; cv=none; b=Ghq2akrGMEcJF4gARj0lk2RBdnsb1e4bP0nxU3Wq1tYC5vShIqsP6lmJiJsyMB4+OAggBZbJY2M6WZPoNuMT+MhIr713UKaLSZD/M5422/V/tq9ZWedxqI6/oMSomS75RYorwNZCODaPhfs9qGP0zvmqd8cbFjlkDAVbd8T+7UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260667; c=relaxed/simple;
	bh=fkA3LgBiZ9P+XFOIZWID3AiDisw4h/M+BwpUezO3WB0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VntBIfbCR1AZRbnmx8CGwnbNnTcQXiD+FFdhleh0S4ALPaGzFUbch7agECq7YXb/vB7nma6aRtRIgJt1xe2v2iSmwa70mTf9V76hrlQevwsHA3/4REFo9Xx9osw663d4SiAJxrQ23Tfgrqz+Fw++KZ6WHmhMf5ptOs2GN7qzMh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEI/2yVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C6FBC4CEE8;
	Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260667;
	bh=fkA3LgBiZ9P+XFOIZWID3AiDisw4h/M+BwpUezO3WB0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iEI/2yVXL7kv0R61esJ/3nrrZEDp9VtxZ71OFiWgxHdq42jQuch1EhVLbATfzL7Up
	 bIc8c2yphHNbmKBNnc3OfsQ/jXUT8GCrnYfLBdmiy/JmgRRLqfvuV3iSOFbKm3RM6n
	 /5xZPLkAw8jELi5VyxQz82Q9Wlzc+MCx/4xI96fQZRX2it3rg+0PfXlZRVJJzYEb51
	 tLh0zLOmkdzhykWDRFCCTOHU21PuA2vzXyG7YNwkXFb3r5rSNBl9OSqphkLdkyrg0r
	 9/tzNKWE4NevUGkeYCA/2SrgpeUs8ZlLFyS3T4La3WyMr3KBJPSxVHsu//hMkcgazy
	 cjOSprmLTJsKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014C9C282EC;
	Thu,  6 Mar 2025 11:31:07 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Subject: [PATCH v5 0/7] bits: Fixed-type GENMASK()/BIT()
Date: Thu, 06 Mar 2025 20:29:51 +0900
Message-Id: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC+HyWcC/22OQQ6DIBQFr9Kw7jeIIKQr79G4IPBR0goGrK0x3
 r3aprsuJ3lvMivJmDxmcjmtJOHss49hB3E+EdPr0CF4uzNhlAnKmALnX2hhWkaEDsOg8y2DsqU
 WQriKoyL7c0x4zA7rtd3ZpTjA1CfUPxenjCoquWBlIaSksoYS7g+jc2Fx0Mn0vvFhwnth4nAoe
 5+nmJZP58wP8TepouJv0syBQqlkZY11tWRV89RB2xgLl0i7bdsb8fKhDPoAAAA=
X-Change-ID: 20250228-fixed-type-genmasks-8d1a555f34e8
To: Yury Norov <yury.norov@gmail.com>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>, 
 David Laight <David.Laight@ACULAB.COM>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5101;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=fkA3LgBiZ9P+XFOIZWID3AiDisw4h/M+BwpUezO3WB0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkn2+Mzt6hqV07xqVjoevnexmONu5TXS0+au/KUWaKug
 SLfgVz2jlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABOZIc7wPypxXsPk6syfe7Y6
 L4uQuagT0BagLlhtvnChstBS/9TlyowMCyPaz/3gmWj/L/Xfmd8W2m7v+nV+2TldcVsdvmvdmoo
 DTAA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

Introduce some fixed width variant of the GENMASK() and the BIT()
macros in bits.h. Note that the main goal is not to get the correct
type, but rather to enforce more checks at compile time. For example:

  GENMASK_U16(16, 0)

will raise a build bug.

This series is a continuation of:

  https://lore.kernel.org/intel-xe/20240208074521.577076-1-lucas.demarchi@intel.com

from Lucas De Marchi. Above series is one year old. I really think
that this was a good idea and I do not want this series to die. So I
am volunteering to revive it.

Meanwhile, many changes occurred in bits.h. The most significant
change is that __GENMASK() was moved to the uapi headers.

In v4 an onward, I introduce one big change: split the definition of
the asm and non-asm GENMASK(). I think this is controversial.
Especially, Yury commented that he did not want such split. So I
initially implemented a first draft in which both the asm and non-asm
version would rely on the same helper macro, i.e. adding this:

  #define __GENMASK_t(t, w, h, l)			\
  	(((t)~_ULL(0) - ((t)1 << (l)) + 1) &		\
  	 ((t)~_ULL(0) >> (w - 1 - (h))))
    
to uapi/bits.h. And then, the different GENMASK()s would look like
this:

  #define __GENMASK(h, l) __GENMASK_t(unsigned long, __BITS_PER_LONG, h, l)
    
and so on.
    
I implemented it, and the final result looks quite ugly. Not only do
we need to manually provide the width each time, the biggest concern
is that adding this to the uapi is asking for trouble. Who knows how
people are going to use this? And once it is in the uapi, there is
virtually no way back.

Finally, I do not think it makes sense to expose the fixed width
variants to the asm. The fixed width integers type are a C
concept. For asm, the long and long long variants seems sufficient.

And so, after implementing both, the asm and non-asm split seems way
more clean and I think this is the best compromise. Let me know what
you think :)

As requested, here are the bloat-o-meter stats:

  $ ./scripts/bloat-o-meter vmlinux_before.o vmlinux_after.o 
  add/remove: 0/0 grow/shrink: 4/2 up/down: 5/-4 (1)
  Function                                     old     new   delta
  intel_psr_invalidate                         666     668      +2
  mst_stream_compute_config                   1652    1653      +1
  intel_psr_flush                              977     978      +1
  intel_dp_compute_link_config                1327    1328      +1
  cfg80211_inform_bss_data                    5109    5108      -1
  intel_drrs_activate                          379     376      -3
  Total: Before=22723481, After=22723482, chg +0.00%

(done with GCC 12.4.1 on a defconfig)

--
2.43.0

---
Changes from v4:

  - Rebase on https://github.com/norov/linux/tree/bitmap-for-next

  - Rename GENMASK_t() to GENMASK_TYPE()

  - First patch of v4 (the typo fix 'init128' -> 'int128') is removed
    because it was resent separately in:
    https://lore.kernel.org/all/20250305-fix_init128_typo-v1-1-cbe5b8e54e7d@wanadoo.fr

  - Replace the (t)~ULL(0) by type_max(t). This way, GENMASK_TYPE()
    can now be used to generate GENMASK_U128().

  - Get rid of the unsigned int cast for the U8 and U16 variants.

  - Add the BIT_TYPE() helper macro.

  - Link to v4: https://lore.kernel.org/r/20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr

Changes from v3:

  - Rebase on v6.14-rc5

  - Fix a typo in GENMASK_U128() comment.

  - Split the asm and non-asm definition of 

  - Replace ~0ULL by ~ULL(0)

  - Since v3, __GENMASK() was moved to the uapi and people started
    using directly. Introduce GENMASK_t() instead.

  - Link to v3: https://lore.kernel.org/intel-xe/20240208074521.577076-1-lucas.demarchi@intel.com

Changes from v2:

  - Document both in commit message and code about the strict type
    checking and give examples how it´d break with invalid params.

  - Link to v2: https://lore.kernel.org/intel-xe/20240124050205.3646390-1-lucas.demarchi@intel.com

Link to v1: https://lore.kernel.org/intel-xe/20230509051403.2748545-1-lucas.demarchi@intel.com

---
Lucas De Marchi (3):
      bits: introduce fixed-type BIT_U*()
      drm/i915: Convert REG_GENMASK*() to fixed-width GENMASK_U*()
      test_bits: add tests for GENMASK_U*()

Vincent Mailhol (3):
      bits: split the definition of the asm and non-asm GENMASK()
      test_bits: add tests for __GENMASK() and __GENMASK_ULL()
      test_bits: add tests for BIT_U*()

Yury Norov (1):
      bits: introduce fixed-type genmasks

 drivers/gpu/drm/i915/i915_reg_defs.h | 108 ++++-------------------------------
 include/linux/bitops.h               |   1 -
 include/linux/bits.h                 |  77 ++++++++++++++++++-------
 lib/test_bits.c                      |  47 +++++++++++++++
 4 files changed, 113 insertions(+), 120 deletions(-)
---
base-commit: 0312e94abe484b9ee58c32d2f8ba177e04955b35
change-id: 20250228-fixed-type-genmasks-8d1a555f34e8

Best regards,
-- 
Vincent Mailhol <mailhol.vincent@wanadoo.fr>



