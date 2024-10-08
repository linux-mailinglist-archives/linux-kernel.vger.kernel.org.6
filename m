Return-Path: <linux-kernel+bounces-355376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A899516F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FD4285262
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583D81DF997;
	Tue,  8 Oct 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QT01KvKG"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C781DF98E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397396; cv=none; b=GLTHLAdFx5jy/wHvK4zfyQPmO3GwYwSByPlNhaq+RJdXIWbMc1MaUPwdR3hmfyXm5JPQ5DHa/s6vFZIkueswKEqwnnK5tdhnLR8ae4XoLm2ANUoEU+LH4B+B0cDjL+mFtijuJDv3aGxpz7wmvGqDeQubgJG9B3Yxz1EZIkePfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397396; c=relaxed/simple;
	bh=oovhDjQ+h+tGiTzVPs+Bd3Ctyp+vKbNtabnaRMLZ0MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKnanusOW7F7uLYrB/+akl2x4coitH2zhpnyCMGvZ9wgOQYYAShTy4ySljxmzl3w51M9SsxBEe2ZecPSpy7MJwo6qsZvPToKLd4jU8IEtbeONOvrYJsWE46AyQedHNJMjaH/cBfzU4uAgHhG2PA91e9X8MimoOe1tIQopgBrIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QT01KvKG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso4213183a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728397394; x=1729002194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3s0y0U4U/zNTntZ4JNtG+dOk0GuXy1+AAJizNLWCVpk=;
        b=QT01KvKG2prqrjJs4f+XFzFhxsReuJ3NlXP0O4SB0RxgfjaQu7tAWSWGVcBMfxFiFi
         HxrMjmW7lMZzmGl9QGIRNh3stx6SqFQv9z/nm6poARNynL3LhAZZC1w4m6kJoLdUdOkX
         4wY7rlnyFu5k28z2OG354pwZ/mDyt79FQUPgCOot69YR5NF8sZ+7mYuNjkp3EQ+eYG1P
         +hOTerq12mXrBYLHCbVQzzqUE5LiBJyY5aBfdvdXjgwQrAzRyOY7E0b8WM2UXULPPGya
         9XlDKvb9Z4Wq4jN0JMOFcY1ke5kPmPL/R4IWjy5zlxsKlM5a60wGR3Toj9+rbjoLd2IN
         xVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397394; x=1729002194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3s0y0U4U/zNTntZ4JNtG+dOk0GuXy1+AAJizNLWCVpk=;
        b=esYTJynW1mcOjePiSMsSNLw+z/e62LznKIPH8y10MjghPlB7xIzNNrGe1HT2UBA4tY
         1nnzHTFbIC6V7ceE/3vcfb6BmDh28AlIO2C92XRlNCp4fo0HlXUOdeIyMsLwTbqSL4nh
         H/Gb5pHdxAtfrgf8dic2hRMbBbuiRue3ARsrYGog05B/JpXe4kYgWo38uYaLdOB/ZEKV
         LZ/0OOlvqnWPVH/FDoNcywKx9YWmdkj4K0XWzCxWPmV0eoKJ6S8oPR9ox8v/GW1wdJV8
         X65SJFOO9xWsBWVAQqGoO/uwJ2CpWNXxB+l5o/eGAl4xMh/3FUVck1Q6dZriJiGFIaCd
         Mo2g==
X-Forwarded-Encrypted: i=1; AJvYcCX2Ya3iTqGaOeyjUrLNku3NM0JwT4KSwP6bgslUz9a98DG+fMtyLM7C8KGUmP6x7Hs/CawLMBLuw5PmnP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFmQLUhz0/3XKh+uZvkjVQB+4qCj46YmlW8qKqJi1dYFSL2z3B
	OvVUU5p3La5VeRcuw5ega9ig08LxrFlfjQ5IO4lYpi2swbcE/qrt3J/Okgkasi4=
X-Google-Smtp-Source: AGHT+IET4qjoJB1wWodF/QyFu2wMpdITwsro6eNAfvM/IE1PiYckOL2Jg39NTknxUkJQohIJiVZU3w==
X-Received: by 2002:a05:6a20:d50b:b0:1d7:1040:8519 with SMTP id adf61e73a8af0-1d710408630mr2986112637.42.1728397394539;
        Tue, 08 Oct 2024 07:23:14 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e3a0:1c0:95c8:8b16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd2a1bsm6168882b3a.85.2024.10.08.07.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:23:14 -0700 (PDT)
Date: Tue, 8 Oct 2024 08:23:10 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: kernel test robot <lkp@intel.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 7/7] remoteproc: stm32: Add support of an OP-TEE TA
 to load the firmware
Message-ID: <ZwVATlRbo0OdRLbj@p14s>
References: <20241007131620.2090104-8-arnaud.pouliquen@foss.st.com>
 <202410081902.TwQcmWjk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410081902.TwQcmWjk-lkp@intel.com>

From hereon and starting with this version, I will not review patchets that
don't pass the compilation bots.

Mathieu

On Tue, Oct 08, 2024 at 07:07:40PM +0800, kernel test robot wrote:
> Hi Arnaud,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 9852d85ec9d492ebef56dc5f229416c925758edc]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Arnaud-Pouliquen/remoteproc-core-Introduce-rproc_pa_to_va-helper/20241007-212358
> base:   9852d85ec9d492ebef56dc5f229416c925758edc
> patch link:    https://lore.kernel.org/r/20241007131620.2090104-8-arnaud.pouliquen%40foss.st.com
> patch subject: [PATCH v10 7/7] remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
> config: alpha-kismet-CONFIG_REMOTEPROC_TEE-CONFIG_STM32_RPROC-0-0 (https://download.01.org/0day-ci/archive/20241008/202410081902.TwQcmWjk-lkp@intel.com/config)
> reproduce: (https://download.01.org/0day-ci/archive/20241008/202410081902.TwQcmWjk-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410081902.TwQcmWjk-lkp@intel.com/
> 
> kismet warnings: (new ones prefixed by >>)
> >> kismet: WARNING: unmet direct dependencies detected for REMOTEPROC_TEE when selected by STM32_RPROC
>    WARNING: unmet direct dependencies detected for REMOTEPROC_TEE
>      Depends on [n]: REMOTEPROC [=y] && OPTEE [=n]
>      Selected by [y]:
>      - STM32_RPROC [=y] && (ARCH_STM32 || COMPILE_TEST [=y]) && REMOTEPROC [=y]
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

