Return-Path: <linux-kernel+bounces-521684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65D3A3C0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87D01895651
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FDC1F17E9;
	Wed, 19 Feb 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iOjKkdyS"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375141EFFA3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973030; cv=none; b=oNvwHo2QKUOZE8QuQtQv84E0EHNxBAOLAC9G52Yw6ojB607RvMqYn3EAoixKSKNYoEygzWsVD1gfFT9iFaUW9PgRdEjAjeInL/StbqB5HhfMRaq//lsF2zhw6V/Gl5DeDlGS3ZVNfIYJTQ2N1pcGE7gKgRQiwmIQhYlnOKA6l6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973030; c=relaxed/simple;
	bh=cUA7XGIEYvXXI6LpEvkpuihgJFTpSxZlDOgmf9EBdE8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q27U2kM0ah7C1u1gJ8yeReTCvm7j7M2hXNilr/jtwvodmpV7p7ELphkqiKFW47dfKtCSlQ4SCFdXKuk8w24PmOQJQnJA80IDCUQLRnZUQcm19bYYe04NBWqbe550HTbeZJ5ZDQEMqZKrWAJOwmW7UXswk3o+aUk/1Kq6xgUOmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iOjKkdyS; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B042C3F296
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739973026;
	bh=HkThrHww5O7217vswgEm19Ksu4iUBCwcKWWe4XYtKbw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=iOjKkdySiO15H/owhS+6RlWbTaM7qWbj/4SbkVh+GTb6k7Ome6jhwOVeyqSiYJ0CN
	 8wsi7Xh49BRWqybkMhmMJ7OXQIIRBxU7WaFU8um6IXpgHggOu8TH9S4/ch+6DpwWtV
	 BmDJU1m3OuH/tT5NAya4xB7Z5QDS5WJ5BW1JArIh/vp4Z11Y3Ag36c980Axgskm4kk
	 YA8MhzSAoYzW44t0RbwFe+9HRBzgFqyjw/2G/ytcLrUDg5ynE6nOUrrHVNgRXGqrS7
	 taELqWiW9iFAw9i2MG37l2FOW2mcSdw4wNlKeWaJTdq5Qpl3+G7gcw9AYVahisF33R
	 xqfnhjmByjTQQ==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3f4165b5849so218367b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739973025; x=1740577825;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HkThrHww5O7217vswgEm19Ksu4iUBCwcKWWe4XYtKbw=;
        b=ZF8ft9Uy46LXfNC6Bj7jSp4qa3R45/hVMB+8PL76pGMacon4ndrPfdDSbsD2dPQymW
         OPMJ97DSmCthxptRP/zBYnbY/JLBdu1uTjN526waJ9EL1DNMumxJHs2+80i094B+4pby
         ljtNb6IqBCqhzcpx2AO/SiFJq/wCIEEzDFql63SIJm4Q4PcdpbybbLkECrrisbTs21/T
         jsrhuzAvlJAAuCK3cmPgRHUg+tCeatdfdR4oXYMMvGK90tqbcxJvF70PiZlIVcH7WF6o
         cChcS0GZARuu+3wM3aonSyi9uBvOGpey1ud/U38RxmtxOi/rJdlG2KIyjmb2cOeGiqPF
         BaIA==
X-Forwarded-Encrypted: i=1; AJvYcCURE5txbNIwEbBq8Usm0kAVK0tHGuDRQJzkYm85CrzaHQ4JSwCmyg0BuXtLii/LvmwwHPvuwMbXfqDTgek=@vger.kernel.org
X-Gm-Message-State: AOJu0YydLGkgg/43c9BWDlvRRGz1KrFEBbmkkqWkFBNI42nzcvwl4Cvf
	4CoMeKG2jPxVbSeK1gTiEixjWGAbUjRoQNlMG+tXnF/o1QIkodQMCVcbmnWKgzzbL8I2gfU2QGu
	Wh75jZTqFwSaVibzpK1c4F7dMcK2p1y5fLeSNpV1XYlmpplNk1Ayzratp0nxX1pM1Jn3TmloLrL
	ZDWpKAuSzOnhOjydeIoIKUN4w4snl52vV4O0USwYoLC+YUE0jnQnDE
X-Gm-Gg: ASbGncsGMGXyuPsd4L8nnOs77e4ztasq2GpchP4um4g93b30Bf7/g+rojFq57jOexqr
	dVcXkGmSWi52QDCaIgOfUJWsxp1xOkcGwIXj78dgmdhQQIqYy1HAI/wSC8Dios3aLFSzoQw3bGK
	zmAV8AUScDXfmnx6Y=
X-Received: by 2002:a05:6808:1404:b0:3f3:fca6:e780 with SMTP id 5614622812f47-3f40f1d80damr2677728b6e.4.1739973025296;
        Wed, 19 Feb 2025 05:50:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELzb0relCMdxW2h9gdJIHGCHMAFy7OUi/2S7r6jAP4Sq1/PdQCSb8BJv9iB/UP1miQ71opDlKqPQcOB0oF060=
X-Received: by 2002:a05:6808:1404:b0:3f3:fca6:e780 with SMTP id
 5614622812f47-3f40f1d80damr2677715b6e.4.1739973025019; Wed, 19 Feb 2025
 05:50:25 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 05:50:24 -0800
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 05:50:24 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20250102183746.411526-3-e@freeshell.de>
References: <20250102183746.411526-1-e@freeshell.de> <20250102183746.411526-3-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 19 Feb 2025 05:50:24 -0800
X-Gm-Features: AWEUYZnjj3UcLpDwY9vHo1V6-acr0oNVHmkQ82SwWdTmAkFxnAuNPZAUCub5EJA
Message-ID: <CAJM55Z_b2qf7NsvKm5mVjS4O-hqqsDNhpohcvJ_myasOL97oSg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: jh7110-pine64-star64: enable
 USB 3.0 port
To: E Shattow <e@freeshell.de>, Conor Dooley <conor@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

E Shattow wrote:
> One of four USB-A ports on the Pine64 Star64 is USB 3.0 which requires to
> disable PCIE0 and change the mode of PCIE0 PHY to USB3.0 operation. The
> remaining three USB-A ports are USB 2.0 with the USB0 PHY and do not
> conflict with any of PCIE0 or PCIE1. PCIE1 (1-lane) routes to a PCIe X4
> connector.
>
> Signed-off-by: E Shattow <e@freeshell.de>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Thanks!

> ---
>  arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> index b764d4d92fd9..31e825be2065 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> @@ -100,3 +100,8 @@ &usb0 {
>  	pinctrl-0 = <&usb0_pins>;
>  	status = "okay";
>  };
> +
> +&usb_cdns3 {
> +	phys = <&usbphy0>, <&pciephy0>;
> +	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
> +};
> --
> 2.45.2
>

