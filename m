Return-Path: <linux-kernel+bounces-329727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA1B979509
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 09:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EE61C21934
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026CF1CF93;
	Sun, 15 Sep 2024 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyEgZ0yJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF96168BE
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726385680; cv=none; b=XptkPNwa+9IQyhmGxd5aBniRBPodqnw5wcJCS0Q14VUpcacaFGNEzl5M0Ti+mvCJc+B6sGn//I6ScPUYz0CBCsgUBN4qH04LD9ZWs26ouYjwnmMabcncKH8jNsQ0U/xeXfLAc/URxwo2Zngq0UqsLVWtZ9DfQ+U7gdFEqSFMajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726385680; c=relaxed/simple;
	bh=vI/EqcHfqLXhj+Xp5qXnWOanPCfo3IcQWUPpWplXq/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bFTzmuI7TLzNdOIibiQrU/9e6o5MqkXlfAl5pv7T5SWUX1SIG0eBykDR+nZ0+tsLURBlg2AaOgCNQQ4sI4XzO9I6PxGYhbk4Xe0xrmJWccMQI3ZmojiTZGfNvK/IrKwqMkXCDyvUveiF+33RTuEBhUpwOiHNQFmdel0FL0EMP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyEgZ0yJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726385678; x=1757921678;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vI/EqcHfqLXhj+Xp5qXnWOanPCfo3IcQWUPpWplXq/8=;
  b=AyEgZ0yJY2qp4tk3k1/CZIiU9eyqyHbM5iw5rA1N+OvaIGMq33tqDs2U
   3Eq44sMFvWuiyPuf2Plwgh5/RTH8hxomdjcgnXGNaUPU5H6jBoGQTPMgb
   xql4baSzpBeAKafnUYF0eX7Y7KifvmrXJ+E9ybDQnTIUoVd2F33+sLAIe
   BbUlxXe/lz5W4trZjcNpY9HSvcEEuRNY5sjNVP4PqtmzYsM/sDyy1D0IH
   4oYM/ilDUFWK6vcuoC4YDCUBSq6DVhpgnSbfzZscskDSCMicATpjY0cO1
   oYJ2CrRLFGUq2p5EqJQxfHduvlhsCjCD4v1zxzvwZksdAfcfMnsCms3ML
   A==;
X-CSE-ConnectionGUID: jeDYM3ayT9ezuGNLbCEFgg==
X-CSE-MsgGUID: lJf2dLulQIeL3Sz+aY28Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25392834"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="25392834"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 00:34:37 -0700
X-CSE-ConnectionGUID: f478bZOAQU+HBku6EDx/EA==
X-CSE-MsgGUID: s5eQomInSK6ufiyxpWDI8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="69339722"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Sep 2024 00:34:36 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spjmD-0008Us-2F;
	Sun, 15 Sep 2024 07:34:33 +0000
Date: Sun, 15 Sep 2024 15:33:44 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: drivers/video/console/dummycon.c:26:25: error:
 'CONFIG_DUMMY_CONSOLE_COLUMNS' undeclared; did you mean
 'CONFIG_DUMMY_CONSOLE'?
Message-ID: <202409151512.LML1slol-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0babf683783ddca06551537c6781e413cfe8d27b
commit: 4293b09251490fe493c3fc5e0d3de7168fe70039 dummycon: limit Arm console size hack to footbridge
date:   11 months ago
config: arm-randconfig-r003-20221107 (https://download.01.org/0day-ci/archive/20240915/202409151512.LML1slol-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240915/202409151512.LML1slol-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409151512.LML1slol-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/video/console/dummycon.c: In function 'dummycon_init':
>> drivers/video/console/dummycon.c:26:25: error: 'CONFIG_DUMMY_CONSOLE_COLUMNS' undeclared (first use in this function); did you mean 'CONFIG_DUMMY_CONSOLE'?
      26 | #define DUMMY_COLUMNS   CONFIG_DUMMY_CONSOLE_COLUMNS
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/console/dummycon.c:104:23: note: in expansion of macro 'DUMMY_COLUMNS'
     104 |         vc->vc_cols = DUMMY_COLUMNS;
         |                       ^~~~~~~~~~~~~
   drivers/video/console/dummycon.c:26:25: note: each undeclared identifier is reported only once for each function it appears in
      26 | #define DUMMY_COLUMNS   CONFIG_DUMMY_CONSOLE_COLUMNS
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/console/dummycon.c:104:23: note: in expansion of macro 'DUMMY_COLUMNS'
     104 |         vc->vc_cols = DUMMY_COLUMNS;
         |                       ^~~~~~~~~~~~~
>> drivers/video/console/dummycon.c:27:25: error: 'CONFIG_DUMMY_CONSOLE_ROWS' undeclared (first use in this function); did you mean 'CONFIG_DUMMY_CONSOLE'?
      27 | #define DUMMY_ROWS      CONFIG_DUMMY_CONSOLE_ROWS
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/video/console/dummycon.c:105:23: note: in expansion of macro 'DUMMY_ROWS'
     105 |         vc->vc_rows = DUMMY_ROWS;
         |                       ^~~~~~~~~~


vim +26 drivers/video/console/dummycon.c

^1da177e4c3f41 Linus Torvalds     2005-04-16   16  
^1da177e4c3f41 Linus Torvalds     2005-04-16   17  /*
^1da177e4c3f41 Linus Torvalds     2005-04-16   18   *  Dummy console driver
^1da177e4c3f41 Linus Torvalds     2005-04-16   19   */
^1da177e4c3f41 Linus Torvalds     2005-04-16   20  
4293b09251490f Arnd Bergmann      2023-10-09   21  #if defined(CONFIG_ARCH_FOOTBRIDGE) && defined(CONFIG_VGA_CONSOLE)
3ea33510001478 H. Peter Anvin     2007-10-16   22  #define DUMMY_COLUMNS	screen_info.orig_video_cols
3ea33510001478 H. Peter Anvin     2007-10-16   23  #define DUMMY_ROWS	screen_info.orig_video_lines
8f5b1e6511b83a Geert Uytterhoeven 2015-01-12   24  #else
^1da177e4c3f41 Linus Torvalds     2005-04-16   25  /* set by Kconfig. Use 80x25 for 640x480 and 160x64 for 1280x1024 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  @26  #define DUMMY_COLUMNS	CONFIG_DUMMY_CONSOLE_COLUMNS
^1da177e4c3f41 Linus Torvalds     2005-04-16  @27  #define DUMMY_ROWS	CONFIG_DUMMY_CONSOLE_ROWS
^1da177e4c3f41 Linus Torvalds     2005-04-16   28  #endif
^1da177e4c3f41 Linus Torvalds     2005-04-16   29  
83d83bebf40132 Hans de Goede      2018-06-28   30  #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
83d83bebf40132 Hans de Goede      2018-06-28   31  /* These are both protected by the console_lock */
83d83bebf40132 Hans de Goede      2018-06-28   32  static RAW_NOTIFIER_HEAD(dummycon_output_nh);
83d83bebf40132 Hans de Goede      2018-06-28   33  static bool dummycon_putc_called;
83d83bebf40132 Hans de Goede      2018-06-28   34  
83d83bebf40132 Hans de Goede      2018-06-28   35  void dummycon_register_output_notifier(struct notifier_block *nb)
83d83bebf40132 Hans de Goede      2018-06-28   36  {
214b0dd591abfd Daniel Vetter      2019-05-28   37  	WARN_CONSOLE_UNLOCKED();
214b0dd591abfd Daniel Vetter      2019-05-28   38  
83d83bebf40132 Hans de Goede      2018-06-28   39  	raw_notifier_chain_register(&dummycon_output_nh, nb);
83d83bebf40132 Hans de Goede      2018-06-28   40  
83d83bebf40132 Hans de Goede      2018-06-28   41  	if (dummycon_putc_called)
83d83bebf40132 Hans de Goede      2018-06-28   42  		nb->notifier_call(nb, 0, NULL);
83d83bebf40132 Hans de Goede      2018-06-28   43  }
83d83bebf40132 Hans de Goede      2018-06-28   44  
83d83bebf40132 Hans de Goede      2018-06-28   45  void dummycon_unregister_output_notifier(struct notifier_block *nb)
83d83bebf40132 Hans de Goede      2018-06-28   46  {
214b0dd591abfd Daniel Vetter      2019-05-28   47  	WARN_CONSOLE_UNLOCKED();
214b0dd591abfd Daniel Vetter      2019-05-28   48  
83d83bebf40132 Hans de Goede      2018-06-28   49  	raw_notifier_chain_unregister(&dummycon_output_nh, nb);
83d83bebf40132 Hans de Goede      2018-06-28   50  }
83d83bebf40132 Hans de Goede      2018-06-28   51  
83d83bebf40132 Hans de Goede      2018-06-28   52  static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
83d83bebf40132 Hans de Goede      2018-06-28   53  {
214b0dd591abfd Daniel Vetter      2019-05-28   54  	WARN_CONSOLE_UNLOCKED();
214b0dd591abfd Daniel Vetter      2019-05-28   55  
83d83bebf40132 Hans de Goede      2018-06-28   56  	dummycon_putc_called = true;
83d83bebf40132 Hans de Goede      2018-06-28   57  	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
83d83bebf40132 Hans de Goede      2018-06-28   58  }
83d83bebf40132 Hans de Goede      2018-06-28   59  
83d83bebf40132 Hans de Goede      2018-06-28   60  static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
83d83bebf40132 Hans de Goede      2018-06-28   61  			   int count, int ypos, int xpos)
83d83bebf40132 Hans de Goede      2018-06-28   62  {
83d83bebf40132 Hans de Goede      2018-06-28   63  	int i;
83d83bebf40132 Hans de Goede      2018-06-28   64  
83d83bebf40132 Hans de Goede      2018-06-28   65  	if (!dummycon_putc_called) {
83d83bebf40132 Hans de Goede      2018-06-28   66  		/* Ignore erases */
83d83bebf40132 Hans de Goede      2018-06-28   67  		for (i = 0 ; i < count; i++) {
83d83bebf40132 Hans de Goede      2018-06-28   68  			if (s[i] != vc->vc_video_erase_char)
83d83bebf40132 Hans de Goede      2018-06-28   69  				break;
83d83bebf40132 Hans de Goede      2018-06-28   70  		}
83d83bebf40132 Hans de Goede      2018-06-28   71  		if (i == count)
83d83bebf40132 Hans de Goede      2018-06-28   72  			return;
83d83bebf40132 Hans de Goede      2018-06-28   73  
83d83bebf40132 Hans de Goede      2018-06-28   74  		dummycon_putc_called = true;
83d83bebf40132 Hans de Goede      2018-06-28   75  	}
83d83bebf40132 Hans de Goede      2018-06-28   76  
83d83bebf40132 Hans de Goede      2018-06-28   77  	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
83d83bebf40132 Hans de Goede      2018-06-28   78  }
83d83bebf40132 Hans de Goede      2018-06-28   79  
83d83bebf40132 Hans de Goede      2018-06-28   80  static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
83d83bebf40132 Hans de Goede      2018-06-28   81  {
83d83bebf40132 Hans de Goede      2018-06-28   82  	/* Redraw, so that we get putc(s) for output done while blanked */
83d83bebf40132 Hans de Goede      2018-06-28   83  	return 1;
83d83bebf40132 Hans de Goede      2018-06-28   84  }
83d83bebf40132 Hans de Goede      2018-06-28   85  #else
83d83bebf40132 Hans de Goede      2018-06-28   86  static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
83d83bebf40132 Hans de Goede      2018-06-28   87  static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
83d83bebf40132 Hans de Goede      2018-06-28   88  			   int count, int ypos, int xpos) { }
83d83bebf40132 Hans de Goede      2018-06-28   89  static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
83d83bebf40132 Hans de Goede      2018-06-28   90  {
83d83bebf40132 Hans de Goede      2018-06-28   91  	return 0;
83d83bebf40132 Hans de Goede      2018-06-28   92  }
83d83bebf40132 Hans de Goede      2018-06-28   93  #endif
83d83bebf40132 Hans de Goede      2018-06-28   94  
^1da177e4c3f41 Linus Torvalds     2005-04-16   95  static const char *dummycon_startup(void)
^1da177e4c3f41 Linus Torvalds     2005-04-16   96  {
^1da177e4c3f41 Linus Torvalds     2005-04-16   97      return "dummy device";
^1da177e4c3f41 Linus Torvalds     2005-04-16   98  }
^1da177e4c3f41 Linus Torvalds     2005-04-16   99  
^1da177e4c3f41 Linus Torvalds     2005-04-16  100  static void dummycon_init(struct vc_data *vc, int init)
^1da177e4c3f41 Linus Torvalds     2005-04-16  101  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  102      vc->vc_can_do_color = 1;
^1da177e4c3f41 Linus Torvalds     2005-04-16  103      if (init) {
^1da177e4c3f41 Linus Torvalds     2005-04-16 @104  	vc->vc_cols = DUMMY_COLUMNS;
^1da177e4c3f41 Linus Torvalds     2005-04-16  105  	vc->vc_rows = DUMMY_ROWS;
^1da177e4c3f41 Linus Torvalds     2005-04-16  106      } else
^1da177e4c3f41 Linus Torvalds     2005-04-16  107  	vc_resize(vc, DUMMY_COLUMNS, DUMMY_ROWS);
^1da177e4c3f41 Linus Torvalds     2005-04-16  108  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  109  

:::::: The code at line 26 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

