Return-Path: <linux-kernel+bounces-443969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F169EFE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C8328A4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30A21D89FA;
	Thu, 12 Dec 2024 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6nsrmso"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590701CEAAC;
	Thu, 12 Dec 2024 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039337; cv=none; b=U7UufisBECdSALF4fPzIhczZaVJ1SMwMn8WeSTGEXivZAEELKPxG9D1Ol3JpN/S5jstNaySeeRGrmanaPX+OctnKRTtY/PN5lF3R/5Njz9ZcezyaRIIzf2K9taWKObBD0CUL/Pw8uffYUqgt6rOF7+rYuyn4R7ku4wvotLiocO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039337; c=relaxed/simple;
	bh=KJeEqh9P+D5wKwY133jjVp/f7MLpthcGlZboaBFR+VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+Go+6lWCU9WEeBtLS1RlXpJOV1x7OPN1F39AhefJY/28QxOROvkRxXjAr1607evUnP9GJH6t7XoAknS45ws5eKldrv4IvdIIDJNiOUpAQM0nbq0g4AX7FOtVvQsqWK8x8QZQd9XDjVWIX0FgCv++iJZZYvJcXYvn1P1nZn2iyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6nsrmso; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53e384e3481so944719e87.2;
        Thu, 12 Dec 2024 13:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734039333; x=1734644133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnXmfYEr9PT7Is83CX8z0wrAPwuQ/xSME7IAcOpGTK8=;
        b=E6nsrmsopZdizVghZ8DyrtZxVc5Edbp/5huZuFyXpgzRbZC5Y66m4eZKWv+4ljZRVc
         v3ce7JrCVOc8dUf7Gu82WIFwA5gC+nAj0Q/jE0UfOV1kzrYEBX8e2nThBVIQGDc6RCSv
         W7w7i0g6ErL4hvnnzo3MjkPSn8Mnh6MWi/rJfsN1HQLx3LsDxuj33cgudl1Oh6LEEWk+
         Hz4QDTyww+IvO80wNO6AtoMLL2gMn2jtdTj8T+fYOE/3Sx+uZcLSqqz4JizPK8wh4PAl
         s+0oaifoEb8jrQXcNJKTwQFVdpW63p1L7LW9S7Pyskt5Y7D80s4KbwyM3NS6jhsdqfyr
         9DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734039333; x=1734644133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnXmfYEr9PT7Is83CX8z0wrAPwuQ/xSME7IAcOpGTK8=;
        b=k3HPYLhu87H0jrXoUKj4lq66uysq9spM3yEsQlO6oI8q5FRzePDu7oKRWM36ZDmY8V
         HeWvchupGgfRrqvbbw3rfMzs/+MJM8/XDtZ8aU20St2FM4lv+cNAXJHD0X+MK2tXIrfJ
         zvnsVI31PeapVmntnM6K2yxr9D6oVXovAGz4pdu7iaoJGoj7DqkMTVLPRa09HSgQ37Ak
         q60H2DFefabcluSn/64Xhu0wXBjBCc1bluYe/gy5VlcyO+ZG804Tk5OKpf+LFI+adfKO
         anjQ5jbQSDt2lZwAzUPCfkoK+2ofyvXSEmGlA/HCm5NV1/22uhmiQxv1Iifj/9q9G8Rn
         41NA==
X-Forwarded-Encrypted: i=1; AJvYcCUVHTbqlFCIoEAhkYdmXMTW7MlK6TNFFLcDo3oN9Q//7nIDeyLxaNG8yRNPpaRJ8QuzQEKu0FJxrWWI+Drp@vger.kernel.org, AJvYcCWCw3ruoqsLZs2M8hk+nn+RIuaA0Pl0Gi18b1MlM8ZyAhdSAHk/T98EHjYfSAmDrrzhO2Zf7n9d+LM=@vger.kernel.org, AJvYcCWpJ9tSVQuJw3e4S6AmxCEl/zCdJHG9xmqUHy52x5C143eqqXNUx95DqmDjfUXPRPYTeffyWnLou5k/aC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxljCZEtlm9QMerAJav+r4Fu3zcGwDotm9veQ2dcZIDZLFhdHvV
	g11uPykN583N0BGoIYH9qH3M3ouMcI+rsMMIgXp6UUl2ivUXkXVYMBjSOEzVdtVGQKuXm8U2sGO
	+UJI4TY/8gfeHH6vhN44jLqcIYdc=
X-Gm-Gg: ASbGnctdxAVqqzzSBrjo8a/rXJIVDJ57DEIiL2ey+QtPX3XzPD9zrjbwNdn4fmG4y3w
	CRoJOS6ThKJt1h+tq2WcEgKNgG7Yw7TTYb4SS+NxsU3PGBWVLU8aUaEdEDU+gEM+3aVlSIZV6
X-Google-Smtp-Source: AGHT+IFqXLVOS6tetzuIiVC1SeKpDz1DktGwGndsy0tvCJCIuFH/K0ZN4npwCq78ugCyZ4wrTGVLSvr3HOZXiLYW++E=
X-Received: by 2002:a05:6512:39d0:b0:540:1e5e:3876 with SMTP id
 2adb3069b0e04-54034134873mr713024e87.52.1734039333186; Thu, 12 Dec 2024
 13:35:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207193441.15767-1-yesanishhere@gmail.com> <Z1ggwXLAu+/Y817c@opensource.cirrus.com>
In-Reply-To: <Z1ggwXLAu+/Y817c@opensource.cirrus.com>
From: anish kumar <yesanishhere@gmail.com>
Date: Thu, 12 Dec 2024 13:35:22 -0800
Message-ID: <CABCoZhA1g4McaLtsQqZv=Y1UrEg4kmyMVjdJJTfDow0ho-WdCA@mail.gmail.com>
Subject: Re: [PATCH V5] Docs/sound: Update codec-to-codec documentation
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:06=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Sat, Dec 07, 2024 at 11:34:41AM -0800, anish kumar wrote:
> > +Boot-up logs will display message similar to:
> > +
> > +.. code-block:: text
> > +
> > +   ASoC: registered pcm #0 codec2codec(Playback Codec)
> > +
> > +To trigger this DAI link, a control interface is established by the
> > +DAPM core during internal DAI creation. This interface links to
> > +the ``snd_soc_dai_link_event`` function, which is invoked when a
> > +path connects in the DAPM core. A mixer must be created to trigger
> > +the connection, prompting the DAPM core to evaluate path
> > +connections and call the ``snd_soc_dai_link_event`` callback with
> > +SND_SOC_DAPM_*_PMU and SND_SOC_DAPM_*_PMD events.
> > +
>
> I am still not really following this, what are we trying to
> convey in this paragraph?
>
> What do we mean by a "control interface" here, is that referring
> to the kcontrol that is created to select the rate in the case
> of multiple rates? Or is it simply refering to the fact we call
> snd_soc_dapm_new_control_unlocked? But really that function is
> adding widgets, as I noted in my last email.

I mean snd_soc_dapm_new_control_unlocked gets called to
create the widget which gets triggered as part of DAPM path
enablement.

>
> Also what do we mean by a "A mixer must be created", I am not
> aware of any requirement for a mixer? The DAI link needs to be on
> a valid DAPM path, but I don't see any requirements other than
> that.

In my case, I was implementing a mixer widget that users could
trigger to enable the entire DAPM path. However, I believe it's
sufficient to simply state that there should be a mechanism to
trigger the codec-to-codec widget, enabling the full DAPM path.
>
> Thanks,
> Charles

