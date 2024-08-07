Return-Path: <linux-kernel+bounces-278149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12094AD56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A4DB2B727
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21485654;
	Wed,  7 Aug 2024 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nbr1uIGE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9B768FD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044171; cv=none; b=lteE5Nps7YGg3GzwyGREYkXSAybsMYEy8oixcKdMzxzrw+pgOMLVQvJ4XjBPw0PYEcLlSkmZh+tXiZ3EqJcdLHLt6wFiH+AUvnAtP77++nNkjpGAqyeLw42d15LnRxrS3FHgOGLcNUI7+x+Ntsg4TgCKiIhULLw4aZGDxLfTMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044171; c=relaxed/simple;
	bh=b400N+knfVALmbzGgPj3BTbRD+oELeXUCqkW+G8VIW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f01G5u19JaeOLOcqxYlJk2KOY6sXPuuB1lpqJyDOzmKAWXCrwx+kdiiXlqjBV6A+Lyxk9JHuuaBHrllLAsU+uQS+CUNCULBGMapS3A9OrX4zmisStLuFLmRqczgsQU2cXnhJsaJeddd/kqSlJ7TBmXC39KgvZy66a974lHbocpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nbr1uIGE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso6228785e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723044167; x=1723648967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b400N+knfVALmbzGgPj3BTbRD+oELeXUCqkW+G8VIW8=;
        b=nbr1uIGE6Tl9bgsKyljrKH0N2j2DtlW1huEQl2IFRlPqMxk3eYpZTZfytu7HtU3Nrd
         nsluPTIirbHupzh8EZOs5quFuSEA0KdVfqmudHkTtyaRi7NMJ8JkVjbmoHOujAgLkHfO
         wDWMZpBlveuiLXBBbObVYUzhC+OryhQF9nCUYxmg4FJtlASNHDSK1e7rN1iwNOVFFBNJ
         cYPzmIDgVnEZwuk/PBm8XauQmex0PBm+kGqwLlHRDRbYJO9xAPecgAR63ntDcGN2MIbZ
         D/TZ2VnghfcIMLQVGXyTfY9PXUZl/iklrHsoldVfzEs2ymyN4N2iro6usvJr1DePetup
         NRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044167; x=1723648967;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b400N+knfVALmbzGgPj3BTbRD+oELeXUCqkW+G8VIW8=;
        b=QnzJ6lgJwQ8zmpN17TCO2r4CryfaCMEyvQQu4/JoMr8DBfIgky/I3U+Oe08Jnlr9X8
         dTIMcGD6RDFy04ujLj8M+pq6vgu6vclBZoovReEKm/cFqR7fi3AkelhRf4LUoS9k1KJf
         kVpvH8KBK734NV3ycFU2YV0ccc4bnv2FqiIbwrDSp5Iozq4ekOyusp3RDXUtct35aCzF
         VaYxdClm354+l8fLkgBT3asomBEmG6pnaUqoKLCPRxUVzJL46zRdOpfWh2c6UH2mlByd
         epb9pwA6s7J1OkqxOQtSP3R/bmpG2L+DZ+BjrhMZOKf/fz4XZUScgYNmUm5sNK81OXYr
         GZnA==
X-Forwarded-Encrypted: i=1; AJvYcCWizcs3e+bgQODHlhkE62gg10bDfllVCi7n05w/id2Wkc0ssgxd3Z0LRTI4pZiHdkVyqaaGRoCckql6eixPw1hvWpTnrBogJtxvFvWg
X-Gm-Message-State: AOJu0YyTEWrEQsli3bqaOCV6APkenQmeTkoLL1p7ELicJijY+eENUjVj
	TQmHUKG9885jF+0fvpeLqEUznGUqeVWgON2d0SgN5IvbkDwBeoxQlF0pW/6Qz4w=
X-Google-Smtp-Source: AGHT+IEee9/+95rBHM9qmfhHhWhuk6lT6qGII5W5sxauIeebfdopV9mCLXxpK67d6U+eT9QpOoZVag==
X-Received: by 2002:a05:600c:4f14:b0:426:698b:791f with SMTP id 5b1f17b1804b1-4290509fda7mr20851805e9.3.1723044167397;
        Wed, 07 Aug 2024 08:22:47 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:90f1:3c4c:261c:b0f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290580c970sm34320015e9.46.2024.08.07.08.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:22:47 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linus.walleij@linaro.org,  neil.armstrong@linaro.org,
  khilman@baylibre.com,  martin.blumenstingl@googlemail.com,
  linux-gpio@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org,
  kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/3] pinctrl: meson: Constify some structure
In-Reply-To: <c8eca123-8ca8-4dfc-acc6-3e196ff0c844@wanadoo.fr> (Christophe
	JAILLET's message of "Wed, 7 Aug 2024 17:08:27 +0200")
References: <cover.1723022467.git.christophe.jaillet@wanadoo.fr>
	<1jy158xvwz.fsf@starbuckisacylon.baylibre.com>
	<c8eca123-8ca8-4dfc-acc6-3e196ff0c844@wanadoo.fr>
Date: Wed, 07 Aug 2024 17:22:46 +0200
Message-ID: <1jttfwxsqh.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed 07 Aug 2024 at 17:08, Christophe JAILLET <christophe.jaillet@wanadoo=
.fr> wrote:

> Le 07/08/2024 =C3=A0 16:14, Jerome Brunet a =C3=A9crit=C2=A0:
>> On Wed 07 Aug 2024 at 11:30, Christophe JAILLET <christophe.jaillet@wana=
doo.fr> wrote:
>>=20
>>> These 3 patches constify some structures in order to move some data to a
>>> read-only section, so increase overall security.
>>>
>>> It is splitted in 3 to ease review.
>> I'm not entirely sure it eases review in this case.
>> If a v2 is necessary, I think a single patch would be better.
>>=20
>>> Patch 1: struct meson_pmx_group and meson_pmx_func
>>> patch 2: struct meson_bank
>>> patch 3: struct meson_pmx_bank
>> Is there any reason for leaving out 'struct meson_pinctrl_data' and
>> 'struct meson_axg_pmx_data' ? I don't think they get modified but maybe
>> I missed it.
>
> No good reasons.
>
> I'll send a v2 with everything constified all at once.
>
> Should I take the R-b and T-b below, for the v2?
>

Leave them out. I'll test again and report.
Thanks for this

>
> Thanks for the review and comment.
>
> CJ
>
>>=20
>>>
>>> All patches are only compile tested.
>> Looks good anyway
>> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
>> On the vim3l:
>> Tested-by: Jerome Brunet <jbrunet@baylibre.com>
>>=20

--=20
Jerome

