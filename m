Return-Path: <linux-kernel+bounces-282226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4829494E10E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EB228222B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59C84D5A2;
	Sun, 11 Aug 2024 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEBdcy4x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E0F4FB;
	Sun, 11 Aug 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723378689; cv=none; b=tpZKZBSTnTp++fgnGjmd+++pzmUjCQwCCBF7quXtB60ReIVuPKhsZRw9gNSLfonuHMaXhoOp0345+9qk9UqRWLCuhBMQtyGaal4GZkiTbbl1uR4+DXxn1OGuUgzXEf14RYHVRy45umOgzHyWRmBj4U1Oy8MB2qbKP3uiVOeihuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723378689; c=relaxed/simple;
	bh=hHwWR9mdrr1F86wPJmxJ+Z+hpsFfE7JK/YLabgBSPHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN9JR0l4Zw6ZmzVUFadx4CnSLQxmRYE2CdDneZFrojP+G6SyKyEfkZIAWV0HDyG/YYCYEf8c8Nyyi1FYcjwc84USi107MQUpV3fLmJiegm3AFyiMkDQAU0pWnYCSWHdf5ZvqKFVWhDZ5/r9qpJ/hlG3ikQ+nleVkWZFIISe5wK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEBdcy4x; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723378688; x=1754914688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hHwWR9mdrr1F86wPJmxJ+Z+hpsFfE7JK/YLabgBSPHc=;
  b=iEBdcy4xTKhzv1x5a48df+bDWFOG8H8q9j7Fy63K2+MwK0w2jgSh5DDo
   SRlqFE6cAtT7ez+9BcN/S1KVa+QnrfTtFkGk4+5N1JdezlcqqH8VCLRQ/
   M0YuBTubHdMaecg3Q9jaju0xQl1rps6wNXNmkq19N0wbtMldqbeKS8Oct
   IMjcIwz9PiaOPLN/lRe2+UZN8+36f+htmVe8yBNtLb7p1Cwr0p5VJbFdD
   TA9xllZ70jkU+uY/awkaurl4tjnF6h7OLSHo4a7hIdw4etxD1y1B0nHwP
   RN0luhnnc13EOGTpNrfaISpP/z+6iIcvxvslD+ohalO6tlzgJ+cUm6Z0x
   Q==;
X-CSE-ConnectionGUID: FRu2HZOHSZKAqBoWjWozyg==
X-CSE-MsgGUID: K7bpZk+iQNe+NH/paZ1QhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="44012926"
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="44012926"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 05:18:07 -0700
X-CSE-ConnectionGUID: bdThaog8TSmmVcTT7UQGHw==
X-CSE-MsgGUID: aUUBDBetRYS5ZabXVNtqXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,281,1716274800"; 
   d="scan'208";a="62663202"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 11 Aug 2024 05:18:03 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sd7WL-000AoV-1D;
	Sun, 11 Aug 2024 12:18:01 +0000
Date: Sun, 11 Aug 2024 20:17:24 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202408112059.XkTMhslU-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240809]
[cannot apply to robh/for-next soc/for-next linus/master v6.11-rc2 v6.11-rc1 v6.10 v6.11-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/dt-bindings-sram-Document-reg-io-width-property/20240811-055659
base:   next-20240809
patch link:    https://lore.kernel.org/r/20240810214621.14417-3-florian.fainelli%40broadcom.com
patch subject: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property for shared memory
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240811/202408112059.XkTMhslU-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240811/202408112059.XkTMhslU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408112059.XkTMhslU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/firmware/arm_scmi/shmem.c:9:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/firmware/arm_scmi/shmem.c:9:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/firmware/arm_scmi/shmem.c:9:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/firmware/arm_scmi/shmem.c:98:4: error: call to undeclared function 'iowrite64'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      98 |                         __shmem_copy_toio_tpl(64);
         |                         ^
   drivers/firmware/arm_scmi/shmem.c:39:3: note: expanded from macro '__shmem_copy_toio_tpl'
      39 |                 iowrite##s(((u##s *)(xfer->tx.buf))[i / shmem_io_width],        \
         |                 ^
   <scratch space>:43:1: note: expanded from here
      43 | iowrite64
         | ^
   6 warnings and 1 error generated.


vim +/iowrite64 +98 drivers/firmware/arm_scmi/shmem.c

    36	
    37	#define __shmem_copy_toio_tpl(s)			\
    38		for (unsigned int i = 0; i < xfer->tx.len; i += shmem_io_width)		\
    39			iowrite##s(((u##s *)(xfer->tx.buf))[i / shmem_io_width],	\
    40				   shmem->msg_payload + i);
    41	
    42	#define __shmem_copy_fromio_tpl(s)			\
    43		for (unsigned int i = 0; i < xfer->rx.len; i += shmem_io_width)		\
    44			((u##s *)(xfer->rx.buf))[i / shmem_io_width] = 			\
    45				 ioread##s(shmem->msg_payload + shmem_io_width + i);
    46	
    47	static void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
    48				     struct scmi_xfer *xfer,
    49				     struct scmi_chan_info *cinfo,
    50				     u32 shmem_io_width)
    51	{
    52		ktime_t stop;
    53	
    54		/*
    55		 * Ideally channel must be free by now unless OS timeout last
    56		 * request and platform continued to process the same, wait
    57		 * until it releases the shared memory, otherwise we may endup
    58		 * overwriting its response with new message payload or vice-versa.
    59		 * Giving up anyway after twice the expected channel timeout so as
    60		 * not to bail-out on intermittent issues where the platform is
    61		 * occasionally a bit slower to answer.
    62		 *
    63		 * Note that after a timeout is detected we bail-out and carry on but
    64		 * the transport functionality is probably permanently compromised:
    65		 * this is just to ease debugging and avoid complete hangs on boot
    66		 * due to a misbehaving SCMI firmware.
    67		 */
    68		stop = ktime_add_ms(ktime_get(), 2 * cinfo->rx_timeout_ms);
    69		spin_until_cond((ioread32(&shmem->channel_status) &
    70				 SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE) ||
    71				 ktime_after(ktime_get(), stop));
    72		if (!(ioread32(&shmem->channel_status) &
    73		      SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE)) {
    74			WARN_ON_ONCE(1);
    75			dev_err(cinfo->dev,
    76				"Timeout waiting for a free TX channel !\n");
    77			return;
    78		}
    79	
    80		/* Mark channel busy + clear error */
    81		iowrite32(0x0, &shmem->channel_status);
    82		iowrite32(xfer->hdr.poll_completion ? 0 : SCMI_SHMEM_FLAG_INTR_ENABLED,
    83			  &shmem->flags);
    84		iowrite32(sizeof(shmem->msg_header) + xfer->tx.len, &shmem->length);
    85		iowrite32(pack_scmi_header(&xfer->hdr), &shmem->msg_header);
    86		if (xfer->tx.buf) {
    87			switch (shmem_io_width) {
    88			case 1:
    89				__shmem_copy_toio_tpl(8);
    90				break;
    91			case 2:
    92				__shmem_copy_toio_tpl(16);
    93				break;
    94			case 4:
    95				__shmem_copy_toio_tpl(32);
    96				break;
    97			case 8:
  > 98				__shmem_copy_toio_tpl(64);
    99				break;
   100			default:
   101				memcpy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
   102				break;
   103			}
   104		}
   105	}
   106	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

