Return-Path: <linux-kernel+bounces-350060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFF198FF3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FE21C20EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41274179BB;
	Fri,  4 Oct 2024 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deWLJ0AW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262F140E50
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032527; cv=none; b=BHbaX3u7QpH77TjcnFk3D0BCDJ8BQs7imotwHUwCxS5St6uhEosKUIaslnOc//zmTd2htbFRy4gKYVaAPxqOReejR9PUU+RibzE1olh1wnDuCj/l3bK9+I6RcnMVfcZl/7vPVEWj1fdS3cqg3StK0xLZ3TwVcO8vNDSHLC3Gyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032527; c=relaxed/simple;
	bh=K5lM5oTMnWmatcunyhhtDKJEiz8Iy8ERPUUQ6K7r9W0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TuyisLYivE9fhuXme2sAYnly/V4crSevmgsYJJtzMVlLjEC5IGaEmPGy60JHw66enZ5bzHOeObT0KbFu35LNbwVYYZYFVMLObzz0sAQb4DuttkN/0bGBLXxtnzKhCv0yhrFGDU0MJQwjkIAY5Cq7G8KKkUKpqZi2dTn7ltPqlG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=deWLJ0AW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728032524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=POGiK5aXq+5mxnM2dIKXwwemv3Zm7oZ5fRtKj2qEy18=;
	b=deWLJ0AWBJTUpBMddvTnPHh4HTKXLdHRaGLRcKVJaaN4kwZ892XpXBhWyQ5n5NMuDVWRnj
	oFzbzoro44oE+7mr/u+j88753CFuf7F7CTTfcYcqG7PnP+2APBu80o2NR54pWV6gV2diw9
	0JlRtsPhiiPwB5+dQ095tusHncVHxjQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Nn-THrPYO8WdYk3Hlk4Tmw-1; Fri, 04 Oct 2024 05:02:03 -0400
X-MC-Unique: Nn-THrPYO8WdYk3Hlk4Tmw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb5f6708aso10947995e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 02:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032522; x=1728637322;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POGiK5aXq+5mxnM2dIKXwwemv3Zm7oZ5fRtKj2qEy18=;
        b=ti0oQh5Zw0+8uiojvY6n/Hg/9wO3EgLPTi3eOYzm/wIkq0hk/M1b/mlKOga1icfq4D
         vPja6rhk58fkA0kZvOLfCPUOGy7EoKydy1XJyEH/BOcC2zj7M3XLhG6PEk2g5TDRUv50
         +yZLjLIY7Xn/hglSD81s2dxoo167JGXT8Zjb35qn51owBuKRkq7zQ+tIU2wVj/DuZd3o
         y598QB9vrFljxoVVat6sba66Sq2hgt4rESs16FVtK5K3PSkubC1CU0hl6LzzaPH5PPvt
         t65+ZFEyTX5VFBumn/DU1TWwe5Ie7VnElI7aqA3v/iGTQ5eBvsp6+NoGrk0E1VCyTQP+
         /N/g==
X-Forwarded-Encrypted: i=1; AJvYcCWr5RphVqXxvnYJH94aP0AvlXt4Iq1HUhSqUrW6tsniS67FdHJVvDf3LvA+ChCGSHpwyOXb1TYB5xvdKVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaysoH8H1eNcCgYhT/cKNdak+VnyrlD8SNwtdSg5nMuapmvvoz
	NvZwF0vD6c9wy2tCC1ozlkyHQjf/fHDXWYGCrJR2MwLNs6GiJ8Lqbg3xR+rR1JpbaXQkDaFFD85
	h7hpsDy6/UFUFRq8hkEg1YZ956ZgfC22qLEM1/IGxIVZ+y6X5fTq87VpmCeneoPV6Sl+i5GX+zx
	DFheK2Xa6xYZtN1W4l89F6oxTU45EzGYp6jWbZ1BkG2Oxifg==
X-Received: by 2002:adf:e88c:0:b0:37c:d2d2:7f5a with SMTP id ffacd0b85a97d-37d0e778bd5mr1002886f8f.32.1728032521973;
        Fri, 04 Oct 2024 02:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsax2npipLHpiQaTkmVYD5+gDzZzKbMVA5mPfgl42MvDLKH/onj9NiurRzIwVoUEotMH1THw==
X-Received: by 2002:adf:e88c:0:b0:37c:d2d2:7f5a with SMTP id ffacd0b85a97d-37d0e778bd5mr1002864f8f.32.1728032521444;
        Fri, 04 Oct 2024 02:02:01 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d223asm2811344f8f.104.2024.10.04.02.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 02:02:01 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] KVM: selftests: Mask off OSPKE and OSXSAVE when
 comparing CPUID entries
In-Reply-To: <20241003234337.273364-4-seanjc@google.com>
References: <20241003234337.273364-1-seanjc@google.com>
 <20241003234337.273364-4-seanjc@google.com>
Date: Fri, 04 Oct 2024 11:02:00 +0200
Message-ID: <87ttdsi6lz.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Mask off OSPKE and OSXSAVE, which are toggled based on corresponding CR4
> enabling bits, when comparing vCPU CPUID against KVM's supported CPUID.
> This will allow setting OSXSAVE by default when creating vCPUs, without
> causing test failures (KVM doesn't enumerate OSXSAVE=1).
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/cpuid_test.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> index f7fdcef5fa59..7b3fda6842bc 100644
> --- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
> @@ -62,6 +62,12 @@ static struct cpuid_mask get_const_cpuid_mask(const struct kvm_cpuid_entry2 *ent
>  	memset(&mask, 0xff, sizeof(mask));
>  
>  	switch (entry->function) {
> +	case 0x1:
> +		mask.regs[X86_FEATURE_OSXSAVE.reg] &= ~BIT(X86_FEATURE_OSXSAVE.bit);
> +		break;
> +	case 0x7:
> +		mask.regs[X86_FEATURE_OSPKE.reg] &= ~BIT(X86_FEATURE_OSPKE.bit);
> +		break;
>  	case 0xd:
>  		/*
>  		 * CPUID.0xD.{0,1}.EBX enumerate XSAVE size based on the current

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly


