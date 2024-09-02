Return-Path: <linux-kernel+bounces-311014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87209683ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9671F21136
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B974D13BC0C;
	Mon,  2 Sep 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aO21rqgP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C986126
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271252; cv=none; b=Z2tZL+kkRe3YCvCE0p+uBIUi/QhtG+N7OMYjYRKO5wk76CWe+vvpQJw/KMl8TF/rf57bALaiq0ogBz53tslBy9xYbO8o+UAxZJWLrdsRyMAkv6QwdCtlJPsnWsbWNAsk1sm9VoXldKay/d0uOGM+dBF2HKvBdPnGaS7GzIeRKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271252; c=relaxed/simple;
	bh=LBIzi1LpQ/rTjLpmqqbTh+L8ZKr4rAACHWK5C8SLLBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sf5J4bnHgqcK5u6I/dZBzqPyrgXWiyVy3mE4xkhjeDTLVdNdTFF1xBrLixD9pm95HGwYLGCWWbHJzKFsvNW5ylTDpVBs1aEdjRHvrY57uWUTdXnH6m2fmz+b+tFlCnkxwwBYDd+MIT6Jc8nGhBwY6moaI5+vjx49b2O/FebN4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aO21rqgP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725271248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwCtVYjTsC/+5qLh9aBp3HoHm+8Qd+MXKxdiS5FMHAw=;
	b=aO21rqgPtgD4NZv3G0JQndMpWc7jpBFRboAQLGGtYLmA3PEZPKuc8bfJpR3JJZM5vfDpbQ
	MTAy3JhvbFwh8zJBuZghUSK+889fM46MlmM1wihxdQKuVL8RSGq4yPUSHM5CN4kpJILNhj
	DZCiDJ4RNHX05t+IC6My6u/NTrkVSkQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-OMaKYJyHMfKZ0BGi58sJhA-1; Mon, 02 Sep 2024 06:00:47 -0400
X-MC-Unique: OMaKYJyHMfKZ0BGi58sJhA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bb68e16b0so46278765e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271246; x=1725876046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwCtVYjTsC/+5qLh9aBp3HoHm+8Qd+MXKxdiS5FMHAw=;
        b=As9AjmiTznGBlthLEZEGL77nM8qkQzKco79D44G0HCOyzIeqAp9bd7eVHThVjWCRVe
         ATeKE8f4uLH8vdZKZzVgfMruWZjrB0Y3iGtQ++PlP6+Gqf7BOz298zPHCidhHSWlwLgd
         NPkNiAXRJ431VmnowIB99w7PUo2rG+XS4ijgbYNGHXrlYkciJz2rX9ogMKIoM9Zf2wNd
         b90wyjGK3Mz+Ym4lljCoTU8Kmr62Gao0pIMSs0cBrJNVLX+4CFkOaQLIR1IhfYbHo71T
         PHCCXO9fe1Q7PFzux7AxMmGCgLImu5lA45lhrsEksL684P1z1YararKQy2uxj2aDD54W
         mVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4JczMIIR00V6ZNr9jpbNXR05JrFDn8bRbf2ycfzSgBWzIc8wnrN2pCBiD32TJDYIhmsOXKCTG1hnWBFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvEh2fBVkhwy2jcIBgTnVNs5B1jBpGlODG8gRdK1md7fmMlyno
	HzVCEqF0gJbD+4LWJmrV7tbl08kBzSDU6IyJVF8Y7rZNp/TENerPdoJk6Ebhnt11AUA8iv1NzvE
	E4n4TrllhZLnl0toBlSG90IDZmt9NCQM/PMFHHNnrK0b9Iuz148Xzb3wygUHzwIO/lmImgBm7e5
	872BnzSxOvj7Hu4PAOuHxfkkBY0qg5rwJMYFCy
X-Received: by 2002:a05:600c:474c:b0:429:c674:d9de with SMTP id 5b1f17b1804b1-42bb01ad776mr118711095e9.2.1725271246049;
        Mon, 02 Sep 2024 03:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOuviAeUInZpYXRD0meSDjikwC0zm0YoIdWxbYwWDChPxMnaeeJFb7+Xg7Qs/JQBeQAgsR71gAvgnbt2b40qQ=
X-Received: by 2002:a05:600c:474c:b0:429:c674:d9de with SMTP id
 5b1f17b1804b1-42bb01ad776mr118710895e9.2.1725271245574; Mon, 02 Sep 2024
 03:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802195120.325560-1-seanjc@google.com> <172506359625.339073.2989659682393219819.b4-ty@google.com>
In-Reply-To: <172506359625.339073.2989659682393219819.b4-ty@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Sep 2024 12:00:34 +0200
Message-ID: <CABgObfb390uz6c42PwjF=3Gss+H4MW1_Cs2r=V3cEG7xhYC9RQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM: x86: Fastpath cleanup, fix, and enhancement
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 2:21=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> Applied to kvm-x86 misc, I gave myself enough confidence the fastpath fix=
 is
> correct with a selftest update[*] (which I'll get applied next week).

Sorry for not reviewing this before vacation; done this belatedly and
patches 1/2 may require another thought (or a revert). Hopefully I'm
wrong.

Paolo


> [*] https://lore.kernel.org/all/20240830044448.130449-1-seanjc@google.com
>
> [1/5] KVM: x86: Re-enter guest if WRMSR(X2APIC_ICR) fastpath is successfu=
l
>       https://github.com/kvm-x86/linux/commit/0dd45f2cd8cc
> [2/5] KVM: x86: Dedup fastpath MSR post-handling logic
>       https://github.com/kvm-x86/linux/commit/ea60229af7fb
> [3/5] KVM: x86: Exit to userspace if fastpath triggers one on instruction=
 skip
>       https://github.com/kvm-x86/linux/commit/f7f39c50edb9
> [4/5] KVM: x86: Reorganize code in x86.c to co-locate vCPU blocking/runni=
ng helpers
>       https://github.com/kvm-x86/linux/commit/70cdd2385106
> [5/5] KVM: x86: Add fastpath handling of HLT VM-Exits
>       https://github.com/kvm-x86/linux/commit/1876dd69dfe8
>
> --
> https://github.com/kvm-x86/linux/tree/next
>


