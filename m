Return-Path: <linux-kernel+bounces-190166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D518CFA71
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6E41C21109
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FCB47F69;
	Mon, 27 May 2024 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDooChSZ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325FE47F5F
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796104; cv=none; b=KtGrvB590jGWg5hgPkV9nAQ493Q5PhwLAQklefwZWEIJOYE2wvZkeYoewp/+gb5MQD0I9jpL89ed4NsL7Bmq/1FZKTmsTNHe8YQXZ7AKlYM17it7+A0Q1WSGkF3QVEF5bOpvw7X5oZL9ss3h9sUpAgD3lVoHgSNIw1iCHqO2BUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796104; c=relaxed/simple;
	bh=snHEB08XY5JQn621PObDnGVEpGYE4z2PihmqwwfM3ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gHYMMo8JOOfRshZh6q2Y9J7kaD5Lg45y+biKXcevdA5eRVNVpDHCHHEH5NVrAHoxSmhMq0y81ns+z6Gqwq+eKIPFk1pySVxSZh1kwWnfeQ18MoxhPG3ViyaBsgj/QNJfyDPhu7LaD0OwgUdEBeBOkD8irUMpepLO4J8fNFtDNAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QDooChSZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52962423ed8so3158132e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716796100; x=1717400900; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0F8xDz21HTi5SrFsLB+iyLzGOKVclLkyve6qrrpHP8=;
        b=QDooChSZLqSa4V0kNcos/UGo/5DEd9P/Xb4vGpkO1VpBMPGWvH37GMwppNMoC6wY4S
         A2OMvyeESfuVp85Mq6HQRhevN/wOG42sk2ZZrAGZRo7KBVrqyvWL4EI91MUqO8eKf3kv
         +idvmbjhtFTJZzAjbFLoO5aUC/jxBzeTlR2vV+K8Vmg0TwgZzW+wrJnosMlQFFua8saH
         ZaZIydKZR9NdNIxOx10ZkIbSWXccysCRm+R53tI2TspfCv/ROeO4WSQ2lGGdrcMR2Nvr
         bjLb0h0JV/uIDoKs6S7ytyENQ6hwQ5yNagFvD5rZXn2AanAqkPnn3DWP3yKoFAXGkQzU
         RM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716796100; x=1717400900;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0F8xDz21HTi5SrFsLB+iyLzGOKVclLkyve6qrrpHP8=;
        b=axKbmA9IBq9+NHG0Tl72bpxpJqDqafBlvBnlNpDepSD2SYStzEcIqFHEE+LBysFMq9
         7oPhy/XNhxnvSFSNj+DyCsoMDyf8nEE0fFmy/6aTuVcZceX82Z/hZfrbU7Vx0sS+FI9E
         0XQykuddqvUGoQGYZuMwwqclxDbq+SRSqLmrA7yChDIVZg6l+L+PFSqRVc/2Ap4TiEw+
         n+G/64u3ZQJPLc61Lfn3Piw5+3IDDXEYOpHmPhPTLpEZXoNKe3q88P7CVwzpXzAnlh8L
         i7//yl4EYpwy9mZ+IVULsO7hnPiLMII3q/hG5Joq3M7ZL5YzRV4xErdJbQb7D7Mg7Kke
         niug==
X-Forwarded-Encrypted: i=1; AJvYcCUm3t0XWxwMhjDG74yIcJeGrPx3AXUe3jIkoUTH6DeXPOvR1U5XEeEwnNbQdOB0J/zq29cbG+vVYqJH0k7jqLJQ2rjSArS0Q4Dqw41L
X-Gm-Message-State: AOJu0Ywyc2lRuUk7WFKcRJ8jNMUMaKANrSQb70QzZ9fOo0wiMJztVuTW
	HIFwO1x7sPINhgaj5pNXUpVhZaXHTKvLacAQpIAAl/ti7b4kc3y2eYmgj3g3B34RLdjkaUNYT8D
	Q
X-Google-Smtp-Source: AGHT+IH4t/IBOf/Ew7gwWEo6+jgoCpj8r+bvyE+lZiUzS0bhtYDCCBlqMIU+yWaaueZRRxr5Vu1LEA==
X-Received: by 2002:a05:6512:10cc:b0:523:7f19:cb44 with SMTP id 2adb3069b0e04-52965198b94mr7303495e87.29.1716796100209;
        Mon, 27 May 2024 00:48:20 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda48e6sm458737266b.203.2024.05.27.00.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:48:19 -0700 (PDT)
Date: Mon, 27 May 2024 10:48:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, David Gstir <david@sigma-star.at>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: drivers/crypto/mxs-dcp.c:292 mxs_dcp_run_aes() error: uninitialized
 symbol 'key_phys'.
Message-ID: <129493f0-211f-408f-8435-2e6fead3f07b@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c13320499ba0efd93174ef6462ae8a7a2933f6e7
commit: 3d16af0b4cfac4b2c3b238e2ec37b38c2f316978 crypto: mxs-dcp: Add support for hardware-bound keys
config: arm-randconfig-r071-20240524 (https://download.01.org/0day-ci/archive/20240527/202405270146.Y9tPoil8-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7aa382fd7257d9bd4f7fc50bb7078a3c26a1628c)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405270146.Y9tPoil8-lkp@intel.com/

smatch warnings:
drivers/crypto/mxs-dcp.c:292 mxs_dcp_run_aes() error: uninitialized symbol 'key_phys'.

vim +/key_phys +292 drivers/crypto/mxs-dcp.c

2021abaa00da64a Marek Vasut    2014-01-14  225  static int mxs_dcp_run_aes(struct dcp_async_ctx *actx,
9acb3247e0e1d94 Ard Biesheuvel 2019-11-09  226  			   struct skcipher_request *req, int init)
15b59e7c3733f90 Marek Vasut    2013-12-10  227  {
df6313d707e575a Sean Anderson  2021-07-01  228  	dma_addr_t key_phys, src_phys, dst_phys;
15b59e7c3733f90 Marek Vasut    2013-12-10  229  	struct dcp *sdcp = global_sdcp;
15b59e7c3733f90 Marek Vasut    2013-12-10  230  	struct dcp_dma_desc *desc = &sdcp->coh->desc[actx->chan];
9acb3247e0e1d94 Ard Biesheuvel 2019-11-09  231  	struct dcp_aes_req_ctx *rctx = skcipher_request_ctx(req);
3d16af0b4cfac4b David Gstir    2024-04-03  232  	bool key_referenced = actx->key_referenced;
15b59e7c3733f90 Marek Vasut    2013-12-10  233  	int ret;
15b59e7c3733f90 Marek Vasut    2013-12-10  234  
3d16af0b4cfac4b David Gstir    2024-04-03  235  	if (!key_referenced) {
df6313d707e575a Sean Anderson  2021-07-01  236  		key_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_key,
df6313d707e575a Sean Anderson  2021-07-01  237  					  2 * AES_KEYSIZE_128, DMA_TO_DEVICE);
df6313d707e575a Sean Anderson  2021-07-01  238  		ret = dma_mapping_error(sdcp->dev, key_phys);
df6313d707e575a Sean Anderson  2021-07-01  239  		if (ret)
df6313d707e575a Sean Anderson  2021-07-01  240  			return ret;
3d16af0b4cfac4b David Gstir    2024-04-03  241  	}

key_phys not initialized on else path.

df6313d707e575a Sean Anderson  2021-07-01  242  
df6313d707e575a Sean Anderson  2021-07-01  243  	src_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_in_buf,
15b59e7c3733f90 Marek Vasut    2013-12-10  244  				  DCP_BUF_SZ, DMA_TO_DEVICE);
df6313d707e575a Sean Anderson  2021-07-01  245  	ret = dma_mapping_error(sdcp->dev, src_phys);
df6313d707e575a Sean Anderson  2021-07-01  246  	if (ret)
df6313d707e575a Sean Anderson  2021-07-01  247  		goto err_src;
df6313d707e575a Sean Anderson  2021-07-01  248  
df6313d707e575a Sean Anderson  2021-07-01  249  	dst_phys = dma_map_single(sdcp->dev, sdcp->coh->aes_out_buf,
15b59e7c3733f90 Marek Vasut    2013-12-10  250  				  DCP_BUF_SZ, DMA_FROM_DEVICE);
df6313d707e575a Sean Anderson  2021-07-01  251  	ret = dma_mapping_error(sdcp->dev, dst_phys);
df6313d707e575a Sean Anderson  2021-07-01  252  	if (ret)
df6313d707e575a Sean Anderson  2021-07-01  253  		goto err_dst;
15b59e7c3733f90 Marek Vasut    2013-12-10  254  
fadd7a6e616b89c Radu Solea     2018-10-02  255  	if (actx->fill % AES_BLOCK_SIZE) {
fadd7a6e616b89c Radu Solea     2018-10-02  256  		dev_err(sdcp->dev, "Invalid block size!\n");
fadd7a6e616b89c Radu Solea     2018-10-02  257  		ret = -EINVAL;
fadd7a6e616b89c Radu Solea     2018-10-02  258  		goto aes_done_run;
fadd7a6e616b89c Radu Solea     2018-10-02  259  	}
fadd7a6e616b89c Radu Solea     2018-10-02  260  
15b59e7c3733f90 Marek Vasut    2013-12-10  261  	/* Fill in the DMA descriptor. */
15b59e7c3733f90 Marek Vasut    2013-12-10  262  	desc->control0 = MXS_DCP_CONTROL0_DECR_SEMAPHORE |
15b59e7c3733f90 Marek Vasut    2013-12-10  263  		    MXS_DCP_CONTROL0_INTERRUPT |
15b59e7c3733f90 Marek Vasut    2013-12-10  264  		    MXS_DCP_CONTROL0_ENABLE_CIPHER;
15b59e7c3733f90 Marek Vasut    2013-12-10  265  
3d16af0b4cfac4b David Gstir    2024-04-03  266  	if (key_referenced)
3d16af0b4cfac4b David Gstir    2024-04-03  267  		/* Set OTP key bit to select the key via KEY_SELECT. */
3d16af0b4cfac4b David Gstir    2024-04-03  268  		desc->control0 |= MXS_DCP_CONTROL0_OTP_KEY;
3d16af0b4cfac4b David Gstir    2024-04-03  269  	else
15b59e7c3733f90 Marek Vasut    2013-12-10  270  		/* Payload contains the key. */
15b59e7c3733f90 Marek Vasut    2013-12-10  271  		desc->control0 |= MXS_DCP_CONTROL0_PAYLOAD_KEY;
15b59e7c3733f90 Marek Vasut    2013-12-10  272  
2021abaa00da64a Marek Vasut    2014-01-14  273  	if (rctx->enc)
15b59e7c3733f90 Marek Vasut    2013-12-10  274  		desc->control0 |= MXS_DCP_CONTROL0_CIPHER_ENCRYPT;
15b59e7c3733f90 Marek Vasut    2013-12-10  275  	if (init)
15b59e7c3733f90 Marek Vasut    2013-12-10  276  		desc->control0 |= MXS_DCP_CONTROL0_CIPHER_INIT;
15b59e7c3733f90 Marek Vasut    2013-12-10  277  
15b59e7c3733f90 Marek Vasut    2013-12-10  278  	desc->control1 = MXS_DCP_CONTROL1_CIPHER_SELECT_AES128;
15b59e7c3733f90 Marek Vasut    2013-12-10  279  
2021abaa00da64a Marek Vasut    2014-01-14  280  	if (rctx->ecb)
15b59e7c3733f90 Marek Vasut    2013-12-10  281  		desc->control1 |= MXS_DCP_CONTROL1_CIPHER_MODE_ECB;
15b59e7c3733f90 Marek Vasut    2013-12-10  282  	else
15b59e7c3733f90 Marek Vasut    2013-12-10  283  		desc->control1 |= MXS_DCP_CONTROL1_CIPHER_MODE_CBC;
15b59e7c3733f90 Marek Vasut    2013-12-10  284  
3d16af0b4cfac4b David Gstir    2024-04-03  285  	if (key_referenced)
3d16af0b4cfac4b David Gstir    2024-04-03  286  		desc->control1 |= sdcp->coh->aes_key[0] << MXS_DCP_CONTROL1_KEY_SELECT_SHIFT;
3d16af0b4cfac4b David Gstir    2024-04-03  287  
15b59e7c3733f90 Marek Vasut    2013-12-10  288  	desc->next_cmd_addr = 0;
15b59e7c3733f90 Marek Vasut    2013-12-10  289  	desc->source = src_phys;
15b59e7c3733f90 Marek Vasut    2013-12-10  290  	desc->destination = dst_phys;
15b59e7c3733f90 Marek Vasut    2013-12-10  291  	desc->size = actx->fill;
15b59e7c3733f90 Marek Vasut    2013-12-10 @292  	desc->payload = key_phys;
                                                                        ^^^^^^^^
Uninitialized.

15b59e7c3733f90 Marek Vasut    2013-12-10  293  	desc->status = 0;
15b59e7c3733f90 Marek Vasut    2013-12-10  294  
15b59e7c3733f90 Marek Vasut    2013-12-10  295  	ret = mxs_dcp_start_dma(actx);
15b59e7c3733f90 Marek Vasut    2013-12-10  296  
fadd7a6e616b89c Radu Solea     2018-10-02  297  aes_done_run:
df6313d707e575a Sean Anderson  2021-07-01  298  	dma_unmap_single(sdcp->dev, dst_phys, DCP_BUF_SZ, DMA_FROM_DEVICE);
df6313d707e575a Sean Anderson  2021-07-01  299  err_dst:
df6313d707e575a Sean Anderson  2021-07-01  300  	dma_unmap_single(sdcp->dev, src_phys, DCP_BUF_SZ, DMA_TO_DEVICE);
df6313d707e575a Sean Anderson  2021-07-01  301  err_src:
3d16af0b4cfac4b David Gstir    2024-04-03  302  	if (!key_referenced)
15b59e7c3733f90 Marek Vasut    2013-12-10  303  		dma_unmap_single(sdcp->dev, key_phys, 2 * AES_KEYSIZE_128,
15b59e7c3733f90 Marek Vasut    2013-12-10  304  				 DMA_TO_DEVICE);
15b59e7c3733f90 Marek Vasut    2013-12-10  305  	return ret;
15b59e7c3733f90 Marek Vasut    2013-12-10  306  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


