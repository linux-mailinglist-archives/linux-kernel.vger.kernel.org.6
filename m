Return-Path: <linux-kernel+bounces-249699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFF992EEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3BB12892C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A416DC29;
	Thu, 11 Jul 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkSK/D/7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A516D4FA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721982; cv=none; b=X/tdwg+rBvUwlD/a3VBabfcDGU8D/CE48+n+Ogz6fVUoD7dcfEPq111n5cOFCeNpettGh0njkzMX5dsLjS/YxEbz5gDj3T9i7t1m8xWHVrWqMTIQWL3BmG1ch7Djm8dmYeqJ03Xin64xyTNzuujcvLHevh5SASXZc4mlkpAdg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721982; c=relaxed/simple;
	bh=Eclwa3uElrMZeDtYKr10AnmVJlksudtD8oE64F0dyLU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=InsgNsuqo00Oj5wfCzWpFidE0v2Do8bWAO1jYrs6aJbwhTt0NO2lr6VBxg9LQ3q1y2iSHs3AzHJ2fQAiHXVALJvG344sZtR0iWu7KNGsf+a5/lWQ7pFAzlf5m/lRU2cF10N8yWVI6ptX+YpupbPAHHLdN0cPXWSdqCjFmDjW/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkSK/D/7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720721980; x=1752257980;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Eclwa3uElrMZeDtYKr10AnmVJlksudtD8oE64F0dyLU=;
  b=jkSK/D/7DpTJHNV/O9JyvwTjomyix1TTIaxxUJLQVuFiOQ/Z0DoMfzgK
   NFPIsNii3MnSGni3isyierucuUNPJymBk+zQHRRnsj6KHrG6haou9HmX9
   p2WKxBmDxGfVSLo7+1e8gdO+bHytvGxND9UDUHku9NCvAEaYmbJnaYlH8
   NVyiEmDiEzfdB/IDvuCYVAO2oh6iL1dQkOINht2jZGlZEWisp52W7vaHv
   LYUwJPw6cGI/rQe27bbrX7GLl4MiMG34gS450dMNDz1EhRYz1FJ0FstwA
   4BGnszxkDo70eQxhJyCt+r5gvnRbFa2BxiiTwC4iQsK2757Etv0UXuACW
   w==;
X-CSE-ConnectionGUID: GELFaxZcSI6z6HIJYQFmeQ==
X-CSE-MsgGUID: Z5VD0JhnQ9+Ym55zCNmddg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28722309"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="28722309"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:19:40 -0700
X-CSE-ConnectionGUID: 8XpkcuTsTFOZvUpmG+p84Q==
X-CSE-MsgGUID: F04CnuUeRIeHL6ey5UK3sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48394020"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jul 2024 11:19:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRyOF-000Zds-3C;
	Thu, 11 Jul 2024 18:19:35 +0000
Date: Fri, 12 Jul 2024 02:19:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240710-cbc 12/13]
 ./usr/include/linux/ethtool.h:1644:15: error: unknown type name 'offsetof'
Message-ID: <202407120212.LWwEpZgQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240710-cbc
head:   73efb8d9b6a2ba4b07021861a1760ec742ddf432
commit: d2fc97b383bbbdff9312f7993dbc9fd9d44bf379 [12/13] ethtool: Avoid -Wflex-array-member-not-at-end warning
config: i386-buildonly-randconfig-001-20240711 (https://download.01.org/0day-ci/archive/20240712/202407120212.LWwEpZgQ-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407120212.LWwEpZgQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407120212.LWwEpZgQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/ethtool.h:1644:15: error: unknown type name 'offsetof'
    1644 | static_assert(offsetof(struct ethtool_dump, data) ==
         |               ^~~~~~~~
   ./usr/include/linux/ethtool.h:22:1: note: 'offsetof' is defined in header '<stddef.h>'; did you forget to '#include <stddef.h>'?
      21 | #include <limits.h> /* for INT_MAX */
     +++ |+#include <stddef.h>
      22 | 
>> ./usr/include/linux/ethtool.h:1646:15: error: expected declaration specifiers or '...' before string constant
    1646 |               "struct member outside of __struct_group()");
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

