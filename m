Return-Path: <linux-kernel+bounces-380459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C079AEEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C553281037
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE721FF05F;
	Thu, 24 Oct 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXjZa/2W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5954A1FF608;
	Thu, 24 Oct 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792755; cv=none; b=OVDPtBHYDbWFeazKOBctqAxQ4DBasxuHEfGVZmDazndS7w0/6x6r78doF3eJastZyJVU2SL8hfH2IOvtFaKrXykAXLDILt6H9tmKlHAF1OSrwuEAn0mbjOifb3CsU2NU5/AJ1ghYDc8xk6yzyxcHijrC6zJFNINn1JQOhgtatTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792755; c=relaxed/simple;
	bh=WR8V6R8aTQ9J4ym6UObkFbD0QVdvihFZTWWiv3N/Fcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7fo5/9qcN+oX5tar9RCiNEZG706528fS3HSgUsm3To3ljMRZu6/Yj73HL6z/eW4p2NuyKHpjveiMUqNp+HRE3PAwVldWkHrXSIi4+pTqdvqBK34Ain5DdKcrbioXj4NgcED1hnCGaaAjDh40m/SImBEcTUPXfZbEWic++fdGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXjZa/2W; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729792752; x=1761328752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WR8V6R8aTQ9J4ym6UObkFbD0QVdvihFZTWWiv3N/Fcw=;
  b=nXjZa/2WE3saAXze+8CVCFAODGU1v2HqdVuI5Mu7iTkexHUvVPMIJGfx
   kd2tvpy4ClVeYvLoH7cVQUB937GDg9Ox2bfLBm2WmnQXcUju1bb5PNKqR
   Wq7pLiWTKSW0lNM+qwCDqn4NgC7nyUJT7Q2Qvts+4rgUNdXKW7y52DOqy
   g31Du/Ne19UtASOORkbqOlbks73UUZyw9v7720Py3gT0O5d/RCr3vLS3o
   4e9VluhMCwkVgf9XGmhN3ciddc3LU3+RLn31iin6rdbtbhPFMteHr2VIc
   AtYaDtAgPZ0RBx0KRhzIiVQFPyjSUQcjwwY/GCXEET2PkBSw35LgPjqx2
   A==;
X-CSE-ConnectionGUID: U+upD41gQtaiJaOtehHqmw==
X-CSE-MsgGUID: N7XVLnouSqiHRk2+kNf+cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29345419"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29345419"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:59:12 -0700
X-CSE-ConnectionGUID: ayxnAQiQSXi2t5BJxzxD0g==
X-CSE-MsgGUID: UFef8pa8QKaMQ3ReMWN4kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="111471519"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2024 10:59:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4271-000Woq-38;
	Thu, 24 Oct 2024 17:59:07 +0000
Date: Fri, 25 Oct 2024 01:58:17 +0800
From: kernel test robot <lkp@intel.com>
To: Tony Chung <tony467913@gmail.com>, johan@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: Re: [PATCH] usb: serial: mos7840: Fix coding style warnings
Message-ID: <202410250141.AEkzzW60-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on johan-usb-serial/usb-next]
[also build test WARNING on johan-usb-serial/usb-linus usb/usb-testing usb/usb-next usb/usb-linus tty/tty-testing tty/tty-next tty/tty-linus linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Chung/usb-serial-mos7840-Fix-coding-style-warnings/20241023-171615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git usb-next
patch link:    https://lore.kernel.org/r/20241023091414.18098-1-tony467913%40gmail.com
patch subject: [PATCH] usb: serial: mos7840: Fix coding style warnings
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241025/202410250141.AEkzzW60-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250141.AEkzzW60-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250141.AEkzzW60-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/serial/mos7840.c: In function 'mos7840_write':
   drivers/usb/serial/mos7840.c:923:39: warning: missing terminating " character
     923 |                 dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
         |                                       ^
   drivers/usb/serial/mos7840.c:924:43: warning: missing terminating " character
     924 |                         with status = %d\n", __func__, status);
         |                                           ^
   drivers/usb/serial/mos7840.c:1832:23: error: unterminated argument list invoking macro "dev_err_console"
    1832 | MODULE_LICENSE("GPL");
         |                       ^
   drivers/usb/serial/mos7840.c:923:17: error: 'dev_err_console' undeclared (first use in this function); did you mean 'dev_err_probe'?
     923 |                 dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
         |                 ^~~~~~~~~~~~~~~
         |                 dev_err_probe
   drivers/usb/serial/mos7840.c:923:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/usb/serial/mos7840.c:923:32: error: expected ';' at end of input
     923 |                 dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
         |                                ^
         |                                ;
   ......
   drivers/usb/serial/mos7840.c:923:17: error: expected declaration or statement at end of input
     923 |                 dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
         |                 ^~~~~~~~~~~~~~~
   drivers/usb/serial/mos7840.c:923:17: error: expected declaration or statement at end of input
   drivers/usb/serial/mos7840.c:887:25: error: label 'exit' used but not defined
     887 |                         goto exit;
         |                         ^~~~
   drivers/usb/serial/mos7840.c:856:13: warning: variable 'bytes_sent' set but not used [-Wunused-but-set-variable]
     856 |         int bytes_sent = 0;
         |             ^~~~~~~~~~
   drivers/usb/serial/mos7840.c: At top level:
   drivers/usb/serial/mos7840.c:849:12: warning: 'mos7840_write' defined but not used [-Wunused-function]
     849 | static int mos7840_write(struct tty_struct *tty, struct usb_serial_port *port,
         |            ^~~~~~~~~~~~~
   drivers/usb/serial/mos7840.c:820:21: warning: 'mos7840_write_room' defined but not used [-Wunused-function]
     820 | static unsigned int mos7840_write_room(struct tty_struct *tty)
         |                     ^~~~~~~~~~~~~~~~~~
   drivers/usb/serial/mos7840.c:795:12: warning: 'mos7840_break' defined but not used [-Wunused-function]
     795 | static int mos7840_break(struct tty_struct *tty, int break_state)
         |            ^~~~~~~~~~~~~
   drivers/usb/serial/mos7840.c:764:13: warning: 'mos7840_close' defined but not used [-Wunused-function]
     764 | static void mos7840_close(struct usb_serial_port *port)
         |             ^~~~~~~~~~~~~
   drivers/usb/serial/mos7840.c:737:21: warning: 'mos7840_chars_in_buffer' defined but not used [-Wunused-function]
     737 | static unsigned int mos7840_chars_in_buffer(struct tty_struct *tty)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/serial/mos7840.c:516:12: warning: 'mos7840_open' defined but not used [-Wunused-function]
     516 | static int mos7840_open(struct tty_struct *tty, struct usb_serial_port *port)
         |            ^~~~~~~~~~~~
   drivers/usb/serial/mos7840.c:410:13: warning: 'mos7840_led_flag_off' defined but not used [-Wunused-function]
     410 | static void mos7840_led_flag_off(struct timer_list *t)
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/usb/serial/mos7840.c:400:13: warning: 'mos7840_led_off' defined but not used [-Wunused-function]
     400 | static void mos7840_led_off(struct timer_list *t)
         |             ^~~~~~~~~~~~~~~
   drivers/usb/serial/mos7840.c:391:13: warning: 'mos7840_set_led_sync' defined but not used [-Wunused-function]
     391 | static void mos7840_set_led_sync(struct usb_serial_port *port, __u16 reg,
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/usb/serial/mos7840.c:337:13: warning: 'mos7840_dump_serial_port' defined but not used [-Wunused-function]
     337 | static void mos7840_dump_serial_port(struct usb_serial_port *port,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/serial/mos7840.c:168:35: warning: 'id_table' defined but not used [-Wunused-const-variable=]
     168 | static const struct usb_device_id id_table[] = {
         |                                   ^~~~~~~~


vim +/id_table +168 drivers/usb/serial/mos7840.c

375cb533c00a237 Johan Hovold       2019-11-07  164  
375cb533c00a237 Johan Hovold       2019-11-07  165  #define MCS_DEVICE(vid, pid, flags) \
375cb533c00a237 Johan Hovold       2019-11-07  166  		USB_DEVICE((vid), (pid)), .driver_info = (flags)
375cb533c00a237 Johan Hovold       2019-11-07  167  
b9c87663eead64c Tony Zelenoff      2012-06-05 @168  static const struct usb_device_id id_table[] = {
375cb533c00a237 Johan Hovold       2019-11-07  169  	{ MCS_DEVICE(0x0557, 0x2011, MCS_PORTS(4)) },	/* ATEN UC2324 */
375cb533c00a237 Johan Hovold       2019-11-07  170  	{ MCS_DEVICE(0x0557, 0x7820, MCS_PORTS(2)) },	/* ATEN UC2322 */
375cb533c00a237 Johan Hovold       2019-11-07  171  	{ MCS_DEVICE(0x110a, 0x2210, MCS_PORTS(2)) },	/* Moxa UPort 2210 */
375cb533c00a237 Johan Hovold       2019-11-07  172  	{ MCS_DEVICE(0x9710, 0x7810, MCS_PORTS(1) | MCS_LED) }, /* ASIX MCS7810 */
375cb533c00a237 Johan Hovold       2019-11-07  173  	{ MCS_DEVICE(0x9710, 0x7820, MCS_PORTS(2)) },	/* MosChip MCS7820 */
375cb533c00a237 Johan Hovold       2019-11-07  174  	{ MCS_DEVICE(0x9710, 0x7840, MCS_PORTS(4)) },	/* MosChip MCS7840 */
375cb533c00a237 Johan Hovold       2019-11-07  175  	{ MCS_DEVICE(0x9710, 0x7843, MCS_PORTS(3)) },	/* ASIX MCS7840 3 port */
acf509ae28301d7 Cliff Brake        2009-12-01  176  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USO9ML2_2) },
870408c82910158 Dave Ludlow        2010-09-01  177  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USO9ML2_2P) },
acf509ae28301d7 Cliff Brake        2009-12-01  178  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USO9ML2_4) },
870408c82910158 Dave Ludlow        2010-09-01  179  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USO9ML2_4P) },
acf509ae28301d7 Cliff Brake        2009-12-01  180  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_US9ML2_2) },
acf509ae28301d7 Cliff Brake        2009-12-01  181  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_US9ML2_4) },
acf509ae28301d7 Cliff Brake        2009-12-01  182  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USPTL4_2) },
acf509ae28301d7 Cliff Brake        2009-12-01  183  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USPTL4_4) },
11e1abb453690a9 David Ludlow       2008-02-25  184  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USOPTL4_2) },
870408c82910158 Dave Ludlow        2010-09-01  185  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USOPTL4_2P) },
acf509ae28301d7 Cliff Brake        2009-12-01  186  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USOPTL4_4) },
870408c82910158 Dave Ludlow        2010-09-01  187  	{ USB_DEVICE(USB_VENDOR_ID_BANDB, BANDB_DEVICE_ID_USOPTL4_4P) },
3f5429746d91f21 Paul B Schroeder   2006-08-31  188  	{}			/* terminating entry */
3f5429746d91f21 Paul B Schroeder   2006-08-31  189  };
68e24113457e437 Greg Kroah-Hartman 2012-05-08  190  MODULE_DEVICE_TABLE(usb, id_table);
3f5429746d91f21 Paul B Schroeder   2006-08-31  191  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

