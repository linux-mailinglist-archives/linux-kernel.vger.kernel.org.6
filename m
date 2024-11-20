Return-Path: <linux-kernel+bounces-416305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E2F9D4300
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966FEB29A01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5171BD9D7;
	Wed, 20 Nov 2024 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bbCw2Gej"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D939C1581EE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134291; cv=none; b=GJQBQEe9QkQpBXQz7wyd5KPVDw342aeNUE1veGTsEaVf3JuvB7B3rKXhRgxRULOCQw/QuqlKWvdABjef386vqyvrRpza/mNSLV8qDGD4j/dDA4pzYpdqIh5HBll9ma2Jm+xa/6xtltw4cpF/hxgPCEfFVs7IPsckEqeY6c83dTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134291; c=relaxed/simple;
	bh=+rDU1z69SalK6JzR8mTFd+A6eY5KNtddrtHed7iEQks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fA7giBYdPcrVBGP7/NNUufYFbLdCymsQPC/ODQGxAf80DBP1dijPCLkTJXOJ9apPVcY/agHZjOrkyMh9UQd2iRUvyY52ebzhqa9ni93YU7QWLFhv7ErVNnRPqw8QVWKT3oXMPoUw5hAr5GFAV3QXqZVOX7duyQIS3vcQWy6+pIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bbCw2Gej; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso29516966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732134287; x=1732739087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg+6xm5brW/79ZZOgxi+hS8YyznFJJFaoQ16T8rJB3g=;
        b=bbCw2Gejs3vwc+2M6S7nHlscp+CH3UkD8FYglZztXnWVbhTWa+7SSsHAVWq12KG9GT
         jenjCqKFlb1iOQKNKysh4ZmK23tIMfriQpNF2UN8eeuW7TyeQTMlDRmJNsOI8YHKUkkh
         kpw+JfdpZThczw8U6sZOWnvuT15vtwFt9g94g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732134287; x=1732739087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bg+6xm5brW/79ZZOgxi+hS8YyznFJJFaoQ16T8rJB3g=;
        b=jbVlXtunDgtG3rTJE+yv+v8Qiz7PP9+2uhsmt/APnOKsDJ4//bc8ZNcQtfs3dwv02W
         6fe1+WPWCLNnNuQnQBQafARnRY6Q6Fga5kBlhF8O97jwdD4/eO8PCQIrc5rP31fP0sae
         BDimjk5T/zevdNIPmlRbBVDWzoPkxZWLJOiTAI86EcONXBjvrkqpeBcaVeo9SJP+gu+b
         JleufiTFBMD//5Lm95SdqthtHeMmvPgKPVHq4A9dqSJolsWpvZ5mU0xwsNhz/e2jsYOY
         YcnH41lHlJWDvyM/OVHTGxPyCnSuxgJri2xSZ5ewGC2XODvex/RVYXl5UKBBwConNSoI
         zp/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUa72NfUViq1+/QFpnLz7jyqoYNFiqQAabJLqUIAv7Y/H8Z+yOTP6DBR78CVC6kP5hcaGkssNx7RvUn+sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjqk418GLSEeDzj5HqnWVSt6GT9JA/wKgiUnRCBuCiL9X5+Gsd
	X1ptUhnEcXZGzbZuwtXpghR8oXxpPkjUzUaV4AQNgKEbg3cIORl7J9DtpAOnX0HAzlhYAKFV9qB
	LC54gSw==
X-Gm-Gg: ASbGnctABDF5CEUl2KrhPZKDsRX9c+Ke148BLz0fALiO4DrabR0tzVkodOvdRkS4f14
	v7Mx2xagKQ81dSMq10YJifaC6Z4RlC3TccdmTdXQoF79HmAcsQcU0nOrb/6mIeHLMXKECO5I6us
	dJyTj+U/shh5F+9v0l7bw0B06niSpgjJCtoLFug/kgfvKqzhwsun5wiiTfqW3TUzZl3r7+KCzbx
	RhhFDv4rKj0gvrsrFQ+gwZJ4Jr6iap0x59RSv/UmrQ/RqV8DRxWx82WrxKzwo68FawMhAeirK8k
	wMdRGrsgVaqkngDx4OzhJtVT
X-Google-Smtp-Source: AGHT+IGTPFdtLwJhvX4mxXCIyF0+DGvs7kh9JdzGYUKowiLGoLlJ0u75SfUhwcjAf0XQQSgrAdck9g==
X-Received: by 2002:a17:907:3f86:b0:aa4:c721:fac0 with SMTP id a640c23a62f3a-aa4dd70a23bmr371589166b.40.1732134286855;
        Wed, 20 Nov 2024 12:24:46 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e086063sm822512966b.189.2024.11.20.12.24.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 12:24:46 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed49edd41so30335966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:24:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQF7pq+P7D9c8YwmadUxD6hMQ3xHa/HEdNdeY8NWlCdDdFfXqzyKkoN4t+EY8vYejT4gmL8btBxtfhl/Y=@vger.kernel.org
X-Received: by 2002:a17:907:2cc2:b0:a9a:bbcd:e63 with SMTP id
 a640c23a62f3a-aa4dd54842cmr423495466b.14.1732134285864; Wed, 20 Nov 2024
 12:24:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1c6bb542f52ef9a8428a0f35dc21dfc7.broonie@kernel.org>
In-Reply-To: <1c6bb542f52ef9a8428a0f35dc21dfc7.broonie@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 20 Nov 2024 12:24:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9TZSLX0Dtbh5_oQK7temAjQCScVFnEY86NYSAO83pQQ@mail.gmail.com>
Message-ID: <CAHk-=wg9TZSLX0Dtbh5_oQK7temAjQCScVFnEY86NYSAO83pQQ@mail.gmail.com>
Subject: Re: [GIT PULL] SPI updates for v6.13
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 05:33, Mark Brown <broonie@kernel.org> wrote:
>
> The Rockchip cleanups

Ooh. Cliffhanger. Continued in the next PR?

            Linus

