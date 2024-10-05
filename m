Return-Path: <linux-kernel+bounces-351745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE414991594
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B882A2848E1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5760A13BAFA;
	Sat,  5 Oct 2024 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8rF92V8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC913BC02;
	Sat,  5 Oct 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728121870; cv=none; b=qHTfboKxnU7VrAakykGm+h8dWt0D3AQzmHNIjXXFLR7On0vH9DmuVukHPzrGvJpnkV4lMKoN4Z0YCrRzvRlqLWa6MC5IDmWa/6rz1S+ht7pJ35PVndjH2/Tt2sh7ba8A6HCVMx7vmd+oNtglZqbbt2536k80bfL7ByxdXeFH/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728121870; c=relaxed/simple;
	bh=fGd/ccuej3lJsMcCPKlwNfu7PMq5MKOFnHvd63r1bLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaNJg0QJrciCMZhgQQ5BslJUBGkMqWiXzPJ5L+BM6zXlxgbY63Csdg2MOLLjcv3klJPh8xy87U/yti46xV7ZWksEVJVaqnsNaZkZch4h0bFtIQXpfPO6+Za/5vCDYP46j2os+pjnMlIW+BqXllm2oN3JHk5WL9b6elhfYQufn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8rF92V8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728121867; x=1759657867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fGd/ccuej3lJsMcCPKlwNfu7PMq5MKOFnHvd63r1bLA=;
  b=W8rF92V8jSMw3qXKEed/Ddim5G7u1i911TtydlReiNOORV67QbKNc+s6
   2yv+Zd5apf/gwSVTDPmII4dwLb8KTW8jyX1QnBOTJCkSsOCCXXQrvbFlY
   EDq/qfhib055cSBqgdZsuNFGZaqI6+vbebIC0adFYQSbA2SWNDyclWB3J
   hnFGusrA8QilP4lXPfasyqvVsDlcJkx14DGBr190HtWbciwr7cltGLY/D
   8hUn71Ke1zsLXkb6LzcE8e25+dMklgHd1RXMkGdsm22270LoyEZOKOR81
   NixgjaOK25gB9VFC5CmwDT6s7kul/hXdgpk2DVqFna7dUw5KFjrBHsMo3
   A==;
X-CSE-ConnectionGUID: R+V2c0nKQvya0Msj+h4x+w==
X-CSE-MsgGUID: cD0xt0RNRB6qTo6Bfgadeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37992117"
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="37992117"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 02:51:06 -0700
X-CSE-ConnectionGUID: XxIofd7kTt6ej87I7+9HgA==
X-CSE-MsgGUID: OH6j2RhTThms2FL9MpojyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="75280979"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Oct 2024 02:51:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sx1RG-0002pN-2w;
	Sat, 05 Oct 2024 09:51:02 +0000
Date: Sat, 5 Oct 2024 17:50:34 +0800
From: kernel test robot <lkp@intel.com>
To: Manuel Quintero F <sakunix@yahoo.com>, duncan.sands@free.fr
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manuel Quintero F <sakunix@yahoo.com>
Subject: Re: [PATCH] USB: atm: speedtch: do not use assignment in if condition
Message-ID: <202410051744.I4PVYrMx-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manuel-Quintero-F/USB-atm-speedtch-do-not-use-assignment-in-if-condition/20241004-113643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20241004030512.2036-1-sakunix%40yahoo.com
patch subject: [PATCH] USB: atm: speedtch: do not use assignment in if condition
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241005/202410051744.I4PVYrMx-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410051744.I4PVYrMx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410051744.I4PVYrMx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/atm/speedtch.c: In function 'speedtch_upload_firmware':
   drivers/usb/atm/speedtch.c:327:85: error: expected ')' before 'if'
     327 |         ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->params.altsetting
         |                                ~                                                    ^
         |                                                                                     )
     328 | 
     329 |         if (ret < 0) {
         |         ~~                                                                           
   drivers/usb/atm/speedtch.c:346:20: error: expected ';' before '}' token
     346 |         return ret;
         |                    ^
         |                    ;
     347 | }
         | ~                   
   drivers/usb/atm/speedtch.c:317:17: error: label 'out_free' used but not defined
     317 |                 goto out_free;
         |                 ^~~~
   drivers/usb/atm/speedtch.c:247:17: error: label 'out' used but not defined
     247 |                 goto out;
         |                 ^~~~
>> drivers/usb/atm/speedtch.c:347:1: warning: control reaches end of non-void function [-Wreturn-type]
     347 | }
         | ^
   drivers/usb/atm/speedtch.c: At top level:
   drivers/usb/atm/speedtch.c:160:13: warning: 'speedtch_test_sequence' defined but not used [-Wunused-function]
     160 | static void speedtch_test_sequence(struct speedtch_instance_data *instance)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/atm/speedtch.c:144:13: warning: 'speedtch_set_swbuff' defined but not used [-Wunused-function]
     144 | static void speedtch_set_swbuff(struct speedtch_instance_data *instance, int state)
         |             ^~~~~~~~~~~~~~~~~~~


vim +347 drivers/usb/atm/speedtch.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  229  
48da7267ff1631 Duncan Sands       2005-05-11  230  static int speedtch_upload_firmware(struct speedtch_instance_data *instance,
48da7267ff1631 Duncan Sands       2005-05-11  231  				     const struct firmware *fw1,
48da7267ff1631 Duncan Sands       2005-05-11  232  				     const struct firmware *fw2)
^1da177e4c3f41 Linus Torvalds     2005-04-16  233  {
48da7267ff1631 Duncan Sands       2005-05-11  234  	unsigned char *buffer;
48da7267ff1631 Duncan Sands       2005-05-11  235  	struct usbatm_data *usbatm = instance->usbatm;
48da7267ff1631 Duncan Sands       2005-05-11  236  	struct usb_device *usb_dev = usbatm->usb_dev;
48da7267ff1631 Duncan Sands       2005-05-11  237  	int actual_length;
48da7267ff1631 Duncan Sands       2005-05-11  238  	int ret = 0;
48da7267ff1631 Duncan Sands       2005-05-11  239  	int offset;
48da7267ff1631 Duncan Sands       2005-05-11  240  
48da7267ff1631 Duncan Sands       2005-05-11  241  	usb_dbg(usbatm, "%s entered\n", __func__);
48da7267ff1631 Duncan Sands       2005-05-11  242  
3383ee4c3abf2e Greg Kroah-Hartman 2015-04-30  243  	buffer = (unsigned char *)__get_free_page(GFP_KERNEL);
3383ee4c3abf2e Greg Kroah-Hartman 2015-04-30  244  	if (!buffer) {
48da7267ff1631 Duncan Sands       2005-05-11  245  		ret = -ENOMEM;
48da7267ff1631 Duncan Sands       2005-05-11  246  		usb_dbg(usbatm, "%s: no memory for buffer!\n", __func__);
48da7267ff1631 Duncan Sands       2005-05-11  247  		goto out;
48da7267ff1631 Duncan Sands       2005-05-11  248  	}
48da7267ff1631 Duncan Sands       2005-05-11  249  
011db815231f40 Micah Gruber       2007-09-05  250  	if (!usb_ifnum_to_if(usb_dev, 2)) {
48da7267ff1631 Duncan Sands       2005-05-11  251  		ret = -ENODEV;
48da7267ff1631 Duncan Sands       2005-05-11  252  		usb_dbg(usbatm, "%s: interface not found!\n", __func__);
48da7267ff1631 Duncan Sands       2005-05-11  253  		goto out_free;
48da7267ff1631 Duncan Sands       2005-05-11  254  	}
48da7267ff1631 Duncan Sands       2005-05-11  255  
48da7267ff1631 Duncan Sands       2005-05-11  256  	/* URB 7 */
48da7267ff1631 Duncan Sands       2005-05-11  257  	if (dl_512_first) {	/* some modems need a read before writing the firmware */
48da7267ff1631 Duncan Sands       2005-05-11  258  		ret = usb_bulk_msg(usb_dev, usb_rcvbulkpipe(usb_dev, ENDPOINT_FIRMWARE),
48da7267ff1631 Duncan Sands       2005-05-11  259  				   buffer, 0x200, &actual_length, 2000);
48da7267ff1631 Duncan Sands       2005-05-11  260  
48da7267ff1631 Duncan Sands       2005-05-11  261  		if (ret < 0 && ret != -ETIMEDOUT)
0ec3c7e856319b Duncan Sands       2006-01-17  262  			usb_warn(usbatm, "%s: read BLOCK0 from modem failed (%d)!\n", __func__, ret);
48da7267ff1631 Duncan Sands       2005-05-11  263  		else
48da7267ff1631 Duncan Sands       2005-05-11  264  			usb_dbg(usbatm, "%s: BLOCK0 downloaded (%d bytes)\n", __func__, ret);
48da7267ff1631 Duncan Sands       2005-05-11  265  	}
48da7267ff1631 Duncan Sands       2005-05-11  266  
48da7267ff1631 Duncan Sands       2005-05-11  267  	/* URB 8 : both leds are static green */
48da7267ff1631 Duncan Sands       2005-05-11  268  	for (offset = 0; offset < fw1->size; offset += PAGE_SIZE) {
48da7267ff1631 Duncan Sands       2005-05-11  269  		int thislen = min_t(int, PAGE_SIZE, fw1->size - offset);
48da7267ff1631 Duncan Sands       2005-05-11  270  		memcpy(buffer, fw1->data + offset, thislen);
48da7267ff1631 Duncan Sands       2005-05-11  271  
48da7267ff1631 Duncan Sands       2005-05-11  272  		ret = usb_bulk_msg(usb_dev, usb_sndbulkpipe(usb_dev, ENDPOINT_FIRMWARE),
48da7267ff1631 Duncan Sands       2005-05-11  273  				   buffer, thislen, &actual_length, DATA_TIMEOUT);
48da7267ff1631 Duncan Sands       2005-05-11  274  
48da7267ff1631 Duncan Sands       2005-05-11  275  		if (ret < 0) {
0ec3c7e856319b Duncan Sands       2006-01-17  276  			usb_err(usbatm, "%s: write BLOCK1 to modem failed (%d)!\n", __func__, ret);
48da7267ff1631 Duncan Sands       2005-05-11  277  			goto out_free;
48da7267ff1631 Duncan Sands       2005-05-11  278  		}
48da7267ff1631 Duncan Sands       2005-05-11  279  		usb_dbg(usbatm, "%s: BLOCK1 uploaded (%zu bytes)\n", __func__, fw1->size);
48da7267ff1631 Duncan Sands       2005-05-11  280  	}
48da7267ff1631 Duncan Sands       2005-05-11  281  
48da7267ff1631 Duncan Sands       2005-05-11  282  	/* USB led blinking green, ADSL led off */
48da7267ff1631 Duncan Sands       2005-05-11  283  
48da7267ff1631 Duncan Sands       2005-05-11  284  	/* URB 11 */
48da7267ff1631 Duncan Sands       2005-05-11  285  	ret = usb_bulk_msg(usb_dev, usb_rcvbulkpipe(usb_dev, ENDPOINT_FIRMWARE),
48da7267ff1631 Duncan Sands       2005-05-11  286  			   buffer, 0x200, &actual_length, DATA_TIMEOUT);
48da7267ff1631 Duncan Sands       2005-05-11  287  
48da7267ff1631 Duncan Sands       2005-05-11  288  	if (ret < 0) {
0ec3c7e856319b Duncan Sands       2006-01-17  289  		usb_err(usbatm, "%s: read BLOCK2 from modem failed (%d)!\n", __func__, ret);
48da7267ff1631 Duncan Sands       2005-05-11  290  		goto out_free;
48da7267ff1631 Duncan Sands       2005-05-11  291  	}
48da7267ff1631 Duncan Sands       2005-05-11  292  	usb_dbg(usbatm, "%s: BLOCK2 downloaded (%d bytes)\n", __func__, actual_length);
48da7267ff1631 Duncan Sands       2005-05-11  293  
48da7267ff1631 Duncan Sands       2005-05-11  294  	/* URBs 12 to 139 - USB led blinking green, ADSL led off */
48da7267ff1631 Duncan Sands       2005-05-11  295  	for (offset = 0; offset < fw2->size; offset += PAGE_SIZE) {
48da7267ff1631 Duncan Sands       2005-05-11  296  		int thislen = min_t(int, PAGE_SIZE, fw2->size - offset);
48da7267ff1631 Duncan Sands       2005-05-11  297  		memcpy(buffer, fw2->data + offset, thislen);
48da7267ff1631 Duncan Sands       2005-05-11  298  
48da7267ff1631 Duncan Sands       2005-05-11  299  		ret = usb_bulk_msg(usb_dev, usb_sndbulkpipe(usb_dev, ENDPOINT_FIRMWARE),
48da7267ff1631 Duncan Sands       2005-05-11  300  				   buffer, thislen, &actual_length, DATA_TIMEOUT);
48da7267ff1631 Duncan Sands       2005-05-11  301  
48da7267ff1631 Duncan Sands       2005-05-11  302  		if (ret < 0) {
0ec3c7e856319b Duncan Sands       2006-01-17  303  			usb_err(usbatm, "%s: write BLOCK3 to modem failed (%d)!\n", __func__, ret);
48da7267ff1631 Duncan Sands       2005-05-11  304  			goto out_free;
48da7267ff1631 Duncan Sands       2005-05-11  305  		}
48da7267ff1631 Duncan Sands       2005-05-11  306  	}
48da7267ff1631 Duncan Sands       2005-05-11  307  	usb_dbg(usbatm, "%s: BLOCK3 uploaded (%zu bytes)\n", __func__, fw2->size);
48da7267ff1631 Duncan Sands       2005-05-11  308  
48da7267ff1631 Duncan Sands       2005-05-11  309  	/* USB led static green, ADSL led static red */
48da7267ff1631 Duncan Sands       2005-05-11  310  
48da7267ff1631 Duncan Sands       2005-05-11  311  	/* URB 142 */
48da7267ff1631 Duncan Sands       2005-05-11  312  	ret = usb_bulk_msg(usb_dev, usb_rcvbulkpipe(usb_dev, ENDPOINT_FIRMWARE),
48da7267ff1631 Duncan Sands       2005-05-11  313  			   buffer, 0x200, &actual_length, DATA_TIMEOUT);
^1da177e4c3f41 Linus Torvalds     2005-04-16  314  
^1da177e4c3f41 Linus Torvalds     2005-04-16  315  	if (ret < 0) {
0ec3c7e856319b Duncan Sands       2006-01-17  316  		usb_err(usbatm, "%s: read BLOCK4 from modem failed (%d)!\n", __func__, ret);
48da7267ff1631 Duncan Sands       2005-05-11  317  		goto out_free;
48da7267ff1631 Duncan Sands       2005-05-11  318  	}
48da7267ff1631 Duncan Sands       2005-05-11  319  
48da7267ff1631 Duncan Sands       2005-05-11  320  	/* success */
48da7267ff1631 Duncan Sands       2005-05-11  321  	usb_dbg(usbatm, "%s: BLOCK4 downloaded (%d bytes)\n", __func__, actual_length);
48da7267ff1631 Duncan Sands       2005-05-11  322  
48da7267ff1631 Duncan Sands       2005-05-11  323  	/* Delay to allow firmware to start up. We can do this here
48da7267ff1631 Duncan Sands       2005-05-11  324  	   because we're in our own kernel thread anyway. */
48da7267ff1631 Duncan Sands       2005-05-11  325  	msleep_interruptible(1000);
48da7267ff1631 Duncan Sands       2005-05-11  326  
a23b48ae442d5f Manuel Quintero F  2024-10-03  327  	ret = usb_set_interface(usb_dev, INTERFACE_DATA, instance->params.altsetting
a23b48ae442d5f Manuel Quintero F  2024-10-03  328  
a23b48ae442d5f Manuel Quintero F  2024-10-03  329  	if (ret < 0) {
6a4f1b41357d2b Duncan Sands       2006-10-05  330  		usb_err(usbatm, "%s: setting interface to %d failed (%d)!\n", __func__, instance->params.altsetting, ret);
6f7494759870ec Duncan Sands       2006-01-13  331  		goto out_free;
6f7494759870ec Duncan Sands       2006-01-13  332  	}
6f7494759870ec Duncan Sands       2006-01-13  333  
48da7267ff1631 Duncan Sands       2005-05-11  334  	/* Enable software buffering, if requested */
48da7267ff1631 Duncan Sands       2005-05-11  335  	if (sw_buffering)
48da7267ff1631 Duncan Sands       2005-05-11  336  		speedtch_set_swbuff(instance, 1);
48da7267ff1631 Duncan Sands       2005-05-11  337  
48da7267ff1631 Duncan Sands       2005-05-11  338  	/* Magic spell; don't ask us what this does */
48da7267ff1631 Duncan Sands       2005-05-11  339  	speedtch_test_sequence(instance);
48da7267ff1631 Duncan Sands       2005-05-11  340  
48da7267ff1631 Duncan Sands       2005-05-11  341  	ret = 0;
48da7267ff1631 Duncan Sands       2005-05-11  342  
48da7267ff1631 Duncan Sands       2005-05-11  343  out_free:
48da7267ff1631 Duncan Sands       2005-05-11  344  	free_page((unsigned long)buffer);
48da7267ff1631 Duncan Sands       2005-05-11  345  out:
^1da177e4c3f41 Linus Torvalds     2005-04-16  346  	return ret;
^1da177e4c3f41 Linus Torvalds     2005-04-16 @347  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  348  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

