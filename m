Return-Path: <linux-kernel+bounces-373805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8629A5D07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D1B2844BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E09D1946BC;
	Mon, 21 Oct 2024 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8NvF+zc"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7611D3195
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495695; cv=none; b=gtOLlNFfd9CfkLRMr3bTLJ3INohM0BpqJJeZrBJo9LHtYCK32Q/SKVZj58N2RDZC83qIuGayVUm3L6wIyF6ydkODsGf5cw+QnXThLj5ercakVLV+1+O7aJGCoUdR7UzqQvrJM8YuU5vO/RudRl6F5IelBnqayosCneLh4eyLYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495695; c=relaxed/simple;
	bh=yLt4P+aFKsbYRKyQBp9kIVZtjx4+ma6tx6NpxMwTg08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ndc7FeZMAINNS//Ugyi/uISBDZUhYq4uz4KwFaI5c2BQ3VKruAd12RaIPmCfrKLN6s9gel2cIQsC8lKS5YrofqX81825iFi2cq7oz7fZ9oJmBn4l6aaMf+/poJCxW2sHsiS0PW+tItZVmKUqVzt7wN5p5Ko1AA6IHFyXWNiPnjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U8NvF+zc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314b316495so39460845e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729495691; x=1730100491; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbzFOFCkLwBY6/I+BFLuJ0WlPPJIPe8WCwwU3mX1OLM=;
        b=U8NvF+zc6ntnC5q7h4vzv9EsjPJZicd5WHg+kfA1BpA/J6J3jVXjjAAOa3lZMnjhwV
         TuG54H5BrsZRQ7PKnWj1s1UBr+iwehIIU9mMKPKVvhItCACBoWE9C+J0Ja3adMmmn2Na
         31EOcvwwIelDflnf7PxAiyrxozSTkHKfU24KaCVWLk6Q0Jst9ML+XT2tIi3X3KdegnY3
         l8yWfapLWTwhOooXRvbBZ9pLuEHPPCX23qorbdo5ppqthsFQwUbNX+Yo4Tn8BeEeApjI
         ULJejbTPan9kJ6bAoC5EXqSjz37QGUFpZo6ATYNQVoA7TQlRAS7OKSNHtdKa3mwz4yET
         l07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495691; x=1730100491;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbzFOFCkLwBY6/I+BFLuJ0WlPPJIPe8WCwwU3mX1OLM=;
        b=umLedTujJlveTNrFLqIzcRn77yO8102qh/t89JTIyFd8dyPwJ+HVY4YW7rt5Gjd90H
         47f6fFyLlK937JmVIaW6/gjC7rzmsyNSUQf1DhY9p8YHK3gPR9+aiVtQ6ylbTz7o8SHU
         qNroqDqha0L1jIGNyq7E5mB4kbwPHkWpGcuyvR1dCDDT+UA2yOHo2Gd23SNT5xu35pEJ
         nwVo9Bi1X/PMMaeuE7cZKqLlTkRalfnd+qthsR9eehAWQRtcx0kCru1/LDhhzcs9mXqw
         ylSnHTjWzqNSbeuvu6AlLG0tWorAjKMifq9IYp17gL855cFEW+nq/msdl9q8zGtni0CY
         qYlA==
X-Forwarded-Encrypted: i=1; AJvYcCV8fMkU4jct6UcDfvbDfWvNClQykXQEboNZ6eJmLx0bhOdB6WsM/Y7rb1gDj3C7UB8s3ps7A8lai4bCveQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94LRogA6zSHMDFJ9oShPrUHoG5UaTMsy3Yx0j3acctII+KPjn
	/5HZ7H6OxS8bGsP58T5b9SBnjYATDlTX/D1G3jsEBKppioNAfgy3/c/VQDrCmMk=
X-Google-Smtp-Source: AGHT+IF/fDrVSWGmNnEMi7ykD0TpQR91iOtOLsFC59sXFMSL/cnwNC7Tm2avPeNPtwtwqCyDjTGo5Q==
X-Received: by 2002:a05:600c:5124:b0:431:5bf2:2d4 with SMTP id 5b1f17b1804b1-431616a388cmr85325755e9.29.1729495691015;
        Mon, 21 Oct 2024 00:28:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c3173sm47208225e9.33.2024.10.21.00.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:28:10 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:28:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Brijesh Singh <brijesh.singh@amd.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Michael Roth <michael.roth@amd.com>
Subject: arch/x86/kvm/svm/sev.c:454 __sev_guest_init() warn: missing error
 code 'ret'
Message-ID: <148feb5b-cdd8-4065-8570-d0304383cc62@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3d5ad2d4eca337e80f38df77de89614aa5aaceb9
commit: 88caf544c9305313e1c48ac1a437faa5df8fff06 KVM: SEV: Provide support for SNP_GUEST_REQUEST NAE event
config: x86_64-randconfig-161-20241016 (https://download.01.org/0day-ci/archive/20241019/202410192220.MeTyHPxI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410192220.MeTyHPxI-lkp@intel.com/

New smatch warnings:
arch/x86/kvm/svm/sev.c:454 __sev_guest_init() warn: missing error code 'ret'

vim +/ret +454 arch/x86/kvm/svm/sev.c

4f5defae708992 Paolo Bonzini         2024-04-04  402  static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
4f5defae708992 Paolo Bonzini         2024-04-04  403  			    struct kvm_sev_init *data,
4f5defae708992 Paolo Bonzini         2024-04-04  404  			    unsigned long vm_type)
eaf78265a4ab33 Joerg Roedel          2020-03-24  405  {
eaf78265a4ab33 Joerg Roedel          2020-03-24  406  	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
1ca5614b84eed5 Brijesh Singh         2024-01-25  407  	struct sev_platform_init_args init_args = {0};
4f5defae708992 Paolo Bonzini         2024-04-04  408  	bool es_active = vm_type != KVM_X86_SEV_VM;
4f5defae708992 Paolo Bonzini         2024-04-04  409  	u64 valid_vmsa_features = es_active ? sev_supported_vmsa_features : 0;
cc4ce37bed8598 Sean Christopherson   2024-01-31  410  	int ret;
eaf78265a4ab33 Joerg Roedel          2020-03-24  411  
8727906fde6ea6 Sean Christopherson   2021-03-30  412  	if (kvm->created_vcpus)
8727906fde6ea6 Sean Christopherson   2021-03-30  413  		return -EINVAL;
8727906fde6ea6 Sean Christopherson   2021-03-30  414  
4f5defae708992 Paolo Bonzini         2024-04-04  415  	if (data->flags)
4f5defae708992 Paolo Bonzini         2024-04-04  416  		return -EINVAL;
4f5defae708992 Paolo Bonzini         2024-04-04  417  
4f5defae708992 Paolo Bonzini         2024-04-04  418  	if (data->vmsa_features & ~valid_vmsa_features)
26c44aa9e076ed Paolo Bonzini         2024-04-04  419  		return -EINVAL;
26c44aa9e076ed Paolo Bonzini         2024-04-04  420  
4af663c2f64a8d Michael Roth          2024-05-01  421  	if (data->ghcb_version > GHCB_VERSION_MAX || (!es_active && data->ghcb_version))
4af663c2f64a8d Michael Roth          2024-05-01  422  		return -EINVAL;
4af663c2f64a8d Michael Roth          2024-05-01  423  
eaf78265a4ab33 Joerg Roedel          2020-03-24  424  	if (unlikely(sev->active))
fdd58834d13204 Sean Christopherson   2024-01-31  425  		return -EINVAL;
eaf78265a4ab33 Joerg Roedel          2020-03-24  426  
a41fb26e616973 Sean Christopherson   2021-11-09  427  	sev->active = true;
4f5defae708992 Paolo Bonzini         2024-04-04  428  	sev->es_active = es_active;
4f5defae708992 Paolo Bonzini         2024-04-04  429  	sev->vmsa_features = data->vmsa_features;
4af663c2f64a8d Michael Roth          2024-05-01  430  	sev->ghcb_version = data->ghcb_version;
4af663c2f64a8d Michael Roth          2024-05-01  431  
4af663c2f64a8d Michael Roth          2024-05-01  432  	/*
4af663c2f64a8d Michael Roth          2024-05-01  433  	 * Currently KVM supports the full range of mandatory features defined
4af663c2f64a8d Michael Roth          2024-05-01  434  	 * by version 2 of the GHCB protocol, so default to that for SEV-ES
4af663c2f64a8d Michael Roth          2024-05-01  435  	 * guests created via KVM_SEV_INIT2.
4af663c2f64a8d Michael Roth          2024-05-01  436  	 */
4af663c2f64a8d Michael Roth          2024-05-01  437  	if (sev->es_active && !sev->ghcb_version)
4af663c2f64a8d Michael Roth          2024-05-01  438  		sev->ghcb_version = GHCB_VERSION_DEFAULT;
605bbdc12bc883 Paolo Bonzini         2024-04-04  439  
1dfe571c12cf99 Brijesh Singh         2024-05-01  440  	if (vm_type == KVM_X86_SNP_VM)
1dfe571c12cf99 Brijesh Singh         2024-05-01  441  		sev->vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE;
1dfe571c12cf99 Brijesh Singh         2024-05-01  442  
cc4ce37bed8598 Sean Christopherson   2024-01-31  443  	ret = sev_asid_new(sev);
cc4ce37bed8598 Sean Christopherson   2024-01-31  444  	if (ret)
fd49e8ee70b306 Paolo Bonzini         2021-04-22  445  		goto e_no_asid;
eaf78265a4ab33 Joerg Roedel          2020-03-24  446  
1ca5614b84eed5 Brijesh Singh         2024-01-25  447  	init_args.probe = false;
1ca5614b84eed5 Brijesh Singh         2024-01-25  448  	ret = sev_platform_init(&init_args);
eaf78265a4ab33 Joerg Roedel          2020-03-24  449  	if (ret)
eaf78265a4ab33 Joerg Roedel          2020-03-24  450  		goto e_free;
eaf78265a4ab33 Joerg Roedel          2020-03-24  451  
88caf544c93053 Brijesh Singh         2024-07-01  452  	/* This needs to happen after SEV/SNP firmware initialization. */
88caf544c93053 Brijesh Singh         2024-07-01  453  	if (vm_type == KVM_X86_SNP_VM && snp_guest_req_init(kvm))
88caf544c93053 Brijesh Singh         2024-07-01 @454  		goto e_free;

Hard to tell if this is an error path or not.

88caf544c93053 Brijesh Singh         2024-07-01  455  
eaf78265a4ab33 Joerg Roedel          2020-03-24  456  	INIT_LIST_HEAD(&sev->regions_list);
b2125513dfc0dd Peter Gonda           2022-02-11  457  	INIT_LIST_HEAD(&sev->mirror_vms);
26c44aa9e076ed Paolo Bonzini         2024-04-04  458  	sev->need_init = false;
eaf78265a4ab33 Joerg Roedel          2020-03-24  459  
c538dc792ff7e4 Suravee Suthikulpanit 2022-04-08  460  	kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_SEV);
c538dc792ff7e4 Suravee Suthikulpanit 2022-04-08  461  
eaf78265a4ab33 Joerg Roedel          2020-03-24  462  	return 0;
eaf78265a4ab33 Joerg Roedel          2020-03-24  463  
eaf78265a4ab33 Joerg Roedel          2020-03-24  464  e_free:
1ca5614b84eed5 Brijesh Singh         2024-01-25  465  	argp->error = init_args.error;
7aef27f0b2a8a5 Vipin Sharma          2021-03-29  466  	sev_asid_free(sev);
7aef27f0b2a8a5 Vipin Sharma          2021-03-29  467  	sev->asid = 0;
fd49e8ee70b306 Paolo Bonzini         2021-04-22  468  e_no_asid:
605bbdc12bc883 Paolo Bonzini         2024-04-04  469  	sev->vmsa_features = 0;
fd49e8ee70b306 Paolo Bonzini         2021-04-22  470  	sev->es_active = false;
a41fb26e616973 Sean Christopherson   2021-11-09  471  	sev->active = false;
eaf78265a4ab33 Joerg Roedel          2020-03-24  472  	return ret;
eaf78265a4ab33 Joerg Roedel          2020-03-24  473  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


