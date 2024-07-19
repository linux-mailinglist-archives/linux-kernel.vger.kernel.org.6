Return-Path: <linux-kernel+bounces-257657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206CE937D16
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF45C2815E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FD81487FE;
	Fri, 19 Jul 2024 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="A+R42Y3m"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6A1487EF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721419053; cv=none; b=FLGsxVbmhkwtboOx5JTQXe3A9BntJta2qF88A6z4sU+9ibEO8n4ZKU29IeBYR33U/DdkrYk3zLFKB9dQrVNcuZawgThCZk8J9x8ZPytV0VP/H8Iw5QEg9M8YJCBkvdIBoOOIAG8v8MqjF32UXdsGnqfz3LDSC2wbxUMD0AF6xPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721419053; c=relaxed/simple;
	bh=B8aLNC8rU70Zjs3Uh/UPocyKDEXo99TS0oP0YsHJFOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HouMdF5RMu6/RUiuCzCfH0qmuXygBG9W8bUdXaPVBg+xbeWB/ppGEKFUzSMAXafY+ECqMJo4uQW/WYaFH4Vuqub0KAZXb5iqrOzO1W/dgHSjDLNgfbhlvXoJD8+s2b6XjB0FYBR6uo6Rea0AYIjyXkXj0KEy5QiAdLhVrOgtRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=A+R42Y3m; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ed741fe46so2669924e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721419050; x=1722023850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8aLNC8rU70Zjs3Uh/UPocyKDEXo99TS0oP0YsHJFOw=;
        b=A+R42Y3m3ym4LzcnmLSS7/8k7CTsDnmjgpQcStQK2tcUhTLfAqQ8Y0hyBBAq6GIvi2
         kgqLjdUIT3auWETyaWc0OLZtLA4AKh2o9mb9qs7nGju2i9KBx5xJ4IHml5OY/QeY3Pws
         RN/Vy0UWCzP3fQPzVC0hRST6EnRaK/RjZHj/lUHL9+dPoyP15KwCDDSlf/WD/FYJ0f07
         gCggk8+/NLxyjnGNYN6g3JvaMM0Rnqdiz65Ee2em2rWaXhA296hJqxiaKryrisvBW99O
         sWIgayOl1Rb39si1ERv6kfkGeKzWmRYSU6YfBmTrMVp2vd/6jeVzQai4Z6l87LY0DG9e
         51Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721419050; x=1722023850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8aLNC8rU70Zjs3Uh/UPocyKDEXo99TS0oP0YsHJFOw=;
        b=dpxU8XoP2of4IQwVDC9AK9pdu+usyEW50C7m/o7CJq66X4wmv/dy7pTGRLhxjv07IX
         t6Ash30P7ld10h30CkyNQZpvrWriWKVoICmPENIFy9MzbD6vLoquG2SSOyvmCYnfr7Eu
         ZkN0/rC9C5vKv+yNUAJ4CkIGqmuIXXI2941gbTOSZjRYNn4A1viI+duFtDIgV0U7hCOk
         ZYZ8BIP5cRXnLYw97fBBTcmw8olsrJDtanMV8Si/eEauNO9PH8D9QSol9+Yp+6Y9Ou7d
         SxYqRpccXaQys1Ng1nSYJZxItMvRdUMUwTJ5hIV2GmejwCbHGLULXejURaz/y/tjI75e
         PyUw==
X-Forwarded-Encrypted: i=1; AJvYcCWVfLiinBH9srB/R9hlN2G664WRlfzq5UYQi3NiBT14x4NvTvTudj+fZZn1F2nDaJx3eVNu7SRFhRuGOPGCzClVgxXRCdQPpnVpEqy4
X-Gm-Message-State: AOJu0YzqwRoWpVbL4upogWQJilqPfNJkYpri/Vu5hyZnAO55SKZ8vi6O
	OuezASgSmPwqpp41B+Z+ejYP7ETa4Z2agm+Q8ENBFnZY9tDLrXsu4jE2t7gg7bGA640prZFbWmK
	pK4T8Gpt4LaC9cUd4b/v97eAOAVtxVYLedB+Ibg==
X-Google-Smtp-Source: AGHT+IGLg0Zec4iHQMawiM7bkM9+i3kahZr0JAjZ2I8oWLHvoCCPg25fvrVDiKEktiVDPxl/yiCHdhaZSmY8GsEWCOg=
X-Received: by 2002:ac2:4c55:0:b0:52c:e10b:cb36 with SMTP id
 2adb3069b0e04-52ee53dc66fmr6231799e87.33.1721419050254; Fri, 19 Jul 2024
 12:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717180727.4180475-1-jesse@rivosinc.com> <20240717180727.4180475-8-jesse@rivosinc.com>
In-Reply-To: <20240717180727.4180475-8-jesse@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 19 Jul 2024 12:56:54 -0700
Message-ID: <CALs-Hsu-jNSpoOq836GQjREChEYVWy=osYzS0KQzBB79_uKSrA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] RISC-V: hwprobe: Document unaligned vector perf key
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 11:08=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> Document key for reporting the speed of unaligned vector accesses.
> The descriptions are the same as the scalar equivalent values.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

