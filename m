Return-Path: <linux-kernel+bounces-527712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A701A40E6D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830DC3AF763
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423AB205E1C;
	Sun, 23 Feb 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7p8377r"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DE205AD2;
	Sun, 23 Feb 2025 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740311103; cv=none; b=JBRwCjMwuvugJqCwi1d+Mj1T88QQxJFmB9/bKxYQxUNBhNYXzB8dfws599iDbya0gBG/b3jUimuB5gtToNyvQDGIuWVIihd/mR5QA3EfbnavVR6GmkhiGo3rekVkC7Rp+hRDJvYAeLMeveuhyhTXHhBOzErc3MwsvKGgO9GFHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740311103; c=relaxed/simple;
	bh=WtQLiUtxlY7jOBkqMlKxzFRYp9wU0OtHvKBwlhSt9RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pVrqD6uJyBz4/XFh+j0BGKQxehGfcXsHJc6tJ1bUoMUl08Nvf3/3sZ7S7lJ6gPKxfDvqE8zGbyC5T6I9xq279el5ie1RGEF5AF0Z77jOtpU3TJY1JiHtFzW10hh2MzSw3zn3tQOArMtoNLBgsjJBZtanvOYzSi+QA+WsK4qmoOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7p8377r; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-545284eac3bso3494078e87.0;
        Sun, 23 Feb 2025 03:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740311100; x=1740915900; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtQLiUtxlY7jOBkqMlKxzFRYp9wU0OtHvKBwlhSt9RE=;
        b=V7p8377rhaXWieG/1uY2pvkPre/QdJCbS6K87V3F42lqxD9iIabrF9m3SRKmbKRjPH
         1LB4/4BVvt5IEwYXKDHshUDi4j1w6gaAFOHTkQ2laDPx8FyW2E8lMR84WOY0jDW3F6G+
         LlgXUo4q+pRpTWQa8EYBYm9HSh04dvwzGKI/ZnJ61OQ7OX+0stJL93BUX10/x1xLwN2a
         BYnTotsfgS262jJonf3NSpf6WPosiDLgyLAdVo5mB4BiaoQ1AG2tpVRubrveGAgB9y0/
         qRaiN2kfvKKJ898sBv13qXur7IIKD8kK108BERosL6LGS3AZBG4vG9qPqCS1cDSVUVhl
         p2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740311100; x=1740915900;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtQLiUtxlY7jOBkqMlKxzFRYp9wU0OtHvKBwlhSt9RE=;
        b=I3YZpxg9AJrIetKJ93A23r6n+4j2uFmTSrXKGHNLcqNerGSHj/uYVQZJWVQHKQp9Gp
         rAz8m2hl/Om3zl9eCz6MfPr7HLh8Zp6jSyzVlKjR93KQdnkvmLjNv/J6ycT8slvbYIgg
         qUUT+QLbFXXz8wVBw8xPN3ZKQ3AjFJQBpiy+WHNvxBnamFI/6zbAdD46vp4ZFiE/k8Dd
         BK8UeXh7WlYPefJyli81tBxmaC32RXyaiS74YOORxD30YwbNw9+xX02/nYWfvZJ/1DX/
         BRGE7XuPshALYqlPqY/YUTn0oTj7vmqNMRwcKBbzClXk4soRFyTAxFoNJt9Rv09Q/uzK
         AgZA==
X-Forwarded-Encrypted: i=1; AJvYcCX4wzlEIJRA7JlFdj7LsJkjDV/H3udEm+Z4ImOlVkHTwDf7KU21c/bcSo0ANTyPpriVzlzYqBw964cabovf@vger.kernel.org, AJvYcCX7QOgbEuiH6SFCK2HZWLd5rHkUP7c7tSlEmjmg/mjt8Qr5KwFWni5grOnAlWWpUM4AAwIAvMOQ0tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5CtJsrYSf9jBJPArvFQIEm/1Mk9sJbPrK19UjAafOdR4Cfhbt
	B1s4cEElEzi6nh9jamukTzC+HCOrA6JUD8wtXqXoXJH2mO7MZl1/93QcDCp1Z5AFtyaH3ye5PXW
	UTWz0zzslZdLa2U/DSSkzIZzqS30=
X-Gm-Gg: ASbGncuMqpTQHNt5bYvea0gfih5ciqaw/i+dawSnMdCr++LVmhj653mSrTVBqSUUHIO
	vHe8Ib3XLt84QSBYeB1dZekKSdLMxaTrXHhKZ4lrTeGG+1oCMvzKd4AMCIgAgyr6Phemw+PgSkb
	zVXY7dKDQ1gMfnB4bqVNK49gjYWLyn2dQYiOMJMUIt
X-Google-Smtp-Source: AGHT+IFXdyTaLGb71sdwhuFPbKFfl6zs87BcvN+nBv/3PAoR+eNgHv2zos0UpogzeCxvv45FfKaCGezUok3jmbH90U8=
X-Received: by 2002:a05:6512:3f05:b0:542:2e09:639a with SMTP id
 2adb3069b0e04-54838edddd1mr3320418e87.10.1740311099559; Sun, 23 Feb 2025
 03:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207165325.3998-1-pranav.tyagi03@gmail.com>
 <Z6bKR9K16-oYMLFl@archie.me> <CAH4c4jKe7Q-E1LhA0KxOxEjK-gn=JY7e=2GN13X=yutaO8k3Pw@mail.gmail.com>
 <CAH4c4j+kOYMfzO5QOBg+hGe2zt4kN4f7v+mrri-2GMLzYtCPrw@mail.gmail.com>
 <Z7WOym9fl8GNPJiO@archie.me> <Z7XdkAKqlK2KJuq2@phenom.ffwll.local>
In-Reply-To: <Z7XdkAKqlK2KJuq2@phenom.ffwll.local>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Sun, 23 Feb 2025 17:14:48 +0530
X-Gm-Features: AWEUYZlGbGI477Musg_0U1Z8C_cUlMEZdld-9_O8sc0I-75qlnom3khRJkDC8B8
Message-ID: <CAH4c4jKhXn=EhoLJLYhD1jro_KM0TemNnVjokSFRR55oUVuPjA@mail.gmail.com>
Subject: Re: [PATCH] vgaarbiter: documentation grammar correction
To: Bagas Sanjaya <bagasdotme@gmail.com>, Pranav Tyagi <pranav.tyagi03@gmail.com>, 
	Linux Documentation <linux-doc@vger.kernel.org>, 
	Linux DRI Development <dri-devel@lists.freedesktop.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 7:03=E2=80=AFPM Simona Vetter <simona.vetter@ffwll.=
ch> wrote:
>
> On Wed, Feb 19, 2025 at 02:56:58PM +0700, Bagas Sanjaya wrote:
> > On Thu, Feb 13, 2025 at 11:05:39PM +0530, Pranav Tyagi wrote:
> > > Hi,
> > >
> > > Just a gentle follow-up on this patch. It has been reviewed but hasn'=
t
> > > been applied yet.
> >
> > You may need to resend the patch, but with scripts/get_maintainer.pl
> > output Cc'ed so that DRM maintainers can be notified on the patch.
>
> I don't have the patch since it wasn't cc'ed to dri-devel. Can you please
> resend with r-b tag included?
>
> Thanks, Sima
> --
> Simona Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

Hi,

I have sent the patch again to you with the r-b tag included and cc'ed
it to dri-devel aswell.

Regards
Pranav Tyagi

