Return-Path: <linux-kernel+bounces-235789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9691D9AD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7A628540E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12A4823AF;
	Mon,  1 Jul 2024 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WH6ry1g+"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8054347B4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821291; cv=none; b=T5m+VB2h1uBLuGDEk8WTo8OXgQiIjVpdEfDRFC3O4TlOwOoea5K0eC22cVXpMGlQk++a50nf4yn5K3jdRe2XcZzBtN1k8yruz+W2wxcepgBxGJFRK3oWW9SbZV4OnxX7O6a3vhV23r83qO5j9KT/F5IsV5gI/k5m0cB4L1vC1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821291; c=relaxed/simple;
	bh=VPRkoE3ztljhYb2mUym0oBvK660ieGuSjJxUH6lVx+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVLy9uquOVy8XGahPIXTxUKzJTqv42N288kGE7VUpMkKYGkTVAGhFme0SY3AqugYK/UKz8vznGtIHMo8ejFY1a9o1gU7ObJ/8DZV3HZ473Z7N1KYFH/UN6ewMtO999AAnCIi+la1ZgPRjiI+2uHv3UR2S4Aen/Vs72/eM9JnQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WH6ry1g+; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4ef765e6dcaso763640e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719821288; x=1720426088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aSwYtSpfHiZc4CsUqleqrbbtIAk9e+BSHL8NQ5ures=;
        b=WH6ry1g+7aGovV9XFLs76HAQpAJfjStMaRjcZjPbDPOwlONnitHuJ24s9Tqh/a0uAY
         odmIsU3M1p7/x4KMkeuuZWIMdxBvFzrsbiB7sMBZLSwVNIcpKQE7bXSno4bEvMeX5T15
         Qd80jqz+vZOvm+LeRq7Zcf9KW94w3FihKXST8E5rLuA3IhtDq7zQdqmAEkAAEU5AWhzo
         DmPyWA/HrwE//9qPjg3hCZCBhT56J1wWpu6Xf1f0pGJXN7qgm2hvIAs5mqCYAcktHP70
         Buavt7xTwyMOwuicGxQ2toMZIfOfMDtiVpcJpc9y/1VmMnwNMWcYccuBR85HZariE8PM
         h+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719821288; x=1720426088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aSwYtSpfHiZc4CsUqleqrbbtIAk9e+BSHL8NQ5ures=;
        b=pdERLQHYgNiGcLg5PUf7biuhwKiXuZNW2PxfMHACPtXwxdHxHLqgBTRGNtZBadA5hP
         y3ldmTpiXTdH5t4DKjpx07AYxQmdi0tx1JcN7bhD50Rkvk36H6i6HSD18JPFaIsFT3Sh
         oWrwrN3sIbGLgbddNnEJnr431FIKCkUeAxb+9GyOaSpVtiUtvsa+EjuhcPS36n3N5eFc
         64QgnMNEf63bGZGv8fXRHj3svR/tpm7FQdy0mcaBUdJv8fG76lt0Oxi92uNJ2sg6II90
         MBRPFe0zJ6VSKhF4SZYamCGMKdXP5lzE+aUJF3aDxF01ZvIqUlqqxrM8xttqXyIB1LKK
         9Bmw==
X-Forwarded-Encrypted: i=1; AJvYcCUYCGtSyZ+43nqmphlc4AfMvwWG4Bh3a73xIzxeYaN634ck6S8v9d7mdjVGfGBZwHDHPRRDNPJGvpgkrIrwfhv1KpC8MV48VWHLZZyC
X-Gm-Message-State: AOJu0YxcXYmJ8AiHi6LqGHInnmBOFKJVOpDp4Gl4prNoabGm1XcI6P+j
	v2Uv+W3/mD3lAfrpcNFprP3+O4mbFDCdDU2C+JhdSyimxJoCFCHzvI7b/RS25ibJ7Qaj9ocb7pb
	jk4ONhJdnkVdlQtUAX463gKeSi0bT1HutR+RM
X-Google-Smtp-Source: AGHT+IFy0wXG91tZbiAf8hSc4kA1fz73JufSo3AsicBjchsYn+XC8+nuxiGgboitMYwn7yXgLuAcqQEtRy0zMy9Kcfo=
X-Received: by 2002:a05:6122:4014:b0:4df:261c:fc0c with SMTP id
 71dfb90a1353d-4f2a56f27e9mr2234065e0c.13.1719821287938; Mon, 01 Jul 2024
 01:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630200135.224108-1-thorsten.blum@toblux.com>
In-Reply-To: <20240630200135.224108-1-thorsten.blum@toblux.com>
From: Marco Elver <elver@google.com>
Date: Mon, 1 Jul 2024 10:07:29 +0200
Message-ID: <CANpmjNMXOn_N=9CY2iGLC=r=FAP4J2EFJbwDsAEuhKydwh6wtg@mail.gmail.com>
Subject: Re: [PATCH v3] kcsan: Use min() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: dvyukov@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, David.Laight@aculab.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 30 Jun 2024 at 22:03, Thorsten Blum <thorsten.blum@toblux.com> wrote:
>
> Fixes the following Coccinelle/coccicheck warning reported by
> minmax.cocci:
>
>   WARNING opportunity for min()
>
> Use size_t instead of int for the result of min().
>
> Compile-tested with CONFIG_KCSAN=y.
>
> Reviewed-by: Marco Elver <elver@google.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Add const and remove redundant parentheses as suggested by Marco Elver
> - Link to v1: https://lore.kernel.org/linux-kernel/20240623220606.134718-2-thorsten.blum@toblux.com/
>
> Changes in v3:
> - Remove const again after feedback from David Laight

I think I was clear that the removal of const was not needed in this
case, and my preference was to keep const.

While general and _constructive_ comments are helpful and appreciated,
this level of nit-picking and bikeshedding about 'const' is a complete
and utter waste of time. I'm sorry, but I'm rather allergic to this
level of time-wasting.

As KCSAN maintainer, I'm just going to say I prefer v2.

> - Link to v2: https://lore.kernel.org/linux-kernel/20240624175727.88012-2-thorsten.blum@toblux.com/

[+Cc Paul]

Paul, if possible kindly pick v2 of this patch into the KCSAN tree:
https://lore.kernel.org/linux-kernel/20240624175727.88012-2-thorsten.blum@toblux.com/

Many thanks,
-- Marco

