Return-Path: <linux-kernel+bounces-381166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545379AFB7A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD601F23DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E52C1C175C;
	Fri, 25 Oct 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlE9BJ6g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F60199FD0;
	Fri, 25 Oct 2024 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842592; cv=none; b=LkN7j/Ls/Y0QFfkxHqf3YiZoBg+x8M3oPOlwbXDggcTsmp5HIrx94kVnRL8djlqjOIFrhl5WLrbWEXbCC0GrJ9EJrxiUm0vFDWtaUkQDHrX3WHrTkzhjkCeLm4OcNLhZ3MEC/dX2LIkzs4LflW+jiHRScMz43IJ+aRHtv8fL8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842592; c=relaxed/simple;
	bh=952y0NPkhwarQKxJG1f+kljQakJhI+T6e79joVRiUcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvQxSwv24BBv4Iaf9W2Y67FodQMn3GKfwyhfprR4FQTb9YRaMUAlYtfNrWHTLxH9/4xEKGoJrYpLMMmPIhSjg9D+z76rg1JdVGJp6yeRacfiXwRRRueugzuQjOzbSWoK+FwbBoYnKUlLdFSkUlaQn5GMShAOV0r0auVTQSjhHT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlE9BJ6g; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729842590; x=1761378590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=952y0NPkhwarQKxJG1f+kljQakJhI+T6e79joVRiUcg=;
  b=dlE9BJ6gs0n1UBEtIr2AFy+VYd12dRolotRoOGvadNXWg4oFT0mqxMDV
   O3m64Czms3d+YJhQrzW4H8QAsIXYHFjDcN3D56B9OIvVvzjFFUJBdk5fZ
   Z5s/qEYl9Z9cT1ngWqMraTqLQ5towQFKfGuzyQBqPbxVHaxyIsB3ABYpg
   tetbBNg75GQXceMJSKPQZQ7PUBwCZMdtsIkvDIFQK/OOqy7OWunvHtjbP
   mf9Nsj/gitET/KBcu+7zuPplNBNcJ93oZjmLRMubh0NBziBsyfGc6wiV2
   FBVoIEZdjsOqfC46dC4HDKh06cKvdt2kGvBmUBQafcsU/rdywjsZMTkU7
   A==;
X-CSE-ConnectionGUID: qQ49ByMYSA+zxTkOfujb7w==
X-CSE-MsgGUID: UZj+t1rCQ3Gbj56b81fcWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40090468"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="40090468"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 00:49:50 -0700
X-CSE-ConnectionGUID: 5CsphyJ0QgaztpFi6nXfbw==
X-CSE-MsgGUID: YazC/HHFR3Cepcl9LasKHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80848388"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 25 Oct 2024 00:49:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4F4r-000XnR-2f;
	Fri, 25 Oct 2024 07:49:45 +0000
Date: Fri, 25 Oct 2024 15:49:16 +0800
From: kernel test robot <lkp@intel.com>
To: Tony Chung <tony467913@gmail.com>, johan@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: Re: [PATCH] usb: serial: mos7840: Fix coding style warnings
Message-ID: <202410251501.9hTgSYCH-lkp@intel.com>
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
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241025/202410251501.9hTgSYCH-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410251501.9hTgSYCH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251501.9hTgSYCH-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/usb/serial/mos7840.c: In function 'mos7840_write':
>> drivers/usb/serial/mos7840.c:923:39: warning: missing terminating " character
     923 |                 dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
         |                                       ^
   drivers/usb/serial/mos7840.c:924:43: warning: missing terminating " character
     924 |                         with status = %d\n", __func__, status);
         |                                           ^
>> drivers/usb/serial/mos7840.c:1832:23: error: unterminated argument list invoking macro "dev_err_console"
    1832 | MODULE_LICENSE("GPL");
         |                       ^
>> drivers/usb/serial/mos7840.c:923:17: error: 'dev_err_console' undeclared (first use in this function); did you mean 'dev_err_probe'?
     923 |                 dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
         |                 ^~~~~~~~~~~~~~~
         |                 dev_err_probe
   drivers/usb/serial/mos7840.c:923:17: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/usb/serial/mos7840.c:923:32: error: expected ';' at end of input
     923 |                 dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
         |                                ^
         |                                ;
   ......
>> drivers/usb/serial/mos7840.c:923:17: error: expected declaration or statement at end of input
     923 |                 dev_err_console(port, "%s - usb_submit_urb(write bulk) failed
         |                 ^~~~~~~~~~~~~~~
>> drivers/usb/serial/mos7840.c:923:17: error: expected declaration or statement at end of input
>> drivers/usb/serial/mos7840.c:887:25: error: label 'exit' used but not defined
     887 |                         goto exit;
         |                         ^~~~
>> drivers/usb/serial/mos7840.c:856:13: warning: variable 'bytes_sent' set but not used [-Wunused-but-set-variable]
     856 |         int bytes_sent = 0;
         |             ^~~~~~~~~~
   drivers/usb/serial/mos7840.c: At top level:
>> drivers/usb/serial/mos7840.c:849:12: warning: 'mos7840_write' defined but not used [-Wunused-function]
     849 | static int mos7840_write(struct tty_struct *tty, struct usb_serial_port *port,
         |            ^~~~~~~~~~~~~
>> drivers/usb/serial/mos7840.c:820:21: warning: 'mos7840_write_room' defined but not used [-Wunused-function]
     820 | static unsigned int mos7840_write_room(struct tty_struct *tty)
         |                     ^~~~~~~~~~~~~~~~~~
>> drivers/usb/serial/mos7840.c:795:12: warning: 'mos7840_break' defined but not used [-Wunused-function]
     795 | static int mos7840_break(struct tty_struct *tty, int break_state)
         |            ^~~~~~~~~~~~~
>> drivers/usb/serial/mos7840.c:764:13: warning: 'mos7840_close' defined but not used [-Wunused-function]
     764 | static void mos7840_close(struct usb_serial_port *port)
         |             ^~~~~~~~~~~~~
>> drivers/usb/serial/mos7840.c:737:21: warning: 'mos7840_chars_in_buffer' defined but not used [-Wunused-function]
     737 | static unsigned int mos7840_chars_in_buffer(struct tty_struct *tty)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/serial/mos7840.c:516:12: warning: 'mos7840_open' defined but not used [-Wunused-function]
     516 | static int mos7840_open(struct tty_struct *tty, struct usb_serial_port *port)
         |            ^~~~~~~~~~~~
>> drivers/usb/serial/mos7840.c:410:13: warning: 'mos7840_led_flag_off' defined but not used [-Wunused-function]
     410 | static void mos7840_led_flag_off(struct timer_list *t)
         |             ^~~~~~~~~~~~~~~~~~~~
>> drivers/usb/serial/mos7840.c:400:13: warning: 'mos7840_led_off' defined but not used [-Wunused-function]
     400 | static void mos7840_led_off(struct timer_list *t)
         |             ^~~~~~~~~~~~~~~
>> drivers/usb/serial/mos7840.c:391:13: warning: 'mos7840_set_led_sync' defined but not used [-Wunused-function]
     391 | static void mos7840_set_led_sync(struct usb_serial_port *port, __u16 reg,
         |             ^~~~~~~~~~~~~~~~~~~~
>> drivers/usb/serial/mos7840.c:337:13: warning: 'mos7840_dump_serial_port' defined but not used [-Wunused-function]
     337 | static void mos7840_dump_serial_port(struct usb_serial_port *port,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/dev_err_console +1832 drivers/usb/serial/mos7840.c

3f5429746d91f2 Paul B Schroeder 2006-08-31  1830  
3f5429746d91f2 Paul B Schroeder 2006-08-31  1831  MODULE_DESCRIPTION(DRIVER_DESC);
3f5429746d91f2 Paul B Schroeder 2006-08-31 @1832  MODULE_LICENSE("GPL");

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

