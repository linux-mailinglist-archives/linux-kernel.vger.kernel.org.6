Return-Path: <linux-kernel+bounces-249884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B2392F120
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AAB281C59
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F4719F461;
	Thu, 11 Jul 2024 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulEm/Je0"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28ED1509BA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733424; cv=none; b=Hrr840QOTwJMAyWMAHlHh9cNVoKqXYq8yJNQs4wVGpfHA+oepC+k3LmPW5V4sx30QwBEDM3y+n0lO3x/25yC/d+bf9CJNm4EHe0/TLciOmreYGOI/98lc46ZSzQYjnRuES9XKqjnrUYhARQzaPGhD0+HtME1TnpBjuMxyF/XeCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733424; c=relaxed/simple;
	bh=PfV2LHhczgIOiF/FLHFpLccfgiYbU8sArpFAL8jU+I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STFo8fhxw1hO3iB34ZHN98pPDnfMqYWhwQDXEEktRlP+uYTrmQNn5gPo9BPsDeLfcQLDRd/0Eb2LD+dQ5Jx7piy3qKjl93nD1Gn1NNBCGf6/ItADyGuc86O15GGbiwPRgFN1VIZG1BB2832Q+Ct8l/JH9jYRHGlQyg3Wqv+Bn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulEm/Je0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44a8b140a1bso84151cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720733421; x=1721338221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdfX1DsNm8qjiscI8ctGm/5sGZ9D9wiSufYLdJu7uyk=;
        b=ulEm/Je02zanIO3IOm21GY0zW9vTWtwgqtBGNvwaFiePQo9M+n43BVLZGDgh8wPXiZ
         W20H/rD2oIKSCL1/4NVHRUMirpwaQcx4SVYID+5X8gr9GAxUsld/YluCibHBd44/MbAr
         oYER70/8/yl9/FkMoj4Pn7DFZ/0lQfXzhG75RI4wLRJTnPi8DMPVdAeBea6CaZCOV9qI
         QfzyEz/X5FInmi0R7+uCKa44wKAWzZ5STD2EWFQPaejuLV84ycDoW01q7c8XjMfTBJHh
         sd5p603vDz1yDlyXsJ8kPij9JlLRVIAr044u1spm3gRY1o4+jL4EP4jmyM1RLReJ/nl8
         641A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720733421; x=1721338221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdfX1DsNm8qjiscI8ctGm/5sGZ9D9wiSufYLdJu7uyk=;
        b=mvox+r0dcMICi5C+9RNqJZ5ykPMTDWLxUqVZIf1bIFlJMuazQzmLMSTT3Js0RDtPkl
         85Z8Nn9QlcB7pKX2NkT6w+N+LTq2aIuFwNOmZxHphwoqNgEYYycjso9/cZ2IzSF7ArxI
         Geg8siOmk5O3bMmf+Ayb09mAivN05vg8yoc+XoI2ZYTmoXc5ptNTvHNhuKAQ04E0o7nv
         6ksr9KjWSxN7nRlsJI2IW5CYm6TEQHnzFv7rBL2C8Mo03K05dNbUsscUgQtoigM6ODAW
         LcghgsjVUTn7LfLeKk+9XigFkx2scmH4kdrQ9XSQKz34AGqwyYujXKlwSxYNkyl2FaZE
         dl9A==
X-Forwarded-Encrypted: i=1; AJvYcCURnr88248mj6pE2/als80+pVkqzqxLKGyA++q5WImXXAEA7b5peLzB+2WdmQTXLcoQQNqrsxePbs40gqThQRO8ZX84wr/49NNFljZR
X-Gm-Message-State: AOJu0YxYl0ktESQXqNp8pCqNpqk83/BxHDGj6IYsk36y7iv4zSqZcxrC
	Ap/uk5WsS555UKLZKjuf5NJuTtX2NwA/C9zeDIixRu+8/GJMAnO7hstCaEky3nSuSxzBuUOucX8
	xrbgbhF0kpFqCOVQ1+rv3dFHRoWrmEc4eTKi5
X-Google-Smtp-Source: AGHT+IH1gJu5R1iFRIxSGci2RgwfG8wuhhVVH665/5MtCBtZ7FUXpsLXOP0eGmaZoZ6oaZEEKWJwGogTVVA5LciZykM=
X-Received: by 2002:a05:622a:7703:b0:447:f44d:d0ed with SMTP id
 d75a77b69052e-44e9c93886amr194641cf.1.1720733421418; Thu, 11 Jul 2024
 14:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711212514.2372780-1-yoann.congal@smile.fr>
In-Reply-To: <20240711212514.2372780-1-yoann.congal@smile.fr>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 11 Jul 2024 14:29:43 -0700
Message-ID: <CAGETcx--FNpz3o5TiZ3T6UkMHKBUjD8cwHR6eQAjM-U86=p_Eg@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Set the fwnode for regulator_dev
To: Yoann Congal <yoann.congal@smile.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 2:25=E2=80=AFPM Yoann Congal <yoann.congal@smile.fr=
> wrote:
>
> From: Yoann Congal <yoann.congal@smile.fr>
>
> After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> detection more robust"), fw_devlink prints an error when consumer
> devices don't have their fwnode set. This used to be ignored silently.
>
> Set the fwnode in regulator_dev so fw_devlink can find them and properly
> track their dependencies.
>
> This fixes errors like this:
>   stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Failed to create d=
evice link (0x180) with 2-0033
>
> NB: This is similar to the commit a26cc2934331 ("drm/mipi-dsi: Set the
> fwnode for mipi_dsi_device") applied to the regulator framework.
>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: stable@vger.kernel.org # 5.13.x
> Fixes: 63c7c9e16c8e ("regulator: core: Get and put regulator of_node")
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

The change is valid but the problem is that managed device links don't
work correctly for "class" type devices. So, we can't merge this
change yet.

So, for now, we shouldn't land this. Are you not seeing probing issues
when you do this? Or significant changes/delays in probing?

-Saravana

> ---
>  drivers/regulator/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 844e9587a880..f05f873021d2 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5656,7 +5656,7 @@ regulator_register(struct device *dev,
>                 dangling_of_gpiod =3D true;
>         if (!init_data) {
>                 init_data =3D config->init_data;
> -               rdev->dev.of_node =3D of_node_get(config->of_node);
> +               device_set_node(&rdev->dev, of_fwnode_handle(config->of_n=
ode));
>         }
>
>         ww_mutex_init(&rdev->mutex, &regulator_ww_class);

