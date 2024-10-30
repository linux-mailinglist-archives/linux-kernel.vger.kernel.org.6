Return-Path: <linux-kernel+bounces-388545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1319B6110
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE772817DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC41E3DF3;
	Wed, 30 Oct 2024 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2kRHwRd"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0A374F1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286488; cv=none; b=IRnmv07FCaBEmRP2VkRcUH5d+YGLroaKJ3b0C+wrsxEB4cy81unGFkr9nLWF5qPIF4nyHK7fD0uLTZCaGzfGI8CW5uFe9CvAL52bQBkqNFV3eImc2EGssK22XTzuu1HJARcINQ15rQALhWBmUKK4U8g5nwfhTC3OeR5ZrUB5fs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286488; c=relaxed/simple;
	bh=zzrha7jGy6bX4A4KIQJr6OduF2QVMnAKjm8yxplyNYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mT50agLD4xbcAaSw8DHSnVNBl7AJuCFNjPa4W1xNKP3fW1cqz85OAM8ywWzRaqTBfO5ntdO7a58DrlM1xVA+5W/yBP9DtmU0tdcCblqDugnlyf26eXNuJPvFj0uTZYq18LYrdEH/iycZdY29QdwLHtLi0ISI3nDypPp1qztn2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2kRHwRd; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so9143594a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730286484; x=1730891284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HtW7qNw/Gr/IvmBwOpblzp4beHIWRAaSzNdUMpl4z7U=;
        b=D2kRHwRdHDN2BcGJd6LGb2IteosWeHU0j1NddhY2tB5w0dwGcz7w8XOmJmyHw/oMPn
         yC37AJO4h+4P4TJpPEGL8mTTeagxBub0zJR9wqZ9c9wQMJ9vGa7F4V6Sf/88Fem9t5i4
         L/c5rLVRphizxe5CwGTW8i+Pj48fX209GAHT6ltH4mtvFL1g+SmzNMsaOpqXbmXhXKhM
         d/r3xDkMRHjUeNW/eOJW3bIOirnF4ywGS9UTAflzORghj6NZStauXTYrx9NMmNFsX8/z
         9xhjyrqr9LsqX/RU2OZ7ZDizmlFUEtY4VjVDEKJ8IrIQfLGtlYEn5Gwd4brRVYDfbDv1
         jVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286484; x=1730891284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtW7qNw/Gr/IvmBwOpblzp4beHIWRAaSzNdUMpl4z7U=;
        b=ht5FozwHfPhH+t5gWrQoRBZlTPU2s7Djm3lpjHdZy+c81ILzakhy12BR/WbfRDJML8
         j9zDIOWwc7NUS98CiX3FmOWO/Ou7OAvBQ2JmRKnwP1J6kq8ObS81HOVTGgAWcs69r3Lo
         jrx09UnG5D8kP1drkXEh5j0x1PGrtrLVe5ZTRlBCQ0vVQ9J4XiFFYhCpV7U8nBIMEINl
         hKwWfRL7gEmHPw+9pic7XU0ksfkiu5phZR7kTvouj9xz8jNFdLRJm+1OSBgtJnJsc2Q3
         BIfgT2BzQJ5SY3zmmSpVelPi/1Asadv0gG5Z5E7UVsg9x3MQXFYwEeAW2uutuE7m8HOn
         pqAA==
X-Forwarded-Encrypted: i=1; AJvYcCX4otF5odL4bxX4YYFX31kLn9i1gdoqehbYoEqAdoFsD4YU6R+lYdNfehDkIRIcOMfJ+Wk1OYVilgSZ4JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGJpzl/rpa+rVZ4+0arEoxVfxmSWy9MFe8PXLqlDu/NxgkoX6
	EuT0PWaOC9uHc482J49rUkQqUSZCI5zuJcKY79gzOnooElj5KTTD4/Up6uaImjO4GGXsBYfk1dc
	Z6xfsiVzX/ZcsP6WjsY/RjNJ9o6MOnVtHQJG+Kw==
X-Google-Smtp-Source: AGHT+IFXN3h9v/G1nyYZauhpuoFivbA/dTsCzahlR97/GO2a33q0fDcSFnxWfjsGDzeOG9bypL8ba+QnHBYYVFERS80=
X-Received: by 2002:a05:6402:440a:b0:5c9:87a0:4fcc with SMTP id
 4fb4d7f45d1cf-5cbbf8c30a9mr12008965a12.16.1730286484442; Wed, 30 Oct 2024
 04:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029131752.226764-1-ulf.hansson@linaro.org> <b46e153f-f329-44b9-a72e-bcc65763f789@intel.com>
In-Reply-To: <b46e153f-f329-44b9-a72e-bcc65763f789@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Oct 2024 12:07:25 +0100
Message-ID: <CAPDyKFoL7gHY7h924HXc6_TTyGsRR=oTs1p5BitJP8OpBPcTfw@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: core: A couple of fixes for UHS-II card
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Victor Shih <victorshihgli@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 16:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/10/24 15:17, Ulf Hansson wrote:
> > The recently introduced UHS-II support to the mmc core has a few problems,
> > during the card initialization and re-initialization. This series intends to
> > addresses some these problems.
> >
> > Ulf Hansson (3):
> >   mmc: core: Simplify sd_uhs2_power_up()
> >   mmc: core: Add error handling of sd_uhs2_power_up()
> >   mmc: core: Fix error paths for UHS-II card init and re-init
> >
> >  drivers/mmc/core/sd_uhs2.c | 65 +++++++++++++++++---------------------
> >  1 file changed, 29 insertions(+), 36 deletions(-)
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for reviewing!

I have queued up the series for next.

Kind regards
Uffe

