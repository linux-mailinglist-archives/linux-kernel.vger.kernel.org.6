Return-Path: <linux-kernel+bounces-200341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B2A8FAEA1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350EEB21339
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ED0143888;
	Tue,  4 Jun 2024 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEDnmrOp"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5C137936
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492914; cv=none; b=QS/e/daJgWA6p0bQWkSbC3DSkgBHG4c/DFjo7fET/U2t+mIWtk+TzRdHXs0OD2RRKLZNrXBpNeUArrUw3k54Of4ZkQcmSUdGlXql5/VbCniDdwAtxApnNNwncjuHFAvY4P6GSnwGzIw4OI/wcBfWmPNqdTyNMb+9sONlXWPAqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492914; c=relaxed/simple;
	bh=WsyvWG2yV+idBf9tbl4bFm3p4pGciThaH/I+ZywwKHA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OSoHwg1BcjnKmR7hZfc3nZSMYxkyYYWO/arG6dCQ2ifhoKRWrjDfz9cW+7mYTjvGOpnfCykU3w+Ry2s3Aj33cWsErPbyVACkhACyOEcU90zkrixWI69pS2EZhElpncWmM91HdNOuC/r6b/K/BCJfaSs2xw58BZleyFxKO+bWh5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rEDnmrOp; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso1061755a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717492910; x=1718097710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5T+9FltYwCRJsWCrzY8gXQ3PI2wIWCw8VRf/aXR0eE=;
        b=rEDnmrOpjfyBt+hG3xRqyIhWyZnI6htj8gv8TzJT3rfEHvFz5MKVkMkffSebFBstL2
         GrjQoIikquUfCQGY6UXCNvjlb/4FR9T7DkQouWt1MqMxzOAH4YoyAS+RXopkxAo6Tvrs
         WY0mssDseDJY0MxVjIYHMmWuMAkzkVND4lbEYo6cyr2ejYyoCP4FRx9wl3R0yJx7pmBF
         n9JNUuMx6jcP/QkZ2AkYHvKdGCJXXA6i1T64Q7rmBM48hTcMZhio2EPYkWab3AQ2ogjk
         3px9yUfUr3CLlJCauMVHbfJD6wFlpn/2jwNAVzlSTSP3FGafdwnyQchjHFKGIRiHv2rl
         UIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492910; x=1718097710;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5T+9FltYwCRJsWCrzY8gXQ3PI2wIWCw8VRf/aXR0eE=;
        b=XUhNYHA1XfWURqsF2kDcLVnJlxzXq0+p+nBTMToyel4HQSWlm8ukX/q6v3G5+TnFMT
         8ZAGr2NmJHukdU1Q1qecMl6riAAGcds+BvPmQ26fHwwd7FPicqRbQeTiW+QWq6QNFD0g
         fQdmw7D6+yE8xI1isJSwJvRatQFqnmZPxPKPg4pMfuWNiRK00LnEmRn8/QhHthhJsmKB
         uBT1aJIh2DLkXPd5ffBqlhL1XK6MZz9YGFUyFoJG7EesN0pLhedzH70eIo3mq3yvxZQ2
         8k+coKYuh8RUp4H73Ue0uSppL1CqA7wGDHXbW0yLitR5in7baJGCr+qHIz7nMHn6d8CE
         aF5g==
X-Forwarded-Encrypted: i=1; AJvYcCUNZL8kUkfxqNtOlk6rRAbmN9O4Ntz42MQNQIMEogLrJCkawTEETVc//TLl7aDlJfVWSC8E3xXjqmGr0Y7USScVVd/mtF1i1YVSoHQV
X-Gm-Message-State: AOJu0Yx/XVQBAyMvx+S2o1DF/V3JanHsHYksuIZZxF9XhRmQgc1habxP
	uGPmUWyXp6IYSmrbifOw1xs50TNORgxFq4nQ7Hf3OqTRcg5z1Ev4Tow/I050g90=
X-Google-Smtp-Source: AGHT+IF/1rFz/j9iytXx8jWDqKGDaJxuS30o8xQOuHWmR4YJnzerTlbRW7XMfrBEdC7TOHEGQb2AaQ==
X-Received: by 2002:a17:907:26ca:b0:a65:7643:3849 with SMTP id a640c23a62f3a-a68224493ffmr947305166b.73.1717492909385;
        Tue, 04 Jun 2024 02:21:49 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6911e3676dsm245378766b.88.2024.06.04.02.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:21:49 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:21:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Witold Sadowski <wsadowski@marvell.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, broonie@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, pthombar@cadence.com,
	Witold Sadowski <wsadowski@marvell.com>
Subject: Re: [PATCH v7 4/4] spi: cadence: Add MRVL overlay xfer operation
 support
Message-ID: <096b0aa3-47b1-48f8-a0ed-89458506b7b7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529220026.1644986-5-wsadowski@marvell.com>

Hi Witold,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Witold-Sadowski/spi-dt-bindings-cadence-Add-Marvell-overlay-bindings-documentation-for-Cadence-XSPI/20240530-060250
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240529220026.1644986-5-wsadowski%40marvell.com
patch subject: [PATCH v7 4/4] spi: cadence: Add MRVL overlay xfer operation support
config: powerpc64-randconfig-r071-20240531 (https://download.01.org/0day-ci/archive/20240602/202406020007.yDo5EI4r-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406020007.yDo5EI4r-lkp@intel.com/

New smatch warnings:
drivers/spi/spi-cadence-xspi.c:955 cdns_xspi_stig_ready() warn: signedness bug returning '(-110)'
drivers/spi/spi-cadence-xspi.c:967 cdns_xspi_sdma_ready() warn: signedness bug returning '(-110)'

vim +955 drivers/spi/spi-cadence-xspi.c

66e19aa5a2e022b Witold Sadowski 2024-05-29  951  static bool cdns_xspi_stig_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
66e19aa5a2e022b Witold Sadowski 2024-05-29  952  {
66e19aa5a2e022b Witold Sadowski 2024-05-29  953  	u32 ctrl_stat;
66e19aa5a2e022b Witold Sadowski 2024-05-29  954  
66e19aa5a2e022b Witold Sadowski 2024-05-29 @955  	return readl_relaxed_poll_timeout
66e19aa5a2e022b Witold Sadowski 2024-05-29  956  		(cdns_xspi->iobase + CDNS_XSPI_CTRL_STATUS_REG,
66e19aa5a2e022b Witold Sadowski 2024-05-29  957  		ctrl_stat,
66e19aa5a2e022b Witold Sadowski 2024-05-29  958  		((ctrl_stat & BIT(3)) == 0),
66e19aa5a2e022b Witold Sadowski 2024-05-29  959  		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
66e19aa5a2e022b Witold Sadowski 2024-05-29  960  		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);

This works but from the name you would expect it to return true when
it's ready and false when it's not.

66e19aa5a2e022b Witold Sadowski 2024-05-29  961  }
66e19aa5a2e022b Witold Sadowski 2024-05-29  962  
66e19aa5a2e022b Witold Sadowski 2024-05-29  963  static bool cdns_xspi_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
66e19aa5a2e022b Witold Sadowski 2024-05-29  964  {
66e19aa5a2e022b Witold Sadowski 2024-05-29  965  	u32 ctrl_stat;
66e19aa5a2e022b Witold Sadowski 2024-05-29  966  
66e19aa5a2e022b Witold Sadowski 2024-05-29 @967  	return readl_relaxed_poll_timeout
66e19aa5a2e022b Witold Sadowski 2024-05-29  968  		(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
66e19aa5a2e022b Witold Sadowski 2024-05-29  969  		ctrl_stat,
66e19aa5a2e022b Witold Sadowski 2024-05-29  970  		(ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
66e19aa5a2e022b Witold Sadowski 2024-05-29  971  		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
66e19aa5a2e022b Witold Sadowski 2024-05-29  972  		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
66e19aa5a2e022b Witold Sadowski 2024-05-29  973  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


