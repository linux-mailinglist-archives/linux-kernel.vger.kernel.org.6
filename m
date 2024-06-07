Return-Path: <linux-kernel+bounces-205579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667D38FFDB7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05C0B23E1D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F44C15AABB;
	Fri,  7 Jun 2024 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tv7KzzyE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5412152783
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747237; cv=none; b=P3tlvtClt+tpr4kg0w9oSQog7n3txn8XFhxA+7WvAVgRGXxN1INEeuup9w4egWBXwgRYH5jn1oshfSRkxUzHuyNj3RwqzfGRW0z7SwLOSFk/Gb++DOEj1LQMIRi2q229O5GK+UFTZk84k75EUfFHxscKa3piZJQvTsxI7spAd6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747237; c=relaxed/simple;
	bh=oNxSAuBoC9Rq3RAiBfP7Pj7KC2X0qYrJRitwV4RgUGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjaDxCt269lo0jaCKmY6nLH2aCzklTC6DGT94B+lbvrxtqrptMHK4HS9YVLo1qGcthj65Px/ZknjTrvtDzZPdNIt9s5zxBDoXbwCEXJrHdDWFlvQTY/hob8m5jE8C/NzRnGilBW51RuZDxDH9grI+pvW5WRDXG0pKhjbo+njdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tv7KzzyE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717747234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIC5ST502mWLGRzx98Wcntt/WKTFrMsaguUwt9JTDVk=;
	b=Tv7KzzyE8IFbQ1nRwlTEalKY81INt5Ut6ofh5veHqdgLAs2FcKRdn6A8GtoKmxeHWYS5vN
	XkuWX/V2tRFdsz6EjCQEZsq2BYh0mnWaP14Zq1kGczDybH9LTbDCvjXpSqZ37Ivh96g3VW
	/uERisyiFJCgvpXpQmCvFXmAL9Fqd3c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-MVpHuQhmNY-b7CrDxxLu5Q-1; Fri, 07 Jun 2024 04:00:32 -0400
X-MC-Unique: MVpHuQhmNY-b7CrDxxLu5Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4216d9d8f03so1307815e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 01:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717747231; x=1718352031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIC5ST502mWLGRzx98Wcntt/WKTFrMsaguUwt9JTDVk=;
        b=OnJuMyhGBuspoXEYHObfcauluVOaDf3on2Gn50PdVGYQwbv9piEpsc+4j2rI4chgWr
         PxeARJWGKvlO6/5G/d/apQIrHarGGShdupUUJU/3V0Cxqhp/y8Xm/8z5mJxUyiwQkvrn
         0Kh2DU5NOViJUBZQjQoheoEvQl4ahWcwsE8SRrzmydv5zmLAYbwZwePAD3uD4aM7HFqH
         GWqCgVgTnKmBU1XA7I7Dzl1KBOoRc1/5XmeTzHn2pqS+7Dmuwcwld1aXvNFWfeYhWrmK
         gKgq0d6dAGvEMLxcrsikTKdBb6BFBVAzZPLsL01fYqlPFpqdA0z3RTklxfR9m5MdQ7y9
         AhuA==
X-Forwarded-Encrypted: i=1; AJvYcCXqu7pGGcDLO9mzfZ39u/606FQbbJRv6GqLu+GS25VJ+cT8mNjpf98+Lj91yU4KFxSHbiZdzFrBXEhTm717Btqr7XzN/auS6/USW6d1
X-Gm-Message-State: AOJu0YyHDPSnn4TmfLOBKSnxKY5Me1h1cVepOptbeqLudIqHZoGN3tdR
	ltiHz7gvQ8jj/GAs1z6KP2EfhuFjnTxgQ1EwPtP0ftZ976cG6+p3S0Dwnyugj0p1rxI0iglj/xx
	dTVLpYme+k8FuWpooqO/ptWrUqNR7961lIF/0zSZGE9D8ooBfqPpWfttLTlCxSeoWXzEJanDA25
	+bbk7MzAO4cE8wtUFgXE91omPFhMEqWx3L6xi9
X-Received: by 2002:a05:600c:3503:b0:420:29dd:84d4 with SMTP id 5b1f17b1804b1-42164a32b3dmr16587105e9.13.1717747231633;
        Fri, 07 Jun 2024 01:00:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf8VmunjtYddmqCV8lUMRd+Fgeu8b3V0xVIaYgKZvZ18JU7CTxTwELQm/gwU1s+OkgoEJs3FeenAgsaKrKZSk=
X-Received: by 2002:a05:600c:3503:b0:420:29dd:84d4 with SMTP id
 5b1f17b1804b1-42164a32b3dmr16586865e9.13.1717747231288; Fri, 07 Jun 2024
 01:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530210714.364118-1-rick.p.edgecombe@intel.com> <20240530210714.364118-7-rick.p.edgecombe@intel.com>
In-Reply-To: <20240530210714.364118-7-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Jun 2024 10:00:20 +0200
Message-ID: <CABgObfY5HhB_3f=+51CRNpx0LEbEVqGTnpfX5GFTDwHtCfq6-Q@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] KVM: x86/mmu: Support GFN direct mask
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	dmatlack@google.com, erdemaktas@google.com, isaku.yamahata@gmail.com, 
	linux-kernel@vger.kernel.org, sagis@google.com, yan.y.zhao@intel.com, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:07=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
> -                                                  u64 nr_pages)
> -{
> -       if (!kvm_x86_ops.flush_remote_tlbs_range)
> -               return -EOPNOTSUPP;
> -
> -       return static_call(kvm_x86_flush_remote_tlbs_range)(kvm, gfn, nr_=
pages);
> -}
> +int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, u64 nr_=
pages);
>  #endif /* CONFIG_HYPERV */

Ah, since you are at it please move the prototype out of the #ifdef
CONFIG_HYPERV.

Paolo


