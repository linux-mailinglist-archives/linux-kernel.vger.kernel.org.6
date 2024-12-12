Return-Path: <linux-kernel+bounces-442998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D29EE549
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6320318870BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD42B211A1A;
	Thu, 12 Dec 2024 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPVHzzkl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286EE20C01A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003892; cv=none; b=cF3dOv1rIMW/k3Xaba1xUW/xHMOo5SHsxTUi7gY5Skj/E0Bbn3Pitpo51m+SxuPxmXrkEh7c9zwxpMDCxixeEqQwhKzRlhJUYErzzQgvRb0Vg95ryyTbWRejT29QGIcktaD10j2ih9PXJR47pNxIITaKqQ3AwkVtn2lgcmFmy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003892; c=relaxed/simple;
	bh=HyXEfR+D1qnH4DNim5iPlsqxtl1hQOSDGzR8IuOmMmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJxCUxz+tOj41GZ6f/GsHr/8oO2+upj7RI3g/HmEUSigyhF/PqBFz87u/cJZR3eFPGSMTRwsNqO2RgOW7raPV7M3rdXRf2vI44QxEYMClzGkobYV1PfUEzOGk78xgmwmMQoqKar/pUL+5m0EO/hKAaNy9F3GJ/NGZgJ6WMPiCzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPVHzzkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C56C4CED1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003891;
	bh=HyXEfR+D1qnH4DNim5iPlsqxtl1hQOSDGzR8IuOmMmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fPVHzzklKAtNaesDcx4kEA6JJe7qF0gAtQ+lyM0+rzHG+KCVlpZf3vzArk7zEA53o
	 Gt+35JvNWvwo/xhxqixJqDj/tZBM8RO9wWJ44tb1FfOUxgjn5oFyerYP7qXENa0ryR
	 sgx68Ii7huWdLrsabV78RwP6+V9ESMajRr3jr/K/9SunzG9mCtC74SCjRMgCLDvOfO
	 tASeeajOMdDiMm7qYekZJ3vLimWrG7clYiJ3kSJ8wQ0kWZUF9VFBEwxup8bv+y6TfR
	 pDJsKh+LVrn1xmVxXmBlq7Va14nKfluK+lExKokL7WW76JIGfqO6gptdmeEGG7/i2w
	 +SUjF0toZAJqg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30229d5b229so3912171fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:44:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFSmggUKBAWXcSBKJQWgAQJPhHwcRehFygeXmz6Zbk2z2Z9U8TW/kSqewPBc45nt02JdyQ5qPfO7fRSeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmBHaaCMNIlq+NQYc7Z5RMa/gLCJTa6yNoB1EIPAa0j4evAd13
	S7OYiT+Bekuo92kKPr9ZvIGZhxqIDQP1lbXK2idTciiOSfwGPFbS3if4WVaQ1evGttjrfwhx4OR
	E+Hhp/kYxLlVbk1jGt2SSGW+t3OQ=
X-Google-Smtp-Source: AGHT+IEbX5tqLnIbrK2KEGYQZQxlBqgxXKYoEGIDV/zv3l8JcHTRnWkTERVd8YDrkMv47zVzM5r8d0CCEZeG/SsqelY=
X-Received: by 2002:a2e:a586:0:b0:302:1d7a:e09 with SMTP id
 38308e7fff4ca-30249e830a2mr8588641fa.31.1734003889992; Thu, 12 Dec 2024
 03:44:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212081841.2168124-8-ardb+git@google.com> <20241212081841.2168124-12-ardb+git@google.com>
 <Z1rJ_dMJJzGOmjNs@google.com>
In-Reply-To: <Z1rJ_dMJJzGOmjNs@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Dec 2024 12:44:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXERuRK_MdHJOY+SKR=BJ-Yi+q0FNgVayq3W_jL9zdjLVA@mail.gmail.com>
Message-ID: <CAMj1kXERuRK_MdHJOY+SKR=BJ-Yi+q0FNgVayq3W_jL9zdjLVA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] arm64/kvm: Avoid invalid physical addresses to
 signal owner updates
To: Quentin Perret <qperret@google.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 12:33, Quentin Perret <qperret@google.com> wrote:
>
> On Thursday 12 Dec 2024 at 09:18:46 (+0100), Ard Biesheuvel wrote:
> > @@ -908,6 +892,9 @@ static bool stage2_leaf_mapping_allowed(const struct kvm_pgtable_visit_ctx *ctx,
> >       if (data->force_pte && ctx->level < KVM_PGTABLE_LAST_LEVEL)
> >               return false;
> >
> > +     if (data->annotation && ctx->level == KVM_PGTABLE_LAST_LEVEL)
> > +             return true;
> > +
>
> I don't think it's a problem, but what's the rationale for checking
> ctx->level here? The data->force_pte logic should already do this for us
> and be somewhat orthogonal to data->annotation, no?
>

So you are saying this could be

> > +     if (data->annotation)
> > +             return true;

right? That hides the fact that we expect data->annotation to imply
data->force_pte, but other than that, it should work the same, yes.

> Either way, the patch looks good to me
>
>   Reviewed-by: Quentin Perret <qperret@google.com>
>

Thanks!

