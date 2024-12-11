Return-Path: <linux-kernel+bounces-441127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE869ECA04
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E243188C5B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18F1EC4E8;
	Wed, 11 Dec 2024 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVJzolj0"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB31A8406
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911917; cv=none; b=fbzJAJ6x60ig3ePIcskxZImLiz53DynAtRbgJHN2INVPz4IZ31VMjnY/JBx+mNg0ocDJ4ZRCX1dddmwm686OiFXKt7jPvFFlIVaR5pKbyNBmITFQQ8I8oHWe8TzTkRzkwOgfUYenoUkShezDNwoHHtLohZtpHk8h/qMp/UhwiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911917; c=relaxed/simple;
	bh=UNSkvp5Fi4jdAsiQOX2ohUox6oA4Eol6M3ew5tYCm7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc2npkRqF9VJNCrjot0mvH/qJ8lTJQC6gN/OfFzt4xgmxEoSY8Q4x0GWNUJg6w3mqElqI6gxHVbiSQOUmk5LVWN9PDAf1kbSnBB6Do06m9RPol+EiVzuahe4ph4/VRsIe/F+D9bgSxc0lEaKYcvucPkt80VfBR6y6D1dDTLfp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVJzolj0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434f150e9b5so28815e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733911914; x=1734516714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k5/pBdgJ0WtdygNIfcUkdF80xl9r4Rk30sip5q/77pY=;
        b=AVJzolj0y6b9j8Df+2Hqn/HJ6q2G2WOy3xsnAE/mbCjWBySihJlM9IfeOJt2a1cFvq
         7ETI6DGkxIRCTgM/ZCGRTOTgG+K1l2wwgTrOzeDuE19NkXZEmjHFK/VQYXvsfvnxhso7
         afVJkLmTJMM40qb97hpXd3HPzOizR9+R0OWdMCzzf1BL5drFifz59Ig9DlT4D5/NftPG
         PwUCrpy3y7U30WgYOjQo1JT593dipwaXLHUHgWyuzQHm6/kaBcVdF8QaLb6+tqVEBzqX
         TFscrrx3rVSrI4tt/zvUES31LqXbna/nUSk8nXb9BACdE9OOsEkbkGjKBWuq5yeO51bN
         tHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911914; x=1734516714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5/pBdgJ0WtdygNIfcUkdF80xl9r4Rk30sip5q/77pY=;
        b=qG2P+g7B9P72DHNwONvAUQsAb6a3/b75GUAc06LHQkudwaDx2bfB85ke5K5EhOKI/a
         tafBtt1oop8b0oc38FDEPSDfQcpZJJbea3PMx/XKaK57eso0Gr3jqCxYn1ThOJzamH+C
         tug5Oemmi2FGPUO+jmHVUMu4m8mc3cvjXwYw5kqtqOXVR1RgkLMY98JQHv/zA6Ujiz9D
         HFFHjqNqD5bGQnV2XBiINY2K6NmLWiMXN11WL/8UuLq+N3mnDSzRarIxsmfWIUJx7y8/
         aXXXoSPBbRwABViaHWi0a5xmJwbejh+vahNF0PSNLIK88ZvDy2USeuMQDJlOKCTlnvLA
         wYnA==
X-Forwarded-Encrypted: i=1; AJvYcCW/hY+9oLPFXccuaYWNKfuMSPzL3+nt1z29rDDur7LdR7YoPlmEf2Y7IFBZgxLpAHk88S3c09PucaBLDZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNpZPXZxLbZAKldV/t/6gcy4JiCvyQqt/38deybX7JR0ZgN1ED
	V6S1yDCKN+uFs0UYvZY2xBAvnlizF9SiJNw/QbRD8+lGve3Zs4yEonMy0NRFr0TP36/frbNWTci
	tbiKTQsGwgxUkLqdJtKGb9niOSG67nM9d/gpx
X-Gm-Gg: ASbGnctLnkIbclETm/ntpk8xzGu4NdgfrXRsu/Gca8CvDx8xrxN2BMuygzrAZjC6/o8
	OzAzMlOpIlVkQjL6WYHAPD4YWhklFn69vXHdQZWRe9paz3xvA+P88ulZzrc1Rp4S8
X-Google-Smtp-Source: AGHT+IHKlxzo1xy4xRwvjpYoXuxiOd/XjNGW14dtMQxwLOZNl9tNvycqqdCoKpeiFlUtFyA39Sdg5yzXDCdFY1hYk7g=
X-Received: by 2002:a05:600c:490a:b0:42c:9e35:cde6 with SMTP id
 5b1f17b1804b1-4361c0e320bmr987705e9.2.1733911913821; Wed, 11 Dec 2024
 02:11:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-16-qperret@google.com>
 <CA+EHjTzOjwNyUkS5_zSUiAbiCauLKKgkKU6TM_-+Wsh9A0FdRQ@mail.gmail.com> <Z1iaof2DgZfZxc4l@google.com>
In-Reply-To: <Z1iaof2DgZfZxc4l@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 11 Dec 2024 10:11:17 +0000
Message-ID: <CA+EHjTyzh_tqH-M4zSDEQ9meK_W_c-sQDvJ6H4kBd4e_MCmLfA@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] KVM: arm64: Introduce __pkvm_host_mkyoung_guest()
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Quentin,

On Tue, 10 Dec 2024 at 19:46, Quentin Perret <qperret@google.com> wrote:
>
> On Tuesday 10 Dec 2024 at 15:14:03 (+0000), Fuad Tabba wrote:
> > > +int __pkvm_host_mkyoung_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu)
> > > +{
> > > +       struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
> > > +       u64 ipa = hyp_pfn_to_phys(gfn);
> > > +       u64 phys;
> > > +       int ret;
> > > +
> > > +       host_lock_component();
> > > +       guest_lock_component(vm);
> > > +
> > > +       ret = __check_host_unshare_guest(vm, &phys, ipa);
> >
> > While I'm bikeshedding some more, does the name
> > __check_host_unshare_guest() make sense? Should it be something like
> > __check_host_changeperm_guest(), or something along those lines? (feel
> > free to ignore this :) )
>
> I understand the comment, but not a huge fan of 'changeperm' as that
> sounds like we're only allowing permission changes while we use this
> all over the place. Maybe __check_host_is_shared_guest()? Naming is
> hard, so happy to take suggestions :-)

I've gone and done it now :) I almost like that, it's the *is* part I
don't like since it implied a boolean return. Maybe just
__check_host_shared_guest(), no is?

Cheers,
/fuad

