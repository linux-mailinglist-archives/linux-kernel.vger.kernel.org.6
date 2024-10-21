Return-Path: <linux-kernel+bounces-373807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D49A5D11
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64A82846FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DAA1D1E72;
	Mon, 21 Oct 2024 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDtXA5lm"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC31DE898
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495789; cv=none; b=Vq+XoczdhE4zF/kK+ptmlxpTtgrMS9+z73HhqSI/YoQ3+8bVHTnCKk5hXeYa4GIZamcuUIziBdXM02hkEYXe1M2u4ypiFgAKlRwtFRe0CaXAmFywcXV3mQlN3IeHKWhYn4DSpxbGeQjaH3wbu5dlrFHjD5ReN/T3O2flEglMtOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495789; c=relaxed/simple;
	bh=XrusYag+LII0liDvjBVw2JqWK3sU0P0bEy+YtyI5W7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uxc5qzEBZIZ0K0TPiuocRYdzyaeVsOGSFBvpNio4EFWSuQDJUp60YNdY8nDQHVl5S6shYGHU6E17CU+baKWFNIW2SHshX9YuvqxyL4Wy+K1IGTiko04BcBqSmcTq6T9ovUgPXaAC20jJkcg9/1EKAGkEMWQ+ir1qKrl4GaQBzzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EDtXA5lm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so3098709f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729495785; x=1730100585; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/oqIfHdzcYvPr+1084fMJueTQGBe/OWdE59Qz6opvs=;
        b=EDtXA5lmcUR8SFnhiHxLAgMGt9CnuCNtq+yltnF80hBzG0d17rdA7z46p8x/7+0MJc
         4zfKHf9U13Q6P+z7ebB5Drl8k5Yc9/yW1qXfNjPSyv0g5cdBqE2sWlv4AfFr/Dp6kUaQ
         YwDkjWPch6QVw0FS3LTFFRLlYr5BazW12l589yR4QaVSURV1oSqw4VkNBxYWb1CuuGSd
         C3EkNo9uhT2huc0YXKnHXsvgHGWHHG3tv3CH19+9LUnOaQpk0G8EI1NisUEqNzYpAg8t
         mRFZY1ym3oqnih62MRZ7drviVCtOxAD2Snpj85n9xoezArd7wgvs8RRvHwaCIR6N2SGk
         yTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495785; x=1730100585;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/oqIfHdzcYvPr+1084fMJueTQGBe/OWdE59Qz6opvs=;
        b=UeNrfm6zBubaDZMj+bBIjXd84q66wdChZM7vgEYxd/tJP2ZjCuaJLuJLAYLNTCVA0y
         BxgKtWxGIJGMlJU5sAE3z7+rHXKPHZSxVExkuW3bmwrMIbyeX4G9/+uLQaI5YQrBvmx6
         n3LJZNKP1r0XFFJ3+wic1PmCszYkaq0GX26pkpLCRFlZ38kWv8nkKEjm2eJc9/EYsXrs
         1FYY+E72pIz9B6pJIGSNePntnUYsV1c10yKEIqUTejW2JpPleX96edptPrBV8BrU4HUd
         T/lyZNns1oU8FMCdHdfFVMkQBw4lr7nFBGX9XyMLziXp6Sv88W9N18AI+gSTBRPuRbzS
         6EoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDQDIekvnoL+tR9GjlKPLhdcl7CX9GuYJdmNQpJi4HtaqPsXD6kbb/hsTYUopNuPyZGx2x1Ebn74aLpCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SuI1ZEest2ysxj+YAbFe5AZFLfOaISDT7GF+kywEljenbUF7
	ER0mJvjlZODSybI5MokCSwFlvEdJ3Fo6cTTwbRVbHhW22YsWVnEbSjHMhq477aM=
X-Google-Smtp-Source: AGHT+IEiT5sMS+JgZu4ao5jBHWTOP1eckzgWiyUMsyejreFShjkny/C9UcGB2hR74+jC68Jx+/qP2w==
X-Received: by 2002:adf:a34e:0:b0:37d:4b73:24c0 with SMTP id ffacd0b85a97d-37eb4896bcemr6237577f8f.35.1729495785515;
        Mon, 21 Oct 2024 00:29:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b944f0sm3581825f8f.77.2024.10.21.00.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:29:45 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:29:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Marc Zyngier <maz@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: arch/arm64/kvm/at.c:71 at_s1e1p_fast() error: uninitialized symbol
 'fail'.
Message-ID: <7612de9a-d262-4d40-addb-64449768b35a@stanley.mountain>
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
commit: be0135bde1df5e80cffacd2ed6f952e6d38d6f71 KVM: arm64: nv: Add basic emulation of AT S1E1{R,W}P
date:   7 weeks ago
config: arm64-randconfig-r071-20241015 (https://download.01.org/0day-ci/archive/20241020/202410200209.bAXXL58Q-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410200209.bAXXL58Q-lkp@intel.com/

smatch warnings:
arch/arm64/kvm/at.c:71 at_s1e1p_fast() error: uninitialized symbol 'fail'.

vim +/fail +71 arch/arm64/kvm/at.c

be0135bde1df5e Marc Zyngier 2024-07-14  52  static bool at_s1e1p_fast(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
be0135bde1df5e Marc Zyngier 2024-07-14  53  {
be0135bde1df5e Marc Zyngier 2024-07-14  54  	u64 host_pan;
be0135bde1df5e Marc Zyngier 2024-07-14  55  	bool fail;
be0135bde1df5e Marc Zyngier 2024-07-14  56  
be0135bde1df5e Marc Zyngier 2024-07-14  57  	host_pan = read_sysreg_s(SYS_PSTATE_PAN);
be0135bde1df5e Marc Zyngier 2024-07-14  58  	write_sysreg_s(*vcpu_cpsr(vcpu) & PSTATE_PAN, SYS_PSTATE_PAN);
be0135bde1df5e Marc Zyngier 2024-07-14  59  
be0135bde1df5e Marc Zyngier 2024-07-14  60  	switch (op) {
be0135bde1df5e Marc Zyngier 2024-07-14  61  	case OP_AT_S1E1RP:
be0135bde1df5e Marc Zyngier 2024-07-14  62  		fail = __kvm_at(OP_AT_S1E1RP, vaddr);
be0135bde1df5e Marc Zyngier 2024-07-14  63  		break;
be0135bde1df5e Marc Zyngier 2024-07-14  64  	case OP_AT_S1E1WP:
be0135bde1df5e Marc Zyngier 2024-07-14  65  		fail = __kvm_at(OP_AT_S1E1WP, vaddr);
be0135bde1df5e Marc Zyngier 2024-07-14  66  		break;

default case?

be0135bde1df5e Marc Zyngier 2024-07-14  67  	}
be0135bde1df5e Marc Zyngier 2024-07-14  68  
be0135bde1df5e Marc Zyngier 2024-07-14  69  	write_sysreg_s(host_pan, SYS_PSTATE_PAN);
be0135bde1df5e Marc Zyngier 2024-07-14  70  
be0135bde1df5e Marc Zyngier 2024-07-14 @71  	return fail;
be0135bde1df5e Marc Zyngier 2024-07-14  72  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


