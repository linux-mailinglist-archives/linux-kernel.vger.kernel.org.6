Return-Path: <linux-kernel+bounces-442696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB119EE071
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8471D167855
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3C20B201;
	Thu, 12 Dec 2024 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAdJQsiJ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3520ADF3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733989473; cv=none; b=Iuyh9kYQK9dfyX3P3owWGvp2MIZvx00wPGwz2anp1bkBq4rHLhQFV3G0N6LQBTC7Yt4cw3ZDMcJXPwCXtUQoCpBNSHj/KdL5s93CKzk9Lur6pI4pnl0bUwpnQ13PhFmfv0KSxcL0Q60GnGaaqJHwk7U1Ki4UY91syU5Bc3S0w9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733989473; c=relaxed/simple;
	bh=aa1sjAc36pQTBINH5+XkznFw1PVthGF/6LeesuAsfGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XGENNvi2FGDwGugQlghp6ucOThH42MciP7Q/Fqdy470fktmaEeYfyh4ywrg4arFB6UscIyG6xwaehTuYT4VSIgnzAtT8E058qNATNYZNwcb/FKeBOUkh60m8UjhtBvpL4smHkDEUZRsInbJGV1Qeld27P7hLxg9JdVCgLu+FPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAdJQsiJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso212205f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733989469; x=1734594269; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvox4XeB3afkXlBEWKa2zsXp6ZSE/fQTwV3mqwfswDA=;
        b=CAdJQsiJwPVnTP6n8bf/yCoxV5JnauCC2umfj9Jzd+DG1aGcjpR/TaUbZXk8uMkPlw
         xgMg6JrYrx93lDRsZ8nYyGSOLIv83Q0YO5iJw1QyZBERjYVK+eKqg6S5hP2mTg+CZRwh
         xOoy7jkzQfqfCNG1/mXDbJnMLzDxf4FHyDXrz04RJyv8fvEtJtQObgDsYpdmv8pOhjel
         cMsHF4BtUImimKer5Nl8PHJcvW3FheJJr7fFFGBw2b28LKjZN9iFYDHNsPImuspZD+Dm
         1rYORoo2n+WWekfoUifj08JSFe38chDu36T3fJxJpSd1AZB4mEihHkmqMHytHQduMhnR
         DUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733989469; x=1734594269;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvox4XeB3afkXlBEWKa2zsXp6ZSE/fQTwV3mqwfswDA=;
        b=jzMjS/6rj9ovagzXndSw2GZEQSyOor+MIKLw/iYgGyLSETapUjB5ZGDbMy0DUDAl7R
         uOM5HdmAR1tTPHHMBD1QjnX1/sCWn4bq0ECvCQVrirOIzoMTaY6iY45SfKn0LJKi4dG+
         hG+oh/VXHJZAhEpdQpCwmsceLWmWmfDBPzuVmOBkkPfS1PTx/fifA+d2MzulFpjUJbai
         SmWk4Jm+2trD+5KM9uDYFxIIVltYR8UZpl/1F2llmcXBSRWKv+0vh8LSbLlji7uxlxmn
         596DK6ircoY00aspD9yzAWoizDPB39DNT477ofR5Sgh73dxB3gWisAgYM2DE24OOkYke
         0Dtg==
X-Forwarded-Encrypted: i=1; AJvYcCXVsqeGj1GjWDOLtPzA2H6wPgbQkkuEEaFrFSyr6HUF/D0+rghFFZhJqtmS+v08+6XCqUB2rfqWj2S4zA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNnZv4KZ3SfhQbHLEZY0MmilZQsPS54oVe4hYS/XfaL2MPPYRH
	iYb51YF5jvb+P6i0xn5uNgd54eqjwTQzTw890kiX3v+h/VcFLlayDgTRJxdt5uE=
X-Gm-Gg: ASbGncsL1Xuny7ziFbXaFsDrPP8oN46fNEpyZV026p3SqLcK3+OeZcsmx5n9Nf+115R
	I/wHavBi0Tu8fYdJbkEEdg62G663KKe//Y1WmQQ+8ABRW/QafkN9w3RsMoJpi1hBZNnGyxtNR8r
	a3h3Ry75LQ0bVWVg45TISjAt4HEOyFtZQI+BVJ9ucsiLWWvUzBJAiafCv+sC47Ntz73z/DA2cSA
	Y6+xhRjQn0P0NNF76pHeOGWOMOjD1u+Ys65vd8tRbPawp8is0wDVc4pKU+wEg==
X-Google-Smtp-Source: AGHT+IG3fGL/3aSUn9Mp4roKW2nBfW9qWEnTBniFgc9EdBcwQ+q9RgrsOjP6Paz/BxGO0h7Xp+/5mA==
X-Received: by 2002:a05:6000:18a7:b0:385:dc45:ea22 with SMTP id ffacd0b85a97d-3864cec708fmr5575889f8f.39.1733989469324;
        Wed, 11 Dec 2024 23:44:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514c06sm3263022f8f.73.2024.12.11.23.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:44:28 -0800 (PST)
Date: Thu, 12 Dec 2024 10:44:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: drivers/nvmem/zynqmp_nvmem.c:123 zynqmp_efuse_access() error:
 uninitialized symbol 'ret'.
Message-ID: <c8c9dc57-2496-4917-898d-dce892f85f6f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
commit: 737c0c8d07b5f671c0a33cec95965fcb2d2ea893 nvmem: zynqmp_nvmem: Add support to access efuse
config: arm64-randconfig-r072-20241210 (https://download.01.org/0day-ci/archive/20241212/202412121555.Fp663tyH-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412121555.Fp663tyH-lkp@intel.com/

smatch warnings:
drivers/nvmem/zynqmp_nvmem.c:123 zynqmp_efuse_access() error: uninitialized symbol 'ret'.

vim +/ret +123 drivers/nvmem/zynqmp_nvmem.c

737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   59  static int zynqmp_efuse_access(void *context, unsigned int offset,
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   60  			       void *val, size_t bytes, enum efuse_access flag,
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   61  			       unsigned int pufflag)
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   62  {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   63  	struct device *dev = context;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   64  	struct xilinx_efuse *efuse;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   65  	dma_addr_t dma_addr;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   66  	dma_addr_t dma_buf;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   67  	size_t words = bytes / WORD_INBYTES;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   68  	int ret;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   69  	int value;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   70  	char *data;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   71  
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   72  	if (bytes % WORD_INBYTES != 0) {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   73  		dev_err(dev, "Bytes requested should be word aligned\n");
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   74  		return -EOPNOTSUPP;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   75  	}
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   76  
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   77  	if (pufflag == 0 && offset % WORD_INBYTES) {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   78  		dev_err(dev, "Offset requested should be word aligned\n");
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   79  		return -EOPNOTSUPP;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   80  	}
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   81  
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   82  	if (pufflag == 1 && flag == EFUSE_WRITE) {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   83  		memcpy(&value, val, bytes);
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   84  		if ((offset == EFUSE_PUF_START_OFFSET ||
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   85  		     offset == EFUSE_PUF_MID_OFFSET) &&
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   86  		    value & P_USER_0_64_UPPER_MASK) {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   87  			dev_err(dev, "Only lower 4 bytes are allowed to be programmed in P_USER_0 & P_USER_64\n");
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   88  			return -EOPNOTSUPP;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   89  		}
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   90  
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   91  		if (offset == EFUSE_PUF_END_OFFSET &&
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   92  		    (value & P_USER_127_LOWER_4_BIT_MASK)) {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   93  			dev_err(dev, "Only MSB 28 bits are allowed to be programmed for P_USER_127\n");
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   94  			return -EOPNOTSUPP;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   95  		}
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   96  	}
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   97  
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   98  	efuse = dma_alloc_coherent(dev, sizeof(struct xilinx_efuse),
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24   99  				   &dma_addr, GFP_KERNEL);
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  100  	if (!efuse)
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  101  		return -ENOMEM;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  102  
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  103  	data = dma_alloc_coherent(dev, sizeof(bytes),
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  104  				  &dma_buf, GFP_KERNEL);
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  105  	if (!data) {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  106  		ret = -ENOMEM;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  107  		goto efuse_data_fail;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  108  	}
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  109  
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  110  	if (flag == EFUSE_WRITE) {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  111  		memcpy(data, val, bytes);
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  112  		efuse->flag = EFUSE_WRITE;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  113  	} else {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  114  		efuse->flag = EFUSE_READ;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  115  	}
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  116  
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  117  	efuse->src = dma_buf;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  118  	efuse->size = words;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  119  	efuse->offset = offset;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  120  	efuse->pufuserfuse = pufflag;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  121  
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  122  	zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);

In this .config the zynqmp_pm_efuse_access() is stubbed out so ret isn't
initialized.

737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24 @123  	if (ret != 0) {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  124  		if (ret == EFUSE_NOT_ENABLED) {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  125  			dev_err(dev, "efuse access is not enabled\n");
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  126  			ret = -EOPNOTSUPP;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  127  		} else {
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  128  			dev_err(dev, "Error in efuse read %x\n", ret);
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  129  			ret = -EPERM;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  130  		}
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  131  		goto efuse_access_err;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  132  	}
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  133  
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  134  	if (flag == EFUSE_READ)
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  135  		memcpy(val, data, bytes);
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  136  efuse_access_err:
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  137  	dma_free_coherent(dev, sizeof(bytes),
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  138  			  data, dma_buf);
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  139  efuse_data_fail:
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  140  	dma_free_coherent(dev, sizeof(struct xilinx_efuse),
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  141  			  efuse, dma_addr);
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  142  
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  143  	return ret;
737c0c8d07b5f67 Praveen Teja Kundanala 2024-02-24  144  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


