Return-Path: <linux-kernel+bounces-341265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1C1987D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999641C22A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6D16F287;
	Fri, 27 Sep 2024 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P2YREVYE"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA911C01
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 04:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409663; cv=none; b=SqM1uHbK3nuEi1zMUpGrROsNihHfIyuLUVINkrfxow69Y2igr31unqpTtdrHeZlZ2DlcoBeHeR5Sc5OfwYaFgambhIJ98XwJ2tISQEM2o7AL7FmpZvRXHUBDbdA57zzIAjQRmSY73feak662wOAAKojZVUTEGi7LU8l6ds4ITKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409663; c=relaxed/simple;
	bh=/rigCc5vpyD5j9AYkIW/Sw3s5sCexLETUpveXhlJF30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lksLcAyiPbgmRQY0swO09r9i3kank1wbtIph7JNlZfm0x9Oa4F9gM4IvIbQbudB08+TpwEFFgvESHpua5EYppAvC0lEeKMq2m3+dgFD6dR9uSkmh5DWQf6maBYmVlsMOPI6HFo7z6zG09JH4PMI3npTbx7roL4e212UKcZxHk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P2YREVYE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so982134e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727409660; x=1728014460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts6Ybuhxy9EO97nxINn08YUin8kXfW9IAD6aPStdVq8=;
        b=P2YREVYEDoXLeaubx+0K3YrRZhMAFY6JadFFkkREnYZq6vJ+WZ979JQ96WeJkomJmZ
         adSeurEHic+9sz09nR50oebq8HM6bxjlC7v4lEMoAYOF4bBAqliA5Zf6Lh1dgqGzeVFA
         FOEPcaMSasplUZZbLdzCe05Mm0wY2ZZTeQQNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727409660; x=1728014460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ts6Ybuhxy9EO97nxINn08YUin8kXfW9IAD6aPStdVq8=;
        b=eNNicgP4O6XCKsvxg8rye4DockfXfZe8AlEaB0ZpTt+OQ3wzuAYSD7JpX6yH/zvF9i
         d+nyYJiHuXTdaA1l90tLrd4sozYiLm+G0PxFSwk/x4CQJJop+VyN9ElUs0OV8oEN6AiU
         dvLZ2d4hs48I9i/Pr9bZjTDM9xaA6lPgpwYF0IjaVJ4pgbxzcf6UUQyr5KzmOLAUc8Z6
         9+hB7JSqePM130s4m4/30WM/RlnPp43vijymQI9YEpIIuZTc7BcmJQQJCURq6kWxugRJ
         qIvjfkGowZaahZDfjfYeHXM3x19S1pgC8gcfJ3P/Qlt6727wkmmOmxfJAXUwoY9WjZwu
         AOsg==
X-Forwarded-Encrypted: i=1; AJvYcCUg/yg1hMn4AfDeeLOCcCFFJY4+nw0UsY7CNngNq7fiM/TWIVdVmnecfd1GGqMf6WRS+usu7jiBtyFMvT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7jeMpRCYk0bVwwzYqw8xt05S8Nui7DZXsv7FMEk+APzmPJXdS
	xbCHoADUUwy3q/K7FL/cswCHR8qTBZCr214KUCDHNyBiBPbN3jtXtWcR2V1+8+nFibYJARTNYxw
	4/nUrsrKSgRx+Hnzp8K5BlGK4AqWnv/Qo55pFuyBlXrCvrJY=
X-Google-Smtp-Source: AGHT+IFhILfvyN612dVfAZjt7mlHdsnT36bs2zlQCVH9UI+WtCiOa7LORMIXTip1YcFTiMjzEjST5u3lqpdVSQXGrdI=
X-Received: by 2002:a05:6512:1256:b0:535:6400:1da8 with SMTP id
 2adb3069b0e04-5389fc477eemr884467e87.28.1727409659514; Thu, 26 Sep 2024
 21:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925093807.1026949-1-wenst@chromium.org> <CAPDyKFqoqppLipOG1vK-8oU_6cMdZ3DV5Gxqhs5-+7+cQJ6=qQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqoqppLipOG1vK-8oU_6cMdZ3DV5Gxqhs5-+7+cQJ6=qQ@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 27 Sep 2024 12:00:48 +0800
Message-ID: <CAGXv+5Fot5BVxtAiEj==2u1ew7mGYkrS7=mTqeTMjTiEg8LNag@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] Add of_regulator_get_optional() and Fix MTK Power
 Domain Driver
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Johan Hovold <johan@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Pablo Sun <pablo.sun@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:49=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Wed, 25 Sept 2024 at 11:38, Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > Hi folks,
> >
> > This series is split off from my "DT hardware prober" series [1].
> >
> > Changes since v7:
> > - Added stub versions for of_regulator_get_optional() for !CONFIG_OF
> >   and !CONFIG_REGULATOR
> > - Added new patches for devres version and converting MTK pmdomain
> >   driver
> >
> > At ELCE, Sebastian told me about his recent work on adding regulator
> > supply support to the Rockchip power domain driver [2], how the MediaTe=
k
> > driver has been using the existing devm_regulator_get() API and
> > reassigning different device nodes to the device doing the lookup, and
> > how the new of_regulator_get_optional() is the proper fit for this.
> >
> > Patch 1 adds a new of_regulator_get_optional() function to look up
> > regulator supplies using device tree nodes.
> >
> > Patch 2 adds a devres version of the aforementioned function at
> > Sebastian's request for the two power domain drivers.
> >
> > Patch 3 converts the MediaTek power domain driver to use function.
> >
> >
> > Each of the latter two patches depend on the previous one at build time=
.
> > Mark, would it be possible for you to put the two regulator patches
> > on an immutable branch / tag? Otherwise we could have Ulf ack the
> > pmdomain patch and merge it through your tree. Sebastian was fine
> > with converting the rockchip pmdomain some time later.
>
> Thanks for providing some context!
>
> In my opinion I would prefer an immutable branch/tag of the regulator
> core changes, so I can carry the pmdomain changes for MTK through my
> pmdomain tree, but also because I would prefer if Sebastian could make
> the corresponding conversion for the Rockchip pmdomain driver. If this
> can get queued soon, there is really no need to have an intermediate
> step for Rockchip, I think.
>
> Does it make sense - or do you prefer another way forward?

Makes sense to me!

ChenYu

