Return-Path: <linux-kernel+bounces-274307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F4947657
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8559B280FF8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E9C149C6E;
	Mon,  5 Aug 2024 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJW926b6"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F621428E4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844331; cv=none; b=guTA2E3+Q9iKrz9DrY7xdNhSrXSErKb/8PShRGxf9IVBs2QUtebqxWYiGF4APw5I9OpOe9QYcgQL3REGzB4xBBNyoxVyFD0nD0KV9YRGwVmkAif4x6QB1gSEXBJ5r/YBKZyvxIPykHGy52nDGHQnaU/9QVPFl7z3c9irhu3iPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844331; c=relaxed/simple;
	bh=IXve6+F8Yq7AVXT7NfIkYMoHQ43AoL/EhFkEMA7/OYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nk6/lRZ57aBxuYkXqD6EbKFlJR6QNpW9paGHJMj7zNWFhN5Hj9BbRPOVPVG7CP6b883a09glo21kx/upL/7LOMF6rscgQJNl6Y589YnWF9ujFmca9RaepLxB3e4JwW3diQs08qIYDFINsKDLGwnvQTg2vUn0gEzFC1S8u2oQwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TJW926b6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so150441101fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722844328; x=1723449128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YA9Y9VMAPxbylebRC1XdIIi/H9qoWvJWVxmB4cwGQA=;
        b=TJW926b6WOJh+jj0Og4/Ra8S9Gs6CM77fYQoVy9Cr+M22n+/NUV2xBt/477iCXht6Y
         YK4hOTpQBoxL+LyN8HS2SHvbsPtWNs6v2sshG/UFhnteEYTRg54qKJ2xzfLfkhS6QBJP
         cbhyivpN6OsOpMPYDpKEMawxu6TJsvVMmzmd66eSlsHbV24ZS7vGgKPdNQAQfPyiKlVk
         5L61YgQht0yNlr4OM9mhrvvPXo2sQdFqnkvFsDff3OGIdwv7RL3IaxLVL9DRA1QGzcdm
         rD0DuVJ6Zl024GYc+SSP2bY+ptF9XndgYNo3xeRU6a7fRTXEuJfNbEGj49HKNsQva3tV
         fs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844328; x=1723449128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YA9Y9VMAPxbylebRC1XdIIi/H9qoWvJWVxmB4cwGQA=;
        b=r7OujaKs61aD4cvuJYDYr4rkXEuJBPOk151QyUItDqHn+Tk22szgdrb/487IcBxZmG
         n7pOZInBbygPDUYYtti3+Ht5ZX/JEQZCoe5aN00Z8fsoxrdjPIpKN1kqW8LOTXb1xP6v
         xxIDodvUz81UYhPw6xRzlaHzuBZ8Bn136c/QBcPFo3JedL9YnqdSvWvNVeFza7WxV+ra
         d0sRrxsuQ6uzdDH7JdN5U0N+2iqggGLHmDWxO6QyWPBBhiLfGVH0zTh2O2XDYueUfDu6
         oo2Nq8/FaHReXfJx+iZ25K5k6b+tWUZBUhIjf8egoYQpImfVoQ4UCDYCqyYVK4TbFnsA
         OEzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZlhmhStWZ9nJO5p61+5pYSwSGZSNUg/Fx3pjkOpN108g3TjG43/uUR/xQavpjarHBv8T61v+YmDQsc6v60Mbxdz3TqI56sPebO7iS
X-Gm-Message-State: AOJu0YzMwnZYjomHfbSVO6jgu2yvLyN1smoY6WngZXf9dAAxWqIqEmM2
	nSx/vTaM9xsFc720ltR1Z3uT91XnoILGZPt55zI5HLs8rElS9Pfa2RI3pV7NOYJNgrpaKClgdwL
	TkM4vGllPcz/yX2bJ9IfvhvYn/3DvMUo0AeNkdw==
X-Google-Smtp-Source: AGHT+IFjTMi5LTeJhpKw69H6ErUCnOJMAzJqM2E7B1tEBffKUkVO1xM1ianZH9WzkF88CksIdFWX3NbjhNpLgGIAIQM=
X-Received: by 2002:a2e:a1c7:0:b0:2ec:56d1:f28 with SMTP id
 38308e7fff4ca-2f15aac3954mr70149661fa.26.1722844327469; Mon, 05 Aug 2024
 00:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718035444.2977105-1-ruanjinjie@huawei.com> <20240718035444.2977105-4-ruanjinjie@huawei.com>
In-Reply-To: <20240718035444.2977105-4-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 09:51:56 +0200
Message-ID: <CACRpkdaJLBt8-c_f4Q3_nLdB_7hZE9Pv5LiX0ObiycXZcj9j0g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: Use generic interface to simplify crashkernel reservation
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, bhe@redhat.com, vgoyal@redhat.com, 
	dyoung@redhat.com, arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org, 
	eric.devolder@oracle.com, gregkh@linuxfoundation.org, javierm@redhat.com, 
	deller@gmx.de, robh@kernel.org, hbathini@linux.ibm.com, 
	thunder.leizhen@huawei.com, chenjiahao16@huawei.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 5:51=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Currently, x86, arm64, riscv and loongarch has been switched to generic
> crashkernel reservation, which is also ready for 32bit system.
> So with the help of function parse_crashkernel() and generic
> reserve_crashkernel_generic(), arm32 crashkernel reservation can also
> be simplified by steps:
>
> 1) Add a new header file <asm/crash_reserve.h>, and define CRASH_ALIGN,
>    CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX in it;
>
> 2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
>    reserve_crashkernel_generic();
>
> 3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
>    arch/arm/Kconfig.
>
> The old reserve_crashkernel() can be removed.
>
> Following test cases have been performed as expected on QEMU vexpress-a9
> (1GB system memory):
>
> 1) crashkernel=3D4G,high                          // invalid
> 2) crashkernel=3D1G,high                          // invalid
> 3) crashkernel=3D1G,high crashkernel=3D0M,low       // invalid
> 4) crashkernel=3D256M,high                        // invalid
> 5) crashkernel=3D256M,low                         // invalid
> 6) crashkernel=3D256M crashkernel=3D256M,high       // high is ignored, o=
k
> 7) crashkernel=3D256M crashkernel=3D256M,low        // low is ignored, ok
> 8) crashkernel=3D256M,high crashkernel=3D256M,low   // invalid
> 9) crashkernel=3D256M,high crashkernel=3D4G,low     // invalid
> 10) crashkernel=3D256M                            // ok
> 11) crashkernel=3D512M                            // ok
> 12) crashkernel=3D256M@0x88000000                 // ok
> 13) crashkernel=3D256M@0x78000000                 // ok
> 14) crashkernel=3D512M@0x78000000                 // ok
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Update the commit message.

I haven't used crash much but it looks right to my untrained eye.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

