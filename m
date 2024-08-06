Return-Path: <linux-kernel+bounces-275503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA40948696
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECB01F23494
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851429476;
	Tue,  6 Aug 2024 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nejeXTie"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB610F1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722903518; cv=none; b=kAgFcyOD7kSfGfSNw/ByxfaP4OxIG5FFp3A9t7IA+l14CosJF+gSyt8peZqLMJGkBXSxZo5YwPpdDr8SaxQZ5K4ni0a5bCdufPSXli89Fe2CbqWNcgUQQJI43QGBi2BsMIZlTX7YaGf90UJE3j+aEoVa+Sl3raDhG/JQvqCTvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722903518; c=relaxed/simple;
	bh=iBQQoPnPFu3x0hoJEL6ONUfPNzhAReU3HB5vyjT/ajQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tF2/5JzO5XmdtrIVG1VUMYGnXRyNqy1vwVMnttN9qKU3dChBpzITXuCVwB9YaSvGyqLD3DO/kT9Yjt3MnPMBCIVkY3bp00Xy3UAZvwM+Afn7Xol81Fd49Q0P5jT0QvODSXUMZ5Gio2H9iFNE8cM33GnVlurBWD+skmLZseFK02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nejeXTie; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722903516; x=1754439516;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iBQQoPnPFu3x0hoJEL6ONUfPNzhAReU3HB5vyjT/ajQ=;
  b=nejeXTie63CYrEKHt8rDztSsvh0ZHyQY9fUIJg4FYYTAFlyyQUEnEBAb
   2wWXM5+LyrA1PsTgwPmnvUK0xVtJTTUZv9/jmg6HJ+F86kUgJOWeIhKcc
   jJFmSaeRh6NA/Iq9HBGmsgRSpe3HcZPko0ptCIUWyTFcYSTWOWrEdFyNR
   p6rdb9lCm7hW5CGHOaghSMOdymR1KnCkc0yy3Z7PldVBxqa8LsBWPgs0M
   RnLAUJxoAJgyshr0h+qiuggPP3tjvB/UuKAEg8D2j2FSsCcz7hWdyBeYf
   5VTfYCZhyUpmYqdascpN3nQytgo1nNrg3Cr2b5+GvVFHmZML/gyybp9uf
   g==;
X-CSE-ConnectionGUID: IsvZxFYGQASm9p39MeSBLA==
X-CSE-MsgGUID: mRyRDcj6T6GYIm4aviBu0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="24660599"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="24660599"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 17:18:36 -0700
X-CSE-ConnectionGUID: +w5pes7HR9yg7A/B+boM8Q==
X-CSE-MsgGUID: gcuPaYToTy+lRjN8h2GvHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56420300"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 05 Aug 2024 17:18:34 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sb7uJ-0003wb-30;
	Tue, 06 Aug 2024 00:18:31 +0000
Date: Tue, 6 Aug 2024 08:17:22 +0800
From: kernel test robot <lkp@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Ard Biesheuvel <ardb@kernel.org>,
	Abbott Liu <liuwenliang@huawei.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: drivers/interconnect/qcom/bcm-voter.c:339:1: warning: the frame size
 of 1104 bytes is larger than 1024 bytes
Message-ID: <202408060845.RPSHdunC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b446a2dae984fa5bd56dd7c3a02a426f87e05813
commit: 421015713b306e47af95d4d61cdfbd96d462e4cb ARM: 9017/2: Enable KASan for ARM
date:   3 years, 9 months ago
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240806/202408060845.RPSHdunC-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408060845.RPSHdunC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408060845.RPSHdunC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/interconnect/qcom/bcm-voter.c: In function 'qcom_icc_bcm_voter_commit':
>> drivers/interconnect/qcom/bcm-voter.c:339:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     339 | }
         | ^


vim +339 drivers/interconnect/qcom/bcm-voter.c

976daac4a1c581 David Dai   2020-02-28  239  
976daac4a1c581 David Dai   2020-02-28  240  /**
976daac4a1c581 David Dai   2020-02-28  241   * qcom_icc_bcm_voter_commit - generates and commits tcs cmds based on bcms
976daac4a1c581 David Dai   2020-02-28  242   * @voter: voter that needs flushing
976daac4a1c581 David Dai   2020-02-28  243   *
976daac4a1c581 David Dai   2020-02-28  244   * This function generates a set of AMC commands and flushes to the BCM device
976daac4a1c581 David Dai   2020-02-28  245   * associated with the voter. It conditionally generate WAKE and SLEEP commands
976daac4a1c581 David Dai   2020-02-28  246   * based on deltas between WAKE/SLEEP requirements. The ws_list persists
976daac4a1c581 David Dai   2020-02-28  247   * through multiple commit requests and bcm nodes are removed only when the
976daac4a1c581 David Dai   2020-02-28  248   * requirements for WAKE matches SLEEP.
976daac4a1c581 David Dai   2020-02-28  249   *
976daac4a1c581 David Dai   2020-02-28  250   * Returns 0 on success, or an appropriate error code otherwise.
976daac4a1c581 David Dai   2020-02-28  251   */
976daac4a1c581 David Dai   2020-02-28  252  int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
976daac4a1c581 David Dai   2020-02-28  253  {
976daac4a1c581 David Dai   2020-02-28  254  	struct qcom_icc_bcm *bcm;
976daac4a1c581 David Dai   2020-02-28  255  	struct qcom_icc_bcm *bcm_tmp;
976daac4a1c581 David Dai   2020-02-28  256  	int commit_idx[MAX_VCD + 1];
976daac4a1c581 David Dai   2020-02-28  257  	struct tcs_cmd cmds[MAX_BCMS];
976daac4a1c581 David Dai   2020-02-28  258  	int ret = 0;
976daac4a1c581 David Dai   2020-02-28  259  
976daac4a1c581 David Dai   2020-02-28  260  	if (!voter)
976daac4a1c581 David Dai   2020-02-28  261  		return 0;
976daac4a1c581 David Dai   2020-02-28  262  
976daac4a1c581 David Dai   2020-02-28  263  	mutex_lock(&voter->lock);
976daac4a1c581 David Dai   2020-02-28  264  	list_for_each_entry(bcm, &voter->commit_list, list)
976daac4a1c581 David Dai   2020-02-28  265  		bcm_aggregate(bcm);
976daac4a1c581 David Dai   2020-02-28  266  
976daac4a1c581 David Dai   2020-02-28  267  	/*
976daac4a1c581 David Dai   2020-02-28  268  	 * Pre sort the BCMs based on VCD for ease of generating a command list
976daac4a1c581 David Dai   2020-02-28  269  	 * that groups the BCMs with the same VCD together. VCDs are numbered
976daac4a1c581 David Dai   2020-02-28  270  	 * with lowest being the most expensive time wise, ensuring that
976daac4a1c581 David Dai   2020-02-28  271  	 * those commands are being sent the earliest in the queue. This needs
976daac4a1c581 David Dai   2020-02-28  272  	 * to be sorted every commit since we can't guarantee the order in which
976daac4a1c581 David Dai   2020-02-28  273  	 * the BCMs are added to the list.
976daac4a1c581 David Dai   2020-02-28  274  	 */
976daac4a1c581 David Dai   2020-02-28  275  	list_sort(NULL, &voter->commit_list, cmp_vcd);
976daac4a1c581 David Dai   2020-02-28  276  
976daac4a1c581 David Dai   2020-02-28  277  	/*
976daac4a1c581 David Dai   2020-02-28  278  	 * Construct the command list based on a pre ordered list of BCMs
976daac4a1c581 David Dai   2020-02-28  279  	 * based on VCD.
976daac4a1c581 David Dai   2020-02-28  280  	 */
b92902fddf4200 Mike Tipton 2020-09-03  281  	tcs_list_gen(voter, QCOM_ICC_BUCKET_AMC, cmds, commit_idx);
976daac4a1c581 David Dai   2020-02-28  282  	if (!commit_idx[0])
976daac4a1c581 David Dai   2020-02-28  283  		goto out;
976daac4a1c581 David Dai   2020-02-28  284  
73edcd38d7720b Maulik Shah 2020-06-18  285  	rpmh_invalidate(voter->dev);
976daac4a1c581 David Dai   2020-02-28  286  
976daac4a1c581 David Dai   2020-02-28  287  	ret = rpmh_write_batch(voter->dev, RPMH_ACTIVE_ONLY_STATE,
976daac4a1c581 David Dai   2020-02-28  288  			       cmds, commit_idx);
976daac4a1c581 David Dai   2020-02-28  289  	if (ret) {
976daac4a1c581 David Dai   2020-02-28  290  		pr_err("Error sending AMC RPMH requests (%d)\n", ret);
976daac4a1c581 David Dai   2020-02-28  291  		goto out;
976daac4a1c581 David Dai   2020-02-28  292  	}
976daac4a1c581 David Dai   2020-02-28  293  
976daac4a1c581 David Dai   2020-02-28  294  	list_for_each_entry_safe(bcm, bcm_tmp, &voter->commit_list, list)
976daac4a1c581 David Dai   2020-02-28  295  		list_del_init(&bcm->list);
976daac4a1c581 David Dai   2020-02-28  296  
976daac4a1c581 David Dai   2020-02-28  297  	list_for_each_entry_safe(bcm, bcm_tmp, &voter->ws_list, ws_list) {
976daac4a1c581 David Dai   2020-02-28  298  		/*
976daac4a1c581 David Dai   2020-02-28  299  		 * Only generate WAKE and SLEEP commands if a resource's
976daac4a1c581 David Dai   2020-02-28  300  		 * requirements change as the execution environment transitions
976daac4a1c581 David Dai   2020-02-28  301  		 * between different power states.
976daac4a1c581 David Dai   2020-02-28  302  		 */
976daac4a1c581 David Dai   2020-02-28  303  		if (bcm->vote_x[QCOM_ICC_BUCKET_WAKE] !=
976daac4a1c581 David Dai   2020-02-28  304  		    bcm->vote_x[QCOM_ICC_BUCKET_SLEEP] ||
976daac4a1c581 David Dai   2020-02-28  305  		    bcm->vote_y[QCOM_ICC_BUCKET_WAKE] !=
976daac4a1c581 David Dai   2020-02-28  306  		    bcm->vote_y[QCOM_ICC_BUCKET_SLEEP])
976daac4a1c581 David Dai   2020-02-28  307  			list_add_tail(&bcm->list, &voter->commit_list);
976daac4a1c581 David Dai   2020-02-28  308  		else
976daac4a1c581 David Dai   2020-02-28  309  			list_del_init(&bcm->ws_list);
976daac4a1c581 David Dai   2020-02-28  310  	}
976daac4a1c581 David Dai   2020-02-28  311  
976daac4a1c581 David Dai   2020-02-28  312  	if (list_empty(&voter->commit_list))
976daac4a1c581 David Dai   2020-02-28  313  		goto out;
976daac4a1c581 David Dai   2020-02-28  314  
976daac4a1c581 David Dai   2020-02-28  315  	list_sort(NULL, &voter->commit_list, cmp_vcd);
976daac4a1c581 David Dai   2020-02-28  316  
b92902fddf4200 Mike Tipton 2020-09-03  317  	tcs_list_gen(voter, QCOM_ICC_BUCKET_WAKE, cmds, commit_idx);
976daac4a1c581 David Dai   2020-02-28  318  
976daac4a1c581 David Dai   2020-02-28  319  	ret = rpmh_write_batch(voter->dev, RPMH_WAKE_ONLY_STATE, cmds, commit_idx);
976daac4a1c581 David Dai   2020-02-28  320  	if (ret) {
976daac4a1c581 David Dai   2020-02-28  321  		pr_err("Error sending WAKE RPMH requests (%d)\n", ret);
976daac4a1c581 David Dai   2020-02-28  322  		goto out;
976daac4a1c581 David Dai   2020-02-28  323  	}
976daac4a1c581 David Dai   2020-02-28  324  
b92902fddf4200 Mike Tipton 2020-09-03  325  	tcs_list_gen(voter, QCOM_ICC_BUCKET_SLEEP, cmds, commit_idx);
976daac4a1c581 David Dai   2020-02-28  326  
976daac4a1c581 David Dai   2020-02-28  327  	ret = rpmh_write_batch(voter->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
976daac4a1c581 David Dai   2020-02-28  328  	if (ret) {
976daac4a1c581 David Dai   2020-02-28  329  		pr_err("Error sending SLEEP RPMH requests (%d)\n", ret);
976daac4a1c581 David Dai   2020-02-28  330  		goto out;
976daac4a1c581 David Dai   2020-02-28  331  	}
976daac4a1c581 David Dai   2020-02-28  332  
976daac4a1c581 David Dai   2020-02-28  333  out:
976daac4a1c581 David Dai   2020-02-28  334  	list_for_each_entry_safe(bcm, bcm_tmp, &voter->commit_list, list)
976daac4a1c581 David Dai   2020-02-28  335  		list_del_init(&bcm->list);
976daac4a1c581 David Dai   2020-02-28  336  
976daac4a1c581 David Dai   2020-02-28  337  	mutex_unlock(&voter->lock);
976daac4a1c581 David Dai   2020-02-28  338  	return ret;
976daac4a1c581 David Dai   2020-02-28 @339  }
976daac4a1c581 David Dai   2020-02-28  340  EXPORT_SYMBOL_GPL(qcom_icc_bcm_voter_commit);
976daac4a1c581 David Dai   2020-02-28  341  

:::::: The code at line 339 was first introduced by commit
:::::: 976daac4a1c581e5d5fd64047519fd6fcde39738 interconnect: qcom: Consolidate interconnect RPMh support

:::::: TO: David Dai <daidavid1@codeaurora.org>
:::::: CC: Georgi Djakov <georgi.djakov@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

