Return-Path: <linux-kernel+bounces-193086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB388D26A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608D31F2A787
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2217B41C;
	Tue, 28 May 2024 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g/yhiN2Y"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B4B2563
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930083; cv=none; b=AeaoAe3ibpKtduLOCtG9CdKVZTMRUQEHzZn1qNFj9zMQvq8y4Y0A8ocKW6e6iND3qhxtt6LvsjDfAWMDJZfmvkpfT5D4MwehkxEXMR31r4AxZQ5AL47EBN4AD2po1NrUIXXFTUDZWG55Q+HPGZzKajbnQnH0XEmmKyqRu6YgEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930083; c=relaxed/simple;
	bh=+QWwr6h/8bGkB3MhQ5SbVgdATUM/awW+A5S+arrE8JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QC8Y7EicxCyJP7r1BDpV0ml8n4CdCDZHhDkzpI8DVgmYP4V81h/TDUtILmubv+YTebf32C7WW5NSn8fCca5iJffR4QZ+GDysfY90ZS7fZsRhR1GDk19+qBdXApzYLXGb1m6FcIxOxc/Iekqy9hSy4oRAh/Jt/6rtCIOV+3ZLNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g/yhiN2Y; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d1c077b9baso703185b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716930080; x=1717534880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAiZLH4SqBbY1UwV3SCGGHNBB/wuO7Z17nSxSfKqNPs=;
        b=g/yhiN2YXaufUlkCI/MMxllfW0DsfMVvti2TUD/TB9zV1uKpSzzQ3FSvldYPvfmDtu
         0jNgbe6epDRTEIBGwUM66zjn1hadA+8PDLZ15JY6bgsHcKww0sDgHj0OAJoZV7vn3eoQ
         TasxeQ3ZQcK0qa8Jj0zLA3LuiFGL831Iz6tlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716930080; x=1717534880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAiZLH4SqBbY1UwV3SCGGHNBB/wuO7Z17nSxSfKqNPs=;
        b=dUX50pxEzpFsxxlmxiv+yr6oUbgHae2oRehZ2A0guV0IaxJRT46eVxNWNDSWZMvoVx
         5RpjrLF3bsD8ZW19GEl+phNa0UuAvdQYSThf1sfGxz+VKC1th8FpnGYP0mBsdj2gxYk0
         SM5OwaXEcNZSRzDZbPXacPnytJ9Ie/PWV2m4TnqltCIGgOzMgZfghII8sHdjMFzZyHIP
         oCsTM3cwjUOoHQ1g4erG/z1PzaP8lSL9K0j7s+szQkZeqntGMR0yBVK6N2s7N0X6sNn/
         16Z153IQGzC+LZES7U8/4AcVaMhf/l5k7cx8nE9cs7aKtIm74K9pglfwpq6uu2dH0cpb
         hYjg==
X-Forwarded-Encrypted: i=1; AJvYcCXf/VQ6A8nh8M53DxHuI0y1y1Abhtw9hxWnRrfJEcMN9h2Tuws/AbkQZFDSbC6LgPxxKRt8HJaXiEghRjJmtt00pW9iVGv044hkk/Z8
X-Gm-Message-State: AOJu0YzOCPWbL2ZD1lTqiqBV+1Zko1t4g8oxvvBT+TGU7N+UFT0vEWag
	zqGwFPESdFOcuVvRCAGHhXBE5mEqZmhH0KKJPvC8GMCPweg9Yguf+g3RRG955amAHmsCgr3l5Go
	=
X-Google-Smtp-Source: AGHT+IFetCKROVDq7Y7FoWa28Bm8Z6VOypcjZUX6MvcqEIpFPJOrA6K4QGwPvtO2s+dX8I90fNPD5w==
X-Received: by 2002:a05:6808:150a:b0:3c9:6bc8:227e with SMTP id 5614622812f47-3d1a6019f1fmr15536083b6e.10.1716930080369;
        Tue, 28 May 2024 14:01:20 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad7a3450a1sm27590186d6.78.2024.05.28.14.01.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 14:01:19 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43dfe020675so156961cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:01:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/MK1BITSfcldl8HoKs09UZaqw77XjJWCFp5fJEalYp0sWZTvgpd3+rdV1eHfJiWwVmnTyypYh8EoU058bMr+Hx6Tx/2Lq/kFrfMi0
X-Received: by 2002:a05:622a:4d91:b0:43f:b182:df58 with SMTP id
 d75a77b69052e-43fe0f4cf97mr504881cf.4.1716930074114; Tue, 28 May 2024
 14:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527095511.719825-1-treapking@chromium.org> <20240527095511.719825-3-treapking@chromium.org>
In-Reply-To: <20240527095511.719825-3-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 28 May 2024 14:01:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WS+3V0EfXnS2b_t+CFZqea5OM=fs9NMRKapLiQ9qB12Q@mail.gmail.com>
Message-ID: <CAD=FV=WS+3V0EfXnS2b_t+CFZqea5OM=fs9NMRKapLiQ9qB12Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel-edp: Add more panels with conservative timings
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
> Same as commit 7c8690d8fc80 ("drm/panel-edp: Add some panels with
> conservative timings"), the 3 panels added in this patch are used by
> Mediatek MT8173 Chromebooks and they used to work with the downstream
> v4.19 kernel without any specified delay.
>
> These panel IDs were found from in-field reports, but their datahseets
> are not available. For BOE 0x0623 and SHP 0x153a, their product names
> are retrieved from the EDIDs. The EDID of AUO 0x1999 does not contain
> such information, so list as "Unknown" in this patch.
>
> Update these entries with less-conservative timings from other panels of
> the same vendor.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

..and as usual with small updates to this table I've pushed it to
drm-misc-next without a big wait.

