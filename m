Return-Path: <linux-kernel+bounces-281829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7841394DBCF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 11:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED441F21B43
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A85F1514DC;
	Sat, 10 Aug 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PkqP6B2u"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C411509AE
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723280994; cv=none; b=FdqwUmCuTUQmhAVWvD6g/33ocM9KdsSj+Ot8BX7MNfhXcsTdAadiRqtV968pg64Vsunnc/TZBI/Hm+gxgYfzpQc52paU/0WVnH95niQU+MdBsCSkiie2/1tLQ4NaF0aYaMSOhxO86dsaqxe9TFawfGwYH178FoW4CEq3a7QbZLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723280994; c=relaxed/simple;
	bh=ijZdhBQqDvhovgCbjsCyXpmc7K8XxUC2xgSZq+llBjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyyVYKk5MqEpGIsFJIvMRtAC2emXL3WOaFeP/HKBiRu/UzA2Xr8adjm6Gt1JrDJ4SaH6KAlc2c8CoG3pN7blIhLDlD+DVYUYezuJ35SpcpTbGcjioTDAs/79V4V2bB5nv6QNLt3CZ2nYcI6uzAVL4LwYZ1eMtkp7tSGBeBjHHTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=PkqP6B2u; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd69e44596so20024555ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723280992; x=1723885792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIhiNkZ8ivhgmM1Cc6VYiyybqghiNsm+0JIy+oF46uI=;
        b=PkqP6B2uAg1ADfIqaofHBy079SbTPTrTfoHY9C56pgW5t51BBWspBm91+5o1V3OTV0
         9hPNsac56iOojbUaff38zK9Ca6Br1jKE3g1Q59k/E+yGJJYgzrMjTqXCPrflxc4T/TkY
         YfbLaz256XUIyJqIdhOa+EQRDYlDhhGH5oR0Bl4YJg6pWEKFcabKNn+h2gNT87eP3nJJ
         IhmVHuvtzV4/+f75OWzqU4IWG4OP6/ikDNpkqvl236NuDZ2lhRt2o1vjD74BoWHvRRHE
         ihftS29u0JPBb6es4YfOnmdCzaRcuJ68qXWNq61vzQPlHvqGvfb3gHgvPg9pHdvWZgST
         /v8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723280992; x=1723885792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIhiNkZ8ivhgmM1Cc6VYiyybqghiNsm+0JIy+oF46uI=;
        b=hDRE2klrLqhFXuC2lWzFLr/ePrLrG+hmAuA7L/c9zvNLShyBDTAYoOvgmvVqah98eJ
         woOXSHbF4n9nP+oSviU4cXcVaoms67HueM6VPixkhPE4rObzN58zR3wty7cRv2DRleb9
         OFoMoEaFjs/XzqD7YfjNLAV4qh7oFvxm/aVWyeDKYrnOKCRoZNv+KizVOnmN3u1yC5SG
         0/ugw5VXEYnxHzKVWGJx4QSrkNUATpi/VPolu/lrC3drgvgYrZ1rl4gSxKWDSg40y+Pl
         2jfRf01yVlhTbbZTRlnJ0ioGCYAINYmr60WHQZVc+IIzJmV2j7Rfh5gz1IuwtBWiY0Z+
         F2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXFkiklQJ/esxLNzBpT+rPnpohzL+AuCAQG9hBs2uSW8ZEgr/oQuG2juaCQawIOcm3rCmB534K8BO5bju38Ry0sfY30k+X4Ds1eBQfw
X-Gm-Message-State: AOJu0YxQNqe2POJYNtoIXiFi5yfApZD1Aw+oX3J8nBHSwEnNU9gXfjVb
	iNZ36ijKbYWUZwl9y+U64Zxucha1DfALWb1m4KMD3T8q4Os4vBij8xuKwPm3nLOPGZsvKqFD9ic
	tT2iFj7tIhaa37iWUi5wcPXp1RaE=
X-Google-Smtp-Source: AGHT+IF0omZAMZcq00ACjBVeu35rKGSbTQfOx1gz2tQVmuRuPcEz5qrubbYp8kV3RZnFuDT5aznCRbdgeLj6EanoUrE=
X-Received: by 2002:a17:902:d482:b0:200:97b5:dc3f with SMTP id
 d9443c01a7336-200ae5d86afmr58455285ad.21.1723280992065; Sat, 10 Aug 2024
 02:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809124725.17956-1-abelova@astralinux.ru>
In-Reply-To: <20240809124725.17956-1-abelova@astralinux.ru>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 10 Aug 2024 11:09:40 +0200
Message-ID: <CAFBinCATiUnR=P9VRBxWeQhf49k6PVxK+nU95G7w94f-mR2HWQ@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: add check to prevent dereference of NULL
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Anastasia,

Thank you for working on this!

On Fri, Aug 9, 2024 at 2:48=E2=80=AFPM Anastasia Belova <abelova@astralinux=
.ru> wrote:
[...]
> @@ -373,9 +373,11 @@ static int meson_drv_bind_master(struct device *dev,=
 bool has_components)
>  free_drm:
>         drm_dev_put(drm);
>
> -       meson_encoder_dsi_remove(priv);
> -       meson_encoder_hdmi_remove(priv);
> -       meson_encoder_cvbs_remove(priv);
> +       if (priv) {
> +               meson_encoder_dsi_remove(priv);
> +               meson_encoder_hdmi_remove(priv);
> +               meson_encoder_cvbs_remove(priv);
> +       }
This is the straight-forward approach.

There's been conversions from non-devm_ functions to their devm_*
counterparts in the past in various subsystems.
I just found that there's a devm_drm_dev_alloc() which seems to be
calling drm_dev_put() automatically - but I have never used it myself
before.
As an alternative to your suggested approach: could you please look
into whether devm_drm_dev_alloc() is a suitable replacement (if not:
just explain why - then this patch is good to be merged)?


Thank you!
Martin

