Return-Path: <linux-kernel+bounces-311212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D331E96861F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0041F1C229DF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B13C184559;
	Mon,  2 Sep 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hdn7015D"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFEB186E20
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276199; cv=none; b=nVQNJXd9mwSExZ3QNLhvxIkZrUZZ9JBWTYg80et77gqbIfzNJuW5GT2s53GkCzgVZ6hHanUGanS3bKSw7xhyhOBdzvxrmtle73URJCwfK83uDtcwBXX9FeCyEelnDKvNLRZvc+JCto83zgbJ8J8wpDmp6TpMa7Rk00ApjOrEe98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276199; c=relaxed/simple;
	bh=FpetsQ5I1CDSi8wtSlI1e+AMgn3cH3BIUkkDyXHtNqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nx+g5krPGjkrsjjPxpt0/MWhPHQoxVRsMGUdIO7dUCSslSPDJ8McP6hy437bs3j8K8bqQWddTHNBtchUWIZlWqZ8WWnzAllWPB4fZkxCCONt6+oXjhPIX9NtLBUxN9sZBnhGkW3ZSWf4BEOQzH+Z+TAavRVhXApo8zXX7qAMLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hdn7015D; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bbe908380so22911655e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725276196; x=1725880996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEt0+dc1LSyQIyl13xdTGJyLQn3oDUp5kW96ysZGY3w=;
        b=Hdn7015D56Nf+JeGukbWYVq5bUoemRNSQ5CMziew+iaNawQJ3koZw1RnfvVtzw2Lav
         k+R4rz278AYM6tP7jMQui6ldRa6WK529CskU9tyzxbD5h5Wvfx/2wIvL/sa98LyetwOE
         fphxUzD+1ZrZJOgvYvbY+fRShB/K9IPNfvKmpXCfge4XONHOT1ar8Zp4xTP1IO+RjB3h
         XbcAH/9irEo46/Mz9EH69o0rtqcnmv9jyOP9VnzowLbIeqTm96L6yV7G22f28Cep7Z5t
         UUck9bkPaNN5KTOD/AcrLgIHhU3LdJIsOCucquc0Vp08dV+ttbCL1eEuT84Y3D9nLiZe
         T83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725276196; x=1725880996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEt0+dc1LSyQIyl13xdTGJyLQn3oDUp5kW96ysZGY3w=;
        b=MX4vzCoLqP1t9X6pHh+l9pZJ6dTRwhTNhKKMSpQaqCsXxDdAB1wHog0t862rJyEFdf
         2V1KrlrGCIOQEKqs06He1Vc0pmH9Zm9yhFTGM5WSGhF4vt9UBPhMt29VYcTpXI4EYwMj
         gv3axME7EtKjlrQJ5p72LL5zIAgwWW6BHj0JlPLglZ9HYe+wnQYux9qlMaJRmxUxr9yB
         RyIG43EAMg47Rp5CtpZvVfe3dQsaQYk4SfDpIUHiFXKYDRtwUDJlhbTXyITXAG0Q9pt9
         Q8u/lSOEG2SLnJjYhr4HwP5IO+hhS9QC0oRLEjWMyka6MzChSuX5F8e5bsO4eiXAmXqo
         w1oA==
X-Forwarded-Encrypted: i=1; AJvYcCU4FQsVhM/exPt89Zhe+7+gIW8RyOILB2EyRD3aNr9UP5oSy15aCdz3PVATNF89ZANv3h0ekKU+jNIas2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpbSajuUeAOBv0isF6QDZeNv01vrMGgMaY7BXJdlW9FJ2W6TFT
	JkwdDzkUxRzJbYt8wi90zPPYvwnRB4HV1tt6R/WNn1Od/ZahcTrEsF/73snhS00=
X-Google-Smtp-Source: AGHT+IFxJcCTvoMwpH+tvEwVOkWpvLSMuNdbuHPGieP5ISOoCAVIM3ROhsGt3PZ8voU2RxcgHG86EQ==
X-Received: by 2002:a05:600c:4452:b0:428:1090:cfd4 with SMTP id 5b1f17b1804b1-42be48faa4emr44328095e9.33.1725276196265;
        Mon, 02 Sep 2024 04:23:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42baf1b0c18sm151736775e9.37.2024.09.02.04.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:23:15 -0700 (PDT)
Date: Mon, 2 Sep 2024 14:23:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: oe-kbuild@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 2/4] platform/x86: int3472: Simplify dev_err_probe()
 usage
Message-ID: <6be0acdb-6b4a-4330-929a-2e319075b3c6@stanley.mountain>
References: <20240822130722.1261891-3-andriy.shevchenko@linux.intel.com>
 <20dd56f0-78ea-4255-86ac-32151160b83d@stanley.mountain>
 <ZtWQzwvo7f0QfeCI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtWQzwvo7f0QfeCI@smile.fi.intel.com>

On Mon, Sep 02, 2024 at 01:17:51PM +0300, Andy Shevchenko wrote:
> On Sat, Aug 31, 2024 at 11:31:53AM +0300, Dan Carpenter wrote:
> > Hi Andy,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/driver-core-Ignore-0-in-dev_err_probe/20240826-113856
> > base:   driver-core/driver-core-testing
> > patch link:    https://lore.kernel.org/r/20240822130722.1261891-3-andriy.shevchenko%40linux.intel.com
> > patch subject: [PATCH v2 2/4] platform/x86: int3472: Simplify dev_err_probe() usage
> > config: i386-randconfig-141-20240830 (https://download.01.org/0day-ci/archive/20240831/202408310807.sNPe5Mr2-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202408310807.sNPe5Mr2-lkp@intel.com/
> > 
> > smatch warnings:
> > drivers/platform/x86/intel/int3472/discrete.c:292 skl_int3472_handle_gpio_resources() error: uninitialized symbol 'err_msg'.
> > drivers/platform/x86/intel/int3472/discrete.c:292 skl_int3472_handle_gpio_resources() warn: passing zero to 'dev_err_probe'
> 
> Okay, I might agree on the err_msg, which is good to have to be passed anyway.
> In such a case it might be good to have a dev_dbg() in the dev_err_probe() to
> say that it is likely a bug in the code.
> 
> Would you accept that approach?

ret is 1.  We have to revert this patch.

regards,
dan carpenter


