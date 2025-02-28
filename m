Return-Path: <linux-kernel+bounces-539078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D8A4A09D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347C418995F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3FD2512E4;
	Fri, 28 Feb 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnHJQX6s"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5251AB6FF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764409; cv=none; b=uIGn/3i+DKiXznFHFJ2d3xqojWAMimb6TkFL+pTKcXYnNhLJgryJ97yffMXBPr4yInTDYKpNngdn16cpA4TMPFf1t1MpcJsr4jQcH7lAFDyEfGq5kKcc6+y8mzoyqg9AWnanux/teLHnwxIs7snATnpRwOXsj2+8iqZEOqJ81Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764409; c=relaxed/simple;
	bh=nhR/P/6U5t/QZbBIPrPO7uVnSy5xVoKPhPv0X5+5HOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTiN59Zbrd5zVPmpgHdx9UEnTEu8HDLwQNjc3knC3Pl+N0oyDVINp49Oyy31R4QuArCMWup+itBIbMzy2zWb9MyLHyrLFBpbUOAuycDtaNTBFqQLX6OJ5L106aJn7lCGPtboTDIjv3NC47SvAVPRdCaDVDIHN7N08nbyo+nOsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hnHJQX6s; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb7520028bso315503966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740764405; x=1741369205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=riQXDN9QZs6LxV8yAa+6lbOT9fE5uen2D3eotym0+Xk=;
        b=hnHJQX6sKwS1OP7pPdj4gNeTa7A6yZ5rwZ3mzfBqffAi7HTH7hDTozBSK+GYD6LgY0
         cTNOWAKS5cWueAKE9Wp5Vx3Pz19C5/ZCtOHsHV4Dbp87uK5pgH+9YjC/ejwzHte4IefW
         0Y0kK0CaFx8WOw0LI3d/WEXmwNoR4yG9j9GgZX8S9VdK0puUlP4wZMoNEDN5qhEU1e7P
         Oak99K053ONZEM3JCJMS4XkE0pVaI9N5z0OA/qFKJGTP0Qa899jQcKNNP+hJn3N1fFGI
         S18BQNejkEbMjSr5WMe70K7DfSk2bN/rbJPHiOIlWxfDbEwyfAl8pkQpzBifaMNNKyhc
         oJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740764405; x=1741369205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riQXDN9QZs6LxV8yAa+6lbOT9fE5uen2D3eotym0+Xk=;
        b=VQZynXf8AS/CUU2PnoWhtehqawWIrqIAbuJ95vfvzWniSM1DII8tDQISQAr/e2Wdyo
         bN9cA6+KGoMkKp2WA7qcrVHYLGNw5wXACyzhugaZIgptJxUtVwgJDAe7q4JwQBfDUU9f
         +GtBQ9ebsGMh8RwwGr9zaMbwospAPsn5N4+psZBXyq9P4diYZrNMGHZqRrCE0wp3vR8g
         E0fTbSe2PkTeWQw9Z6mzSwrblD+QBBvUdzg+lbjh24RE1AOi50d+EKLIiU9kGaWxXoqj
         BZqMDxGzoh8peSQnogV8Ys1SMjy0x8oW1SvyStLDTI9N9rK6L8iG3Ak3WvUPPtRCH4sj
         +Mdw==
X-Forwarded-Encrypted: i=1; AJvYcCXz4mldC9UOP1NybwKkfrV4U3NSa/5IuJQNsWC32LHhkwEdP2PxESlkb83c7guxJqYAJEMgOrnmei8yozw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6uvG0B3vOdi6WKTFE8tGhfZ1ho/tCoxZXY34JqiwSFCm57+4
	cXIkma/tG+NfadO9Mq52mX1SQr4z3dsmzHIItsgez0jgnu0/spAHU3lBUqAihiU=
X-Gm-Gg: ASbGncu1yRmM3Er8a9zuL+3Jr8nZQbGFlJlGjHK8EUmIB1VPpUU2lQF6k0FsmZDNu/W
	GmQvBt8y25bOSdFqNqkm5vFklIll2SX7NHJyPHLAupWG2QXP5lYVperFTznpE4pQNr4iSnPqdHE
	IjlJ2W790+SIbTokVaPxXATcEc+s8OhnmFYkEfDB1VoiQml9cOPO7l6l6C0D87lFK3gED6oZZRQ
	lnJrtNCJK3Ua0E+wfZE1j68NSqJNZ02pLtVJNgoaV/aow2ZI12yrJI9YpGWRQqNWdmDosbT2o0F
	nxq2wl6vzNOpLF/7CP5GjhchIJ/+Uvg=
X-Google-Smtp-Source: AGHT+IH9J6JKqMSthgE9WEHmeCIetbaaQ9ZpNXV3XeAC+1XH1Fo46T2ivFKqFX77iByopRqjkr30Kg==
X-Received: by 2002:a17:907:3e0b:b0:aa6:832b:8d76 with SMTP id a640c23a62f3a-abf25d95298mr449951666b.12.1740764404831;
        Fri, 28 Feb 2025 09:40:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c6ee4b3sm316011766b.112.2025.02.28.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:40:04 -0800 (PST)
Date: Fri, 28 Feb 2025 20:40:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: sm750fb: Fix CamelCase variable naming
Message-ID: <ba45d980-c6b1-482a-8bfd-457a92d3e24b@stanley.mountain>
References: <20250228162359.14029-1-lima.gabriel.luz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228162359.14029-1-lima.gabriel.luz@gmail.com>

On Fri, Feb 28, 2025 at 01:23:54PM -0300, Gabriel Lima Luz wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: Avoid CamelCase
> 
> Signed-off-by: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_power.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
> index 63c9e8b6ffb3..33e852fe6949 100644
> --- a/drivers/staging/sm750fb/ddk750_power.h
> +++ b/drivers/staging/sm750fb/ddk750_power.h
> @@ -3,10 +3,10 @@
>  #define DDK750_POWER_H__
>  
>  enum dpms {
> -	crtDPMS_ON = 0x0,
> -	crtDPMS_STANDBY = 0x1,
> -	crtDPMS_SUSPEND = 0x2,
> -	crtDPMS_OFF = 0x3,
> +	crt_DPMS_ON = 0x0,
> +	crt_DPMS_STANDBY = 0x1,
> +	crt_DPMS_SUSPEND = 0x2,
> +	crt_DPMS_OFF = 0x3,
>  };
>  

It seems these are not used.  Just delete them.

regards,
dan carpenter


