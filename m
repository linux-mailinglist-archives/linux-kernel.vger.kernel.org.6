Return-Path: <linux-kernel+bounces-228766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D37916692
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3873B1F2429A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BCA154C12;
	Tue, 25 Jun 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QWIe5at1"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F4154C03
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315926; cv=none; b=EoPliFbHrJkkRMhdICcs5yzOx0suZHURIavTgaOVbksX7OWmLfGHhHgVKaI243XAvhWtYJg+KTYs8zLH68wwxTWdSt4lTME83kRJDHLnwuNRSGxFDWcT/uKT4HHihL4UkWdXQgObPzNZKNClS7LnarRmPJpKYOQ7No0AnRyvKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315926; c=relaxed/simple;
	bh=wu4prykytf2AM+/fQHl+GXpgJchAjyAXSdSuKMRSYNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiiIXGbQ1a8xik8eL6IGyVq6GqR0yNE477tVd1142hbIEsBv/dd9TA4aIybTwubLtdnY3m5V+NBUN8KhuhQk80TsH6pXBy1Ql1jUOZ9mBDwjcCKNSWiJSXsQgIxsXcV7coizxklipE2hA0vxNMOppI9xeYAS7hbNf9lJUKhvrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QWIe5at1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so5193560a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719315922; x=1719920722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMUhzznUZed7QosruqCaiTofY87z0Rh5ZDjCpva9+sA=;
        b=QWIe5at1o8RJK6o12ZQL8QWh5uGvNNWilbN+mHYodhQ0tFORZ4eZUkAGjkj5aQxSLW
         SNgkKtlVfO9Gwj0hCOeSS1JXD34daCopjRpjM5FpF3SfMWwK7rvqAv+YitRXqc99xbR0
         HWen3yWXn0/N/iNsftpRdAR84n/7emcALeaNu4cn+Z25i/nLFBWfKlwaqqlIy1/lAUf6
         YuV5f8wrbZhG8wSRh+oqxi8fQCupQSkqiUmB2W60nObFUejpCWlm4Njd69iQegCvzPga
         lFCpZSmfydofwgBo99BcJWOCpxnF1kxncJOzvvCYlVgOKfBpMS34h3CurmFGxbG+X6oV
         h5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719315922; x=1719920722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMUhzznUZed7QosruqCaiTofY87z0Rh5ZDjCpva9+sA=;
        b=RnbhjZJyt/fy75+Z6LGGk/nWmjLjgcMP3h8/izMqTgWJBW3rD6j6chlvjjl+WnobOf
         fHLghUjXiEzA8oiUViiwQu0pRb7dv/ksW7sFqQW83S5oaILkTtbyRqceVn1dA5r1Y7Ts
         P0TEossWJxOd68FQlcqrvwRgFGuVOL1V0UHfTmvHZOqmZTBn2u+hVGPdWm5O1gXj2dmH
         nr/TVasz40Zun9SX9IdttKt5SIoVy39CtX6cnoR/HB4u/f8pAZ0H4Ualyw4pB7WzhG6j
         rOSR48F3HD7iWMbnGwIYizaGNJdVomO18ilMlj/A2bw4Wnk7UMBtFh76IiR3r4eeCYEU
         PKzw==
X-Forwarded-Encrypted: i=1; AJvYcCVmGCvypTNOsXYcv0qpVf9wPDLCR6/lOEv4b1E+bUTgV/chGgQLIii1jVKcFHFcOi7QBj817gU2Ek6/XCdmnSqVzkYPb0OlMJlttcKd
X-Gm-Message-State: AOJu0YxqU5cAU6DOaphXmD2043NW1j26n8Wa0nVEojhreqjJhQ42YS3A
	peYe4TR0PBpvnrd6skHKU61mbqdVwG/g6HyKZVGg47hAs1wMvQzm3DBgjb2lOyHYBfUF9V6NmqU
	X5O0fXGBkjamGvBqaDc3pM9SuDwa+1OdalTz68g==
X-Google-Smtp-Source: AGHT+IH9oE5avAcWE1dPfuPWXIMdR/bUBTzCledqBKIgAA1sscmeeXwl9hobU0kHO9Oj+2sOIr59kjUvaPz1Cy6Hh38=
X-Received: by 2002:a17:907:c78e:b0:a6f:bc02:a008 with SMTP id
 a640c23a62f3a-a7242c4de49mr533457666b.4.1719315921872; Tue, 25 Jun 2024
 04:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_7721F6B72F58AA6154DFBDFF@qq.com>
In-Reply-To: <tencent_7721F6B72F58AA6154DFBDFF@qq.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 25 Jun 2024 13:45:10 +0200
Message-ID: <CAHVXubhkrDv3Fx1KH-jjjWjo-LGKBMabvafAPsDZeSpGMEt-gg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Only flush the mm icache when setting an exec pte
To: =?UTF-8?B?5qGC5YW1?= <guibing@nucleisys.com>
Cc: aou <aou@eecs.berkeley.edu>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, palmer <palmer@dabbelt.com>, 
	"paul.walmsley" <paul.walmsley@sifive.com>, =?UTF-8?B?5pa55Y2O5ZCv?= <hqfang@nucleisys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guibing,

You sent your email in html, so it got rejected by the ML, make sure
you reply in plain text mode :)

On Tue, Jun 25, 2024 at 10:45=E2=80=AFAM =E6=A1=82=E5=85=B5 <guibing@nuclei=
sys.com> wrote:
>
> Hi alex=EF=BC=8C
>
> We have encountered a problem related to this patch and would like to ask=
 for your advice, thank you in advance!
>
> Problem description:
> When we use the v6.9 kernel, there is an illegal instruction problem when=
 executing a statically linked application on an SD card, and this problem =
is not reproduced in v6.6/v6.1 kernel.
> SD card driver uses PIO mode, and the SD card interrupt is bound to core0=
. If the system schedule the apllication to execute on core1, core2, or cor=
e3, it will report an illegal instruction, and if scheduled to execute on c=
ore0, it will be executed successfully.

Is it a multithreaded application? You mean that if the application
always runs on core1/2/3, you get an illegal instruction, but that
does not happen when run on core0?

>
> We track the source code, flush_icache_pte function patch leads to this i=
ssue on our riscv hardware.
> If you merge this patch into the v6.1 kernel, the same problem can be rep=
roduced in v6.1 kernel.
> If using flush_icache_all() not flush_icache_mm in v6.9 kernel ; this iss=
ue can not be reproduced in v6.9 kernel.
>
> +void flush_icache_pte(struct mm_struct *mm, pte_t pte)
>  {
>  struct folio *folio =3D page_folio(pte_page(pte));
>
>  if (!test_bit(PG_dcache_clean, &folio->flags)) {
> -=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82flush_icache_all();
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82flush_icache_mm(mm, false);
>  set_bit(PG_dcache_clean, &folio->flags);
>  }
>  }

Did you check if the instruction in badaddr is different from the
expected instruction? The image you provided is not available here,
but it indicated 0xf486 which corresponds to "c.sdsp  ra, 104(sp)", is
that correct?

>
>
> Our riscv cpu IP supports multi-core L1 dcache synchronization, but does =
not support multi-core L1 icache synchronization. iCache synchronization re=
quires software maintenance.
> Does the RISCV architecture kernel in future have mandatory requirements =
for multi-core iCache hardware consistency?

No no, we try to introduce icache flushes whenever it is needed for such ua=
rch.

>
> Thank you for your reply!
>
>
> Link=EF=BC=9A[PATCH] riscv: Only flush the mm icache when setting an exec=
 pte - Alexandre Ghiti (kernel.org)
>
> ________________________________
> =E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84=E4=BC=81=E4=B8=9A=E5=BE=AE=E4=BF=A1
>
>

Thanks for the report,

Alex

