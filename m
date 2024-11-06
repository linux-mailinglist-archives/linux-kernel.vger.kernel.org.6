Return-Path: <linux-kernel+bounces-397674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C3C9BDEE0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24530283B22
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595917A924;
	Wed,  6 Nov 2024 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hljFpBP/"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC8191F8F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874691; cv=none; b=pn7uMPLO/DZiS4bL4opqlOLjMUiXP/ccLbZQ70f400NkEiOh8wRYOEFyo6yRbUD9uqws6A/y6Dlo8TfURsF754m4fd5S8zc7Rk2iHNkeWvRs9CeiEtSEzNIxwPs3jyS2MGsZJNu8yEdLmns+nxVnW9KpSEFojm1GEQh54f0L3nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874691; c=relaxed/simple;
	bh=sE9pBy95toFx4muSE0fET583MXc33k6vo6rGPz322Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5hwkq5VGNceDtYkvV9iZ25TllIe0imo5Ncjvyh48OjKOLzZ9zlxj75rwXulOtwjamTMO9YUzNIQNzYgryhDQWi6vBG6uBPY7SWQWurZD25T6X5WV6W4v9RGSEyQKTjoEmAZ3tVNLXFUzvq2JtlzFaDXm+aUcauI9FTaZGi3ZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hljFpBP/; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84fccf51df1so2190615241.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 22:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730874688; x=1731479488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mba6U/dT9znvEMNh8rko7R6epkDmG/m28ZS6cZzb6Nc=;
        b=hljFpBP/qbJAPKwM39ypq6/CZYoS831pXVKF4krkDEBxjBo6vmtxGqPx4c5a8TPN//
         AUTuxst5n6Epbo2yBSJkODdtDCCh6t0T+eCZVtWgdcDl+otKg7BcZpEaR5OSc0jI6g+Q
         RDyqPQRY/wMIsl0FCqRe5kHJJj6w2og1cNTjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730874688; x=1731479488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mba6U/dT9znvEMNh8rko7R6epkDmG/m28ZS6cZzb6Nc=;
        b=eem9TjTLcvwJ4UZMVL7h0zF1zkVIy5Hxh6uK34WYQIDWV0dy/DU2DAvKFESdzikFFi
         mL6d7IArTnqpo71CwuTZ2TK67Te+XnJRBDRI0EYAcZSA9SkZHyLoYZF+bwvVKbFjG22Y
         2psuhu5GqR0EK+2nAAhuFQlTAy6m4moFpbe3lvoXGc1Ybjf+qhfoQgl7oiIx8pFV43KS
         jVHd4tL8H+wR9dOmxE9DRRbc3IIALVL09LYXvJr341oWAER6lId2pnyF2Fy60ZfUOtWJ
         j1eI8GbxYqv2zXrVLZJ7qyW15dAmh9l0vo4JCiIaQOAIADJLRDae6ymU00BTnwVBR8v8
         vWnA==
X-Forwarded-Encrypted: i=1; AJvYcCUBmmqhX+4R4emfLUT1SxWXkB7kp7rPKswEpMw9JQu9e32Ujk+zuiqjC0B/iwYOFsWaAKci1SDRZA3c8mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN4Fputo557SLyfh6zGQJsjUerBHvxWAeK89mRg2BZJh/+MzFV
	WWd04vUXslgqaBXzCFZzH5xvl5eGZbxIDpkbx+HoiJHtxpPWH37GtNcxUuTm6DxT8M5yJycZWtS
	s8Q==
X-Google-Smtp-Source: AGHT+IE2q2sRNsKMnUiMsmG4uzOWzGiGzAlqcWfPokkgaklLi7MoeoPg9JMuBAhpbJe6NypAWQj/HQ==
X-Received: by 2002:a05:6102:32d2:b0:4a4:7980:b9c7 with SMTP id ada2fe7eead31-4a8cfb83109mr37438257137.14.1730874688625;
        Tue, 05 Nov 2024 22:31:28 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-855dada67edsm2510948241.21.2024.11.05.22.31.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 22:31:28 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-84fd057a973so2131963241.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 22:31:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYxOFzV85ZBYlwNE8x4PKGiH0D0TuwYmRALQmq5e/5F1WanlTtcQKYJSpCSAR85dI6ftsUNl0ymj2v0L4=@vger.kernel.org
X-Received: by 2002:a05:6102:6c9:b0:497:6bb5:398a with SMTP id
 ada2fe7eead31-4a8cfb5d0c6mr33880066137.7.1730874687401; Tue, 05 Nov 2024
 22:31:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105093222.4055774-1-fshao@chromium.org> <173081219726.3053098.16931220466079803577.robh@kernel.org>
In-Reply-To: <173081219726.3053098.16931220466079803577.robh@kernel.org>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 6 Nov 2024 14:30:51 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngYUYeZpbjDh1a6ssftMN8rDgrinHJ4NCmzXJRyWx1DgA@mail.gmail.com>
Message-ID: <CAC=S1ngYUYeZpbjDh1a6ssftMN8rDgrinHJ4NCmzXJRyWx1DgA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add device tree for MT8188-based Chromebook "Ciri"
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 9:11=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> On Tue, 05 Nov 2024 17:30:11 +0800, Fei Shao wrote:
[...]
> > Note that there are some known dtbs_check warnings:
> > - sound: Unevaluated 'mediatek,adsp' property
> >     >> see [1] for the fix
> > - amplifier: '#sound-dai-cells' does not match any of the regexes
> >     >> see [2] for the fix
> > - dp-tx: '#sound-dai-cells' does not match any of the regexes
> >     >> see [3] for the fix
> > - audio-codec: 'interrupts-extended' does not match any of the regexes
> >     >> see [4] for the fix
> > - pmic: 'compatible' is a required property; 'adc', 'mt6359codec',
> >   'mt6359rtc' do not match any of the regexes
> >     >> see [5] for the fix
> > - amplifier@4f: reg:0:0: 79 is greater than the maximum of 63
> >     >> ti,tas2781 binding specifies that ti,tas2563 register range is
> >        0x4c-0x4f. The DT follows what the binding literally suggests.
> >        I tried changing the binding locally but didn't help.
> >
> > [1]:
> > https://lore.kernel.org/all/20241105091246.3944946-1-fshao@chromium.org=
/
> > [2]:
> > https://lore.kernel.org/all/20241105091513.3963102-1-fshao@chromium.org=
/
> > [3]:
> > https://lore.kernel.org/all/20241105090207.3892242-1-fshao@chromium.org=
/
> > [4]:
> > https://lore.kernel.org/all/20241105091910.3984381-1-fshao@chromium.org=
/
> > [5]:
> > https://lore.kernel.org/all/20241004030148.13366-2-macpaul.lin@mediatek=
.com/
> >
[...]
> >
> My bot found new DTB warnings on the .dts files added or changed in this
> series.

[...]
As for the following warnings that were not mentioned above:

> arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: power-controlle=
r: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevalu=
ated properties are not allowed ('power-domain@31', 'power-domain@32' were =
unexpected)
>         from schema $id: http://devicetree.org/schemas/power/mediatek,pow=
er-controller.yaml#

https://lore.kernel.org/all/20241001113052.3124869-2-fshao@chromium.org/

> arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: mailbox@1032000=
0: 'clock-names' is a required property
>         from schema $id: http://devicetree.org/schemas/mailbox/mediatek,g=
ce-mailbox.yaml#

https://lore.kernel.org/all/20240911104327.123602-1-angelogioacchino.delreg=
no@collabora.com/

> arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: jpeg-decoder@1a=
040000: iommus: [[141, 685], [141, 686], [141, 690], [141, 691], [141, 692]=
, [141, 693]] is too long
>         from schema $id: http://devicetree.org/schemas/media/mediatek-jpe=
g-decoder.yaml#

https://lore.kernel.org/all/20241001113052.3124869-4-fshao@chromium.org/

