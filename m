Return-Path: <linux-kernel+bounces-222544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763F991037A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEDE2B23BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA253307B;
	Thu, 20 Jun 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GomE+gFF"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2429175562
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884436; cv=none; b=jFmcBVwXRyQ8z/D92TTBiKFZ9yJxzQfLvefCn/ShrfIjSjHasAR7cB7Fii+nXqUQ7TdyYmzW8LhRS2qDQMP1DoU3v+olzt5ZeUcy0TYrJ5aEuU2G9dCnhV6tHKKFeofECyYn4zrKATV94tNifgkPh0cCZqUf6bkQPveD4tFrEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884436; c=relaxed/simple;
	bh=x+qABZ4JfmfGmpZHBp7+niF77ec63+ZO9qrC0sEi3ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzMVTel6UyvQZj12p30v9Xz/v00kctfE199j7Mk092bX3g4HE4ZbUVEVUb/77SopwAcShOxPrpnLocdhgLrxVOEC0/AL65mQisLccRNj09K0z0BzlQAQurq2lHt0a6JuXEH7yM+shnyYDpWMVGzxvIaiPJLHsqD1AtQpH9/+KRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GomE+gFF; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b53bb4bebaso394794eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718884432; x=1719489232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cjrKq/3Qh8NTVOb/zVT+vutzDEvUB3oaVogbIVhMr70=;
        b=GomE+gFFDiArOQ6PzL6cmvRa9sNcRK+dUWsWl+FnldHpwvHsicv73P3A29jvy+o1u0
         K3VszaSDXKfY9zMfoyAOQidukLCtmrXx1UEey/kEUVI/UfmQPBPIB8lniI3ThArVNXbg
         R2B4Ui+G0ZHiT6KJ2g0adm6Oee922hlnFBqvxbKeQRXt1bX5U8Re39LMUmOGH34YjiDZ
         E5rHSIiXAMVdEuH96GMWiIgiI3cfghPeZvsjLXFvtmClBWQ4MH/pCDBzq8qA3h5GIxRm
         h9SD+41CzwfVDChWHnG/GR88tF7/WHMqT5L1KSV6ltN8zhS7w0mV3HLSpZgOQDUy3aHX
         h1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884432; x=1719489232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjrKq/3Qh8NTVOb/zVT+vutzDEvUB3oaVogbIVhMr70=;
        b=otNRqt/zI6hkITN73CgHfVS0FObe8xQ4/qOYJ00giV7fnqSOxAhpVYt3PVfgV3YOfj
         Sd5pp5xqW2nAf9ZxOgSS1GfsfUJf3zDsUMG20TdBvOWkDctIA7MDLjssEhHBib9t3OIz
         s1SGFc+poySINsyWxEp02Yw+3Zc9nM7LHP+r2TCjp3yfvGXJLgxr2WLel78AGRTjPFji
         K+MfdgVDs6InrEighEIgBG87DcTNT31t1Zpaue8DNIJkgugg9EVMnozvI+tXextuBibF
         DPAFx1FIaNo481jB5Gq6vEUExGgP8QI2iTRMz1S5sMHucvG+zBUNu6zvs7sV/qslz1aZ
         3fag==
X-Forwarded-Encrypted: i=1; AJvYcCVQ5lKJl6JnwMPhapwvr/7b8RJ6ABqg1YZFfYt1FvM/EZq1PDG+lD8IWHwjWZU9P38heAql9uInxA00FngHXmr/CywyAaVNR1//z+FG
X-Gm-Message-State: AOJu0Yy9JAboZH0U0LWrW+S4jh21Xhi9G3r7y4XQrLIzRlic9h90+Z1f
	SnhLBhKAmPO6mgnEQDQz7q0zKwO+nxFPBdxrWWUH+AI5yu2GrRj995CvJy37dayqpCHlf+bx5sk
	A10G68ZEnjgYnNOS/KMiFsdiyoYmSG2yI+bQ0lg==
X-Google-Smtp-Source: AGHT+IFPx+/U0MCQcAmhqRdoRS/mrygvKBapXgwNhMr/lYOA6Js+H/0uIcES6GdbOZI42Bp3HEwrbbkdplWrAB8inzg=
X-Received: by 2002:a4a:d285:0:b0:5bd:c0a2:c349 with SMTP id
 006d021491bc7-5c1adbeae27mr5662760eaf.4.1718884432634; Thu, 20 Jun 2024
 04:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620112446.1286223-1-peter.griffin@linaro.org>
 <20240620112446.1286223-2-peter.griffin@linaro.org> <73d2002a-9afa-4cfd-b835-6908d64586d6@app.fastmail.com>
In-Reply-To: <73d2002a-9afa-4cfd-b835-6908d64586d6@app.fastmail.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 20 Jun 2024 12:53:40 +0100
Message-ID: <CADrjBPobNnneOy2EuT9jNtJAxa+Cz-a-Jcy-==LE55PbOo7LMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mfd: syscon: add of_syscon_register_regmap() API
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Saravana Kannan <saravanak@google.com>, William McVicker <willmcvicker@google.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

Thanks for the review feedback.

On Thu, 20 Jun 2024 at 12:40, Arnd Bergmann <arnd@arndb.de> wrote:
>
>
> On Thu, Jun 20, 2024, at 13:24, Peter Griffin wrote:
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> > Changes in v2:
> > - Keep syscon lock held between checking and adding entry (Krzysztof)
>
> Unfortunately you now have a different bug:
>
> > +     /* check if syscon entry already exists */
> > +     spin_lock(&syscon_list_slock);
> > +
> > +     list_for_each_entry(entry, &syscon_list, list)
> > +             if (entry->np == np) {
> > +                     syscon = entry;
> > +                     break;
> > +             }
> > +
> > +     if (syscon) {
> > +             ret = -EEXIST;
> > +             goto err_unlock;
> > +     }
> > +
> > +     syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
> > +     if (!syscon) {
> > +             ret = -ENOMEM;
> > +             goto err_unlock;
> > +     }
>
> You can't use GFP_KERNEL while holding a spinlock.
>
> I think the correct way to do this is to move the allocation
> before the locked section, and then free it in the failure case.

Thanks for spotting this! I'll update as you suggest in v3.

Peter.

