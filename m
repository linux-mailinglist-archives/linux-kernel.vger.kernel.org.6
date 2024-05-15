Return-Path: <linux-kernel+bounces-180479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DF98C6F10
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 01:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA27280E94
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5B24D5A5;
	Wed, 15 May 2024 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrII6GyH"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D39101C8
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715815077; cv=none; b=R7wGKi+h205VpZQS0tvfS9xot+66+uwqvNi5iNmwknI/DFyXXH3+yT6eZupmgqFz0p/JKkvyodIxRe0ebPg0RoTsq6rNEHiWUqsv/ufYpPuCaCgzoMGBf5G8wwokoUViaWISBeIkazBgSRh81QNYl+PJBYGoz/NVR1fXPN74rwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715815077; c=relaxed/simple;
	bh=rXiiDvC0G8yftHUqkMlkQjgaeYMZEVMFUgTD9x7Hgo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjnUK0/MYgAzfz44vhET1BeCnZhahWbQ0MQeEbrGNN8YpSrBLtpdxrQPUl5EU3f2tog/CzWbxnYzpV+CUAXZl/84MdMDJbuzfiWws4mzvI2lrFw85cTj6oJQ/0paENHeMA9s3Z8I9blONM55CybVMZ9JAio/U1xtJWJrJPaiAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrII6GyH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so245353766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715815074; x=1716419874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KQkiI/PZoB2oJorTHLYz0xoOjUhSuDugXleksLOQ91w=;
        b=MrII6GyHEmVETxZG2bxQHeHhLdFDi5e8GSzhBNVdVq4kSuEJAArgSlh2pwSOYWkM0d
         9rczSP/gPwTe7zW5TF15oZhLimIPlzEhh9M2GtXzX9zkxz1GvwoT3gz2i6nnLHVGSuct
         nmbVCXfC9pnWATKtZe0K2avEnbCDI8QzUroWkMMxV63FGR/4aERiAnnEqQqzZZKolr7c
         8UJelvKMPTfS6aAnw3TsYCMecxXqZGQRE9324xPjNb2b+nRTg45A5SJRaw7MZQWtaOJD
         2zCLduv/1jrQ1uhCiNnKJZK82b5rMcDOrImP9T2GZ2C1NXxPz0q4HK0vM8zextBuOwHM
         qUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715815074; x=1716419874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQkiI/PZoB2oJorTHLYz0xoOjUhSuDugXleksLOQ91w=;
        b=HHu2/kfpgigIT6D4mH/jUtNRs+xO0XZCgW2NchqCueyCS+/wKtfiOtNPPXaMmnbDr+
         c893hOTYaQvl/BavUw9DyOZPrs9N9FjDPg9NEeOuwShOqR83Y6IP3/MaLhrN92VZXlLR
         7vHEe9O/eVCyYFrfziEz4DLyIi5pleBAODZBJvNNT4IN8mcbEQEKYZ4dhvynjFzQgf6A
         s64UUcI3YQxV+Gex1HrVrEet6EoNfzjSIuscieiAWQELTFJmvyCz1aw9YRjrGLyn1CCu
         jQDZ10zaTw1VyT4L57vA7l1YO0qdisLoNqKv6M0CEtK11uBa1q1Um+Zw41BlNFuiuhiA
         OBgA==
X-Forwarded-Encrypted: i=1; AJvYcCUuykQVxziJ6/i8/4BMs9gC6wQIli4lDekAfBqWtpYV6CnG5ovbcFyFDNxrMRwc3cE4cnZTVmZmx9N/pR0wibqRdcLOG498RaaSDGJZ
X-Gm-Message-State: AOJu0Yw9A1G+YmnVY0/y7OyqC/Oq6OM2RnBKuUudjDkOfK53lxDx8sPc
	X4hU55+1j2WI35T1XeYtLldqsdE2xBk+mH8COCHWWFX+hZnr8W4SMzpdgRPtqMct638drS05/KU
	KuCNVo8Jwl3NNi3zpW1+aefI5sSU=
X-Google-Smtp-Source: AGHT+IHuo2WCZvG3HdUyqPlEEQPeV4QkDD96yJ7fXtu9aQhRZOLuTLsMoRXsGUMrONerqPk1SEO9VdQuEio5vRe/IjA=
X-Received: by 2002:a17:906:2b0d:b0:a59:be21:3575 with SMTP id
 a640c23a62f3a-a5a2d672ee4mr1259988066b.51.1715815074233; Wed, 15 May 2024
 16:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com>
 <CAPM=9tyOtH24Mw_2X+bgV9iChOQV3LtmRCoR5x6KXhSUD6FjUg@mail.gmail.com> <CAHk-=wh8DWSMrtuhZOzanfBCFcuJCihO9x7fkzx-dBhLddXF-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wh8DWSMrtuhZOzanfBCFcuJCihO9x7fkzx-dBhLddXF-Q@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 16 May 2024 09:17:42 +1000
Message-ID: <CAPM=9twCVkx9OqndCcvjjgx+P7ixBRwttiz25-R=bkycEo5vrQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 08:56, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 15 May 2024 at 15:45, Dave Airlie <airlied@gmail.com> wrote:
> >
> >           The drm subsystem enables more warnings than the kernel default, so
> >           this config option is disabled by default.
>
> Irrelevant.
>
> If the *main* CONFIG_WERROR is on, then it does NOT MATTER if somebody
> sets CONFIG_DRM_WERROR or not. It's a no-op. It's pointless.
>
> And that means that it's also entirely pointless to ask. It's only annoying.
>
> > depends on DRM && EXPERT
> >
> > so we aren't throwing it at random users.
>
> Yes you are.
>
> Because - rightly or wrongly - distros enable EXPERT by default. At
> least Fedora does. So any user that starts from a distro config will
> have EXPERT enabled.
>
> > should we rename it CONFIG_DRM_WERROR_MORE or something?
>
> Renaming does nothing. If it's pointless, it's pointless even if it's renamed.
>
> It needs to have a
>
>    depends on !WERROR
>
> because if WERROR is already true, then it's stupid and wrong to ask AGAIN.
>
> To summarize: if the main WERROR is enabled, then the DRM tree is
> *ALREADY* built with WERROR. Asking for DRM_WERROR is wrong.
>
> I keep harping on bad config variables because our kernel config thing
> is already much too messy and is by far the most difficult part of
> building your own kernel.
>
> Everything else is literally just "make" followed by "make
> modules_install" and "make install". Very straightforward.
>
> But doing a kernel config? Nasty. And made nastier by bad and
> nonsensical questions.

It's also possible it's just that hey there's a few others in the tree

KVM_WERROR not tied to it
PPC_WERROR (why does CXL uses this?)
AMDGPU, I915 and XE all have !COMPILE_TEST on their variants

We should probably add !WERROR to all of these at this point.

Adding Jani who was the initial author of

commit f89632a9e5fa6c4787c14458cd42a9ef42025434
Author: Jani Nikula <jani.nikula@intel.com>
Date:   Tue Mar 5 11:07:36 2024 +0200

    drm: Add CONFIG_DRM_WERROR

where I see we actually removed the !COMPILE_TEST check in v2.

Dave.

