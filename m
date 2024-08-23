Return-Path: <linux-kernel+bounces-299280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAC495D24A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1A51C21CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5571898E6;
	Fri, 23 Aug 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSoFFUWZ"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469201C680
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428948; cv=none; b=YjIRyjPBHD0GNDi8Dir23lha9fnyPC0fqQE7Eru1YA5zgPFz5L4Y/hHX2tPZMHL90dfbxS0HRf8199VHHgHd6jmr9aYUuEwW2V3bkcz/qIvLoFgcSSbRR+QiqF7Uu3U5DfwN1bXgd8z5dCQnJsjTFNOwsJDwLWsnaPje78Vp3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428948; c=relaxed/simple;
	bh=d/qAONad33R0jZNDEjz+rr+CKv6vN/+BTiZ2PyG+I5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ7h+/QMBjHKjiIW5ijq28CfwbZBfLeTl86gMngL5ojp+NshsC4f1oI2BR+2BcAbptgovctiQ/TulXWGVJf+ETx4DD5pYTlX3jbcbBTntTP7FbFQtXpXrdhipWfsRVTWi4izdk2zIUWL//Kw4zJw6ZZTS8aqx80Ln8/aBv9whS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xSoFFUWZ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso24504621fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724428945; x=1725033745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+byIGe4g18ARlIGzsWCBhessTlbszeK6bqUvyBPezWg=;
        b=xSoFFUWZuRg5/1cu/BXWg8hPzasdO3dO3eM3+DS/oBzVLp9/uzG1twKLqt6c8Nu+eY
         2+i/8YR8QmBl32L5k/B3YYXTnJ2pWfVs5wuRUNy/509E2OCKrYAW1kd4OowNkpQlVFF9
         oRWaYbPHsBp09hOMelV0Gd/JPk7uPc/dxDyePpAs/ClmIeY7QljU2hxkURGD0ge6bfBw
         qgohEcREqxomjreW+tCvYELEcnb1SLD7FwoxCi+sSt+fpxLuGX3Frco9bQ75rSmn5tSx
         EL/XaNmjoEptSK27S6sxdMZOZ03IqE0UmRZs3yCZ/2T7rYAG/uZSNufhmb+g27s03r43
         INcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428945; x=1725033745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+byIGe4g18ARlIGzsWCBhessTlbszeK6bqUvyBPezWg=;
        b=bio8h9TGIp30HTDCkG3gL85UlLkTedRSbGoz/FdA0jqRoRXTKXWlF/Cx5twRGtxT0A
         bGRyia/QrPX/8eqyaGXIeZf7Stj4Jh64OOHYMgOpRAYSZLsJMd6FtnTnIOKx4BzpEsf6
         aGiOi0zZnzmgeOs7Dm0tHYI5NqGb7g+yxoq2SzAprwbfxSlAjb3aqX2bmSI5y1zWDpq4
         noDJtgw3a6D2tafnufVf0oo8e/FxqheV46FexL2d+fiwIzF2NVB6NQ93mtH1sevoqGIX
         iXTtVBKFr4S7kK9EYR+3xwNVeRHKYLIzoE7q6pnf1M+fwWiZZxfXPjaEGFTwkDxQmcSv
         ENlA==
X-Forwarded-Encrypted: i=1; AJvYcCXgZ3qnMUzNSZoegXPLJQCBdcfEVmBKmRdukHGfypXanCYNAqtUUTUyUsaRANm23JR9Ouwd0UJsHq/cwYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdozP7FeeuQbOsREox+YO2cum6TGGGc6X6A/ecSrI7zVN5ovcz
	63ybHW8GLq0uyUC8N5rWjaVPzligoQBsaMRESErJM95Rygf7XDge2n1YkCHRtAs3XLKSNr13fY7
	8XRi2jiBETrr2fkILQ0JJAi1Dg+s2TZwn1G3Waw==
X-Google-Smtp-Source: AGHT+IEbEoxnoSIsIcOXGYvvsido0gU280o9EgFhYynNtmAq+4AgzMA3KAh37jKek70/MtZreE52cxmgz9LwgewK5p8=
X-Received: by 2002:a05:6512:e9d:b0:533:47ca:974f with SMTP id
 2adb3069b0e04-5343883a0e6mr1568421e87.27.1724428944837; Fri, 23 Aug 2024
 09:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f74e326bd7d48003c06219545bad7c2ef1a84bf8.1723053850.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f74e326bd7d48003c06219545bad7c2ef1a84bf8.1723053850.git.christophe.jaillet@wanadoo.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 18:02:14 +0200
Message-ID: <CACRpkdYUaqtqQ7mggRu6BFTs9cP-jsvqFhHv939jGSjZ4F6MCA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: meson: Constify some structures
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:05=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> The following structures are not modified in these drivers.
>   - struct meson_bank
>   - struct meson_pmx_bank
>   - struct meson_pmx_func
>   - struct meson_pmx_group
>   - struct meson_pinctrl_data
>   - struct meson_axg_pmx_data
>
> Constifying these structures moves some data to a read-only section, so
> increase overall security.

Patch applied.

Yours,
Linus Walleij

