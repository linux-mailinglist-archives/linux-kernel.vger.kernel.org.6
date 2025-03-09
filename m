Return-Path: <linux-kernel+bounces-553152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB5CA584E2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAF33A7630
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD31DE3A8;
	Sun,  9 Mar 2025 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jF2AaZSX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6D1D6DAD
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741529983; cv=none; b=inzHBkLLOFLbgXezeTbCdb6jTsl/uct/v6UJiIupSFYEWKeyMXmpEMRtb+joRiBvJnI0Y4Ab4MUH9lpBGMqC/zTUND66+zIEnU2sUgn4F6gnxxlGsA3juusb+ak/NfZFFkvnL1ZNqCbHR74ChEotwBg5X3V7EzGa04hTWo/HFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741529983; c=relaxed/simple;
	bh=ZG2rzKu6iXilCkrrkwptgdpwn28MXDhu6DMLhGe1TIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PRqQHpdryefXT2FGiaQsE5LHDQrgdgDl9HHAzBe3zZKn2rf07SxIXdIrftBcWpATuuT0FT6T+R5nLZII0NxDli6071YRAmvQGkcGwJz+UKDQPhxdiFSNbmmYypBCy1zmoLoxjrdv5xaUAEUaG4XR53gyjHWHw6BMwvO2qQ7I69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jF2AaZSX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741529981; x=1773065981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZG2rzKu6iXilCkrrkwptgdpwn28MXDhu6DMLhGe1TIA=;
  b=jF2AaZSXgrkopYSdVstPEgdhQXkpX1jF7eLAqcK9WPaVWhHH7GjZaObR
   AJbVWhpi4we+0//xeKqM5+ZpvuvWv6TkSsTLK24I8iOM37XgP+qjxePt2
   d7rs78IsmfTW2GvV799BsHQFPxgd2k5z3ydRH+2jPSUNHad9hC7oyd8Or
   MDZsuSLXHJWNHO/7+RaVmQ16RnBVrGOvwA3vE/2qaNPSRE20bqitBL0Bw
   5oasdLP3ABrUBGRorWSfjBLQnqbBFEvUCisnwzExnhgMOUhMyfVrpxFS+
   RNeExC+Z7vpnh1g8tE4/ehK6H0jmVd63lbGkoItftAfpUyuh5HCDpblAb
   g==;
X-CSE-ConnectionGUID: hiyeKpclS/ixlCzYOdnbIQ==
X-CSE-MsgGUID: 5hZPWicDQy22QRDKRFjA1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42568596"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="42568596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 07:19:41 -0700
X-CSE-ConnectionGUID: COab6tBdQ4WTqq6hRftOIg==
X-CSE-MsgGUID: Z8dMQavqQrSFOfV67h0yRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120666787"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 09 Mar 2025 07:19:40 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trHV6-0003As-2u;
	Sun, 09 Mar 2025 14:19:34 +0000
Date: Sun, 9 Mar 2025 22:19:01 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: drivers/most/most_snd.c:58: warning: Excess struct member 'opened'
 description in 'channel'
Message-ID: <202503092254.0yxhP6hv-lkp@intel.com>
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
head:   1110ce6a1e34fe1fdc1bfe4ad52405f327d5083b
commit: 512d092d78823f9813f4af38090b33c454137a4c ALSA: Enable build with UML
date:   1 year, 8 months ago
config: um-randconfig-001-20240624 (https://download.01.org/0day-ci/archive/20250309/202503092254.0yxhP6hv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503092254.0yxhP6hv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503092254.0yxhP6hv-lkp@intel.com/

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

