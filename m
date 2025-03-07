Return-Path: <linux-kernel+bounces-551169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E140A568EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E7188430E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51DE219E98;
	Fri,  7 Mar 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8Nf1V0y"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3101E1DEB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354115; cv=none; b=ZlJBX/Y++/PYJhFJ1wf0Yr+b1Qk5d1Y1b+keKPijqodgexhJT5onw4Hqzhfpnt4LNtbqB3qxGsvFpfsFFPwyY3EMv+TySOtU9960Oc+lLk8QAE8S/RTssA1eMO2VfN/no9TYM1uXZV1vG60hE2fvkQk91H3aPztCDOOCUK+GJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354115; c=relaxed/simple;
	bh=G58WSS2BRYACf8eMDjRCtoBi77EO7RBrcH/PK1+e5i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UR4MLnqC8KC9pi4/Fr+0zmxmcYUcqdBFI+EFIhmO1AInBKMVLKYq4QOrgI1wQ54zj+MTt1qUG++TqGFxK6oaA5psgd34Qba82VSg0ngJ1HDo69WAm8WA4G9DfedQxz8eLOXKltKQsCMmaS31X30YHpAQmV3v1aXaSL2RPXQGsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8Nf1V0y; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2bcbfad2f8cso960490fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741354113; x=1741958913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om7dUSQeU3nA4vWwFqpjqIAryUg9gFGfPyFmJdqn+yw=;
        b=L8Nf1V0y/4aQyA2AhBMm2l8JgYgqUqRDkbYpOGkjOTxKAZe5xOk0HckFUhhW8kW6sx
         ygUH5vP9jAWKPFzS3bfWDSMxlwHORtm2l5rTh7LalvRGWzfoK9Nv3ezJJKC6S70Rluhu
         GEJK4yL+wa3RzTyiqpl8d5fKVprTlMLUQspRdH+5gB85QvvB2kensO1YJl9/BuM5dr60
         qB8AOHBtJUTjdGPLlKMhtmNgGW0T4fjgbtgPRsx9Wqqt9qRXxTYPsTnmgw/CqMI6cOAg
         QXwVnMdbTAb9EEk9xXjwHF31KoVH4RXRNANEae0nkQN4SrSHUClLWAaf399WpGm0FpgP
         7bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354113; x=1741958913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om7dUSQeU3nA4vWwFqpjqIAryUg9gFGfPyFmJdqn+yw=;
        b=rRtJ2UCIYe4TjnuFRRyXX1VmH0sluUxsTWGoTASvT3OhY/3HenbBGqzAqEylPQxC1p
         dTjJed90JRslta2BHfd/wwsi49RUF60E4sC4R5rS1v4DzIDgPO2UDpdMXCXauylNXz1X
         AzSutMIeTrd+JNkF0GFztkpN/K2p8BZr2FxEmfNBQmvzPBBX4r9F7YSamDi7YaPCgJ53
         75zzQ37MIsO1wRIxMm14IME4D7M0QoomszIz1DPavY1BPJLGIbS1gv/OEp/lnxTp55SX
         etdtEhvcUc4+s0576W+Jb3KHi1QTyKovxrSSs0YA20P/21ph5Gfjzt7o7OxAsamvTe4g
         Foig==
X-Forwarded-Encrypted: i=1; AJvYcCV7tboyvJx1bhPPJ8BwRFWK6Uo5QOz/aGaJddzPZKRvMJaFpCIFEGzey1QgmS3vLkGt7qNNHimmgR2eYEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MbglUbKZGvgT7Fdzk8dpALKxHEM8r0iOZuRHrBxmAvMWjtJR
	nz8x6AfEx+YvZeHvhWk7h+Qu2aJe0sGZEp8MJnqnHc/6g3MLQ753XJtBpgBVIFPyU5R3nFe9L0q
	3lkz4lswV+3aT4vv5VhwuuhC3UnA=
X-Gm-Gg: ASbGnctcGCNqg20GmWhCmZw8aAqbauxBcd65LO4lwwu+LZKz05NCdYfUnOSzZd3Aprm
	3pTo5csZxX5ICcI1E72zpi/elozdrxQBC+iuzceY1X0T/5qTmTIhyGVgDZmkdyEhyh/nqGbhqE9
	orK4DB3pbd/C024OZ65x9Sh8lG
X-Google-Smtp-Source: AGHT+IE33fovpF9R81jBgh9BHSNr65ixbRJzK0lDwC/iy1PppPEO9z5fS2XneckRazv9rar0Y1yj92tlmt4FtYA8AWM=
X-Received: by 2002:a05:6870:9a12:b0:29e:8485:197b with SMTP id
 586e51a60fabf-2c260f71217mr1989035fac.2.1741354112790; Fri, 07 Mar 2025
 05:28:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306155155.212599-1-linux@treblig.org>
In-Reply-To: <20250306155155.212599-1-linux@treblig.org>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Fri, 7 Mar 2025 14:28:21 +0100
X-Gm-Features: AQ5f1JqOu2fBJjbXECylHFbNtSZ3YUtFsUmYnsIhzE-HJAPGJVe7c0dc4Ub3W5g
Message-ID: <CAMeQTsaNfQJ=OgWXwQ2bAxa1xbbQxAWDYEcokQ3VJE_EApPbzQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/gma500: Remove unused mrst_clock_funcs
To: linux@treblig.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 4:52=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The mrst_clock_funcs const was added in 2013 by
> commit ac6113ebb70d ("drm/gma500/mrst: Add SDVO clock calculation")
> and commented as 'Not used yet'.
>
> It's not been used since, so remove it.
> The helper functions it points to are still used elsewhere.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Applied to drm-misc-next
Thanks


> ---
> v2
>   commit message fixed to use correct struct name, and add
>   note about the functions used still being used.
>
>  drivers/gpu/drm/gma500/oaktrail_crtc.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma=
500/oaktrail_crtc.c
> index de8ccfe9890f..ea9b41af0867 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> @@ -658,10 +658,3 @@ const struct drm_crtc_helper_funcs oaktrail_helper_f=
uncs =3D {
>         .prepare =3D gma_crtc_prepare,
>         .commit =3D gma_crtc_commit,
>  };
> -
> -/* Not used yet */
> -const struct gma_clock_funcs mrst_clock_funcs =3D {
> -       .clock =3D mrst_lvds_clock,
> -       .limit =3D mrst_limit,
> -       .pll_is_valid =3D gma_pll_is_valid,
> -};
> --
> 2.48.1
>

