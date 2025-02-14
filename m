Return-Path: <linux-kernel+bounces-515365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4452CA363CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D643B2340
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93C267AF8;
	Fri, 14 Feb 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZx+tg1j"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592B24291F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552464; cv=none; b=duT8CFS7TGoL6slP7M3TlpJJ9Jec2heCDR2FWtENhQJNS+pwF78RXbMDQPe0La/fc+WiGINS0tKVCa5zeu21tFJ11XysiKS+/sXDhrw4v+sNcKsUy+GUTdM6sIrwDgME7EpibiHRVMiVXIedFgcr0ap6PpYsfq4XPvtfCpTaLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552464; c=relaxed/simple;
	bh=eGqfS78pmJ/bj5BPsCQeo9hU2Hyn6ObIUQO0AmB2+Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9MnnY1qbAVxcNhPZYBlHInJC4SakvmMyw+QDwG6S2V7PMjNl7wAZaBqPIvKOqgNMJY2b14NBZ4LfQh61OhbrxbYiwrPrrd4OaYRPv64RQgxspqz2XDaM39uAvzeu2tAWD6V9WEPVD3g3eWiCG6M2QUVpqt5dhsmmmACwcQaJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eZx+tg1j; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5452c2805bcso767560e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739552457; x=1740157257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGqfS78pmJ/bj5BPsCQeo9hU2Hyn6ObIUQO0AmB2+Co=;
        b=eZx+tg1j9zZQ9MHcRHSijsUFkraz4PpXJ2sOeL7W2y/rICX+p8mUoCBwol4SIGvCmI
         q86YkNNI4/2wB02rlX3JIIOkOKdN/W8tOBIjDMnDT2pi+CWQjAiN6sZS+9qUjiQ8ree3
         uRMsVRQa+s6grJrWy2P1JMKivNt6GcSryccsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739552457; x=1740157257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGqfS78pmJ/bj5BPsCQeo9hU2Hyn6ObIUQO0AmB2+Co=;
        b=jVQt4n1kH8zh0ycjQvAhvKCHxMfXNXR5mfmIJg/ghv4P8bis7W8fhtzuBDX/tQHot9
         /jaygRe+T/6x7ZPjDReNLdU1vY4TvhH7CFMnWq4UdHxDOCf+l0hvujikQdg64J5Zgmd1
         5gI+Xablhg34r7dNBFGyRjiOGvICJQpHVPtCZruSrx0WUwrbjCq1jbtVHEpX1gr9WvS6
         QEiUO00U8IoRedaEEvbKL1TeZtiFJHwe5Zk0XVaPtYSKIBqkC4+huNPKfWr/JsNwVR+J
         s0sqv7GmM+VVEZqwdnAOcvxvQP1NCI48wnyqFcjqfEb2S3JzFjknvEkmrj/FpT2Rfuc9
         Z3zg==
X-Forwarded-Encrypted: i=1; AJvYcCVF6VIIc1GHAAOhhuhP1FmOGXEVRkcMc1R6eQN6P5YT29u5Vz/3YcKVfJFoKEui7ev67QDO1t8RZdal2iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxgzSGtVGYv9YUdem8tRMuc6qQmfWxPnDE68rd7FhLD1EYvjXY
	dO7gmPR+uIxRndaEX5LmUxlW0SjZn2P5vP/U1TQO1s+HABPzirQgc7aNESEhVjJzOfnavd8Ztsc
	HleMO
X-Gm-Gg: ASbGncvjS+eraGUtqVDGboEPuBw1blOWsD9XnqitQ/ij5GEL+ziuHazG9JxmIlc+bzg
	3V8g3Zz1ROpnN2z2ylGqlf2I0UnSqzg14UJC44el84y036dACIEhnyEysUW372h3+29EcEbaMSE
	jUIiunYtoNLg2WUMaUmkXjSXMatEhdgfKISm5HnhUIiProYllFJpPSHHBaFERuehO/cFwxlQiOq
	i1CIWnMhRLHSsn87LUoNPdsWdeu2yviNWdPeoZ4/LP0d2YLKYwvU6CQD1O/yHiLjDheN+5ywQ6z
	LuHwA/1yaot88xmD1o8eL4VEjfU8pDfH9IBRya4BOqBGpont1axzXJ4kWdU=
X-Google-Smtp-Source: AGHT+IHsCXChSGyrTSit86wzDL7V5UFrFB9QGhjZ65jaf3m7kxP08UyFRKg2BZ0jw2HbuF/cxDox8Q==
X-Received: by 2002:a05:6512:ba6:b0:545:532:fd2f with SMTP id 2adb3069b0e04-5452fe3659bmr33617e87.12.1739552455965;
        Fri, 14 Feb 2025 09:00:55 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452ba48767sm219692e87.177.2025.02.14.09.00.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 09:00:54 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-307bc125e2eso23016001fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:00:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZ709K6mIgtKGTQM5DifnGHNNmnnoxhOz59LNdz17Zp3JlkQC9b3du1ItuX+3W5N1CWZ08THdhjm0b59U=@vger.kernel.org
X-Received: by 2002:a2e:b2d0:0:b0:308:efdd:b184 with SMTP id
 38308e7fff4ca-30927a6fa08mr801931fa.10.1739552444566; Fri, 14 Feb 2025
 09:00:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org> <20250213-bridge-connector-v3-5-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-5-e71598f49c8f@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Feb 2025 09:00:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U30w51nXWzmqMjimKXEXN1iGCGy+FgvPQJio8nUJwsSw@mail.gmail.com>
X-Gm-Features: AWEUYZmgW7gsdTTn4UdK692jYlJBK_pdnm3uhZfmTNqc94knOyyM8gyi7aEc-f4
Message-ID: <CAD=FV=U30w51nXWzmqMjimKXEXN1iGCGy+FgvPQJio8nUJwsSw@mail.gmail.com>
Subject: Re: [PATCH v3 05/37] drm/bridge: Pass full state to atomic_post_disable
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
> drm_bridges, so let's change the atomic_post_disable hook prototype to
> pass it directly.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

From the point of view of ti-sn65dsi86 and parade-ps8640:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

