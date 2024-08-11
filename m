Return-Path: <linux-kernel+bounces-282229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9C94E119
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3285B1F21990
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1244D8C6;
	Sun, 11 Aug 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8HaaE1U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0B4C61B;
	Sun, 11 Aug 2024 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723379289; cv=none; b=ht8u00+qSXe+0XSQMQlkWYCWRDUs4Gd/VCR3yUoe3fac9885lrRCceFfhhl1Yd++fpePR6e+Awf2kYlzNJh/kly4P6pJA2tmRB3fwjtigznIBQhFUGPz4LUqicoecATb0D8ubc1+hmX1YLHhayui7SI0aEvwdOXNtia+OS/UUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723379289; c=relaxed/simple;
	bh=ifmY/NwVet51VR/YQi8+8+GQTxggPltCSZCaVKRizfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvqUhdp5fIM07yyjdceFIOoNZKZ+uD3WW8i8mRj6Znx5W1S64Z3MTgfalIlRdyY+CcZuYygTfw7FWFkIXH02LnlYG0kBtOeKSu5l3u8v/xACXooNE3zZWoKikEcItkvIzOwsRzkuvShuF8qTtals5F6Tqh3qJZ4eWWFN7KQMNUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8HaaE1U; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723379288; x=1754915288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifmY/NwVet51VR/YQi8+8+GQTxggPltCSZCaVKRizfk=;
  b=L8HaaE1UhaHdM8nSPZolNIHYXeSBf1PG6VYo00r0NNU4REXfnw+QTZ9s
   wUL6TEzIi+soAN6O6I3aD6aCv8EKGH4vKLnrN73gaZSTytg/I9waxfxwc
   R5XVtbbd/Fr1dz8nceJfUuvEWijIBzIuFMgtA18noZCe5MKhJoFbOl6+0
   jq4MVkzLPuvvme9XAqYagda75/Ctf/i1E6YumlFmeEk4vEujKgl9j1ZuN
   Ccsr/pDfc3hAkxAaGRQE6W8OzlUz6zRQr+YfKWdDSdV94fY05uZ2FvTpH
   bbBrvuAqp1rG7QZenHlx2sn76aYGEoP4aR8b4L00VbU52p611kYGVWzz3
   Q==;
X-CSE-ConnectionGUID: a8TqYQjiSbeLj4X+jd92Zw==
X-CSE-MsgGUID: fkeJLlzTSXSspfDvwA/H5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="25262671"
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="25262671"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 05:28:08 -0700
X-CSE-ConnectionGUID: dztFoq09TQ+ksk8tLDz1WA==
X-CSE-MsgGUID: QX/NrWQTRjKd/99h+wucuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="62932464"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 11 Aug 2024 05:28:04 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sd7g1-000ApD-2l;
	Sun, 11 Aug 2024 12:28:01 +0000
Date: Sun, 11 Aug 2024 20:27:47 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, james.quinlan@broadcom.com,
	justin.chen@broadcom.com, kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property
 for shared memory
Message-ID: <202408112059.t5hPmQeS-lkp@intel.com>
References: <20240810214621.14417-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810214621.14417-3-florian.fainelli@broadcom.com>

Hi Florian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240809]
[cannot apply to robh/for-next soc/for-next linus/master v6.11-rc2 v6.11-rc1 v6.10 v6.11-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/dt-bindings-sram-Document-reg-io-width-property/20240811-055659
base:   next-20240809
patch link:    https://lore.kernel.org/r/20240810214621.14417-3-florian.fainelli%40broadcom.com
patch subject: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property for shared memory
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240811/202408112059.t5hPmQeS-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240811/202408112059.t5hPmQeS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408112059.t5hPmQeS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/arm_scmi/scmi_transport_mailbox.c:37: warning: Function parameter or struct member 'shmem_io_width' not described in 'scmi_mailbox'


vim +37 drivers/firmware/arm_scmi/scmi_transport_mailbox.c

5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  18  
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  19  /**
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  20   * struct scmi_mailbox - Structure representing a SCMI mailbox transport
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  21   *
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  22   * @cl: Mailbox Client
9f68ff79ec2cb3 drivers/firmware/arm_scmi/mailbox.c                Cristian Marussi 2023-04-04  23   * @chan: Transmit/Receive mailbox uni/bi-directional channel
9f68ff79ec2cb3 drivers/firmware/arm_scmi/mailbox.c                Cristian Marussi 2023-04-04  24   * @chan_receiver: Optional Receiver mailbox unidirectional channel
fa8b28ba22d95b drivers/firmware/arm_scmi/mailbox.c                Peng Fan         2024-05-10  25   * @chan_platform_receiver: Optional Platform Receiver mailbox unidirectional channel
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  26   * @cinfo: SCMI channel info
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  27   * @shmem: Transmit/Receive shared memory area
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  28   */
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  29  struct scmi_mailbox {
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  30  	struct mbox_client cl;
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  31  	struct mbox_chan *chan;
9f68ff79ec2cb3 drivers/firmware/arm_scmi/mailbox.c                Cristian Marussi 2023-04-04  32  	struct mbox_chan *chan_receiver;
fa8b28ba22d95b drivers/firmware/arm_scmi/mailbox.c                Peng Fan         2024-05-10  33  	struct mbox_chan *chan_platform_receiver;
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  34  	struct scmi_chan_info *cinfo;
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  35  	struct scmi_shared_mem __iomem *shmem;
0905440d6ece25 drivers/firmware/arm_scmi/scmi_transport_mailbox.c Florian Fainelli 2024-08-10  36  	u32 shmem_io_width;
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31 @37  };
5c8a47a5a91d4d drivers/firmware/arm_scmi/mailbox.c                Viresh Kumar     2020-01-31  38  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

