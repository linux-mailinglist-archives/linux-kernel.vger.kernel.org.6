Return-Path: <linux-kernel+bounces-168701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6C48BBC64
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 16:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2611C20FC2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D63B2A1;
	Sat,  4 May 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXWgnymr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB053A1BB
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714832560; cv=none; b=DBCileBntNpdRpjdKOBGAW+NIPQ+JWlKdjjtI4NquR+EQzzxHE550FWb4FTRQ9vLE95eUkua9njI8G5Jlg3hJZUwc1xnsuu1iSnzVWVEjCMYmYm/T2vmADgDD7qlfyUxnxmkwfzOuTPOoNurI++tCj6ZwItJjvBnBkcR3kq21bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714832560; c=relaxed/simple;
	bh=CILwjP0ONUZbyTTcX+CyOZLykJ1vSQsMj2UBjnbECmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co6VyeDnxswCV3R2v76oDA4dVYLbpPLNpdFsURcV1gNPaw85ehA148uEl7ENv3BGq2Zs4Q2Kcrt5n2YQsu60ux/cg95Q7Wi7Sah+zkoRGuF0ZJ299Vy/8pyx4/gIUNo288DdMermnbbIQTt5JP6bwiqBs/UCeexjbhGxTMY+kUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXWgnymr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714832559; x=1746368559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CILwjP0ONUZbyTTcX+CyOZLykJ1vSQsMj2UBjnbECmc=;
  b=WXWgnymr9W6yTLPrtUKfPJW4vTGSYDe4dLNVycCjtEDThoAXc8CwQMZq
   xJ9FnqyO/8NT18hxkUEseYSKqMLrBwgRXpT/en7f1cXGcPdmBC9g8aUgi
   cc0GKrPTa5aSpdO1VmQVJCYjEYJC2D573b0KSp+Bl5B93fzRawjOVvs5j
   z85C0i/aP70qMeDkWT2MAiVagRcIKqEhHKzXYyTGnRoyxLgMGtCFaPQ6r
   FejjuAUXa8KP6WXyenSQzJ9wOrEWR9YqkCbXc05Zt5Kr+bNhSmQ8k38Yk
   aswa13Zjs9xDD1TfC1QjeNie1rc/OfMpSkdYTkmE1ES0hBQVAMZxEq1Mm
   w==;
X-CSE-ConnectionGUID: dfnrjRvVSJ2hRa688KU7/w==
X-CSE-MsgGUID: 94dwzt2TSuWf5LnkNFbACA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="28104596"
X-IronPort-AV: E=Sophos;i="6.07,254,1708416000"; 
   d="scan'208";a="28104596"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 07:22:38 -0700
X-CSE-ConnectionGUID: D6ZZSsqiRy6oOitYNRRBtg==
X-CSE-MsgGUID: FthiDTOOQc+pp/Ddru3WnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,254,1708416000"; 
   d="scan'208";a="28218343"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 May 2024 07:22:33 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3GHW-000Cr2-2z;
	Sat, 04 May 2024 14:22:30 +0000
Date: Sat, 4 May 2024 22:22:19 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Sung <shawn.sung@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
	"Nancy . Lin" <nancy.lin@mediatek.com>,
	Fei Shao <fshao@chromium.org>, Sean Paul <sean@poorly.run>,
	Jason Chen <jason-ch.chen@mediatek.corp-partner.google.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: Re: [PATCH v7 16/18] drm/mediatek: Support CRC in display driver
Message-ID: <202405042214.VhrmelKu-lkp@intel.com>
References: <20240502103848.5845-17-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502103848.5845-17-shawn.sung@mediatek.com>

Hi Shawn,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240501]
[cannot apply to v6.9-rc6 v6.9-rc5 v6.9-rc4 linus/master v6.9-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Sung/soc-mediatek-Disable-9-bit-alpha-in-ETHDR/20240502-184103
base:   next-20240501
patch link:    https://lore.kernel.org/r/20240502103848.5845-17-shawn.sung%40mediatek.com
patch subject: [PATCH v7 16/18] drm/mediatek: Support CRC in display driver
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240504/202405042214.VhrmelKu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240504/202405042214.VhrmelKu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405042214.VhrmelKu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/mediatek/mtk_crtc.c: In function 'mtk_crtc_create_crc_cmdq':
>> drivers/gpu/drm/mediatek/mtk_crtc.c:1362:9: error: too few arguments to function 'cmdq_pkt_jump'
    1362 |         cmdq_pkt_jump(&crc->cmdq_handle, crc->cmdq_handle.pa_base);
         |         ^~~~~~~~~~~~~
   In file included from drivers/gpu/drm/mediatek/mtk_crtc.c:11:
   include/linux/soc/mediatek/mtk-cmdq.h:319:19: note: declared here
     319 | static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr, u8 shift_pa)
         |                   ^~~~~~~~~~~~~


vim +/cmdq_pkt_jump +1362 drivers/gpu/drm/mediatek/mtk_crtc.c

  1267	
  1268	#if IS_REACHABLE(CONFIG_MTK_CMDQ)
  1269	/**
  1270	 * mtk_crtc_create_crc_cmdq - Create a CMDQ thread for syncing the CRCs
  1271	 * @dev: Kernel device node of the CRC provider
  1272	 * @crc: Pointer of the CRC to init
  1273	 *
  1274	 * This function will create a looping thread on GCE (Global Command Engine) to
  1275	 * keep the CRC up to date by monitoring the assigned event (usually the frame
  1276	 * done event) of the CRC provider, and read the CRCs from the registers to a
  1277	 * shared memory for the workqueue to read. To start/stop the looping thread,
  1278	 * please call `mtk_crtc_start_crc_cmdq()` and `mtk_crtc_stop_crc_cmdq()`
  1279	 * defined blow.
  1280	 *
  1281	 * The reason why we don't update the CRCs with CPU is that the front porch of
  1282	 * 4K60 timing in CEA-861 is less than 60us, and register read/write speed is
  1283	 * relatively unreliable comparing to GCE due to the bus design.
  1284	 *
  1285	 * We must create a new thread instead of using the original one for plane
  1286	 * update is because:
  1287	 * 1. We cannot add another wait-for-event command at the end of cmdq packet, or
  1288	 *    the cmdq callback will delay for too long
  1289	 * 2. Will get the CRC of the previous frame if using the existed wait-for-event
  1290	 *    command which is at the beginning of the packet
  1291	 */
  1292	void mtk_crtc_create_crc_cmdq(struct device *dev, struct mtk_crtc_crc *crc)
  1293	{
  1294		int i;
  1295	
  1296		if (!crc->cnt) {
  1297			dev_warn(dev, "%s: not support\n", __func__);
  1298			goto cleanup;
  1299		}
  1300	
  1301		if (!crc->ofs) {
  1302			dev_warn(dev, "%s: not defined\n", __func__);
  1303			goto cleanup;
  1304		}
  1305	
  1306		crc->cmdq_client.client.dev = dev;
  1307		crc->cmdq_client.client.tx_block = false;
  1308		crc->cmdq_client.client.knows_txdone = true;
  1309		crc->cmdq_client.client.rx_callback = NULL;
  1310		crc->cmdq_client.chan = mbox_request_channel(&crc->cmdq_client.client, 0);
  1311		if (IS_ERR(crc->cmdq_client.chan)) {
  1312			dev_warn(dev, "%s: failed to create mailbox client\n", __func__);
  1313			crc->cmdq_client.chan = NULL;
  1314			goto cleanup;
  1315		}
  1316	
  1317		if (mtk_drm_cmdq_pkt_create(&crc->cmdq_client, &crc->cmdq_handle, PAGE_SIZE)) {
  1318			dev_warn(dev, "%s: failed to create cmdq packet\n", __func__);
  1319			goto cleanup;
  1320		}
  1321	
  1322		if (!crc->va) {
  1323			dev_warn(dev, "%s: no memory\n", __func__);
  1324			goto cleanup;
  1325		}
  1326	
  1327		/* map the entry to get a dma address for cmdq to store the crc */
  1328		crc->pa = dma_map_single(crc->cmdq_client.chan->mbox->dev,
  1329					 crc->va, crc->cnt * sizeof(*crc->va),
  1330					 DMA_FROM_DEVICE);
  1331	
  1332		if (dma_mapping_error(crc->cmdq_client.chan->mbox->dev, crc->pa)) {
  1333			dev_err(dev, "%s: failed to map dma\n", __func__);
  1334			goto cleanup;
  1335		}
  1336	
  1337		if (crc->cmdq_event)
  1338			cmdq_pkt_wfe(&crc->cmdq_handle, crc->cmdq_event, true);
  1339	
  1340		for (i = 0; i < crc->cnt; i++) {
  1341			/* put crc to spr1 register */
  1342			cmdq_pkt_read_s(&crc->cmdq_handle, crc->cmdq_reg->subsys,
  1343					crc->cmdq_reg->offset + crc->ofs[i],
  1344					CMDQ_THR_SPR_IDX1);
  1345	
  1346			/* copy spr1 register to physical address of the crc */
  1347			cmdq_pkt_assign(&crc->cmdq_handle, CMDQ_THR_SPR_IDX0,
  1348					CMDQ_ADDR_HIGH(crc->pa + i * sizeof(*crc->va)));
  1349			cmdq_pkt_write_s(&crc->cmdq_handle, CMDQ_THR_SPR_IDX0,
  1350					 CMDQ_ADDR_LOW(crc->pa + i * sizeof(*crc->va)),
  1351					 CMDQ_THR_SPR_IDX1);
  1352		}
  1353		/* reset crc */
  1354		mtk_ddp_write_mask(&crc->cmdq_handle, ~0, crc->cmdq_reg, 0,
  1355				   crc->rst_ofs, crc->rst_msk);
  1356	
  1357		/* clear reset bit */
  1358		mtk_ddp_write_mask(&crc->cmdq_handle, 0, crc->cmdq_reg, 0,
  1359				   crc->rst_ofs, crc->rst_msk);
  1360	
  1361		/* jump to head of the cmdq packet */
> 1362		cmdq_pkt_jump(&crc->cmdq_handle, crc->cmdq_handle.pa_base);
  1363	
  1364		return;
  1365	cleanup:
  1366		mtk_crtc_destroy_crc(crc);
  1367	}
  1368	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

