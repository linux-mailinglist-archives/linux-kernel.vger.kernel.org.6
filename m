Return-Path: <linux-kernel+bounces-440780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA129EC424
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709311886263
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756631C07E3;
	Wed, 11 Dec 2024 05:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krq5QyUj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24A71BDAA0;
	Wed, 11 Dec 2024 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733893809; cv=none; b=ly4Fdlpa76yZFxYxce4L5SwtEqh6TNAohsqPYWhQgfn4rEp9/dA5gWUSmJoLkD8WuKic9LzaDemT9p/k1ygcGMJPTsZnZlYgTWw4+DMQtQc888V5zIRCPwcz20FFQnEeBSFs0BIBLyc5UC7WWjucsry+A70FBjQwc7YTrCO5D8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733893809; c=relaxed/simple;
	bh=YdX1dc6xsEAC92Xthg31J1U7TalgtZEvoo0qN6qkuRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekfyuBpTAV2uQz/4HXr885CXchoBDRUOkQpbWZftuKURo6tSaHpwdfcZytfBq+xERm69E3ZE8KA4xLfAg+B3FSTx1XyhasoLRPlNR44GsMv9xfrsE0a95DJe35j5cAaDZ8+JdCIRueJAiBEITw5Yo1L3IWNScht9x7gr4vpvjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krq5QyUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CE6C4CEE2;
	Wed, 11 Dec 2024 05:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733893809;
	bh=YdX1dc6xsEAC92Xthg31J1U7TalgtZEvoo0qN6qkuRY=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Krq5QyUjf0EEDOcYntNfcf80ez+thWwtLj9n9hk958Ra4O9siL3nA5Pl422U1BnkO
	 PDTfyQZfZNf2j37VR/Gqp6GtY10s/DB7Vo8OOwnqvqN2ZVR6+UfLMOIGfhTD7un6L1
	 iIsLH18Wuy46+8gGFu+x7GjchFROyL+aVk7JOZ5gkIRYbXrAoA0WhCU2mO0TMSr2eE
	 P0bVwxOtLgcG7Pd2stswbU/WnAFcD6PjAp5WafJ3m+P6X9BdeNmwJzqZbi5+pN0BNU
	 jomzrEkdjjPbPJWuIx0poiGw9LuozeaReYS79yYq6jWf6zJEuFU3vb4Q1P0k+f23KW
	 hJxlr/TtS1CNA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3003943288bso45902991fa.0;
        Tue, 10 Dec 2024 21:10:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsfWoS2qfwrNAocnYCAlI3bCd6GiKsOox86Oi2l/f+nn/nHWdMgmYF2/KhZLxnyv2MEFzZ4gb6+fVyUD1e@vger.kernel.org, AJvYcCWBLk0qeH7KZAlmPowYVTkq60gwEfSU97UaApHkdHh0MhznFUvPKnckuH0P7kF2Ts73wKEr+DYueHDQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YpNq2V9BfuKZV62n9k5BtpgGQKRRrVmufWygAxgQi1hiZnr4
	xW+k3AfRBmOtQkxpWvzJa9U6lT6S5xiW70KUV+2fJf1OIUAlkeL45GbI5KUiZiXzqK6kUbzEIXz
	7lmsOC7AjFhbVmwXOgtU+6dliJ5I=
X-Google-Smtp-Source: AGHT+IF6N4Na/k+b/kefNQKbmVXbyAnVl/Bv7G3C8f7c+yra9jFGmNFSnmVvDOEzo13KT4U9uvLIdgjGdQPdboaPjQY=
X-Received: by 2002:a05:651c:b2a:b0:300:3a15:8f15 with SMTP id
 38308e7fff4ca-30240d23617mr5158551fa.14.1733893807383; Tue, 10 Dec 2024
 21:10:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210092614.3951748-1-wenst@chromium.org> <173386568696.497617.3727087837255802552.robh@kernel.org>
In-Reply-To: <173386568696.497617.3727087837255802552.robh@kernel.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 11 Dec 2024 13:09:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v65D9cdTRoEwwpTUcRZBnrdJ+6UZ-osN1vpUP_JxtJMr8Q@mail.gmail.com>
Message-ID: <CAGb2v65D9cdTRoEwwpTUcRZBnrdJ+6UZ-osN1vpUP_JxtJMr8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8173-elm: Fix MT6397 PMIC
 sub-node names
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:43=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Tue, 10 Dec 2024 17:26:12 +0800, Chen-Yu Tsai wrote:
> > The MT6397 PMIC bindings specify exact names for its sub-nodes. The
> > names used in the current dts don't match, causing a validation error.
> >
> > Fix up the names. Also drop the label for the regulators node, since
> > any reference should be against the individual regulator sub-nodes.
> >
> > Fixes: 689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana boa=
rd")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>   pip3 install dtschema --upgrade
>
>
> New warnings running 'make CHECK_DTBS=3Dy mediatek/mt8173-evb.dtb' for 20=
241210092614.3951748-1-wenst@chromium.org:
>
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vpca15: Une=
valuated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vpca7: Unev=
aluated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vsramca15: =
Unevaluated properties are not allowed ('regulator-compatible' was unexpect=
ed)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vsramca7: U=
nevaluated properties are not allowed ('regulator-compatible' was unexpecte=
d)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vcore: Unev=
aluated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vgpu: Uneva=
luated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vdrm: Uneva=
luated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vio18: Unev=
aluated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vtcxo: Uneva=
luated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_va28: Uneval=
uated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vio28: Uneva=
luated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vusb: Uneval=
uated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vcama: Uneva=
luated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vmc: Unevalu=
ated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vmch: Uneval=
uated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vemc3v3: Une=
valuated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp1: Uneval=
uated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp2: Uneval=
uated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp3: Uneval=
uated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp4: Uneval=
uated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp5: Uneval=
uated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp6: Uneval=
uated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vibr: Uneval=
uated properties are not allowed ('regulator-compatible' was unexpected)
>         from schema $id: http://devicetree.org/schemas/regulator/mediatek=
,mt6397-regulator.yaml#

Ack. I already prepared another series to address these.

ChenYu

