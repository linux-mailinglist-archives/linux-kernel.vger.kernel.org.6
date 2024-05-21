Return-Path: <linux-kernel+bounces-184889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB398CAD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AEF28335B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B0F757E5;
	Tue, 21 May 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Seb1q4of"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68714F605
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291739; cv=none; b=dEtJ2vfLYO/rdjy35hBM43jAYHaE0ZKMDNomaOr2bTJ8nh2q95cDeepNARwKNKyw20VJUUBdrom4xWvdRsy4poE8B2TsSDDF86sd4gP+qBK6x3rBDeRAwTy4XVj4LZDqeN+8DDUvJOS4/Kt440USrhqKrcZv4uzrRf7uJhstKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291739; c=relaxed/simple;
	bh=pKZKLFyFEI17SWtvaWH9LZFzoWuFQMuJEKf+90+3XpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVsrD8G45L5eTWYOlusRGExcIE/zBtVGhxt0E++zV0tPfcaqjFSfr2pGXOQ6QBfSdLjlMGhA6nmGIRuRKEHyAJPe5xSrV9bkA4N6ikrE2NSN1LDxHTxu/yuVyPNIGhghcHafvZRwt178+N6E7NSyInpcpVMe9qWpP78d9RLbIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Seb1q4of; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f99f9e0faso6261752e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716291736; x=1716896536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOwHb2FPKGtsc1cG3NXDK56YSWp4wady62ZsYSdaVyo=;
        b=Seb1q4ofMOYlKuTua+1wf9A06qhzVs/pwC7ejqJfGx6M4aNrJI0xRRmlezKmRAgBwh
         PS0N4YnpoZyEoEIznxPGvZ8okbN0aOdFicXujG4ki6e5EytByh2QAWMYBzQotxFHM+v0
         0TwPd4HXHK1XrKfZ5ZaqcJcJsNTEHk+mn32Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716291736; x=1716896536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOwHb2FPKGtsc1cG3NXDK56YSWp4wady62ZsYSdaVyo=;
        b=eCTVHSMB9YDZwVCJWPvdaekikoXTuFkf1KoDd5SDqbSAytctz9cLqbihUexYE5H9Qx
         yenh7r+Py2ekLJWtItWM1W1Awx2gdyPn2+bbOzj7/q4T9xhwsj8QUyRS9Vta83qsfRl/
         n9qGg4R/MVsGhircZRvryaXfFFEr1l091CkcT9hCR4UP8KK7ulbOM7mxvdiwvreafg5n
         h16+fk7C2gzvtfX+gogeG+a1UIqZ1yZd6VgAx50KsgEcahuyJ7oZkhPhbmH3wwVynJrn
         yKLUeZ9fhrcXvewK2kPRVFB9uyC9PLnnaAi9bG2vtUZKCVWXiWwGle0T4tm7jrDKRkyj
         9yww==
X-Forwarded-Encrypted: i=1; AJvYcCVJwoKFq4Wmk1zLgYnPPSIJkwAQK+Hj8/Z9UQ11xP/AcDGozbZfzqcd72PXon2skUvdq+hb4EJ650QdD0cC+3k92HmjiYxpL4YIeir+
X-Gm-Message-State: AOJu0YwypHjYcY/GbiPLM74gNRKAuN2M00LXOufQzl9Y82z5s2qRbL3c
	u349/LK/tTDNGm22P3G965LQX4/eFovq9BShf2uhp2g0qmAPlu7Zg6RenwwRj4qIbItxAmxx+np
	ckxrErh9Nfw145iW1+bKrXKe6qkTAlqJ6hXI=
X-Google-Smtp-Source: AGHT+IGFQbxuASC0z5fcr1ZzpHYzP0ADmVgWr/XRwQrzu8D9zdlyqGnAyFkQkl4o6hfGD3wZgmOVYTkluKrfmrzcHn8=
X-Received: by 2002:a05:6512:1304:b0:51c:5171:bbed with SMTP id
 2adb3069b0e04-5221006e625mr25872000e87.15.1716291735867; Tue, 21 May 2024
 04:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-5-jim.cromie@gmail.com>
In-Reply-To: <20240516174357.26755-5-jim.cromie@gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Tue, 21 May 2024 13:42:04 +0200
Message-ID: <CALwA+NZP7OkAh3_h+bk_iKosBmbshvMfwU58JVjRwG46XevXSQ@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 04/33] dyndbg: make ddebug_class_param union
 members same size
To: Jim Cromie <jim.cromie@gmail.com>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 7:44=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com> w=
rote:
>
> struct ddebug_class_param keeps a ref to the state-storage of the
> param; make both class-types use the same unsigned long storage type.
> ISTM this is simpler and safer.

Why is it safer for members of a union to have the same size ?


>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  include/linux/dynamic_debug.h | 2 +-
>  lib/dynamic_debug.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.=
h
> index 4fcbf4d4fd0a..5231aaf361c4 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -124,7 +124,7 @@ struct _ddebug_info {
>  struct ddebug_class_param {
>         union {
>                 unsigned long *bits;
> -               unsigned int *lvl;
> +               unsigned long *lvl;
>         };
>         char flags[8];
>         const struct ddebug_class_map *map;
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 73ccf947d4aa..152b04c05981 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -799,7 +799,7 @@ int param_get_dyndbg_classes(char *buffer, const stru=
ct kernel_param *kp)
>
>         case DD_CLASS_TYPE_LEVEL_NAMES:
>         case DD_CLASS_TYPE_LEVEL_NUM:
> -               return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
> +               return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
>         default:
>                 return -1;
>         }
> --
> 2.45.0
>

