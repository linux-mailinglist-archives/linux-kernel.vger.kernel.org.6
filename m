Return-Path: <linux-kernel+bounces-195971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611A58D557F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3ED1F2479D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C647B182D07;
	Thu, 30 May 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSbCcdEG"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375291761B6
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717108710; cv=none; b=Xjbc/c9JqLMYb/eNGwk4QcBUcMkyFJjEj0pu1lwAjCRAzZwzMsTs6FNf85XZuSMpJp9tUqHiyC5sFLd9fa5nIxNpSsoGpR0Nl9CrnVuYcP+bTiqr6VYUgRDoRYLXXkivAH9Cz1DJWGCGh9m9pHUIhW7gcAsNXVCfs3Hjk5WB3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717108710; c=relaxed/simple;
	bh=Fjzer8QqLFsATl8glp0AAGSY40jW8Spt85gruSjFpBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fnwz9KDh94+bhgIRCP+R+OkvJQOnKHIle/Z1iHm1P6HZQcgZ/dPbDlxt4YxwF3I8tgmY9SIbzpDbYkhihPaPioBJqngyHgIFw0vqYTyqxmsQi/fYeh+bQJZ7BZwDZxmsD6yVjoYtW4y3Kj3jQbQN/XUNHyw/9LuQP4+QRM/LB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VSbCcdEG; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b03d66861so1507676e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717108706; x=1717713506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXlCq0DJxkxxyKLvV8+ZkZTnpl2ZObVXFmhWlTC2CL0=;
        b=VSbCcdEGgASkJMjwCXADOFvC3bwxXocjTTXsE7NxFjCv/Ls/5G7nEIFwE7ce3TZ8jA
         hfWng7iyVv3iQg0y5K9zHsuA+zlB2XQ860cfcAkpruKOcT0+WI4Dt6qLwnBJUhqPO+JG
         CxuO8FEMp9VUhBGt44SbfKSAwjwxgYOe3v8Gpa1Cif+975rKbyeT0pvbruo2xq8fkYaH
         Six2gkSexqUe8r2EbVUJ94y34cARjS0jHttVy91fN0/wsdIE07VnC5+Pk5PhrAX/RxWX
         tINSaDZGUlHjlCUSHZUNuEHN5+Bpwegm1gpiLBF5PnXuT4zoYH8MMFj44r88GD5hiMhd
         UfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717108706; x=1717713506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXlCq0DJxkxxyKLvV8+ZkZTnpl2ZObVXFmhWlTC2CL0=;
        b=i5LSMGHi5L8G9W0tmZycMp5xOfqJrPdy0GK5zeQVlwnqVPmzCzFXiWxgxOMN9YvWFw
         +YQO96mgoTw1n+fkJu8/6UrKmQQNJXL9hb7GXTRvw4Vv8y2tK1APSUigE4ILDICz6ubA
         hLO0LBQzug2pIILd+DbYYEP/sfzRUB8BWJDMQpVkeWJlZvAF1eoXTDvgSaVa6FHdgtei
         JnJ4D2fxsDhvrJFwrP3UVc/GdaxNZ5ucKMOwSZsneDIlzzs8j6prZVrtd86JHWZqIgY/
         cRc+I7VQZY5P4sPZsEb/cRAJLsnEEmYepAXjSFtfQmpvAZl7RSs05EXwXCXiYqAhuwlV
         MGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn+YeT1n/ITd9X0NEfoyGcuutucbXPZ00dHs5y39bFTJ659Gn6rxf4uEbK3QOed6p/lZ/HQ6Gb0uZUPpRBPz5MyI+r9newXyizeQ0i
X-Gm-Message-State: AOJu0YzUkwq0p3rsSrUCdGZrQo7kKid15FEvdnaPPKYsdUz621B95pJi
	EtBwQ2TDP2IbkblvLgmsRxc1UHlLWkoW/+KAdlx7GNCLHwSyUVVpHvF/kvsEcqY=
X-Google-Smtp-Source: AGHT+IFnEBYJSgU24AbKOGM7TJ91eoG+D0UNGLi9QDLuQI6tXBLo5Sj9AYbvSSfIx8nFWe1bYC8zEg==
X-Received: by 2002:ac2:5a07:0:b0:51e:fc99:d6ef with SMTP id 2adb3069b0e04-52b895a11d9mr12829e87.18.1717108706187;
        Thu, 30 May 2024 15:38:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d7ff1csm112527e87.209.2024.05.30.15.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 15:38:25 -0700 (PDT)
Date: Fri, 31 May 2024 01:38:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: qcom: common: add Display port Jack function
Message-ID: <Zlj_4IuZqnC3gESL@eriador.lumag.spb.ru>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <20240422134354.89291-3-srinivas.kandagatla@linaro.org>
 <ZiejT5yddioQ8upR@hovoldconsulting.com>
 <b9d0e2fd-069c-439c-a85f-1e99bf9018c3@linaro.org>
 <Zi-0kSU6TMcev05r@hovoldconsulting.com>
 <a980d7a5-0d80-4ff1-93e1-b5f5806980c3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a980d7a5-0d80-4ff1-93e1-b5f5806980c3@linaro.org>

On Thu, May 09, 2024 at 09:59:40AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 29/04/2024 15:54, Johan Hovold wrote:
> > On Tue, Apr 23, 2024 at 04:55:32PM +0100, Srinivas Kandagatla wrote:
> > > On 23/04/2024 13:02, Johan Hovold wrote:
> > > > On Mon, Apr 22, 2024 at 02:43:52PM +0100, Srinivas Kandagatla wrote:
> > > > >    static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
> > > > >    	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> > > > >    	SND_SOC_DAPM_MIC("Mic Jack", NULL),
> > > > > +	SND_SOC_DAPM_SPK("HDMI/DP0 Jack", NULL),
> > > > > +	SND_SOC_DAPM_SPK("HDMI/DP1 Jack", NULL),
> > > > > +	SND_SOC_DAPM_SPK("HDMI/DP2 Jack", NULL),
> > > > 
> > > > Shouldn't these be split in dedicated HDMI and DP jacks too? What if you
> > > > have a machine with HDMI and DP jacks which would otherwise both claim
> > > > "HDMI/DP0"?
> > > 
> > > These map to the Jack's added as part of qcom_snd_dp_jack_setup and
> > > belong to DISPLAY_PORT_RX_0, DISPLAY_PORT_RX_1, DISPLAY_PORT_RX_2.
> > > 
> > > If its going via USB-C DP controller it will be either DP or an HDMI ?
> > 
> > It will always be DP out of the machine even if an adapter can convert
> > to HDMI internally.
> > 
> > The DRM ports are called "DP-1" and "DP-2" so it seems we should match
> > that.
> > 
> > > This is the most common naming for the USB-C DP/HDMI jack events.
> > 
> > It looks like some Intel machines use names like "HDMI/DP, pcm=%d Jack"
> > (with a pcm device number), but we also have "DP Jack". Not sure which
> > are are used with USB-C, though. (Or if the former actually support HDMI
> > altmode.)
> 
> I checked this on my machine which has usb-c and I can confirm using HDMI/DP
> naming for these jack.
> 
> Either way I don't mind having any names, but my point here is to be more
> consistent across.

I fear it is till not consistent. On the Intel laptop I see following
jacks:

numid=18,iface=CARD,name='HDMI/DP,pcm=3 Jack'
numid=24,iface=CARD,name='HDMI/DP,pcm=7 Jack'
numid=30,iface=CARD,name='HDMI/DP,pcm=8 Jack'

On the other hand Mediatek and RockChip use just 'DP Jack'.

I'd suggest settling on the latter option. We are closer to MTK and
RockChip rather than Intel.

BTW: a platform can easily have 4 (x1e8100) or even 8 (sc8280xp) DP
outputs. Could you please point out why there are just 3 jacks?

> --srini
> > 
> > > Qualcomm LPASS in some older SoCs had a dedicated HDMI interface which
> > > is different to this one.
> > > 
> > > Usual Other ways to connect HDMI is via external HDMI Bridge using I2S
> > > interface which totally different to this DP interface.
> > 
> > Sure, but if there's ever a design with such a port then it will be
> > called "HDMI Jack" and then the "HDMI in "HDMI/DP0 Jack" is unnecessary
> > and confusing when it is always DP out.
> > 
> > Johan

-- 
With best wishes
Dmitry

