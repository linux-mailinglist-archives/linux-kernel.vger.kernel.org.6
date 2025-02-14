Return-Path: <linux-kernel+bounces-515363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 679A5A363C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3AF47A1A53
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586D426773F;
	Fri, 14 Feb 2025 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C/wfNbgH"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1265425E456
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552433; cv=none; b=BxKcEuYzpfc0I9uwxSbibh7hQ7jIrq4/UceUzpVYWMI/YQkmeztPpY1NuYe5BxFD0w+HkZfd4ar1DeYHfVAM34/XE0RjenOrKnFSMYlDnkMzo9bJk4w1lK1z4Ofs2Ud+a5qV1n+595n/bjf8X4AQ0zIwx+R7LOPao7dpSdw5zjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552433; c=relaxed/simple;
	bh=c2tb/suTl1nSS8YywUwSH5Dc0llHnUO+gUroKzzSxGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUXyxPWM4aAcvoBFmu4mbsCvAOETJjqLKLfJdyLhT5NqEnTXD4cyFU8+eXY8tvBudXArV49ei6TZCTyTj6yRzBaX41KPTpSbZoo1IPcfOsTjm1dxxs1kQHmFIJ6BOizzOkw7oiwkUfUyfvYOnOcvt3tA5gIyxeaNaxzfkuT2x3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C/wfNbgH; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-308f32984bdso19701791fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739552428; x=1740157228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2tb/suTl1nSS8YywUwSH5Dc0llHnUO+gUroKzzSxGM=;
        b=C/wfNbgH6KLYH/tYpFE5El30RWGznwu4+i9axnxGAStMl2SoxP96MB61TQCv+2GshT
         qbGUdABysd7mARCgp3tJZJ2GDD/B49j03SVXreh3BDd0lsU/DN+I9tZHgrGpi6H4kaJq
         IHxsDO3GNXvTfww4sKrMKpa3Pf8SSTiOAATwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739552428; x=1740157228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2tb/suTl1nSS8YywUwSH5Dc0llHnUO+gUroKzzSxGM=;
        b=jvLpWBNAdIX+ux/4DloCFdnYHAWzAb7loNVNjyS5xbO6XUXcuFGqjh8oY6TC8q6Gzt
         jfdxbUwEvHlSL4WPi+2EebxlS5hiq8Nr3xJJfBxMoS3rr18U2rhsMHivLL9UPrBN061N
         +HEkpey0bgTw3tYAQ7QoPNDiCXe1PAzi0fUaNUQl+lXTNbZ3MLQUN+balnC9KtG0uZZf
         TwMg4HLT6PN8cP2fiHzQXflZEYKvIktYgsJ1Er/XfkBNwsJmBGU7MilljybcAJaCRnH+
         VaUsd0fFDUAoMy/sO89ZnrCV65bQpZPcLbepiRwxGi2eE4jhSZoCNSj9SlKBX1omfb8l
         mynw==
X-Forwarded-Encrypted: i=1; AJvYcCV6oWobhWFarYKyMZeBy0pmzOdmCl/P3po7D6IWRwnUvsJi/jSPk+KiWgUxFaqNqrMu62NEWFaJCFidOqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlfh1bYqMarcgmHQILzMteGMjj+HG6If9ngHmocMDxsDOs1gLO
	Dtqs7z5Nn31OdGwiYFez1w/pP19vRvbBSDb5WUuxq2+pJ5jibRjXEAan8jGIGBKj58bDdjPhqNq
	ysUhd
X-Gm-Gg: ASbGnctF8WHOvibcgMiNLkmRnOkOlK/EWQ30sUCX5XszwPCnQiqzYosraJPQRfBu0RM
	px3JdAbi4ohglcOwnXS5X9t9lQeEcjnLXx0UVWGDgTjOXtZSBjRmHajdoz99L4hvqRNV1G/VRE5
	fL/J5XOltLYD1ysW9OQJGscH2lA1GXDouTb9nFWCJCNX6dyE0+CcbOhh4KrsL+Oh4uzpmKWT6Pd
	nH7j+eUxg1A6EYC/k7p5MOh3SKCFLOGZbJvTj4XhMaPgkejNTfI5pH1I9W+CkCIvvVVFrib7ZTO
	PG3x3xVb62ww+HN9wc1mHs33THc9UHWJ49gRc4QujsXK+f39iVcnm6Q=
X-Google-Smtp-Source: AGHT+IG9dB+ID38qSlM382rXIVcFspAdac2Xvd0KqUtl25sHxp12fjdCXdzw63JAxnzn+pCsAIjKYw==
X-Received: by 2002:a2e:988a:0:b0:2ff:56a6:2992 with SMTP id 38308e7fff4ca-30927b27554mr490091fa.37.1739552428469;
        Fri, 14 Feb 2025 09:00:28 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30924b1f574sm1435281fa.26.2025.02.14.09.00.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 09:00:27 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-543cc81ddebso2405586e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:00:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRgKddUP5HoTxE95jgwUJOHzREAQRsktW3AYZ341EvXB0OuVCLZrvr3CXmg8KXyUo4xbwkYzqnvZjdZU0=@vger.kernel.org
X-Received: by 2002:a05:6512:3b0b:b0:545:17b:3cf5 with SMTP id
 2adb3069b0e04-5452fea5f11mr5412e87.47.1739552425610; Fri, 14 Feb 2025
 09:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org> <20250213-bridge-connector-v3-2-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-2-e71598f49c8f@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Feb 2025 09:00:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WvmWCgEDOF7Wxw5UGjnmy2_b3CzFuZNH2+t4JLc6JEuA@mail.gmail.com>
X-Gm-Features: AWEUYZlwb8rAgYDd-6FmyrJKUl5kYa0lEXcUU7k0RahjDPdc1oQN7hzxIRS7TgA
Message-ID: <CAD=FV=WvmWCgEDOF7Wxw5UGjnmy2_b3CzFuZNH2+t4JLc6JEuA@mail.gmail.com>
Subject: Re: [PATCH v3 02/37] drm/bridge: Pass full state to atomic_pre_enable
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2025 at 6:44=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> It's pretty inconvenient to access the full atomic state from
> drm_bridges, so let's change the atomic_pre_enable hook prototype to
> pass it directly.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

From the point of view of ti-sn65dsi86 and parade-ps8640:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

