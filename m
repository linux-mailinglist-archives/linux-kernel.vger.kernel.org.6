Return-Path: <linux-kernel+bounces-261250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA9293B4B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4781C237FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B97C15ECCF;
	Wed, 24 Jul 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHkx+Ywc"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237215EFA3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837726; cv=none; b=UL1HnbJGyj2UQMIFOSvK8GDCvyQ+vZCAWzDRcUBykVsvYpK3U+KWLz8LNiCd+iizU8CpHqaOWS6FTkegNRM6ypiBtsL7qB9mfb38mmz08MoSEZ2xtMuOuuSD3J5N9WEumkUWDzp3PJ0S06j3BFMNdW2WL5VSdqn+VYbFPqhh2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837726; c=relaxed/simple;
	bh=VPwKY5kApoZuCZcBhUZbgRHDZmiTR0tK/OIj5arOVAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJVHYg8XTRP4WBlNPK2dwckekMx7e3wagweywES3x7B+O5J20sdWVdzrOvgPRsORDNfKncKUiZx0EdVZVQI5kDC6dKyG3kHP/Znyrm+9XHol1sWz+SKGQVfDRFUgx4ZN06x4nbjRpXbHHOjc9kpoYPNkOQQiH00U8QY5bQD2Bxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CHkx+Ywc; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b6199ef089so40014486d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721837722; x=1722442522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7e5mdNizpr6t3j3m8AUb0y13KqlMGi3CCgQaLhUCww=;
        b=CHkx+YwcqznOLrbHVudfMrYzdM/ptF0hrmg2NHKR+0r6weFcvc/kYAGQ9ASaLKUbUx
         9tH0bkv8Ra//ebG70PLvkykYrgoMApF7oeg+2F23kRRr9h1LAZNzATFEhhj/zygyo2Ff
         BybNg7AbDby69/eBr2oTBNd6u1SlUcjBrRd3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837722; x=1722442522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7e5mdNizpr6t3j3m8AUb0y13KqlMGi3CCgQaLhUCww=;
        b=Hsl0loSvhscRCg74Tphzm1NTG97c+s3Qc09is6pG3dlAmJsXXACqwvCSVSOV0VIqaw
         w6o2f7u7wZxakK5W9lapDt7nD9eKvMM5uYTdWz8u/H42h8aVjIw9fWze8XGXN0CImGA6
         pyV3V1edzRfZFowu6Z91K9QFrj9wg0iqtJomYvkZx/5+SHn513xWX1GlOtJIXimZYmBp
         1Icw9GDwrAGtu1gtDhmMg7bWHB39FE+PGrOhnyaPwaVpqvg9/t9ai2Gm3DH4Zu7loAa4
         zTIEggLOQTi6nrsIo4MKkTsEQE3KcLvlskIlF9gQgKuQyznYBBioNXJMpMtmrzIXQV/G
         UQdw==
X-Forwarded-Encrypted: i=1; AJvYcCXP4PXj+TKS16xgbH93wTBgdNDCqzKFuRxBow6CY3Ck2/Hh52rwBnAkZEZtY7K7gUuNo5ULJfVV9TQXtPt3TaT3a30ESLgLTjACZsDQ
X-Gm-Message-State: AOJu0YzrzetLJyLFXboiWCO2qrh0hCb8MTBH44RjbqRDQcGrm0QIve6F
	fSgAQG5gH0YXne8cSjbVVtkLUiltPAHFJbT+bZBrzj+hrNqXkbeqWhjnjJAm+wLKo8/fXGf5CZI
	=
X-Google-Smtp-Source: AGHT+IHLUV7yYaeDbcYGg+GgsS+GRCyUYm5qEyK6guksUvBOaTLTvBz4EfIl95Ms38cwZvEPgelnFg==
X-Received: by 2002:a05:6214:629:b0:6b5:4573:4ac5 with SMTP id 6a1803df08f44-6bb3cad7be7mr917326d6.45.1721837721926;
        Wed, 24 Jul 2024 09:15:21 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7bd446sm60066996d6.19.2024.07.24.09.15.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 09:15:21 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447df43324fso359911cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:15:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0In1DP9T9RGRSGjpmzl2UAXt53yB0cQi8Oqqvk4QBY2HwYzwSCrQwpnRcZOutnzJQFp9XUVjjZEpzTrbZ1ZsJMh8HLeagLpf/+tH6
X-Received: by 2002:ac8:7d8f:0:b0:447:e3e3:77c1 with SMTP id
 d75a77b69052e-44fd4c9a903mr4534671cf.29.1721837720254; Wed, 24 Jul 2024
 09:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709-topic-sdm450-upstream-tbx605f-panel-v1-0-af473397835d@linaro.org>
 <20240709-topic-sdm450-upstream-tbx605f-panel-v1-2-af473397835d@linaro.org>
 <CAD=FV=VL1Wxd0veW7N+0Hy=LdKMzNbBang9_EZ9Zo_d-wZOBfw@mail.gmail.com> <dfb29dca-7110-4c11-b86e-9063f71a8ada@linaro.org>
In-Reply-To: <dfb29dca-7110-4c11-b86e-9063f71a8ada@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 24 Jul 2024 09:15:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=0R_FScPPmU0CXbUv0n+PeSdF0MitRKf5r83V2wEYyg@mail.gmail.com>
Message-ID: <CAD=FV=X=0R_FScPPmU0CXbUv0n+PeSdF0MitRKf5r83V2wEYyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: add BOE tv101wum-ll2 panel driver
To: neil.armstrong@linaro.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 24, 2024 at 12:51=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> >> @@ -0,0 +1,240 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +// Generated with linux-mdss-dsi-panel-driver-generator from vendor d=
evice tree:
> >> +//   Copyright (c) 2013, The Linux Foundation. All rights reserved.
> >> +//   Copyright (c) 2024, Neil Armstrong <neil.armstrong@linaro.org>
> >> +
> >> +#include <linux/delay.h>
> >> +#include <linux/gpio/consumer.h>
> >> +#include <linux/regulator/consumer.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >
> > nit: sort header files?
>
> Will do while I'm it, but I don't personally care of the include order..

FWIW: the main reason I push for sorting in cases like this is to
avoid merge conflicts as the driver changes. If everyone adds new
#includes at the end then every change will cause a merge conflict. If
things are kept sorted it's still possible to get a merge conflict but
the number goes down. Probably not super relevant in such a simple
driver but just the policy I push for in general.

The criteria for sorting doesn't matter to me (some people put
"nested" includes in separate sections and some just do a normal sort)
as long as it's obvious / consistent for a given file.

-Doug

