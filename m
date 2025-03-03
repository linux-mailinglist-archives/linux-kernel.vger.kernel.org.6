Return-Path: <linux-kernel+bounces-541305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3406A4BB20
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67FC1892C15
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A6D1F0E50;
	Mon,  3 Mar 2025 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMVGiFia"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6D1EEA27
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995275; cv=none; b=K7yPKvbGvfakhIgXsLCn4ipjZrx+W9hjhztLzNYT3ltOKBiiMO69I3mVYMG2Rp27N5lHxh5PpUMhs8xDMF7+iKYU6Cps7sPDOdE6wyOIFsvlqTPsD+COLcj1k51+Rnq6+2bnKEInu92/Pxl1gNRWMUo1KTRB3OVY3ZFX7OZrudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995275; c=relaxed/simple;
	bh=sSIGCV1NJMucwdo63O6AoWB/mxERMptnXw9CEzSBXF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWVzsVcRd31Xv2VO6NdwEs3cCrrxYoAviguvRdWMhYtVEpE5V5vVNMGnf0mVO8mbl/JTDWHNs6RaDZmHKq6WgNslEldGn/ynxVqVnpu6qUbz1unP6mfUU0LM2GLBAtQqBrlIVtqrGm1oIhYNwUn1vmufFHrzPCgsZSQIaWEz1jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMVGiFia; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390e3b3d432so2848214f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740995272; x=1741600072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CKA+Otx0H3SSzEwciVvwkw/A8oV7+p3SzrtXzaI0oPU=;
        b=EMVGiFiaNY+4UvYFViW27GkVsczugurb+IVX63QVpn0DJwf58p1Ko2jiyKlcasrfPv
         zzCNuTjg7ThRxPfDwmieflnPEpGRb7uZRgRCamggnJxLYogkBRTaPQFCEZUIKTRbIwCM
         SlPv3A6lx/0y15lmLyoPO/2BxzJF+dMPNfX4Ccz4vfALVW6Oi2rjklt7T33w7a4ZRb4I
         /FJ7bMypa2KsgLftsNL57vINqnlJuW/qkIJqwtiB5Q8SLS/3+ToN637406X4S3ooIaUc
         CH7GKkN/Q11hRZt8vQeehQFnH4CsrfqOp3bDnJlRNan2A8TOjwTcj3wbUgO6Xcv8FBj8
         ETng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740995272; x=1741600072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKA+Otx0H3SSzEwciVvwkw/A8oV7+p3SzrtXzaI0oPU=;
        b=fpezy3PTLAgldmDhb/ovGA4pEg4sxbKOmkuYGMlQxmMF18/bOp9HP5TL+fZZo3wsiY
         w5Ag0FmMfaFU02zIVSIiBWsJ0Q9alyt4u6WL7Dm+WIeGkmGvBWjT1Dvkj0ZI/xi6tHz8
         5dR28K0Nlo1aLfAAl44YEd8cdqFIvtSBP9+15bBfB8iGpx/qIK0sdKPTKeT+t0zJSGkC
         4IZSsicVodkAuDJGY9Br48T2YCB62/DXLCThrqOcXnrK5lD1A39pKoAJGS1nhvLAe7sX
         Hn8uuWCdudDz6V8oUI2x8Xlkz8blF5n631fSZbrP9waJuh/9btENoAeqtRN5C7BPqG1T
         Hb/A==
X-Forwarded-Encrypted: i=1; AJvYcCX9qqzJlL4yIuxaqQ11/PSytNUoylq1zgHeOMx+Yv+EGVVDWh8PgvgECuGDfY9NQxbmLRskGpat4mLhc9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1V4XxU7GS9PZIiQzwQUJE/6hWjR2K7Z056nN8G/OMzyuknh5U
	uzmdWGtp2d9jH9+M2SIq4QzdcpbmVp0Q1hrb9iv2m06p0M0zJpIvVx0AFDeTog==
X-Gm-Gg: ASbGncvlSLD6FWA137N7/akDE6Sm7pJ+Hc/nFWfxxOyyiH51pAoMD6EUMkYiJqGSsKg
	9Q9V+1OokTOp4dlnjwzJ0Z6Kyxs6jTSI8ryCYUu0D5bkCbVWLe4kQmpiXvgqJNy6jRnisReOVlR
	sJpawHp5PSxrru4YhjIflrtPK0aINEdKnS1jGFoabQ4Jg43Wwa8V7dOzO+bNTSM4Xq0XGB4D61K
	OjrRjeYLX8ig46/8QtFVpjZupucYARklF330+ZekcLUzr/hHDTOPM5KSi9IJilCZ1SgnSga3ZiU
	VU0wO1Zptj0EvnOLd1HUmnvzaFj+/pmCIcA4UiYa3/8JZxOMl0OFoJ6yHowNNoH786uZ8eH3zyY
	Vw9RiMrb64Rj/
X-Google-Smtp-Source: AGHT+IGZadExtmq2ZKN18m9L/PK1JThIrBLdkTgdsuEaaAEPwP3+f2+949dpjiKHv0jHI9BGV6sDlw==
X-Received: by 2002:a05:6000:2ce:b0:390:f9d0:5e3 with SMTP id ffacd0b85a97d-390f9d0075cmr4936619f8f.1.1740995272497;
        Mon, 03 Mar 2025 01:47:52 -0800 (PST)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796051sm14170400f8f.12.2025.03.03.01.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:47:52 -0800 (PST)
Date: Mon, 3 Mar 2025 09:47:48 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] KVM: arm64: Move hyp state to hyp_vmemmap
Message-ID: <Z8V6xOVCPp7OOX6g@google.com>
References: <20250227003310.367350-1-qperret@google.com>
 <20250227003310.367350-5-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227003310.367350-5-qperret@google.com>

[...]

> diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> index 1a414288fe8c..955c431af5d0 100644
> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> @@ -194,16 +194,20 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
>  
>  	/*
>  	 * Adjust the host stage-2 mappings to match the ownership attributes
> -	 * configured in the hypervisor stage-1.
> +	 * configured in the hypervisor stage-1, and make sure to propagate them
> +	 * to the hyp_vmemmap state.
>  	 */
>  	state = pkvm_getstate(kvm_pgtable_hyp_pte_prot(ctx->old));
>  	switch (state) {
>  	case PKVM_PAGE_OWNED:
> +		set_hyp_state(phys, PKVM_PAGE_OWNED);
>  		return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
>  	case PKVM_PAGE_SHARED_OWNED:
> +		set_hyp_state(phys, PKVM_PAGE_SHARED_OWNED);
>  		set_host_state(phys, PKVM_PAGE_SHARED_BORROWED);
>  		break;
>  	case PKVM_PAGE_SHARED_BORROWED:
> +		set_hyp_state(phys, PKVM_PAGE_SHARED_BORROWED);
>  		set_host_state(phys, PKVM_PAGE_SHARED_OWNED);
>  		break;
>  	default:

Are the SHARED_OWNED/SHARED_BORROWED still relevant since the introduction of
"KVM: arm64: Don't map 'kvm_vgic_global_state' at EL2 with pKVM"? It doesn't
seem we have any !OWNED pages in the hyp anymore at setup, do we?

> -- 
> 2.48.1.658.g4767266eb4-goog
> 

