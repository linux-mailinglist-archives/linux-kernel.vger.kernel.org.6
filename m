Return-Path: <linux-kernel+bounces-341763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387579885B5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9258A2838FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2994018C92D;
	Fri, 27 Sep 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cpYTVPJN"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6F18C34D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441714; cv=none; b=afN0hKMzSRwWyu2+v9gsuqCfVt+PVwj1zzMpRrtozchgCLr5ND0hfvFThvS2CLc/upgFtC4nk/T4EeZSInMSIPbzKey9on61gjLR+IDRHjB3yOSb8Ao67WDxlBC5DLGcQH8P+YUHjc033f36435QtPjhLvM8t98Az7Wg0fKXivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441714; c=relaxed/simple;
	bh=XIIAM18PIWY1uWyT4rOqqfqO716IvFJ3bHm8Si4kxpg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qnx9L6SM6TjBsMm6/ZePPFl5aiDtek7EqASi5xoTFi2uEhIiXvWS4AiiOasVMgXd66F1NlYoHtcC3cWj1/wChmAFzl36mB+Std6YyB9CotUHRN0ruLV/pKHjco19nxhbJbW8jF0TgO77zX+EE5U77soLMhYH1ZK+e5ciYTv8rwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cpYTVPJN; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CCC3E3F135
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727441706;
	bh=sSmJYgv7I+zUFEDVZuQHO2YXTAln9N/geQIOSH+hGyE=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cpYTVPJNTX0sqbyrMEJRO/uVjz2otErD6UKsNj5Ar1mFDwh5wFPV+z1lFG9GFas+t
	 sHxYZTmUUDHGZAI7XUxtI3NVLMW9k2oSKf7AL1Rdk3nvJ8dwAUc6feCond7OClug3o
	 kDbSHAZ4kk1efruWv2WZUPA76AkNgsr5xoJgnAYWbfzmyhAwqPgSSJH1MfQ502bmq7
	 1Dp9jwzS6ngF9wL7LdL1qDYl4PvQD/dTUoYgEE/0PDAxahJkISnUmUBW1s5zXhkGfo
	 17OpLxRlchX0EJzfBhoBejqMEqdmyl6HHhlesT24gqi8tpNbsbhforB5Vt//051NoO
	 8PIEyS7GD5aLw==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5e1d2056d62so1604309eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 05:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727441705; x=1728046505;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSmJYgv7I+zUFEDVZuQHO2YXTAln9N/geQIOSH+hGyE=;
        b=EcIyuH4MA96Hc4LrTq172n4uKlkkgvQuaBiPP6/ezMy0L4cJdM1mNLDxiTCA9VfimW
         Ph5MY5GWT2CfR/SlOKnLTPov909eKplwdObP7ohX7zt9QkshMio0r3eiH4RSXz3dIT9n
         97voX/ZuWgtvRjshROuuwbCUEouLUxh/FbEZ3VnSrZa/pdW5hEihE5WuwYzrJ/V913ul
         MrItz+3VUYtKEzk0pfS2z8ie4XbiFhegjbD8BN0SNKrIv3P1JyweUHilCttGYgTcCr5I
         QDvc1xmb60KZFxkVRGPDLxCSrZIWauQ4ymvCu0paJXVnan7Vpl3cG/FosEa6BShCmlAs
         6cvg==
X-Forwarded-Encrypted: i=1; AJvYcCVbQ5pGFsnm5ZORF9LuPucOLNHQ2yO5YiWKlO4oHluDz6rdGgDM5z1daICSRY/mX4Evjl8uWSzUjMKxzdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSmQxPFMeGSKXj29FxU7i4mHutk3tffUs+c6/4G2Aik/IkEsNd
	4ThoqGT1eMK/bq+i0UJFZbbzM0CUQyUOl2qnm2xIrAIkuQqcrQVOfFyYbJNbbifJNHM1KvzADIi
	LqyyfPWgWCV+VT2wK1ikluqwDGs0saIWgi5pvcGsqZFXG3K961G3RphFOMQknIkAkNIC987ouVB
	2tiGmbp7dKEozba4lXccNSVdmvDwTYMEZA5E7+eB6J1JkEfS7D4wex
X-Received: by 2002:a05:6871:890e:b0:27b:66ea:add7 with SMTP id 586e51a60fabf-287109f5bb4mr2306166fac.4.1727441705659;
        Fri, 27 Sep 2024 05:55:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq2edOIUBYR+Xf5m9TknVcpYnAPqK6sQBsqv8AamrOSSkCMEyyDtCAwOwZQ7rY9zd/qv/ETMaRzLJy5zKgxVE=
X-Received: by 2002:a05:6871:890e:b0:27b:66ea:add7 with SMTP id
 586e51a60fabf-287109f5bb4mr2306155fac.4.1727441705340; Fri, 27 Sep 2024
 05:55:05 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Sep 2024 05:55:04 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com> <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 27 Sep 2024 05:55:04 -0700
Message-ID: <CAJM55Z-FLmpFfisNpJi8FP7o_5mwoDa7r18VXW7u7nF0V6oiRw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: Add TH1520 ethernet nodes
To: Drew Fustini <dfustini@tenstorrent.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Drew Fustini <drew@pdp7.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Drew Fustini wrote:
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> [drew: change apb registers from syscon to second reg of gmac node]
> [drew: add phy reset delay properties for beaglev ahead]
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  91 ++++++++++++++
>  .../boot/dts/thead/th1520-lichee-module-4a.dtsi    | 135 +++++++++++++++++++++
>  arch/riscv/boot/dts/thead/th1520.dtsi              |  50 ++++++++
>  3 files changed, 276 insertions(+)

...

> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> index ca84bc2039ef..d9d2e1f4dc68 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> @@ -11,6 +11,11 @@ / {
>  	model = "Sipeed Lichee Module 4A";
>  	compatible = "sipeed,lichee-module-4a", "thead,th1520";
>
> +	aliases {
> +		ethernet0 = &gmac0;
> +		ethernet1 = &gmac1;
> +	};
> +
>  	memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x00000000 0x2 0x00000000>;
> @@ -25,6 +30,16 @@ &osc_32k {
>  	clock-frequency = <32768>;
>  };
>
> +&dmac0 {
> +	status = "okay";
> +};
> +
> +&aogpio {
> +	gpio-line-names = "", "", "",
> +			  "GPIO00",
> +			  "GPIO04";
> +};
> +

These GPIO line names does not belong in this patch. They should
already be included in your other patchset adding the names for the
other lines.

/Emil

