Return-Path: <linux-kernel+bounces-560696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925DDA6085F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A995616ECE5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A28143895;
	Fri, 14 Mar 2025 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CAqfbod0"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21E1E86E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741930835; cv=none; b=qn4NW5Abg3BP9I5Om4ZFSYmlZgbHoSvorl+eQFRBL8TJuhS8xsuMh3g14k1JX/y8eX5o2PYZzcH9G0S76wT1BMVEA9PJkWLXj0w7UAVCS+Hu5mkudbQzG1652xYdPfuw52E9pi119LbwDCSnxvYdwjwOzTveUfTizumHKdNx0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741930835; c=relaxed/simple;
	bh=9P6g4eTczIvn1VFQPL7r3DuGjsOk7C+WUFt8Sf8NUBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2p65acYzSFhoS6XInLdU+cxCEKAOAIX5vg6fka1eM6l9v/JKLryVV9KaYUuCQvzYf0mSrghM11kHc4rjOw/QLa6xEd/vwnwySoREaKNoSI7XVZzOZj0egka5RYpqUXvwDBYGXLytwtmxoIZVnYCTVsOqCQiPdu7VqleFkA1e/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CAqfbod0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5BCCB3F68D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741930823;
	bh=KHVvEo4a2v+cW7rLYC5E5IP2TKLmXgAPS/TIAmIpZA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=CAqfbod0caPEckgS9cNer6BoSFf/KO1mGs/BYj49aXoHqLwxLkPzuH2eFJZuPrFIP
	 k/i7Yma5kpGdFm2XaY+yMTtOhPSmDaErnapN/zgGAxVVjrW8k1oqoQLA9E7fXnna5R
	 pSmDrOt5VO3fJcu8Gha8jMBWb9h/xx3x0w5FZeJNojnOs1LZUCpOu8JqBsiJUM5+/M
	 NyleL9xzJfli2yftCCuiZNHKvknXcQyHWbPT0fj4jlnFGhT8me9vNNQdYNtihb5BNF
	 8BtMSFtEJvDr5o8q8qUfDI0E3izwgObi3piN2yjOBs8ydNOSmHH50Yf7ymRtjnzgqt
	 s5qF4c7ydIaGA==
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-523da152dbfso699646e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741930822; x=1742535622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHVvEo4a2v+cW7rLYC5E5IP2TKLmXgAPS/TIAmIpZA0=;
        b=FHtAd+AhEEuNQFYGrxPKx8HhTaFCXOXxy2nk51/885SNWsbEeNQZI3dBJTmd15ql/e
         BF8Yr0fFaK4PgoShcMt3h5MXWTa8/lzZ4iDmZCf3a/c2aZvXYqvLKHxXy7TNd1Q7vI6A
         Jniz3kKup/YX0XfJOUJCS5piLvUJc952jJHWqDJiJQRVKTfEfLXDhnYxvL7VjDAzhEV9
         JazmcVI9P1zrtur8MKdRNZsMCVMbSUUVhgaKIs05eJy7/k6GKnMPHTLnCGrnyZjbzRAX
         +UXJ4guzj4JcFkGRPsKwbEHMyt+x7vsQcjA5ckw1pND1at/FJe8miud3GtrUXkWYcRMb
         dOxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsfxnCZ6Alksc9h/W4eMrFo/OxBKU3xL6obbqHVrk7gbk3NwWXOgOyQtim20yE3Tm0MDtcHokMVm+cebQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYhAQjZayIK+vlyQCBQ2p5DsvynSkLahRhtSQ+IDqx8vWvW6wz
	PpZpdsso0t9UA8gzKltRxUPMT68jCbEAw1GyP7M92zrwyUCf+OTQsxio2voPaRVwa4UbT9bOyEs
	19OtdyJNnVsNQ2RMQ8hyZKPdlagJ7XEQ/lOsHe056uOIgVxEP3tYclTOS/KBzH2My5gWyUZuieX
	lujaphQ9ZzAFpXS68xfu0Wehkk31yYpYBTuSUvRtHSFDjiHpF4C3VK
X-Gm-Gg: ASbGncvCYsX722SrY20gIQ4W7Oj/W5fVwD2guv86W2sVRKFWr0SUlg5LjGlLkRBh0Ti
	hWq2O4F1zFx6rZ1QyAvf8+2IkMJucVQ0dDFKWiNkozEDJsKy+prGMbyiqBsftj2Esbkqa+PgaeQ
	==
X-Received: by 2002:a05:6102:3ed5:b0:4c3:52f:175c with SMTP id ada2fe7eead31-4c382f9c38cmr701333137.0.1741930822217;
        Thu, 13 Mar 2025 22:40:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkuI4xwxwmD4W5vZwFXVV+zKk/vRrjtyFmpUBFLwhuuzFgHWzblfl66y37xJJgM90/2dkfIVuz1WX3xnyepHM=
X-Received: by 2002:a05:6102:3ed5:b0:4c3:52f:175c with SMTP id
 ada2fe7eead31-4c382f9c38cmr701328137.0.1741930821970; Thu, 13 Mar 2025
 22:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313041711.872378-1-leo.lin@canonical.com> <878qp9dx54.fsf@intel.com>
In-Reply-To: <878qp9dx54.fsf@intel.com>
From: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>
Date: Fri, 14 Mar 2025 13:40:10 +0800
X-Gm-Features: AQ5f1Jqt4zZ3VwSHms6FObxGsQo-FxR5l0nzNgI0L4koCsAaEmsRm1MKhPg3l5o
Message-ID: <CABscksPic1NdfVs+_g9s_HtyDtAACKNshbMXObWApmiMMhyf_A@mail.gmail.com>
Subject: Re: [PATCH] drm: add .hdrtest to .gitignore under drm directories
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jani,

On Thu, Mar 13, 2025 at 6:48=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Thu, 13 Mar 2025, "Yo-Jung (Leo) Lin" <leo.lin@canonical.com> wrote:
> > The header self-contained tests in drm may leave .hdrtest files in
> > include/drm/ and drivers/gpu/drm/. Omit them by adding .gitignore
>
> This has already been the case with usr/include for
> CONFIG_UAPI_HEADER_TEST=3Dy but I guess nobody noticed before.
>
> Maybe fix that too?

I think for usr/include there's already a .gitignore for that. For
example see commit  5134e94ac4f5 (usr/include: refactor .gitignore).

>
> BR,
> Jani.
>
>
> >
> > Signed-off-by: Yo-Jung (Leo) Lin <leo.lin@canonical.com>
> > ---
> >  drivers/gpu/drm/.gitignore | 1 +
> >  include/drm/.gitignore     | 1 +
> >  2 files changed, 2 insertions(+)
> >  create mode 100644 drivers/gpu/drm/.gitignore
> >  create mode 100644 include/drm/.gitignore
> >
> > diff --git a/drivers/gpu/drm/.gitignore b/drivers/gpu/drm/.gitignore
> > new file mode 100644
> > index 000000000000..d9a77f3b59b2
> > --- /dev/null
> > +++ b/drivers/gpu/drm/.gitignore
> > @@ -0,0 +1 @@
> > +*.hdrtest
> > diff --git a/include/drm/.gitignore b/include/drm/.gitignore
> > new file mode 100644
> > index 000000000000..d9a77f3b59b2
> > --- /dev/null
> > +++ b/include/drm/.gitignore
> > @@ -0,0 +1 @@
> > +*.hdrtest
>
> --
> Jani Nikula, Intel

Best,
Leo

