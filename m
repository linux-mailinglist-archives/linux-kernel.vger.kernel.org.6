Return-Path: <linux-kernel+bounces-577365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A4FA71C23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBB8188B8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C71F790B;
	Wed, 26 Mar 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V6gkOj8A"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56682FB2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007476; cv=none; b=TKTaT6rzAbNlNWlFi5exTRk0Xsx4OHxftnYnU5mMKG5lxyFFIlCzzIS/fvwyWRil2f2nh0YTxGdbCVw5NHePk4FlNlwj473c/ZgKBiHNZ6QYjIzLnN0Z11GJ+C/uOkGXUez4aX/xgftRC2n0nuXan/CJ5bUg+AAJM/9/nvk+Hvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007476; c=relaxed/simple;
	bh=vl/8jvl883eRDOcU46eNAJBVeBbw1nad1SPppAXkr2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ2aeAuZMs62D1g6m/5KTQRElAsoBi44GB+m1jkJNKW3rK7L25bir8mbDCk0b9CXk6bG7Zjr524NKIT7cHbXeRiQBDOlw0vWRLQpQcipgq9wCLxGJa+rHWwSXY+8ajm0fe9s9AumiruVcZeLghchQtJK0/5LqI5r6UDm52VzOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V6gkOj8A; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso46962a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743007473; x=1743612273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FLbYc6DJ86SQdhqAmrNYoz6E78qOWd9IB6ZElcruN4=;
        b=V6gkOj8AZj5eNzzw8K4v8g3FokLnoIQNxrY4gmaGQhaL13ypThXh4IEeh1g9f8laNi
         IsEHGc7sskt5YMgWv/tMUBOFCSZLDq8C4GgSWzAw1XBV+rS4usTVbaVwqD64pkXfrcw/
         3Taf5XPfoFet5g5afEDhzwpBC9iDr2Px01s843h/SfIBRmbB5gAP1o6nwhYDTH/4wp7j
         gSvoJncm4xNVVn7uPfBophUhlFs89eQMLyUKl+toNqq3ls/ZJjRgGq+2O/UZll3d2tpX
         fEtI0EXNoBCAweeCcc1OHvromOvuZXSOSh+21O9Rm8XTbfeDw09U5ogXj08t0KCS/7ao
         oJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007473; x=1743612273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FLbYc6DJ86SQdhqAmrNYoz6E78qOWd9IB6ZElcruN4=;
        b=R+TAoT8nXRKQy55tpyK/5DEhiPYL36xtZUOuB1ROh3IdcTP42T70Jj2dxDofGIIv73
         XFrTdsyrE6UlnPhVwDx2ACmwFeQgrvIr6/b2zlTEHWrwCtJRTHwCrNUZxdHV7J0cf9ho
         CIBx9mvsVGCDyx4IW96GLzwcqS54LG5JaC/La9+MmU0tZGj0DveuONkGa42upZbpuvF2
         Z6ygz6/Zd7BDBVrPVpV68db4fRp1TtzW1YM8XCkC6vU64X2dcBnnvvf3UBBfJdLpiFnY
         EEqpt5CSKmynAyhl5mzy5ypLg3ABpWJJVzumVIc6MgRW5GU2mNaataMNOrEUSbxNAKgj
         txAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUqShR/YzlL5h3oI/DqSQVQ29SDqniWhptUtLpxn1KKhrAY0fPXk5XC6hjQa8pXRBrQuzK0tMzl25BsJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTOR9kfZ9qpyzqwDu5foqlkiORYW+vKPZyJxyYP0cqLJbLBF0R
	p77/Pb4I33fn4ezbDox6Y0SkjW3+TiZElEbXTwIfcJyjhJlE4sR8WZKLPIpKuw==
X-Gm-Gg: ASbGncvISR9uWdWBMD2JMRG88hlCSInxCrb4G4kN31j/w9gZW4wFVuWnCwNay91Sg5V
	Pv/T+dOWkQjS6o5oF9+ZKnoFwwFajVL2ovOCyHTJLdyeiLiggGPjujgksde0TVbVOJf2MBHMHPT
	w/v+Mh8kX8R2sKCx2k4GE+Y+ZSNEZGBJKLNKDOTGZ+O2v5/TMZ2l23so4wNgSi5TaRRZcvQsHwm
	BVn7x+ZcxHe7iL6ilcl3v8Zjh60i+yAM+jn6pjaCu7MCaXlQlweFDowjrUs5y4PyKOhPjqWu8pU
	PWrxkkRI8lGH7PDq0LM2c41khbcnfFkkFWjtI0m+fXTGBlZYZwr7lJ2QCXidTCOxkM9e6UgR9P6
	1I8Y=
X-Google-Smtp-Source: AGHT+IElc209Ee2L3zjrpSie3PIBXbdLz1F9LHwLhTXBJRf87bcz8LqAbv5vE8ZPP/e4GdP9Kaf4Lg==
X-Received: by 2002:a17:907:7f25:b0:ac3:b126:58a9 with SMTP id a640c23a62f3a-ac6fb107f18mr8924066b.40.1743007472752;
        Wed, 26 Mar 2025 09:44:32 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb6588esm1066894166b.90.2025.03.26.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:44:32 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:44:28 +0000
From: Quentin Perret <qperret@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, snehalreddy@google.com,
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com,
	will@kernel.org, yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v4 1/3] KVM: arm64: Use the static initializer for the
 version lock
Message-ID: <Z-Qu7NSg96-1uimk@google.com>
References: <20250326113901.3308804-1-sebastianene@google.com>
 <20250326113901.3308804-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326113901.3308804-2-sebastianene@google.com>

On Wednesday 26 Mar 2025 at 11:38:59 (+0000), Sebastian Ene wrote:
> Replace the definition of the hypervisor version lock
> with a static initializer.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> Acked-by: Will Deacon <will@kernel.org>

Reviewed-by: Quentin Perret <qperret@google.com>

> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index e433dfab882a..6df6131f1107 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -69,7 +69,7 @@ static struct kvm_ffa_buffers hyp_buffers;
>  static struct kvm_ffa_buffers host_buffers;
>  static u32 hyp_ffa_version;
>  static bool has_version_negotiated;
> -static hyp_spinlock_t version_lock;
> +static DEFINE_HYP_SPINLOCK(version_lock);
>  
>  static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
>  {
> @@ -911,6 +911,5 @@ int hyp_ffa_init(void *pages)
>  		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
>  	};
>  
> -	version_lock = __HYP_SPIN_LOCK_UNLOCKED;
>  	return 0;
>  }
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

