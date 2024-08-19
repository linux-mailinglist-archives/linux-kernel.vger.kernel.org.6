Return-Path: <linux-kernel+bounces-292512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F826957056
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6FC1F21B60
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342171779A9;
	Mon, 19 Aug 2024 16:31:22 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF3176249;
	Mon, 19 Aug 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085081; cv=none; b=Y85yoiiFXcSFYEdymjfs1h+BpdCJavyfROiuZl/6rkWuAU6kmZ20Xmf40vl36eeM4cDxswlusDz0Y53eSkQowGReYro+bT5k2IVPazgw5eLaGBGYg5ixyIsVI44Au5Bytn011+r0qxdJZOzjbajdfriD9Ent8qiz86OSw2+/Ujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085081; c=relaxed/simple;
	bh=6BdvQ6T7K3CaZ2blSgGXz6eQG1eUROw0yaG/efO9nxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZeEO1iou1KooJdnztxBWn3WHTCMbDYwf3bCZmH8ylIDaxhzYm0xOZTMfcF3prsSgczxaNHqtGc0yI0ab1kNRaiUyrb0HKUCFhL71ZZzPfMjc4F/rnm/NFOeKsiymV69IU+7wHQfMw52yKT5BjZZk3Kd2owU4lD6s/LhTaTOOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5320d8155b4so6002649e87.3;
        Mon, 19 Aug 2024 09:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724085077; x=1724689877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1x2FXnkVymZ0+l/V5XpdI7vewTGjXzSX2+6VUE20Bi4=;
        b=vuJi9Au0qR0EidKq0B/pMiN+O4qX3yn4oxwV1x19zxQHYp49vs6G95MubJa8C6bvz8
         Sq2isLeoR4hlPjljiQ0uy6qvyj3bTsxBv1Vih69z9Z3KuZqrPRgblWwY/SU4F3ryFot6
         nhCfVvEzeU9UCQ5hf/c0uhysZQbyYuAMJXtKememgNGNVj9mrysxfyTWqjT5PDVz+QcM
         S+Ah6WrF3BNSVLpt/fPDyswfFPKmdrRMZ0WCT3RcWmsXNNTksw6Lvj1s/nHVwYneYrg8
         PvpFHaPHmvwYYi5atc3/7OFL7Ny500ViH7QzyW+54K9TQH+XLlrPGVTU8Mw8rR6tyZP5
         UckQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+INlv9veR5bhxT7SuRJOy9EZk3USystyp43XreTo3UEgPH/11ILKx8yDw1AkwwZgyN6VBVrEQEjHWJAn6dkCA9OIeD2h/XBxLaAMWckWXtP8dYkJpACJ9HfOBEjh1cmmjlbJ+5m4c3g==
X-Gm-Message-State: AOJu0YyIUT96yIMiQOPnpVTvXJb6eZvpeqZngl7sLIKE7b3LrADwwuJQ
	QodgQlH3MKVQZdEZSyxJQbC2iizv0wj7yIyoGsV7n+j032tg6sd2aOtnAIid
X-Google-Smtp-Source: AGHT+IFirvIVFxy9CspKt5UKFghvJ9daOnBinMub5ErUDQvw0qbKr0J7jV/QevPbaRolXPYQVs9lpQ==
X-Received: by 2002:a05:6512:ad0:b0:533:71f:3a68 with SMTP id 2adb3069b0e04-5331c6aca00mr8316267e87.23.1724085076144;
        Mon, 19 Aug 2024 09:31:16 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d3b9246sm1531159e87.88.2024.08.19.09.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:31:15 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f189a2a7f8so46243651fa.2;
        Mon, 19 Aug 2024 09:31:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/1i8/3mZFZASUYVC55NZ3wRyu/n60UQ81BNAvCiFfJzs6GF3lNQS8ZCN3jii8UQvvYalchxJEluhoISQEAMJzG/1j1rxFn+ekKshe7eTwjYd713EblNz4vtN7VyZ002wGC4cIvpBOhA==
X-Received: by 2002:a2e:9d97:0:b0:2f3:b8dc:7d24 with SMTP id
 38308e7fff4ca-2f3be59a2b5mr70558051fa.17.1724085074993; Mon, 19 Aug 2024
 09:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816001824.6028-1-andre.przywara@arm.com>
In-Reply-To: <20240816001824.6028-1-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 20 Aug 2024 00:31:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v66LeA5gV-WTn3_Hyfx2o83_46Z5nBoLV12D4SLUmy0DLw@mail.gmail.com>
Message-ID: <CAGb2v66LeA5gV-WTn3_Hyfx2o83_46Z5nBoLV12D4SLUmy0DLw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] regulator: Add AXP717 boost support
To: Andre Przywara <andre.przywara@arm.com>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Chris Morgan <macroalpha82@gmail.com>, John Watts <contact@jookia.org>, 
	Ryan Walklin <ryan@testtoast.com>, Philippe Simons <simons.philippe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 8:18=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> This is remainder of the AXP717 fix series, containing support for the
> boost regulator. This is meant to increase the battery voltage to the 5
> volts required to provide the USB VBUS power.
> It's the usual trinity of DT bindings patch (1/3), the MFD part
> describing the PMIC registers (2/3) and the final patch to model the
> regulator (3/3).
> Compared to v2, this drops the merged patches, and just retains the
> boost related parts. It also changes the internal name of the register
> to AXP717_MODULE_EN_CONTROL_2, since there is another control register
> we will need later for battery support.
>
> Please have a look and test!

Whole series is

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Not sure which tree this is going through, but since Lee already gave
acks, maybe we could have it all go through the regulator tree?

Thanks

> Cheers,
> Andre
>
> Changelog v2 .. v3:
> - drop already merged fix patches
> - rename control register name to make room for second control register
> - rebase on top of v6.11-rc3
> - add review tags
>
> Andre Przywara (3):
>   dt-bindings: mfd: x-powers,axp152: add boost regulator
>   mfd: axp20x: AXP717: Add support for boost regulator
>   regulator: axp20x: AXP717: Add boost regulator
>
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 2 +-
>  drivers/mfd/axp20x.c                                       | 2 ++
>  drivers/regulator/axp20x-regulator.c                       | 4 ++++
>  include/linux/mfd/axp20x.h                                 | 3 +++
>  4 files changed, 10 insertions(+), 1 deletion(-)
>
> --
> 2.39.4
>

