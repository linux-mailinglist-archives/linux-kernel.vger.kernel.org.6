Return-Path: <linux-kernel+bounces-220855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0996190E835
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7BA1F22202
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C82082866;
	Wed, 19 Jun 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AQzOgtHP"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784B40879
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792365; cv=none; b=nm0bU3AjJHSileR2EBIzowRZPQ4VFaD3GvJZbyVIc8HWmC/AF3+d4h0/r3ZMjCyJWmNxOkdgbth7OOOZsbfc+qeAlYKNYpxov9f2VGQd40Jkho/8PaI8YgFr0/xDBX8vJ9FWHFWxuuuW5bWGzLOY8c1xG37tNHH0asBQxxByZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792365; c=relaxed/simple;
	bh=MbUeaa2LZLaNTE5kZ2SLNoA2hdABUPU/FjsRj6mUvFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjwiiBGmLZ3kIe3A6Xlza8IaacmFhgY2LAbmDiAAAKWqWOvnmFr7zS9I4eM/82kVKUHyAjVizq4KPG04J+3hlqBTtAC7ebNec9hDSYxrIIVXdVF67EkLFkF0H7s3D/nYx1emitYkNxkXCNtwARkw0LPEPIz8j+GARyH7YLPzyJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AQzOgtHP; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f9923df5dbso3615716a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718792363; x=1719397163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE8h2jNNZ6vFW2z7uotyBC53nGYQN5vB31WOkuARonw=;
        b=AQzOgtHPRluMjBQdG0F4m8pZZqU4fhb/bYy2NyLcUDm8iJgjByu7CSCxb3fBKbXrwT
         utoeFE129X5JJ4t4FO10RDaFCB/1A5BsAtiVp7PBH2lB2/LXm+MTYv9TIHb5dXX2o2sp
         mBO4q32IlwjOad4dnGDdt/HokKPEXCXcyc9Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718792363; x=1719397163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE8h2jNNZ6vFW2z7uotyBC53nGYQN5vB31WOkuARonw=;
        b=ihw/0w2kco+/Gfry7EoB5QqF/zkLfO8wIxQBBlioPS6j3LsrZXfYLIBLbiEn+TcWgn
         MMtgZmXPbUsefPOw3MId2DpShuZdYTcxc4qLHr197lKRO1J2mipSgObv1bH6pPoJbyuX
         bVlm1kG5HTexFgbXpJWdIQynKv6s7tBYLRbHBTZ2ohXOx/0N6njs0qZpD3OivtlPHi1Y
         N8bm2uECC+PPrT5728Ft8HT+86co4qZsSaqLd204zJaHum9FOLH/rD6JohE6kLYxHfgw
         EUoqc/w7OaBBAD9ii7TuNnR5vk9k9IC1KGzNS2pC0hcBxE3P9iUak0mX+5t4CrnemmCx
         uTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlPGzKjGMiC85RgoGLA9/XgxtXTMxp7ljI8F6mT30H9Vakq9v5NNP6FsXbR2BI2f5naAnRf622YcfqaQUj4EIqYeMGCDSpAjMO0aW5
X-Gm-Message-State: AOJu0YyWRQmmgf1G1QHQVbLDyAoNKcTv6kbqRKobll5bb39E/DB6QblU
	6p0WxZGWGjnT341+GGpXsZ040EJIFjuxVOug+PfIIHnF+hzote/hJ5S61wd4uSqqCOajTGvO4Fw
	=
X-Google-Smtp-Source: AGHT+IGMtzBYauL+ikNQE3HoFJcNa20r99mJ2YAGRD64FTwPdgM6oelv91TKueP+bc+Mm4gM1cQ+2w==
X-Received: by 2002:a9d:7409:0:b0:6fc:15e9:c3ed with SMTP id 46e09a7af769-7007549908dmr2737381a34.18.1718792363131;
        Wed, 19 Jun 2024 03:19:23 -0700 (PDT)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b14f5sm2162043a34.26.2024.06.19.03.19.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 03:19:22 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5bae81effd1so3366976eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:19:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXRgPMRkZei98Udt4WZrQDiZgnTBnL+umAVVKJUkgW09w4/eS53AJxkWX8Utb5NG4P9FNP5haEyn8XhBoqXNVlVdn9oBaoKY0PxmBJ
X-Received: by 2002:a05:6122:250e:b0:4d3:45a2:ae53 with SMTP id
 71dfb90a1353d-4ef27845548mr2420871e0c.16.1718792011586; Wed, 19 Jun 2024
 03:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com> <20240322092845.381313-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240322092845.381313-5-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 19 Jun 2024 18:12:55 +0800
X-Gmail-Original-Message-ID: <CAC=S1niC5ZePFFbEM6Fhr4q7kNqv45uSQNnTp1U8pesfe5f_Aw@mail.gmail.com>
Message-ID: <CAC=S1niC5ZePFFbEM6Fhr4q7kNqv45uSQNnTp1U8pesfe5f_Aw@mail.gmail.com>
Subject: Re: [PATCH 4/4] media: platform: mtk-mdp3: Add support for MT8188
 MDP3 components
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, amergnat@baylibre.com, moudy.ho@mediatek.com, 
	hverkuil-cisco@xs4all.nl, sebastian.fricke@collabora.com, 
	u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

On Fri, Mar 22, 2024 at 5:29=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> MT8195 and MT8188 share a similar MDP3 macro-block, with minor
> differences - as in, the latter supports a subset of the number
> of components supported by the former, but are otherwise handled
> in the same way.
>
> Add driver data for MT8188, reusing the already present MT8195
> data where possible.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../platform/mediatek/mdp3/mdp_cfg_data.c     | 280 ++++++++++++++++++
>  .../platform/mediatek/mdp3/mtk-img-ipi.h      |   1 +
>  .../platform/mediatek/mdp3/mtk-mdp3-cfg.h     |   1 +
>  .../platform/mediatek/mdp3/mtk-mdp3-core.c    |   3 +
>  4 files changed, 285 insertions(+)

Reviewed-by: Fei Shao <fshao@chromium.org>

Regards,
Fei

