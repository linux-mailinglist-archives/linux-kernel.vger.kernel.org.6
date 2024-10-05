Return-Path: <linux-kernel+bounces-351746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC2C991597
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF5DB232FA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349701474A5;
	Sat,  5 Oct 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9kPhDbh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E95142E6F;
	Sat,  5 Oct 2024 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728121872; cv=none; b=bY2zVrFPJEtxNYFvgfgeAAzT5b9eA444beItTc591YNXlXV98s0WRCa+F/4LKtObCvmpxiuRwEJaRtFmPF2cPna+CAeiC2wbJArlvoCaMPeM071sFPwhILFM2Id9Tcqkqfo7VUTItCvetpywP9MPAokmnwXcKhcpUFLqgsgEToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728121872; c=relaxed/simple;
	bh=kLA0odstNUX+dbcYfoPiylpV9R0J+7jb1qHYbUsBU68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAsmzEUYjLFQZA2cLVn/0rElzIE+L3rSfDqqvZfh9bnLuEXqNdrlRjnfAO646x47oe5ZCPg1UBKuq/kz9o5AwUVSZXdo71mumrmdpIDgVWGFE+ajQrsjIgZqZqO+bnh3p7Z31F+TXYLF4NDlpVnv2AXRPoL4cK3zb9tOOs4U7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9kPhDbh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728121870; x=1759657870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kLA0odstNUX+dbcYfoPiylpV9R0J+7jb1qHYbUsBU68=;
  b=X9kPhDbhz5l+BFTy3WYEZFAgavloQKi8PM9jai1PkRR4u5XHPtQwSI+D
   efUtJ7PLDf0oX3LPeWte9HhKD09xplmBHTYQn6x3kccUL5OCW/RRlePTR
   73U8+jAawWXHDw3PcrPgjTGENHB80CT7NbZ+kOLgWG+c9C9I6k/LxRvPS
   NZBlhoK05dSWlKO9JDXwn2+JfNi8uYodUbuTHhCWozYlS+eYKyKlnzHPM
   Z0F7mKEBdMBLXdl56RShgtrRUf2yXVAixGOKy2roaJUgOJwXHu3/e2Ns9
   2DF8CAE+2k6By13zSvDaTvte74ZiST4Q3Wzfd1NecxcV+eVDRzt150xmd
   Q==;
X-CSE-ConnectionGUID: M++QQdq7SVyPNztuwcO09w==
X-CSE-MsgGUID: 6WBDTsFgRBe0ulGgqtk5mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37992121"
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="37992121"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 02:51:06 -0700
X-CSE-ConnectionGUID: iU31nSlSRWOU/KBA++aXuw==
X-CSE-MsgGUID: S2GH+0ENR1C/8cw/wIa4HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="75280981"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Oct 2024 02:51:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sx1RG-0002pK-2q;
	Sat, 05 Oct 2024 09:51:02 +0000
Date: Sat, 5 Oct 2024 17:50:33 +0800
From: kernel test robot <lkp@intel.com>
To: Manuel Quintero F <sakunix@yahoo.com>, duncan.sands@free.fr
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manuel Quintero F <sakunix@yahoo.com>
Subject: Re: [PATCH] USB: atm: speedtch: do not use assignment in if condition
Message-ID: <202410051738.GFfOxDuk-lkp@intel.com>
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241005/202410051738.GFfOxDuk-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410051738.GFfOxDuk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410051738.GFfOxDuk-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/usb/atm/speedtch.c: In function 'speedtch_upload_firmware':
>> drivers/usb/atm/speedtch.c:327:85: error: expected ')' before 'if'
     327 |         ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->params.altsetting
         |                                ~                                                    ^
         |                                                                                     )
     328 | 
     329 |         if (ret < 0) {
         |         ~~                                                                           
>> drivers/usb/atm/speedtch.c:346:20: error: expected ';' before '}' token
     346 |         return ret;
         |                    ^
         |                    ;
     347 | }
         | ~                   
>> drivers/usb/atm/speedtch.c:317:17: error: label 'out_free' used but not defined
     317 |                 goto out_free;
         |                 ^~~~
>> drivers/usb/atm/speedtch.c:247:17: error: label 'out' used but not defined
     247 |                 goto out;
         |                 ^~~~
>> drivers/usb/atm/speedtch.c:347:1: warning: no return statement in function returning non-void [-Wreturn-type]
     347 | }
         | ^
   drivers/usb/atm/speedtch.c: At top level:
>> drivers/usb/atm/speedtch.c:160:13: warning: 'speedtch_test_sequence' defined but not used [-Wunused-function]
     160 | static void speedtch_test_sequence(struct speedtch_instance_data *instance)
         |             ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/atm/speedtch.c:144:13: warning: 'speedtch_set_swbuff' defined but not used [-Wunused-function]
     144 | static void speedtch_set_swbuff(struct speedtch_instance_data *instance, int state)
         |             ^~~~~~~~~~~~~~~~~~~


vim +327 drivers/usb/atm/speedtch.c

   143	
 > 144	static void speedtch_set_swbuff(struct speedtch_instance_data *instance, int state)
   145	{
   146		struct usbatm_data *usbatm = instance->usbatm;
   147		struct usb_device *usb_dev = usbatm->usb_dev;
   148		int ret;
   149	
   150		ret = usb_control_msg(usb_dev, usb_sndctrlpipe(usb_dev, 0),
   151				      0x32, 0x40, state ? 0x01 : 0x00, 0x00, NULL, 0, CTRL_TIMEOUT);
   152		if (ret < 0)
   153			usb_warn(usbatm,
   154				 "%sabling SW buffering: usb_control_msg returned %d\n",
   155				 state ? "En" : "Dis", ret);
   156		else
   157			usb_dbg(usbatm, "speedtch_set_swbuff: %sbled SW buffering\n", state ? "En" : "Dis");
   158	}
   159	
 > 160	static void speedtch_test_sequence(struct speedtch_instance_data *instance)
   161	{
   162		struct usbatm_data *usbatm = instance->usbatm;
   163		struct usb_device *usb_dev = usbatm->usb_dev;
   164		unsigned char *buf = instance->scratch_buffer;
   165		int ret;
   166	
   167		/* URB 147 */
   168		buf[0] = 0x1c;
   169		buf[1] = 0x50;
   170		ret = usb_control_msg(usb_dev, usb_sndctrlpipe(usb_dev, 0),
   171				      0x01, 0x40, 0x0b, 0x00, buf, 2, CTRL_TIMEOUT);
   172		if (ret < 0)
   173			usb_warn(usbatm, "%s failed on URB147: %d\n", __func__, ret);
   174	
   175		/* URB 148 */
   176		buf[0] = 0x32;
   177		buf[1] = 0x00;
   178		ret = usb_control_msg(usb_dev, usb_sndctrlpipe(usb_dev, 0),
   179				      0x01, 0x40, 0x02, 0x00, buf, 2, CTRL_TIMEOUT);
   180		if (ret < 0)
   181			usb_warn(usbatm, "%s failed on URB148: %d\n", __func__, ret);
   182	
   183		/* URB 149 */
   184		buf[0] = 0x01;
   185		buf[1] = 0x00;
   186		buf[2] = 0x01;
   187		ret = usb_control_msg(usb_dev, usb_sndctrlpipe(usb_dev, 0),
   188				      0x01, 0x40, 0x03, 0x00, buf, 3, CTRL_TIMEOUT);
   189		if (ret < 0)
   190			usb_warn(usbatm, "%s failed on URB149: %d\n", __func__, ret);
   191	
   192		/* URB 150 */
   193		buf[0] = 0x01;
   194		buf[1] = 0x00;
   195		buf[2] = 0x01;
   196		ret = usb_control_msg(usb_dev, usb_sndctrlpipe(usb_dev, 0),
   197				      0x01, 0x40, 0x04, 0x00, buf, 3, CTRL_TIMEOUT);
   198		if (ret < 0)
   199			usb_warn(usbatm, "%s failed on URB150: %d\n", __func__, ret);
   200	
   201		/* Extra initialisation in recent drivers - gives higher speeds */
   202	
   203		/* URBext1 */
   204		buf[0] = instance->params.ModemMode;
   205		ret = usb_control_msg(usb_dev, usb_sndctrlpipe(usb_dev, 0),
   206				      0x01, 0x40, 0x11, 0x00, buf, 1, CTRL_TIMEOUT);
   207		if (ret < 0)
   208			usb_warn(usbatm, "%s failed on URBext1: %d\n", __func__, ret);
   209	
   210		/* URBext2 */
   211		/* This seems to be the one which actually triggers the higher sync
   212		   rate -- it does require the new firmware too, although it works OK
   213		   with older firmware */
   214		ret = usb_control_msg(usb_dev, usb_sndctrlpipe(usb_dev, 0),
   215				      0x01, 0x40, 0x14, 0x00,
   216				      instance->params.ModemOption,
   217				      MODEM_OPTION_LENGTH, CTRL_TIMEOUT);
   218		if (ret < 0)
   219			usb_warn(usbatm, "%s failed on URBext2: %d\n", __func__, ret);
   220	
   221		/* URBext3 */
   222		buf[0] = instance->params.BMaxDSL & 0xff;
   223		buf[1] = instance->params.BMaxDSL >> 8;
   224		ret = usb_control_msg(usb_dev, usb_sndctrlpipe(usb_dev, 0),
   225				      0x01, 0x40, 0x12, 0x00, buf, 2, CTRL_TIMEOUT);
   226		if (ret < 0)
   227			usb_warn(usbatm, "%s failed on URBext3: %d\n", __func__, ret);
   228	}
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
 > 247			goto out;
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
 > 317			goto out_free;
   318		}
   319	
   320		/* success */
   321		usb_dbg(usbatm, "%s: BLOCK4 downloaded (%d bytes)\n", __func__, actual_length);
   322	
   323		/* Delay to allow firmware to start up. We can do this here
   324		   because we're in our own kernel thread anyway. */
   325		msleep_interruptible(1000);
   326	
 > 327		ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->params.altsetting
   328	
   329		if (ret < 0) {
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
 > 346		return ret;
 > 347	}
   348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

