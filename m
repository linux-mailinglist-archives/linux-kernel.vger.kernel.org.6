Return-Path: <linux-kernel+bounces-447943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5622B9F38FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979DB168E77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FBA26AD0;
	Mon, 16 Dec 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FOimZLih"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAE190674
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373823; cv=none; b=CFv6Z8onF8XAlXAa6kAXEHKeJpZbCMpFmwCICzJJr456x+Nr0+z87kmAYorhIfslk5NTon59OuBFVmwsZcRclU4QHbQem2iZPnspevyKSQFTuutBsJ3q+ulq5iqUj6xX68ClxJbPrNmEECTAB0fKe/OS5T2jqtzh+j5w5jCjqj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373823; c=relaxed/simple;
	bh=jnwuGVyAOEKZ320Va8tOKK5N6yh3orOqh3vNUx1y0RM=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYCWQXZ3iut+M9aWp4RcCbKbbZ3GnYaRx+gy7b4q7FTsgBcBh6rdcPS9n11QL2mMcSj+udZjbgOBEGzu5+33pX7GPHJR2YdDSLno+o7fhXcfiV5U/VLac8XrwdLzDaxSIYFXZTeMoS+EkgXr7yovPxZQj9zIY81HCdNFW/EOyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FOimZLih; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f145e5cd83so36887947b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734373821; x=1734978621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnwuGVyAOEKZ320Va8tOKK5N6yh3orOqh3vNUx1y0RM=;
        b=FOimZLihMFU0RA3VpJizyaVIYF1wr5euRkKrCErAI8kUAusYTLOyZj2FpMUoij9uJy
         gaGFpV46+so935UaQLQm3OcuLSUIWqR3rbjlTsNlIXME/I/ipvpITgn9JwXJ8LZcjssE
         UITwvkYVQ6bYbC1jPjuvKjhyyyp0PysYCv5Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734373821; x=1734978621;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnwuGVyAOEKZ320Va8tOKK5N6yh3orOqh3vNUx1y0RM=;
        b=ey85Mq4bO+osiFQDFzQeI50KUUYkhioBIId8LQ/2ENElsbS/yHXpTvFajYshZh0a/c
         qvolgvYmg4eO3GlYSUtn2k/c7kSfcWv7noK0OvMc5d9jvsvWCE1FHEeUlAtqWj5XCBch
         2kW0/CHn3mvkZkqUUtvs1HlSf5DuqdOcu419adxlbeDubrTi/hpuiNg3Gw6CzpmSnmEm
         cJyZAyq8GXKit034Lx7ATwSbeRhOEQrA4QmkVUZPrQReQuihwWoetBSOvSJCnv0tp2Ao
         3C8XBAJYgNLTHvHzCQoBWMZpk5gEBl8SS7GDCkjojifaB0bMH/1SuW2A5Ywd4uh4EwqM
         iT4A==
X-Forwarded-Encrypted: i=1; AJvYcCXVNEzqN8ST3DzK+Kg8y9cD5mG975+FVHEA7sqNBzK48UFy+DKU0qerAb8s8cPtTB1CBZTL8OoUqn6Q/Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YylrFQYv+DWyHqmhnzGlQgcb2bkZuN+nWQhr0zWuOhsAQSC3gJS
	JJjCKco0BYPsX+XYpOFEoFvNISvJOdrE/suj8JDtYVX7DmG1s1+DQ9/gdebGyWUCOy87xV6ccFc
	gwmZCroOQzsL899ZfOfw0yGSByrT+cnezpO7l
X-Gm-Gg: ASbGncuTs1iaO/mOx5HGq1ORRQcdoRmuBEB38ByED0N/+SKamVLiPxsnQAhP+2Y1F3t
	xN5hJRL2miMuRu53FVIi0ChkWf9m5t/JfCEdGpD0hsgzBqN4yvmqBeXJap4ZdAjFG0g==
X-Google-Smtp-Source: AGHT+IGAZ9GP/e8joq93AJgn9vGXh5Tq52Geg2Bjs8/hq7LhWnPC5AAAAbSev0Vk3ryNjuoLA19eOKXVMbQsxPH64mI=
X-Received: by 2002:a05:690c:d95:b0:6ef:58f9:4c0d with SMTP id
 00721157ae682-6f279b9e06amr99061537b3.39.1734373820988; Mon, 16 Dec 2024
 10:30:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Dec 2024 12:30:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241216-fd-dp-audio-fixup-v4-16-f8d1961cf22f@linaro.org>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org> <20241216-fd-dp-audio-fixup-v4-16-f8d1961cf22f@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Mon, 16 Dec 2024 12:30:20 -0600
Message-ID: <CAE-0n50i1nLrBAgOdcc4aW40O1Bxd_N7fgrK2jCZqOFbMosAug@mail.gmail.com>
Subject: Re: [PATCH v4 16/16] drm/msm/dp: drop the msm_dp_catalog module
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-15 14:44:21)
> Now as the msm_dp_catalog module became nearly empty, drop it, accessing
> registers directly from the corresponding submodules.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org> # sc7180-trogdor

