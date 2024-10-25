Return-Path: <linux-kernel+bounces-382688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33A09B121F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D551F2279C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F3720C32A;
	Fri, 25 Oct 2024 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9D7wOcY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149B213125
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893577; cv=none; b=erTRyazwzIRM6Ezx01Q5j7xwZ5yLrObdS+RnrUZUaBH0b0DyLN0ud7Hrhc4rIQ2XLttV+kAkRXn5A9pDWumvLxFTxblMmawYQT9ex8L562ACtuy+gwgaQc8V1aWrOkqNwYdRX1imv/yrdvbHjTW5kC0JlGmcy4TLZiSKL4cOvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893577; c=relaxed/simple;
	bh=ery+KxW6fm5rZa03YvTOQEw7C5lkB13jeS40iRnsmy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0O7oFBYAc3bbvRgFXJoxU5xEJJK4jtHnWHOUSXSksdam2iuGZfcVvTj2X5rB5hiDTBQVdA0zYry2rmcOyR310Ef7wUPk5cFCokxYiuiHL7RC+kLQHYbB3dmHT/ODYEAV2/Cgl5ilg5g8R5hQTkDAYyrfVDDcctVZOxwg46v5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9D7wOcY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729893574; x=1761429574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ery+KxW6fm5rZa03YvTOQEw7C5lkB13jeS40iRnsmy4=;
  b=W9D7wOcYUCFXPAUQpd19ys9VXbE+fa8DrLsv4MBS4gUolKYRAMm96X6S
   wJWFsc7qYEhYBLqNaoI60V+Aszg1PbcCKj/FhD2/qlt1p8WnUX0InDtoY
   7PnlaZO7g0AFhVJXs1E5cYWDYWGjPqdN2wEesF6+gHp6qgKtilDG4/LB0
   vJAj1NzEzNmbVNFbSS1OXscxV+vjDKPEFAWg6whqexNKbdY5FR4SIqCwE
   TLB+2r/SJOr3Op6E0/+hqVCPxCX3Xq5wEi7KI/OObClRcWFdrqkhzh5tC
   UjNIe/9a3J8GYYzDuV0qv5whukIxO/AEAXLDTXfkbYKUqMtNNIHz4FTKk
   A==;
X-CSE-ConnectionGUID: EbxS922GRSOqPZMiwan4vw==
X-CSE-MsgGUID: kXV9EqweS++WzLfSVgE0uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40965945"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40965945"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 14:59:34 -0700
X-CSE-ConnectionGUID: TGqJ7OmNQWO5dcD3G6GzyQ==
X-CSE-MsgGUID: VsgAOv6YSSuYpNfGbtA9FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="80686025"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Oct 2024 14:59:31 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4SLB-000Ywc-2h;
	Fri, 25 Oct 2024 21:59:29 +0000
Date: Sat, 26 Oct 2024 05:58:37 +0800
From: kernel test robot <lkp@intel.com>
To: 412574090@163.com, sudipm.mukherjee@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn, weiyufeng <weiyufeng@kylinos.cn>
Subject: Re: [PATCH 2/4] parport: change struct parport member to iobase
Message-ID: <202410260507.aPp3LOTd-lkp@intel.com>
References: <20241025082128.60034-2-412574090@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025082128.60034-2-412574090@163.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc4 next-20241025]
[cannot apply to deller-parisc/for-next mkp-scsi/for-next jejb-scsi/for-next tiwai-sound/for-next tiwai-sound/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/412574090-163-com/parport-change-struct-parport-member-to-iobase/20241025-162302
base:   linus/master
patch link:    https://lore.kernel.org/r/20241025082128.60034-2-412574090%40163.com
patch subject: [PATCH 2/4] parport: change struct parport member to iobase
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241026/202410260507.aPp3LOTd-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260507.aPp3LOTd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260507.aPp3LOTd-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/parport/parport_mfc3.c: In function 'mfc3_write_data':
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:84:17: note: in expansion of macro 'pia'
      84 |         dummy = pia(p)->pprb; /* clears irq bit */
         |                 ^~~
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:86:9: note: in expansion of macro 'pia'
      86 |         pia(p)->pprb = data;
         |         ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_read_data':
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:92:16: note: in expansion of macro 'pia'
      92 |         return pia(p)->pprb;
         |                ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_write_control':
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:126:9: note: in expansion of macro 'pia'
     126 |         pia(p)->ppra = (pia(p)->ppra & 0x1f) | control_pc_to_mfc3(control);
         |         ^~~
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:126:25: note: in expansion of macro 'pia'
     126 |         pia(p)->ppra = (pia(p)->ppra & 0x1f) | control_pc_to_mfc3(control);
         |                         ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_read_control':
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:132:35: note: in expansion of macro 'pia'
     132 |         return control_mfc3_to_pc(pia(p)->ppra & 0xe0);
         |                                   ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_read_status':
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:167:36: note: in expansion of macro 'pia'
     167 |         status = status_mfc3_to_pc(pia(p)->ppra & 0x1f);
         |                                    ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_interrupt':
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:180:29: note: in expansion of macro 'pia'
     180 |                         if (pia(this_port[i])->crb & 128) { /* Board caused interrupt */
         |                             ^~~
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:181:41: note: in expansion of macro 'pia'
     181 |                                 dummy = pia(this_port[i])->pprb; /* clear irq bit */
         |                                         ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_enable_irq':
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:189:9: note: in expansion of macro 'pia'
     189 |         pia(p)->crb |= PIA_C1_ENABLE_IRQ;
         |         ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_disable_irq':
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:194:9: note: in expansion of macro 'pia'
     194 |         pia(p)->crb &= ~PIA_C1_ENABLE_IRQ;
         |         ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_data_forward':
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:200:9: note: in expansion of macro 'pia'
     200 |         pia(p)->crb &= ~PIA_DDR; /* make data direction register visible */
         |         ^~~
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:201:9: note: in expansion of macro 'pia'
     201 |         pia(p)->pddrb = 255; /* all pins output */
         |         ^~~
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:202:9: note: in expansion of macro 'pia'
     202 |         pia(p)->crb |= PIA_DDR; /* make data register visible - default */
         |         ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_data_reverse':
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:208:9: note: in expansion of macro 'pia'
     208 |         pia(p)->crb &= ~PIA_DDR; /* make data direction register visible */
         |         ^~~
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:209:9: note: in expansion of macro 'pia'
     209 |         pia(p)->pddrb = 0; /* all pins input */
         |         ^~~
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:210:9: note: in expansion of macro 'pia'
     210 |         pia(p)->crb |= PIA_DDR; /* make data register visible - default */
         |         ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_save_state':
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:223:27: note: in expansion of macro 'pia'
     223 |         s->u.amiga.data = pia(p)->pprb;
         |                           ^~~
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:224:9: note: in expansion of macro 'pia'
     224 |         pia(p)->crb &= ~PIA_DDR;
         |         ^~~
>> drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:225:30: note: in expansion of macro 'pia'
     225 |         s->u.amiga.datadir = pia(p)->pddrb;
         |                              ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:226:9: note: in expansion of macro 'pia'
     226 |         pia(p)->crb |= PIA_DDR;
         |         ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:227:29: note: in expansion of macro 'pia'
     227 |         s->u.amiga.status = pia(p)->ppra;
         |                             ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:228:9: note: in expansion of macro 'pia'
     228 |         pia(p)->cra &= ~PIA_DDR;
         |         ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:229:32: note: in expansion of macro 'pia'
     229 |         s->u.amiga.statusdir = pia(p)->pddrb;
         |                                ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:230:9: note: in expansion of macro 'pia'
     230 |         pia(p)->cra |= PIA_DDR;
         |         ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_restore_state':
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:235:9: note: in expansion of macro 'pia'
     235 |         pia(p)->pprb = s->u.amiga.data;
         |         ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:236:9: note: in expansion of macro 'pia'
     236 |         pia(p)->crb &= ~PIA_DDR;
         |         ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:237:9: note: in expansion of macro 'pia'
     237 |         pia(p)->pddrb = s->u.amiga.datadir;
         |         ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:238:9: note: in expansion of macro 'pia'
     238 |         pia(p)->crb |= PIA_DDR;
         |         ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:239:9: note: in expansion of macro 'pia'
     239 |         pia(p)->ppra = s->u.amiga.status;
         |         ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:240:9: note: in expansion of macro 'pia'
     240 |         pia(p)->cra &= ~PIA_DDR;
         |         ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:241:9: note: in expansion of macro 'pia'
     241 |         pia(p)->pddrb = s->u.amiga.statusdir;
         |         ^~~
   drivers/parport/parport_mfc3.c:77:39: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
      77 | #define pia(dev) ((struct pia *)(dev->base))
         |                                       ^~~~
   drivers/parport/parport_mfc3.c:242:9: note: in expansion of macro 'pia'
     242 |         pia(p)->cra |= PIA_DDR;
         |         ^~~
   drivers/parport/parport_mfc3.c: In function 'mfc3_read_control':
   drivers/parport/parport_mfc3.c:133:1: warning: control reaches end of non-void function [-Wreturn-type]
     133 | }
         | ^
   drivers/parport/parport_mfc3.c: In function 'mfc3_read_data':
   drivers/parport/parport_mfc3.c:93:1: warning: control reaches end of non-void function [-Wreturn-type]
      93 | }
         | ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +77 drivers/parport/parport_mfc3.c

^1da177e4c3f41 Linus Torvalds 2005-04-16   76  
^1da177e4c3f41 Linus Torvalds 2005-04-16  @77  #define pia(dev) ((struct pia *)(dev->base))
^1da177e4c3f41 Linus Torvalds 2005-04-16   78  static struct parport_operations pp_mfc3_ops;
^1da177e4c3f41 Linus Torvalds 2005-04-16   79  
^1da177e4c3f41 Linus Torvalds 2005-04-16   80  static void mfc3_write_data(struct parport *p, unsigned char data)
^1da177e4c3f41 Linus Torvalds 2005-04-16   81  {
46aea0d41cf836 Joe Perches    2020-04-03   82  	pr_debug("write_data %c\n", data);
^1da177e4c3f41 Linus Torvalds 2005-04-16   83  
^1da177e4c3f41 Linus Torvalds 2005-04-16   84  	dummy = pia(p)->pprb; /* clears irq bit */
^1da177e4c3f41 Linus Torvalds 2005-04-16   85  	/* Triggers also /STROBE.*/
^1da177e4c3f41 Linus Torvalds 2005-04-16   86  	pia(p)->pprb = data;
^1da177e4c3f41 Linus Torvalds 2005-04-16   87  }
^1da177e4c3f41 Linus Torvalds 2005-04-16   88  
^1da177e4c3f41 Linus Torvalds 2005-04-16   89  static unsigned char mfc3_read_data(struct parport *p)
^1da177e4c3f41 Linus Torvalds 2005-04-16   90  {
^1da177e4c3f41 Linus Torvalds 2005-04-16   91  	/* clears interrupt bit. Triggers also /STROBE. */
^1da177e4c3f41 Linus Torvalds 2005-04-16   92  	return pia(p)->pprb;
^1da177e4c3f41 Linus Torvalds 2005-04-16   93  }
^1da177e4c3f41 Linus Torvalds 2005-04-16   94  
^1da177e4c3f41 Linus Torvalds 2005-04-16   95  static unsigned char control_pc_to_mfc3(unsigned char control)
^1da177e4c3f41 Linus Torvalds 2005-04-16   96  {
^1da177e4c3f41 Linus Torvalds 2005-04-16   97  	unsigned char ret = 32|64;
^1da177e4c3f41 Linus Torvalds 2005-04-16   98  
^1da177e4c3f41 Linus Torvalds 2005-04-16   99  	if (control & PARPORT_CONTROL_SELECT) /* XXX: What is SELECP? */
^1da177e4c3f41 Linus Torvalds 2005-04-16  100  		ret &= ~32; /* /SELECT_IN */
^1da177e4c3f41 Linus Torvalds 2005-04-16  101  	if (control & PARPORT_CONTROL_INIT) /* INITP */
^1da177e4c3f41 Linus Torvalds 2005-04-16  102  		ret |= 128;
^1da177e4c3f41 Linus Torvalds 2005-04-16  103  	if (control & PARPORT_CONTROL_AUTOFD) /* AUTOLF */
^1da177e4c3f41 Linus Torvalds 2005-04-16  104  		ret &= ~64;
1d6b84d29779f8 Arnd Bergmann  2024-04-05  105  	/* PARPORT_CONTROL_STROBE handled directly by hardware */
^1da177e4c3f41 Linus Torvalds 2005-04-16  106  	return ret;
^1da177e4c3f41 Linus Torvalds 2005-04-16  107  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  108  
^1da177e4c3f41 Linus Torvalds 2005-04-16  109  static unsigned char control_mfc3_to_pc(unsigned char control)
^1da177e4c3f41 Linus Torvalds 2005-04-16  110  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  111  	unsigned char ret = PARPORT_CONTROL_STROBE 
^1da177e4c3f41 Linus Torvalds 2005-04-16  112  			  | PARPORT_CONTROL_AUTOFD | PARPORT_CONTROL_SELECT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  113  
^1da177e4c3f41 Linus Torvalds 2005-04-16  114  	if (control & 128) /* /INITP */
^1da177e4c3f41 Linus Torvalds 2005-04-16  115  		ret |= PARPORT_CONTROL_INIT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  116  	if (control & 64) /* /AUTOLF */
^1da177e4c3f41 Linus Torvalds 2005-04-16  117  		ret &= ~PARPORT_CONTROL_AUTOFD;
^1da177e4c3f41 Linus Torvalds 2005-04-16  118  	if (control & 32) /* /SELECT_IN */
^1da177e4c3f41 Linus Torvalds 2005-04-16  119  		ret &= ~PARPORT_CONTROL_SELECT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  120  	return ret;
^1da177e4c3f41 Linus Torvalds 2005-04-16  121  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  122  
^1da177e4c3f41 Linus Torvalds 2005-04-16  123  static void mfc3_write_control(struct parport *p, unsigned char control)
^1da177e4c3f41 Linus Torvalds 2005-04-16  124  {
46aea0d41cf836 Joe Perches    2020-04-03  125  	pr_debug("write_control %02x\n", control);
^1da177e4c3f41 Linus Torvalds 2005-04-16  126  	pia(p)->ppra = (pia(p)->ppra & 0x1f) | control_pc_to_mfc3(control);
^1da177e4c3f41 Linus Torvalds 2005-04-16  127  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  128  	
^1da177e4c3f41 Linus Torvalds 2005-04-16  129  static unsigned char mfc3_read_control( struct parport *p)
^1da177e4c3f41 Linus Torvalds 2005-04-16  130  {
46aea0d41cf836 Joe Perches    2020-04-03  131  	pr_debug("read_control\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  132  	return control_mfc3_to_pc(pia(p)->ppra & 0xe0);
^1da177e4c3f41 Linus Torvalds 2005-04-16 @133  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  134  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

