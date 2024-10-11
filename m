Return-Path: <linux-kernel+bounces-361493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07699A8ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5CBB2331B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED36199E94;
	Fri, 11 Oct 2024 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="SQKDUqxH"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951C188918
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664276; cv=none; b=ktrI6jAX+AJzPQWJGjNEl6dE2AGLPCdFuPKdjDvU0/kO5My6Bue6kOszOlRieYAVB6TFLu4FzU7FXAcja6dfK7yFtyDlG3jSzFdZjUYgcpRXbDPZuA8ILilckufxvpBB8JoOZsTaqgJBoB9ml7E29aazisewKXaCOBQRSR/3QVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664276; c=relaxed/simple;
	bh=32Mjcd2dJsumm+btTsVmfBP+NbjBoMPuUy6307MRM+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8hDWd2b0o1SdqmlMVsislP3oDnVU64y3jFyj9m8q8okqWVzdo/JUI0LsGkbpQYTq+FB49YgeO0TTfLTtA/FKAoLDNiOF3DNF7UPh42pYS8+Hcp0mNHBqN64eKNVuZpe3dj1lxqElBvox0BhzSxajMc7JlEnjZ4hfWI/XRCW1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=SQKDUqxH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so508058a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728664274; x=1729269074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymJ/qex09j4ioztSVDBbfNAos9AY+mRR2jHbKLcRzPg=;
        b=SQKDUqxH/+TpHnQVGvczsZAfr/bmo6dc9a1J+jx7Vv8N+0qhwQn40uVobe0ySs+rCq
         mSdJgShmtBPF4I/7whVApyOshP0s/FfeLECl7GtujkcLWSeHeFnRvX8aunvCLWKllMqs
         y8m3yw0rw6xSjKEafA3YTF7SqBuW6Z+xHTzjxnVmsC4JHI0q55RpxcyMuzqDbKjuxBJb
         eEOM5MtGNy9hSFkqeuUxYy60Jk+9Aayk5je3HjSJNPkuir/2OogSDt5V/G4qO8kmDKKy
         ol6Nrcngo/XVN1ccWsdmZp7Jb8vcpRp8cG2JB+o6UeYOFaGGGCG+9nWPdHBIOHpacsF/
         9fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664274; x=1729269074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymJ/qex09j4ioztSVDBbfNAos9AY+mRR2jHbKLcRzPg=;
        b=A8GlLeQu0/nx9aEN0tC0xIjgPONXTHq4ryUJyAZTD3+Y7Q9w1GAIi180YyubjsGJeR
         t2RkInvg9kIS4D0DKiJDz1GF8wecUV8VI8RitDVqPyKfVVek4/lNabEHhW/x7LC/5UmP
         3gdjjazxWZUmU4cUb936MgLFBHfUtfEhsIyWhSwYkEr0482IIotiTf1M9Kk4JSM/+mZM
         +sHIfKNOnY3G/M0CBHBgII2dXlRJd+YYLQf0pSPenX3kzZcvCiwl3KKE6y50n7xiRp9a
         xG9LhlHvz2MgnGQ+qJwFwvwBRJ+xHuBoGv9DrhkTSo17oXvgu5EPTiQEXXHdqvTVcnXC
         AVww==
X-Gm-Message-State: AOJu0Yzr6qgEfeMYVi04SqhcZibSPVLrO7rC7bTDLIW7OBcwklCeX+sE
	jRwfsMoOI9xaDlhbJo4l2bTSZX2axvMquHPN5u2PExQHN+9mPDdfexRDfulkTGk=
X-Google-Smtp-Source: AGHT+IFZHNKSdlUtyflW/oAl3271oyzHBL3EezDm4ZEZS8ioT4B/wsLs4jMN4bfjeIMRhEIYEroxww==
X-Received: by 2002:a17:90a:4b0f:b0:2e2:bfba:18d4 with SMTP id 98e67ed59e1d1-2e2f0b3b53bmr4317697a91.17.1728664274280;
        Fri, 11 Oct 2024 09:31:14 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2ea9d4145sm2092573a91.18.2024.10.11.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:31:14 -0700 (PDT)
Date: Fri, 11 Oct 2024 09:31:12 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: Re: [PATCH v1 2/3] pinctrl: th1520: Update pinmux tables
Message-ID: <ZwlS0FiKfiPjhNSf@x1>
References: <20241011144826.381104-1-emil.renner.berthing@canonical.com>
 <20241011144826.381104-3-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011144826.381104-3-emil.renner.berthing@canonical.com>

On Fri, Oct 11, 2024 at 04:48:24PM +0200, Emil Renner Berthing wrote:
> When Drew took over the pinctrl driver it seems like he didn't use the
> git tree I pointed him at and thus missed some important fixes to the
> tables describing valid pinmux settings.
> 
> The documentation has a nice overview table of these settings but
> unfortunately it doesn't fully match the register descriptions, which
> seem to be the correct version.
> 
> Fixes: bed5cd6f8a98 ("pinctrl: Add driver for the T-Head TH1520 SoC")
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  drivers/pinctrl/pinctrl-th1520.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl-th1520.c
> index 03326df69668..8bd40cb2f013 100644
> --- a/drivers/pinctrl/pinctrl-th1520.c
> +++ b/drivers/pinctrl/pinctrl-th1520.c
> @@ -221,9 +221,9 @@ static const struct pinctrl_pin_desc th1520_group2_pins[] = {
>  	TH1520_PAD(15, UART4_RTSN,    UART, ____, ____, GPIO, ____, ____, 0),
>  	TH1520_PAD(16, UART3_TXD,     DBG,  UART, ____, GPIO, ____, ____, 0),
>  	TH1520_PAD(17, UART3_RXD,     DBG,  UART, ____, GPIO, ____, ____, 0),
> -	TH1520_PAD(18, GPIO0_18,      GPIO, I2C,  ____, ____, ____, ____, 0),
> -	TH1520_PAD(19, GPIO0_19,      GPIO, I2C,  ____, ____, ____, ____, 0),
> -	TH1520_PAD(20, GPIO0_20,      GPIO, UART, IR,   ____, ____, ____, 0),
> +	TH1520_PAD(18, GPIO0_18,      GPIO, I2C,  ____, ____, DPU0, DPU1, 0),
> +	TH1520_PAD(19, GPIO0_19,      GPIO, I2C,  ____, ____, DPU0, DPU1, 0),
> +	TH1520_PAD(20, GPIO0_20,      GPIO, UART, IR,   ____, DPU0, DPU1, 0),
>  	TH1520_PAD(21, GPIO0_21,      GPIO, UART, IR,   ____, DPU0, DPU1, 0),
>  	TH1520_PAD(22, GPIO0_22,      GPIO, JTAG, I2C,  ____, DPU0, DPU1, 0),
>  	TH1520_PAD(23, GPIO0_23,      GPIO, JTAG, I2C,  ____, DPU0, DPU1, 0),
> @@ -241,7 +241,7 @@ static const struct pinctrl_pin_desc th1520_group2_pins[] = {
>  	TH1520_PAD(35, GPIO1_3,       GPIO, JTAG, ____, ____, DPU0, DPU1, 0),
>  	TH1520_PAD(36, GPIO1_4,       GPIO, JTAG, ____, ____, DPU0, DPU1, 0),
>  	TH1520_PAD(37, GPIO1_5,       GPIO, ____, ____, ____, DPU0, DPU1, 0),
> -	TH1520_PAD(38, GPIO1_6,       GPIO, ____, ____, ____, DPU0, DPU1, 0),
> +	TH1520_PAD(38, GPIO1_6,       GPIO, QSPI, ____, ____, DPU0, DPU1, 0),
>  	TH1520_PAD(39, GPIO1_7,       GPIO, QSPI, ____, ____, DPU0, DPU1, 0),
>  	TH1520_PAD(40, GPIO1_8,       GPIO, QSPI, ____, ____, DPU0, DPU1, 0),
>  	TH1520_PAD(41, GPIO1_9,       GPIO, QSPI, ____, ____, DPU0, DPU1, 0),
> @@ -256,11 +256,11 @@ static const struct pinctrl_pin_desc th1520_group2_pins[] = {
>  	TH1520_PAD(50, CLK_OUT_1,     BSEL, CLK,  ____, GPIO, ____, ____, 0),
>  	TH1520_PAD(51, CLK_OUT_2,     BSEL, CLK,  ____, GPIO, ____, ____, 0),
>  	TH1520_PAD(52, CLK_OUT_3,     BSEL, CLK,  ____, GPIO, ____, ____, 0),
> -	TH1520_PAD(53, GPIO1_21,      GPIO, ____, ISP,  ____, ____, ____, 0),
> -	TH1520_PAD(54, GPIO1_22,      GPIO, ____, ISP,  ____, ____, ____, 0),
> -	TH1520_PAD(55, GPIO1_23,      GPIO, ____, ISP,  ____, ____, ____, 0),
> -	TH1520_PAD(56, GPIO1_24,      GPIO, ____, ISP,  ____, ____, ____, 0),
> -	TH1520_PAD(57, GPIO1_25,      GPIO, ____, ISP,  ____, ____, ____, 0),
> +	TH1520_PAD(53, GPIO1_21,      JTAG, ____, ISP,  GPIO, ____, ____, 0),
> +	TH1520_PAD(54, GPIO1_22,      JTAG, ____, ISP,  GPIO, ____, ____, 0),
> +	TH1520_PAD(55, GPIO1_23,      JTAG, ____, ISP,  GPIO, ____, ____, 0),
> +	TH1520_PAD(56, GPIO1_24,      JTAG, ____, ISP,  GPIO, ____, ____, 0),
> +	TH1520_PAD(57, GPIO1_25,      JTAG, ____, ISP,  GPIO, ____, ____, 0),
>  	TH1520_PAD(58, GPIO1_26,      GPIO, ____, ISP,  ____, ____, ____, 0),
>  	TH1520_PAD(59, GPIO1_27,      GPIO, ____, ISP,  ____, ____, ____, 0),
>  	TH1520_PAD(60, GPIO1_28,      GPIO, ____, ISP,  ____, ____, ____, 0),
> -- 
> 2.43.0
> 

Reviewed-by: Drew Fustini <dfustini@tenstorrent.com>

