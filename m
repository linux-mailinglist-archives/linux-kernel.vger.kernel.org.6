Return-Path: <linux-kernel+bounces-446639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AA99F276A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B97164E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106F01C3BF4;
	Sun, 15 Dec 2024 23:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtCFVVao"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28F1B3949
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734305040; cv=none; b=Y6uaHRE9hWCksEf6deOMfScZHnYpouZWL/Ivjmwe812wANvrzY39Kg7Bv0KHD3c+Yyu7hbvSqRUn8B1uQ7REbTP+cGwlqaC68H+NeErAX3ysxinOcO2kd7rSV33plTEuumdVPOwYD2YbY8XHWdfrpI1tU5dGfxUTZqRrMjR+SbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734305040; c=relaxed/simple;
	bh=h0FYrYATPQdlmulxPGcmaER2U5+TMtyT0/7oQz10eZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQDe4taBadSqWcuo+2eP0p5K44X6aH+az0tx53iplbsmhI1WmI/WWwEQNTXhWR0cTw9z19QG/C9e/6mfvixrqEJCdw5eDtAqxXchFpa+ogLWLPRxdVRf8V0nj3SRpnTg69PyrwXixgQW2/smmWYfzUbynneeVwQMYQyGSlh0IQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtCFVVao; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2156e078563so26073935ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 15:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734305038; x=1734909838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWWZuxEzXqbDg7/DsXgrSxhRT6PifOagMeAUD/7eOt0=;
        b=WtCFVVaoRKEAAMCduCY8aYFV+GN0b8qTySRGWIIiqeUyYWRpgS5ziMyuCGbtEQC1Y0
         ldaEV761uuWyGHDZZ9x1orh8pJ+ytRdvJs3GOdp+L+IrmdEYNifcSNPC/f2bZJTeB0PQ
         kkObjUVMuuCZlh3VK919x8eaJ6MRmtas5uS8AJliLAcdKSehq92i2XSL5ch5rZMlHzYN
         ZwtHWdEuls4+WZVnUZP3kQOYLpobTqwVamZFZQMXuZRfj8h/WsfBfiEpT5BITf6pma2W
         hhlLizPpmGtKuF+T1WpTCrfgrqgnz1VVEhQ2FMlyNUHsub1dYeKnSZGH3rb+DdR32/ee
         M+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734305038; x=1734909838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWWZuxEzXqbDg7/DsXgrSxhRT6PifOagMeAUD/7eOt0=;
        b=a0f6usyevutBNu/Xui9NFPOOz4OlOnuC7+fNAeVG+O/PMS4Rolo3mp0vPzuz0/Ek4w
         l6lGaAW4inhhm1CCTDyHo22EXeeVoM9ZULZU1amHnCPtetn9eA168Hkg1M8R2B1YeEod
         SedemmyXdJAdVOy3qfsq7YPtO+BCzuTNVQT/YFznM6hjCVE5JIdJ4a6LM8pno6EiteQf
         LrcCcj9Tn1k+P+xcWuTmD1DnYbOrlEwYoEQ+3GpqyE5zBBO8E4FQpSp1WbrC25FOEW5J
         c3O2sfdOuUPzdtXj9jkGE6o/BW3c/zTTwYC7YlHyvjYopVuVZWMOj4b1A3JVUAOgRr3v
         6X7w==
X-Forwarded-Encrypted: i=1; AJvYcCWjPap0RrJcFZFfVYO/whbEC1w/8+ldmk5mk7RX3I+e6XNPy1FGGXoZp4xRvk8sCRTayQF38kgxBRZhxW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfiKp4CS6Hyvgo9UW8kwzuS/E35wwuj/niXORv+DfwlXrGLNXU
	a927LcAb5JZ9SQAHAM6SOxyZCbg2Nv42GNoVFdXbR/QVQbH14LGNoVWfKQ==
X-Gm-Gg: ASbGncvcvbru8Ouj7C1lOOX7gaTWpyc8cIzRuY6C+bQtUIAmRsiSavNpt3rdUYs8OpM
	aPx2N5u05+KWKPHanNBl7F5/j346hPQnes1iB3w0EkDrjH/TMgzSSEYgFfKVW8RqbUsinbZuZgW
	mskr4Im4i1Fzwd26cBVYdf2osc+912t/ZLYLJ23D8DNSA37/+WpAY/FVFT25R4XG8HwFuNZyxtz
	7NyNDnrCrquaPCsd9pCZoXux8HC4X5ZJ49pC3MaM+vkiGtFOBKX5qjtLktl8Zg5x2cvVA==
X-Google-Smtp-Source: AGHT+IHcFri9lc9NhsBUklSUjNqdUKX6evC5mOSz6ro40NIxE+FHD8rBUZNEsndpRhsnA81fnoOyqA==
X-Received: by 2002:a17:903:1c6:b0:215:b18d:ef with SMTP id d9443c01a7336-218929e8849mr147905365ad.25.1734305037965;
        Sun, 15 Dec 2024 15:23:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e65461sm31001025ad.238.2024.12.15.15.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 15:23:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 15 Dec 2024 15:23:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: [PATCH] staging: gpib: Workaround for ppc build failure
Message-ID: <b6102c6b-693f-4237-8c0c-83c5936aab3c@roeck-us.net>
References: <20241204134736.6660-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204134736.6660-1-dpenkler@gmail.com>

On Wed, Dec 04, 2024 at 02:47:36PM +0100, Dave Penkler wrote:
> Make GPIB_FMH depend on !PPC
> 
> Reported_by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/all/20241015165538.634707e5@canb.auug.org.au/
> 
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>

This patch just exposes other build failures, for example
i386:allyesconfig or x86_64:allyesconfig.

Error log:
x86_64-linux-ld: vmlinux.o: in function `fmh_gpib_t1_delay':
fmh_gpib.c:(.text+0xfd49dbd): undefined reference to `nec7210_t1_delay'

There are many more missing functions. FWIW, I don't know how this is
supposed to work in the first place, since pretty much all gpib Makefiles
say

obj-m += <object file>

meaning they won't be built with allyesconfig. fmh_gpib is the only
exception with

obj-$(CONFIG_GPIB_FMH) += fmh_gpib.o

which means it _will_ be built with allyesconfig. So it is not surprising
that it fails to link allyesconfig builds. Actually, it will fail all builds
with CONFIG_GPIB_FMH=y.

Guenter

