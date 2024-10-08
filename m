Return-Path: <linux-kernel+bounces-355123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE51E9947AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433F4B23236
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63A51DE894;
	Tue,  8 Oct 2024 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YmvrVrej"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3EC1DE2A2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388201; cv=none; b=mwWXGyBe7AMr8UdoePXA9ihiBN3YhWtW+lTEavYy7d1S4ABcRS5euPY+PwwBHW12r88Dq9M3cp/J843Ys8bxDZIEHe1h4CUVJ4Cq8EoL2VIpunIzVnBIZnLF0y7muU8Be4Pe45X4XEPgocOASQVn9TKrvx6mITl86ZULPQod/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388201; c=relaxed/simple;
	bh=tYhSU1I7hxfXz8r4NbQO2nPEZlUty8+ixCSRvwc7ckQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZe+J42icV9bkhKa3yhoDAEh1J7gO0h4pD2Urr9uDja88Ez3ouS4dZlyLdGRdOnGTLMQYpbTRu+WTpf7bA0SqdoNXtnPGKEz1vOHGN3VTNP24dK0by/Qm6qE8T2sHWKYlsebgwgv1Ve6ASxLhcAEcS2TahdYx3/gs2nxG/WD6+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YmvrVrej; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728388198; x=1759924198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tYhSU1I7hxfXz8r4NbQO2nPEZlUty8+ixCSRvwc7ckQ=;
  b=YmvrVrejmeTefxk6dJZ0sssh6dLXCFUZSK/wYzwm7SaBg0dRnfHNYhgZ
   bEwni9qvpfOS81+Dt3tS/GPCxr0QznEg9gMWyPtPYW5Q8yhumOF6TZXLn
   JvzbAkrh7zMBVjM0vd1O0WWVEktJnxNfXWTctPi/jbtaWLnLNOc63w+q9
   ldv7o6wF9o1mDZAnJauhnqSUMYTMHdcZACsU54Tt6n9CDpt3QBr4EoXfx
   Fs8aB31N2UsMymnaiPSs7dIrL6MJnLMn5u7mCl26Lc8eC4xAntu30BX7f
   m8WONDyYEEB/a7pOcnlBo1gT4Ma4JPTZfZm1Xaickpv5CYm9MeqPfiF5T
   g==;
X-CSE-ConnectionGUID: EmZ2K8Z0SC6lthyarF5BZQ==
X-CSE-MsgGUID: o7qlyvUtQYavblJrciynSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="45101412"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="45101412"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 04:49:57 -0700
X-CSE-ConnectionGUID: y4xf3e7OSgiUrze3yr0pLw==
X-CSE-MsgGUID: +HhmQBGESBmuilcSP53YiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="80650620"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Oct 2024 04:49:55 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy8iu-0006Ki-2i;
	Tue, 08 Oct 2024 11:49:52 +0000
Date: Tue, 8 Oct 2024 19:48:54 +0800
From: kernel test robot <lkp@intel.com>
To: Xiaofeng Lian <1198715581lxf@gmail.com>, stefani@seibold.net,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Xiaofeng Lian <1198715581lxf@gmail.com>
Subject: Re: [PATCH v2] include/linux/kfifo.h: fix some IDEs Intelligence
 errors and the previous patch was misnamed
Message-ID: <202410081934.6u1I94gw-lkp@intel.com>
References: <20241002172427.412715-1-1198715581lxf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002172427.412715-1-1198715581lxf@gmail.com>

Hi Xiaofeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc2 next-20241008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaofeng-Lian/include-linux-kfifo-h-fix-some-IDEs-Intelligence-errors-and-the-previous-patch-was-misnamed/20241006-015547
base:   linus/master
patch link:    https://lore.kernel.org/r/20241002172427.412715-1-1198715581lxf%40gmail.com
patch subject: [PATCH v2] include/linux/kfifo.h: fix some IDEs Intelligence errors and the previous patch was misnamed
config: i386-randconfig-012-20241008 (https://download.01.org/0day-ci/archive/20241008/202410081934.6u1I94gw-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410081934.6u1I94gw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410081934.6u1I94gw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/greybus/es2.c:1282:2: error: member reference base type 'char' is not a structure or union
    1282 |         INIT_KFIFO(es2->apb_log_fifo);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:34: note: expanded from macro '__KFIFO_SIZE'
     138 |                 DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^ ~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/kfifo.h:84:28: note: expanded from macro 'STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   include/linux/kfifo.h:79:24: note: expanded from macro '__STRUCT_KFIFO_PTR'
      79 |         __STRUCT_KFIFO_COMMON(type, recsize, ptrtype); \
         |         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:61:3: note: expanded from macro '__STRUCT_KFIFO_COMMON'
      61 |                 datatype        *type; \
         |                 ^~~~~~~~
>> drivers/greybus/es2.c:1282:2: error: member reference base type 'char' is not a structure or union
    1282 |         INIT_KFIFO(es2->apb_log_fifo);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:34: note: expanded from macro '__KFIFO_SIZE'
     138 |                 DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^ ~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/kfifo.h:84:28: note: expanded from macro 'STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   include/linux/kfifo.h:79:24: note: expanded from macro '__STRUCT_KFIFO_PTR'
      79 |         __STRUCT_KFIFO_COMMON(type, recsize, ptrtype); \
         |         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:62:9: note: expanded from macro '__STRUCT_KFIFO_COMMON'
      62 |                 const datatype  *const_type; \
         |                       ^~~~~~~~
>> drivers/greybus/es2.c:1282:2: error: member reference base type 'char' is not a structure or union
    1282 |         INIT_KFIFO(es2->apb_log_fifo);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:34: note: expanded from macro '__KFIFO_SIZE'
     138 |                 DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^ ~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/kfifo.h:84:37: note: expanded from macro 'STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   include/linux/kfifo.h:79:39: note: expanded from macro '__STRUCT_KFIFO_PTR'
      79 |         __STRUCT_KFIFO_COMMON(type, recsize, ptrtype); \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
   include/linux/kfifo.h:64:3: note: expanded from macro '__STRUCT_KFIFO_COMMON'
      64 |                 ptrtype         *ptr; \
         |                 ^~~~~~~
>> drivers/greybus/es2.c:1282:2: error: member reference base type 'char' is not a structure or union
    1282 |         INIT_KFIFO(es2->apb_log_fifo);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:34: note: expanded from macro '__KFIFO_SIZE'
     138 |                 DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^ ~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/kfifo.h:84:37: note: expanded from macro 'STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
   include/linux/kfifo.h:79:39: note: expanded from macro '__STRUCT_KFIFO_PTR'
      79 |         __STRUCT_KFIFO_COMMON(type, recsize, ptrtype); \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
   include/linux/kfifo.h:65:3: note: expanded from macro '__STRUCT_KFIFO_COMMON'
      65 |                 ptrtype const   *ptr_const; \
         |                 ^~~~~~~
>> drivers/greybus/es2.c:1282:2: error: member reference base type 'char' is not a structure or union
    1282 |         INIT_KFIFO(es2->apb_log_fifo);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:34: note: expanded from macro '__KFIFO_SIZE'
     138 |                 DECLARE_KFIFO_PTR(__tmp_kfifo, get_kfifo_data_type(fifo));\
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^ ~~~~
   include/linux/kfifo.h:116:56: note: expanded from macro 'DECLARE_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/kfifo.h:84:28: note: expanded from macro 'STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~
   include/linux/kfifo.h:80:2: note: expanded from macro '__STRUCT_KFIFO_PTR'
      80 |         type            buf[0]; \
         |         ^~~~
>> drivers/greybus/es2.c:1282:2: error: member reference base type 'char' is not a structure or union
    1282 |         INIT_KFIFO(es2->apb_log_fifo);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:46: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:139:52: note: expanded from macro '__KFIFO_SIZE'
     139 |                 (sizeof(*(fifo)) - sizeof(__tmp_kfifo)) / sizeof(get_kfifo_data_type(fifo));\
         |                                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:49: note: expanded from macro 'get_kfifo_data_type'
     130 | #define get_kfifo_data_type(fifo) typeof(*(fifo)->type)
         |                                           ~~~~~~^ ~~~~
>> drivers/greybus/es2.c:1282:2: error: invalid operands to binary expression ('void' and 'int')
    1282 |         INIT_KFIFO(es2->apb_log_fifo);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:71: note: expanded from macro 'INIT_KFIFO'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __KFIFO_SIZE(__tmp->buf) - 1;\
         |                                                     ~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~
   7 errors generated.


vim +/char +1282 drivers/greybus/es2.c

24a6112fa53e8a drivers/staging/greybus/es2.c    Fabien Parent      2015-09-02  1237  
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1238  /*
4d5c446b53655d drivers/staging/greybus/es2.c    Johan Hovold       2015-11-02  1239   * The ES2 USB Bridge device has 15 endpoints
4d5c446b53655d drivers/staging/greybus/es2.c    Johan Hovold       2015-11-02  1240   * 1 Control - usual USB stuff + AP -> APBridgeA messages
4d5c446b53655d drivers/staging/greybus/es2.c    Johan Hovold       2015-11-02  1241   * 7 Bulk IN - CPort data in
4d5c446b53655d drivers/staging/greybus/es2.c    Johan Hovold       2015-11-02  1242   * 7 Bulk OUT - CPort data out
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1243   */
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1244  static int ap_probe(struct usb_interface *interface,
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1245  		    const struct usb_device_id *id)
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1246  {
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1247  	struct es2_ap_dev *es2;
2537636abae5b8 drivers/staging/greybus/es2.c    Johan Hovold       2015-11-03  1248  	struct gb_host_device *hd;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1249  	struct usb_device *udev;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1250  	struct usb_host_interface *iface_desc;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1251  	struct usb_endpoint_descriptor *endpoint;
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1252  	__u8 ep_addr;
be5d01f10bdb78 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1253  	int retval;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1254  	int i;
24a6112fa53e8a drivers/staging/greybus/es2.c    Fabien Parent      2015-09-02  1255  	int num_cports;
403074b50b66f1 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1256  	bool bulk_out_found = false;
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1257  	bool bulk_in_found = false;
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1258  	bool arpc_in_found = false;
4bc1389de9fcaa drivers/staging/greybus/es2.c    Alex Elder         2015-06-13  1259  
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1260  	udev = usb_get_dev(interface_to_usbdev(interface));
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1261  
3be0e17d62d5a9 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1262  	num_cports = apb_get_cport_count(udev);
24a6112fa53e8a drivers/staging/greybus/es2.c    Fabien Parent      2015-09-02  1263  	if (num_cports < 0) {
24a6112fa53e8a drivers/staging/greybus/es2.c    Fabien Parent      2015-09-02  1264  		usb_put_dev(udev);
24a6112fa53e8a drivers/staging/greybus/es2.c    Fabien Parent      2015-09-02  1265  		dev_err(&udev->dev, "Cannot retrieve CPort count: %d\n",
24a6112fa53e8a drivers/staging/greybus/es2.c    Fabien Parent      2015-09-02  1266  			num_cports);
24a6112fa53e8a drivers/staging/greybus/es2.c    Fabien Parent      2015-09-02  1267  		return num_cports;
24a6112fa53e8a drivers/staging/greybus/es2.c    Fabien Parent      2015-09-02  1268  	}
24a6112fa53e8a drivers/staging/greybus/es2.c    Fabien Parent      2015-09-02  1269  
d6e139bc15118c drivers/staging/greybus/es2.c    Johan Hovold       2015-11-03  1270  	hd = gb_hd_create(&es2_driver, &udev->dev, ES2_GBUF_MSG_SIZE_MAX,
24a6112fa53e8a drivers/staging/greybus/es2.c    Fabien Parent      2015-09-02  1271  			  num_cports);
8ea70fe0497c5d drivers/staging/greybus/es2.c    Alex Elder         2015-05-22  1272  	if (IS_ERR(hd)) {
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1273  		usb_put_dev(udev);
8ea70fe0497c5d drivers/staging/greybus/es2.c    Alex Elder         2015-05-22  1274  		return PTR_ERR(hd);
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1275  	}
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1276  
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1277  	es2 = hd_to_es2(hd);
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1278  	es2->hd = hd;
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1279  	es2->usb_intf = interface;
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1280  	es2->usb_dev = udev;
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1281  	spin_lock_init(&es2->cport_out_urb_lock);
3be0e17d62d5a9 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27 @1282  	INIT_KFIFO(es2->apb_log_fifo);
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1283  	usb_set_intfdata(interface, es2);
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1284  
050615076699e5 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1285  	/*
050615076699e5 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1286  	 * Reserve the CDSI0 and CDSI1 CPorts so they won't be allocated
050615076699e5 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1287  	 * dynamically.
050615076699e5 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1288  	 */
050615076699e5 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1289  	retval = gb_hd_cport_reserve(hd, ES2_CPORT_CDSI0);
050615076699e5 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1290  	if (retval)
050615076699e5 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1291  		goto error;
050615076699e5 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1292  	retval = gb_hd_cport_reserve(hd, ES2_CPORT_CDSI1);
050615076699e5 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1293  	if (retval)
050615076699e5 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1294  		goto error;
050615076699e5 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1295  
4d5c446b53655d drivers/staging/greybus/es2.c    Johan Hovold       2015-11-02  1296  	/* find all bulk endpoints */
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1297  	iface_desc = interface->cur_altsetting;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1298  	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1299  		endpoint = &iface_desc->endpoint[i].desc;
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1300  		ep_addr = endpoint->bEndpointAddress;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1301  
b767ee402070ce drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2015-07-24  1302  		if (usb_endpoint_is_bulk_in(endpoint)) {
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1303  			if (!bulk_in_found) {
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1304  				es2->cport_in.endpoint = ep_addr;
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1305  				bulk_in_found = true;
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1306  			} else if (!arpc_in_found) {
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1307  				es2->arpc_endpoint_in = ep_addr;
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1308  				arpc_in_found = true;
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1309  			} else {
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1310  				dev_warn(&udev->dev,
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1311  					 "Unused bulk IN endpoint found: 0x%02x\n",
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1312  					 ep_addr);
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1313  			}
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1314  			continue;
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1315  		}
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1316  		if (usb_endpoint_is_bulk_out(endpoint)) {
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1317  			if (!bulk_out_found) {
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1318  				es2->cport_out_endpoint = ep_addr;
403074b50b66f1 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1319  				bulk_out_found = true;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1320  			} else {
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1321  				dev_warn(&udev->dev,
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1322  					 "Unused bulk OUT endpoint found: 0x%02x\n",
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1323  					 ep_addr);
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1324  			}
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1325  			continue;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1326  		}
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1327  		dev_warn(&udev->dev,
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1328  			 "Unknown endpoint type found, address 0x%02x\n",
272291008fc55e drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1329  			 ep_addr);
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1330  	}
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1331  	if (!bulk_in_found || !arpc_in_found || !bulk_out_found) {
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1332  		dev_err(&udev->dev, "Not enough endpoints found in device, aborting!\n");
be5d01f10bdb78 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1333  		retval = -ENODEV;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1334  		goto error;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1335  	}
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1336  
0ce68ce41779c3 drivers/staging/greybus/es2.c    Johan Hovold       2015-11-04  1337  	/* Allocate buffers for our cport in messages */
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1338  	for (i = 0; i < NUM_CPORT_IN_URB; ++i) {
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1339  		struct urb *urb;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1340  		u8 *buffer;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1341  
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1342  		urb = usb_alloc_urb(0, GFP_KERNEL);
be5d01f10bdb78 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1343  		if (!urb) {
be5d01f10bdb78 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1344  			retval = -ENOMEM;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1345  			goto error;
be5d01f10bdb78 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1346  		}
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1347  		es2->cport_in.urb[i] = urb;
5f62eab04ab7d7 drivers/staging/greybus/es2.c    Johan Hovold       2016-08-17  1348  
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1349  		buffer = kmalloc(ES2_GBUF_MSG_SIZE_MAX, GFP_KERNEL);
be5d01f10bdb78 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1350  		if (!buffer) {
be5d01f10bdb78 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1351  			retval = -ENOMEM;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1352  			goto error;
be5d01f10bdb78 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1353  		}
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1354  
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1355  		usb_fill_bulk_urb(urb, udev,
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1356  				  usb_rcvbulkpipe(udev, es2->cport_in.endpoint),
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1357  				  buffer, ES2_GBUF_MSG_SIZE_MAX,
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1358  				  cport_in_callback, hd);
5f62eab04ab7d7 drivers/staging/greybus/es2.c    Johan Hovold       2016-08-17  1359  
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1360  		es2->cport_in.buffer[i] = buffer;
606addd2847ccc drivers/staging/greybus/es2.c    Alexandre Bailon   2015-06-15  1361  	}
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1362  
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1363  	/* Allocate buffers for ARPC in messages */
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1364  	for (i = 0; i < NUM_ARPC_IN_URB; ++i) {
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1365  		struct urb *urb;
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1366  		u8 *buffer;
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1367  
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1368  		urb = usb_alloc_urb(0, GFP_KERNEL);
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1369  		if (!urb) {
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1370  			retval = -ENOMEM;
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1371  			goto error;
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1372  		}
5f62eab04ab7d7 drivers/staging/greybus/es2.c    Johan Hovold       2016-08-17  1373  		es2->arpc_urb[i] = urb;
5f62eab04ab7d7 drivers/staging/greybus/es2.c    Johan Hovold       2016-08-17  1374  
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1375  		buffer = kmalloc(ARPC_IN_SIZE_MAX, GFP_KERNEL);
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1376  		if (!buffer) {
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1377  			retval = -ENOMEM;
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1378  			goto error;
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1379  		}
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1380  
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1381  		usb_fill_bulk_urb(urb, udev,
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1382  				  usb_rcvbulkpipe(udev,
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1383  						  es2->arpc_endpoint_in),
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1384  				  buffer, ARPC_IN_SIZE_MAX,
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1385  				  arpc_in_callback, es2);
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1386  
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1387  		es2->arpc_buffer[i] = buffer;
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1388  	}
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1389  
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1390  	/* Allocate urbs for our CPort OUT messages */
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1391  	for (i = 0; i < NUM_CPORT_OUT_URB; ++i) {
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1392  		struct urb *urb;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1393  
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1394  		urb = usb_alloc_urb(0, GFP_KERNEL);
be5d01f10bdb78 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1395  		if (!urb) {
be5d01f10bdb78 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1396  			retval = -ENOMEM;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1397  			goto error;
be5d01f10bdb78 drivers/staging/greybus/es2.c    Johan Hovold       2016-05-11  1398  		}
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1399  
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1400  		es2->cport_out_urb[i] = urb;
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1401  		es2->cport_out_urb_busy[i] = false;	/* just to be anal */
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1402  	}
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1403  
3be0e17d62d5a9 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1404  	/* XXX We will need to rename this per APB */
3be0e17d62d5a9 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1405  	es2->apb_log_enable_dentry = debugfs_create_file("apb_log_enable",
563a8412c563cd drivers/staging/greybus/es2.c    Gioh Kim           2017-02-09  1406  							 0644,
4b1d82047ebbb1 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1407  							 gb_debugfs_get(), es2,
3be0e17d62d5a9 drivers/staging/greybus/es2.c    Alex Elder         2015-10-27  1408  							 &apb_log_enable_fops);
0ce68ce41779c3 drivers/staging/greybus/es2.c    Johan Hovold       2015-11-04  1409  
c14118a8411c4d drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1410  	INIT_LIST_HEAD(&es2->arpcs);
c14118a8411c4d drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1411  	spin_lock_init(&es2->arpc_lock);
c14118a8411c4d drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1412  
1305f2b2f52af5 drivers/staging/greybus/es2.c    Wei Yongjun        2016-10-19  1413  	retval = es2_arpc_in_enable(es2);
1305f2b2f52af5 drivers/staging/greybus/es2.c    Wei Yongjun        2016-10-19  1414  	if (retval)
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1415  		goto error;
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1416  
c1700479845bc3 drivers/staging/greybus/es2.c    Johan Hovold       2015-11-04  1417  	retval = gb_hd_add(hd);
c1700479845bc3 drivers/staging/greybus/es2.c    Johan Hovold       2015-11-04  1418  	if (retval)
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1419  		goto err_disable_arpc_in;
c1700479845bc3 drivers/staging/greybus/es2.c    Johan Hovold       2015-11-04  1420  
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1421  	retval = es2_cport_in_enable(es2, &es2->cport_in);
0ce68ce41779c3 drivers/staging/greybus/es2.c    Johan Hovold       2015-11-04  1422  	if (retval)
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1423  		goto err_hd_del;
0ce68ce41779c3 drivers/staging/greybus/es2.c    Johan Hovold       2015-11-04  1424  
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1425  	return 0;
57bc17ffc566de drivers/staging/greybus/es2.c    Johan Hovold       2015-11-04  1426  
7330c48ec09367 drivers/staging/greybus/es2.c    Greg Kroah-Hartman 2016-08-17  1427  err_hd_del:
c1700479845bc3 drivers/staging/greybus/es2.c    Johan Hovold       2015-11-04  1428  	gb_hd_del(hd);
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1429  err_disable_arpc_in:
9d9d3777a9db5c drivers/staging/greybus/es2.c    Alexandre Bailon   2016-07-07  1430  	es2_arpc_in_disable(es2);
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1431  error:
57bc17ffc566de drivers/staging/greybus/es2.c    Johan Hovold       2015-11-04  1432  	es2_destroy(es2);
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1433  
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1434  	return retval;
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1435  }
f587027e793cf8 drivers/staging/greybus/gb-es2.c Greg Kroah-Hartman 2015-01-21  1436  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

