Return-Path: <linux-kernel+bounces-335076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF397E0B5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BA11F212C9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC53F13A260;
	Sun, 22 Sep 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa+3Tl4/"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131A1EB46
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726997183; cv=none; b=TzmY8mWudQqZ5ROu3AHNcJZVatFhHQb3XsXMDZ86jaKuXGOMQq5H9EBg9shAZRIM1XYm2ZdXIHpORsek5oz1b8rlpM7HM7n2E9GYq1WdDQcTOd4YrcpoTxp19p1hUo1P7JjbfeK2hnf+O20A6DbqB5GoM3js9IKNuIdjtKXfAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726997183; c=relaxed/simple;
	bh=v26B5rb0HebxXVZ1o6iq7edGSSdE/AhTSaSIaBxYmhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyNx4/dxZ6O5HIJUFC/9dZfxd9zax84t7D2euT2XHPvDR50yAlWK1dorTvRnsliI+LtW06ZYer2anxCX7lCLHgCEln0GRNCHOYbnaNDWJwLRr3LDaBL+VDZRnBiigyIJphflp7TUE7YoxCe6i+qZ/qvgDHhC3/jAvrHP03MUzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa+3Tl4/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso4210706a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 02:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726997180; x=1727601980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v26B5rb0HebxXVZ1o6iq7edGSSdE/AhTSaSIaBxYmhw=;
        b=Xa+3Tl4/U/ELqb5UrFq9Rd2u8zxJvHvowx6pq9DdwRKIA3GLcxrPJ+t3XDPAeuTsE7
         PH5JYoD9Tiu1y5H5qvL2+M4gLjd02g1PPY0ju//x49oxzpu34vSEs7bbhqJ7fGwM1kQf
         XioHKWHN1/aWq4hhJIRcNxpMTQJV+BuAAF5EP8eIy+kMlEyjLHVVvg6Kiw0K2Ywao1Zr
         cxT9AJT3qubNuAqFIY1SRysypKBtQRL2nFIDzfETCkoI6UdKSJQbQtOuPbCfjXYPqtiF
         Ls2ReIQkd0eNVvVLy0aNTzV91AYclUdkAg3JHcsaIH5M8fDQRpHyUNeZU4+lOejRX26T
         tA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726997180; x=1727601980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v26B5rb0HebxXVZ1o6iq7edGSSdE/AhTSaSIaBxYmhw=;
        b=GQGpYXc4tgjRFfdYFY/3FrNH0Z4B41bcf3D9g90Z6a5pkLccz2Klits2Szil7JwRs3
         kM8QBqHjrpAIc91K8muwljYxZuorJ9vkj5KipR8IMR4E3TWML8JQWankScuwSyDj3JTW
         FMKlVcDIci4zZSBprh25XGTf29KsVg9U5RriiqM/Qz6A0D4qU9mRSqYKdEfijYoKzrAT
         xPyQWc6Q16CADvvO7r1b7CZ7XBYUx2+TCMqMYN8rNDzSqbs5/9TIHvRh2txRrmbXOxhw
         d1tZLKU/Uheq7JFTjMiVTtwT2nXYjgOc7BEkCN9SYYU+ULEwy6JCJ0HVzf7KkMyzTr4R
         6baA==
X-Forwarded-Encrypted: i=1; AJvYcCUmeTmDqOx1oPCXv9dKax70PBZjDNlXqPyL6Yf7JDexfkpnLJqZnLPkLSs4ZW5fpULTYZFYiEBqlYENX3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN05YND6CgWQLkBgZIN6SuBt/7Kj+eal3OqXc3BkTWH7QRNQVp
	3tpPmrxcezH9VW0nekqWrgUC4tV+1P7mYVFtBobcw/N4bx4I2UIZrsrkGj9IHhGK3esQeZe0qUy
	2H52F+2U19sbpivf2CktF961aPRc=
X-Google-Smtp-Source: AGHT+IFpnZ0j5qe8qoIl4KNiJhsXbz758howSU6U8kdKpqsm6OzX/nclcj2AWWjGN+hxBzUALHmHh52w0qcxYzwJyWI=
X-Received: by 2002:a05:6402:520b:b0:5be:e01c:6b5f with SMTP id
 4fb4d7f45d1cf-5c464a7f4f4mr6878449a12.33.1726997179864; Sun, 22 Sep 2024
 02:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZeiVRiO76h+RR+uKkWNNGGNsVt_yRGGod+fmC8O519T+g@mail.gmail.com>
 <20240921071005.909660-1-snovitoll@gmail.com> <CA+fCnZfQT3j=GpomTZU3pa-OiQXMOGX1tOpGdmdpMWy4a7XVEw@mail.gmail.com>
In-Reply-To: <CA+fCnZfQT3j=GpomTZU3pa-OiQXMOGX1tOpGdmdpMWy4a7XVEw@mail.gmail.com>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Sun, 22 Sep 2024 14:26:54 +0500
Message-ID: <CACzwLxjZ33r2aCKromHP++2sLjWAQ9evF5kZQCx2poty=+N_3Q@mail.gmail.com>
Subject: Re: [PATCH v4] mm: x86: instrument __get/__put_kernel_nofault
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, 
	glider@google.com, hpa@zytor.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, 
	ryabinin.a.a@gmail.com, tglx@linutronix.de, vincenzo.frascino@arm.com, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 1:49=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> I tried running the tests with this patch applied, but unfortunately
> the added test fails on arm64, most likely due to missing annotations
> in arm64 asm code.

Thanks for testing it on arm64. I've checked other arch and found out
that only s390, x86 are using <linux/instrumented.h> header with
KASAN and friends in annotations. <linux/kasan-checks.h> is in arm64 and x8=
6.

While the current [PATCH v4] has x86 only instrumentations for
__get/put_kernel_nofault, I think, we can take as an example copy_from_user
solution here:

https://elixir.bootlin.com/linux/v6.11-rc7/source/include/linux/uaccess.h#L=
162-L164

, which should be a generic instrumentation of __get/put_kernel_nofault
for all arch. I can try to make a separate PATCH with this solution.

> We need to either mark the added test as x86-only via
> KASAN_TEST_NEEDS_CONFIG_ON or add annotations for arm64.
>
> With annotations for arm64, the test might still fail for other
> architectures, but I think that's fine: hopefully relevant people will
> add annotations in time. But I consider both x86 and arm64 important,
> so we should keep the tests working there.
>
> If you decide to add annotations for arm64, please also test both
> KASAN_SW_TAGS and KASAN_HW_TAGS modes.

Please suggest if the solution above to make a generic instrumentation of
__get/put_kernel_nofault is suitable.

Otherwise, for this patch as you've suggested, we can add
KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_X86);
to make sure that kunit test is for x86 only and I can add arm64 kasan-chec=
ks
with SW, HW tags in separate "mm, arm64" PATCH.

