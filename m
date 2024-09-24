Return-Path: <linux-kernel+bounces-337467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD6B984A72
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377B41F25757
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512BA4AEEA;
	Tue, 24 Sep 2024 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KyeNYO2L"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE951B85CC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200142; cv=none; b=oMTwU2wQjJZ8I9kUr8t4S+bnKSBAH4e78KSHGNt5OVLMd0M3uHLBetsdX0sAuzSG3UkxLR5lz2Us9waC10j+tXYzpf3EwiLXDUglcED/PSKXVjlwaicgtG1FwtL5td5T37HrO2A6cEXhyj7HmfVHlvmn+C+GLw4p4W9FQp9N6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200142; c=relaxed/simple;
	bh=v6+1tMSPXdX+e7aqvVNDBI/94dfcqthc8RiI5QbNKDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxRUIJPXSm9O7RzOL/JVORpjP1kaDmgka7HnghP1ItjLI4/xFUbrsjptcKne58DB7B6VRTGuELUGE9d1iKPYX9By5QhPqJ7kMBWRcXUMsLc2I46XmvqQw+iLL+abojcSyj/YpYML6x7P22XtCC5Rn9PrBJxpq8i0tkKnBCY21Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KyeNYO2L; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53659c8d688so81534e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727200136; x=1727804936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6+1tMSPXdX+e7aqvVNDBI/94dfcqthc8RiI5QbNKDU=;
        b=KyeNYO2LxgUBcRVwBLDIgCjHYW0V8PaYl1udNsSR1ugkR5ZFkJYLHfuNT3/s2b3tPB
         ilWFhOnwUMZGgB7dn6Ljd7jmpOPK1XVZ7MIArROD5oCgI3quFL8oE4IeraREzyaHLxsA
         egN6cfBf+qaRy2eNVpZNELymHxn/9C3OtV8SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727200136; x=1727804936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6+1tMSPXdX+e7aqvVNDBI/94dfcqthc8RiI5QbNKDU=;
        b=BJYRgJD0nhDfEnuNpSjKtwvnNCzxHGCp6vrhgraXq1nSirZtHQ8zbZJBHKxm3HdJ2d
         WFAr0PkC6ihpkY5TCVsHyMLHWGNU17ybq9QXapHm4YH4lxg+jC6Y2r1Zkz2h5rH9uAcw
         kax7xl2RENofqTVfSNbjfzNsS1bKfeiazd8X9m0fu8YQzDbowY7Bp5/mlQlNfvLfPgdD
         sH76eROwHj7njtDZaOn1wxESJl8F/PBNFzWgQXM/pm4zX883RwHYMUyG6GNGxLfcp5be
         G518WhTjPvRCdBQJoTqvxlQhpUbiN6OthsvVuXus/uTLMFiUp61tDdaF/17JJmZLjcBU
         RKqw==
X-Forwarded-Encrypted: i=1; AJvYcCVp/jKb8cA0S3ZUWfX4+HzhTFTB3oqKc2Na0m5mn6QRjE80YPFI1M3LV/ksOqhMABHDIy9/gSkNR5Cj8Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5IEqSx2ptWkah/+G9NBXjbIfOYm1xQcuMcYHL1JlN7pLgv5oY
	gmHjG2rzbsv6VFCGDPQvXz8bsfSrE8VS8+zyxquA5BMxTXxquUMx/z1SMoCzkm8DEPgLqa6UjK5
	Q2t0R
X-Google-Smtp-Source: AGHT+IGncUUPI6IGs7S6b9ryViqZK8YNadAc0IN+suGgagN6DCbJe4aCh3aGxpYc+z+tPM2dDJE2GA==
X-Received: by 2002:a05:6512:3d1f:b0:536:5e7d:6ab3 with SMTP id 2adb3069b0e04-537a69215ecmr1423582e87.27.1727200135868;
        Tue, 24 Sep 2024 10:48:55 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85f064asm293528e87.99.2024.09.24.10.48.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 10:48:55 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f7529203ddso1119121fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:48:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwComSDY6udM2OQ4u176eib8dgb3buHPGcgn8ym5Q7Z1AB2dQ74CsZp++oW1qluehGSfX+Q/R7pJgz9qU=@vger.kernel.org
X-Received: by 2002:a2e:bc15:0:b0:2f2:b5c6:ccca with SMTP id
 38308e7fff4ca-2f8d0bc22d9mr14867861fa.14.1727200133930; Tue, 24 Sep 2024
 10:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924035231.1163670-1-treapking@chromium.org> <20240924035231.1163670-3-treapking@chromium.org>
In-Reply-To: <20240924035231.1163670-3-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 24 Sep 2024 10:48:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X2V+LQ1XOo_eJ1Vv3Pn+E309kvyY9FOzaZP_j8ToXM2g@mail.gmail.com>
Message-ID: <CAD=FV=X2V+LQ1XOo_eJ1Vv3Pn+E309kvyY9FOzaZP_j8ToXM2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: it6505: Drop EDID cache on bridge power off
To: Pin-yen Lin <treapking@chromium.org>
Cc: Xin Ji <xji@analogixsemi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 23, 2024 at 8:53=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> The bridge might miss the display change events when it's powered off.
> This happens when a user changes the external monitor when the system
> is suspended and the embedded controller doesn't not wake AP up.
>
> It's also observed that one DP-to-HDMI bridge doesn't work correctly
> when there is no EDID read after it is powered on.
>
> Drop the cache to force an EDID read after system resume to fix this.
>
> Fixes: 11feaef69d0c ("drm/bridge: it6505: Add caching for EDID")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Ah, I guess this answers my question in the previous patch about
whether caching was important even for external displays since this
driver only supports external DP and the commit you mention in "Fixes"
says that caching was important.

So this looks reasonable. One thing I wonder is if you're totally
guaranteed to get a PM Runtime suspend whenever you get an unplug /
replug of a display. I tried to dig a little bit but I'm not super
familiar with this bridge and it looks complicated enough that I guess
I'll have to trust that it's fine. So...

Reviewed-by: Douglas Anderson <dianders@chromium.org>

