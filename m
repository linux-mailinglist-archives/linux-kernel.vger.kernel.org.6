Return-Path: <linux-kernel+bounces-380426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB9E9AEE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EAD1F2515D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D461FE112;
	Thu, 24 Oct 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAZxxn49"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B91FBF58;
	Thu, 24 Oct 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791496; cv=none; b=TnFdTcX8uWw+UfnJQxWOLGo1iTPgcwUIEBnCZ2FF14d3E5hLaCIA9XeGWCrp6N7eQ3RHPGER3/F1HklpaqPtzpljqv4siB6IXP0RV396baGxoxAvmr685pelN0OfVQA6yznB9LX2xvKq6uwh7i1VlEiPRdcqA/Qju2TpQ6BZp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791496; c=relaxed/simple;
	bh=Oan/SkH3IPRDX8e2NbsGfXCx3pLV3nmTT6WW6XybXlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgPynMCqdLpd/rtZLfBTFSSokTsBWLDQzLvxwzWPN2yKvBhqXo9tGhLnIVl3MGxe1zZqXAeX+lnRjxvYnpTVWXvNKzT+xKWL/ONdx0+qMsGcgDhl1U8+r2oNClT8715eT8QBRjSEevM1PtnIo2D5jIc2ll4mhGuuc/FMegB4CWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAZxxn49; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729791494; x=1761327494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oan/SkH3IPRDX8e2NbsGfXCx3pLV3nmTT6WW6XybXlk=;
  b=bAZxxn49Bz/9cQgzZl5HhseJkniwo4lQURiyJb+bj1e+G9SqdDd6r6Vt
   F362SYGkJT2JPSG+r5CRWzqJKRwUr/1M8D7+sU48OwsBmqdL6zwt1RoPV
   SCLTFyS4hqqv1kWZ0lKqmy4jmYvJYp7j4eEBUMyxfy2go1FYRyPeGHSP1
   N80Ej9+n3H1+jT6V5MXyEKiAND9UlJ/ec0jQXMEz0/ms3u5ihGuZqbx8t
   YT8aaWBtlROtqBU8JzT7e9by9WTnW6apKM/nVNcQSMVuh0CpTPTaFtmqe
   puQd5ZLvjTdt3LvW7ADm7PWwOXiEPUFK86xKPwrkfv4/pCwkhBagr9yku
   A==;
X-CSE-ConnectionGUID: JCK3FV3+QyynU3IfGqvr+g==
X-CSE-MsgGUID: 1EYl4B3rRn2YiErtJLcd3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40028700"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40028700"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:38:11 -0700
X-CSE-ConnectionGUID: wvQjMbuvQg6WrDaYVu1O3Q==
X-CSE-MsgGUID: uOsmB8MaTbKjlBNlGNDpSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80247299"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 10:38:09 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t41mh-000WnK-0a;
	Thu, 24 Oct 2024 17:38:07 +0000
Date: Fri, 25 Oct 2024 01:37:07 +0800
From: kernel test robot <lkp@intel.com>
To: Tony Chung <tony467913@gmail.com>, johan@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Chung <tony467913@gmail.com>
Subject: Re: [PATCH] usb: serial: mos7840: Fix coding style warnings
Message-ID: <202410250138.OhF04o8W-lkp@intel.com>
References: <20241023091414.18098-1-tony467913@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023091414.18098-1-tony467913@gmail.com>

Hi Tony,

kernel test robot noticed the following build errors:

[auto build test ERROR on johan-usb-serial/usb-next]
[also build test ERROR on johan-usb-serial/usb-linus usb/usb-testing usb/usb-next usb/usb-linus tty/tty-testing tty/tty-next tty/tty-linus linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Chung/usb-serial-mos7840-Fix-coding-style-warnings/20241023-171615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git usb-next
patch link:    https://lore.kernel.org/r/20241023091414.18098-1-tony467913%40gmail.com
patch subject: [PATCH] usb: serial: mos7840: Fix coding style warnings
config: i386-buildonly-randconfig-005-20241024 (https://download.01.org/0day-ci/archive/20241025/202410250138.OhF04o8W-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250138.OhF04o8W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250138.OhF04o8W-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/usb/serial/mos7840.c:15:
   In file included from include/linux/tty.h:11:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:40:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/usb/serial/mos7840.c:923:25: warning: missing terminating '"' character [-Winvalid-pp-token]
     923 |                 dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
         |                                       ^
   drivers/usb/serial/mos7840.c:924:22: warning: missing terminating '"' character [-Winvalid-pp-token]
     924 |                         with status = %d\n", __func__, status);
         |                                           ^
>> drivers/usb/serial/mos7840.c:923:3: error: unterminated function-like macro invocation
     923 |                 dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
         |                 ^
   include/linux/usb/serial.h:399:9: note: macro 'dev_err_console' defined here
     399 | #define dev_err_console(usport, fmt, ...)                               \
         |         ^
>> drivers/usb/serial/mos7840.c:1832:23: error: expected '}'
    1832 | MODULE_LICENSE("GPL");
         |                       ^
   drivers/usb/serial/mos7840.c:921:14: note: to match this '{'
     921 |         if (status) {
         |                     ^
>> drivers/usb/serial/mos7840.c:1832:23: error: expected '}'
    1832 | MODULE_LICENSE("GPL");
         |                       ^
   drivers/usb/serial/mos7840.c:851:1: note: to match this '{'
     851 | {
         | ^
>> drivers/usb/serial/mos7840.c:879:8: error: use of undeclared label 'exit'
     879 |                 goto exit;
         |                      ^
   3 warnings and 4 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +923 drivers/usb/serial/mos7840.c

   840	
   841	/*****************************************************************************
   842	 * mos7840_write
   843	 *	this function is called by the tty driver when data should be written to
   844	 *	the port.
   845	 *	If successful, we return the number of bytes written, otherwise we
   846	 *      return a negative error number.
   847	 *****************************************************************************/
   848	
   849	static int mos7840_write(struct tty_struct *tty, struct usb_serial_port *port,
   850				 const unsigned char *data, int count)
   851	{
   852		struct moschip_port *mos7840_port = usb_get_serial_port_data(port);
   853		struct usb_serial *serial = port->serial;
   854		int status;
   855		int i;
   856		int bytes_sent = 0;
   857		int transfer_size;
   858		unsigned long flags;
   859		struct urb *urb;
   860		/* __u16 Data; */
   861		const unsigned char *current_position = data;
   862	
   863		/* try to find a free urb in the list */
   864		urb = NULL;
   865	
   866		spin_lock_irqsave(&mos7840_port->pool_lock, flags);
   867		for (i = 0; i < NUM_URBS; ++i) {
   868			if (!mos7840_port->busy[i]) {
   869				mos7840_port->busy[i] = 1;
   870				urb = mos7840_port->write_urb_pool[i];
   871				dev_dbg(&port->dev, "URB:%d\n", i);
   872				break;
   873			}
   874		}
   875		spin_unlock_irqrestore(&mos7840_port->pool_lock, flags);
   876	
   877		if (urb == NULL) {
   878			dev_dbg(&port->dev, "%s - no more free urbs\n", __func__);
 > 879			goto exit;
   880		}
   881	
   882		if (urb->transfer_buffer == NULL) {
   883			urb->transfer_buffer = kmalloc(URB_TRANSFER_BUFFER_SIZE,
   884						       GFP_ATOMIC);
   885			if (!urb->transfer_buffer) {
   886				bytes_sent = -ENOMEM;
   887				goto exit;
   888			}
   889		}
   890		transfer_size = min(count, URB_TRANSFER_BUFFER_SIZE);
   891	
   892		memcpy(urb->transfer_buffer, current_position, transfer_size);
   893	
   894		/* fill urb with data and submit  */
   895		if ((serial->num_ports == 2) && (((__u16)port->port_number % 2) != 0)) {
   896			usb_fill_bulk_urb(urb,
   897				serial->dev,
   898				usb_sndbulkpipe(serial->dev,
   899					(port->bulk_out_endpointAddress) + 2),
   900				urb->transfer_buffer,
   901				transfer_size,
   902				mos7840_bulk_out_data_callback, mos7840_port);
   903		} else {
   904			usb_fill_bulk_urb(urb,
   905				serial->dev,
   906				usb_sndbulkpipe(serial->dev,
   907					port->bulk_out_endpointAddress),
   908				urb->transfer_buffer,
   909				transfer_size,
   910				mos7840_bulk_out_data_callback, mos7840_port);
   911		}
   912	
   913		dev_dbg(&port->dev, "bulkout endpoint is %d\n", port->bulk_out_endpointAddress);
   914	
   915		if (mos7840_port->has_led)
   916			mos7840_led_activity(port);
   917	
   918		/* send it down the pipe */
   919		status = usb_submit_urb(urb, GFP_ATOMIC);
   920	
   921		if (status) {
   922			mos7840_port->busy[i] = 0;
 > 923			dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
   924				with status = %d\n", __func__, status);
   925			bytes_sent = status;
   926			goto exit;
   927		}
   928		bytes_sent = transfer_size;
   929		port->icount.tx += transfer_size;
   930		dev_dbg(&port->dev, "icount.tx is %d:\n", port->icount.tx);
   931	exit:
   932		return bytes_sent;
   933	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

