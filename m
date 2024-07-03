Return-Path: <linux-kernel+bounces-239494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A27169260E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C71B2791B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C0178CF5;
	Wed,  3 Jul 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUIWeMOF"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8A17334F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011079; cv=none; b=GDkJ/0X7et2XEcYQHDlf9tnbA+tEwov5XSv0GMCX/YiHrHTUzOfxpN6foln0qG/YcfNXrmrSi4yC+spKMoJGQdUhcGAhYpu62kket88D4hbzbm6FmjHOPOc7BEO8ahupJE0eHJnr2uE+tZR+k2JHwhJo3OXl7ba9ZqMbXfTrvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011079; c=relaxed/simple;
	bh=ZZVkBBnq2f3WMD6/iuDrxcJPNCrmNZnRew3n6wDwu7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6/QPKtQi7soy1YxJoGEr6ggua6sIkA6Gj4L72Vv7u40zonzSHyFkRJZf88bKqiSzkuhyZTr51bgg6hIVN4HxNrUnnfZIFjd8LJacR5YH9vkozjiVbf4G/XyZLRd3lwoeen4EA+192zCjHrEiFQNy2NTHxBYu8UW7fFX1P1hlqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tUIWeMOF; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e0365588ab8so4714842276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720011077; x=1720615877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZVkBBnq2f3WMD6/iuDrxcJPNCrmNZnRew3n6wDwu7s=;
        b=tUIWeMOFUIgmXLDzOrCdgsQmOerepX6Dnfxfqm9IsRir9pGt2R+Q3hgOIuiDj4SHuk
         djxH6Knc2tL4VhbRfYJAXQRGTS76g5zD9ILfTFEPOMLKY7gXaUz2C1FCE6A/no0EUwoH
         JdgIG273Z29Dw/Ves2Rrb+pbSLEfnyuHm7qoNXYkVCO2z43mztOEBq2rVlbtGAJ7quE9
         lCY/SC5UaUqxqOCrC0coJtjKmS8jH82kbLwr4p/TXrPjGXjNXHy+xSpeav2UfEKWKBXK
         YeSZrwSajAUa92BJAuspUq563N1GwW4Y1PGkuWYYGMVBMVh1hqUtAqlnKtvs5q8Cvd/G
         sDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720011077; x=1720615877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZVkBBnq2f3WMD6/iuDrxcJPNCrmNZnRew3n6wDwu7s=;
        b=tf3SQ2nBznPiAF/9YwXJ5ssvTCS55sSCHY9MNMNryR1RIG+CE9YMONRDVTrpDeyiSF
         R9prf5xKY7UUsUpIoLpp9e9YS5WIAsUGVi38fPX9h63A0EfyRh1426kmPxAT2YUspxjP
         7dhijwZiQzzQcqS2Cvi0coTFrwUuwv7x4NgnJN89zMWX9qsSI7lhmBgUPWXjU6fIVe30
         ZD1Fk2RTPjRNgCyVe29dqDsD794j3KKw3JH95F4u1KvaXywAg3Km3+P0B6GwQ1FGVLpv
         STY7WbdmotmKKuCmzE+4tbVNiYV1/pskIbyzpANh5aZ3UtM/CWC4vILJ7GtPNiEnm5rY
         ybbw==
X-Forwarded-Encrypted: i=1; AJvYcCUmdohw4ADNqo91VkHgbXfR2yF2jEpjAsaCCezaT2zCfXhv2TEv9JyOMCKZV/auELtemtKwBF6bZePLn2JZP4S+SYHckHoCux5H141r
X-Gm-Message-State: AOJu0YxsOYp/DzZklqrjnBMMqJhUG5g3UITHILCsYmz9wunmoPdiqyqL
	WaSt9iyMPxsn26inRhMF+rxw5szzkD+BswQLBlSWFWocVZ7o8eq74Tc2u43kpTUX/NX1tUrxW6v
	IqZ1oYWZ4YyKjDKSa1IaVynS05xefEqjHFbAwHMEMmZ4QvQIF
X-Google-Smtp-Source: AGHT+IECrd8bfdv0TCVTEGytAoZV0MmpC2JqwWFIdgBO3sCCPGjShflQOP9qVEN/9TFxAfVaWqkWmk0wLDZLlLAKfuA=
X-Received: by 2002:a25:d692:0:b0:dfe:4ab9:1cc1 with SMTP id
 3f1490d57ef6-e03712615e2mr10259122276.40.1720011076677; Wed, 03 Jul 2024
 05:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627150610.469645-1-nm@ti.com>
In-Reply-To: <20240627150610.469645-1-nm@ti.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 14:51:04 +0200
Message-ID: <CACRpkdaY4xK+yegDHjkUReRydc3oVLy00i73KDRasCwxkkpEGA@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: pinctrl: pinctrl-single: Fix
 pinctrl-single,gpio-range description
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 5:06=E2=80=AFPM Nishanth Menon <nm@ti.com> wrote:

> The binding is supposed to describe the properties of each element
> of the pinctrl-single,gpio-range array entry, however when we use
> "- items:" instead of "items:", it explicitly describes that there
> is just a single entry in the array.
>
> The pinctrl-single,gpio-range property should describe more than one
> entry in the array. Fix the typo and adjust the alignment of the
> description of the entries appropriately.
>
> Fixes: 677a62482bd6 ("dt-bindings: pinctrl: Update pinctrl-single to use =
yaml")
> Signed-off-by: Nishanth Menon <nm@ti.com>

Patch applied!

Yours,
Linus Walleij

