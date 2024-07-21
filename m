Return-Path: <linux-kernel+bounces-258322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F37593865E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 00:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C188EB20B82
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035F16B396;
	Sun, 21 Jul 2024 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aMDEuwvU"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821E2745B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721599691; cv=none; b=qkUaVz7sDIP+Yoh8Zsi5Us9KXxIkjuWhn8vM5LrNsWNFgQKPDV65h4v3WbJhvMoLxBJjSwPvnIYS8BJ2eH8g9pJvAyBd/lWzmAbz12BeygEKDSXzimLTdBhtCKf/fnEEQJRAVvr9RIbVD1J6/a95SsOiT5A4YNlgeH3gOP+pntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721599691; c=relaxed/simple;
	bh=NvQhgqZ/eJ4eay+hcTekcrXMx75pemCUoA4q7W94dWo=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyb5BbNjmsq0pSA1o+KVOnemjl4nXsIP2MMoyBRapIQoN/mcGEVgJkQtRXRkQRoMUOGA+ImD2e+mYZgMDPVRr3T1U0/kWJIt/+bIsTEdKFDQiSfP3dk/wBcTzF3Q2Px8UjICAkkaBemJxnXaazs9kb2mP4Y2N3p8VUrgQ0XhM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aMDEuwvU; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 212F73FE16
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 22:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721599681;
	bh=y5sr3lEv07by+NAwwOdiyaM6+TTZ7xKpJ82kUwR7sbg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=aMDEuwvUZG7sOXUNPPo8Tz0sr+ynI3dAbUPWkfahKS6ja9qXBndB3DUdXTq1WlbH4
	 Xofiypl3b4o9NBiChGEn0+VKZXCFwjgvnficwAvmXTUxbeNmkGokrLgDg8snHZLw+r
	 1O9cON6vmQV5TSJKV6wEQCQCWLwRhYE0mTS7axMVLcmswxi480fFHvBrhFokaz49vP
	 kRwy+FUf+SSbovsPmDsNt1uxSgdxb0j4rug2ZPJrueCMog679sMCcIxnFnlDW+iupd
	 V68AniDTiBVd7Wz4Yrp/4JBnyOfNSY/sSpJkhAiuCQEDA6Nb2MnhzHNUDij1fLw0dT
	 9zC97k1LWbWpw==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d92425ce97so3777303b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 15:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721599679; x=1722204479;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5sr3lEv07by+NAwwOdiyaM6+TTZ7xKpJ82kUwR7sbg=;
        b=Tr/TPLbRcey3x+JOVZYV5oPK564syIGb6PmFrCVzKJ6GD38W2SfwJl7SgaH8TboUwG
         R0jGrVViPnk/Pwkthc4X5Dw3NivVDkJaRQEuzYKpFyUFV9ZWdXRl+orFOuppIiITTURt
         d6ewW5eF5rUn5s7hDJ6xyluUffCMFnXZ9SwR6oHpXTTcKqfwUoi0t4lg/K4xCKn3T78q
         x8bS1PlV6RH61PtD6Nrrpiz4sasSxE1NNl17oGoK2B8mfoUoVRK0Uqxx8ax5Rql+1s8p
         DJ8mOgkmiwfBkMGPOqSFuMEFfSHbGywQecwC+SJj2DAvwPtgKAvoCzcP9n5EIl/TD6Z5
         L/fw==
X-Forwarded-Encrypted: i=1; AJvYcCXxXfCWgiWpsW4+Tb/SInzeA6AZ8ONmBe8Ms/2vj7+UjuDrfCf7wyUa/ZnV90i+su92vIo3brkj/S8It3WZtiz6tw7hvLDzlHr3Bt4f
X-Gm-Message-State: AOJu0YyGoxPYINgxKLOAt3g4js0yYqOHK61CkL8JRzIQaxkEKB2fpQVr
	LA4cYsdZTh4rvkUoHDG9JxpN97ABe/4sI13qwixw/pilBoZrVYrudF0rIeTVOW/M7TaHXltRKSa
	fgmhkwSM0bsSpb3E1fkL/+qjGtj5gE7l4B6yZp3P9V5vgySISfxs6ljjcOqg8eQrgg7sRTQe9d5
	rpMrWu2uk8uwtvCsSK+l212cO+cGssTY7K1twMCCR3G3R+5saPau+u
X-Received: by 2002:a05:6808:2384:b0:3d5:2e2f:bf9 with SMTP id 5614622812f47-3dae5fd6b6emr8114729b6e.30.1721599678744;
        Sun, 21 Jul 2024 15:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKu3rxDjbynntjHH+0+p7b3ltQUv9i7hhvrMnwR7SAjBoMSrD4QUg9VCnWIvxOUrarV5om39CY87FNWsSBz4A=
X-Received: by 2002:a05:6808:2384:b0:3d5:2e2f:bf9 with SMTP id
 5614622812f47-3dae5fd6b6emr8114702b6e.30.1721599678304; Sun, 21 Jul 2024
 15:07:58 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 21 Jul 2024 17:07:57 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240711-th1520-clk-v3-3-6ff17bb318fb@tenstorrent.com>
References: <20240711-th1520-clk-v3-0-6ff17bb318fb@tenstorrent.com> <20240711-th1520-clk-v3-3-6ff17bb318fb@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 21 Jul 2024 17:07:57 -0500
Message-ID: <CAJM55Z8uo-Z_9ruyqygK1pbBCTkCxMBVoF8GD2dajhTKOYrAfA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] riscv: dts: thead: Add TH1520 AP_SUBSYS clock controller
To: Drew Fustini <dfustini@tenstorrent.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drew Fustini wrote:
> Add node for the AP_SUBSYS clock controller on the T-Head TH1520 SoC.
>
> Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
> Link: https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index d2fa25839012..10a38ed55658 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -5,6 +5,7 @@
>   */
>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/clock/thead,th1520-clk-ap.h>
>
>  / {
>  	compatible = "thead,th1520";
> @@ -161,6 +162,13 @@ soc {
>  		dma-noncoherent;
>  		ranges;
>
> +		clk: clock-controller@ffef010000 {
> +			compatible = "thead,th1520-clk-ap";
> +			reg = <0xff 0xef010000 0x0 0x1000>;
> +			clocks = <&osc>;
> +			#clock-cells = <1>;
> +		};

Please add this node so nodes are still sorted by address.

> +
>  		plic: interrupt-controller@ffd8000000 {
>  			compatible = "thead,th1520-plic", "thead,c900-plic";
>  			reg = <0xff 0xd8000000 0x0 0x01000000>;
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

