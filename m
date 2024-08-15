Return-Path: <linux-kernel+bounces-288292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04260953879
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F62B20F49
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6A61BA87B;
	Thu, 15 Aug 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHMXQqqp"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F31B4C44
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740173; cv=none; b=W+Y7quAiwGflihfMFFZhBQ+fiD4AtkqW7tOyDvn6v6GKy4dqNYCRT/KcNCVwiL104cnqY7j29ZzjdG1qCAW+IWoFXnmIgndT9gWo1s6uuQ6rkAVxCD8VhrYSGSk+Fw9xdoaryXOaU5QGTICOmgNUXD022Sp0l3KRDYUicUBrS0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740173; c=relaxed/simple;
	bh=1zRUFULarkTq6LPHVNJ0pkCLjhF3gvttZE7Jb/DKsk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irw3c6A7KwXWaNaAgra3fAIwilU1Pc8VGjma4WwAP64Bi8E12c3sU9vAo0xAZqJx5mdnVAiPftI9Rn8qV66zv5xHacoY+zRBRhZHvlHhcwcrp4qX8NXTig+WfSY2CDrGs6kmql+7cAkP0PRHWCyyRN3ldcz3SeuZgpJwGz+ZUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QHMXQqqp; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db157cb959so696400b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723740171; x=1724344971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f9XWOzgA/HPz/G4P1h718yGI+VzmZbkZwfnQInlVNGo=;
        b=QHMXQqqp0faOlKAPErne6hqqOve9t3QxZ8ty67nwkIUROLh34MGXfI7bliG0RtkeSF
         9rCCO8BgHeAeHGqg63hvu+VuAYE6DdLuhpQSeStjC2dYjBEGB4SXUCYP2686IP7FFcpR
         rh3Tq9cK1xqctLKQ3WWKIaMmqvl50QLfwsKfxX5MgPydR7XuCIEH4KYvekPCOk7lSprA
         XHAttpT48PZFtEHpO8npLkq+WhvmrlTJaMkrU8Z8MUvAvYn9N4TXUgAc1YtrO5ubYa/x
         NJFCwFezWMx+eGY0UnLmVO3IoINGl/j/ZmEsAa7KJFbvOqAPG4VpHJK6/eNaRQrQp1yF
         rL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723740171; x=1724344971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9XWOzgA/HPz/G4P1h718yGI+VzmZbkZwfnQInlVNGo=;
        b=WnlCLvgIvzS/2bCbhjU6JZihUVQpJePvMuAD2+/wcx54jrvCDRnqFL4XQeCIB27DNV
         PgU0+2rd2I/pgde49quQ14LhmFeHgPTZIVo0rW7EH674mgZAQsGkKLKZEYZBW3aPSCwy
         KPxIT7GtPw3QakGvlJyKvjzpUCBBweR64B1UO5NYHaRAY/Efy/hyhj60mE3LUtVvgBqN
         8Qw5KG2/i3TJy2Xq3cPaM76TWyt7WQ6i227YAhhoFo7Oddig0VYtgzhWHsEhUmN+P+XJ
         3uRjmzkkN1bQw1qOd0HmpNlsh0WrybCQiOYfDHbtlEIn65DpAnu6jCrHInE5WD9eCGUf
         jQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Pytzh7IlrFh6dlO3xck4VCWCzB3wp+SBdkMavWPNXI2NdBYUJ4JOrAMXaSkBpYErm0o9a6X4NDCtrgX6q+Fs5d1o0H/afHgP60T5
X-Gm-Message-State: AOJu0Ywy1FzCiNvTsHzf3EA/xflHkbEH51sqsOYdNHukto7mLHGOyFnw
	yCrfQWG8OeVpYxFC+TACDVb0ouVhRX12QFE3Lo7re6w86ijcrh030Wfdmi5hsw==
X-Google-Smtp-Source: AGHT+IGcK7SGE8EjW4QiHlEKJJHDBb8NIW/RbvoYkf19zDjo/HtqxIAEn4/qp/U2DyWRmGixwywMhA==
X-Received: by 2002:a05:6808:1b13:b0:3da:57b8:22f3 with SMTP id 5614622812f47-3dd29971d90mr8649806b6e.43.1723740170612;
        Thu, 15 Aug 2024 09:42:50 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b636ca92sm1324086a12.91.2024.08.15.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 09:42:49 -0700 (PDT)
Date: Thu, 15 Aug 2024 09:42:44 -0700
From: Vipin Sharma <vipinsh@google.com>
To: kernel test robot <lkp@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, oe-kbuild-all@lists.linux.dev,
	dmatlack@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Recover NX Huge pages belonging to TDP
 MMU under MMU read lock
Message-ID: <20240815164244.GA132028.vipinsh@google.com>
References: <20240812171341.1763297-3-vipinsh@google.com>
 <202408150646.VV4z8Znl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408150646.VV4z8Znl-lkp@intel.com>

On 2024-08-15 06:50:04, kernel test robot wrote:
> sparse warnings: (new ones prefixed by >>)
> >> arch/x86/kvm/mmu/tdp_mmu.c:847:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    arch/x86/kvm/mmu/tdp_mmu.c:847:21: sparse:    unsigned long long [usertype] *
>    arch/x86/kvm/mmu/tdp_mmu.c:847:21: sparse:    unsigned long long [noderef] [usertype] __rcu *
>    arch/x86/kvm/mmu/tdp_mmu.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
>    include/linux/rcupdate.h:812:25: sparse: sparse: context imbalance in '__tdp_mmu_zap_root' - unexpected unlock
>    arch/x86/kvm/mmu/tdp_mmu.c:1447:33: sparse: sparse: context imbalance in 'tdp_mmu_split_huge_pages_root' - unexpected unlock
> 
> vim +847 arch/x86/kvm/mmu/tdp_mmu.c
> 
>    819	
>    820	static bool tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
>    821	{
>    822		struct tdp_iter iter = {};
>    823	
>    824		lockdep_assert_held_read(&kvm->mmu_lock);
>    825	
>    826		/*
>    827		 * This helper intentionally doesn't allow zapping a root shadow page,
>    828		 * which doesn't have a parent page table and thus no associated entry.
>    829		 */
>    830		if (WARN_ON_ONCE(!sp->ptep))
>    831			return false;
>    832	
>    833		iter.old_spte = kvm_tdp_mmu_read_spte(sp->ptep);
>    834		iter.sptep = sp->ptep;
>    835		iter.level = sp->role.level + 1;
>    836		iter.gfn = sp->gfn;
>    837		iter.as_id = kvm_mmu_page_as_id(sp);
>    838	
>    839	retry:
>    840		/*
>    841		 * Since mmu_lock is held in read mode, it's possible to race with
>    842		 * another CPU which can remove sp from the page table hierarchy.
>    843		 *
>    844		 * No need to re-read iter.old_spte as tdp_mmu_set_spte_atomic() will
>    845		 * update it in the case of failure.
>    846		 */
>  > 847		if (sp->spt != spte_to_child_pt(iter.old_spte, iter.level))

Hmm, I need to wrap spte_to_child_pt() with rcu_access_pointer() before
comparing it to sp->spt. Following patch makes this Sparse error go
away.

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7c7d207ee590..7d5dbfe48c4b 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -820,6 +820,7 @@ static void tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
 static bool tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
        struct tdp_iter iter = {};
+       tdp_ptep_t pt;

        lockdep_assert_held_read(&kvm->mmu_lock);

@@ -844,7 +845,8 @@ static bool tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
         * No need to re-read iter.old_spte as tdp_mmu_set_spte_atomic() will
         * update it in the case of failure.
         */
-       if (sp->spt != spte_to_child_pt(iter.old_spte, iter.level))
+       pt = spte_to_child_pt(iter.old_spte, iter.level);
+       if (sp->spt != rcu_access_pointer(pt))
                return false;

        if (tdp_mmu_set_spte_atomic(kvm, &iter, SHADOW_NONPRESENT_VALUE))


