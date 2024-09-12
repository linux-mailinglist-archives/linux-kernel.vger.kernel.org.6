Return-Path: <linux-kernel+bounces-326521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7EB97695E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F0CB24EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DBF1A0BC5;
	Thu, 12 Sep 2024 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdlhaSXQ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C01A3AA5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145078; cv=none; b=Cjuzm4I8OU3UII2GAWhlZi9yeUcS89H7Uwe66q0sFhiNJncco5HkTdjm3qAgosFmkX9YGJZxnKHeKB+pnzfc+p5qq+aAEssGn0BQuUKoVt5YR9x6O1vSU6nchLGQLYi5V6CHLZM7sy4v1A1D2Z66wruPinV2kUEopI2+TBQ21K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145078; c=relaxed/simple;
	bh=Hla1wMqf0HrT6fXzcUP8UY1GsACDSmIzSbBDMFZop6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVSEZqwBELaesI4ECxwDjqJp0EojsGvDB/qBnlPQjeaOSDsklPeaB4rTJGfKofwpsXeUQlC5kIrwtSekSUtng+8NSlvKq6DRQuiY7fl2EkdkevM1XuF8sQ+qT9zVOKsm2qN/tAMyezB0da940/QGwVD+rAbfla7gu7YoULuUQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdlhaSXQ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so689215f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726145075; x=1726749875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIRFE104iqmiqvypwgtVAS+aqcQZibJcoPMVTtseVEM=;
        b=RdlhaSXQmAgp1KnlXkYhfU+Qh7TYYFm51uP6HOwE7tN4n1gLj0r91WFoVw19BquJFD
         /n87cq8t3y1v1QEl3Vj+OMUMJ2WgdMc3XTp//FrHF0RzFC2haiQNkuWMvIa18GtQeonW
         9eHuIFwSEmLvKeALpsKMTWnn2hT8joSrgFWFH2TuBCC/sWln4SuzcWzgSyAdYueArwvz
         PjhI8HjTxAb/+q31ZDQL1ZLM9c5DF/GqNkJJTGRuUybmeMuMDkkcpq9WQet/7bXBMNP3
         gjFL8bZ/nxfABXPl8AUGpxFxX3LPgWfALNPrEcY/TlpsMXlZVwGbQhMHnINpKtuz0UUV
         sqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726145075; x=1726749875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIRFE104iqmiqvypwgtVAS+aqcQZibJcoPMVTtseVEM=;
        b=ui6+27eP6TpAYBQy96+JUVqJfTKpExTtjdlgaDUwBcy85PxzDX+uCNLNPEJufsI3S3
         o8H8cezG07gEEhaNE5gXD/EsiyeR7GKweiPJl0sR6irK8p+//LIeY8kzOkbW44kNttcc
         qyEqchvlWAp/uqm352YGVMVqq1CCpgYqxzJDbtJXatOtSXaPfUZrlQ5JgIcI4bywm8NX
         f/Nftk2ClBhuKIufty0Ouccay27zM2tgVPIX45a2NS8RxfOohWWJF7qo8rk5U0bowKDf
         xrxb0D/GaXjC/7y8KvTONwHGEFloKPGkqHzy2D9W4N1W6nfhzxe6Wx9JPJIsyh12RHX2
         S3dA==
X-Forwarded-Encrypted: i=1; AJvYcCXQvjG4c9uXNxnKW3wPyqFf6m1sSWCFOJfVXdH+o+x+0Rqb9MPTeHa1t3emBGCbmwZfWXadq9HwT1nyH0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12w2eg3yw+D6zPO4ZedRKK/ELJ3zZqB/06KmrQgiQ/XXikKWU
	ZCzEXh8xxw9aI/Iab9piTqGz60AZY/0v8BUNQADRzUudUKqwE62QB8zNVyRicAE=
X-Google-Smtp-Source: AGHT+IEkEa3kJagup7Qw7aPq60YN6Qx3p0uT99t7HEvmeyCNpx3cYutAK/MV22Ep795nOBJrPgDpJQ==
X-Received: by 2002:a5d:4b8a:0:b0:374:c287:2afe with SMTP id ffacd0b85a97d-378c2d58ee0mr1534533f8f.56.1726145074680;
        Thu, 12 Sep 2024 05:44:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789556aa7dsm14773393f8f.0.2024.09.12.05.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 05:44:34 -0700 (PDT)
Date: Thu, 12 Sep 2024 15:44:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: control: prevent some integer overflow issues
Message-ID: <72907305-eddc-4fb4-9c74-7e1d2750f4b9@stanley.mountain>
References: <0f03d569-9804-4617-a806-f0e5c32399fb@stanley.mountain>
 <87v7z1yyok.wl-tiwai@suse.de>
 <20c99f50-948e-4076-ba28-9640c3cd982d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c99f50-948e-4076-ba28-9640c3cd982d@stanley.mountain>

On Thu, Sep 12, 2024 at 02:29:58PM +0300, Dan Carpenter wrote:
> On Thu, Sep 12, 2024 at 12:05:31PM +0200, Takashi Iwai wrote:
> > On Thu, 12 Sep 2024 10:51:14 +0200,
> > Dan Carpenter wrote:
> > > 
> > > I believe the this bug affects 64bit systems as well, but analyzing this
> > > code is easier if we assume that we're on a 32bit system.  The problem is
> > > in snd_ctl_elem_add() where we do:
> > > 
> > > sound/core/control.c
> > >   1669          private_size = value_sizes[info->type] * info->count;
> > >   1670          alloc_size = compute_user_elem_size(private_size, count);
> > >                                                                   ^^^^^
> > > count is info->owner.  It's a non-zero u32 that comes from the user via
> > > snd_ctl_elem_add_user().  So the math in compute_user_elem_size() could
> > > have an integer overflow resulting in a smaller than expected size.
> > 
> > So this should also use the overflow macro, too, in addition to your
> > changes?  Something like:
> > 
> > --- a/sound/core/control.c
> > +++ b/sound/core/control.c
> > @@ -1618,7 +1618,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
> >  	struct snd_kcontrol *kctl;
> >  	unsigned int count;
> >  	unsigned int access;
> > -	long private_size;
> > +	size_t private_size;
> >  	size_t alloc_size;
> >  	struct user_element *ue;
> >  	unsigned int offset;
> > @@ -1666,7 +1666,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
> >  	/* user-space control doesn't allow zero-size data */
> >  	if (info->count < 1)
> >  		return -EINVAL;
> > -	private_size = value_sizes[info->type] * info->count;
> > +	private_size = array_size(value_sizes[info->type], info->count);
> >  	alloc_size = compute_user_elem_size(private_size, count);
> >  
> >  	guard(rwsem_write)(&card->controls_rwsem);
> > 
> 
> I've reviewed this some more and those changes are harmless but unnecessary.
> info->count is checked in snd_ctl_check_elem_info().
> 

I also considered if I should fix this bug by adding checks to
snd_ctl_check_elem_info() but I don't think that's the right approach.  I
couldn't see how it would work at least.

regards,
dan carpenter


