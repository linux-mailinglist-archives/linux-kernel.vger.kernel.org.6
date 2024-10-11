Return-Path: <linux-kernel+bounces-361283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A9B99A62A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072FCB218F2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B7D218D7C;
	Fri, 11 Oct 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jfxXddjj"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9771E87B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656431; cv=none; b=FUZi/B7HuAcIGgCdnHq0pIMQM+4RyznlJLP9Quqq2s22oMuzLqGZwzB2mqs14cYsEFnc0ojWNIXsZEh4nWi7sKPuXZExl7Y2nL5i8xtvQbYqUIN+nR3eqr/76FeS1gW8gjK3Oyl0D4WoAtfiXxQx7LCwrrWwEPnM2fcmLD9yYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656431; c=relaxed/simple;
	bh=7EbH+3VAZ1saDb1IT42ACcxguJGIG2cli9j7ZXzO7kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsJBuvhYBsZASS26qxPyoes0UxW+d87kSssiaXg+vu5kgf/QQm0NUEOLPAyftXy5kV+bOyu4RX50IHIksF1xbDBnFpZb29tnBBLc6qEqbaV29gyf2yTIe3WBVYEJ67KSxoQ/ls/ADlUU2dYRvXdVhLkzkWjvK6WCjMIEyXw7b6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jfxXddjj; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fac787f39fso23589691fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728656426; x=1729261226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvzCEOHylQFKpOsQ3b4jdnej7dL8ckuDevHyY8WxVL4=;
        b=jfxXddjjJVdpcl9/t00ko6Ot3AnoxHqiX2O2it5DfPgd9auHps3Ek2wOl8HgFCh7+M
         TX3srYQ2GeiazQZaUjgtPrhAka/qT37e2qRsZ0VmQ5yTJ3cZ6WDAQlhyy9phIOfH4qY4
         cl1fzu6RhYZpqQOSMiWNUc8h0bsyNVU3eOFJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728656426; x=1729261226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvzCEOHylQFKpOsQ3b4jdnej7dL8ckuDevHyY8WxVL4=;
        b=uPPoRxdm0RDU9y1qodZe3yPqNlS9J0nVQIn0V3Ib7PpY55nOzhsLsNGneG+GzBGyxz
         j2weM/9YCyhLAoydsjysMc/DHxlz0XJWG5k2Ft9wPB0dEuS8uMnySgY7wXbl/lpegDbr
         TjfFp+pRm9rRGWY6yfhagBIecO+lVRU+sHEgUTBFO5tzWDwbqyVIRUBtI+tjexwWn/A+
         hEgMyWmVOEIVrsub1lJTfRklDD2rJNaBtA+L5IwaN/lJH4+DAjL4fB5x0yDE1IF9AWub
         aS1axQrWxzmIx63pc+u+W2f1UxWUhpodb2hSkZ0SzXz1ag98BoSbyUDxWc36Oq/Li9OM
         1nng==
X-Forwarded-Encrypted: i=1; AJvYcCXrhY50AYJO73QRbdaRxSR4N8fnElApEn3E3skmKFXIgjpUIkHKV9hZlZtj49DJwjYKbppkRcP9ZggUkQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUL9vFLuGGOqynR8fQaa9pVUhkAgOJeQOsEf268n/V1crIVSZs
	CoJBDKyFPhBeVDcZcVw2sEfQaxpBimHS35sSHqF5u60xsxzo5wlE+02EFCLWOD0ipPCoj0bTqCT
	yo+yQ
X-Google-Smtp-Source: AGHT+IFkQ3LNNfDjYVvBtbTTeVXixbsxRqKPa2t/aDMo/u/zo/BgDVkabzAJamW22AoFKqJXsa+7+Q==
X-Received: by 2002:a2e:b24d:0:b0:2fa:fc3f:d606 with SMTP id 38308e7fff4ca-2fb3272ce35mr12846651fa.22.1728656425596;
        Fri, 11 Oct 2024 07:20:25 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb247729bbsm5231581fa.133.2024.10.11.07.20.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 07:20:25 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5398d171fa2so2754700e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:20:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlGdHn2FlF57SjhBV85EyUgDeNUoJinhUyNy8sPljqDabDSgQ52d2V7e2/3Ff9ffGysNihBHf/V30m8yc=@vger.kernel.org
X-Received: by 2002:a05:6512:2302:b0:52e:9b9e:a6cb with SMTP id
 2adb3069b0e04-539da3c649dmr1856067e87.15.1728656423759; Fri, 11 Oct 2024
 07:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011020819.1254157-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20241011020819.1254157-1-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 11 Oct 2024 07:20:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XfHtdc9RpEwAtVHNYwBGJGhHUAoHaJhP+ZPWuUHAASFQ@mail.gmail.com>
Message-ID: <CAD=FV=XfHtdc9RpEwAtVHNYwBGJGhHUAoHaJhP+ZPWuUHAASFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: Adjust power and gamma to
 optimize brightness
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, linus.walleij@linaro.org, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 10, 2024 at 7:08=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The current panel brightness is only 360 nit. Adjust the power and gamma =
to
> optimize the panel brightness. The brightness after adjustment is 390 nit=
.
>
> Fixes: 3179338750d8 ("drm/panel: Support for IVO t109nw41 MIPI-DSI panel"=
)
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx83102.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

No objection on my part. This is just modification of some constants,
is well described, and is to a panel that you added so I don't think
it needs a long bake time on the list. I'll plan to apply this on
Monday unless there are comments or someone beats me to applying.

Reviewed-by: Douglas Anderson <dianders@chromium.org>


Thanks!

-Doug

