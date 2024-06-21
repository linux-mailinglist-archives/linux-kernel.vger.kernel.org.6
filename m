Return-Path: <linux-kernel+bounces-224214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E38B911EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169CC1F24B58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36916D4DA;
	Fri, 21 Jun 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iceT/iqF"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205BB16D31E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959123; cv=none; b=PMajLzaF5XpoG/tVfmHPl5VweqqHpn1fW1KrQuMQusgtJesShQmcLvA39mBbpTgVY8AhrF/9GDDm02e3zVoB7gXuf00LCcLdAfdn1trBTg328CJaqCcis74j8qUHQQvz3v9xa49waGRq9c0ghZvEka/xx2X3Zi/9DkAJBaZfX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959123; c=relaxed/simple;
	bh=jmuD9ij6chyK8MTqocqlyj2la/6Cg/k6crdy5De8/FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJsyJhgZ8CmKYt6pwI5Nl2OHHQDN3E5jUYZqlRshi9N+ABHnMAbhwIiRJI8q3agSGVUMnTN29KXV8bTBlPl057UKwwl5/bO74N5P8qtEVYNtLGkEMtuBtICTxJReSck04ryoCdo4pswIdIiETnGH+RiXPQSq2WbF6JQpQp8ZN8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=iceT/iqF; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62a2424ed00so19803267b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718959121; x=1719563921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmuD9ij6chyK8MTqocqlyj2la/6Cg/k6crdy5De8/FI=;
        b=iceT/iqFEAfxajYycndQB7ZuK29itP0byDkn1MWUq23cRucOZ7TP1v3SsRBlkJ/P+N
         fGOc5meH0NpDhY0OKiKeLue716cnEh1d678Frvsw7d9UITYTWw9hta2U+ixBDHkDCpj8
         ceO2OVn9rQdFnM/alh4hxa657xQr12HKL7ib9DOBslI+Eu9TAkbqi2Mc1RmY8xxC3Egw
         z+dxvTva3yl8yEwIgcdx5KsIbDyalLfcqc4f1PQqZahSFfHRsXR2c27GiUK5CyOYmi5V
         Luh11OA6woyIWr+5/Wme0veV8rt8kAkKiR8AglTdpPhLGBdTtdqx/O+tO5kfLAOThWVU
         NPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718959121; x=1719563921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmuD9ij6chyK8MTqocqlyj2la/6Cg/k6crdy5De8/FI=;
        b=Uftm3/KdL777RxeKUjq9tfscHeBUm/K16J2aTIESJ+4hnnPEpyMMVjmZ0WtwHhHdxL
         CP87NdA1lAkzBrTvzR47+EgTZ2JoC2UD2TJXHsrYfAUgclXhQTn/bRaASqsNdzfqDoiH
         EJgmZdMZjejs0L3H7BeHPhenRc435UqOPPfYyEI1DIpWfbk6GjErFAH9g1B1sbbB/sFR
         dpXcJZud1W0t23bhmNBLT6IlHjEqY906cHnLHVhKfIk00qgFKXsZ++drCtnR9feOGS4k
         K9G5Riai63cenYf8YYqqw3LVhb7CGHSMH2xzDzI43EywTNabIUmxQNFqrsfor7E10Gij
         /3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbOL31wESkSjpPek8g0at7lGmgfI2NVfC/oMprJMC09DaHooSSeFkEi5EWS0/CZXBBP6fXB0xcP1gunU1+tRtNl1eM5QGnTZFFWS2h
X-Gm-Message-State: AOJu0YyX4gCVOER0/ZrJ80l5F+P2DxJpOWWnfbGWZ2sk9SK6513PzYdx
	TeRYZcTmH+R2MDNZxefixpfLS9B9tTW5UbaJREKSRvjRQ9E+jMazXUSQo1SxK66K/UnFkAaZtYi
	ZrYUhtLpNZmsrZa7Wsnovupg34L1uDB7pJ5ahPQ==
X-Google-Smtp-Source: AGHT+IF912ccGWjWI9KaFr/46jfr9YC6MYpl/J6B8gC/LJE0T8xr9OXEwfRFOQ4rmWJjIRKdkcAoXsOlgo0V93Pg20I=
X-Received: by 2002:a0d:eb01:0:b0:631:4e00:2c06 with SMTP id
 00721157ae682-63a8d82c7efmr80902067b3.2.1718959121093; Fri, 21 Jun 2024
 01:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
 <20240609-support_vendor_extensions-v2-4-9a43f1fdcbb9@rivosinc.com>
In-Reply-To: <20240609-support_vendor_extensions-v2-4-9a43f1fdcbb9@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 21 Jun 2024 16:38:30 +0800
Message-ID: <CABgGipWk=8v=bgZ0OaA=HSDrm2iX3qk6WQuBcqLCzTr_HVYANw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] riscv: cpufeature: Extract common elements from
 extension checking
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor.dooley@microchip.com>, 
	Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 12:34=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> The __riscv_has_extension_likely() and __riscv_has_extension_unlikely()
> functions from the vendor_extensions.h can be used to simplify the
> standard extension checking code as well. Migrate those functions to
> cpufeature.h and reorganize the code in the file to use the functions.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

