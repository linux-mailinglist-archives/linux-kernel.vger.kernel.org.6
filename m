Return-Path: <linux-kernel+bounces-250000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4D992F2D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270761F2358F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5361A0719;
	Thu, 11 Jul 2024 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+/L+bZg"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37EC6EB7C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741987; cv=none; b=Qi9dmllR49m9T0CIvQi1n63LY5BXVEp3C3/1jcXVCVXR7pS14e1+VXbe5pML6JOgeZFYkJmKIKuHW43nsx3M1siOrveIfPVgRRUI/UwyUNgTNQIDQgINZD7I/Q/FPY2pg3Clr4/+UpnwZzn1YnHAQfyfUrefPLq84XM509YEWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741987; c=relaxed/simple;
	bh=eHwJddF+i82eOhfzBTfbWQn49KtPf7X+mrBUinBbdfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3NivrjAXyLC3AZpW0AX6ki588tbzzjBs1iY61KEiT4d/x/plsNDi++6GdTeYA2VHBaeTBEPdHJ2sPomoJQjkwAH4K5THGdY2E1kSjEcyyy+YxhwaZ0xgvZ+hOVDxw6uBdW45LoSM/xc03yfipiE7IYBA00tMrDs4E/U333iOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+/L+bZg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso194178266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720741984; x=1721346784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1ii8KLMLxRl5UF5VTiJZsw30BNj3HWI5MJg1fOCFrg=;
        b=S+/L+bZgkdvJz05Cm9iyiIJDNm355VyPSA9HsiMLiZePQFhWs/DcuEv9Z0lRvRBJXp
         guoj09t5IIQW2MpNUCgrlm5qgH3wF6HThmSWHv0ELUuBD5V0vSRXXX5U5Vbmb614S1lF
         9XgXKONT+TSjTnLj/MJxJUSV3h6nWye1mLgO9OK6JEsGV8r+hymtICdfta7Cb1GWWAhO
         OppbjFfIfhJZ86SzrewF/axThpXAlVYvncLP7Qz60FObvN80dBBPn69O8VeuiS+WRT8y
         +cRp2OSB2287rjKizRLGuA1nSo6RaI2FiaEIdA26v6OudFPv/q8yfkFmYNHlkzuhM+gP
         5v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720741984; x=1721346784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1ii8KLMLxRl5UF5VTiJZsw30BNj3HWI5MJg1fOCFrg=;
        b=pySRpNMvBYoqxmuuF60eEYds2+mFK6dUpbdY4dJfl228qonL0C3Fu70d5WvxHOXNeb
         u1lMnCTjt5lcsZbbkFxeaSQoJAFqFD6szL4v444ESgnDO0DzDHEDCnLf5n/IgI1jyPn/
         jt4Kl7gQBDxGx5LkpXHU7k31NMaER687SG1eEMdQ9Oh568Qs/CX7KM7GNHlXTe44Ylzk
         QWcKoS+LdVKpTVZHMwoM8rqEIKOJK/YvqejIZPH3+YX78O4ZsjO2OMiq/Mnyi0Hh27UX
         ivt3/7uP3YP6rB0Y44qBHu1bnsBvTXt57e8QzhtlFz30+O9ljd+PvUmk2ywcc+Ih2Glv
         PhJw==
X-Forwarded-Encrypted: i=1; AJvYcCU9rGUlcrfVe3qWY0pHDGTNXCmgToYl++HPsNrzqnZT/MAayCuCpG9bIPQzj/d4Yagl6/RhU19Zi7o83wy0GE8N70o8cLLh+q5U90Ri
X-Gm-Message-State: AOJu0YweWaAqgAn2ehHFPoQ+P8vvfyC+HpPIA46x7L8XSKB0QjXLz46j
	mwP7X3pOJAGJxnh+i3XnluN8L5TUHllOgfqprcP89AAap0fanAQ7CJR0S+p7eoX31xaKfiwH0SV
	xZjwmdUCm0uzFGXPeohua7meHqvIU6feLIVMx
X-Google-Smtp-Source: AGHT+IGg/L+LIOLGS8JdBlkXQAM9OjIKvUIv0USQWI0ixWzGE8fSPNkcsknZoKiaKzNv9LECa/JaMTAQzxubG6QsFVs=
X-Received: by 2002:a17:906:cc9a:b0:a77:c7d7:5ece with SMTP id
 a640c23a62f3a-a780b701683mr557985866b.35.1720741984043; Thu, 11 Jul 2024
 16:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com> <20240710234222.2333120-15-jthoughton@google.com>
In-Reply-To: <20240710234222.2333120-15-jthoughton@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 11 Jul 2024 16:52:38 -0700
Message-ID: <CALzav=d=LaVCFTLxzJD8C_=6+fxjsoLxdKOnxKBgn_QdNDOoXw@mail.gmail.com>
Subject: Re: [RFC PATCH 14/18] KVM: Add asynchronous userfaults, KVM_READ_USERFAULT
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:42=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> +       case KVM_READ_USERFAULT: {
> +               struct kvm_fault fault;
> +               gfn_t gfn;
> +
> +               r =3D kvm_vm_ioctl_read_userfault(kvm, &gfn);
> +               if (r)
> +                       goto out;
> +
> +               fault.address =3D gfn;
> +
> +               /* TODO: if this fails, this gfn is lost. */
> +               r =3D -EFAULT;
> +               if (copy_to_user(&fault, argp, sizeof(fault)))

You could do the copy under the spin_lock() with
copy_to_user_nofault() to avoid losing gfn.

