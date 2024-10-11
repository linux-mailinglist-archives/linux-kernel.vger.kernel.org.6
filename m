Return-Path: <linux-kernel+bounces-361795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B4199AD22
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7343AB252D7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118701D0F42;
	Fri, 11 Oct 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awnF2X1u"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA21CFEB8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676550; cv=none; b=fqdh2gnXzTLzHvnLI7CA7jeLg7/AtT5Ob7cuC3XA7h1zCpHUZPom6rsurQLQr75EkGPoMxPakiNGxzMnXl+UN/qcvVW9mjmFJlPQ40qRljNw/xR/gXwo2L6dtzLl+JCEdGu7K+6AKPvgrTZaBHIW3Q4VZudebqsT+zcQUysCbR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676550; c=relaxed/simple;
	bh=a5D6CRKK6FRSWd/adGyc0iCMDGRKCSw2V0dQAJdi94Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjwE8tLl8HnNPyopD5Goif0/bxr4aVQT8sHlETc2M1lUNMuGR7a0QpXDkZJo21X/YpK0KuVw/b5tlr/kCpkvo2FDTZTaUzMcWQJn5MmTQXgQVkOsb1jcMVvQefaJKqP6rEIu2xzOLnWB9FOZZ8LBI9kD5ejPibAoDHfxpxdckRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awnF2X1u; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e2f4c1f79bso22768377b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728676548; x=1729281348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkBoPVksNssq3kk3PRQvLrV5w199+kZDVbn+dDVtSPE=;
        b=awnF2X1u+JGwPCfYeQaZfeTDKaUYR3fh61rrprJM9QiweC9+dsMVCOFoVDjvs0DGX9
         Evai97b86I+IM+lRYGckAzIgyH1aWiHIiJ54snKQ8kNU5yDOjzcWyWeC0GqL7jVHbBgs
         tC7SHh2OqiAnSo/WWfXJUHKCanJmkJW/eQrXightxqbWm6ZCvFGPcYUGSN9yUl0BGA7p
         T3d5Vb0mkEIiGscz2YLm92RhuEaGzs7EHsdNu5DKrTMHl6CcB2+Fi75tzBD0TTwxHv0S
         GH+RIwd6KCMa7BEulMKO4I16X19sqKRZb/Ax5yXiFIoN+McS0+jaAMj+Y+ZlKNLsGR98
         gQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676548; x=1729281348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkBoPVksNssq3kk3PRQvLrV5w199+kZDVbn+dDVtSPE=;
        b=S/yGaPZPpjHfuyck4kSpruO06IS83z++vo+Ie/PD9x+mDPm5D0USE/XYTE1QEuVv/5
         +w7dlsLLnN0JZGhrD5jbYJ1NLAXqnKC9iSI8c0XcsrGz2lAFzKoPjAh9JNWak/J2OfEn
         n5hdz22x1Sj3Th6AbyuHZzU26o0Z31R1sx7ERd/0pdXtykLJ7pLpL2jpLlQAKKP7LC9K
         wZ1IU3mVNSi8s1sNiRUeIrSZ27yyoLaRP1bcfalQa2pPzwGeWq6s4Ul8WW8u8VdAh8e+
         9LwkvkYwZqYeu5Afr+XDUnQyX/SX85ELYaoLnTc1uOf3TwzSufzqMOZodrsXio+NTVE+
         Yiwg==
X-Forwarded-Encrypted: i=1; AJvYcCXnEOoKUdKXJYOWViQjqGWAcpM084uNTRgxRgeOnolHUFRa3NjJn6dastULgWBnGrXduNV89/Mx3bjtVCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhthzhv344BVCovKn/gyxKqusLCjy3hWwh/QNoj1EYHJQ/tSJ1
	l5olyUcWgEdhQEgI5oSYyHjZRJLPmgCs2Qa23Xqggg01mjTeeubMERAUH1kdLDZwSRFootmoKAk
	9pm2e+RPIT6+mTvC3/83eY7hOB3QHqj5XmtrqyQ==
X-Google-Smtp-Source: AGHT+IEm/NZLoO0B4BF4b0vFgq+5uRsH3TsYvJLQRrk7Qkb93mKDfqxwigJ4J2wXtENbFFnnkwnUAWOGHOtZzCq2V6I=
X-Received: by 2002:a05:690c:ecb:b0:6e2:ad08:490e with SMTP id
 00721157ae682-6e3477c014bmr38960987b3.5.1728676547975; Fri, 11 Oct 2024
 12:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205237.1245318-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20241010205237.1245318-1-harshit.m.mogalapalli@oracle.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:55:36 +0200
Message-ID: <CACRpkdYy9JL_tE=N1=4aK7JG82usxGN6eteTxsopTbFsU0Vh_g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nuvoton: fix a double free in ma35_pinctrl_dt_node_to_map_func()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: christophe.jaillet@wanadoo.fr, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org, error27@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:52=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:

> 'new_map' is allocated using devm_* which takes care of freeing the
> allocated data on device removal, call to
>
>         .dt_free_map =3D pinconf_generic_dt_free_map
>
> double frees the map as pinconf_generic_dt_free_map() calls
> pinctrl_utils_free_map().
>
> Fix this by using kcalloc() instead of auto-managed devm_kcalloc().
>
> Cc: stable@vger.kernel.org
> Fixes: f805e356313b ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO drive=
r")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Patch applied for fixes.

Yours,
Linus Walleij

