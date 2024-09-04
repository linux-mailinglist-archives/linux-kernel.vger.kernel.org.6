Return-Path: <linux-kernel+bounces-316009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A996C9C7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094D11C24E25
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF316F839;
	Wed,  4 Sep 2024 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YiLVo2ta"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE041547FF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486684; cv=none; b=Wj1d7NsLmbU5U2nBj6WVFj/YwJXUAKytasKY93TZoMEKU70zF2S0Qzle/oQ4qc7xFrQJuD4CPtGRfHs5RofdEh9tU1sMhXauNn2oF3u2/IU15f64uVd7gUSdZ4w7HV9Ha8TvVjJzo8XY1KN9fTk0YST0eFKKY0bTYbmxXnorctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486684; c=relaxed/simple;
	bh=knUk5g8ScG6jaMqCjtTQXGlVYSsfYw20xNj43ODq8mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ai9t4gD7wYAvY8lCd4xBs3elJcaEtDKKa8koEVpMdLO7Wp32CLJT11oZnqNhwVI5DTOALtl5zCQENb7xzid7YFnZPT7AkE+scBXC9I1yjo4Cf3TTzcqxkkoEqxCmTbl1PY8ETcgQjKVJ3TPACrkkwiYD09vU5FmJDo5zAM4VjaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YiLVo2ta; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-456954d0396so554751cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486681; x=1726091481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXSA8W0aVMFFsXPo/UPncBkp5lzvV+GsF0QFk8bga9s=;
        b=YiLVo2tagvEaVXBUynwJehLf4zzXUvX1n7XCQDnl/up0tq33LEVrdTg38BthyuYcKz
         1brWsbeytYhi09PwumE/W4Qd3FG/gLb49/A5m95t8eiMP5topcRp0Z9wJt5WxQaDlf6U
         KG9Ahx3EQUD3igh80G5qKNyPP/e6sO5s7bqMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486681; x=1726091481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXSA8W0aVMFFsXPo/UPncBkp5lzvV+GsF0QFk8bga9s=;
        b=dtq+4l8qmfpYKVRMiIH49AB07AdfbWLNuodUZaJ/q6VilWLuW7RQYla/BkpB2s3O4y
         3e1IdebQINa7lnUIQ8IV/rZeClWxWHMS7mUAGjpdxdB76ygLwZ6vHgDmsYp5evAH43yu
         kzC4TWw5Zgklrjhj70cBvllUGtjxg5ARaN8LRJKOWa8GVcUYRiJJBc7d8G/XXUaBnYjg
         /6JG+q45Ap5PtvVZASjB0eOJle0wPdvE5TGh7+tjoWFa7sb1swWsV73wpHYionvf4gcv
         tl1R8uQyFq+/Db7C9O3mx5PUU1G/NvTM+RB84iRa65t6xK0gYZO4QbFc/tXrM814dUoT
         EeDw==
X-Forwarded-Encrypted: i=1; AJvYcCXaQLljs9kegeWSz/8fhH1a0pu8v0aRtRkGFuzGlxghCiLuXztwYd2Jf/aoLg3Hc+cPT7QSS2UPF5j2GOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBxltuy2WqnbuVUMPnS5ZZbgmT7WDh9jFE+bNwGHTAVwZ5+kJ
	kTwZnjSB+yZwtniRaTgMulUpS1q7Qc+LesPRKIoOBmJ0j7+ug1TncWhZpEvLtfJ7vRyxUvyWOdk
	=
X-Google-Smtp-Source: AGHT+IGGQnDRocbc6pS+mT1W1yx+L57bjZVOjn3TgyH2EUvt3zuxLD3r8waZCf1IAfYhiDn1Hc8R5g==
X-Received: by 2002:a05:6214:4988:b0:6c3:67d5:aa1 with SMTP id 6a1803df08f44-6c367d50e15mr130717136d6.10.1725486681489;
        Wed, 04 Sep 2024 14:51:21 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b36092sm2107051cf.38.2024.09.04.14.51.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:20 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso516306d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:51:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZNbzx6Kc5mJAQxwz5IZTtZxvhJAvw6SFKgixLWBGDG/oBJ3g5e2BrFe6Me2Z+Lrg6QqZoXHOs3VVjOcg=@vger.kernel.org
X-Received: by 2002:a05:6214:5d0c:b0:6c3:5aec:4504 with SMTP id
 6a1803df08f44-6c35aec461emr191088526d6.28.1725486680181; Wed, 04 Sep 2024
 14:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-3-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:51:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UH8dLB6ebCXGeF2t5Bi5EhYrumLDnSV68fg7qzdPCQMg@mail.gmail.com>
Message-ID: <CAD=FV=UH8dLB6ebCXGeF2t5Bi5EhYrumLDnSV68fg7qzdPCQMg@mail.gmail.com>
Subject: Re: [PATCH 2/8] serial: qcom-geni: fix false console tx restart
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 8:26=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Commit 663abb1a7a7f ("tty: serial: qcom_geni_serial: Fix UART hang")
> addressed an issue with stalled tx after the console code interrupted
> the last bytes of a tx command by reenabling the watermark interrupt if
> there is data in write buffer. This can however break software flow
> control by re-enabling tx after the user has stopped it.
>
> Address the original issue by not clearing the CMD_DONE flag after
> polling for command completion. This allows the interrupt handler to
> start another transfer when the CMD_DONE interrupt has not been disabled
> due to flow control.
>
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Fixes: 663abb1a7a7f ("tty: serial: qcom_geni_serial: Fix UART hang")
> Cc: stable@vger.kernel.org      # 4.17
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

This seems reasonable. I guess this can end up causing a spurious
"done" interrupt to sometimes occur but that looks to be harmless.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

