Return-Path: <linux-kernel+bounces-354170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5779938A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8031C23DB5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F291DE8AD;
	Mon,  7 Oct 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIG4LvZy"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693C1D31A0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334610; cv=none; b=kdf0M1xLlm8Ss2ZkHahfQCz0u0P0npiHTu1TWryKaXwxhI/kkDndFiw9xyNDsbEIowQitJ81ofhyyUIG+a43kmGnoWShRFC5aqFKDy7h/6MzS4mp3pUToEouWZ0To4nFZofJf4eOy2ycM7lUGig7KWWKapqB0CRGKbVZMzIh98Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334610; c=relaxed/simple;
	bh=xZJAFpMouvWG6zS3+F4DbW+1vh6OgnwW9o3CxkImSwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXy2l48QEIShL5nlIs9eAFWbvBYM7YNz5+8zuH1/jUUZe9OQd3rAv65HmqeaDPCU+Rz++6AvjlrwvHtYMYQOC/6cYjuxAdybYf2yOVStewO1cAc6HD/SceK44unjo0yA0/A9A3NuZFYNGyAEKU0J1CBUoiOjVg6CzuyJRDbOi90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wIG4LvZy; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2e4244413so20527817b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728334607; x=1728939407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZJAFpMouvWG6zS3+F4DbW+1vh6OgnwW9o3CxkImSwE=;
        b=wIG4LvZy4SprLAUZlZLSSTN1W5q7lElb6cmXh6B7i8CVIkmqR/mbxu06pjiHiiRcdr
         Wk5N55RrWPePND9+sIJkRAWItsu7tK3lU12CaTgdV5xh3ThtFWTugatFURz62AOpIQ3u
         ftfM5BBFFucvPIGGN/qQQQJShRezVaQXAThQ1UZXFmTTE7gtqwkEFT6rgQMqE9U8TypB
         Qf0Oag3kIo+H22PKVqCOBjqk1LjmpyyBVkZO2aweIVuCa0wrpe0MxfcywWHQLCjx3HAG
         f3Yy4WjIg8zcKk3FoKiW7dd7jfJ2Lp7quvKCjdm9QNnPAbmwfY6AZ8VwZgL20aKXdlhv
         rJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728334607; x=1728939407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZJAFpMouvWG6zS3+F4DbW+1vh6OgnwW9o3CxkImSwE=;
        b=GC8qTK7afeh2+WpbAkCDmR0T3arM50CmxK3XRGh66kGxIXAmmS48OVrgoNVPM3sfFd
         reHHPwfiYz7uEL6w3jNaYpqbsYYpmpku3j5eAL1rHZ3tj5gqAYunZRU9DnrvB8bqUyiT
         Ydq5DJQ0sMG/mK+5IeC8n6KQT1xgykIOOYdcFc5HCT84rvZ4WFkHrlrrbRkLGPbVhbL5
         j6cmfcm1mSj/d/+/0JjRvORVdYY13JX6baChYBbGpbq42vbl9+/UWNycnjCea21ewcnp
         Il+tVBMqLel6vEF93/3RUjPeTPanUETq2VH6YSI9MRbdUZpCfUInt37IIpmg71CoknOn
         2EhA==
X-Forwarded-Encrypted: i=1; AJvYcCU7/nA+N1zUrj1L+iP9DTGKXF39wWQCz42sKkHzeUzeSgMUoX7WvVuzsuahB0nNqtsrxsF50AiQiDrGrJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRYEUZOCGlLVNbfM596ejLxpQ5rAaF2zft2vdwbJhmwzKk9i08
	QHkGjyuzsmQfq+xqdaYvzT8+WxaJf5EvmgKlCySsNrrcvC4wLKFp2c5zp0m6eWrdBvmSr14EBwg
	LYAAySSPYnZ6OiKCAum2bFXi/0JC6j0uIaP/91A==
X-Google-Smtp-Source: AGHT+IH9JibtRn7hWF2aIVbPOxqpOoKC4zASzFHmnvgWSHK0W+0r5Z5oJL2SC0hZy1ZdJPUSNaYWkN0VZ/4nZ1grcd4=
X-Received: by 2002:a05:690c:2904:b0:6e2:145e:7733 with SMTP id
 00721157ae682-6e2c723cd67mr82791877b3.18.1728334607481; Mon, 07 Oct 2024
 13:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005140150.4109700-1-quic_kuldsing@quicinc.com>
 <20241005140150.4109700-3-quic_kuldsing@quicinc.com> <wzrj4vhrb4h3pe5dft7vqz2tl55txdyuciuxlysuck5isi7r4z@bs2ts3popy2t>
 <2eb53ea6-848a-48bb-8c31-83a118bc5a73@quicinc.com> <CAA8EJppEQKJ=oQh=TeFaP0z1sXDQhz=LN_TC4YygiLOe_EX6Tw@mail.gmail.com>
 <015c697f-5842-4797-89c8-7c6cc68ced49@quicinc.com>
In-Reply-To: <015c697f-5842-4797-89c8-7c6cc68ced49@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 7 Oct 2024 22:56:36 +0200
Message-ID: <CACMJSesF1tQyG85uLNbdsGqqq4xY39-KKwW=3QRMOcvpOCNsxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: qcom: qcom_tzmem: Implement sanity checks
To: Kuldeep Singh <quic_kuldsing@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Oct 2024 at 22:44, Kuldeep Singh <quic_kuldsing@quicinc.com> wrot=
e:
>
>
>
> On 10/8/2024 1:43 AM, Dmitry Baryshkov wrote:
> > On Mon, 7 Oct 2024 at 21:17, Kuldeep Singh <quic_kuldsing@quicinc.com> =
wrote:
> >>
> >>
> >> On 10/7/2024 1:00 AM, Dmitry Baryshkov wrote:
> >>> On Sat, Oct 05, 2024 at 07:31:50PM GMT, Kuldeep Singh wrote:
> >>>> The qcom_tzmem driver currently has multiple exposed APIs that lack
> >>>> validations on input parameters. This oversight can lead to unexpect=
ed
> >>>> crashes due to null pointer dereference when incorrect inputs are
> >>>> provided.
> >>>>
> >>>> To address this issue, add required sanity for all input parameters =
in
> >>>> the exposed APIs.
> >>>
> >>> Please don't be overprotective. Inserting guarding conditions is good=
,
> >>> inserting useless guarding conditions is bad, it complicates the driv=
er
> >>> and makes it harder to follow. Please validate return data rather tha=
n
> >>> adding extra checks to the functions.
> >>
> >> Sure, I=E2=80=99ll remove the redundant checks.
> >> Please see below for explanations.
> >>
> >> My intention here is to handle erroneous conditions gracefully to avoi=
d system crashes, as crashes can be detrimental.
> >
> > Please fix the callers first, rather than adding band-aids.
>
> I see your point and understand the emphasis.
> I'll submit v2 as per suggestion.
>

Just to add to what Dmitry said: when you see this kind of checks in
the kernel, it's typically because it makes functional sense for the
API. For instance clk_get_clock_optional() can return NULL and it's
considered a no-error situation but in this case clk_set_rate() must
check whether struct clk * is NULL and it returns 0 as if the
underlying set-rate operation succeeded.

On the other hand there's no such situation where a NULL-pointer
returned by kmalloc() could be considered successful and so we don't
do NULL-checks whenever kmalloc'ed memory is expected as argument.

Similarly here: there's no chance qcom_tzmem_pool_new() will return
NULL so there's no reason to check it and if it returns an ERR_PTR()
then we have to trust the user to check the return value and not pass
it on.

If anything: you could add __must_check to the relevant definitions here.

Bart

