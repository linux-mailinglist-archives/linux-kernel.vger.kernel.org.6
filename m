Return-Path: <linux-kernel+bounces-193085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0D8D26A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01A21C26980
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0071F17B41A;
	Tue, 28 May 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GIyBvUaW"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDFD2563
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930076; cv=none; b=ePanjquOrq3hLAQrqa1E66JaIoQVR83zvxiUFeu5MrfvaLcC9RbtllYVdjAwzcDrxiTCEuQKs+vqYvLElF072StFzULUKc1gV1bazFNxQC1fouwLVH8ZHfROaJ0Pp8rtkVfRrWl110b4IbkgLplH3/fqMYgunY/tplsR3N4S3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930076; c=relaxed/simple;
	bh=cf9PMaUbI5FOdilEcZUZdM45GoPV2rjkvSX9PwgMvF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8f+mgmLY4XJeWYTbXmMsBjQD/c/qlLzuVycWZr/rpnBMr8GUcaW7K9ACK89HkOgj/WPF3vGWPLXMQk5hsjdNFxOTG+Z5BL8F8i90R2WEN+QAki8p3FTJYUc9TGYExS7JDTNR924v4LzKnEZBHg2gBLQdX0QHknjyKGhJPhcEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GIyBvUaW; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ad7d743147so7217386d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716930071; x=1717534871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCcnpJubZASOor34aOMFA4z8fa+dAgrJm6IkELF/PzI=;
        b=GIyBvUaWxe07+UkluNn4V21QEaBxxOSktAv6la7VDvNMYQxX7WWltTfLZsTYukHVsf
         d3AnQYQ5C9MDNtTULgVgQedyKDHN++7agCZAerYK27EJgfPxZmhhfhZg9zAqQYKmncL7
         pRHNuWaBH49/3PuFScJDZ6/mHlpVe/Uf5lTWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716930071; x=1717534871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCcnpJubZASOor34aOMFA4z8fa+dAgrJm6IkELF/PzI=;
        b=w2ABGXXoZIQSJEbGuBqgkgioBOoIuuZuuu+ImxVsol58wgD7fZHtQj9MQH3x6TCbqP
         NB2PEuJQkWcungnkdR5eZV92KK9b/80HdBngzHVDuFp4Oj44MS5SZRaj2VsxgP7nFglY
         QFAHZ6xKmuqbYeoOgJrypNOaiJlJfPwTP8PHGvkx0/oJ6AADESiWVNYAEE/j0KAITnS4
         tLKjTRU9NLD6sbLHG8PCFDRbeVuURpi3qhISiVYZj1tinLqfPVq9iNUYVwQZi7/mmNIl
         h1nJyrm0ABDCagaryuxeI36NHGAPyBjS7bRSiYtxgtm7exnTgNkvqwJ2Yrml+zL3OAVl
         2IZw==
X-Forwarded-Encrypted: i=1; AJvYcCW03UESDmH5MOp0T410fWWnaNe3WrIrjtbNm9romEld3aAAAUiSIExlZT9AbsD6asXh2p2TNnZqz8WcZfLVUu9okWoLxwMtvk7aI5G3
X-Gm-Message-State: AOJu0YwycXOpESf4Jxdi2LOyqv6ZKFE+JbbXnfWXrMz+8RfxVO64V2Z9
	FJ703WsdVXQXVNB4mxEVmzsA2QzpWC7rtKFe6/oqJ3mxTzCDOLYlM8kGqkCEi2mELHTcYTeesaU
	=
X-Google-Smtp-Source: AGHT+IEtiPs0+ZNws7XI95X1tmCvKOKcbWUMeERPI9XrqM0enGjlGpAN1aoEUu4uI/IF09rIpw7eIw==
X-Received: by 2002:a05:6214:3bca:b0:6ad:754a:e4fc with SMTP id 6a1803df08f44-6ad754aec0amr118300416d6.28.1716930071486;
        Tue, 28 May 2024 14:01:11 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad83d33667sm20528636d6.107.2024.05.28.14.01.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 14:01:11 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43dfe020675so156861cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:01:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzH/1GoTLMG5Iz2Amg2vSD4Yr7aahyQyza+hDzPzqpxHDXEHL02/SCXm0CztL5Dy/fckU0lb6a5FuN2e9EoNBhEP1PIo63uLq5586C
X-Received: by 2002:a05:622a:17c6:b0:43f:bba6:3759 with SMTP id
 d75a77b69052e-43fe0f4f29emr478361cf.10.1716930067998; Tue, 28 May 2024
 14:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527095511.719825-1-treapking@chromium.org> <20240527095511.719825-2-treapking@chromium.org>
In-Reply-To: <20240527095511.719825-2-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 28 May 2024 14:00:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUWhBTXeszCm94TM04sbdt3bM7McsXc_Rih86STGGk8g@mail.gmail.com>
Message-ID: <CAD=FV=WUWhBTXeszCm94TM04sbdt3bM7McsXc_Rih86STGGk8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel-edp: Add support for several panels
To: Pin-yen Lin <treapking@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 27, 2024 at 2:56=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Add support for the following models:
> AUO B140HTN02.0
> BOE NT116WHM-N21 V4.1
> BOE NT116WHM-N21
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 3 +++
>  1 file changed, 3 insertions(+)

Ideally the subject would be slightly less generic, but I guess it's fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

..and as usual with small updates to this table I've pushed it to
drm-misc-next without a big wait.

