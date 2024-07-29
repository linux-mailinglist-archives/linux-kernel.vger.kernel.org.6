Return-Path: <linux-kernel+bounces-266499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354369400AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BB9B22187
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E618E772;
	Mon, 29 Jul 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="k8SFm33b"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492518D4B9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290263; cv=none; b=H2PCfDG8BZ2dw8o56YZteu7SNpgrslMNNYcjrno+pw8Y6JFYh3fjF9jtG1cj2PIBGcmmL3xXwAh3sjYrKRoAcYLei8fimeSvqCKiT29KxgfRCoLnkk5vxvdqy92k5ndaHfKEIwmMfIjygzMWlAkpq0UTUfvyvojmNLridk5U/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290263; c=relaxed/simple;
	bh=nHl2Y5IWaProKCvXUomzic+RUjes+RyRmoyy8eze+JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDaBA40vOgec0TVEnHr2ct+Uxcbp6DIz5nhMSp2dVIRlVs5rojE1lnS8QYu9sT45ZDXR/oyD2D/RvAWdYqMBEl5xaNGPz0cJd0suGItsDdrg/qne73Jyk5BPmCXEEMI985WCKvW5+S6wf0ISDdOM2VFVTZ+5doPx0CTM4pXTBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=k8SFm33b; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd78c165eeso31235565ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722290260; x=1722895060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/uG0RbPF+t6wEe0TF57sCA99ACL1gtkgDLZUWdqXsM=;
        b=k8SFm33btmfByCBNlcfMVA1+1GUpX+duHXFPnIT/vPNIK54hXAgzzisdygMVLSpZGs
         /0gmvxC3ckTqnp/6ESFzNuqR1npSrfv2rToxEZv9ebUMVcUsNox33rOO1V/IJ0aZns4d
         +gxBV+KHY/XArV6fatKXZVk+vShwj3gVKcvi1JNsp0XJU+B6bFggpB8VcEeDKWKRIA3F
         H9IDx9NXxJ8Hl34RfRfhZiO+qbvctBocM7AkvbiVq/fCW6rafkWtNbnL84Dea6Stqo4S
         Xcae6LUyvPeuT9+gDhLgAhxZCWG5wB4Cfd+DG6CFyxHzRgF4qOx1KoUT0/r4EuIRgyj8
         U91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290260; x=1722895060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/uG0RbPF+t6wEe0TF57sCA99ACL1gtkgDLZUWdqXsM=;
        b=iTvqkCefCpxPFeKrCxmPgS0sSW1/OzpdK+VWx9wJ6shSxxSV3wT9wDuC4+hqONEYfj
         Z+33zoevTn3w+cYzObNbrTfOqkGEAbZmwZXVC0NltS2P5pXA3RCavMUdnmeJLPFm3hC9
         qvlYyQxMyjBC3CAfGRyNNoGH8v2P0/Rf2YF2pJpP1KDqHTSQtfWFJZz8uceAZn3chU+g
         x+sZbJCoUoCMqlFWqZ0XtT1+RUgzOJ7Ym4qLfcanXmyQscVYo5vbL0SeLKnnn/Re4het
         aWWAhQLv6gaxwxXIa+FUCv61AbZ6JqTfT3EUp36ZwLlrBwrWIUt2WNqSQ3CO/KEFZ66V
         YV6g==
X-Forwarded-Encrypted: i=1; AJvYcCWskEAEycpQdWdYw7r1fKUHkgiZc7s/yorGg6YnIAJT2sJOr4t1VvJ5WCs/FvSqKGgwPmdDDDikAOtIqPOr4A6H0ttvOTLC3U3fYfO3
X-Gm-Message-State: AOJu0Yw1mXdkGgUAzMqG+uUf/lR3SzZCPDuZeQXAAmbxlR5iZJCTuHsb
	uKpH+ac9TMOA6jdaSiNeJWBIsR2NYOo3jpsSYqIi8UrSXT3QawiyMUyyOhs2+YQ=
X-Google-Smtp-Source: AGHT+IHwZkZt24czu8/lKOn2GWi2SUrhVTkh/FSI6AFzn2vEWdyOC7cANh35tDrGnaCxah8UqaL2rQ==
X-Received: by 2002:a17:902:f542:b0:1fb:779e:4fd0 with SMTP id d9443c01a7336-1ff04824612mr112584575ad.24.1722290259864;
        Mon, 29 Jul 2024 14:57:39 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff0fead748sm45010935ad.74.2024.07.29.14.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:57:39 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:57:36 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tools: selftests: riscv: Fix spelling mistake
 "regesters" -> "registers"
Message-ID: <ZqgQUKmoNrSAeoQI@ghost>
References: <20240729091734.42259-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729091734.42259-1-colin.i.king@gmail.com>

On Mon, Jul 29, 2024 at 10:17:34AM +0100, Colin Ian King wrote:
> There are a couple of spelling mistakes in ksft_test_result_fail messages.
> Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
> index 1dd94197da30..6838c561e4c9 100644
> --- a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
> +++ b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
> @@ -49,14 +49,14 @@ int main(void)
>  	ksft_print_msg("vl = %lu\n", vl);
>  
>  	if (datap[0] != 0x00 && datap[0] != 0xff) {
> -		ksft_test_result_fail("v-regesters are not properly initialized\n");
> +		ksft_test_result_fail("v-registers are not properly initialized\n");
>  		dump(datap, vl * 4);
>  		exit(-1);
>  	}
>  
>  	for (i = 1; i < vl * 4; i++) {
>  		if (datap[i] != datap[0]) {
> -			ksft_test_result_fail("detect stale values on v-regesters\n");
> +			ksft_test_result_fail("detect stale values on v-registers\n");
>  			dump(datap, vl * 4);
>  			exit(-2);
>  		}
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

I fixed this and some incorrect error reporting in a different patch:
https://lore.kernel.org/lkml/20240724-xtheadvector-v8-12-cf043168e137@rivosinc.com/

- Charlie


