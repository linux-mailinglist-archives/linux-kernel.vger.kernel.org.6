Return-Path: <linux-kernel+bounces-541237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D30A4BA54
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500B27A01A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D5A1F0E2B;
	Mon,  3 Mar 2025 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdnZ+zkO"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24121EF376
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992938; cv=none; b=YyMN/W5k+lV1K6ssKPB80XAFu/gXNsPCTXdd2juFCcfktK8YIgbHz6jIMEwNfOgrwTRmquazp1aaUSZovJ+V3Qwv1HqtGSy+5ysHECFbxUsTm5VT8wtw0i/R7QH79SHgWGZnCBA6a8XqjEDQ+g+BSyrWPp+zrspgcXLgiZiWE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992938; c=relaxed/simple;
	bh=5qkLkijq1aHVBAJe+pKnmmcboRU43L52rr+dVfewpTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIcJgsDboe8UUn2XknllOzP9JnO9sFPEcS0hCvbegMU8Le3C5+drPt7Tn5gujQJQ3Et4YjrHJuRd/tHcOk2Fwz/hPzhAJF+55Yg2uLLFr+KOzxc21/c25Xr2VdwP0tyCQKRkqL4iTu28j57OcpitKEoKrDbFzsv9ubQB/5IU05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LdnZ+zkO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390dd35c78dso2708584f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740992935; x=1741597735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=73r+pPBFPmA5vexT3Ec5rGd49/E5Soa5Y1/Qzc7kIO4=;
        b=LdnZ+zkOpYJrjMymLaQE50OI46e72jhUhFQOQ7S0AJ1Bqu7O8Om5aoK1l624PLoBw6
         cdBwwQF1OlQ40AoD+YNfyZTgNMTGE+9ghJU8Hv/YXY/pmVwhPFtB2jIL2tAClXfHhTxM
         ZlGS5VqV4vWHuV//G71OvhfYYxE4Wl1woFedPBkMQ1mrOi1qPRs2VGQY+ZQZpzHBs8Pc
         PePwOuKJzb/0wO0gFUIimFSWqNhZuiVa7zhUKAWdwi6WPBD6y8Vm4j73gOUXjQNUu/4N
         E7GkGFP64Q9XyXPM4i/vt7KF+Ik5k0IPwtFUzmKp5NHoBxYC5YA4fIPW8LId/K0rhHmT
         TmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740992935; x=1741597735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73r+pPBFPmA5vexT3Ec5rGd49/E5Soa5Y1/Qzc7kIO4=;
        b=IokmYBnVZLFWJ+TvNgFw5mq5nsWc6JueeGNLS+qY+RuwrCFcrNSnjlQWxRXbfIUAqG
         glnl1y7NGDnlVKfRtTung2GS3lY0GnDvRetX7OsBSP964t487fcydRvqC0q+qVvrse+7
         JDn1w6QCmcl0PiwVC13PBz3Euih1vitGKYhwQ/8Czp6jIXhMCEDYXKgkUEKcGgFhWZfQ
         vF2KhXXye+p0RBTijJlUMpZUYDKLz1C2ue8jOgjsGbCYWIiHGv7QZkSl7WLuStFmtjwZ
         +zhpMl1ed0aV5yPy2MS+M3MkRkcgssjITA17rk7BQw3tx8tSjH9NomebqCmJcCr4hf/w
         Nt7g==
X-Forwarded-Encrypted: i=1; AJvYcCVlZyz2Lp5vAXE+u8E3lfcfZ4Pt9TAjjWeqfUbm51HsM9rHnOzlDGx+qvCWWS9AAH1w/u77YiqxzExB9+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9Q72xmmACngh1js8OEWRHi3g1tVXvtJx6xeVEyfmpuI+RzDc
	8jn1gzLiqcZ0nCBheEzR90U6XBcXbglEA5goJbnrjNwKkE3B1U4ywa8n/DFVAQ==
X-Gm-Gg: ASbGncu8d8s9fd2KAz6ge3+gL3qxr8SzgrXHk7UkgNSEip6TWw7yVZv55Ca8pH8qkOI
	b0WSyNJZfqQ6cCcBycVnuyr9KUWB6VgIQxbn1HRk6+56UnSU0tSs6OGmzVDjg0LlvUPiEzvHxNf
	X1rfALFsl56f2cJ8LqnVtS9ZZs/GCoh27zsiUFGuKsg6MK+3Z9SmplhAcUXD0ksEIJkCvamK/UW
	xDaNUne7dFk35Q+GreLODTsiXZEGyWfqn2ZqEDcp5A2B7aj0tqTLxZRG6JG3LYAlLvtjKx+LxCv
	DfZNGCClWicPjf5QO6x7T9DQwjNKtjOgr26P9ASvFHKaBOjTYMw3Q0PShCEFWkjoXwQL04KG3nr
	LlWHqQCDw+Kxl
X-Google-Smtp-Source: AGHT+IFulJGyYMQXTykjX7NCa+Iy43Ll73kEXzRosIE/q2QvgywumoNWk3nbePvrLXe4q9Ef14rB/g==
X-Received: by 2002:a5d:64cf:0:b0:38d:b12f:60d1 with SMTP id ffacd0b85a97d-390ec16ad09mr11136503f8f.26.1740992934969;
        Mon, 03 Mar 2025 01:08:54 -0800 (PST)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7a73sm14106715f8f.50.2025.03.03.01.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:08:54 -0800 (PST)
Date: Mon, 3 Mar 2025 09:08:50 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Quentin Perret <qperret@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/9] KVM: arm64: Handle huge mappings for np-guest CMOs
Message-ID: <Z8VxotNAW9CLogum@google.com>
References: <20250228102530.1229089-1-vdonnefort@google.com>
 <20250228102530.1229089-2-vdonnefort@google.com>
 <Z8IGcA6h6hZx7ujh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8IGcA6h6hZx7ujh@google.com>

On Fri, Feb 28, 2025 at 06:54:40PM +0000, Quentin Perret wrote:
> On Friday 28 Feb 2025 at 10:25:17 (+0000), Vincent Donnefort wrote:
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 19c3c631708c..a796e257c41f 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -219,14 +219,24 @@ static void guest_s2_put_page(void *addr)
> >  
> >  static void clean_dcache_guest_page(void *va, size_t size)
> >  {
> > -	__clean_dcache_guest_page(hyp_fixmap_map(__hyp_pa(va)), size);
> > -	hyp_fixmap_unmap();
> > +	while (size) {
> 
> Nit: not a problem at the moment, but this makes me mildly worried if
> size ever became non-page-aligned, could we make the code robust to
> that?

The fixmap doesn't handle !ALIGNED adresses. (I have a patch in the tracing
series to cover that though). So wonder if that really makes sense to handle
unaligned size while it wouldn't work with unaligned va anyway?

Perhaps just a WARN_ON() then?

> 
> > +		__clean_dcache_guest_page(hyp_fixmap_map(__hyp_pa(va)),
> > +					  PAGE_SIZE);
> > +		hyp_fixmap_unmap();
> > +		va += PAGE_SIZE;
> > +		size -= PAGE_SIZE;
> > +	}
> >  }
> >  
> >  static void invalidate_icache_guest_page(void *va, size_t size)
> >  {
> > -	__invalidate_icache_guest_page(hyp_fixmap_map(__hyp_pa(va)), size);
> > -	hyp_fixmap_unmap();
> > +	while (size) {
> > +		__invalidate_icache_guest_page(hyp_fixmap_map(__hyp_pa(va)),
> > +					       PAGE_SIZE);
> > +		hyp_fixmap_unmap();
> > +		va += PAGE_SIZE;
> > +		size -= PAGE_SIZE;
> > +	}
> >  }
> >  
> >  int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
> > -- 
> > 2.48.1.711.g2feabab25a-goog
> > 

