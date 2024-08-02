Return-Path: <linux-kernel+bounces-273125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B2D9464C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56B6B21783
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191486A33F;
	Fri,  2 Aug 2024 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjV1T+oM"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7F46E611
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632631; cv=none; b=ElrsoC/VVKRtsXIMNFb95qcswGscVb5/R2EZ4zJOkiNU6o4/pRc9Ux7HJ/SLL3xsK1lieXG0Znn0waPlVUUu+EnicapxJuAfbKguRViK326eypSZ4UHaLC2/Kt7ZF48W2L8tYq7O6O3S4HX4Uh5HChDODDIEWfwMOj0CL8FTF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632631; c=relaxed/simple;
	bh=g1ws3w0Di7lti2/42seyLnX7XSXs8Ks2FzqDuuO8k38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqaLemGwhhrmSygZbioQx4C27w4ciNlQDsxLuoTQEcga2dYTPWn/SanROCdKgJ5q/i8r5nr6FHstXcXDmF0e+rACuCxU+nBeYcPwEOG2eUe9a9KZByf0If9EHos2KDp72X1kxEhZSG7qn2WPTv3cDbKxTCSFGQpazWoLuACFzwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MjV1T+oM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efbc57456so8473772e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722632628; x=1723237428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1ws3w0Di7lti2/42seyLnX7XSXs8Ks2FzqDuuO8k38=;
        b=MjV1T+oMoV9Qt7M5/CV5/4n2519teLLJy1w1NUvcr2IiKC7EhPTCxYJarh5eKpr16s
         dg3Ed1C0zdgLKgmmCQkBJmtPZ3xawpt678/K8vLZnX1fNWhsohPn15qCpHMNBPbeDYp2
         B49Ga0x/mmN/Bb4+tyyzpT6EisRNvN7EJXsy7LoY5HN7PQpfUMT2ixqDS9g8RKXM5Zfl
         8QlzMgf1iZ2QL5yFfpbn3sWQUUDhXQ5Q/jhi7McF3J+m1RQtYB6j0HPc0UZOLy2r9skV
         Vn+2miHFDjLbC4xNsPzP5bnJlFpZYLwwmsguu6OowImwhCFj2XzftzxfI5+y3dIEVSK5
         RniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632628; x=1723237428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1ws3w0Di7lti2/42seyLnX7XSXs8Ks2FzqDuuO8k38=;
        b=ny9CAXyvSPPWixXV+g11m6ZvmJ9ZDabgfD8IA93AS9UulcYYg4TdPVY17GUQ748P4o
         hVp43d6ZqnGkdcs6zbrPjoTzn8ARkcO/AUTB44u0YTiz7nwwsk8GJwhyugbWM9aGb4Vu
         ETJq1gVbsuBVmJa98024AEdw6KK1yhthvFI0hHbosAlJWe+RCEaOHAWVaZxZ9NEk4jmy
         y9g8jiq1uGG0aQrMJYLdtyqLLiCUD8yJd+wZPpzD3ZMtuNpu3bIvIepnseBI9M/BDpMJ
         enA4PdrpAdB8xd9jfVKX0qu3AWjFGhbzrpq81D89ePXDXrDwesAXYzSJNBX6pLdM1tFw
         MSDA==
X-Forwarded-Encrypted: i=1; AJvYcCVqc+yc745XHalPA/SYN6qXqVdSYebo4FVdyK6tRUCbinUWrMsBrP8lZRaqi8oqo5JQ+06C6IDn7BqqzhQ08UnsxNQ7ZHEVL8zXqPve
X-Gm-Message-State: AOJu0YziPxc1Mmmn43XBQLMIE3YaUR2aEc+VKxH7ed6gUs2PhSOI3MGs
	HoUjYHQC8Tb8zf7+gYIBTH0LlzVzrK1SuOc9RaVCyFCMr+9oX9EXCh80iN7MVkdcJaH59iekMbQ
	3xi39pz4/Ll5k39piHPcWSV76Ad1kQQ+ShItWfA==
X-Google-Smtp-Source: AGHT+IGztMKIab+OCtyYIDvqYN9zD2lQOuwu5TzL9SNqwpSjGGgswmMvrF8iAI1ubdL7WKIhRWvdTbe4djnOay1B/S0=
X-Received: by 2002:ac2:4c47:0:b0:52e:f950:31f5 with SMTP id
 2adb3069b0e04-530bb36bd23mr3034748e87.18.1722632627773; Fri, 02 Aug 2024
 14:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802080403.739509-1-paweldembicki@gmail.com> <20240802080403.739509-4-paweldembicki@gmail.com>
In-Reply-To: <20240802080403.739509-4-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Aug 2024 23:03:36 +0200
Message-ID: <CACRpkdY+TwqXfAXfL6HKrAAVpYOv_BqaGdc_QrqFPGoscRnkng@mail.gmail.com>
Subject: Re: [PATCH net 3/6] net: dsa: vsc73xx: use defined values in phy operations
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 10:04=E2=80=AFAM Pawel Dembicki <paweldembicki@gmail=
.com> wrote:

> This commit changes magic numbers in phy operations.
> Some shifted registers was replaced with bitfield macros.
>
> No functional changes done.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

