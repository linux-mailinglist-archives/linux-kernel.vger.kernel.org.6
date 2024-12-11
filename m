Return-Path: <linux-kernel+bounces-440949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D363F9EC6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BA8188C09B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6821D88D3;
	Wed, 11 Dec 2024 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lIY9plcr"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A61C175A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905163; cv=none; b=qtlB+fLJ3coKW7SY/ukg+KOvWTusKeAjC1UzXwo71v4d26S7CbfQWF9HLK2GsZFavoD6WnT7XyAMqcZE0cr20uePZ+K1/D5S3aU0MEi7UK2LRNSc7ftnKyc4F/zs8IKcXhiGzpD3dfvUcFerLwc8C+g0+06XZqfzAM5su/TRfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905163; c=relaxed/simple;
	bh=Lsm8C3031w9xBCb23/cgZ3DoZ2ls3z/NYBjnTBCzjJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTYi9tcqENjOGrhLWVCXRx1YfpF0bWz/glmeorcSnxMUP3mXrkwjox53NP51djvfFpYYNW/fNVhAJPxzaq20Rpuh5YzGHMUJ8prXhk6X56cCYNV6bTfC7x/RPYc0Ol2UD3EEl/bBlAA9gysFlNe/QqXIE+YWe9ohZfMjFx0mNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lIY9plcr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21644aca3a0so35813135ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733905161; x=1734509961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S37tUa9+4E/BElh55Abu22jNluchZXe2JCq2BZHuzPc=;
        b=lIY9plcrD8704hgAsJUdrcSN1nUNRJscymBh/2hFyrDBcYQnzzTZ+NgHC428E3+sXm
         tKIqzm0qR6BxGVuwwNoHhoxTi88N/zPAV+iLvqxuoMQv9Dv8LK9RkKYM9oByHjc9kCUZ
         J5lOFeATMXnOqrHt2yMT3kFIIPYruLHkckVKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905161; x=1734509961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S37tUa9+4E/BElh55Abu22jNluchZXe2JCq2BZHuzPc=;
        b=uaUs7BxRdl8dxWI7L1vdaHa1wIfqedN339bJxEnNaZKoZMeSy6vGeRUw/y8JwfC3/H
         FupPQ1oH05J+xwLg2qANikCYfoKALXiCQjgRY79Nx+kAofs3Ny7i3A0IbDkot94purBb
         UWDWCJ8ihNCVENjrUZeYp+5JxO2rwwoL2kex/BYZiFjfJtkgZdv0FMqGP9GOa+er1Ko0
         UL6mO9nRifgDlyOshvtNpHpXnr1FF0xekqkwBiu7FgrF7XF2/icNl6uzpZjzEe3+OQNG
         RdV2oFgTI8Sq4BqhUuO/Zzdg7fNpoGRuVjKMSmBHF3SCgWWu0tCBUKsAkTM+YeLTCDkw
         Me/A==
X-Forwarded-Encrypted: i=1; AJvYcCVt1AcLNA4MIUvYBu89lw+KTh1ulCHVzXE4ZIuecyHZGA2x3+dbmEYXPWdcs2qhvMeD298luJCofQuzaaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVcXxXj0rFBCyskq5uxyFZxtBKfVSrdSrGgy8vdxQ9iOi43fM
	Lpflns7GXrIg/szqz0qcBVsjgbiK4F9Rwh41HmhK/+j0btbmivLf9gYkZoEUYP2KAfHjxs9Tzps
	=
X-Gm-Gg: ASbGnctA3XsFMqiWXjZ8KpVpjb/Ht9aJZrju3hvoiZ3mPfDT9D/2KYiR5rXps5ztqmK
	/x4oDo2P1yhQ1dFkcliJx8RHGG7KZ7DJYWtvWA+31Yzo12hNq+9fGhA3WVRV6AX81PqOB5+2e9Z
	mI8PTGpbe74fganNwtNXLTM7gXwIJmR9Ot8C9aXW8Uh6raFc73qZRr7zzwNWS7vx3V5VS7lNNTC
	l4gu/uA8yROsjB3gk8VF/ur5ohHi7/EWXrLv+gjt09OAbBs9vsxzwFgeaMuryJrZ5b+2ZlCLbey
	uwZZucy1N4qwzHxXBkQS
X-Google-Smtp-Source: AGHT+IFsTPp7VnBUqpn2CuOz76VV+qw74nv/Pzclm9cpyJkHpeEKmESIoY0nu7iGZO5ClHkKv/Q0Gg==
X-Received: by 2002:a17:902:ecc4:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-217787a2d96mr30065505ad.56.1733905161426;
        Wed, 11 Dec 2024 00:19:21 -0800 (PST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09146sm101662285ad.199.2024.12.11.00.19.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:19:19 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so5002231a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:19:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPoKo4pbPKhqQpaDpz2g36kz+J7FokIQToFU/N/Et0NdGYFtJMMw7aOegpjtLRhsiRlWSqUE72ys2CTV8=@vger.kernel.org
X-Received: by 2002:a17:90b:1d91:b0:2ee:f687:6acb with SMTP id
 98e67ed59e1d1-2f127fc7278mr3021275a91.13.1733905159097; Wed, 11 Dec 2024
 00:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org> <20241211091147.717e53a4@foz.lan>
In-Reply-To: <20241211091147.717e53a4@foz.lan>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 09:19:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCvkBvdstVn4GwtdNiJhs67TO6rXVBcsdfRJNgNMXkjvKA@mail.gmail.com>
X-Gm-Features: AZHOrDm09Y0n30eCWNJ7YxalIcoq21V7pnpLmE36rjaksDFouTGIwgN4Tsc_yGk
Message-ID: <CANiDSCvkBvdstVn4GwtdNiJhs67TO6rXVBcsdfRJNgNMXkjvKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
To: Mauro Carvalho Chehab <maurochehab@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mauro

On Wed, 11 Dec 2024 at 09:15, Mauro Carvalho Chehab
<maurochehab@gmail.com> wrote:
>
> Em Tue, 10 Dec 2024 19:55:58 +0000
> Ricardo Ribalda <ribalda@chromium.org> escreveu:
>
> > One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> > throws the following smatch warning:
> > drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> >
> > Fix it by replacing the condition.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/pci/intel/ipu-bridge.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> > index a0e9a71580b5..be82bc3e27d0 100644
> > --- a/drivers/media/pci/intel/ipu-bridge.c
> > +++ b/drivers/media/pci/intel/ipu-bridge.c
> > @@ -774,7 +774,7 @@ static int ipu_bridge_ivsc_is_ready(void)
> >
> >               for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> >  #else
> > -             while (true) {
> > +             while (false) {
> >                       sensor_adev = NULL;
> >  #endif
>
> The better would be to just remove all #if and handle ACPI compatibility
> with COMPILE_TEST inside acpi headers.
>
> Besides that, t sounds that patch 2 makes this hack unneeded, as you added
> a false check at the for macro:
>
>         #define for_each_acpi_dev_match(adev, hid, uid, hrv)                    \
>         for (adev = NULL; false && (hid) && (uid) && (hrv);)
>
> Please place only one set of subsystem maintainers at the To: line,
> directing to the one(s) you expect to merge this series.
>
> In this particular case, the one to be added should be the ACPI
> maintainers.

The plan was to land 1/7 via the media tree with a PR from Sakari soonish.

I believe he has already picked it on his tree. I will remove you from
Cc in the next version

thanks :)

>
> Regards,
> Mauro



-- 
Ricardo Ribalda

