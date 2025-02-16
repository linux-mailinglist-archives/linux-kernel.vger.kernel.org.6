Return-Path: <linux-kernel+bounces-516455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C692AA371F1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 04:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8926518866FC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 03:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF4D38385;
	Sun, 16 Feb 2025 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CznvtCCj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616C2FB2
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739675655; cv=none; b=pxX0JSBspK9A5uk6mACoc15xeJG5OC7+KzSmvnfbAXbDbTw9ZpvHzyP5sKFY6ZfXbiqw/4v95/Z/zzHMudVP3WTusKapPJnTfjNe0lQjmo9CXoJMRC3tbsmBVmDJFNjoTC4VGPWDOFGMfPPOERSoHIm1dC8vrjlSNtSwEMK6IqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739675655; c=relaxed/simple;
	bh=Wl9Y65/82dQkpfABODvPurytI56l3tXy0oi5NkNAmac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rCYf69922NU0dz3tHoIu0YsT/ahVlRSfnoGmtiIdITGuVu2/6f2cB+zlqGCrpG33kvPbM3R9S+pyCCNCy3hDWwB/rZ1f3/iCg5F0e/KcA86LAEB9jEPM37Kr2y0oo1YxyXRdPGuZy2J/vPfICzMU5r/zcgMC/UW+SYHIXc0NSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CznvtCCj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739675653; x=1771211653;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wl9Y65/82dQkpfABODvPurytI56l3tXy0oi5NkNAmac=;
  b=CznvtCCjX5R75zjz7gqsBkNEyvi6HNO6vUE/igzfVPMQGn+CcF0NyLRN
   1kpCAdf4tfdQmzJsV7q2lHI+iTPLMhZ6i1NDtbgD055KS1t/6qO1/26t9
   vgvQnWS7Mt7KGgyb9o8JVR/e+3zpRYAGnwP0GILCipxFcg69xJBvabGn9
   cI1ExxfY3FzawL0Q4JUqiu8wjdBGb8v3avFeEQrRyi55N6EDtZ04QVqdq
   6FKDDf4QC0pyU1amZ0RGaOGnogI2H7KvT/Qz2qw0Y4kJMOfHWR3fOcizz
   g5GcO6D8Xm/Jr699+4Go/WBm7rZNTJ44plI+1gbaVu/HCi5Zcy8pJs45w
   Q==;
X-CSE-ConnectionGUID: kF3YXd5UQDGcT5amsLxPqQ==
X-CSE-MsgGUID: oS3AlfX0SXaTIhB3wHKhEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="39572600"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="39572600"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:14:13 -0800
X-CSE-ConnectionGUID: vkJmcjDdRBOfxtKeQeG6pQ==
X-CSE-MsgGUID: mURxjP3lTF2dJ3K0O06G8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113685003"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Feb 2025 19:14:11 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjV6f-001BXX-1V;
	Sun, 16 Feb 2025 03:14:09 +0000
Date: Sun, 16 Feb 2025 11:13:14 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: drivers/net/virtio_net.c:1227 xsk_append_merge_buffer() warn:
 unsigned '_x' is never less than zero.
Message-ID: <202502161158.KmluxANz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   496659003dac5d08ea292c44fce9dfb36fa34691
commit: 99c861b44eb1fb9dfe8776854116a6a9064c19bb virtio_net: xsk: rx: support recv merge mode
date:   7 months ago
config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250216/202502161158.KmluxANz-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502161158.KmluxANz-lkp@intel.com/

New smatch warnings:
drivers/net/virtio_net.c:1227 xsk_append_merge_buffer() warn: unsigned '_x' is never less than zero.

Old smatch warnings:
include/linux/mm.h:1311 virt_to_head_page() warn: unsigned '_x' is never less than zero.
include/linux/scatterlist.h:189 sg_set_buf() warn: unsigned '_x' is never less than zero.
drivers/net/virtio_net.c:1934 build_skb_from_xdp_buff() error: uninitialized symbol 'nr_frags'.
drivers/net/virtio_net.c:2016 virtnet_build_xdp_buff_mrg() error: uninitialized symbol 'shinfo'.
drivers/net/virtio_net.c:5096 virtnet_update_settings() error: uninitialized symbol 'virtio_cread_v'.
drivers/net/virtio_net.c:5804 virtnet_config_changed_work() error: uninitialized symbol 'virtio_cread_v'.
drivers/net/virtio_net.c:5808 virtnet_config_changed_work() error: uninitialized symbol 'v'.

vim +/_x +1227 drivers/net/virtio_net.c

  1184	
  1185	static int xsk_append_merge_buffer(struct virtnet_info *vi,
  1186					   struct receive_queue *rq,
  1187					   struct sk_buff *head_skb,
  1188					   u32 num_buf,
  1189					   struct virtio_net_hdr_mrg_rxbuf *hdr,
  1190					   struct virtnet_rq_stats *stats)
  1191	{
  1192		struct sk_buff *curr_skb;
  1193		struct xdp_buff *xdp;
  1194		u32 len, truesize;
  1195		struct page *page;
  1196		void *buf;
  1197	
  1198		curr_skb = head_skb;
  1199	
  1200		while (--num_buf) {
  1201			buf = virtqueue_get_buf(rq->vq, &len);
  1202			if (unlikely(!buf)) {
  1203				pr_debug("%s: rx error: %d buffers out of %d missing\n",
  1204					 vi->dev->name, num_buf,
  1205					 virtio16_to_cpu(vi->vdev,
  1206							 hdr->num_buffers));
  1207				DEV_STATS_INC(vi->dev, rx_length_errors);
  1208				return -EINVAL;
  1209			}
  1210	
  1211			u64_stats_add(&stats->bytes, len);
  1212	
  1213			xdp = buf_to_xdp(vi, rq, buf, len);
  1214			if (!xdp)
  1215				goto err;
  1216	
  1217			buf = napi_alloc_frag(len);
  1218			if (!buf) {
  1219				xsk_buff_free(xdp);
  1220				goto err;
  1221			}
  1222	
  1223			memcpy(buf, xdp->data - vi->hdr_len, len);
  1224	
  1225			xsk_buff_free(xdp);
  1226	
> 1227			page = virt_to_page(buf);
  1228	
  1229			truesize = len;
  1230	
  1231			curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
  1232							    buf, len, truesize);
  1233			if (!curr_skb) {
  1234				put_page(page);
  1235				goto err;
  1236			}
  1237		}
  1238	
  1239		return 0;
  1240	
  1241	err:
  1242		xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
  1243		return -EINVAL;
  1244	}
  1245	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

