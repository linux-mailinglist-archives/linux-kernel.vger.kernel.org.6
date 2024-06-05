Return-Path: <linux-kernel+bounces-202157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0225F8FC870
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DFF283178
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC02219004E;
	Wed,  5 Jun 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b78bhk65"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472218FDBD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581485; cv=none; b=fyoLCfs3xLW1iH3t3384lMe3HHeDIpy0TyXDQPlHjIU3HatDZkcPlW7RrS3SzmQ2A1dQfZMo6YZboSu7CyVLYzQ9wXZcl8i+Y9D6aWclnezJG/Q+YqV6kXwC87+4UQY60f8TI+ySPPdAuE6klM/Ucqp8XOnFiKjhQXcZMLFO69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581485; c=relaxed/simple;
	bh=RQc4Y5JzCyPSexPf3Wi3TLrBGuonQNYkM259jWz7/zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IU28TxJYvdh5wN9M+dSIGS3gwnZCZK/M9eWUeUmzxJfrjfheUdPQiuVxGlQK1wx+0W/6+isoATVs8fQ5j9l92YS1DnRpzm1CInrMc5uk/Qa6MB2KrDxjpgB0+IIik9IAYDdyBMD1XkATem0wgu4hM4g0JvlxR4Zu677qMF6UX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b78bhk65; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62a088f80f6so6158737b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717581483; x=1718186283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5mAYD1Avt8pq2XcOOEM7xebLX9m2RKKIBoR9HWmP6lo=;
        b=b78bhk651qsOiAqBWWtYLgJE6cEi7LziBQvDru8GAH5ehAuqt8uz9dr0Ru+MwLWiRA
         cyNzA1TmHVCVP0joDMkVTHHa+crH80E0YDZlVMibNBCGynMRQtHxwqfyIc4g68b/q14O
         /amQO9VI2phVL35uwcLkgHsg4dJFOiTeA4T+O5lXWrYMEWYgn5Ipu8NfWJUew/RasbXR
         EVQ8AsY/vOx93PRaa0I/JVnCfqxmtyl+qf7GxMerO5jADOKxk9HXGEUjD3dxBidhxDhA
         2nKCkweikV4Mj7ICVCe6XYo/TYaR1o6sBjvZI3ZTPu4fW97yRphkUM++Y+J3ynfY8vxW
         iKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717581483; x=1718186283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mAYD1Avt8pq2XcOOEM7xebLX9m2RKKIBoR9HWmP6lo=;
        b=gjOpM4e9M9NL2rT9jZBsQGEFcNXu42+qjFOdDOWp6rL62SpTEcEEsqZn+GeZgfqr3u
         qVToMy2fhWb/keWTImsOfcFfvWx2+FnnYdf8DSvP6CMwP3XoanfkHCsJYzgSL9QmDdPd
         PwCENIofJXmutc1rLNP4sQS46KQfI03HL5u6B3iu6BIvkbv+JC4dEwodlr/Ivl2HDBWr
         tzCqN9oplVYVjPTy7uncSMYATuaovnWgOMEz4/dXd6xwEz8+qRXtjVU8SSP1wQZnMzQm
         lb0HoGCpRy9wDdNtzDaowoXiTIGbu8s85tTcA1HMqZiThP52ZK6IWqtzr+rC6HVa9h40
         TWSA==
X-Forwarded-Encrypted: i=1; AJvYcCVoYT1zO/kl/1JxXoV9kmP+dlcdnzOWSzmObjx+ZMHO5GAu2WoTghB4ahgCyfkcCW7YYj6Qxvj7RPHcNcGw8jISNSTB3gmZtgtW8y6K
X-Gm-Message-State: AOJu0Yx2PRAKaT1wWvbplaiECoNRlvx4RefFq4DyJphtmRyHfbpltUZp
	VzxuGNonkBdv5xvRfC5XDd0v/HdWM1mWDHXMuZKjAslba9oTU91XSAvRI5ApKImyTtraEApguJR
	dulLyv35/ZSmMy7zAmpvQt6PYViEZwlVMaPEx1A==
X-Google-Smtp-Source: AGHT+IF2R/aghDc5IVYeX1rVhBtT3A6VAsaeguTPhS6sYRA62wpiuZD2zzzvBra0tS6pu+Cqh5RE9zZsadl70OemW/g=
X-Received: by 2002:a25:b88:0:b0:de5:8427:d66f with SMTP id
 3f1490d57ef6-dfac96febfemr1772988276.4.1717581482636; Wed, 05 Jun 2024
 02:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
In-Reply-To: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Jun 2024 11:57:26 +0200
Message-ID: <CAPDyKFo-V4aNKWQn2r61_Q5d9R2Lhj8d5Ri_b-zW7VMsVBHARw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Power: A4: add power domain driver
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jianxin Pan <jianxin.pan@amlogic.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 May 2024 at 05:10, Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> Add power controller driver support for Amlogic A4 SoC.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Changes in v2:
> - dts: Move power-controller node to be a child of secure-monitor.
> - dts: Include power head file.
> - Link to v1: https://lore.kernel.org/r/20240528-a4_secpowerdomain-v1-0-2a9d7df9b128@amlogic.com
>
> ---
> Xianwei Zhao (3):
>       dt-bindings: power: add Amlogic A4 power domains
>       pmdomain: amlogic: Add support for A4 power domains controller
>       arm64: dts: amlogic: a4: add power domain controller node
>
>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  1 +
>  arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 10 ++++++++
>  drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 28 ++++++++++++++++++++++
>  include/dt-bindings/power/amlogic,a4-pwrc.h        | 21 ++++++++++++++++
>  4 files changed, 60 insertions(+)
> ---

Patch 1 and 2 applied for next, thanks!

Note that the DT patch (patch1) is also available on the immutable dt branch.

Kind regards
Uffe

