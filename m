Return-Path: <linux-kernel+bounces-570546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D57A6B1DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704C71897188
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0D421C9E7;
	Thu, 20 Mar 2025 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FEj738y/"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BDE1DEFE4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514836; cv=none; b=RY4YX1b7qmllDlO418X0Wnve+mzMghnJBphhVgguGpv/9W0WTm1nh8EhtSMWYj3zHalmaA6+R0Lx551jjz+pM41Lnon+MGye75aOSOP2rWWE8VV2V6riSaHaZYzzQfM+CAdjo0kIlzHUtU9Wzh71HOPfHyeRIqBy73mHzOHGX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514836; c=relaxed/simple;
	bh=usTbWtQbitsIU0oL5HuAKCKt+cnWQYochpwag445Mko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqMPsEEo900aEX83rGKloBAfIWtIDK0tA8lXSGsLSiRcuTT8NtGfjUaJTIEjMjKCJewSnv1ARwTJJrB0wbpak1HaEg6o4gP56OipMB3Ads9fBlTY61m3PgBQCevb36jd8MUYm613xiUEhhh55VMCKyh/MaN885vbxIMvE8OZyTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FEj738y/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac3b12e8518so304047666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742514830; x=1743119630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g79Us2tPjcPhaprEoYB0FA0GTnwbp8RzZTv7et0Rz44=;
        b=FEj738y/QYyKeN8UMOFadNQHUfwxPNxRJJIAwMeYYAEsu++xZEl18nxXsSXoTW/1tU
         QCXknmdO5A8hp53jstWlT5/TLAp4bFYXc+XWUaETqeY0CnxtYPopd1lFiZA5+ruELcXG
         cpXP6GEuYYXwigyq7oQOIc//aOaikY8N2rKQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742514830; x=1743119630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g79Us2tPjcPhaprEoYB0FA0GTnwbp8RzZTv7et0Rz44=;
        b=DJgJ+hqGsoBkyRAYRBtzg1sEhf5CnPQrn9g2mhM2PWK6fH4Or15zFD39L97Vmx52yH
         xaKIcewZ3CMKdzQwpngkCSh1/Ld7MFzVN/AbIvLKeF9j9TN3SqZElHqbIT9qGLPXIqDW
         YXT0IqlB9lU6UveoNg1PMnOyH83DMDnQ8KMteU4pfD4lsgrBObTq37TIxRnLEuytsPhl
         yO2d9MJucmotk/CKda9AcBm8JuUsKQxVkZExOkw+hXFjEHOXmw/J+RwRTxqo6+GMhlLq
         c5dGMO1Dt1mXUGhZGIC+n+lgDmL/+PP85LS0n00j2EwhnslWQltsSjlJXxSJphxsKF32
         2Yow==
X-Forwarded-Encrypted: i=1; AJvYcCVYsZSjcBLPAHz/j5gmjJTGLdV1rWdGl+FnefJmei+EbTdj/hUKVCJ8HYH2GTxGDrO2BK4W30djqRRjtCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzArz1RwQC4fGgFIlKpQbglSQ24S4n/jMFUfIv58MprSYmhuNtw
	XHw4dWaBG9RChi+x55HbAbF5CqHujYJPy8SjJSA6IhSCpMiwUYMUL6I1jQg3KlEAnt+qdR4S8Vc
	v35M=
X-Gm-Gg: ASbGnctTr/+8E0RM8d6uaHlTh8x7bXLeFQcPhEVpWaEHPSWi3lBGl8iKaEG2on+Ba82
	itpuhotMGMrKEd7mKl9hsYCUd7SZqB0lAKqfZSBjFTlfYqodb4Pnp5ej6Oh3z1evOsKqAISxTOy
	Y3Ij6ArgKouL/ha+hGb8+Eb1JxqWEBX5b4gXK63NxCy3E+LXJQtR4LvJIRxTzr1WNqNLPDuB+5K
	DYhP6p0XCRr09Hfv7bgtmclvaqrZLBmw9dcRgGGG/t9aIQ1EO01xGQdI9xD3NMX5tNbS/rWEbK0
	PvU1nwDDj4XMaciK9myH6Pr6+Lcz/7r76NiKGDZNP4E/+An9WY6pfpI/tk7vMOnd+x283s0hYwY
	q2ZtjyS/A17D3My10y7w=
X-Google-Smtp-Source: AGHT+IF7zv9WuKpi6bFDSF4lPUDUCiSArfa1PvaXdpTFpO8+nH6CJPaV+b4gqrlkjHYuwjSw1UKWmw==
X-Received: by 2002:a17:907:97cd:b0:ac3:115f:453a with SMTP id a640c23a62f3a-ac3f24d6ecfmr103238866b.36.1742514830341;
        Thu, 20 Mar 2025 16:53:50 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbe0356sm48738766b.144.2025.03.20.16.53.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 16:53:49 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbd96bef64so248233366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:53:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUB3AK/f6yyHP48LKWFsjsw22JfpTUxmke4wY2i0eH74sr12p8ysHXZRQb72l0uxOyQB3Nvms0uvZ85oHU=@vger.kernel.org
X-Received: by 2002:a17:907:cd04:b0:ac1:e1a7:9445 with SMTP id
 a640c23a62f3a-ac3f207f876mr125724166b.12.1742514828618; Thu, 20 Mar 2025
 16:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320190514.1961144-1-mjguzik@gmail.com> <CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
 <CAGudoHGNFT+LC24842ZKLWBxD3vvvddBqDKa6gkixN4Esor+RQ@mail.gmail.com> <CAHk-=wjo__Bj3JNw_7E8HhTDUF65LVOApvN0D2cofgotJoqpmg@mail.gmail.com>
In-Reply-To: <CAHk-=wjo__Bj3JNw_7E8HhTDUF65LVOApvN0D2cofgotJoqpmg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Mar 2025 16:53:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxi0poUzCd666Kx5wCjgOwN5v=-zG8xSAL7Wj_ax8Zvw@mail.gmail.com>
X-Gm-Features: AQ5f1JoePSVOT0jErXKStFEyChXAAm9D2FB-Z_lkXw-9SZ499nddPwTOXLFdnKA
Message-ID: <CAHk-=wjxi0poUzCd666Kx5wCjgOwN5v=-zG8xSAL7Wj_ax8Zvw@mail.gmail.com>
Subject: Re: [PATCH] x86: handle the tail in rep_movs_alternative() with an
 overlapping store
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: x86@kernel.org, hkrzesin@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, olichtne@redhat.com, 
	atomasov@redhat.com, aokuliar@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 14:17, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 20 Mar 2025 at 12:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I have a recollection that handling the tail after rep movsq with an
> > overlapping store was suffering a penalty big enough to warrant a
> > "normal" copy instead, avoiding the just written to area.
>
> Ahh. Good point. The rep movsq might indeed end up having odd effects
> with subsequent aliasing memory operations.
>
> Consider myself convinced.

Actually, I think there's a solution for this.

Do not do the last 0-7 bytes as a word that overlaps with the tail of
the 'rep movs'

Do the last 8-15 bytes *non-overlapping* (well, they overlap each
other, but not the 'rep movs')

Something UNTESTED like the appended, in other words. The large case
then ends up without any conditionals, looking something like this:

        mov    %rcx,%rax
        shr    $0x3,%rcx
        dec    %rcx
        and    $0x7,%eax
        rep movsq %ds:(%rsi),%es:(%rdi)
        mov    (%rsi),%rcx
        mov    %rcx,(%rdi)
        mov    (%rsi,%rax,1),%rcx
        mov    %rcx,(%rdi,%rax,1)
        xor    %ecx,%ecx
        ret

with some added complexity - but not a lot - in the exception fixup cases.

This is once again intentionally whitespace-damaged, because I don't
want people applying this mindlessly. Somebody needs to double-check
my logic, and verify that this also avoids the cost from the aliasing
with the rep movs.

                   Linus

---
  --- a/arch/x86/lib/copy_user_64.S
  +++ b/arch/x86/lib/copy_user_64.S
  @@ -76,16 +76,38 @@ SYM_FUNC_START(rep_movs_alternative)
   .Llarge_movsq:
        movq %rcx,%rax
        shrq $3,%rcx
  +     decq %rcx
        andl $7,%eax
  +
  +     /* 8*%rcx + 8 + %rax bytes: do the 8*%rcx */
   0:   rep movsq
  -     movl %eax,%ecx
  -     testl %ecx,%ecx
  -     jne .Lcopy_user_tail
  +
  +     /* We now have 8 + %rax bytes left */
  +1:   movq (%rsi),%rcx
  +2:   movq %rcx,(%rdi)
  +
  +     /* %rax bytes left - do it as one overlapping word */
  +3:   movq (%rsi,%rax),%rcx
  +4:   movq %rcx,(%rdi,%rax)
  +
  +     xorl %ecx,%ecx
        RET

  -1:   leaq (%rax,%rcx,8),%rcx
  +10:  leaq 8(%rax,%rcx,8),%rcx
        jmp .Lcopy_user_tail

  -     _ASM_EXTABLE_UA( 0b, 1b)
  +11:  leaq 8(%rax),%rcx
  +     jmp .Lcopy_user_tail
  +
  +12:  addq $8,%rsi
  +     addq $8,%rdi
  +     movl %eax,%ecx
  +     jmp .Lcopy_user_tail
  +
  +     _ASM_EXTABLE_UA( 0b, 10b)
  +     _ASM_EXTABLE_UA( 1b, 11b)
  +     _ASM_EXTABLE_UA( 2b, 11b)
  +     _ASM_EXTABLE_UA( 3b, 12b)
  +     _ASM_EXTABLE_UA( 4b, 12b)
   SYM_FUNC_END(rep_movs_alternative)
   EXPORT_SYMBOL(rep_movs_alternative)

