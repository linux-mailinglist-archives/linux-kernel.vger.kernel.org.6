Return-Path: <linux-kernel+bounces-169375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C08BC7CD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC851C21009
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 06:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BDC4EB30;
	Mon,  6 May 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjHe4A17"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23345948
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978157; cv=none; b=jaZTXP2Ozz1TZl9R9z0rORdnpSS0yHdlSnAeShpbM31+DzqWVqzXNFmDpp/V8vXP98kmaDGMrsQQoxVykBE7fiGnkOk058FBcBozTpgbD2UcBVgP1Gp4yJkli0EB7f9W8OXtvTkpYLxH593nWzF51yZPxa1Kfe7vJuwGs3K5z6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978157; c=relaxed/simple;
	bh=Nrafd49uuelVpJdscgz/Mad+QSbSTwFXfEAGUqb3rGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITsF+rlq2CX9T2N9IpxTk7QnlFpAiPL5u23fhUqEbGOHhaMVejMav3n5F0vI6d/Cao2xReWYV/6ZPRIc93djDgluqdlypuLpbVxOUzOf2e8e0XxzmWQZyIX9xVWXoxcV1oVNKgp6CgvgydFqQ1Z50qe20b6ojmTFdRfEECO0X2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JjHe4A17; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61bee45d035so17073287b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714978154; x=1715582954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8noqLZ7rreQXY6bq7wOdAQ/j08jV52ZrD0dDyncfUM=;
        b=JjHe4A17Qh2fAZWvkvarWKaJMMOrdR5v+hHYGKR4foHXLhf7IXpgEb8sBRhOZhHYjK
         jrIltMlsVdtk8iuG8MvJiguf+6cflDGtBpqizOoRPltf1GMma4TXYUUeTgztPU6BOmxT
         d9mcdKZ6D1+hOsV5ZfxImi1v/nxk3VH7mhNjqhlWi8wvx3Q5UPEfBSMlfO16DYcrB+m5
         5g34H8/c4IjR6qpIvdDucYyw7e5HPWKp9yW3YlHvLs+ySbu/mmPLb44V3e7LSCi3k2bh
         PSk+txBdK26HT4SjtPgl6F+CHasVjpyNvvNprdzeoCzzqnfdkO7xbOaowD/EL2T61SUv
         /HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714978154; x=1715582954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8noqLZ7rreQXY6bq7wOdAQ/j08jV52ZrD0dDyncfUM=;
        b=AUq0OyeBwwVjZBaaEhNZ11/RNYhU5psIVRYB+Q0F5X92gEQw2oVaUK6E57uhca2QPL
         0nCezXbSYQcC27eoIdkB1pgqRZG3HZCbaewZ3pJcJAxlaeDgXfrLVgh1k5Ux9+4CYHxY
         xURPT3VXWMtqiMSBR+ZZ74USa1IM946HzHdkDcZlahEZ79o1iR63C0BV0GulzP9qhhP4
         nqbxLy06k4nAtP1PE5pVADXKK3agyufY+tbS9xb9YiXIYfhkpcgoj2cv727rswoijXrZ
         TEel7VkChhOKU9jaszwFRJEQMOtRqMBiF/7aJMnRR0nKBnyrQs8AX4RyIUD+5gEaUwIh
         OqnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUBO/EKdI3P1gR7eWEwEFebxr+o+REuOf2/StgWHJDpHoZwisQfAgwSCD0g7iWkrVF6vxvf5v7k8x2iUiyxBX+FM3WrmZW04b2o9zs
X-Gm-Message-State: AOJu0Ywwx007WeXdPh7FL0q95t3T4/EO0LHGC2oLBJgsvcf4wRA3YZqH
	Tme0boNRoYO1AfEF6u5oZ2h0SHP/5gVTI8wV9eANbW6Co1aSlKKmZP4Sh2A5uzkqHAGTagCYli3
	M3rsaykt6L0Q2h3e2Jnt2jzcIulLTRRsQKHnFqA==
X-Google-Smtp-Source: AGHT+IGTmTyx+2hxP484wZ1RDm/WIK4rLYQ/umGSZShmQj88zjWTJid5DVM66fAf4w/k7f8vI65YD102wVdQ0FL8qBw=
X-Received: by 2002:a81:ac13:0:b0:619:da17:87be with SMTP id
 k19-20020a81ac13000000b00619da1787bemr7931494ywh.42.1714978154440; Sun, 05
 May 2024 23:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503213441.177109-1-dianders@chromium.org> <20240503143327.RFT.v2.46.I6a51b36831a5c7b2b82bccf8c550cf0d076aa541@changeid>
In-Reply-To: <20240503143327.RFT.v2.46.I6a51b36831a5c7b2b82bccf8c550cf0d076aa541@changeid>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 08:49:03 +0200
Message-ID: <CACRpkdarbyhZufTHy1m57rfVdMO9aqbgkoHfdhG3h0=RZTjV8g@mail.gmail.com>
Subject: Re: [RFT PATCH v2 46/48] drm/panel: sony-acx565akm: Don't
 double-check enabled state in disable
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 11:38=E2=80=AFPM Douglas Anderson <dianders@chromium=
org> wrote:

> As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> prepared/enabled in drm_panel"), we want to remove needless code from
> panel drivers that was storing and double-checking the
> prepared/enabled state. Even if someone was relying on the
> double-check before, that double-check is now in the core and not
> needed in individual drivers.
>
> The acx565akm seems to do some unique stuff with the "enabled"
> state. Specifically:
> 1. It seems to detect the enabled state based on how the bootloader
>    left the panel.
> 2. It uses the enabled state to prevent certain sysfs files from
>    accessing a disabled panel.
>
> We'll leave the "enabled" state tracking for this. However, we can at
> least get rid of the double-check when trying to disable.
>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

