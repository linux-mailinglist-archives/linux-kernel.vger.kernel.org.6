Return-Path: <linux-kernel+bounces-269346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE0B9431CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF349B24208
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BDB1B3754;
	Wed, 31 Jul 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjC8UgQ2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2031B3748
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435226; cv=none; b=jRrrExpePpxrkU1vw6Sv/5qZSp6Vv/4+2YR3KeWIP03R63RXBuHbmDMrpeK51P9kljUXBkAKrdJBn26o7EZSONAvLF+YDaOMymlXLOX/VIoy7HIAJNi2HGaKWwNsoE+D21gSpIRRIDdA3oTq0U+mWm3rxZoQkXPe7ha1nCTdziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435226; c=relaxed/simple;
	bh=PsZ7vZbtm6qZyG0nHh+ujBlh/HQ25NrLbIHOdDMREow=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E4D7oxGFJl2KZygPqmlOj4DK87ltb1D31isJza15XYInH1OLH4xkQLfCPDrxQ7rDZFIDQzp3JJnJCN7oJdAbXlAdAYWTb0uYQCz8JJbuzP2MkvWxT8hE7wnjimNmn+MBrPfI72UDpCcBc90Z8iQF/mPbm58xLgKdMi8yMcg0mLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjC8UgQ2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722435224; x=1753971224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PsZ7vZbtm6qZyG0nHh+ujBlh/HQ25NrLbIHOdDMREow=;
  b=jjC8UgQ2eM2Lwz+LX5y/AMmEbddZcnaX9K9vyqg3j1VZXDUZY2sYd+At
   ngt/CWzcgGERHmJNm6OlyJISJ5RXQAvNyzFx1I0wLC5icqlIz//kouKo/
   2Xx0PnmJkeUTH4RJvFCzPmjtrwFPGc+p6BqazRPwdgU3tnQvyBr/zz82v
   M3x8AnOn9qd5uy1qMFEYzne/V1RBkpLHuP1r1P/cr2BU+jUR0mtcTYwQk
   Oyuv5IHVBbzLQnJq6dM4n9/zST7oVs7j0ehz+EDqcD6SQTvd3YPC5gy9o
   T+SUgco5/TLbwo2aFxlpPYR9P4jYvQwDJF9mrF55suxK1Zf6a/DwH4od6
   Q==;
X-CSE-ConnectionGUID: sRSgyDc7RXu2SNdQa5BC2Q==
X-CSE-MsgGUID: nq9bpXOnT+C1co8xGqbUYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="30899326"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="30899326"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:13:43 -0700
X-CSE-ConnectionGUID: 7hvZbxjQTP2MR4C1o+DkNw==
X-CSE-MsgGUID: 7hDysihvRIyNzIlnuqHv9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="85333005"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Jul 2024 07:13:41 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZA5C-000uPL-38;
	Wed, 31 Jul 2024 14:13:38 +0000
Date: Wed, 31 Jul 2024 22:13:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240729-cbc-2 8/9]
 ./usr/include/scsi/fc/fc_els.h:1130:53: error: use of undeclared identifier
 'desc_tags'
Message-ID: <202407312216.neWTKzbG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240729-cbc-2
head:   7028047dd569cc1fc6fcda22626a7c85347fadbd
commit: 06621fb3befe6bcfd46d10a14ea18b22b9daa740 [8/9] scsi: fc: Avoid -Wflex-array-member-not-at-end warnings
config: i386-buildonly-randconfig-003-20240731 (https://download.01.org/0day-ci/archive/20240731/202407312216.neWTKzbG-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240731/202407312216.neWTKzbG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407312216.neWTKzbG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/scsi/fc/fc_els.h:1130:16: error: implicit declaration of function 'offsetof' [-Werror,-Wimplicit-function-declaration]
    1130 | _Static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
         |                ^
>> ./usr/include/scsi/fc/fc_els.h:1130:25: error: expected expression
    1130 | _Static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
         |                         ^
>> ./usr/include/scsi/fc/fc_els.h:1130:53: error: use of undeclared identifier 'desc_tags'
    1130 | _Static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
         |                                                     ^
   ./usr/include/scsi/fc/fc_els.h:1148:25: error: expected expression
    1148 | _Static_assert(offsetof(struct fc_els_rdf, desc) == sizeof(struct fc_els_rdf_hdr),
         |                         ^
>> ./usr/include/scsi/fc/fc_els.h:1148:44: error: use of undeclared identifier 'desc'
    1148 | _Static_assert(offsetof(struct fc_els_rdf, desc) == sizeof(struct fc_els_rdf_hdr),
         |                                            ^
   5 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

