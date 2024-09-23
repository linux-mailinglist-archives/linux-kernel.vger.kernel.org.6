Return-Path: <linux-kernel+bounces-335440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC15197E5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDAA1C20986
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9821754B;
	Mon, 23 Sep 2024 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="thyKlhEB"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E21134B2
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727070777; cv=none; b=c1NAu53mX2tfNmxrWLc9484WO8OzA4WOiNjNU/aiykM+n6YHNj4EbAUbsPcsQoUb59fqIVFClatc9Mz66IW5XXurYILCXZK8pEwq49N8hYELYWzz9aS/yg0r3YPT0gr7HQD2/t6/hilzFtMlVvx0a/elJWQuivMvedZP/2nw7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727070777; c=relaxed/simple;
	bh=jdFNWa2lQIKNDOLjiJa6F8zBHQYysX18WWS31rkDF3E=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=t3zqq08SJvSW1y4If/yX0xtsq6/dfFp/lrlKk5jqxK4agnfAGeuhj6E6ztwWQUoxOA0ptJbrh99u3i1rG+crvwoYcgt86PYsE+mXomUIWyBeq787lS1bXFwNpFP4YTmbUhz3nH97YrdvPQbpydJvSLd1EtjlXOO02kD1WyZTYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=thyKlhEB; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VH/2p6QFE5M8vhp2WtPeQxRJLuM/ISYqgGthCFfJcfo=;
  b=thyKlhEBY8cbyg8JQcL3uQbSDlx0OzPhcozydjLV310VkzRuIgfOKvyx
   3+gmFwDxueegKDGUfaC4ljJltMz6WUAzscr4/PbJ00KkWZ7fm6iCK+her
   ex8WW6FpDrwYIx0H9oNold+tToGknhdpeeuwKnO/P7PaAU1Ntwl6vnRZz
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.10,250,1719871200"; 
   d="scan'208";a="184474004"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 07:52:45 +0200
Date: Mon, 23 Sep 2024 07:52:44 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Frank Wang <frank.wang@rock-chips.com>
cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
    oe-kbuild-all@lists.linux.dev
Subject: drivers/usb/typec/tcpm/tcpm.c:6356:20-21: WARNING opportunity for
 max() (fwd)
Message-ID: <a27853fb-d0b4-c5b3-c26f-fdc088eea558@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Mon, 23 Sep 2024 10:57:07 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/usb/typec/tcpm/tcpm.c:6356:20-21: WARNING opportunity for max()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Frank Wang <frank.wang@rock-chips.com>
CC: Guenter Roeck <linux@roeck-us.net>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de5cb0dcb74c294ec527eddfe5094acfdb21ff21
commit: 8be558dcffe69b078b34b1fa93b82acaf4ce4957 usb: typec: tcpm: add get max power support
date:   1 year, 3 months ago
:::::: branch date: 8 hours ago
:::::: commit date: 1 year, 3 months ago
config: arc-randconfig-r054-20240923 (https://download.01.org/0day-ci/archive/20240923/202409231009.2efXAh9b-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202409231009.2efXAh9b-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/usb/typec/tcpm/tcpm.c:6356:20-21: WARNING opportunity for max()

vim +6356 drivers/usb/typec/tcpm/tcpm.c

f2a8aa053c1761 drivers/usb/typec/tcpm.c      Adam Thomson 2018-04-23  6342
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6343  static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6344  					  union power_supply_propval *val)
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6345  {
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6346  	unsigned int src_mv, src_ma, max_src_uw = 0;
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6347  	unsigned int i, tmp;
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6348
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6349  	for (i = 0; i < port->nr_source_caps; i++) {
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6350  		u32 pdo = port->source_caps[i];
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6351
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6352  		if (pdo_type(pdo) == PDO_TYPE_FIXED) {
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6353  			src_mv = pdo_fixed_voltage(pdo);
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6354  			src_ma = pdo_max_current(pdo);
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6355  			tmp = src_mv * src_ma;
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16 @6356  			max_src_uw = tmp > max_src_uw ? tmp : max_src_uw;
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6357  		}
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6358  	}
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6359
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6360  	val->intval = max_src_uw;
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6361  	return 0;
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6362  }
8be558dcffe69b drivers/usb/typec/tcpm/tcpm.c Frank Wang   2023-06-16  6363

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

