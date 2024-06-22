Return-Path: <linux-kernel+bounces-225770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B369E91352B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 18:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F28B21A52
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E99BE7F;
	Sat, 22 Jun 2024 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hnq7EXRv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B258F4E;
	Sat, 22 Jun 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719074826; cv=none; b=ZrMb0y5TkSlgVfxed6uwZVoX1qFXzB643lpSElgF+yo0dE4BUqoG/1RqW8bP8De0DPric2rwsy8N5uIWT7wIV6UuhUyJtULl4/BnLSH//64f6m7zHcFOPW0FSQQGTAX5UcZZvi9XRsmqJ6Trr5Vi2xULaBc+EV6nX/Gq3CvNdhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719074826; c=relaxed/simple;
	bh=6o2GVijMyt7bzrd339rAvtddzKF1tfqFnbIInrY5XWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVWY1GhM+SNK6Ps6HfKkFYpSwv6iPgJWUbxifC2mUuOgiek/P9dQB805ktzDIzr1ykq8gM/0vCSwEG3hhtH73nkMbs6BZBW02b06BGL3M8tgfGFdHNgHIhpE3h+PvJoZmBC5eNc7e9ctUkCsAcQef371odChp1yjYBXa3KiFlko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnq7EXRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C68C4AF09;
	Sat, 22 Jun 2024 16:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719074825;
	bh=6o2GVijMyt7bzrd339rAvtddzKF1tfqFnbIInrY5XWM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Hnq7EXRvXUPSsTl4kBGSMV/cQJNg78YaDNqsvhOGHotuWf4bOCbVQvw1lpzOCSX3Q
	 QWey/irz5/nv4U6uE/oehiel+gM/LLQqjAeUVZOEf3kTUtWGn0ONtC+/EVtU7Pv5kU
	 PQmlFi/8gB+XdhGBQObFp5jaTTUTGAMcF7dvJlqt0XMVTdAWcymTdCciFFFtVRdnvy
	 S3lS2PnGcQhLwMenISPDXcRoF9xGOKpzng9/NW8KNw8VugRUksKe2GRe8tYi0EWJpC
	 n0UYv2Yzd10lMW5YhYYPRYZx1BnB82PWWCAKB/Y5NdGzboLBTc8Hv9SwNAzWxJa7tf
	 0SK7qY5JOhC6A==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec10324791so33725181fa.1;
        Sat, 22 Jun 2024 09:47:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQTCDMuum2XjL49hshk8skJ0hIGa8VR7QarpYPM7Hn9MgtWxQETCjIhr7+kxmfD/BFMPODUwzu4+d3vdC4sjrLxu4Se0RwBSaw7DkaoPD76hsNKRoPzqBp9L9makV6ibVaLTpavnD4qA==
X-Gm-Message-State: AOJu0YzojN7Zh6lzC1jOfNyQizlgK/0qFOeRvLN6D19GXvYMbcxBHMp7
	0GJzlba/KAHPlMlaOp6fW22pnbMjXzkBPpamM2Dzxy7AB26+5mKdIre9Qb3+gwuqB1gwQq6DwJq
	jw9K1MvhaqdzpdkHoYdjdMmy29fI=
X-Google-Smtp-Source: AGHT+IH5/klRobrk8C8Tx8r4xEV1zy70cWikSV0uysow8O2/V58aKkLa/zaQhuBPPi8FPf4Cxx6rkddcvaqELWY/X38=
X-Received: by 2002:a2e:9902:0:b0:2ec:5736:e8f1 with SMTP id
 38308e7fff4ca-2ec5b2e9046mr1607861fa.46.1719074823759; Sat, 22 Jun 2024
 09:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622150731.1105901-1-wens@kernel.org> <20240622150731.1105901-2-wens@kernel.org>
 <171907415897.1042829.2907756455868106157.robh@kernel.org>
In-Reply-To: <171907415897.1042829.2907756455868106157.robh@kernel.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 23 Jun 2024 00:46:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v66MptRCWnSyJ6B1g=E9rHh0MUac1kPw56rTO6So9_Qqow@mail.gmail.com>
Message-ID: <CAGb2v66MptRCWnSyJ6B1g=E9rHh0MUac1kPw56rTO6So9_Qqow@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: sram: sunxi-sram: Add regulators child
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Albert Ou <aou@eecs.berkeley.edu>, linux-sunxi@lists.linux.dev, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-riscv@lists.infradead.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 23, 2024 at 12:36=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org=
> wrote:
>
>
> On Sat, 22 Jun 2024 23:07:29 +0800, Chen-Yu Tsai wrote:
> > From: Samuel Holland <samuel@sholland.org>
> >
> > Some sunxi SoCs have in-package regulators controlled by a register in
> > the system control MMIO block. Allow a child node for this regulator
> > device in addition to SRAM child nodes.
> >
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  .../allwinner,sun4i-a10-system-control.yaml   | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/s=
ram/allwinner,sun4i-a10-system-control.example.dtb: syscon@3000000: regulat=
ors@3000150: False schema does not allow {'compatible': ['allwinner,sun20i-=
d1-system-ldos'], 'reg': [[50331984, 4]], 'ldoa': {'regulator-min-microvolt=
': [[1800000]], 'regulator-max-microvolt': [[1800000]]}, 'ldob': {'regulato=
r-name': ['vcc-dram'], 'regulator-min-microvolt': [[1500000]], 'regulator-m=
ax-microvolt': [[1500000]]}}
>         from schema $id: http://devicetree.org/schemas/sram/allwinner,sun=
4i-a10-system-control.yaml#
> Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control=
.example.dtb: /example-1/syscon@3000000/regulators@3000150: failed to match=
 any schema with compatible: ['allwinner,sun20i-d1-system-ldos']

I'm not seeing this error locally. The binding in question for
'allwinner,sun20i-d1-system-ldos' was merged in v6.10-rc1 in commit
622bab188484 ("regulator: dt-bindings: Add Allwinner D1 system LDOs").


ChenYu

> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202406=
22150731.1105901-2-wens@kernel.org
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

