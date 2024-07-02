Return-Path: <linux-kernel+bounces-238526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFE6924B8A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C86B22ED7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E88B1DA31C;
	Tue,  2 Jul 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndm3V3I5"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107AB1DA307
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958906; cv=none; b=Lox8zUV+Bqe9didfLurYJ5lCFkF/fTtb5vYQIzhG8CoicYYEc8UpzY5qV3GimVwlRcEQOEiwsLvy+cj6jdTt/deulWsYRikF7vHMBbHWImbO8inz5WDnAXkeO7POYXpvzczepKx0rUlcUwRx7aPcnd4RYi8OG3b9eugbm2bLDOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958906; c=relaxed/simple;
	bh=wlBS/O3lRLm1cFsYILVwP9qj5Lg6sGwigsuc3gaufFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+/z0A3atLCXwwoOylZINW/oB+tBPS5Klf7RdNxDngNSIzMkVN2GT4HKMnrAMl75kjhg4vK54L67V8svLjI7UFR7+2rKtLBkG1+ImB7B86fb30NJzH8vYAeLZWWmOtXoU6Pz6G33dNdemxs78pc002RpmM+63HnShMN7Q/ph0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndm3V3I5; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36703b0f914so22701f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719958903; x=1720563703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9vgcK/xm02vctzIF3h5toINdya3dR3yqrhsTftG73M=;
        b=ndm3V3I51OLXV/m1tWO7q1WeXbGmj35h0rxEGWrDsz2RIxkMaDowCPZXKdUrvhvgca
         NQtJXY32tV8xygXMIaIq0bVdJAwcJmhpxo7eF6lUGhVNX72pvpu8e6+L7gxOr0y6UprP
         b4EWIfne/WZIPFlsCTw+4iREEtlKcXiw8J7MxBL3TJS15OsEG65KijtICbiu9bxmTXAN
         ftwGo6yE5C7PMyNZ/FXzcZJQFQj0nNjshlERIfxCpgC1CFoPw9ZUU8WHsVUD0YTXZlI5
         na5cwg6Y6ivdLjlkLGVX1q4bl6LeqKGk2H7+EqMwrCvQLEEItHCbRJ3xgK3AeDPvAF6w
         sQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719958903; x=1720563703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9vgcK/xm02vctzIF3h5toINdya3dR3yqrhsTftG73M=;
        b=YbMhTJIUqGECHLHTPZhYF/qqiYzqm+yXMJEBmgpM+iJCLig3sNkFslRcJpk2ZPvfp1
         nIdo9WBGGHLkMK9a5HA4GMvyEfnDrW9OE84u3WXHQpqf8oXFIIK5ndqIv6F/lxgl9xXL
         SIklG+w3OpSSNVd7hZAaEMcjmn8WnkMgcRzF+gtOhoVCWUjXEU/Qz6NjoHaA4+o3hmP6
         SnrlpaAzVMF3wQT7wOef0b9OCPwvoeuyw3ns6S9tzdkjLd7CeCH4bMMjkL8SBg0VwFBD
         FIOHz9xhjoVM+Q7GEQHrnr0azgoXJbQbOS9YoA3+ELdgCQVAJ3eO4vfbX0OVwPQNQSl1
         OSxA==
X-Gm-Message-State: AOJu0YzgOLNP5edTnTV9fimZCp4laJtNAAJG+vnibzBoyocd5twIUNSB
	Inifl5coLqj+bmooYM9EPlgFgxYrEVl2hbn4EnL+hZmVRQUdfKTHKd27o9eu2z7ceqqwMcQUM7l
	zsVvx1YCXisEVHE4Vc8+oujvdBQY=
X-Google-Smtp-Source: AGHT+IE6KI59FdH94mNz6QCT52qCK9nMcKkJLsqY5hrpIbquZ+qloFhsu/enL/iF4DqZaK14tDnn5QmgUZnTWqnbHfI=
X-Received: by 2002:adf:e25c:0:b0:367:8e52:3bb9 with SMTP id
 ffacd0b85a97d-3678e523de3mr1706933f8f.22.1719958903156; Tue, 02 Jul 2024
 15:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702215804.2201271-1-jim.cromie@gmail.com> <20240702215804.2201271-33-jim.cromie@gmail.com>
In-Reply-To: <20240702215804.2201271-33-jim.cromie@gmail.com>
From: jim.cromie@gmail.com
Date: Tue, 2 Jul 2024 16:21:15 -0600
Message-ID: <CAJfuBxyuwpkWQpqoncHXOx5v_naAnxW1BUyHzon6PXiPCRrSSg@mail.gmail.com>
Subject: Re: [PATCH v9 32/53] DRM-CLASSMAP-USE in drm-drv.c
To: daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, jbaron@akamai.com, 
	gregkh@linuxfoundation.org, ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 3:58=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com> wr=
ote:
>
> ---
>  drivers/gpu/drm/drm_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 243cacb3575c..f511d40f577a 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -56,6 +56,9 @@ MODULE_LICENSE("GPL and additional rights");
>  static DEFINE_SPINLOCK(drm_minor_lock);
>  static struct idr drm_minors_idr;
>
> +/* single ref for all clients ? */

So this was my attempt to try a single USE
from the client-side of drm core / driver interface.

I didnt find it to work, and meant to rebase it away.


> +DRM_CLASSMAP_USE(drm_debug_classes);
> +
>  /*
>   * If the drm core fails to init for whatever reason,
>   * we should prevent any drivers from registering with it.
> --
> 2.45.2
>

