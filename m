Return-Path: <linux-kernel+bounces-440208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D84D9EBA35
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC2D164DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473D226872;
	Tue, 10 Dec 2024 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npGDc2pi"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570F214232
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733859605; cv=none; b=QuoBMd4l4Yax0+UlE2oEqTy8zNAZg+gEHkDQVBqFXBQFfmz4E1rJ79PcHLICfNij4J77bW6Wk1fa5sexMg5zVSudgWto7ubXC45k2+dxFELqq6g2eAHMC2aIV4wMpRscD+BQ+drBTwHVetsMGzA7JHA1PzByDVDaaC27o61JFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733859605; c=relaxed/simple;
	bh=unXnRfu/yUThTbpM4v8udjLfXFivgtwIKR880XV65Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn3k34r6WDtwyucze/imBbkukOW27bkg49emtt42ANw+Zf3kt4YFo9F8E11+rco+MkNwG2iW8wmpnJboCVZGS4oi6a49AH4jX7fBQkjelCMqOSaiWhwzIiI/hbDlNKzT5Hid6BCZNh/JzJ2SSNyJBnBi11ccnLP9tmBFXe5bkqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npGDc2pi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so7013751a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733859603; x=1734464403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q91PmvibJrjArXljdo3eEl/cePC9h8EbSI/sERSQTH4=;
        b=npGDc2piNdDStPkaGjDNrwxXXsXt0DlUkcChGwGepvOCfc97+lre58jnGKCR9VHhwq
         /X8o4mrHjKq8FLYv1hzEZNt4eIj7xnW3bCksOoLZ0rEZZddmfOeyUyewj1so1Ozdz2WI
         3774NbCDy8DVtCd+lgZFQO+zgncCB6G8dVGS+ydEK8uj1tvIzjBhlTyjPDQii4kn5AeW
         wpX/vk25APXqTGzTHYYhKO7BLy2GL9yTnY9H1InfytKU0rUmeUh3N1Xxly0O2S2AluJL
         yiUI8WOcrtA7Ziy0wrT+hdMJeA42YlEx8tlNUK/WjU2767fyNY/sq/HVUKQojYfSezBr
         0SHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733859603; x=1734464403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q91PmvibJrjArXljdo3eEl/cePC9h8EbSI/sERSQTH4=;
        b=SyCcP75LhSXYBFNK1fuYcMuAWbihZK40t66zRTQ0WSobJM0no+M1kHB19I+hr0G629
         drZJLu08ZOP29eZHPhZrIrgMmUTGZ+Z4jIauqXRMSgp5+J43PuQReWJjDQLl0p7Ue9UX
         nWbvgRXanYYUyFoamYib91kTk9mWp8ZuxvmVp1prSzKGGm8kmoi4LwaIX22YmIB3PDPa
         DRU1w53Yx20jqZlR3r3BB+5XKjtrbagG6jcRHhybIGG9hGffhb3qoDFg1K2G6TzEMBa1
         aWE9dcILz/nyfVxYq76d+AbvOIKuEpGSlL0zaHBROF6QU1+VOJ5H6Ek8jhIw1jSHTaRR
         RUtw==
X-Forwarded-Encrypted: i=1; AJvYcCW7QYzPXOTtIdbB3h2TQ31bEbl3Gafhm/ubnZ7x6oQCnNRs0KBZIrX2JUNS1g8Puhn2s/yMHJGlydCt5Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpIoTZYoStEdntfSbr9EiJIlYUKgfX+AbdduSTTQLUpd8zaieA
	8hWvuk0dzUT+FCwcDSGUlEJDmw7s1JiN6LbKwGVK3Iz6ffqu4fmfCok3F3/l3Q==
X-Gm-Gg: ASbGncstz7AstERsb75cFfER1zaQoM4t0n6MCBH5hukHerMhetSQnF0FP49l1S9VijL
	Si/+OSRMwZdLlgoCC44vviZFApYwrFyfeYzDNyb+7FkuBKgcUAdhooU7Yhi4cR+BG1+C+VBZO63
	ZJJNepOCqxJPemWB/f93YLTPUfup9b92PFpdL9xrtHYyvc66+A0553yKNf0uKePatRGbxwn2cIS
	i+KX6KLgdqLam6HHso/bEIPRjD8kNmFEbjwluaPNxrWk4Bup59kz5E3BxBzZaJD2sTK41Dl8Fwn
	FHzb0ucTe7/O
X-Google-Smtp-Source: AGHT+IHWIDVdFqGs95DGfrfVEYVGD04C9okzNTbglc21NwXMz+6mFDbeHCJtOk1PZLW3D2Rl/6yrJw==
X-Received: by 2002:a05:6402:360b:b0:5d0:b925:a8a with SMTP id 4fb4d7f45d1cf-5d4330a2f6dmr35199a12.16.1733859602562;
        Tue, 10 Dec 2024 11:40:02 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7936581sm4997727a12.56.2024.12.10.11.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:40:02 -0800 (PST)
Date: Tue, 10 Dec 2024 19:39:59 +0000
From: Quentin Perret <qperret@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] KVM: arm64: Introduce
 __pkvm_host_test_clear_young_guest()
Message-ID: <Z1iZD54EdpvbpW7I@google.com>
References: <20241203103735.2267589-1-qperret@google.com>
 <20241203103735.2267589-15-qperret@google.com>
 <CA+EHjTwV2mXOXMF7u+pVaSqvJ2c-iPGMxPBhrj7oZrm+oaAi3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTwV2mXOXMF7u+pVaSqvJ2c-iPGMxPBhrj7oZrm+oaAi3A@mail.gmail.com>

On Tuesday 10 Dec 2024 at 15:11:53 (+0000), Fuad Tabba wrote:
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > index 8658b5932473..554ce31882e6 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > @@ -43,6 +43,7 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum k
> >  int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
> >  int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu);
> >  int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
> > +int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm);
> 
> While I'm piling on the function names/parameters, some functions have
> _guest as a postfix at the end (e.g., this one), others have it in the
> middle (__pkvm_host_relax_guest_perms). I guess
> __pkvm_host_relax_guest_perms is the odd one out. Could you rename it?

Right, 'relax_guest_perms' felt more natural to me, but consistency
should take precedence, so I'll rename :-)

