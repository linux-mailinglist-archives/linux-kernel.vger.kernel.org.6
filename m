Return-Path: <linux-kernel+bounces-223375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F01A9111FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434AD1F225C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB4B1B4C3D;
	Thu, 20 Jun 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J9RMUDQC"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AF22EED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911102; cv=none; b=DMJHjL3qBFuhtbaWW7Sn0DyMZeQ6NkWjEU+sLTvUObh5WNpD5pf/Yy6YNElQ25XXOihiPNFRAn0mDJjp20uxt2Qz2qqb8QwwN9izznrxcPw99srPkruEe43naep9UA+JS9onm1CbaD9eKUNm9A+dDCzeE3Db6RiNxNRJHkYnfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911102; c=relaxed/simple;
	bh=Rbe3f+lB5Ro+BQNQZ0q4+dlQz7zvxl7OEKOq0of1IhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JX7FwCXdslmnnWZKWMUyPZ3+EkMOww4loT+zSNcOcypSSiNh4IeXrxjv/jtT6jX6n2Y2rokgKZ8mhFkX5rJF+DJh6y/f5/C0X9O7HTLm2t8qlYZa9NJAHoM2FtXO2dh9yqeL1kjMemwkNmy3WqotM3UnlN9oUyDAfGae0FxxejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J9RMUDQC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7955c585af0so66235185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718911099; x=1719515899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejsoHVwhFG9/ygIbEOYT86bzjsPu64MEjeZtGRSh1XM=;
        b=J9RMUDQC268sblPcyE2f5q7kwFCIYW4ZYpljs4b+ldFQczZ9nfGC3kkZ/2TH2rYAJ3
         uP+VsDM9Mg6md+9NQBFU6B5oAXOhz89yxvc96+PZ9ZYGqMUUQvJ1a8jeB5RRTdiwYezv
         bXgBncjNl//EeKBFTbBWnulzRB/YG2xJtZGGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718911099; x=1719515899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejsoHVwhFG9/ygIbEOYT86bzjsPu64MEjeZtGRSh1XM=;
        b=UMEU+43J0xaD//XV5wb00Fdm4wtg9z6hh0kNGKKU0GgO9EOXjpWQqo1PSaAdeVq3SP
         S/I5CI3yC7lbNBAEGMoxLVMwP2Mu/mZRlEeFbHzOz4kW1MUspiwhEu2MIptaEf0g6nfn
         wVGFro2O0WtyWJnoo5EV08IYojqXYUCENpAG1qHH4ofFjsggEvF85nS7uNa9fWLSYFIz
         CU7v81PMVHu4E3qw/RdWJj6qKbSyg+yawKng/6ODtYHiFazmzIBFEZvVL3r6ZCUSJqJx
         Jb6sLUeTqll+fLuKUc5F7zW9heXKhdMaR+KDe5FAfA55VdCh2AD0cectUIPOQps62p3s
         kcRg==
X-Forwarded-Encrypted: i=1; AJvYcCU13yOvs9vYsJGa5936DWV6fkEjbP5l6+ml1cVUS5NX9hE9jdBQFn4SQ7mHRPETEwuASeQB1fkvGjm4P7L4iMLujOSWJ9ZcOc40PLA7
X-Gm-Message-State: AOJu0Yy04tmANDdoHBkJATq3Yh345PyqEn7oVVvnYnP508MR265F4yPi
	Ye37ZMAyzgan3xyfgtWLkPPJ7LXavoTQ/8X0kJp1A/Z1Yjj9jjkFH+xVzxtfXO0cVqz4hndNnXQ
	=
X-Google-Smtp-Source: AGHT+IFFKEkeq9Y37P36b9sb0UrT5hRNYk2J8oNdZOCbVCBQq7oR4ggxLmnODLMRPz5nuh5IeRXwxQ==
X-Received: by 2002:a05:620a:46a5:b0:796:af63:b7c3 with SMTP id af79cd13be357-79bb3ecacd0mr721146485a.52.1718911098891;
        Thu, 20 Jun 2024 12:18:18 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8c3574sm2749785a.69.2024.06.20.12.18.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:18:16 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-443586c2091so86461cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:18:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5THjvE9+gdo7skTiKg3shUiIT7HjvKrUr+yFdIZyh3Ymnb08Vrff3c4pqieG3LVFs277dGghpd+/+v9tBt8tLSCIByzuwwkZoBl3d
X-Received: by 2002:a05:622a:1306:b0:440:3996:84aa with SMTP id
 d75a77b69052e-444c1dc7fb2mr352411cf.15.1718911096385; Thu, 20 Jun 2024
 12:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620181051.102173-1-tejasvipin76@gmail.com>
In-Reply-To: <20240620181051.102173-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Jun 2024 12:18:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vpb2xy68LUT9MRi2d=Lze=5AyPjV-ff5FLW30Q6MasJQ@mail.gmail.com>
Message-ID: <CAD=FV=Vpb2xy68LUT9MRi2d=Lze=5AyPjV-ff5FLW30Q6MasJQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 20, 2024 at 11:12=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi:
> Introduce mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> raydium-rm692e5 panel.
>
> Additionally, the error handling in rm692e5_prepare() is changed to
> properly power the panel off in the case of a wider range of
> initialization commands failing than before.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v3:
>     - Remove extra blank line
>     - Expanded on error handling functionality in patch notes
>
> Changes in v2:
>     - Change rm692e5_on to return void and take mipi_dsi_multi_context
>       as an argument.
>     - Remove unnecessary warnings.
>     - More efficient error handling in rm692e5_prepare
>
> v1: https://lore.kernel.org/all/20240615093758.65431-1-tejasvipin76@gmail=
.com/
>
> v2: https://lore.kernel.org/all/20240619033351.230929-1-tejasvipin76@gmai=
l.com/
> ---
>  drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 238 ++++++++----------
>  1 file changed, 99 insertions(+), 139 deletions(-)

Thanks! I normally let non-urgent things sit for a week or so before
applying them, but I'll be on vacation for some of next week and the
one after. If this is still pending when I get back then I'll try to
apply it as I'm getting through my inbox, though I'd also be happy if
someone else (maybe Neil?) wanted to apply it next week.

-Doug

