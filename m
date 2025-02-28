Return-Path: <linux-kernel+bounces-539081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8D2A4A0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C172E7A4068
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938D2512E4;
	Fri, 28 Feb 2025 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeUdm1UR"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E21F4C83
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764463; cv=none; b=t+V3qniD/HTLHVhOgvqfWvfCMtjDXqQX70Nr6+xP9L7vh6YBGCJTAivnvEGMTf2RPYokFIR3E+dVSy0HhySaRG8PGpRx/Zy3f6jlykLi6O1Co9Vy/CNZFKZdJNWtMpwuO7PsHTm3bZu9eqQh+jiOicY8NYXIbrq4659I0a0c/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764463; c=relaxed/simple;
	bh=vyEmjP6QT1vg+OHvd2U/iE+uXcH3049E7GTRmaIcycM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QniRyKv7eEA864+eG+AOHVxNpNU5Zr4YQJtZfyf874W2E2XeOPDA8BHlAp1iGZCfinBlVzoak5KTKnpVrhowc149eCyy0t/q8xBD9tg8ve/MGDH2JTDwEoTRYk2e4hIIEsn7zG8zvkvXruc7esQks+726zjlZbcr1kuH7WaFwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AeUdm1UR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbb12bea54so442571566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740764459; x=1741369259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip181qt97NpbjsJVHc05CWyvCafu17cZ0khXBbAc8es=;
        b=AeUdm1URJdXIdXXhYM/eO8DmSk5SYCqD+EcMrbryW55DlibSv13XvQZt4gtp6SMUlP
         tXy8aew6ImuktM9kfHc8KLo6rG6w3RgxVvq67XSgFiKBtDF4sf/DW0lItCvMpGW8fdeo
         SS2I5QC6pVKKaQYddzL4RX/Q1/gyvSTWoKg8/UGoHRpay/HJQpXCvui5hs19bBD6VEpj
         EKpf0wEJdCodxtyGh2AWYyltWOVfqLMgfJYlE1ya2uLrzFhFQPyM2I2mSCzm+h3AkA6g
         YvDew6vYywVTbjZep42f9/wlwQ70U+igtdGrxpt/yGezs4doFlD2hO0/rhA71cFdkfYM
         GqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740764459; x=1741369259;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ip181qt97NpbjsJVHc05CWyvCafu17cZ0khXBbAc8es=;
        b=wuuKBoXOx54Smt5xHNiLiTgz49mKJ6hxdoRaAkhbLucGF0P682g+GsGP8lSht8rSt5
         XZ4YiFBAbajUuat9MOdJsOqIHpL46pkvoU51AnCeHaju9w2A9KeAREdjWLS1ogs/poBe
         tGTFFyXwRXbzntBDyHNytpEh4xs74TYWvAhuU4kpgleZgcONNn66gvYCbUSJ4XRkabTD
         FbGdHPJDlMjhUYlhXi+09t6aS8XrSr5SMYk/1y7YQ6/PE6ztv5EeZFTal9Gecn1IQfps
         eFhxKC37UdYo5zV+ATjcR3bFQsXOksuQwlFd8PSx2946sQnITg+4patjtw2k5zBTxgOc
         vIPg==
X-Forwarded-Encrypted: i=1; AJvYcCX2k7MellXpRiM7r2ERrsWTRwM9TEX4VyNCsFWVUnfsuK2EAJiPyHI+4L488SdgjZJIjzpWtjhvCkAgZkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJ31oW9Cx/N6U9Eymf3Kg3ToclfvGU1nyBXZKFKXJVwcf80dE
	vYq0/t+iG8NQMMX5Qpd6W1Y2P8dNDooNqEUhMSMcL79iJykLgxtit5l6ezWoGpZJhL4raMkR8yn
	u
X-Gm-Gg: ASbGnct6poKKn4Rr3v9vBO+7qmDT7cAbvLBqOuEDJWtATcoAbF9crWkKEo5QezTF2d1
	Fk4+n7yKVEr+xf3Ro0Gb+7VCJlV4JZnlDdjYCfLyWHOcMSQgBGkAaolKKCyNAksxtGhw8MN+W8s
	R+R6kiV+WlNjrf1V8qEYe7tzPMkcKEAgMrBT+Zq4zLKLCf5vU0R9W29LZnA1ssIh7qjXnsb2K6a
	mjH1dacm9yjFk+SB6+xQXuca4Q5PXsEOhTqvRIbP7HsHV7YdTwgraiV4VhCg2rh4ZLYFo49/nHj
	rf5csnT6P1XQQq1e2ve09fF44V5bOZ0=
X-Google-Smtp-Source: AGHT+IGt23ZU44CPasKpKr9Z8pStmLXmmtwKI9OLxRVbDer6zeXXYLVsD2hcn9AiKlmKYTNu/6MyVA==
X-Received: by 2002:a17:907:3e88:b0:abc:c34:4130 with SMTP id a640c23a62f3a-abf25fdc124mr522480266b.18.1740764459577;
        Fri, 28 Feb 2025 09:40:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c7bb85asm318324266b.162.2025.02.28.09.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:40:59 -0800 (PST)
Date: Fri, 28 Feb 2025 20:40:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Anindya Sundar Gayen <anindya.sg@samsung.com>,
	andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, aswani.reddy@samsung.com,
	pankaj.dubey@samsung.com
Subject: Re: [PATCH] i2c-algo-bit: Added the bus lock during a i2c transaction
Message-ID: <7a7f18e0-1ed2-4258-abd6-5c32f95edc58@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225113314.12353-1-anindya.sg@samsung.com>

Hi Anindya,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anindya-Sundar-Gayen/i2c-algo-bit-Added-the-bus-lock-during-a-i2c-transaction/20250225-201732
base:   https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git i2c/i2c-host
patch link:    https://lore.kernel.org/r/20250225113314.12353-1-anindya.sg%40samsung.com
patch subject: [PATCH] i2c-algo-bit: Added the bus lock during a i2c transaction
config: powerpc-randconfig-r071-20250228 (https://download.01.org/0day-ci/archive/20250228/202502281946.tIwDrE9k-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 204dcafec0ecf0db81d420d2de57b02ada6b09ec)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202502281946.tIwDrE9k-lkp@intel.com/

smatch warnings:
drivers/i2c/algos/i2c-algo-bit.c:385 sendbytes() warn: inconsistent returns 'global &i2c_bus_lock'.

vim +385 drivers/i2c/algos/i2c-algo-bit.c

^1da177e4c3f41 Linus Torvalds       2005-04-16  344  static int sendbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
^1da177e4c3f41 Linus Torvalds       2005-04-16  345  {
494dbb64dc5b36 Jean Delvare         2007-05-01  346  	const unsigned char *temp = msg->buf;
^1da177e4c3f41 Linus Torvalds       2005-04-16  347  	int count = msg->len;
^1da177e4c3f41 Linus Torvalds       2005-04-16  348  	unsigned short nak_ok = msg->flags & I2C_M_IGNORE_NAK;
^1da177e4c3f41 Linus Torvalds       2005-04-16  349  	int retval;
^1da177e4c3f41 Linus Torvalds       2005-04-16  350  	int wrcount = 0;
^1da177e4c3f41 Linus Torvalds       2005-04-16  351  
8eb6c9a270e167 Anindya Sundar Gayen 2025-02-25  352  	/* Aquire the lock before accessing the I2C bus */
8eb6c9a270e167 Anindya Sundar Gayen 2025-02-25  353  	mutex_lock(&i2c_bus_lock);
^1da177e4c3f41 Linus Torvalds       2005-04-16  354  	while (count > 0) {
494dbb64dc5b36 Jean Delvare         2007-05-01  355  		retval = i2c_outb(i2c_adap, *temp);
cf978ab2846d86 David Brownell       2008-01-27  356  
cf978ab2846d86 David Brownell       2008-01-27  357  		/* OK/ACK; or ignored NAK */
cf978ab2846d86 David Brownell       2008-01-27  358  		if ((retval > 0) || (nak_ok && (retval == 0))) {
^1da177e4c3f41 Linus Torvalds       2005-04-16  359  			count--;
^1da177e4c3f41 Linus Torvalds       2005-04-16  360  			temp++;
^1da177e4c3f41 Linus Torvalds       2005-04-16  361  			wrcount++;
bf3e2d1d9b8605 David Brownell       2008-01-27  362  
bf3e2d1d9b8605 David Brownell       2008-01-27  363  		/* A slave NAKing the master means the slave didn't like
bf3e2d1d9b8605 David Brownell       2008-01-27  364  		 * something about the data it saw.  For example, maybe
bf3e2d1d9b8605 David Brownell       2008-01-27  365  		 * the SMBus PEC was wrong.
bf3e2d1d9b8605 David Brownell       2008-01-27  366  		 */
bf3e2d1d9b8605 David Brownell       2008-01-27  367  		} else if (retval == 0) {
bf3e2d1d9b8605 David Brownell       2008-01-27  368  			dev_err(&i2c_adap->dev, "sendbytes: NAK bailout.\n");
bf3e2d1d9b8605 David Brownell       2008-01-27  369  			return -EIO;

mutex_unlock(&i2c_bus_lock);

bf3e2d1d9b8605 David Brownell       2008-01-27  370  
bf3e2d1d9b8605 David Brownell       2008-01-27  371  		/* Timeout; or (someday) lost arbitration
bf3e2d1d9b8605 David Brownell       2008-01-27  372  		 *
bf3e2d1d9b8605 David Brownell       2008-01-27  373  		 * FIXME Lost ARB implies retrying the transaction from
bf3e2d1d9b8605 David Brownell       2008-01-27  374  		 * the first message, after the "winning" master issues
bf3e2d1d9b8605 David Brownell       2008-01-27  375  		 * its STOP.  As a rule, upper layer code has no reason
bf3e2d1d9b8605 David Brownell       2008-01-27  376  		 * to know or care about this ... it is *NOT* an error.
bf3e2d1d9b8605 David Brownell       2008-01-27  377  		 */
bf3e2d1d9b8605 David Brownell       2008-01-27  378  		} else {
bf3e2d1d9b8605 David Brownell       2008-01-27  379  			dev_err(&i2c_adap->dev, "sendbytes: error %d\n",
bf3e2d1d9b8605 David Brownell       2008-01-27  380  					retval);
bf3e2d1d9b8605 David Brownell       2008-01-27  381  			return retval;

And here too.

^1da177e4c3f41 Linus Torvalds       2005-04-16  382  		}
^1da177e4c3f41 Linus Torvalds       2005-04-16  383  	}
8eb6c9a270e167 Anindya Sundar Gayen 2025-02-25  384  	mutex_unlock(&i2c_bus_lock);
^1da177e4c3f41 Linus Torvalds       2005-04-16 @385  	return wrcount;
^1da177e4c3f41 Linus Torvalds       2005-04-16  386  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


