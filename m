Return-Path: <linux-kernel+bounces-449233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1522A9F4C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3ACE18954E6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3291F8688;
	Tue, 17 Dec 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6yYx09W"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4F01F4E24
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440911; cv=none; b=gkyY9DO+zpVw7ANPeyyR6iBgwPGqtGrMsAc3e4IBVk+9FUgI59V8OIFjzyQ5GQORcLpbWG5mP5OGD7gbBykWnEGvXjY13FtJx1xMWZE3GRIty9dXPeNObUH34QGThGcp+6GlNLslZzmzytIJc6QJJ56/jgSWcI04f2jqy/rWsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440911; c=relaxed/simple;
	bh=A15dhjFUApKDLBTkWTdNxfsteBwmhP1rdtBlLWCGnlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qsl0I8JYyM1qEuE78xUjQjVIkNioyYLPaAGNRdl2E6voxCO2Zb/xFMMYDYy9gPhf4jGKEklUNzweLyt/0axJmc9GWE1l8pLzBOszcBTKs4IpO3YrpUz7flcJKhxaibp+fBUDiGquTxBpDrS0dn5bZ5ffSFqPG1knzzkQWPI74wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6yYx09W; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so7311454a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734440908; x=1735045708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8OYND6fn7kYwT+1ERcVanRX0/dhZjw7OVtcr6DSH24=;
        b=t6yYx09WNcw4hFqya+725P8bB7Irwr5/mlv2T4QTwTwPtdXpJjtEOiLYpk84ZNRgKj
         ttmxQuQ7G/as5SfT9xZxQ8WAObryQuFSfCLCZAbgxm5s6qKPqGd2r6hqBnOx5ZGejmOd
         34Ly/6hBH7kTzWYPg1dp247Y9dZ4/zZtOUza4eAkJitTcECNLMoS3MsTrYULOWyelx3E
         HrxI3JVGPAPtL1T/IekUoJ495JdTFX0ZFPOdChKv3mjwhnPiSXh5FTJM69+LjrsxGuVw
         lhHhT3cnFtjC62ro1wfCJiO8ENkjGAx0g1IkPnAHCha016ix0cO2CyPrAjVfnPCSKC+T
         BIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440908; x=1735045708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8OYND6fn7kYwT+1ERcVanRX0/dhZjw7OVtcr6DSH24=;
        b=MUubYZUdyDrKjVPr0tKJVe/fBOWg6IoBuSaf+mjfon+2c8zepJs28Kq0IFW9y3CD+W
         lJJK7v7p2FrHZ899n9K7VOofwiAJS/4kQLmG4Qc3PBjrw2/huV1Q6boAghnHZT/CSUbN
         crpv/su7Fp1BJUSBvkqpmMP9esu/KNvwqYr0hY5uSUm9BYIhS2NnNFokGjC6buPnR7aI
         xpvRPn/N1yX3Sa+VbERETJXX2GTX7yVQMCq3QCF78AQgU1+6hOgjVPX96DYV4adx3UER
         F9w2PLZIRg3wIOTalrRwlnaHu8Kp1EBBDoyxtnCy9mV/ak5/91V8+Xc9gxOPF6t3xQbY
         BYrA==
X-Forwarded-Encrypted: i=1; AJvYcCWAFWlBEcaK+JWlmO5JfIhjI1SAzl1tepUamgpWnHTrvEWJ7ZHerSEK1BO5IYXHimhbPYBuNLONLKbw6T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmL80zysegckl8efJKyBjdf6F15u9BUlU2R/9JNOOBE8hFC/wi
	eDtw19lJOwNoAkh0sklB9uv57BqXTmALD7p9BM8RWudkPBqU/j34TWRVTgypfQ==
X-Gm-Gg: ASbGncsEHmA6385QKlhPrcpwrUg0vQIIcZn3rxYTN9pmVcEoIB5OqxFtrq5NJGHQqwy
	lVT9b0CUFMtqUlkTtF1G/VoQWBwpojLmpMI9puyFjlUDPnAm1jrkuD24RopsCnIepK9aVrkZTj+
	nUzI6r4KddzeiwZpwOXtotvmapw/hIlPypTlvNwyOtgapPtRwM6bw9vg2qOhhVQg+O+ksnSGXne
	DsJ7mKFKMP3b+IED94Ou5B725pkvJFp7DezrABne/oux9Jq1RVIm4OjTCJgBgAYK7lDOjnix5Qi
	aq8apW5YiJUaj2A=
X-Google-Smtp-Source: AGHT+IHU4tb4zHbFKvDOUJ9Ob7TRBXCdnvvA1xIyi35Z/f8YS65dxxBPeEBOCyi0d2KP9W+sPCa32A==
X-Received: by 2002:a05:6402:2690:b0:5d0:cfad:f6b with SMTP id 4fb4d7f45d1cf-5d63c30684bmr14855753a12.11.1734440908222;
        Tue, 17 Dec 2024 05:08:28 -0800 (PST)
Received: from google.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d7c043e7d7sm2050482a12.35.2024.12.17.05.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 05:08:27 -0800 (PST)
Date: Tue, 17 Dec 2024 13:08:25 +0000
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
Subject: Re: [PATCH v3 03/18] KVM: arm64: Make hyp_page::order a u8
Message-ID: <Z2F3yY6DwUBmTtnr@google.com>
References: <20241216175803.2716565-1-qperret@google.com>
 <20241216175803.2716565-4-qperret@google.com>
 <86zfkur329.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86zfkur329.wl-maz@kernel.org>

On Tuesday 17 Dec 2024 at 10:55:58 (+0000), Marc Zyngier wrote:
> On Mon, 16 Dec 2024 17:57:48 +0000,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > We don't need 16 bits to store the hyp page order, and we'll need some
> > bits to store page ownership data soon, so let's reduce the order
> > member.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/gfp.h    |  6 +++---
> >  arch/arm64/kvm/hyp/include/nvhe/memory.h |  5 +++--
> >  arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 14 +++++++-------
> >  3 files changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
> > index 97c527ef53c2..f1725bad6331 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
> > @@ -7,7 +7,7 @@
> >  #include <nvhe/memory.h>
> >  #include <nvhe/spinlock.h>
> >  
> > -#define HYP_NO_ORDER	USHRT_MAX
> > +#define HYP_NO_ORDER	0xff
> 
> nit: (u8)(~0)?

SGTM.

Thanks,
Quentin

