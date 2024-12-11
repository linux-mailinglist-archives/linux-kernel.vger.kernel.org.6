Return-Path: <linux-kernel+bounces-442317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7D09EDA84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BB428375E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033371F2396;
	Wed, 11 Dec 2024 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DNmy12XT"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A821F2C23
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957936; cv=none; b=i5r1sMW+HBEiCqqwP8z7kfEBzdV/cLVjaP9abcBazwZ/8o1IWgkD17pqCqlVIEvqpbl5i2AHoYk/ARzrg2c3c59KYSYjBDmF5AB7JtoolirQbPenvci5TvJ18Ej3dG/+qnWnL47b9Iet1oRvk14wIbeEBOAlTSz7RIb6hTehIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957936; c=relaxed/simple;
	bh=d7oul3/epjfIWJpF9pC+/pDis54zJFCmAnINjv8ddgk=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZsV6ReYUsnmIR/avZUIOiOPmwK8+0XKL9VPT8J8mXw3kEoscjAI4jYv96V8phdivFHiOCCRJQ/9TtHp0gMz+tqTAc+gXucMIfSeCpjvjmjTsFGT36RX7tNqXmXuyIQpK2fMSkW2lz6ANeJN264ZYfGBezmbjEd97CWaaeRceq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DNmy12XT; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46785fbb949so21820351cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733957934; x=1734562734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7oul3/epjfIWJpF9pC+/pDis54zJFCmAnINjv8ddgk=;
        b=DNmy12XTKkCDpbqK6KAJl/PMNWZHizJbEIAOhZrLVE1XvqWmwroY1dMPZ4RyC//lfy
         y/yL3c5q6gmnHPwF4RB2/bZn8nD50KEBhmqh9Nvk6p55eLdEs4PnHd+wTGZCRtU4nIfF
         Xs/djWhbZ4H/5kXmiC5Xuy0B/UIjEQbZClNnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957934; x=1734562734;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7oul3/epjfIWJpF9pC+/pDis54zJFCmAnINjv8ddgk=;
        b=CxqYygsLJmJAcfHcZe4BtM/RlSff/z278YiepPmx43DGmp7ItCGUIPntqjQBkfU4xb
         X+IYly6dFS0WpTQS/WYkIC7Dd8/587QeOBUlU/LzZXE7XPTFWMmSNlKL6W59GU4TnwAG
         O1a7mNq2Mhh08Xn0Q2Oqcgu9KA+lqMvqI6OJQ374BcMSJ4F3Bpo3nU2wRn6gnMDtWKk8
         drdJEGRyHDWP+18mT+QKsEz4TOsdfGjNNPU8AESm8z7da7Pm5E2P6TPVW5GOZcUTs8CG
         0Ppzj/6OOFTVGsoBDD4lCo0IP9CKAQglyFwMaHZpv/H0Pzy35tstvtNFw2/2fMw3xBjo
         JlNg==
X-Forwarded-Encrypted: i=1; AJvYcCX15/MG3xJd0Och71CV3cOZJ6Ijc2DRUXTBsyrP9PKfncdDMW01Lsmi/T1AtRQvLju9KFcbirVk/PCyhLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQX1vQvnGNke3J1eoZ9KXtJMpXi3oYg5y4kF9aJSbm6c9Ghfg6
	3fs/zSi77LiQ7jSpvigX+e3qgOBW0gVfQ7ebWtRM7PDo7X6MQZdrZmmk01qidbKD4574R/pKEag
	aaFcOhdzEBh3xy86VVEt2yYxx1Ym8ZMb3J80g
X-Gm-Gg: ASbGncv8THBVdSZyBikDt+8MGatU1OIhYzzt/s+tC1EPKj3oRSt/QYIdLIEenqbjdC5
	rj7hzSBFkV2wmcsgkfCfmbYN5ERPj+TSUriMjHwiGBueI/LNygWhxxgPmfSdiN7E=
X-Google-Smtp-Source: AGHT+IGPvlar9kD/U1IZ+NJKxYLinjgrZQ9MpbRulgpuokUWHWjoaaMJU+Xn5x1nVqU9KmYDv8PLu/rJckgmgpIo2wo=
X-Received: by 2002:a05:6214:5293:b0:6d8:8cb0:b40d with SMTP id
 6a1803df08f44-6dae398c5efmr20747426d6.39.1733957933934; Wed, 11 Dec 2024
 14:58:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 14:58:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-14-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-14-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 14:58:53 -0800
Message-ID: <CAE-0n50Ae+HqW2ZvZ5n=zgw0ZNA+ndgUFf_vFXZs3uzj3VPQzA@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] drm/msm/dp: move interrupt handling to dp_ctrl
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:44)
> It makes it easier to keep all interrupts-related code in dp_ctrl
> submodule. Move all functions to dp_ctrl.c.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

