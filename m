Return-Path: <linux-kernel+bounces-364275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EAA99CFF9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C3EB21FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842AF1ABECB;
	Mon, 14 Oct 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oqaDaQod"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC261ABEB1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917854; cv=none; b=Q8J7dpKP6I56qI9kfmP/Kft/KSFqV8DJNwcYeMM/gJyoQ7rLpEPWzVADxngUwArJxKUl9ayY2vpT91M7pT+j/2n5F9PETGYRvODLxssKENzZ8KyTl6ZsmFUw9eAf8G5GlFv1u3V3pf2JhcdC9vmQqrTSn9orOWctgb7cn/6onsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917854; c=relaxed/simple;
	bh=4I22R8EH6rJft0GBNcZ0FqU8QlkA7JHkZcP5FIrhCMQ=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEOooIElOhppPrsUuDVWX8O06tdvGc50De/ReIa7Jo4xbd5+l41ky5/5hjW/gnPNaU1fG7STooXc80iGDNwCyet5WTVLauT8YsQUTY7z6gED9KN91/OxtJbQYiraI9luOlsHo2EGDRF0sAEV1TANh+Z0XDsQQf2Yq7Rp5RCZWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oqaDaQod; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1478D3FE09
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728917843;
	bh=w7jcJQQrs2lciGR+l1IMV3wPi6SzvVaYcIWT6ArXKPU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=oqaDaQodQE6Tf+dNfyZ1RdwJa87Kz9p0bIg3rHSHK+GopyTX8tQOhuQDyMDD5GUfF
	 DC9yFIq8hPk244lUkL7fRWOBaInjpsNHXaMqcWKjdt7b+rGhiuOEuz5cPzjOm65x9d
	 9jq8AKVg45zvF3hwvH0NTkmuRnnttBAPJBUYbcczS1pzkqZK0u9ayykDC+ERZofZGx
	 cgIfwAJyhXpoI0u8MGYbO0TJlSHqiQPjUpQnsLQ1VZf4SJTMzJdmKG56ZyWRyrRF38
	 xmg0efxLW3Lf8yubNu0o/godt418aYZupUY0cs7M49IdEk3m7DcjKJl30Gfxh8SaHY
	 GMmjhDztO5qOQ==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e5d803a442so1392522b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728917842; x=1729522642;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7jcJQQrs2lciGR+l1IMV3wPi6SzvVaYcIWT6ArXKPU=;
        b=hu09NIWo8q6Si35Qis227I8re8Jer0tL26hx3CMXYh++LpEpRXT1WdDUWWXXxPst7t
         WsvKs6GyDzjguQguNaCwFsjj/kCpEPndur2PrzbsoiLu5XO7ZgtynhV7EMIElH4hdKHs
         VONcXLvrG8U7+ncFZJuPdTrxiN+sj6XAdTAucjVs1XVnDnsQBU4ZBhn6+i9hn36XJXAh
         LfGH13f2sLhsQibzEi5BGdG4HiwCGUvFMmGBMsQAzWUtJpruxr2MAp4dQX2tQMKnXflB
         4smE6zzTo4BAtsZzL5lmTnnbbBGiAqbs+POCVUCXe9Xz2CAasa1S3Euni4RK0v6hu0n8
         fBEg==
X-Forwarded-Encrypted: i=1; AJvYcCXGq10F05UQ6oTsUIEJwy7I9vvjQr4iOf48Iu6RbcSBsGmLGEcilKRtFcOgtyko2UDQpDWJxgtyhewanN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99SQu74vQGmYPjUomSUxxsD73EE9zDpSt17cqXKvi859IUHtJ
	TRmS++Vx0nqloZ8AETccC0jIliDr4p/fTl3K83E2y+nvkoaFVurRtirPLE7Cx/jE0NYdnzZGpuR
	I1fYQ4QlKzyb2yvAmhI0/vEZHzEu/T1Wm0pG/Nyjvmr/b8uR2iU+YI5FMkkBks+JYjCz7wKt9zM
	eOcv/uCBDla3XZhN1OQ4bS+gxZSNI+2W3IK7mlVmuHrvpPAe0XJfTE
X-Received: by 2002:a05:6870:4214:b0:278:bfa:87da with SMTP id 586e51a60fabf-2886dced84amr7421843fac.10.1728917841756;
        Mon, 14 Oct 2024 07:57:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZc7S/SsrDerBCPsPZzUzEauPicO5lJ3x7aYFJHGS/2FP/NfQZYzrPO7bg8HBk/3yI2N7NccykyCVKHL+eU0Q=
X-Received: by 2002:a05:6870:4214:b0:278:bfa:87da with SMTP id
 586e51a60fabf-2886dced84amr7421814fac.10.1728917841412; Mon, 14 Oct 2024
 07:57:21 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Oct 2024 10:57:20 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241014123314.1231517-4-m.wilczynski@samsung.com>
References: <20241014123314.1231517-1-m.wilczynski@samsung.com>
 <CGME20241014123412eucas1p2144768f373a2e2de7f6d00e7b67f9328@eucas1p2.samsung.com>
 <20241014123314.1231517-4-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 14 Oct 2024 10:57:20 -0400
Message-ID: <CAJM55Z-bzivMZWUsHiii+2tw2-kdRe7kqtVa+MvPEAVTmOvChg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] riscv: dts: thead: Add mailbox node
To: Michal Wilczynski <m.wilczynski@samsung.com>, drew@pdp7.com, guoren@kernel.org, 
	wefu@redhat.com, jassisinghbrar@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Michal Wilczynski wrote:
> Add mailbox device tree node. This work is based on the vendor kernel [1].
>
> Link: https://github.com/revyos/thead-kernel.git [1]
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 6992060e6a54..435f0ab0174d 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -555,5 +555,17 @@ portf: gpio-controller@0 {
>  				interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  		};
> +
> +		mbox_910t: mailbox@ffffc38000 {

Hi Michal,

Thanks for your patch! Please sort this by address similar to the other nodes.

> +		       compatible = "thead,th1520-mbox";
> +		       reg = <0xff 0xffc38000 0x0 0x4000>,

The documentation[1] calls this area MBOX0_T, but it says it's 24kB long.

[1]: https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf

> +			     <0xff 0xffc44000 0x0 0x1000>,

According to the documentation this is inside the 24kB MBOX1_T area.

> +			     <0xff 0xffc4c000 0x0 0x1000>,

This is callod MBOX2_T, but is 8kB long.

> +			     <0xff 0xffc54000 0x0 0x1000>;

This is callod MBOX3_T, but is 8kB long.

> +		       reg-names = "local", "remote-icu0", "remote-icu1", "remote-icu2";

Maybe these should match the MBOXn_T names in the documentation?

> +		       interrupt-parent = <&plic>;
> +		       interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;

You should probably also add the clocks here:

	clocks = <&clk CLK_MBOX0>,  .., <&clk CLK_MBOX3>;

..and claim them in the driver. Otherwise the clock framework will consider
them unused and turn them off without the clk_ignore_unesed kernel command
line.

/Emil

> +		       #mbox-cells = <2>;
> +		};
>  	};
>  };
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

