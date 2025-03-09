Return-Path: <linux-kernel+bounces-553155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9150A584EB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB9516AF57
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4741DE2C0;
	Sun,  9 Mar 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8ewZFu4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E96326ACB
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741530728; cv=none; b=ZKuankcDWrW4wEH3fFF4p5uDFMGYbItB3w4qOTZfjUbOkte8KS/3eGyUL9qELmsUgaM00rkJnufF1nkrejY8y2ZqFzT3dDDVmQ1wkc0vjxu6Xl9q+QOAuQuOSdXFPLt2vIzJYnHAJK7M1KdqeczbWRdNaeQb9PDtpY2cE6TpREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741530728; c=relaxed/simple;
	bh=bM8KgHA9rXTFzkZz2YUyXVCXsDpEbBTTpxv7YveLWAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MmG98n1OGWlri48PzX0qznjTtUdO6iLg+i5ENDyJcwHotiMcrk6kIcZhqry01koqjaaLq6uWPULjRDfv6njsdNyW+RWJbIAv4t3zneuPuvEBm4emscU2PqctJiVs9QYsaffeNBu+RkyDKr1OuUFd4722kU4CbYVqBCUfcosCCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8ewZFu4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741530727; x=1773066727;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bM8KgHA9rXTFzkZz2YUyXVCXsDpEbBTTpxv7YveLWAU=;
  b=l8ewZFu4jrdTsfV9oL6cfv3tMohadhUAPS02oTopvWJmNQM1ByxJYG/i
   nhlGxgbem9mYu00/ikVaBnlgGQRDoH5F6mJm/X0sORlOnGQyUWQ9IkLMC
   GikRFHLJ0c6tZEsfGjISJ/a2x4fEEAWu+tRSZUwfRtWVn5NbshbdsABG6
   bVbN0d+IIotV+KkmnRPLR9F3nKmIoDO5dLAnn2/Aj0rdHZ9+MySZ6yheq
   /vQ9YmI+tU6kAT11qREzG5LP1ZZ+TbPT4l2F+TGmL+yWMM6DtmIfmu4eU
   xb790/OQaNJSW+Bl2lC55ffofQJsXxalBS2N6/1BIj5kCtE3crXYr3qt4
   w==;
X-CSE-ConnectionGUID: YqapgdiZRI6ikOfvfrNiuA==
X-CSE-MsgGUID: zFDxV2+cRbGjPzsLaGy0rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="59938739"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="59938739"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 07:32:06 -0700
X-CSE-ConnectionGUID: xXM4is8+QW691AlE3zMhng==
X-CSE-MsgGUID: 3uOXxDMGTV2CzwqEKsPaQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123947084"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 09 Mar 2025 07:32:04 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trHhC-0003BS-0X;
	Sun, 09 Mar 2025 14:32:02 +0000
Date: Sun, 9 Mar 2025 22:31:39 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gerecke <jason.gerecke@wacom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: drivers/input/touchscreen/wacom_w8001.c:637:29: warning: ' Pen'
 directive output may be truncated writing 4 bytes into a region of size
 between 1 and 64
Message-ID: <202503092244.Ets7kUrD-lkp@intel.com>
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
head:   1110ce6a1e34fe1fdc1bfe4ad52405f327d5083b
commit: 6c7cc1a29d1e679be4a98b01141f1ba491e5775e Input: wacom_w8001 - simplify device name generation
date:   9 months ago
config: sparc-randconfig-002-20241212 (https://download.01.org/0day-ci/archive/20250309/202503092244.Ets7kUrD-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503092244.Ets7kUrD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503092244.Ets7kUrD-lkp@intel.com/

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

