Return-Path: <linux-kernel+bounces-410288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A139CD88A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F201F231ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60C1891AA;
	Fri, 15 Nov 2024 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrXd7Y+V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07151885BF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653509; cv=none; b=lLM36R86xzx72tWZ7IDftQ6dLvq44EwIG1s4qsJOOw1AJ/dR7HwaOlbKklZq5x9tpBpKwNHLfjjoEoTYUJ8xn6L4jifkxvNwKVPs2CVaiKgPQZx0h9faqetngoZ/WovburjUy1YZKN5fTw4ye6Pu/tIWd5qdwpmk3G/m/HcrhLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653509; c=relaxed/simple;
	bh=Wy4L3bUeHnZKBRu+h9uMrikHMffOLKz+jJTRwzpJxxw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VjuzASps5/n5xJcwdQ6ANkmpZwdZMA7EW4G5KakScYM8Mg7E7EI/3f66YBsX7LUuW3i8ffDJhWbeMbQ7PvOKq8bwR5neMQJ/xITVGA0c77X7herhFhHK1kzukZW5/y8TMdmaS7+aK/2pD19Fo5pmuEMztjt9K9PakU9dcE0sEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZrXd7Y+V; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731653508; x=1763189508;
  h=date:from:to:cc:subject:message-id;
  bh=Wy4L3bUeHnZKBRu+h9uMrikHMffOLKz+jJTRwzpJxxw=;
  b=ZrXd7Y+VA7vqL2PJ/feQhjdGk0S6kOy3+AIo8jHvbXL6+/UD+aOI1bIB
   Ki8O7Ga6dfW5sL12/OE6OncFldJpJUD6wEIGL+0js9M5rZakPe8SFtHoc
   UARV41zmNvUc6IYEBh4tHp6Lif84GmHCe2WmQAGjcCOloBolgTmtou/Fr
   +N7Cs86a8NgecZ0g00X5nP0T0lr13VlVKH8Rx6hYp0xBpF5UWFw5i2dET
   AMOeqkqUg96w+nvsDc2Au77yzl7dBdfyxIswzyA89i3lc1THjQ9oTn8L5
   vYPZWmO3tdWlvEXupD6yqBXvN3W2ypDpWoSLXvDH9laAQdkyvwPYwz4wz
   A==;
X-CSE-ConnectionGUID: h4A30OoiS4yqzFHkmoq1Jg==
X-CSE-MsgGUID: KCg5BPK1TkqkakQ9n9cmMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="31587192"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="31587192"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 14:47:20 -0800
X-CSE-ConnectionGUID: bx/M7Ya8QbiB4W51v6i9NA==
X-CSE-MsgGUID: phctoD+CRbaYTax18mz/Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93305072"
Received: from lkp-server02.sh.intel.com (HELO f5eddd9a323a) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 14 Nov 2024 14:47:19 -0800
Received: from kbuild by f5eddd9a323a with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBibO-00005J-1z;
	Thu, 14 Nov 2024 22:46:29 +0000
Date: Fri, 15 Nov 2024 06:45:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 a2512b55bfb1b25107cf32a44f2f4b76b7f74465
Message-ID: <202411150634.2BJhzzsT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: a2512b55bfb1b25107cf32a44f2f4b76b7f74465  Merge branch into tip/master: 'x86/urgent'

elapsed time: 726m

configs tested: 7
configs skipped: 28

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    allmodconfig    gcc-12
i386     allnoconfig    gcc-12
i386    allyesconfig    gcc-12
i386       defconfig    clang-19
x86_64   allnoconfig    clang-19
x86_64  allyesconfig    clang-19
x86_64     defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

