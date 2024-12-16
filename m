Return-Path: <linux-kernel+bounces-447939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B899F38F0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35731168DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB787207A06;
	Mon, 16 Dec 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hOkYr5T/"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87420207658
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373716; cv=none; b=oW62OQ1hdihAaJyu5CX6BjAM6c6HXYtx+fNsJhBGFm/NUQABdNo3CTWITawQ196Bat898UjjFhyf6v5U3LSdUrEI4vU2a2QOjHZ58ipBz+JG3VBB/CRjzRZjGSYGV2f9Q1NXxGZwAcH61Nn5GKZ+rVQBp/yOmHHPEp7nR2j0pp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373716; c=relaxed/simple;
	bh=rO0fP7kC0ChLCdFf2h9Dk5fHEcQ84J84WudIRLZjttI=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0Z+rW+GOxgZdfxg33VVMAh7PMCaJfWNCAtiiYS7tZLyc2m7dbuZKrHJ+nsve5B08w+iPcuJVdPH47gVTc2Qjoh6x4nNiSDVHTkRoe3Pa7aKQTPzXgpP9uHAfSFUHUpxYeHWvfA4mgm2+PwQgBetoKiwPf0wVPwf4d3wBnJmA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hOkYr5T/; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6eff5ad69a1so35947497b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734373713; x=1734978513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rO0fP7kC0ChLCdFf2h9Dk5fHEcQ84J84WudIRLZjttI=;
        b=hOkYr5T/AwsYx+QG22p1BOaCMSMKSojYwi7DngX1GaPhzd1xAK3x1mpUiVCSfv3bCL
         0nfFLLGkDu9qQV2Hnn/tX6Hp26E96r6OqlIykQw9r4TTvvPJ94HAnw6PjMQgKo3pnpFW
         4M6qw3QgkrXu5XL0Jvb2tSdU8Hq1II0hZfJU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734373713; x=1734978513;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO0fP7kC0ChLCdFf2h9Dk5fHEcQ84J84WudIRLZjttI=;
        b=ZUDfoCkFBtsH3TX5BasE4ECbZ3Xp7j9QbV3ePET2sfbpFIINyU/UY9ijKwTCKfF7Jk
         vx/0QoyvqOFJcmZYOkCkg2HzB6aZUvivRG7ILC90CeGGR28sp3/L3M16s/w0wBeJ+ELW
         8dJVnTy8QteLynkSm2EzFUVhEfFyz/3Ze7ovTgwLfmUcPuPhgfydFlw2u7HAMr17MoUB
         H4yPlMm+rBCyU/ZTLP885HqmbB0ZioZMCvowi56ewtVrEK+ZO5LFbyd423PFnmSpLsGD
         ysCd6waOKKtKEXpzwMWws+7vb+ETl5A5DzbYf+qeE+5AZIq9IR4O4LBqzRPxO1f8hwgL
         uEww==
X-Forwarded-Encrypted: i=1; AJvYcCV4JCbQELVry34Tqp7EpWugvKRiKN7gU2tiem+dEWaNDVfPnzRqEJGPageh/cq+Ga0v8fXbLW4RIeh9pEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdiotoVgY3efLxdflCqDeelzqHBGsN5tT1Kh47PNwmWChir0hV
	bfPAXLgQohhCpO+h1HiQyBdLtdy57UgwsMBxjwCzAWH0YVHcRNGIa9kx6hMMQS4h1b4zVV4wmZd
	p+Wq5S/6cu03POVoeSADth4GRqpdsRcpZrgD9
X-Gm-Gg: ASbGncsrADhPfDPzefGt/sRc52YdS+pGc5bTCFg94QZ/MLqmnuXygRqgUj+61f29bGe
	+aazlo5TKSWC10AlxFzxYEuptFRsDcsDKpIy+LBwqYE126g1jNWTuTOuw+V6IgA6s/g==
X-Google-Smtp-Source: AGHT+IE4CdB36DYH9vipsU7nBQzIha3QX2anHYVsV1wQT8Ge+vTgkTSbipalEX/mJfncpySK3J6yzUz+Iw2WBcHVy54=
X-Received: by 2002:a05:690c:6408:b0:6ef:6d61:c249 with SMTP id
 00721157ae682-6f2bb3a54c2mr8410207b3.39.1734373713619; Mon, 16 Dec 2024
 10:28:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Dec 2024 10:28:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241216-fd-dp-audio-fixup-v4-2-f8d1961cf22f@linaro.org>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org> <20241216-fd-dp-audio-fixup-v4-2-f8d1961cf22f@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Mon, 16 Dec 2024 10:28:32 -0800
Message-ID: <CAE-0n52uH4q5=QbU7V1jvRmvccAWTF1bOSXZ32j2NxKEKQVhMQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] drm/msm/dp: use msm_dp_utils_pack_sdp_header()
 for audio packets
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-15 14:44:07)
> Use msm_dp_utils_pack_sdp_header() and call msm_dp_write_link() directly
> to program audio packet data. Use 0 as Packet ID, as it was not
> programmed earlier.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org> # sc7180-trogdor

