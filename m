Return-Path: <linux-kernel+bounces-321321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCE69718A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6CD1F238B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1FF1B78EC;
	Mon,  9 Sep 2024 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZXBrXwPT"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F841B6525
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882683; cv=none; b=TDj74IMeYZ1+YKcALIOhZHr98CDq6HYMM1LjWVqBhJRVGf65LJBU+WwM9HJwx2boTTix1nJOHB7ehlMZZlsCb6SUJxc1XH6v/4BVhYCiA7vnf0uCJzF+9PkYjFjHMyIH6Aw/eCzgPrQrxlGJe6FSMDtHzZQBovrHu9qnxVPavMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882683; c=relaxed/simple;
	bh=BbWjoQ45d+g8AqhbdV0mu/mdMLVinfQ53fl8AVSz1Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohReC7QlSmNXvRjy9TTsFhbq5tD6fGT6sRq0fGCd81cRPYw+TitGACSNJR3AGsAlVUfxcAvmiR0XrJj4vtrErNhWGBaNPMwGjI6pclNGATMZ/x3yWEkDWDyAuBuK5aZPiPOmnQzFRUPFxyj7l8JodLvXIup24W1D3cBy3WpODgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZXBrXwPT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6d7073a39dcso46408137b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725882680; x=1726487480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2DW9+4+5dkfE7I6UYkBdI6PKZkJx34MPOXwo0S6pwi4=;
        b=ZXBrXwPTcTDP2CwflXldP/MtoXpUZLNF4twAtf2ZQC9GXjLdFf7VGclL8iCtO7wJ5Z
         GOrnQTYLL7wgcQnkKYvCFWER/dJTjOzW/ARn4idKZTmNk1MlmMxDJIB0Lyx7kCHwfwfS
         QK6uZstiCoq19FLx6vcYLXMCBj5ub8TohHXHFwzevr5t1Pb1txuYnBTWNIjo+kTmvLby
         o2My44kHiYtWVbjjw8P6nsJkdv7Ok3BXPPhX/D+cSW9atKeBELzmQyZjzCseaTnJ0EGh
         6a279C/f+0MOITPQpf36v1XJ9qTSpP8MyhkolqAqizhBV73MDnoXUXpAjr8NQN2kqWa9
         PHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725882680; x=1726487480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DW9+4+5dkfE7I6UYkBdI6PKZkJx34MPOXwo0S6pwi4=;
        b=HCnCeVghv+v8Kwq2SiBCpOWrUiuGLmMDpMum1ZEDoASjFu4lTGWQTVgC8jZUs8gP5t
         XrR1sEs4lOdn46/BLCSzZ3UUAqw2uDjbB69/S18mAJmvPzf4/x0BYqTbtau50WQodib8
         ZClCHmA2i6fpmIWYnAz435G5vswpp0VZX6pulkUaVY3w31e+hdRPb9E3z2wMlxknDlFq
         nPGyLy6KOwn9IiNljsHplUKF/y2cmWssAZI2qeLmTqQXzRcSC2rBBBlJhbt1XjteolWg
         PYtBU7msmDFBuhYGM5TkMqEq5KALJfX7o9Gum+Xa+hQTtQx2togdaNYVT3SnsfgE/1Hy
         NDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhQb45ztfhzkYT4MLRhDMg9yvXfSsaqWvOLHoIprh8FwAhSeKyeRXhAu7mkKpzriGHMcPexiO+FtPBi4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuO+/6v2DI1NZO+NHs/qySP1JJ6We1N3EsPgh9KWk/A9AEfSvY
	SU8JuzQwiqutOOPQfAGv3fBbPaUOoY7NLzGDUWECdHyf/dp/b3hcrWXCK4PHke2HXNa9IrP91Vk
	TxTsx8AdiEvs4Lk+nB3D1ilEvbGx/aWtKc64hSg==
X-Google-Smtp-Source: AGHT+IEMTaW+rWSxBziYnJcShG+IJ94pyw+lUFZaTrGyjB3BTvwxhatfwf6+foBYAXccdSu//5Pp4I9bSN82zQLDkXE=
X-Received: by 2002:a05:690c:3384:b0:6d5:6718:e5d2 with SMTP id
 00721157ae682-6db25f48dc7mr130087127b3.3.1725882680477; Mon, 09 Sep 2024
 04:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909073141.951494-1-ruanjinjie@huawei.com>
 <20240909073141.951494-4-ruanjinjie@huawei.com> <45m7oruivszoiesijmdr66oeatvr3ff6ores4lx4kbus2ti552@5sobv4hk7laa>
 <5487bcb2-7792-e3b3-5972-d224df61b9da@huawei.com>
In-Reply-To: <5487bcb2-7792-e3b3-5972-d224df61b9da@huawei.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 9 Sep 2024 14:51:09 +0300
Message-ID: <CAA8EJpp2H4uGieVXj8varne2H3sAJhponApj0-baM1rcaOTCBA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] spi: geni-qcom: Use devm functions to simplify code
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, dianders@chromium.org, 
	vkoul@kernel.org, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 14:46, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>
> On 2024/9/9 17:49, Dmitry Baryshkov wrote:
> > On Mon, Sep 09, 2024 at 03:31:41PM GMT, Jinjie Ruan wrote:
> >> Use devm_pm_runtime_enable(), devm_request_irq() and
> >> devm_spi_register_controller() to simplify code.
> >>
> >> And also register a callback spi_geni_release_dma_chan() with
> >> devm_add_action_or_reset(), to release dma channel in both error
> >> and device detach path, which can make sure the release sequence is
> >> consistent with the original one.
> >>
> >> 1. Unregister spi controller.
> >> 2. Free the IRQ.
> >> 3. Free DMA chans
> >> 4. Disable runtime PM.
> >>
> >> So the remove function can also be removed.
> >>
> >> Suggested-by: Doug Anderson <dianders@chromium.org>
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> ---
> >> v3:
> >> - Land the rest of the cleanups afterwards.
> >> ---
> >>  drivers/spi/spi-geni-qcom.c | 37 +++++++++++++------------------------
> >>  1 file changed, 13 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> >> index 6f4057330444..8b0039d14605 100644
> >> --- a/drivers/spi/spi-geni-qcom.c
> >> +++ b/drivers/spi/spi-geni-qcom.c
> >> @@ -632,8 +632,10 @@ static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
> >>      return ret;
> >>  }
> >>
> >> -static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
> >> +static void spi_geni_release_dma_chan(void *data)
> >>  {
> >> +    struct spi_geni_master *mas = data;
> >> +
> >>      if (mas->rx) {
> >>              dma_release_channel(mas->rx);
> >>              mas->rx = NULL;
> >> @@ -1132,6 +1134,12 @@ static int spi_geni_probe(struct platform_device *pdev)
> >>      if (ret)
> >>              return ret;
> >>
> >> +    ret = devm_add_action_or_reset(dev, spi_geni_release_dma_chan, spi);
> >
> > This should be mas, not spi.
> >
> > Doesn't looks like this was tested. Please correct me if I'm wrong.
>
> Yes, you are right, the data should be struct spi_geni_master, which is
> mas. Sorry, only compile passed.

Please perform a runtime test or mention it in the cover letter that
it was only compile-tested.



-- 
With best wishes
Dmitry

