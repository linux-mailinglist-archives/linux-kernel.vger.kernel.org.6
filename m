Return-Path: <linux-kernel+bounces-195993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7AB8D55D5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365DC1F2397D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02308183070;
	Thu, 30 May 2024 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6mtiSRc"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB1F17545
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717109777; cv=none; b=V167+wiV0r+dmqVosVe6L03E+eNqIwg7qT4Qa95eCTHKT5pZQAyWKTjrMYkbHe02qxbALSjqn26oakHvnUAmnTAenYQQPchg3sgR34523VW3a5yknl9wMVP7zW5xzsLjJUc2DDpR2SGpBgQFJ4CfhZMNtMzlJjO9YYkdo3jAaCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717109777; c=relaxed/simple;
	bh=t2b3q3NvivHfKbxWs52/YIC7yc0r0DKyLxE8Ev0azjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s70hC+QNymmqCou+4wbswPtvkHLxVkyc4ah4lxzbdHAkXnCfT6Bq8GxRy99+vsv9tvf83/7/XsBPrDh8HcP7JiUDZFp6SHOiuDZJ5tCOXq75Y9oas6dh/nkYNuX3NaIuhUAZCIo1twAaj1Gjre/D1V8rSnmPcRjFrmGrLMSSLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K6mtiSRc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso21997051fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717109773; x=1717714573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyzzXBthjiz94idPYhOV9w7TAAGo24N1F5P/VAMGj+w=;
        b=K6mtiSRcIDInWTWGfn1gHQ9n5QQBlFVicawnbr7AbiSQzWxjd2OeqNAlGuC5Kxf4AL
         W4+9yypjrIlcPzIE+ltAC2L90ugDOIyih9ofgQM7A9OGcdQplR3DpayXqIXciK1OILdB
         06te6BqVdaNFb1GwOp1Y6R+yntDUmvu+igTJDawpvSZh0hzGw0WTT+JXs5Ir0yAemE55
         KXyj2rIxyQFqvHqOJULyPEvimwdgstUvi2jHE00ddKgDqRtyxPQLiFEcqxotnhcGNoL2
         vRCJso5RQ0YPJ7ZCOgXOghAMQOgVrdAU9jwQWgIhWXdsZ+3Jeq0pXDJeZFZp4jFYbD7l
         bDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717109773; x=1717714573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyzzXBthjiz94idPYhOV9w7TAAGo24N1F5P/VAMGj+w=;
        b=Wynr7cJ2JA1+/SMzVuIufLQf1M/GQn04SccddIhn5hBHTBTbIwvqqlyAqv4GeEr9yR
         A6tNjj7liusYhVnrBYm3VUyYJGQLsaNADHveB/uC6KY4gV2lIPhLTjZ5712Cwlsgz+0m
         2tXSgaroKE+CmUuTXfpkmIAzapSOez2SLst7CW3+d8HMoM96cJt8X41yw/AmpkXVKnw1
         3dBjn5KE9RFfY9XVFyx1CsLTGPKflWbESYRDJ34WHVlAABUPc1Yly6/ZWi9bKb9ZjPSp
         LgiG8Y7HnyFLKEfIUdjg0BTQOLnf1XaGeeZKZ7qswCRI3D9iVt1hGYwJtp1V1lEhKSGf
         zixQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCTyj/pJeG2G0TNJ3ImYVAdEQ7OATeRFYRojUUof7a2blQmmQTD1xJcxm2/9iQe5y0fzjfAvTGTmZm9WEZWQmSH8j/25GYTGq37EYb
X-Gm-Message-State: AOJu0Yz/FopDLuWXKQnYjhYWckc1Dg81KhaycWEt9ZIDXlejj7i6pBe7
	wmPOpZobmXiNhckYdo1MOqhwcRCDukUdrgVKoDwKZfBwtCyT2S+WqEzMh5eiS7fAQJa6sxDrj3x
	J
X-Google-Smtp-Source: AGHT+IGsolCfsunFrk+u+BfEK1ofwORxtsBKNx+Vx7U6yTZdYv6NnpXISN5IijgrRZGaS4kqu+n/MQ==
X-Received: by 2002:a2e:9ec6:0:b0:2e6:935f:b6d3 with SMTP id 38308e7fff4ca-2ea9510e721mr1921981fa.14.1717109773222;
        Thu, 30 May 2024 15:56:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91bb6bc7sm1127091fa.56.2024.05.30.15.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 15:56:12 -0700 (PDT)
Date: Fri, 31 May 2024 01:56:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2 0/4] ASoC: qcom: display port changes
Message-ID: <ZlkEC-X2vzYEZ-Zl@eriador.lumag.spb.ru>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <ZieihZRKe7OtP-nV@hovoldconsulting.com>
 <92b02fd3-5eba-42a7-a166-21b14724b10c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b02fd3-5eba-42a7-a166-21b14724b10c@linaro.org>

On Tue, Apr 23, 2024 at 01:38:18PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 23/04/2024 12:59, Johan Hovold wrote:
> > On Mon, Apr 22, 2024 at 02:43:50PM +0100, Srinivas Kandagatla wrote:
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > 
> > > This patchset adds support for.
> > > 	1. parse Display Port module tokens from ASoC topology
> > > 	2. add support to DP/HDMI Jack events.
> > > 	3. fixes a typo in function name in sm8250
> > > 
> > > Verified these patches on X13s along with changes to tplg in
> > > https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
> > > and ucm changes from https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp
> > 
> > It looks like your UCM changes are still muxing the speaker and *each*
> > displayport output so that you can only use one device at a time (i.e.
> > only Speaker or DP1 or DP2 can be used).
> that is true.
> 
> What is the use-case to use more than one audio sink devices at the same
> time for a laptops?

Consider multi-seat setup, with each monitor having its own set of
keyboard, mouse, headphone and user behind it.

> 
> How do you test it? I never tested anything like that on a full desktop
> setup.
> 
> May be some manual setup in Wireplumber, but not 100% sure about multiple
> stream handling.
> 
> > 
> > As we discussed off list last week, this seems unnecessarily limited and
> > as far as I understood is mostly needed to work around some
> > implementation details (not sure why DP1 and DP2 can't be used in
> > parallel either).
> 
> It is absolutely possible to run all the streams in parallel from the Audio
> hardware and DSP point of view.
> 
> One thing to note is, On Qualcomm DP IP, we can not read/write registers if
> the DP port is not connected, which means that we can not send data in such
> cases.

How is this handled for the native HDMI playback on platforms like
Dragonboard 820c? As far as I was able to test, playback fails with -EIO
if HDMI output is not enabled or if the DVI monitor is connected.

> 
> This makes it challenging to work with sound-servers like pipewire or
> pulseaudio as they tend to send silence data at very early stages in the
> full system boot up, ignoring state of the Jack events.
> 
> > 
> > Can you please describe the problem here so that we can discuss this
> > before merging an unnecessarily restricted solution which may later be
> > harder to change (e.g. as kernel, topology and ucm may again need to be
> > updated in lock step).
> > 
> >  From what I could tell after a quick look, this series does not
> > necessarily depend on muxing things this way, but please confirm that
> > too.
> 
> These patches have nothing to do with how we model the muxing in UCM or in
> tplg.
> 
> so these can go as it is irrespective of how we want to model the DP sinks
> in the UCM or tplg.
> 
> 
> --srini
> > 
> > Johan

-- 
With best wishes
Dmitry

