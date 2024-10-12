Return-Path: <linux-kernel+bounces-362641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024E899B78A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 00:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273401F21811
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DD914F102;
	Sat, 12 Oct 2024 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiMRXG3b"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981CE17BB6
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728773378; cv=none; b=cyWmLsUBLOpk6nmDdUwC+gg0RgIp1j4KS7OgMGw+Kj1QDyVtmEwuMrY581+Fnkk6rbgbPCUlq4EaYJVtxNggn7j3sPgYDapdiDpOg+p8ak2fD7jRsFHfkhvD5vhiGjtmmagDwB6ydwSKc+V0ZsPUsjpkUXvfWCVU4be4SQEnsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728773378; c=relaxed/simple;
	bh=DXGcarXrgC1bafRzX15SVhzMM2C64vgI0R8ZyYyWTpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UExzzwbjdAjNoLHn8bPlgrNhl/WOhvG7MbUllpFnPM+SNrERREwN4iPvcxD0Bkci7qbQOCwXi+FErlEpXz7wh2ehFL7DrwI31E0fmdQc9nBLzCn+r0ZnbpuEJBBq3YWU2jtmFIcu0Wr5GlKn/lC6CoVru0OvqB5m2HcsXuCD7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiMRXG3b; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43128a40d29so5836215e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728773375; x=1729378175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=567XFgs0KNnQIhu74l9eLsWryemY/O3KSe7EFbZlnGk=;
        b=CiMRXG3bUAmsmFw3asTG9HCPaRSKXI2VgQ08uuPwukt8FdBW0CtKlHBhcuA57prEwY
         oZRaxjs1fLZicw6QXqGfNN3HyIj+h1HQPdHw7vPcrXYZYGgUVyfklSqF+LqvK3OZzXWz
         kl0zrK3CXXnP6VrfkFtHxXmS0vyYaKWP6uCqJuUU42Vb+FuoSCF8WAJtOn3W2EUgq+1n
         iQfeM1Qwp27SC1w5EDXoEyGVfF+b0gM64EDK6CRaOqfX6SZTjvPgwK76VqjJQayByIkv
         i3XuUlgfwf6bnVQd0hkjLmE+0C1v0PO/LvjIkWWwSWQ/5l+BBPfW3eih/jQOg/QI8UWK
         gRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728773375; x=1729378175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=567XFgs0KNnQIhu74l9eLsWryemY/O3KSe7EFbZlnGk=;
        b=HTzuhMwvvRNqL+BtplBCLwkKaNpBDreYjhHKNBZKdwAYZ4f5L5R1QI9yuGvt8Z3zcr
         Jt62F0ns+HMT0lMvy8fItSY5TCzHhv4MPPenZ4gRvvZEAHAahyPwhIv8qv8ulRuPpS15
         lrJxSTNG91eKgeocphfQhUH8yIXhu36wDEZ/WNEXqs57zJRWWRFK4cRxBtiMlMA4/mt+
         ZEhRBZLnEn6/qi+vVgoyid7+pfo82gED9j2db8e6++0bE8pyZyJO+z706ZokPTtLLrTR
         nGFfPOrRNoUgxu/e3K843Rx7CLRctoX86Kub6u8yVBe+B40SkDzB+usewLBRgNf10JNs
         KwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQKWV0LlRfUwVxjFegnBlOVPjzBZErnwrpaeATMPNCPAEt03BpTHj3PcVq7JKp379vR2LJki+9l2TuyR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6h55JCmYtXFhldV8MeSozXKhgssLzKAqTt1l/16EQHAP0CL+
	cyxNyMj+IsCIpiJD+R8N9U+IZ9OT5iIeYdhXcJW9z0L7SglQyMCHhm73GC/c9Vn7KE/nmsa3AD5
	WY8agAvO5T7Y/W22fWTBLhufDTbQ=
X-Google-Smtp-Source: AGHT+IHJiYaUJFgodiJ6bhdg9ou2IfF+ctYiqTy1xDgG7yuU8hdoc78hIbs7z3LNH5XU+extj33kRKCWTDyTJ5fMl04=
X-Received: by 2002:a5d:6645:0:b0:37d:4e03:ff86 with SMTP id
 ffacd0b85a97d-37d55313314mr4715694f8f.49.1728773374667; Sat, 12 Oct 2024
 15:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011071657.3032690-1-snovitoll@gmail.com> <CACzwLxj21h7nCcS2-KA_q7ybe+5pxH0uCDwu64q_9pPsydneWQ@mail.gmail.com>
In-Reply-To: <CACzwLxj21h7nCcS2-KA_q7ybe+5pxH0uCDwu64q_9pPsydneWQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 13 Oct 2024 00:49:23 +0200
Message-ID: <CA+fCnZdasETx78HOLViEQHDZV1JS7ibzTbmfPzCb--3uN+tLiQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: migrate copy_user_test to kunit
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: akpm@linux-foundation.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:12=E2=80=AFAM Sabyrzhan Tasbolatov
<snovitoll@gmail.com> wrote:
>
> This has been tested on:
> - x86_64 with CONFIG_KASAN_GENERIC
> - arm64 with CONFIG_KASAN_SW_TAGS
> - arm64 with CONFIG_KASAN_HW_TAGS
>
> - arm64 SW_TAGS has 1 failing test which is in the mainline,
> will try to address it in different patch, not related to changes in this=
 PR:
> [    9.480716]     # vmalloc_percpu: EXPECTATION FAILED at
> mm/kasan/kasan_test_c.c:1830
> [    9.480716]     Expected (u8)(__u8)((u64)(c_ptr) >> 56) < (u8)0xFF, bu=
t
> [    9.480716]         (u8)(__u8)((u64)(c_ptr) >> 56) =3D=3D 255 (0xff)
> [    9.480716]         (u8)0xFF =3D=3D 255 (0xff)
> [    9.481936]     # vmalloc_percpu: EXPECTATION FAILED at
> mm/kasan/kasan_test_c.c:1830
> [    9.481936]     Expected (u8)(__u8)((u64)(c_ptr) >> 56) < (u8)0xFF, bu=
t
> [    9.481936]         (u8)(__u8)((u64)(c_ptr) >> 56) =3D=3D 255 (0xff)
> [    9.481936]         (u8)0xFF =3D=3D 255 (0xff)

Could you share the kernel config that you use to get this failure?
This test works for me with my config...

> Here is my full console log of arm64-sw.log:
> https://gist.githubusercontent.com/novitoll/7ab93edca1f7d71925735075e84fc=
2ec/raw/6ef05758bcc396cd2f5796a5bcb5e41a091224cf/arm64-sw.log
>
> - arm64 HW_TAGS has 1 failing test related to new changes
> and AFAIU, it's known issue related to HW_TAGS:
>
> [ 11.167324] # copy_user_test_oob: EXPECTATION FAILED at
> mm/kasan/kasan_test_c.c:1992
> [ 11.167324] KASAN failure expected in "unused =3D
> strncpy_from_user(kmem, usermem, size + 1)", but none occurred
>
> Here is the console log of arm64-hw.log:
> https://gist.github.com/novitoll/7ab93edca1f7d71925735075e84fc2ec#file-ar=
m64-hw-log-L11208

I don't remember seeing this issue before, did you manage to figure
out why this happens?

Thank you for working on this!

