Return-Path: <linux-kernel+bounces-384973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4275D9B30DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDE8FB21CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB41D95AB;
	Mon, 28 Oct 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wEz30wdN"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453131E519
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119668; cv=none; b=VPt800l/Ww0VM0iCD4jdzixvrAfKhT+R2PG3A9ao+C9is8fJRXr8ox8ff5QOaYMi/i4D7jx6eTa6qyLtyd9hw7sifzJ9K0UkogwZaBa35RG7cLxV1ugqMr1flx/UnauPX5O2hVCWz7HfTrx1B7Ok2IjHBPB7U44N1Zva/R0T8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119668; c=relaxed/simple;
	bh=RAxHdK7Nc18OMO867UdF4uPbQ9YU7Xhpufz5sijgR1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbLPIWlQpGE6ZrP6JTK2sWnYxeaj+e+kaexv2+ElBps1IQWrUJ5QjaETm5+6pftTMf82cdxUDoMa+57d6+z02cEyhajIf2OKLWIgrKc0+8HUpSFnWiuoZdQQDcMeaBYycDARqMk+v4455OGakMic1vsjy/1ywqth5lKVqyYG0FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wEz30wdN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb443746b8so39226141fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730119664; x=1730724464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAxHdK7Nc18OMO867UdF4uPbQ9YU7Xhpufz5sijgR1M=;
        b=wEz30wdNMy85/v68A9aE16UoNK3ajfbitshxP6yvRPdI15y0Tm2888gzZ80AxO2NHw
         93zOHHkxVp86zG/UVyblSQjakFmf2lEuup8jv8X+HB92SrQtfZpeBLxWZGdwaoTm5Xm9
         SHddXfUaI9tymrNzkP5O0KjYjNhjdmq9tLijeEylr2DZ2xa4DWOg7jwnQah+zdQB3Vab
         ibw6lUC4Ru61+dN9U77dYV6P4yo/MjJyRVuWRlcDy9gN17yxGMbhVagzI7AEN5tsf2TU
         pGZfiLt8c71l15Ms3PCBKJ7DtTYTkywE6fbzYXfURrfJ2wIGvOlWXte6AhiF1LSqTVT1
         /FOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119664; x=1730724464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAxHdK7Nc18OMO867UdF4uPbQ9YU7Xhpufz5sijgR1M=;
        b=JRdonvDsTfjAu/yhlLnOERTI1XHzio6+4IIKBu5l2+X9nsV8QGjqLIM0xjRf3WVulH
         bRIKpLDxO4cS/v2APLFzFOc++xSzGoy+l76+ERq/c7nDmDfv2Assn2WTCxTaTNSKzXCK
         9PXNUrCR8EfKnz8xY0WD/SJwTk0kzHb33U5umZb9iwUGH3Ul7x/icpAtIu9KDgexgyua
         wvyjmvWnnVfFmSOKTxXODEX80KPeLWPlgxgMc+5b53dy5JewxEWCsQqjzHzKdBR+FvkY
         JkWEsb2bm0IedqyHVWNTO/3sOol3hO64xOQ6defpl0x1poODt6HqKCGGhuvYZcLzIo6f
         n+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPgv0cWJVxyiCGd6A3alLeREhPPdfsee+2EspkyLsjXsWHkjRUgDm8Ripyqb/2E0hN7vt5GrysmaDdHXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2oqt+yxVWE0BOKS/DkBy3G7id/fCF4LGxPRsjrlTxQc7hKHVK
	1lpN6d/LH9Xd5On73PjfvSGOtewy5Yn48YJqq1GAJxAZIAsmHoB+/m+DJc1oUyLK6IrEQ46jFAR
	clPzuPGwk6rUXD1TgwFBYEAkTqqASZdcJhk8sxQ==
X-Google-Smtp-Source: AGHT+IGmcTiIlNRg9bE3mhHjf1euDiK5RVv2I8rfuort+Uj/jsAnk0dYe87dqLP1FyJnvDejhjUGho1fBoV/SrdQy8k=
X-Received: by 2002:a2e:be20:0:b0:2fb:3a12:a582 with SMTP id
 38308e7fff4ca-2fcbe004c83mr29806141fa.23.1730119664333; Mon, 28 Oct 2024
 05:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730070570.git.jahau@rocketmail.com> <1491f275e9956b2da1f1e2580abd54f4e459c7d2.1730070570.git.jahau@rocketmail.com>
In-Reply-To: <1491f275e9956b2da1f1e2580abd54f4e459c7d2.1730070570.git.jahau@rocketmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 13:47:33 +0100
Message-ID: <CACRpkdY-5G0uui1xKnKFbxVs6couGUy14CH+KrHH=j5LfDsb_g@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drm/panel: samsung-s6e88a0-ams427ap24: Add flip option
To: Jakob Hauser <jahau@rocketmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 12:42=E2=80=AFAM Jakob Hauser <jahau@rocketmail.com=
> wrote:

> The way of implementing a flip option follows the existing
> panel-samsung-s6e8aa0.c [1][2][3].
>
> The value to flip the screen is taken from a downstream kernel file of
> a similar but older panel [4]. The mipi clock [5] for the new panel
> samsung-s6e88a0-ams427ap24 matches 461 MHz and a hardware read-out of the
> 0xcb values corresponds to revision R01 of that older panel [6]. Although
> for samsung-s6e88a0-ams427ap24 that's in non-flipped state while in this
> older driver it seems to be the other way around. Further up there is a
> hint [7] basically saying for revision R01 to change the first word of th=
e
> 0xcb command from 0x06 to 0x0e, which is actually setting BIT(3) of that
> word. This causes a horizontal flip.
>
> [1] https://github.com/torvalds/linux/blob/v6.11/drivers/gpu/drm/panel/pa=
nel-samsung-s6e8aa0.c#L103
> [2] https://github.com/torvalds/linux/blob/v6.11/drivers/gpu/drm/panel/pa=
nel-samsung-s6e8aa0.c#L207-L211
> [3] https://github.com/torvalds/linux/blob/v6.11/drivers/gpu/drm/panel/pa=
nel-samsung-s6e8aa0.c#L954-L974
> [4] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/bl=
ob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c
> [5] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/bl=
ob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c#L20=
27-L2028
> [6] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/bl=
ob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c#L13=
7-L151
> [7] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/bl=
ob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c#L66=
-L74
>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

