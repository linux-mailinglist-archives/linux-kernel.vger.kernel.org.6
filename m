Return-Path: <linux-kernel+bounces-384988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDC39B3117
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46734B22EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546941DA309;
	Mon, 28 Oct 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCgtsLct"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B661D5CC5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120081; cv=none; b=CNUiAnJExfNm+TLNRHFFkKPrkWMvg1R6hcZyfHZ7nsIyd9iQilBwJXDuxZjwUp4H4KvBiJh83YmID5k4l5a0Xu4g3raBQcQVDP0wvTfH7XeZ3pHJjT7p0loS5GOvjz6A4qhY8fjfrOz4P40UaWPG7nmV4DNYlMn9rCiO5+cHxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120081; c=relaxed/simple;
	bh=seI8UO8liH/MjIwO0BVJ3zPmW5DvN1lsIKmmEv7NXaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezbLR1g0DemYZTrYnjy2sHRQwl0JbVe4niBarn0M7QzBNOEFSyW0i1RYwX27WqQYlM9YouqAIdaARiwBlgB4uJEeO2Sq/crt/OCASQ5uoY+POvdEaOgvWk8AjbntKTSaI+IBjKXrDEkhdxwckiwmWncPwG48JntYJRQU7xzb0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cCgtsLct; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539983beb19so5039374e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730120078; x=1730724878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umup54zPr/YxS1kzJqH2Mzz16zItuDuoZj7kmVQKCCM=;
        b=cCgtsLctISLLOVkD2JfHx3DXEAKRHbBvGVz2c3+v4KfWascqOPvaLBpS6DHQ4uWQBB
         CHNn8/f7SxNrEqCV5zhHdRGrvaiUd6VxT5k8o5hI/kAx0ebEHRud7SorqlMSieIpNfQt
         VeqZ2oaHDKQM4UojFdMIHlgDwSMmvXYWnczte2kKdZTUVGapjSL5z1LDSqVHBFs0fcj+
         J4fFuYyp3kVoocZ35CIDJKa6cGuSbnmltDC3Q7Puu8vepXzTHJ4ZDw3L5gHlSAAeguwv
         f1tqeNoOALR1Dm4jqdG8fehR6Yv4LB2G9Ar9I1UQxIN7ODeXwZvRAa26vzae/xhQGzjD
         PJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730120078; x=1730724878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umup54zPr/YxS1kzJqH2Mzz16zItuDuoZj7kmVQKCCM=;
        b=HgIjwxHcPBsfBCH5ETvBaeSTPTr7jrx2hKjz0UOdsbMtH5qoxkz/GdxiOoT8u7r3sL
         MlR4OTemk7xo++Qo3M0xfAePfN1vZXTAxS44OejlGET6Homf1doJtmsVj3DgAeEt+2Y7
         sidJRJT7h/eUni8KylOerMDVG0FSbpDrCvwK2znhZYhYX5crTjPO4tSvqvAnevnNZcIh
         Xy8s/lOv0w4NkxCPhX1hZVAOl8a5jjPpEfD66Zrs4UY6RtZ+3yLdiN/qtZ7CwaW/gBRV
         rdMeBcwZokyn6YBbBsMOvDEx24yI7UqOuJf51Xht5gfll9JVLUFgHxu9HzoXmRZ6OWv2
         7MAA==
X-Forwarded-Encrypted: i=1; AJvYcCXQkpjBJjLnu6M6OK5hsgDv9pQ6Xs8b8kDcbENJynD/lsE+2uxM5rl8h5XUsaW73GTfGSroH4pMIfoBLSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9vYei+9378brAd0A/w6q66yovqS0ZHCqZGy9+6xraTyY5utdc
	ZQXhKgRLKxEF/yjXRSKYGkJlLIF2CLr/MKKGbsBdYiU/98zQ7k48MlTt1AGiQq3xEQFJEsB5tJZ
	mx6ZQ1e/PRNORFRhujgnre6mQ/UD6ovAAMEmBRg==
X-Google-Smtp-Source: AGHT+IE0RFORu2qhCHVTzNL8EmTHxZvAv0CpOPcLoW/ThHRI1Ejo/uY+Ar9l2qfXZiVTY6d//qDHWFdO9TE8RAOq4Ro=
X-Received: by 2002:a05:6512:3b98:b0:539:f51e:2465 with SMTP id
 2adb3069b0e04-53b348cad03mr3726018e87.22.1730120077585; Mon, 28 Oct 2024
 05:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4b5f1306-dc01-4edc-96d3-b232b930ddf2@stanley.mountain>
In-Reply-To: <4b5f1306-dc01-4edc-96d3-b232b930ddf2@stanley.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 13:54:26 +0100
Message-ID: <CACRpkda=5rSCjoW0ScNg3pFFOjgSQEv8v+0ZkAw-d0pkF5CaZw@mail.gmail.com>
Subject: Re: [PATCH next] pinctrl: spacemit: fix double free of map
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yixun Lan <dlan@gentoo.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 10:39=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:

> The map pointer is freed by pinctrl_utils_free_map().  It must not be a
> devm_ pointer or it leads to a double free when the device is unloaded.
>
> This is similar to a couple bugs Harshit Mogalapalli fixed earlier in
> commits 3fd976afe974 ("pinctrl: nuvoton: fix a double free in
> ma35_pinctrl_dt_node_to_map_func()") and 4575962aeed6 ("pinctrl: sophgo:
> fix double free in cv1800_pctrl_dt_node_to_map()").
>
> Fixes: a83c29e1d145 ("pinctrl: spacemit: add support for SpacemiT K1 SoC"=
)
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Patch applied!

Yours,
Linus Walleij

