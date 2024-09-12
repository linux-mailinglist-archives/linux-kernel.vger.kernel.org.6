Return-Path: <linux-kernel+bounces-326754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BD9976C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6FF285A95
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18161B9843;
	Thu, 12 Sep 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWW9yDkB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6C1B9829
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152421; cv=none; b=lU4/jCK/zCmgnoNyvxm+6AwdMaJgYl4Fwuqj1YrWGLOhNxEhFFqVb2iRu5/zRvLNgpH7WMytDYnrxmL2HruJYYZ4DgIezY3IlY25Ka4iRUSWIgdoXOBNRRLQ75lwdRAym0Hpam2TrpnK8exQdSBV8akw51l9WuFR9EZQLJkdjQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152421; c=relaxed/simple;
	bh=tpdgi4juBb051AiOwZ5loJ0Avk2Y9YVyXPUQ57w6zTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkNwBqtlvDviqv4fJQ9O+YQ+YkDvLZsGcrRoZFC4Y+/yC3H9Zrrt+TLOLT18SqTbdixzu7fAJpsx0sDxTcbYipfRbcR5DlTMHgVw6jsV1kOwwnyZ/1wTZvvB6tZY0U6COj62k2LCTqGuKkkPqtBGn0UgGFFnxAElLZpTQTkr9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWW9yDkB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726152417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpdgi4juBb051AiOwZ5loJ0Avk2Y9YVyXPUQ57w6zTk=;
	b=LWW9yDkBBnvJQc0+nXBykRoboaZyYWVBqj0g4nqgE0pxJ2PWFxAnt/DpuOC3oMOHfVa7ot
	weObX6hXjKzqPsqleHTqkFN3fECOSTk8MPI+K3hIG+W7mhVNgNnYR3wCU0WSErjoukKn5W
	TKWuDMRaZSb8xx6J7fc22kQ70FSiP5U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-7olfwgR5NemhXYeV--QTUw-1; Thu, 12 Sep 2024 10:46:55 -0400
X-MC-Unique: 7olfwgR5NemhXYeV--QTUw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cceb06940so7874145e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152412; x=1726757212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpdgi4juBb051AiOwZ5loJ0Avk2Y9YVyXPUQ57w6zTk=;
        b=nsUzsaD4XhUDh9i23IHGzsB1OVHHIy2bMUnX7c7WoT6fhw4tDh4vv6XCDd5CIt61uc
         w2b0EfC9WVvX7RZh8Z/EAut4QNM4nEgLbxX7XeUUuO/t4AGkWsnjfG8vglOuj5qdawTI
         5xioODKSSgABItbHsF8BagMXg8sgji8AdSKP3U2UD7xpa6wAhY/3s8rGdOm2XqMDgBH8
         lpqa63VgL7hWwzpCcDlNXXy73W3wiYqolKI+3+qdcpzc8NfTKylQz8YqGBjdnRH8FUJf
         TKeq40zFa5H8nAvK8vER7y84XXw6HjeSZAhUiy/HQjcRzUYsaY5e3p8xrTo+ullxISDG
         LVUw==
X-Forwarded-Encrypted: i=1; AJvYcCV7zxXbcVTY2JrbTEv/W+jpqlbgi+23gSNbKUidWK4IxnVmDKH5dqfofHreYsWUjnFmFpxZiYPDSiRt4fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nBW1/4PXpIwd9eKHG869ey6rCo6RPpX6Gqh04D69RX8X983a
	q+IkcYJnytsv3b7fEdaUG08Lcc4O7BhleaKfzgKVuL0AWNa9PPyLtHlLrdvbjlh7STBC0tYJR//
	L6lCLM6koiuGmNOHOlF7k0uVcxZbbEAfV1oJFF+p77Oxh23zHzsqDKpVGi0hNMOGIGQclsmqmeq
	p3CIZRFDRWBO2up33IL26FvD4Y9fjidwbgPm/h
X-Received: by 2002:a05:6000:128b:b0:374:c911:7756 with SMTP id ffacd0b85a97d-378c2d5a0b9mr1767659f8f.38.1726152412436;
        Thu, 12 Sep 2024 07:46:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXOt7eWeKrY/oke1uOUY9JGn1eMWvkplmC6z0F6bdmjBjP9Jctk6jvW8//ZU8X0ryKSQz/AKC9pD2uLCl6aP8=
X-Received: by 2002:a05:6000:128b:b0:374:c911:7756 with SMTP id
 ffacd0b85a97d-378c2d5a0b9mr1767637f8f.38.1726152411958; Thu, 12 Sep 2024
 07:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com>
 <20240904030751.117579-6-rick.p.edgecombe@intel.com> <8761e1b8-4c65-4837-b152-98be86cf220d@intel.com>
 <ZuLzl6reeDH_1fFh@google.com> <d5c49c918a86d37995ed6388c1e77cd41fc51c19.camel@intel.com>
In-Reply-To: <d5c49c918a86d37995ed6388c1e77cd41fc51c19.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Sep 2024 16:46:39 +0200
Message-ID: <CABgObfZsqf7BbXo0CzyDOAG=x_GucHt-kANQHLa=on9RhE_ngg@mail.gmail.com>
Subject: Re: [PATCH 05/21] KVM: VMX: Teach EPT violation helper about private mem
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	"dmatlack@google.com" <dmatlack@google.com>, "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 4:43=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Thu, 2024-09-12 at 06:58 -0700, Sean Christopherson wrote:
> > > Which clearly says it is checking the *faulting* GPA.
> >
> > I don't think that necessarily solves the problem either, because the r=
eader
> > has
> > to know that the KVM looks at the shared bit.
> >
> > If open coding is undesirable
>
> Yea, I think it's used in enough places that a helper is worth it.
>
> > , maybe a very literal name, e.g. vmx_is_shared_bit_set()?
>
> Sure, thanks.

I didn't see a problem with kvm_is_private_gpa(), but I do prefer
something that has vmx_ or vt_ in the name after seeing it. My
preference would go to something like vt_is_tdx_private_gpa(), but I'm
not going to force one name or another.

Paolo


