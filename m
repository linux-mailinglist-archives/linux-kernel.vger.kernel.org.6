Return-Path: <linux-kernel+bounces-296591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26495AC80
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BD71F21F36
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5021F3A28B;
	Thu, 22 Aug 2024 04:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gweVEftJ"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A925779
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300576; cv=none; b=MUfevIoRKrU/MtL4gnEJRr3i5gVVXq4M+MoZwWEpi8g7Si+sSFpyBeK5xf2XPz3yz0f2bxjW7uz4cHkeeu6VbuJfOUHSxsjGq31eeivd78zymJNlIHlOUoUbhQwS2zLan+Oyy3Vba3OfzDn38ZpyOqed1L17DNkcMJf1kZBdpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300576; c=relaxed/simple;
	bh=zEBM3hHwU1lhgPSNhjNvPXA9SB6je4wV2ZfhzZqx8DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZUu2IHEfZR33rjsVCx6+An9E3QJlIJw7hqmmXM8Nby76RLM1ySELmAn/RHgN3UkqBFsrSIMATdkUmJqd99A273VMKXkbJzjgOdgpynUh6vKnAbBHm+CAipHysrUEVtuQO9+6IGAVD2QXSnrSQgSkYi1mPCG1i5VV+JpgFMTpe9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gweVEftJ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7092dd03223so146027a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724300574; x=1724905374; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/P0vbfAjm6K3LNoQ5CD1IrJf0GFaknx79tF0mwTM7G8=;
        b=gweVEftJ/OKhyQ7qpaQwm1ZPB75C/kl5Fp3hJu6eYQIhiCJ1thaLiVPQs14l8VW9m1
         Xyq5M68AAjWdaofTFUQZwrjn9LxvIMaUnWO4qaD+QLFrCeHuhX1lk+2NujdqS3sLohAs
         vC2VHcjEXcn5YNCByc82K0fM5SsJ9u7mKA8ZEvzq4IZIYkQO9klSzJ7imDcjG+bQzaIM
         G6QeXF30qtQ32+htAQGYhAW72mXNBEXYWuMoVGN1T84ylmDRFV4DSYsxxkTVxmNd2tpt
         zv8SbFqdO2aNQEPLsml8zsIiGpwJf+uUVRtnkol5Y2q/NoQvZD7QhoTSMy82eroivAuA
         EmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724300574; x=1724905374;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/P0vbfAjm6K3LNoQ5CD1IrJf0GFaknx79tF0mwTM7G8=;
        b=tI9vwuGGVdfSfrZYtBLbGwNYtc6qhyjP3uxVHmVdNM753+x+es3CDfkBxFh8o/9UsD
         0TfTmd6jGMoobdJgVWYebYlgHLC7W6J2yf/ku/y2IAwig2peHGjY5K5z+8OnR2oP8If9
         jGnkk51QeWZgwSeZIvdmN8HpIojN439o3LsRkRX7ZqvLzUBK9wZrx5g+xosFI/cf+qet
         cTfKLyyxE1wbkboxxDZlNL1KKuWus/ulyj42Yh6z3BjWIY6y1hb6ApQvgoGPNC2jBi9n
         fAjt2OHfiSl8CHRenCtrReJCzeO+wtkJE9+v/lD9MB/pq6hcntzQVuK0yAcYyP+zX02h
         wxtg==
X-Forwarded-Encrypted: i=1; AJvYcCVGpby582w30aCIRerLob2qrOxNZ5+ZMGrA3+n4GwuNfann7TYSlroqeus/nukT70qv/U/kUmrUmvsBU1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvg907WHalxg0EnpYAElTg9LtUqXpTt581QRvNHo31tcmC2bW
	NuSJ+4t6Pqa5rjSHbRiE0YFl6JMJVCmATDI/Wb0pbruDlm2LrgtyQbPh2B7fxIH1vGPr+eWmgRf
	7RPC71taiTlXCwbbgUox96mPZ1mYwYTkq+JtXCA==
X-Google-Smtp-Source: AGHT+IEpdBLiEt1QeV/r1ArAeTNomsIoxgldSKxTLruJ6FvISHi+9M+Oz1GauKpOvyUFIwwNZXL6T3m6b3lVwcyxDas=
X-Received: by 2002:a05:6870:9111:b0:261:1177:6a56 with SMTP id
 586e51a60fabf-273cfc54187mr874430fac.20.1724300574074; Wed, 21 Aug 2024
 21:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814054434.3563453-1-nick.hu@sifive.com>
In-Reply-To: <20240814054434.3563453-1-nick.hu@sifive.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 22 Aug 2024 12:22:43 +0800
Message-ID: <CAKddAkCa1pZGZRtTLeB0PFK_sdsxDC44EwYmh4f=SFPzuSbG+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cpuidle: riscv-sbi: Allow cpuidle pd used by other devices
To: anup@brainfault.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, greentime.hu@sifive.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anup

Any suggestions on this one?

On Wed, Aug 14, 2024 at 1:44=E2=80=AFPM Nick Hu <nick.hu@sifive.com> wrote:
>
> Add this patchset so the devices that inside the cpu/cluster power domain
> can use the cpuidle pd to register the genpd notifier to handle the PM
> when cpu/cluster is going to enter a deeper sleep state.
>
> Nick Hu (2):
>   cpuidle: riscv-sbi: Move sbi_cpuidle_init to arch_initcall
>   cpuidle: riscv-sbi: Add cpuidle_disabled() check
>
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>

Regards,
Nick

