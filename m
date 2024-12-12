Return-Path: <linux-kernel+bounces-443135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7A69EE7C9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521CA281AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06922135C3;
	Thu, 12 Dec 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="irg0MmUg"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5752E414
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010745; cv=none; b=Wc4uWe0aCcfr9qfKp8dTDrDcixKQ9f1yquWZzz8PfvUnXID8aXiusyHOrsnwjYsi3TFkraS9pxDE4axG0mK/gHiACAvFpOw0LqQiJkIsdlonMXvHdl5OZikme2gy8WYmfIUKuR2FjJUylHWSlXzt9IBbK9SOPSshmew65/0OVdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010745; c=relaxed/simple;
	bh=pwBc6jopJG2fnr8sukSdGyV0P2m7SwiydFbswQKN2Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSoD5L+MpdUsxvh9/YGWn+4s1iLH74Mz1LzD3jYIlX1DU4D2RkaTyp9B9cbObXjkjWbAfyvKZqq/29Ud/m6DncVol6O55SSwl6OiedKQUaip5uCbrrQUIhh8gd0ZDnn1fDrUC5YWJh/riMrrkUaBquQg4TKO05f1mk8JJgCRrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=irg0MmUg; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso428762fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 05:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734010741; x=1734615541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZFpmuGq8Hcysw1ltCrcXIg/0YmimJ8vHdWx8dLQ+nM=;
        b=irg0MmUgCfBaIlh/KxU2r0lT0VZVcAJp/akujRYv8Q/AYVKxQJSR+jrU6gy7UXyuix
         juFfsSEB1ntU+3REwAkOyMTXECr/e6qAURrDvGs47Rr0d79R4ru8iv4ECpjpPfJOLvbQ
         rl/vmyfqsct4zWx2tmuaX31mQHPeiJf960+N6Xn/btAPfPWL+fMUCLvC4Tf0GtSVRPbd
         pFq+oJxeR5MVmocTDXafvKxlTzhzQBNVbpH4ZG2F7x7kDbLcRlQpzeqfRGQ4AttAc0cR
         b33e+mUnpqSyz6ULXpSb4RLxfdlsUQM/wdeyMP9jz3zvo2JHfaB82hQC/iyUXJzIoUOi
         Z/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010741; x=1734615541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZFpmuGq8Hcysw1ltCrcXIg/0YmimJ8vHdWx8dLQ+nM=;
        b=ey3dTBwfuE6n29vWqux4ovf+s4QcqeGYoj9dB0vNbZDS1QjD1h6yzj1SFLYuLfhPlQ
         ZmcmFdY/kY3E3ZBJYIPXs29HiyyfYhGErTuWe+Mi1NNsOh9E17KZ88suL+ADecbovl9m
         dxkfgb45/xHlC2FzrVAzRmBnTgQQYWJTZ9WDblwtAZcywNtA39pPPY319A7WVNlIVZSp
         xknfcQ/2PoaSlFqVuVEFsyxGaGAyv9ptA0yFUx0Tf/F6Ei1uaGH4PNs9LE/d20bHhsoL
         L7I7wkkjD04i8NPUy75iE5G1xPUu73u6K9tOlm9XdHvkiKUpbRAp2Zs1FSep8kLVAwYi
         uRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8WK8qTML89GWcXyke9SShZVqcuwHhNEgwwwRfgLaC1DHVEzXXGjMqMehje+LDhh5aoPeKK57VrFnb+74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGEWg+IvUlKD/4Sz45CNwrfTUqzSY4zCXCahCIs9ovP56yy95D
	fQLI8f7p9xzFWrVIgHSv1C9u78kJOystpC87L0u9uGhGgb5h4zesafe3A1kXsTVAHsTTzJcUTgc
	KW9SFneTm8DGOB7xEx98ZgwITeRBQizZuOJzr1Q==
X-Gm-Gg: ASbGnct8tML/NeGq1R77+V6YnHs2U3Vhl1Gf4jU8PMkujWrLcq00ItEff/8Zklwtt0v
	FfAHUmMht2tvEF589vZx3aipXQBrImQprM23iAFfV
X-Google-Smtp-Source: AGHT+IHD6Qcrh2srXPJLHbja5JHfzEhRV/ZpqJWPNHK2/yvOTs/tJi6K/af6ItiRmPRwJ5PEr5Zhb5P3EQeLDRyb/Zw=
X-Received: by 2002:a05:6870:9a1c:b0:29e:6bcd:3ba7 with SMTP id
 586e51a60fabf-2a012d99e0cmr3460926fac.28.1734010741230; Thu, 12 Dec 2024
 05:39:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212131134.288819-1-alexghiti@rivosinc.com>
In-Reply-To: <20241212131134.288819-1-alexghiti@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 12 Dec 2024 21:38:50 +0800
Message-ID: <CAEEQ3w=siNTV4DdVj3N4tW5xBKR-WWByeSxL89_EyC0v=6YNMQ@mail.gmail.com>
Subject: Re: [External] [PATCH] MAINTAINERS: Add myself as a riscv reviewer
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


On Thu, Dec 12, 2024 at 9:12=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> The goal is for me to get a kernel.org account and then send pull request=
s
> in order to relieve some pressure from Palmer and make our workflow
> smoother.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 17daa9ee9384..1c7838642398 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20108,6 +20108,7 @@ RISC-V ARCHITECTURE
>  M:     Paul Walmsley <paul.walmsley@sifive.com>
>  M:     Palmer Dabbelt <palmer@dabbelt.com>
>  M:     Albert Ou <aou@eecs.berkeley.edu>
> +R:     Alexandre Ghiti <alex@ghiti.fr>
>  L:     linux-riscv@lists.infradead.org
>  S:     Supported
>  Q:     https://patchwork.kernel.org/project/linux-riscv/list/
> --
> 2.39.2
>
>

Thanks for reviewing many patches before. It sounds good and I also support=
 it.

Thanks,
Yunhui

