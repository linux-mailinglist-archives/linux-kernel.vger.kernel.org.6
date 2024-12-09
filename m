Return-Path: <linux-kernel+bounces-436757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F394A9E8A55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD701188450F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049E9189F37;
	Mon,  9 Dec 2024 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPtoG3TM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE82156228
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718684; cv=none; b=mXtwhbWefLqbih2jq+dh43MnmEp8V4X7MAffvw1eDYeY84Du0SkQyOpRp2MFUDyavxOknyTj7LADCQ0dZdYrYcTmHci5Jqq1U4GX/+3QnW85xAOVuAT7PSc/KWHN4E8yh9cIKo2fGjN6C5vzkE1fiq9cNwK07mAVVvuchv0AFRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718684; c=relaxed/simple;
	bh=ZJ3igJtk2NjtdQvhdiMW41K2QCX7GzWe82Y6ttnRgMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dEtR060OsOVJ5THqpHnzq6WvQ9zwWT8D6xLirP7n2QVdv4qkvkxPIpfz+Ao58JGhmel8z0dVT/j1CHHNr6pYknqUbfCKSSERHuUIBscdh6jgNRWMIHxilfUvtfDugEOrOIcao3+bDYDgeoZ3v3e52wUjErvvY61/lUiU9HIAKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPtoG3TM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733718681; x=1765254681;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZJ3igJtk2NjtdQvhdiMW41K2QCX7GzWe82Y6ttnRgMQ=;
  b=nPtoG3TMKaAPWzULQqp3V+HhAKt2qu4QCmC77t/wONkmx1/fIJr+oqjn
   iDMOCV1DM37mEcKMixtMYSe1A2slk6UjE+DigqxvnVnOdzHa1zT/J9CoQ
   pwEy/PV2/uRIPyzL9Q2peUZf5wQIQtaXGQBIDnfOLl/ZTA0/mpnPOq3r0
   1CZ/hV3PvGXeo9jfdxCgsKg/S2KX9m4iyLCnp4nM1fwaM/u34beeRFjM/
   LiOFLaqXD+f7KBf5X+iA9L658bZP3lVJNRmjkLnEIqzt3RxRahCoHyHxv
   SqhHFr8v7s/aVoM+XPGqTVC0+WNBU/lvXItiyZmU25fXKMGWTixj19I5r
   g==;
X-CSE-ConnectionGUID: uXlfasgiTw68Ghq9Cl/XDg==
X-CSE-MsgGUID: A+yBgrpES6OjNBcDPEPBtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37931018"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="37931018"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:31:21 -0800
X-CSE-ConnectionGUID: ZbtP1u1ATU2Rh9rxK8sO3g==
X-CSE-MsgGUID: fkWqezzxSRCK6p5TN/KP/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95751434"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Dec 2024 20:31:19 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVQS-0003ry-0U;
	Mon, 09 Dec 2024 04:31:16 +0000
Date: Mon, 9 Dec 2024 12:30:50 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: include/asm-generic/io.h:733:14: error: call to 'insw' declared with
 attribute error: insw() requires HAS_IOPORT
Message-ID: <202412080511.ORVinTDs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7503345ac5f5e82fd9a36d6e6b447c016376403a
commit: 6f043e75744596968b6547c4bd43e4d30bbb6d6e asm-generic/io.h: Remove I/O port accessors for HAS_IOPORT=n
date:   6 weeks ago
config: m68k-randconfig-r062-20241208 (https://download.01.org/0day-ci/archive/20241208/202412080511.ORVinTDs-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241208/202412080511.ORVinTDs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412080511.ORVinTDs-lkp@intel.com/

All errors (new ones prefixed by >>):

   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     542 | #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
     643 | #define inb _inb
         |             ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:25: note: in expansion of macro 'inb'
     131 | #define ei_inb          inb
         |                         ^~~
   drivers/net/ethernet/8390/mcf8390.c:163:17: note: in expansion of macro 'ei_inb'
     163 |         while ((ei_inb(addr + NE_EN0_ISR) & ENISR_RESET) == 0) {
         |                 ^~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:170:9: note: in expansion of macro 'ei_outb'
     170 |         ei_outb(ENISR_RESET, addr + NE_EN0_ISR);
         |         ^~~~~~~
   drivers/net/ethernet/8390/mcf8390.c: In function 'mcf8390_get_8390_hdr':
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:201:9: note: in expansion of macro 'ei_outb'
     201 |         ei_outb(E8390_NODMA + E8390_PAGE0 + E8390_START, addr + NE_CMD);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:202:9: note: in expansion of macro 'ei_outb'
     202 |         ei_outb(ENISR_RDC, addr + NE_EN0_ISR);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:203:9: note: in expansion of macro 'ei_outb'
     203 |         ei_outb(sizeof(struct e8390_pkt_hdr), addr + NE_EN0_RCNTLO);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:204:9: note: in expansion of macro 'ei_outb'
     204 |         ei_outb(0, addr + NE_EN0_RCNTHI);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:205:9: note: in expansion of macro 'ei_outb'
     205 |         ei_outb(0, addr + NE_EN0_RSARLO);               /* On page boundary */
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:206:9: note: in expansion of macro 'ei_outb'
     206 |         ei_outb(ring_page, addr + NE_EN0_RSARHI);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:207:9: note: in expansion of macro 'ei_outb'
     207 |         ei_outb(E8390_RREAD + E8390_START, addr + NE_CMD);
         |         ^~~~~~~
>> include/asm-generic/io.h:733:14: error: call to 'insw' declared with attribute error: insw() requires HAS_IOPORT
     733 | #define insw insw
   drivers/net/ethernet/8390/mcf8390.c:134:25: note: in expansion of macro 'insw'
     134 | #define ei_insw         insw
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:209:9: note: in expansion of macro 'ei_insw'
     209 |         ei_insw(addr + NE_DATAPORT, hdr, sizeof(struct e8390_pkt_hdr) >> 1);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:211:9: note: in expansion of macro 'outb'
     211 |         outb(ENISR_RDC, addr + NE_EN0_ISR);     /* Ack intr */
         |         ^~~~
   drivers/net/ethernet/8390/mcf8390.c: In function 'mcf8390_block_input':
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:237:9: note: in expansion of macro 'ei_outb'
     237 |         ei_outb(E8390_NODMA + E8390_PAGE0 + E8390_START, addr + NE_CMD);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:238:9: note: in expansion of macro 'ei_outb'
     238 |         ei_outb(ENISR_RDC, addr + NE_EN0_ISR);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:239:9: note: in expansion of macro 'ei_outb'
     239 |         ei_outb(count & 0xff, addr + NE_EN0_RCNTLO);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:240:9: note: in expansion of macro 'ei_outb'
     240 |         ei_outb(count >> 8, addr + NE_EN0_RCNTHI);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:241:9: note: in expansion of macro 'ei_outb'
     241 |         ei_outb(ring_offset & 0xff, addr + NE_EN0_RSARLO);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:242:9: note: in expansion of macro 'ei_outb'
     242 |         ei_outb(ring_offset >> 8, addr + NE_EN0_RSARHI);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:243:9: note: in expansion of macro 'ei_outb'
     243 |         ei_outb(E8390_RREAD + E8390_START, addr + NE_CMD);
         |         ^~~~~~~
>> include/asm-generic/io.h:733:14: error: call to 'insw' declared with attribute error: insw() requires HAS_IOPORT
     733 | #define insw insw
   drivers/net/ethernet/8390/mcf8390.c:134:25: note: in expansion of macro 'insw'
     134 | #define ei_insw         insw
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:245:9: note: in expansion of macro 'ei_insw'
     245 |         ei_insw(addr + NE_DATAPORT, buf, count >> 1);
         |         ^~~~~~~
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     542 | #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
     643 | #define inb _inb
         |             ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:25: note: in expansion of macro 'inb'
     131 | #define ei_inb          inb
         |                         ^~~
   drivers/net/ethernet/8390/mcf8390.c:247:34: note: in expansion of macro 'ei_inb'
     247 |                 buf[count - 1] = ei_inb(addr + NE_DATAPORT);
         |                                  ^~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:249:9: note: in expansion of macro 'ei_outb'
     249 |         ei_outb(ENISR_RDC, addr + NE_EN0_ISR);  /* Ack intr */
         |         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c: In function '__NS8390_init':
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:25: note: in expansion of macro 'ei_outb'
     141 | #define ei_outb_p       ei_outb
         |                         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1025:9: note: in expansion of macro 'ei_outb_p'
    1025 |         ei_outb_p(E8390_NODMA+E8390_PAGE0+E8390_STOP, e8390_base+E8390_CMD); /* 0x21 */
         |         ^~~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:25: note: in expansion of macro 'ei_outb'
     141 | #define ei_outb_p       ei_outb
         |                         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1026:9: note: in expansion of macro 'ei_outb_p'
    1026 |         ei_outb_p(endcfg, e8390_base + EN0_DCFG);       /* 0x48 or 0x49 */
         |         ^~~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:25: note: in expansion of macro 'ei_outb'
     141 | #define ei_outb_p       ei_outb
         |                         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1028:9: note: in expansion of macro 'ei_outb_p'
    1028 |         ei_outb_p(0x00,  e8390_base + EN0_RCNTLO);
         |         ^~~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:25: note: in expansion of macro 'ei_outb'
     141 | #define ei_outb_p       ei_outb
         |                         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1029:9: note: in expansion of macro 'ei_outb_p'
    1029 |         ei_outb_p(0x00,  e8390_base + EN0_RCNTHI);
         |         ^~~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:25: note: in expansion of macro 'ei_outb'
     141 | #define ei_outb_p       ei_outb
         |                         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1031:9: note: in expansion of macro 'ei_outb_p'
    1031 |         ei_outb_p(E8390_RXOFF, e8390_base + EN0_RXCR); /* 0x20 */
         |         ^~~~~~~~~
--
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:25: note: in expansion of macro 'ei_outb'
     141 | #define ei_outb_p       ei_outb
         |                         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1065:17: note: in expansion of macro 'ei_outb_p'
    1065 |                 ei_outb_p(E8390_TXCONFIG, e8390_base + EN0_TXCR); /* xmit on. */
         |                 ^~~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:25: note: in expansion of macro 'ei_outb'
     141 | #define ei_outb_p       ei_outb
         |                         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:1067:17: note: in expansion of macro 'ei_outb_p'
    1067 |                 ei_outb_p(E8390_RXCONFIG, e8390_base + EN0_RXCR); /* rx on,  */
         |                 ^~~~~~~~~
   drivers/net/ethernet/8390/mcf8390.c: In function 'mcf8390_block_output':
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:272:9: note: in expansion of macro 'ei_outb'
     272 |         ei_outb(E8390_PAGE0 + E8390_START + E8390_NODMA, addr + NE_CMD);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:274:9: note: in expansion of macro 'ei_outb'
     274 |         ei_outb(ENISR_RDC, addr + NE_EN0_ISR);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:277:9: note: in expansion of macro 'ei_outb'
     277 |         ei_outb(count & 0xff, addr + NE_EN0_RCNTLO);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:278:9: note: in expansion of macro 'ei_outb'
     278 |         ei_outb(count >> 8, addr + NE_EN0_RCNTHI);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:279:9: note: in expansion of macro 'ei_outb'
     279 |         ei_outb(0x00, addr + NE_EN0_RSARLO);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:280:9: note: in expansion of macro 'ei_outb'
     280 |         ei_outb(start_page, addr + NE_EN0_RSARHI);
         |         ^~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:281:9: note: in expansion of macro 'ei_outb'
     281 |         ei_outb(E8390_RWRITE + E8390_START, addr + NE_CMD);
         |         ^~~~~~~
>> include/asm-generic/io.h:773:15: error: call to 'outsw' declared with attribute error: outsw() requires HAS_IOPORT
     773 | #define outsw outsw
   drivers/net/ethernet/8390/mcf8390.c:136:25: note: in expansion of macro 'outsw'
     136 | #define ei_outsw        outsw
         |                         ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:283:9: note: in expansion of macro 'ei_outsw'
     283 |         ei_outsw(addr + NE_DATAPORT, buf, count >> 1);
         |         ^~~~~~~~
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     542 | #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
     643 | #define inb _inb
         |             ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:25: note: in expansion of macro 'inb'
     131 | #define ei_inb          inb
         |                         ^~~
   drivers/net/ethernet/8390/mcf8390.c:286:17: note: in expansion of macro 'ei_inb'
     286 |         while ((ei_inb(addr + NE_EN0_ISR) & ENISR_RDC) == 0) {
         |                 ^~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:295:9: note: in expansion of macro 'ei_outb'
     295 |         ei_outb(ENISR_RDC, addr + NE_EN0_ISR);  /* Ack intr */
         |         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c: In function '__ei_start_xmit':
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:25: note: in expansion of macro 'ei_outb'
     141 | #define ei_outb_p       ei_outb
         |                         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:325:9: note: in expansion of macro 'ei_outb_p'
     325 |         ei_outb_p(0x00, e8390_base + EN0_IMR);
         |         ^~~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:25: note: in expansion of macro 'ei_outb'
     141 | #define ei_outb_p       ei_outb
         |                         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:369:17: note: in expansion of macro 'ei_outb_p'
     369 |                 ei_outb_p(ENISR_ALL, e8390_base + EN0_IMR);
         |                 ^~~~~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:25: note: in expansion of macro 'ei_outb'
     141 | #define ei_outb_p       ei_outb
         |                         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:404:9: note: in expansion of macro 'ei_outb_p'
     404 |         ei_outb_p(ENISR_ALL, e8390_base + EN0_IMR);
         |         ^~~~~~~~~
   drivers/net/ethernet/8390/lib8390.c: In function 'ei_tx_intr':
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     542 | #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
     643 | #define inb _inb
         |             ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:25: note: in expansion of macro 'inb'
     131 | #define ei_inb          inb
         |                         ^~~
   drivers/net/ethernet/8390/lib8390.c:583:22: note: in expansion of macro 'ei_inb'
     583 |         int status = ei_inb(e8390_base + EN0_TSR);
         |                      ^~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:141:25: note: in expansion of macro 'ei_outb'
     141 | #define ei_outb_p       ei_outb
         |                         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c:585:9: note: in expansion of macro 'ei_outb_p'
     585 |         ei_outb_p(ENISR_TX, e8390_base + EN0_ISR); /* Ack intr. */
         |         ^~~~~~~~~
   drivers/net/ethernet/8390/lib8390.c: In function '__ei_tx_timeout':
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT


vim +/insw +733 include/asm-generic/io.h

f009c89df79abe John Garry      2020-03-28  653  
f009c89df79abe John Garry      2020-03-28  654  #ifndef outb
f009c89df79abe John Garry      2020-03-28 @655  #define outb _outb
f009c89df79abe John Garry      2020-03-28  656  #endif
f009c89df79abe John Garry      2020-03-28  657  
f009c89df79abe John Garry      2020-03-28  658  #ifndef outw
f009c89df79abe John Garry      2020-03-28  659  #define outw _outw
f009c89df79abe John Garry      2020-03-28  660  #endif
f009c89df79abe John Garry      2020-03-28  661  
f009c89df79abe John Garry      2020-03-28  662  #ifndef outl
f009c89df79abe John Garry      2020-03-28  663  #define outl _outl
f009c89df79abe John Garry      2020-03-28  664  #endif
f009c89df79abe John Garry      2020-03-28  665  
9216efafc52ff9 Thierry Reding  2014-10-01  666  #ifndef inb_p
9216efafc52ff9 Thierry Reding  2014-10-01  667  #define inb_p inb_p
9216efafc52ff9 Thierry Reding  2014-10-01  668  static inline u8 inb_p(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  669  {
9216efafc52ff9 Thierry Reding  2014-10-01  670  	return inb(addr);
9216efafc52ff9 Thierry Reding  2014-10-01  671  }
9216efafc52ff9 Thierry Reding  2014-10-01  672  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  673  
9216efafc52ff9 Thierry Reding  2014-10-01  674  #ifndef inw_p
9216efafc52ff9 Thierry Reding  2014-10-01  675  #define inw_p inw_p
9216efafc52ff9 Thierry Reding  2014-10-01  676  static inline u16 inw_p(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  677  {
9216efafc52ff9 Thierry Reding  2014-10-01  678  	return inw(addr);
9216efafc52ff9 Thierry Reding  2014-10-01  679  }
9216efafc52ff9 Thierry Reding  2014-10-01  680  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  681  
9216efafc52ff9 Thierry Reding  2014-10-01  682  #ifndef inl_p
9216efafc52ff9 Thierry Reding  2014-10-01  683  #define inl_p inl_p
9216efafc52ff9 Thierry Reding  2014-10-01  684  static inline u32 inl_p(unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  685  {
9216efafc52ff9 Thierry Reding  2014-10-01  686  	return inl(addr);
9216efafc52ff9 Thierry Reding  2014-10-01  687  }
9216efafc52ff9 Thierry Reding  2014-10-01  688  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  689  
9216efafc52ff9 Thierry Reding  2014-10-01  690  #ifndef outb_p
9216efafc52ff9 Thierry Reding  2014-10-01  691  #define outb_p outb_p
9216efafc52ff9 Thierry Reding  2014-10-01  692  static inline void outb_p(u8 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  693  {
9216efafc52ff9 Thierry Reding  2014-10-01  694  	outb(value, addr);
9216efafc52ff9 Thierry Reding  2014-10-01  695  }
9216efafc52ff9 Thierry Reding  2014-10-01  696  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  697  
9216efafc52ff9 Thierry Reding  2014-10-01  698  #ifndef outw_p
9216efafc52ff9 Thierry Reding  2014-10-01  699  #define outw_p outw_p
9216efafc52ff9 Thierry Reding  2014-10-01  700  static inline void outw_p(u16 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  701  {
9216efafc52ff9 Thierry Reding  2014-10-01  702  	outw(value, addr);
9216efafc52ff9 Thierry Reding  2014-10-01  703  }
9216efafc52ff9 Thierry Reding  2014-10-01  704  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  705  
9216efafc52ff9 Thierry Reding  2014-10-01  706  #ifndef outl_p
9216efafc52ff9 Thierry Reding  2014-10-01  707  #define outl_p outl_p
9216efafc52ff9 Thierry Reding  2014-10-01  708  static inline void outl_p(u32 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  709  {
9216efafc52ff9 Thierry Reding  2014-10-01  710  	outl(value, addr);
9216efafc52ff9 Thierry Reding  2014-10-01  711  }
9216efafc52ff9 Thierry Reding  2014-10-01  712  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  713  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  714  /*
9ab3a7a0d2b417 Thierry Reding  2014-07-04  715   * {in,out}s{b,w,l}{,_p}() are variants of the above that repeatedly access a
9ab3a7a0d2b417 Thierry Reding  2014-07-04  716   * single I/O port multiple times.
9ab3a7a0d2b417 Thierry Reding  2014-07-04  717   */
9ab3a7a0d2b417 Thierry Reding  2014-07-04  718  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  719  #ifndef insb
9ab3a7a0d2b417 Thierry Reding  2014-07-04  720  #define insb insb
6f043e75744596 Niklas Schnelle 2024-10-24  721  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  722  static inline void insb(unsigned long addr, void *buffer, unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  723  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  724  	readsb(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  725  }
6f043e75744596 Niklas Schnelle 2024-10-24  726  #else
6f043e75744596 Niklas Schnelle 2024-10-24  727  void insb(unsigned long addr, void *buffer, unsigned int count)
6f043e75744596 Niklas Schnelle 2024-10-24  728  	__compiletime_error("insb() requires HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  729  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  730  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  731  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  732  #ifndef insw
9ab3a7a0d2b417 Thierry Reding  2014-07-04 @733  #define insw insw
6f043e75744596 Niklas Schnelle 2024-10-24  734  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  735  static inline void insw(unsigned long addr, void *buffer, unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  736  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  737  	readsw(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  738  }
6f043e75744596 Niklas Schnelle 2024-10-24  739  #else
6f043e75744596 Niklas Schnelle 2024-10-24  740  void insw(unsigned long addr, void *buffer, unsigned int count)
6f043e75744596 Niklas Schnelle 2024-10-24  741  	__compiletime_error("insw() requires HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  742  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  743  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  744  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  745  #ifndef insl
9ab3a7a0d2b417 Thierry Reding  2014-07-04  746  #define insl insl
6f043e75744596 Niklas Schnelle 2024-10-24  747  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  748  static inline void insl(unsigned long addr, void *buffer, unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  749  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  750  	readsl(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  751  }
6f043e75744596 Niklas Schnelle 2024-10-24  752  #else
6f043e75744596 Niklas Schnelle 2024-10-24  753  void insl(unsigned long addr, void *buffer, unsigned int count)
6f043e75744596 Niklas Schnelle 2024-10-24  754  	__compiletime_error("insl() requires HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  755  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  756  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  757  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  758  #ifndef outsb
9ab3a7a0d2b417 Thierry Reding  2014-07-04  759  #define outsb outsb
6f043e75744596 Niklas Schnelle 2024-10-24  760  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  761  static inline void outsb(unsigned long addr, const void *buffer,
9ab3a7a0d2b417 Thierry Reding  2014-07-04  762  			 unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  763  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  764  	writesb(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  765  }
6f043e75744596 Niklas Schnelle 2024-10-24  766  #else
6f043e75744596 Niklas Schnelle 2024-10-24  767  void outsb(unsigned long addr, const void *buffer, unsigned int count)
6f043e75744596 Niklas Schnelle 2024-10-24  768  	__compiletime_error("outsb() requires HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  769  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  770  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  771  
9ab3a7a0d2b417 Thierry Reding  2014-07-04  772  #ifndef outsw
9ab3a7a0d2b417 Thierry Reding  2014-07-04 @773  #define outsw outsw
6f043e75744596 Niklas Schnelle 2024-10-24  774  #ifdef CONFIG_HAS_IOPORT
9ab3a7a0d2b417 Thierry Reding  2014-07-04  775  static inline void outsw(unsigned long addr, const void *buffer,
9ab3a7a0d2b417 Thierry Reding  2014-07-04  776  			 unsigned int count)
9ab3a7a0d2b417 Thierry Reding  2014-07-04  777  {
9ab3a7a0d2b417 Thierry Reding  2014-07-04  778  	writesw(PCI_IOBASE + addr, buffer, count);
9ab3a7a0d2b417 Thierry Reding  2014-07-04  779  }
6f043e75744596 Niklas Schnelle 2024-10-24  780  #else
6f043e75744596 Niklas Schnelle 2024-10-24  781  void outsw(unsigned long addr, const void *buffer, unsigned int count)
6f043e75744596 Niklas Schnelle 2024-10-24  782  	__compiletime_error("outsw() requires HAS_IOPORT");
6f043e75744596 Niklas Schnelle 2024-10-24  783  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  784  #endif
9ab3a7a0d2b417 Thierry Reding  2014-07-04  785  

:::::: The code at line 733 was first introduced by commit
:::::: 9ab3a7a0d2b417773e8e8a880fc3a69f7fc1f57a asm-generic/io.h: Implement generic {read,write}s*()

:::::: TO: Thierry Reding <treding@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

