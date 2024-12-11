Return-Path: <linux-kernel+bounces-442136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05E9ED874
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA771888ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A11C4612;
	Wed, 11 Dec 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RrcNaFzV"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594C1EC4EB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952070; cv=none; b=VfzNg2VYNyj+ou0ibVb6E9xNEL3Vkjbjh3hQ/XUda5U5YQJz68asKvSS69ABFob8wyy8UwRDTE2qD7IvSNTE9tweJUvhm/Ry8Z5UffF/o4D+/MN/+Fh+AfW9eD5Xq/6VEYYBs0gYaJbJfzell7jAAMS5vnqb8wJu7PUN3BhMsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952070; c=relaxed/simple;
	bh=brnEi/aJpSTL43ttJW7MhyFkF6Ud+FSLpSFKqAmDpCw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlwzElmvTp0Jhb2ckPNxl8mbNdqTVuLEIVdBaAb10YldrN0LWCk6PiVtdll1+PpkKdQfllUEqJiRGOT2sTRaUjJGlNJm3Vc3/xgwOOaGpllS2L+DS7pkEH/OZ7kY1zjxwOsNR7lSi2twcni+SKSA06a6gk+n948yrBGz5xB4fPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RrcNaFzV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f14626c5d3so16968647b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733952067; x=1734556867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brnEi/aJpSTL43ttJW7MhyFkF6Ud+FSLpSFKqAmDpCw=;
        b=RrcNaFzVB8WO8I9y48CPyz6bmoTFgkPGNqwavvcc2rYzZG/5e3y7Z8WTJaGvbUE7zn
         RwIHxkayROQ1FWFQF8S89RC7YFI5tqAD+4De1g8a/oz950a7xMpqaPeg3yUDTuHy4cva
         ZOVN7w0jrXMQhlyIlSQy/KMjGq9/LJMX48jxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952067; x=1734556867;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brnEi/aJpSTL43ttJW7MhyFkF6Ud+FSLpSFKqAmDpCw=;
        b=cz/wQL84goRIbM6vX112ADDyIrWn1Rl5fMriznSqWGKkN3ubxVD+czGfFW7XOrHDaE
         qLshoOCgr3qCW44eKTKoPYcc+xyaNkDUg6GkgFDnENrIzUjjrTDGw9V9jA0IJ9jlNhG9
         u2t+HuzwntniWdX8GvCVrkkBIvqZKOT229Sh/oydK/yEm5SZ9Cu/FMc2Vmmz/Edj+1uh
         6EnjOElJoR+r5n6UB6a+u2+KasuNb0x2Tj8etFHqumWR+G9cegTLfqqdUam5irQvuPsX
         EW4184qS5H1lW1hv5HEj0qkrfUlQVC2Xf+EJRlyxnjnG92D9WCr+UFIhybqkEITi0jqt
         ydUg==
X-Forwarded-Encrypted: i=1; AJvYcCVO+UjuTOAOXqQ0e2Nkwb7ab0/4CSE6iHlZAWTnVsJejIZ0X3tnbp7ncJ83XEz1f0GqJqjmu9jwuITAFx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyByzFX0hVpNHq2bMvW6T+IJTin81VdsRBqwCFtC4BmNjkCk6Ep
	MW6WXTa1L0TvUYfD6EuRLSUR6BeubZAKtxq7n3tqYNrpkwqp8n2Kgp9XT9teu6gg1pVVO6tgF1D
	Y89XvPGr5qUSw01EGXBnajg/T/ylfp/h47L5n
X-Gm-Gg: ASbGncud/n96qCLlkXs9OfHYMN0qMLU1UAi88Czhi51tiXQCjTo54D3+MtCyOrOflHe
	Ps0THa/sS/Uzu15XsR4ROn1ZQvDdk10hA5tmQBJ3LVkVGecl7ke7MCSq4xpHk5bI=
X-Google-Smtp-Source: AGHT+IEq7Zw2BDt+iOPDyUWk0YHRW/a0ILaMn5oRc2ufsHMgU7TT14V8Ms7zyoIfRG/qrZpS8pIGFl7jVktKfKw+4P4=
X-Received: by 2002:a05:690c:4c13:b0:6ee:4ce9:b33e with SMTP id
 00721157ae682-6f19e4f0f18mr13027267b3.12.1733952067697; Wed, 11 Dec 2024
 13:21:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 13:21:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-3-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-3-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 13:21:07 -0800
Message-ID: <CAE-0n50U56XYpayM64BBOPE5U8xQaYg9TOWWmCvtyzB4kChgYg@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] drm/msm/dp: drop msm_dp_panel_dump_regs() and msm_dp_catalog_dump_regs()
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:33)
> The msm_dp_panel_dump_regs() and msm_dp_catalog_dump_regs() are not
> called anywhere. If there is a necessity to dump registers, the
> snapshotting should be used instead. Drop these two functions.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

