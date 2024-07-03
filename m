Return-Path: <linux-kernel+bounces-239479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEEB9260AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B32C285E72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693AF178360;
	Wed,  3 Jul 2024 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coALAr6d"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868F176AA4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010538; cv=none; b=UlzVmpKyJgbwzqnB78kBiUvsg34gN+0EoMzljQChdh0yK0lNAcE0zw9zKHfJv6j+Hwdb6eKr7Pyml55M6smsLh++J9IWUvOEBsGGxylVdXJ9bmM0djJHQQbg4xbjKJVnwmxPq60MWZh/oAKEpxN4h49BbX8xmHu98u4dQcRkBf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010538; c=relaxed/simple;
	bh=WGy9HnHtG0sk7gbF5+taydKdEFXh/w2zbWiiG26OMSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O66JROOb5G+cOKYQk3Nn63g3vq++jMOzzgFTNBj8iuosiBwkv0DBXbzp5nz3Z9cCqHNjviePKsF+ThSDNyTDyNIIsc5Bf2E7URFwZGrOXH73i90PR73KLUNWzkMSeb51AtMDAGoVM7n9UhxxZaS2ywEssmrV+JxvW/hdm3yu7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=coALAr6d; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64b0d45a7aaso49886367b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720010536; x=1720615336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGy9HnHtG0sk7gbF5+taydKdEFXh/w2zbWiiG26OMSQ=;
        b=coALAr6dH1P0fxAyBGJOf+nG7m+tqGwxvOfmJ2OX1DyaGkoHFFc6fM4iVyKRG1QkMF
         +Ski73Y2v4uIuMytuaLENrMyOw4sxhAfesoT3iKmk5+M2Zd1QPhYOaSy7l3vr86JgwWs
         Dp8okJ1WU6agFZrilJrwOm9wc7D46zTRJldhB8ed4II27nELhz0Jg7bxjPpkjp1z/JNS
         4ap+Hkc1MD69RucY0v3hINjqft+5OawznOirGHHVK89CD3p9d3B9jzWabXqrwhHErQWN
         rUCQ8SZuAllqy3enWEldTr1EA4GLAwWkbxtACPt8wQCpDTlHyyyPRz5zbOZLli1ofBWa
         d+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010536; x=1720615336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGy9HnHtG0sk7gbF5+taydKdEFXh/w2zbWiiG26OMSQ=;
        b=UN/Lq0M7mQZ6v2bmYYwIrBYnfndF/HxiEjjTsZWX2wC1rI2Mvvhdy8Kmpy6wca0atX
         5sD0lVWdEaBSSMVYFeq3JHxlfv9EEr6LMm/AhgjVUF3bm2mOeMWUbuWnbRAAeXn7/L82
         hvoXj13DsD6Pt7q/fHTe4PlWf60/Il9LsGmUDl4gf+OeTR2Mc20sd1JeDanPGQKKFG+H
         cN8t8aljNrpPNV+NSbSqPT7g+/Q5/RT8LgL0IQgCuTR3FrBMqdo5CtGjgFNXlXdaVTJB
         6nshaQGWzkl3mJARTcfEhhyGinIC5U64iv4tpFShtjk9UKEeegIEZLbr+yUHNQqFXGN1
         f0iw==
X-Forwarded-Encrypted: i=1; AJvYcCXvgYddYmS2wZLPSNgSv4311NYXha46l0Ofg1YvHHfA76Xnc5z1NcUFMck1k1efR6LLUG/gUW3wzgTEOPh50ACh3ew1rmpNqv91QvHP
X-Gm-Message-State: AOJu0YyyjI7wSKbwT+89zquvdQs9HVnEps89fHR2t6X6M3Oxv2m92njL
	O1+jGpvSK1b6zrDyUDLyRyzYTDtLOomWGSePN0pvNoPnlNp7bXRuMrT8AzUYh9Lg7CuZEvHWyb9
	WTnLEd3WYmz9xazIPSsZIBJf/dKibSSIux3kcgg==
X-Google-Smtp-Source: AGHT+IExCk5Vq7oaEX9hYErcWNt/jn8F8v/b3cmMK80gc7WrrgnGrV1BBcszUD1l2ZP+IAdB1HfikZckPy1bcw1vcGo=
X-Received: by 2002:a25:df16:0:b0:e03:229d:69f5 with SMTP id
 3f1490d57ef6-e036ead1e52mr12491370276.3.1720010536270; Wed, 03 Jul 2024
 05:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627131721.678727-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240627131721.678727-1-peng.fan@oss.nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 14:42:04 +0200
Message-ID: <CACRpkdYzg8jE0F7SHo9-WoyfvHgEwkL5ouxX3vSj-qdq1JX97g@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] pinctrl: use scope based of_node_put
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: dan.carpenter@linaro.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org, 
	kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 3:08=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> This is to send the non-applied ones of [1] after rebase, no more changes

Last three patches applied!

Thanks for doing this work Peng, it's really nice because this kind of
stuff tend to end up on the backburner for me, but now it gets done
with proper attention and focus!

Yours,
Linus Walleij

