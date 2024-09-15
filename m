Return-Path: <linux-kernel+bounces-330006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD3997985C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0489282ED2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7B21C9EDD;
	Sun, 15 Sep 2024 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JjV0Etml"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0EB282E1;
	Sun, 15 Sep 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726427543; cv=none; b=P4o3HXtAYwTTiBht16xLPiXcFQwOi5ygyySQPzm4QCVBtGc4XlDrPat/zb2NT7qh64YfxTQGlPRwmAgJeUUAjbueaziUb2ZBfSZd5RtNI894iYol7ysAcl1zrPeUY6xbkvIaBBGC5RSIfE7V7K708UH4Yk5vanZzJko58pKqDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726427543; c=relaxed/simple;
	bh=H6cMlZCkPdeABP+HQgXYJFpxk146R6dKpNrOQxsa0wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Alj1y4cduJF9Rji7Og927w+DUOJSfp1sfrE+xbeYPAatU5MAxGqaMz4w+QFC8dWQs8OuvHROWnfd+RTkwhfrY7VCBWql4G+kA8SsIO98kosxR6kAHHPD1TWd8iS5ACY21p+aMDDkd0NI9+WGiVY7GXUVJzZ0flLacGtOaONR/s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JjV0Etml; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-206f9b872b2so34465655ad.3;
        Sun, 15 Sep 2024 12:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726427542; x=1727032342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxbVkHtrWftjJ2Lx66Ozc/KK6sjKVqL5eejGgkG0fY8=;
        b=JjV0EtmlzF2D0alVLf/kPpSsGBL536FH5aOfvKwx2baPepwCLQQobepMxfw6VfkrMP
         LaekqaivLCBLt6p8TeVhXGjfwSccLhAmo5D8MR/7StKOGrHa/b/jvaLzeywJ9zlBT5qx
         /T11Y1nlZGY7hQx3pbep+F2/54JZF/1stXX8EUPSd7urZNQGMgdsHb5ptZfK+N685JhK
         qAEiMxPLQtlE3Q8HbV0GWlMxep5xqw+wLnNdt/Aaz3TFb6hAchyDLMDJjMpvjA044uxE
         cKmVNEU1JBrwPCqT7bmCtpn1yO/j1cqiXsX5nqe5XqO2k9BwmeIkl3VVUZaRfTei55xv
         H0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726427542; x=1727032342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxbVkHtrWftjJ2Lx66Ozc/KK6sjKVqL5eejGgkG0fY8=;
        b=MD/uKZszUYHCrOdRmltZe+4Cu7g7AegEk7nUPX+HF+HwOfJArUkgnxAn+umF+x2/d+
         Tg0Z4Dpd2VS4FGI0kf2Ef1dXeMEsOphlBytc38CyvnwObn8zBats0vY4qd11obGqWUm5
         ysxN4INgE9FJmFW5sbdY2yIEyeyP+6OgyVcXghgm4P3zUgDVoSlL2x1hTD+PrK7NgCIF
         /XobJE/V+x6Ia+tBvkwSMeNxHncxEERdNyDUdmMxoeMvEMaxRdTiK9guh6uh52uAI5u2
         kO/7rYE268B4EJ1dUWWQYq9jctJnincFQEVRspIZwi8bmwf3o0ta/B44Q/518Xq4+nw+
         leUg==
X-Forwarded-Encrypted: i=1; AJvYcCXOj2a/82nkeoU4Hn8p+WIeNZyVnixtQX5eM6L/1/A7/+dwgZx6p2KXuwwVOACU37jAaKEaZL9lopi1@vger.kernel.org, AJvYcCXmstTqTxcHZgKubpIeZpwTfZF0qARivwfzf0h+v+AOKS9XKkXex82489z8d7YugNlYbWxFmSkTRcpc/xmj@vger.kernel.org
X-Gm-Message-State: AOJu0YwPl3m1C9un+81XlK0xfc48D3WzVfnd+V7EwMddM6VpimMyRGBH
	5ATOMGBpG0BCAwOwwCn379jBB1FP04FjjF2C+kifqidSU0bZEAmr0uQluuCEzwF/B07pdXOzcmo
	XHGlFvwCGSik+aBn3aMiaF17lB6s=
X-Google-Smtp-Source: AGHT+IHxCPO0nUOsBlDCzPdjxqDPeTdDXS2walgmZ+6/o28mYOwDrUV87m3jQF+6E8j/0hcYgKfgCATM8QOp7MRaDvM=
X-Received: by 2002:a17:902:e851:b0:205:861c:5c4a with SMTP id
 d9443c01a7336-2076e4ebba0mr150793145ad.60.1726427541541; Sun, 15 Sep 2024
 12:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
 <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-4-feaabb45916b@linaro.org>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-4-feaabb45916b@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Sep 2024 21:12:10 +0200
Message-ID: <CAFBinCD+txhz0x20LXhydZpLk=u4d9FT4=1sOX1bKuDeQqsMjQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] ARM: dts: amlogic: meson6: delete undocumented nodes
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On Wed, Sep 11, 2024 at 12:19=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Delete nodes in meson6.dtsi that are clearly undocumented & unused for me=
son6,
> fixing the following check errors:
> audio-controller@5400: compatible:0: 'amlogic,aiu' is not one of ['amlogi=
c,aiu-gxbb', 'amlogic,aiu-gxl', 'amlogic,aiu-meson8', 'amlogic,aiu-meson8b'=
]
>         from schema $id: http://devicetree.org/schemas/sound/amlogic,aiu.=
yaml#
> audio-controller@5400: compatible: ['amlogic,aiu'] is too short
>         from schema $id: http://devicetree.org/schemas/sound/amlogic,aiu.=
yaml#
> /soc/bus@c1100000/pwm@8550: failed to match any schema with compatible: [=
'amlogic,meson-pwm']
> /soc/bus@c1100000/pwm@8650: failed to match any schema with compatible: [=
'amlogic,meson-pwm']
> phy@8800: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['amlogic,meson-mx-usb2-phy'] is too short
>         'amlogic,meson-mx-usb2-phy' is not one of ['amlogic,meson8-usb2-p=
hy', 'amlogic,meson8b-usb2-phy', 'amlogic,meson8m2-usb2-phy']
>         'amlogic,meson-gxbb-usb2-phy' was expected
>         from schema $id: http://devicetree.org/schemas/phy/amlogic,meson8=
b-usb2-phy.yaml#
> phy@8820: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['amlogic,meson-mx-usb2-phy'] is too short
>         'amlogic,meson-mx-usb2-phy' is not one of ['amlogic,meson8-usb2-p=
hy', 'amlogic,meson8b-usb2-phy', 'amlogic,meson8m2-usb2-phy']
>         'amlogic,meson-gxbb-usb2-phy' was expected
>         from schema $id: http://devicetree.org/schemas/phy/amlogic,meson8=
b-usb2-phy.yaml#
> /soc/bus@c1100000/mmc@8c20: failed to match any schema with compatible: [=
'amlogic,meson-mx-sdio']
> mmc@8e00: compatible:0: 'amlogic,meson-mx-sdhc' is not one of ['amlogic,m=
eson8-sdhc', 'amlogic,meson8b-sdhc', 'amlogic,meson8m2-sdhc']
>         from schema $id: http://devicetree.org/schemas/mmc/amlogic,meson-=
mx-sdhc.yaml#
> mmc@8e00: compatible: ['amlogic,meson-mx-sdhc'] is too short
>         from schema $id: http://devicetree.org/schemas/mmc/amlogic,meson-=
mx-sdhc.yaml#
> remoteproc@1c: compatible:0: 'amlogic,meson-mx-ao-arc' is not one of ['am=
logic,meson8-ao-arc', 'amlogic,meson8b-ao-arc']
>         from schema $id: http://devicetree.org/schemas/remoteproc/amlogic=
,meson-mx-ao-arc.yaml#
> remoteproc@1c: compatible: ['amlogic,meson-mx-ao-arc'] is too short
>         from schema $id: http://devicetree.org/schemas/remoteproc/amlogic=
,meson-mx-ao-arc.yaml#
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Generally I'm fine with this. I'm wondering if we should go one step
further by decommissioning Meson6 support?
To be specific here, I'm thinking of removing MACH_MESON6 from
arch/arm/mach-meson/Kconfig and deleting meson6{.dtsi,-atv1200.dts}

I don't have any boards with Meson6 SoC, there's no upstream GPIO,
pinctrl, clock, MMC, <you name it> driver for that SoC either.
So all we have upstream is the ability to boot to initramfs and use
serial console(s).
If someone is interested in Meson6 support they should bring it back
along with a few more patches for upstream support of further
peripherals.


Best regards,
Martin

