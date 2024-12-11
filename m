Return-Path: <linux-kernel+bounces-442309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B759EDA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9031886AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1DB195;
	Wed, 11 Dec 2024 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+EA6ZcJ"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ECA1F0E3B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957633; cv=none; b=jpkK40aoGZmWJtFdAlDvwWIZN/LOL9AMkDh70qaGmJ2oa0voGbghhfIbJttxzuhOeJkzC7enYQAndWGdNc8hP0+J7MbSeChqQyPKJGb2YGOBwTEno2Pc/ZpFuSD8iKv7FJxXiw4oUaNw5ip192OTlASDAaltX6o/5SMVj/KZJpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957633; c=relaxed/simple;
	bh=2egq6Dq3KjRKLgPQmABDsLel2na1tngRhhj74d6j2rc=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFrYpmE7lWxSPgPdFBu3m00oj+fRDYmnr8y2jkVT/O1nTGMVGoDa7oLE5p94kzUTo0ZuGsj36sptO88B+LR4BKo213/OZnp3kFewEvCwFoWpGvzPwRZB4hi707Yuna7sYlCReYmd6EPSlwA1Tr47yyL44Dv/N04Gnup9x/QIpFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U+EA6ZcJ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d8f916b40bso64202666d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733957630; x=1734562430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2egq6Dq3KjRKLgPQmABDsLel2na1tngRhhj74d6j2rc=;
        b=U+EA6ZcJcegLMz/W/bRSHMX7M8MFIrPs4Fe9V1VxvN0/LYPo6V+YP4PuNUN7ViRjUG
         HyPwYUJVBKHbxUOXcrDPI9LFcmuix+1hf4D2lTzgt8vUgTzGEExR5jdOTXfUxyXTzKxK
         RHllCm0db1iMLvqX/OzIb6Be8KrXE0a4e31Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957630; x=1734562430;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2egq6Dq3KjRKLgPQmABDsLel2na1tngRhhj74d6j2rc=;
        b=aITNBDq9D2ft18TgMwF447+kJ/RCUkqubQHNYFPbNfTPqQUvHUUUfpU5zJDwT+DYSL
         XfrdpJh5VTMUUW0g5+jhzGFHymtBwHYmmCthSpeILHopF6jYsC6ybpH2zIo/8dvOAE6T
         m4rvZcwse6/UrNyuRc/Zx4FHGGOjgJe8HRwZH60ZNDxwTFD6WW/6m/VoLzYv/3R96dwk
         zqN4x2N/PYlpZVwRJGORWb+obOXuybjjwvOg6+oBPFEEGeyM1eRLfvn7zKV1DKoOkvFj
         JPq0PHLFVX6uDFfYMKKTobuGCaCvMOKfFahILNr7hpI1DA4WdMzsGYGXyVhNQEcYzlwd
         zOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP+msK5VvYK6DIGqt6wWkKtq6ggw+C3nD9mNxXgZga98F33P4pje46EnYGOwRFS1/Zwyb9aXprbDNbRIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/QCGopX1PDvmwY8i1wHDV1VRv0o5UjiCC/UeAQTdbOXQfSDc
	/BSF7Id7fZ2HlQKx70U346JQXpj5DvDruFMWLdQ87SRQ6XWAPzsPwZINK4SqC8MvAt/vmxs3nbn
	I3u5X+C3IE4IKWMteLNsBvgvPthP9XFzDBtxx
X-Gm-Gg: ASbGnctwrQwWf4HZt2zATuzB1YQq+kHMoge+LlpOoFEleVaKQKWeZpmeWxokfnwQauF
	eGclVJQFt8EJrkTtUwyRORZQCltENyesUVfb9PuxPSQjhacQsXLlmsWds2Tn9SDU=
X-Google-Smtp-Source: AGHT+IHPYfu5RWwg4QjV5Ft9MAhO7VJZB9xFWbSMLRysOqfixDFuOnt9+09RHZcOWbxPXE1q+wf1OmiIJ0aIfFFsbn0=
X-Received: by 2002:a05:6214:1d0e:b0:6d8:aa45:a8a2 with SMTP id
 6a1803df08f44-6dae38f441emr17981836d6.11.1733957630566; Wed, 11 Dec 2024
 14:53:50 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 14:53:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-13-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-13-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 14:53:50 -0800
Message-ID: <CAE-0n52NEHh6XnsWsg4XG0nS8cVpC-HW8snBLD86PO3-AV3jfg@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] drm/msm/dp: drop struct msm_dp_panel_in
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:43)
> All other submodules pass arguments directly. Drop struct
> msm_dp_panel_in that is used to wrap dp_panel's submodule args and pass
> all data to msm_dp_panel_get() directly.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

