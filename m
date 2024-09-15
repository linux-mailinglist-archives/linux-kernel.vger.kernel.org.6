Return-Path: <linux-kernel+bounces-330080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60C3979976
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 00:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBEA28309C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 22:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF89129E93;
	Sun, 15 Sep 2024 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2r8a01Z"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827365B216;
	Sun, 15 Sep 2024 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726441102; cv=none; b=W4vFX4bryIALBtK27yykI5muz4Vmt5ZwxU7amKLSRazfY4F37KKf83DvbIRNQbJ2qZb+l2fbfDu8NVirQ2PQkj7qiaQPPYYc3Xrc4eKJQJ0PtCEBP7nDLqI1s1boNzNivNm9FId4BuHNovcRzU8aQnB93l0atUvIUY20MU/YPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726441102; c=relaxed/simple;
	bh=izYeozNrBPOQ0kDuU4FExi0WlAXzsG/SZyGO8ND3hcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfdUiMGIVemD85waIUT2aIgQlkxc+ZQzP1sDKG6GKEKdkPhMxSB3Uci8xdPjU1ZLBIsLCeoKyZdPt6SDZv+7hHMv3zZQ+naDJ/E5fjtxDSMPd/5ak6XCTdsqr8MdiAUt+Zz5oX8yGEHzOiuvHEOfd/Iy3MEvIBa6c7TUZ85x2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2r8a01Z; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718da0821cbso2922488b3a.0;
        Sun, 15 Sep 2024 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726441100; x=1727045900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJWQfIoMB7rnjHeIW9tHLPiTsezG8rJXL1GQ5QFGffE=;
        b=i2r8a01ZzcAA88oxA6634nTN0/vajCCz5/Xf7MlEcfvB8zVnNrnX9SxRZJVNUaZtF4
         P4bzzyp9klVT+kw4XUt1+TbmmOIvU+BE6qB+cQ8VwkFTgaPDddPjwdSfJrUQOIIunwFl
         N0qxhPVB5DuF+WU309BPWO+70wHHlD7sSRDBMvfdWb7bK73QdLNTfsQfEGnySRvoxYAn
         adfgiZp3hVCa3SxE35VhEj4CMUrY8GG4S/Q0+rJLsMoR9IDhg0UMcFDtbK9gGoJAppka
         NQo+YPB0RjcTnQDRD+jIEHL+JzhOetRy+r/IgWMbJxZkdqpEHmF1MWkoCBsKWhSgS4UL
         WddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726441100; x=1727045900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJWQfIoMB7rnjHeIW9tHLPiTsezG8rJXL1GQ5QFGffE=;
        b=v5gj+rrQNrOhX7pN5F7gpN83FzhvTvImVDISMxFqLhfem6z0X9/nynURkCKhHMTpI/
         egLYo6dtzg5o19x4Gd14yVvQHAJMwOqAKZ+pXxD/5ODFnVzejaVtZyJ6FMdOLHujRT5L
         KpifsFWkgXF4LmdE6ol7Ww9fVJNUR3+Cp8iwVH7k/S7F1N6KlzTtJQWbjcilhJC9PzPn
         bp5eOLHnsovPCcDcobdFbV8E/AX4ia9ubw262cBmGpSaVp4jP6sDwacLXsU4YXQ1KpH6
         9jDNurO8Y+dxgAA795KLs8OqVZYrPZHHwK09MADSG2BTolIMKNH2kiV6faVpaCAu9V48
         A3yg==
X-Forwarded-Encrypted: i=1; AJvYcCWAMn3PNuWztA07EZ2ZnR/mWcDljbcUWgBMI4YpXlxx7vWBjYGZ4b43TnOW5kmgXH4RKcHBP2d5ymUGb24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoe3SvoHbeT2HHopCpStv8D6XnFQQq8IAJewgGb6nFCSdENr7s
	hsxlpCVLl8JVVATJAxzSViI/9pOf3y35sm91adoiq5yttr7+UBeG
X-Google-Smtp-Source: AGHT+IHwEMyb2PyzYlv4wkbD2Vq7MyLvipf+Xbm1p6NlFyhaFsyu5L6K6K0QDK6tP5WHviwshIt68g==
X-Received: by 2002:a05:6a00:2d2a:b0:706:61d5:2792 with SMTP id d2e1a72fcca58-71926081bf9mr17549908b3a.8.1726441099557;
        Sun, 15 Sep 2024 15:58:19 -0700 (PDT)
Received: from inochi.infowork ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db499b8105sm3038351a12.94.2024.09.15.15.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 15:58:19 -0700 (PDT)
Date: Mon, 16 Sep 2024 06:56:57 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Ze Huang <18771902331@163.com>, linus.walleij@linaro.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, conor@kernel.org
Cc: devicetree@vger.kernel.org, dlan@gentoo.org, 
	zhangmeng.kevin@spacemit.com, linux-kernel@vger.kernel.org, jesse@rivosinc.com, 
	cyy@cyyself.name, inochiama@outlook.com, jszhang@kernel.org, kevin.z.m@hotmail.com
Subject: Re: [PATCH 0/3] Add initial support for Canaan Kendryte K230 pinctrl
Message-ID: <qecfx4gepop65xivvnk2w7waikvadrl2bp4evyehp4kgaegsdp@dmluqpj3xune>
References: <ZubtZKlxqejnCFx_@jean.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZubtZKlxqejnCFx_@jean.localdomain>

On Sun, Sep 15, 2024 at 10:21:24PM GMT, Ze Huang wrote:
> This patch series introduces support for the pinctrl driver of the Canaan
> K230 SoC. The K230 SoC features 64 IO pins, each of which can be configured
> for up to five different functions.
> 							
> The controller manages the entire pin configuration and multiplexing
> through a single register, which control features such as schmitt trigger,
> drive strength, bias pull-up/down, input/output enable, power source, and
> mux mode.
> 
> The changes have been tested on the K230 development board.
> 							
> The pin function definition can be found here [1], and most of the DTS data
> was converted from the vendor's code [2].
> 
> Link: https://developer.canaan-creative.com/k230/dev/_downloads/a53655a81951bc8a440ae647be286e75/K230_PINOUT_V1.1_20230321.xlsx [1]
> Link: https://github.com/kendryte/k230_sdk/blob/main/src/little/uboot/arch/riscv/dts/k230_canmv.dts [2]
> 
> Ze Huang (3):
>   dt-bindings: pinctrl: Add support for canaan,k230 SoC
>   pinctrl: canaan: Add support for k230 SoC
>   riscv: dts: canaan: Add k230's pinctrl node
> 
>  .../bindings/pinctrl/canaan,k230-pinctrl.yaml | 128 ++++
>  arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi  | 318 +++++++++
>  arch/riscv/boot/dts/canaan/k230-pinctrl.h     |  18 +
>  arch/riscv/boot/dts/canaan/k230.dtsi          |   2 +
>  drivers/pinctrl/Kconfig                       |  10 +
>  drivers/pinctrl/Makefile                      |   1 +
>  drivers/pinctrl/pinctrl-k230.c                | 674 ++++++++++++++++++
>  7 files changed, 1151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/canaan,k230-pinctrl.yaml
>  create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi
>  create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.h
>  create mode 100644 drivers/pinctrl/pinctrl-k230.c
> 
> -- 
> 2.46.1

You should send your patched as a thread. I think you
forgot to set (or set wrong) in-reply-to?

Regards,
Inochi

