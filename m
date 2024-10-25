Return-Path: <linux-kernel+bounces-381913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39429B0638
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225121C2260F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B4714D6EF;
	Fri, 25 Oct 2024 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtbbuTAr"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571E14A4C3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867919; cv=none; b=c+eX4+7SHi4mPqtRF+Tc2BPh+WCJxxT/M01u99Hiyk2s1ziOw8Y51+Lwms+QldY+vrlizc+vsunT9+rMM3gLqM1Eyld4zDZuRPqC7I8GcMTbO6ppLc8n5ZDn9rWasTddusjX7Y1OEjcvzZjcXWTWjuZ/EvLjSrrbhLwciw22PQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867919; c=relaxed/simple;
	bh=Vx8Bd9sC0kDg9EtadUja5JmXpyq7Oneb9WEXhTdHlV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWCpvnK0+J2eMdt+RxObQpUXhFT3OyZWiGKSPywF1M6UAwSWkwDq1XeL1uj67MzDkp0ls8j2iVtZLj5cpSSAwvgi9iPlLFdQK0hSSrTw7r2i4DG0HVxiYzCOA/PQG6et/vjnZVw81fI+xsAwlV43Cxay5NVrokHxCUjp4AbA+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtbbuTAr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso2402003a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729867915; x=1730472715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XR/4Fvu0tMyoCCtOc6mB1xqHO3YtOWoM5ClealtuxgM=;
        b=DtbbuTArMtW2T0bqSX1pVoWD20AfmSyMOJ8GbpoFowvd4ffVs/ujY1+qCQFqAFkTge
         FquSFOvIjFqwj4y95Px555IpeFfQYj1/S9GqyZEgM3fVd2N6mvUMzoDge2C7Y11L22To
         DW+BLGcnLneLl06Tn3ZeZIPnlK6fUTLzJCynvEGqzI1FZ/tg7jE5oK/OM7I406PadcfQ
         FWGCDw4zSA/kf2Fpm6o+z09329HNieJCK5jW0aklvKlTF2fiqFXb1pwJ7E0BsooJ3D1K
         74CIdt56kYTJTjmu7uqASx45gL5mArJc9uCEY4p9vF94DsZ8Djrua3h4iIFnK/QRLnw1
         egJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867915; x=1730472715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XR/4Fvu0tMyoCCtOc6mB1xqHO3YtOWoM5ClealtuxgM=;
        b=q0tZfH0z57JjqakqZimqp5B0QTkgRs+x3bws4jSmpGKU+AgiIhxoayzY9naWJpCUyL
         xpYI60u1t4eeWiHyMR1tCURMdg2LEHK8u7q0eAF3xY9nxdkEyng5M+QOzROfR4p+Qzax
         3anMR64781Z/dPudELmwbpbsIGsZFueOUZYljRIjj3rBF1ZtfpOKILk6AQQ0hZqQe/y+
         /j/1lBMLXEx1e38EuAB4+1UIk1B/S0QLCrVkAPBI8aNqJkQCTD2gMjb+9pCRBfrU0d+8
         L3HuhEhhD+G+4bIFsXivvruHLCO+LuDavUtNYwguQX9wZo4c5p6EdX57H+aQ5DQn/evQ
         rR3A==
X-Forwarded-Encrypted: i=1; AJvYcCXNlPRuETyVjFtM0h/kxQ3hozTdQovRBeMaimncJtE5A+7z0zGwH8FUSe2chgaW1fSIR/ydT+gf0uOpdJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+wSmvLmpCJtMuMOBYJOfB7/XjymOUmREtMi+HogAC7tI1abd
	/Ro+iOSX2T61WF28DrjosoSnE+IOgn+Dx4AA1ed8ibbJQM1RepsiJc6iKgHNkTf8uOnkIOrC4M3
	s3EmNxjmVlvbqZlB6qQRJY1IxpMxVFtMkMCZEoQ==
X-Google-Smtp-Source: AGHT+IER6oLuLAmMqy0L4qN7TusuZBghOustjiSV8015jNjOqosSq06NJ/Zu1YsQk+kV8Qw7CqO4h9Ex1wfPvyXxJpM=
X-Received: by 2002:a05:6402:1ed6:b0:5ca:18bc:8358 with SMTP id
 4fb4d7f45d1cf-5cb8b264348mr8002531a12.24.1729867915170; Fri, 25 Oct 2024
 07:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012143826.7690-1-linux@fw-web.de>
In-Reply-To: <20241012143826.7690-1-linux@fw-web.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 16:51:16 +0200
Message-ID: <CAPDyKFp192dy_OXXYk5zqJQPUvrTwkQYPaMoFVsHHQiO74U1eg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add mmc support for mt7988
To: Frank Wunderlich <linux@fw-web.de>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wenbin Mei <wenbin.mei@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, daniel@makrotopia.org, john@phrozen.org, 
	eladwf@gmail.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Oct 2024 at 16:38, Frank Wunderlich <linux@fw-web.de> wrote:
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> Add MMC-Support for MT798 SoC
>
> changes in v4:
> - drop minitems because of dt_binding_check error
> - explain mt7988 compatible with mt7986 platform data in commit description
> changes in v3:
> - use mt7986 platform-data with the mt7988 compatible

Applied for next, thanks!

Kind regards
Uffe


>
> changes in v2:
> - corrected minItems to require all 4 clocks
>
>
> Frank Wunderlich (2):
>   dt-bindings: mmc: mtk-sd: Add mt7988 SoC
>   mmc: mtk-sd: add support for mt7988
>
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 22 +++++++++++++++++++
>  drivers/mmc/host/mtk-sd.c                     |  1 +
>  2 files changed, 23 insertions(+)
>
> --
> 2.43.0
>

