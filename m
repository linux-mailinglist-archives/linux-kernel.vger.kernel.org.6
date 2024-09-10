Return-Path: <linux-kernel+bounces-323827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3976D9743EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5244D1C25404
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381DA1A4F2F;
	Tue, 10 Sep 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yfuz2oxt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2E176252
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999193; cv=none; b=Qvu4w2v39x9+TzAOvQ2dkKUZ4g/AinfaNo5z4P4655eJ7PV7ZSQKFu2CxG6zEAuzQ6FN5BjuKeyKaeJfu3SZg/ghBxZn60AWT20+8u00Mw7ftWvSQsCFotJiWii8lu5kqem62GHyai0waDAIgdN6+w8b+CXajsrHBlq0cjj3Ea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999193; c=relaxed/simple;
	bh=SmGdKsMeARzok6Efk7DiO3PzMavjkZ1CyBtvfmmY88o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZImKtFxzxNVZHmpYphk/lKiVv+oNQzH198aeNSjuAC1ZYzAN267H2paQZl4hbVMDagBu8eZ4jQAeX7J08tKMIA6itRjF7/k2WOSFh2+b8a1k8mX92AW1hmTBSZ/4mNLDyZerdja9mIV6TuL9vPSLLKygc03w2fcBnewtOHEpfho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yfuz2oxt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725999191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDtYyQHUbQoxUf9RtgQfhLfnKwLGRhZtyaZbqqn8Z/0=;
	b=Yfuz2oxtv0Qoq3sfZB7SDw0hhB9Qs289SXaKKbdzzCtNz7p6xZ/hb2poiy7fuVHstj5yRG
	vDqD7oCMmWvmko3q+RPaOAnQdQPptiN9gzTTU4dHECFhloc/+VXn8ujF2KJViKt9dJPQ2i
	z/7yAdC9gFiS5mwUgWS2QWLfKDdHVEQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-wmnPJ6hHP46y2OzxyIK9yw-1; Tue, 10 Sep 2024 16:13:10 -0400
X-MC-Unique: wmnPJ6hHP46y2OzxyIK9yw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a9af65cf73so458212085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725999189; x=1726603989;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDtYyQHUbQoxUf9RtgQfhLfnKwLGRhZtyaZbqqn8Z/0=;
        b=S+2J4Qcr3t1h+X2gP1ApoC7N0zix5nZf2+s7tnO42+Hh+YRBf/It4UkYK/nhMJ9BY6
         dlNl5RIH4/JTCXChb4PsXKgp8SDbNbaS+4PRIrsRjTEvnBNs4JG3s7s5BstAuPZ6myi/
         h5wUui4M1LD+987O4SAmhCZiQAg6XWhVZGjxQOV9GG1s92+u0ylkRWpnwO51pImlu2hT
         8p9ENlaCZ3BlZlJVFo4b6vnEjomwqPbK5Tz8CaJ32Ay5IzdxAYaNjONYWLTE+XED1l07
         uj81wXvj1064bnUxY1/ML4yq3Ay95bDaqIuHABCAWkJwbeia/tFw+gQq0gI50DIKY1jg
         lR1g==
X-Forwarded-Encrypted: i=1; AJvYcCU2P8hjyYs8RB3fHkGEdbQ79PjZ1bHNXt6V8PT18bl+hiQJ9IVnAOYR6GVKT69CySMNMoFyKt0PDQnfMMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmEvZYrCj8HGDtGwdQlBuNu/b/ETbmJM9QqTicLH7axGPiCHKM
	G9n662C7Z8f1vijzdeuyd50P51n+BjTXppo7iBBiAjf9v4Xu4kTA2PqkolJc4cAjVnedm11KE1H
	PK078noeS5uNfy/JvyyxGOSDl8ytb0V+7Onhse8hfF8JbH2D+e0ECrOpUZOhb5A==
X-Received: by 2002:a05:6214:4345:b0:6c5:52cb:eb77 with SMTP id 6a1803df08f44-6c552cbed7emr83953216d6.2.1725999189590;
        Tue, 10 Sep 2024 13:13:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsa80Vfsj+4PZuSTXsmrgG/jjhTRObLUykG/vdN5JeOTBK1I0ZLARmLG+r7hRF7RzLsA44+g==
X-Received: by 2002:a05:6214:4345:b0:6c5:52cb:eb77 with SMTP id 6a1803df08f44-6c552cbed7emr83952686d6.2.1725999189045;
        Tue, 10 Sep 2024 13:13:09 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:760d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534774303sm33189216d6.111.2024.09.10.13.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 13:13:08 -0700 (PDT)
Message-ID: <e5218efaceec20920166bd907416d6f88905558d.camel@redhat.com>
Subject: Re: [PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, 
 linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Ingo Molnar
 <mingo@redhat.com>,  "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner
 <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>,  Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 10 Sep 2024 16:13:07 -0400
In-Reply-To: <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
References: <20231002115723.175344-1-mlevitsk@redhat.com>
	 <ZRsYNnYEEaY1gMo5@google.com>
	 <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2023-10-04 at 16:14 +0300, Maxim Levitsky wrote:
> У пн, 2023-10-02 у 12:21 -0700, Sean Christopherson пише:
> > On Mon, Oct 02, 2023, Maxim Levitsky wrote:
> > > Hi!
> > > 
> > > This patch allows AVIC's ICR emulation to be optional and thus allows
> > > to workaround AVIC's errata #1235 by disabling this portion of the feature.
> > > 
> > > This is v3 of my patch series 'AVIC bugfixes and workarounds' including
> > > review feedback.
> > 
> > Please respond to my idea[*] instead of sending more patches. 
> 
> Hi,
> 
> For the v2 of the patch I was already on the fence if to do it this way or to refactor
> the code, and back when I posted it, I decided still to avoid the refactoring.
> 
> However, your idea of rewriting this patch, while it does change less lines of code,
> is even less obvious and consequently required you to write even longer comment to 
> justify it which is not a good sign.
> 
> In particular I don't want someone to find out later, and in the hard way that sometimes
> real physid table is accessed, and sometimes a fake copy of it is.
> 
> So I decided to fix the root cause by not reading the physid table back,
> which made the code cleaner, and even with the workaround the code 
> IMHO is still simpler than it was before.
> 
> About the added 'vcpu->loaded' variable, I added it also because it is something that is 
> long overdue to be added, I remember that in IPIv code there was also a need for this, 
> and probalby more places in KVM can be refactored to take advantage of it,
> instead of various hacks.
> 
> I did adopt your idea of using 'enable_ipiv', although I am still not 100% sure that this
> is more readable than 'avic_zen2_workaround'.

Hi!

Sean, can you take another look at this patch series?

Thanks in advance,
	Maxim Levitsky

> 
> Best regards,
> 	Maxim Levitsky
> 
> >  I'm not opposed to
> > a different approach, but we need to have an actual discussion around the pros and
> > cons, and hopefully come to an agreement.  This cover letter doesn't even acknowledge
> > that there is an alternative proposal, let alone justify why the vcpu->loaded
> > approach was taken.
> > 
> > [*] https://lore.kernel.org/all/ZRYxPNeq1rnp-M0f@google.com
> > 
> 
> 



