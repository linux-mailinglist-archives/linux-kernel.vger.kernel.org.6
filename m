Return-Path: <linux-kernel+bounces-248305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83FF92DB81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2AF1F239F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F130143885;
	Wed, 10 Jul 2024 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nhez7E8f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF5127E18
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649100; cv=none; b=gnPEbBhQHC/lepZdxOpU46UjHOR8H4UicOGsw/JDYqJdIUTF2O8ethtYcUKB86A6Lr3s3rbI8fJo53XyKZvyWlTrsAKlIi01E5RAaFkE1ykdX5hMAPE4l7pfSoVaUUxt+HvOeFKXLRUwyPNTRPG+oe/+xR1oUU2boelFb5wEqGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649100; c=relaxed/simple;
	bh=VoJ/gJl5xvnTdhEHVHw45a7iTQIUHdeoCoeJEKThHDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABXIx9pqsu4l2BQnzb1uWlQPz96nHyFBqUWbD+NEXiaNs1GGH3pjc5FVpwxhjrafh5wQ1l2diF8gJeQ5qBh4+8qG4TqE2TB3VWYfyEp7AdlHdzVj0+kA0Gh6JOow0Ivjs6xuvaWTTIqokDB6OQJ1UktjIsGKOoX77LaW4j6pUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nhez7E8f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720649098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4p2Yj6Wm6bNDeAQEfGI5P0AFWtl3OHuV5/lNYpxb6YA=;
	b=Nhez7E8fafIV3G6nafJpyMZYQB0kgzOEo8uFXQK7cI17PAv0PfWn7Idz5qXtH8BNnjoi4t
	yT6iVxej9+aoq5w3VZwn3AI/DBHPQRWgJY23p9y1pmLVhMRs7i2kju6HRmY52kZfVi5KDR
	z+k3WOOp4irXeqOZ/D6aoNN+d/u2gow=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-CnLWTG0AMHOvFXbsKPCS_Q-1; Wed, 10 Jul 2024 18:04:57 -0400
X-MC-Unique: CnLWTG0AMHOvFXbsKPCS_Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367963c4f52so207106f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720649095; x=1721253895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p2Yj6Wm6bNDeAQEfGI5P0AFWtl3OHuV5/lNYpxb6YA=;
        b=nCXVCPU3/DVvOiE4RI3ceUMG7UW67a9wNs7mSIfWdfgdoEUCgl0kMQIvsT6kaf7+6/
         3DCbDOaHrCeQnfMd33sxMEUijdLERU1QG9Zt8V6gDhrC+gHlCJ3RjW3KIR1k0bnG95+Q
         4Bf8DMknzrcGI3eyTjTB7XiY/t6wXfzLftxZQHittRkSI859BR/lztq5Qa5vKVlQvdlB
         KCxcF+qLnzS+/J5IZstKTUcgiKWDItz39qurLqo5UEt7bJ1jEK2g99ZRH5qzX7wvX608
         WVg/HzaJXYaN5evyPpEhItQ+h8v/+XMzRoCkhpA9+lX1NXDm6+Zc2Rin+KayTKJyeNsL
         hESg==
X-Forwarded-Encrypted: i=1; AJvYcCWN/+ojK4HXGcPcGciex8XLylA+xrXTZmMfr7lpPvebnHxZmfM1G7WhqxzpUXG4SjxnIKzPvU2W8uW6UgJPcZiGce0GKe4yaLybKEU9
X-Gm-Message-State: AOJu0YyAY4aZNGuJs6oGLotA6F1xKBBqzlNl95d5W+OhzL/+tCEwHSkn
	+CwkbTO167t2Bds0Mq6XytK74DXgXUY9k2Q+0caKzv3CWVF0+jEadoYcI93XmJcPo2f8Zy6Szg+
	/8YVXLl4lPXx9kdZ27SNMrdI5brOQMS1u1yzXmaCFwArEgQ9m+lPts0qklRqBGuEX318id2U9/r
	JpmbeIjXw8L5JtuIg6Yjw3zh0i4U7vhtwHGoyeTqtMg/6/
X-Received: by 2002:a5d:5f88:0:b0:367:2945:4093 with SMTP id ffacd0b85a97d-367cea9641amr5288870f8f.40.1720649095640;
        Wed, 10 Jul 2024 15:04:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4RsMhRx4b7K69gGzPS4i9eFbJL1CdwzkwON4Rx/q599P28tz2n1hwhqhx+Aw4ba05nmViVYYj3SyKU2p+3i4=
X-Received: by 2002:a5d:5f88:0:b0:367:2945:4093 with SMTP id
 ffacd0b85a97d-367cea9641amr5288861f8f.40.1720649095355; Wed, 10 Jul 2024
 15:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710174031.312055-1-pbonzini@redhat.com> <20240710174031.312055-3-pbonzini@redhat.com>
 <CAF7b7mogOgTs5FZMfuUDms2uHqy3_CNu7p=3TanLzHkem=EMyA@mail.gmail.com> <Zo8DjhQq3GOpmO5f@google.com>
In-Reply-To: <Zo8DjhQq3GOpmO5f@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Jul 2024 00:04:42 +0200
Message-ID: <CABgObfbfA6oGVcHwFH10YC7EEMw2A9W-L1aJjHAWGRajog6uwA@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] KVM: Add KVM_PRE_FAULT_MEMORY vcpu ioctl to
 pre-populate guest memory
To: Sean Christopherson <seanjc@google.com>
Cc: Anish Moorthy <amoorthy@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, binbin.wu@linux.intel.com, xiaoyao.li@intel.com, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:56=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Wed, Jul 10, 2024, Anish Moorthy wrote:
> > On Wed, Jul 10, 2024 at 10:41=E2=80=AFAM Paolo Bonzini <pbonzini@redhat=
.com> wrote:
> > >
> > > +       if (!PAGE_ALIGNED(range->gpa) ||
> > > +           !PAGE_ALIGNED(range->size) ||
> > > ...
> > > +               return -EINVAL;
> >
> > If 'gpa' and 'size' must be page-aligned anyways, doesn't it make
> > sense to just take a 'gfn' and 'num_pages'  and eliminate this error
> > condition?
>
> The downside is that taking gfn+num_pages prevents supporting sub-page pr=
e-faulting
> in the future.  I highly doubt that sub-page mappings will ever be a thin=
g in KVM,
> but two PAGE_ALIGNED() checks is super cheap, so it's soft of a "why not?=
" scenario.

With ARM having multiple page sizes, and not necessarily the same size
in host and guest, using a gfn argument is also unnecessarily
confusing.

Paolo


