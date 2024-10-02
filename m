Return-Path: <linux-kernel+bounces-347579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B540C98D5A4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAEF1F23152
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA481D0BB2;
	Wed,  2 Oct 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irIPf3Zl"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9811D0B90
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875917; cv=none; b=XoOKvEV5prYU0jIQQ7gqDH8FQ3mfMDZv4FRktDEw+GJHuU08bkDs+Fu4ZyYmgu7p2By8rYsybSzh+XCgJBQuMQOWm8sgG2Dxxta84T2WDfBOSbImXsl+Kak0dTtHEK9zfEBZvzi3XsWdJMK7TGdhWb9qiPUR4m2a+5KWitWkEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875917; c=relaxed/simple;
	bh=GF+FpjmHemMSnoXE4oxTn/O6oroaDnMhtkRnkeKXo/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rj9jIg3hgavR1zV2AuV4IyDY/lS0HAM82GMlrsNT5dmwJXfRb6gNpxbNXLi6tCve1MNR5g0xpVyEUqsGo3FO5LneRiLicz9fr178LXUtt+HDev/5LJcQPmIbJc4Fkemg/FjQ5oxbpGysU5ruNR9st9cT0aKL+ocrR/lyu//ivXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=irIPf3Zl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2faccccbca7so31354591fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727875912; x=1728480712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF+FpjmHemMSnoXE4oxTn/O6oroaDnMhtkRnkeKXo/w=;
        b=irIPf3Zl9QOmEXjCo/eoBcsLVJRhtAE/PGxa/wu/xTLJ13nUDCB6CkdI2o5/b7KhVN
         jxoY6OHMp1FUg+xOCNXoV8/StHFa1fDtuwgP+SP6bGlXC7LiT90V0uL3ja5UuJ4tmRmj
         MI/zKseM76AODqvLMgvHP7w+e8k5tK7Pv7gyXonMRtBrFJsf90ACyKHA6A9z+kyOQs/S
         k4QQnig5Y4EuPC/3TD51lTh7skLJBsX5NiR5k5Dsm1dnMmeLaDviD9cBTmr1b2d0atoo
         KrY1o+VzZjphgs85COEr/B3IKMZwsxGhtG6MX4frrpUvnfnclotixrP0/bRpRkx8Doqv
         L4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875912; x=1728480712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF+FpjmHemMSnoXE4oxTn/O6oroaDnMhtkRnkeKXo/w=;
        b=twbvKM/jIAr+Dio2w5B54uCG9IkDkBtMDDiYnYFEipOeeJzJPnMMIudcbrg5yBFFGR
         dvC9d4oIuJxVWFyWDjAAj88Q2fWaFf2SEHxg4Xg7i4SojRREn0y6pptmCSNBtqeJtdzd
         Hp56pQqzthol5PBJ74pf5PdU2k469JaylybIUncqCLJwNC86ZierPZJyLwukemr9LMs/
         xNA6mSLAClzRqOmS6I9j7S/oCcivnu889DHZbuE6Nxl+ZVnxATJghaKS8dDq/rvfeQde
         ibMoBZEd0LhyHlNgIRB3D4tC0uqn9LV6igIDbi+JhAajnrzAZ+aQvh/3h3kEe8kNk9Gv
         z7Pw==
X-Gm-Message-State: AOJu0Yy0T0Fe2vTugjExbkVJFIGOOzhuPyQ+7wHSpEOMZAEqty+kbsaX
	C9TP/ndgoG4C700JssnvApHg+WMaob87KL5HHQTqySKsgUR1NZgZo/pRmzqmKJvb6rEDqJETAZp
	p43NRTCMJDthWnUHYqxddciSEOMZm4GJZ5GIZmA==
X-Google-Smtp-Source: AGHT+IFp+pV6kUnrhDunKG+hHXERZ3Qxr9EP+o5uKrgLTGM/4nnbXUH2KX9osKs8zDfSk9Che9WUJeUTJwNk5N72jlo=
X-Received: by 2002:a2e:a543:0:b0:2f7:7d69:cb5d with SMTP id
 38308e7fff4ca-2fae0f7ab47mr22165831fa.0.1727875912010; Wed, 02 Oct 2024
 06:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926124424.2133464-1-mstrodl@csh.rit.edu>
In-Reply-To: <20240926124424.2133464-1-mstrodl@csh.rit.edu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 15:31:39 +0200
Message-ID: <CACRpkdZhSsU3K97gAmZhGhN_Jj72GhdQPQgJQpJAOjNXJqfw+w@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: add support for FTDI's MPSSE as GPIO
To: Mary Strodl <mstrodl@csh.rit.edu>
Cc: linux-kernel@vger.kernel.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:44=E2=80=AFPM Mary Strodl <mstrodl@csh.rit.edu> w=
rote:

> FTDI FT2232H is a USB to GPIO chip. Sealevel produces some devices
> with this chip. FT2232H presents itself as a composite device with two
> interfaces (each is an "MPSSE"). Each MPSSE has two banks (high and low)
> of 8 GPIO each. I believe some MPSSE's have only one bank, but I don't
> know how to identify them (I don't have any for testing) and as a result
> are unsupported for the time being.
>
> Additionally, this driver provides software polling-based interrupts for
> edge detection. For the Sealevel device I have to test with, this works
> well because there is hardware debouncing. From talking to Sealevel's
> people, this is their preferred way to do edge detection.
>
> Signed-off-by: Mary Strodl <mstrodl@csh.rit.edu>

All my review comments are addressed so with
Bartosz' nits addressed too:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

