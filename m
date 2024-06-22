Return-Path: <linux-kernel+bounces-225518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804829131B0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 04:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01681C21B84
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14B579FE;
	Sat, 22 Jun 2024 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUH/PuCo"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835D7A5F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719024606; cv=none; b=KUZHO8Vs5vIHep2pGfVMFWd9EsZt1CkLgFjyDhKNQfOn8kMqkMhLA/xstPsSJJTSnu4IfCFGsK30lcusVna2yD6u4pfjTt+mH2k97ThmYebmVZ/+llUxjLOh+fbskcG1HyZgb1yG+hNnwl6ZtaUzqEXz4o8kl7KTQteaxP8AjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719024606; c=relaxed/simple;
	bh=MxOTiAGZjwuFbedhzSvB3ixFs1u3Vzg33PRF5PSvKjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jykhoyoyTORgJHxC6QU0wCC4zCC0V85YYrUvbw6meQcaEt5CSCwah3wXJYClEYS4ZaYB0HL8oHY/mRAeMoP34OKMiH5pnU1IJlJPWJNEBiTz8sZOnydR6f2zcDXmhiOc3Y4Cm6jyBVsfQuW96o4g4eEg9fCHh7gFFgaDKqG7ZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUH/PuCo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so2583141a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719024603; x=1719629403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pRzIAtXesY3Se8kcF/OROsXtbtTY54OQJkhiu98SfE=;
        b=FUH/PuCoQ45AUfZQkvGvhXbXuo7lLUKRn7nM9H/I6J5i0FcUdfPrVI3zFLFMAbE4Tq
         IPlnQkCR+gMvo0PevABWJh8ME9MAwaePzqWix5OPAYX2pLtgb6LWvq5XkCXYwRxlcUp9
         lpbqjIyvQuPdbGkrbG+Mc9eJgRKyN5exOJwt8+15kotbyXwoghrPkHC9VtVpyLk6lrbA
         SoY8eWNTXVkXMOXbaSltQ3Avn3WEkR2JRGZJ8SkJt65PZRMuuQi8H1Plq1a2t5XfUnHj
         9Nm8BCM5CL8ytivHobNZYAyYwJ2+fJmhg0RyiU4XoFAwu/Qk7Ww0xBlPgnRRI6YKywq5
         kPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719024603; x=1719629403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pRzIAtXesY3Se8kcF/OROsXtbtTY54OQJkhiu98SfE=;
        b=o//3Zi/+mJZewPaK2+XTOFECVDt1pc55eEX6sT+AGUFXMMv3MQuuA1NqlS6c8c3Hb9
         7hG/d4m0eN+BrpFnej1kR/rLuL7AmdZNwaEr33V4Zm8lW+IfgCtJn1CagowUMGBNiRXx
         s2qnOkMvdKGHJfPw1i1zMVrzYOupz1RIpo2s8MncF3X+sBHFcvS4r+Eqq741QfJs52/p
         me8JQvVykUQofBIhBFPPve2WKnTM9VgBQCCHIK1yHPihjiN3aUVtEZSeTBIiUxwTvauT
         ys+a5/baNZBGNyAxMbEnxwjRzduQlBFQhCR7TapwQUNjhzGS87UYnNvqBjCLsPqFMo9F
         vCaw==
X-Forwarded-Encrypted: i=1; AJvYcCW8+I0iCOhutBbP9fYqpJ5U+Ka3kEj9+pdlweAnVZT7bXymiAPkEzLYumAhkYh14bQTFB+/lR8FCogUqMqnV0n7EGHP1X1DjXiE96VZ
X-Gm-Message-State: AOJu0YwCitBlIyYQi1dGWaWOB/eEMrrUjS528uT0J5q3YjiyxNOyvvhF
	A8jNFUpH7fRA8pb6h6Q7C0XTTQoA3adFcTMwFTYhcbOUSulkPM8iZinPi8u67Cb36L4JKb1XtSj
	/wXpCNbWSaxzem7zyW27EEmZ2gn0=
X-Google-Smtp-Source: AGHT+IEUeAxjghJEFotw4ajRoivTMhkPmu4wnZshebL61xJv2U5EpFvkNBQExKTrQ7GjYfL6B2yKvEpht6zpxzydX5Y=
X-Received: by 2002:a17:907:a684:b0:a6f:b284:4279 with SMTP id
 a640c23a62f3a-a6fb28442b4mr570501766b.36.1719024602231; Fri, 21 Jun 2024
 19:50:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620020625.3851354-1-chenhuacai@loongson.cn> <87msnem3i1.ffs@tglx>
In-Reply-To: <87msnem3i1.ffs@tglx>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sat, 22 Jun 2024 10:49:50 +0800
Message-ID: <CAAhV-H5TNnf+EMEtKmXk+Q9KXSZpW+9vd-7qqXDifsKfny+v=g@mail.gmail.com>
Subject: Re: [PATCH V2] irqchip/loongson-eiointc: Use early_cpu_to_node()
 instead of cpu_to_node()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Sat, Jun 22, 2024 at 4:42=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Jun 20 2024 at 10:06, Huacai Chen wrote:
> > When we use "nr_cpus=3Dn" to hard limit the CPU number, cpu_to_node() i=
s
> > not usable because it can only applied on "possible" CPUs. On the other
> > hand, early_cpu_to_node() can be always used instead.
cpu_to_node() depends on per-cpu area, and per-cpu area is only usable
for "possible" CPUs.

>
> We use nothing...
>
> Aside of that you fail to explain what the problem is (i.e. the
> malfunction) and why using early_cpu_to_node() is fixing it.
>
> >  #define pr_fmt(fmt) "eiointc: " fmt
> >
> > +#include <asm/numa.h>
>
> asm includes come after the linux includes.
>
> >  #include <linux/cpuhotplug.h>
OK, will modify in the next version.

Huacai

>
> Thanks,
>
>         tglx

