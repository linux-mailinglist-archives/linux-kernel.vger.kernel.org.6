Return-Path: <linux-kernel+bounces-361780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BC599ACEB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB75285370
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C911D0F5D;
	Fri, 11 Oct 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhfZ2fZw"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9F1D0E3E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675768; cv=none; b=HMSDzHRkx2zR+O8c0Nrjj/aag2Ef54es5UAuxYCapOZM9lqpIMi4axiR0q8ZDFYo4Hlk1n2loBNEvBhXEHh0ifSmX3u1Ayz6OTsghzbUS2WtplMl7DFWtnPb2SDPkc9aZPVl6MjePQCBCT0s9pemJLubMlldoDgHVFsi4jX5iRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675768; c=relaxed/simple;
	bh=oEenWqwwBvlWpd2BK+tBQnlRr9uWR7YqbUNUrbjm1dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6Ora2YtowwWmhv/+hN8FMAE+40vswOTN70uPP8+KpAXyq+6DfI3ZnF4Dd9dfgdc9WTGFWmW5A3RLhbZ4evaPrEYIzjdGRAraWecLGMH9cs146bW+BijvDsHKUSczuMK2wHPhOFuejNvEUJjf7kS98ywJwMG3Mw8YYJHeUN4Ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UhfZ2fZw; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fad75b46a3so24360251fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728675765; x=1729280565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEenWqwwBvlWpd2BK+tBQnlRr9uWR7YqbUNUrbjm1dY=;
        b=UhfZ2fZwmotqQSRxqI6SVo/conmNEVjKjezoALS/HFiBgNMFu3D/vgpdhZe2GoaT1U
         eVcNBkoJRlP+6h5qsoz7c1YCbXKQaPMJiCSMEWv4wTwtu5l+je5k4U1rMboABszu3vT1
         YO8XSR23VIG3TGlq2ye9KiLR+Sh3/6pg8pYfB8JgGI7uA6hkAZNNACj2OD4ukLCG6MuQ
         ocFY8Qx0Z8IzSYzMM7RkFaB9l66it6yAGrhjTgbJFBnRqP+uqAG8NIa3RtKyvYam6Hce
         N2fl/Wz55iCQViChlwoNqSeXXCJw/jg2g93kve1GNtfoYqHlf6Xrzcom+Ho5aIjCIFUx
         eTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675765; x=1729280565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEenWqwwBvlWpd2BK+tBQnlRr9uWR7YqbUNUrbjm1dY=;
        b=WfJnSu8CecAsesx43qPoGIBUSYEelfvaAQaKEnnx7IlzyBLk06Eu8wIXOKIfMaR4Ww
         vI2fUdppPhoOY32XTt1VAGO2JEWb7D743fDR0dZiShCta2cdLw2lyDraHq2zVkMMNFWT
         TFqfwtxuPzjrrtGHnbMluaofHRbdKm930XOrSJRPvPxTUwq9O18gJ8K4bim+W3OQELNX
         zvUW1UPBqdm8hhXW+41bnG/gAczHXZ5IcTh4o0tC4QdhFX7SdHjGf/+jo+1BIoINWpT+
         /jJv4/VtLfOgOFm4MhmzzH7YahoK7daxBuPjjvyLq9W3uguW0a2Tbv5oi2Dsgpgz9UjV
         k2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpMQAhRvu5bFFgHkCX09XoFGoLkVp/X3C47A4rramsQcYLcCV+rXLaSs9IrOAXUK7xb4VFiIXpbXl6eYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe+ybW6qYOS6ScVenornMvoZ39ZtRY8NN5sVniQD+zmMarxxJZ
	70mstanzlBPR4/KXBkG0dVusE07hktjosqiRS2/e25C+VY3vMeuptd/OykkafjYqUx7jThhIEbZ
	Gdvu85xzPWE6WrkPK6hDKRbkN7/XibxitJ8FQGQ==
X-Google-Smtp-Source: AGHT+IFXhtGiu0BS1l/h0GV5cEtsaHcNjwARyABL6VXYXRpwOs+tOyv7UJGbtsSmecdKIGDMRk3CWn21qHwTH7tGwrY=
X-Received: by 2002:a2e:1309:0:b0:2f6:6074:db71 with SMTP id
 38308e7fff4ca-2fb32729553mr14953661fa.17.1728675764928; Fri, 11 Oct 2024
 12:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007102549.34926-1-brgl@bgdev.pl>
In-Reply-To: <20241007102549.34926-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:42:33 +0200
Message-ID: <CACRpkdajEnP=-7ia3L7sr3v02ePWqKbC2PukSLXRBecsVT6Xpw@mail.gmail.com>
Subject: Re: [PATCH] gpio: vf610: use generic device_get_match_data()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:25=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There's no need to use the OF-specific variant to get the match data.
> Switch to using device_get_match_data() and with that remove the of.h
> include. Also remove of_irq.h as none of its interfaces is used here and
> order the includes in alphabetical order.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

