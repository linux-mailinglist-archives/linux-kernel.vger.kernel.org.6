Return-Path: <linux-kernel+bounces-513111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C9A341B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7393A5441
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A964523A9B6;
	Thu, 13 Feb 2025 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jemejRhw"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3130523A9AF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455998; cv=none; b=hmaISHExbUXhFUp5ZOmzNNralwm0+OHFblJpNiEW9l5giy+oSLYHIH0tssV0nXXYF6N6VP3N8JiHJDmEOU0vkIxxJriv1pwbhkUY5XLWQHxjLUMMmwkeZYvU3WghyVQf1O/vII0lmuIkVI8PW78sQb0/BZZn8l+cnOyFxDF/94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455998; c=relaxed/simple;
	bh=uvwJ81+uWpJgvczZfhN1U6bHIxTEKtHvjxJuBbDwwtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2JHEm9G968j+vyadF8qJ8Q4xMrXKS/BoXPcL/j3OjxlyBXzofBpHYtBeKHoyagYKNikqMy+Pyn8BpU86FpHrin44jgmCGlQDPlFHXvvnmV1c/0Khak8PE3PfkCTtEgR71pVnHcsjn+PZlX7xbUGRF1U87iCArFYZNQ8boMG7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jemejRhw; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 61DB23F2EE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739455992;
	bh=wAYCS0tXykg6XPNKlmOCWk97LsyZYiej+hy/OfVM+AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=jemejRhwWNpJgZiGjAkXQy6wAxKaX2oZPip3TdOt3hE4T6ILSNYVPtOoLsKe8YhLf
	 ci3T2F7yNB0ZAeS32VydKsef07NWf5Prnd+VHak47HOibO7WzA2T2tSOXzGv9Mx6Rh
	 lI58x+uoF3H26UJiWi51vcDa8Wo/4U3flDc0y6XX/OhTRzp5RpMMcpbrvxfT4HawfJ
	 QDVTc/9vCmA1bLBr/hDl96Ge5XhvQ+4b3YXMhwXqJwEQFia5JKc50AZFwZJznlb8Tk
	 SSK2murRMA3wFetypetWgQAnlJVEY4s30yu9JCwxb6px/MODP2+P6sFQiZi6q0p0Rx
	 ZOHQKfWdB9ZPg==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f81fc2248so19159165ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455991; x=1740060791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAYCS0tXykg6XPNKlmOCWk97LsyZYiej+hy/OfVM+AY=;
        b=dRNr6U1Ho8jv4IL2x6Y+XSQ4bXjLKHiSD7xBMIXz7Wo4tflRgnSDJfefh8SUnOTmCo
         M83RRn0lh1DbTlXvqjUzdsVB0AjzXrwt94VyXBWiB7jIh8kSMx5u1itBQCJRfSpv7Kz7
         0vVjw9azc7kc+Y4Hlv4LbPZ3RT51Arw+2+PWHT7Q8XqvLcQc/8ySgXO7dvtkbbUZTm9Q
         KdPvWK47I3gFhD2Pmsvnha2OKAzBNDWGYgFWAo3SonxWOZXiybLHpCydo3M9qCyWkniw
         kVK1qiX+xQ6yl4tUy7WsRQCePKNgiZUxFfOUe7d5Et7c4Ctz+3+mhtL3COOAX05Xu4Fk
         SRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqe+inZf4Ssj+sPsKh+j5wtska7IJxRgO33uDN4xo+vqU80u0acbA87NSHYSh10fcWK8MXL9DHvOifN8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHQadbMxzb6C3C3OHicGvfbouMxtC/uazMZ0W7u5MI1cwKo40
	YPSg+SBdZUqHLqR7iKRQO8P/1C7DCD7NTYNpdLf8zjstLoVpdemUnxtNqPRM4ypzpt+qp3iSwD7
	nTiGjzFi9y4uFXL85VWz6aLNkCup+24ie0rocHALisDVh3mtPOHMp3lvQBpyBrLDZ0S7Gpr6Rls
	FTvQ==
X-Gm-Gg: ASbGncuDMFksBZWYkzfY6Aq4nFdJ19RqtXREHqEc5BGIml/O5Zl6TMGVSwcfmF1BX99
	MVMGAucWbLzr9eadk9Fnia34IXvZ39Gg55w6eqgK43Bra2jDdFysWk6qJddbJGcFgBiOO8gVVA/
	qyLN/V8C44z2WrpcYGfaxU/SYd3Ekff0J7OJp/Z43ZzvFwnARxPBkMPYD8RhkxrmH5vzmmkln9P
	3ggZFVd7w/Aj4i4Ol7wXC24FQfktH3dMqCJVkcDxT4fpZc7oT2odLLKiUQfX7NN06mcH7VVF0/D
	UmxkeaA=
X-Received: by 2002:a17:902:c94c:b0:216:2bd7:1c2f with SMTP id d9443c01a7336-220bbad0fd6mr96931865ad.18.1739455991009;
        Thu, 13 Feb 2025 06:13:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0LbYDKu6OhXYYnEuKg+BPRg/KVjt55CtvNx+dM4QFYUCz7MQa+kKnvg1dAzsvyRIFbMJtBg==
X-Received: by 2002:a17:902:c94c:b0:216:2bd7:1c2f with SMTP id d9443c01a7336-220bbad0fd6mr96931545ad.18.1739455990704;
        Thu, 13 Feb 2025 06:13:10 -0800 (PST)
Received: from localhost ([240f:74:7be:1:5439:d90c:a342:e2bb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536459fsm13047815ad.78.2025.02.13.06.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:13:10 -0800 (PST)
Date: Thu, 13 Feb 2025 23:13:08 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-gpio@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] gpio: aggregator: add read-only 'dev_name'
 configfs attribute
Message-ID: <k6hkhysiocawfv5oftzt3l5s3l4wzvpxmd4m4xex22sgp4gvzh@nxhsugpr3wwx>
References: <20250203031213.399914-1-koichiro.den@canonical.com>
 <20250203031213.399914-4-koichiro.den@canonical.com>
 <CAMuHMdWUrHbizyKoLs-DJL43QvmE+Y=vCuGc+1yteYXYQOmURg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWUrHbizyKoLs-DJL43QvmE+Y=vCuGc+1yteYXYQOmURg@mail.gmail.com>

On Wed, Feb 12, 2025 at 03:20:06PM GMT, Geert Uytterhoeven wrote:
> Hi Den-san,
> 
> On Mon, 3 Feb 2025 at 04:12, Koichiro Den <koichiro.den@canonical.com> wrote:
> > Add a read-only 'dev_name' attribute to configfs interface, which
> > exposes the platform bus device name. Users can easily identify which
> > gpiochip<N> has been created as follows:
> >
> > $ cat /sys/kernel/config/gpio-aggregator/<aggregator-name>/dev_name
> >   gpio-aggregator.0
> > $ ls -d /sys/devices/platform/gpio-aggregator.0/gpiochip*
> >   gpiochip3
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/gpio/gpio-aggregator.c
> > +++ b/drivers/gpio/gpio-aggregator.c
> > @@ -732,6 +732,23 @@ static struct configfs_attribute *gpio_aggr_line_attrs[] = {
> >         NULL
> >  };
> >
> > +static ssize_t
> > +gpio_aggr_device_dev_name_show(struct config_item *item, char *page)
> > +{
> > +       struct gpio_aggregator *aggr = to_gpio_aggregator(item);
> > +       struct platform_device *pdev;
> > +
> > +       guard(mutex)(&aggr->lock);
> > +
> > +       pdev = aggr->pdev;
> > +       if (pdev)
> > +               return sprintf(page, "%s\n", dev_name(&pdev->dev));
> > +
> > +       return sprintf(page, "%s.%d\n", DRV_NAME, aggr->id);
> 
> sysfs_emit(), for both branches.

Will fix in v3.

> 
> > +}
> > +
> 
> Please drop this blank line (everywhere).

Will fix in v3.

Thanks!

Koichiro

> 
> > +CONFIGFS_ATTR_RO(gpio_aggr_device_, dev_name);
> > +
> >  static ssize_t
> >  gpio_aggr_device_live_show(struct config_item *item, char *page)
> >  {
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

