Return-Path: <linux-kernel+bounces-202329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 629978FCB50
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094811F21B7D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B36519D072;
	Wed,  5 Jun 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XV4ZEjJD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D519B59A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588231; cv=none; b=Ur2PEeG7UQ5wN8hTkDU6YnwchrCWUYzUWNxT4qlmE4KUTHU9RhEm5/ukjfPcdWUZ3ZIF1gOslWBF0GrDc6gZUr3nXF/6K/nbpYg8wuxSqw9oKagDYzO7PDJWWB6Ggn6/9ABvwCvvrK45twSRGWS2i5sahWsLglP1ZyNnnauyHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588231; c=relaxed/simple;
	bh=ONrEo9FNO/9LJSKku7iv/BrnTzWIK6mPQb5zmZ6p3ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KshFD54WNUTeT1pyl3lOyqFHlakZkjOcaId1HKaLAJKIbKCkr1g2Nqz0aA/2+u/1YW0IRVnG804kLkkpT3J/RuWmBK/xHKAtT1WN6z7Z5E/j0BC+E8KNnp//InRs3JIRrIG3XUisAWRbLoEgqbeHUUKOLwq238UrsUelJ0KjVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XV4ZEjJD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717588228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YlG1Bw2xgnk32skP33PtoFJXnD9dZT+4APyJtar36o=;
	b=XV4ZEjJDtVytXVP8hBBdvTjkH+UJu9X41whX+bl77q7PSqAkgh+AWyKpJb8ay3PYDYdg3D
	ZkMrA9xdzC0ZxK41moTm2Pzdx3N9Vz22HJk2LQeNtkAsLwBfcEhlraNM/Dmnf1aJJjDYoK
	7zOmMKclP2e3Xm9HKiUSxQCoK258fDs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-I6IbGtpPMeqKEZzly2yRTQ-1; Wed, 05 Jun 2024 07:50:24 -0400
X-MC-Unique: I6IbGtpPMeqKEZzly2yRTQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42155e1f0aaso9373825e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 04:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717588223; x=1718193023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YlG1Bw2xgnk32skP33PtoFJXnD9dZT+4APyJtar36o=;
        b=M6IefWo6TmM2kGYNmyv4UkPxx8v/2WVM7AE+UglefehKkpU02gmwL3c3gfjAgpliGU
         wP5htKrGCMxu9gVZV9CeeSxyZ2EAnybT05RISdrCa/qnc5NhFnEOe16IFCYE3LJh4N0k
         MMe9GC5DrFUlkDwRGYqWgNY/EchLu5MVNBt8maPnvK9JBEHisiv8KfowXis4HoQ9G3ob
         3vE9zPn5MVC+omAlQ/2DVeq/tgsaFsiRYNjA4DhrtTTHBlI4XjtHQNntFZVbk7tRoMRw
         tt1FHn+017Sr7nE+9/GObyLRvNC8vOcsvyQ61dVY1v7ml9pp7FKoNvpv2yZlx1IBJoVQ
         zQ4A==
X-Forwarded-Encrypted: i=1; AJvYcCUZgKubqjmh1Yec5KMOlPuWeeA3CZDM0c+K+epbfEilBkmDvgsscId6qp5DF1gjoFegmxoGE7uWKWU8TY0RMA//6bXJKZh6gjy58vsR
X-Gm-Message-State: AOJu0YxhhfSF1yXBvus8cmpbe7nBpUs4lS6RmBQmqvposxDwgewpP0zJ
	7JO9RdVNIwnQ65ItZzYys03N37aI06+RGfwk9pe9Mt0I+Qtb7X23TiXFrRZ/cnULABMAQ7aQ2t3
	9S+7ohWhCpuUF/fIZ0uUrVp82Y5oBrweP3bZxA5czu/8b068PPC/oyeWG5dnOVSITq3AwwMWEb6
	ldOalAcoYh22R/oIfkRrRw/VNaIvEB9MEInaNF
X-Received: by 2002:a05:6000:e8c:b0:35a:62e3:7103 with SMTP id ffacd0b85a97d-35e8406df3fmr2232090f8f.2.1717588223659;
        Wed, 05 Jun 2024 04:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1hBpVkwUAsy5NCJn3bUgFRhVOdiW5gUbZZW6lmADP3rMiS2Grtmju2yHiy1M7tLme7GF6GfKPF6kT8CkEllU=
X-Received: by 2002:a05:6000:e8c:b0:35a:62e3:7103 with SMTP id
 ffacd0b85a97d-35e8406df3fmr2232070f8f.2.1717588223353; Wed, 05 Jun 2024
 04:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531044644.768-4-ravi.bangoria@amd.com> <20240605114810.1304-1-ravi.bangoria@amd.com>
In-Reply-To: <20240605114810.1304-1-ravi.bangoria@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 5 Jun 2024 13:50:11 +0200
Message-ID: <CABgObfbq2sZ9U=8650EJq4FqiO=Dz2_mivOj_GponeNn2KyAVQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: SNP: Fix LBR Virtualization for SNP guest
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: seanjc@google.com, nikunj.dadhania@amd.com, sraithal@amd.com, 
	thomas.lendacky@amd.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	michael.roth@amd.com, pankaj.gupta@amd.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:49=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.com=
> wrote:
>
> SEV-ES and thus SNP guest mandates LBR Virtualization to be _always_ ON.
> Although commit b7e4be0a224f ("KVM: SEV-ES: Delegate LBR virtualization
> to the processor") did the correct change for SEV-ES guests, it missed
> the SNP. Fix it.
>
> Reported-by: Srikanth Aithal <sraithal@amd.com>
> Fixes: b7e4be0a224f ("KVM: SEV-ES: Delegate LBR virtualization to the pro=
cessor")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> - SNP support was not present while I prepared the original patches and
>   that lead to this confusion. Sorry about that.

No problem, this is a semantic conflict and your original patches will
go in 6.10. Applied to kvm/next.

Paolo

>  arch/x86/kvm/svm/sev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 7d401f8a3001..57291525e084 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2395,6 +2395,14 @@ static int snp_launch_update_vmsa(struct kvm *kvm,=
 struct kvm_sev_cmd *argp)
>                 }
>
>                 svm->vcpu.arch.guest_state_protected =3D true;
> +               /*
> +                * SEV-ES (and thus SNP) guest mandates LBR Virtualizatio=
n to
> +                * be _always_ ON. Enable it only after setting
> +                * guest_state_protected because KVM_SET_MSRS allows dyna=
mic
> +                * toggling of LBRV (for performance reason) on write acc=
ess to
> +                * MSR_IA32_DEBUGCTLMSR when guest_state_protected is not=
 set.
> +                */
> +               svm_enable_lbrv(vcpu);
>         }
>
>         return 0;
> --
> 2.45.1
>


