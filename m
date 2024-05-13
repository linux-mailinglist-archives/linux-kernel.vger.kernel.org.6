Return-Path: <linux-kernel+bounces-177858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4538C4563
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1868A1C20803
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE51B5A4;
	Mon, 13 May 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QcI4m9Ct"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82018C3D
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619354; cv=none; b=hkUI4KWjDTKtLjyFIQySva9O8RhbFuUF8A1cAx6FjeaWUJeqbyCNgLGlXJ9lLcWr1hRvNeRsuLmtCBg4/Doo0dFWLJTmOycP4OdWs5GSC3cTY0TpZzlkuf9K8Ic3aixHkTUet5vg50PutSo5OJ/7cfDZ5kh0duMW/SYmLu2phpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619354; c=relaxed/simple;
	bh=Q4T8vXoHPZEkmdIakq62WIsnrqTauoxd/8JWnWqS/P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqDpDX1hCBOIrTEPpyFTMa8tKj8OfLAOwsLIHLCYx8B2pIYlU4yT2v/0nw326qMcM7HY9IChJTSayx2g+uFLoxt47nxlGwzzAXpIkQjJWf3M2Qg1VlJTqqg7PHVwavpQAXEMxC22C8eG3AANNC2WovtOyhsZxDx9NyXKtUvMyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QcI4m9Ct; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7e1e0939cbdso44213539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715619352; x=1716224152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3xjzHuMpEUX44ljRlkgoiEVbWwXbypeHFgnO2FiPZg=;
        b=QcI4m9CtR2kBVuSVVUhF6zzWodjXExMg2DLiKGV6/HsWd6geVQw+TLBlx13HriDylX
         KKIdVD/hRzpZenUYo+BtAUv8zLZ1cVoFHIcGA6KDu3mOt7T64BztL2csbfWej2t5W8wp
         aa2HrNkgFUaT965ny7yNwULrL4EeFr6Iic37Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619352; x=1716224152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3xjzHuMpEUX44ljRlkgoiEVbWwXbypeHFgnO2FiPZg=;
        b=IgGg2gJ6/+KfL+Y40VBqFXFOWEdjZZsPAsBggs59l0r9PjJfGLrb7WbQzBFUnRJ5Zb
         EFrDuHjGuTj+aQW9jOu86rIyCHsPIP4baxH5gTvG6mOq6bh7RUzTXMbNMA0qo6LihBLC
         buQgL507Vy0s2AJ8isWsbcwI46UE4jkPcpbDUULqv/rpWIiUOHkW93yybeNj+w/hN15H
         oB+8S/w0H+d9lLypj39xxIJUV2kOgSm3L2iDWza0fjfAy1NX0/bX50eH/ZF6zofRQceh
         I2MHI+7P7zjEwLvbnkKQiA2R0mwf8FC+SO/NSfIndFNBxSsYutVmD2NEbIyQQbSo3DG6
         HNnw==
X-Forwarded-Encrypted: i=1; AJvYcCWuq04Tzokt9WMt9h3CxrQkTFDLdMNvNSzJYVyA1n5U+idgzAndgZlmNUhCPdHQGirUcDz7F/WKWsjPTcZFaKTSfWgIV+tXnNYYvMID
X-Gm-Message-State: AOJu0YxX4+xDso90nPRnpQHKSOb5SS584fMi8mHdf5nGKJdTtWv4RvlV
	rtoDI4Tc52E57HMh3bJrZqcty3WiqbvUhZLnqWjjeZRvlGcyeS4IQsuJu2tk/Yt4NlnDiwlYsqs
	=
X-Google-Smtp-Source: AGHT+IHPrB70BmtT2jh7emRHE9oUKENnWhl44s3Z241CY6HNDAYMuW9WJ1BuJc/DDTVn9iGZDQFKqg==
X-Received: by 2002:a05:6602:1cd3:b0:7e1:7e1e:624c with SMTP id ca18e2360f4ac-7e1b51b6194mr1119974139f.5.1715619352141;
        Mon, 13 May 2024 09:55:52 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489375c19a0sm2610474173.108.2024.05.13.09.55.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:55:51 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36c6dd950d8so366925ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:55:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXymvT0rBEq1fme5GOu/JzD6F6JVFsvmZMiNaj/GpFj7vCu9leZY4d0aZJfDxGl71Ajma3dwgUmAqKZrTFJdpvL3j7SXCOgVkMV1hri
X-Received: by 2002:a05:622a:510e:b0:437:b572:6d with SMTP id
 d75a77b69052e-43e0a2240ccmr4259321cf.21.1715618997464; Mon, 13 May 2024
 09:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511021326.288728-1-yangcong5@huaqin.corp-partner.google.com> <20240511021326.288728-8-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240511021326.288728-8-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 May 2024 09:49:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U0AqC1HKaVfJhw4zQjH4EPyWdQ=sNGOd=Of48A64hHKg@mail.gmail.com>
Message-ID: <CAD=FV=U0AqC1HKaVfJhw4zQjH4EPyWdQ=sNGOd=Of48A64hHKg@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] drm/panel: himax-hx83102: Support for IVO t109nw41
 MIPI-DSI panel
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 10, 2024 at 7:14=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> The IVO t109nw41 is a 11.0" WUXGA TFT LCD panel, use hx83102 controller
> which fits in nicely with the existing panel-himax-hx83102 driver. Hence,
> we add a new compatible with panel specific config.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
> Chage since V6:
>
> - Add hx83102_enable_extended_cmds(&dsi_ctx, false) at end of inital cmds=
.
>
> V5: https://lore.kernel.org/all/20240509015207.3271370-8-yangcong5@huaqin=
corp-partner.google.com
>
> Chage since V5:
>
> - Adjust inital cmds indentation and check accum_err before calling mdela=
y in init().
> - Adjust somes inital cmds to Optimize gamma.
>
> V4: https://lore.kernel.org/all/20240507135234.1356855-8-yangcong5@huaqin=
corp-partner.google.com
>
> Chage since V4:
>
> - inital cmds use lowercasehex.
>
> V3: https://lore.kernel.org/all/20240424023010.2099949-8-yangcong5@huaqin=
corp-partner.google.com
>
> Chage since V3:
>
> - Depend Dous'series [1].
> [1]: https://lore.kernel.org/all/20240501154251.3302887-1-dianders@chromi=
um.org
>
> V2: https://lore.kernel.org/all/20240422090310.3311429-8-yangcong5@huaqin=
corp-partner.google.com
>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx83102.c | 131 ++++++++++++++++++++
>  1 file changed, 131 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

