Return-Path: <linux-kernel+bounces-427157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB68D9DFD5E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3977BB2375B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7824C1FAC45;
	Mon,  2 Dec 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tU4WLN5i"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D61FBCA1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132291; cv=none; b=GPuSuUQCa/CYDBZYWNQSincJPs8sJYV9K6cZzvXZLIyiv77iRgYUaQ1LrfEK1TkyElPcabjjl22+PBOuMKBqQU8p0ZzDlNmGYTwuDgXyOOQPxColBWeWiGbf0uH5sfh2ISjnkz27gWH0la7fdxgHkQepnA9o9HtskfOmq6Jy+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132291; c=relaxed/simple;
	bh=yZXt4gGnXIs0rJpdGc8dOa8lWJxV3khZ3QXqM5Uof28=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCjIpt7FksKLGHC88U+oH6RU909CXtUcFTds7ju2WQDzPGvt0Vgmsu18HE2xmmsZym/5dEXrb9r6z/JVBVVyuqzwwEpBfzSFsib2NyiQ5RlDJ8PNO77n/h76Y862siOirlBKEYmRbrtxm8x/ewpAMzgc/FEc7OLWdHXgo31LVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tU4WLN5i; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ea55c356caso2151050b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733132288; x=1733737088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTAHukQDOhRmCnoHVRWCZSaR6X9fYnJA+kiQMKbXQ6U=;
        b=tU4WLN5iwhlchTeL5cTiYP0OXJHPzQ7j+fhmcHOEfi04nNccOQuwKNZWgXSxwRvKqa
         YN9HaDDlbLPu/n7dWK5Si354kwpgSk7QzxjWGlydcTnyJ8yj43sBHYCp+5o3P3rCBh1z
         g+XxzzBc01wIwLbsRzkp8kUQHSwzK1zlpvQLtDYCCc1SOaglORX/6GLPUHFA8HugoMIt
         Nm/UHmKj47m7bILeMzrJGs9cGGxkbMpnb4Qhqq/qbpr3VpdNakdzZXLG/VUBPzJZ9h+p
         bLnWbXeQHHzQ+pWCUfTxep6FG6ql/NoQMvAe1oeWSFLFp6fbesLSuXWxnru5CDWKPyQE
         vDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132288; x=1733737088;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTAHukQDOhRmCnoHVRWCZSaR6X9fYnJA+kiQMKbXQ6U=;
        b=ucfJEsOJnzrqROFqbBqJF7rktfkDAd30NAppnNv009BE3PUbWPDdnuglrXeBtPSJyS
         CNa5sJO1nEzXAldo8IPcmGrwQ74uf28Njg9Uxe8SB+LRC06qyDh3AM/2VQv4Qs7Eahs/
         toFRBl0tyHpoP/eLyqiix5c7jAk08AL4F21aHbafFDozzTK4W6Sr5xaMGMVbWpDultVR
         u1yLB8rl7DJLTGf1p8Vggi1FeGKMMuRFbmFnUxSF2rgpbDz/FSynGg51jByxqFXsiFUB
         0EKW6vrH+BqyaBZ8GP8GXD//Vx77j5jqyi3YRdgSrgYEpPLHsQWH98qr8NqzOpYC7utG
         YnVA==
X-Forwarded-Encrypted: i=1; AJvYcCVisjFRZW38Uyh3st/YcrWFJEQtteWb9jh6htxk8Q424Jr6+zl1YUeyF2b7SZSaiUSbK3xxIvhr27gg2/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+KVdPNroim5KuSrC0OtL9mPtwogqsclcUwtnF3N1IUDpaKBu
	DxErRaEHslQaUfVrLwiARb0vndc/bAqMmxqP2C/Ha0Lm08yDKb+0qQLJhz0Mn3UxRaiQtMmyTH5
	u8aj7AOqwsF5jqzYv0/DhEI9nb6puS0AHexK2Mg==
X-Gm-Gg: ASbGnctJlFQ564FzH4ZGS9PzxYN/r/Fvke1FMHOnvUb7qykUPt6xW3328PnaJGRiBSv
	wZ28RdrRzOV9FAmdXNiQREK1XplRKyA==
X-Google-Smtp-Source: AGHT+IGFYBkRu+t9Rgm8uEYvRACv3R8GZFuyUPEoCQ2kFsszRxvWlytkFAb4tTArftXgRYmzaFXCGr9/hwxPw8QMZIA=
X-Received: by 2002:a05:6830:6d84:b0:71d:559d:de29 with SMTP id
 46e09a7af769-71d65cce8femr13291782a34.17.1733132288329; Mon, 02 Dec 2024
 01:38:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Dec 2024 03:38:07 -0600
From: Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.8.9
References: <20241128030940.25657-1-liankun.yang@mediatek.com>
In-Reply-To: <20241128030940.25657-1-liankun.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Dec 2024 03:38:07 -0600
Message-ID: <CABnWg9tDMkKkFbQpL8YphOBu3_2zr_q4YASnO-UYMrdM22wCuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/mediatek: Add return value check when reading DPCD
To: Liankun Yang <liankun.yang@mediatek.com>, chunkuang.hu@kernel.org, 
	p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	ck.hu@mediatek.com, dmitry.osipenko@collabora.com, rex-bc.chen@mediatek.com, 
	jitao.shi@mediatek.com, mac.shen@mediatek.com, peng.liu@mediatek.com, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 04:08, Liankun Yang <liankun.yang@mediatek.com> wrote:
>Returns the number of bytes transferred (1) on success.
>Check the return value to confirm that AUX communication is successful.
>
>Fixes: d9e6ea02fc3f ("drm/mediatek: dp: Add MT8195 External DisplayPort support")
>
>Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
>---
>Changes in V2:
>- Modify Fixes in Commit Message.
>Per suggestion from the previous thread:
>https://patchwork.kernel.org/project/linux-mediatek/patch/20240930092000.5385-1-liankun.yang@mediatek.com/
>---
> drivers/gpu/drm/mediatek/mtk_dp.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
>index 1cc916b16471..9dc68ec2ff43 100644
>--- a/drivers/gpu/drm/mediatek/mtk_dp.c
>+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
>@@ -2101,6 +2101,7 @@ static enum drm_connector_status mtk_dp_bdg_detect(struct drm_bridge *bridge)
> 	enum drm_connector_status ret = connector_status_disconnected;
> 	bool enabled = mtk_dp->enabled;
> 	u8 sink_count = 0;
>+	size_t value;
>
> 	if (!mtk_dp->train_info.cable_plugged_in)
> 		return ret;
>@@ -2115,7 +2116,12 @@ static enum drm_connector_status mtk_dp_bdg_detect(struct drm_bridge *bridge)
> 	 * function, we just need to check the HPD connection to check
> 	 * whether we connect to a sink device.
> 	 */
>-	drm_dp_dpcd_readb(&mtk_dp->aux, DP_SINK_COUNT, &sink_count);
>+	value = drm_dp_dpcd_readb(&mtk_dp->aux, DP_SINK_COUNT, &sink_count);
>+	if (value < 0) {
>+		drm_err(mtk_dp->drm_dev, "Failed to read DP Sink Count: %zd\n", value);
>+		return ret;
>+	}
>+
> 	if (DP_GET_SINK_COUNT(sink_count))
> 		ret = connector_status_connected;

Hi Liankun,

thx for your fix.
I think your patch could be improved by using the drm_dp_helper
function drm_dp_read_sink_count() ?

Thx,
Guillaume.

>
>--
>2.45.2

