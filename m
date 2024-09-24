Return-Path: <linux-kernel+bounces-337694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216F4984DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6401F240E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48C5149E1A;
	Tue, 24 Sep 2024 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYjUIZuo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECA146D76
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216870; cv=none; b=Q2Oeu8pwa5f8wtCjxTwIayFufxQeaSWlITJMED5ZdYYXiGlFBaPeuEq69d3YMfmHvsGb+Hg+PVemA/BTRgCydJlGP6rIjiZvaRH6jbU9SSFfFFZHnn9d1+ocXgUMg++girvenqRbilf+G7n52Fcj5S/Bq51iqM2BJ0JMT9R5OuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216870; c=relaxed/simple;
	bh=1KT8JsF7dFmWaU1E+MmbaZVahSXzssNF4xnvWizLijg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZVyznlnP4l31sOiCwTpRgBXedrnSPtsLwZI7dyZGzkOdtLJ0qfV2+qs+FT6dGugjxFDt76hInVZhCb9pMVY7xzHbf804rhPuz9InVC3lVYM0hyRT0/PhFmFRDCV4fKNWvCF1YBf0qkt0DxiuZBODQozzJbVAGTk2bbpM2wsODN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYjUIZuo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727216869; x=1758752869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1KT8JsF7dFmWaU1E+MmbaZVahSXzssNF4xnvWizLijg=;
  b=cYjUIZuoyiXAhLMixi229KOWn2UhfiRIPn4jT6ePnLtVRN3ZtoLc23M8
   tajuNjuCDP2PoUqQvMUMqAY5TwsRMs+d+eg1KC9gOcly43v2S6jnN1cRE
   ilSxBjnpqPfHJLDU99PMqyweroAduxExLgCFOaoNm6IWOaoMfKxwQprGI
   aNfZgTfFr29ADkf7WbKck2RqQu/eBDw49E9ZWNq3qiABcrqoIjdMN8D9+
   OuWRPnCXOWbzoQ9glgpSoGt1VqT00W8SQi3/rjPGYkENi75k9UXIVzIIL
   OY08XAm1eQtl3QQbRNKR9JZNqwE9Iqb37NrjyWfKG0eRfQUbGegLdovdc
   Q==;
X-CSE-ConnectionGUID: g/u74lfKTJehQ0709jG8lA==
X-CSE-MsgGUID: w/B3rAa/RzuIsTOzhvnOvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="25715479"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="25715479"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:27:46 -0700
X-CSE-ConnectionGUID: kCEQysbWRNGajWreGhXAzw==
X-CSE-MsgGUID: EwXPbwzLTy+kFZKXT2M4Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="72020142"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Sep 2024 15:27:44 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stE0T-000Itt-0w;
	Tue, 24 Sep 2024 22:27:41 +0000
Date: Wed, 25 Sep 2024 06:27:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/thermal/testing/thermal-testing.o: warning: objtool:
 .text.tt_add_tz: unexpected end of section
Message-ID: <202409250637.5QiiHNph-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68e5c7d4cefb66de3953a874e670ec8f1ce86a24
commit: f6a034f2df426e279f1ecad53626bab80c04796a thermal: Introduce a debugfs-based testing facility
date:   5 weeks ago
config: x86_64-randconfig-122-20240925 (https://download.01.org/0day-ci/archive/20240925/202409250637.5QiiHNph-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250637.5QiiHNph-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250637.5QiiHNph-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/testing/thermal-testing.o: warning: objtool: .text.tt_add_tz: unexpected end of section
>> drivers/thermal/testing/thermal-testing.o: warning: objtool: .text.tt_del_tz: unexpected end of section
>> drivers/thermal/testing/thermal-testing.o: warning: objtool: .text.tt_zone_add_trip: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

