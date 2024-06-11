Return-Path: <linux-kernel+bounces-209382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BDA9033D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C324A1C22B92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E572172791;
	Tue, 11 Jun 2024 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKd5cXl5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD98171E7C;
	Tue, 11 Jun 2024 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091366; cv=none; b=CJlsyWksYazfmxLVdX1XbRMfj9/fxOCh2gIKK0ZqnYwKr3Bim4b4XnOIuKcTlD0mTDMQUORTs3L/zfw4aaIkbSkY68Y3xQk0BYsU3yTbZko5FkQWB+HDF5X9/2072///T8MEXVRSO7qeAJ1rzK7PlvKiOsaS+0jP7+ak/wqBQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091366; c=relaxed/simple;
	bh=h5lWjlmg4j2trX70zrGXvV0gKEBmsyN3kR6SWh2/Xik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDqM3V/qdOkrF0Di58BDsibAY8El4SjYBt3vmwwcog96ktcJ0fwmfRkNXpqYswZ7Opykj215M1OKK+JAFcn4hoh0ZHQ47JLg76bIVutTU4yM2CqxIzt7BcelQBMy5oTlTFsXLc0JIIK/Fh/A7ajpP2/5NNkYsi8VHr3UqdP/6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKd5cXl5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718091364; x=1749627364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h5lWjlmg4j2trX70zrGXvV0gKEBmsyN3kR6SWh2/Xik=;
  b=aKd5cXl58N/2m+3heoUmgZ6qN920lDq3wvuKJAaL7XaSVFPb9OAqZAnF
   RXD1JqAAw6zN9QFmRLvfzP+dLubVxe4e/tSOGpoGalU98aNiY/b1r+Vsm
   w0U6baCB+ois+1l2KnWSZATmzlYWOek6d8UUxwGG1FQqRrS+CpyYVU5Ra
   bFnx6bNva/tZ4utYa6C/ft+7ZnIoTzz/YYUzhBvYjtNst2x9YVJtWGlVX
   Ze4zD+kGXhFRpLUQTS2OUnMUqsNGzpILJU05KwxR53fGdl+kWzzB8eoUO
   7gn1Jz/4B57qRIkCQkrF/diSAPec1gORJycYoacHwIXYILogSPxNczQNg
   w==;
X-CSE-ConnectionGUID: qTOGRrSLSpKA3Cz0JchD2g==
X-CSE-MsgGUID: bwHUADkWTjulqxbyxbgS3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25448850"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="25448850"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 00:36:04 -0700
X-CSE-ConnectionGUID: WFtqwmd2SqGqXWeXlVpBrQ==
X-CSE-MsgGUID: fGQrY9XXROaEisoh+KQgPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="44282695"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Jun 2024 00:36:00 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGw2v-0000Bd-2E;
	Tue, 11 Jun 2024 07:35:57 +0000
Date: Tue, 11 Jun 2024 15:35:10 +0800
From: kernel test robot <lkp@intel.com>
To: Beleswar Padhi <b-padhi@ti.com>, nm@ti.com, vigneshr@ti.com
Cc: oe-kbuild-all@lists.linux.dev, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vaishnav.a@ti.com, j-choudhary@ti.com,
	u-kumar1@ti.com
Subject: Re: [PATCH 1/3] arm64: dts: ti: Add R5F and C7x remote processor
 nodes
Message-ID: <202406111537.bNPc0hYx-lkp@intel.com>
References: <20240607090433.488454-2-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607090433.488454-2-b-padhi@ti.com>

Hi Beleswar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc3 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Beleswar-Padhi/arm64-dts-ti-Add-R5F-and-C7x-remote-processor-nodes/20240607-170843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240607090433.488454-2-b-padhi%40ti.com
patch subject: [PATCH 1/3] arm64: dts: ti: Add R5F and C7x remote processor nodes
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240611/202406111537.bNPc0hYx-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240611/202406111537.bNPc0hYx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406111537.bNPc0hYx-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e000000: reg: [[0, 2113929216, 0, 2097152]] is too short
   	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
>> arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e000000: reg-names: ['l2sram'] is too short
   	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
>> arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e200000: reg: [[0, 2116026368, 0, 2097152]] is too short
   	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
>> arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e200000: reg-names: ['l2sram'] is too short
   	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

