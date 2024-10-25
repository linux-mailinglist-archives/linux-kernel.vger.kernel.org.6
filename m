Return-Path: <linux-kernel+bounces-382713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD7C9B1293
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485EB1F21ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D289F1D2202;
	Fri, 25 Oct 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iG/D/dyV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192FF217F31
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895439; cv=none; b=EkeicKeoUAcjMwnSOBXWpTdzihH/6WhDXfr3Qz15zU6lvD2sfAHghm2O5zcVrJfM6BOaYoiqj90O6GXZIQOaP4aWAoDq+7pJoMncbBUapkVH6ARyMq06gi7EyG6tENT+HnYaxDO3gCqZ3XBEswCZ9KGvBV7Px5jnTlqKKu6Ds7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895439; c=relaxed/simple;
	bh=xEQCAdq9iQXXkLjdeUukpG0YsZCj+dnaxH5NC6cmjpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwz3UJ0/ZPmJGIbkI3NZY/eEKDNrhKu9960VGH293q2RTDiOfCUfcBOk2KicFf2VBMCw4vtKSYpXR00h5VcZzyXT+zGBYZ7q7fvLWXFrym+GcepNFpRvVZWtJHAkqt7135qYZNrB5K329rxNlNMA9Rip4Y3bW3H57IwRoOf9UIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iG/D/dyV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895436; x=1761431436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xEQCAdq9iQXXkLjdeUukpG0YsZCj+dnaxH5NC6cmjpk=;
  b=iG/D/dyVOpkpQIZCCywR0Y6sOpKt9QFlUM5G+HcWJBfCbgozH/88PEVF
   HMEKFOfu/+icT0RAWARP3hmiOrqv+bfwaJWV4CrG4/STJPFKqNxvRrJL3
   thzJdaweVfaxMZmvr1zrNmR0AtGsVLiJbh30fUmKYX0TEqKU9cG+1jUU3
   uMpfjdB2rag9X80HSS4zP+XRjufvdG+hytYr+coJ88EYd502PGTxFaGf/
   8MDo/19FWHudj3WMUimgSqEYYxn1l0d4iEQZC24h1XFrKLnaAUoFimTkD
   fAOWZrk/ijgfKd8iEyJqEXvsuKuwKuYvm0Pvm5o5HSLzkNG7t2DSYvoWY
   Q==;
X-CSE-ConnectionGUID: PZjArEsFQhiAuFYfSK0wuw==
X-CSE-MsgGUID: 6eyy4DMiR/OnqlGWeeXjfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40161012"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40161012"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:30:35 -0700
X-CSE-ConnectionGUID: rzXVUWM3TF+XxvFqwDotKg==
X-CSE-MsgGUID: QvMgxuR7SxO/BOM7n/Tibg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85824037"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Oct 2024 15:30:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4SpD-000Yz8-0o;
	Fri, 25 Oct 2024 22:30:31 +0000
Date: Sat, 26 Oct 2024 06:29:37 +0800
From: kernel test robot <lkp@intel.com>
To: 412574090@163.com, sudipm.mukherjee@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn, weiyufeng <weiyufeng@kylinos.cn>
Subject: Re: [PATCH 2/4] parport: change struct parport member to iobase
Message-ID: <202410260604.8KzF4khS-lkp@intel.com>
References: <20241025082128.60034-2-412574090@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025082128.60034-2-412574090@163.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc4 next-20241025]
[cannot apply to deller-parisc/for-next mkp-scsi/for-next jejb-scsi/for-next tiwai-sound/for-next tiwai-sound/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/412574090-163-com/parport-change-struct-parport-member-to-iobase/20241025-162302
base:   linus/master
patch link:    https://lore.kernel.org/r/20241025082128.60034-2-412574090%40163.com
patch subject: [PATCH 2/4] parport: change struct parport member to iobase
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241026/202410260604.8KzF4khS-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260604.8KzF4khS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260604.8KzF4khS-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ata/pata_parport/pata_parport.c: In function 'pi_init_one':
>> drivers/ata/pata_parport/pata_parport.c:542:29: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
     542 |         pi->port = parport->base;
         |                             ^~~~
         |                             iobase
--
   In file included from include/linux/device.h:15,
                    from include/linux/parport.h:16,
                    from drivers/ata/pata_parport/bpck6.c:16:
   drivers/ata/pata_parport/bpck6.c: In function 'bpck6_test_port':
>> drivers/ata/pata_parport/bpck6.c:397:60: error: 'struct parport' has no member named 'base'; did you mean 'iobase'?
     397 |                 pi->pardev->port->modes, pi->pardev->port->base);
         |                                                            ^~~~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/ata/pata_parport/bpck6.c:396:9: note: in expansion of macro 'dev_dbg'
     396 |         dev_dbg(&pi->dev, "PARPORT indicates modes=%x for lp=0x%lx\n",
         |         ^~~~~~~


vim +542 drivers/ata/pata_parport/pata_parport.c

246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  492  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  493  static struct pi_adapter *pi_init_one(struct parport *parport,
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  494  			struct pi_protocol *pr, int mode, int unit, int delay)
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  495  {
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  496  	struct pardev_cb par_cb = { };
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  497  	const struct ata_port_info *ppi[] = { &pata_parport_port_info };
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  498  	struct ata_host *host;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  499  	struct pi_adapter *pi;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  500  	struct pi_device_match match = { .parport = parport, .proto = pr };
8844f0aa8dc42f drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-02-04  501  	int id;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  502  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  503  	/*
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  504  	 * Abort if there's a device already registered on the same parport
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  505  	 * using the same protocol.
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  506  	 */
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  507  	if (bus_for_each_dev(&pata_parport_bus_type, NULL, &match, pi_find_dev))
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  508  		return NULL;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  509  
5bc9e2d43f8610 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-14  510  	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
5bc9e2d43f8610 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-14  511  	if (id < 0)
5bc9e2d43f8610 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-14  512  		return NULL;
5bc9e2d43f8610 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-14  513  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  514  	pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
5bc9e2d43f8610 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-14  515  	if (!pi) {
5bc9e2d43f8610 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-14  516  		ida_free(&pata_parport_bus_dev_ids, id);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  517  		return NULL;
5bc9e2d43f8610 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-14  518  	}
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  519  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  520  	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  521  	pi->dev.parent = &pata_parport_bus;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  522  	pi->dev.bus = &pata_parport_bus_type;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  523  	pi->dev.driver = &pr->driver;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  524  	pi->dev.release = pata_parport_dev_release;
8844f0aa8dc42f drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-02-04  525  	pi->dev.id = id;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  526  	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  527  	if (device_register(&pi->dev)) {
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  528  		put_device(&pi->dev);
5bc9e2d43f8610 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-14  529  		/* pata_parport_dev_release will do ida_free(dev->id) and kfree(pi) */
5bc9e2d43f8610 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-14  530  		return NULL;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  531  	}
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  532  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  533  	pi->proto = pr;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  534  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  535  	if (!try_module_get(pi->proto->owner))
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  536  		goto out_unreg_dev;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  537  	if (pi->proto->init_proto && pi->proto->init_proto(pi) < 0)
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  538  		goto out_module_put;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  539  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  540  	pi->delay = (delay == -1) ? pi->proto->default_delay : delay;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  541  	pi->mode = mode;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23 @542  	pi->port = parport->base;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  543  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  544  	par_cb.private = pi;
5bc9e2d43f8610 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-14  545  	pi->pardev = parport_register_dev_model(parport, DRV_NAME, &par_cb, id);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  546  	if (!pi->pardev)
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  547  		goto out_module_put;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  548  
b42251a867a985 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-02-18  549  	if (!pi_probe_unit(pi, unit)) {
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  550  		dev_info(&pi->dev, "Adapter not found\n");
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  551  		goto out_unreg_parport;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  552  	}
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  553  
5b77db9ccff444 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-02-18  554  	pi->proto->log_adapter(pi);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  555  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  556  	host = ata_host_alloc_pinfo(&pi->pardev->dev, ppi, 1);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  557  	if (!host)
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  558  		goto out_unreg_parport;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  559  	dev_set_drvdata(&pi->dev, host);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  560  	host->private_data = pi;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  561  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  562  	ata_port_desc(host->ports[0], "port %s", pi->pardev->port->name);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  563  	ata_port_desc(host->ports[0], "protocol %s", pi->proto->name);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  564  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  565  	pi_connect(pi);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  566  	if (ata_host_activate(host, 0, NULL, 0, &pata_parport_sht))
dc472c7612297f drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-11  567  		goto out_disconnect;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  568  
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  569  	return pi;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  570  
dc472c7612297f drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-11  571  out_disconnect:
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  572  	pi_disconnect(pi);
dc472c7612297f drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-11  573  out_unreg_parport:
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  574  	parport_unregister_device(pi->pardev);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  575  	if (pi->proto->release_proto)
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  576  		pi->proto->release_proto(pi);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  577  out_module_put:
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  578  	module_put(pi->proto->owner);
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  579  out_unreg_dev:
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  580  	device_unregister(&pi->dev);
5bc9e2d43f8610 drivers/ata/pata_parport/pata_parport.c Ondrej Zary 2023-03-14  581  	/* pata_parport_dev_release will do ida_free(dev->id) and kfree(pi) */
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  582  	return NULL;
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  583  }
246a1c4c6b7ffb drivers/ata/pata_parport.c              Ondrej Zary 2023-01-23  584  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

