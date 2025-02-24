Return-Path: <linux-kernel+bounces-529940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D406A42CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF64F3AF569
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B571200138;
	Mon, 24 Feb 2025 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvUMFj91"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59A1EDA0F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425218; cv=none; b=VxWdKzv5b+EqK/tU/ZVLb8acD8p186OmQDmcjZdBiMHPj92n5iZKK8KDSmRJPqR1Htm5vv+RLY7RlXeVjvJczK4iQl1QAl9Rtwn7cYbxxH1YtwmjdickIUtakhNds/kQpVjQzqHzgXgyThn5+F2907NJBVmHYuXPVWjqj2nXBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425218; c=relaxed/simple;
	bh=RjsVDHq5onMdcNO8yu6bUCK3Q733x4J7UZ4pmLrG/ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPo80qZE3VcbcToIWsETI0/S4AqUpXECCowGXCTB0Udyd8CXdEdojAcN7fIukJ7tyU0qE6eXAeiXUDkGT8qPuC452r9ocHpP6pbNF/StHP6z//t8d0zdKmqtj7UjT9yGSGDh1MwW4w09qxUSdbtxZ6wrn7+DH60n8rceYuJhUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QvUMFj91; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so10530747a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740425214; x=1741030014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpG14FyHciUCJeJWu7dlaHcQcwmbGCSP29+dFb0PBnE=;
        b=QvUMFj916w/3zQN75r97CA2nQQ6oiRtk5JJG2rHygf2jiEmc/+uPq3cnVUngEcF0GU
         Nd/O62RWxUKRqIJKnnpgrWNvWetGMs1l+AkvENWsHW9DvDtMhrp6ucQq2fbiMhJ2FH2Q
         1Q1dlesVGQoNGLJ9iGdsg0cs8lucp6FZvjpKJJvSiSJcGsssjIF71L1/BZ5muRJl9/G9
         nT/7IV2/wmrjnyjg3t9FAwzn61V+8hC9FTv2IdiG+1QseWIrEphjnK/llvHGaEbzA0xk
         sGihqEfBmm97AQ9nK66zWBGOhnR9xLUOe7l9Gt4/GN5Z0u69cOrSkqAsw2YmZsCApya2
         j34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425214; x=1741030014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpG14FyHciUCJeJWu7dlaHcQcwmbGCSP29+dFb0PBnE=;
        b=lm35tMm9fio+4bQMLLAfIv1WcX8myQz5JD9aHxVpiaJL7eXVioy9PTwQLDUcMkHpq+
         FZs2PvDewmZg3H1hdCtpDGSD4m+hSgLMilK+FrfrT7HpkgA/3X9Eh3f7JflCz1i1dmVC
         1wz3JUIoHpHPfG3OYexhRlUWHzA0oKRxoI5i3DHHJIKFEmQXLehi66G1cSSP8Yu+XFmD
         pCY+s2QzoM4vINP/GxGqryWnURqErsO6/m9JjWnVS1uaQ49bKIzAiKyZCyh2IPaN76wJ
         SDA3hdkjhkFE6L9eu6mFcafflwoHlMwA/9VZlZ3VVAN87YoQdQo1ytFRSUrVLGjv4pfd
         D7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpuEsn+x5AmQRC/hx65mi9a+rFqXfJT/EC3pnJEbgok2phKiFLSZdIPlhAqSt6IW0rSIB2WjB+vioYekg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKlddreD8LT5UDb3CowQMsSI1rru6zxdPxkbW1YKkT1pjCEtp
	SKLtnrYXrYVhyt+oHnggdYcGX7bu3j9W1+K9DWLEWStDubRUk5L4y4whylqTYTc=
X-Gm-Gg: ASbGncsB4gHpqUj4vsbNYqIo2998of9Lx0lfC4mgFeAD2PTd1Q9a/ioguH+6JUDHJYG
	2SbWXiSMFUdg9TqL32j7J27xtazjU+p1xmJwPB35SaPvm+lhw9vOWE/zq0ZgJ0mxhtHqSynKrz2
	AgitHiELg6g2/H9Ipn5xiPk5pHYgHTUzP3faVYxsjc58E/+skj8Ldr0CzGNSmQZvZ6MN49poA+5
	tIBhR/MF8tz1MYPMI0dXF56UlgIa4i+IND39qXePx2eo2k25qv1t2+StKra/LjnW2qCQK1yBt0Y
	eUUTcdk+tQDVAvtYlh6BF/eE+8a1Ld8=
X-Google-Smtp-Source: AGHT+IEkKWuUL7F5MtASBjfUP3GAc3+5X8K8oDEv6bNFiTlpvxETEam5AUBsm70isUAlIpvpz/BZvA==
X-Received: by 2002:a17:907:9989:b0:abb:daa7:f769 with SMTP id a640c23a62f3a-abbed5b21b4mr1841919766b.0.1740425213760;
        Mon, 24 Feb 2025 11:26:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abed1cd4c23sm11026266b.11.2025.02.24.11.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:26:53 -0800 (PST)
Date: Mon, 24 Feb 2025 22:26:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jim Qu <Jim.Qu@amd.com>, Lukas Wunner <lukas@wunner.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] vgaswitcheroo: Fix error checking in
 vga_switcheroo_register_audio_client()
Message-ID: <8e161bf8-70f6-4557-8fa8-81d4bbfab91f@stanley.mountain>
References: <ae24cd32-1e78-4656-b983-051ed22d86b9@stanley.mountain>
 <87eczn7adi.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eczn7adi.fsf@intel.com>

On Mon, Feb 24, 2025 at 03:14:33PM +0200, Jani Nikula wrote:
> On Wed, 19 Feb 2025, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > The "id" variable is an enum and in this context it's treated as an
> > unsigned int so the error handling can never trigger.  The
> > ->get_client_id() functions do not currently return any errors but
> > I imagine that if they did, then the intention was to return
> > VGA_SWITCHEROO_UNKNOWN_ID on error.  Let's check for both negatives
> > and UNKNOWN_ID so we'll catch it either way.
> >
> > Reported-by: Su Hui <suhui@nfschina.com>
> > Closes: https://lore.kernel.org/all/20231026021056.850680-1-suhui@nfschina.com/
> > Fixes: 4aaf448fa975 ("vga_switcheroo: set audio client id according to bound GPU id")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/gpu/vga/vga_switcheroo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> > index 18f2c92beff8..216fb208eb31 100644
> > --- a/drivers/gpu/vga/vga_switcheroo.c
> > +++ b/drivers/gpu/vga/vga_switcheroo.c
> > @@ -375,7 +375,7 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
> >  	mutex_lock(&vgasr_mutex);
> >  	if (vgasr_priv.active) {
> >  		id = vgasr_priv.handler->get_client_id(vga_dev);
> > -		if (id < 0) {
> > +		if ((int)id < 0 || id == VGA_SWITCHEROO_UNKNOWN_ID) {
> 
> Maybe we want to do something else here... see [1].
> 
> BR,
> Jani.
> 
> 
> [1] https://lore.kernel.org/r/CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com
> 

I feel like my patch is good enough...  I guess the concern here is that
GCC could change enums to something else.  I don't think that's likely as
it would break a lot of code.  The other option, which is a good option,
is to change the function signature for vgasr_priv.handler->get_client_id()
so that we do:

	ret = vgasr_priv.handler->get_client_id(vga_dev, &id);
	if (ret)
		return;

That's better code, honestly.  But I can't find motivation enough to do
the work.

regards,
dan carpenter


