Return-Path: <linux-kernel+bounces-351779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 482BF9915E7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 12:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15C5B25502
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F1B1494DE;
	Sat,  5 Oct 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUllVojR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81106136337;
	Sat,  5 Oct 2024 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728123133; cv=none; b=urxa0I4dqINCMAzNfmMU904sdFWROmA3zd5w12GmPfvI4QFYsqrfxK1/pLyDM4q0JAjGZTGdr61n2bjayP/4umwncHdj43lMd0xIyKbfwBEjj72HRsoxd+a0W5RAgDbtbB2KLYoMBKBDieSIA/V1dVjcyOgxnFfpkigGeORTzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728123133; c=relaxed/simple;
	bh=CI77kQewLme6kjpyKd7vY6uErzaYvE1Weu1JnMCLcaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JttpZKtrFLqnLrUOA9hYnjrEYpC7sln0uQMMSXm9APO4stpK5lxyLLgN+vqLCw2Gd0cvgtLTle3fUj/zUDWjAFWqxS8x2XkxyLlrTVMU3DMPQ1tnSCaNJ6+ULHpAKZNTotD0XlyQvzE8qqCjwGTE4GJzkFIimPhJmyZARqEg2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUllVojR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728123132; x=1759659132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CI77kQewLme6kjpyKd7vY6uErzaYvE1Weu1JnMCLcaA=;
  b=HUllVojRhi+Aq9U5hD0oq2ZsLgCdpdk1T2gg8O7FXoqyQVWl0JoU+KPX
   B0gEOVvWqYOfQgBL6zVdaF/aoraFF6JTTKyn20RSH6REBX33BoJiNktXJ
   BRWiOvQH7eoclH8HmH6bnRYBLPIwMziagx1UCWjorkzmzAfzyzTcERaj0
   93K+vGx9CxoaQgdZEpQpwS7syBYp9+q7ssNhk1gx8SlsOoss2CkZicPOJ
   uHC3MEw/U3qsW5dOsiydo3YgB6radR6CS74QABvWJMzqaHZuRJXwO+sD4
   qqbMDDwFSV40+1au+8dCu0KzCqTcx7Qh5/slWUrqx3f1EVA4jjIz/SVLt
   w==;
X-CSE-ConnectionGUID: 6+UT7GU6TS6bB+d7DLlYmQ==
X-CSE-MsgGUID: vj5ZVkYBTOi5BtiapUW2Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="26839746"
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="26839746"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 03:12:08 -0700
X-CSE-ConnectionGUID: upDFbmVVSIGjMBpB0M290w==
X-CSE-MsgGUID: tgCoEkRuRhSz7ooS5kCXfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="105801602"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Oct 2024 03:12:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sx1lb-0002qO-13;
	Sat, 05 Oct 2024 10:12:03 +0000
Date: Sat, 5 Oct 2024 18:11:22 +0800
From: kernel test robot <lkp@intel.com>
To: Manuel Quintero F <sakunix@yahoo.com>, duncan.sands@free.fr
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Manuel Quintero F <sakunix@yahoo.com>
Subject: Re: [PATCH] USB: atm: speedtch: do not use assignment in if condition
Message-ID: <202410051833.7M7dq3rD-lkp@intel.com>
References: <20241004030512.2036-1-sakunix@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004030512.2036-1-sakunix@yahoo.com>

Hi Manuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manuel-Quintero-F/USB-atm-speedtch-do-not-use-assignment-in-if-condition/20241004-113643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20241004030512.2036-1-sakunix%40yahoo.com
patch subject: [PATCH] USB: atm: speedtch: do not use assignment in if condition
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241005/202410051833.7M7dq3rD-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410051833.7M7dq3rD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410051833.7M7dq3rD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/usb/atm/speedtch.c:26:
   In file included from drivers/usb/atm/usbatm.h:14:
   In file included from include/linux/atmdev.h:9:
   In file included from include/linux/net.h:24:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/usb/atm/speedtch.c:26:
   In file included from drivers/usb/atm/usbatm.h:14:
   In file included from include/linux/atmdev.h:11:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/usb/atm/speedtch.c:26:
   In file included from drivers/usb/atm/usbatm.h:14:
   In file included from include/linux/atmdev.h:11:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/usb/atm/speedtch.c:26:
   In file included from drivers/usb/atm/usbatm.h:14:
   In file included from include/linux/atmdev.h:11:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/usb/atm/speedtch.c:329:2: error: expected ')'
     329 |         if (ret < 0) {
         |         ^
   drivers/usb/atm/speedtch.c:327:25: note: to match this '('
     327 |         ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->params.altsetting
         |                                ^
   7 warnings and 1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +329 drivers/usb/atm/speedtch.c

   229	
   230	static int speedtch_upload_firmware(struct speedtch_instance_data *instance,
   231					     const struct firmware *fw1,
   232					     const struct firmware *fw2)
   233	{
   234		unsigned char *buffer;
   235		struct usbatm_data *usbatm = instance->usbatm;
   236		struct usb_device *usb_dev = usbatm->usb_dev;
   237		int actual_length;
   238		int ret = 0;
   239		int offset;
   240	
   241		usb_dbg(usbatm, "%s entered\n", __func__);
   242	
   243		buffer = (unsigned char *)__get_free_page(GFP_KERNEL);
   244		if (!buffer) {
   245			ret = -ENOMEM;
   246			usb_dbg(usbatm, "%s: no memory for buffer!\n", __func__);
   247			goto out;
   248		}
   249	
   250		if (!usb_ifnum_to_if(usb_dev, 2)) {
   251			ret = -ENODEV;
   252			usb_dbg(usbatm, "%s: interface not found!\n", __func__);
   253			goto out_free;
   254		}
   255	
   256		/* URB 7 */
   257		if (dl_512_first) {	/* some modems need a read before writing the firmware */
   258			ret = usb_bulk_msg(usb_dev, usb_rcvbulkpipe(usb_dev, ENDPOINT_FIRMWARE),
   259					   buffer, 0x200, &actual_length, 2000);
   260	
   261			if (ret < 0 && ret != -ETIMEDOUT)
   262				usb_warn(usbatm, "%s: read BLOCK0 from modem failed (%d)!\n", __func__, ret);
   263			else
   264				usb_dbg(usbatm, "%s: BLOCK0 downloaded (%d bytes)\n", __func__, ret);
   265		}
   266	
   267		/* URB 8 : both leds are static green */
   268		for (offset = 0; offset < fw1->size; offset += PAGE_SIZE) {
   269			int thislen = min_t(int, PAGE_SIZE, fw1->size - offset);
   270			memcpy(buffer, fw1->data + offset, thislen);
   271	
   272			ret = usb_bulk_msg(usb_dev, usb_sndbulkpipe(usb_dev, ENDPOINT_FIRMWARE),
   273					   buffer, thislen, &actual_length, DATA_TIMEOUT);
   274	
   275			if (ret < 0) {
   276				usb_err(usbatm, "%s: write BLOCK1 to modem failed (%d)!\n", __func__, ret);
   277				goto out_free;
   278			}
   279			usb_dbg(usbatm, "%s: BLOCK1 uploaded (%zu bytes)\n", __func__, fw1->size);
   280		}
   281	
   282		/* USB led blinking green, ADSL led off */
   283	
   284		/* URB 11 */
   285		ret = usb_bulk_msg(usb_dev, usb_rcvbulkpipe(usb_dev, ENDPOINT_FIRMWARE),
   286				   buffer, 0x200, &actual_length, DATA_TIMEOUT);
   287	
   288		if (ret < 0) {
   289			usb_err(usbatm, "%s: read BLOCK2 from modem failed (%d)!\n", __func__, ret);
   290			goto out_free;
   291		}
   292		usb_dbg(usbatm, "%s: BLOCK2 downloaded (%d bytes)\n", __func__, actual_length);
   293	
   294		/* URBs 12 to 139 - USB led blinking green, ADSL led off */
   295		for (offset = 0; offset < fw2->size; offset += PAGE_SIZE) {
   296			int thislen = min_t(int, PAGE_SIZE, fw2->size - offset);
   297			memcpy(buffer, fw2->data + offset, thislen);
   298	
   299			ret = usb_bulk_msg(usb_dev, usb_sndbulkpipe(usb_dev, ENDPOINT_FIRMWARE),
   300					   buffer, thislen, &actual_length, DATA_TIMEOUT);
   301	
   302			if (ret < 0) {
   303				usb_err(usbatm, "%s: write BLOCK3 to modem failed (%d)!\n", __func__, ret);
   304				goto out_free;
   305			}
   306		}
   307		usb_dbg(usbatm, "%s: BLOCK3 uploaded (%zu bytes)\n", __func__, fw2->size);
   308	
   309		/* USB led static green, ADSL led static red */
   310	
   311		/* URB 142 */
   312		ret = usb_bulk_msg(usb_dev, usb_rcvbulkpipe(usb_dev, ENDPOINT_FIRMWARE),
   313				   buffer, 0x200, &actual_length, DATA_TIMEOUT);
   314	
   315		if (ret < 0) {
   316			usb_err(usbatm, "%s: read BLOCK4 from modem failed (%d)!\n", __func__, ret);
   317			goto out_free;
   318		}
   319	
   320		/* success */
   321		usb_dbg(usbatm, "%s: BLOCK4 downloaded (%d bytes)\n", __func__, actual_length);
   322	
   323		/* Delay to allow firmware to start up. We can do this here
   324		   because we're in our own kernel thread anyway. */
   325		msleep_interruptible(1000);
   326	
   327		ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->params.altsetting
   328	
 > 329		if (ret < 0) {
   330			usb_err(usbatm, "%s: setting interface to %d failed (%d)!\n", __func__, instance->params.altsetting, ret);
   331			goto out_free;
   332		}
   333	
   334		/* Enable software buffering, if requested */
   335		if (sw_buffering)
   336			speedtch_set_swbuff(instance, 1);
   337	
   338		/* Magic spell; don't ask us what this does */
   339		speedtch_test_sequence(instance);
   340	
   341		ret = 0;
   342	
   343	out_free:
   344		free_page((unsigned long)buffer);
   345	out:
   346		return ret;
   347	}
   348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

