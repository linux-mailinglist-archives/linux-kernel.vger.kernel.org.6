Return-Path: <linux-kernel+bounces-353529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CEB992F11
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E071F1F23224
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D031D363A;
	Mon,  7 Oct 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrB2xEf4"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799A188588
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311172; cv=none; b=ZMf2C78alCjiiUbdcBsand4nsLFJeQMlpQjyLsiV0R146oaes3ZeX0IpC8zJ6ySzfOqrdR7Cid2HkhYhc5lD9AWNQEcALNG/O3R/FmtkOv6k3PkZiscTBywl5W2ceFQorVJZrdLGN+ivR/CgOH9Y7xEtMGnJVUH4tdCSEnwpa4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311172; c=relaxed/simple;
	bh=n11ieSpWh0nRIY1KEt8oDLFzeIYMq1wVh9SRUL4RpCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wr0cjb+DpEef2uwuD/NYOb7ShnbY9LvCCCVwMA5LAwRmGOTkNrlxrypdQXrUkb1e2lE2lRxbSfTefoRrIYxMoAPoCJ0TDE4S6Mp75KECtQMvw7ZU9fuR7V+27lHXEcDj2mxGNQsG+wt3O0mgL77iZm1yjRA0gVesls3XszywHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OrB2xEf4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2e4d1c992so13634057b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728311169; x=1728915969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n11ieSpWh0nRIY1KEt8oDLFzeIYMq1wVh9SRUL4RpCE=;
        b=OrB2xEf4GQZ02YdMXzHckVukEzYREXKXDK3nfq2BpIjnm21P8HADJ3v5/a+h3cfi60
         +fWDcbPMibD3L5yeNHAsJ3TVM0q+N/LTaXKmPMH6Y8iESAr+/LPswIOklxPHbEfx1+y9
         4/4BpPFscBtoXjTdPJ4BJtwM0j9KthX2JqOxuTsw6JzjSbnSOwscZJd0Q9rJUFzl5ksQ
         g+lC9EtE1d3TZ81H6CGW7T+IL1py184FM7jFLXw8hUnLjb2Ls1PhvPRh8N0p+Fpu39kM
         khlK1ZccBQPXZbAq/k7X4ko0F+g41bpAzpsgiEDwl4Jn18r+Yx0HT8L36Uk7EbSINjOQ
         Z7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311169; x=1728915969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n11ieSpWh0nRIY1KEt8oDLFzeIYMq1wVh9SRUL4RpCE=;
        b=F167XVsjGAMuKsgvP7XkEu34rtXnd6q/jNrhF+0ApZ0llkBb6/yeQG95RAUK/2H7JC
         c5ejdpacM+Zy2ckICD11ghhfqYVXfVD/6RrmCuiX0DnWcQNWz1O6COxvYdYx8QZK4KQO
         3Hw2TcXNQqlY0nTGBDJrybBNU+Ibie0J1RfQjblXggt6SgoP4goMk1ZomXhtjOQrN226
         VZCdN748HxWchKvm3u71hKixc8cFy7l8fUHlLZB6Pv8ZP/JFxuEbGagMeV67VyDBNdV/
         qROb+tn5jYXsx6Zx2DG/yS3xMelGdVMS/b2dOcbRIRHWVnZEjXNHBcQrTK4Ogz+2pXae
         LEgg==
X-Forwarded-Encrypted: i=1; AJvYcCUYVJ/YoKC3+XhMxfDXWIvcY6x3Rx3zj6SGSlcWJS8jIsKeTwjwkN43SLELGYdtlYbmrncxx3DC8fA09R4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1kg+PW/w20c9lzLXNP7b9bg16PRQBv0s7Fm1z0+oXNvgN3LFp
	/qllkAILFTFVLXsI1cDoEFFvbyxXwTjQeCIofY8Bh1M8lyh/eXhrpuGbY21zYzedyl0g2Xr/A61
	fMGAfBHvlaSpzRGCqoUC2AtlvYbCxT9YCgY/3/A==
X-Google-Smtp-Source: AGHT+IFqXn9I5A36od8pTZ5OISG1E2cfgwB0GKV3jyBjKDEgdacTJ+nK+S3N3ldWRKoxnpFcpCCE+x0yo22XrCawjaE=
X-Received: by 2002:a05:690c:7008:b0:6e2:a561:246d with SMTP id
 00721157ae682-6e2b534c690mr109041517b3.9.1728311169613; Mon, 07 Oct 2024
 07:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005140150.4109700-1-quic_kuldsing@quicinc.com>
In-Reply-To: <20241005140150.4109700-1-quic_kuldsing@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 7 Oct 2024 16:25:58 +0200
Message-ID: <CACMJSesUCVXu8qdFgp88KL9KZxL80ki0UE09f5ciEbe23NvamA@mail.gmail.com>
Subject: Re: [PATCH 0/2] qcom_tzmem: Enhance Error Handling for shmbridge
To: Kuldeep Singh <quic_kuldsing@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 16:02, Kuldeep Singh <quic_kuldsing@quicinc.com> wrote:
>
> This patchset addresses the tzmem driver probe failure caused by
> incorrect error handling. The qcom_scm_shm_bridge_enable() SCM call
> captures SCM success/failure in a0 and E_NOT_SUPPORTED in a1.
>
> Previously, qcom_scm returned values based solely on a0, without
> capturing not_supported scenario. This patchset corrects that behavior.
>

Ah, I guess this may be the reason for the SHM bridge enablement to
seemingly work on certain platforms and then lead to crashes when we
actually try to use it?

Bart

