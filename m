Return-Path: <linux-kernel+bounces-318774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B1596F327
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A008DB21D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA141B3757;
	Fri,  6 Sep 2024 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpJiIkJp"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A61CBE82
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622535; cv=none; b=gn+kVBFkWZu3pTwBF0uL+duNv0A7CyAMy3KxwhNNqchvF29Oh1ox8XrhaK4YY2dMeNcOAMNoBh9LDXZv1MOiqojvfl/z+xr4ziwCR/IK4lNWliWLs8valSpwvls/a/FhWuuucbvOKeMpyrIzvyCIREghxk2M8o5tqPiPSU6QRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622535; c=relaxed/simple;
	bh=XF2QmJ5s7PXjzUAPDJ5DuMHsT4jZHu5RgH0eb39TqRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVPLqcTkdaHsmcIm5PrvhZilsoLKO6YrWqL7Dw0NZimQgQ0ghkwgOG84jFZRny4vCacfThHFgGq0L+O5LtxkAQgO+fM0DD/NFDdUkiNpK7QwLu8GE5mlF02MfbHSsirwir8MNUc/xA2vKK8m/uz/Op7D4YX1O5KSVv6ge1q+NPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DpJiIkJp; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso2025866276.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 04:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725622532; x=1726227332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4MGtjs5dofMDa08crIubVUGiyT33xxJyNXECaSO5qU=;
        b=DpJiIkJpGfIFug6hg0lLvZ3oFdLWzydMHNv6Tvkus5WqKn1GzKiWFeoVE08k3ObEu3
         Wo9DhBghNjEMOLY66SQo8KVHA9yZo4lwNoHPrYekGq8SAMOhZBYxaWDD+A3iMNSnqzIK
         Cen4GK4FfvOTzewjWKCQVgE6YHc4oBg+KCg3BlsoFloT1OjF+3daRwFUJaQ7SDefIJKV
         DbfgxV7GjLcjsfDpPACD7OEG7fNBoQ64ZCk6RgYqeZThGUUOOFQlbBDzLjYBM1+AwjEt
         MK0Nm2nuBlyR/nASjtg58aBQX9F3cxbUnCnl+fqco2DwNpkX99OR5IyZoXakacFrmoqk
         dBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725622532; x=1726227332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4MGtjs5dofMDa08crIubVUGiyT33xxJyNXECaSO5qU=;
        b=at5ICrOTyl3SHGypDKCRtHyOReFbufHzCsm1bdmiENi6RM/Xar8Bbp7+U49cL0ujiB
         NzRBeZfPOqOW4EpjLfGMBzGnIwpMx4ppeG4UbYSWgfK/tevyzFVmO7lUWIqa76qss86t
         H/xkFC5IoIGQ6J68jAUGTr+5Ugc0DpPT4bJlqK10pNT2Djqh8RXDN6rezjZZ8wfUDoP3
         HGdnbB3P8YvQR9IilxW9Du1m6a87S6fFUJ32ovo5+UndFRMc7Fds7tn07/G7GiwO/jPc
         weAo8oXQ/zNgucBMxXl/hvXzYK6K8YNK0sqkFxhrtrKuAXvXLwvqfZvKWYXMJ/TTyfBJ
         OoXw==
X-Forwarded-Encrypted: i=1; AJvYcCXP5z2rpHcUPYr8MLcsooG5hKBCA5lDLQK8tuQlT7y2ULCfiUr1qkKov/8GBi+IeQ0ADsFnK5jWZWwTY8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNyXUy10ozGJl0+cRkP9KRNILUkXqAeyyR/Yk9zrFC2bkAr5h3
	okOBHzvdHq7aIMwEsk2rUW4bU59NiWjmkgQNTuOgmC4vY1dPzbZWXdpmSRDJcojxoJofEY+0y76
	3lcCpnCFW+874foOj1NkPyEQ0E9m6R4m5nHbjYA==
X-Google-Smtp-Source: AGHT+IG+ElisUJ0/Qq7f/WCMCZfQCBvKZ4j5xc1ADihAYSJbTXA18QR6nGPwP+SLc7FS1BLGz6TzDS6rI43soiiWSOM=
X-Received: by 2002:a05:690c:6f03:b0:6ae:528f:be36 with SMTP id
 00721157ae682-6db44dbab24mr29072817b3.12.1725622532290; Fri, 06 Sep 2024
 04:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906063857.2223442-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240906063857.2223442-1-alexander.stein@ew.tq-group.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 6 Sep 2024 14:35:21 +0300
Message-ID: <CAA8EJpoz7jtjN-Dxq-6SHNiZCz2xsFFf5j4HOoFiLAq=OnHn6Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 09:39, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> When drm/bridge-connector was moved to DRM_DISPLAY_HELPER not all
> users were updated. Add missing Kconfig selections.
>
> Fixes: 9da7ec9b19d8 ("drm/bridge-connector: move to DRM_DISPLAY_HELPER module")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/gpu/drm/imx/ipuv3/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I'll update it to drm-misc-next if nobody objects within a few hours


-- 
With best wishes
Dmitry

