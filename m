Return-Path: <linux-kernel+bounces-569847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D8BA6A83C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337533B8CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148D1223326;
	Thu, 20 Mar 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yH341I71"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E422157F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480242; cv=none; b=ph92w4RyNWEHbxMvbrpOJIP3rlayrzh1MUCizQ1e6+DOYeQ6D+1SMfni/EFM4geI65L56WzzoHC9cv7nw2lD2FtQfgMwYMsQc62deD90UUQXfYWjuwV9u/XZUbFX9agF2Ji6AOgujgEkw6rvFiS4/MQjs5FN/jYUppTJ5sA8sp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480242; c=relaxed/simple;
	bh=IlVHcIUwTHDGDzWDxXw5mj5DevpjPK7OG62Ebrk4Y4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvDWkI8ekt9RUYCUSe8uO/1fU1foSxYybnPQM4mDn7Fzn5HOEa0BXZHNO6mor5MiTpu8zaWu1xWUJSshB6ouBTEcml+SjKqXsL20zfpSvxeb4o3TDhTz9QG0NrZu7BRXfeAI1vSycy50NdbdZfkF1EManNBfAa8DqPShflNUO7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yH341I71; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fd80f30ba5so5654927b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742480239; x=1743085039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xySvCJOLXrJepe3VbecFXnHY3VhWrdBNrIlRTw8Fv1g=;
        b=yH341I713lDiSX1SY3WFEQA7JglWeuuC38Ol45MeEcnrxHS1VqM39X6+C5gVJOSC2+
         ZGMThva2x7TJeYf756XsosMAqoIggCW9FfgecGRkicoyLLp2Ec7S5rc0icfqZ6edTETM
         qktyBuOvF5VNVJHeh/4aHMQ4IZLbiuxgHM4FhODXv7voLi35xvvX4yyFkBr1H9SrHfET
         D8O5XCr8U9JfLdwOZUtZMINP0Gxp/0lg4t5RE0PbcxPh937L5x05e07jLfqEFF/ZgTg+
         8C8CokPFk7cLI5F84OOZ9HJD55pkrldGM/+CqOqtbuuOQuGTusYqMokVtVFbyIV5CGsk
         Lo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480239; x=1743085039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xySvCJOLXrJepe3VbecFXnHY3VhWrdBNrIlRTw8Fv1g=;
        b=oP9sSPo0DctFUNKitpkPtKT5uP10xmQ6uqRlMLLFEfWa9dDQMMs4txBnbLgw1x3VYX
         MRpcZl6Aa31bQSeyiXiSrOal90pIF+/W7XlTzyiRVFR+e57mklzGfSsRJGbn4xqXJbNA
         UHIjsTh0hEg3ZFxBhA9O1oi7W/MeCWk+DUJqSrU2SADagLXp8bs9ccC8U3cxw8Glm4YO
         yy+dxkvhelzDnNhBuGBi3AFP3Knis8xL4B6OhB2tR0sdnkuo+VitscNsrX3eWu+TbuVN
         i4Hsgrs+aL4IaWfHYxXWEviNSQQvDHB6/WysXpVeCAgNS4YOzPIi6mMC7U8QblW771qy
         fE5A==
X-Forwarded-Encrypted: i=1; AJvYcCWH4OHdOPeApUK8EV9kdEX2MDpnHGE6VI4DE59PTibcMJgYF8BFTRp+bfUjezZlnaK+SizjKBYAE9XUA84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXNDkc4UuttdwFdhWc0OoRCZJf235kwOwX2FPbMBTM+HkoOU+
	zWaF2PF5eI//Vry+BbGh1fosDVY2dv0jDqqTbrLQMldUJXwT6FdoxqnB7G8RYZh7b/JkimAGv62
	RDt+vMz4ecTZ0h/4u0UUSUpkQkp+FwJ7C+p/HzA==
X-Gm-Gg: ASbGnctkYlb0THwSPTtwHagUzbVBn7gx/ho14RPJnWdFy+etltdvnGiODY4CJIwe6io
	Zr9LoCWS5WrGupPYVktpb8gjJCE9gncXQOufLTqnfsyqFZzM/+C0W9XKw7EDBNpP2kfhn4Z+eak
	gVIisAACuowRHmexrhbM6dtvZwcVwhpPcSnRwN3g==
X-Google-Smtp-Source: AGHT+IGgko416faeQRVE2tkudUuv/QKn021Rg6RvuC8kA3YkTzF42evnEbm/C8UtKjUS0Ha5DCyXu9VOZNGFENIJ0+k=
X-Received: by 2002:a05:690c:48c3:b0:6fd:4670:80e5 with SMTP id
 00721157ae682-700ac6e4fd7mr46108777b3.35.1742480238782; Thu, 20 Mar 2025
 07:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314195021.1588090-1-erick.shepherd@ni.com> <5081fa69-32cb-4fd4-bad5-5f33032efc39@intel.com>
In-Reply-To: <5081fa69-32cb-4fd4-bad5-5f33032efc39@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Mar 2025 15:16:43 +0100
X-Gm-Features: AQ5f1Jq7_vidRskaRn7KoiZCLYWPvDdfRXWjX4kSgM-fVSs5UbHOgXr8XZ3krpg
Message-ID: <CAPDyKFrOWHGVNHtKpaY02AXV9AV0NT6LoK2grcN9FTQmVOj7kA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: host: Wait for Vdd to settle on card power off
To: Adrian Hunter <adrian.hunter@intel.com>, Erick Shepherd <erick.shepherd@ni.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 08:26, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 14/03/25 21:50, Erick Shepherd wrote:
> > The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
> > lowered to less than 0.5V for a minimum of 1 ms when powering off a
> > card. Increase wait to 15 ms so that voltage has time to drain down
> > to 0.5V and cards can power off correctly. Issues with voltage drain
> > time were only observed on Apollo Lake and Bay Trail host controllers
> > so this fix is limited to those devices.
> >
> > Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
>
> Can we leave a blank line after the block.  It was that way before.
>
> With that, you can add:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next with the suggested change, thanks!

Kind regards
Uffe


>
> > ---
> >  drivers/mmc/host/sdhci-pci-core.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 1f0bd723f011..b1f7c11ea61e 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -610,9 +610,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
> >
> >       sdhci_set_power(host, mode, vdd);
> >
> > -     if (mode == MMC_POWER_OFF)
> > +     if (mode == MMC_POWER_OFF) {
> > +             if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
> > +                 slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_SD)
> > +                     usleep_range(15000, 17500);
> >               return;
> > -
> > +     }
>
> Blank line here
>
> >       /*
> >        * Bus power might not enable after D3 -> D0 transition due to the
> >        * present state not yet having propagated. Retry for up to 2ms.
>

