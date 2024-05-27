Return-Path: <linux-kernel+bounces-190671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9718D0139
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF313284CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1270015ECF1;
	Mon, 27 May 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFq33a0l"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6243AC1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816073; cv=none; b=dpR2o6DCdyFKkXaO1i4NPL8yjcJ+3EhytHtnGKWpsb/Lhw0HO3xlJbkM4NMXmYLO1lfGpLVt6Dub72ab832fVtbeD4V+chdMzqLO3kQcQNUNk+4oJEAsA4Q394Dc1y6leD06ieriB7ckimjaUdFf81KaeotqnlH9jHM1mDo/iJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816073; c=relaxed/simple;
	bh=A5oLEapcgP37aYCcmTzxVsLxRtwo1Khvk/g3fb46GnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPhrlv+UPsxr/MwDKnfnNW94/o8QExPvHyr/XAKGZNv8xdp81vIMFe32nc3d0hsNv7tPJSTQBYsBRHW66Ou1/HQ93uDDnuZ8Bc/lLD2ebESH65wa6waqTrlqLLknrhTN/prM7zsKcoRaj82cu1iKAFSJzTpZWWmMP0serCY8Rmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sFq33a0l; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df771b6cf71so3446577276.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716816071; x=1717420871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5oLEapcgP37aYCcmTzxVsLxRtwo1Khvk/g3fb46GnQ=;
        b=sFq33a0ljSEPw2bBgB1oc4GdtGuAEC8UMpXQYehPesrv4+k9RqO+MnKe8zSsc+yvTH
         PV5DFscWuM2G9eGFlJ5qxeMjD5AWHzOr+QnUCr1c8n0k/suOWYq3c64gznCpwDnqk9Q6
         FCkyHfMl+JDnrO9CWInUCrHV2SbQtvVfXsABAJkEDyigskb5QPoNbJIuQgLWJQAMg1z3
         d6HAnVoJlCOr0Civhr/Dcs24V+2gCQycqfzjc58WsGPwsbwu3mlHSagr8Fi1Ee8/pc7p
         CWkJTaES8L9krufMwAqq5SmSARD8afBOEzVTWgrPZrrftGFBM6Bmpofiz1JnH68dFxxr
         oHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816071; x=1717420871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5oLEapcgP37aYCcmTzxVsLxRtwo1Khvk/g3fb46GnQ=;
        b=r4FUHAA3E5H7larLhJOErFeDaO17gdoV8fSRLQ6uMA8eTJ9LvibXlQH4cb6vo5bNYO
         OG1yz8aWvVxwZ/HGBb9mhEIcQHAkWL3ul1HvIdYjAoWQcGTJCNPzTu03Zh1obWuyGuv6
         wW00Sa6eldkhEflYVXftYNae8Z9/KwAJi4QiBfFf4rYCz88wxnCDfqwRfSV04Hyk16x6
         +QcLJ6idAjJm99s9kpWtZ4IyWbek7h6dqfKkHOWd29RmxDIge+hAZlJNIKpGLPTTIEfP
         FPUkoBPLdYQZIp7N9DmkokgKYBNcZTni3V7NEgmf+A9dOJ+DpR50Y9UISfpy/0xpToQx
         V8hg==
X-Gm-Message-State: AOJu0Yzqgu3U++c9Fy5oznpCe/lOQEuzqy50gn/nbP0CebASD2mJ1pdu
	WVryiY7eB2/WIxTppRUHjc5QbDweIZKH1r1uPJdvDMqT7ZQiOyOtCDdH8GwMjkjjhK0P/8N0ClV
	3ohVCgwYH7OcRDk7c7S1o4UyJTWxpk/Jh8PFtBA==
X-Google-Smtp-Source: AGHT+IG2fUIYlwOTAQHjIZDJHL1+p7r/HhFOGyIZRHukArpnfwiG3MrekBB9kwdL/jOJkM1EBFXBjWodbdGUvkKTZJc=
X-Received: by 2002:a25:6809:0:b0:df4:d367:6bd6 with SMTP id
 3f1490d57ef6-df7721a7909mr9597567276.29.1716816070788; Mon, 27 May 2024
 06:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com> <20240508184905.2102633-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240508184905.2102633-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 15:21:00 +0200
Message-ID: <CACRpkdYMwoj9fc0MUPn8ytqSUrbnsRt5rf5s=YE4_9rQ-AC0tQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] misc: eeprom_93xx46: Make use of device properties
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 8:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Include mod_devicetable.h explicitly to replace the dropped of.h
> which included mod_devicetable.h indirectly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

