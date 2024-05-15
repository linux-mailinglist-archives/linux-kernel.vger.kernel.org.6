Return-Path: <linux-kernel+bounces-180453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224168C6EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C43B22AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACA53FB1B;
	Wed, 15 May 2024 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbQ2psdi"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326739FEC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715813125; cv=none; b=k6InTN5mciQgS8CNLdbVFEwR5jKY0DhtLnRd4blv5FPye8FIF589Fu+DkXcvX5/CjtUQdSPhYN5hvfWSHaubZQWfKboGGXEliDG3He+pHIThx24eNa4ZTrwCyS8nFoWUoga4HWv8GyIruBOVKmDnfd6kxslf8hu2RDZE4NcK0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715813125; c=relaxed/simple;
	bh=7yzWmZ364OkIuO7sH24bl0+F0rv6Nd2L/awqggmIQc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBazQf/IzdgHQCjSYT/uyb60tGKYjVSulJlDrKG2xclmdqMar/AJipw+3uEHVuTj0ANfK8WkeP3wmxir+zo8/ymSg9S1/0gTESxjNC8TY2Vbc/HbvUA2c6jPIK/X8k2Sdcit3rjWq3T2+8Edr/nYhQoQPieIEBlO8wCTg+kNzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbQ2psdi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-574f7c0bab4so2286075a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715813122; x=1716417922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a7lJcqe1kAwWaUrSqQrIwPbz3u27O8i6pHbRPj7VwJE=;
        b=QbQ2psdie8kJN1S8wfIXSCZxn7MP84vtDenaI1ATV+ORW6DDcFi29/Qrs1WOc/zaBm
         s5+AdhgxpPvb+2zKzCvbwqYMtGIzqay/otZOjxmIf941w3n9AkCfShV6xnF8peZCkzMT
         y8pn/C9cAUN8jxLGTuPyRXJoMmoLYjOongUIIcSFzK10sv39NJf1M/D2thl3EY83ky+a
         IADpWAqWQsMZ5fWBkZ8YaKLb2Xifb/Zv0HA1CPu6BdYw8dvGRfnLruV+5fkZutFpxN0r
         MG0DX0J2pIZusPVT0dyjTgdLn9EZ4LvkTYldXfrkGTEkF+5Kf7QQCYSoYY0jnFHRxrOi
         J8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715813122; x=1716417922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7lJcqe1kAwWaUrSqQrIwPbz3u27O8i6pHbRPj7VwJE=;
        b=MndbO5UnzlJcD32zDNuy+OJyQKBhBXGH4ijnu6cuPm9jwtVmkcjvKdFt6JAhg4E+fC
         g7MRVS2NnUGTnQ1dTwxrC0GQdWcPLTqZI46r3Noi/Sovt1CNzuWH7j6s07DKpfHCv6ah
         EEBnW5Jx8Wz1Z7CQ/8oqLwguNU3MGOJkrM12WGvP1+VQqwsiIsKiiDifpna3owaTYbn6
         nMOTmxF7UNrqPwet6skaco042Stssmi911CzuF8bI8s+H3P3Acnz+SlDYFWnGuxkaUPg
         WJTceBINzeq/pfa39VN/eZ5frpMcCGsWzNCHgHMIw/5t4Eo2ckaXKCn/NZFNIa99ENEi
         +7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVFWiOEnmOe9V274dip3mBD3iK7y+PETcH8JeqVSMYVluuKcl6qcbC61p3u/yyOa4GpyQqJV/RDLDxu73tRK8dDl+ltNegtEFvYBh4K
X-Gm-Message-State: AOJu0Yw9tiVPfpFq1+q511wiYdOXsb8/tlexO5KLSzLxDpY1PJwx5Mf0
	UY3nxIfW1K6pfl49l/2tGPDOj8P8V+O1kNsQT8++vYfweG6xQBlOLFZLFV/Any/9NtRqvNU1Dv2
	HH5UNeiVRp50Wpcb1Z9G9g8G4Wy8=
X-Google-Smtp-Source: AGHT+IEnZtZ4SIfj9sglEMTaE3csfFcwbLewzJHmHxd5wagZk24j1xIRqljEdAzdOdGSa0hRMsUs6IixlaN9ZeX+DQw=
X-Received: by 2002:a17:906:e0c5:b0:a59:a979:2b03 with SMTP id
 a640c23a62f3a-a5a2d292b12mr1486105166b.23.1715813121682; Wed, 15 May 2024
 15:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com>
In-Reply-To: <CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 16 May 2024 08:45:10 +1000
Message-ID: <CAPM=9tyOtH24Mw_2X+bgV9iChOQV3LtmRCoR5x6KXhSUD6FjUg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 06:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 14 May 2024 at 23:21, Dave Airlie <airlied@gmail.com> wrote:
> >
> > This is the main pull request for the drm subsystems for 6.10.
>
> .. and now that I look more at this pull request, I find other things wrong.
>
> Why is the DRM code asking if I want to enable -Werror? I have Werror
> enabled *already*.
>
> I hate stupid config questions. They only confuse users.
>
> If the global WERROR config is enabled, then the DRM config certainly
> shouldn't ask whether you want even more -Werror. It does nothing but
> annoy people.
>
> And no, we are not going to have subsystems that can *weaken* the
> existing CONFIG_WERROR. Happily, that doesn't seem to be what the DRM
> code wants to do, it just wants to add -Werror, but as mentioned, its'
> crazy to do that when we already have it globally enabled.
>
> Now, it might make more sense to ask if you want -Wextra. A lot of
> those warnings are bogus.

The help says:

          The drm subsystem enables more warnings than the kernel default, so
          this config option is disabled by default.

It's also

depends on DRM && EXPERT

so we aren't throwing it at random users.

should we rename it CONFIG_DRM_WERROR_MORE or something?

Dave.

