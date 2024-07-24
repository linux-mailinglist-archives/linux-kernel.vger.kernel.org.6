Return-Path: <linux-kernel+bounces-261361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D37E93B65E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D710C284A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405016A95C;
	Wed, 24 Jul 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYTz1bPu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BB1662FA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721844023; cv=none; b=MSC/trHzZQqAVkhI+DNetKr5UKEHAnwNOArclVAV4FnxYcvYYNdTOzZDfQvagOlqsefuJn8QKm6TTngqTBx6tU8CjFFuG8FJZi8AtvBZqfwcq0OdIE/lpXvKWZind8kYS3aP9Ja8GshdKqwPy0D16QXBgBXzsDzg/gBdJV9KdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721844023; c=relaxed/simple;
	bh=QJ6MXEQ8sLFk21e4td4ArZEHAj6BL4RmQyxNqLb/X8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gS1qlzzWNJFc73acbqXY8chEH1dwZIH4UIEevU4piKv4fmvpHF9wVxKiWaLIi/7rhweEmezXNggR+6wCpfXJCWJZYCKYwvg0sdd8gDsWSMRRkB1rxUDfoWiFeTOls0dLRKWUZME7UtyWdLEEy9YOEhp+lBvVbhTfQy/8DWa8whM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYTz1bPu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721844021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IL9ahkTlAZzT7WvDQ4rSd+/gKo3vqcrGfXXriwbJsOM=;
	b=DYTz1bPupeDON6pGBj8rSqcgiUcZzxwwihB1Q5IzpY7SiJnyw+vc+kdUUtES6u2toUdI94
	hwQIx02t+R7hgD1oUaGa8x2tI8/spfC08UkGitxGTKBr/Xq+jLKGF925Kva/0XPNveQuhY
	L6WzaU/39TCof3G4HRFrzg/BcJ7qPds=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-zAwE4pZuMwigBkj9VEbtGw-1; Wed, 24 Jul 2024 14:00:17 -0400
X-MC-Unique: zAwE4pZuMwigBkj9VEbtGw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-449332e01c0so477201cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721844017; x=1722448817;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IL9ahkTlAZzT7WvDQ4rSd+/gKo3vqcrGfXXriwbJsOM=;
        b=BdlAg0PmAQVQNTA5Q9W9Sc3EwwHh3+JqxU4lzEgmIVEinhCzXS+FHq0rw44WDhRz+B
         co1xxehi2JfRC/AAsx7OYRwhlf2Dz0znRJj7Pir7bHAsa2cNKr4muuwwcNQZbu2hCWe6
         JgVqh6avdZqiye3GPMjJOjF47sbI5oDKxBNFyFKUwIl67fCSOv4+RUUWbAht23zMLho1
         iLH0Wa4YhBCKkwzuo7cmAmXF1lwZFTmm9uI3Irej2/Ax0EdAgzl2z+lYE9hZ3Ii5VMNZ
         AKpJodiKrbiWgrA1Qv6p17kxip8keKcG33DGX5vvSMgWaSJSGPyyOH382hbBqrsrNc1R
         HWEg==
X-Forwarded-Encrypted: i=1; AJvYcCUWB1K64TOkLEYYi0ltkMpH9nKF0covH26pob6IBPTMfT6w6+XYLapjAWevHMaLhNGIr9CTxnoUYQu0HTYqy2UOarHxkfmtUhX82mzi
X-Gm-Message-State: AOJu0YzgVOXztYAd5pyVIjFRIhNCweJVZ30aiaLTWS4ll7OoH9wKCDv/
	W6/S2szBhcL77vX9MykodYibawt1PZWm4PnkC4aPe1zBgGaMC0bPJIJaqZC6ScWNU1P2wsGAOht
	IHu2RUBJea34pBrlaAWqgtRDom3dCo4Rv9YKK3XNqguGxrBcLpdWqhqbP4AXMiQ==
X-Received: by 2002:a05:622a:1827:b0:444:ff16:9ffd with SMTP id d75a77b69052e-44fe32f8841mr4089201cf.25.1721844017038;
        Wed, 24 Jul 2024 11:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEzc02t+9r6K8WNizGDAVsGJ+kIaKTY5JlDBcrgjaDFLWk8V5snGHQijVtE/6qbOpgnuYPhA==
X-Received: by 2002:a05:622a:1827:b0:444:ff16:9ffd with SMTP id d75a77b69052e-44fe32f8841mr4088671cf.25.1721844016445;
        Wed, 24 Jul 2024 11:00:16 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cda2dcasm56335681cf.75.2024.07.24.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 11:00:15 -0700 (PDT)
Message-ID: <fd5134ffd39b89b09b5aa23c642d5401af53f032.camel@redhat.com>
Subject: Re: [PATCH v2 37/49] KVM: x86: Replace guts of "governed" features
 with comprehensive cpu_caps
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>,  kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>,
 Oliver Upton <oliver.upton@linux.dev>, Binbin Wu
 <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Robert Hoo <robert.hoo.linux@gmail.com>
Date: Wed, 24 Jul 2024 14:00:14 -0400
In-Reply-To: <Zo2B0jDjufR4EdTx@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-38-seanjc@google.com>
	 <34d209d318111677c1cd47ff321cc361bf06bd60.camel@redhat.com>
	 <Zo2B0jDjufR4EdTx@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-07-09 at 11:30 -0700, Sean Christopherson wrote:
> On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> > On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> > > @@ -861,23 +877,20 @@ struct kvm_vcpu_arch {
> > >  	bool is_amd_compatible;
> > >  
> > >  	/*
> > > -	 * FIXME: Drop this macro and use KVM_NR_GOVERNED_FEATURES directly
> > > -	 * when "struct kvm_vcpu_arch" is no longer defined in an
> > > -	 * arch/x86/include/asm header.  The max is mostly arbitrary, i.e.
> > > -	 * can be increased as necessary.
> > > +	 * cpu_caps holds the effective guest capabilities, i.e. the features
> > > +	 * the vCPU is allowed to use.  Typically, but not always, features can
> > > +	 * be used by the guest if and only if both KVM and userspace want to
> > > +	 * expose the feature to the guest.
> > 
> > Nitpick: Since even the comment mentions this, wouldn't it be better to call this
> > cpu_effective_caps? or at least cpu_eff_caps, to emphasize that these are indeed
> > effective capabilities, e.g these that both kvm and userspace support?
> 
> I strongly prefer cpu_caps, in part to match kvm_cpu_caps, but also because adding
> "effective" to the name incorrectly suggests that there are other guest capabilities
> that aren't effective.  These are the _only_ per-vCPU capabilities as far as KVM
> is concerned, i.e. they are the single source of truth.  kvm_cpu_caps holds KVM's
> capabilities, boot_cpu_data holds kernel capabilities, and bare metal holds its
> capabilities somewhere in silicion.
Looking from this POV, it make sense.
> 
> E.g. being pedantic, kvm_cpu_caps are also KVM's effective capabilities, as they
> are a reflection of KVM-the-module's capabilities, module params, kernel capabilities,
> and CPU capabilities.
> 

Let it be then,
Best regards,
	Maxim Levitsky


