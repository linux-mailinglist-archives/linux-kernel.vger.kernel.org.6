Return-Path: <linux-kernel+bounces-524311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00F2A3E1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C720616CBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF8C20E6F7;
	Thu, 20 Feb 2025 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imxWhsdc"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BEE1FF1A7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070679; cv=none; b=eazH9qeKhkvcHEnlPH5TyqdyslvlBXE9Xy7rmv71upMmQUb0L0f842/YLlHSWmbftol74JStlxG8/YosTSZ6Oj2KKJ61Al6WoQzWN45hVxQNV+a/8um/L/TkX+EAKUKKsF7C/8VKvTjyeCqRr5H8B/y1V0D97optNB90oz1znBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070679; c=relaxed/simple;
	bh=5JtfmGOicW04al1EGAJOYw0ML135NPF9yS3PcFGnjN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlP70VSAX8ZX8EpwKDZisSJVj+rwW5KvyI/fPoHhbxx8P0HDuEdPE8om+Mo2sVjK8c8IvRm+otgszNmt0Y2cYVRSfw/TcBGJ5P6DWCjblPurn3cpP2g0J9isVyhhABji/2yK4qAaMc1RudY9Whn6EuRVVMl8Qi+lKqhO0h+TS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=imxWhsdc; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f8c58229f1so10932487b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740070676; x=1740675476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nQNdnw8eZcrMXGZ8JezKGVHSn8lKXmz+Y4gt/ozVgyY=;
        b=imxWhsdcKPmAfS0pvHjf7vKwBi0OSZxi08cTK9hPdblU8Clo7MQwv0k6XWZFDO4F9k
         qCBC/TswOy14n8hmy5XkKDhNRE//wqqFALVEQQc/hv7eSYBTJuCthhWErQd0lHLGuTon
         7aaWHoLbCR59y78X+MNM/Q3SBZLaxUteffUXyD91a1oNsy063Zh62n3pg4cojasCoKRH
         TJ4wHpr364v4deD+ZFEpIW8kWJTnxOc1f7Bn2/q4VNZEk2cQpn3zNjlpTHxp3GdP/viP
         ogcCONmFnIQYZx00IE5c/X3Xlx/eH6tmONCQvpCo6P8+NdHVGcHKKOt33mZYJ3SFgOBh
         moMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070676; x=1740675476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQNdnw8eZcrMXGZ8JezKGVHSn8lKXmz+Y4gt/ozVgyY=;
        b=a6fo4vr9QLCIiP22WanEqo1ZGstdRIbmI3IzyXjIV/CpWtGxu9r1XHU+4bGXeE2kFx
         PFoE7w4GkweMKeopTPbgd1AbwTl91KIY4eBInC6egjlGI19Ie1R+yShtc6virNdRgmBp
         yileISkRj5SXXRCeVFN2P6fGHW9p20NdRyuoK4RLf0VN6UHOlvX7lhDPMPdsTXovGodf
         DOJVgCSXMFFOPSukuMP2yP1sbLZqTB4OrNyAjD9/gdUbVzjA3RRkrfhwiRkAQwxFUuZ1
         PRvHuBEKxeVRym2D1odT4UXS3SPw02lQC3poPCAyIJ6eQ2iGONa7Um9JgrJfBIVtD3e5
         r6Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVHuYqxh/kx3eU1cnB7E1ttwj9mK4i+LNPwzmr1VkxU4cUZ5M9lZNbUjdRiAM+Sv9f5SRKsNKl404e6YqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnqqNtspwdNoiDrKw8J+JNQU8696nnjSx1vNWORFDfLhiHoHj9
	UFStSKcD6Bdi3z/6VFp/FGwxsurx2pULWPTkB9TAdAUYSI0Y/L0bNn5gpI3/s9EJK0N5rRdiaM1
	RHiF3QwDxP8xPbVsIcpZ0f+SLE2qqRe0g3G9v4A==
X-Gm-Gg: ASbGnctN5mIxoLGqs6TGe0eapDaUcAj9JbC5Ksl9tZKTj0e1wqz2OMpYReZrTJGpX68
	0HB65mEzB+kc6r6QOw0VNA/TD05NYnkYkcRn2D2YAP7nWagyH3gG8yACvmuZFRtSALhVNcFzBUa
	tV0ZqBhUJ6WEg=
X-Google-Smtp-Source: AGHT+IGTzwdM7XAGbT4Wb/bnOnPG0YkAOA4aOQm7K+g+wi5SiNeO8OVb3mOzmK0qbEZl7WVYr9JV+AZdIttBgIk5bNc=
X-Received: by 2002:a05:690c:4d42:b0:6fb:b38e:2076 with SMTP id
 00721157ae682-6fbb798d491mr39535587b3.11.1740070674841; Thu, 20 Feb 2025
 08:57:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220162847.11994-1-srinivas.kandagatla@linaro.org> <20250220162847.11994-5-srinivas.kandagatla@linaro.org>
In-Reply-To: <20250220162847.11994-5-srinivas.kandagatla@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 18:57:44 +0200
X-Gm-Features: AWEUYZmKSThXa-h2i8izvX0JkpbHRtsDXDUdPOdCOOOy3PX0YOtduln-ftn-Tik
Message-ID: <CAA8EJprX9j_pTXxC9o0RGTNgos6ao2aLcRKsgv3pfNAQOrbChA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ASoC: qdsp6: q6apm-dai: set correct period size
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	johan+linaro@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 18:29, <srinivas.kandagatla@linaro.org> wrote:
>
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> For some reason we ended up with a period size which is less than 1ms,



> DSP does not support such a small fragment size. Adjust this to be in
> the range of 16ms to 32ms.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Fixes: ?

> ---
>  sound/soc/qcom/qdsp6/q6apm-dai.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
> index 7466fe0c661a..049b91fd7a23 100644
> --- a/sound/soc/qcom/qdsp6/q6apm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
> @@ -21,11 +21,11 @@
>  #define PLAYBACK_MIN_NUM_PERIODS       2
>  #define PLAYBACK_MAX_NUM_PERIODS       8
>  #define PLAYBACK_MAX_PERIOD_SIZE       65536
> -#define PLAYBACK_MIN_PERIOD_SIZE       128
> -#define CAPTURE_MIN_NUM_PERIODS                2
> -#define CAPTURE_MAX_NUM_PERIODS                8
> -#define CAPTURE_MAX_PERIOD_SIZE                4096
> -#define CAPTURE_MIN_PERIOD_SIZE                320
> +#define PLAYBACK_MIN_PERIOD_SIZE       6144
> +#define CAPTURE_MIN_NUM_PERIODS                PLAYBACK_MIN_NUM_PERIODS
> +#define CAPTURE_MAX_NUM_PERIODS                PLAYBACK_MAX_NUM_PERIODS
> +#define CAPTURE_MAX_PERIOD_SIZE                PLAYBACK_MAX_PERIOD_SIZE
> +#define CAPTURE_MIN_PERIOD_SIZE                PLAYBACK_MIN_PERIOD_SIZE
>  #define BUFFER_BYTES_MAX (PLAYBACK_MAX_NUM_PERIODS * PLAYBACK_MAX_PERIOD_SIZE)
>  #define BUFFER_BYTES_MIN (PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE)
>  #define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
> --
> 2.39.5
>


-- 
With best wishes
Dmitry

