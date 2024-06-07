Return-Path: <linux-kernel+bounces-205904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDBE900204
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3799F1F251C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1411922EA;
	Fri,  7 Jun 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ikJXzkVU"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419CA188CBB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759248; cv=none; b=O0QOHsTw45CDTFRyEfTfFwBaQ13VqqgNrBNSyu3c5CodGG56iqR93KfOKxlHWaad89H2cXE1CcUXIbAxOG0/UIU1093Oc7g/+wOIsM3HyxTSo3YdLc0SRtRFGaU96NnTWzv4+4Gci9ds0hCysYDjUXPvwbvcN4iihx2iIK+mx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759248; c=relaxed/simple;
	bh=UXrg4sVxCUukDDGsNqD6ghGWEjqWMXR9QLDCnb60Xb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDc0ZMlEc92EUjffgqnNPwW9iiZYxI92/OUg39lyDVL7L2fSooALQbfUdxM6ary7nZ8of62/MgFHcJ0ln5qRvMzOpn/k/Hyupb/gcrmIqWtBSqZ02qw4IcnCB3zErSLf3eSo5uaffHDsxS5bfV1FM8JyEN/XztQlt2PmaArGXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ikJXzkVU; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48bbcaf093bso541041137.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717759245; x=1718364045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXrg4sVxCUukDDGsNqD6ghGWEjqWMXR9QLDCnb60Xb8=;
        b=ikJXzkVUoJlaP7m4ktiYZp0f6x9iliC62cHgHjwyPCBDpljsGCHWbrvIuDvTvJF5c4
         L7n+ME+4DKCX1moxPGwTOvcTVTuIcoJM070ahFZCZt41pxdTpARMcdcxHq2TyGp+Wlfi
         JJq5mievJL9wOkW6fBApYucEO5cKTLACmGU1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759245; x=1718364045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXrg4sVxCUukDDGsNqD6ghGWEjqWMXR9QLDCnb60Xb8=;
        b=Eo6OrE1V+JU8x9EJUPQ6KpSVOUHqSykocuKVYa9sYfTQbUwVByKW4HfK5aKWjz8Ra8
         U+CnsYCjhYRZaQmDi06tvUD/JHfuKZKnUo8GNLMYGz2Rx2DfHdp1FHjcH6/UYJeW4m+i
         RIdwiwaJqlaOs32tQjItCpLe06BkEp4LkgvW7XH/q/cvTC6PoNo5Fk3FIDtH9+DeHYLT
         Xci7oM2ylzhLJ9hrBHWuC12iHA75YKdbpoWKl5Oe8oquiFj+FYv1jCpU067HWXOarfxz
         O5uQySKq/5PXeREAYnyaBp8bTlFdEcuUUlsSO++U6mzE6huSYXBI2hJDdBEGk+xhqX4+
         oBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvJ/jrzznpG+ob36ncWxxtJ+XMSaMRkyzU2bcBhYoTSj8NO2ln3odFcX2tvUEbNqDOstzQr8l+P0iZW+R0qbAAWY2MZ2pKx96zJTbV
X-Gm-Message-State: AOJu0YzhjeRkwim9fywm2v3idIfyU5rAxpBMYIR+s8pc/jyzLVW7sYZe
	/hPDp8bRMJw4miBmgAmZzOHSYIzOMnWHHMnia+J8qwO1oYV9cQcGDSpCxzKV2fZPMHeUFaiAYaA
	=
X-Google-Smtp-Source: AGHT+IEtW6i9y0ohbtLgYQKee7VLJGZQ2Eu2AdW5Q/asoIzD06TNQXXPq1ux64BZc0YLkUYow4ID0w==
X-Received: by 2002:a05:6102:1285:b0:48c:3475:da33 with SMTP id ada2fe7eead31-48c3475dc3amr494708137.7.1717759243612;
        Fri, 07 Jun 2024 04:20:43 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-80b788b5963sm92771241.18.2024.06.07.04.20.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 04:20:42 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48bc3314cddso731783137.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:20:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4th+FkUIRL8XxTVts8BbmOYzd3B2M1QFmVxo8BFvJ5he846sFvZpguSMyg/CI90LYRkVsj8HeWrE+ByD8p1X5NohjLJdqAMOlBhTM
X-Received: by 2002:a05:6102:34e2:b0:48c:379a:b362 with SMTP id
 ada2fe7eead31-48c379ab51dmr77117137.15.1717759241750; Fri, 07 Jun 2024
 04:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521095536.3869399-1-fshao@chromium.org> <9f73dffc48394e6304263ac2293a2b18864ae3dd.camel@collabora.com>
In-Reply-To: <9f73dffc48394e6304263ac2293a2b18864ae3dd.camel@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 7 Jun 2024 19:20:04 +0800
X-Gmail-Original-Message-ID: <CAC=S1njnqrdrQqJZYQ7mffgmAUUxtoO7utZumED0dmX=Fa9+Qw@mail.gmail.com>
Message-ID: <CAC=S1njnqrdrQqJZYQ7mffgmAUUxtoO7utZumED0dmX=Fa9+Qw@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Reduce msg queue trans buffer size
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Yunfei Dong <yunfei.dong@mediatek.com>, 
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Xiaoyong Lu <xiaoyong.lu@mediatek.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 8:47=E2=80=AFPM Nicolas Dufresne
<nicolas.dufresne@collabora.com> wrote:
>
> Le mardi 21 mai 2024 =C3=A0 17:54 +0800, Fei Shao a =C3=A9crit :
> > In the MediaTek HW vcodec pipeline, the `trans` buffer is used to
> > transfer the data decoded by the lat decoder to the core decoder.
> >
> > In the beginning, 6MB and 30MB were allocated for the trans buffer to
> > handle FHD and higher-resolution contents respectively, but it turns ou=
t
> > that's more than enough in practice and there's room for improvement.
> >
> > The buffer sizes were reduced to 5MB / 8MB respectively and the decoder=
s
> > have been validated to work normally on the MediaTek Android products.
> > It's time to adopt that change in the upstream MediaTek vcodec driver.
> >
> > Reduce the msg queue trans buffer size to 5MB / 8MB respectively to
> > optimize the memory usage per decoder instance and improve the overall
> > system performance.
>
> I don't disagree with the change, but it feels like this is has hack over=
 a
> hack. We have an entropy decoder (LAT) metadata buffer, which of course i=
s
> resolution dependent, for which we hardcore two sizes.
>
> Any chance Mediatek can document this blob, or at least document the prop=
er
> relation between the size and the resolution ? This way we could dynamica=
lly
> size the buffer for the chosen resolution and trust it to remain big enou=
gh for
> a long time. Removing the non scientific claim of "have been validated", =
which
> is producible for anyone hitting issue with that change in the future.
>
> Nicolas
>

Sorry for the delayed reply. I totally agree with your point, but last
time I was told these are what they are using internally so I guess
it's not there... or it could be me that didn't ask the right question
(we want to do this with finer granularity or dynamically).
If we don't get an answer here, I can also bring this up to MediaTek
next time and see if they can provide more details.

Regards,
Fei

