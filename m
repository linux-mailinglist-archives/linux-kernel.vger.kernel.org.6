Return-Path: <linux-kernel+bounces-539096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64015A4A0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE4018977B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0F81624C3;
	Fri, 28 Feb 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKakdK8G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FBC1F4CB2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764890; cv=none; b=TK9OpWfvPE8ZHfOcp7vKGGDB8Pz1akiRpntSOL3ysknt0XpMQKVFomjhfIOUCAutZmdzoQQAbTkdGHG2bkQihvghhARaFXKaxeIlUb75UQrwXdrIDnnV8wVJ5FEuxWd2a5kOa79MJ2uISiHmT9LxmKhQp1qyTE3oW5Xl39EMXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764890; c=relaxed/simple;
	bh=jEGuY85aQVAWxR1y/cDpCIMIorypJGos60cokjssuUE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J++IGvmjNz2SUCux9WDDQXytXHk6Q8rTLKX0fYIjI+Efp8GukEdxwgyMqxiP5P3ZgYPlr3iQwxfc+yzGnvIXRBWlr08tSB5VHulchnUerYPWyiQf38oixvYFr4NTaq8IaWwLyMIfrXQeGtFPZ0oIJt812LKwqWesBERUfxUGDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKakdK8G; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740764887; x=1772300887;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jEGuY85aQVAWxR1y/cDpCIMIorypJGos60cokjssuUE=;
  b=dKakdK8GtLNl1XMDPvj/eT78L4dYhif86RZHBrBYVGzwdMz8jpVLAtUT
   XDH/ebapnvwJFJyGsXDAY6yLjVevuTBkZC+adA4Y0ImX5ciTmBlkNPNH8
   tpRQeTxLOzUuUu1ZGftyP+GE8xyNmXn4ALnr4CaqVG5CX324RXj5AVJY6
   LZOsJyv903m2r15u1NwCPwaqZ+9NrWZUCi7x15o0Qx4s6EJOgiH1jzFc7
   RDTlof9RL7YomsFYB8gaoiIwDjAoaFT9Fuy7JItszplnbzUAuC/HK5wK5
   XCJqWkmrug9eY8BA4/RSD1mcrO0RDw/IyVesnkabpTgmvmYTpumyQxT41
   Q==;
X-CSE-ConnectionGUID: NTqhFNeXRgmoPaiffYXlGA==
X-CSE-MsgGUID: g+3bd5YISYKP5OUtgH452w==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="51905281"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="51905281"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 09:48:07 -0800
X-CSE-ConnectionGUID: hBrE6GCtSU2gcrO8zdq33A==
X-CSE-MsgGUID: gbg52CESQ4mavnNDI++USw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117892711"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 28 Feb 2025 09:48:05 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to4Sx-000FJQ-0L;
	Fri, 28 Feb 2025 17:48:03 +0000
Date: Sat, 1 Mar 2025 01:47:29 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: drivers/most/most_snd.c:58: warning: Excess struct member 'opened'
 description in 'channel'
Message-ID: <202503010132.Tm7IXIxx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   76544811c850a1f4c055aa182b513b7a843868ea
commit: 512d092d78823f9813f4af38090b33c454137a4c ALSA: Enable build with UML
date:   1 year, 7 months ago
config: um-randconfig-001-20240624 (https://download.01.org/0day-ci/archive/20250301/202503010132.Tm7IXIxx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503010132.Tm7IXIxx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503010132.Tm7IXIxx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/most/most_snd.c:58: warning: Excess struct member 'opened' description in 'channel'


vim +58 drivers/most/most_snd.c

54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  26  
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  27  /**
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  28   * struct channel - private structure to keep channel specific data
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  29   * @substream: stores the substream structure
fba3993e86cc44 drivers/most/most_snd.c                Randy Dunlap    2023-01-12  30   * @pcm_hardware: low-level hardware description
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  31   * @iface: interface for which the channel belongs to
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  32   * @cfg: channel configuration
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  33   * @card: registered sound card
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  34   * @list: list for private use
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  35   * @id: channel index
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  36   * @period_pos: current period position (ring buffer)
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  37   * @buffer_pos: current buffer position (ring buffer)
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  38   * @is_stream_running: identifies whether a stream is running or not
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  39   * @opened: set when the stream is opened
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  40   * @playback_task: playback thread
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  41   * @playback_waitq: waitq used by playback thread
fba3993e86cc44 drivers/most/most_snd.c                Randy Dunlap    2023-01-12  42   * @copy_fn: copy function for PCM-specific format and width
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  43   */
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  44  struct channel {
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  45  	struct snd_pcm_substream *substream;
d801887248312f drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-09-28  46  	struct snd_pcm_hardware pcm_hardware;
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  47  	struct most_interface *iface;
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  48  	struct most_channel_config *cfg;
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  49  	struct snd_card *card;
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  50  	struct list_head list;
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  51  	int id;
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  52  	unsigned int period_pos;
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  53  	unsigned int buffer_pos;
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  54  	bool is_stream_running;
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  55  	struct task_struct *playback_task;
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  56  	wait_queue_head_t playback_waitq;
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  57  	void (*copy_fn)(void *alsa, void *most, unsigned int bytes);
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24 @58  };
54b4856fb36246 drivers/staging/most/aim-sound/sound.c Christian Gromm 2015-07-24  59  

:::::: The code at line 58 was first introduced by commit
:::::: 54b4856fb3624609dd5d9ed013bfec7d67083622 Staging: most: add MOST driver's aim-sound module

:::::: TO: Christian Gromm <christian.gromm@microchip.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

