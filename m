Return-Path: <linux-kernel+bounces-343089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC49896A2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84493B21328
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017B73F9FB;
	Sun, 29 Sep 2024 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A0rdhj0C"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D49338396
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727631382; cv=none; b=N13gIpI4kutBPtDTBs76QkkBFIyRqtLWUBevGqRRhYATJRvlKZjrm0Yy8LwgsPD2p5xbCaiHdlRUXV/EwCZVKb12CT3J6uzPAvaOvLRLb9fYM8/auEVcfDjLPAouM0zdkpEj6H8eoamGSrh13hY6MlLIetqGZoFROc1qFHj2Qjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727631382; c=relaxed/simple;
	bh=pJ2+5xf3JPLPFG7ajx6iu9zP2xRrrmOhbM89yxGePGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwYHiNx4jl22O5bAcnKCMfV0Dx/ziB+79EG7gEd6zfYGe+1J9j72dvGlYWKYcyn6XCNGfbewL6PcGmvtsuFx3BKLq/B8Ua3bZe++BkX885XheAUTCX4kw4ubnKI6F42bZxRkjOOA2cr7Dud1ZLegFT89lxSB/ryTpzkrxBCIh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A0rdhj0C; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso668694766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727631378; x=1728236178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vi4TCfM4jiQzxcMHDXObhlmlU/euEJoDfcgbZrM6Np0=;
        b=A0rdhj0C8G6pPe7ctTmtvRGLajRIkcIA5DYum+5yTE3V2u864UoRurrFy/y2/Q4mQC
         fcnEPtLa4ZzgSQRQmkqYmfY2Im3s5Tn5BpW1y2JKtNy16o3dh8c4CPeqrpmr5/IpWJ6a
         cGmIvmhSkZrJ39CYePwociZbJXFtGAOYlvkls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727631378; x=1728236178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vi4TCfM4jiQzxcMHDXObhlmlU/euEJoDfcgbZrM6Np0=;
        b=qQ4UaGNBzeGi/kkSkiZqD7RjKlNCLkQ1jvF9XRb+NV95lE9sckBFYvu/IenShEsh7Y
         +5kcsNjNM1N+x75F4tjKIdxzV4OslZczo4zX33dD42G/Vyoi7o8C6F+CED1vAtNJFOGM
         vRcLU2eObB0E8YhMZLQVycDavg7tGvSFXXEjnPPVTjT/eE7zT9Au7YyQwG8EaTcxha+4
         2MEhEST8T+i2E2MJWe6ptFlbp+X54/qk4UE2S5LtoC6PqE0jmv+q3iP8HzewykqUnbEm
         /+Kq7HJKLfSWA0Hhx5BdYu4erDoh8TdNjNXnNjnDJQMCHDhqnYpJG9Nc/gimcXUgtKi/
         9o0A==
X-Gm-Message-State: AOJu0YzNhLMJSEeb7j4NLGsWGBHbNJk0zWHOauJpM9mkH52gL3Z+WQkd
	vj8DaWyhdMTvYhmbIV32B9wEvUvGxy2KUwS2HumiXP+hxtliJl5Umf1IHItzYeP99hNfZfxsAh/
	qChM=
X-Google-Smtp-Source: AGHT+IERxQ4Ks4JfmrBrxmcJnFo/MB6zMBWAqyhalz5Djckhr1ZEpb457YccFqDchMd0TFKxQeZblQ==
X-Received: by 2002:a17:907:d2e5:b0:a8d:5f69:c839 with SMTP id a640c23a62f3a-a93b15f92aamr1243930066b.15.1727631378140;
        Sun, 29 Sep 2024 10:36:18 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2978a04sm410951866b.144.2024.09.29.10.36.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 10:36:16 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso431653166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:36:16 -0700 (PDT)
X-Received: by 2002:a17:907:7f26:b0:a75:7a8:d70c with SMTP id
 a640c23a62f3a-a93c3098a87mr1232049066b.4.1727631376200; Sun, 29 Sep 2024
 10:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928153302.92406-1-pbonzini@redhat.com>
In-Reply-To: <20240928153302.92406-1-pbonzini@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Sep 2024 10:35:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQ2m+zkBUhb1m=m6S-H1syAgWmCHzit9=5y7XsriKFvw@mail.gmail.com>
Message-ID: <CAHk-=wiQ2m+zkBUhb1m=m6S-H1syAgWmCHzit9=5y7XsriKFvw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/x86 changes for Linux 6.12
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Farrah Chen <farrah.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007b816506234586fa"

--0000000000007b816506234586fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Sept 2024 at 08:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Apologize for the late pull request; all the traveling made things a
> bit messy.  Also, we have a known regression here on ancient processors
> and will fix it next week.

.. actually, much worse than that, you have a build error.

  arch/x86/kvm/x86.c: In function =E2=80=98kvm_arch_enable_virtualization=
=E2=80=99:
  arch/x86/kvm/x86.c:12517:9: error: implicit declaration of function
=E2=80=98cpu_emergency_register_virt_callback=E2=80=99
[-Wimplicit-function-declaration]
  12517 |
cpu_emergency_register_virt_callback(kvm_x86_ops.emergency_disable_virtuali=
zation_cpu);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  arch/x86/kvm/x86.c: In function =E2=80=98kvm_arch_disable_virtualization=
=E2=80=99:
  arch/x86/kvm/x86.c:12522:9: error: implicit declaration of function
=E2=80=98cpu_emergency_unregister_virt_callback=E2=80=99
[-Wimplicit-function-declaration]
  12522 |
cpu_emergency_unregister_virt_callback(kvm_x86_ops.emergency_disable_virtua=
lization_cpu);
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

which I hadn't noticed before, because I did just allmodconfig builds.

But with a smaller config, the above error happens.

The culprit is commit 590b09b1d88e ("KVM: x86: Register "emergency
disable" callbacks when virt is enabled"), and the reason seems to be
this:

  #if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
  void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callback=
);
  ...

ie if you have a config with KVM enabled, but neither KVM_INTEL nor
KVM_AMD set, you don't get that callback thing.

The fix may be something like the attached.

                   Linus

--0000000000007b816506234586fa
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m1nv3bmn0>
X-Attachment-Id: f_m1nv3bmn0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3JlYm9vdC5oIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3JlYm9vdC5o
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcmVib290LmgKaW5kZXggZDBlZjJhNjc4ZDY2Li5jMDIx
ODNkM2NkZDcgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3JlYm9vdC5oCisrKyBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3JlYm9vdC5oCkBAIC0zMSw2ICszMSw4IEBAIHZvaWQgY3B1
X2VtZXJnZW5jeV9yZWdpc3Rlcl92aXJ0X2NhbGxiYWNrKGNwdV9lbWVyZ2VuY3lfdmlydF9jYiAq
Y2FsbGJhY2spOwogdm9pZCBjcHVfZW1lcmdlbmN5X3VucmVnaXN0ZXJfdmlydF9jYWxsYmFjayhj
cHVfZW1lcmdlbmN5X3ZpcnRfY2IgKmNhbGxiYWNrKTsKIHZvaWQgY3B1X2VtZXJnZW5jeV9kaXNh
YmxlX3ZpcnR1YWxpemF0aW9uKHZvaWQpOwogI2Vsc2UKK3N0YXRpYyBpbmxpbmUgdm9pZCBjcHVf
ZW1lcmdlbmN5X3JlZ2lzdGVyX3ZpcnRfY2FsbGJhY2soY3B1X2VtZXJnZW5jeV92aXJ0X2NiICpj
YWxsYmFjaykge30KK3N0YXRpYyBpbmxpbmUgdm9pZCBjcHVfZW1lcmdlbmN5X3VucmVnaXN0ZXJf
dmlydF9jYWxsYmFjayhjcHVfZW1lcmdlbmN5X3ZpcnRfY2IgKmNhbGxiYWNrKSB7fQogc3RhdGlj
IGlubGluZSB2b2lkIGNwdV9lbWVyZ2VuY3lfZGlzYWJsZV92aXJ0dWFsaXphdGlvbih2b2lkKSB7
fQogI2VuZGlmIC8qIENPTkZJR19LVk1fSU5URUwgfHwgQ09ORklHX0tWTV9BTUQgKi8KIAo=
--0000000000007b816506234586fa--

