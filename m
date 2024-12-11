Return-Path: <linux-kernel+bounces-442217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1569ED975
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F35A2829B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55BB1F0E53;
	Wed, 11 Dec 2024 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MOdJO1/2"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0FA1DB956
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955503; cv=none; b=oYkiiFEdEQ5xGB4dwOfAq8jEgoDvK8pavA3a6SrJI2NSXRoGJDonIwMlYL/OmwzB4vmt7NFQ7OP+f72ZR83MyB9nhUSlGVsjsWU8pEvQxV2X5jXJxtxvDqmHDo5HnKA3yolED7gQsh35hJOTcwOvREiAoI8Dxh6CVvl1UNLZixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955503; c=relaxed/simple;
	bh=0rt+LftUaiIAtV8Lnqx/UsM/DKwcWcCSJ7gULGGysG8=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWH0thXcIGfN188bum5C0l3BDXZOOQgbrGgwSgQXtawRH8NJ6rBjVWLBCVPdN5rs8QqDhY89p4X6iGf4esPZSV7NkNou/kGmybgbJkIUWRcZlOSS2Pfw3kehx5y/wIH6ykEXaOBr4RE5QxOLJS4ExJl86bt4t66UjaTCI2VdMi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MOdJO1/2; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d8adbda583so80977716d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733955500; x=1734560300; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rt+LftUaiIAtV8Lnqx/UsM/DKwcWcCSJ7gULGGysG8=;
        b=MOdJO1/2u1msu9ZAIleGiLmpT4S4X9UBG8BCKWZeWSQCzjp7kRHRNtB6yeVSIvKhEB
         LQvtb+qRfDcBBqLpP1ThZcWGNpXGHfSJ260ig4ouZCUwBX4zSrtGnShkCT9+gSPRLmIv
         E9R6Kz6Eisa8xIWrGxlhPfpwsuvEcux+8pd2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733955500; x=1734560300;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rt+LftUaiIAtV8Lnqx/UsM/DKwcWcCSJ7gULGGysG8=;
        b=ofV+BKUKluMcF/kFyo4jXZo5oYDp3qGjfVgBk02bFXAHh1fs3S3GrtLCN7MzZ3ggK2
         Zmvq7cylzH9lBqNSGsJygmZT1pYnB9AE8dlYLUTbHFf322vl2F2uDrJJDMRfkmlM3z/K
         FifZJBemtooYwsjO61qeI4chp8e6ojYKWr/CzAONMxKMeUkQkzShKKOn1qp6JlcZ0zJk
         wSS9JNnFpu5DlZ9R7Pb9Y58NVs1xGqpeb0AhcAGB/Bf144pDgCb3N74KmeEEtQ6l0yN2
         FZG0hOSCixaShv+eQtoAZBAq2dZyORbEPoudgLYelTAbQGK7gfeVOgHHyYaA47t8+3/2
         0atA==
X-Forwarded-Encrypted: i=1; AJvYcCXkxC+S/b8Or42AaY5RBEn+FtCDMuQfDfLb6AqwWFtEk6cj2iaWCPjslI0Eb8lFnJI2tldgA1bc5AukS8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPT7/UgHJelsGZOXPlw80mJMlIXkdCJ2QipJXmBfdnJn4z9q4e
	DqEHKmlSQouNkRryAS4MXc9BJB4VrJgOnBGNz7G5B39saCw7K43C/x96tXLNh5uCZ0cpLzdfgV8
	BZzxxErU5V2s/BNY5MnfH3v/FeS+YL/4Yoi0N
X-Gm-Gg: ASbGnctPHA+qW0YmJUoHz8FBzqcs/+QJ0f6VHsw/ZF8fvNFH1Opl3xklEGOZbRppR1E
	EqCGX2/6n9FatAiQ/kTs736yYIAhLuaDVYFexPcdycPytW2rk0Pbf0+RCrPtAWhM=
X-Google-Smtp-Source: AGHT+IEh22eo0rd7CRUaBnizbOTPapamAsVOnD5oqCjCeDY0vRSnRalP/VlK+LQ2LP76cy7+yeYmUI+Cf2UJpD/kvGU=
X-Received: by 2002:a05:6214:d68:b0:6d8:8e0f:8c03 with SMTP id
 6a1803df08f44-6dae38f5720mr18047506d6.18.1733955500628; Wed, 11 Dec 2024
 14:18:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 14:18:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-4-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org> <20241202-fd-dp-audio-fixup-v2-4-d9187ea96dad@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Wed, 11 Dec 2024 14:18:20 -0800
Message-ID: <CAE-0n53V9xmrktUBpfNd9Me7pig=c3sP1AcCPdKnpDd-RSuakw@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] drm/msm/dp: pull I/O data out of msm_dp_catalog_private()
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Paloma Arellano <quic_parellan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Cc: Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Dmitry Baryshkov (2024-12-02 02:06:34)
> Having I/O regions inside a msm_dp_catalog_private() results in extra
> layers of one-line wrappers for accessing the data. Move I/O region base
> and size to the globally visible struct msm_dp_catalog.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

