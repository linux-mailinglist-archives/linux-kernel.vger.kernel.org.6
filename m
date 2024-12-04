Return-Path: <linux-kernel+bounces-431483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AC89E3DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15986165126
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C46220C00C;
	Wed,  4 Dec 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpN6yT+c"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D885E20B213
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325261; cv=none; b=R3XMVfbQH+3TBCiUbQOZG8W4i9XrOWv//11eY4fOzVPeOiAf6PzkYjpfZerR/dpa1vvoUgJvU/uA+co/rFfv0y95P4WwKD429IJIWLyUkKCanwzGdZHfx+LQQfHU523wSPZk8syo5dXJXXPEEKVmGxAzbkLXEhsO243+EQXcHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325261; c=relaxed/simple;
	bh=EvXM02tO6yjyKm/Jwl4qSn9ESvQ4Qu0hdnvG8bDmZu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JG5LUMHX9FXtbLwhngqisp/7v/H9iOPOwU74tZlqSLRktcPOOcizhYLfnJ5KQZqy0CfYuaGvSLwdgCD5Ar9Oc6AEOfYaSaiOavld1Y6R7TuA1tIgQzVh3432vLZywFDRBVw4uOzoZZQTb8sZW+j8Q8+rnbGjHEPwV9Blj+S9FZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NpN6yT+c; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso1189442666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733325257; x=1733930057; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZiMvEGOnA3x8ktWeqDOREzwrlUTrCkUJYsXv6kLLcLI=;
        b=NpN6yT+c/XaXpTR6sOv3ouTsysiScoU1gKIueKUXPSt5AGQvlRvmZ6TjlRN9BAGPD1
         gPtjWuhAJf+yKcPIzB2GAxxICtlAooJ/MnzGHAh/nuVm/QLxdQChzh/0pyzXBvG/22Gp
         00dnJJ44uJkFlmuwzTOYzwywE267edhelcwP+17YRwerGse6PEo5y1mG3Vvcx3x6oOWc
         ItqSzcPjIelWwWC+3vfkT/fzqeKp6SnamI4YklBWN4J6/YYBLCDNbirPt69Ocxhnr/lR
         Q9G0acUlCn8sCHQ924UC8pbcLwCPq3xj36XSNyKVfQGE0JO/Ovy+HC/xwEG3WicJNKye
         RQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733325257; x=1733930057;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiMvEGOnA3x8ktWeqDOREzwrlUTrCkUJYsXv6kLLcLI=;
        b=RmFkDpXyo9F7yTAO98/HxawGaE7rDXOtQTZm1FRqF3uhOfArXK/A41rzBtyAaZ5pdy
         zg9H8u0je3V+B+TN0Fr0aAaWMUUeZTmY/onVGvLE8w0EM99tPZF62nE0QwA7Q7gpuwxP
         4twQkrxnsAoPSGA5cZDl9JhKbPE6gLPqRRhr06mKXR+3roWSHgOUU1w5I5FiBbWmWxbr
         76NVsRH119DU564JYjttacUPHUrZXF1suECnUO4h1rR236+UrkQaCC4UtpmrYlQDyyp7
         PasXerPSODSWuxjMqSvE2rmTNFsdYx/x9r9pRC/szO/dRZiNl4pflk4FH6wcEgXGB8B1
         FwSA==
X-Forwarded-Encrypted: i=1; AJvYcCXFLK48g4gzEzwlf02riTQPeWVzhGMcdiHfn9oxnovAq64PDPAM0oeZifi5wWSqn0GLVFlVdhCzwH/akhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRssSO8NTq3Qxd5M2KGFb0prha2Mugy1VrQsjhbreD7Rwpx7mY
	M00AmusyJFWinsrlc9zSDXqUOurqr58+83mZdQnZn7+MNv0MsALwDE57Z+kzL7g=
X-Gm-Gg: ASbGncv9raHGgjXx5xqW3hkKp7Iy8ECy9TK6mfzqTWT9U+tAcZWBdtqEGUZIr0UNwLZ
	kBJpBrss95TAet44wNjlUNXK91Y+Yz7TR4ng6+2TmOVZ2HZKHUM5VEaLVbeKzqchFuUTUtmfZ96
	/i8BGJ60RVjAvWDxwoXw6QJeQrlew8vGXepu1j9vxyyHDtyS/aX7/W7Didj2yXhIZ1o7LVYKLUD
	ATQ3BOiAizWmLnaEFAXOUT75Gk663D6X/+Mo1qBlTmPkMHMsq4N401fu6U2u96laASAe1wt4Q==
X-Google-Smtp-Source: AGHT+IHbdn++zxupMPsIv4w/y2HdWMryceH/LpF4wX4mLdWemSgp6CuJQnWo+ftPXRvxTNtQzIB0dQ==
X-Received: by 2002:a17:907:7719:b0:aa5:249f:8431 with SMTP id a640c23a62f3a-aa5f7d4ed63mr634753666b.18.1733325257169;
        Wed, 04 Dec 2024 07:14:17 -0800 (PST)
Received: from localhost (hdeb.n1.ips.mtn.co.ug. [41.210.141.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d12136e9f9sm254760a12.44.2024.12.04.07.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:14:16 -0800 (PST)
Date: Wed, 4 Dec 2024 18:14:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Simon Horman <horms@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drivers/remoteproc/pru_rproc.c:341 pru_rproc_set_ctable() warn:
 variable dereferenced before IS_ERR check 'rproc' (see line 335)
Message-ID: <f5bd0861-abaa-4e9a-89af-deb682df8641@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Simon,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feffde684ac29a3b7aec82d2df850fbdbdee55e4
commit: e752f9b924a1fd1afcf36e51b03dfa9c3096a3bd soc: ti: pruss: Allow compile-testing
config: alpha-randconfig-r072-20241122 (https://download.01.org/0day-ci/archive/20241204/202412042058.zwL1rOlr-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412042058.zwL1rOlr-lkp@intel.com/

smatch warnings:
drivers/remoteproc/pru_rproc.c:341 pru_rproc_set_ctable() warn: variable dereferenced before IS_ERR check 'rproc' (see line 335)

vim +/rproc +341 drivers/remoteproc/pru_rproc.c

102853400321bae Roger Quadros   2023-01-06  333  int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
102853400321bae Roger Quadros   2023-01-06  334  {
102853400321bae Roger Quadros   2023-01-06 @335  	struct pru_rproc *pru = rproc->priv;
                                                                                ^^^^^^^^^^^
Dereference

102853400321bae Roger Quadros   2023-01-06  336  	unsigned int reg;
102853400321bae Roger Quadros   2023-01-06  337  	u32 mask, set;
102853400321bae Roger Quadros   2023-01-06  338  	u16 idx;
102853400321bae Roger Quadros   2023-01-06  339  	u16 idx_mask;
102853400321bae Roger Quadros   2023-01-06  340  
102853400321bae Roger Quadros   2023-01-06 @341  	if (IS_ERR_OR_NULL(rproc))
                                                                           ^^^^^
Checked too late

102853400321bae Roger Quadros   2023-01-06  342  		return -EINVAL;
102853400321bae Roger Quadros   2023-01-06  343  
102853400321bae Roger Quadros   2023-01-06  344  	if (!rproc->dev.parent || !is_pru_rproc(rproc->dev.parent))

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


