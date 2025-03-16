Return-Path: <linux-kernel+bounces-562947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986D7A63505
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F413A6D03
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19819E998;
	Sun, 16 Mar 2025 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCkn3x9W"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76CEA933
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742121141; cv=none; b=sAIcq+NlImDOpKzbKe7UVZxcsXzA14otyAu9meSwpmrno8ttQgn7FlzuG78sizuPnWGUJ20ccJuzdsuTP6q4pw729J5TNyxpFjI+I72ttPvDyam/9h+DxNTZz33HquZ3gXCoQnLctCe0e+JGtkjPdys/9Cj/+BKexzhC18Meqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742121141; c=relaxed/simple;
	bh=rrZy0viAniqPbhoR+1hQ7ijtZ9CkDKXykVMVhgwnyzA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oUP9Nh63tIT2Ye/F/cyrSoo1y4zKiPGtOPVDX4wO2ZbgWJQ8BJQrwCjJtrY30QIv2w9+FIqF89SarSH4L1A101w0SUjF/uqAhJArahkqljDrLVSL3ERebU0J0UXpOci1NvVVgbPdntYZLrOf+mOJz4qNW+IITZMXQ196/nPx2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VCkn3x9W; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913b539aabso2212938f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742121137; x=1742725937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbB3Zun3gDrzT2BzlBXVO8tDPzz0kaoZWWFSKmDuYmw=;
        b=VCkn3x9WOV9Nld35bfal9VJQgKLUdvQISx+UjrioEuyOkI8V/6V4FR/Ug1wP+6yS8P
         rMfs1uitVSY3WHIJ1hBQXQNtUSYGsupVR++JnDPMT4XyLy6Bajc/u5h6lBHJwFtufqLv
         c6ugKn6yP9SPfOOsZvVCZD5KHV/Oz8MCNAeiGe9icl5U0nX/lgkGPo70amlQLmxH7AZ8
         RQtqGdaJ5THD23ONWnAT7K4AW+YwogVGOPPC70zQLDXOBx+880CmEqSCPYAJDWcKx7Ea
         wQlHSQllWPqkWvV3h2b9e+Luz0L49UkiK1HhUaC0UcrfD5dYVP875J+ZR0yG/lXChgoY
         pCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742121137; x=1742725937;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbB3Zun3gDrzT2BzlBXVO8tDPzz0kaoZWWFSKmDuYmw=;
        b=dKakff4g8Oc493brAeMJlAKWYK1Ch0e+MfsuqkrVgG6K3K9y0duQEfCfq1Bj1bKZkK
         aHSkIcJiiNBN0c+xy5r/iA+7OsT5l04ufeDpzHmTNduw57xKh+J+Wu9TT4xT8jKez8SY
         cj68tauDiomjQqTFGkIKjg/hnJ6UC/p+/byTBfZr4F+l10mMjhuic8k5jl43KyrVvRDA
         GIIH+wtp+iJrjs6pLAFZP/1h70Gr6PwSlmcURYl9p/U2Tn3z+QZEVt7BSJTCyAF14g/1
         xCawqtlrzoQ40v6iHFsUqpiV6E3MaqRbbz9hVWZoq7VU4TEaJb2YGCF/yF0d2W8FTrv/
         pSpw==
X-Forwarded-Encrypted: i=1; AJvYcCWZeNCkm8lS0GXDtAzzmUfhnn3V6TlArbXifNwhbxEhEraFY0I6ooS9IYgN9vh6HY7OK49sHoDq1YNEScE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxfKlQ0Q9u1rw5zgENAvqqWPCLKMdCLlKaDu2ayaYCrai2Claw
	7ef/b73ce9B4SWjHceFxQNmsxpsieMEPd6BhNuxDT1QHERtLWU1DfoXb48dd7bA=
X-Gm-Gg: ASbGnctBBD8VZhvXeRnCpCZ8ihHksK0aVV6ccVHwNCVxH4QJdSg0rNAya8KsjrmRzrt
	h0E9JrlvCtcKNC1g8eWxv8aXlHey/pwyyOl7kzIAO2p480dgPWk9ER9rGIZYQD1z/0NX1cac7G/
	ATReEWdXx3lXZV9oo1S2soJj9S5rHj9B9+5keOXfOypsm2YO/tELZnQwq+RRywEusAB9Gy76U0R
	j2sNFlPcKg4U8rtKLsJa9OFZXY75zof0ivLmkcunjaMET/4Ivp6MZybiXwLBVUXxQyP3BacAYpw
	J+FyoX+dhohVFZ71Zo4nwqJFRpjS/6zwiPlOH1iB2QLhRhnJlA==
X-Google-Smtp-Source: AGHT+IGPUH+kPc//pK+nbCVSTVrqoPbY9VyOj+oM6MVV21R+0n68FEr8K6JofP1y8x4JU00kKq6+Og==
X-Received: by 2002:adf:c790:0:b0:391:41fb:89ff with SMTP id ffacd0b85a97d-3971f60b104mr9360022f8f.27.1742121137018;
        Sun, 16 Mar 2025 03:32:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c888152dsm11459147f8f.48.2025.03.16.03.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 03:32:16 -0700 (PDT)
Date: Sun, 16 Mar 2025 13:32:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, corbet@lwn.net,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 1/4] iio: adc: ad4000: Add support for SPI offload
Message-ID: <0658073a-059b-417a-aafc-c83651e922cf@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301fc83a961c4a2ef2ac980d0baa83d9d89a88c5.1741970538.git.marcelo.schmitt@analog.com>

Hi Marcelo,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/iio-adc-ad4000-Add-support-for-SPI-offload/20250315-012316
base:   af94f401e26f686f7391ce79b38a6129417c22dc
patch link:    https://lore.kernel.org/r/301fc83a961c4a2ef2ac980d0baa83d9d89a88c5.1741970538.git.marcelo.schmitt%40analog.com
patch subject: [PATCH v1 1/4] iio: adc: ad4000: Add support for SPI offload
config: parisc-randconfig-r072-20250316 (https://download.01.org/0day-ci/archive/20250316/202503161513.yeRBTxjg-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503161513.yeRBTxjg-lkp@intel.com/

New smatch warnings:
drivers/iio/adc/ad4000.c:862 ad4000_spi_offload_setup() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +862 drivers/iio/adc/ad4000.c

e74205e82803041 Marcelo Schmitt 2025-03-14  846  static int ad4000_spi_offload_setup(struct iio_dev *indio_dev,
e74205e82803041 Marcelo Schmitt 2025-03-14  847  				    struct ad4000_state *st)
e74205e82803041 Marcelo Schmitt 2025-03-14  848  {
e74205e82803041 Marcelo Schmitt 2025-03-14  849  	struct spi_device *spi = st->spi;
e74205e82803041 Marcelo Schmitt 2025-03-14  850  	struct device *dev = &spi->dev;
e74205e82803041 Marcelo Schmitt 2025-03-14  851  	struct dma_chan *rx_dma;
e74205e82803041 Marcelo Schmitt 2025-03-14  852  	int ret;
e74205e82803041 Marcelo Schmitt 2025-03-14  853  
e74205e82803041 Marcelo Schmitt 2025-03-14  854  	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
e74205e82803041 Marcelo Schmitt 2025-03-14  855  							   SPI_OFFLOAD_TRIGGER_PERIODIC);
e74205e82803041 Marcelo Schmitt 2025-03-14  856  	if (IS_ERR(st->offload_trigger))
e74205e82803041 Marcelo Schmitt 2025-03-14  857  		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
e74205e82803041 Marcelo Schmitt 2025-03-14  858  				     "Failed to get offload trigger\n");
e74205e82803041 Marcelo Schmitt 2025-03-14  859  
e74205e82803041 Marcelo Schmitt 2025-03-14  860  	ret = ad4000_set_sampling_freq(st, st->max_rate_hz);
e74205e82803041 Marcelo Schmitt 2025-03-14  861  	if (ret)
e74205e82803041 Marcelo Schmitt 2025-03-14 @862  		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),

s/PTR_ERR(st->offload_trigger)/ret/

e74205e82803041 Marcelo Schmitt 2025-03-14  863  				     "Failed to set sampling frequency\n");
e74205e82803041 Marcelo Schmitt 2025-03-14  864  
e74205e82803041 Marcelo Schmitt 2025-03-14  865  	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
e74205e82803041 Marcelo Schmitt 2025-03-14  866  	if (IS_ERR(rx_dma))
e74205e82803041 Marcelo Schmitt 2025-03-14  867  		return dev_err_probe(dev, PTR_ERR(rx_dma),
e74205e82803041 Marcelo Schmitt 2025-03-14  868  				     "Failed to get offload RX DMA\n");
e74205e82803041 Marcelo Schmitt 2025-03-14  869  
e74205e82803041 Marcelo Schmitt 2025-03-14  870  	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
e74205e82803041 Marcelo Schmitt 2025-03-14  871  							  IIO_BUFFER_DIRECTION_IN);
e74205e82803041 Marcelo Schmitt 2025-03-14  872  	if (ret)
e74205e82803041 Marcelo Schmitt 2025-03-14  873  		return dev_err_probe(dev, ret, "Failed to setup DMA buffer\n");
e74205e82803041 Marcelo Schmitt 2025-03-14  874  
e74205e82803041 Marcelo Schmitt 2025-03-14  875  	return 0;
e74205e82803041 Marcelo Schmitt 2025-03-14  876  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


