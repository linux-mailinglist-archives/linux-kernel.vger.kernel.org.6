Return-Path: <linux-kernel+bounces-261355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B6B93B636
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7C31F21FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1220115F41F;
	Wed, 24 Jul 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1tfTtsS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D149447A76
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843708; cv=none; b=bE6q1pVxucFCslo909LQjHxN2vulcmUZLFiZy5qkuO5B1W/Orz8DMZdJqW+0b8KagUwsSqs00psjmbkf95Xw3jL/kT1VERLnWa5MLOSsIt/cZ3kfjfhR8jgZY094tPe9uutOv/lv5fD0vqP73U9ntX/3urjAdst8VyGktmkbNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843708; c=relaxed/simple;
	bh=pAggti4CxDh8aaKGOiWwcGNCnca4OscjeY43dDFw0qY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UNyaiOd7MnHuSFjp7pxKgDpAn74XsKlWsi+Q9dU1QuWb2730od8YsdTajACTub+eL/pHT9Tpup/OmTx0ij8EMB5KLo5yqPzaohRdZff0Fw5iFfyoBh2UZIE8zg0JvbqUf1zZlpKGc9Z/3lEigW0KlrTyOylHAIW1vFNNJLyiYhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1tfTtsS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721843705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCSjvQojnSBcvZOuO5x0oYLCUoJsIiQ0BK/dbIXil2Y=;
	b=F1tfTtsSyEC7qCauo/q15c7CzxbHiId8HWhtycVzoac/LmYg3LqiDw0hMx6JooRCYGQSvc
	1vUpFzwU4cNxJww3GzhnOgNfCbcX+6c8aUQqw2B4smBw18FffMizB8nu8Fd+uj5rlotJ2P
	aiZ/xKuWKXptwxbj3qgRFsY0t7gaT7g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-9u9FTQ22PMWR9EoU1xLMYA-1; Wed, 24 Jul 2024 13:55:04 -0400
X-MC-Unique: 9u9FTQ22PMWR9EoU1xLMYA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-44fdd39f503so419071cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721843704; x=1722448504;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCSjvQojnSBcvZOuO5x0oYLCUoJsIiQ0BK/dbIXil2Y=;
        b=Gt34lYY4Iu4LI+q3uYkHtFTzRmoDlIjm3hr6EUvn38OwUxf4PAO7dQQ0lhOy9qAM0B
         MjzupjE2/R+6HS5SVyaa+1Q6eDe0MNFsxsTmc69lw5lxIgHN04v5q6szC2jig+zvh1Rw
         0BmhlEKiGDYAoGeQPSXq93Z7l3yG7r30lIcmw+OSp1ZZAKxbKosyKmMHrcVVZ5HGE4N8
         FQRL1cCShc0rlsbSfqEl9m5RWkMZklwJc3uW6BczgBJO96SnYDq0xMINNAM/qloD80gi
         QzICgOYVAwbabBAVsz/paRKjsQArEgwYnRPgbXwIn/zLmuCM9QYdyDhmxblpekDsQtUR
         AoGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtGKUG1eMUws6sX7R5KHwtvaS0izW4tEQVJIXx5c4aJz2OHSguVjAdL6xBxtxEpfYhyTpdWT1UuS58MGI/QW812DeniYOZygkMdMBm
X-Gm-Message-State: AOJu0YxVfgxLQmRi2neH8s7Gf2fmsbMoaXPtLQRoUjDSt/Gw91ryXzuJ
	jWt/ccw3kcXOrG2hKJHWCe0L9TPo7ZRE1cny+xNEBJuDd22S6zUw0E8BmFwA3OLuRp+MLVMq1PB
	YCdFzyJU3+08ZmoQfpwcgpUAZbzUnRBYoM7OAUUL5TUqFt+ZqILqGpnY3cani0w==
X-Received: by 2002:ac8:7d54:0:b0:44f:e591:a676 with SMTP id d75a77b69052e-44fe591a9d9mr517341cf.23.1721843703913;
        Wed, 24 Jul 2024 10:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGchekRilGVZO6s0wOLP4Iqdh0ZaYupUIyDfjrBA2nOsm/NoGM+WLs8pdDpP8/i2GrA3JpCRQ==
X-Received: by 2002:ac8:7d54:0:b0:44f:e591:a676 with SMTP id d75a77b69052e-44fe591a9d9mr517071cf.23.1721843703569;
        Wed, 24 Jul 2024 10:55:03 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdc18f4sm55661491cf.86.2024.07.24.10.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:55:03 -0700 (PDT)
Message-ID: <669b2a0fb4f028f3903bd4468f819f3e7f9758cb.camel@redhat.com>
Subject: Re: [PATCH v2 25/49] KVM: x86: Harden CPU capabilities processing
 against out-of-scope features
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 13:55:02 -0400
In-Reply-To: <Zo19SWre5eJm8XTu@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-26-seanjc@google.com>
	 <7c072dac426f77953158b0c804d81c664c00d1e3.camel@redhat.com>
	 <Zo19SWre5eJm8XTu@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-07-09 at 11:11 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > > +/*
> > > + * For kernel-defined leafs, mask the boot CPU's pre-populated value.  For KVM-
> > > + * defined leafs, explicitly set the leaf, as KVM is the one and only authority.
> > > + */
> > > +#define kvm_cpu_cap_init(leaf, mask)					\
> > > +do {									\
> > > +	const struct cpuid_reg cpuid = x86_feature_cpuid(leaf * 32);	\
> > > +	const u32 __maybe_unused kvm_cpu_cap_init_in_progress = leaf;	\
> > 
> > Why not to #define the kvm_cpu_cap_init_in_progress as well instead of a variable?
> 
> Macros can't #define new macros.  A macro could be used, but it would require the
> caller to #define and #undef the macro, e.g.

Oh, I somehow forgot about this, of course this is how C processor works.


> 	#define kvm_cpu_cap_init_in_progress CPUID_1_ECX
> 	kvm_cpu_cap_init(CPUID_1_ECX, ...)
> 	#undef kvm_cpu_cap_init_in_progress
> 
Yes, this is much uglier.

> but, stating the obvious, that's ugly and is less robust than automatically
> "defining" the in-progress leaf in kvm_cpu_cap_init().
> 

Best regards,
	Maxim Levitsky



