Return-Path: <linux-kernel+bounces-195553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED2A8D4E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE01C23B36
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C8917D899;
	Thu, 30 May 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="j9V9qBoO"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF017C208
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080760; cv=none; b=lCA8vEaIX0JHch+eGe2tOZaICoorHwp7fn6qZ+ATVq0YAVtSDXxBAuT2ImfEuZx6BnwvVarIMI5w+DE9PUh00FOcR2nyeQEmPfnE6dACKxRhCKMlO2LdrLcRriuB37r2S8vQcqh2yFT3rE8mNZaV0sFpy41/cKj7+QxSH5id9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080760; c=relaxed/simple;
	bh=qCr2fwCZCC0sZAtQMrr7v5keGCDnI6ZBVcUAOfpdlSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE8YRwmic81pooXCPh/uc8qmFFOBKLn3pCprt+BmKIyHPLpPZLKVPgCdMiPnb7opxakv/dEvvsWcy5sohFy5urfEMty5wAS6uxPmcpbcY3GFFttVPY7Drc5RoYt2zK7z6UfRV8CrUhZAQcgvyN1q/mIfl2ALvF4QiRqNKVflSKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=j9V9qBoO; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e96f298fbdso10181691fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717080755; x=1717685555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xju9nW5aEF63Pcv0lMb3cbBthG2ZJ9khtPEmPPr3uI=;
        b=j9V9qBoORQqeS3GKArPqvCwjBurBaovpjLhdWtece1aT1WlBuhmztHTGSAemZaMT2X
         F8mWXa8evU4eSXTREfPIXJJsluCy14HXoVNVZncmRzX2Km0KOM0EJ8SZ1rXOWYUsUJhX
         d9ErEkms/QWb3z9Z+ddqFeJHIgn1a5+U1ljG1fInmJaQCOP/ZZV7bE5hosRmZoJoJlWx
         ZYanWnoF0KN62fT6m7pz4l+LEeI6ca5Gsb4ykrfLJ78LLITxvCUtOhJOPU/Ihb2p2fpI
         Qq745Jl79/LpPpg7jC6a/U8XhXJU/+HX7BSV9lg9jY5rPwJ4LIeco8MGHnO7L9LYKnH0
         uipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717080755; x=1717685555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xju9nW5aEF63Pcv0lMb3cbBthG2ZJ9khtPEmPPr3uI=;
        b=ZqJ+3lwwSyqm5F2o84kkmxGEjjxuSy6JFseRMwR2nYNzpAwdmsMm/aAoPi3PTtO4I/
         eDVrAajx3M9+o4W9qgeug6CUPm+v8ls8e3ywVQsQe4z4YIJTVKWMh9z7M+fBA/wR0KJC
         wRR/NyX8A8cBFi6q0dg5Ft52O0YK5NtrYPI9vh2RllxRSYzBG9EwPajrfm/6U1fd2/FC
         6NlwGDlRwJvkfZ33WBm4OiXGQ4qsqD0zVHetloHR9ltVbqVMc1jr3WVTktMG0BOa42RY
         X1PiqB2C+eqSIdfNPVJqKdwK698XzpVSrxWYuE0ERSdAq+A/EdpnUxESXMODyroeVMyp
         ztjA==
X-Forwarded-Encrypted: i=1; AJvYcCX00JEJ10pi8+ETIk+oKGQCss2wSPatDLQOJPtxzhmn/79nsBEBux4AyhJNCwOlh0ZfQCwAHXCgeqd6CFJn3pvBesiQNG4dylJMhXRL
X-Gm-Message-State: AOJu0YwHdwThKMChsQpc8NLeYMzka1Kn/rtVW54FS5VvBP1oLge9bVz9
	vw8018/kTsKf+fTsweOigB1V+qkkUnRqk6FxQfl3C1yl/CdD12HaGzlSIRiqsP4zZwC8LDgxdj3
	HJjoMr/GL5HweMOs/5ehhkvhlKLEjt7mBYXY6fWD5+iZUScDc
X-Google-Smtp-Source: AGHT+IHf8TmrUvKHY3tZVeP9T/NeHo/+xLt+IhXkdMwRroWcQhly/ewRsUPfk31Cc9BSWLvx0W2D6Ia7qNisp/t3DcU=
X-Received: by 2002:a05:651c:224:b0:2ea:8e94:a2f4 with SMTP id
 38308e7fff4ca-2ea8e94a54emr2778791fa.21.1717080755423; Thu, 30 May 2024
 07:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-dt-interrupt-map-fix-v2-0-ef86dc5bcd2a@kernel.org>
In-Reply-To: <20240529-dt-interrupt-map-fix-v2-0-ef86dc5bcd2a@kernel.org>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 30 May 2024 20:22:23 +0530
Message-ID: <CAK9=C2WvmXujHT-PpvhcHgg1Tck3k_K_BmLVp-=1Z71Y385Cbw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] of: Fix interrupt-map for fw_devlink
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 1:29=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> The duplicated parsing continued to bother me, so I've refactored things
> to avoid that for parsing the interrupt parent and args in the
> interrupt-map.
>
> It passes testing with unittests on QEMU virt platform, but I don't
> think that catches the problematic cases. So please test.
>
> v1: https://lore.kernel.org/all/20240528164132.2451685-1-maz@kernel.org/
>  - Refactor existing interrupt-map parsing code and use it for
>    fw_devlink
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Marc Zyngier (1):
>       of: property: Fix fw_devlink handling of interrupt-map
>
> Rob Herring (Arm) (1):
>       of/irq: Factor out parsing of interrupt-map parent phandle+args fro=
m of_irq_parse_raw()
>
>  drivers/of/irq.c        | 127 +++++++++++++++++++++++++++++-------------=
------
>  drivers/of/of_private.h |   3 ++
>  drivers/of/property.c   |  30 ++++--------
>  3 files changed, 89 insertions(+), 71 deletions(-)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240529-dt-interrupt-map-fix-a37b9aff5ca0
>
> Best regards,
> --
> Rob Herring (Arm) <robh@kernel.org>
>

Works well for RISC-V, Thanks!

Tested-by: Anup Patel <apatel@ventanamicro.com>

Regards,
Anup

