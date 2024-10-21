Return-Path: <linux-kernel+bounces-373826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855AA9A5D54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418FF281FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BDB1E0DDA;
	Mon, 21 Oct 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Spsph74D"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958C1946DA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496567; cv=none; b=sbGjvAgyFBc7fET+AeR5TW4ssTu+fDxAVHBjtG3a6GMUSVEw78JZobi3L6ccL/+ageIItxFQcp3Dqw8x639mkwjxhE8AdLSHGoCV2c5SLH7+3kBqo+KDyaoKlDO+BcRCcNq+0XlBw2sZWkZqUepfrE1KTcgRQeFybKIE8NNOfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496567; c=relaxed/simple;
	bh=ZXLwB8q0dFSD1Q49mCyn/4UrVX5fDr5U7NeyL+JipHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IbnzgO6dpbdy13CDHkSEToqsr/UjDT4HwJPFxCxOI5FXG2MFnUQTEyt0ZwY+QoArW5An8dkJAg8bTHDZxcXDItEorPz+2nsjI6u8izJgj9gsh7Ms0O9e7H79bpPCOEEht1vpWUZaksuXYgO51FjkTXabkwWxXKih5uYsNEBzRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Spsph74D; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so1717122f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729496563; x=1730101363; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+lQWPjKZ9d7tkuc53uWo09ku707dlVXTx1v4ShPgTl0=;
        b=Spsph74DnodnGpFVpHDdHcrMRfuXOPvh8/Ns2bpm+7fT7WKEguEdelUUbhm4BZuz1u
         IFFtTJoqjr6AZjTkDiHXRWqBYn3sx+Ifh/ROXBq1qz/Zcor1LDqJK6uHw7Tx20lytxzB
         68mSwogupaAsfRdMJuOaJiJHrI2riE3hGKz4bZTabLcczTuFzbwTfWo+4sqmmMi7bwdi
         3F0qP7o8SVHf186qHOCRFZZhxPqmJvSiK5Yo3a8Iw+cLkASUk0GBdRSXxNhgfq/sKuEj
         VkwStk+GM8gOFlvcXixKFch2PCpIIt0H3Fq4aswC1k0zgJy2gf7NkGIyu00T4z0BUfuM
         9dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729496563; x=1730101363;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lQWPjKZ9d7tkuc53uWo09ku707dlVXTx1v4ShPgTl0=;
        b=AruGaoMV2UYcQUsqhQBlLgo7MGbRPyiYAUzWsVsYTXPPGB4notGmebl9ikASwLDGgn
         5AB+tfsHiQFUPN5Fq0FA8FYq6F2hZIpddVBvc7PhbslY2hvgPZsgRzEw6+LyALy436mb
         EQZy5DuzyTGax6+ABcts7J9lhGtNGdm2ix+Oz5W0isztY3F0fHbdHdjkvQDpI0XipT0R
         WQrPj0pBgLmNDaoj9StQ2zACLGNo6OtX8OFrdGqqWQ0LYq6H0mHe8VVAxmi2gCXEmbBP
         RBETfGpAePVlZr0YmpsImdomXedgpLEjMO2vP0SA8e92N+Riw+cvKc62iAO7x190W5pr
         NA/A==
X-Forwarded-Encrypted: i=1; AJvYcCWLbP3xIO/FeEMRz/PrToDReSh+2cL3aKfEsqapTpdfFuNSizwITWpf5MlE3LNiI7vfakh9geYxDTlBOwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lSjZvuT8X+AdkWs7tOzfkZB/AqszlRQQ7EMDn8lGDAU3yFgI
	nmKX5aHNZRTyd6KZF3kayU8yY9E1RP36iI4fmJs1NcqJy34WT0ZYWBD0mEBhQNg=
X-Google-Smtp-Source: AGHT+IEdvzDzqDRY+HZx+VWgSMIXcrnHqSAnQwai7eUHWJTW7BDl8Goz0UnI5B80meN5RV1ZTFytFg==
X-Received: by 2002:a5d:4952:0:b0:374:fa0a:773c with SMTP id ffacd0b85a97d-37eab4ed869mr6054206f8f.47.1729496563309;
        Mon, 21 Oct 2024 00:42:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0ba74dbsm3579918f8f.112.2024.10.21.00.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:42:42 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:42:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: drivers/infiniband/hw/bnxt_re/qplib_fp.c:1090 bnxt_qplib_create_qp()
 error: we previously assumed 'res->dattr' could be null (see line 985)
Message-ID: <c2ff81f3-5de6-4498-b157-909d89e74fcb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   715ca9dd687f89ddaac8ec8ccb3b5e5a30311a99
commit: 07f830ae4913d0b986c8c0ff88a7d597948b9bd8 RDMA/bnxt_re: Adds MSN table capability for Gen P7 adapters
config: x86_64-randconfig-161-20241020 (https://download.01.org/0day-ci/archive/20241020/202410202140.TMNDJ4l1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410202140.TMNDJ4l1-lkp@intel.com/

New smatch warnings:
drivers/infiniband/hw/bnxt_re/qplib_fp.c:1090 bnxt_qplib_create_qp() error: we previously assumed 'res->dattr' could be null (see line 985)

vim +1090 drivers/infiniband/hw/bnxt_re/qplib_fp.c

1ac5a404797523 Selvin Xavier      2017-02-10   967  int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
1ac5a404797523 Selvin Xavier      2017-02-10   968  {
1ac5a404797523 Selvin Xavier      2017-02-10   969  	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
0c4dcd60281750 Devesh Sharma      2020-02-15   970  	struct bnxt_qplib_hwq_attr hwq_attr = {};
0c4dcd60281750 Devesh Sharma      2020-02-15   971  	struct bnxt_qplib_sg_info sginfo = {};
ff015bcd213b5d Selvin Xavier      2023-03-30   972  	struct creq_create_qp_resp resp = {};
ff015bcd213b5d Selvin Xavier      2023-03-30   973  	struct bnxt_qplib_cmdqmsg msg = {};
1ac5a404797523 Selvin Xavier      2017-02-10   974  	struct bnxt_qplib_q *sq = &qp->sq;
1ac5a404797523 Selvin Xavier      2017-02-10   975  	struct bnxt_qplib_q *rq = &qp->rq;
ff015bcd213b5d Selvin Xavier      2023-03-30   976  	struct cmdq_create_qp req = {};
fddcbbb02af42a Devesh Sharma      2020-04-02   977  	int rc, req_size, psn_sz = 0;
1ac5a404797523 Selvin Xavier      2017-02-10   978  	struct bnxt_qplib_hwq *xrrq;
c50866e2853a03 Devesh Sharma      2019-02-22   979  	struct bnxt_qplib_pbl *pbl;
c50866e2853a03 Devesh Sharma      2019-02-22   980  	u32 qp_flags = 0;
99bf84e24eb83d Devesh Sharma      2020-04-02   981  	u8 pg_sz_lvl;
84cf229f4001c1 Selvin Xavier      2020-08-24   982  	u32 tbl_indx;
159fb4ceacd79b Devesh Sharma      2020-07-15   983  	u16 nsge;
1ac5a404797523 Selvin Xavier      2017-02-10   984  
07f830ae4913d0 Selvin Xavier      2023-12-07  @985  	if (res->dattr)
                                                            ^^^^^^^^^^
Can res->dattr be NULL?

07f830ae4913d0 Selvin Xavier      2023-12-07   986  		qp->dev_cap_flags = res->dattr->dev_cap_flags;
07f830ae4913d0 Selvin Xavier      2023-12-07   987  
3a4304d8269501 Chandramohan Akula 2023-10-23   988  	sq->dbinfo.flags = 0;
e576adf583b525 Selvin Xavier      2023-03-30   989  	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
e576adf583b525 Selvin Xavier      2023-03-30   990  				 CMDQ_BASE_OPCODE_CREATE_QP,
e576adf583b525 Selvin Xavier      2023-03-30   991  				 sizeof(req));
1ac5a404797523 Selvin Xavier      2017-02-10   992  
1ac5a404797523 Selvin Xavier      2017-02-10   993  	/* General */
1ac5a404797523 Selvin Xavier      2017-02-10   994  	req.type = qp->type;
1ac5a404797523 Selvin Xavier      2017-02-10   995  	req.dpi = cpu_to_le32(qp->dpi->dpi);
1ac5a404797523 Selvin Xavier      2017-02-10   996  	req.qp_handle = cpu_to_le64(qp->qp_handle);
1ac5a404797523 Selvin Xavier      2017-02-10   997  
1ac5a404797523 Selvin Xavier      2017-02-10   998  	/* SQ */
37f91cff2de017 Devesh Sharma      2019-02-07   999  	if (qp->type == CMDQ_CREATE_QP_TYPE_RC) {
1801d87b3598b1 Selvin Xavier      2023-12-07  1000  		psn_sz = bnxt_qplib_is_chip_gen_p5_p7(res->cctx) ?
37f91cff2de017 Devesh Sharma      2019-02-07  1001  			 sizeof(struct sq_psn_search_ext) :
37f91cff2de017 Devesh Sharma      2019-02-07  1002  			 sizeof(struct sq_psn_search);
07f830ae4913d0 Selvin Xavier      2023-12-07  1003  
07f830ae4913d0 Selvin Xavier      2023-12-07  1004  		if (BNXT_RE_HW_RETX(qp->dev_cap_flags)) {
07f830ae4913d0 Selvin Xavier      2023-12-07  1005  			psn_sz = sizeof(struct sq_msn_search);
07f830ae4913d0 Selvin Xavier      2023-12-07  1006  			qp->msn = 0;
07f830ae4913d0 Selvin Xavier      2023-12-07  1007  		}
37f91cff2de017 Devesh Sharma      2019-02-07  1008  	}
0c4dcd60281750 Devesh Sharma      2020-02-15  1009  
0c4dcd60281750 Devesh Sharma      2020-02-15  1010  	hwq_attr.res = res;
0c4dcd60281750 Devesh Sharma      2020-02-15  1011  	hwq_attr.sginfo = &sq->sg_info;
2bb3c32c5c5fe9 Devesh Sharma      2020-07-15  1012  	hwq_attr.stride = sizeof(struct sq_sge);
2bb3c32c5c5fe9 Devesh Sharma      2020-07-15  1013  	hwq_attr.depth = bnxt_qplib_get_depth(sq);
0c4dcd60281750 Devesh Sharma      2020-02-15  1014  	hwq_attr.aux_stride = psn_sz;
2bb3c32c5c5fe9 Devesh Sharma      2020-07-15  1015  	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
07f830ae4913d0 Selvin Xavier      2023-12-07  1016  	/* Update msn tbl size */
07f830ae4913d0 Selvin Xavier      2023-12-07  1017  	if (BNXT_RE_HW_RETX(qp->dev_cap_flags) && psn_sz) {
07f830ae4913d0 Selvin Xavier      2023-12-07  1018  		hwq_attr.aux_depth = roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
07f830ae4913d0 Selvin Xavier      2023-12-07  1019  		qp->msn_tbl_sz = hwq_attr.aux_depth;
07f830ae4913d0 Selvin Xavier      2023-12-07  1020  		qp->msn = 0;
07f830ae4913d0 Selvin Xavier      2023-12-07  1021  	}
07f830ae4913d0 Selvin Xavier      2023-12-07  1022  
0c4dcd60281750 Devesh Sharma      2020-02-15  1023  	hwq_attr.type = HWQ_TYPE_QUEUE;
0c4dcd60281750 Devesh Sharma      2020-02-15  1024  	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
1ac5a404797523 Selvin Xavier      2017-02-10  1025  	if (rc)
07d5ce14b2aa22 Kalesh AP          2023-05-18  1026  		return rc;
1ac5a404797523 Selvin Xavier      2017-02-10  1027  
159fb4ceacd79b Devesh Sharma      2020-07-15  1028  	rc = bnxt_qplib_alloc_init_swq(sq);
159fb4ceacd79b Devesh Sharma      2020-07-15  1029  	if (rc)
1ac5a404797523 Selvin Xavier      2017-02-10  1030  		goto fail_sq;
fddcbbb02af42a Devesh Sharma      2020-04-02  1031  
fddcbbb02af42a Devesh Sharma      2020-04-02  1032  	if (psn_sz)
fddcbbb02af42a Devesh Sharma      2020-04-02  1033  		bnxt_qplib_init_psn_ptr(qp, psn_sz);
fddcbbb02af42a Devesh Sharma      2020-04-02  1034  
2bb3c32c5c5fe9 Devesh Sharma      2020-07-15  1035  	req.sq_size = cpu_to_le32(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
1ac5a404797523 Selvin Xavier      2017-02-10  1036  	pbl = &sq->hwq.pbl[PBL_LVL_0];
1ac5a404797523 Selvin Xavier      2017-02-10  1037  	req.sq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
99bf84e24eb83d Devesh Sharma      2020-04-02  1038  	pg_sz_lvl = (bnxt_qplib_base_pg_size(&sq->hwq) <<
99bf84e24eb83d Devesh Sharma      2020-04-02  1039  		     CMDQ_CREATE_QP_SQ_PG_SIZE_SFT);
99bf84e24eb83d Devesh Sharma      2020-04-02  1040  	pg_sz_lvl |= (sq->hwq.level & CMDQ_CREATE_QP_SQ_LVL_MASK);
99bf84e24eb83d Devesh Sharma      2020-04-02  1041  	req.sq_pg_size_sq_lvl = pg_sz_lvl;
159fb4ceacd79b Devesh Sharma      2020-07-15  1042  	req.sq_fwo_sq_sge =
159fb4ceacd79b Devesh Sharma      2020-07-15  1043  		cpu_to_le16(((sq->max_sge & CMDQ_CREATE_QP_SQ_SGE_MASK) <<
159fb4ceacd79b Devesh Sharma      2020-07-15  1044  			     CMDQ_CREATE_QP_SQ_SGE_SFT) | 0);
1ac5a404797523 Selvin Xavier      2017-02-10  1045  	req.scq_cid = cpu_to_le32(qp->scq->id);
1ac5a404797523 Selvin Xavier      2017-02-10  1046  
1ac5a404797523 Selvin Xavier      2017-02-10  1047  	/* RQ */
159fb4ceacd79b Devesh Sharma      2020-07-15  1048  	if (!qp->srq) {
3a4304d8269501 Chandramohan Akula 2023-10-23  1049  		rq->dbinfo.flags = 0;
0c4dcd60281750 Devesh Sharma      2020-02-15  1050  		hwq_attr.res = res;
0c4dcd60281750 Devesh Sharma      2020-02-15  1051  		hwq_attr.sginfo = &rq->sg_info;
2bb3c32c5c5fe9 Devesh Sharma      2020-07-15  1052  		hwq_attr.stride = sizeof(struct sq_sge);
2bb3c32c5c5fe9 Devesh Sharma      2020-07-15  1053  		hwq_attr.depth = bnxt_qplib_get_depth(rq);
0c4dcd60281750 Devesh Sharma      2020-02-15  1054  		hwq_attr.aux_stride = 0;
0c4dcd60281750 Devesh Sharma      2020-02-15  1055  		hwq_attr.aux_depth = 0;
0c4dcd60281750 Devesh Sharma      2020-02-15  1056  		hwq_attr.type = HWQ_TYPE_QUEUE;
0c4dcd60281750 Devesh Sharma      2020-02-15  1057  		rc = bnxt_qplib_alloc_init_hwq(&rq->hwq, &hwq_attr);
1ac5a404797523 Selvin Xavier      2017-02-10  1058  		if (rc)
159fb4ceacd79b Devesh Sharma      2020-07-15  1059  			goto sq_swq;
159fb4ceacd79b Devesh Sharma      2020-07-15  1060  		rc = bnxt_qplib_alloc_init_swq(rq);
159fb4ceacd79b Devesh Sharma      2020-07-15  1061  		if (rc)
1ac5a404797523 Selvin Xavier      2017-02-10  1062  			goto fail_rq;
159fb4ceacd79b Devesh Sharma      2020-07-15  1063  
159fb4ceacd79b Devesh Sharma      2020-07-15  1064  		req.rq_size = cpu_to_le32(rq->max_wqe);
1ac5a404797523 Selvin Xavier      2017-02-10  1065  		pbl = &rq->hwq.pbl[PBL_LVL_0];
1ac5a404797523 Selvin Xavier      2017-02-10  1066  		req.rq_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
99bf84e24eb83d Devesh Sharma      2020-04-02  1067  		pg_sz_lvl = (bnxt_qplib_base_pg_size(&rq->hwq) <<
99bf84e24eb83d Devesh Sharma      2020-04-02  1068  			     CMDQ_CREATE_QP_RQ_PG_SIZE_SFT);
99bf84e24eb83d Devesh Sharma      2020-04-02  1069  		pg_sz_lvl |= (rq->hwq.level & CMDQ_CREATE_QP_RQ_LVL_MASK);
99bf84e24eb83d Devesh Sharma      2020-04-02  1070  		req.rq_pg_size_rq_lvl = pg_sz_lvl;
159fb4ceacd79b Devesh Sharma      2020-07-15  1071  		nsge = (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC) ?
159fb4ceacd79b Devesh Sharma      2020-07-15  1072  			6 : rq->max_sge;
159fb4ceacd79b Devesh Sharma      2020-07-15  1073  		req.rq_fwo_rq_sge =
159fb4ceacd79b Devesh Sharma      2020-07-15  1074  			cpu_to_le16(((nsge &
159fb4ceacd79b Devesh Sharma      2020-07-15  1075  				      CMDQ_CREATE_QP_RQ_SGE_MASK) <<
159fb4ceacd79b Devesh Sharma      2020-07-15  1076  				     CMDQ_CREATE_QP_RQ_SGE_SFT) | 0);
37cb11acf1f72a Devesh Sharma      2018-01-11  1077  	} else {
37cb11acf1f72a Devesh Sharma      2018-01-11  1078  		/* SRQ */
37cb11acf1f72a Devesh Sharma      2018-01-11  1079  		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_SRQ_USED;
37cb11acf1f72a Devesh Sharma      2018-01-11  1080  		req.srq_cid = cpu_to_le32(qp->srq->id);
37cb11acf1f72a Devesh Sharma      2018-01-11  1081  	}
1ac5a404797523 Selvin Xavier      2017-02-10  1082  	req.rcq_cid = cpu_to_le32(qp->rcq->id);
99bf84e24eb83d Devesh Sharma      2020-04-02  1083  
99bf84e24eb83d Devesh Sharma      2020-04-02  1084  	qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_RESERVED_LKEY_ENABLE;
99bf84e24eb83d Devesh Sharma      2020-04-02  1085  	qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FR_PMR_ENABLED;
99bf84e24eb83d Devesh Sharma      2020-04-02  1086  	if (qp->sig_type)
99bf84e24eb83d Devesh Sharma      2020-04-02  1087  		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_FORCE_COMPLETION;
2bb3c32c5c5fe9 Devesh Sharma      2020-07-15  1088  	if (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE)
2bb3c32c5c5fe9 Devesh Sharma      2020-07-15  1089  		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_VARIABLE_SIZED_WQE_ENABLED;
9a381f7e5aa299 Selvin Xavier      2021-09-15 @1090  	if (_is_ext_stats_supported(res->dattr->dev_cap_flags) && !res->is_vf)
                                                                                    ^^^^^^^^^^^^
Unchecked dereference

9a381f7e5aa299 Selvin Xavier      2021-09-15  1091  		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_EXT_STATS_ENABLED;
9a381f7e5aa299 Selvin Xavier      2021-09-15  1092  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


