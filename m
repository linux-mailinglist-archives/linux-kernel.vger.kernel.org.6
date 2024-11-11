Return-Path: <linux-kernel+bounces-404841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4179C48F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2162D28850D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346C81BE87B;
	Mon, 11 Nov 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V48Mgw+D"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3C1BDAAE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363273; cv=none; b=KK+3Nb+JNhkLuPmoYsm8/FZA40LaeR6PiW0cq/4/fWt//qlc9+c6j0UrYBWfICmbtkHXQsUOC/Tf0IwdF9jRANXgKsK0D175GrJ0AV964I3qhXDnACmbpu0nsIP3q1znpuLl976q/MX96aBam98QT+UfS8hjXZUSc6oz0eip598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363273; c=relaxed/simple;
	bh=y3uT15DDbZWh+TzY8EP4H2Qyk+6F3ZVR+5rPEnJzsYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrxEfecnO3IgaTWlHl/NAA3oYFwTsUJkcklh+h+Xyankw50hVm8mzOgITZ89pLpbJiii5dqCjc7Ex6mDs4UTPyVas/xpv3Tck2SrihIT4cZtC34Kt/hQklTwjBC2zGblZCGHbUhCAeOpan6W0d8jW1M2gqo3Y2vphnXtcFU/icw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V48Mgw+D; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb49510250so42041971fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731363269; x=1731968069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI7boWwqXKndf80D8Nn/YC3JWVhQHek4XwW5deDXo7c=;
        b=V48Mgw+D/Sk/z0P3yxHcHar1fQa0Eo534zkM4KEe5p67cHsCIXGXyzLFhvU0JWIvOh
         YO6wlTokQSm8S9H0QTK14OJ1mibIj0IfxYnRg7x5s7SnqP5hB1QvCISAc/umRj3j6l/N
         NMRPL7MtS0KB8dJG5mmsIUKdSUVY3mBKDibUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731363269; x=1731968069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI7boWwqXKndf80D8Nn/YC3JWVhQHek4XwW5deDXo7c=;
        b=rAIbRF4Ff/mPrGVy5OE5fRsG6qYwCGwzn5zDfaV4DhEUSH+c4qswC1IjdSQA/TR10p
         C15mVrbXdTYf/yZ+2HrNqFRnYgRzKJSVwEr1xbqncVkvN+pQ3GX5N0cCELRtDs96KLNC
         eBwHee7pwNIXk1W8V5qrdJQM2768BleudHb4AwAjTAjS84OoCdgHIvXBJHzocY/ZnoYo
         l6rxeEk6Cb8h61uBqU2YanLSXylIhBlI1JYHPMiFsZZZ1MRdKo8nY8CCTdqP0REaBtXc
         MobTTGRrkNDaStjZlbd1M8pj1HV3LVcR/4lfqW60ZQcl4vM1EQkUq6AA4+yJdwe0P2VM
         GWYg==
X-Forwarded-Encrypted: i=1; AJvYcCVqABn0twNFC9YoCv3Fxxkgdi6mgwS55B0VbNHDM6dF95i4PETTwbq7aC8ks6Z9bjewC4yBD7ZEAjXmd7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrX6QksM+fGxwH/GzQrVUvRtKBOocaqwuYcHeYxw94sBH/NItt
	GXg/EhPiyL6B7kSYjk9ygdfubVOSoo/zRAK1iGrBT9L9B/kmkE8EHSVzg050ptaD1+nKyOWhBqR
	dxQ==
X-Google-Smtp-Source: AGHT+IGrsCl9cqJ2fdBkXy2P0gkJb/o3yuv7Vv7gaSnHdfYm5hRj6V453r6PN3hGGtaBGLZgAXAWVA==
X-Received: by 2002:a05:651c:997:b0:2fb:266b:e3b2 with SMTP id 38308e7fff4ca-2ff2030978bmr62325181fa.36.1731363268630;
        Mon, 11 Nov 2024 14:14:28 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17902152sm17906171fa.57.2024.11.11.14.14.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 14:14:27 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5111747cso43258561fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:14:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmBoTR6Oy9Pq8QCOakUyLzI63x/2zrQfSpcbmOsb0xSEWy7AnVPfasdQUdeUn2wVePWFKqw0dID/Al0FU=@vger.kernel.org
X-Received: by 2002:a05:651c:1026:b0:2fb:411e:d979 with SMTP id
 38308e7fff4ca-2ff202e18e6mr53912041fa.31.1731363267379; Mon, 11 Nov 2024
 14:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111215622.GA161253@lichtman.org>
In-Reply-To: <20241111215622.GA161253@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Nov 2024 14:14:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UJ8DG93Nd_=AgNrsDzN=rj4urUoG3KEnFJijj4UTsJCA@mail.gmail.com>
Message-ID: <CAD=FV=UJ8DG93Nd_=AgNrsDzN=rj4urUoG3KEnFJijj4UTsJCA@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: fix ctrl+e/a/f/b/d/p/n broken in keyboard mode
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 11, 2024 at 1:56=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> Problem: When using kdb via keyboard it does not react to control
> characters which are supported in serial mode.
>
> Example: Chords such as ctrl+a/e/d/p do not work in keyboard mode
>
> Solution: Before disregarding non-printable key characters, check if they
> are one of the supported control characters, I have took the control
> characters from the switch case upwards in this function that translates
> scan codes of arrow keys/backspace/home/.. to the control characters.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>
> v2: Add CTRL macro following Douglas's suggestion in the CR of v1
> v3: Safely wrap the usage of the macro args and fix switch ident
>
>  kernel/debug/kdb/kdb_keyboard.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

