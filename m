Return-Path: <linux-kernel+bounces-547975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F30A53E51
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1657A375B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C301205E23;
	Wed,  5 Mar 2025 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzI5gVwx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44E1F1913
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216794; cv=none; b=kQ5gFEU6ealr4vZpIDU72WcB761g2PLCz9QDHiiW5BwaN1faB02tZG5ASOyJctWqxzhjjzA/xRFQqavoRsdb9I6jnDEgaQ0nqpL2Qx2jgkpKRdRRzIYqi7w66EVhrcUp0QWS+kRLQZ8R1F7PAsEYLZo1eHAMI5LVD8T2P8PKy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216794; c=relaxed/simple;
	bh=Q5HVKn6cT6uI02sCOFu9ushar7IdMFCypXRgB+UfAtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ctdg5iSDBwqrWw4s74WyhIYpKrhyTg1mZLKbb3go6vUz3ySmyGECGtc56QkXgawulk5EnR+1wkfrjmrelR3vfwh02MueJ7ozpgR+AaN2VrGh5v63ngT2FxL3xE996g29Cj2wzZDf1ze5m14TpPLrAUdMVoqmexOSFLL33CjcD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzI5gVwx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741216791; x=1772752791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q5HVKn6cT6uI02sCOFu9ushar7IdMFCypXRgB+UfAtU=;
  b=KzI5gVwxoIlXoOSZjZk41LXiWTN4GY3d+NZ/4JZ5qXI/B/kMR87HPykm
   qjVLO83uaaI0woW+8D+y8IAKDXXRklaIQHfezTn0/Y/40bSoqFrbGQC7R
   IRnScGKujlj4Qoz9VkGwP/mKAyY5q6i4YyrtEK6FG+SmP10VTe5wuwmZM
   xozXSmMUrDMSHiFXsTCOQWv6pY2NKa/jFRcA1X+UJxYvkpNvMW+Vg1yZP
   fDxt+7NhHRIjQIuWSMKQvT3B5L+4RhAfyy5wqZo5KrmLPDOE6xzWR9RQx
   /XcIK7tTSqC9L4nBLvTJUJ4VZs8bG5wIcKyuV6NUtWK1DoHGkSu/stm3f
   g==;
X-CSE-ConnectionGUID: 1rUaa7F9SjqNVUkm9PcboA==
X-CSE-MsgGUID: SAsc560YS9KsjswvW5F39g==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="64650146"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="64650146"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:19:50 -0800
X-CSE-ConnectionGUID: GY628nnUQdKCoGaAfUWqYg==
X-CSE-MsgGUID: 5+3ZVNaTQue3dIo1irgNpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119341243"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 05 Mar 2025 15:19:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpy1i-000MJC-00;
	Wed, 05 Mar 2025 23:19:46 +0000
Date: Thu, 6 Mar 2025 07:19:24 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: include/asm-generic/io.h:733:14: error: call to 'insw' declared with
 attribute error: insw() requires HAS_IOPORT
Message-ID: <202503060721.FBBxPzYT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Niklas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   848e076317446f9c663771ddec142d7c2eb4cb43
commit: 6f043e75744596968b6547c4bd43e4d30bbb6d6e asm-generic/io.h: Remove I/O port accessors for HAS_IOPORT=n
date:   4 months ago
config: m68k-randconfig-r053-20250306 (https://download.01.org/0day-ci/archive/20250306/202503060721.FBBxPzYT-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503060721.FBBxPzYT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503060721.FBBxPzYT-lkp@intel.com/

All errors (new ones prefixed by >>):

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
   drivers/net/ethernet/8390/mcf8390.c: In function 'mcf8390_init':
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:355:25: note: in expansion of macro 'ei_outb'
     355 |                         ei_outb(program_seq[i].value,
         |                         ^~~~~~~
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     542 | #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
     643 | #define inb _inb
         |             ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:25: note: in expansion of macro 'inb'
     131 | #define ei_inb          inb
         |                         ^~~
   drivers/net/ethernet/8390/mcf8390.c:361:30: note: in expansion of macro 'ei_inb'
     361 |                 SA_prom[i] = ei_inb(addr + NE_DATAPORT);
         |                              ^~~~~~
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     542 | #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
     643 | #define inb _inb
         |             ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:25: note: in expansion of macro 'inb'
     131 | #define ei_inb          inb
         |                         ^~~
   drivers/net/ethernet/8390/mcf8390.c:362:17: note: in expansion of macro 'ei_inb'
     362 |                 ei_inb(addr + NE_DATAPORT);
         |                 ^~~~~~
   include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/net/ethernet/8390/mcf8390.c:132:25: note: in expansion of macro 'outb'
     132 | #define ei_outb         outb
         |                         ^~~~
   drivers/net/ethernet/8390/mcf8390.c:366:9: note: in expansion of macro 'ei_outb'
     366 |         ei_outb(0x49, addr + NE_EN0_DCFG);
         |         ^~~~~~~
   drivers/net/ethernet/8390/lib8390.c: In function 'ei_receive':
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
   drivers/net/ethernet/8390/lib8390.c:673:17: note: in expansion of macro 'ei_outb_p'
     673 |                 ei_outb_p(E8390_NODMA+E8390_PAGE1, e8390_base + E8390_CMD);
         |                 ^~~~~~~~~
   include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
     542 | #define _inb _inb
   include/asm-generic/io.h:643:13: note: in expansion of macro '_inb'
     643 | #define inb _inb
         |             ^~~~
   drivers/net/ethernet/8390/mcf8390.c:131:25: note: in expansion of macro 'inb'
     131 | #define ei_inb          inb
         |                         ^~~
   drivers/net/ethernet/8390/mcf8390.c:140:25: note: in expansion of macro 'ei_inb'
     140 | #define ei_inb_p        ei_inb
         |                         ^~~~~~


vim +/insw +733 include/asm-generic/io.h

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

