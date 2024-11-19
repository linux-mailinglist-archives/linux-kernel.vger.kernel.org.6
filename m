Return-Path: <linux-kernel+bounces-413920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124169D2098
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D364E282BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753C8155743;
	Tue, 19 Nov 2024 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMvZ9pOg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1771531C2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000239; cv=none; b=oVKKavtO/J+gQSQikUTO1TwiV+WkAjafPiyVqxedsUL53x/icMzsr0aE/MpN0ERsSUKBQv/m3D/ih69PuSYCP4etMYLIy0HLE83nN/rCWZuI1on27o2ZCXsAMz+FVlIr8xM4SAP/VlP9tnZldhh7FcVPGZ+j6RQz91KWadoDZcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000239; c=relaxed/simple;
	bh=BqpjFTDnJnBbRx9nVC/Obu6+AVn00e1MNg9RMCdqtyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wcdvs2ve6OO2BNiPvPFLawLiVL9zEQWfLlC7m9dilAm2gDmQ4VaSdcuiHe3V/ZzdOZeTkwzbwHuwO4W2W1vXlRW91TGWCFG74kHx2nEl4M+EwwU+M7KY18UgHKaDFFxT/hhoE8+++7HBH2ZEGqerNRrW1JBxxSw4r7fmJMCZRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMvZ9pOg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732000238; x=1763536238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BqpjFTDnJnBbRx9nVC/Obu6+AVn00e1MNg9RMCdqtyo=;
  b=JMvZ9pOgerSwhuMXuyXqoWUmJ0WofDj6ARvus6PhxQrY47WKVEqNJYiH
   ibW6Tu4wuxkCQZDBZ8OQvEkN9xLJqQHmF54LLvs2ZrhMXK2eCUeeX2/9e
   DSUdzvcvWHyINByySsPBq5cadOSg+TushygH2AqDTHf7sJCClkbJsqQvi
   K8nIooNHUaREbZAsWgraLF+LR6VxiKkzwhGfIhaAWNQQef4HdwmLoaqJ/
   3486V8JWlTpw6n2rjXTDIlQYUSYb21lth0TwNeatYwzxrPpdsSzFLVX/0
   7cD24tyczicuwxPQN10zHJh5K2Vk42LnuyYi9vmvSF1nRAQPFmzVbfpT1
   Q==;
X-CSE-ConnectionGUID: 3fwSodcLT6OUDAnbyuguPA==
X-CSE-MsgGUID: yHt7OJrpQi+AVBtNYa/uvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="42500272"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="42500272"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 23:10:38 -0800
X-CSE-ConnectionGUID: py2w9umARqWogdqol3xrRw==
X-CSE-MsgGUID: cVaXzrD1TQi4NJzckwuviQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="93924252"
Received: from lkp-server02.sh.intel.com (HELO 2cc4542d09d4) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 18 Nov 2024 23:10:36 -0800
Received: from kbuild by 2cc4542d09d4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDINe-00009q-0O;
	Tue, 19 Nov 2024 07:10:34 +0000
Date: Tue, 19 Nov 2024 14:59:51 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: ld.lld: error: unknown argument '-dp'
Message-ID: <202411191708.N1a70IsG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nathan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9fb2cfa4635ab7b3d44e88104666e599cd163692
commit: dd3a7ee91e0ce0b03d22e974a79e8247cc99959b hardening: Adjust dependencies in selection of MODVERSIONS
date:   7 weeks ago
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20241119/202411191708.N1a70IsG-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241119/202411191708.N1a70IsG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411191708.N1a70IsG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: unknown argument '-dp'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

