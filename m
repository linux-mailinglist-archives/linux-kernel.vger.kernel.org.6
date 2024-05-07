Return-Path: <linux-kernel+bounces-171780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E08BE890
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E5E1F241D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7B16ABFA;
	Tue,  7 May 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcRhUQWN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1C1649C8
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098687; cv=none; b=h8FX/FMBEeHsHfGHM7tr6PiJ2e7HOtj+fqBmdKqMzOvYHHd+zwheBxNw9Bx0zINYtdg0jM55OSz9TcR9TFHy28SJtOcy4+3OWRMGAL7/Xiaulyxz+c80f/yTmM28RG+axVwPw0TsB3ZWIXD/Q1jz8SlRQSR9Ic4/T5O+mpOZxH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098687; c=relaxed/simple;
	bh=bmDYFgLs0Cmm7WmKjXSCVcMrHQMbufeoCPqNMYFR29c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3Ru76dfWPAe9UN2Uwpa2ROqxjSWxMZPrIBnz0GMhELjbxyoeKIcUTtRqSnwJdVix8n4v4U+MtBhA+wfBT85DwF6fwHJSQbYODkRTey1NV6OxmJ1OWPWZ/+sHkdt6BaG1Ns59Og8ho1wef4Mndio9JHl7w9eqRGOExsTiViKYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcRhUQWN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715098684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJQKBDLXfhyqpp4QTxdihb4gZQvDUBNWPvIw0Yoz3nM=;
	b=PcRhUQWNzbiau3hjOD7H4oCcBDBY4tUcDReIbdOkWyGGoEVU0f8Lmdu+nRC0Fuayj0/AMD
	SbMUZbbxfQXlxgpU8h+maUcitvSCVzrAMeCvUiqNZh63tbQp22it7Fr8xTBUPYQBhzTZy8
	+VZmVLQkTfMAzrrU2DiU3+1+yrN7mIA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-MUodNDrvNai0Yv1cffRgsw-1; Tue, 07 May 2024 12:18:02 -0400
X-MC-Unique: MUodNDrvNai0Yv1cffRgsw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34db1830d7cso1534561f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098681; x=1715703481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJQKBDLXfhyqpp4QTxdihb4gZQvDUBNWPvIw0Yoz3nM=;
        b=UUoeQNDpA3LHdi7YituXeCyBvgpMDe1YrIH6zh+C7fDHmBc4uba/nVshxZAAHCL+jK
         dJeyKcWTDZhUuk1Htx6Q9xluAe4++4Bf+7S87cGaay37rrBjWp2pP6wkiQybxduOUFE7
         sN6ZrLs8UHacMK5k3Yg7QF8h6BoM9TyMknygVC6BySUivZ8E7dicAW4l1qFlWyNFa1HF
         HkRL6i+c298FGcY2EWTJfakz22WzM6y/ZT7VoNC3XOSfnwTN1xdJMHiuXJpyUhamkGCN
         qSFJjWrAqTg0Bn4/5qyASg+Yd/FrvaJoVOWRgMd8YxQ0Wvx1NbGQSzK52SRXnREVHlJA
         JhiQ==
X-Gm-Message-State: AOJu0YyNUn5Ja1lDQcSJeNC/N3hw3tnMPclsgv4el2gahQFa/a2U91+W
	kRGfYNXzt2ehv2qHkrBPiL4De6oOrSP5iYrd+gWVYC0EQS6siomXC2ROpxEps37BW1BXUbPMe9p
	yAToCHUbP/+onoGwF+MtFCrmm3QXUh/XUTGHUnp8Fp17IyyichEM1S4Wj6Qk4ZqB5k0qfq0pRnx
	RB3QASWq4sG/PHOyitrTg932hKoChhjGFhnG2c
X-Received: by 2002:a5d:6205:0:b0:34c:e0d6:bea6 with SMTP id ffacd0b85a97d-34fcaa02522mr238392f8f.29.1715098681568;
        Tue, 07 May 2024 09:18:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8XbzFM1yff/gSrevtfGkUyBLvE34lgU2RXofWjlWekolpZnAK33i5RBY8uSOBt5Tyolo+b18ASIZbf6Vtaoc=
X-Received: by 2002:a5d:6205:0:b0:34c:e0d6:bea6 with SMTP id
 ffacd0b85a97d-34fcaa02522mr238375f8f.29.1715098681160; Tue, 07 May 2024
 09:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404185034.3184582-1-pbonzini@redhat.com> <20240404185034.3184582-7-pbonzini@redhat.com>
 <ZiZBjtQvUuuqqKNF@yilunxu-OptiPlex-7050>
In-Reply-To: <ZiZBjtQvUuuqqKNF@yilunxu-OptiPlex-7050>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 May 2024 18:17:49 +0200
Message-ID: <CABgObfaULPdNbf8yZHEwesDx+KWvt1A+Eps4xY4DkgzhTq9AzA@mail.gmail.com>
Subject: Re: [PATCH 06/11] KVM: guest_memfd: Add hook for initializing memory
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com, 
	michael.roth@amd.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 12:58=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.com=
> wrote:
> > In some cases, it is necessary to defer the preparation of the pages to
> > handle things like in-place encryption of initial guest memory payloads
> > before marking these pages as 'private'/'guest-owned'.  Add an argument
> > (always true for now) to kvm_gmem_get_folio() that allows for the
> > preparation callback to be bypassed.  To detect possible issues in
>
> IIUC, we have 2 dedicated flows.
> 1 kvm_gmem_get_pfn() or kvm_gmem_allocate()
>   a. kvm_gmem_get_folio()
>   b. gmem_prepare() for RMP
>
> 2 in-place encryption or whatever
>   a. kvm_gmem_get_folio(FGP_CREAT_ONLY)
>   b. in-place encryption
>   c. gmem_prepare() for RMP
>
> Could we move gmem_prepare() out of kvm_gmem_get_folio(), then we could
> have straightforward flow for each case, and don't have to have an
> argument to pospone gmem_prepare().

There are 3 flows as you note above - kvm_gmem_get_pfn() and
kvm_gmem_allocate() are different paths but they all need to call the
prepare hook. It is a tempting idea to pull kvm_gmem_prepare_folio()
to the two functions (get_pfn and allocate) but the resulting code is
really ugly due to folio_unlock/folio_put.

> > -static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t i=
ndex)
> > +#ifdef CONFIG_HAVE_KVM_GMEM_PREPARE
> > +bool __weak kvm_arch_gmem_prepare_needed(struct kvm *kvm)
> > +{
> > +     return false;
> > +}
> > +#endif
>
> In which case HAVE_KVM_GMEM_PREPARE is selected but
> gmem_prepare_needed() is never implemented?  Then all gmem_prepare stuff
> are actually dead code.  Maybe we don't need this weak stub?

It's not needed indeed.

> > +     if (prepare) {
> > +             int r =3D kvm_gmem_prepare_folio(inode, index, folio);
> > +             if (r < 0) {
> > +                     folio_unlock(folio);
> > +                     folio_put(folio);
> > +                     return ERR_PTR(r);
> > +             }
> > +     }
> > +
>
> Do we still need to prepare the page if it is hwpoisoned? I see the
> hwpoisoned check is outside, in kvm_gmem_get_pfn().

Yep, it can be moved here.

Paolo


