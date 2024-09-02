Return-Path: <linux-kernel+bounces-311011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66759683E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F961C20430
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8461D2F52;
	Mon,  2 Sep 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoPszJ9a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A41C3314
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271138; cv=none; b=uU4mlDAk5BAK5VklFGVVqBwJLieZs6EKlP81d9X+whw4QuXiklkm9zOSq2vzUMMLeIBgrY9W8Mqkc0oHDlgr+lvcU7UQVqyAnHRuoEqswd+NiCVvwnqlcyzriHSK8xtzTfIK2ybxatB4bvCgOcnUWanlnANwS0P91bHO8imKy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271138; c=relaxed/simple;
	bh=BTRkW3xmxXHurQAVY701fWMBVhIpjdnc5tz3yF4Tua0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntfmiISVkvdvSiCJ44QOn0VKqmH8SqXvD/goCRt3b3DY3w4TdyPp4tD+aY0x3uY4NllxrcpM2mLqAm4tiAoe6IKsfkDiVXAZ1aVDOXDXkYH2+ZsbzhXQmJwwM8+hxk3CSbj/CqEcKzcnOYKMq565rKWRArgjYnIdSNAk/pNBe14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoPszJ9a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725271135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ+K8eSEOtaWbpAfWLmNDheCB3Bj04E+T76/DftjJL8=;
	b=AoPszJ9aYXceWU5gyrm7DM37e28sIXPvBBDI0rheq9DG5O/yVSSVxRZJ26k4bc2WcRqJco
	97KoB1x5jA7kYGFy10Pm4rvvqZgdhrqy2ypiEo5N+3b9gDHtcB5O/Fau5S3GPCDcwGWYhH
	ZYYv7Q37ejRtNNVZjftzBHZA1/ubAoI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-isiSPLdHOcOkyWscozsIlA-1; Mon, 02 Sep 2024 05:58:54 -0400
X-MC-Unique: isiSPLdHOcOkyWscozsIlA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374cd315c68so318749f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271133; x=1725875933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ+K8eSEOtaWbpAfWLmNDheCB3Bj04E+T76/DftjJL8=;
        b=hJL/Kg3OFT+emIQobQt64Oy9wo48MRxLyPl4mY0Lgq2eY5mSXhMd1ASyysHDQokuo8
         2IntuX/TZqXqch2MQv5TbpK2hfwhTGp5blfxb7I3Fo93SsouPNXW5tF6z0svpSOrFdzn
         9d2h3vj+0dE3hOgIWz4Vx26wQu2itDGUTp0H0OgxG8DC57BHdRbqURwGGKDG5xhoRbRs
         Gu5Oo9qxuMUuNDawarduoqmPZB42FUcbkEPziIG4kpnQaPjq+NCL49wfeIpQxNhrKogl
         V92s05Wj/cR8bTm41TQ8vZlTVbLxqr76rrShipF+w8E7NzZpuxJskp3liKc5EXtcHP2x
         92BA==
X-Forwarded-Encrypted: i=1; AJvYcCXfjVbgWoYqWW29kvizWvCunVnOaoI6nFQeoUjhG2167xSGwcBz/xahM5HwbR8b1QvQY9QEvemizrlpw/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgLa6nA6SSRGZxKWiBXZvWJrwh9DmR25OMk748p5kVmAeqXM0r
	nsquo+W1YToskCQZVIumlVqLh19eGZMSHlS1AhNd/E5cPRXPWu+x7rtH0QL10t3qHD6jR0B8zF9
	Wpe99DQ8/CryCaO5g8+NA8vVcnTathW8qSb0f6sMB6/I0PV6hdf6U+cVTOhxxD1jxQ8iq7MeSN+
	M+IBaYIp3XhVguZJl1cia8PEa5+NNAsKuWnJ7a
X-Received: by 2002:a5d:598c:0:b0:371:899b:5c5 with SMTP id ffacd0b85a97d-3749b54d9dfmr8779777f8f.27.1725271133241;
        Mon, 02 Sep 2024 02:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhkdHZNQcsFtS77EBUtm4w/qI+BidAfcz4I4KmP/oeWMIUFO7gY8HdOCvuLo/g6faFQsWixvT4rfu2njLFZVc=
X-Received: by 2002:a5d:598c:0:b0:371:899b:5c5 with SMTP id
 ffacd0b85a97d-3749b54d9dfmr8779762f8f.27.1725271132794; Mon, 02 Sep 2024
 02:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802195120.325560-1-seanjc@google.com> <20240802195120.325560-2-seanjc@google.com>
In-Reply-To: <20240802195120.325560-2-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Sep 2024 11:58:40 +0200
Message-ID: <CABgObfYT_X3-Qjb_ouNAGX1OOL2ULT2aEA6SDKessSbJxGZEOQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: x86: Re-enter guest if WRMSR(X2APIC_ICR)
 fastpath is successful
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 9:51=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> Re-enter the guest in the fastpath if WRMSR emulation for x2APIC's ICR is
> successful, as no additional work is needed, i.e. there is no code unique
> for WRMSR exits between the fastpath and the "!=3D EXIT_FASTPATH_NONE" ch=
eck
> in __vmx_handle_exit().

What about if you send an IPI to yourself?  Doesn't that return true
for kvm_vcpu_exit_request() if posted interrupts are disabled?

Paolo

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index af6c8cf6a37a..cf397110953f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2173,7 +2173,7 @@ fastpath_t handle_fastpath_set_msr_irqoff(struct kv=
m_vcpu *vcpu)
>                 data =3D kvm_read_edx_eax(vcpu);
>                 if (!handle_fastpath_set_x2apic_icr_irqoff(vcpu, data)) {
>                         kvm_skip_emulated_instruction(vcpu);
> -                       ret =3D EXIT_FASTPATH_EXIT_HANDLED;
> +                       ret =3D EXIT_FASTPATH_REENTER_GUEST;
>                 }
>                 break;
>         case MSR_IA32_TSC_DEADLINE:
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>


