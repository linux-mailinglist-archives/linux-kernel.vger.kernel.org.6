Return-Path: <linux-kernel+bounces-238517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD8D924B77
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0F72918E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3F01DA30C;
	Tue,  2 Jul 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3o5pB5n"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660711DA303
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958470; cv=none; b=ZBmK3RIbK5KHVZR6jJF+0lNaaLgBbXGZw4yol68g7ODgBrCCujPQxmc/PaoJWjXeQsKpRjVRqH7QJTfE7bNyQN3S0wMdEdeeMA5z590xDXx3t+IaR/N7KGNZsnvqPFS6iv3m9beq9qaDDr8VXUaPmYxbhu2e1N0e4usEOSHCFXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958470; c=relaxed/simple;
	bh=6ll4s5hWO8hb3f/5cgn9ls9vhCpyGt6d2EZDxyzusJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kl1qLN8qP4cKGlW3Ct1LhB/T3cyKxU3quzydLgdTNxAAhSZGjYiFw9FUM3nwxWfceebIpl2LmK+jUfnQZjOcqMNOk7Azwn1FTsZGqs3M84/c+tFh/UP9NHn564as1bS9AV2/CqCSkRdeMpKmMMVRracIQG8gYmrlrx9kBa2xwIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3o5pB5n; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-48fde151f25so14076137.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719958468; x=1720563268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sD8orU3RBfAf2hoz6apBJzmcU2qvSOHNCAhe0iXUBY=;
        b=E3o5pB5nob7IJzsU5lDANqS3qu1ldW6l2u3XjLvyjKsZMyR1Pf/i+YdkzUjgBvp5l2
         gblxWJNfgbXo9KZYwbKezwlUhZnQKGg+E4QliTtgsmQtFDHJuc+HpELO08JFbW/JGpem
         uwbTmbjGDwI4zt8HcB27tVmeiyyu+Ge15k+8LLydJKCES6bxliVJi+ppl0ek8OQ9bClP
         k4kXN7VEEp2QOyCF26gqzPD1qlctA3DlF6HCkWZmDF/8eVbLIIsd/39c+pvqOcM/dzdq
         GM8e2M7UbR/54mstyUwreZ3rwHQD+LmFBfdd8lQu8qQYC7t/WQMRs1zw8GJi1cBdDbS2
         aVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719958468; x=1720563268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sD8orU3RBfAf2hoz6apBJzmcU2qvSOHNCAhe0iXUBY=;
        b=OseNir6mWahCpXR+TBOdEp3Dik0sB8epR8Vzb9BaFrNU8blKVD8opQdANVLclfNqYa
         Q68jE3NKRkE/n7J7qH93G0DRZWQdA/bnF8hMVS0nH/BLo51wbX202DVi8jlM+TIr3DTY
         gGmcYwnriAmgNYgCo3bHQEXzGC4+Ml7xX8aUW2Wv5WxMXxcPFChpbEgu5wzijOyp2IEX
         xlJbVfrnw1SnjUyaZ6afXb3vFHJfqDjoaZHQJ+8tv0LXnsPbZ9LLRxYyllQVnOuai9Xt
         49X+rH9bjnLo13Er/qkmuRa6UzNsdcX2i44C3LGoeBYGplOQAc+g0kfJIOTcdGI+/s5g
         aehw==
X-Forwarded-Encrypted: i=1; AJvYcCVNMzgwj8BQpzH/zoNFYiDEIREc5wFQX6bcumOI8T/idVpvNNW/qwhi51Dnq9zuv8PXNPRqoypGVEssXhBm9eWFdSjBeqIfL+Xebpw7
X-Gm-Message-State: AOJu0YzJqCHpCU/bKYy7Wd3LU/Ciczcq6uOjN6FJr2g5KS4atZvkDmRU
	iWBjhFGf9GwV0/W9aIPL/wvOSZefkfvvLxr6jJSPPjctAVfcoCQQ2vf08/QvC93yeh8INqzOpBB
	DDRcDooQgRYldjQFuhRw/eY3ISIA=
X-Google-Smtp-Source: AGHT+IFXhbMOr7DzwzYNNyCsqRINNrgPdR0zpixK3ln2x5FkwZHpp8LDhrs2Je7fcFc10Y+XcQgRdrAqwBXhcj1xmd8=
X-Received: by 2002:a67:cb16:0:b0:48f:a93b:502 with SMTP id
 ada2fe7eead31-48faf133971mr11356498137.26.1719958468275; Tue, 02 Jul 2024
 15:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702215804.2201271-1-jim.cromie@gmail.com> <ZoR40nWmpEV2Ly_6@bombadil.infradead.org>
In-Reply-To: <ZoR40nWmpEV2Ly_6@bombadil.infradead.org>
From: jim.cromie@gmail.com
Date: Tue, 2 Jul 2024 16:14:01 -0600
Message-ID: <CAJfuBxyxamRhOyz8WuL+7=eJkEKSw8jnAWjyAuqU2i7gvg-rsQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/53] fix CONFIG_DRM_USE_DYNAMIC_DEBUG=y
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, jbaron@akamai.com, 
	gregkh@linuxfoundation.org, ukaszb@chromium.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux@rasmusvillemoes.dk, joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 4:01=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Tue, Jul 02, 2024 at 03:56:50PM -0600, Jim Cromie wrote:
> > This fixes dynamic-debug support for DRM.debug, added via classmaps.
> > commit bb2ff6c27bc9 (drm: Disable dynamic debug as broken)
> >
> > CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy was marked broken because drm.debug=3D=
val
> > was applied when drm.ko was modprobed; too early for the yet-to-load
> > drivers, which thus missed the enablement.  My testing with
> > /etc/modprobe.d/ entries and modprobes with dyndbg=3D$querycmd options
> > obscured this omission.
> >
> > The fix is to replace invocations of DECLARE_DYNDBG_CLASSMAP with
> > DYNDBG_CLASSMAP_DEFINE for core, and DYNDBG_CLASSMAP_USE for drivers.
> > The distinction allows dyndbg to also handle the users properly.
> >
> > DRM is the only current classmaps user, and is not really using it,
> > so if you think DRM could benefit from zero-off-cost debugs based on
> > static-keys, please test.
> >
> > HISTORY
> >
> > 9/4/22  - ee879be38bc8..ace7c4bbb240 commited - classmaps-v1 dyndbg par=
ts
> > 9/11/22 - 0406faf25fb1..16deeb8e18ca commited - classmaps-v1 drm parts
> >
> > https://lore.kernel.org/lkml/Y3XUrOGAV4I7bB3M@kroah.com/
> > greg k-h says:
> > This should go through the drm tree now.  The rest probably should also
> > go that way and not through my tree as well.
>
> Can't this just be defined as a coccinelle smpl patch? Must easier
> to read than 53 patches?
>

perhaps it could - Im not sure that would be easier to review
than a file-scoped struct declaration or reference per driver

Also, I did it hoping to solicit more Tested-by:s with drm.debug=3D0x1ff

Jim

>   Luis
>

