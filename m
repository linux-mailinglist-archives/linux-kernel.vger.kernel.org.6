Return-Path: <linux-kernel+bounces-220898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BE690E8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A672874E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5064913212E;
	Wed, 19 Jun 2024 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bMjHODUw"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9F81722
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794678; cv=none; b=DyqpDjFZsv2U7Gf8pXRXjBQ/z/3PBW1LOL2wljsGtpgAT404uY7IL8S6l+pcwUtM06JlEKpc900MGarz8suXTwcbFvVvHKHLN4g+KRcNmAOmmh/b1bIVznhKzJ2jpc3OgZHydF3I0LDNzMqcjpI7BdSeHUff+tj3Xd15FCMrgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794678; c=relaxed/simple;
	bh=6SwUveGhsJ2yFgj2oXvWQ9NfEqHE2QpIS1PVhMYjA+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJk+JRehTEcLaSVCrnmo/N4jaT72lCeQD1nBlcxSvhIw4JhSaHhWNGLBaxXJl+Rsy33VCsX8/qyt7/RtHJTwBsBgZ56K5OaM/A8yxGfeDBVhLCMVnOpPv4Vajby2Im4TbwtgYjn/UOanZCfNdFFCRtkpRfukSjc8ggExtvSo7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bMjHODUw; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso7158991276.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718794676; x=1719399476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ltaKEL7XJMSkKIw8u+LhpWZOs3XHgOjod6ZHs6SZA8=;
        b=bMjHODUwT6dpmd5d3FIZCGOzAehc529H7VyOZgd1ySrC8BeTaOtAmxvgSqIO7yne7d
         IDwDy9EhE646EII8AM1LeezH32Ml/en0IDbOKQc+hts2j0dFN6bowjCcXY1PeSdZUZEU
         1n8mTNFn3Q+lLM0Ko5u8p5gsO1rWD8hJFddZPQd2OB17BaHRhnsfCDJtgXs5YcZo5Bpl
         /b9tRt7wV4lHIkQPf6FnY2EvwsNLPvh7ujtwW6HNGKqvEr55bt5iZgUrsvyjdXa5YtVR
         d+nMBUjpAUfZ7pbKBMtJTkJscB1BZA6lM0C7JRDvcEgA14YBr7k5kme3qyMWa33+exZy
         F+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794676; x=1719399476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ltaKEL7XJMSkKIw8u+LhpWZOs3XHgOjod6ZHs6SZA8=;
        b=GOnAGNgN0qhzOv21EOZh5pwSDgz/FNIj2V5RI6bXAprpXcII62Gdnjs2U0DrcGd17z
         V2GB9TJusQ3SRv+cXi7O8thPpyBYh4RTTRyExGSMdYk7LsqcV/OAtOYPiXV4zvIJogO9
         tCDfxf5lJbjZdUmV9AMpusflvS38P8t+CcQFQOfBUrcAbZsPAqIkTDqH0I6WHMlHXhlf
         EEhalvWsIZnA1MC8YGlUx93XjLximeKu9HMI3eMfWq2bVUONN6N87umKDBgblBPoskr1
         bNOOahyzvhluWNsNuKeUNmh2yi4RmDOgMdrn3xptBjgO9cTNYenQwG3Pm11wwr0fUW/o
         HKYA==
X-Forwarded-Encrypted: i=1; AJvYcCWCcILu/o8TtqqrvbeiQAPxKaeqSg2YweVHsR+VsH0itd+CorDEx8jN29U38tEJjAGy6v0rd9w9wSD/EAh9zO2dlWk1xrxPkshu5UC6
X-Gm-Message-State: AOJu0YyUDhvfP8H2jSfut4lSIOAeRSGUKo2p8braRJRncdlyRCkjT++f
	zFpHJcrx1xGpfx0MMmwNCmHbnUpdKYshj0DiilOW7BLN6GlTxgi/mX4X7UruI89YZSOlkMbhOid
	M0/zEHW2m5OKDpyQiZ2PZl8nj7N+hrIylumSLmQ==
X-Google-Smtp-Source: AGHT+IFfi4jDyEnaxZAO8wGIs81Q1Kv5j3U4KQFs3jfEOlyMDNcKN5AzMsT30FNnMyIoHQsBafG6yE9ZWHU3Hp6dvhU=
X-Received: by 2002:a25:b02:0:b0:dff:1a17:dcbc with SMTP id
 3f1490d57ef6-e02be0fc880mr2350844276.2.1718794675921; Wed, 19 Jun 2024
 03:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619105642.18947-1-quic_kbajaj@quicinc.com>
In-Reply-To: <20240619105642.18947-1-quic_kbajaj@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 19 Jun 2024 13:57:44 +0300
Message-ID: <CAA8EJpo=DsQeLirD5W98Cqi7eUo_-g676QmfJERrCpeGBtrg4Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable secure QFPROM driver
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_mojha@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 13:57, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Enable the secure QFPROM driver which is used by QDU1000
> platform for reading the secure qfprom region to get the
> DDR channel configuration.
>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

