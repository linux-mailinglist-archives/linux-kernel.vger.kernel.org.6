Return-Path: <linux-kernel+bounces-368485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA79A1053
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45A31C216C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7608620F5DF;
	Wed, 16 Oct 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="ox0UoO/G"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F0187342
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098512; cv=none; b=SnnoR3pPci/gxriNh/au2SgVDkM4qtiuch4JYbhBS4XXRdmYKruY5LVrbFm7IhO0DqmlL9C8bKRdW1uyRP5ZQAL05BWXB+cUKSoTupPfTOM5GDFqio3ILh41tzo+5yH03H3FU5KFjASlq1SoW0smOH7OWAL9Bv1bE4uztMNx1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098512; c=relaxed/simple;
	bh=vTPL+8RbD5EH+C790fc6r2Ug4lG/D0GptEvfLet8gVM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=BXOV3SpKZ2Wma6MNdi/Xbooc6dY7Y2n8nClmwntIhKyMQe+DyZOjBOEC1DG/zUP1v7HsDo3PCVnjtDJj8CKYIklXSi0V2hvUK/llT+ns8aSNfgRjEtBN2VSimtDcic59SnWE9c0J91vdeUIWO6y08gY1ADgGJNtD18ruBYkw/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=ox0UoO/G; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oQcN6MPtUqLZH1eMRlZJxKQBqb+s5THzi7N50fuEBfc=;
  b=ox0UoO/GJq2YOtr7hyVFAnBIBClUZHP5SxLosGMU0pBS+pv0zvd6DaAL
   bJToXKelKsrHpoc5trbW2PCNEzEe4JKd8rBNGqEEx9UYU5vhLeWp4cteX
   u1kn+WNMGJGjQ6enFeSFLYLHegPLJeWirn9yCqCscplTIigoKWa5bYK1d
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,208,1725314400"; 
   d="scan'208";a="189208288"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 19:08:20 +0200
Date: Wed, 16 Oct 2024 19:08:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Luben Tuikov <luben.tuikov@amd.com>
cc: Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, 
    oe-kbuild-all@lists.linux.dev
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c:145:8-12: opportunity
 for str_read_write(read) (fwd)
Message-ID: <23858629-8fe8-94ee-88d0-209dbdee4fbf@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Wed, 16 Oct 2024 18:28:29 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c:145:8-12: opportunity for
    str_read_write(read)

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Luben Tuikov <luben.tuikov@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
commit: 93ade343bbadd73999324dcc66c933e398e39818 drm/amdgpu: EEPROM respects I2C quirks
date:   3 years, 4 months ago
:::::: branch date: 16 hours ago
:::::: commit date: 3 years, 4 months ago
config: i386-randconfig-054-20241016 (https://download.01.org/0day-ci/archive/20241016/202410161814.I6p2Nnux-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202410161814.I6p2Nnux-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c:145:8-12: opportunity for str_read_write(read)

vim +145 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c

93ade343bbadd7 Luben Tuikov 2021-01-28  112
93ade343bbadd7 Luben Tuikov 2021-01-28  113  /**
93ade343bbadd7 Luben Tuikov 2021-01-28  114   * amdgpu_eeprom_xfer -- Read/write from/to an I2C EEPROM device
93ade343bbadd7 Luben Tuikov 2021-01-28  115   * @i2c_adap: pointer to the I2C adapter to use
93ade343bbadd7 Luben Tuikov 2021-01-28  116   * @slave_addr: I2C address of the slave device
93ade343bbadd7 Luben Tuikov 2021-01-28  117   * @eeprom_addr: EEPROM address from which to read/write
93ade343bbadd7 Luben Tuikov 2021-01-28  118   * @eeprom_buf: pointer to data buffer to read into/write from
93ade343bbadd7 Luben Tuikov 2021-01-28  119   * @buf_size: the size of @eeprom_buf
93ade343bbadd7 Luben Tuikov 2021-01-28  120   * @read: True if reading from the EEPROM, false if writing
93ade343bbadd7 Luben Tuikov 2021-01-28  121   *
93ade343bbadd7 Luben Tuikov 2021-01-28  122   * Returns the number of bytes read/written; -errno on error.
93ade343bbadd7 Luben Tuikov 2021-01-28  123   */
93ade343bbadd7 Luben Tuikov 2021-01-28  124  int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
93ade343bbadd7 Luben Tuikov 2021-01-28  125  		       u16 slave_addr, u16 eeprom_addr,
93ade343bbadd7 Luben Tuikov 2021-01-28  126  		       u8 *eeprom_buf, u16 buf_size, bool read)
93ade343bbadd7 Luben Tuikov 2021-01-28  127  {
93ade343bbadd7 Luben Tuikov 2021-01-28  128  	const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
93ade343bbadd7 Luben Tuikov 2021-01-28  129  	u16 limit;
93ade343bbadd7 Luben Tuikov 2021-01-28  130
93ade343bbadd7 Luben Tuikov 2021-01-28  131  	if (!quirks)
93ade343bbadd7 Luben Tuikov 2021-01-28  132  		limit = 0;
93ade343bbadd7 Luben Tuikov 2021-01-28  133  	else if (read)
93ade343bbadd7 Luben Tuikov 2021-01-28  134  		limit = quirks->max_read_len;
93ade343bbadd7 Luben Tuikov 2021-01-28  135  	else
93ade343bbadd7 Luben Tuikov 2021-01-28  136  		limit = quirks->max_write_len;
93ade343bbadd7 Luben Tuikov 2021-01-28  137
93ade343bbadd7 Luben Tuikov 2021-01-28  138  	if (limit == 0) {
93ade343bbadd7 Luben Tuikov 2021-01-28  139  		return __amdgpu_eeprom_xfer(i2c_adap, slave_addr, eeprom_addr,
93ade343bbadd7 Luben Tuikov 2021-01-28  140  					    eeprom_buf, buf_size, read);
93ade343bbadd7 Luben Tuikov 2021-01-28  141  	} else if (limit <= EEPROM_OFFSET_SIZE) {
93ade343bbadd7 Luben Tuikov 2021-01-28  142  		dev_err_ratelimited(&i2c_adap->dev,
93ade343bbadd7 Luben Tuikov 2021-01-28  143  				    "maddr:0x%04X size:0x%02X:quirk max_%s_len must be > %d",
93ade343bbadd7 Luben Tuikov 2021-01-28  144  				    eeprom_addr, buf_size,
93ade343bbadd7 Luben Tuikov 2021-01-28 @145  				    read ? "read" : "write", EEPROM_OFFSET_SIZE);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

