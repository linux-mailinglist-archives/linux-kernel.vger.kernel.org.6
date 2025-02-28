Return-Path: <linux-kernel+bounces-537963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B3DA492F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B79171939
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D011DFD9B;
	Fri, 28 Feb 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7MzjX/A"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3511DFD8D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730023; cv=none; b=eGdS4NRLz39OZWEGOa6YyJT98I7TzjwXoB66R+9ctR+37Stdzajpdi+Cij5S153wJW/HCh1hcgipVfRZqWXLLH8LRIePp+qE6AOnplYcV/VZtcDZx+h/FjSbdWr3R9LgOxDI3JspneRo1jEHScv1N3viUQwO3mE3DRiShK7DdEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730023; c=relaxed/simple;
	bh=BmJ/lVzZSA7fl7W+s31zkTISrUXtMIX78WNI7kT6pdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0KTDUjb2scBG6qea9CbG92tzWw36jbDQvSMlTH/EjOsOwpIEgMIQ29pI5tla5VjBomHfk4FPszKexDV9ZemShbbM8e4zH4H3FPmZFhlpr3WUk8R0SfFLx9o8XQQvGJFs8BAj8jXd16osp1ewztZXdnMndXCstStEUBPsHEvBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W7MzjX/A; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso19661711fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740730019; x=1741334819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmJ/lVzZSA7fl7W+s31zkTISrUXtMIX78WNI7kT6pdI=;
        b=W7MzjX/AHghc+6oVIh9EQTCKxaOwv0DqXXoZZtGf5EVwAtExSDkRuVrCl0WKEQT9Gf
         3TUHhD2QLi4C0RMKEyrTaliiXnaCjcrFXEpKpMRvj/v7jba36xQHJ79RGv1JnXcHpaAh
         MEcWbvw3GsWuWojev+ccy9w55HC+w6ZA08pIY2fhWazBExwqAUJHajOae9ZMRqTLb8sR
         I+VPpHIT2GfeWhWZK+9pY+xK0eeJ7xuuCe+3hDykbe1H+ojUAmjJRef/hwdFB7YJLnGF
         tlLTqkmzMdAFmLcB5CSWF8YaIOis3EC09AI1AvX4p1PKa+1CoSuzCNNsE5Ni+0ZBfWKC
         Mi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730019; x=1741334819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmJ/lVzZSA7fl7W+s31zkTISrUXtMIX78WNI7kT6pdI=;
        b=Hc4yH78qTH+JtOxtx6wwrzmFoHOiI9sf37RYX69iPutMLqNfHEUjJMXe7nanXpCSPm
         dRCSRj6h1hzTtolhPMSBXwNMKeWoIN97YBEG5o/WGylG8hO22nnkUW7ClCnkeG6k+m39
         H7QxYqhdwoo9saHH8lvCgUH1AvCjShfmgNl/UoNQyLxHv2sqKdOzzZa3QQb6LM7LHu+0
         zOF/Y8G8A5NOrWYFRnVzyNxkVf8s21EMUXMvI5hSfiZyspjyb9HRRN6tP2HeUx7r6UqO
         HFxcXBXeuO/TpCw5A+SuQV3jbXPM04ykWiMqlZkg441LiU/ANHG4czkVlEWU7nggVlij
         g3XA==
X-Forwarded-Encrypted: i=1; AJvYcCXBiI0S2BbeNBnsK2sY/TXmIE2a2OzUN2Jl11xut7yLd5cLUigjiPIi1KDxgSCDrz5exeaTa06tnqchVXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQLRDl4T9BEaYn3YgOvT708Snp8Tntx0ZKjCxxtI4WLhPiX+J
	NDgi498VKSVraZltlQ9FPQ1tq8keG4Ygj/rnp8qiWHE1zi/o4aFJ8rzECwhLqNDG+DYd7eBK0JS
	h+x2WnWULRsTjz3tzJV6zj8LuET75J2LcQ2cM1/dbKBPmWILn
X-Gm-Gg: ASbGncv/zl3olRXTPHGeOQ5ta+OocahUrLB6HZLidb57TxG/zsRt97UXdtNIhlGgSbM
	+h2rh6R6411Jg+bjYQg8iGA/pY/p/JnxrIwxbavT0jsoM+l0oB4VdcEFWvDSTYydV9kDIozaFsk
	4Jcmto8Q0=
X-Google-Smtp-Source: AGHT+IFX5LCqc4zj+I+fDMMy6Qj3F6HvFKgL0PhFMbmA8t7r07E9HuEUrbEQYDHDQ0S+rIm5ImU6MfGOQWA+OMTAvLA=
X-Received: by 2002:a05:6512:6d2:b0:545:aa5:d455 with SMTP id
 2adb3069b0e04-5494c323289mr943874e87.15.1740730019397; Fri, 28 Feb 2025
 00:06:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z71qphikHPGB0Yuv@mva-rohm> <CACRpkdYOGeDaDUuQQUGwvFNNk7ZuFjkXSMPXL3BJ=4jGEGPkoQ@mail.gmail.com>
 <ce0d802d-6bad-4028-bb57-18bddba5632d@gmail.com> <CACRpkdZtWLGAn0K+xENY+RF6CsWPn0m7R--W9EaH+xTKazALFg@mail.gmail.com>
 <8979f8d4-8768-40b0-a3a7-6638ddb626cd@gmail.com>
In-Reply-To: <8979f8d4-8768-40b0-a3a7-6638ddb626cd@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 09:06:48 +0100
X-Gm-Features: AQ5f1JqtXa1vp8lT0VdJJWyBrFs4qLMArBc_1M7bj9evlmGzfINOXdE_ss7H7Mo
Message-ID: <CACRpkdasQZ26cEv7CCSu75MJH=Pn8a45XQvZmNt4MB=hzTSa6A@mail.gmail.com>
Subject: Re: [PATCH] gpio: Document the 'valid_mask' being internal
To: Matti Vaittinen <mazziesaccount@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:42=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On 26/02/2025 12:18, Linus Walleij wrote:


> > That's easy to check with some git grep valid_mask
>
> True. I just tried. It seems mostly Ok, but...
> For example the drivers/gpio/gpio-rcar.c uses the contents of the
> 'valid_mask' in it's set_multiple callback to disallow setting the value
> of masked GPIOs.
>
> For uneducated person like me, it feels this check should be done and
> enforced by the gpiolib and not left for untrustworthy driver writers
> like me! (I am working on BD79124 driver and it didn't occur to me I
> should check for the valid_mask in driver :) If gpiolib may call the
> driver's set_multiple() with masked lines - then the bd79124 driver just
> had one unknown bug less :rolleyes:) )

Yeah that should be done in gpiolib.

And I think it is, gpiolib will not allow you to request a line
that is not valid AFAIK.

This check in rcar is just overzealous and can probably be
removed. Geert what do you say?

Yours,
Linus Walleij

