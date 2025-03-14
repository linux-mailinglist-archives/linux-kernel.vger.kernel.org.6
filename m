Return-Path: <linux-kernel+bounces-560629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B65A60779
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69E419C3933
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7477A41A8F;
	Fri, 14 Mar 2025 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fbM7eI9R"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0712B94
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741919287; cv=none; b=RZ26OXz/5i/IGPmwnnDYxzmXSQLlxy4rD1Ve1Qb9JVAAmt32M6M6YIcNkM1UP0dOSqDYpGtl1D7GPJvyGuX+1Wczhjkd/xVgKz7DegPDdV0G0u3XHY3RzdhwWFLh3qYF/y3kz3LvgDH9WYg+J3oi9LeKyDUhla6q+lnLP/aoW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741919287; c=relaxed/simple;
	bh=l/P9CX77aVaT7iPjebMKtrMjMWUYqgPXyKrAVqMJ9pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iojCjkJMf6FyQClfmgfisgBH50+5Mqehll84qtmdIUEniSFokiE1WBv9SJqi5gGtoMWk8BNb8mndc5osnyGEME2NbrUXqEVU1ayAdT6SSBySzE693ZsUj4p372+NL/zUvMbWFbNsGE2hQPIQmbx6Vsie5t2fmgembgk51bhG6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fbM7eI9R; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499bd3084aso1624782e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741919282; x=1742524082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EDLto5Fj+QyO1rc5OeVTSwga/F1rC5M7RFzWcpsACU=;
        b=fbM7eI9RHgy2bLhdhftBCQqwjCVbisxM1ta5SdKSusiFkvzCFhn8Vr+74d3KZ2cdd7
         HVW9uF3VxyQRvu5d+Epgoce8uUTr8xu3bkh3nf415WIbYhNDRdWU7IF2km5QGxc2A9Eb
         AhjNNyb8KGnO1Tp0sckD1eOpiRrkjNQAPvwUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741919282; x=1742524082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EDLto5Fj+QyO1rc5OeVTSwga/F1rC5M7RFzWcpsACU=;
        b=lqDVp0c5HEB8w4AYdhcxzeNJCq/IdsiB9R6seWRdLAzvkHpcKd3f9mCD6Nw0KM7Jik
         JvxwttH06OOgHPHD9U4nBoPalCOF+o8DBp6FkU2jH1bbMVUpUJWsJv3Zd1TYFVDWqyV+
         b3IKtlwv/Sflyr+fwubZb154cJdTi/ThvjpxD2PAvetovEkNiQz+rVDPRv0nCS2qoGBU
         5n3DRYyTsdm7eU9I6+uyFKVGtvGcwWFvzkj4CHspxu12NP0swzzEPQ7lG5N66dSSTudl
         ialay6xkHuDIBppiW7BEOtjiAToMHrhOvYyfSn3ZouU8l1bq4mPrrjAMNwQhMjEsp+wa
         YrPg==
X-Forwarded-Encrypted: i=1; AJvYcCXPgDWYU5xoIzXIK+q3txs1IbQoB5vSrm7N5KV406Wl4ZsigvQaxYuRVzECRbBXG0T5LumKMCqAXJcLJgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIvwst5vgS+eQdywATuyUX58JtGV1veznU4LYrrxo3yPyqO0+
	u7R687izYK1P5GJ3oZ7DRjfh/dU2iIkMURCwIn5yid5TEhSk/VHhyHKzGmVxLRp+68nL+kVYY8H
	Z1A==
X-Gm-Gg: ASbGnctEi4BsJyLStNCe1wtR/Wv+B9kmakAm0BTGDB4g0H33wxHb2otWThsvWgdlhw6
	cNaoxD0ij+ncrxxlbjswQX3eIsWuwzhbr1m6Nkxyt51GUdkpNUjx9WwMfRRYKRzSsG4vGPHB8rk
	9xT8z+XKW9ti2pJ3jhLmgIpW9LWFoj36nTbBU3ha7EBIbYC5YEcagd05+BrARralrVtGGtZTwjr
	BvGZWvHF6FVlISTHfxuuZa0oXisREjpKYlJvWcxm5KUSUmoDxRzsde6+HIykWQ6ymJyP9XzDahn
	tmZ4OBtWFDx5njSHpUW1UMwMRJ4zQYmB2pIqFTBQiYU/TxkKavgpQJxPkkVUN6+h1+sR1an1rx9
	x51aYPcFq
X-Google-Smtp-Source: AGHT+IH+ZQksNxvfRn+bC7f3hoq8Z/8q5IPSdIjRNW52tDKK9Ya4iRIpKR5hjMyxVNF4EDgrYAhRQQ==
X-Received: by 2002:a05:6512:1253:b0:545:93b:30c3 with SMTP id 2adb3069b0e04-549c38e361fmr293306e87.18.1741919281989;
        Thu, 13 Mar 2025 19:28:01 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a702asm378108e87.212.2025.03.13.19.28.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 19:28:00 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-549946c5346so1714648e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:28:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGlQqPjri+S6194cCCRSOzPA53FdI3ornVL/QN6hLf+yhi6Ip9q3IVgFLPzMgbB+FlLgj7WvEmDuiNquw=@vger.kernel.org
X-Received: by 2002:a05:6512:3b90:b0:549:c1e6:cbb9 with SMTP id
 2adb3069b0e04-549c38d07bemr214129e87.9.1741919280219; Thu, 13 Mar 2025
 19:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310104114.2608063-1-damon.ding@rock-chips.com> <20250310104114.2608063-7-damon.ding@rock-chips.com>
In-Reply-To: <20250310104114.2608063-7-damon.ding@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 13 Mar 2025 19:27:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V0Q5v6hcEFJqMfhCSQ80ki5SQRmrXvyeGCOQiFsXc28A@mail.gmail.com>
X-Gm-Features: AQ5f1Jpkp3eXwx7hKjmZ3N01Nrt914JFcQlKc2Ek2r-3Xhw1Wi6nZVzuUBUzhgE
Message-ID: <CAD=FV=V0Q5v6hcEFJqMfhCSQ80ki5SQRmrXvyeGCOQiFsXc28A@mail.gmail.com>
Subject: Re: [PATCH v8 06/13] drm/bridge: analogix_dp: Add support to get
 panel from the DP AUX bus
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, andy.yan@rock-chips.com, hjc@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, dmitry.baryshkov@linaro.org, 
	sebastian.reichel@collabora.com, cristian.ciocaltea@collabora.com, 
	boris.brezillon@collabora.com, l.stach@pengutronix.de, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 10, 2025 at 3:42=E2=80=AFAM Damon Ding <damon.ding@rock-chips.c=
om> wrote:
>
> The main modification is moving the DP AUX initialization from function
> analogix_dp_bind() to analogix_dp_probe(). In order to get the EDID of
> eDP panel during probing, it is also needed to advance PM operations to
> ensure that eDP controller and phy are prepared for AUX transmission.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>
> ---
>
> Changes in v4:
> - Use done_probing() to call drm_of_find_panel_or_bridge() and
>   component_add() when getting panel from the DP AUX bus
>
> Changes in v5:
> - Advance PM operations to make eDP AUX work well
>
> Changes in v6:
> - Use devm_pm_runtime_enable() instead of devm_add_action_or_reset()
> - Add a new function analogix_dp_remove() to ensure symmetry for PM
>   operations
>
> Changes in v7:
> - Fix the misspelling of word 'operations' in commit message
> - Remove the check related to CONFIG_PM
> - Remove the unnecessary call to pm_runtime_dont_use_autosuspend() if
>   devm_pm_runtime_enable() fails
> - Remove unnecessary function analogix_dp_remove()
> - Add new function analogix_dpaux_wait_hpd_asserted()
>
> Changes in v8:
> - Move the addition of the analogix_dpaux_wait_hpd_asserted() to the
>   other patch
> ---
>  .../drm/bridge/analogix/analogix_dp_core.c    | 20 ++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

