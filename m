Return-Path: <linux-kernel+bounces-326615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF40976AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8A5B234EA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D91A2C2B;
	Thu, 12 Sep 2024 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SrauZmwi"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235A91A4E89
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148343; cv=none; b=VhNw6av8jkRTdy96kM33GGymVoALTtE1xgEY5rOQK4lXlSnWoR5My64M1gBgWIOhi/qQGYaE7mAmrosuyr/xvmKah0Z36t7thoWym5+NMcdZLxQwdksOZP7JPRih3bbZvGjYiHokWDo6uBYmeXBPhg4zuXBZeEBFCzl35KP/ssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148343; c=relaxed/simple;
	bh=XXqWO2yT//ii9l3KRjQXPc8FLHim6ZQatV7xee+2n/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDUc94YPnpQqO7BUDnIqNQOmU73zVvmZztaThRkZhtjtkvcCPgyhlyGU7Sp3gcmEQ117aFfDj1Y5lwPzfhlD9Yi9JgsSgLNrt+RhxXrBVH/Ja9xj1wbz+5ejwYaM5mL3F2MHO3RohTSY47XAWJQsE90QQ9HgyUhDHAzBHKa1Les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SrauZmwi; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4582f9abb43so6179651cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726148340; x=1726753140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ROrVvxpUOVpCOqDUYbk+Dw5AAWa4u/uZvSb0nkfTT0=;
        b=SrauZmwimIXsbi3eSM+0Htgj+O0TweNiDPgjMgOPKwS1GHvzXLmQWJWXo3m0JJq14r
         qmN57o8UraMAK5/QiotM05uYDOXNWBj9gmSQB+WTZwG4AJ5FgkZRVEMEfe0OxA5kje2Y
         mUBy9KE3JXu79DrhaKeptjd7hFNAqAPpgF0Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726148340; x=1726753140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ROrVvxpUOVpCOqDUYbk+Dw5AAWa4u/uZvSb0nkfTT0=;
        b=lAxV6wLqrd27qefzGwxAjZhlFo9hknmbvK33kMHS9nilUCIJmy2eU0yBNokcTABjQ9
         +8RozgIznC9juvUsyk5w70cjBoRiPXpIKtSYGC5C4heUx0hGrun8ej04Lp0MFinC8sRK
         9ZeqpF7XssoG5eaX/8HDq/xOtlSjUOcbdET0iWPktdBRYyNFYvW1uJhVNXCSSAzogg+j
         pzLk+sdJ5/iR9g08NWpopVpZh7K2glz7xwoTGnEifhxKvT47XXrEZh/Vg5GL5Vz2Nul8
         G29AyX2pnM2Cv/nk03lH/P1lQHzrIzU4Pb6JiKvaCPjiAkKwqkz0yIKcCLTocauX+SWj
         AWoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUA5X1OlqSz4Xcpo4g1Rg7T/ZHE0bd76Gxl8fA9cxuUtFcgFf8kVtBBpUjpKjCFK9KUb5sdVPC2O/UMw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo7ulbls/VMAG7329nhDamAmFr3pHUUW41wcTjB5lqF0vnhgiE
	FexL4ENgxXmrnUzZorX+uEuIU6Z4Cnw9Ya6Pe3Y/YO4ACqoMm93NaKjAgSZHP++GYkbcjhl2BfQ
	=
X-Google-Smtp-Source: AGHT+IGYhW47DYAZdyBZdzgALxlLtI4jwPXsHozYEXdSeQu6FUE6CqVQ4LsW+6Yv53aoGgpkKLVCFg==
X-Received: by 2002:a05:622a:87:b0:456:4615:3718 with SMTP id d75a77b69052e-45860443e5emr45294021cf.55.1726148340106;
        Thu, 12 Sep 2024 06:39:00 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e63c58sm53249281cf.9.2024.09.12.06.38.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 06:38:59 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf7ad1ec3aso7020406d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:38:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgUjzQUD3DVb5zWrek1wMc+Th6iv0dDcFJwxWgl7pg+ZvkJfFdUi5AoyDTyKHvY1HMmcSqD2Y7TcK/S3g=@vger.kernel.org
X-Received: by 2002:a05:6214:2b97:b0:6c5:50ed:ac3d with SMTP id
 6a1803df08f44-6c57351b1ccmr42400066d6.16.1726148338348; Thu, 12 Sep 2024
 06:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909132810.1296786-1-ruanjinjie@huawei.com>
 <20240909132810.1296786-4-ruanjinjie@huawei.com> <CAD=FV=XQ7uf_Y_WTv_6-DX1Mo=+RycKSyxf=E-f3TOKiuE5RMA@mail.gmail.com>
 <c662f0b9-31dc-8b97-ef3f-ea33f9fc62af@huawei.com>
In-Reply-To: <c662f0b9-31dc-8b97-ef3f-ea33f9fc62af@huawei.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 12 Sep 2024 06:38:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+kc1rKSDDo-Zx+CiuapoJ8izrCW0Wh-PfR7ivY_4bXw@mail.gmail.com>
Message-ID: <CAD=FV=U+kc1rKSDDo-Zx+CiuapoJ8izrCW0Wh-PfR7ivY_4bXw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] spi: geni-qcom: Use devm functions to simplify code
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, vkoul@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 11, 2024 at 8:53=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> >> @@ -1132,6 +1134,12 @@ static int spi_geni_probe(struct platform_devic=
e *pdev)
> >>         if (ret)
> >>                 return ret;
> >>
> >> +       ret =3D devm_add_action_or_reset(dev, spi_geni_release_dma_cha=
n, mas);
> >> +       if (ret) {
> >> +               dev_err(dev, "Unable to add action.\n");
> >> +               return ret;
> >> +       }
> >
> > Use dev_err_probe() to simplify.
> >
> > ret =3D devm_add_action_or_reset(dev, spi_geni_release_dma_chan, mas);
> > if (ret)
> >   return dev_err_probe(dev, ret, "Unable to add action.\n");
>
> It seems that if it only return -ENOMEM or 0, using dev_err_probe() has
> not not much value for many community maintainers.

While I won't insist, it still has some value to use dev_err_probe()
as I talked about in commit 7065f92255bb ("driver core: Clarify that
dev_err_probe() is OK even w/out -EPROBE_DEFER").

-Doug

