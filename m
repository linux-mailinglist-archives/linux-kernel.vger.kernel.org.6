Return-Path: <linux-kernel+bounces-364487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401C799D53A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055962828B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46631B0137;
	Mon, 14 Oct 2024 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LapglRyV"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F25C29CA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925434; cv=none; b=sTBTSZmRdoJPm7NLzOLt8yIGlCHya919NTTMNhDAf99+tZb8Wer35QrN0MDnhPBkD6YhoJbo1ZtiRlIJnCUnznG88mWJt+I4yU3LzhHVAWmBRYkgmV40bmP44Q8rBQ1Z1ESj45YwcK2Sq4N0UKkhYmv3FhOvHe1fUms954e60ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925434; c=relaxed/simple;
	bh=QgHhEkaLzgOlydjYpoXN7smlVjp0xbTpJ42Xq4kBQvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3iWX14rt38rD1TTeXLow+KhQBmAg0kdp2T6ffJEu1xZb3VG7VNz+d7REHhwEX425aQAMJM7di+vmsJsKXl1YtxdQ55S3bNSbwg71HATUGoimwZp88vkauDRnQQZZG+HQnBUVo/XpbaxsfCw+8c24rzhodyBG37tUtIMN5+R6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LapglRyV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e1543ab8so4442026e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728925430; x=1729530230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpqfZpy0KhNOi4dX7TpD4nUG6HhaVwhIk+AiVaYBRNs=;
        b=LapglRyVZuYuq9NcEv4pOAHHSXma0CA4XkKq7ZZDiwIwIU162BbqE4TpEdkLc0XBWI
         pSBKHIQAmFdn5lWnU0rl2NS9+hQq+WRQ6Q4vk54Ax5vWts5uE3G0ABuzr/6zUtqGKVR/
         47IwTG+y26b/JiSgTcAzc3YjJ2+StXyKHV8UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728925430; x=1729530230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpqfZpy0KhNOi4dX7TpD4nUG6HhaVwhIk+AiVaYBRNs=;
        b=P/i/XSSX4NLMdeIgLFzjodGB//xT/WbuGAd9ri5gAy84zpL8IL3dNOhDRIidnCV+zO
         RBsiPyqD6Tz++pzsKUbjRiTu5D3Nu7ZhYB9GgE4atTvn6kIAy1NVcgWrdl/CznNARr5Y
         BxFcSsg8Buw+RTFFxEN369SOZU/5sQoSLKQKOdEbo+/6xLMgAxalCGPMOiMXk8eAeaEs
         +AtCPBxeED8tytLpo3c3Az1DsiddEMcTIjISWY1pdQDFLmhubEzHDg7ZOwOf2Pu1T9xC
         ghedupUDiyq+STqgGRmPkJnMx1hModlXbZoZByWWfhRnNAuaf4Nz7bdk+SJ3XZGPsfO3
         XmUg==
X-Forwarded-Encrypted: i=1; AJvYcCWeD3vvpjsVwcaSQxkgidC/f3WrdfUX81mWx51puxznt1wC9N2R2OOb8TRmK7rJarqmoZZzWjhm210MM04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6+CyYO1p9oTxmvx9kW0fPoMC7nFyMD7qBQtR8TQ2+b73d0vx
	6LALWzFgYVekcIgrpnyZEXiFaVveN9SaKpNvrtDQjOd95QyOlP2oLQNqGSOvDnhWaM081BytJ3z
	hPg==
X-Google-Smtp-Source: AGHT+IFxEi41NuT3EmOwZjAI0TkCraPV08H6kA5V7LWjTmuvSk4cwKCp+EVqpbRxa5oTsG/hy8XA9g==
X-Received: by 2002:a05:6512:10d1:b0:536:a695:9414 with SMTP id 2adb3069b0e04-539e54d7907mr4267635e87.6.1728925430377;
        Mon, 14 Oct 2024 10:03:50 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539e4488019sm1103581e87.78.2024.10.14.10.03.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 10:03:49 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f58c68c5so2013895e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:03:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWXGbxDnC9lA9fzYnHHY6Xvx5dgoneUbxg+RsnIJsgnogOggbwU9xeGfiiGdPwyLEoajwkr7C9OBNQzHY=@vger.kernel.org
X-Received: by 2002:a05:6512:39c7:b0:531:8f2f:8ae7 with SMTP id
 2adb3069b0e04-539e550179cmr5026613e87.25.1728925429365; Mon, 14 Oct 2024
 10:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011020819.1254157-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=XfHtdc9RpEwAtVHNYwBGJGhHUAoHaJhP+ZPWuUHAASFQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XfHtdc9RpEwAtVHNYwBGJGhHUAoHaJhP+ZPWuUHAASFQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Oct 2024 10:03:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UMaAo9x0URaaVNxzx+ztLreAcbiAfLFvDFNcHut5srvg@mail.gmail.com>
Message-ID: <CAD=FV=UMaAo9x0URaaVNxzx+ztLreAcbiAfLFvDFNcHut5srvg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: Adjust power and gamma to
 optimize brightness
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, linus.walleij@linaro.org, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 11, 2024 at 7:20=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Oct 10, 2024 at 7:08=E2=80=AFPM Cong Yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
> >
> > The current panel brightness is only 360 nit. Adjust the power and gamm=
a to
> > optimize the panel brightness. The brightness after adjustment is 390 n=
it.
> >
> > Fixes: 3179338750d8 ("drm/panel: Support for IVO t109nw41 MIPI-DSI pane=
l")

When applying your patch, I got a yell about your "Fixes" line. It
turns out you didn't copy the subject of the patch you're fixing
exactly. The above should be:

Fixes: 3179338750d8 ("drm/panel: himax-hx83102: Support for IVO
t109nw41 MIPI-DSI panel")

I'll fix that when applying. Please make sure you get the commit
subject exactly in the future.


> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/panel/panel-himax-hx83102.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
>
> No objection on my part. This is just modification of some constants,
> is well described, and is to a panel that you added so I don't think
> it needs a long bake time on the list. I'll plan to apply this on
> Monday unless there are comments or someone beats me to applying.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

I've applied and pushed to drm-misc-fixes:

[1/1] drm/panel: himax-hx83102: Adjust power and gamma to optimize brightne=
ss
      commit: fcf38bc321fbc87dfcd829f42e64e541f17599f7

-Doug

