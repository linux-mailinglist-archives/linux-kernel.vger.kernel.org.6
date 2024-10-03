Return-Path: <linux-kernel+bounces-349114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC798F11C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04001C22759
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F72E19CC3C;
	Thu,  3 Oct 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajAxLzXc"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D222C1547EB
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727964528; cv=none; b=YRA4oeLJflB/a9B4EHuHlPgWccy8fJGUQMWGgtbOMsuq084o6LQI9j579ueoghI0pX8eN0KHDkojIAxiIJHxKUsU8b45GD7Fw36Vu5FCgD6Xud/JpeRlT8rTYU2RIwWOaT5P5leVgCjzidF6isjSGT4dgmtYp7CZ4twDQT8wDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727964528; c=relaxed/simple;
	bh=dmBAw90LcE/efXuNJODHttzykTK2TqESk97mzA79OYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPVRfcmHnrY2xIEP5GLTzoYFWtvZZUw7ENgkVhHLUmqmtkckschQr+v5iDGUdcdSx3jkYTlY2MQwAC0XABsiW6kpLtNpBAIfnOkH+Pyj1+B6KCccjXAkLaqvpSpIaeI6ddOprZznY7V2m228CMYaSXjGbdrK/RklLraa+CUrldY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajAxLzXc; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fad6de2590so17662591fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727964524; x=1728569324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmBAw90LcE/efXuNJODHttzykTK2TqESk97mzA79OYI=;
        b=ajAxLzXcavnVgSFbv3OKIlAwT8uBZs4aohPnCN4VrDKmRlphmCT4OgVyVw8nrSvpBH
         VnAvyl2DJBhqWbdhwuniWUQdGkCbOZRVkjtZzlt5RXMypuemrpkY3sw0aBSgL1zExFyi
         mK9ImBrwPXvNu9qqRC9T8zic+C2NUCzmd2+HV0+c/HhDfJRVybFbo9gFS3vUP5NvQc6U
         F9dTNagVasGQHXkN8HkRIeN0Gf8BaqQ57fSoRgpYVqI0E7IBCNqgEJs2qlZpncxmm9SC
         f9/rv0yoUeAYxx26EfIeGW439U2JJTnFOsSRp/Gy+2enkAMQmi+BTNR8EebPlEjk24sN
         xtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727964524; x=1728569324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmBAw90LcE/efXuNJODHttzykTK2TqESk97mzA79OYI=;
        b=u3yNJzIgJk61v0vSRUZxX6vAwS4t5ipnfzPPCKwFdZkV4z839VNmAeheIVwe67bSTO
         Znhm4nABrzdHNb1Nti9RsROTB4krj58Z3fJGBTMM3MdoksAfjOJ5blHkXlrXa4U+IPEO
         qSOQfNtSUa/7xCmKfrdKip3WLHFvnphRLNSV+Rn0g3hwvvx9lAQj5XPPs4YCzMH4E4/L
         Yb59ELJpD58pYvSDeuyMIR3WoNe3g5Nr1KwHVcvUe5zxdYGZHpGoPKdwSfTCoJlqRCPd
         YLvZ+vzh1h2S4SU4c8He7jfIHlovc4RKwqIXy2hiURot09oJrIgxlvcjTAhLlVUp4vqg
         Xflg==
X-Forwarded-Encrypted: i=1; AJvYcCX+4k2sjfbkcgP1dGWTCkMPSkxaom9jAZGaVbZ/YjlATY1QE8L6HtjKxaoGcxUuxMgx8sVhbodNtwDHAXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyniwkAAfty2zfIp2Dxid6y2N5n7D3UBj3jYyvYekEtSfA4nom6
	rHWhILEDk/JvT4DscxcwlUfrjGJVqY7fffRYefrohjXLByDHGRsjoXbIYPgosZGj/6cXXcpfoR5
	hmvERIgtsaHVdnhABjeQmIwh4aST5h/fjQU84xg==
X-Google-Smtp-Source: AGHT+IE4Yzk+gQd7NYEAkgJXljIayhLrOVUv/EmJ0SEtev6CljYTU6L1jsmlcpNqMNvW7F73TN7QNRiYQA7SGD6cUZQ=
X-Received: by 2002:a2e:9907:0:b0:2fa:bd56:98c5 with SMTP id
 38308e7fff4ca-2fae10a628cmr53731641fa.33.1727964524094; Thu, 03 Oct 2024
 07:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003023307.2138695-1-clf700383@gmail.com>
In-Reply-To: <20241003023307.2138695-1-clf700383@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 3 Oct 2024 16:08:31 +0200
Message-ID: <CACRpkdb2LE1qTe8jrY=pBt2JKxMvQu-b=znjLUAMWv56jkuhSw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: fix Null pointer dereference
To: clingfei <clf700383@gmail.com>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com, 
	linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 4:33=E2=80=AFAM clingfei <clf700383@gmail.com> wrote=
:

> pinmux_generic_get_function may returns NULL, and its retval is
> dereferenced without check, which will cause a null pointer dereference.
>
> Signed-off-by: clingfei <clf700383@gmail.com>

Fixed up topic, added Drew's tag and applied, thanks!

Yours,
Linus Walleij

