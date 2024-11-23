Return-Path: <linux-kernel+bounces-419014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB79D688C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A166FB211E1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197AE185952;
	Sat, 23 Nov 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYyUpPL3"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EBA4204B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732356873; cv=none; b=GBiWhiW1LpRkMwoqdPYVZg9C49Y0ipp0hcJ7axTzA4hTqFAqHQJNFtXcHHU7i0GWhn5dyAeND22E2tJfL7O2/Mgn4KJLFZBYIkKO9jzpH4mcLfou6MSnxE5gS2ejEeZ8Qj1h4UZIXcHKkUCluCJlJd1zD7diuK8D634QrHqgTuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732356873; c=relaxed/simple;
	bh=CoKqyizm+b6eCv4dVMw5zl+cXuNBPCmJ8xv4BykcDvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cheaVK6CAxIOZqZ8O6Zq5I1DVBHCH+qGxVZ5Q41hVNtn3y95wSoPLJtaQL0wp0svpn3L7dd1CJAMg9zf42QOOBe0N1avBeEjFXtk9dWBVEkacHhHeUrTpdZihqyXuFjAIlKlv1ZwIEmXUap2beq87ZSZ8oewjoJ4JvRCtof5tnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LYyUpPL3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43159c9f617so24345635e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 02:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732356870; x=1732961670; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JlbQbRdER9cb6XxyOBEUlXd/vTrDH7hjVXWhSQyU36s=;
        b=LYyUpPL3n56+bpGjFZlWEv3S4Iu+3LyYdjy65wTG9Du6nOhsBF9nmuf/ckWVSM30rB
         e4PqF03X+2rz6ZMf3+vPpBVBINFJgs4DE33iphF8jzXYqe3qXhGEij6YPsaziDsRbGlj
         zhzFVYzsQL2In7pFgWZrX+aqSFL85nUhmGQKPkh+BH1/7LRmu58FpUxzTlKqFoyR9gDZ
         LfM8YPrDtwoN+EeWxnox+zAh9lLAb2ijWJLexHu1CGcSCKuoN/bfd7XaY6CxKHcEUpEm
         OM23P2H9n3gHjL+h1ilK95TrPwZD7Wo9ZfV06aQ4bhSjW50Wg45GnF9J3l35pwZh2tYT
         wF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732356870; x=1732961670;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlbQbRdER9cb6XxyOBEUlXd/vTrDH7hjVXWhSQyU36s=;
        b=LcDndl4iZ97bbU8CH3Eyf+EFV3DWuTLCbbMfZV49OwfdiU327vaLQepQMR7ozKwrcT
         KVnGaLyv2Cv3q2TJq483+D4b3xx+tyVG/mFR21ehmXZPN2hJOHvEkvowaNkDOuCRMXBn
         mQlPk72U3wWeShbOWfr9NEvFZuSmmJi9XWFPzTaZy+7AFVLzV2N3BroeKBtm3xKLGbVA
         aUlvk/n9L+z1yElMqUY9YOr6iUemGCa+k/ohEQZW+C8O8+6sfcNE0gbGf2HAvDVv8Xpr
         bFWYHxlT/rHBeEk88XvOuhU/y4AISno0p6zdhBeqooNqyu+3ivE68AoDVz+R8YDrB/kb
         WPsA==
X-Forwarded-Encrypted: i=1; AJvYcCV4N/NE5eSWz1YdveCmDfsmt/JWEtGBLurQfvXx777uC/DbMooI93NdzDYbs+1VZ4M7bWMBDEK+fUUHyxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwirhQLeNE6gSNPOM32VO8Zf0Yj6L8FNEJ29wuF6u7DWW6AxAqX
	YhKABQ33W+HJ6s/l6W6PGF2/3lhmV4NlPsl5qhli9WRLfF1JL9uShWKQ6wZLnIg=
X-Gm-Gg: ASbGncvDcmvV9ab7i0h4ohEQj09kJrqCrv7NQ577yFT68nkeTDqYq4n/9hifHyc0L9H
	bY/rPlW6jtd1XM1cQV1oR4Pv7nQSBpY5CrrcAUL6kjjpzzpTfmxhYywGgytHOVoM2d3VTL87FmG
	oXKf+XFYmMbnm10X8fLE5hwvmsfqjGHbhYbO9YZnRV4rVpinNuWH/Uh7UciXw5CgT3/WuIRcFcZ
	lkkJ7jsgViwgzeDNDH9q5AfMw/H461Y5j6esrOds289/9OCJ8W+59s=
X-Google-Smtp-Source: AGHT+IHrbAOHzHT+Xq8sm68N1Yuvz86bbCkYek+tG0oo/6yZ/oUSC9ixlQW6ukqiA9+qeA0WfOfb8A==
X-Received: by 2002:a05:600c:3150:b0:42f:310f:de9 with SMTP id 5b1f17b1804b1-433ce434707mr58386975e9.15.1732356869582;
        Sat, 23 Nov 2024 02:14:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde10e50sm55471855e9.12.2024.11.23.02.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 02:14:29 -0800 (PST)
Date: Sat, 23 Nov 2024 13:14:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: drivers/infiniband/hw/bnxt_re/qplib_fp.c:1090 bnxt_qplib_create_qp()
 error: we previously assumed 'res->dattr' could be null (see line 985)
Message-ID: <da54caf2-26af-420e-bfd5-106881ce6b27@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ I reported this last year and generally I try to report only report these
  warnings one time, but it still feels like perhaps a bug.  Mostly likely with
  these the NULL check can be removed.  But smatch still warns about it even
  with cross function analysis.
  https://lore.kernel.org/all/c2ff81f3-5de6-4498-b157-909d89e74fcb@stanley.mountain/
  -dan ]

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   28eb75e178d389d325f1666e422bc13bbbb9804c
commit: 07f830ae4913d0b986c8c0ff88a7d597948b9bd8 RDMA/bnxt_re: Adds MSN table capability for Gen P7 adapters
config: x86_64-randconfig-161-20241122 (https://download.01.org/0day-ci/archive/20241122/202411222329.YTrwonWi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411222329.YTrwonWi-lkp@intel.com/

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
The new code assumes this can be NULL

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
                                                                                    ^^^^^^^^^^
But the old code dereferences it without checking.

9a381f7e5aa299 Selvin Xavier      2021-09-15  1091  		qp_flags |= CMDQ_CREATE_QP_QP_FLAGS_EXT_STATS_ENABLED;
9a381f7e5aa299 Selvin Xavier      2021-09-15  1092  
1ac5a404797523 Selvin Xavier      2017-02-10  1093  	req.qp_flags = cpu_to_le32(qp_flags);
99bf84e24eb83d Devesh Sharma      2020-04-02  1094  
1ac5a404797523 Selvin Xavier      2017-02-10  1095  	/* ORRQ and IRRQ */
1ac5a404797523 Selvin Xavier      2017-02-10  1096  	if (psn_sz) {
1ac5a404797523 Selvin Xavier      2017-02-10  1097  		xrrq = &qp->orrq;
1ac5a404797523 Selvin Xavier      2017-02-10  1098  		xrrq->max_elements =
1ac5a404797523 Selvin Xavier      2017-02-10  1099  			ORD_LIMIT_TO_ORRQ_SLOTS(qp->max_rd_atomic);
1ac5a404797523 Selvin Xavier      2017-02-10  1100  		req_size = xrrq->max_elements *
1ac5a404797523 Selvin Xavier      2017-02-10  1101  			   BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE + PAGE_SIZE - 1;
1ac5a404797523 Selvin Xavier      2017-02-10  1102  		req_size &= ~(PAGE_SIZE - 1);
0c4dcd60281750 Devesh Sharma      2020-02-15  1103  		sginfo.pgsize = req_size;
0c4dcd60281750 Devesh Sharma      2020-02-15  1104  		sginfo.pgshft = PAGE_SHIFT;
0c4dcd60281750 Devesh Sharma      2020-02-15  1105  
0c4dcd60281750 Devesh Sharma      2020-02-15  1106  		hwq_attr.res = res;
0c4dcd60281750 Devesh Sharma      2020-02-15  1107  		hwq_attr.sginfo = &sginfo;
0c4dcd60281750 Devesh Sharma      2020-02-15  1108  		hwq_attr.depth = xrrq->max_elements;
0c4dcd60281750 Devesh Sharma      2020-02-15  1109  		hwq_attr.stride = BNXT_QPLIB_MAX_ORRQE_ENTRY_SIZE;
0c4dcd60281750 Devesh Sharma      2020-02-15  1110  		hwq_attr.aux_stride = 0;
0c4dcd60281750 Devesh Sharma      2020-02-15  1111  		hwq_attr.aux_depth = 0;
0c4dcd60281750 Devesh Sharma      2020-02-15  1112  		hwq_attr.type = HWQ_TYPE_CTX;
0c4dcd60281750 Devesh Sharma      2020-02-15  1113  		rc = bnxt_qplib_alloc_init_hwq(xrrq, &hwq_attr);
1ac5a404797523 Selvin Xavier      2017-02-10  1114  		if (rc)
159fb4ceacd79b Devesh Sharma      2020-07-15  1115  			goto rq_swq;
1ac5a404797523 Selvin Xavier      2017-02-10  1116  		pbl = &xrrq->pbl[PBL_LVL_0];
1ac5a404797523 Selvin Xavier      2017-02-10  1117  		req.orrq_addr = cpu_to_le64(pbl->pg_map_arr[0]);
1ac5a404797523 Selvin Xavier      2017-02-10  1118  
1ac5a404797523 Selvin Xavier      2017-02-10  1119  		xrrq = &qp->irrq;
1ac5a404797523 Selvin Xavier      2017-02-10  1120  		xrrq->max_elements = IRD_LIMIT_TO_IRRQ_SLOTS(
1ac5a404797523 Selvin Xavier      2017-02-10  1121  						qp->max_dest_rd_atomic);
1ac5a404797523 Selvin Xavier      2017-02-10  1122  		req_size = xrrq->max_elements *
1ac5a404797523 Selvin Xavier      2017-02-10  1123  			   BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE + PAGE_SIZE - 1;
1ac5a404797523 Selvin Xavier      2017-02-10  1124  		req_size &= ~(PAGE_SIZE - 1);
0c4dcd60281750 Devesh Sharma      2020-02-15  1125  		sginfo.pgsize = req_size;
0c4dcd60281750 Devesh Sharma      2020-02-15  1126  		hwq_attr.depth =  xrrq->max_elements;
0c4dcd60281750 Devesh Sharma      2020-02-15  1127  		hwq_attr.stride = BNXT_QPLIB_MAX_IRRQE_ENTRY_SIZE;
0c4dcd60281750 Devesh Sharma      2020-02-15  1128  		rc = bnxt_qplib_alloc_init_hwq(xrrq, &hwq_attr);
1ac5a404797523 Selvin Xavier      2017-02-10  1129  		if (rc)
1ac5a404797523 Selvin Xavier      2017-02-10  1130  			goto fail_orrq;
1ac5a404797523 Selvin Xavier      2017-02-10  1131  
1ac5a404797523 Selvin Xavier      2017-02-10  1132  		pbl = &xrrq->pbl[PBL_LVL_0];
1ac5a404797523 Selvin Xavier      2017-02-10  1133  		req.irrq_addr = cpu_to_le64(pbl->pg_map_arr[0]);
1ac5a404797523 Selvin Xavier      2017-02-10  1134  	}
1ac5a404797523 Selvin Xavier      2017-02-10  1135  	req.pd_id = cpu_to_le32(qp->pd->id);
1ac5a404797523 Selvin Xavier      2017-02-10  1136  
ff015bcd213b5d Selvin Xavier      2023-03-30  1137  	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
ff015bcd213b5d Selvin Xavier      2023-03-30  1138  				sizeof(resp), 0);
ff015bcd213b5d Selvin Xavier      2023-03-30  1139  	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
cc1ec769b87c7d Devesh Sharma      2017-05-22  1140  	if (rc)
1ac5a404797523 Selvin Xavier      2017-02-10  1141  		goto fail;
cc1ec769b87c7d Devesh Sharma      2017-05-22  1142  
cc1ec769b87c7d Devesh Sharma      2017-05-22  1143  	qp->id = le32_to_cpu(resp.xid);
1ac5a404797523 Selvin Xavier      2017-02-10  1144  	qp->cur_qp_state = CMDQ_MODIFY_QP_NEW_STATE_RESET;
f218d67ef00431 Selvin Xavier      2017-06-29  1145  	INIT_LIST_HEAD(&qp->sq_flush);
f218d67ef00431 Selvin Xavier      2017-06-29  1146  	INIT_LIST_HEAD(&qp->rq_flush);
6f53196bc5e7fd Devesh Sharma      2020-02-15  1147  	qp->cctx = res->cctx;
6f53196bc5e7fd Devesh Sharma      2020-02-15  1148  	sq->dbinfo.hwq = &sq->hwq;
6f53196bc5e7fd Devesh Sharma      2020-02-15  1149  	sq->dbinfo.xid = qp->id;
6f53196bc5e7fd Devesh Sharma      2020-02-15  1150  	sq->dbinfo.db = qp->dpi->dbr;
2bb3c32c5c5fe9 Devesh Sharma      2020-07-15  1151  	sq->dbinfo.max_slot = bnxt_qplib_set_sq_max_slot(qp->wqe_mode);
6f53196bc5e7fd Devesh Sharma      2020-02-15  1152  	if (rq->max_wqe) {
6f53196bc5e7fd Devesh Sharma      2020-02-15  1153  		rq->dbinfo.hwq = &rq->hwq;
6f53196bc5e7fd Devesh Sharma      2020-02-15  1154  		rq->dbinfo.xid = qp->id;
6f53196bc5e7fd Devesh Sharma      2020-02-15  1155  		rq->dbinfo.db = qp->dpi->dbr;
2bb3c32c5c5fe9 Devesh Sharma      2020-07-15  1156  		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
6f53196bc5e7fd Devesh Sharma      2020-02-15  1157  	}
84cf229f4001c1 Selvin Xavier      2020-08-24  1158  	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
84cf229f4001c1 Selvin Xavier      2020-08-24  1159  	rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
84cf229f4001c1 Selvin Xavier      2020-08-24  1160  	rcfw->qp_tbl[tbl_indx].qp_handle = (void *)qp;
1ac5a404797523 Selvin Xavier      2017-02-10  1161  
1ac5a404797523 Selvin Xavier      2017-02-10  1162  	return 0;
1ac5a404797523 Selvin Xavier      2017-02-10  1163  fail:
0c4dcd60281750 Devesh Sharma      2020-02-15  1164  	bnxt_qplib_free_hwq(res, &qp->irrq);
1ac5a404797523 Selvin Xavier      2017-02-10  1165  fail_orrq:
0c4dcd60281750 Devesh Sharma      2020-02-15  1166  	bnxt_qplib_free_hwq(res, &qp->orrq);
159fb4ceacd79b Devesh Sharma      2020-07-15  1167  rq_swq:
159fb4ceacd79b Devesh Sharma      2020-07-15  1168  	kfree(rq->swq);
1ac5a404797523 Selvin Xavier      2017-02-10  1169  fail_rq:
0c4dcd60281750 Devesh Sharma      2020-02-15  1170  	bnxt_qplib_free_hwq(res, &rq->hwq);
159fb4ceacd79b Devesh Sharma      2020-07-15  1171  sq_swq:
159fb4ceacd79b Devesh Sharma      2020-07-15  1172  	kfree(sq->swq);
1ac5a404797523 Selvin Xavier      2017-02-10  1173  fail_sq:
0c4dcd60281750 Devesh Sharma      2020-02-15  1174  	bnxt_qplib_free_hwq(res, &sq->hwq);
1ac5a404797523 Selvin Xavier      2017-02-10  1175  	return rc;
1ac5a404797523 Selvin Xavier      2017-02-10  1176  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


