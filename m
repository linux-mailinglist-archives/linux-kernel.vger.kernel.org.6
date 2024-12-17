Return-Path: <linux-kernel+bounces-449235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B721B9F4C39
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335EB1898FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8F1F868D;
	Tue, 17 Dec 2024 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b33zhH/h"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403EE1F4263
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440965; cv=none; b=aYAZMPjW8/8INGE5LdOz0RAIzvQJtnYH1KRwm1Dv1IGprBLyr8KsVd3MGcg3JyBcuLxZpiPDcaAcleWykJqfSe2d0r+S/+igKtYYgIbvRVWuT0Ogj3482dfy/5zY5yqd4XYab/+g4Zb81/HoTXep4I4cxTDTGvhFK7VQScgM42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440965; c=relaxed/simple;
	bh=8ri6RbzWNaTPDTw7kmq71IKYTlN2CuqaBg+QxuJxeOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLgSRcNOShekr2w/Hpt8joXuZGQG8Deqw29Pfi7LeHXAg5L0aOvl0XT54qZeHE+rHy1v9HFAXRr8+PFLFmasBnH0k7pE8wMI9MubXTD0y1WB/1Mu8+AyWlzBCitJT/CEi3o+Pn8zVgs/ioHRXg3oFBcZNXyZk9HD7qxTP+nQtFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b33zhH/h; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso392038a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734440963; x=1735045763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTusGh58VW6+2NSFZii2lA8KCNl1o8/ZwWDL6LUst5g=;
        b=b33zhH/heFNBQBxLxdmVhNeHiSsJmmeTYurNgQFN+ta4Gac1tKbA4kAIY8dNBKGQiJ
         53u/CkkBkN9mAQ/GDPwMsRoMDoGTZBDRpzUmllmX0IVcgtqCNCJYtwD2LY9zfxJjgWsF
         53XUb0ovcV8qhzUj7SJu1dDDJ6XhBK9eBLkypii49A6hfA7X/zrDc93aSV5hqh9mVCug
         n2bXSirrM30chutUHCkm6uXcXLH7rLUQNQ50STqHW/qRDTNejr1fAeijln2YL3e/FTGD
         GL6y/UNnyAh5sELKxvfGbdm+4LrjVQAf2ftLkJoJGeY0dn+W1YjCFMp6Y8mQmERrTKya
         bWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440963; x=1735045763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTusGh58VW6+2NSFZii2lA8KCNl1o8/ZwWDL6LUst5g=;
        b=q/q+LhSXIfKd+izObRNXIGc+0Kag+bkaNH7ECrEWvUve2ppnIedG8gmoFsd/m22Wq5
         pdlnPOODGaL//dcx1iscBrsA5Hy8BNbCESSzRZWdZUoqCRrRhPNgK2wwpiRtnePAQ9Z+
         y6zhooeor8UTza/08zYKR2ZkTH1GNfbnSxtRgH1gp372Dw/jmmuGIEOzf8zEnu1a3AWG
         2Pj+H+xA36o/XVPJnUb29/tVTwphgiG3DgGxsaTpc1ktzf8WFCCgu+4k2rqKAa0zypvm
         fWRF4D6FFQsKqKyGoCfG5i1m6Q4lr817F51OW+bZFGUr5wMAL1zBXd+f9BW3dMM1uZJJ
         hMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrIYCjE6lwQsMfH3OAmbLGYqRNusG7d+/AdPGKNz+QX1iYJuKhr7q8SRwflHkt69mWZJ0AUbUra4OcHx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvaDLlNfsjOCSBBvtAeAHIGQfnh9T4O++wHNvzCtp/LSYhs4HT
	VCZXiyaLzy95k4AwLI7XQfi7SjM/sH1PppWiGFQBg+ii/L8bP6BBpx0Fv3CMRw==
X-Gm-Gg: ASbGncvKouQcSoyUN8OwVdBuhV6+Q2SZ5iGXUdBCswhne5jkmRX6BGJM9//fsZgw2Vy
	GUvrcJ4ARyyx8M4QeFrorgdmRjwbbdDEkzmbdetxlMvi5dV3h3EO4mIWYErkf5qd7mRpZjuhCAc
	hvOxNFaJCjUvIOQMMhPNe0Dvt6VvLxXtfh/SysBc0hjF0l9+lKn9Ts5JbWBm1mLkkgjkj803/VY
	w2BAZCYToWmHYIRKOFPadiO5n0089F3lw3WHltijEoco9Uqa//EyjaCQQnRxwQiFAPlUXoAjk9K
	RqrjYA5oD7dIdqg=
X-Google-Smtp-Source: AGHT+IEnhJMVLLV7Owj/1nOGB+GoFuLCOhRtzgitfH4oBA0YabMmvVMaad90R/9EuoBl8AAIk2rV7Q==
X-Received: by 2002:a05:6402:3890:b0:5d0:cfad:f6c with SMTP id 4fb4d7f45d1cf-5d63c3ad5c6mr13033930a12.21.1734440962482;
        Tue, 17 Dec 2024 05:09:22 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f271a6sm4443462a12.60.2024.12.17.05.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:09:22 -0800 (PST)
Date: Tue, 17 Dec 2024 13:09:19 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Ene <sebastianene@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/18] KVM: arm64: Move host page ownership tracking
 to the hyp vmemmap
Message-ID: <Z2F3_8rN3NBFZXRX@google.com>
References: <20241216175803.2716565-1-qperret@google.com>
 <20241216175803.2716565-5-qperret@google.com>
 <86y10er2qb.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86y10er2qb.wl-maz@kernel.org>

On Tuesday 17 Dec 2024 at 11:03:08 (+0000), Marc Zyngier wrote:
> On Mon, 16 Dec 2024 17:57:49 +0000,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > We currently store part of the page-tracking state in PTE software bits
> > for the host, guests and the hypervisor. This is sub-optimal when e.g.
> > sharing pages as this forces to break block mappings purely to support
> > this software tracking. This causes an unnecessarily fragmented stage-2
> > page-table for the host in particular when it shares pages with Secure,
> > which can lead to measurable regressions. Moreover, having this state
> > stored in the page-table forces us to do multiple costly walks on the
> > page transition path, hence causing overhead.
> > 
> > In order to work around these problems, move the host-side page-tracking
> > logic from SW bits in its stage-2 PTEs to the hypervisor's vmemmap.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/memory.h |   6 +-
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 100 ++++++++++++++++-------
> >  arch/arm64/kvm/hyp/nvhe/setup.c          |   7 +-
> >  3 files changed, 77 insertions(+), 36 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > index 45b8d1840aa4..8bd9a539f260 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > @@ -8,7 +8,7 @@
> >  #include <linux/types.h>
> >  
> >  /*
> > - * SW bits 0-1 are reserved to track the memory ownership state of each page:
> > + * Bits 0-1 are reserved to track the memory ownership state of each page:
> >   *   00: The page is owned exclusively by the page-table owner.
> >   *   01: The page is owned by the page-table owner, but is shared
> >   *       with another entity.
> > @@ -43,7 +43,9 @@ static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
> >  struct hyp_page {
> >  	u16 refcount;
> >  	u8 order;
> > -	u8 reserved;
> > +
> > +	/* Host (non-meta) state. Guarded by the host stage-2 lock. */
> > +	enum pkvm_page_state host_state : 8;
> 
> An enum as a bitfield? Crazy! :)

Hehe, it works so why not :)

> You probably want an assert somewhere that ensures that hyp_page is a
> 32bit quantity, just to make sure (and avoid hard to track bugs).

Sounds like a good idea, I'll stick a BUILD_BUG_ON() somewhere.

