Return-Path: <linux-kernel+bounces-378056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B299ACABC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570702820B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D2C156C72;
	Wed, 23 Oct 2024 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABjpIbtG"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805B1ADFE8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688933; cv=none; b=AWKVAQIZiaiSnqzG1qHwk09lvaLVhlDnULOjaiQetbCvbEy/Ld5LRX1LnUzw7sDTFNBOs930ariSVWz93JYiHDTKZApMZk6lgV0mAHjnkJdKwcTDHZl3hdN5ZiCaZPG1+ViwK8gRljFgIoKac2h2nnYsk34JgxiLCC3XSO3EEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688933; c=relaxed/simple;
	bh=dV1gbO1qLb6NKBW03Yj7HQfwxoH+NP+YUmjI9o87CxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL6S+Ywfp1IO83ly2HllVeMAGZpdbq0rptChppg/G9EaAQ0pvVnBQCZkKYFTZW4kpVXrN+BEDGCYZkn+NH+gAcDwAV2/yx6kCbhJHH/ax+k5voX/oIqNHpJYilWD6DIfT32lCFPARJsd+1M/7vciAubsGyrVZurDf/2eBEEqjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ABjpIbtG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f7606199so7602370e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729688929; x=1730293729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WnD2nZJAklMiOeWZJa3ROELAJ4NyTZ2a7s0JkiTjll4=;
        b=ABjpIbtGc+RaAUr7Man3GYAdwdAKzioXwMA77alxC5JZtCSR9Z1wQ+lVmi24qbwoOE
         p6U5GRWU6nr12+g6Be1Vuso0eRyEVw1gpBlt3J16i0Hn2jyLUuSN7TXgzPFdp6HMAC6e
         XlkYHrC+yS3CwKkN/zKFguLRf79nhruKcDl5CavehDuLN+sysFt7lwYC2PQl/MqokOyH
         QWlaS01qtkjX8wovunXCwA6rzK8swm5G1mTASVPEuWHglYjteaJ8mZG46dEbqnsLb4kB
         XpFbGHVnevyvyxUYclV0TP6EhU8GyRIMAY+fQj1slhdnF/pzjgJKck1zqpY4jYqhLaVT
         Jqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729688929; x=1730293729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnD2nZJAklMiOeWZJa3ROELAJ4NyTZ2a7s0JkiTjll4=;
        b=CWQKlXi48gVAhidnheYadCgR5kfkFWqBrORQ0hB6QpnzJpPk05f4WUihRqyzY37zmc
         iZaczCXowPIZLOUQgyiW2BKQiJrmUmWKz4R9KcTBj/0bQXkamS3j2WZN2YOzX5rxjTg6
         byVz5DuN7a/57AEELmc1GXQfMKnAY8zEEEcrtSEx8CoNOEtDnmeiBqFBoym1MiCqeVfT
         dE3utwhRi3rSomp3MzJBOwii7KlmtNbKqKG89zEdPWlJZdkH2ioY4H4V2MESzESfGBjW
         fLeF6c465AhC2TMcCAVzCpWvgf5M2KCMWOWXG029xLBwiG8Y8GaOHm/BBrSPuurMXxWQ
         XTzg==
X-Forwarded-Encrypted: i=1; AJvYcCVJyoj80ConzQH2o65ow5cq8cBkjdRD7W2mgIFRMPVe92jXxU5hk9KIymwl596dSh/ZxWxk7KuGcRBsKGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV16iJZQtGqMSJXsLSBsYB8HAKx86LXg4m8Nd1HLUUoo2xT8IU
	YMnf6JkgqubqfFwL98loRjyDspqoDks/E4JnGnrB3lT88gBdtQvKw+Unnyk0QiM=
X-Google-Smtp-Source: AGHT+IFw5ht7rmnC4d2saXeTVIgInQdtV2P7ds7Hv2UrhifS4vHmObILRq5jgIoeA5fMxxeePNLDug==
X-Received: by 2002:a05:6512:3082:b0:53b:15dc:f15d with SMTP id 2adb3069b0e04-53b1a375f5fmr1493195e87.50.1729688929224;
        Wed, 23 Oct 2024 06:08:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186bd223dsm16159645e9.1.2024.10.23.06.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:08:48 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:08:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: arch/arm64/kvm/at.c:71 at_s1e1p_fast() error: uninitialized
 symbol 'fail'.
Message-ID: <50405e9c-7921-49ee-bd97-f2b603987f0f@stanley.mountain>
References: <7612de9a-d262-4d40-addb-64449768b35a@stanley.mountain>
 <864j533s88.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864j533s88.wl-maz@kernel.org>

On Wed, Oct 23, 2024 at 01:43:03PM +0100, Marc Zyngier wrote:
> On Mon, 21 Oct 2024 08:29:41 +0100,
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   3d5ad2d4eca337e80f38df77de89614aa5aaceb9
> > commit: be0135bde1df5e80cffacd2ed6f952e6d38d6f71 KVM: arm64: nv: Add basic emulation of AT S1E1{R,W}P
> > date:   7 weeks ago
> > config: arm64-randconfig-r071-20241015 (https://download.01.org/0day-ci/archive/20241020/202410200209.bAXXL58Q-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 14.1.0
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202410200209.bAXXL58Q-lkp@intel.com/
> > 
> > smatch warnings:
> > arch/arm64/kvm/at.c:71 at_s1e1p_fast() error: uninitialized symbol 'fail'.
> > 
> > vim +/fail +71 arch/arm64/kvm/at.c
> > 
> > be0135bde1df5e Marc Zyngier 2024-07-14  52  static bool at_s1e1p_fast(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
> > be0135bde1df5e Marc Zyngier 2024-07-14  53  {
> > be0135bde1df5e Marc Zyngier 2024-07-14  54  	u64 host_pan;
> > be0135bde1df5e Marc Zyngier 2024-07-14  55  	bool fail;
> > be0135bde1df5e Marc Zyngier 2024-07-14  56  
> > be0135bde1df5e Marc Zyngier 2024-07-14  57  	host_pan = read_sysreg_s(SYS_PSTATE_PAN);
> > be0135bde1df5e Marc Zyngier 2024-07-14  58  	write_sysreg_s(*vcpu_cpsr(vcpu) & PSTATE_PAN, SYS_PSTATE_PAN);
> > be0135bde1df5e Marc Zyngier 2024-07-14  59  
> > be0135bde1df5e Marc Zyngier 2024-07-14  60  	switch (op) {
> > be0135bde1df5e Marc Zyngier 2024-07-14  61  	case OP_AT_S1E1RP:
> > be0135bde1df5e Marc Zyngier 2024-07-14  62  		fail = __kvm_at(OP_AT_S1E1RP, vaddr);
> > be0135bde1df5e Marc Zyngier 2024-07-14  63  		break;
> > be0135bde1df5e Marc Zyngier 2024-07-14  64  	case OP_AT_S1E1WP:
> > be0135bde1df5e Marc Zyngier 2024-07-14  65  		fail = __kvm_at(OP_AT_S1E1WP, vaddr);
> > be0135bde1df5e Marc Zyngier 2024-07-14  66  		break;
> > 
> > default case?
> 
> There is no bug here, as evidenced by the *only* caller of this
> function (__kvm_at_s1e01_fast()):
> 
> 	switch (op) {
> 	case OP_AT_S1E1RP:
> 	case OP_AT_S1E1WP:
> 		fail = at_s1e1p_fast(vcpu, op, vaddr);
> 		break;
> 
> So 'op' can only be one of these two values, and at_s1e1p_fast()
> always initialises 'fail'.
> 
> I guess this is a case of smatch not seeing beyond function scope.
> 

Yeah. I don't know why I sent this report.  :/ The kbuild-bot doesn't have cross
function information, but I have a system with that right infront of me.

Sorry.

regards,
dan carpenter


