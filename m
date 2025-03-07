Return-Path: <linux-kernel+bounces-551008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631D7A566DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9D1188A455
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917EE217F5C;
	Fri,  7 Mar 2025 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KeXjAM2m"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D79149C50
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347321; cv=none; b=ugSpMZ1268XUSLG/7muFgCnp35AVKlPm9RrWfjtPM5N05GecpMznRkAt2ySuAbz6RqV1TbMTLVVekZIOqxslZBniXkowQznloM2BCn7m56Xdb2R/ukaJpLmwOhENk8aNLzFbqPtVZqAnqOoGMLces0t6496PRrO8gmWeOYvnsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347321; c=relaxed/simple;
	bh=IoVuQEdepfRvzlxrsClyF2IYX1axCE/yG9AQE63tqvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9/3RR9REANNCyPe9S5Vh6MhE07PV1tmY93VWnq9oQHLsZHD4zALKhUG2ZWZ00gqexT5MorREVhxR4JayJ7wSGdzGisjMTI+b3+mICQtvxliICausWhndxF+LcBe/AT5q+oNLfuheVTb2gaBTxtTMc9l6fQrqIdm+NT5aeMhJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KeXjAM2m; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bcf9612f4so14407885e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741347318; x=1741952118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNAp1guL3DdfnvorYMboaljiCgvGEgEmNmgxMM62RUY=;
        b=KeXjAM2melpipyqoZIWUosAUkVtk8NI+fOZXxU06Qq0cnE1BwmuGHiAiufwpCEHGFm
         uK02oXc84TTp5SZAJF4KRyS8RWW/KLfqgWIDgxiqOfkMET6dQRIHBNnx1DLsIaw2JD7C
         nJDXl2T/a94zqG8yIJmBxv/5dILpIwx/YAg66mTuZIxKbCFXfuLWFDrOIaf9/8XRTTsP
         7rGjQRx5/3YA6xcWuwD/JqLnQ57HGVVj/fosg/8CTZFG54eBgzLbXhyoOQizrnCQxNSf
         xH2/g4ZLlak+wJvIN9218EDVwWqhift4KsJoUa/jimW74qnfMBjyMNKH5HhLOR2cWksW
         b5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741347318; x=1741952118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNAp1guL3DdfnvorYMboaljiCgvGEgEmNmgxMM62RUY=;
        b=Z8cJkaA7+R/wVnByDVouG5NL9QCzyk/lbbrkqvqZabfrY2j2lMDjppwEGgZA4uzc4k
         xtx4770ZQ2fpXSGs6FbPIz8yNvHRYwJg9GFyCTpK1GAJrQxnjTCoy+wqfvqDLLCMLqhL
         I5TXwTJFQQBZKayn1i4Xab9jY3xXOEFyECJ1K6ukeSDl0AT5zWxF4GMwHH6gi/L4E+eo
         /hgfW57lMyadQRXuSHRSjcv9ShfDz0+jRq+XJHeZrxEVbUDddrZT1yYpFgCWfer1+3Vf
         krG0+gckYVNF9TW5O67N0klFp4Oy5kLAc7+Yaw0b71XueqiMH7IWsWoshIntVqxetp6t
         ykMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZcLf1CaV+9N1GecrP1gkFzeIvnZD1iVXR1NR/3xU+CB8/Z6vy1WWxgUaX0LEDcN0rgpeBDCM5KAfSzgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+F3NYI238SFaGQj0nv40SoyfQ39Urp2CDXJGgUmc2NC0k1MCU
	+cj95gFdYMQzk5S/+SNbAHV6lfCQyUuo9cx4M/6p5Qusafq9BbKm0wq6/JKIwg==
X-Gm-Gg: ASbGncuREBWq3dgzdKkxOn99uYHyCqbS95cusDGzrVumz9VupgEfmW5Q17LkYldjCl5
	G3ex8DJA4GjdC8AA1GzuxOGgWp8VOjQdrlIPqjTZtlyV7YCg7iRlyJM+C4K9Jas6IfxWlwRDwU3
	HHZpTnlFhUQ6ut/WYNZz1GRQlh2HyF8UHCdtUtkXbsay6wJBobUcaqqsBkFJF6Z9J7uEsQRD3dB
	Xr+PUewsOv5SytlSX6YdhLHk0VkUEShcErm8Wsb9lAWz4DhNmzYnXKAq43Tnluhj58suAHC2+qV
	QN90jeg8Yq4qhkt3EkaPIAg6hugrX/NMhZmaeqCrr5BZL0dOVylny+mA6KlIppxNG69M9VUZo9C
	XqwIo6yGdfrr6
X-Google-Smtp-Source: AGHT+IGjS32YvEDJ0dggC62JcymX/iPFtuS61I6Hr817oYxnTdUEtKfb2H4jSY7/r9bkym5Nc7UyVQ==
X-Received: by 2002:a05:600c:1c92:b0:43b:c284:5bc2 with SMTP id 5b1f17b1804b1-43c54a13899mr24034885e9.0.1741347318291;
        Fri, 07 Mar 2025 03:35:18 -0800 (PST)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01957csm5051720f8f.47.2025.03.07.03.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:35:17 -0800 (PST)
Date: Fri, 7 Mar 2025 11:35:13 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	qperret@google.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v2 1/3] KVM: arm64: Add flags to kvm_hyp_memcache
Message-ID: <Z8rZ8bBnSllaZCEs@google.com>
References: <20250304134347.369854-1-vdonnefort@google.com>
 <20250304134347.369854-2-vdonnefort@google.com>
 <Z8qeIPfTOJU6w_8l@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8qeIPfTOJU6w_8l@linux.dev>

On Thu, Mar 06, 2025 at 11:20:00PM -0800, Oliver Upton wrote:
> Hi Vincent,
> 
> On Tue, Mar 04, 2025 at 01:43:44PM +0000, Vincent Donnefort wrote:
> > Add flags to kvm_hyp_memcache and propagate them up to the allocation
> > and free callbacks. This will later allow to account for memory, based
> > on the memcache configuration.
> 
> It seems slightly more obvious to me if we pass a pointer to the
> memcache instead, but that's just a minor nit.

That sounds good!

> 
> Unless you have a preference on this, I can change it when I apply the
> patch.

I have just sent a v3 to save you the trouble.

> 
> Thanks,
> Oliver

