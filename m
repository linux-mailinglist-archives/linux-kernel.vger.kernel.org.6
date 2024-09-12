Return-Path: <linux-kernel+bounces-326868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C964976DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4475F1C23B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86B71BA29D;
	Thu, 12 Sep 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAYjBf6i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9F18C90C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155443; cv=none; b=O54lkzh0JFlwDOCEQPwdOoc+AAfWYeNdjMMHtYtLGQyUGbWllHrWxcrG7AXLyQkOCPs8bqWmw4eoGGBxxMK+OyoENPKN8azrlFscvCmQ4gIbU82k890RGs0n2zVltytmRxjTTF8Yj4PRIHeyzcnw9fFCfSjLAND5QupgauaA2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155443; c=relaxed/simple;
	bh=cEEKZ0yc4WxAK5OYKnZTo8Ykusk2IEEUB/2uepHjovg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYsSUSY85wzQxQHLvCyrOEf2NIEl+eu74w0EffiKto1ilU7G12jJx76G0359/F6ehwEvrQzfyAbnlIas27vNAESF/fefUY9DcQEbiM1I64FrPTs9i/JjrnjAW2g3nVVOiKes2u+irbJeTzY5+WLG5XUVzs49zWlM8JpHSQlTF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EAYjBf6i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726155440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cJBcvCFq/HwgNdpAfecYvxM1im2ig/oEquJyq/fPvU=;
	b=EAYjBf6i0yDjr43tjMjYAoedq1UiuD9hBSKmmi7CVucDx048Op4pkxfABr23j42uEM3L2Q
	ZhiAub1D80OSq2k+r6racXsA3d8E2gMyEYy1IhgY3oXFAtVEBSlz62gyY2jIOxi1TyAhe1
	O3Gy4juuG4Lxk5l4wglrTlhWgt1vUVk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-bU6Sp-RwNuW5GmK_W66m0g-1; Thu, 12 Sep 2024 11:37:18 -0400
X-MC-Unique: bU6Sp-RwNuW5GmK_W66m0g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374bb1e931cso1161594f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726155437; x=1726760237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cJBcvCFq/HwgNdpAfecYvxM1im2ig/oEquJyq/fPvU=;
        b=isuUCR47zJoJsAz4VuY/cpjCpq85pt+GRQzvlzZReNnyW0+4T57N46+qhv4h/t+zcI
         thdaouuE8SN1cjv6Fs182ddHSeIHIo15nPe2ebrxM96rCXiDNZ/aucmCqxXrJhKMoEtX
         AiDt2OaxqzMuqR6VazrVtU82k9j1dkgEObcbmLeEpGomKHA960QkAHQMm0OxcttHOgyw
         PC5Qf0Q17R92m0Gf1/29gBLM2dC2DIkqdagThf5tHyLOzRqVPvUNuRCcAni8Tbs7Wevc
         Wjz8KYDvkR1hY+JXN/XpJ9v8r6wOC2e6datJkk3aOgOOzX/ujnZg59lpiOCDUd7AR0HK
         NPGA==
X-Forwarded-Encrypted: i=1; AJvYcCWT9BMPY4AQyqQmL0zIGxlwYmGpJIuCKTIn2bV0TWt2GFLWxz7AxhlQMqN4uZO8OqtZATf5dNx/HaJ5IWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfs9njftHMuv5v2wNwKKAqcu3X5HolnaJ25MvgYCNI0XIIbfjW
	xrGjPY2z+ppXeqCcikXDz6mkpvX1VHuKZ0s/XTgRFBhb2hbKMZfHYyRpv8/zSw9HgU7GVEfEgxA
	Ee+kxiLsiY7JY/ocuLzTVtW57rezEDi5tWuJQnD0Rmh/iYlnG68+BxtVXLw1nU+F1paicIH1Vri
	YK/GkzyLeGwRqwgRXGGA0C5tTD+8txrzxvAMyT
X-Received: by 2002:a5d:6582:0:b0:374:c21a:9dd4 with SMTP id ffacd0b85a97d-378c27f920bmr2091229f8f.20.1726155437489;
        Thu, 12 Sep 2024 08:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDr/ETXhSBCXnBltJraH9uNK9CYjqEQeHbXIVHj5zFg6GxTqVGpOUbIg4B2kFrRn8OL1sx4Q+tZG5NOcHa4bk=
X-Received: by 2002:a5d:6582:0:b0:374:c21a:9dd4 with SMTP id
 ffacd0b85a97d-378c27f920bmr2091200f8f.20.1726155436928; Thu, 12 Sep 2024
 08:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-26-rick.p.edgecombe@intel.com> <05cf3e20-6508-48c3-9e4c-9f2a2a719012@redhat.com>
 <cd236026-0bc9-424c-8d49-6bdc9daf5743@intel.com> <CABgObfbyd-a_bD-3fKmF3jVgrTiCDa3SHmrmugRji8BB-vs5GA@mail.gmail.com>
 <c2b1da5ac7641b1c9ff80dc288f0420e7aa43950.camel@intel.com>
In-Reply-To: <c2b1da5ac7641b1c9ff80dc288f0420e7aa43950.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Sep 2024 17:37:04 +0200
Message-ID: <CABgObfaobJ=G18JO9Jx6-K2mhZ2saVyLY-tHOgab1cJupOe-0Q@mail.gmail.com>
Subject: Re: [PATCH 25/25] KVM: x86: Add CPUID bits missing from KVM_GET_SUPPORTED_CPUID
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 5:08=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
> > KVM can have a TDX-specific version of KVM_GET_SUPPORTED_CPUID, so
> > that we can keep a variant of the "get supported bits and pass them
> > to KVM_SET_CPUID2" logic, but that's it.
>
> Can you clarify what you mean here when you say TDX-specific version of
> KVM_GET_SUPPORTED_CPUID?
>
> We have two things kind of like that implemented in this series:
> 1. KVM_TDX_GET_CPUID, which returns the CPUID bits actually set in the TD
> 2. KVM_TDX_CAPABILITIES, which returns CPUID bits that TDX module allows =
full
> control over (i.e. what we have been calling directly configurable CPUID =
bits)
>
> KVM_TDX_GET_CPUID->KVM_SET_CPUID2 kind of works like
> KVM_GET_SUPPORTED_CPUID->KVM_SET_CPUID2, so I think that is what you mean=
, but
> just want to confirm.

Yes, that's correct.

> We can't get the needed information (fixed bits, etc) to create a TDX
> KVM_GET_SUPPORTED_CPUID today from the TDX module, so we would have to en=
code it
> into KVM. This was NAKed by Sean at some point. We have started looking i=
nto
> exposing the needed info in the TDX module, but it is just starting.

I think a bare minimum of this API is needed (adding HYPERVISOR,
and masking TDX-supported features against what KVM supports).
It's too much of a fundamental step in KVM's configuration API.

I am not sure if there are other fixed-1 bits than HYPERVISOR as of
today.  But in any case, if the TDX module breaks it unilaterally by
adding more fixed-1 bits, that's a problem for Intel not for KVM.

On the other hand is KVM_TDX_CAPABILITIES even needed?  If userspace
can replace that with hardcoded logic or info from the infamous JSON
file, that would work.

Paolo


