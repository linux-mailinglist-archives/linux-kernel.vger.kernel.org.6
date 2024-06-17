Return-Path: <linux-kernel+bounces-216914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F00690A877
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A748DB25353
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585CD190473;
	Mon, 17 Jun 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grK87cQe"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773A25740
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613139; cv=none; b=cmyFHutg9icE6zXuIjPehkyXxu5YmCHn2zCziwcQFh1lRdWM+HEgEPSII/5FH8Cq/n3inFuuIEh2Eh4+aRiDAUwHMdkFuVRfxdWwnE1F1409GFBasmzlkCbayrVllKT4AsbVRBnZOu1jrhSS4cUD8FDwvLgWeoUwHk5XabXWVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613139; c=relaxed/simple;
	bh=FE3iEKlKCJMVD0D4H2XPGzG/BmtORvHVK64W6Si+9nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSwe02WAHIzkPJwKAIMz/o0y/TlvkPZYrXPRIY4GF5GOoKRYYzWeREb7Smt6lGF6lrWHml6BL8fkxe6H8UqHTY3rf3RWW+8IiiFCYv+ftJA6hI4rcDPdTCTXiW0ptvwvGcnzeN5CHK5uFm+yHvHXJngvlECC/jSYf2gg0JQi8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=grK87cQe; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52caebc6137so1825693e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718613135; x=1719217935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE3iEKlKCJMVD0D4H2XPGzG/BmtORvHVK64W6Si+9nQ=;
        b=grK87cQeKpfsLVcKCca1WDRZfiAillk3uGlqF4TBka8ly7gyrrLwYHQmjgIIuQn6Vo
         /bNFKb+oq5H0mj+nd8rP+klbi6RiBJ26w4J6nXM6GCMLvEawuBgRZatOuj7ZUdJwIVlr
         EaNeTHe/JH0TeA4TaQJvNgxTpLEox8vUNMQbm97vhscZAoqy3C5p6Fen+PVgJeULr6Na
         m2pU1l6B/CczzRN+D8a9tZ1kw+y6iMxMwIG0MqsljWG3wDXK+Gv6HKuyfYR2zQLFvdQD
         mDkkyTiTdcJn+Xxi3+/UPRCoKW2+wFcBWnbNDhExAhNrgxYXyfXCKt18vdrUFUG2Csol
         2CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718613135; x=1719217935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE3iEKlKCJMVD0D4H2XPGzG/BmtORvHVK64W6Si+9nQ=;
        b=Lo7IZvYJBqF9ajc2qgOP1/X3aFrQZCrwwA0B9A23lHRK2mBdljcgCQdXtD+Hkd+bua
         2WmiBM8yxhsU6BwjrRY/6VoTSwD31neZDAMGxjN/vQUsL0LlXWLg/nxP6FAcRNvbsv+Q
         eRZ0rkbAc0JT6zaiA7Wti0bDzFCOxFmtuKcP0rKzPFNUewOuOaKcUK/foUzfsod5vrO/
         x7p1XuJ1WE/5IktQVElZkx47XCm4PtmVkPD2yQjGQqH1xjcT324ZxjRDbq11etp518K0
         jd4QJ1Uia4VlttMRYXONJ1/8PGJozA9s8E/IIO1sj4hN8wfMHj01rI2/ygQaw5IunCuA
         78pw==
X-Forwarded-Encrypted: i=1; AJvYcCXoRoQ+8HHzyqW4SU6KbBt+7iDmsZfDeNfe+gxHjl3xe3Zxo0L9xjx2fGx08FMvWFKV2q1j2GnPb9kjgJw8zzBoJki7wKsHeTjK9EQg
X-Gm-Message-State: AOJu0YxAG572qcpBsd9lHi06Yd5rzfja1u9971yqPJXPJ63OQeMJ2JeR
	+0dyADRJp3UmhJDt0AqZisLj8nclScto6wWZ+7chRpkGMrEaq8DZfCmlA2knBFoMXULTLXLe9Uz
	OwchzjNBdMhz3ebTWxOQtMWO/3vX03A3Lvh3hNQ==
X-Google-Smtp-Source: AGHT+IHsGlzkH4ixE2I4yC9Apel6pNGxFLAlaESfH/KyLi3NbHz3v9EPdEBe+o05FhL2D2zPDZO2on8osUVs7OTikn4=
X-Received: by 2002:a05:6512:104c:b0:52c:818c:13b8 with SMTP id
 2adb3069b0e04-52ca6e55abemr7654865e87.4.1718613134835; Mon, 17 Jun 2024
 01:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f6fc17e-2ab4-43f2-b166-2393a369a263@web.de>
In-Reply-To: <3f6fc17e-2ab4-43f2-b166-2393a369a263@web.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Jun 2024 10:32:03 +0200
Message-ID: <CACRpkdanLmWrDD6AdzJJx3fJsQWTE64vh+MjOtDTkpzwqqPkuQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pistachio: Use scope-based resource management
 in pistachio_gpio_register()
To: Markus Elfring <Markus.Elfring@web.de>, Jonathan Cameron <jic23@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 6:02=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 5 Jun 2024 17:46:52 +0200
>
> Scope-based resource management became supported also for another
> programming interface by contributions of Jonathan Cameron on 2024-02-17.
> See also the commit 59ed5e2d505bf5f9b4af64d0021cd0c96aec1f7c ("device
> property: Add cleanup.h based fwnode_handle_put() scope based cleanup.").
>
> * Thus use the attribute =E2=80=9C__free(fwnode_handle)=E2=80=9D.
>
> * Reduce the scope for the local variable =E2=80=9Cchild=E2=80=9D.
>
> * Omit explicit fwnode_handle_put() calls accordingly.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Looks reasonable but I'd like Jonathan's and Andy's review tags on this.

Yours,
Linus Walleij

