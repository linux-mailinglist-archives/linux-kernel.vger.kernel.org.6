Return-Path: <linux-kernel+bounces-520914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAF6A3B112
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FDC3AFB00
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2E8BF8;
	Wed, 19 Feb 2025 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RG10Z7Hb"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26381AF0DC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944189; cv=none; b=q2OqQkS1ChhBWyb+MGzWem5atmWqx2Jn1jBIL91Y5M9BXcEI+9o9toZqzhsXoCVgfxYpT60rlGBlyAUtly2FbVFt47t3R/t1VaH7JG6G42uW95aR5t674ehNtifvz77S6O3NyXhF8KhnmhpF2q3PEUSAbQsB9znhWWg/xsEjwSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944189; c=relaxed/simple;
	bh=gGRwfgPpTpK82Oyia/6u3CHtfQpPTB9d5xrWF187gz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkkFnyuIZgDuJKCSu4Fhy8afDcrOqb+oHuM8J1JClkSitWK30vHu76EC/T044ZS6WNkPm8BQohzdmmlhg4NabVLfebM/YLU0OSCXTPwRl6IUJztO0cYzA7sD3G0KzOMBRRx2hFd6cZ5zbgX82gD3dxGT4ZXtOobLVAzcRiJ2FA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RG10Z7Hb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2211acda7f6so69693745ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 21:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739944187; x=1740548987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nf8/3/DreRNzXlFHg2AgTTtfjDRLaudroEyy156u0qE=;
        b=RG10Z7HbWIm0Eh41GAQyiQ17uV4pN8Qf4586+QXFdrEvwgC4m/musdMUcIM5bZ4uLG
         3Va4Q4Vhl9ZR8ZfIOZRrFa631KSOc3ve4I+T1J1KRpLWGp1KX8oBb8f6TAq4/SV+4xoV
         /Lzct7iImH1z5hkVIqhMJKgqNy71FfR2TB1doIQGKNN1JiPnXo4TdkUvml6g4VQpYyog
         s72XU2ufT0epoxc8xKxVvS+N5qxhUTw5mkZt9rkYD3em0/rvroI/epy8OkGfsoXkzVzo
         5nT/ydb297wFVxU8NRm4qwMZEoDV3qG0qdTRUi9NnZJe+K2SSMx3wlQbkMrlE0OxQsq0
         dVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739944187; x=1740548987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf8/3/DreRNzXlFHg2AgTTtfjDRLaudroEyy156u0qE=;
        b=MCdILjhKKAL0p8pbDBQ7GniNuNkEUD/bqIlZoLzEk53asPNelhMnCj5RoE7b7Te1B7
         8As2KMMmnt+Gv685zg1QHQR6vAaNJUj/f7XTtRRM5ul6MNsVdWexqpIqylRVKpSUAr/m
         Yg82IIvtPFJGM2hFuhQQ3ZYtiqjxVBzilXGpRSFFQTe/EDpwSJptzdJy5Fl1VvGjUxaR
         ougaPJPgYrHIe7/oXLt4eo1VQZg1jXT/N5/THDQUqV+2IdMukZhQIJeN/j6huhViEMnk
         hj1nPXFf7BHzjC4MtuQ1tw5FtSU6SzhEa2yB1nxxOcB0fIUrdn1qw4wetYWKilhYDRGZ
         0YdA==
X-Forwarded-Encrypted: i=1; AJvYcCW2WZflBVDZiSFN8jIN3DO52C3EKgPbFjKm+OI4/kPrwp5hDSLobSkPtN/Ggs93A3G62I71efOwceXbUaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5mdA+oFB7ZZs5RXrQWB5C4bVf20CLkmLff288bhZv0EUxgMtX
	/S3Om9WKTazPZjEYlRVxJnKe1JQObs66ulfIp+6Pofz+3jjFvzWF9QMi6mnzIt8=
X-Gm-Gg: ASbGncubpqS4EKt2UC9eotyPInrXCppQYu/3YdGtm60lOK2Uwlr4PqHVCjlUvG/+FY4
	9fg0GTJxY/RBt6pAEs/0hKW3iA1w9vxhcmHXVLyeq93PXVFPmnA4qjCnoVIhjP/iedY0rms+hki
	zHiDAgkS7enGpxUZdh6g4inVkYJtaUevN8L49oLBk0OAtE3iIgxLDtTuAb0TuVulRznD2Ta52HM
	IqsShBD5wM9Vd4XggvTOIYlAT9Tqa3NBi9A60fZljY1NZz35MMQicVvrDkXCeSRpVS9XABzddhE
	J6bfLxFT11TKtqd1BQ==
X-Google-Smtp-Source: AGHT+IGTrwUiHai/F6Gc6jLbRLvEYwLeRI5NCdNzX1yb+2FEyc1a3QDq5aXdiTbSDtTZsAlf5lbhwQ==
X-Received: by 2002:a05:6a20:b58b:b0:1ee:8bd5:81c4 with SMTP id adf61e73a8af0-1eed4fb2d4bmr3091062637.28.1739944187132;
        Tue, 18 Feb 2025 21:49:47 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73274399467sm5972331b3a.140.2025.02.18.21.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:49:46 -0800 (PST)
Date: Wed, 19 Feb 2025 11:19:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mark Tseng <chun-jen.tseng@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 3/3] cpufreq: mediatek: data safety protect
Message-ID: <20250219054944.4kztb6rtumdt3x7h@vireshk-i7>
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-4-chun-jen.tseng@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214074353.1169864-4-chun-jen.tseng@mediatek.com>

On 14-02-25, 15:43, Mark Tseng wrote:
> get policy data in global lock session avoid get wrong data.
> 
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

I think there is some confusion on why exactly locking is required and where
exactly you need it. This patch is incorrect.

If you really think some locking issue is present here, please explain in
detail how a race can happen between different threads.

-- 
viresh

