Return-Path: <linux-kernel+bounces-171786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DDA8BE8AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF91A1F23748
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665F316C691;
	Tue,  7 May 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VWErID3z"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B416ABC4
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098785; cv=none; b=LjI+wOoHWCtbQqMlZSRXphAXMOlXLPWJqsXTKQ8kTOpZTtXONvf0TEKxTF61VKstHW3EQKEIhDRqJSkJcn5ADvLiaa/Sxes/Z3YjoyenyXrePYUeMXV0YJwmYdkw5JSSC524xcvy8C4021vPE9aWpqEZLVGxWACq1Ss3ur3QLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098785; c=relaxed/simple;
	bh=nuE7Hje15d435noQ6oio6QflofQiQ/LyahZFOtihOUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D34Q0/XyKneCAsv2rnv4+y2nPL2egiYGU1JkxnOWZ8ZrSj1htB8FuTOINVUF7EM3RX93CzKncgzxvIxgC17Q1gbQvXKX9qX2g6/z7GwJXeu8XutlsZxdabW+GLOaweDPWhh7JbKX/enzjRkjY9fCxOklXs+vgJvh0bmX+KvHYBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VWErID3z; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-439656c1b50so18553761cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715098781; x=1715703581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrlcgV/ss0UWVmE0JQWGJQN7bh+N6Cn4d6Xqz8KuFtk=;
        b=VWErID3zThFRlwHB6xUsvrzUx4nF4Mqm3er0+LA8p/b0SNTMI3EKLo75bEYGEBaW2J
         NuET7uledLJF1HlCpn2YGc/py+Ih2f+dJqDI3R3qSWDmud7hJBETw/Mh+vhxt9ic6rk5
         nmgeFPN6Y43g3I+N5Fqz/GYkHGLeEf489JHlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098781; x=1715703581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrlcgV/ss0UWVmE0JQWGJQN7bh+N6Cn4d6Xqz8KuFtk=;
        b=Zeoif7SMfGNm/xGcRJccvpbO3DOl4isNvkW5MT5vIzqCDwm308k2kffRV/eDSeGIVp
         P3KX6l5AFxN0l2lMirAZqAiHEffim4Qh/ZdTqUy3e+qgY9DBYonThExPgW7BL9FKKyYi
         vurZJR3KEAm2zFJvtvfNKNBZxj7wKXLCGV2Ca9VokubRppgG4iIZbJe+PsPP4DspqHb6
         urxavdCjJOPlJHwABgNyM8BEWcAw+PfPPV+DERmtQPvNnnb1qa4mt0l9Ql5pJxvZ6KOV
         tO7T41Wfjf8ZzcmQzrx0QxWhKz1vBBUMlQ4k94V6CB8QbBG0uwSK8JKw82+V9BhLIigE
         zi3g==
X-Forwarded-Encrypted: i=1; AJvYcCXcLuQgHa/YjGQMCx0bmJhHqAxnX1DwS95LsClVTYnhPj/ytGRoIQ6nI9u19z4o15hBQuNbRX/0b+0Wgr1obMIl8Jb2FfzKNqdZxE40
X-Gm-Message-State: AOJu0YxRsdKceD+k7KMKNycm6pf40cEqyPZdDZH0xPEYn1v5WuEYcYnM
	uh0zGrEsq143I7WCDTYHJaf0joJy9LuZAi4tPWGS3VnLdYkN3X1KvEXg4S2DAnME7O/1IFIrZx8
	=
X-Google-Smtp-Source: AGHT+IFAsMQWKmNMT/WJYZOWTIG/S/IcsKkgbxdO5mT7mp53cWu6hNcCakzzxp1OS+qKgQLll27Mcg==
X-Received: by 2002:a05:622a:5b8f:b0:43a:ecf9:c19d with SMTP id d75a77b69052e-43dbed4c9c7mr2202291cf.40.1715098781542;
        Tue, 07 May 2024 09:19:41 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id bz6-20020a05622a1e8600b00439c1419553sm6611495qtb.44.2024.05.07.09.19.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:19:40 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43d55133609so390311cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:19:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVp8MxQb60141+fLHDDg854T/BO63h5lpQChW3vFRvpHnL1b191zNA4Zr50QxkhjIp2CXG7txepFXQL+v3/yH1pnl7ZBfxT4daYzloI
X-Received: by 2002:ac8:6ecf:0:b0:43a:e2ea:bfa5 with SMTP id
 d75a77b69052e-43d984d1473mr2462641cf.17.1715098779928; Tue, 07 May 2024
 09:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502153234.1.I2052f01c8d209d9ae9c300b87c6e4f60bd3cc99e@changeid>
In-Reply-To: <20240502153234.1.I2052f01c8d209d9ae9c300b87c6e4f60bd3cc99e@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 May 2024 09:19:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WWQiv8WEdjDYXV3i7RSOssnvurq_aNwGU+-EDcVGK=LQ@mail.gmail.com>
Message-ID: <CAD=FV=WWQiv8WEdjDYXV3i7RSOssnvurq_aNwGU+-EDcVGK=LQ@mail.gmail.com>
Subject: Re: [PATCH] drm/connector: Add \n to message about demoting connector force-probes
To: dri-devel@lists.freedesktop.org
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Pekka Paalanen <pekka.paalanen@collabora.com>, 
	Simon Ser <contact@emersion.fr>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 2, 2024 at 3:33=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> The debug print clearly lacks a \n at the end. Add it.
>
> Fixes: 8f86c82aba8b ("drm/connector: demote connector force-probes for no=
n-master clients")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/drm_connector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pushed to drm-misc-fixes:

6897204ea3df drm/connector: Add \n to message about demoting connector
force-probes

