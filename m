Return-Path: <linux-kernel+bounces-269253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05129942FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2AE1F2A956
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F6F1B0136;
	Wed, 31 Jul 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hc+RXQAR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F01AE871
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431507; cv=none; b=riK66hQNr+UzoTy4b/Ngl+Q3eIgJvApF1mHKZqI2Wcus1tF+Stvzag9rpO340Neusv5epABll3k+PLmWdtQ/do+w0bCGb4RDOtpbdkA32gD6hZcM24jXbPGz/vpjK4wN5gA73h0/r+Bo1X1Ol4Mg/QDImn4bDeaHtO48iXBAFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431507; c=relaxed/simple;
	bh=By9ZMF8i7bFnJ7oseZVgZ4Ip5ORUl4uzykyHVIscDAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rkELyN8OwHaG7O0fLCkRg9FC35tnUo0454PKAQG7AKMn3OYkTJgJucQpPlOLYi4DgX86XFyJwRbRcrH26l3HiJpge9ZDW8IADx+MECVfflO0tykOPB36eH2tn/+jxA9NF5RfaHN5DAksLhPc5Nf/pgv0B5Vz+QRxCs1Vst0YhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hc+RXQAR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722431502; x=1753967502;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=By9ZMF8i7bFnJ7oseZVgZ4Ip5ORUl4uzykyHVIscDAk=;
  b=hc+RXQARdD2q+LX0ZE6z5oYMLmR/+jGD4JMpkd1KGRy3TiLbNEhaWyxH
   pOKvKj8w0O4RE6aeVZEhxuXOLtHFIx07vNfPSmHpqALahPcglg/ghNrIz
   q+ioAB0bw+JPFfzulvtZ+mIHaj2gXsenKB2+gHazkMv4aP93hq/N3Vu0R
   s9cU18t5Eye9nRbecu6kWiCr9P7WNbE1p5F+1o4Cv7GSlN0awxNOxxW4Y
   +wHt4CFX7CEs4IvPE5CQoxd7E6MwbnTbHUyWI7h5oeMgSueeoCBRHpCca
   Fl33mVCsZngAxD6mMeo8YAK42krS2kxGdJiMTMPRMmKEwuFEFb6TPQ3tU
   A==;
X-CSE-ConnectionGUID: 73/2HYVdQIK1gcHkIm+KEQ==
X-CSE-MsgGUID: X/XqS97oQBGReNjfZHkppg==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20123826"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20123826"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 06:11:41 -0700
X-CSE-ConnectionGUID: OnS/ziWdRSquaFGaWA72RQ==
X-CSE-MsgGUID: 6Vz6zhDURsKn0XQvJicp9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="59484831"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 31 Jul 2024 06:11:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZ97B-000uM0-07;
	Wed, 31 Jul 2024 13:11:37 +0000
Date: Wed, 31 Jul 2024 21:11:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240729-cbc-2 8/9]
 ./usr/include/scsi/fc/fc_els.h:1130:16: error: implicit declaration of
 function 'offsetof'
Message-ID: <202407312111.pIdI9KGE-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-004-20240731 (https://download.01.org/0day-ci/archive/20240731/202407312111.pIdI9KGE-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240731/202407312111.pIdI9KGE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407312111.pIdI9KGE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/scsi/fc/fc_els.h:1130:16: error: implicit declaration of function 'offsetof' [-Werror=implicit-function-declaration]
    1130 | _Static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
         |                ^~~~~~~~
   ./usr/include/scsi/fc/fc_els.h:13:1: note: 'offsetof' is defined in header '<stddef.h>'; did you forget to '#include <stddef.h>'?
      12 | #include <asm/byteorder.h>
     +++ |+#include <stddef.h>
      13 | 
>> ./usr/include/scsi/fc/fc_els.h:1130:25: error: expected expression before 'struct'
    1130 | _Static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
         |                         ^~~~~~
>> ./usr/include/scsi/fc/fc_els.h:1130:16: error: expression in static assertion is not an integer
    1130 | _Static_assert(offsetof(struct fc_df_desc_fpin_reg, desc_tags) == sizeof(struct fc_df_desc_fpin_reg_hdr),
         |                ^~~~~~~~
   ./usr/include/scsi/fc/fc_els.h:1148:25: error: expected expression before 'struct'
    1148 | _Static_assert(offsetof(struct fc_els_rdf, desc) == sizeof(struct fc_els_rdf_hdr),
         |                         ^~~~~~
   ./usr/include/scsi/fc/fc_els.h:1148:16: error: expression in static assertion is not an integer
    1148 | _Static_assert(offsetof(struct fc_els_rdf, desc) == sizeof(struct fc_els_rdf_hdr),
         |                ^~~~~~~~
   cc1: some warnings being treated as errors

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

