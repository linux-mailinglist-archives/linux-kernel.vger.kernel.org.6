Return-Path: <linux-kernel+bounces-274319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F57F947681
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FADE1C20F9B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFB514A633;
	Mon,  5 Aug 2024 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQlQitgg"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5025143C4B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844853; cv=none; b=ftSa4JQpRqCrFlvH8YgtZMR2R5qSc/NwxQLBBbTYbe3h2Ck6fGOdWTdkOIFg4J+0ZO/b1HagJ3nPalKQh3iH1sP3OGVEvGtLDghkhlNKwTVQ9AcHz093EG3yAz6ek7pcNoG8Xe2dfM5KjEB58FjhaW0SiRzNBWfAEisq4vcsak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844853; c=relaxed/simple;
	bh=V0XBLdWPsEfluunRhLptNbPEUeInLXsANcgHR2jT3fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVa1Lrua7suBOmXqLC9SCwHNLyyaCXX+qpPCqcBzVgZOSRV2grqUKgZ46ZvPeNAS2yQh0gvpri2FSCrlax2VUuRE3lwpTD+ZM9Rwl0dikcOPbfidN2B1/sc/c6uzrnGXYF32k9+HfnMm+ZZjLQxlSBOfK8D9ggTaCEmnorpWcjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQlQitgg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01993090so14135411e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722844850; x=1723449650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0XBLdWPsEfluunRhLptNbPEUeInLXsANcgHR2jT3fE=;
        b=vQlQitgg8MyKgVBqn9roFoJioZPR4FZHlPEt5jOkCrCLsZFYsHzr2F+mcKg40uk/3N
         jQnMlRLEqz0Xk13WAixEGKM99yaxYlZAlL4ArkB09FmUK95eFOJpGX0ygTVzU0PdYEH3
         tV8f5RGGqfjg1mx3GhyLN1QjJnO3AzH5jeCb49OZjTT6/H5ZUO3H8CsVyS18Zo/6Lwrn
         4sWCi23BsP1S1W/yM5jbhab8cWdkOK8KtxA1cLmxtMW07C9cf+jGfLkFIgWItQ9Z4nOd
         3wLjL9U0TAs3TKo4h5puEzo1xvGgczdYpbWczHjjwDS1FTSomYi0Ofwsp14V8UPnQRZ7
         tP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844850; x=1723449650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0XBLdWPsEfluunRhLptNbPEUeInLXsANcgHR2jT3fE=;
        b=czdcKRu4RgJxY2jzMOuhm0MeKSnPayxA4sJRT8KQNlYGuFHN33n6pc92yI6ZG691Vq
         O/nl621x4Yt/2gfD2T6tGgNg+aF/Jaev05UddPOXr0N5D+/DzJWLuKlGuK2KVIFdc8EU
         /CrLUL2K+pSB0oqVB27GAV0bSUx7Bo0UsIiut02FV7E2rM95+Z3quPOOL60MkyUC/QJC
         Tj40Qog8ez3Lj5PqxZCe/4HA3bAvDRoYHT9r9afpOv7TzZXxgaES/Vipn1wS/GG0DegX
         852PvAibQ+Ou2QjTDHRZEMxcEyO9Wfq9RXPGVfHsw6PnUlkAvlF25jLDUp25Y5LPVt3+
         Q9Gw==
X-Gm-Message-State: AOJu0YyJy6PXoD4DfJzzpafU8bjtb0dMA1c+wFZYtYr5orfljy8ZSjXx
	XClKTZyAK4QYfDVOeM0UlHT6t1Y7iVrCLtvJgf6KAhV+3YgA6mSNhwI1qQFqgelk3J/qlFbQqfb
	9e1+wWMKulnPs+InfMOQZIyxMiwFjfcCwholilQ==
X-Google-Smtp-Source: AGHT+IE4e1ypq3XkPGGxUNLRbeIjoKSdEBrPK+4BFko20jBg17ItwlycPxb12bAyuzMocKZw3XI+Eygzrzew8wFEJfQ=
X-Received: by 2002:a05:6512:ba7:b0:52c:9e82:a971 with SMTP id
 2adb3069b0e04-530bb36640fmr7509297e87.7.1722844849933; Mon, 05 Aug 2024
 01:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-supervise-drown-d5d3b303e7fd@wendy> <20240723-underage-wheat-7dd65c2158e7@wendy>
In-Reply-To: <20240723-underage-wheat-7dd65c2158e7@wendy>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 10:00:38 +0200
Message-ID: <CACRpkda-QEnywHSwMQDMtbP8-rZEbUZT58D+hvXVRdMkFu09wA@mail.gmail.com>
Subject: Re: [RFC v7 4/6] gpio: mpfs: add polarfire soc gpio support
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-kernel@vger.kernel.org, conor@kernel.org, 
	Marc Zyngier <maz@kernel.org>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, Lewis Hanly <lewis.hanly@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:28=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:

> From: Lewis Hanly <lewis.hanly@microchip.com>
>
> Add a driver to support the Polarfire SoC gpio controller
>
> Signed-off-by: Lewis Hanly <lewis.hanly@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

