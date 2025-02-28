Return-Path: <linux-kernel+bounces-539225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4177AA4A239
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188FC3B7295
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD1E277033;
	Fri, 28 Feb 2025 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVEWUnYy"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4938277015
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768888; cv=none; b=s5NpzkpY0hSdMuRHK7nGSw6aZeZsOBjaI/RsfePALBRW48JXZHtynEt9tSX74BtMVfDrXfn/oZfBCF+Xgb8gm1FiKo7I+1+wL1PeIObNUjLwEMmZMEbuUNRGE+X+QIQi2ASoh9P9mlslUMmhJ7cyWRWJGyNnwscVekhLitNtGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768888; c=relaxed/simple;
	bh=TYvRxcLgN1IYxafXpxrr2T3Ke1WemjDAQaAfqYgyWxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi1OhhHp6AP/o9A4kDxSmYyQmO5B1VyEOBokG4vS48++96kohPZ029Fr2/Jfpslv1m2KPqNelG2x1yWjWl61bm7PXVEAKTkwF6Wl0CkRedv1VUWLaq4TAEdJiiexS2aI4rGEdC9jEGU0VqtqgMMVZgHeFpL74bLs9qJVONtdnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVEWUnYy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so474260666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740768885; x=1741373685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppwxYptxUoJTBAvtQNONLY3e8TNhsTgMXgKzmUOztsk=;
        b=kVEWUnYyGbgDtj27DSJxlFHL0bLgpZ8a7djRfLFJnOaFGZQgq5bGSiJ/im6gXw8vgu
         bPApctZ2JH1kCg0cKH9o1ySUFpj7VOXochyI0HpKa7d0buyNPHHeq7x9ToySh7mjrTMp
         6xqcfnULTXoC8mJQq5CotWu8KRpa9vWXrkbB/0GjG3ZGSQJPISC5zFQwQ/GMosDgMEvG
         vQ3RB+PZvD7ULSSvAxlEbK9kAYddz2OFwSmxm5svMFghIt0dMqnarnGtHIMYqyh/4cig
         pXv5pnHnDN7NQ47yaoNl0uS4M7BJGJEk9hNIW/gFrB7vHqJgxvBZhjBw8VfrR/eOyv/+
         tL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740768885; x=1741373685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppwxYptxUoJTBAvtQNONLY3e8TNhsTgMXgKzmUOztsk=;
        b=qM7GIcuG3lpe49AvSTiNw0WJp+bpPJNIti5warXD6yeGSdcCQsLK7TevuTQhb65rw5
         NWjbPc5pe2aDqMMsOI1P2xNF7t1+lRegCOsHljxW7lzcGrOoPo3ZGuYxk3UmgGgtB/UR
         UVldsvYhprlQzt2pWV8vC3TorZLv5uMCWzgtRKj4n7tXg6vSUyVvfja1s8vipaI07sTr
         sgRW6Vq7chUUVUhcRxgt1qx2lYJekU4Bg96YNaKeOEMqqO9ikl0rOZYfofVEDDKgjrdQ
         ZCX9LMyKTqhQp6qLCCYalSdDe0xIuOQQwUc9RNo/mAcLrYjPWMKM/0ZLl8WTMkTJ6cFZ
         EZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj6MxMLA6b0vFl0g/9rHrnrbiXN1uiIWAOrZNUgmErg9GzMQM3zW9288NuCrTVT04iNZCRLAEd2tKzReg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlukENwqUpzudW4NZyBLO153Uz7PNSgg0l5TLT9ouLBW2y6tY
	edBngicTzHTr8+ez1yEfIQIV41EXv+MLeTrQDrDZcaCy5QvYvLIacQHME2JoOQ==
X-Gm-Gg: ASbGncvkKtETRcsc1rU/mxV8TY02D/i63cqWgKUYfaPIbfMdxgqQ3kArkWak5ytxA9P
	59r962UbrW1Gl69MjpHAvxppEoCVNJZ1WgVkqWtoPtOJBJQmjZI0MPxXJbgp8oN+/0cawCEuF52
	OcWf3V1PSANz4/ptDX3VxiJM1ySlQzDeWloIau8tDJR76DpAwo965A1wU3r3JlDmTfUneSo2v5Q
	S5W+lq0wS2na10bqsi7M7OMpBxgjTPSWFh/GLY0W7MKsIs0RNHt3tUnBuk1G36cWPYZxdUu+5uJ
	c3BGjmuX8ywp+P5nX9K47w2+uSHF/WAzFTtLi1dNr7ELVUuE/vMrvnwKqL/zEf8=
X-Google-Smtp-Source: AGHT+IGRZqJXTWPcNybDnAZQX/clH2G/w7qq2Cr5221PpPPsrD4hU6+CM6oIxOZll7K724ZB2dG1Dg==
X-Received: by 2002:a17:907:7f94:b0:ab7:be66:792f with SMTP id a640c23a62f3a-abf26837d32mr566881466b.49.1740768884775;
        Fri, 28 Feb 2025 10:54:44 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0ba408sm331183566b.37.2025.02.28.10.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:54:43 -0800 (PST)
Date: Fri, 28 Feb 2025 18:54:40 +0000
From: Quentin Perret <qperret@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/9] KVM: arm64: Handle huge mappings for np-guest CMOs
Message-ID: <Z8IGcA6h6hZx7ujh@google.com>
References: <20250228102530.1229089-1-vdonnefort@google.com>
 <20250228102530.1229089-2-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228102530.1229089-2-vdonnefort@google.com>

On Friday 28 Feb 2025 at 10:25:17 (+0000), Vincent Donnefort wrote:
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 19c3c631708c..a796e257c41f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -219,14 +219,24 @@ static void guest_s2_put_page(void *addr)
>  
>  static void clean_dcache_guest_page(void *va, size_t size)
>  {
> -	__clean_dcache_guest_page(hyp_fixmap_map(__hyp_pa(va)), size);
> -	hyp_fixmap_unmap();
> +	while (size) {

Nit: not a problem at the moment, but this makes me mildly worried if
size ever became non-page-aligned, could we make the code robust to
that?

> +		__clean_dcache_guest_page(hyp_fixmap_map(__hyp_pa(va)),
> +					  PAGE_SIZE);
> +		hyp_fixmap_unmap();
> +		va += PAGE_SIZE;
> +		size -= PAGE_SIZE;
> +	}
>  }
>  
>  static void invalidate_icache_guest_page(void *va, size_t size)
>  {
> -	__invalidate_icache_guest_page(hyp_fixmap_map(__hyp_pa(va)), size);
> -	hyp_fixmap_unmap();
> +	while (size) {
> +		__invalidate_icache_guest_page(hyp_fixmap_map(__hyp_pa(va)),
> +					       PAGE_SIZE);
> +		hyp_fixmap_unmap();
> +		va += PAGE_SIZE;
> +		size -= PAGE_SIZE;
> +	}
>  }
>  
>  int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

