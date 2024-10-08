Return-Path: <linux-kernel+bounces-354494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3031993E48
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCFDB236D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672B139D13;
	Tue,  8 Oct 2024 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abxb1BU1"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07331DA5F;
	Tue,  8 Oct 2024 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364737; cv=none; b=R/lSzJpMJr6IdR2NtqKqYbL3HBhwehgQlOSxNDYxkKvAhkeXy9hdSevEBkoAvwhds0TvKMsgBpamzakSfuF04razy/N7v9C2npDXdZa4HEiYGz1QZU8ZwWmGiMmJBI1vmc3YcrCCm7IOMEzaTim7q7irv3+PzicnMQ0H7HIiNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364737; c=relaxed/simple;
	bh=7G85euQIAfwanFuzfMJ67+WmFwAzqNOto3i4Rhprh3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnxUbRcb43Ww0qrwQNQG0rccKBC6P71A1sv77I8oEFKB4clJQwEavXSSy8/ZtY0NquSraOmC9r2kKCP5LmW3j0WsrSI5N6CIv3g1fsWjbB5wTMw+9v+okeCBFDAazVn57ZEu5U9hFFlhZ/erAytZBGeo9ekJBTOJTZI+deqwhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abxb1BU1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b49ee353cso48794235ad.2;
        Mon, 07 Oct 2024 22:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728364735; x=1728969535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQO0zvw9KnkYprXk/usa3JnN+eWxXRiy1TqyGCHK6FM=;
        b=abxb1BU12oKmoBzcEZV79dCeMleQKcRXZInikdu9wNS9XTsweqciMI1lvlPTZ2H6b5
         KlnzxKirKEWpvMXYfhcqxx3tNVN0zeqW4pMFvPcqeAow/QwRRN4zWKxGFsMvWK7jCpvK
         Eb+YgsNqNcodTfeW2+NikBcAh7NCb8DO+H+gD6EqHd65d3o89VYs4uOTh76MT+j3s3iO
         8SRDMTDAwxbndggLoMIbVgsIgWSlkKLNch8XMvH2Hn+W8FxXcEuqhNOqQ5uOuaw80Oba
         Va2nvEQLTvUliELSwHwyVNjsMXvPbLeagJwle9S/1P1q6B5f2TJ/kv32xqDcaK/t8obj
         iy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728364735; x=1728969535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQO0zvw9KnkYprXk/usa3JnN+eWxXRiy1TqyGCHK6FM=;
        b=ciyO+LKooXurQFEDEwzpdZn104JAg2Z87bvpkQdHefNhNQ+uBep7O5d3DDev75TVma
         ww9cueM/sFy8qfTpaGCz0jtF13DRJlrs2kRIn6GGR0uDbpwf8UIPX0tyllz+Dk0eSn60
         GvnzGT8lA51MEQ+PQn9nGvnDVHLi0iyCVI1rba8W9Yxj2yVMUwpnfg7c2HhcqxO06B69
         yImQgXCW2LTblAJvjt73AYP76Rh4LEALsOOqwFgie22yfi/hf+cRojmyfH0992i6Y35h
         R1SiesQwbN69Cu7tmmuUozgy03pLnwZEVZQzlK9kTbRGdDb8qyaP9fL67cfFrpU0DTrT
         mtBg==
X-Forwarded-Encrypted: i=1; AJvYcCW9b7qXyGe5WDxd3LRB+633HJtL9n9WWZPxwN2uU5mGyVTD/xYL8nUBQD0YeepEXCjtCWN65cjo2HZA@vger.kernel.org, AJvYcCXm5NAL7eWoSFo4MqSMxoU4SZO2r0D6ZMGwV6W+/7CmnJrhM6qjlx90VQZmlIXoYbxeACVMBNuw+PprbuT6@vger.kernel.org
X-Gm-Message-State: AOJu0YzgwQgvvYrFhT5N6mBAcnGJ7avwVaLdziK5tG4LIjOlchPbzSEp
	5p/+W9strpeTS+CeMU1YF8EG1XgRGADZui/5SvkI13DD+nTD+Y5j
X-Google-Smtp-Source: AGHT+IEJ7tiXzNbXz43iRKpy9kKwG7dH8WSlBskbZXuh6zvWYGqu/6a4ih5eqS1AOLgEJJOllhxQQQ==
X-Received: by 2002:a17:903:32c4:b0:20b:9098:4693 with SMTP id d9443c01a7336-20bfde659c8mr200667015ad.5.1728364735090;
        Mon, 07 Oct 2024 22:18:55 -0700 (PDT)
Received: from inochi.infowork ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138b13a0sm48211415ad.50.2024.10.07.22.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 22:18:54 -0700 (PDT)
Date: Tue, 8 Oct 2024 13:18:46 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, 
	unicorn_wang@outlook.com, conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com, 
	krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	chunzhi.lin@sophgo.com
Cc: Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH 1/1] riscv: sophgo: dts: add power key for pioneer box
Message-ID: <aixuis25v56xwnc6zd2ost5yhho5soznpa2pf6fya6orvwwke4@6n3nhzrd7kio>
References: <cover.1728350655.git.unicorn_wang@outlook.com>
 <12e65a99f1b52c52b7372e900a203063b30c74b5.1728350655.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e65a99f1b52c52b7372e900a203063b30c74b5.1728350655.git.unicorn_wang@outlook.com>

On Tue, Oct 08, 2024 at 09:43:52AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> There is a power button on the front panel of the pioneer box.
> Short pressing the button will trigger the onboard MCU to
> notify SG2042 through GPIO22 to enter the power-off process.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> index a3f9d6f22566..be596d01ff8d 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -5,6 +5,9 @@
>  
>  #include "sg2042.dtsi"
>  
> +#include <dt-bindings/gpio/gpio.h>

Just move this include into sg204.dtsi. It seems you forgot to
add include when sumbitting GPIO dt patch.

> +#include <dt-bindings/input/input.h>
> +
>  / {
>  	model = "Milk-V Pioneer";
>  	compatible = "milkv,pioneer", "sophgo,sg2042";
> @@ -12,6 +15,18 @@ / {
>  	chosen {
>  		stdout-path = "serial0";
>  	};
> +
> +	gpio-power {
> +		compatible = "gpio-keys";
> +
> +		key-power {
> +			label = "Power Key";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&port0a 22 GPIO_ACTIVE_HIGH>;
> +			linux,input-type = <EV_KEY>;
> +			debounce-interval = <100>;
> +		};
> +	};
>  };
>  
>  &cgi_main {
> -- 
> 2.34.1
> 

