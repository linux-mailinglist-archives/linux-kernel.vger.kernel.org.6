Return-Path: <linux-kernel+bounces-270992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7A94481E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1674D288C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36F7189B96;
	Thu,  1 Aug 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGajlqK0"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99C18990E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504067; cv=none; b=ta45908AJEZUnfEkDeoOBolLGetKghoA+yWooEGUCRPmLiZn7RMMnNdgGCXrm2fSCk8NL7Hy6dyyFZjomdhhMKI/yfQIh3dGH5S1tZEQWTZKO0Cgn+9xFXwfss1ICY1jOj+KFKNJvSUxDAlvV7PKcrRt4TxCe7qj9JOjFUpD+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504067; c=relaxed/simple;
	bh=3Io79nUQn8ypd8PwwL4q+T1yD0diA5Tfaz6TUlMiA8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nC6WOyU/W/mrjcsNHKt8nb/80pW/wBvhe3Z6MiSVeeJGu2277UfiaL9G1D7fmPH6ssaKFVrn+DvTMKOK3UXZEESo2VDoG9neZS7DXqGO8MtZSSUNwQqvyd2aEIzPgR+KcSTIAq6aKGTh8IJoiP9UjBmAbJRifW/yHS/LUuAg0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DGajlqK0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so10312753a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722504063; x=1723108863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQVA9z2jkUPxM3dqZI0KDPVXgKoffaizeXmufcNkJbk=;
        b=DGajlqK0Gyyn+hPULgUkUgLzFdFHcVAbeY+X9Ca3AuD4/ymatLH6HcO3HTy9H5NHME
         zOx0sjQGqO01y3smYzWX3bGI2hB8ey4cdvJmQ4czCcKGgs18/hV1O+BExa0tqFSBsZxc
         IcaGGusT/x4c4DC0Jv++B5VV1Ri1m+kaFDOh7Gi1kolcCKrMdqUWlzK9ex5x1sNLqgji
         4r7ACboz+24dUCqbYkIUSPJthaQpS0kd6oneYvNmoGmKGXwEIhqiez5/pVgIJm5bVZ7E
         GfLlo6UUnXNhDRNR7aSIoq9kSLs8qJhVwUt410Fw9s6uzhE5i5iPIHTy49w4GD/a5oFI
         yORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722504063; x=1723108863;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQVA9z2jkUPxM3dqZI0KDPVXgKoffaizeXmufcNkJbk=;
        b=AUHQRv4gYvN52yB0Zx72AJjciDhf49h0uCTYqjKt7dJHljzMu/vy8MoYg71SjPb2PB
         etS4JN2Xmgs1YND88PbB5/hVsOGgpeaxmFo2epmlJmS3R383CSraYg2sWmNs6A1WAMeq
         32oYuov47Ryt3RZ0SpqBkYNqrkRYQB/iA4LExSluNNRrpsmujglwU7uEx1UKAvjHfALL
         q0fMTGoXud2y/nuZBKS0i91CK9NBOEK75fnsGaDYm4gJhMXd2zgsHdiSi6fjP8IggA3F
         YqBmqSwf8aHBG9Bvt3ODtH8bgCHUiPnGOoI2OH3vCTpupj8PVzCESSVer5FSUnMs7+Mf
         o0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWh/6YxBe3BqdhuGog1gu+zsp/5wa8Z9VpNjnN70tBbh6P8UIpvCwFsq1KL5tuWuOoEBwKdcX6Htf7gnXwhLMscEcbC5667xr4F+P1u
X-Gm-Message-State: AOJu0YwK+U/a/veUdSpdsrkGLn8vpG/CXlYTnbN+KpFp2klD3tHmNlnH
	KKgaaJnEgxR6vGRsfrlTRhgIzb4IKxttLB2lgmD5Qradcd/LNQOZgDdWNk0EUHM=
X-Google-Smtp-Source: AGHT+IG4an2mFFKr4wz3Z9DFgeOmmND21A8Rbh3YvwoLKrs/2dCx443xl5h3j8lRXM2FS1yhxPSg2w==
X-Received: by 2002:a50:ee82:0:b0:5a3:3062:36d6 with SMTP id 4fb4d7f45d1cf-5b6fe72ddc6mr1090738a12.1.1722504062925;
        Thu, 01 Aug 2024 02:21:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b017787967sm7857844a12.9.2024.08.01.02.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 02:21:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 51C785F80C;
	Thu,  1 Aug 2024 10:20:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Marc Zyngier <maz@kernel.org>,
  Oliver Upton <oliver.upton@linux.dev>,  Tianrui Zhao
 <zhaotianrui@loongson.cn>,  Bibo Mao <maobibo@loongson.cn>,  Huacai Chen
 <chenhuacai@kernel.org>,  Michael Ellerman <mpe@ellerman.id.au>,  Anup
 Patel <anup@brainfault.org>,  Paul Walmsley <paul.walmsley@sifive.com>,
  Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,
  Christian Borntraeger <borntraeger@linux.ibm.com>,  Janosch Frank
 <frankja@linux.ibm.com>,  Claudio Imbrenda <imbrenda@linux.ibm.com>,
  kvm@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  kvmarm@lists.linux.dev,  loongarch@lists.linux.dev,
  linux-mips@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
  kvm-riscv@lists.infradead.org,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org,  David Matlack <dmatlack@google.com>,
  David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v12 05/84] KVM: Add kvm_release_page_unused() API to put
 pages that KVM never consumes
In-Reply-To: <20240726235234.228822-6-seanjc@google.com> (Sean
	Christopherson's message of "Fri, 26 Jul 2024 16:51:14 -0700")
References: <20240726235234.228822-1-seanjc@google.com>
	<20240726235234.228822-6-seanjc@google.com>
Date: Thu, 01 Aug 2024 10:20:59 +0100
Message-ID: <87wml0egzo.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sean Christopherson <seanjc@google.com> writes:

> Add an API to release an unused page, i.e. to put a page without marking
> it accessed or dirty.  The API will be used when KVM faults-in a page but
> bails before installing the guest mapping (and other similar flows).
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  include/linux/kvm_host.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3d9617d1de41..c5d39a337aa3 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1201,6 +1201,15 @@ unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn=
_t gfn, bool *writable);
>  unsigned long gfn_to_hva_memslot(struct kvm_memory_slot *slot, gfn_t gfn=
);
>  unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot, gfn_=
t gfn,
>  				      bool *writable);
> +
> +static inline void kvm_release_page_unused(struct page *page)
> +{
> +	if (!page)
> +		return;
> +
> +	put_page(page);
> +}

I guess it's unfamiliarity with the mm layout but I was trying to find
where the get_pages come from to see the full pattern of allocate and
return. I guess somewhere in the depths of hva_to_pfn() from
hva_to_pfn_retry()? I think the indirection of the page walking confuses
me ;-)

Anyway the API seems reasonable enough given the other kvm_release_
functions.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

