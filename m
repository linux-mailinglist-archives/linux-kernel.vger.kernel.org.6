Return-Path: <linux-kernel+bounces-510474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF95FA31D84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9A3162EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC511E9905;
	Wed, 12 Feb 2025 04:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HP79/2+R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A227183B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739335380; cv=none; b=rc6TBzeyvpwQi2IGvO8m9XgXiOeWjCakmisFiFpGbjUy0hI4Y18U+fsa/POFtzecWecEWCdDw8wZK2XhsxwSmoxf+fNSNINEGlrh1BqxaQZBrR/eHC8S3VFJkseIQHR6hFivpalf7jiGWYgobW4dulsGSWPwdw//DS3OcQBcWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739335380; c=relaxed/simple;
	bh=GDeaeZH8t1+gAb6VATABMMpqtAd9Qc/3ExpSoq+Sxjg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J4SVJsQSJACuQqTHIBHvXRrAJAUA4wjvVLTHuHlMybSwH+iZXVE1KeLwz2Y+BMrv73trKpuCgQqqmhhvNLB5kGZt6rBjc9e2r+9zY5y9XYb1ZjClXSGGCPaOtvJmC1hGMxWZGmnZd0TfmeAcj7cYMT0M9gDb3u69j0XGB4nV31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HP79/2+R; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739335378; x=1770871378;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GDeaeZH8t1+gAb6VATABMMpqtAd9Qc/3ExpSoq+Sxjg=;
  b=HP79/2+Rr9kTIGR/+tlUqDtk2dSod1pd5aisuS+y8Jm6jgRBmYvIm1yi
   awY16TTlXaPkHuGQlyLq98ONb6gnx1/gshnRX53Vdhhd/928dmSuBFiRI
   qojxZcblrSqe9AVf49yG5eHFBOyTXTv+EUghkiU4wYZz6ZAQAniehK7W7
   Fxbkv+8o9kjNtvLxFuhhrhULTg3ZoFGZNzZyM9zCCROG1J7RF6wVgSATU
   btshOjtBhkPDY9XjczT1OW7+SWOkg/E/pgaun0I5oL10jsp4RAjwlThyn
   pbsJ0OQ6VuD2Z/WBmzGFEmv1UOEETw14B/8sa3JWdWkLnWG1ElkrVmeEB
   Q==;
X-CSE-ConnectionGUID: DmygjJ9dQ2Kzcdji0ImbEw==
X-CSE-MsgGUID: xl9OnznLQwqy4MLvvoVGyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39839671"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39839671"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 20:42:57 -0800
X-CSE-ConnectionGUID: dVf7tGExRnOCLoDSzXIIaQ==
X-CSE-MsgGUID: uu+oYehYR5SsWIhcyuV4oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117792148"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 20:42:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti4aL-00157n-0U;
	Wed, 12 Feb 2025 04:42:53 +0000
Date: Wed, 12 Feb 2025 12:41:57 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: drivers/most/most_snd.c:58: warning: Excess struct member 'opened'
 description in 'channel'
Message-ID: <202502121231.jdgxuPA7-lkp@intel.com>
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
head:   09fbf3d502050282bf47ab3babe1d4ed54dd1fd8
commit: 512d092d78823f9813f4af38090b33c454137a4c ALSA: Enable build with UML
date:   1 year, 7 months ago
config: um-randconfig-001-20240624 (https://download.01.org/0day-ci/archive/20250212/202502121231.jdgxuPA7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502121231.jdgxuPA7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502121231.jdgxuPA7-lkp@intel.com/

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

