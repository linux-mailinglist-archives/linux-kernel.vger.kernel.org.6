Return-Path: <linux-kernel+bounces-350082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C03BC98FF82
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C24B22643
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39756145B11;
	Fri,  4 Oct 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c93FEcvV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E539139D0B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033795; cv=none; b=GH+Mfe1JmEDulBnPce6mBDQW+tObXvtr7zT2JzyWoLSHBazwwpSBqnRzuU3lA2/Lp+Uj+j6aLXPZTZGD4KRO/2UvmtPtti8JUt3gyC1Hq+mB8KwZB2p0OVVERoudj0YzQtpV+U5lER2vA9kBR9JuAK5uwoXCppG8rNi23YEISoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033795; c=relaxed/simple;
	bh=wmErVoH5MClNc/3tj+BU9BF8TY8YvrPak27M0SZtA4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqtbF2BQoZJlPFSkQKbkYdbnGjyfiwpX7wbUzvWBXj4NjR5vUG0kEmCOiWBAOMbXun/lzP51Xabl3i4whQI77f+aSSQAaz6ZWJbXPCkJHWFBTqZUP2waUPGSSHCnvF9OxohvfJ7jQ84eO+1PBZM+KtH4vEGSn0SXMPL5zWcm5dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c93FEcvV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728033793; x=1759569793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wmErVoH5MClNc/3tj+BU9BF8TY8YvrPak27M0SZtA4w=;
  b=c93FEcvVSroyzfeu1mTWfXlacNuaBCeA6A8TlM/DvLS7Mupk/kwhYPBR
   FmcANWTqiXu+cHKYgVpQSplrpB8zEpAt3DzHdhl8xrW/gj3DaasQqSUXo
   NI+NnZcjvVNfoVpscEJ6ay5DWZjvYYe8famuuxWHcLsaVc5jjlRZ4zsoW
   JB0/dHmqyvmwatPRYHS3kXEz2qzcefHPsdmccUOmkwGbl6iJeJkrMiORx
   drV1WYVA/m2qyXR4tv9JpKxBsh3tZOXh7w6DavEALdTBRqfLKwo0KjczL
   2Lg2+tpzOFh8uPONxJ3vSjHrVML3hvuXnWGjU+sNyYcRg/T8Dvr58fRPR
   w==;
X-CSE-ConnectionGUID: ppGxjCV5TFaUf6YpOv+Ufw==
X-CSE-MsgGUID: +n2yWRSjSk2AE3mLGjmwMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37854683"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="37854683"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:23:12 -0700
X-CSE-ConnectionGUID: HbRin4GQTsq7rVQRQ1VQxg==
X-CSE-MsgGUID: 1ebmCpkPSmW/y8U/E7szYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74479269"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Oct 2024 02:23:11 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sweWi-0001Pt-1a;
	Fri, 04 Oct 2024 09:23:08 +0000
Date: Fri, 4 Oct 2024 17:22:50 +0800
From: kernel test robot <lkp@intel.com>
To: Xiaofeng Lian <1198715581lxf@gmail.com>, stefani@seibold.net,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Xiaofeng Lian <1198715581lxf@gmail.com>
Subject: Re: [PATCH] include/linux/kfifo.h
Message-ID: <202410041702.fCzWLtzn-lkp@intel.com>
References: <20241002161437.376042-1-1198715581lxf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002161437.376042-1-1198715581lxf@gmail.com>

Hi Xiaofeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaofeng-Lian/include-linux-kfifo-h/20241003-002015
base:   linus/master
patch link:    https://lore.kernel.org/r/20241002161437.376042-1-1198715581lxf%40gmail.com
patch subject: [PATCH] include/linux/kfifo.h
config: x86_64-buildonly-randconfig-002-20241004 (https://download.01.org/0day-ci/archive/20241004/202410041702.fCzWLtzn-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410041702.fCzWLtzn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410041702.fCzWLtzn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/crypto/hisilicon/sec/sec_drv.h:8,
                    from drivers/crypto/hisilicon/sec/sec_algs.c:17:
   drivers/crypto/hisilicon/sec/sec_algs.c: In function 'sec_alg_skcipher_init_with_queue':
>> include/linux/kfifo.h:130:49: error: '*(struct sec_request_el **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:61:17: note: in definition of macro '__STRUCT_KFIFO_COMMON'
      61 |                 datatype        *type; \
         |                 ^~~~~~~~
   include/linux/kfifo.h:84:16: note: in expansion of macro '__STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ^~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:116:41: note: in expansion of macro 'STRUCT_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:17: note: in expansion of macro 'DECLARE_KFIFO_PTR'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:48: note: in expansion of macro 'get_stack_data_type'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/crypto/hisilicon/sec/sec_algs.c:912:9: note: in expansion of macro 'INIT_KFIFO'
     912 |         INIT_KFIFO(ctx->queue->softqueue);
         |         ^~~~~~~~~~
>> include/linux/kfifo.h:130:49: error: '*(struct sec_request_el **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:62:23: note: in definition of macro '__STRUCT_KFIFO_COMMON'
      62 |                 const datatype  *const_type; \
         |                       ^~~~~~~~
   include/linux/kfifo.h:84:16: note: in expansion of macro '__STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ^~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:116:41: note: in expansion of macro 'STRUCT_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:17: note: in expansion of macro 'DECLARE_KFIFO_PTR'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:48: note: in expansion of macro 'get_stack_data_type'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/crypto/hisilicon/sec/sec_algs.c:912:9: note: in expansion of macro 'INIT_KFIFO'
     912 |         INIT_KFIFO(ctx->queue->softqueue);
         |         ^~~~~~~~~~
>> include/linux/kfifo.h:130:49: error: '*(struct sec_request_el **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:64:17: note: in definition of macro '__STRUCT_KFIFO_COMMON'
      64 |                 ptrtype         *ptr; \
         |                 ^~~~~~~
   include/linux/kfifo.h:84:16: note: in expansion of macro '__STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ^~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:116:41: note: in expansion of macro 'STRUCT_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:17: note: in expansion of macro 'DECLARE_KFIFO_PTR'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:48: note: in expansion of macro 'get_stack_data_type'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/crypto/hisilicon/sec/sec_algs.c:912:9: note: in expansion of macro 'INIT_KFIFO'
     912 |         INIT_KFIFO(ctx->queue->softqueue);
         |         ^~~~~~~~~~
>> include/linux/kfifo.h:130:49: error: '*(struct sec_request_el **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:65:17: note: in definition of macro '__STRUCT_KFIFO_COMMON'
      65 |                 ptrtype const   *ptr_const; \
         |                 ^~~~~~~
   include/linux/kfifo.h:84:16: note: in expansion of macro '__STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ^~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:116:41: note: in expansion of macro 'STRUCT_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:17: note: in expansion of macro 'DECLARE_KFIFO_PTR'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:48: note: in expansion of macro 'get_stack_data_type'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/crypto/hisilicon/sec/sec_algs.c:912:9: note: in expansion of macro 'INIT_KFIFO'
     912 |         INIT_KFIFO(ctx->queue->softqueue);
         |         ^~~~~~~~~~
>> include/linux/kfifo.h:130:49: error: '*(struct sec_request_el **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:80:9: note: in definition of macro '__STRUCT_KFIFO_PTR'
      80 |         type            buf[0]; \
         |         ^~~~
   include/linux/kfifo.h:116:41: note: in expansion of macro 'STRUCT_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:17: note: in expansion of macro 'DECLARE_KFIFO_PTR'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:48: note: in expansion of macro 'get_stack_data_type'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/crypto/hisilicon/sec/sec_algs.c:912:9: note: in expansion of macro 'INIT_KFIFO'
     912 |         INIT_KFIFO(ctx->queue->softqueue);
         |         ^~~~~~~~~~
>> include/linux/kfifo.h:130:49: error: '*(struct sec_request_el **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:139:66: note: in expansion of macro 'get_stack_data_type'
     139 |                 (sizeof(*(fifo)) - sizeof(__tmp_stack)) / sizeof(get_stack_data_type(fifo));\
         |                                                                  ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/crypto/hisilicon/sec/sec_algs.c:912:9: note: in expansion of macro 'INIT_KFIFO'
     912 |         INIT_KFIFO(ctx->queue->softqueue);
         |         ^~~~~~~~~~
--
   In file included from drivers/gpu/drm/sun4i/sun4i_drv.c:11:
   drivers/gpu/drm/sun4i/sun4i_drv.c: In function 'sun4i_drv_probe':
>> include/linux/kfifo.h:130:49: error: '*(struct device_node **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:61:17: note: in definition of macro '__STRUCT_KFIFO_COMMON'
      61 |                 datatype        *type; \
         |                 ^~~~~~~~
   include/linux/kfifo.h:84:16: note: in expansion of macro '__STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ^~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:116:41: note: in expansion of macro 'STRUCT_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:17: note: in expansion of macro 'DECLARE_KFIFO_PTR'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:48: note: in expansion of macro 'get_stack_data_type'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/gpu/drm/sun4i/sun4i_drv.c:372:9: note: in expansion of macro 'INIT_KFIFO'
     372 |         INIT_KFIFO(list.fifo);
         |         ^~~~~~~~~~
>> include/linux/kfifo.h:130:49: error: '*(struct device_node **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:62:23: note: in definition of macro '__STRUCT_KFIFO_COMMON'
      62 |                 const datatype  *const_type; \
         |                       ^~~~~~~~
   include/linux/kfifo.h:84:16: note: in expansion of macro '__STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ^~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:116:41: note: in expansion of macro 'STRUCT_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:17: note: in expansion of macro 'DECLARE_KFIFO_PTR'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:48: note: in expansion of macro 'get_stack_data_type'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/gpu/drm/sun4i/sun4i_drv.c:372:9: note: in expansion of macro 'INIT_KFIFO'
     372 |         INIT_KFIFO(list.fifo);
         |         ^~~~~~~~~~
>> include/linux/kfifo.h:130:49: error: '*(struct device_node **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:64:17: note: in definition of macro '__STRUCT_KFIFO_COMMON'
      64 |                 ptrtype         *ptr; \
         |                 ^~~~~~~
   include/linux/kfifo.h:84:16: note: in expansion of macro '__STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ^~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:116:41: note: in expansion of macro 'STRUCT_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:17: note: in expansion of macro 'DECLARE_KFIFO_PTR'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:48: note: in expansion of macro 'get_stack_data_type'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/gpu/drm/sun4i/sun4i_drv.c:372:9: note: in expansion of macro 'INIT_KFIFO'
     372 |         INIT_KFIFO(list.fifo);
         |         ^~~~~~~~~~
>> include/linux/kfifo.h:130:49: error: '*(struct device_node **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:65:17: note: in definition of macro '__STRUCT_KFIFO_COMMON'
      65 |                 ptrtype const   *ptr_const; \
         |                 ^~~~~~~
   include/linux/kfifo.h:84:16: note: in expansion of macro '__STRUCT_KFIFO_PTR'
      84 |         struct __STRUCT_KFIFO_PTR(type, 0, type)
         |                ^~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:116:41: note: in expansion of macro 'STRUCT_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:17: note: in expansion of macro 'DECLARE_KFIFO_PTR'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:48: note: in expansion of macro 'get_stack_data_type'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/gpu/drm/sun4i/sun4i_drv.c:372:9: note: in expansion of macro 'INIT_KFIFO'
     372 |         INIT_KFIFO(list.fifo);
         |         ^~~~~~~~~~
>> include/linux/kfifo.h:130:49: error: '*(struct device_node **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:80:9: note: in definition of macro '__STRUCT_KFIFO_PTR'
      80 |         type            buf[0]; \
         |         ^~~~
   include/linux/kfifo.h:116:41: note: in expansion of macro 'STRUCT_KFIFO_PTR'
     116 | #define DECLARE_KFIFO_PTR(fifo, type)   STRUCT_KFIFO_PTR(type) fifo
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:17: note: in expansion of macro 'DECLARE_KFIFO_PTR'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                 ^~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:138:48: note: in expansion of macro 'get_stack_data_type'
     138 |                 DECLARE_KFIFO_PTR(__tmp_stack, get_stack_data_type(fifo));\
         |                                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/gpu/drm/sun4i/sun4i_drv.c:372:9: note: in expansion of macro 'INIT_KFIFO'
     372 |         INIT_KFIFO(list.fifo);
         |         ^~~~~~~~~~
>> include/linux/kfifo.h:130:49: error: '*(struct device_node **)&__tmp->buf' is a pointer; did you mean to use '->'?
     130 | #define get_stack_data_type(fifo) typeof(*(fifo)->type)
         |                                                 ^~
   include/linux/kfifo.h:139:66: note: in expansion of macro 'get_stack_data_type'
     139 |                 (sizeof(*(fifo)) - sizeof(__tmp_stack)) / sizeof(get_stack_data_type(fifo));\
         |                                                                  ^~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:151:53: note: in expansion of macro '__STACK_SIZE'
     151 |         __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : __STACK_SIZE(__tmp->buf) - 1;\
         |                                                     ^~~~~~~~~~~~
   drivers/gpu/drm/sun4i/sun4i_drv.c:372:9: note: in expansion of macro 'INIT_KFIFO'
     372 |         INIT_KFIFO(list.fifo);
         |         ^~~~~~~~~~


vim +130 include/linux/kfifo.h

   125	
   126	/**
   127	 * get_kfifo_data_type - macro to get type of kfifo's member
   128	 * @fifo: pointer of kfifo
   129	 */
 > 130	#define get_stack_data_type(fifo) typeof(*(fifo)->type)
   131	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

