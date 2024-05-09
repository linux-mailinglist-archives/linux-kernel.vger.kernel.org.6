Return-Path: <linux-kernel+bounces-173952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18CB8C0826
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C28282766
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6881133997;
	Wed,  8 May 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRT8jxVP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DBB34CDD
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715212555; cv=none; b=KVg5t1cFIXu5n2tXx6QrpCqeckMJ7oKYltsDdfyVf/qa8mhrXNUxtwka2fNXbDYgbTCnriZZxmdgdYza0g79KF7zNq2yx6iZJ3Px6w9X5uSfb33S+Dfa+xZFaU2kez7Uu9wKv3gYZyYfNkDNoMM27fN74tijFi3GAkwx37SO1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715212555; c=relaxed/simple;
	bh=9rINs3VyCm6tAEZfoaCS30hypmdP4mKel8NcCO8rrfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8hCZ44nQ5WHByRhtCiUGrmeXkNc7thxy4fZciiQy39cIG+qiO1OkqgPzI8NkuKTqufe5pNBifQeiy+LSwFhaOoBV4KCCyMpscNEAHH3D12n93nieAG4/Gs+4STQW7cIQajZ0o7pUXr1kA9Y0EjMj5lo/e76/PHLOGn9L4QWSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRT8jxVP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715212552; x=1746748552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9rINs3VyCm6tAEZfoaCS30hypmdP4mKel8NcCO8rrfs=;
  b=mRT8jxVPPJ0MTZwryu8M2YteIB4z8p/RHW4fqJ+8jvlDJqiK3nAbUm90
   53S9YIwjpgFGprn0cWf90EDipX0DoEHrKrS0Mg1B+zgjoIimueTndW6wD
   IbXYTxR7/d13tCkzSlM7DYv8a6w1dP/CIZN6H23ysmEHBlwiYMgzV2qsK
   BHPCHrTG54+EG4nFcbauPSbnOT0btw536fc5gadDeSBRq7GpwOFfWHq5p
   UxQiw2JRwQHwI/5nrUleCq2Z+VwowFlwCYICb6x7mmHT+EIYgBLOeqGpO
   M+/ECX+6J2GQ6g3eo9ZyWV52c+p9sKjBo1CZqdW8zUh4CQR5i7fxeyH7Z
   A==;
X-CSE-ConnectionGUID: VHtqR5FLRHWBAdy2ogIQSA==
X-CSE-MsgGUID: O8kVFuAdSZq234m8vBCbfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10956797"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="10956797"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 16:55:52 -0700
X-CSE-ConnectionGUID: X/OteO3aRomYYA8wFp2YLg==
X-CSE-MsgGUID: f5oQNoN6QmeVs2GRYmxOeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="28936000"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2024 16:55:48 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4r8T-0004F6-1w;
	Wed, 08 May 2024 23:55:45 +0000
Date: Thu, 9 May 2024 07:55:43 +0800
From: kernel test robot <lkp@intel.com>
To: Weishi Li <liweishi@kylinos.cn>, airlied@redhat.com, kraxel@redhat.com,
	gurchetansingh@chromium.org, olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, daniel@ffwll.ch
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, liweishi@kylinos.cn
Subject: Re: [PATCH] [PATCH RESEND] drm/virtio: fix memory leak of vbuf
Message-ID: <202405090747.y8ofUE7r-lkp@intel.com>
References: <20240507033814.57906-1-liweishi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507033814.57906-1-liweishi@kylinos.cn>

Hi Weishi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next linus/master v6.9-rc7 next-20240508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Weishi-Li/drm-virtio-fix-memory-leak-of-vbuf/20240507-114452
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240507033814.57906-1-liweishi%40kylinos.cn
patch subject: [PATCH] [PATCH RESEND] drm/virtio: fix memory leak of vbuf
config: i386-buildonly-randconfig-001-20240508 (https://download.01.org/0day-ci/archive/20240509/202405090747.y8ofUE7r-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240509/202405090747.y8ofUE7r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405090747.y8ofUE7r-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/virtio/virtgpu_vq.c:474:13: warning: variable 'notify' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     474 |         } else if (ret < 0) {
         |                    ^~~~~~~
   drivers/gpu/drm/virtio/virtgpu_vq.c:487:6: note: uninitialized use occurs here
     487 |         if (notify)
         |             ^~~~~~
   drivers/gpu/drm/virtio/virtgpu_vq.c:474:9: note: remove the 'if' if its condition is always false
     474 |         } else if (ret < 0) {
         |                ^~~~~~~~~~~~~~
     475 |                 free_vbuf(vgdev, vbuf);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~
     476 |         } else {
         |         ~~~~~~
   drivers/gpu/drm/virtio/virtgpu_vq.c:455:13: note: initialize the variable 'notify' to silence this warning
     455 |         bool notify;
         |                    ^
         |                     = 0
   1 warning generated.


vim +474 drivers/gpu/drm/virtio/virtgpu_vq.c

   448	
   449	static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
   450					    struct virtio_gpu_vbuffer *vbuf)
   451	{
   452		struct virtqueue *vq = vgdev->cursorq.vq;
   453		struct scatterlist *sgs[1], ccmd;
   454		int idx, ret, outcnt;
   455		bool notify;
   456	
   457		if (!drm_dev_enter(vgdev->ddev, &idx)) {
   458			free_vbuf(vgdev, vbuf);
   459			return;
   460		}
   461	
   462		sg_init_one(&ccmd, vbuf->buf, vbuf->size);
   463		sgs[0] = &ccmd;
   464		outcnt = 1;
   465	
   466		spin_lock(&vgdev->cursorq.qlock);
   467	retry:
   468		ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
   469		if (ret == -ENOSPC) {
   470			spin_unlock(&vgdev->cursorq.qlock);
   471			wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
   472			spin_lock(&vgdev->cursorq.qlock);
   473			goto retry;
 > 474		} else if (ret < 0) {
   475			free_vbuf(vgdev, vbuf);
   476		} else {
   477			vbuf->seqno = ++vgdev->cursorq.seqno;
   478			trace_virtio_gpu_cmd_queue(vq,
   479				virtio_gpu_vbuf_ctrl_hdr(vbuf),
   480				vbuf->seqno);
   481	
   482			notify = virtqueue_kick_prepare(vq);
   483		}
   484	
   485		spin_unlock(&vgdev->cursorq.qlock);
   486	
   487		if (notify)
   488			virtqueue_notify(vq);
   489	
   490		drm_dev_exit(idx);
   491	}
   492	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

