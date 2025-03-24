Return-Path: <linux-kernel+bounces-573141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40081A6D384
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 05:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE22D1890A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5384D189520;
	Mon, 24 Mar 2025 04:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W33V5CrR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69518B03
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742789888; cv=none; b=fAY28T5QBY0w7Zgrmv4NAUa/7XC0k4lQensyhkIQIKLdQA5ffSQyDP73ies1I/gP7sR+bWuKhnjx0M8DYh8NN5gSln/Nl9rWgLkmJL8+gxTOYEy+yEWX8cv6k4CsOfgQyBNmNvfS2VPnhywxF/l8mMIYGvGdQbBgAwj9LLy+5Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742789888; c=relaxed/simple;
	bh=SlHG+ZWGRxRgZh//vL3zEjL4LluOqHa9hF+qK4JIDt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTH9PbZYiuH9AB34g46bf6j9f6CqnHa93q9I/a/8id0lXEzXzhL32doQsH75+VuN9T9v2z3F2jQuscgfCHmn8v4vPYtGUpSJv8n0QnpjwO3rUmGR84RBdYo8NnQ72Sy+kIVwa8tOOHnAc297dUG4wcxEJPozyQaukGXeDNiFlbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W33V5CrR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742789885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tauycDhLSHK8+Z4SEw1ULV8RR4SX0dqi01Ofyz18GyY=;
	b=W33V5CrRCUMkC90h/r035j/Y5gcrgea7vWDbHvFsthUhoRfTCs3SbTXOzmH8juJJOKlbvv
	AnBui29AYJw6XCuNDfk753GHT2Hxw/+DbyzBId8VuRsF8AOs5T3TsyNa3zcu4sVQe37fC+
	zb83GkwlYjsFDDYqmsUPiuGREad1Zq4=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-2DWe0_D7OyeYwT9br8cLbQ-1; Mon, 24 Mar 2025 00:18:04 -0400
X-MC-Unique: 2DWe0_D7OyeYwT9br8cLbQ-1
X-Mimecast-MFC-AGG-ID: 2DWe0_D7OyeYwT9br8cLbQ_1742789883
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d585d76b79so34512215ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 21:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742789883; x=1743394683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tauycDhLSHK8+Z4SEw1ULV8RR4SX0dqi01Ofyz18GyY=;
        b=Fags/l/jMjS+vS4adACJMCo/S5N0akOuceTe2acbzgiUs/HD4AlyIueAXMXbDA1sSo
         qGWLf8T3ZJDK0oi5HnhPgt5kp5S0ZXAy2a1zAEKKetYXJ+ZCTq73/RpsHeu/TvlPgj2I
         CJSGW4zbsXPKYRCWBOvz1xg5QtReIMNyXhATBor890GCWXXSMFCu7/YtnO2qPiSj8gbo
         l6ANUr64CRGK2DWK+i5C2QuWtRql9e3QGKsKswKvg0HfN6rnSK42/zzHy/gfu4t4Xs+T
         SSSNTlNUqdDLPs9uPhqIN3y+Gox/c5L/JhhmZfswDqEteRRMRm9yljE4lFet72hYdH6n
         fXtg==
X-Gm-Message-State: AOJu0YwtnksQ8wiEKaeqVgjrV/sD/eHTjSBLGzC/fr6oyMhJzZ0ZSz+n
	6hMMlvT6sC9zXXy7HZN8h87X4+0Y64VBrgJST+6mw9V6Gk24+gXVxJUMBSLkJuTir0vHYwx0rrB
	o2VCNLq9vtc0NTi+xOVOVVvn1mN0gOW2x3uxe/uguJHQr5d82CXUBof1kclrT4MBl9dW8DZH6n1
	HejvN/bKOwFvBD8n6kpd/uDawBVgyUUusT5hAh
X-Gm-Gg: ASbGncsVfS6J1mFQaLIfy6ADfwlxAAqSCmENKmdkqCW34I534pG3Uw1CklKYkXsBy0C
	r6Xh+it/sVh1R7FebvfPc4gF1Z7+twRlw6NveSymcQw/WwkvIdXbcoEU+tFAw4TZFqPUX8RoVpg
	==
X-Received: by 2002:a05:6e02:3e03:b0:3d4:3cd7:d29c with SMTP id e9e14a558f8ab-3d5961087a4mr114773135ab.11.1742789883486;
        Sun, 23 Mar 2025 21:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKTYUkEhLDCfmTqCzwmW7lTzNOrlm9PhUUN5r+ilaum3pQSmAXsd7VnN9OVuQyn+lnI6uMUA4yOPPaWTzR6xc=
X-Received: by 2002:a05:6e02:3e03:b0:3d4:3cd7:d29c with SMTP id
 e9e14a558f8ab-3d5961087a4mr114772865ab.11.1742789883003; Sun, 23 Mar 2025
 21:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com> <20250320015551.2157511-12-changyuanl@google.com>
In-Reply-To: <20250320015551.2157511-12-changyuanl@google.com>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 24 Mar 2025 12:18:24 +0800
X-Gm-Features: AQ5f1Jo8cgDtoQHR7bje9Ajd-fT5hflpJGHeRbJSkzX-LSsy1GnvBgRPYu2INeE
Message-ID: <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Changyuan Lyu <changyuanl@google.com>
Cc: linux-kernel@vger.kernel.org, graf@amazon.com, akpm@linux-foundation.org, 
	luto@kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 23:05, Changyuan Lyu <changyuanl@google.com> wrote:
>
> From: Alexander Graf <graf@amazon.com>
>
> We have all generic code in place now to support Kexec with KHO. This
> patch adds a config option that depends on architecture support to
> enable KHO support.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> ---
>  kernel/Kconfig.kexec | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 4d111f871951..57db99e758a8 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -95,6 +95,21 @@ config KEXEC_JUMP
>           Jump between original kernel and kexeced kernel and invoke
>           code in physical address mode via KEXEC
>
> +config KEXEC_HANDOVER
> +       bool "kexec handover"
> +       depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
> +       select MEMBLOCK_KHO_SCRATCH
> +       select KEXEC_FILE
> +       select DEBUG_FS
> +       select LIBFDT
> +       select CMA
> +       select XXHASH
> +       help
> +         Allow kexec to hand over state across kernels by generating and
> +         passing additional metadata to the target kernel. This is useful
> +         to keep data or state alive across the kexec. For this to work,
> +         both source and target kernels need to have this option enabled.
> +

Have you tested kdump?  In my mind there are two issues,  one is with
CMA enabled, it could cause kdump crashkernel memory reservation
failures more often due to the fragmented low memory.  Secondly,  in
kdump kernel dump the crazy scratch memory in vmcore is not very
meaningful.  Otherwise I suspect this is not tested under kdump.  If
so please disable this option for kdump.

>  config CRASH_DUMP
>         bool "kernel crash dumps"
>         default ARCH_DEFAULT_CRASH_DUMP
> --
> 2.48.1.711.g2feabab25a-goog
>
>


