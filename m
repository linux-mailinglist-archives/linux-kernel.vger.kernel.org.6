Return-Path: <linux-kernel+bounces-343393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF2989A77
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCEBE1C2123C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F77DA6A;
	Mon, 30 Sep 2024 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViBfy4lx"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E423BE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727677247; cv=none; b=FDpStBUyMLBajbu/6v2WjrfooRQ3z29kAUnQRIk5OtB1CaaGycEJa+kxFv4Hf7rVpP2TsaYP5aPyNB157Xzi9KtTSYnO2ep7CHOIpLDmljdDpgVjBRgy1/DgRD9WjHFV9esLgMzc/p7TSjXVu8B33VUMUSqA2fLM9bkH7u7ygLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727677247; c=relaxed/simple;
	bh=pGPc+JYDsZqFewmXA9OYhQgLIhty7QPS90kktb+w6AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsXLfBYnfPmeBjKT2uK1bTxpYpJrQBcRpo9n5efUgL74gZjWQNaa/PkuI6OOkz5fa2sTQmprcG3zjyBgqCq1+EiDRXLUHZSJVSn5WqFES7JvUlIniitSTgeZmHcYR5k2RKMvi6T18R7+1RBUlR+HBgrOobecQm2iHJQ1UmpHSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViBfy4lx; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a99fd4ea26so352810685a.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 23:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727677244; x=1728282044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhTbPt1aUPRRqMfF/iI2ldaEOQJQVcgQDTvk5oRV9Co=;
        b=ViBfy4lx6SZiA79tOH2tup+LCIVY8/Fs74SJ1VYUNNrZV8iphkhohQhinfaB3TZBMK
         DYdx2wYAutC5x5ekQ7Dwl8lGkplxA+iK3HLP17UByZGziVg66+zw1PNz/kq3g91wO4F3
         T06lt/T+NTuMmHL89gLcBMvxMV4l0mt/8Qk8C8a8fX7OWI6mysIPIS3ZPakISuWotype
         JLN68gTctcHcBvUcwpqZtjIA2MX7O6Tf7wPKtM9+x4Jdo2QT8x/9Q3se6xtrlBL0fPhp
         w5Nb3rOHNTx0uPvr/419/a+RoId6asZc0Xpc6WxNSQghVH6/2uN2JLlocfY5MDjdmgad
         AIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727677244; x=1728282044;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhTbPt1aUPRRqMfF/iI2ldaEOQJQVcgQDTvk5oRV9Co=;
        b=mi+Cnmxa6XOEpIkzSlEPT6/wJSKb16GAbgcem4iVlQ5tHg37YC4ZUQoELKhtKzBUQn
         HmROWWHkra5oX69ALaRHYSva51TAiwfmTTjIkBEspz2kFFECl9yMbZ8PhShPYOUuh6rC
         VDOjX9EbLXCT5w7dN0luSzFHsdgMJ3/6NW6wD0ntZ9wstMMqThOaEad8jU4iKxmXhgLB
         /AjAVHRXOxVnoo6MR9yWBuk7J6d5SeHIuD0U+t4uXKfAxX/t/eqIFntuFloU3CP/qaW0
         rrm/BjvZYguO1kWd5+QrOysVIQzjZzCYE9chHQizBvzzZ1d9MBZ+wb+6WvirMnX9Qp56
         nDfg==
X-Forwarded-Encrypted: i=1; AJvYcCVVCdfZoO3way4SAfvIfcF8QMall9S+GUbOIsE1i6QpX0GAB3J9ndVXOQWhPOlovBU3CX8ophJZMOfb+NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCp+deojy2aNKUn3gNL/SXL+Vdsr6HFUJzNUU0LxH579cbnURG
	GDnYceqW1bJgBh+YxgBJdJZWC9H7G42zfG66AQypkvLDayAvWh53PfSgLhtjaNymWw==
X-Google-Smtp-Source: AGHT+IEXLITWRzMYezDnabDByPKOLgZhSmoB9VoyzWMRR7EMYd6z8a4rkGrGOADqwIVxy1gGuMLxfQ==
X-Received: by 2002:a05:620a:1a06:b0:7a6:6447:19ab with SMTP id af79cd13be357-7ae378bc056mr1713694585a.46.1727677244482;
        Sun, 29 Sep 2024 23:20:44 -0700 (PDT)
Received: from jia-21cx ([185.221.23.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783fdd8sm383704485a.102.2024.09.29.23.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 23:20:43 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:20:35 +0800
From: Jia Qingtong <jiaqingtong97@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Jia Qingtong <jiaqingtong@huawei.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: vgic: fix GICR_STATUSR in
 vgic_v3_rd_registers
Message-ID: <mhwgdkcgoan7r53bubpvlnu4xoexmnldwlk6ni5zjvkn4cnr72@fhxnwlfw536t>
Mail-Followup-To: Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Jia Qingtong <jiaqingtong@huawei.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
References: <20240929043937.242769-2-jiaqingtong97@gmail.com>
 <87v7yevlyc.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7yevlyc.wl-maz@kernel.org>

On 29 Sep 10:38, Marc Zyngier wrote:
> On Sun, 29 Sep 2024 05:39:35 +0100,
> jiaqingtong97@gmail.com wrote:
> > 
> > From: Jia Qingtong <jiaqingtong@huawei.com>
> > 
> > vgic_uaccess use bsearch search regs in vgic_io_device.regions, but the
> > GICR_STATUSR have wrong order in vgic_v3_rd_registers.
> > When check all vgic_register_region, it turned out that only
> > vgic_v3_rd_registers has this problem.
> > 
> > It's harmless since vgic_uaccess behaves as RAZ&WI when it can't find the
> > specified reg. This is exactly the same as the behavior of the GICR_STATUSR
> > register.
> >
> > So just move GICR_STATUSR to the right place.
> 
> That looks correct, but I think we should have some code that ensures
> that these tables are correct at boot time, just like we're doing for
> the system registers. Or completely remove our reliance on bsearch().
> 
struct vgic_register_region was defined in vgic-{its,mmio-v2,mmio-v3},
do you think it's appropriate to extern and check tables's item order in
vgic-init.c's kvm_vgic_hyp_init?.

> Another thing is that GICD_STATUSR looks pretty wrong. It is handled
> as RAO, but we never clear any "error" (it is WI). This has been buggy
> since GICv3 save/restore was added, 7 years ago.
> 
Let's change it to RAZ? We will implement the complete logic when someone
really needs this feature.

> Do you mind spinning a series fixing this up?
> 
Sure. 

> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

--
Thanks,
Qingtong

