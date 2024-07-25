Return-Path: <linux-kernel+bounces-262307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5675F93C3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DBAB234C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215B19B3D6;
	Thu, 25 Jul 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxvP7btQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09B1993AF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917049; cv=none; b=FiiPfy+vItObP42pXth1Eg26pZlvQ8J81CEqOPZJr0v7uP3OwIQAvwF/rBaVGt5XrZWIijJIjd3tp62tVtgOcoaPZ/99GWnS+9lfnhyfF9HzRG72E0doo9VH7IU6DOJI2+kHsr4D0tJ0EoOTiT19QQSG5I5CH8+mYAPkFxkkRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917049; c=relaxed/simple;
	bh=m0ZMQ8YI6zzsbMmByAgfdbdlLMaKgzSyQr5EHwcRrR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yi3lHD0+dXCz0pSV+Nglao8Fp6/cZ4DMtxY8XgnOP4ys81GzGP6STUu8yut6wvkVoycD1Nc4RkImA7jYDNG+A6UcyteRox5T5nqOXnbt3LGnZ2tjoyGZdWThXkirDbFbqVfnm+ksgJ1yQE7Pzg24utwdus5ECa9/WN582TrFWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxvP7btQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721917046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6tWMEURn2dHv81Y4P6gz/ql3VBVwZZJb7ZSFI752Xs=;
	b=HxvP7btQi4TiavEjR2+avEhIX8jaY0TtfPvYMnH5n1Ww9INRmKKaOhEnRBLwieH26G+d5Y
	pZVciISWDtQxwrjskaC8HWv6g72XnPUPzn/cXaoNNudCRJ7Ep9hvb66BzYHAnLwqjuPrmK
	1t6dwsyq540R2I3nBnMYRtQXocxAb9w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-yXpyyo95PGyiR6Hg-rXzFg-1; Thu, 25 Jul 2024 10:17:25 -0400
X-MC-Unique: yXpyyo95PGyiR6Hg-rXzFg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-368374dc565so545401f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917044; x=1722521844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6tWMEURn2dHv81Y4P6gz/ql3VBVwZZJb7ZSFI752Xs=;
        b=oP2OZ+Bj+QuFydLHml6wPPhhuKKyGXflm1kKmnHeOcyOtsE2ReNevWS8lKG+4n4TvX
         p37nC+AycVqJalOEL9cdcfh7EYYumSQQt2X+KBkWQ2kxsoBEALx2syGJN7khET9pwmNn
         gHcGjuVNyV1FkDOoWAGmfm2wyCMSiObZuLqGM/dVD5W4kg9bOcL52LNyXhi2p8tKaMCT
         dAdET05Rac+wh5qdhhE7kaKMKn2Qfis5EkpbtNYDWZ8T7fgJaQqCbinNuq9wM4xQBq1a
         KYoO34/c9yb2Chnpl7cjgtet4Q454EUNBwVtbL03gsmcRAU2r9lIKlBhfJ0qEEj5S9se
         MNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbQw9O2Oi1k5BI8N4T9DwPlHykPoXeRRWOmDhPPtgq1IhIuNFXFUWxdbPdJnojPw8KIal2vfmEQYHTRfe1Xg5RDDWWNbnNmlywPE+Q
X-Gm-Message-State: AOJu0YzF0N12sWswyb+38oWOj1BzQsbXqWiZdyANXBI60b/OC1oq6pas
	e8RNKPrcfeRL58h29KezFwzhgu5WfZKQGvkQ5CyTNqd08AJp0hoakoV9HVX1Xrcr8iwb2JqpQ6p
	pTTmV41sETizzVVIMSnbwdRKaKAGiHlpsUUG7nKmzd0UtYy1lIV7IP/hLbXYWoSJZEIMM0dfJD0
	PdouUDv6Te9SYog3afgk+x3yI1wub7aJBs8fyB
X-Received: by 2002:adf:e5cc:0:b0:368:7edd:b141 with SMTP id ffacd0b85a97d-36b3639e019mr1635259f8f.34.1721917044022;
        Thu, 25 Jul 2024 07:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtE1P2i6EA6Nq11L4VNIqAiLzqnkGkUx3rairfHagP1FO4kiy9c/WYOcLgA6DWVqdqFLq/bQE2fCFI1g75aC0=
X-Received: by 2002:adf:e5cc:0:b0:368:7edd:b141 with SMTP id
 ffacd0b85a97d-36b3639e019mr1635239f8f.34.1721917043618; Thu, 25 Jul 2024
 07:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACZJ9cV2gv+A_2wCXowzi9M-HrySeBxNLKfK+bXRLffwR94=fA@mail.gmail.com>
In-Reply-To: <CACZJ9cV2gv+A_2wCXowzi9M-HrySeBxNLKfK+bXRLffwR94=fA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jul 2024 16:17:11 +0200
Message-ID: <CABgObfYzEzZuDSKjB1SYcveTaRMaayvY8cvtPD8qGLvkDiwV5A@mail.gmail.com>
Subject: Re: [PATCH] KVM:x86:Fix an interrupt injection logic error during PIC
 interrupt simulation
To: Liam Ni <zhiguangni01@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 4:00=E2=80=AFPM Liam Ni <zhiguangni01@gmail.com> wr=
ote:
>
> The input parameter level to the pic_irq_request function indicates
> whether there are interrupts to be injected,
> a level value of 1 indicates that there are interrupts to be injected,
> and a level value of 0 indicates that there are no interrupts to be injec=
ted.
> And the value of level will be assigned to s->output,
> so we should set s->wakeup_needed to true when s->output is true.
>
> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> ---
>  arch/x86/kvm/i8259.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
> index 8dec646e764b..ec9d6ee7d33d 100644
> --- a/arch/x86/kvm/i8259.c
> +++ b/arch/x86/kvm/i8259.c
> @@ -567,7 +567,7 @@ static void pic_irq_request(struct kvm *kvm, int leve=
l)
>  {
>     struct kvm_pic *s =3D kvm->arch.vpic;
>
> -   if (!s->output)
> +   if (s->output)

This is the old value of s->output. wakeup is needed if you have a
0->1 transition, so what you're looking for is either

if (level)
  s->wakeup_needed =3D true;

or

if (!s->output && level)
  s->wakeup_needed =3D true;

but your version is incorrect because it would look for a 1->1
transition instead.

Thanks,

Paolo


