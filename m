Return-Path: <linux-kernel+bounces-514780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C03A35B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC623ADA33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221312586C2;
	Fri, 14 Feb 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVAMCT6n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C12222B1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528638; cv=none; b=ShafJ7TW04xODiYUYlutdia8p2P4gbVgepgazFEqI0GhP+MXEKWtOh/P6IwyEQ1gwMOHLYzeCpM7fqv5Lr/tUy8XCVx28q9Bp0jt0BwKYfR4qfW2WpC04nSLi5KItyt++FqY7jlqg+jcWAVn5ianLzeBFFqGRWtcAnqdY2XbXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528638; c=relaxed/simple;
	bh=kAva56f6qZp6XFVL66Z2i5vc02q098e1Up3Oy+esCHk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RXGzY6WPit87pLcMZlGKu18jdfdFjXwQUnEWeXpgoN4T1OkhfwPAiJuuVCLjRL9EoC3GLlwyfSVkMvaHCZjPMwIHXcvngguO/GQwd9vGdmJSlXpDRAj2bRlZl5bbAEco9yofKeqm6MzWfJfJGD8lgcrNEQzfkSZB/5x85FMPx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVAMCT6n; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739528637; x=1771064637;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kAva56f6qZp6XFVL66Z2i5vc02q098e1Up3Oy+esCHk=;
  b=UVAMCT6nATDoOsGK2beqkeJXX0aRjkNYDDClbR79ltQOciftofyodn+I
   IESdlHbmhf8RQv3p9U0YA/FOLUCmDOcHyeYOOq5AUuAZX/qs2XiyuTAl8
   DOQOgCRVuY2sCOPur5/L7wYqbRx83m/WDw8uVXr+0NYe65aBNE+94loKs
   4KWIPgfIK+kW6oLb5Px/UGiogW3GCitgiSdZmxm0MpVk8Db3LnpmTBIqP
   SeUrSRfZHvaBBhiIR6bs0swuQ74Z5GUY14Czm+bUALlVzadxwAQ7Q6iWe
   Hh3bgnPEZnHTDuugOPxTWRTzG3x7lSmj7BLR4C2zY4zIU7V2nkrZ/vkY5
   Q==;
X-CSE-ConnectionGUID: LJweT9enRhW71xk2seQYkw==
X-CSE-MsgGUID: 7TPGe974T+yF8S6F2UGQWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="65623313"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="65623313"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 02:23:56 -0800
X-CSE-ConnectionGUID: DxjjD+SZR7+C2OEVtMLkkA==
X-CSE-MsgGUID: hNkPyUETTCCP1WVlA37yBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117550043"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Feb 2025 02:23:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tisrQ-0019OI-1k;
	Fri, 14 Feb 2025 10:23:52 +0000
Date: Fri, 14 Feb 2025 18:23:12 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gerecke <jason.gerecke@wacom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: drivers/input/touchscreen/wacom_w8001.c:637:29: warning: ' Pen'
 directive output may be truncated writing 4 bytes into a region of size
 between 1 and 64
Message-ID: <202502141827.HXdTfrgb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jason,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   128c8f96eb8638c060cd3532dc394d046ce64fe1
commit: 6c7cc1a29d1e679be4a98b01141f1ba491e5775e Input: wacom_w8001 - simplify device name generation
date:   9 months ago
config: sparc-randconfig-002-20241212 (https://download.01.org/0day-ci/archive/20250214/202502141827.HXdTfrgb-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502141827.HXdTfrgb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502141827.HXdTfrgb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/touchscreen/wacom_w8001.c: In function 'w8001_connect':
>> drivers/input/touchscreen/wacom_w8001.c:637:29: warning: ' Pen' directive output may be truncated writing 4 bytes into a region of size between 1 and 64 [-Wformat-truncation=]
     637 |                          "%s Pen", basename);
         |                             ^~~~
   drivers/input/touchscreen/wacom_w8001.c:636:17: note: 'snprintf' output between 5 and 68 bytes into a destination of size 64
     636 |                 snprintf(w8001->pen_name, sizeof(w8001->pen_name),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     637 |                          "%s Pen", basename);
         |                          ~~~~~~~~~~~~~~~~~~~
>> drivers/input/touchscreen/wacom_w8001.c:653:29: warning: ' Finger' directive output may be truncated writing 7 bytes into a region of size between 1 and 64 [-Wformat-truncation=]
     653 |                          "%s Finger", basename);
         |                             ^~~~~~~
   drivers/input/touchscreen/wacom_w8001.c:652:17: note: 'snprintf' output between 8 and 71 bytes into a destination of size 64
     652 |                 snprintf(w8001->pen_name, sizeof(w8001->pen_name),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     653 |                          "%s Finger", basename);
         |                          ~~~~~~~~~~~~~~~~~~~~~~


vim +637 drivers/input/touchscreen/wacom_w8001.c

   586	
   587	/*
   588	 * w8001_connect() is the routine that is called when someone adds a
   589	 * new serio device that supports the w8001 protocol and registers it as
   590	 * an input device.
   591	 */
   592	
   593	static int w8001_connect(struct serio *serio, struct serio_driver *drv)
   594	{
   595		struct w8001 *w8001;
   596		struct input_dev *input_dev_pen;
   597		struct input_dev *input_dev_touch;
   598		char basename[64] = "Wacom Serial";
   599		int err, err_pen, err_touch;
   600	
   601		w8001 = kzalloc(sizeof(struct w8001), GFP_KERNEL);
   602		input_dev_pen = input_allocate_device();
   603		input_dev_touch = input_allocate_device();
   604		if (!w8001 || !input_dev_pen || !input_dev_touch) {
   605			err = -ENOMEM;
   606			goto fail1;
   607		}
   608	
   609		w8001->serio = serio;
   610		w8001->pen_dev = input_dev_pen;
   611		w8001->touch_dev = input_dev_touch;
   612		mutex_init(&w8001->mutex);
   613		init_completion(&w8001->cmd_done);
   614		snprintf(w8001->phys, sizeof(w8001->phys), "%s/input0", serio->phys);
   615	
   616		serio_set_drvdata(serio, w8001);
   617		err = serio_open(serio, drv);
   618		if (err)
   619			goto fail2;
   620	
   621		err = w8001_detect(w8001);
   622		if (err)
   623			goto fail3;
   624	
   625		/* For backwards-compatibility we compose the basename based on
   626		 * capabilities and then just append the tool type
   627		 */
   628		err_pen = w8001_setup_pen(w8001, basename, sizeof(basename));
   629		err_touch = w8001_setup_touch(w8001, basename, sizeof(basename));
   630		if (err_pen && err_touch) {
   631			err = -ENXIO;
   632			goto fail3;
   633		}
   634	
   635		if (!err_pen) {
   636			snprintf(w8001->pen_name, sizeof(w8001->pen_name),
 > 637				 "%s Pen", basename);
   638			input_dev_pen->name = w8001->pen_name;
   639	
   640			w8001_set_devdata(input_dev_pen, w8001, serio);
   641	
   642			err = input_register_device(w8001->pen_dev);
   643			if (err)
   644				goto fail3;
   645		} else {
   646			input_free_device(input_dev_pen);
   647			input_dev_pen = NULL;
   648			w8001->pen_dev = NULL;
   649		}
   650	
   651		if (!err_touch) {
   652			snprintf(w8001->pen_name, sizeof(w8001->pen_name),
 > 653				 "%s Finger", basename);
   654			input_dev_touch->name = w8001->touch_name;
   655	
   656			w8001_set_devdata(input_dev_touch, w8001, serio);
   657	
   658			err = input_register_device(w8001->touch_dev);
   659			if (err)
   660				goto fail4;
   661		} else {
   662			input_free_device(input_dev_touch);
   663			input_dev_touch = NULL;
   664			w8001->touch_dev = NULL;
   665		}
   666	
   667		return 0;
   668	
   669	fail4:
   670		if (w8001->pen_dev)
   671			input_unregister_device(w8001->pen_dev);
   672	fail3:
   673		serio_close(serio);
   674	fail2:
   675		serio_set_drvdata(serio, NULL);
   676	fail1:
   677		input_free_device(input_dev_pen);
   678		input_free_device(input_dev_touch);
   679		kfree(w8001);
   680		return err;
   681	}
   682	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

