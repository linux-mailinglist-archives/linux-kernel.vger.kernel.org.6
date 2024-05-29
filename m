Return-Path: <linux-kernel+bounces-194273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB68D3947
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2242D2868AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979BF15920B;
	Wed, 29 May 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbevLIAn"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B201591EE
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993145; cv=none; b=W7Xc5kfj/ZYDMv4k6Ap2BWoWUBfz7+Nd9qW/hUuST2k2t1PUiK4NT/vMB1S8R8MOG5K3rf1lRYdRqjtSZGrEyG+RVTNyV6tZIUl1L8Q3IgMWnjZQzXyevYDf4R9mfETGd3rpIjeTd3Df9KiBGHeru5dNcMHbEasC2H3qcjTULTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993145; c=relaxed/simple;
	bh=kXs3QsURM2zcPPJpgkgPQdLMqzTx/MGlb/EnXgJ0xMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MKu6fUBqp+TZ8D//l6G5V+XAqa5L9piLO1xF2bwt4+/Jqu/uPnvVOoOFo71SfGDYQaTluz8WccsQwoljZlxHloxxqJ3XLyFUIrRvctNT+f29PjF+pYqqwwfZeiacDUMyTKAkQJR/3Jpr4fRW1uF1acYfx60itQysHuifz1ZvYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZbevLIAn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a634e03339dso262128166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716993141; x=1717597941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo88FTZD/E59x8F405UuK0CB4Sb3uR967SF1+FjoNhY=;
        b=ZbevLIAn+L8De152HJyUq7/xchK2Op6E3yi8by00my1TLrARsZkO46StYB/FuonR+D
         Y9XFbROhCWv3sTqg/G7+f7I7cQdvzQEiCJdHg7IfrygDhtciOXYjYfD/VjW5W7nuHYZP
         krA4goIlUMJVGAGpTkz6fRMl7oz+Vmu2+NGu1cbJHsRTstY8yxLiX/1RzwpIv4+yxgGK
         ew4EkLLiFEXCwD0irwwc12MsSD7+kFaufLozyYQyr+raTFFFR5JEB4bQn3Y3EU2SJM6q
         5fkuTfxTl2lmqd70YUvcA9xG77JjoDTcqlWogvCRqjLqTvI7HNUWtj3pstOBBR99s1mq
         yiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993141; x=1717597941;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vo88FTZD/E59x8F405UuK0CB4Sb3uR967SF1+FjoNhY=;
        b=ZJSEH+MUveArZZVHvx89Pj+pBMEBycDviCR6AeDxPZvW7MbSfCt706HIbi82Xl/MEz
         /rZGexl9E9en07CgV47xKwpNG6mst3TzjQiZQ8rxOC/9TLSbvDdMGdcf0PcDKOCwWaFj
         Ie+AasiGxHqbc+Sckue8mASTbli9Y8ykHjO3dCk59OX90G1NRZZJCkaWguTOdPdsb7bv
         YowJvPCM+YCd0Wyo1/NX+z4A3zt4/OPjI+kgr3egEX2yNpOZNGCJQzny5W+39hEYruNG
         C8wPY6a0riX+LVs4/VlvyC0ynqo26BaLZRDU+D/7L1JifNoLPXO9mlNAVt9Qtyd1IuhR
         5yAw==
X-Forwarded-Encrypted: i=1; AJvYcCU4rI/NMCxAsX2z5cQFDt0RmQCGW04BHuFlg9zjL/e3NsRpx8fVhB5II/YdKciPpRsC6h5siKSlDdBE1VySDu6TcfDlfZmprx45f0Pt
X-Gm-Message-State: AOJu0YyyDGQvSeUZI1LNg24Ghkra8qgfCrAhEtassFTSd97r4wwzZhbF
	icoRQX0gp2rgxtct9b2DcHTGN6mBxfTlkutYyNv/a/uelOacQOaAhCyJ36LHa7A=
X-Google-Smtp-Source: AGHT+IE7Ire7AcSf7DwSdDRd2wsD87NIfwOXMT5C6rLL+pinwrrV1xj3IIIM9Ua5rWHq6lcOdLYN1A==
X-Received: by 2002:a17:906:1c12:b0:a63:359b:e5bf with SMTP id a640c23a62f3a-a63359be69cmr333031166b.42.1716993140788;
        Wed, 29 May 2024 07:32:20 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8b9aasm718951466b.155.2024.05.29.07.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:32:20 -0700 (PDT)
Date: Wed, 29 May 2024 17:32:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Christian Marangi <ansuelsmth@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 3/3] leds: leds-lp5569: Add support for Texas
 Instruments LP5569
Message-ID: <1f970609-42fa-4e6d-95d3-7ccdf52d3fee@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527094737.13354-3-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-leds-lp55xx-Add-new-ti-lp5569-compatible/20240527-174959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20240527094737.13354-3-ansuelsmth%40gmail.com
patch subject: [PATCH v3 3/3] leds: leds-lp5569: Add support for Texas Instruments LP5569
config: sparc-randconfig-r071-20240528 (https://download.01.org/0day-ci/archive/20240528/202405280611.QUICzlRj-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405280611.QUICzlRj-lkp@intel.com/

New smatch warnings:
drivers/leds/leds-lp5569.c:378 lp5569_update_program_memory() error: buffer overflow 'pattern' 128 <= 223

vim +/pattern +378 drivers/leds/leds-lp5569.c

ed7ae4f43e228c Christian Marangi 2024-05-27  340  static int lp5569_update_program_memory(struct lp55xx_chip *chip,
ed7ae4f43e228c Christian Marangi 2024-05-27  341  					const u8 *data, size_t size)
ed7ae4f43e228c Christian Marangi 2024-05-27  342  {
ed7ae4f43e228c Christian Marangi 2024-05-27  343  	enum lp55xx_engine_index idx = chip->engine_idx;
ed7ae4f43e228c Christian Marangi 2024-05-27  344  	u8 pattern[LP5569_PROGRAM_LENGTH] = {0};
ed7ae4f43e228c Christian Marangi 2024-05-27  345  	unsigned int cmd;
ed7ae4f43e228c Christian Marangi 2024-05-27  346  	char c[3];
ed7ae4f43e228c Christian Marangi 2024-05-27  347  	int nrchars;
ed7ae4f43e228c Christian Marangi 2024-05-27  348  	int ret;
ed7ae4f43e228c Christian Marangi 2024-05-27  349  	int offset = 0;
ed7ae4f43e228c Christian Marangi 2024-05-27  350  	int page, i = 0;
ed7ae4f43e228c Christian Marangi 2024-05-27  351  
ed7ae4f43e228c Christian Marangi 2024-05-27  352  	while ((offset < size - 1) && (i < LP5569_PROGRAM_LENGTH)) {
ed7ae4f43e228c Christian Marangi 2024-05-27  353  		/* separate sscanfs because length is working only for %s */
ed7ae4f43e228c Christian Marangi 2024-05-27  354  		ret = sscanf(data + offset, "%2s%n ", c, &nrchars);
ed7ae4f43e228c Christian Marangi 2024-05-27  355  		if (ret != 1)
ed7ae4f43e228c Christian Marangi 2024-05-27  356  			goto err;
ed7ae4f43e228c Christian Marangi 2024-05-27  357  
ed7ae4f43e228c Christian Marangi 2024-05-27  358  		ret = sscanf(c, "%2x", &cmd);
ed7ae4f43e228c Christian Marangi 2024-05-27  359  		if (ret != 1)
ed7ae4f43e228c Christian Marangi 2024-05-27  360  			goto err;
ed7ae4f43e228c Christian Marangi 2024-05-27  361  
ed7ae4f43e228c Christian Marangi 2024-05-27  362  		pattern[i] = (u8)cmd;
ed7ae4f43e228c Christian Marangi 2024-05-27  363  		offset += nrchars;
ed7ae4f43e228c Christian Marangi 2024-05-27  364  		i++;
ed7ae4f43e228c Christian Marangi 2024-05-27  365  	}
ed7ae4f43e228c Christian Marangi 2024-05-27  366  
ed7ae4f43e228c Christian Marangi 2024-05-27  367  	/* Each instruction is 16bit long. Check that length is even */
ed7ae4f43e228c Christian Marangi 2024-05-27  368  	if (i % 2)
ed7ae4f43e228c Christian Marangi 2024-05-27  369  		goto err;
ed7ae4f43e228c Christian Marangi 2024-05-27  370  
ed7ae4f43e228c Christian Marangi 2024-05-27  371  	for (page = 0; page < LP5569_PROGRAM_LENGTH / LP5569_BYTES_PER_PAGE; page++) {
ed7ae4f43e228c Christian Marangi 2024-05-27  372  		/* Write to the next page each 32 bytes */
ed7ae4f43e228c Christian Marangi 2024-05-27  373  		lp55xx_write(chip, LP5569_REG_PROG_PAGE_SEL,
ed7ae4f43e228c Christian Marangi 2024-05-27  374  			     LP5569_PAGE_ENG(idx) + page);
ed7ae4f43e228c Christian Marangi 2024-05-27  375  
ed7ae4f43e228c Christian Marangi 2024-05-27  376  		for (i = 0; i < LP5569_PROGRAM_LENGTH; i++) {
ed7ae4f43e228c Christian Marangi 2024-05-27  377  			ret = lp55xx_write(chip, LP5569_REG_PROG_MEM + i,
ed7ae4f43e228c Christian Marangi 2024-05-27 @378  					   pattern[i + (page * LP5569_BYTES_PER_PAGE)]);
                                                                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
i can co up to LP5569_PROGRAM_LENGTH and "page * LP5569_BYTES_PER_PAGE"
can also go up to LP5569_PROGRAM_LENGTH.  So we're 2x beyond the end of
the array.

ed7ae4f43e228c Christian Marangi 2024-05-27  379  			if (ret)
ed7ae4f43e228c Christian Marangi 2024-05-27  380  				return -EINVAL;
ed7ae4f43e228c Christian Marangi 2024-05-27  381  		}
ed7ae4f43e228c Christian Marangi 2024-05-27  382  	}
ed7ae4f43e228c Christian Marangi 2024-05-27  383  
ed7ae4f43e228c Christian Marangi 2024-05-27  384  
ed7ae4f43e228c Christian Marangi 2024-05-27  385  	return size;
ed7ae4f43e228c Christian Marangi 2024-05-27  386  
ed7ae4f43e228c Christian Marangi 2024-05-27  387  err:
ed7ae4f43e228c Christian Marangi 2024-05-27  388  	dev_err(&chip->cl->dev, "wrong pattern format\n");
ed7ae4f43e228c Christian Marangi 2024-05-27  389  	return -EINVAL;
ed7ae4f43e228c Christian Marangi 2024-05-27  390  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


