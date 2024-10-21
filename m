Return-Path: <linux-kernel+bounces-373776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBD79A5C90
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABD01F210AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41A1D130E;
	Mon, 21 Oct 2024 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAzmzub/"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194931D0E30
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495179; cv=none; b=m3sYjDi+TrCi4JXgzbeTM/+wtj3fsxMczZxv3LNu+q0lyB0T+4CGXbeBFU/GogzdvSOqohWd0Wv97Mo4UMVbnpaPvsYZKbuGkm7hg61IZEwV2kIaPHR7DaYGUG1UDr1kJn2BlO1uZKwoLdSBqBJ3H6Dsd4yh5A+59GYL41OFY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495179; c=relaxed/simple;
	bh=A4cT04tk6Qpxw/y0XjtON9qAuNPCJvAufgdp//JETJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PI0fxz3HuTKRpEU8CfrWbfEXE2ANOfhAKkLP2UDsDgd+XUI1lf+6iJjj80JtrXdpMxXkcPdIQXnlxnIPUzHIZ+rj55ClZ8x7/LbB7pGPbvWD3H6mYCinF1+3RyliPvL/pXomVnDKHc1WfYMAfc7qbm884d4PMJK9McsZAFwDTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AAzmzub/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so27406345e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729495175; x=1730099975; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N4mG7OtmO6ALnS+LqwK6H+C2vMDexXNqjYjOqwc57+s=;
        b=AAzmzub/P8s8FT30QOJ29KAD7KOJhGXbIv3HEoWIr6/3K/DQgwuFYTNn4QE8nLVAhZ
         w6KPAjJl7I1wsPnriHSEN9zylH+TUPDenYSGC6mRdsK7gyKJKStFq6wsG4AVey5ZO/G1
         MPNjoPUfLJuI9PRbTIpLn+xQP7SBYTxZlGQVbiO9UGrSMo7aoakDuEyL2TcFp6X4JCOK
         LOvikQS+We6Ai/Y6AdCkv5n+xf2yPb3kZIXqaVDO070jLQEc1bFeRsO/Av1U4r9hxsZI
         jjYKPi18xZz1V1JXCUFeCBRZzh7Lk9QbzpxO2tfM/z1LEb7kXUYmMLf5OZgHavqk2jRI
         wUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495175; x=1730099975;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4mG7OtmO6ALnS+LqwK6H+C2vMDexXNqjYjOqwc57+s=;
        b=fmS2xCsIVic6v9WS9i4j5rH/slzU/wU/LoIczOxrskO7JkUO8wcSlOKSyqk8fVzGck
         AVMrZsVe/TbZ+o5snw4igWf/BJkPnAeG0ZVaxOhWzdg1l4AYh41JANnBbpKoQrN064xo
         9MSIr4J9N5X8r/KFMx583TuLEc4WGBplnfWUFuY+vC84A6FTqULIpxoAfrCR5D5xboyt
         cVTpYXzOB6LlfFHrsIVWEI+q00oRFnCqjnd0YiT+hjNKPFjX84r5XVnXTsFO2AWnh0CM
         0mwtE6s9w+UcJAIRbCKEW6uW1v5X5TzXTntUSHuKoSCegNAaRjvlPi8pjuO5/kKbWq+f
         Wp1A==
X-Forwarded-Encrypted: i=1; AJvYcCWKXCsVDuHpa2C8iYbrxQrxxpAoi/JObZte097nFzjAvFSTK+NyN3yuejqLhF5zQkNARrKhX9WK7p3LKcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6VGUTkmPR4V3W9z2But3cc+tvkAA9oK6yu1laOndEiYk1MK4
	N9DbG4fuxL92RRNeoI5rcH9KnL6rrgWEQw/ww6pQqjRGSd2aPwCyE9mpEhWnO0c=
X-Google-Smtp-Source: AGHT+IE1bmdiEk0vWux62zPzb8bYFDT+mROA8lnQzzHBbtLTh0zkjZe+omLvslbveQ+erNxhecMIrQ==
X-Received: by 2002:a05:600c:4e89:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-431616363b0mr76101885e9.2.1729495175283;
        Mon, 21 Oct 2024 00:19:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58aef6sm46951245e9.22.2024.10.21.00.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:19:34 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:19:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Matthew Sakai <msakai@redhat.com>
Subject: drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn: inconsistent
 returns '&pool->lock'.
Message-ID: <717e8949-55c4-4461-8951-3e582e9b77ef@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mike,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3d5ad2d4eca337e80f38df77de89614aa5aaceb9
commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
config: x86_64-randconfig-161-20241019 (https://download.01.org/0day-ci/archive/20241019/202410191209.osrd8z9H-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410191209.osrd8z9H-lkp@intel.com/

smatch warnings:
drivers/md/dm-vdo/data-vio.c:976 vdo_launch_bio() warn: inconsistent returns '&pool->lock'.

vim +976 drivers/md/dm-vdo/data-vio.c

79535a7881c0cb Matthew Sakai 2023-11-16  958  void vdo_launch_bio(struct data_vio_pool *pool, struct bio *bio)
79535a7881c0cb Matthew Sakai 2023-11-16  959  {
79535a7881c0cb Matthew Sakai 2023-11-16  960  	struct data_vio *data_vio;
79535a7881c0cb Matthew Sakai 2023-11-16  961  
79535a7881c0cb Matthew Sakai 2023-11-16  962  	ASSERT_LOG_ONLY(!vdo_is_state_quiescent(&pool->state),
79535a7881c0cb Matthew Sakai 2023-11-16  963  			"data_vio_pool not quiescent on acquire");
79535a7881c0cb Matthew Sakai 2023-11-16  964  
79535a7881c0cb Matthew Sakai 2023-11-16  965  	bio->bi_private = (void *) jiffies;
79535a7881c0cb Matthew Sakai 2023-11-16  966  	spin_lock(&pool->lock);
79535a7881c0cb Matthew Sakai 2023-11-16  967  	if ((bio_op(bio) == REQ_OP_DISCARD) &&
79535a7881c0cb Matthew Sakai 2023-11-16  968  	    !acquire_permit(&pool->discard_limiter, bio))
79535a7881c0cb Matthew Sakai 2023-11-16  969  		return;
                                                        ^^^^^^

79535a7881c0cb Matthew Sakai 2023-11-16  970  
79535a7881c0cb Matthew Sakai 2023-11-16  971  	if (!acquire_permit(&pool->limiter, bio))
79535a7881c0cb Matthew Sakai 2023-11-16  972  		return;
                                                        ^^^^^^
Still holding pool->lock on these paths.

79535a7881c0cb Matthew Sakai 2023-11-16  973  
79535a7881c0cb Matthew Sakai 2023-11-16  974  	data_vio = get_available_data_vio(pool);
79535a7881c0cb Matthew Sakai 2023-11-16  975  	spin_unlock(&pool->lock);
79535a7881c0cb Matthew Sakai 2023-11-16 @976  	launch_bio(pool->completion.vdo, data_vio, bio);
79535a7881c0cb Matthew Sakai 2023-11-16  977  }
79535a7881c0cb Matthew Sakai 2023-11-16  978  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


