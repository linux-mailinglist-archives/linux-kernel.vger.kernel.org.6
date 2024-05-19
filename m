Return-Path: <linux-kernel+bounces-183201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DB98C95DA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F571F214FD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257516DD0D;
	Sun, 19 May 2024 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYfC+oa1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB846CDBA
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716144067; cv=none; b=j0w5HecVgLCQjrNxwH0njB4nKE0FUA1IkIZUr4XVk1duQjPauVX38wII7d/53mFPmib/7EsA/2d4SdZfvmmvHTXbtK9OiCsOFZqWfQddRvjqSnGfCRbCCuuD8MGjijgPnRQnpiINog1UUDDIpAvMc+8wDiyulWAJp6Ev2W1DK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716144067; c=relaxed/simple;
	bh=KhwAmAPou2kkv7BTGP/ipZ+kQymSAtsihPeeYZuhSVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho5O8A4itiCcojuoksQEZFOM3NLXp+IUrHXi+jyHujGUOHyh++jmPRQ+YHo0uGLIFS15Zeot/H1XciGcATPqYwn0G7dv0Pksn6k7lNibZzZXeL1lMBG8kJzOCoBkL+tsipDpTK+ru9ZcjMaHlMStT46khdFSwqdrYQKzbBqvTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYfC+oa1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716144066; x=1747680066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KhwAmAPou2kkv7BTGP/ipZ+kQymSAtsihPeeYZuhSVs=;
  b=DYfC+oa1/mJ/tohADpzc5rzqC9oZV4zYJr5FT8fEv1Dk+KK0AVy9PKAC
   b8EN1uac30oZRLYlJriUbn3V6dN17joZ7e8XwWcMmycySm9TIqeaZXprR
   b4qcDIfcySULGRcsYVcN5HL8MAlke66BqxhSFFog0PAV+y51RcPxZRYHX
   lBydG7Rdwe/9rKOyT+SzSs9N6BAmi9/z+MpIXpeS0sqrCWf5P29qDXSzA
   yTXN6bO6VWOxehai/wJS9FcMs2jqNY6JIbyxm6XzgFMU7kakOQsv6/T/M
   FUDY6fIinNenKeJN8B/muShWeFjs5fP/n2aNXaytUNEmc1aG0HGuEVoE4
   w==;
X-CSE-ConnectionGUID: Q7u7PLofQRmkKEc4PmXi/A==
X-CSE-MsgGUID: B8iL4JdDSyqhgCf2+vbgVA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="15210589"
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="15210589"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 11:41:05 -0700
X-CSE-ConnectionGUID: qLgz2vTSTBCLpNIiEA+ppQ==
X-CSE-MsgGUID: u+JH4vW5TYW7ga04PS5/4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="37243342"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 19 May 2024 11:40:59 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8lSq-00045c-2r;
	Sun, 19 May 2024 18:40:56 +0000
Date: Mon, 20 May 2024 02:40:28 +0800
From: kernel test robot <lkp@intel.com>
To: Baojun Xu <baojun.xu@ti.com>, tiwai@suse.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com,
	perex@perex.cz, pierre-louis.bossart@linux.intel.com,
	kevin-lu@ti.com, shenghao-ding@ti.com, navada@ti.com,
	13916275206@139.com, v-po@ti.com, niranjan.hy@ti.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	baojun.xu@ti.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v5 1/1] ALSA: hda/tas2781: Add tas2781 hda driver based
 on SPI
Message-ID: <202405200222.TIIew7S6-lkp@intel.com>
References: <20240519150433.760-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519150433.760-2-baojun.xu@ti.com>

Hi Baojun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.9 next-20240517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baojun-Xu/ALSA-hda-tas2781-Add-tas2781-hda-driver-based-on-SPI/20240519-230843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20240519150433.760-2-baojun.xu%40ti.com
patch subject: [PATCH v5 1/1] ALSA: hda/tas2781: Add tas2781 hda driver based on SPI
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240520/202405200222.TIIew7S6-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405200222.TIIew7S6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405200222.TIIew7S6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/pci/hda/tas2781_spi_fwlib.c:1225:11: warning: result of comparison of constant 13656 with expression of type 'unsigned char' is always false [-Wtautological-constant-out-of-range-compare]
    1225 |             (reg == TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG)) &&
         |              ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/pci/hda/tas2781_spi_fwlib.c:1281:11: warning: result of comparison of constant 13660 with expression of type 'unsigned char' is always true [-Wtautological-constant-out-of-range-compare]
    1281 |             (reg <= (TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG) + 4)))
         |              ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/pci/hda/tas2781_spi_fwlib.c:1280:11: warning: result of comparison of constant 13656 with expression of type 'unsigned char' is always false [-Wtautological-constant-out-of-range-compare]
    1280 |             (reg >= TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG)) &&
         |              ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/pci/hda/tas2781_spi_fwlib.c:2112:3: warning: variable 'status' is uninitialized when used here [-Wuninitialized]
    2112 |                 status++;
         |                 ^~~~~~
   sound/pci/hda/tas2781_spi_fwlib.c:2050:12: note: initialize the variable 'status' to silence this warning
    2050 |         int status;
         |                   ^
         |                    = 0
   4 warnings generated.


vim +1225 sound/pci/hda/tas2781_spi_fwlib.c

  1206	
  1207	static int tasdev_multibytes_chksum(struct tasdevice_priv *tasdevice,
  1208		unsigned char book, unsigned char page,
  1209		unsigned char reg, unsigned int len)
  1210	{
  1211		struct tas_crc crc_data;
  1212		unsigned char crc_chksum = 0;
  1213		unsigned char nBuf1[128];
  1214		int ret = 0, i;
  1215		bool in;
  1216	
  1217		if ((reg + len - 1) > 127) {
  1218			ret = -EINVAL;
  1219			dev_err(tasdevice->dev, "firmware error\n");
  1220			goto end;
  1221		}
  1222	
  1223		if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
  1224		    (page == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
> 1225		    (reg == TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG)) &&
  1226		    (len == 4)) {
  1227			/* DSP swap command, pass */
  1228			ret = 0;
  1229			goto end;
  1230		}
  1231	
  1232		in = check_yram(&crc_data, book, page, reg, len);
  1233		if (!in)
  1234			goto end;
  1235	
  1236		if (len == 1) {
  1237			dev_err(tasdevice->dev, "firmware error\n");
  1238			ret = -EINVAL;
  1239			goto end;
  1240		}
  1241	
  1242		ret = tasdevice_spi_dev_bulk_read(tasdevice,
  1243			TASDEVICE_REG(book, page, crc_data.offset),
  1244			nBuf1, crc_data.len);
  1245		if (ret < 0)
  1246			goto end;
  1247	
  1248		for (i = 0; i < crc_data.len; i++) {
  1249			if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
  1250			    (page == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
  1251			    ((i + crc_data.offset) >=
  1252				TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG)) &&
  1253			    ((i + crc_data.offset) <=
  1254				(TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG) + 4)))
  1255				/* DSP swap command, bypass */
  1256				continue;
  1257			else
  1258				crc_chksum += crc8(tasdevice->crc8_lkp_tbl, &nBuf1[i],
  1259					1, 0);
  1260		}
  1261	
  1262		ret = crc_chksum;
  1263	
  1264	end:
  1265		return ret;
  1266	}
  1267	
  1268	static int do_singlereg_checksum(struct tasdevice_priv *tasdevice,
  1269		unsigned char book, unsigned char page,
  1270		unsigned char reg, unsigned char val)
  1271	{
  1272		struct tas_crc crc_data;
  1273		unsigned int nData1;
  1274		int ret = 0;
  1275		bool in;
  1276	
  1277		/* DSP swap command, pass */
  1278		if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
  1279		    (page == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
  1280		    (reg >= TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG)) &&
> 1281		    (reg <= (TASDEVICE_PAGE_REG(TAS2781_SA_COEFF_SWAP_REG) + 4)))
  1282			return 0;
  1283	
  1284		in = check_yram(&crc_data, book, page, reg, 1);
  1285		if (!in)
  1286			return 0;
  1287		ret = tasdevice_spi_dev_read(tasdevice,
  1288			TASDEVICE_REG(book, page, reg), &nData1);
  1289		if (ret < 0)
  1290			return ret;
  1291	
  1292		if (nData1 != val) {
  1293			dev_err(tasdevice->dev,
  1294				"B[0x%x]P[0x%x]R[0x%x] W[0x%x], R[0x%x]\n",
  1295				book, page, reg, val, nData1);
  1296			tasdevice->err_code |= ERROR_YRAM_CRCCHK;
  1297			return -EAGAIN;
  1298		}
  1299	
  1300		ret = crc8(tasdevice->crc8_lkp_tbl, &val, 1, 0);
  1301	
  1302		return ret;
  1303	}
  1304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

