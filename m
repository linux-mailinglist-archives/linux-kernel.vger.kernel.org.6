Return-Path: <linux-kernel+bounces-261362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0F993B65F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E343DB24125
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564F116A947;
	Wed, 24 Jul 2024 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkHZ1Zk9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3B158871
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844033; cv=none; b=oTd0NUvtT5k726aetCJsKZl/M9gZdQ9x/MDvwPR+FYhft++Fv7wXTt8E9D9F73Y9Plm3qI8NnOBO81pzCZEvoqpoAG13hw2P20Fm5STfgW40DjaZraWLrqZmky1S260RQxq/8UMcifMSaDVZuGrnH4/YD+EHItKJ94dIylMgePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844033; c=relaxed/simple;
	bh=q38qcAv/ONlrpumLgbJFpYQGr+xWZGzJKvEtxU/z1YU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RtZGFoyPsKNaJO/RdUmsTqYXB+s/rebqy5a1cNMknjpEJ+jM0D1ulNn4SOvWlfKEHKRYj7F2yVyJvnATTlHw9CLQ3zEngWOLTzLAh9PAexod2sd6diPTIzkRHHisIY3HlRGFtC8heyHkQs9hgp4rufjp45qnLtlfSp7FsC+utfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkHZ1Zk9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721844031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O95M/67R8fNQ8xm2ee1xfFbP6THrenJP8rJCaz7LLsg=;
	b=hkHZ1Zk9TxpnBLfeKIB8IGdXnJENs9o/t9Ns4sacqxdDdAhmkCVfvDe2xsFyd0OonKfIU4
	+x0ERcMgJtAxkChl9ErfuhViDuemkyi31uzJhbgFYAFQFGYekh4bJv4KjGKM2RhowxEuwc
	q/wNuGA7D3VuucfB73ZL2bFa5Q8k14w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-uTKnsyfUN8OrkJSeIGzPYA-1; Wed, 24 Jul 2024 14:00:29 -0400
X-MC-Unique: uTKnsyfUN8OrkJSeIGzPYA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b7a48774e8so943596d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721844029; x=1722448829;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O95M/67R8fNQ8xm2ee1xfFbP6THrenJP8rJCaz7LLsg=;
        b=DTQHs+aOhXKyz3qTsGrFY3DXvyYTYNfUg52bSXKM0JfJ8y44k7QPTYDnM/pdIzz/2s
         8wFAIyb1qlC4Eolep1Krsvc7NwdJVQbWZ/E3H+vUngfgz9l5AoJQ2Dj8eXicQ7KNCUqG
         6taopFoEuA8E8v16c3cr8sHd3LFl5y9iHruJcHZ4r7HHNxad6KstxfVXbu4j/+6aJHgK
         kLyybK6xosi3LLF+lQJgswkb48WnD52Sd+H9p5MeoLdMXaW6Nj5tBrKcyQBbbYi89dVL
         iH85WlO266FUxLsEEAomN+4h2XP4OaSCh+4/5DpejGuoGDKocutc2IXyLUcA9pkQHTWm
         N9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVoKvVOh/mr2CWMU9xh+n0e8iPahzzpyjUbhMBix9iVe8Y48BfUfgWgqVonThr/XEGc6vTyHJOP1mRvSKxx8A9Pn5wvXz8L+vLVuP9q
X-Gm-Message-State: AOJu0YxeNKptk/2seqz76Udy6h6roZsw/YOnFSuUgnMvQ4rCCNEAT3XT
	+yd9d9hhUUIc08UIJyo1A+ugNJVL4DrqgplaPQH3/2ARMCVqCC/IMsZv82CuOpqAObw5K3qBFbb
	gJJeyUTu2lOhPdTqkjusNFkA4hkBiY4l26aS3Z2IjE1TVjPewyRqyJC4/XZAcTw==
X-Received: by 2002:a05:6214:5017:b0:6b5:434:cc86 with SMTP id 6a1803df08f44-6bb3c9d6247mr3804846d6.10.1721844028913;
        Wed, 24 Jul 2024 11:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/F/PikhU9IOI1XzK4uCXYQiLmxbB3S+04oyjY4qjFMZ5iW4ULQ5IXpljNoUNliAPOhZAYMw==
X-Received: by 2002:a05:6214:5017:b0:6b5:434:cc86 with SMTP id 6a1803df08f44-6bb3c9d6247mr3804726d6.10.1721844028539;
        Wed, 24 Jul 2024 11:00:28 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac6858fesm60839726d6.0.2024.07.24.11.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 11:00:27 -0700 (PDT)
Message-ID: <d8ad4c17b01dd3bd3cdceba6712907ed2c7a08e6.camel@redhat.com>
Subject: Re: [PATCH v2 39/49] KVM: x86: Extract code for generating
 per-entry emulated CPUID information
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 14:00:26 -0400
In-Reply-To: <ZoyAkkZjnGmwlVCS@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-40-seanjc@google.com>
	 <960ef7f670c264824fe43b87b8177a84640b8b5d.camel@redhat.com>
	 <ZoyAkkZjnGmwlVCS@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-07-08 at 17:13 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > PS: I spoke with Paolo about the meaning of KVM_GET_EMULATED_CPUID, because
> > it is not clear from the documentation what it does, or what it supposed to
> > do because qemu doesn't use this IOCTL.
> > 
> > So this ioctl is meant to return a static list of CPU features which *can* be
> > emulated by KVM, if the cpu doesn't support them, but there is a cost to it,
> > so they should not be enabled by default.
> > 
> > This means that if you run 'qemu -cpu host', these features (like rdpid) will
> > only be enabled if supported by the host cpu, however if you explicitly ask
> > qemu for such a feature, like 'qemu -cpu host,+rdpid', qemu should not warn
> > if the feature is not supported on host cpu but can be emulated (because kvm
> > can emulate the feature, which is stated by KVM_GET_EMULATED_CPUID ioctl).
> > 
> > Qemu currently doesn't support this but the support can be added.
> > 
> > So I think that the two ioctls should be redefined as such:
> > 
> > KVM_GET_SUPPORTED_CPUID - returns all CPU features that are supported by KVM,
> > supported by host hardware, or that KVM can efficiently emulate.
> > 
> > 
> > KVM_GET_EMULATED_CPUID - returns all CPU features that KVM *can* emulate if
> > the host cpu lacks support, but emulation is not efficient and thus these
> > features should be used with care when not supported by the host (e.g only
> > when the user explicitly asks for them).
> 
> Yep, that aligns with how I view the ioctls (I haven't read the documentaion,
> mainly because I have a terrible habit of never reading docs).
> 
> > I can post a patch to fix this or you can add something like that to your
> > patch series if you prefer.
> 
> Go ahead and post a patch, assuming it's just a documentation update.
> 
OK, will do.

Best regards,
	Maxim Levitsky


