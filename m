Return-Path: <linux-kernel+bounces-407652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D54939C709A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A590283A70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF38F1EBA0A;
	Wed, 13 Nov 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aznUntei"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A646C1E377C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504510; cv=none; b=SDsFUIBMEdD+3vUTbxYHe98rIrH1kkOp/TmSDF8G7MWnIXMW9/lGiHaTMY7qIJNIAwPKDXdZgz4ChrKCBeRTF/ID/8haq+aa2gfoKqC+eZUuXfA8HuhU6IQc/Am+KVy0oSifxKrfp0/8MLcLe1zdASv4dMcb6/i/seL8XrxoTHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504510; c=relaxed/simple;
	bh=k1iJJsP4fxx81YgiXQugBdedKb3vFmcw2IIeFVVTfWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+dOTmHeNLIoOqnbGjJNpCb6p6bNLLqaDORBhJLVkUFzIutOE95/mV979SW8cfDimyR+5DeVF/9NbiS2Cr4f5JkRArXS1HnwE2vgvSRVOftFJTre+TyxZfPJgjK7qAF2LGnd+MEks8Ybf/wNse3dEt1dv2u40vxL6qB3uqFAfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aznUntei; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ff3232ee75so36226741fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731504507; x=1732109307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1iJJsP4fxx81YgiXQugBdedKb3vFmcw2IIeFVVTfWc=;
        b=aznUnteixRWDVvI6G7u+MzIzMmL7kvszPN1cd9mps46/4t5euFumMBh9pndD0vo6aB
         1mJO6Rdq0GqOFNN4jXvnsiBnd8dvBotC/oQ6b/4Rv6cmQkhXeqMzmf9l4J24wM+QYASq
         EMo44LvbVgTYIoF7I1FRXcamKXbrIKKE4kl8d0sFLNe+GF5ReXM9sGNBbXp03CU0aISn
         tiuPPWol2Jz/aCMRrU+REwwPSSHp/lglFjnMQP4r0RHdVBlYjR5tLoK1F5dP/7tw2ftP
         EVeQN69H/lBNMAsca91uABvBlrqDHdC8g1/tBeJfg0eYztYfgiDGPiwokol3w4QwWg6C
         tnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504507; x=1732109307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1iJJsP4fxx81YgiXQugBdedKb3vFmcw2IIeFVVTfWc=;
        b=JYy7sjtSZTaLM5YWL4jyK15f8x7MUu8GB15pWuufIOv+ceLFc2QBu5bkBzLFHfAag2
         dFyPHgz5C049EXn0Ae/YVJ0w3ybpdXJ1x3wB5bzWEmHqfiE7K+qdT798yzA/eAxFEjne
         zLX3aXdkJ7JewdxBKkmyxFBr5wy/32v8nPUzpXDxJbEmh4uX0NNZQMtRzYhSSyEcNtPP
         R49XimvgVkVsIdvuCzF3dYWk84WXe5psA47VBzXpM/Fg1EYEJLu3A0qMElM9tm1gTWro
         n4ZPENX56O0rs+boPX4UkZyL/Ko4PHBzWrNM0c884UR467yqGAHnfFsv27lg0uCPS4vY
         6DwA==
X-Forwarded-Encrypted: i=1; AJvYcCWUKguGihwLyDDKdpM0sF+10asQSEozr9kTojmIECMTKeKwMWqkbm+I5aJrapoYnYYcVRJns7+OsvXxbwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf8A4dh60czRKgJxOq6U2NCuqehdi/M9NOgJl6nWDPNg6b6U02
	JSFU/2uVCgUGwRxik67tzBP8Twf6kueKtTjMUN7A3wkiOzq30cZ459Bcnp+DU+76hSA3Mwsez1s
	5/wqMvlVSGnssB/UlQOc8sub7w9cXJNEYRvjDhw==
X-Google-Smtp-Source: AGHT+IEkgrAvnkTJ5cspkFy9GX1VNIhsj0Q/QVeiK2QhR4qOF90RwckXKqpwSLqoIaSOg2O9mBFnXHSu7X0RYkS3Jm8=
X-Received: by 2002:a2e:a542:0:b0:2fb:4994:b31a with SMTP id
 38308e7fff4ca-2ff20128504mr98330701fa.8.1731504506913; Wed, 13 Nov 2024
 05:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111085354.26576-1-ot_cathy.xu@mediatek.com>
In-Reply-To: <20241111085354.26576-1-ot_cathy.xu@mediatek.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Nov 2024 14:28:15 +0100
Message-ID: <CACRpkdaUYuNBANWyTcwbE2fS-STyGiV4hzOQ7rS=Q1cc2O5b6A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Add support for MT8196
To: ot907280 <ot_cathy.xu@mediatek.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	sean.wang@kernel.org, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Guodong Liu <guodong.liu@mediatek.corp-partner.google.com>, 
	Guodong Liu <guodong.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 9:54=E2=80=AFAM ot907280 <ot_cathy.xu@mediatek.com>=
 wrote:

> From: Guodong Liu <guodong.liu@mediatek.corp-partner.google.com>
>
> Add register address for each pin config.
> Add the function for each pin.
>
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> Cathy Xu <ot_cathy.xu@mediatek.com>

This looks fine, but there are no device tree bindings for mt8196?
What do you expect me to do here, I can't merge a device tree
based driver for a hardware without DT bindings.

Yours,
Linus Walleij

