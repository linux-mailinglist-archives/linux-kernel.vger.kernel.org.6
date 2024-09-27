Return-Path: <linux-kernel+bounces-342245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34091988C72
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 00:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DBD283680
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E37188A22;
	Fri, 27 Sep 2024 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7MMct4S"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96E188A1B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727476088; cv=none; b=lRpqtCi8cOYS/6NGIyDL9PrmtFX4qcKBVYdCLnMFZGwqiHc8FsPF+vCVHw4JO46i3IBxCGfAhkbIi1Z1bvTzw5P8k9+o6oh2VRg71tu44ED6sMJeRWf6GsZPQLVKB5A0qkeazI3sCPnMWtAODRTYE0GMMchDISYUw+8LdaLAx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727476088; c=relaxed/simple;
	bh=XkIN/tVCAIjL0hzwDUIFzpm7JyhkR+9SGViCFB7ACB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X04Porc/Zcs3eq4KDNRsqWXFE572xGXs7DVT1BiAjqS+tiCy5KYqc1cwMaGod0YbruqLf5cv/ug54TrvATgQae16sxnJFRBkzHU+o/w23S+/9yYUTmi1nvN4LAeEdQ9hf3hEy0aI1BBcpI6wr5g4o8VKeE+8zji8k0y6o5ubivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7MMct4S; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2133606a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727476086; x=1728080886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBAuCU9S6wg94yhn31JyydKYaBwmOnO2ppDjiOPOq5U=;
        b=m7MMct4Sy2TzXweViGW12JaknJVqdNWgWkRCiA0jBLcLvgHPgrEFkwh2zuCJOrTH/I
         utdVf6nFU6w00dWs8f1FvubC4BTgPJFG/WiYPfegQ7lR9AAX5sNEXOUXudGKjnXtrfks
         mXwxveL6qOoly7Svjk15uqWtpoBQj82PYm8EtzmQX7M3xtvtOfm+c01yxuxEKFeaesHQ
         a2cerXkDaydSYWIr73PjDm3lOF+5uP4kdle/aIpnhz6SNjLT2tp8VDYU9+I57gIenEQD
         gv6WtVaAStzbcjHdSVBvn3VtHrdD3dqS2yk6EJkijMdFNhE+f8qimEcbX8YBFUYQ9Ia2
         nIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727476086; x=1728080886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBAuCU9S6wg94yhn31JyydKYaBwmOnO2ppDjiOPOq5U=;
        b=Br96j8JwnAFgzJx+ZgJhBXr9xH+3SDZgGVvdfyr/wCeRER9dOQmT430crLY4SoumxF
         Jg6jpAMzF/qk1MfL3wLgprlYqv5n6kL6oru8i7Wm8fwGwBr05Yd/lPWQZE7NudYEYADU
         3XQ6T3BQDonA5anS/ldHCP7BR0Kcw/w5DWdKVuAr+jFZMyB/uGPb0HUGTxUEIC6Wc2g3
         c+9ZKhUcTgD07S0sT8VcWS+PKzmRf/Y9GqIyYUN9GGksgOdViGMg0qfL6R0QkErEYRTr
         LlcdQ8fyXKb4rJ1h4hgYN/REDGEJBF/scLaFvaoLxBq2CoGMQ88z0ZU3ksN3lN/+y/Bn
         alDA==
X-Forwarded-Encrypted: i=1; AJvYcCVgIcLIqUIRrbOCEKwmhSDbq7fdfJlWn1hltBu4BszIAlwoXn0CIyLsbQ2/yIMq7CfN6IyC3eHScAA9hwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdpOf3rm78SR9ZwOcnrNtkLl0npsWPNRIxS8ZW1U7BTJFhWI5h
	ici8uETboRRYn5gsbgAx1VmGEWu0h4fYFgcnikTXW7T+6HrmVGQf/if0XvPxyUWaPr5qCVTmv5L
	2c+3idRYsN76pSArdq46xzXi6uw9oLCxLqegy
X-Google-Smtp-Source: AGHT+IGCo17UUqd+dXC0Z05LSj9ay9OH4C4Yts2JHnU6MdS0imZHPabFMSuz2Urugb7f34NcE0/TH5f9RuhjCyaSCyw=
X-Received: by 2002:a17:90b:3786:b0:2d8:9506:5dfd with SMTP id
 98e67ed59e1d1-2e0b8ec777bmr5708666a91.35.1727476086008; Fri, 27 Sep 2024
 15:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926213729.2882045-1-marex@denx.de> <CAGETcx-q7+DGhPYd3QrsPh7O_0HU7T=NhaJYp0Fu7YW2zwbo7Q@mail.gmail.com>
 <e32ed329-b012-44f2-854b-80a8b0efc4e6@denx.de>
In-Reply-To: <e32ed329-b012-44f2-854b-80a8b0efc4e6@denx.de>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 27 Sep 2024 15:27:26 -0700
Message-ID: <CAGETcx95ZMBJR0F-3Cr8++1_MwiMCPHiwfdx7m5q0XDAiGG75A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] soc: imx8m: Probe the SoC driver as platform driver
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Fabio Estevam <festevam@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 2:55=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 9/27/24 1:39 AM, Saravana Kannan wrote:
>
> [...]
>
> >> +static int imx8mq_soc_revision(u32 *socrev)
> >>   {
> >>          struct device_node *np;
> >>          void __iomem *ocotp_base;
> >>          u32 magic;
> >>          u32 rev;
> >>          struct clk *clk;
> >> +       int ret;
> >>
> >>          np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp"=
);
> >>          if (!np)
> >> -               return 0;
> >> +               return -EINVAL;
> >>
> >>          ocotp_base =3D of_iomap(np, 0);
> >
> > Using devm_of_iomap() and scoped "whatever it's called" might help
> > simplify the error handling.
> >
> > So something like this for np:
> > struct device_node *np __free(device_node) =3D np =3D
> > of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
> >
> > And this for ocotp_base:
> > ocotp_base =3D devm_of_iomap(dev, np, 0);
>
> This would fail if OCOTP driver probes first and claims the memory area
> with request_mem_region() (or devm_request_mem_region(), used in
> __devm_ioremap_resource() which is called from devm_of_iomap()). I ran
> into this with ANATOP, which is the other iomap()d device here. The
> of_iomap() does not use request_mem_region(), so it can map the area.

I'll take your word for it.

>
> > Would mean you can delete all the error handling parts
>
> All right, let's do this in separate 3/3 patch , because the amount of
> changes in this one patch are growing to be too much and difficult to
> review.

Sure. If you can't use devm, I don't care too much about just cleaning
up "of_put()" error handling. Your call on whether you do a 3/3.

>
> [...]
>
> >> @@ -212,8 +240,11 @@ static int __init imx8_soc_init(void)
> >>          data =3D id->data;
> >>          if (data) {
> >>                  soc_dev_attr->soc_id =3D data->name;
> >> -               if (data->soc_revision)
> >> -                       soc_rev =3D data->soc_revision();
> >> +               if (data->soc_revision) {
> >> +                       ret =3D data->soc_revision(&soc_rev);
> >> +                       if (ret)
> >> +                               goto free_soc;
> >> +               }
> >>          }
> >
> > I'm glad it's working for you, but I think there might still be a race
> > that you are just lucky enough to not hit. I think you still need to
> > fix up drivers/base/soc.c to return -EPROBE_DEFER when
> > soc_device_match() is called but soc_bus_type has no devices
> > registered. That way any drivers that try to use that API will defer
> > probe until this device gets to probe.
>
> soc_device_match() returns a pointer to soc_device_attribute or NULL, do
> you have some other function in mind ?

No, I'm talking about the same function. I'm asking to change it to
return ERR_PTR(-EPROBE_DEFER) instead
of NULL if no soc device has been registered yet.

And you'll also go change all the drivers that use that API and are on
the IMX boards supported by this soc driver, to handle the
-EPROBE_DEFER correctly.

And this error will only get returned for boards that do async probing
and using a platform device to register the soc device. So it's
not going to break everyone if you do this change.

>
> > And then you'll have to look at all the callers of that API for the
> > boards this driver is meant for and make sure they don't ignore the
> > error return value. Just add a WARN() on the API to figure out all the
> > callers in your board.
> >
> > Also, you might want to check that your list of probed devices doesn't
> > change without any async probing or this patch vs with async probing
> > and this patch. Quick way to get list of successfully probed devices
> > is:
> > # find /sys/devices -name driver
>
> It seems OK.

Good to know.

-Saravana

>
> [...]

