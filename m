Return-Path: <linux-kernel+bounces-273606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C251E946B66
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35661C2132A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 22:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03978289;
	Sat,  3 Aug 2024 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGHCAvI7"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA97134AB
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722725728; cv=none; b=pTW/WI444S2J54FRezlCNWsxi7DBt4U6ak8kWSjLTJuUpSttnvEQzbVHKgSyJZJcCzYFuv1saCgMx+f2k4QFjzc/kK6tslxVADVHBeMYVfrsIKZxWE0elfLxocT2qrjArWwhU2wbHkywdZneiSQ2n+qUTllp/TqFHmCfu8AZZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722725728; c=relaxed/simple;
	bh=Ob/lgOsw4tVEVWt237mcmK9/mG+RUXlFuY51d9q6PC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjzVu5wNPcD+6jUb+769wLRh3K+ApNRtzAGrPunIjcEu4l7gFMC+eVIw0+JbfaYVD0lkwdp46KoE2pAlccoqVieLHMJHR8t20q3a9Yez+alPKQyAjm5u/NkSbT5igScNhYhup/gDbQwR2cHdKzxtc6XUCOuxqKZbzn3k6CcOqJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGHCAvI7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so138370881fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722725725; x=1723330525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJvTkCcKGogempzQ6AS7OBxpnGmGQsGSl3kzHF88S1M=;
        b=EGHCAvI7A2cebhDXJrNuBzO5UyiJy4WR5vy9W0gLgAndFDIGkjvecnFO9FfXzEmmU8
         af3RcWN7XbXe1RWhFCgrntnqdVPqUX5ue6NQV3hi8AT+ArT+Lo1m6CpuPf9YMi4pwhQT
         vNprEFJd1UXaIjilxvnmiNz5ZhEpUyoEK2ZsV5EJMYzHbPBL7i9V1jO3iBt30YhHexrl
         /PBmNzQ2svHoKMe997810d3phnuXK07Faxsl5Cc0vWsoap6Lzl4aU6gCIbl7N8O0bT8U
         6wEJO7TpoenkZwaB6MRGE3N/I7ogfh8DxBsiu0YSof6FPohL3zOjH2dNInhh3mRaNmOc
         j33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722725725; x=1723330525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJvTkCcKGogempzQ6AS7OBxpnGmGQsGSl3kzHF88S1M=;
        b=v6kkGTTyYelvJGzsXIuRMlJxLUwvqWVuwlUS+EILowDALi/EJ2EcIr70CzI7pO1ORc
         j+ijz81MpEOJ0xUOpNlh8352SOiz0lIQE3CpNrR7vohW/z1U4xovKNJawzqn3Gstcrh3
         2lBJpQWSwB1GN3bD5QfAsPjdE09FakVM67u3FW+o4y+7j8mi5/AOlaza6RiNUvpXNqQ2
         vDI07me7+r1jiFh0tezkJv0vJlI8N/yh/76uLbxQjXFrcDay89l8nva81VEehm9IPL1y
         GGf1Mk+x519l7NIwXSEnfvuMQ5BkNnYg5cYVBHh8yPHL/1qFToePZaM1j9SvuvJRhQYq
         YaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSM6Kq3Oi1GJa67uhGMo2JaiNexHF8wB5klv54f/igKJ37yHRv4vIj5H3KZSwYRtqP2m/JrH/LsWClqolL7aMI/DliDd0ZnNNW9d5s
X-Gm-Message-State: AOJu0YwLPJwWWmvgK54FdRFH0R7IQ0x2Ki2Xj97Q5jxHKLap821+U70e
	EMz9ZFHEgxd62vTDcSKAhFR8MH6bEFKTaLUQzC2vfcPY8nTSHGOAHVS9PLIcdWLUFa7KYzslBiC
	5f0tNiS4erX+majIAtoYPng3ynodVO3Jff/wB0Q==
X-Google-Smtp-Source: AGHT+IEdpC8eTuC8LLUHFYijYUhuKdFxFgzp8L+Y5p4MBOQ0osrXIKeUIAiXufWYWdUQ/kpYHVGFuCg9ELi2J9TaDT8=
X-Received: by 2002:a2e:730a:0:b0:2ef:2b56:36b9 with SMTP id
 38308e7fff4ca-2f15aac1f60mr45347171fa.22.1722725725043; Sat, 03 Aug 2024
 15:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR20MB495346246245074234D337A6BBAC2@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB495346246245074234D337A6BBAC2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 4 Aug 2024 00:55:14 +0200
Message-ID: <CACRpkdZT1VH4isc-LCoMOMrxYM7Qr2auees7J7JwNDvTJ8ARyQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: pinconf-generic: Add "input-schmitt-microvolt"
 property
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:23=E2=80=AFAM Inochi Amaoto <inochiama@outlook.co=
m> wrote:

> On Sophgo CV18XX platform, threshold strength of schmitt trigger can
> be configured. As this standard property is already supported by the
> common pinconf code. Add "input-schmitt-microvolt" property in
> pincfg-node.yaml so that other platforms requiring such feature can
> make use of this property.
>
> See the previous patch discussion about why add "microvolt" suffix:
> https://lore.kernel.org/all/IA1PR20MB4953BB6E71CA3216E652E8B8BBA02@IA1PR2=
0MB4953.namprd20.prod.outlook.com/
>
> Changed for the original patch series:
> 1. add "microvolt" suffix
>
> Inochi Amaoto (2):
>   dt-bindings: pincfg-node: Add "input-schmitt-microvolt" property
>   pinctrl: pinconf-generic: Add support for "input-schmitt-microvolt"
>     property

Patches applied!

Yours,
Linus Walleij

