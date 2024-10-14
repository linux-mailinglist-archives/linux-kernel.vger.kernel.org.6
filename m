Return-Path: <linux-kernel+bounces-363529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B599C385
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714A0281723
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B2814EC47;
	Mon, 14 Oct 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iTmhk7/q"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E514A62A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895031; cv=none; b=QbQGGFKCIYJFeGJPtTB2kX+1MOffIP6XGzuTc6qbDyq888Ag2NBJhEC3De96HPSk7xL/HLZ2KUaxWmgSqULIuswMS3yBO6CAM0venX7paJ4TAOZJ4XpDhS8bxOILiMPESeWmJ5jxseGyP1l0fP/Ljx2NW/aRK0wfB5OMGEqi8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895031; c=relaxed/simple;
	bh=iv8PlZLe++xkk0m32dJ0EmQo0KOn2VYLdArmI+nYxAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJTFeFr5E0GyhAol8xxfu6jOxyyEsu9Bb3ZtjbxNVf5AvcOKPp/sL+DRlLan8EswW2yGyJWG4b0AwKAX22mh4PcBTA2K9F8QEkdhBf4HtDopckylsDgKbsacsLLKENP61jf0KOnE1nlWnsmqCoBAMCRRpQ9a/82ELLE1Pi3pKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iTmhk7/q; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so1348881fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728895028; x=1729499828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iv8PlZLe++xkk0m32dJ0EmQo0KOn2VYLdArmI+nYxAw=;
        b=iTmhk7/qw81o6OQdTc7Vd8tni5SBMVU4JIFFKqX8BgQgjS/QJJzYlF2mEsL9MVg8Kp
         E0MdPULACVh1nqjT+qtnOCeo8yfpluY9HhLSvepcdhFvD0N8m0wwbkqkeoJO41rZ3EQA
         D+yygDRAztGdigjPeMdzCTKsLjTbdtEZxwpcBl4Akbyp3X5QPRgtIWOVOKIic0w0GFLz
         Lqd7uNj1wepPvrp5JDQItPsVwlLmYRxgmQqDiOnh1MAtOSFpT1gynQoP9xMGaufXz/wE
         2V66pSYAq0GO92WRBi73GX8wV/8A4kIJLlHHwZiXM6hFJSbe+FuvpTRzjmkHsWypeaVH
         9z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895028; x=1729499828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iv8PlZLe++xkk0m32dJ0EmQo0KOn2VYLdArmI+nYxAw=;
        b=tLIuJcXlToVJr4vcyCqhvMNjSjFIWLI0Lxz2W4+OsA1flvcg3T9AFN9R3p01Mnnhk8
         6mKvtDnUJcx4YceZ/n6vP83ye8z4ZFAaGVec0C8xPOv0AAsaE3+OrFXqWq+G0HQCtj4p
         LEgQwCQgHgm53Ms+bQPLjjY3AYFQtYC4dxMA5yKYkf9LNY1w6Td7Q2PwnYe9zI88hqH4
         12JZ8U2MRWseSjkdOQjZKeXMALmvA2ot4oyWfuVTUyfKw+B4+z6FxMidngiWIke9yn9h
         qFOxFKskwZzpJB6QHnkcWyAewSuXmG0l1yUuz1uchOJVXtsKt8WL8S6DrPuaDVl2zXFw
         Tevw==
X-Forwarded-Encrypted: i=1; AJvYcCXDbIEyH579Ft0kRjW+Ouy8rNXKE4vEXlqMM4UDthjjETMRgT+pTsELerJ80Pc1DWXMBRtQrBR+et2GoBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO26riR/nM2Ba1pnG2IXyrPjrz3W9lpbTJcXQtEVXXF9G0RxhZ
	9A51MVuIK8tiCIDjmxqVLDNIKz9AzADeu93ee9NJSxD0wFmetSEHAhFEzgR47rVeN4Kdw4HPU0j
	RRlDOrulXSw2X4vYRznfUVMk9kf4hyz2VcYmJqg==
X-Google-Smtp-Source: AGHT+IGmwX4RUF9yi5GZQf3FK7ogVT2hx77a4BAjx/AyRr9zcJ5FNCqQj6Ns4j4UPtygQNm1AUkTia8xfUs9MVDiPKE=
X-Received: by 2002:ac2:4e16:0:b0:536:554a:24c2 with SMTP id
 2adb3069b0e04-539da3c5ee1mr5336025e87.13.1728895027606; Mon, 14 Oct 2024
 01:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930080938.12505-1-brgl@bgdev.pl>
In-Reply-To: <20240930080938.12505-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 10:36:56 +0200
Message-ID: <CAMRc=Mew5uRyWZvtv75MWRKxqgb7qbyrYxQd9hXZ4-b0ZHGo_g@mail.gmail.com>
Subject: Re: [RESEND PATCH] Bluetooth: hci_qca: use devm_clk_get_optional_enabled_with_rate()
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:09=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Use the new devm_clk_get_optional_enabled_with_rate() clock helper to
> shrink the code a bit.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

It's been two weeks, gentle ping.

Bart

