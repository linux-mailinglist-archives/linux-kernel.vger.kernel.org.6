Return-Path: <linux-kernel+bounces-205665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478E58FFEA0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0B7B24576
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7315B152;
	Fri,  7 Jun 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUPUpaWR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E517C6C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751023; cv=none; b=nDgFg7tyI8GZQyQFdlvsd9JlZFBud624tElpQmn0OBxpYeNIjosCB7UnI9onOOQ5UNzLYQIVuBPKMJtYNweBFkiHwAte41WZ+az3gv/Z/o8zzwi8FPtl82OszFdnTaxHTOADEAbZxCMS1OPUYlcN9qyhvcM80ds4NMbbhBhMr78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751023; c=relaxed/simple;
	bh=7X6zarJgJIAqkTEk8mUER5IEjtHSmRMyzVjoW1K8ZhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Csz0ODHJ9xrW52wdMmJkz5g9XVg9A5Agk29k40rD72nXvUFwsp+oNhdDR+A3mPlEgYhqtP61ljeMuWystU/yH/Jq35afyPxHpK9+b6CtRaKVlRupiV7Eaeg2pc1T4VymmNWjM4JS54QprCziUwH7FMIWB2DptJlV8+dDlIxG77U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUPUpaWR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717751020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqE6hPCyqXNy3D1+Jzyj9gbitemqp2I97TKEU0JKvzE=;
	b=eUPUpaWRb7bbisO702jI6rL/5pL3y8tlUQfce7zHvGv9HI70NqsrcaDnphjrpA4eN9fPp9
	XmsgiFGcCmfCgHGvs0M9nBMHyOy0UWtTLjIyPkEQYjY2Y2H1yj2RuOnar4xHwnf20N71S5
	6p/3JpuNBgY7kHjvLZg2mAhjOmFa/qk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-E5xHp6M0OJ--Wwy-WjMRFw-1; Fri, 07 Jun 2024 05:03:39 -0400
X-MC-Unique: E5xHp6M0OJ--Wwy-WjMRFw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52b88765386so1774513e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751018; x=1718355818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqE6hPCyqXNy3D1+Jzyj9gbitemqp2I97TKEU0JKvzE=;
        b=X4iZ+ENvt5AHYbXedCh1xr3candJ2+UKtQCzyn1qWiXiWxwE5wwhRgWW3kqUi3jDkI
         qGCwzt/hRvSW2sBu3up0GHHL7CW02n/rdXktxYYG8bKpiV9wAJRVWRKKlaGkQlutHSXs
         sqIq5Fmzg3VTVRklbWtLwRVDuZj2BrKU1Qemz++czGEKM04J9ti04zUf29Rws8oXR7zT
         3EAEmT0rpD8n5A4AlRNSxSQTrFsC905jbgrP0CXL1FY17pm4CaWcp54SIWZiWcckPUZ7
         T/jU9DAicRXOscRSv7IpEfepZmhISUXZRqcIjPuPXbB+6JNJEfGbYkF3mCu3QwLcsh6H
         iGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5PfNEc2K11YUX2LYJwu1jr4PREu90r3/bwj31t/gL43WWgICAf8lMFE5Kz8+z0OxdrXgvfyptiOs3ln9dxX6BFvWwv3/l7NdL2PNt
X-Gm-Message-State: AOJu0Yy0BKw4JeP6FZQffpXNOcBneEo0FwFUv9266i0L7x24bSb3A1FH
	D3i+ZPEBsJK0q3KWG/paAhxhCvO/CA7HFbB33K+Yix47GW0yqg9mvrL/QY5CT49USYbYEcKCU3Q
	Nqanr/ax6Ly3oSQV1SRcQAyBoBnZ8dV3d5CspKoqXPnsfZ+tv0q9rg7qv0Xxi+3s2EXu/NctY2B
	jI/EBCHeMv6EJZxK8QURKfpPZGxIEr0tlsIHif
X-Received: by 2002:a19:f812:0:b0:529:9fe5:f54b with SMTP id 2adb3069b0e04-52bb9fcc495mr1260613e87.43.1717751018046;
        Fri, 07 Jun 2024 02:03:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3tfq7LInmTFS863fnDty0MeJZUA2Es5xSZAYprCk31HXCX5v9kTaO2IKs/xYldhZhlO5SsG8it4TA8W+b+H8=
X-Received: by 2002:a19:f812:0:b0:529:9fe5:f54b with SMTP id
 2adb3069b0e04-52bb9fcc495mr1260596e87.43.1717751017623; Fri, 07 Jun 2024
 02:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com> <20240530210714.364118-15-rick.p.edgecombe@intel.com>
In-Reply-To: <20240530210714.364118-15-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Jun 2024 11:03:25 +0200
Message-ID: <CABgObfYL9uujoLTmSBW0LqoQbOGKpfZsB50BZqMo5_WOChrZ-A@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] KVM: x86/tdp_mmu: Invalidate correct roots
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	dmatlack@google.com, erdemaktas@google.com, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, sagis@google.com, yan.y.zhao@intel.com, 
	Sean Christopherson <sean.j.christopherson@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:07=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> When invalidating roots, respect the root type passed.
>
> kvm_tdp_mmu_invalidate_roots() is called with different root types. For
> kvm_mmu_zap_all_fast() it only operates on shared roots. But when tearing
> down a VM it needs to invalidate all roots. Check the root type in root
> iterator.

This patch and patch 12 are small enough that they can be merged.

> @@ -1135,6 +1135,7 @@ void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *=
kvm)
>  void kvm_tdp_mmu_invalidate_roots(struct kvm *kvm,
>                                   enum kvm_process process_types)
>  {
> +       enum kvm_tdp_mmu_root_types root_types =3D kvm_process_to_root_ty=
pes(kvm, process_types);

Maybe pass directly enum kvm_tdp_mmu_root_types?

Looking at patch 12:

+ /*
+ * The private page tables doesn't support fast zapping.  The
+ * caller should handle it by other way.
+ */
+ kvm_tdp_mmu_invalidate_roots(kvm, KVM_PROCESS_SHARED);

now that we have separated private-ness and external-ness, it sounds
much better to write:

/*
 * External page tables don't support fast zapping, therefore
 * their mirrors must be invalidated separately by the caller.
 */
kvm_tdp_mmu_invalidate_roots(kvm, KVM_DIRECT_ROOTS);

while kvm_mmu_uninit_tdp_mmu() can pass KVM_ANY_ROOTS. It may also be
worth adding an

if (WARN_ON_ONCE(root_types & KVM_INVALID_ROOTS))
  root_types &=3D ~KVM_INVALID_ROOTS;

to document the invariants.

Paolo


