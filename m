Return-Path: <linux-kernel+bounces-401563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D9B9C1C4D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0451C21451
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B73F1E47D6;
	Fri,  8 Nov 2024 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9J3z4l0"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C631E231E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066093; cv=none; b=a6du4pdR4+zSpHB9A9MBAITOKhfDgGAAIfKiDPklm3MPbv9HrZWvjJpqBJDGhd8HeaI3HeWTJzRS1Sz4zf7gNWGDCVQz+eRc2+teW3JS1JsN3cYA5LjLQd6cxmSoQ3oBv+QafxSTFW979bt+CtCZXt7jSug5sxQLndpDvuV9cmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066093; c=relaxed/simple;
	bh=uY/iMbf3Vk3sXbHtDhy0LKeHEHnsP2OiGaIvmYFRXgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5VvNtci0kqO54FkDXoPIucaAZlrA0SrZeAlgy/am2bkTS4psmjZMVICBdpih6syRAXN9uBkxJH7sfoOHGGkRSy7X4/akWvLff/kOcxRCjOizZ++mpYb78CjtuHXbVz8cKbKZkG9zjFiBi3hMS9YBAcM3B9IO8uGwHkup3sQrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a9J3z4l0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb3110b964so17730311fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731066090; x=1731670890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXSvbTMRrcj6fCxF0ufHCuWCloLz1hIjGxoKK8AG/+o=;
        b=a9J3z4l0gQ22XqiiITIYecjr35fLofBoZvgBO7N+b6NvoZZDkfnHXnh2PJ90jWz4R/
         xuyD19CygiOd0ckGrogpy+ilK0Ory6CtaNf8bZ7aZC5sTraayqFYtF6ZeLCP5k0fzArx
         f/hNZwT19GxlGUHPXCGTRysPHAxs+JH815+7/5RO0ODPE3jAXRGLxZaWEowT/xlHupgH
         0K9UVt9FpZZfzmsmtomhtTvGFOUfRyFB4KNnVZe4uufFfuufZPUhb+Waoy29wbWI3lbe
         m8Pnsk3CUT38O1ff4bbMR8f5blcDcjLUSE6dFvivDVoIJdYyaPpZHsI6AbsqBJHSvWLc
         rHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731066090; x=1731670890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXSvbTMRrcj6fCxF0ufHCuWCloLz1hIjGxoKK8AG/+o=;
        b=KedHuMCk7MEkc/DAjuQyrLCUu6V0S02Fuvp851CMkadGFDcMm2INjIWmimWtQip9Wj
         qIqQOppGfRTrVP4MHxFiX/e7ENgbtqlCLbVzjaLN3bLPnH6Pu57vgyk2/lTahkGpeJ2B
         LG9LVJDFKVTQLFL0qh/DIfGYhNYQ2ZroHSUy8TTcad25TPYBJR83y3f6uous+R3gy/I7
         YCArRvoiy3LxAA1aPzxen6LWBKKtqBm+bpwY0/gBofoVOGxFFOGJl6PdH9y3XSo7c9rv
         51XBOgMK984bmO7E8mzxNZbYNiMg5bokSJlGAPrKV2zh2tX3bSgOd0pngF5aAKy/LFMC
         a96A==
X-Forwarded-Encrypted: i=1; AJvYcCWTDi3wt01mM/OpVj3WrDIEPFgULFEuubYUZxGL8UAF5rHsPKAIQCkVj2FbVySPJdg6YYI2mFtQo4QQKOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxapuOfKd5fXP4ahrzn10Fvh7rv+euJ30aDxDK0TRlV1AbPmzmf
	AxtdPGxmk3AfZk8GnfE2UuYr0F51qoLZfpljRQXYWHC+1spIEjT35VtOhdt0QKs9GifL/HvCgdc
	AvOUDF+P7adcUMiBMJz94N7LG37aqOKoGsKa2ojNONuUuhX0RXTc=
X-Google-Smtp-Source: AGHT+IG6dsbVHDy06kTkj5zAs70A2/MyWRJqE/mKAm1qvOYLwYQg1hL1cr+88CsDKtRlIRo2uCMtTHRVmKF8kaDiYQk=
X-Received: by 2002:a05:651c:1515:b0:2ef:243b:6dce with SMTP id
 38308e7fff4ca-2ff20185abfmr11928261fa.10.1731066088370; Fri, 08 Nov 2024
 03:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410301531.7Vr9UkCn-lkp@intel.com> <CACRpkdbW5kheaWPzKip9ucEwK2uv+Cmf5SwT1necfa3Ynct6Ag@mail.gmail.com>
 <2010cc7a-7f49-4c5b-b684-8e08ff8d17ed@csgroup.eu>
In-Reply-To: <2010cc7a-7f49-4c5b-b684-8e08ff8d17ed@csgroup.eu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 12:41:17 +0100
Message-ID: <CACRpkdYQ6Pfn_Y7FJh7MV2Mb8etDXFCJEUrgq=c3JDxkSPOndA@mail.gmail.com>
Subject: Re: drivers/net/ethernet/freescale/ucc_geth.c:2454:64: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: kernel test robot <lkp@intel.com>, 
	"linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, netdev <netdev@vger.kernel.org>, 
	Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 11:30=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:


> The problem is the __be16 in the function prototype.
>
>         set_mac_addr(&p_82xx_addr_filt->taddr.h, p_enet_addr);
>
> p_82xx_addr_filt->taddr.h is a u16
> and out_be16() expects a u16*
>
> So the following fixes the above warnings:

Ah you are right of course, thanks! :)

Let's wait to the big rework you mentioned to land and I will try
to remember to revisit this in the v6.13 kernel cycle.

Yours,
Linus Walleij

