Return-Path: <linux-kernel+bounces-447942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC139F38FF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956171891693
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE263206F3B;
	Mon, 16 Dec 2024 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hzIXKspo"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D8E1CB31D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373801; cv=none; b=Cb5/RN2w+b2LN/PZQVfyq5f5nnZTRuRKXzsCZ4C8+9ntUf2TAdmKNG9H8eSMJZLqMwJ0veNAmcJ1KKGAM63kWxBeOnx1Q6s92YqCLvDP/uKsrMAmIFlkGc6rmBzT+Qt4mc02boIVsLd8ESa6zDj/uMKMVLc4bKubNvkaqcZ+B3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373801; c=relaxed/simple;
	bh=D6BkjH67J+jGm+KB+qtNt47cbbPwybjknONYRIcntzc=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsFbI1wLU5AjYzzGqe1pi77+XMDzWTIlbHMRC31N5SRaELADjpl6tQWJdhFPBDLVk4oET3sSkUUuBc6+Y4Fu8kcuXO080U+u8alC+o8eBabFQ9uwPrswUfEvXgDoZ7V4YL9kZaGmvVkngWKDPNKda4eCW7Zby/uiq6rGTVLkLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hzIXKspo; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f0054cb797so35490317b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734373799; x=1734978599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6BkjH67J+jGm+KB+qtNt47cbbPwybjknONYRIcntzc=;
        b=hzIXKspoPr8yLJl/ZlJNV7fnBIGtdlFUDvTBuMQ8ELR6LffTieTAahyjqzRl54BQFk
         /NryktWVmYlKOTV/Wkn1AugP7dwKIUErOzTgRdE7+xN5higb/ij3YU/jmxO10vFyTorj
         ThuL57tTEB2FLO8Oc1k124WWyeoLw7bxmid0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734373799; x=1734978599;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6BkjH67J+jGm+KB+qtNt47cbbPwybjknONYRIcntzc=;
        b=np+qnK0vLxcKaFwmjjQBcKULGdVYylJ3t8AZBz7YYzg49h/PAZCGsK5hrqfM5oPP1a
         pRHKE9/6YvhLxOUR1AoB/TY4woclebQTnJgqmKYzcIvW5WifvcaEGC8F0wQcATcYJyTd
         WFdZH6UX9jayv4bPo6Hj1wOpGhBNO1Vq+SJxkEbdN8xzYhryNI2EdFpXuAAoQ9Q4tTN0
         OQvnQJlf1mcgo3rPCWV5a7cTC7lCoZER/KXtjoSez1Yaj4I3L7K8FIiIfFfyCXxXANeZ
         C6W5RC1JKhX+U6rKNZlCuOyocmQjT4VUkIq4A60YrmAiBu6W1AjfNWBj59N2G+IOSG2h
         vsqw==
X-Forwarded-Encrypted: i=1; AJvYcCUiWkLDof/0KXogkuKiFAx6nj7t+3joh21RGY8YHWBdUMIaIFVqAxQrDY9gICq588n4Q5s/QjWpQrTBxAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNEfx1mAzTrhLU8cDOkYaE2Dxdq32gWJZLFYuxRAuK+6YU4Hjk
	T+Ew8hFwtrh2yy//AoU/zeuBv/E1dbvJ2IkB/P+YINOuQe3ZR7UC+ls6/ikYP0TiTR9qQbkHkec
	wjRM2N9oLOtG9KvRQy0yQ0BnM6XFnvY64+xTq
X-Gm-Gg: ASbGncuodhoxTZB7FDAeJwqGe7ehNc0tojnFGVar3g2rFwOb/z87ANzPYRbz0SOf+8L
	ZcCmLV/TGmkDdi/VB5J2RkfJFyc+cZm/Z4VqlUo9BhQUcK2xLe6NSre7U/YW81RCCyA==
X-Google-Smtp-Source: AGHT+IFec3otTchyFxbDJfKFBz47WzGfI8yjCwnobgW8mFZyVIcbwLvFYT+D1W5djrG5rBzv+7Jo60SR7JxAagJAj/U=
X-Received: by 2002:a05:690c:6005:b0:6ef:4ed2:7dec with SMTP id
 00721157ae682-6f279adac53mr117919057b3.8.1734373799003; Mon, 16 Dec 2024
 10:29:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Dec 2024 10:29:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241216-fd-dp-audio-fixup-v4-15-f8d1961cf22f@linaro.org>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org> <20241216-fd-dp-audio-fixup-v4-15-f8d1961cf22f@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Mon, 16 Dec 2024 10:29:58 -0800
Message-ID: <CAE-0n52Uj6h=X2PqZcPBnPDR_vVfi4_Y_miG-dTPP6FzH8rtag@mail.gmail.com>
Subject: Re: [PATCH v4 15/16] drm/msm/dp: read hw revision only once
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-15 14:44:20)
> There is little point in rereading DP controller revision over and over
> again. Read it once, after the first software reset and propagate it to
> the dp_panel module.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org> # sc7180-trogdor

