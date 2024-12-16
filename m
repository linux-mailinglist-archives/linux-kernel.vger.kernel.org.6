Return-Path: <linux-kernel+bounces-447467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6489A9F32F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FBD161461
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AC42066E8;
	Mon, 16 Dec 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c56Irisw"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3F206283
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358513; cv=none; b=IwGzFreVNDJNvCvIogvAFlbwCruhT/sYh48fbO07JLBTK2EGrhMkF4ahgAKgM5O0/z6FQg9cdfqn9DrzuPalPXH4nMyrJO17QMlbPJ5e1GU6oTHT/tqb+5SoB2gY6w2K27XoJBlwonJIkjFFzxr2YIR51v2cZWdSdZ4R+PA66dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358513; c=relaxed/simple;
	bh=BWKay8aCkBASbe7NfIokCvthHXIEjCiOrlZ4ghdpg8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAAGlA3Xt8SWwhKFR+innCGxqpkuGcD0o0B5+PJw1hD3xlTJuBECB/LQRxiCLrYykYGtzOsbvTEUgKnqsLMP8thOapzmTa+ww869PWuahC3QcY0ZD+8CeZEMUOQ3qyF54nE8kyyQ6+2Xkh0F+/PGRiWizeI8+jcs5YT9Dp3ve/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c56Irisw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e384e3481so3856468e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734358510; x=1734963310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKSczxnLoUJAPWSomZ621XIOP46vr1LWagGXlu/bsRA=;
        b=c56Irisw/dTOKJ4OS7dC3W8Y007BbhO2nXf/cFoAnuxcLy6ueP9q+aF9hVhjfAX7cn
         62HTfUbeeKS8pCH/9j/i0XjnGxBWFLr3mmoAZI410WaHUtVQ+oJYTSXYUMtAYRND2FZ1
         Wg6XI/VzEwG/9n+8pnmDNQg9BvKlUlYRXwFJvde1TCJaCHJ/uwUZN5jlMdeq/wI3pPYc
         NWTOdKO7iKcINmVQJqRmV8ALAVk6yZNpAvGNJOwbrqH9IDag9yVedzsuFe21ssmkU/st
         wJXxUgjj/XQjGk9mr88bsF/1Fqhoar1ZZ8xddN0LzmdqvB35b57O4zqzuabq4B3VTtIT
         Yp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358510; x=1734963310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKSczxnLoUJAPWSomZ621XIOP46vr1LWagGXlu/bsRA=;
        b=MtWdJWgc/c+USsjEWQylbsOYRJ/5VIFUZdSjWwWfBjK6ShIgffSK93UDht4poNsukl
         Eq5F73t7T/sHhYCIZXHxe/GC9I5Xx1bYD2+EyqWIT/0MeydQPUm1drB6SINbcP2mqbe9
         0utN2ScDi09MaBqb8LS4LaK9U6GXtpQXcH9YkDYI3UHFkSv+JZk0LhzX9g7c4BI7GC7I
         hF4KxoqylkkcIwG8w2ohs7FOffHCPKQrn606PPL/wq+Y74icNdh3FUAR7jT4r78SG5Zn
         7hGbiOIcXcwhrAZzgrRVN2u/mPyDWmGD9Z1wAd4usMztPNiathuHJd1tF/xuPIGzvgNQ
         JRGg==
X-Forwarded-Encrypted: i=1; AJvYcCUa8HQaux0awrxi13IKXCbKZ6jIxKhTtp1F61psRXx6Oa78rOXYx+shap9GXbnU3L9//Lc6E5esX+dyqYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/GisUpLZY9y9fXlxMzJO+/1M/yf281k7vHHJQNiMQkXMNp3GS
	wdejRKHSxDy+6IvodRdJBnmsSSc0npdtHLL0j4XK+i/x092D21owlGOz+zwAbig=
X-Gm-Gg: ASbGnctSYd2QsgtWNS+bPhtQm+V90EnZTQaf04PnBYBxhnAyvbHCu6fosEg+Ahd0JBZ
	fZeONeQjvELVoc5MHHC5TYo4haVSFg8ylBUQYeEfzGb4FehgZBVEymfRF0U78zwNNKHKywpkd3+
	StZufhG6z5N/7K40l4N/xBvNWieaHUIpRYng15csmY4g1oOQQo9zwGP/t2ivs7aGRbyCoyaVBi7
	6x1kOFL11Br7ghjjV/q96FqnAMuIRJebbydrgrlErbEeLUlnO7NqIPaztgCocHaWp/A/hZLz/1D
	mRfXp/hP2MamxRZeSLwP1D5urD8FkJsQK4BI
X-Google-Smtp-Source: AGHT+IHbHSLczqY5nj/2VfoD1kdLMoq1Dp5yoiXtRZ5jCeqQsP9C363sZLJ5c9AJ/IeUMH19P3sgNg==
X-Received: by 2002:a05:6512:110e:b0:540:241d:d74e with SMTP id 2adb3069b0e04-54090558390mr4985254e87.24.1734358509762;
        Mon, 16 Dec 2024 06:15:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f686sm868000e87.49.2024.12.16.06.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:15:08 -0800 (PST)
Date: Mon, 16 Dec 2024 16:15:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] drm/nouveau: remove drm_encoder_slave interface
Message-ID: <bpvyq543f4o3uusbjrivlymxeiqjcrnzb3atae2bp2vjleiggc@eolxb6jdep57>
References: <20241215-nouveau-encoder-slave-v2-0-ef7a0e687242@linaro.org>
 <Z2ASy3TQ4suupdvd@cassiopeiae>
 <fw7i3kusogrrsslb5sjdid27uqnwey5qa5yhyrfa677n4iqqhq@tfh5s6bmqgna>
 <20241216121651.GP32204@pendragon.ideasonboard.com>
 <Z2AgFHV2BaaZYGTx@cassiopeiae>
 <2p2rx6zmuph4bdwjork5aqp5n3xkho7cohapvgfijka64vbpop@nse4i55pkyy7>
 <Z2Arj_cLW-aY5cnD@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2Arj_cLW-aY5cnD@cassiopeiae>

On Mon, Dec 16, 2024 at 02:30:55PM +0100, Danilo Krummrich wrote:
> On Mon, Dec 16, 2024 at 02:58:59PM +0200, Dmitry Baryshkov wrote:
> > On Mon, Dec 16, 2024 at 01:41:56PM +0100, Danilo Krummrich wrote:
> > > On Mon, Dec 16, 2024 at 02:16:51PM +0200, Laurent Pinchart wrote:
> > > > On Mon, Dec 16, 2024 at 02:11:41PM +0200, Dmitry Baryshkov wrote:
> > > > > On Mon, Dec 16, 2024 at 12:45:15PM +0100, Danilo Krummrich wrote:
> > > > > > On Sun, Dec 15, 2024 at 12:19:22PM +0200, Dmitry Baryshkov wrote:
> > > > > > > The nouveau driver is the only user of the drm_encoder_slave interface.
> > > > > > > Demote it from KMS helpers module to the nouveau driver itself, moving
> > > > > > > corresponding I2C encoders to be handled by nouveau driver too.
> > > > > > 
> > > > > > I understand nouveau is the only driver using this interface (and the
> > > > > > corresponding i2c encoders).
> > > > > > 
> > > > > > However, I'm not quite seeing the advantage of folding the interface (including
> > > > > > the two i2c drivers) into nouveau. I don't think this legacy interface does harm
> > > > > > the subsystem in any way / does prevent the subsystem from moving forward.
> > > > > > 
> > > > > > Can't we just keep it as it is?
> > > > > 
> > > > > Well, drm_encoder_slave is a part of the DRM KMS helpers module, so it
> > > > > take (a little bit) of space on every system. The nouveau situation
> > > > > isn't unique, other drivers (i915, ast) also incorporate the code for
> > > > > I2C backends. For the further discussion see the thread starting from
> > > > > Laurent's email ([1]).
> > > > > 
> > > > > [1] https://lore.kernel.org/all/20241117205426.GE12409@pendragon.ideasonboard.com/
> > > 
> > > The drm_encoder_slave code it's rather small, but I guess this can be used as
> > > argument for both, keeping it where it is and moving it.
> > > 
> > > If you want to move it to nouveau, I'm not going to object. But please fold the
> > > helper code, such that we aren't left with unused functions and unnecessary
> > > function pointer indirections through struct drm_encoder_slave_funcs.
> > 
> > This is more or less what I've done. Or would you prefer to keep the
> > wrapping functions that just execute the callback? I can change the
> > patchset accordingly.
> 
> No, I think it's good indeed -- st a first glance it looked like there's more to
> get rid of.
> 
> There are just a few more nits, I'll go ahead and add comments in the
> corresponding patches.
> 
> > 
> > > 
> > > > 
> > > > It's also a question of whether maintenance of this code based used by
> > > > the nouveau driver only should be the responsibility of the drm-misc
> > > > community or the nouveau driver maintainers.
> > > 
> > > Good question. It's common infrastructure; do we expect / require the last user
> > > of such infrastructure to take ownership?
> > 
> > Unfortunately it's more like 'the only one' :-( In other words, if we
> 
> I can't see a major difference between "last one" and "only one" in this
> context.

I was thinkinkg between "the last one" and "the only one, there will be
more in future". Excuse me.

> 
> > were expecting other users, there would not be such a move. But
> > hopefully all new drivers will use bridges infrastructure.
> 
> Agreed, but I don't think it answers my question.

Anyway, yes (in my humble opinion). it's usually easier to push bits of
infrasrucure towards the last user. Frequently it allows us to simplify
both the framework and the last user.

-- 
With best wishes
Dmitry

