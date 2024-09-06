Return-Path: <linux-kernel+bounces-319535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E2E96FE11
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116ED2830B6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F2D15B135;
	Fri,  6 Sep 2024 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JphLrioD"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E29215AAD3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725662319; cv=none; b=fwBxoILsRfRxcPtnxg84UFUkEYIPpfPUCIYPvX6ik9Fl874IE9R+GF0ZnXvMahdbwEXOYqfXVPR69hMnH7DtDjbKWxzH8n+lti6/EfaZM2KcJRgVDahfIrsNO4kARPU6x/fy9ol00yJK/wVJCvD1/y4u+KeZPTk6RtwH/e+jjvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725662319; c=relaxed/simple;
	bh=6DjXgEpihAA2/g5HWLPjjDNu9oZGS6MvM8OVHKfbVkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4ewuM2XTMZnW0x/3DWR49NReEIBhsaS0MP/YT3QddfyJZRvpQC2kZQlGOCU78fI93BXeG/q5ZhmZFrwJvGOh1bK8Iav8LcBolnPysLOblS3DdvkGsXb+pNLTf8rHD3wXvzXaARI7a8vmefb0Utp2+g5V8xM1vJITCffMIrfMA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JphLrioD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a83597ce5beso410222066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 15:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725662315; x=1726267115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QzP18zWcCgFcNTi1CIuGIcIYtM7nse/YF/iK8sEHePo=;
        b=JphLrioDILdWMfsafOgJq/yz2p+eFLcuPw7T1mJKd8Hp+Ay37WDYSOUkfTpH1874a9
         wSoRy5SVIC4l/xNd0w+7TxhSwA5QPCN9u/eWDJdkmseBxNIWNPxtIkS83Gw8cMJWsbSL
         rTmdApQLWHmDJkTRAmRMGJV3J68Psh0mFjrHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725662315; x=1726267115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzP18zWcCgFcNTi1CIuGIcIYtM7nse/YF/iK8sEHePo=;
        b=bxbg4nLZNgzcJ0gf8tXryJ1dY3jBW1lK1pLOhl9IrdEvdgBZNcp4oGGJ2GLx+Mrb9j
         3/AFie5tk4bLPJOivYoipDtR1wqWumk9c3I5OL8oQNjCHZc0wWriE7Oa+bCyfiQd6lIs
         XRdc5Z+fVnNzhFlu4q3+tIRDcjYCahcV1nyg1k64uwY7/xHHmH4iuP5VLCxo2qbUKspO
         NZK0XLOWZdqGtF1ghcXyKTBkQjpYsIuoGEGOePsHMSujnTVuLoTQ/q431CGvnMvgUjPA
         6He+05xfg8PWsjDwh8rF9mf9ReYY3n1DwWZxOSke1UZdXC1kUBRUf+s/L628utqUEbbk
         Se1A==
X-Gm-Message-State: AOJu0YzBJHpiTgD2e1Y/q0cr9S2qSNeXbl6o+J72CknBLQv62N5mIzCP
	w2XOszd9rabwmyzuQqq+UWALaV4zmsqqgcYDT3GlWY6nVJmt4lI+rOg+3hmxVKOfpdaK7+dNMv5
	8/aU=
X-Google-Smtp-Source: AGHT+IHJo2iooxVTYM0e+0nwuu75+C+Qh+heaA5SlCSbG224CzUAngEqZZ6Cn7kZoyh8B2/+MlOESA==
X-Received: by 2002:a17:907:9287:b0:a7d:c464:d5f3 with SMTP id a640c23a62f3a-a8a85fb7e90mr472768666b.11.1725662314886;
        Fri, 06 Sep 2024 15:38:34 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d259adf76sm1937466b.78.2024.09.06.15.38.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 15:38:34 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c3d8d3ebbdso3232547a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 15:38:34 -0700 (PDT)
X-Received: by 2002:a05:6402:5cd:b0:5c2:6a52:ccc8 with SMTP id
 4fb4d7f45d1cf-5c3db9762b6mr4515569a12.5.1725662313929; Fri, 06 Sep 2024
 15:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906154517.191976-1-pbonzini@redhat.com>
In-Reply-To: <20240906154517.191976-1-pbonzini@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Sep 2024 15:38:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjK7HF3dQT8q_6fr3eLGvKS+c46PdYNVAsHRyQRgcgiyw@mail.gmail.com>
Message-ID: <CAHk-=wjK7HF3dQT8q_6fr3eLGvKS+c46PdYNVAsHRyQRgcgiyw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM fixes for Linux 6.11-rc7
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 08:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> - Specialize return value of KVM_CHECK_EXTENSION(KVM_CAP_READONLY_MEM),
>   based on VM type

Grr. This actually causes a build warning with clang, but I didn't
notice in my "between pulls" build check, because that is with gcc.

So now it's merged with this error:

   arch/x86/kvm/x86.c:4819:2: error: unannotated fall-through between
switch labels [-Werror,-Wimplicit-fallthrough]

and I'm actually surprised that gcc didn't warn about this too.

We definitely enable -Wimplicit-fallthrough on gcc too, but apparently
it's not functional: falling through to a "break" statement seems to
not warn with gcc. Which is nonsensical, but whatever.

                     Linus

