Return-Path: <linux-kernel+bounces-510999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15110A324B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAB8165911
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD7B20A5CC;
	Wed, 12 Feb 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuxGHPUH"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0B1B21AD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359207; cv=none; b=gbHXCT7ok7jCRxNexggSbZpYAlDanVX6iJp5MvfJEg/9X10roEbwdscgyDvCWW84c2XyrCP74DgOuB7xEb3o0AJcgkJ4R0LBmzJQKf58wElbKXLWf6CEZu6hQkKAfn6VLDJRh/fXgYP5xBJ1n7sCa2opexj3/dAz4ILYHnO+RHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359207; c=relaxed/simple;
	bh=R7SXFF5xZBvaqgymZWePikKLlqhrCZfQBN+7ls2UueA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd09L33JqYasXAGGAgEKPdRBMWqXc7hAn6b48dY1teYOLmSJDVTmjHrH3lGpn41oc5tTZKLT2yye8xpHo0W/jh+D4nDq5NzrhvkiiHP9tNN2IXdQK+L3aGINR1DmeMMU//AfExRzRe9huQmT5qPJ8U2AdKIHvzvDI0XmTN3z03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HuxGHPUH; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30227c56b11so68253711fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739359204; x=1739964004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRZ92fMzGnVasOx4w5jeLJUvN4okvRK9mTCYHy/vUF8=;
        b=HuxGHPUHG7FVF1JBwm2wZBN4A3EjeaD8njr+w7Tyfb5JYdhZnmoq5FSow5V2wJ9Cyr
         OPT7Al3vkMufrZN0x436cb+HUmScHqyA5Ygd0Y1VipUfKaTSlDQLoHxlDruzpdBO55AY
         Bu9iZS2P5d8GTDmtTsecqbEkKCVxNy3VKtqTAlos+wdJ61im37g+oFec+TRIDun07CJC
         UNcl+o7gGQOZZJfEwK/fz7KFhLTrpPmKoUlnMHDPcaOCBNoQbw14aoSZCa7G/bqMmrFP
         k72p7e7hS1EKAqgKypzuaUTU9pjV44PedTWbn2LHomYRAqD4XJ1xTqUFcsSgty81FMAq
         PZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739359204; x=1739964004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRZ92fMzGnVasOx4w5jeLJUvN4okvRK9mTCYHy/vUF8=;
        b=luce/UlrxwOez/SgFxxxgvRxy4JlQnwAfBzFriYm+ZvTNS8h3ztt+svLYauIbAaKt/
         F/ygmtGCi28IEEFCNbDiyQzXL53tzE4lsx4DNhP0QOy37WAq6JUOheHqdue5oYxNr5lu
         tQK4FE7QVbijD+ewa53iRVQGqtkuAIAcASROqvVCiMGQCpiQtHQHeV8ltw2OXhnPh5fA
         0sEgbyJWzJlnjGFCB7AzmoyPSxL9lwKGQTRCABa9rujLCSuKRaa09qHqQkx8ZpnVwfh7
         frgalljAdEkB+DbrKG3eWXC5+9TaenYqUKa/LYMWm0EfkrGRUXLhDQcuGFjO9H3QBGFO
         gr8A==
X-Forwarded-Encrypted: i=1; AJvYcCX4wOozKmZ4z4EbWk7CLr2otHHDjEsOrZL0ARMrXz/StXJIjHShb632IzNgl/mkCF5ytCOjwtPgrbXH7is=@vger.kernel.org
X-Gm-Message-State: AOJu0YxisUqETZycrZ9sE3ZolR4cXRvD/aP1JNhMKY9LouClojO0F+Kf
	deZ70PtSjHvacSrifW3dIVvKzbjz6hKZ3cpHYV5CqB5ZggonifyDZ4MDQ8r0s6M=
X-Gm-Gg: ASbGncvrMW+aZM4ebxb+KcHUQpxynty1Ojkhzj6qbAC30SSLjm0KeARz09Vqo8AWVGM
	fTauW2deTjNmjNqDgxw4OLTlS4MKg8b32JQcBEonaA4LjY8MvP7E2M91Wx6oZ9gICRQ01Ht1sGw
	PaZ0yjdlCTeW5XTJrXXMn83f/eej+Kov9Br+LEMhfwCealVjBBMJKODBIfj4Mn8SLrhvEhjcNiE
	a+qUlvWuX8CAIzP13Xc1P+D3GXsKL9t+Gm9nR/S7D33HWUpP6i1/x6dT05CF5nvw9VgO8pe4KUc
	0Ay+Fqf+NGwh5CNxk7yeWYUUeVrVpCKrl3BiTadNQJj6wklGJU/kWW3lASTOwgLllRwG3vM=
X-Google-Smtp-Source: AGHT+IFJgGK8ZLouL/AWBGo/S7q0LDko4RL8Ud8msbJQTLEZRaJgYviwJwVP9yImY07L4CtWYdBbWw==
X-Received: by 2002:a05:6512:39c8:b0:545:f9c:a81f with SMTP id 2adb3069b0e04-5451826ea22mr878271e87.6.1739359203971;
        Wed, 12 Feb 2025 03:20:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450e09e9dbsm823644e87.120.2025.02.12.03.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:20:03 -0800 (PST)
Date: Wed, 12 Feb 2025 13:20:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "James A. MacInnes" <james.a.macinnes@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 0/2] drm/msm/dp: Fix Type-C Timing
Message-ID: <yle4tv3rhxkygvxvq56pls2u4muzmuxlzg5mp6ibckkyhbaycm@mv4hmom2e46c>
References: <20250212034225.2565069-1-james.a.macinnes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212034225.2565069-1-james.a.macinnes@gmail.com>

On Tue, Feb 11, 2025 at 07:42:23PM -0800, James A. MacInnes wrote:
> SDM845 DisplayPort output inop on DP Monitor and tears on HDMI.
> 
> Fixed
>  - SDM845 does not support wide mode.
>  - SDM845 does not need porch shift.
> 
> Verified functionality on SDM845.

Please use ./scripts/get_maintainer.pl to get the To / Cc lists. Your
messages missed several mailing lists and maybe some of maintainers.

> 
> James A. MacInnes (2):
>   drm/msm/dp: Disable wide bus support for SDM845
>   drm/msm/disp: Correct porch timing for SDM845
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 8 ++++----
>  drivers/gpu/drm/msm/dp/dp_display.c                  | 7 ++++++-
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

