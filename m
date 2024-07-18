Return-Path: <linux-kernel+bounces-256465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A66934EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6162847AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED657140E30;
	Thu, 18 Jul 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEZVbq/e"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9002AEE3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311958; cv=none; b=HRdRXoiyH9ckvDYU+oxwUcWvAJ0kcTaMaa1XDExFPfA5Vbhn8b09RBPZuHgPegwP4NNAq+TiZampyazhyNj8kB+oj0O/piM78Z0G5UW4gH8cEhaXkDcZpyNOms9+W+AwuIGcxcA9sudNFtzl7pX1DmqwfBvz2ByNpwPdy6U+Cxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311958; c=relaxed/simple;
	bh=hiEzASeB10fNdaIpxw1XadKQUoRQLlgLlwTAxj43bc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeN7byoiDewFCsbdb3E+EI431eBWq4jhSjo2FQocI+AhlYVoIfzy1ltsnc1w2liK3PEH/T8j174zxRykTzG2zTVTnYKKs0GnqNJZFv+wI/4XPfV2x1El0FyRhaSuTN7A2OXoGdQwYbhmLdUDgQDhSLWK8VX7lMrvhbu4X0rnxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEZVbq/e; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70af3d9169bso654440b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721311956; x=1721916756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFMXWaNIqTAXV7kGU93gXqY15VB1HitSXOGrvoDOazw=;
        b=gEZVbq/eA15qqNWOFMURriTf991ixSjp5COxMKGKBqxcbD1Aoy1ucJ1UWr4qWGqBIi
         7MdYRj0mltvjuY/j/GZHzIsXXrfWN6k11WEJg53pHBHn6HbzhHdxmdFylNb8sYyq5PkP
         BcCkfns/Ikuwvw4A+/CprdjwQPAkz/z40MDXKGPv1sjg92iepNJvmnYHGtV/sODUUvL6
         DNr0b0N9kyhIfhixS7vAzE92DIFA/p3uizxXsOCjp+yKCj6FdMiyXX+uP0bX1FCYyoR8
         qNDV7S8YJ1/qfLkqAsQ+AXtHB1M8QMv/RoHPV1O47V20FAez3PfKxytGT01EYTSluDFY
         3Lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721311956; x=1721916756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFMXWaNIqTAXV7kGU93gXqY15VB1HitSXOGrvoDOazw=;
        b=Gjv8Cv4a/uBaiQTOaZzkWj8c/Z43ClPFlJVOvLIG8/ZNI1S+9yfB7njqFGL83hzm+e
         1JmAdQMPGphfRj4wBm0N4Gjz/GbWw29OdLYxq7e2Noxo8dVTBHDvy/Fn9n2dteEQIT9I
         ePAcK9W6WjYIzngSacXPunHMgvrZxNLsFe6USuz9z52nDkdUT6ti3jQoAQarigCYyRWp
         AUXZXvsVEjVISUls+zaLnr2cJgwKfkVjvNUdv12Dz6RHHOhiOTRO208crtk17sO8xUGO
         skRkkZnUXarCdI+O6TxM67QjGoEW3vroooFmR0Fj2rslogqVuOMusAz5ceJMlVRWVwcM
         ZQhg==
X-Forwarded-Encrypted: i=1; AJvYcCWBtiQAQFNL1Ou6tcKqVm1Gk0W4zwqUdHAiNIq1kyIjoJKwkdFiSWTsYYAkqwTS5xOzxY8ppKdazc6p+jSanN5y3KlsaBW/6B1puKbU
X-Gm-Message-State: AOJu0YzG+IFY+aYSqrmNk4uanvLz7fE+p5apXCHStcW5LnCDTF5arIjX
	s4MzTnlfupWFQnCOkY/DisVHAjk2+beFXvQXi++ceQjQcn607XM4
X-Google-Smtp-Source: AGHT+IEmCFmBg1tjU2Ii0ewR1LYNyJpwL7iEJVy4VVxNjNQi32QcbP53w182ILjMWIhfooCqb2fPxA==
X-Received: by 2002:a05:6a00:cd3:b0:706:6106:5565 with SMTP id d2e1a72fcca58-70ce50a9473mr5969342b3a.27.1721311956173;
        Thu, 18 Jul 2024 07:12:36 -0700 (PDT)
Received: from five231003 ([2405:201:c006:312d:e88f:5b9e:fc3e:8053])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb6aa1sm10084781b3a.77.2024.07.18.07.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 07:12:35 -0700 (PDT)
Date: Thu, 18 Jul 2024 19:42:07 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nishanth Menon <nm@ti.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/4] Do device node auto cleanup in drivers/soc/ti/
Message-ID: <ZpkitzRCeCz9RQtn@five231003>
References: <20240707055341.3656-1-five231003@gmail.com>
 <Zpg41yZRHPv9w0Lg@five231003>
 <20240718112134.txuimtlg62375jaw@musky>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240718112134.txuimtlg62375jaw@musky>

On Thu, Jul 18, 2024 at 06:21:34AM -0500, Nishanth Menon wrote:
> On 03:04-20240718, Kousik Sanagavarapu wrote:
>
> [...]
>
> > Ping
> 
> Umm... ping for what? for whom and why? In addition to reviews, I will
> need someone to do tested-by as well - pruss/am33xx folks..? Further,
> fyi, 6.12 collection cycle starts with 6.11 rc1 and I close mine around
> rc4.

Sorry for not being more specific.  Since the last version was reviewed
by Jonathan, I was wondering if he could review this round too.

And yes, it would be great if someone could test these patches as I don't
have access to the hardware - so RFT.

Also thanks for the heads up on the cycle, I didn't know.

Thanks

