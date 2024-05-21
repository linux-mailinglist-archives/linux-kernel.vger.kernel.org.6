Return-Path: <linux-kernel+bounces-185331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1538CB393
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07CC1F217A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D53149003;
	Tue, 21 May 2024 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O9zGi601"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3092414882B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316607; cv=none; b=LIYub0/BPRoxRIK4v/JeShuuyqnUP6eVWs+S9S/LctNMpST3XqMY6FSsJ6vUwov5RwE+68GwwJ6unRtBKVgmAxfIAJSDdmNKjqnrd98s9ppCI9lGriXe33z5E12FFHBff72oG229niLFVMkAGFxc/8/G+8TB8iCordyKTk880Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316607; c=relaxed/simple;
	bh=p9q2M+O7cnAZmwHeM1C7/2qwgRed7uafThFF3nvl9sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUNG7tTZyy1pEBqJVGgFQSpdFxEJVF5f231+n+O6ss9mTBoUjLju2Z0CBUkYY3DHlh1EPAYcZ6/sp9tEsNH2ejfgMqacvU6dyLsAMKbJ/JqQ0FwRneosi1nc1yTxLEp6KNT1Hud6qdN73Tngtf6q8JwRskAXZE5/8lZCgvHOnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O9zGi601; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59b58fe083so643796466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716316602; x=1716921402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLyU2aNbp4OgiW+TMwuCji93HtnrvdXX6qL+T9597uE=;
        b=O9zGi601uwcyAL0VSIOZXru2Qqf/QZl7aRoVYRafixr0CRBYQLQwTDbKkB1gtUr4UL
         i+wBiEwHEffX4lui6wPKT8CV+Scm/r7uiQ57pWTVxdbOmwM1uGOqcJPB4rpZHJyDCdHq
         yLB6khEuh0OE41x5792Sn6NgJHOkeuXW5WcMTL50Zp1ivG33ZNol1EYWC/UYbIPdZ13d
         WSSBYb2cqQ3H9iNIvH3eh3Igvra6B7JbbzW//ZZ7jX5fdtOsfO87/MuhUn6oWzEgeFuB
         upZeuhp0y0sP5lzKpNe+FLgy1AdnEc8CsH6OIXQvltiT4J3agxogOlRFSuk0ZfKvmacB
         GrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716316602; x=1716921402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLyU2aNbp4OgiW+TMwuCji93HtnrvdXX6qL+T9597uE=;
        b=MCA8qYkrWs34ADgM0W/GnFixpTdvLN9FHXl92s+fdq7QMMiAmuIuFNqoTN6ns7adJr
         vq2c0wNFq5lJmagXWzDHCcc4/a3twH5SNkuIR5fK7kvnZOTIjmf90UACqlhjwa4cc/pc
         qjsBOb5FvhStTPa1EyzD7IEmE5tfxwy1iBmDAdzJTHrkpwzf3ZjD6nnolv92+7BbtXxk
         nrMTAy0ZY+S6/QMZZJGWFSvTZv5yx4JhACdTBJzcqhTWJ8qsNiZSuyak9BTYAoczFc4s
         O9HeX6xKKa9V4ePAGuNLUBK/8+dxC2jNsILLX6qovgjmzFicyTK63SqziKa8/JqZYqwi
         wk0w==
X-Forwarded-Encrypted: i=1; AJvYcCX2AbPNIYvy+DTkxqNn4dYQQZ+ff2Ii6QBiHSQA1d4aT/Zebk8CRNW313i6ZJmTlqgCbIcoGWbbHjxlUkLnGjMlZTFjCSdQZK5sk9oE
X-Gm-Message-State: AOJu0YwjCIq8a4MhWH3P/y0MMx9DgB8+WLOgMPPFCkjP8dbUJKXwjL3R
	7aHcLUhom7g6wSz76K4lERsay8SN5U7yT071b9rngo3yfLzL1T0FAjx+nzDfu5O0yJDNbo30fSW
	acl1RZgb5xZ62KDO1j4V3olgWCIBV/o3i527c3w==
X-Google-Smtp-Source: AGHT+IH0TkrWekL947oxL52MJFhjwXzyz7BwC25c5dh4y5BPrRiD/+EoDq6AAoPxQg5Y2/xKIgyzXSkv/EJ86BIyTYc=
X-Received: by 2002:a17:906:97c8:b0:a5a:a2b6:ba8b with SMTP id
 a640c23a62f3a-a5aa2b6bf6fmr1215235666b.0.1716316602491; Tue, 21 May 2024
 11:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_9D721BDDF88C04DBB5151D57711D62524209@qq.com> <tencent_338DF690631BAE788C4CC858233E9FBAE006@qq.com>
In-Reply-To: <tencent_338DF690631BAE788C4CC858233E9FBAE006@qq.com>
From: Evan Green <evan@rivosinc.com>
Date: Tue, 21 May 2024 11:36:06 -0700
Message-ID: <CALs-HssGcNso6vTfbcsiWX1h_46jgDDRcEWcfZCTpxXYnubcng@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: riscv: hwprobe: Clarify misaligned keys are
 values not bitmasks
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Elliott Hughes <enh@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 9:00=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrot=
e:
>
> The original documentation says hwprobe keys are bitmasks, but actually,
> they are values. This patch clarifies this to avoid confusion.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Hm, we also have this problem in the code, since
hwprobe_key_is_bitmask() returns true for KEY_CPUPERF_0. This results
in wrong information being returned for queries using the WHICH_CPU
flag. If usermode asked for the set of CPUs that was specifically SLOW
or EMULATED, the returned cpuset would also include cpus that were
FAST. I believe all other queries are okay.

The one-liner fix is to just not return true for that key in
hwprobe_key_is_bitmask(). But that's technically user-visible: if some
software relied on the buggy behavior of FAST cpus being swept up in
the query for SLOW or EMULATED cpus, this change would expose that.
The grownups-eat-their-vegetables thing to do would be to define a new
key that returns this same value, but doesn't return true in
hwprobe_key_is_bitmask(). What do people think?

-Evan

> ---
>  Documentation/arch/riscv/hwprobe.rst | 31 ++++++++++++++++------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index 239be63f5089..4abfa3f9fe44 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -188,25 +188,30 @@ The following keys are defined:
>         manual starting from commit 95cf1f9 ("Add changes requested by Ve=
d
>         during signoff")
>
> -* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains perfor=
mance
> +* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A value that contains performa=
nce
>    information about the selected set of processors.
>
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misa=
ligned
> -    scalar accesses is unknown.
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_MASK`: The bitmask of the misalig=
ned
> +    access performance field in the value of key `RISCV_HWPROBE_KEY_CPUP=
ERF_0`.
>
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar acce=
sses are
> -    emulated via software, either in or below the kernel.  These accesse=
s are
> -    always extremely slow.
> +    The following values (not bitmasks) in this field are defined:
>
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses=
 are
> -    slower than equivalent byte accesses.  Misaligned accesses may be su=
pported
> -    directly in hardware, or trapped and emulated by software.
> +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of mi=
saligned
> +      scalar accesses is unknown.
>
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses=
 are
> -    faster than equivalent byte accesses.
> +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar ac=
cesses are
> +      emulated via software, either in or below the kernel.  These acces=
ses are
> +      always extremely slow.
>
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar a=
ccesses
> -    are not supported at all and will generate a misaligned address faul=
t.
> +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar access=
es are
> +      slower than equivalent byte accesses.  Misaligned accesses may be =
supported
> +      directly in hardware, or trapped and emulated by software.
> +
> +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar access=
es are
> +      faster than equivalent byte accesses.
> +
> +    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar=
 accesses
> +      are not supported at all and will generate a misaligned address fa=
ult.
>
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> --
> 2.43.0
>

