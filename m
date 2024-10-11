Return-Path: <linux-kernel+bounces-361565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A8F99A9D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB711C2188D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2891A0BEC;
	Fri, 11 Oct 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="Ezwi5EUg"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4D198A0F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667347; cv=none; b=Z98tLo2sfAZwmkZq3p97tI4mn/N4jQYK6c3a8+LF+1RXXlQkCbLj/Sf4VNhge+b1hyuanJmdwpVv6g+C3hwysnuQPBVx5CwId3g6rqVspaC8OzrHDPvm5M8A4loS620dOeTCfeWFQmC6l/MKsw5J7MAawttSuKP9IAmdcjx0yLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667347; c=relaxed/simple;
	bh=YEyVmkAzBO9qAgH5AgLJiUyq4QQZwdK2WOHvpX7uVV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qytNSOooiJSIsih1TMVnCfVmoGoeuQU2dA4bcjKhPUuHfELqM5mgB9XioO54IReFMnKLD1OJRX8CQmvzy3YX3+P7Z1oN45dzxeOT4vMgeMM2Elx1U3I/vEca3xHxsNx+K2trJSAimXYe2s9YoPsDN8IcfZHsjgQbPEIn2C+9cZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=Ezwi5EUg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c7edf2872so18342935ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1728667345; x=1729272145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aZ52jmXTRU0WDuKnL6qTle0VwGKZCWaBSs2okeMFkY=;
        b=Ezwi5EUgw5q/c5POjBTxem+a1i+pdvjSHjhXo71Gk+tkkBj1InoHV5qECqCohm6yuG
         9vPIpBrCOUb5mSYBpYdf9TVnckMEk7f7gvn2W5UcMreyE1draptgbllDtgftuoNUUGIE
         hZtQuwC4CQx0Y0RYq1Yf9Tj40caq2eAU6cgpxpYfncTErhWwfAdmOf4JtYmpBvMJ7ruQ
         ja5o9hc8KiiUyZiPXU5cHXPMT0cf3Qp9TCxiui2l4eHiLqhpkouGtrwV1dIsdt1f0K8K
         NXrOcrJLzDjHMYkQ92ztxx6ukwt2BmpGh/6sItnStLLMrgJd7etbVZ2TiPiaJMsrOeLq
         ouMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728667345; x=1729272145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aZ52jmXTRU0WDuKnL6qTle0VwGKZCWaBSs2okeMFkY=;
        b=fVPLTrSnraA96ui+8H1FtY5JaSTy4nwsCn55TFFuvtCJEOYdvImNRUvF0d6Z3uO610
         8mz6q+VvuWJpE25BNR6a7erUS+EnX+FNSUdfSc+U2tpmBAFIjAAZPkWTHeZQZb/EmreD
         YSkD0636Ek+PNe2YUqDqvxrkyc0g96N1wCstL1uy8mwnfjy3b3jupR5uJSL6Ezaab90b
         aG6kjmnCa5WwY6eGWkV9mHLBuHCQx5SYd79rRJd5wTnN/1WLykiya30RBXVrApU0DJdB
         Hd1p973VIbo2rhRwNZ2cCLSsMz1GZHwtxMRjbdvaEBO6cZG12IHBNvrjBt83cAAANjaB
         x4yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFZENSmruXBQJsy9aOKEKTNGVuYFubxwIJ1E06/48NXDA3zWr0rCrNPaK9Z3f456MLhBIuodL3KLgsXco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMnMQBH68d4YVH+ZdLMfhDquH+RoFgUdk6T5S1Gxn+d+Oqlxu9
	UEuWuVgAhCUmgH1sw6fkBGQYV4B98sYlKOu8aqawbaFqNmB3fV0Ijo0776XPAJU=
X-Google-Smtp-Source: AGHT+IGMU8kfRZQZdp7FUTBbkcU5ohX16bkO/daQ28hOFX/Z7i9mjCLTsIvmEcg9GdJ8EEGI7Ao9Tw==
X-Received: by 2002:a17:902:da89:b0:20c:ad30:c891 with SMTP id d9443c01a7336-20cad30cbe2mr31776005ad.10.1728667345287;
        Fri, 11 Oct 2024 10:22:25 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e751fsm25622875ad.139.2024.10.11.10.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:22:24 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:22:22 -0700
From: Drew Fustini <drew@pdp7.com>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] pinctrl: Add T-Head TH1520 SoC pin controllers
Message-ID: <Zwlezn9V75hiLtPw@x1>
References: <20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com>

On Mon, Sep 30, 2024 at 12:50:50PM -0700, Drew Fustini wrote:
> This adds a pin control driver created by Emil for the T-Head TH1520
> RISC-V SoC used on the Lichee Pi 4A and BeagleV Ahead boards and updates
> the device trees to make use of it.
> 
> Changes in v3:
>  - Add Rb from Rob for the binding
>  - Rebase on 6.12-rc1 which enables AP_SUBSYS clock controller in dts
>  - Update dts to use AP_SUBSYS clock controller instead of fixed clocks
>  - Remove unneeded defines from the driver for dt unit addresses
>  - Link to v2: https://lore.kernel.org/linux-riscv/20240914-th1520-pinctrl-v2-0-3ba67dde882c@tenstorrent.com/
>
> [...]

I've applied the dts patches to my thead-dt-for-next [1]

[3/8] riscv: dts: thead: Add TH1520 pin control nodes
      commit: ad36d24e4fac83a6cf916fbf7eb458ed5179758b
[4/8] riscv: dts: thead: Add TH1520 GPIO ranges
      commit: 5c0a6b845d1670c7a10d8016cb352c21b0133935
[5/8] riscv: dts: thead: Adjust TH1520 GPIO labels
      commit: 2a3aaf5fd062e9a820c420b02795acf6e031c855
[6/8] riscv: dts: thead: Add Lichee Pi 4M GPIO line names
      commit: 753c9640121235b3ea26137f3a2dcbb301fa8556
[7/8] riscv: dts: thead: Add TH1520 pinctrl settings for UART0
      commit: 5aa0a71414f1e4fcacd64146d40e78ecdfc26374
[8/8] riscv: dtb: thead: Add BeagleV Ahead LEDs
      commit: ddc5ab7259a525670fbea6e9bda5334022aae050

Thanks,
Drew

[1] https://github.com/pdp7/linux/commits/thead-dt-for-next/

