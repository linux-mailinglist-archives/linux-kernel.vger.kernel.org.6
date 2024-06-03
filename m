Return-Path: <linux-kernel+bounces-199537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6868D884B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8A51F2287C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789C137C33;
	Mon,  3 Jun 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApaSl7NM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C817E579
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437422; cv=none; b=lFPJqVbSlHtTueaWSEiltXIRdqVhNNsjp6qXqBNNCO5oX7y8NyUZZT3p5M6tncFKpgSS9U0urRC/HMP5cMBslvOUe3zWU7F76VY7GxcpchpQk1Nd5OYfp+bHA5M5IONGArAG2WnWbuY0mHpUfX+oIg6kk5UPvFQtcfoZE4SS1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437422; c=relaxed/simple;
	bh=fWAP3N6MuHEmaWc7CmU7MdF8HstC514BjuCq3RVc2y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9DAK3NNZLv4M0yeznJuwKaE5fMdrtsOfZMmOO8fyAq9HpvdsCZ2CKhqKstFynnx5gb56FzOj47xXVfh1IpCQ1iHk/PsFa8zkZM/TGN7Jox5kY40Z8mXcQMuMaSkqFx/ljs57DuH3yuG/499OfW2O7sDF6sCG5kBkJNQoNI6r7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ApaSl7NM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717437420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgpZ2iFr+VdiA4WiQP7BEFnqLmDnPEfXbQIX46yfzqo=;
	b=ApaSl7NM0BaSQZlzvKnbqgVzjXGLwnweAGTnoG+8qHBxH6LbPPVCNq1Xe8ZP3ZqLFH93Zw
	f6rldu+loJvIcQjq+2A7WMzR+Fhc/rDvhfpsCxi2sByjmZ7PBLB1YNYB2x196Rg/tqzeu1
	TskO6b3fI6yOC6QpVAUrTBMBMei0c3g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-9eipoTzbM5q77OvgNhrD5g-1; Mon, 03 Jun 2024 13:56:58 -0400
X-MC-Unique: 9eipoTzbM5q77OvgNhrD5g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3580f213373so3101221f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437417; x=1718042217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgpZ2iFr+VdiA4WiQP7BEFnqLmDnPEfXbQIX46yfzqo=;
        b=jiCsiHS/oi+rdQfjEljfSSmxdPBDN2gKEkmpD/rfGiQyE4Vh1kKlXxhn9vGxkwPJnW
         Ra1yQxKM8/uoJNm8dLjbB8mTc0vOmFwcY2i/I7eJiidkkNB61j4jRHb/PPJRZsqYAY9P
         8UfGwOMOX5gO1PrpyYOMqwjNLDQSPcWBmBit5pjW/1riy0BKd8brsgiZtSziBS5ORtVv
         TCmIrFPDrzy5dwhPoE5sYf/lMXESqYbLcyQh07hNcQ/D1mW0sKqwmMf7hZYUgv3PTls3
         1Egq7Xy/o9Z+Q52dT9IgMWf1swFCXpGZ8fGPHxdMf1XVkUGKuwv7NQd9WBbPUlcFBuIB
         WSKg==
X-Forwarded-Encrypted: i=1; AJvYcCXCQDCKLSTZCe+zUYOfiSXrFi0oOIax7M7ZWue/VUydtCwb6lnZ9MGRj/1w8yCRdGFPYe3+RlmSMqUrsirxyecD1B7v+ObFfVue8IvP
X-Gm-Message-State: AOJu0YxPTXWQQGWVbZ+KA8AJmFTxmhJQ5qHYX5RIUYA1UBkiMv44OekQ
	MST5oKRy+hmfZt+craZRdavr6owrditrsBTaKgCqL7J0QIemRAV2TkkuXV8RMj+aV06wn5qMDWD
	NECY/qz/WDoAcYnHgn56aLuRWjaiaX69384t58AocZ5Aj8n9+yCMU0DlpFPVvN1QmSjNpnYUYlP
	QqJl3DBq6e+lklbxTEV4MhD3OPGaNRZBkwcc/v
X-Received: by 2002:a5d:484d:0:b0:354:f1ba:3b20 with SMTP id ffacd0b85a97d-35e0f30eccdmr6063131f8f.54.1717437417688;
        Mon, 03 Jun 2024 10:56:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj5UGIx9WUZ13oTSIicGvgEuq/VINKKOIOvuQiE8mHa398J9mMp7uwCYO8MgO/UwaqYRvY5hEEn8xo1slDrxY=
X-Received: by 2002:a5d:484d:0:b0:354:f1ba:3b20 with SMTP id
 ffacd0b85a97d-35e0f30eccdmr6063122f8f.54.1717437417367; Mon, 03 Jun 2024
 10:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98ad0dab3a2c66834e50e6d465dcae47dd80758b.1717436464.git.babu.moger@amd.com>
 <Zl4DQauIgkrjuBjg@google.com>
In-Reply-To: <Zl4DQauIgkrjuBjg@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Jun 2024 19:56:45 +0200
Message-ID: <CABgObfY5athiQKdV8LQt3b=yKEgydOXRdfXeLz1C8Ho=ZrqOaQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: Fix Undefined Behavior Sanitizer(UBSAN) error
To: Sean Christopherson <seanjc@google.com>
Cc: Babu Moger <babu.moger@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 7:54=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> > However, VM boots up fine without any issues and operational.

Yes, the caller uses kvm_handle_hva_range() as if it returned void.

> Ah, the "break" will only break out of the memslot loop, it won't break o=
ut of
> the address space loop.  Stupid SMM.
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index b312d0cbe60b..70f5a39f8302 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -651,7 +651,7 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_=
range(struct kvm *kvm,
>                                         range->on_lock(kvm);
>
>                                 if (IS_KVM_NULL_FN(range->handler))
> -                                       break;
> +                                       goto mmu_unlock;
>                         }
>                         r.ret |=3D range->handler(kvm, &gfn_range);
>                 }
> @@ -660,6 +660,7 @@ static __always_inline kvm_mn_ret_t __kvm_handle_hva_=
range(struct kvm *kvm,
>         if (range->flush_on_ret && r.ret)
>                 kvm_flush_remote_tlbs(kvm);
>
> +mmu_unlock:
>         if (r.found_memslot)
>                 KVM_MMU_UNLOCK(kvm);

Yep. If you want to just reply with Signed-off-by I'll mix the
original commit message and your patch.

Paolo


