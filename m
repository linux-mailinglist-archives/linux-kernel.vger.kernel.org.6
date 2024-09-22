Return-Path: <linux-kernel+bounces-335110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF41597E11E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C72D1C20A69
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892CA193065;
	Sun, 22 Sep 2024 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="U2DjVAGe"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093E3B7AC
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004285; cv=none; b=WW/Yj8UfmgMyN8Bo3CkRJofy7MUXFoHZ95a9KP019RyfdSnNAZAlD08zOMT/lJbIjcumMrfohbP15brofaDGo6Qt4kJCHzs/ytwZtJPGQJNPeKTZt7A9Wq0F4f1Z7hhcjgyHgLlJvae/R7w8b4uFdSlPEYhJZ0gT2G1TDonkZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004285; c=relaxed/simple;
	bh=dsadym4dEXm//vaT3TC0w7GSJgE09cbWE6tEXWb5yIs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=dQYi+A3Yz6rJjC5SyLKYb0mgDZiXServgTVvhdQS9113RUo+VG0SO4tYDKOrUiQoURecSqJRuvXBMBqVDvZd/nKxidqyYyrBHN5i+gtHoPHWodL4oDe8AC8NtFtOEhWq2lZ8IOpOcty6IyEpdOVe6I8qkhtBuiF0Qxlsg1B+bp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=U2DjVAGe; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=BQoT8FdfEkd5jPNCFSWUxcN9N438Xa7+DM7EFAuDWk0=;
  b=U2DjVAGeYpTsuNgFcZPmo4p2P4mCNLE/nbt658AKFpO6pYH+2spaXoMv
   CksOes1VPjRs1d3m1c3frqmBWJvwXAq0YjE0nIf5+tyx9APwsUAT9vLbc
   biXn56HAOcOSNYQXGLp0z7Z7SwBCjsfC9lZMxqvtnog4HIzyioyz/yWwy
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184415402"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 13:24:39 +0200
Date: Sun, 22 Sep 2024 13:24:39 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Tom Zanussi <tom.zanussi@linux.intel.com>, 
    Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, 
    oe-kbuild-all@lists.linux.dev
Subject: drivers/crypto/intel/qat/qat_common/adf_sysfs.c:25:9-35: opportunity
 for str_up_down(adf_dev_started ( accel_dev )) (fwd)
Message-ID: <alpine.DEB.2.22.394.2409221324000.3517@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Sun, 22 Sep 2024 18:14:02 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/crypto/intel/qat/qat_common/adf_sysfs.c:25:9-35: opportunity
    for str_up_down(adf_dev_started ( accel_dev ))

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Tom Zanussi <tom.zanussi@linux.intel.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88264981f2082248e892a706b2c5004650faac54
commit: a4b16dad46576ce08ecb660fc923d0857dcae107 crypto: qat - Move driver to drivers/crypto/intel/qat
date:   1 year, 6 months ago
:::::: branch date: 17 hours ago
:::::: commit date: 1 year, 6 months ago
config: csky-randconfig-r051-20240922 (https://download.01.org/0day-ci/archive/20240922/202409221848.0jTifKtq-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202409221848.0jTifKtq-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/crypto/intel/qat/qat_common/adf_sysfs.c:25:9-35: opportunity for str_up_down(adf_dev_started ( accel_dev ))

vim +25 drivers/crypto/intel/qat/qat_common/adf_sysfs.c

5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  14
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  15  static ssize_t state_show(struct device *dev, struct device_attribute *attr,
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  16  			  char *buf)
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  17  {
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  18  	struct adf_accel_dev *accel_dev;
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  19  	char *state;
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  20
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  21  	accel_dev = adf_devmgr_pci_to_accel_dev(to_pci_dev(dev));
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  22  	if (!accel_dev)
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  23  		return -EINVAL;
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  24
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27 @25  	state = adf_dev_started(accel_dev) ? "up" : "down";
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  26  	return sysfs_emit(buf, "%s\n", state);
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  27  }
5ee52118ac1481 drivers/crypto/qat/qat_common/adf_sysfs.c Giovanni Cabiddu 2022-06-27  28

:::::: The code at line 25 was first introduced by commit
:::::: 5ee52118ac1481dd8a8f7e6a9bfe6ee05ac6ec92 crypto: qat - expose device state through sysfs for 4xxx

:::::: TO: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

