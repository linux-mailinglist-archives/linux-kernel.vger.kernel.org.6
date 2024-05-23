Return-Path: <linux-kernel+bounces-187695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7764A8CD6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC44AB2224C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FACB657;
	Thu, 23 May 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRuXhll2"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200EB665
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476975; cv=none; b=UQ9Q/8ZRC5HSkQY3i2WfDyufjqXVdfSYUIrcBkouUOrDLz0s6YfmBe/zvL0KCbGdlZaiH76Lx8HK1T3Qxc6z7cP/t23ZDd6dTe8hSNnTclj0k9Lq/I0dgFc+5uekb3d69xawGd93pUYgEl/UvT0H0JDTKo0u2VcnG/TOkEuUVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476975; c=relaxed/simple;
	bh=ju4mwWD7HTNSueQOnNPpV57Ec+J9+tFLImbUclsgOIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hoQpnqW0XoF9QfaohgIAJW4oXbWSa4qi9p+TFNJfKVo8Ls8dKVzOsEQlt2/W2m3cqE9Qh96eiTwbutfZMUwNiUpSGFdzeSO0VtsdQ/9ULnUEJnLeLUqqj8oVoW/uA1u5pisNespiAvA1cJ5DTb4/pMBJek35uYnwsKrxAGbVREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wRuXhll2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4202ca70270so25231455e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716476972; x=1717081772; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBRzWW8ABwwrAgp/rRaEloFhYaP4tJ5xVJxQiF1nl4w=;
        b=wRuXhll20rJQ2snfvx0XIWpuvSk1AqA4bgUhh2xPXl71N9OSpxV3JHbgyYfQenQayU
         SA2d1PrMUE++Xv8pt75K+Up/7FnRSD7aueHE4103US1K39cQLIuJekaCMD2+f9nLV3C+
         DOfKBxXPB8w95FN4K8KOSgFO9+nttFn+1hEpQaFndkJm1GB88SV8GNtt9ExnB0lvutwi
         CgadA9ozG8/EUsD0J6MbWxYlhIxi2YwBox3Z6ACt+vTheS2NXX2uQVxeIG+//BHk5Skj
         gTUZJgeApyE7qN7aQSrJ6AtPCIMqNbsUkjeKN6ShnVegVOBzAdiZB0t3yVApUkGyHEHa
         lQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476972; x=1717081772;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBRzWW8ABwwrAgp/rRaEloFhYaP4tJ5xVJxQiF1nl4w=;
        b=VX3O4ZZeHOs775blJt6Dxaz67prS287OJv6mTsbzyeRVv2iDcfGYIlhTXNU6pZobj5
         SZIQ1bD/8YzDXyYSMXjDBprB/Pj2ApesL4BeDTELH5nLy7N9mOVerCMi8R2AGtbBOnls
         Egu8xIGbCE6Ri5Dwjl9pL2Uk69UHrX25CTrFTsvdJLl9UCP8KOtTxDxNexbBH57RSkkr
         nxM0N37zi4Wa36Pj4sEpZyds+Nzl/flq8WPE29O8yWv1Zhig4QFjOHx7Z18cJVs5LWzz
         SDs2CiBcwa8r6O2Hw1dq3SjMXowQjQfcjkXHivu4MAuq5P0VuCZu+QDEKHIhQ7mP1QnG
         SgJA==
X-Forwarded-Encrypted: i=1; AJvYcCVBMb8UaPU/GipO81C0q0hK9xjRFkRbwGvm3cNrFvAVYJb4VbfEcU1F7eSVktncdV2/vtWKg6NEp6ATqqgnESWt/Wx6HbdO0+F+7IXg
X-Gm-Message-State: AOJu0YwSKwcrWJW1NEVNoMJqEEay1UdUAS5tfEwjZ8i6XUY9lAYMSTsb
	ZWu0n9f32rLa/Alx+WNJzYJtVXrquBFMIEMpcnFSzIRPvPRgLmxChTV7X4jBGZM=
X-Google-Smtp-Source: AGHT+IGJnIP6trm/n/Ivi0WcjoGiFwJeK/q3hka33wn1C3QSjG5oxm0brSYLE1MXWh7b+L8cgcim0Q==
X-Received: by 2002:a7b:c391:0:b0:41b:bb90:4af with SMTP id 5b1f17b1804b1-420fd322d7emr44539235e9.20.1716476971597;
        Thu, 23 May 2024 08:09:31 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f5a27asm27906775e9.21.2024.05.23.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:09:30 -0700 (PDT)
Date: Thu, 23 May 2024 18:09:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Vasant Hegde <vasant.hegde@amd.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: drivers/iommu/amd/iommu.c:2011 init_gcr3_table() warn: missing error
 code? 'ret'
Message-ID: <7765e9c3-414d-444a-8943-7e244c945e57@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   29c73fc794c83505066ee6db893b2a83ac5fac63
commit: c9e8701132e6cc162d082e7dad8a2e9110f5f8fd iommu/amd: Setup GCR3 table in advance if domain is SVA capable
config: x86_64-randconfig-161-20240522 (https://download.01.org/0day-ci/archive/20240522/202405221116.X7cP3GzG-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405221116.X7cP3GzG-lkp@intel.com/

smatch warnings:
drivers/iommu/amd/iommu.c:2011 init_gcr3_table() warn: missing error code? 'ret'

vim +/ret +2011 drivers/iommu/amd/iommu.c

c9e8701132e6cc Vasant Hegde 2024-04-18  1986  static int init_gcr3_table(struct iommu_dev_data *dev_data,
c9e8701132e6cc Vasant Hegde 2024-04-18  1987  			   struct protection_domain *pdom)
c9e8701132e6cc Vasant Hegde 2024-04-18  1988  {
c9e8701132e6cc Vasant Hegde 2024-04-18  1989  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
c9e8701132e6cc Vasant Hegde 2024-04-18  1990  	int max_pasids = dev_data->max_pasids;
c9e8701132e6cc Vasant Hegde 2024-04-18  1991  	int ret = 0;
c9e8701132e6cc Vasant Hegde 2024-04-18  1992  
c9e8701132e6cc Vasant Hegde 2024-04-18  1993  	 /*
c9e8701132e6cc Vasant Hegde 2024-04-18  1994  	  * If domain is in pt mode then setup GCR3 table only if device
c9e8701132e6cc Vasant Hegde 2024-04-18  1995  	  * is PASID capable
c9e8701132e6cc Vasant Hegde 2024-04-18  1996  	  */
c9e8701132e6cc Vasant Hegde 2024-04-18  1997  	if (pdom_is_in_pt_mode(pdom) && !pdev_pasid_supported(dev_data))
c9e8701132e6cc Vasant Hegde 2024-04-18  1998  		return ret;
c9e8701132e6cc Vasant Hegde 2024-04-18  1999  
c9e8701132e6cc Vasant Hegde 2024-04-18  2000  	/*
c9e8701132e6cc Vasant Hegde 2024-04-18  2001  	 * By default, setup GCR3 table to support MAX PASIDs
c9e8701132e6cc Vasant Hegde 2024-04-18  2002  	 * supported by the device/IOMMU.
c9e8701132e6cc Vasant Hegde 2024-04-18  2003  	 */
c9e8701132e6cc Vasant Hegde 2024-04-18  2004  	ret = setup_gcr3_table(&dev_data->gcr3_info, iommu,
c9e8701132e6cc Vasant Hegde 2024-04-18  2005  			       max_pasids > 0 ?  max_pasids : 1);
c9e8701132e6cc Vasant Hegde 2024-04-18  2006  	if (ret)
c9e8701132e6cc Vasant Hegde 2024-04-18  2007  		return ret;
c9e8701132e6cc Vasant Hegde 2024-04-18  2008  
c9e8701132e6cc Vasant Hegde 2024-04-18  2009  	/* Setup GCR3[0] only if domain is setup with v2 page table mode */
c9e8701132e6cc Vasant Hegde 2024-04-18  2010  	if (!pdom_is_v2_pgtbl_mode(pdom))
c9e8701132e6cc Vasant Hegde 2024-04-18 @2011  		return ret;

From the comment, this looks like a false positive, but could you please
change it to "return 0;"

c9e8701132e6cc Vasant Hegde 2024-04-18  2012  
c9e8701132e6cc Vasant Hegde 2024-04-18  2013  	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
c9e8701132e6cc Vasant Hegde 2024-04-18  2014  	if (ret)
c9e8701132e6cc Vasant Hegde 2024-04-18  2015  		free_gcr3_table(&dev_data->gcr3_info);
c9e8701132e6cc Vasant Hegde 2024-04-18  2016  
c9e8701132e6cc Vasant Hegde 2024-04-18  2017  	return ret;
c9e8701132e6cc Vasant Hegde 2024-04-18  2018  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


