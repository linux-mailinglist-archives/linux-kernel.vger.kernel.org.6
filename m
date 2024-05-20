Return-Path: <linux-kernel+bounces-184103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A88CA29F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2A01F21C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E0137C44;
	Mon, 20 May 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="TAfIjEls"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36462136E0F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232516; cv=none; b=ns1sSqL0enTmHTZhTNn37RcMNCorQV4y8oneZocKx1QBnV+KHtY3rP1OMIxx3hzI9JRUk8lbI09a8RP56uGm+YF7fHrvT/Vuy8KSrR3Sp9gb0rOAnfM5xbrKiaNj6aFD70H6Jc1+Tffj2rYEJNEZbFpw9CoRgvRslPOExrdVQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232516; c=relaxed/simple;
	bh=MK6vIe+CYfefOhlpr7MrktVFCisaUlRhB/VbzBhE2N0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=O0dUOlO6VwOAtQuC2WiyBTqwSHwTnOopsL/h+kC59tEtc1AdAX0qUdRPp7kEpHIDoUVL7RtFg5zJQmV6y6x4+dmrVafnn1tK1a2r6oZM9aL/07PontFZff6bYUiuoJa98RuCsOSzSZkCNb9/M7m/OsDiBf8CWBAVgzBdg+oUq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=TAfIjEls; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=TtQSHeSe8VxMywbdGkdM/DXm5oOksvu53Rj/TPMY1f0=;
  b=TAfIjElsWWm9d+/beXq0wyl5kKQXNW8YDhE/Uekoa5WFCSPQu+RJCND+
   eB/5KjLQ0yjTt8W8/zbnTvu0YM3oHZUiEvOWN1dve5ScxPeeRypkEdmOb
   MQfEsuBkVnaZA+3MIJdmfNJryuPZSUe7xmhU4XfvkI3itb08xGPeJMds5
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,175,1712613600"; 
   d="scan'208";a="87479398"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 21:14:00 +0200
Date: Mon, 20 May 2024 21:13:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
    Thierry Reding <treding@nvidia.com>
Subject: drivers/gpu/drm/tegra/dp.c:738:22-33: opportunity for str_plural(link
 -> lanes) (fwd)
Message-ID: <alpine.DEB.2.22.394.2405202113160.3378@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2066449509-1716232439=:3378"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2066449509-1716232439=:3378
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



---------- Forwarded message ----------
Date: Sat, 18 May 2024 02:26:08 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/gpu/drm/tegra/dp.c:738:22-33: opportunity for str_plural(link
    -> lanes)

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: "Christian König" <christian.koenig@amd.com>
CC: Thierry Reding <treding@nvidia.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ff2632d7d08edc11e8bd0629e9fcfebab25c78b4
commit: f75d19827b731c6f24930ef77e5a46cf2242bc68 drm/tegra: Allow compile test on !ARM v2
date:   1 year, 1 month ago
:::::: branch date: 2 hours ago
:::::: commit date: 1 year, 1 month ago
config: mips-randconfig-r052-20240517 (https://download.01.org/0day-ci/archive/20240518/202405180249.j8XWqlXt-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d3455f4ddd16811401fa153298fadd2f59f6914e)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202405180249.j8XWqlXt-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/tegra/dp.c:738:22-33: opportunity for str_plural(link -> lanes)
   drivers/gpu/drm/tegra/dp.c:794:22-33: opportunity for str_plural(link -> lanes)
--
>> drivers/gpu/drm/tegra/sor.c:939:11-16: opportunity for str_plural(lanes)

vim +738 drivers/gpu/drm/tegra/dp.c

078c445733c1e8 Thierry Reding 2015-07-07  731
078c445733c1e8 Thierry Reding 2015-07-07  732  static int drm_dp_link_train_full(struct drm_dp_link *link)
078c445733c1e8 Thierry Reding 2015-07-07  733  {
078c445733c1e8 Thierry Reding 2015-07-07  734  	int err;
078c445733c1e8 Thierry Reding 2015-07-07  735
078c445733c1e8 Thierry Reding 2015-07-07  736  retry:
078c445733c1e8 Thierry Reding 2015-07-07  737  	DRM_DEBUG_KMS("full-training link: %u lane%s at %u MHz\n",
078c445733c1e8 Thierry Reding 2015-07-07 @738  		      link->lanes, (link->lanes > 1) ? "s" : "",
078c445733c1e8 Thierry Reding 2015-07-07  739  		      link->rate / 100);
078c445733c1e8 Thierry Reding 2015-07-07  740
078c445733c1e8 Thierry Reding 2015-07-07  741  	err = drm_dp_link_configure(link->aux, link);
078c445733c1e8 Thierry Reding 2015-07-07  742  	if (err < 0) {
078c445733c1e8 Thierry Reding 2015-07-07  743  		DRM_ERROR("failed to configure DP link: %d\n", err);
078c445733c1e8 Thierry Reding 2015-07-07  744  		return err;
078c445733c1e8 Thierry Reding 2015-07-07  745  	}
078c445733c1e8 Thierry Reding 2015-07-07  746
078c445733c1e8 Thierry Reding 2015-07-07  747  	err = drm_dp_link_clock_recovery(link);
078c445733c1e8 Thierry Reding 2015-07-07  748  	if (err < 0) {
078c445733c1e8 Thierry Reding 2015-07-07  749  		DRM_ERROR("clock recovery failed: %d\n", err);
078c445733c1e8 Thierry Reding 2015-07-07  750  		goto out;
078c445733c1e8 Thierry Reding 2015-07-07  751  	}
078c445733c1e8 Thierry Reding 2015-07-07  752
078c445733c1e8 Thierry Reding 2015-07-07  753  	if (!link->train.clock_recovered) {
078c445733c1e8 Thierry Reding 2015-07-07  754  		DRM_ERROR("clock recovery failed, downgrading link\n");
078c445733c1e8 Thierry Reding 2015-07-07  755
078c445733c1e8 Thierry Reding 2015-07-07  756  		err = drm_dp_link_downgrade(link);
078c445733c1e8 Thierry Reding 2015-07-07  757  		if (err < 0)
078c445733c1e8 Thierry Reding 2015-07-07  758  			goto out;
078c445733c1e8 Thierry Reding 2015-07-07  759
078c445733c1e8 Thierry Reding 2015-07-07  760  		goto retry;
078c445733c1e8 Thierry Reding 2015-07-07  761  	}
078c445733c1e8 Thierry Reding 2015-07-07  762
078c445733c1e8 Thierry Reding 2015-07-07  763  	DRM_DEBUG_KMS("clock recovery succeeded\n");
078c445733c1e8 Thierry Reding 2015-07-07  764
078c445733c1e8 Thierry Reding 2015-07-07  765  	err = drm_dp_link_channel_equalization(link);
078c445733c1e8 Thierry Reding 2015-07-07  766  	if (err < 0) {
078c445733c1e8 Thierry Reding 2015-07-07  767  		DRM_ERROR("channel equalization failed: %d\n", err);
078c445733c1e8 Thierry Reding 2015-07-07  768  		goto out;
078c445733c1e8 Thierry Reding 2015-07-07  769  	}
078c445733c1e8 Thierry Reding 2015-07-07  770
078c445733c1e8 Thierry Reding 2015-07-07  771  	if (!link->train.channel_equalized) {
078c445733c1e8 Thierry Reding 2015-07-07  772  		DRM_ERROR("channel equalization failed, downgrading link\n");
078c445733c1e8 Thierry Reding 2015-07-07  773
078c445733c1e8 Thierry Reding 2015-07-07  774  		err = drm_dp_link_downgrade(link);
078c445733c1e8 Thierry Reding 2015-07-07  775  		if (err < 0)
078c445733c1e8 Thierry Reding 2015-07-07  776  			goto out;
078c445733c1e8 Thierry Reding 2015-07-07  777
078c445733c1e8 Thierry Reding 2015-07-07  778  		goto retry;
078c445733c1e8 Thierry Reding 2015-07-07  779  	}
078c445733c1e8 Thierry Reding 2015-07-07  780
078c445733c1e8 Thierry Reding 2015-07-07  781  	DRM_DEBUG_KMS("channel equalization succeeded\n");
078c445733c1e8 Thierry Reding 2015-07-07  782
078c445733c1e8 Thierry Reding 2015-07-07  783  out:
078c445733c1e8 Thierry Reding 2015-07-07  784  	drm_dp_link_train_disable(link);
078c445733c1e8 Thierry Reding 2015-07-07  785  	return err;
078c445733c1e8 Thierry Reding 2015-07-07  786  }
078c445733c1e8 Thierry Reding 2015-07-07  787

:::::: The code at line 738 was first introduced by commit
:::::: 078c445733c1e8092e23391b251cad6b12f6156e drm/tegra: dp: Add DisplayPort link training helper

:::::: TO: Thierry Reding <treding@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
--8323329-2066449509-1716232439=:3378--

