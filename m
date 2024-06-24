Return-Path: <linux-kernel+bounces-227436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2BF915127
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FC21C21473
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2701E19B5B2;
	Mon, 24 Jun 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXO1cnfT"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1D19DF4E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240969; cv=none; b=MfumT0vieuVL+SlQsljZYU7at0cb0IwoA6halyeP9KVA/e3NzWcN/JzUJciCeywGJ5dln0wJc9zCrRWPL/3N7hQFvR0ODn+b7G8wTnexsqOPNPEz2wRtfRGufoI9EpHSGRBw+e++XgEoYVKjyOlpdIEKQwvsX2KqVEOOLcBRAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240969; c=relaxed/simple;
	bh=/rcuYfsC9eMXg7bGCQ9A+y4XcLw5FONtQZwoyuilmr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6pvoe4VxcjrMyRZaGyrc5r0dyBFVOEKn0UHI0zbmnqsAx2dulUQ/eDSL//htkkzADW1ZgJ8lT4xC6UfoE/IwZkXVdwLnA4bVpf6G+sukrA6Zmnsew6O9DdhVlPAntBwEGnqxdYQSvnGMCrOQFRcSsx7CzL90Mm03sACPL78htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aXO1cnfT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-643423e914aso13534577b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719240967; x=1719845767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AuAYxiWC4TvD0a3p6GxU9uZDqvQlp2MZzMqiBjXKRCU=;
        b=aXO1cnfTtCDoEN1mcriM7q1p8LuGuAaGz+KTVSBILcM9gnBoMCo76bBltZKpaE9AvT
         XZsr87/+gFYTwiQSfGxG1fUfDmuo22w4BEFMrplvMNoT9o2BSUObkKzNKfcnIKXDf1Bz
         uTJBcmixEYLKw0PR36PCFVB+aM7zEZTKimx5V+gFPE4qjVkcWU3g9K9mXIGFWB0RGL4l
         x/Rp+cw6O4xxdx8m1vl8ZHyKm7SdMPJy7rhm0XTRGuMzyoh5TgB+z/63VcJx6+eCgPyY
         thVgMECFwlDk/gdc9JEI7VTEEeoqkmKG6l9t44Qr5onLq1GNFZ2XkL8UHl9KF9wzXuG2
         Y+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240967; x=1719845767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuAYxiWC4TvD0a3p6GxU9uZDqvQlp2MZzMqiBjXKRCU=;
        b=lQ7AQlcn5Y6FsHCq6ma71uWp+whTRB2kmX+8rpyT7Quc+6jrJ2vs1o1RR4TGU2r/vu
         qmCamszC1tZnvu5fbtVCoGUERTgD0RuzxglSCdsIDnJhuEp/dj6zA0POXks+ryGjoB3t
         id95Yp6FKSTNlX8Psr/QahCvXCGkkD41cfKJ1P5SCwCWI13lX2+Acw7GOtnazkIsUehr
         aH8BePt2YiiMTCUXqZyq6EOjhJazmxA1LRtrL413anQLDLtdRgHobjhv1PdZNhlndygl
         8yDP64/78pNX/eEAtOToaNyDwSymsdFB/mW2ruxFntgE/il0g/ooqjNVLRilDU/HNt5I
         rVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3lfG1hpb3a/TnZoqxgcazxhdxNPPkmttUaW/mYC15kUNuDT7+tIfSIsxdfC6llu0bcmY+1Z41dgXaQNsNx0cWiqiw4vKykU/qv94W
X-Gm-Message-State: AOJu0Yy9smmEVul5NMnKqnxqUuyXmz6qDR8QSI6EtqQH5nR9TnXJ63Mj
	+fbIbaitGNnxNxf4zRjTqwFZmTtR1OQ8NRNKdRwWmCu/OL1S5p9g7ZMz5y0kEaJa9dKzMDKhhyx
	rg9gt5iDgwaiZ8W/XzXHv9KfIqoXyrPlGGZA2Ew==
X-Google-Smtp-Source: AGHT+IGbNOJ6QDZx9hqjAHMWcJWpOtmqUWrF8dHeHS0GosTP6j1Yhpc3k6MDGo6NH7cJ/CXWiA1aGC4mzCnhS4X8Tz8=
X-Received: by 2002:a25:aa87:0:b0:e02:9c87:d291 with SMTP id
 3f1490d57ef6-e0303f52695mr5166865276.18.1719240966752; Mon, 24 Jun 2024
 07:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621101833.24703-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240621101833.24703-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 24 Jun 2024 16:55:31 +0200
Message-ID: <CAPDyKFoeYd6PZQ8+tKTyX68Fh7M+6ZMCAGZ+SNKrDU=ePQpZ0Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drop entry for VIA SD/MMC controller
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 12:20, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> EMail addresses of both maintainers bounce. Since there have been only
> cleanups for the last 10 years, let it fall back to the default MMC
> entry.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  MAINTAINERS | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf9c9221c388..5ef1e83e0fd7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23645,12 +23645,6 @@ M:     Kevin Brace <kevinbrace@bracecomputerlab.com>
>  S:     Maintained
>  F:     drivers/net/ethernet/via/via-rhine.c
>
> -VIA SD/MMC CARD CONTROLLER DRIVER
> -M:     Bruce Chang <brucechang@via.com.tw>
> -M:     Harald Welte <HaraldWelte@viatech.com>
> -S:     Maintained
> -F:     drivers/mmc/host/via-sdmmc.c
> -
>  VIA UNICHROME(PRO)/CHROME9 FRAMEBUFFER DRIVER
>  M:     Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
>  L:     linux-fbdev@vger.kernel.org
> --
> 2.43.0
>
>

