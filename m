Return-Path: <linux-kernel+bounces-376944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B69AB7DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C11C22D11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAB1CC88A;
	Tue, 22 Oct 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpfnqRVA"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1EC12F588
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629955; cv=none; b=aiGTz4RVcBJYj6R7T9E1qo8T7IMvze4IGWYBw9R9drSreeYZ2Hk3i83MUMuvFam1KgvnCWPyYlcGMaDLX18T8RPh1ItUZVXZfkism+qXJ/fruIOCIYpP9AiwNbqx2bnVGwSrYRaDnT8ijMikOdzLg7JsJxGKZxG8nF1oI0iBBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629955; c=relaxed/simple;
	bh=ePP0KKG3AmqoivlK1Old/Drm0oSgiiqOXmhfPrCwRTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNSY/S7Un6lP/weAhtSkg7q4pU5PK23xRXFr9q2uOo994CTHGE/L9RLpr2EHbcYWWW0K3tZC4Tf0E9LBscB9kfovmfE5q4oIRV0yySpCatDnGulsXsU0IKNvAY9DyBJbxYgv1ceasdP5F21E8zvHXSpiSJcVDeXVZRxnPhRfX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpfnqRVA; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460b295b9eeso20481cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729629952; x=1730234752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7pdxsF3XjrG3sQC3UYjrYUD/z5vetyx8pXZ2oumqo0=;
        b=OpfnqRVAh+LsA/TalDKYLYJuK1ILZWxmm6SZ94oS7c47UoYOCPJsfzFFH2igvAohwc
         Pfqr62UVyrbK9MxG8s30e8W92X1SyZUA6/KxPrKj5xlSmRE4eKNn8xzd6dAW/SMRq1jy
         c6beJLAaBbfQPH4XT0rFU8mUlLKlb6K2nQlz1pqKI7KnWKHTBMTUYZhM17vLjX3FJU+5
         BavtjOrHDUEqJnmAhqfZI06z2oaUhEwmpeuYFsogHcsXxqmraKOoxe4BsZM0epcW+7q5
         a5kFvXGWi9Mq1CJnXO/F819Ls6w2Mu9Ir3nz68OppAD0lccwSxql96rOGdkkxWUG8NYN
         3KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729629952; x=1730234752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7pdxsF3XjrG3sQC3UYjrYUD/z5vetyx8pXZ2oumqo0=;
        b=sHr4GkdrPRG+/y1Bw1WRvWUys5HEq55YSVwXKdqS1gzwKZ3QirPrPkj4w0Ct+aa88V
         URqDRAllm6cOKa+PyuxXA6UYjGLGh8Tq9aG0lA4FPN+B7G8KwYtYcPEDrBj+MhQCglYS
         Ns7p0GPzGQFSnooN84wNMKZYmuOdB0B6T2bPxYxW5gTkU++ThvjSEAQ8Hh9RN/F7pV4n
         Q8FCtuQhjKysG2VoZOUrbx3XoWeMAQ+CzBuhU//qz5msOwluPuEKqk5zEAI0vjV0HI12
         P9w59qqMtCLJRGthWLOkLDj/iCdFTJW7YCJvO12UkGoCKY0YgViYriq6b2GGw7CO1y24
         0NQA==
X-Forwarded-Encrypted: i=1; AJvYcCUqxql8/ufw1zbQuAzleELEohJRfSlLZwF+y0X81VpS8XB4nSwNlSPf17URJSIi7XablN+Ks9aavqabQB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SG+oE0XO/uiGOaOnzhIsW2wgpvkGMNTS2ukRt2XIqyxvVywM
	8BNNQoxDY4OjDph4+LDMHyrKQPx8wHQWT5rf1RmhM67x73+prtWSg/YIMsbp5OElyAbYaKPPf+Z
	txGwn/ONQasq4Y87Bmlu8tm9mDjNWj9Ll357aPPY4+dNUZehuUrEccRE=
X-Google-Smtp-Source: AGHT+IG2tJpAMbmo2KfN4SiR/K0WDNMUziYfvYUHs03hKb+23lCo5klxeLBVIZb8UJTAAHrJVJYY1WsxyjaM8DrvBec=
X-Received: by 2002:ac8:60d0:0:b0:460:48c3:c352 with SMTP id
 d75a77b69052e-46113cc66c6mr816011cf.1.1729629952138; Tue, 22 Oct 2024
 13:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022004710.1888067-1-rananta@google.com> <20241022-2c60a0bcbb908435aa91d1ff@orel>
In-Reply-To: <20241022-2c60a0bcbb908435aa91d1ff@orel>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Tue, 22 Oct 2024 13:45:40 -0700
Message-ID: <CAJHc60wRgy2Hp6ZKAAmfH0sNFOFgvRXr_8-YuNf9+HV9-xwWDQ@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH 0/3] Fix arm64 clang errors on fpu tests
To: Andrew Jones <andrew.jones@linux.dev>
Cc: Subhasish Ghosh <subhasish.ghosh@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Oct 22, 2024 at 6:10=E2=80=AFAM Andrew Jones <andrew.jones@linux.de=
v> wrote:
>
> With clang 18.1.8 (Fedora 18.1.8-1.fc40) I get a bunch of errors like
> these
>
>     arm/fpu.c:281:3: error: instruction requires: fp-armv8
>
> I used my cross-clang series[1] and configured with
>
>     ./configure --arch=3Darm64 --cc=3Dclang --cflags=3D'--target=3Daarch6=
4' --cross-prefix=3Daarch64-linux-gnu-
>
> [1] https://lore.kernel.org/all/20240911091406.134240-7-andrew.jones@linu=
x.dev/
>
> Thanks,
> drew

I was able to reproduce the errors by pointing to a newer clang (20)
and applying your series.
I think we see the errors because llvm decided to disable loads and
stores on FP registers with "-mgeneral-regs-only" [1]. Explicitly
adding ".arch_extension fp" for the fp_reg_{read,write}() helped with
the build:

diff --git a/arm/fpu.c b/arm/fpu.c
index 6b0411d3..f44ed82a 100644
--- a/arm/fpu.c
+++ b/arm/fpu.c
@@ -38,7 +38,8 @@ static inline bool arch_collect_entropy(uint64_t *random)
 #define fpu_reg_read(val)                              \
 ({                                                     \
        uint64_t *__val =3D (val);                        \
-       asm volatile("stp q0, q1, [%0], #32\n\t"        \
+       asm volatile(".arch_extension fp\n"             \
+                    "stp q0, q1, [%0], #32\n\t"        \
                     "stp q2, q3, [%0], #32\n\t"        \
                     "stp q4, q5, [%0], #32\n\t"        \
                     "stp q6, q7, [%0], #32\n\t"        \
@@ -71,7 +72,8 @@ static inline bool arch_collect_entropy(uint64_t *random)
 #define fpu_reg_write(val)                             \
 do {                                                   \
        uint64_t *__val =3D (val);                        \
-       asm volatile("ldp q0, q1, [%0], #32\n\t"        \
+       asm volatile(".arch_extension fp\n"             \
+                    "ldp q0, q1, [%0], #32\n\t"        \
                     "ldp q2, q3, [%0], #32\n\t"        \
                     "ldp q4, q5, [%0], #32\n\t"        \
                     "ldp q6, q7, [%0], #32\n\t"        \

If you are fine with this, I can push it as a separate patch in v2.

Thank you.
Raghavendra

[1]: https://github.com/llvm/llvm-project/pull/77817

