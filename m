Return-Path: <linux-kernel+bounces-345716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F031398BA25
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99CB1F21658
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE91BE25C;
	Tue,  1 Oct 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ffu86CxH"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C951BD51D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780172; cv=none; b=FwMMEjTxwQzCLH5NpCaKA+p3g8Fwp/gyIPyX3MI2M6iptrl2ta2p5M42acSUQM0A5/avvmKU758QqPnmIEV9nO+3ZlOU1w54CV575hKJiY4xP8ad/MetkPXtdxIvrcgyPy72KTLqJmcRJq3JqzQqDQsOdUdOAHqYGbzU15nU1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780172; c=relaxed/simple;
	bh=q2BxZIKRLar+nRWtHGf6NfCN0u2SBQhbVYOQCkCT6Ws=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2SzA+3ec9yf83r/Xn4fSINlgqvr8LD3uX5CrLwqm7vdpHhDVfFH+pZUpi9/JzcX1Q1fypCq+0DEecXzSq5XF5waBwu0DvGvKSYOaNooCeWradc5IuZ3dpyPWG+JrsPp0T3p3wLk6YSbOoyOAPlPSAW+t1Qc5Oe40JD8cWLuOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ffu86CxH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AB3153F5BB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727780167;
	bh=cffy+Z3VyDZ30QrCrVDSHqUYHPJ52fzEBS/6c6EOh0c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Ffu86CxH6qZuXLLJ4RrmQVnSgRBBwPsbFc7aSQLqWKzzXuPSEUpK8N5U97dmrhivX
	 lQTzn5EQxCtqcBAAT9A3OOZo1ak+i6qqKw7vKdlOk+1ZUE4kAZCFdGUWAxXvj07PAY
	 UZRbkHAyGLq9JXLRXl9rx0b4iQ60+1P2e7Tv16PVgLIjEZm7xWMO81C8V+7vcBqj8J
	 xtywIYf1bpOQf9EAU7ZcOzCQhpklvVXWe2E2EvtsbeoVd6njZgwiche2/TtFmCoM8d
	 gmxaHOJbFDFZg0crh6nJdd64GfcJ91o1iJ4h0G3BGH36Wf2c8lDggZJhWsPUZV3xVw
	 0rilKgzLbMUUQ==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-286efde9783so5251182fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 03:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727780166; x=1728384966;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cffy+Z3VyDZ30QrCrVDSHqUYHPJ52fzEBS/6c6EOh0c=;
        b=p9aVCcGBu/VKTWCI4nPNhu+T855IN+HsdYF+WOIZToZUIjwsjfX6m5h7rQICG0Zb+t
         4+XHGeKaEs21FuHGwYhHQ+Fec4lXAdTvMJo4NfOaeZ7XUbgu5jhhB7GJ4dXfUThVAHBS
         Ivys46xikwgUpaiTEvWDV/mXyWKGHdluEEWzhmK2uCzIbssO6/HAV3frZP6XEZoR3mrX
         WidPWctYQ6Q0ajjQ8t4yUFla0+tL2D5o7XqUd6qVn4reQI2H7iada2ePHcHL8CbP8qeu
         u3I/iEF1MIxv9FtJGIOBr7x3DpEKABsr5nI3QHeq11z635hLbt4Bv1QzChDs/sx1Y4oE
         ksbw==
X-Forwarded-Encrypted: i=1; AJvYcCWpys/04fMaVBJAtpRTfp4KwsNrZKCpRYFhzHLnDCbS2n8bqEBPi4pBsnxEnhtw5b9867QwQFlnJa+rw64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0BxEjf5fbZbrJ6l5whRxNksjWlsL5Hnw+oS/jfap8XHU9/1J
	6ur6LdJF+Un4vTNXv50kSdHxxCNRyMZOzv1ZXRPTMdMq2pI0DWQZ4grnXTfk4s5zJmQ5dOc/UYs
	aNi1F76JqI1U48ODIrveayC/Fr0XW2GK5cWAZDlbTSL12eJJu4B6my+214uWchheaqkDnDm97R3
	u1ranvkYaUX7CsWiLwvi3zmAr/+NH9CA354hzt4lY1O7gpFrrNyuKZ
X-Received: by 2002:a05:6871:546:b0:277:cb9f:8246 with SMTP id 586e51a60fabf-28710bb0f11mr9907409fac.38.1727780166559;
        Tue, 01 Oct 2024 03:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmdyej5fn4nmNuFbnZtzhPVlcamHO9/HtMZQ8zYXDL3DuuDTSynQ1mCkP4fB+TXeRzA2qPuc7jYD2cnz+Pels=
X-Received: by 2002:a05:6871:546:b0:277:cb9f:8246 with SMTP id
 586e51a60fabf-28710bb0f11mr9907391fac.38.1727780166205; Tue, 01 Oct 2024
 03:56:06 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Oct 2024 03:56:05 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
References: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 1 Oct 2024 03:56:05 -0700
Message-ID: <CAJM55Z-3fPh-qyb_dpaBH12ocV3yheR8Rentg2oz9jCVLAuJBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: efi: Set NX compat flag in PE/COFF header
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Heinrich Schuchardt wrote:
> The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
> EFI binary does not rely on pages that are both executable and
> writable.
>
> The flag is used by some distro versions of GRUB to decide if the EFI
> binary may be executed.
>
> As the Linux kernel neither has RWX sections nor needs RWX pages for
> relocation we should set the flag.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Makes sense to me. This was applied a year ago on arm64:

  3c66bb1918c2 ("arm64: efi: Set NX compat flag in PE/COFF header")

..and before that on x86

  24b72bb12e84 ("efi: x86: Set the NX-compatibility flag in the PE header")

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  arch/riscv/kernel/efi-header.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
> index 515b2dfbca75..c5f17c2710b5 100644
> --- a/arch/riscv/kernel/efi-header.S
> +++ b/arch/riscv/kernel/efi-header.S
> @@ -64,7 +64,7 @@ extra_header_fields:
>  	.long	efi_header_end - _start			// SizeOfHeaders
>  	.long	0					// CheckSum
>  	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		// Subsystem
> -	.short	0					// DllCharacteristics
> +	.short	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	// DllCharacteristics
>  	.quad	0					// SizeOfStackReserve
>  	.quad	0					// SizeOfStackCommit
>  	.quad	0					// SizeOfHeapReserve
> --
> 2.45.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

