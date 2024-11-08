Return-Path: <linux-kernel+bounces-400949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854319C1461
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25AF1C214AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8033FEAD7;
	Fri,  8 Nov 2024 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2xeLC9R"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1DBA49
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034851; cv=none; b=vB/BnDWQftHjFnYBF/1b6HbPfE8xa2zfeRAvqMrdR7idjt8b/GFVMlQxgVN1P6lBDmvViJ7Bt42hJ7eRFV90xmrN0diUunheUQUclzt5Uq6XnCy/pyhtlgg0aucO6/7nOKWNI+pN+Vm68zWeduo4dCD7Z2aLzcJcfxj7uV/bkEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034851; c=relaxed/simple;
	bh=1lqzFGn1eXbAen/HouRQEXecZLXqEsPyxz4EZS5zSGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOKaoyeKlgnwSatHj9v8bITkPFPuYLJPoeGkADVrFkqcWf9j+ASTJxVLSoWeE27/yOUF95xaQUp1HXFClHchVwx74jLCy/gAPt++hVQpeE/kxELKCyt4hd+M3kN4ptIf8kb4uzsuGEP5vtR7P2lIF2ywrB+IyY7iEi3Bf60Yz50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2xeLC9R; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ea051d04caso14120547b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 19:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731034849; x=1731639649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpzEZp7ZlditrMUaR0RY215WGeQ8zIPi7Ck1Zq/zD0c=;
        b=f2xeLC9RyPjTVxtYjwz6c9oV/mfXWe7ymKeFka+D6KP5W7r7Hw0ehmtYuw3LuPjs1q
         y0/Wq7nauH8sdcHDe3Ln2bj97mwEcLSE8oAuHiytYRWUYEOMaofwXCoz3y88POrAzBon
         klPz7Ayjrviz2ukj/+Y1UB93kXLkKh7a2+I9WcwNPvjfJ2iAzJJL8qfekCFsIZnjmoQ1
         MJRblWBs257JmKyaxLughKWhAGc1XSpV42pnE9CWOfcNJiCH7pQT0+f85gQb/Z6gZaTq
         WZaRmVjjYWwek/+ZahclALkCGWDBbtId8xLF0Hoe8k3QsEnr1aw/vIf2S+H0DMPU9LsP
         VUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731034849; x=1731639649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpzEZp7ZlditrMUaR0RY215WGeQ8zIPi7Ck1Zq/zD0c=;
        b=J8ZfK/9TzqyV8/tdjf4KLRnZl17TohxwqDh4Smf+34kSCH5LMRYMAYsx1S5Q/zgZzW
         YpFPMpb9YGXlcx9ESsEQ06E36mU2FqzEA5nejQxSJtHkAwCbBNQC2yH/uCC7A2KxNJkk
         md1SE6n7EcSuZtzKqz6QDb9TLPw+Hcns1pdDnxpO7bpZYSmg9LhY272kdxhBOUNNJk5B
         YNAbmbRHbSv1RnOdmYhNyO9Bfpxv1isyqI6LvprPQ+fvjbRuiHrEQibgkhbvr4cAFAlm
         vPqOd+vFtkFgeHOJib+PxBvd4Xy4n4pgY8HHWik5jasB7++4fxhtBFHVKeQ5cC+jZ9jk
         41TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNh05DsK8W8wGoZWaw7VN6+WuvzASmzZPlJeu4wE/8CfYeXSSEK/9Grh/RFwpZKCZMc4oOzDTo8Nho+jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg//Ri8g4wdr3JsNM3Nw6dOwdvR7MJpvFSkBq0zWMkz5BmTh75
	Lrc5Fftxuq06AHUjfBGYdbj5b5aSBz4Gl+8wSzQXA2VGKCA+IbVKeKTyuqDsUMTBw9yoBNksT7U
	xxyFI9HGUE/znt4+U9HvcJohz6baEJK/1A2uQ
X-Google-Smtp-Source: AGHT+IHR4yckEoMuQ7L6FZx8C9n+6mGcTLb5/EhQ62bRePk5jVdh0KVFPZSYTuKhRFZX0cTeNXh9dAaW7vwAUxwoHQM=
X-Received: by 2002:a05:690c:c93:b0:6e3:3336:7932 with SMTP id
 00721157ae682-6eaddf8dc3emr16216267b3.27.1731034849279; Thu, 07 Nov 2024
 19:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105184333.2305744-5-jthoughton@google.com> <202411061526.RAuCXKJh-lkp@intel.com>
In-Reply-To: <202411061526.RAuCXKJh-lkp@intel.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 7 Nov 2024 22:00:13 -0500
Message-ID: <CADrL8HU3KzDxrLsxD1+578zG6E__AjK3TMCfs-nQAnqFTZM2vQ@mail.gmail.com>
Subject: Re: [PATCH v8 04/11] KVM: x86/mmu: Relax locking for kvm_test_age_gfn
 and kvm_age_gfn
To: kernel test robot <lkp@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	oe-kbuild-all@lists.linux.dev, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:22=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi James,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on a27e0515592ec9ca28e0d027f42568c47b314784]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/James-Houghton/KVM=
-Remove-kvm_handle_hva_range-helper-functions/20241106-025133
> base:   a27e0515592ec9ca28e0d027f42568c47b314784
> patch link:    https://lore.kernel.org/r/20241105184333.2305744-5-jthough=
ton%40google.com
> patch subject: [PATCH v8 04/11] KVM: x86/mmu: Relax locking for kvm_test_=
age_gfn and kvm_age_gfn
> config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241106=
/202411061526.RAuCXKJh-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241106/202411061526.RAuCXKJh-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411061526.RAuCXKJh-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    arch/x86/kvm/mmu/tdp_mmu.c: In function 'kvm_tdp_mmu_age_spte':
> >> arch/x86/kvm/mmu/tdp_mmu.c:1189:23: warning: ignoring return value of =
'__tdp_mmu_set_spte_atomic' declared with attribute 'warn_unused_result' [-=
Wunused-result]
>     1189 |                 (void)__tdp_mmu_set_spte_atomic(iter, new_spte=
);
>          |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~
>

Well, I saw this compiler warning in my latest rebase and thought the
`(void)` would fix it. I guess the next best way to fix it would be to
assign to an `int __maybe_unused`. I'll do for a v9, or Sean if you're
going to take the series (maybe? :)), go ahead and apply whatever fix
you like.

