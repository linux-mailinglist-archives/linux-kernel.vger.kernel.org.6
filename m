Return-Path: <linux-kernel+bounces-341282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C9E987DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4EA284F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BCA171E4F;
	Fri, 27 Sep 2024 04:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="DV3zStGr"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C714A4D6
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 04:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727413097; cv=none; b=BsS9J5WOrkJpgVtKrFQCIS3eONMl86zk4vT6Pp0gmW18Nrd0JT43rwzPyKZI/90iIQ6w5pprM+iktk5/Nb+afQ1sVJ261cu5hWS/EjpqxRY5fbcCbup3lfSxdN77zQVS+XzcTyGwT1xoOYmd1o3+DqWGolQdhNu+IaoX7EihtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727413097; c=relaxed/simple;
	bh=wBaXn6nM8ld0jSY+sVPJtoxG9uLmySZVUPA+BotAIz0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=S7urnTkn2nbTwS7f/lqVXp7syuOgZIEWScOrzmr4uCeUyUit4ihlIArXed+V1G/Os01faD6t2YQhclzP6IKWS0U/dW2c4Ivp1NASXSdE8kZN6l/Jqqvi8SDqCWI0gPRcy1IwuvQfzIJ1GawkMQ4Gtzw5Uz3XVpYLMCvc3OItOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=DV3zStGr; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zcHBQfoliBGYPQWk0i8hSpUVRAgTPmZq0rRbuAXIoQI=;
  b=DV3zStGr6kwQm/BnOsv0kF7LZXqgxkMKMp0myxj4juG9pY+9ItnovB5i
   I9iJWHo0jE2LovygByqHXWne0uxbHRAfS++gwBbTha7/p/P7QAL+P87BC
   TaSzvzuuomYdJRe8ZRF5mjpkasXQtUB838nMWbeSJMUk4p55r7Vad0Vxz
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,157,1725314400"; 
   d="scan'208";a="97543553"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 06:56:59 +0200
Date: Fri, 27 Sep 2024 06:56:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: James Smart <jsmart2021@gmail.com>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Dick Kennedy <dick.kennedy@broadcom.com>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/scsi/lpfc/lpfc_init.c:6834:31-32: WARNING opportunity for
 min() (fwd)
Message-ID: <alpine.DEB.2.22.394.2409270656060.3334@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1823911411-1727413019=:3334"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1823911411-1727413019=:3334
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Please see line 6834.

julia

---------- Forwarded message ----------
Date: Fri, 27 Sep 2024 05:33:14 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/scsi/lpfc/lpfc_init.c:6834:31-32: WARNING opportunity for min()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: James Smart <jsmart2021@gmail.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: Dick Kennedy <dick.kennedy@broadcom.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   075dbe9f6e3c21596c5245826a4ee1f1c1676eb8
commit: d79c9e9d4b3d9330ee38f392a7c98e0fc494f7f8 scsi: lpfc: Support dynamic unbounded SGL lists on G7 hardware.
date:   5 years ago
:::::: branch date: 2 hours ago
:::::: commit date: 5 years ago
config: x86_64-randconfig-102-20240924 (https://download.01.org/0day-ci/archive/20240927/202409270500.3iU99njW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202409270500.3iU99njW-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/scsi/lpfc/lpfc_init.c:6834:31-32: WARNING opportunity for min()

vim +6834 drivers/scsi/lpfc/lpfc_init.c

3772a99175f537 James Smart        2009-05-22  6429
3772a99175f537 James Smart        2009-05-22  6430  /**
da0436e915a5c1 James Smart        2009-05-22  6431   * lpfc_sli4_driver_resource_setup - Setup drvr internal resources for SLI4 dev
3772a99175f537 James Smart        2009-05-22  6432   * @phba: pointer to lpfc hba data structure.
3772a99175f537 James Smart        2009-05-22  6433   *
da0436e915a5c1 James Smart        2009-05-22  6434   * This routine is invoked to set up the driver internal resources specific to
da0436e915a5c1 James Smart        2009-05-22  6435   * support the SLI-4 HBA device it attached to.
3772a99175f537 James Smart        2009-05-22  6436   *
3772a99175f537 James Smart        2009-05-22  6437   * Return codes
af901ca181d92a André Goddard Rosa 2009-11-14  6438   * 	0 - successful
3772a99175f537 James Smart        2009-05-22  6439   * 	other values - error
3772a99175f537 James Smart        2009-05-22  6440   **/
3772a99175f537 James Smart        2009-05-22  6441  static int
da0436e915a5c1 James Smart        2009-05-22  6442  lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
3772a99175f537 James Smart        2009-05-22  6443  {
28baac7492fa08 James Smart        2010-02-12  6444  	LPFC_MBOXQ_t *mboxq;
f358dd0ca26c15 James Smart        2017-02-12  6445  	MAILBOX_t *mb;
895427bd012ce5 James Smart        2017-02-12  6446  	int rc, i, max_buf_size;
28baac7492fa08 James Smart        2010-02-12  6447  	uint8_t pn_page[LPFC_MAX_SUPPORTED_PAGES] = {0};
28baac7492fa08 James Smart        2010-02-12  6448  	struct lpfc_mqe *mqe;
09294d4623a314 James Smart        2013-04-17  6449  	int longs;
81e6a63728a409 James Smart        2017-11-20  6450  	int extra;
f358dd0ca26c15 James Smart        2017-02-12  6451  	uint64_t wwn;
b92dc72df3c6b4 James Smart        2018-05-24  6452  	u32 if_type;
b92dc72df3c6b4 James Smart        2018-05-24  6453  	u32 if_fam;
da0436e915a5c1 James Smart        2009-05-22  6454
895427bd012ce5 James Smart        2017-02-12  6455  	phba->sli4_hba.num_present_cpu = lpfc_present_cpu;
222e9239c60888 James Smart        2019-01-28  6456  	phba->sli4_hba.num_possible_cpu = num_possible_cpus();
895427bd012ce5 James Smart        2017-02-12  6457  	phba->sli4_hba.curr_disp_cpu = 0;
895427bd012ce5 James Smart        2017-02-12  6458
716d3bc5030bf9 James Smart        2013-09-06  6459  	/* Get all the module params for configuring this host */
716d3bc5030bf9 James Smart        2013-09-06  6460  	lpfc_get_cfgparam(phba);
716d3bc5030bf9 James Smart        2013-09-06  6461
895427bd012ce5 James Smart        2017-02-12  6462  	/* Set up phase-1 common device driver resources */
895427bd012ce5 James Smart        2017-02-12  6463  	rc = lpfc_setup_driver_resource_phase1(phba);
895427bd012ce5 James Smart        2017-02-12  6464  	if (rc)
895427bd012ce5 James Smart        2017-02-12  6465  		return -ENODEV;
895427bd012ce5 James Smart        2017-02-12  6466
da0436e915a5c1 James Smart        2009-05-22  6467  	/* Before proceed, wait for POST done and device ready */
da0436e915a5c1 James Smart        2009-05-22  6468  	rc = lpfc_sli4_post_status_check(phba);
da0436e915a5c1 James Smart        2009-05-22  6469  	if (rc)
da0436e915a5c1 James Smart        2009-05-22  6470  		return -ENODEV;
da0436e915a5c1 James Smart        2009-05-22  6471
3cee98db2610fb James Smart        2019-08-14  6472  	/* Allocate all driver workqueues here */
3cee98db2610fb James Smart        2019-08-14  6473
3cee98db2610fb James Smart        2019-08-14  6474  	/* The lpfc_wq workqueue for deferred irq use */
3cee98db2610fb James Smart        2019-08-14  6475  	phba->wq = alloc_workqueue("lpfc_wq", WQ_MEM_RECLAIM, 0);
3cee98db2610fb James Smart        2019-08-14  6476
3772a99175f537 James Smart        2009-05-22  6477  	/*
da0436e915a5c1 James Smart        2009-05-22  6478  	 * Initialize timers used by driver
3772a99175f537 James Smart        2009-05-22  6479  	 */
3772a99175f537 James Smart        2009-05-22  6480
f22eb4d31c21ac Kees Cook          2017-09-06  6481  	timer_setup(&phba->rrq_tmr, lpfc_rrq_timeout, 0);
3772a99175f537 James Smart        2009-05-22  6482
ecfd03c6a99ad9 James Smart        2010-02-12  6483  	/* FCF rediscover timer */
f22eb4d31c21ac Kees Cook          2017-09-06  6484  	timer_setup(&phba->fcf.redisc_wait, lpfc_sli4_fcf_redisc_wait_tmo, 0);
ecfd03c6a99ad9 James Smart        2010-02-12  6485
7ad20aa9d39a52 James Smart        2011-05-24  6486  	/*
7ad20aa9d39a52 James Smart        2011-05-24  6487  	 * Control structure for handling external multi-buffer mailbox
7ad20aa9d39a52 James Smart        2011-05-24  6488  	 * command pass-through.
7ad20aa9d39a52 James Smart        2011-05-24  6489  	 */
7ad20aa9d39a52 James Smart        2011-05-24  6490  	memset((uint8_t *)&phba->mbox_ext_buf_ctx, 0,
7ad20aa9d39a52 James Smart        2011-05-24  6491  		sizeof(struct lpfc_mbox_ext_buf_ctx));
7ad20aa9d39a52 James Smart        2011-05-24  6492  	INIT_LIST_HEAD(&phba->mbox_ext_buf_ctx.ext_dmabuf_list);
7ad20aa9d39a52 James Smart        2011-05-24  6493
da0436e915a5c1 James Smart        2009-05-22  6494  	phba->max_vpi = LPFC_MAX_VPI;
67d1273385d454 James Smart        2012-08-03  6495
da0436e915a5c1 James Smart        2009-05-22  6496  	/* This will be set to correct value after the read_config mbox */
da0436e915a5c1 James Smart        2009-05-22  6497  	phba->max_vports = 0;
3772a99175f537 James Smart        2009-05-22  6498
da0436e915a5c1 James Smart        2009-05-22  6499  	/* Program the default value of vlan_id and fc_map */
da0436e915a5c1 James Smart        2009-05-22  6500  	phba->valid_vlan = 0;
da0436e915a5c1 James Smart        2009-05-22  6501  	phba->fc_map[0] = LPFC_FCOE_FCF_MAP0;
da0436e915a5c1 James Smart        2009-05-22  6502  	phba->fc_map[1] = LPFC_FCOE_FCF_MAP1;
da0436e915a5c1 James Smart        2009-05-22  6503  	phba->fc_map[2] = LPFC_FCOE_FCF_MAP2;
3772a99175f537 James Smart        2009-05-22  6504
2a76a28314993d James Smart        2012-08-03  6505  	/*
2a76a28314993d James Smart        2012-08-03  6506  	 * For SLI4, instead of using ring 0 (LPFC_FCP_RING) for FCP commands
895427bd012ce5 James Smart        2017-02-12  6507  	 * we will associate a new ring, for each EQ/CQ/WQ tuple.
895427bd012ce5 James Smart        2017-02-12  6508  	 * The WQ create will allocate the ring.
2a76a28314993d James Smart        2012-08-03  6509  	 */
09294d4623a314 James Smart        2013-04-17  6510
da0436e915a5c1 James Smart        2009-05-22  6511  	/* Initialize buffer queue management fields */
895427bd012ce5 James Smart        2017-02-12  6512  	INIT_LIST_HEAD(&phba->hbqs[LPFC_ELS_HBQ].hbq_buffer_list);
da0436e915a5c1 James Smart        2009-05-22  6513  	phba->hbqs[LPFC_ELS_HBQ].hbq_alloc_buffer = lpfc_sli4_rb_alloc;
da0436e915a5c1 James Smart        2009-05-22  6514  	phba->hbqs[LPFC_ELS_HBQ].hbq_free_buffer = lpfc_sli4_rb_free;
3772a99175f537 James Smart        2009-05-22  6515
da0436e915a5c1 James Smart        2009-05-22  6516  	/*
da0436e915a5c1 James Smart        2009-05-22  6517  	 * Initialize the SLI Layer to run with lpfc SLI4 HBAs.
da0436e915a5c1 James Smart        2009-05-22  6518  	 */
895427bd012ce5 James Smart        2017-02-12  6519  	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_FCP) {
da0436e915a5c1 James Smart        2009-05-22  6520  		/* Initialize the Abort scsi buffer list used by driver */
da0436e915a5c1 James Smart        2009-05-22  6521  		spin_lock_init(&phba->sli4_hba.abts_scsi_buf_list_lock);
da0436e915a5c1 James Smart        2009-05-22  6522  		INIT_LIST_HEAD(&phba->sli4_hba.lpfc_abts_scsi_buf_list);
895427bd012ce5 James Smart        2017-02-12  6523  	}
895427bd012ce5 James Smart        2017-02-12  6524
895427bd012ce5 James Smart        2017-02-12  6525  	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
895427bd012ce5 James Smart        2017-02-12  6526  		/* Initialize the Abort nvme buffer list used by driver */
5e5b511d8bfaf7 James Smart        2019-01-28  6527  		spin_lock_init(&phba->sli4_hba.abts_nvmet_buf_list_lock);
86c6737963e1c6 James Smart        2017-04-21  6528  		INIT_LIST_HEAD(&phba->sli4_hba.lpfc_abts_nvmet_ctx_list);
a8cf5dfeb4d842 James Smart        2017-05-15  6529  		INIT_LIST_HEAD(&phba->sli4_hba.lpfc_nvmet_io_wait_list);
79d8c4ce01b273 James Smart        2019-05-21  6530  		spin_lock_init(&phba->sli4_hba.t_active_list_lock);
79d8c4ce01b273 James Smart        2019-05-21  6531  		INIT_LIST_HEAD(&phba->sli4_hba.t_active_ctx_list);
895427bd012ce5 James Smart        2017-02-12  6532  	}
895427bd012ce5 James Smart        2017-02-12  6533
da0436e915a5c1 James Smart        2009-05-22  6534  	/* This abort list used by worker thread */
895427bd012ce5 James Smart        2017-02-12  6535  	spin_lock_init(&phba->sli4_hba.sgl_list_lock);
a8cf5dfeb4d842 James Smart        2017-05-15  6536  	spin_lock_init(&phba->sli4_hba.nvmet_io_wait_lock);
3772a99175f537 James Smart        2009-05-22  6537
da0436e915a5c1 James Smart        2009-05-22  6538  	/*
6d368e532168cb James Smart        2011-05-24  6539  	 * Initialize driver internal slow-path work queues
da0436e915a5c1 James Smart        2009-05-22  6540  	 */
3772a99175f537 James Smart        2009-05-22  6541
da0436e915a5c1 James Smart        2009-05-22  6542  	/* Driver internel slow-path CQ Event pool */
da0436e915a5c1 James Smart        2009-05-22  6543  	INIT_LIST_HEAD(&phba->sli4_hba.sp_cqe_event_pool);
da0436e915a5c1 James Smart        2009-05-22  6544  	/* Response IOCB work queue list */
45ed119035b27f James Smart        2009-10-02  6545  	INIT_LIST_HEAD(&phba->sli4_hba.sp_queue_event);
da0436e915a5c1 James Smart        2009-05-22  6546  	/* Asynchronous event CQ Event work queue list */
da0436e915a5c1 James Smart        2009-05-22  6547  	INIT_LIST_HEAD(&phba->sli4_hba.sp_asynce_work_queue);
da0436e915a5c1 James Smart        2009-05-22  6548  	/* Fast-path XRI aborted CQ Event work queue list */
da0436e915a5c1 James Smart        2009-05-22  6549  	INIT_LIST_HEAD(&phba->sli4_hba.sp_fcp_xri_aborted_work_queue);
da0436e915a5c1 James Smart        2009-05-22  6550  	/* Slow-path XRI aborted CQ Event work queue list */
da0436e915a5c1 James Smart        2009-05-22  6551  	INIT_LIST_HEAD(&phba->sli4_hba.sp_els_xri_aborted_work_queue);
da0436e915a5c1 James Smart        2009-05-22  6552  	/* Receive queue CQ Event work queue list */
da0436e915a5c1 James Smart        2009-05-22  6553  	INIT_LIST_HEAD(&phba->sli4_hba.sp_unsol_work_queue);
da0436e915a5c1 James Smart        2009-05-22  6554
6d368e532168cb James Smart        2011-05-24  6555  	/* Initialize extent block lists. */
6d368e532168cb James Smart        2011-05-24  6556  	INIT_LIST_HEAD(&phba->sli4_hba.lpfc_rpi_blk_list);
6d368e532168cb James Smart        2011-05-24  6557  	INIT_LIST_HEAD(&phba->sli4_hba.lpfc_xri_blk_list);
6d368e532168cb James Smart        2011-05-24  6558  	INIT_LIST_HEAD(&phba->sli4_hba.lpfc_vfi_blk_list);
6d368e532168cb James Smart        2011-05-24  6559  	INIT_LIST_HEAD(&phba->lpfc_vpi_blk_list);
6d368e532168cb James Smart        2011-05-24  6560
d1f525aaa4d7e5 James Smart        2017-04-21  6561  	/* Initialize mboxq lists. If the early init routines fail
d1f525aaa4d7e5 James Smart        2017-04-21  6562  	 * these lists need to be correctly initialized.
d1f525aaa4d7e5 James Smart        2017-04-21  6563  	 */
d1f525aaa4d7e5 James Smart        2017-04-21  6564  	INIT_LIST_HEAD(&phba->sli.mboxq);
d1f525aaa4d7e5 James Smart        2017-04-21  6565  	INIT_LIST_HEAD(&phba->sli.mboxq_cmpl);
d1f525aaa4d7e5 James Smart        2017-04-21  6566
448193b5b5e247 James Smart        2015-12-16  6567  	/* initialize optic_state to 0xFF */
448193b5b5e247 James Smart        2015-12-16  6568  	phba->sli4_hba.lnk_info.optic_state = 0xff;
448193b5b5e247 James Smart        2015-12-16  6569
da0436e915a5c1 James Smart        2009-05-22  6570  	/* Allocate device driver memory */
da0436e915a5c1 James Smart        2009-05-22  6571  	rc = lpfc_mem_alloc(phba, SGL_ALIGN_SZ);
da0436e915a5c1 James Smart        2009-05-22  6572  	if (rc)
da0436e915a5c1 James Smart        2009-05-22  6573  		return -ENOMEM;
da0436e915a5c1 James Smart        2009-05-22  6574
2fcee4bf874a8a James Smart        2010-12-15  6575  	/* IF Type 2 ports get initialized now. */
27d6ac0a6e8300 James Smart        2018-02-22  6576  	if (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) >=
2fcee4bf874a8a James Smart        2010-12-15  6577  	    LPFC_SLI_INTF_IF_TYPE_2) {
2fcee4bf874a8a James Smart        2010-12-15  6578  		rc = lpfc_pci_function_reset(phba);
895427bd012ce5 James Smart        2017-02-12  6579  		if (unlikely(rc)) {
895427bd012ce5 James Smart        2017-02-12  6580  			rc = -ENODEV;
895427bd012ce5 James Smart        2017-02-12  6581  			goto out_free_mem;
895427bd012ce5 James Smart        2017-02-12  6582  		}
946727dc073dba James Smart        2015-04-07  6583  		phba->temp_sensor_support = 1;
2fcee4bf874a8a James Smart        2010-12-15  6584  	}
2fcee4bf874a8a James Smart        2010-12-15  6585
da0436e915a5c1 James Smart        2009-05-22  6586  	/* Create the bootstrap mailbox command */
da0436e915a5c1 James Smart        2009-05-22  6587  	rc = lpfc_create_bootstrap_mbox(phba);
da0436e915a5c1 James Smart        2009-05-22  6588  	if (unlikely(rc))
da0436e915a5c1 James Smart        2009-05-22  6589  		goto out_free_mem;
da0436e915a5c1 James Smart        2009-05-22  6590
da0436e915a5c1 James Smart        2009-05-22  6591  	/* Set up the host's endian order with the device. */
da0436e915a5c1 James Smart        2009-05-22  6592  	rc = lpfc_setup_endian_order(phba);
da0436e915a5c1 James Smart        2009-05-22  6593  	if (unlikely(rc))
da0436e915a5c1 James Smart        2009-05-22  6594  		goto out_free_bsmbx;
da0436e915a5c1 James Smart        2009-05-22  6595
da0436e915a5c1 James Smart        2009-05-22  6596  	/* Set up the hba's configuration parameters. */
da0436e915a5c1 James Smart        2009-05-22  6597  	rc = lpfc_sli4_read_config(phba);
cff261f6bd0361 James Smart        2013-12-17  6598  	if (unlikely(rc))
cff261f6bd0361 James Smart        2013-12-17  6599  		goto out_free_bsmbx;
cff261f6bd0361 James Smart        2013-12-17  6600  	rc = lpfc_mem_alloc_active_rrq_pool_s4(phba);
da0436e915a5c1 James Smart        2009-05-22  6601  	if (unlikely(rc))
da0436e915a5c1 James Smart        2009-05-22  6602  		goto out_free_bsmbx;
da0436e915a5c1 James Smart        2009-05-22  6603
2fcee4bf874a8a James Smart        2010-12-15  6604  	/* IF Type 0 ports get initialized now. */
2fcee4bf874a8a James Smart        2010-12-15  6605  	if (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) ==
2fcee4bf874a8a James Smart        2010-12-15  6606  	    LPFC_SLI_INTF_IF_TYPE_0) {
da0436e915a5c1 James Smart        2009-05-22  6607  		rc = lpfc_pci_function_reset(phba);
da0436e915a5c1 James Smart        2009-05-22  6608  		if (unlikely(rc))
da0436e915a5c1 James Smart        2009-05-22  6609  			goto out_free_bsmbx;
2fcee4bf874a8a James Smart        2010-12-15  6610  	}
da0436e915a5c1 James Smart        2009-05-22  6611
cb5172eafd9ffd James Smart        2010-03-15  6612  	mboxq = (LPFC_MBOXQ_t *) mempool_alloc(phba->mbox_mem_pool,
cb5172eafd9ffd James Smart        2010-03-15  6613  						       GFP_KERNEL);
cb5172eafd9ffd James Smart        2010-03-15  6614  	if (!mboxq) {
cb5172eafd9ffd James Smart        2010-03-15  6615  		rc = -ENOMEM;
cb5172eafd9ffd James Smart        2010-03-15  6616  		goto out_free_bsmbx;
cb5172eafd9ffd James Smart        2010-03-15  6617  	}
cb5172eafd9ffd James Smart        2010-03-15  6618
f358dd0ca26c15 James Smart        2017-02-12  6619  	/* Check for NVMET being configured */
895427bd012ce5 James Smart        2017-02-12  6620  	phba->nvmet_support = 0;
f358dd0ca26c15 James Smart        2017-02-12  6621  	if (lpfc_enable_nvmet_cnt) {
f358dd0ca26c15 James Smart        2017-02-12  6622
f358dd0ca26c15 James Smart        2017-02-12  6623  		/* First get WWN of HBA instance */
f358dd0ca26c15 James Smart        2017-02-12  6624  		lpfc_read_nv(phba, mboxq);
f358dd0ca26c15 James Smart        2017-02-12  6625  		rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
f358dd0ca26c15 James Smart        2017-02-12  6626  		if (rc != MBX_SUCCESS) {
f358dd0ca26c15 James Smart        2017-02-12  6627  			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
f358dd0ca26c15 James Smart        2017-02-12  6628  					"6016 Mailbox failed , mbxCmd x%x "
f358dd0ca26c15 James Smart        2017-02-12  6629  					"READ_NV, mbxStatus x%x\n",
f358dd0ca26c15 James Smart        2017-02-12  6630  					bf_get(lpfc_mqe_command, &mboxq->u.mqe),
f358dd0ca26c15 James Smart        2017-02-12  6631  					bf_get(lpfc_mqe_status, &mboxq->u.mqe));
d1f525aaa4d7e5 James Smart        2017-04-21  6632  			mempool_free(mboxq, phba->mbox_mem_pool);
f358dd0ca26c15 James Smart        2017-02-12  6633  			rc = -EIO;
f358dd0ca26c15 James Smart        2017-02-12  6634  			goto out_free_bsmbx;
f358dd0ca26c15 James Smart        2017-02-12  6635  		}
f358dd0ca26c15 James Smart        2017-02-12  6636  		mb = &mboxq->u.mb;
f358dd0ca26c15 James Smart        2017-02-12  6637  		memcpy(&wwn, (char *)mb->un.varRDnvp.nodename,
f358dd0ca26c15 James Smart        2017-02-12  6638  		       sizeof(uint64_t));
f358dd0ca26c15 James Smart        2017-02-12  6639  		wwn = cpu_to_be64(wwn);
f358dd0ca26c15 James Smart        2017-02-12  6640  		phba->sli4_hba.wwnn.u.name = wwn;
f358dd0ca26c15 James Smart        2017-02-12  6641  		memcpy(&wwn, (char *)mb->un.varRDnvp.portname,
f358dd0ca26c15 James Smart        2017-02-12  6642  		       sizeof(uint64_t));
f358dd0ca26c15 James Smart        2017-02-12  6643  		/* wwn is WWPN of HBA instance */
f358dd0ca26c15 James Smart        2017-02-12  6644  		wwn = cpu_to_be64(wwn);
f358dd0ca26c15 James Smart        2017-02-12  6645  		phba->sli4_hba.wwpn.u.name = wwn;
f358dd0ca26c15 James Smart        2017-02-12  6646
f358dd0ca26c15 James Smart        2017-02-12  6647  		/* Check to see if it matches any module parameter */
f358dd0ca26c15 James Smart        2017-02-12  6648  		for (i = 0; i < lpfc_enable_nvmet_cnt; i++) {
f358dd0ca26c15 James Smart        2017-02-12  6649  			if (wwn == lpfc_enable_nvmet[i]) {
7d7080335f8d93 James Smart        2017-03-08  6650  #if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
3c603be9798758 James Smart        2017-05-15  6651  				if (lpfc_nvmet_mem_alloc(phba))
3c603be9798758 James Smart        2017-05-15  6652  					break;
3c603be9798758 James Smart        2017-05-15  6653
3c603be9798758 James Smart        2017-05-15  6654  				phba->nvmet_support = 1; /* a match */
3c603be9798758 James Smart        2017-05-15  6655
f358dd0ca26c15 James Smart        2017-02-12  6656  				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
f358dd0ca26c15 James Smart        2017-02-12  6657  						"6017 NVME Target %016llx\n",
f358dd0ca26c15 James Smart        2017-02-12  6658  						wwn);
7d7080335f8d93 James Smart        2017-03-08  6659  #else
7d7080335f8d93 James Smart        2017-03-08  6660  				lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
7d7080335f8d93 James Smart        2017-03-08  6661  						"6021 Can't enable NVME Target."
7d7080335f8d93 James Smart        2017-03-08  6662  						" NVME_TARGET_FC infrastructure"
7d7080335f8d93 James Smart        2017-03-08  6663  						" is not in kernel\n");
7d7080335f8d93 James Smart        2017-03-08  6664  #endif
c490850a094794 James Smart        2019-01-28  6665  				/* Not supported for NVMET */
c490850a094794 James Smart        2019-01-28  6666  				phba->cfg_xri_rebalancing = 0;
3c603be9798758 James Smart        2017-05-15  6667  				break;
f358dd0ca26c15 James Smart        2017-02-12  6668  			}
f358dd0ca26c15 James Smart        2017-02-12  6669  		}
f358dd0ca26c15 James Smart        2017-02-12  6670  	}
895427bd012ce5 James Smart        2017-02-12  6671
895427bd012ce5 James Smart        2017-02-12  6672  	lpfc_nvme_mod_param_dep(phba);
895427bd012ce5 James Smart        2017-02-12  6673
fedd3b7b93302c James Smart        2011-02-16  6674  	/* Get the Supported Pages if PORT_CAPABILITIES is supported by port. */
cb5172eafd9ffd James Smart        2010-03-15  6675  	lpfc_supported_pages(mboxq);
cb5172eafd9ffd James Smart        2010-03-15  6676  	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
fedd3b7b93302c James Smart        2011-02-16  6677  	if (!rc) {
cb5172eafd9ffd James Smart        2010-03-15  6678  		mqe = &mboxq->u.mqe;
cb5172eafd9ffd James Smart        2010-03-15  6679  		memcpy(&pn_page[0], ((uint8_t *)&mqe->un.supp_pages.word3),
cb5172eafd9ffd James Smart        2010-03-15  6680  		       LPFC_MAX_SUPPORTED_PAGES);
cb5172eafd9ffd James Smart        2010-03-15  6681  		for (i = 0; i < LPFC_MAX_SUPPORTED_PAGES; i++) {
cb5172eafd9ffd James Smart        2010-03-15  6682  			switch (pn_page[i]) {
cb5172eafd9ffd James Smart        2010-03-15  6683  			case LPFC_SLI4_PARAMETERS:
cb5172eafd9ffd James Smart        2010-03-15  6684  				phba->sli4_hba.pc_sli4_params.supported = 1;
cb5172eafd9ffd James Smart        2010-03-15  6685  				break;
cb5172eafd9ffd James Smart        2010-03-15  6686  			default:
cb5172eafd9ffd James Smart        2010-03-15  6687  				break;
cb5172eafd9ffd James Smart        2010-03-15  6688  			}
cb5172eafd9ffd James Smart        2010-03-15  6689  		}
cb5172eafd9ffd James Smart        2010-03-15  6690  		/* Read the port's SLI4 Parameters capabilities if supported. */
cb5172eafd9ffd James Smart        2010-03-15  6691  		if (phba->sli4_hba.pc_sli4_params.supported)
cb5172eafd9ffd James Smart        2010-03-15  6692  			rc = lpfc_pc_sli4_params_get(phba, mboxq);
cb5172eafd9ffd James Smart        2010-03-15  6693  		if (rc) {
fedd3b7b93302c James Smart        2011-02-16  6694  			mempool_free(mboxq, phba->mbox_mem_pool);
cb5172eafd9ffd James Smart        2010-03-15  6695  			rc = -EIO;
cb5172eafd9ffd James Smart        2010-03-15  6696  			goto out_free_bsmbx;
cb5172eafd9ffd James Smart        2010-03-15  6697  		}
fedd3b7b93302c James Smart        2011-02-16  6698  	}
65791f1f90aade James Smart        2016-07-06  6699
fedd3b7b93302c James Smart        2011-02-16  6700  	/*
fedd3b7b93302c James Smart        2011-02-16  6701  	 * Get sli4 parameters that override parameters from Port capabilities.
6d368e532168cb James Smart        2011-05-24  6702  	 * If this call fails, it isn't critical unless the SLI4 parameters come
6d368e532168cb James Smart        2011-05-24  6703  	 * back in conflict.
fedd3b7b93302c James Smart        2011-02-16  6704  	 */
6d368e532168cb James Smart        2011-05-24  6705  	rc = lpfc_get_sli4_parameters(phba, mboxq);
6d368e532168cb James Smart        2011-05-24  6706  	if (rc) {
b92dc72df3c6b4 James Smart        2018-05-24  6707  		if_type = bf_get(lpfc_sli_intf_if_type,
b92dc72df3c6b4 James Smart        2018-05-24  6708  				 &phba->sli4_hba.sli_intf);
b92dc72df3c6b4 James Smart        2018-05-24  6709  		if_fam = bf_get(lpfc_sli_intf_sli_family,
b92dc72df3c6b4 James Smart        2018-05-24  6710  				&phba->sli4_hba.sli_intf);
6d368e532168cb James Smart        2011-05-24  6711  		if (phba->sli4_hba.extents_in_use &&
6d368e532168cb James Smart        2011-05-24  6712  		    phba->sli4_hba.rpi_hdrs_in_use) {
6d368e532168cb James Smart        2011-05-24  6713  			lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
6d368e532168cb James Smart        2011-05-24  6714  				"2999 Unsupported SLI4 Parameters "
6d368e532168cb James Smart        2011-05-24  6715  				"Extents and RPI headers enabled.\n");
b92dc72df3c6b4 James Smart        2018-05-24  6716  			if (if_type == LPFC_SLI_INTF_IF_TYPE_0 &&
b92dc72df3c6b4 James Smart        2018-05-24  6717  			    if_fam ==  LPFC_SLI_INTF_FAMILY_BE2) {
b92dc72df3c6b4 James Smart        2018-05-24  6718  				mempool_free(mboxq, phba->mbox_mem_pool);
b92dc72df3c6b4 James Smart        2018-05-24  6719  				rc = -EIO;
b92dc72df3c6b4 James Smart        2018-05-24  6720  				goto out_free_bsmbx;
6d368e532168cb James Smart        2011-05-24  6721  			}
b92dc72df3c6b4 James Smart        2018-05-24  6722  		}
b92dc72df3c6b4 James Smart        2018-05-24  6723  		if (!(if_type == LPFC_SLI_INTF_IF_TYPE_0 &&
b92dc72df3c6b4 James Smart        2018-05-24  6724  		      if_fam == LPFC_SLI_INTF_FAMILY_BE2)) {
895427bd012ce5 James Smart        2017-02-12  6725  			mempool_free(mboxq, phba->mbox_mem_pool);
5c756065e47dc3 Stefano Brivio     2017-09-06  6726  			rc = -EIO;
895427bd012ce5 James Smart        2017-02-12  6727  			goto out_free_bsmbx;
6d368e532168cb James Smart        2011-05-24  6728  		}
b92dc72df3c6b4 James Smart        2018-05-24  6729  	}
895427bd012ce5 James Smart        2017-02-12  6730
d79c9e9d4b3d93 James Smart        2019-08-14  6731  	/*
d79c9e9d4b3d93 James Smart        2019-08-14  6732  	 * 1 for cmd, 1 for rsp, NVME adds an extra one
d79c9e9d4b3d93 James Smart        2019-08-14  6733  	 * for boundary conditions in its max_sgl_segment template.
d79c9e9d4b3d93 James Smart        2019-08-14  6734  	 */
d79c9e9d4b3d93 James Smart        2019-08-14  6735  	extra = 2;
d79c9e9d4b3d93 James Smart        2019-08-14  6736  	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
d79c9e9d4b3d93 James Smart        2019-08-14  6737  		extra++;
d79c9e9d4b3d93 James Smart        2019-08-14  6738
d79c9e9d4b3d93 James Smart        2019-08-14  6739  	/*
d79c9e9d4b3d93 James Smart        2019-08-14  6740  	 * It doesn't matter what family our adapter is in, we are
d79c9e9d4b3d93 James Smart        2019-08-14  6741  	 * limited to 2 Pages, 512 SGEs, for our SGL.
d79c9e9d4b3d93 James Smart        2019-08-14  6742  	 * There are going to be 2 reserved SGEs: 1 FCP cmnd + 1 FCP rsp
d79c9e9d4b3d93 James Smart        2019-08-14  6743  	 */
d79c9e9d4b3d93 James Smart        2019-08-14  6744  	max_buf_size = (2 * SLI4_PAGE_SIZE);
d79c9e9d4b3d93 James Smart        2019-08-14  6745
d79c9e9d4b3d93 James Smart        2019-08-14  6746  	/*
d79c9e9d4b3d93 James Smart        2019-08-14  6747  	 * Since lpfc_sg_seg_cnt is module param, the sg_dma_buf_size
d79c9e9d4b3d93 James Smart        2019-08-14  6748  	 * used to create the sg_dma_buf_pool must be calculated.
d79c9e9d4b3d93 James Smart        2019-08-14  6749  	 */
d79c9e9d4b3d93 James Smart        2019-08-14  6750  	if (phba->sli3_options & LPFC_SLI3_BG_ENABLED) {
d79c9e9d4b3d93 James Smart        2019-08-14  6751  		/* Both cfg_enable_bg and cfg_external_dif code paths */
d79c9e9d4b3d93 James Smart        2019-08-14  6752
d79c9e9d4b3d93 James Smart        2019-08-14  6753  		/*
d79c9e9d4b3d93 James Smart        2019-08-14  6754  		 * The scsi_buf for a T10-DIF I/O holds the FCP cmnd,
d79c9e9d4b3d93 James Smart        2019-08-14  6755  		 * the FCP rsp, and a SGE. Sice we have no control
d79c9e9d4b3d93 James Smart        2019-08-14  6756  		 * over how many protection segments the SCSI Layer
d79c9e9d4b3d93 James Smart        2019-08-14  6757  		 * will hand us (ie: there could be one for every block
d79c9e9d4b3d93 James Smart        2019-08-14  6758  		 * in the IO), just allocate enough SGEs to accomidate
d79c9e9d4b3d93 James Smart        2019-08-14  6759  		 * our max amount and we need to limit lpfc_sg_seg_cnt
d79c9e9d4b3d93 James Smart        2019-08-14  6760  		 * to minimize the risk of running out.
d79c9e9d4b3d93 James Smart        2019-08-14  6761  		 */
d79c9e9d4b3d93 James Smart        2019-08-14  6762  		phba->cfg_sg_dma_buf_size = sizeof(struct fcp_cmnd) +
d79c9e9d4b3d93 James Smart        2019-08-14  6763  				sizeof(struct fcp_rsp) + max_buf_size;
d79c9e9d4b3d93 James Smart        2019-08-14  6764
d79c9e9d4b3d93 James Smart        2019-08-14  6765  		/* Total SGEs for scsi_sg_list and scsi_sg_prot_list */
d79c9e9d4b3d93 James Smart        2019-08-14  6766  		phba->cfg_total_seg_cnt = LPFC_MAX_SGL_SEG_CNT;
d79c9e9d4b3d93 James Smart        2019-08-14  6767
d79c9e9d4b3d93 James Smart        2019-08-14  6768  		/*
d79c9e9d4b3d93 James Smart        2019-08-14  6769  		 * If supporting DIF, reduce the seg count for scsi to
d79c9e9d4b3d93 James Smart        2019-08-14  6770  		 * allow room for the DIF sges.
d79c9e9d4b3d93 James Smart        2019-08-14  6771  		 */
d79c9e9d4b3d93 James Smart        2019-08-14  6772  		if (phba->cfg_enable_bg &&
d79c9e9d4b3d93 James Smart        2019-08-14  6773  		    phba->cfg_sg_seg_cnt > LPFC_MAX_BG_SLI4_SEG_CNT_DIF)
d79c9e9d4b3d93 James Smart        2019-08-14  6774  			phba->cfg_scsi_seg_cnt = LPFC_MAX_BG_SLI4_SEG_CNT_DIF;
d79c9e9d4b3d93 James Smart        2019-08-14  6775  		else
d79c9e9d4b3d93 James Smart        2019-08-14  6776  			phba->cfg_scsi_seg_cnt = phba->cfg_sg_seg_cnt;
d79c9e9d4b3d93 James Smart        2019-08-14  6777
d79c9e9d4b3d93 James Smart        2019-08-14  6778  	} else {
d79c9e9d4b3d93 James Smart        2019-08-14  6779  		/*
d79c9e9d4b3d93 James Smart        2019-08-14  6780  		 * The scsi_buf for a regular I/O holds the FCP cmnd,
d79c9e9d4b3d93 James Smart        2019-08-14  6781  		 * the FCP rsp, a SGE for each, and a SGE for up to
d79c9e9d4b3d93 James Smart        2019-08-14  6782  		 * cfg_sg_seg_cnt data segments.
d79c9e9d4b3d93 James Smart        2019-08-14  6783  		 */
d79c9e9d4b3d93 James Smart        2019-08-14  6784  		phba->cfg_sg_dma_buf_size = sizeof(struct fcp_cmnd) +
d79c9e9d4b3d93 James Smart        2019-08-14  6785  				sizeof(struct fcp_rsp) +
d79c9e9d4b3d93 James Smart        2019-08-14  6786  				((phba->cfg_sg_seg_cnt + extra) *
d79c9e9d4b3d93 James Smart        2019-08-14  6787  				sizeof(struct sli4_sge));
d79c9e9d4b3d93 James Smart        2019-08-14  6788
d79c9e9d4b3d93 James Smart        2019-08-14  6789  		/* Total SGEs for scsi_sg_list */
d79c9e9d4b3d93 James Smart        2019-08-14  6790  		phba->cfg_total_seg_cnt = phba->cfg_sg_seg_cnt + extra;
d79c9e9d4b3d93 James Smart        2019-08-14  6791  		phba->cfg_scsi_seg_cnt = phba->cfg_sg_seg_cnt;
d79c9e9d4b3d93 James Smart        2019-08-14  6792
d79c9e9d4b3d93 James Smart        2019-08-14  6793  		/*
d79c9e9d4b3d93 James Smart        2019-08-14  6794  		 * NOTE: if (phba->cfg_sg_seg_cnt + extra) <= 256 we only
d79c9e9d4b3d93 James Smart        2019-08-14  6795  		 * need to post 1 page for the SGL.
d79c9e9d4b3d93 James Smart        2019-08-14  6796  		 */
d79c9e9d4b3d93 James Smart        2019-08-14  6797  	}
d79c9e9d4b3d93 James Smart        2019-08-14  6798
d79c9e9d4b3d93 James Smart        2019-08-14  6799  	if (phba->cfg_xpsgl && !phba->nvmet_support)
d79c9e9d4b3d93 James Smart        2019-08-14  6800  		phba->cfg_sg_dma_buf_size = LPFC_DEFAULT_XPSGL_SIZE;
d79c9e9d4b3d93 James Smart        2019-08-14  6801  	else if (phba->cfg_sg_dma_buf_size  <= LPFC_MIN_SG_SLI4_BUF_SZ)
d79c9e9d4b3d93 James Smart        2019-08-14  6802  		phba->cfg_sg_dma_buf_size = LPFC_MIN_SG_SLI4_BUF_SZ;
d79c9e9d4b3d93 James Smart        2019-08-14  6803  	else
d79c9e9d4b3d93 James Smart        2019-08-14  6804  		phba->cfg_sg_dma_buf_size =
d79c9e9d4b3d93 James Smart        2019-08-14  6805  				SLI4_PAGE_ALIGN(phba->cfg_sg_dma_buf_size);
d79c9e9d4b3d93 James Smart        2019-08-14  6806
d79c9e9d4b3d93 James Smart        2019-08-14  6807  	phba->border_sge_num = phba->cfg_sg_dma_buf_size /
d79c9e9d4b3d93 James Smart        2019-08-14  6808  			       sizeof(struct sli4_sge);
d79c9e9d4b3d93 James Smart        2019-08-14  6809
d79c9e9d4b3d93 James Smart        2019-08-14  6810  	/* Limit to LPFC_MAX_NVME_SEG_CNT for NVME. */
d79c9e9d4b3d93 James Smart        2019-08-14  6811  	if (phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
d79c9e9d4b3d93 James Smart        2019-08-14  6812  		if (phba->cfg_sg_seg_cnt > LPFC_MAX_NVME_SEG_CNT) {
d79c9e9d4b3d93 James Smart        2019-08-14  6813  			lpfc_printf_log(phba, KERN_INFO, LOG_NVME | LOG_INIT,
d79c9e9d4b3d93 James Smart        2019-08-14  6814  					"6300 Reducing NVME sg segment "
d79c9e9d4b3d93 James Smart        2019-08-14  6815  					"cnt to %d\n",
d79c9e9d4b3d93 James Smart        2019-08-14  6816  					LPFC_MAX_NVME_SEG_CNT);
d79c9e9d4b3d93 James Smart        2019-08-14  6817  			phba->cfg_nvme_seg_cnt = LPFC_MAX_NVME_SEG_CNT;
d79c9e9d4b3d93 James Smart        2019-08-14  6818  		} else
d79c9e9d4b3d93 James Smart        2019-08-14  6819  			phba->cfg_nvme_seg_cnt = phba->cfg_sg_seg_cnt;
d79c9e9d4b3d93 James Smart        2019-08-14  6820  	}
d79c9e9d4b3d93 James Smart        2019-08-14  6821
d79c9e9d4b3d93 James Smart        2019-08-14  6822  	/* Initialize the host templates with the updated values. */
d79c9e9d4b3d93 James Smart        2019-08-14  6823  	lpfc_vport_template.sg_tablesize = phba->cfg_scsi_seg_cnt;
d79c9e9d4b3d93 James Smart        2019-08-14  6824  	lpfc_template.sg_tablesize = phba->cfg_scsi_seg_cnt;
d79c9e9d4b3d93 James Smart        2019-08-14  6825  	lpfc_template_no_hr.sg_tablesize = phba->cfg_scsi_seg_cnt;
d79c9e9d4b3d93 James Smart        2019-08-14  6826
d79c9e9d4b3d93 James Smart        2019-08-14  6827  	lpfc_printf_log(phba, KERN_INFO, LOG_INIT | LOG_FCP,
d79c9e9d4b3d93 James Smart        2019-08-14  6828  			"9087 sg_seg_cnt:%d dmabuf_size:%d "
d79c9e9d4b3d93 James Smart        2019-08-14  6829  			"total:%d scsi:%d nvme:%d\n",
d79c9e9d4b3d93 James Smart        2019-08-14  6830  			phba->cfg_sg_seg_cnt, phba->cfg_sg_dma_buf_size,
d79c9e9d4b3d93 James Smart        2019-08-14  6831  			phba->cfg_total_seg_cnt,  phba->cfg_scsi_seg_cnt,
d79c9e9d4b3d93 James Smart        2019-08-14  6832  			phba->cfg_nvme_seg_cnt);
d79c9e9d4b3d93 James Smart        2019-08-14  6833
d79c9e9d4b3d93 James Smart        2019-08-14 @6834  	if (phba->cfg_sg_dma_buf_size < SLI4_PAGE_SIZE)
d79c9e9d4b3d93 James Smart        2019-08-14  6835  		i = phba->cfg_sg_dma_buf_size;
d79c9e9d4b3d93 James Smart        2019-08-14  6836  	else
d79c9e9d4b3d93 James Smart        2019-08-14  6837  		i = SLI4_PAGE_SIZE;
d79c9e9d4b3d93 James Smart        2019-08-14  6838
d79c9e9d4b3d93 James Smart        2019-08-14  6839  	phba->lpfc_sg_dma_buf_pool =
d79c9e9d4b3d93 James Smart        2019-08-14  6840  			dma_pool_create("lpfc_sg_dma_buf_pool",
d79c9e9d4b3d93 James Smart        2019-08-14  6841  					&phba->pcidev->dev,
d79c9e9d4b3d93 James Smart        2019-08-14  6842  					phba->cfg_sg_dma_buf_size,
d79c9e9d4b3d93 James Smart        2019-08-14  6843  					i, 0);
d79c9e9d4b3d93 James Smart        2019-08-14  6844  	if (!phba->lpfc_sg_dma_buf_pool)
d79c9e9d4b3d93 James Smart        2019-08-14  6845  		goto out_free_bsmbx;
d79c9e9d4b3d93 James Smart        2019-08-14  6846
d79c9e9d4b3d93 James Smart        2019-08-14  6847  	phba->lpfc_cmd_rsp_buf_pool =
d79c9e9d4b3d93 James Smart        2019-08-14  6848  			dma_pool_create("lpfc_cmd_rsp_buf_pool",
d79c9e9d4b3d93 James Smart        2019-08-14  6849  					&phba->pcidev->dev,
d79c9e9d4b3d93 James Smart        2019-08-14  6850  					sizeof(struct fcp_cmnd) +
d79c9e9d4b3d93 James Smart        2019-08-14  6851  					sizeof(struct fcp_rsp),
d79c9e9d4b3d93 James Smart        2019-08-14  6852  					i, 0);
d79c9e9d4b3d93 James Smart        2019-08-14  6853  	if (!phba->lpfc_cmd_rsp_buf_pool)
d79c9e9d4b3d93 James Smart        2019-08-14  6854  		goto out_free_sg_dma_buf;
d79c9e9d4b3d93 James Smart        2019-08-14  6855
fedd3b7b93302c James Smart        2011-02-16  6856  	mempool_free(mboxq, phba->mbox_mem_pool);
1ba981fd3ad1f9 James Smart        2014-02-20  6857
1ba981fd3ad1f9 James Smart        2014-02-20  6858  	/* Verify OAS is supported */
1ba981fd3ad1f9 James Smart        2014-02-20  6859  	lpfc_sli4_oas_verify(phba);
1ba981fd3ad1f9 James Smart        2014-02-20  6860
d2cc9bcd7fa30b James Smart        2018-09-10  6861  	/* Verify RAS support on adapter */
d2cc9bcd7fa30b James Smart        2018-09-10  6862  	lpfc_sli4_ras_init(phba);
d2cc9bcd7fa30b James Smart        2018-09-10  6863
5350d872c19a59 James Smart        2011-10-10  6864  	/* Verify all the SLI4 queues */
5350d872c19a59 James Smart        2011-10-10  6865  	rc = lpfc_sli4_queue_verify(phba);
da0436e915a5c1 James Smart        2009-05-22  6866  	if (rc)
d79c9e9d4b3d93 James Smart        2019-08-14  6867  		goto out_free_cmd_rsp_buf;
da0436e915a5c1 James Smart        2009-05-22  6868
da0436e915a5c1 James Smart        2009-05-22  6869  	/* Create driver internal CQE event pool */
da0436e915a5c1 James Smart        2009-05-22  6870  	rc = lpfc_sli4_cq_event_pool_create(phba);
da0436e915a5c1 James Smart        2009-05-22  6871  	if (rc)
d79c9e9d4b3d93 James Smart        2019-08-14  6872  		goto out_free_cmd_rsp_buf;
da0436e915a5c1 James Smart        2009-05-22  6873
8a9d2e8003040d James Smart        2012-05-09  6874  	/* Initialize sgl lists per host */
8a9d2e8003040d James Smart        2012-05-09  6875  	lpfc_init_sgl_list(phba);
8a9d2e8003040d James Smart        2012-05-09  6876
8a9d2e8003040d James Smart        2012-05-09  6877  	/* Allocate and initialize active sgl array */
da0436e915a5c1 James Smart        2009-05-22  6878  	rc = lpfc_init_active_sgl_array(phba);
da0436e915a5c1 James Smart        2009-05-22  6879  	if (rc) {
da0436e915a5c1 James Smart        2009-05-22  6880  		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
da0436e915a5c1 James Smart        2009-05-22  6881  				"1430 Failed to initialize sgl list.\n");
8a9d2e8003040d James Smart        2012-05-09  6882  		goto out_destroy_cq_event_pool;
da0436e915a5c1 James Smart        2009-05-22  6883  	}
da0436e915a5c1 James Smart        2009-05-22  6884  	rc = lpfc_sli4_init_rpi_hdrs(phba);
da0436e915a5c1 James Smart        2009-05-22  6885  	if (rc) {
da0436e915a5c1 James Smart        2009-05-22  6886  		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
da0436e915a5c1 James Smart        2009-05-22  6887  				"1432 Failed to initialize rpi headers.\n");
da0436e915a5c1 James Smart        2009-05-22  6888  		goto out_free_active_sgl;
da0436e915a5c1 James Smart        2009-05-22  6889  	}
da0436e915a5c1 James Smart        2009-05-22  6890
0c9ab6f5cb2819 James Smart        2010-02-26  6891  	/* Allocate eligible FCF bmask memory for FCF roundrobin failover */
0c9ab6f5cb2819 James Smart        2010-02-26  6892  	longs = (LPFC_SLI4_FCF_TBL_INDX_MAX + BITS_PER_LONG - 1)/BITS_PER_LONG;
6396bb221514d2 Kees Cook          2018-06-12  6893  	phba->fcf.fcf_rr_bmask = kcalloc(longs, sizeof(unsigned long),
0c9ab6f5cb2819 James Smart        2010-02-26  6894  					 GFP_KERNEL);
0c9ab6f5cb2819 James Smart        2010-02-26  6895  	if (!phba->fcf.fcf_rr_bmask) {
0c9ab6f5cb2819 James Smart        2010-02-26  6896  		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
0c9ab6f5cb2819 James Smart        2010-02-26  6897  				"2759 Failed allocate memory for FCF round "
0c9ab6f5cb2819 James Smart        2010-02-26  6898  				"robin failover bmask\n");
0558056c1ecd17 James Smart        2011-05-24  6899  		rc = -ENOMEM;
0c9ab6f5cb2819 James Smart        2010-02-26  6900  		goto out_remove_rpi_hdrs;
0c9ab6f5cb2819 James Smart        2010-02-26  6901  	}
0c9ab6f5cb2819 James Smart        2010-02-26  6902
6a828b0f6192b4 James Smart        2019-01-28  6903  	phba->sli4_hba.hba_eq_hdl = kcalloc(phba->cfg_irq_chann,
895427bd012ce5 James Smart        2017-02-12  6904  					    sizeof(struct lpfc_hba_eq_hdl),
1ba981fd3ad1f9 James Smart        2014-02-20  6905  					    GFP_KERNEL);
895427bd012ce5 James Smart        2017-02-12  6906  	if (!phba->sli4_hba.hba_eq_hdl) {
da0436e915a5c1 James Smart        2009-05-22  6907  		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
5350d872c19a59 James Smart        2011-10-10  6908  				"2572 Failed allocate memory for "
5350d872c19a59 James Smart        2011-10-10  6909  				"fast-path per-EQ handle array\n");
0558056c1ecd17 James Smart        2011-05-24  6910  		rc = -ENOMEM;
0c9ab6f5cb2819 James Smart        2010-02-26  6911  		goto out_free_fcf_rr_bmask;
da0436e915a5c1 James Smart        2009-05-22  6912  	}
da0436e915a5c1 James Smart        2009-05-22  6913
222e9239c60888 James Smart        2019-01-28  6914  	phba->sli4_hba.cpu_map = kcalloc(phba->sli4_hba.num_possible_cpu,
895427bd012ce5 James Smart        2017-02-12  6915  					sizeof(struct lpfc_vector_map_info),
7bb03bbf1e8c0c James Smart        2013-04-17  6916  					GFP_KERNEL);
7bb03bbf1e8c0c James Smart        2013-04-17  6917  	if (!phba->sli4_hba.cpu_map) {
7bb03bbf1e8c0c James Smart        2013-04-17  6918  		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
7bb03bbf1e8c0c James Smart        2013-04-17  6919  				"3327 Failed allocate memory for msi-x "
7bb03bbf1e8c0c James Smart        2013-04-17  6920  				"interrupt vector mapping\n");
7bb03bbf1e8c0c James Smart        2013-04-17  6921  		rc = -ENOMEM;
895427bd012ce5 James Smart        2017-02-12  6922  		goto out_free_hba_eq_hdl;
7bb03bbf1e8c0c James Smart        2013-04-17  6923  	}
b246de174300db James Smart        2013-05-31  6924
32517fc0975bf8 James Smart        2019-01-28  6925  	phba->sli4_hba.eq_info = alloc_percpu(struct lpfc_eq_intr_info);
32517fc0975bf8 James Smart        2019-01-28  6926  	if (!phba->sli4_hba.eq_info) {
b246de174300db James Smart        2013-05-31  6927  		lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
32517fc0975bf8 James Smart        2019-01-28  6928  				"3321 Failed allocation for per_cpu stats\n");
b246de174300db James Smart        2013-05-31  6929  		rc = -ENOMEM;
32517fc0975bf8 James Smart        2019-01-28  6930  		goto out_free_hba_cpu_map;
b246de174300db James Smart        2013-05-31  6931  	}
912e3acde60b3b James Smart        2011-05-24  6932  	/*
912e3acde60b3b James Smart        2011-05-24  6933  	 * Enable sr-iov virtual functions if supported and configured
912e3acde60b3b James Smart        2011-05-24  6934  	 * through the module parameter.
912e3acde60b3b James Smart        2011-05-24  6935  	 */
912e3acde60b3b James Smart        2011-05-24  6936  	if (phba->cfg_sriov_nr_virtfn > 0) {
912e3acde60b3b James Smart        2011-05-24  6937  		rc = lpfc_sli_probe_sriov_nr_virtfn(phba,
912e3acde60b3b James Smart        2011-05-24  6938  						 phba->cfg_sriov_nr_virtfn);
912e3acde60b3b James Smart        2011-05-24  6939  		if (rc) {
912e3acde60b3b James Smart        2011-05-24  6940  			lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
912e3acde60b3b James Smart        2011-05-24  6941  					"3020 Requested number of SR-IOV "
912e3acde60b3b James Smart        2011-05-24  6942  					"virtual functions (%d) is not "
912e3acde60b3b James Smart        2011-05-24  6943  					"supported\n",
912e3acde60b3b James Smart        2011-05-24  6944  					phba->cfg_sriov_nr_virtfn);
912e3acde60b3b James Smart        2011-05-24  6945  			phba->cfg_sriov_nr_virtfn = 0;
912e3acde60b3b James Smart        2011-05-24  6946  		}
912e3acde60b3b James Smart        2011-05-24  6947  	}
912e3acde60b3b James Smart        2011-05-24  6948
5248a7498e5f6f James Smart        2011-07-22  6949  	return 0;
da0436e915a5c1 James Smart        2009-05-22  6950
32517fc0975bf8 James Smart        2019-01-28  6951  out_free_hba_cpu_map:
32517fc0975bf8 James Smart        2019-01-28  6952  	kfree(phba->sli4_hba.cpu_map);
895427bd012ce5 James Smart        2017-02-12  6953  out_free_hba_eq_hdl:
895427bd012ce5 James Smart        2017-02-12  6954  	kfree(phba->sli4_hba.hba_eq_hdl);
0c9ab6f5cb2819 James Smart        2010-02-26  6955  out_free_fcf_rr_bmask:
0c9ab6f5cb2819 James Smart        2010-02-26  6956  	kfree(phba->fcf.fcf_rr_bmask);
da0436e915a5c1 James Smart        2009-05-22  6957  out_remove_rpi_hdrs:
da0436e915a5c1 James Smart        2009-05-22  6958  	lpfc_sli4_remove_rpi_hdrs(phba);
da0436e915a5c1 James Smart        2009-05-22  6959  out_free_active_sgl:
da0436e915a5c1 James Smart        2009-05-22  6960  	lpfc_free_active_sgl(phba);
da0436e915a5c1 James Smart        2009-05-22  6961  out_destroy_cq_event_pool:
da0436e915a5c1 James Smart        2009-05-22  6962  	lpfc_sli4_cq_event_pool_destroy(phba);
d79c9e9d4b3d93 James Smart        2019-08-14  6963  out_free_cmd_rsp_buf:
d79c9e9d4b3d93 James Smart        2019-08-14  6964  	dma_pool_destroy(phba->lpfc_cmd_rsp_buf_pool);
d79c9e9d4b3d93 James Smart        2019-08-14  6965  	phba->lpfc_cmd_rsp_buf_pool = NULL;
d79c9e9d4b3d93 James Smart        2019-08-14  6966  out_free_sg_dma_buf:
d79c9e9d4b3d93 James Smart        2019-08-14  6967  	dma_pool_destroy(phba->lpfc_sg_dma_buf_pool);
d79c9e9d4b3d93 James Smart        2019-08-14  6968  	phba->lpfc_sg_dma_buf_pool = NULL;
da0436e915a5c1 James Smart        2009-05-22  6969  out_free_bsmbx:
da0436e915a5c1 James Smart        2009-05-22  6970  	lpfc_destroy_bootstrap_mbox(phba);
da0436e915a5c1 James Smart        2009-05-22  6971  out_free_mem:
da0436e915a5c1 James Smart        2009-05-22  6972  	lpfc_mem_free(phba);
da0436e915a5c1 James Smart        2009-05-22  6973  	return rc;
da0436e915a5c1 James Smart        2009-05-22  6974  }
da0436e915a5c1 James Smart        2009-05-22  6975

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
--8323329-1823911411-1727413019=:3334--

