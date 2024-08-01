Return-Path: <linux-kernel+bounces-271134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32279449F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F551C251B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4882B189534;
	Thu,  1 Aug 2024 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xwmMacpC"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC70A18952E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510116; cv=none; b=RHpxkpJckiru+jkZl8KSuKH1MU3oEWDHYBgZPZlP2GPILKNsGMnjh3WverNcnFpZF/znMMK2fyv6WHFqko6C78YRYrRMnws69jeAxlzCAAFqHUC+Y+HPyeXTsr8B44qTZjbrBM7BNJNGCfImWRrYHP06P7gHfUfk4iqyg/FOYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510116; c=relaxed/simple;
	bh=PDTx8zjwXbXzbNWfOuMH0iA/PcBbphotz7ExTZjHXjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HS3xvDsNEDogpNA8zb2ktMyCH7N2KXXtwMmRm5jkJReIReEFKEUUCvuDxEvBiPdunhYDxAF14rSvilAEeDqx1YVNNpUH10ZoDxV/DaTm5ySo3ZTgvoZLOepaNuVDHLL5Yzs4qywPaEiM58sb1YkJy/roKlqb9EEddGHRz6qOKtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xwmMacpC; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e05f913e382so5183641276.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510114; x=1723114914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xf663Oxqn+Hg/bp3CbFPSIMYObW/RVLrZF4k/w+9/Rc=;
        b=xwmMacpCpRTKt9lDC4rBFs3WZ+qNGsRqxxnz+5c/cHCcZ7XvODk3qZVe/TGJ0MXmrM
         b8LW4Yed4BuQVU/OQ+O22BAZ5AM5Qz4MkmR3qmUUqUqQ7H5ogYtz6MLfXCNq2h4b/LD5
         /RDyEGQah+8Pt/TLw6DoWKLudCkQghjhae7yX7/8mzcWYXVDKcvNvx55emyEladT8ifp
         G+TpEE7qT5UXzjUbQZLQyj5G56IVtc8pru5vcdnco5rsbz8qkR3J4a0RanocBc+l4y6a
         toh4YymmyYkuWZi+kr9EX3fH/DOkE9Z+Re6KPbgavd3gHH7j64I09xZlU1S0I5WEakYT
         g/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510114; x=1723114914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xf663Oxqn+Hg/bp3CbFPSIMYObW/RVLrZF4k/w+9/Rc=;
        b=jwgvOfXO8a7Ieymc6/cJRa38/8tVtVx2moKEkqfbvIEnC23UnBPwoAOGvbWNghsoeG
         HggmcR2BumBqnavZdkL+oxui6nXi+ZAt834E5zsXSi+zR5nfBKuxROk61aWm11Q376WV
         wCAVpaYV1n3RrLkQf6bfrjnzaRJFV+uEbLkLCr1+Y5OZvEDDoTT2btDdssP/0lCF7h6m
         SJbiNv0lI5Fi/268dPu6Z0fTguwwVBvLem2zICKGeHVIHFbpWS9ddchfHGELmICrU9v1
         zm++RQdIooXnxZhHmqBnzmrPewPDM6tiXcucVRbn6i5QFFa+Dt+tgz/rwtlfeV3GiGM2
         Zh1A==
X-Forwarded-Encrypted: i=1; AJvYcCX9R0etDi7qR2Vagwg/b0tGyDWfPgTWSdZFzZRmxpFpCtueQJcSSxsq8vDPinI673+kVb9b9ZUI8dgDBhQ4UWmZUhS0KY02s+YQxPlF
X-Gm-Message-State: AOJu0YyWyTenkSckMnKp+BdsflXO1MWVcKi2wxtBES+eoQl0ssjOoiRH
	tGj/Roh3Ljk+Bu/AsQBKX9hlLgeulWO+n1VXO6+ZW0SG0YZ69CFFMlw96SFDdbOVHlWJRBjF+oK
	9iLgZHPfCtitpM3ceLxjFGqxyJ66ZctbOzPRQ/w==
X-Google-Smtp-Source: AGHT+IGz8BY1lj9zv3tlXj5dYR89gFHb8pzgw3f8o7RUzA9kEaL9W7hkxl5EaciVMR7U8IJTC1gV5bcO0wGy86mIQic=
X-Received: by 2002:a05:6902:110d:b0:e0b:bc96:550 with SMTP id
 3f1490d57ef6-e0bcd25c795mr2527077276.23.1722510113989; Thu, 01 Aug 2024
 04:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724182119.652080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240724182119.652080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Aug 2024 13:01:18 +0200
Message-ID: <CAPDyKFpP7VkXNJZ_uYpnO8=bH9k0P0qq-JVBfYRC3QmsM=ia1g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add SD/MMC support for Renesas RZ/V2H(P) SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 20:22, Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Hi All,
>
> This patch series aims to add SD/MMC support for Renesas RZ/V2H(P) SoC.
>
> v4->v5
> - Since the SDxIOVS and SDxPWEN pins can always be used as GPIO pins on
>   the RZ/V2H(P) SoC dropped adding regulator support.
>
> v3->v4
> - Dropped 'renesas,sdhi-use-internal-regulator' property
> - Defined vqmmc-regulator in top level
> - For special handling of internal regulator now using of_device_is_available()
> - Fixed comments from Claudiu
> - Rebased patch on top of https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240626085015.32171-2-wsa+renesas@sang-engineering.com/
>
> v2->v3
> - Renamed vqmmc-r9a09g057-regulator object to vqmmc-regulator
> - Added regulator-compatible property for vqmmc-regulator
> - Added 'renesas,sdhi-use-internal-regulator' DT property
> - Included RB tags for patch 2/3
> - Moved regulator info to renesas_sdhi_of_data instead of quirks
> - Added support to configure the init state of regulator
> - Added function pointers to configure regulator
> - Added REGULATOR_CHANGE_VOLTAGE mask
>
> v1->v2
> - Dropped regulator core API changes
> - Updated DT binding
> - Now controlling PWEN bit via regulator api
>
> v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240605074936.578687-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (3):
>   dt-bindings: mmc: renesas,sdhi: Document RZ/V2H(P) support
>   mmc: tmio: Use MMC core APIs to control the vqmmc regulator
>   mmc: renesas_sdhi: Add RZ/V2H(P) compatible string
>
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 2 ++
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c           | 1 +
>  drivers/mmc/host/tmio_mmc_core.c                        | 7 +++----
>  3 files changed, 6 insertions(+), 4 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe

