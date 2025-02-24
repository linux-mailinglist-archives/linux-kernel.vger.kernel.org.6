Return-Path: <linux-kernel+bounces-529112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53C8A41FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCA43A5666
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F9D23BCE7;
	Mon, 24 Feb 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ubd8FU2V"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464492571CF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402151; cv=none; b=cW+QwJp+jmsIQmjqAXJYAwQxPYrhhzFoO3YLKWm7EIwbSWALKEk7FMWreVxOChffMtXC2T3NTKcAJ6EDMv/37QrPhjKFDdjeSlYXrW7ler3QX98uqY9Nx8DnMR3TS5rv8MIJKyBP4jVG3oI6msIXy2eteK0J1PvqCgExrjXi0Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402151; c=relaxed/simple;
	bh=3GoOSlh4aghrEUhFA8T2QcZ172IFZvBUU3F8aELhD30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MijEl0SumLVw8anHi+qKcUN/ZCt2KrRlXBGWm91H8679qCmo2w0+319rAxP03puudeXPmKs1VbDhsbv6d97qG3Y28ry9LjQBstuRqDtKwLu2FRSSTFjbc0HOxVu2FJcPqnow/8b+E/wAJeTOxILckFceK306kJZtzA0Bt0yVA9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ubd8FU2V; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a823036so41823555e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740402147; x=1741006947; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6JKe2d60+WlSAD6t2/IsKdHC5kmJu+MWZz25xMIMoOk=;
        b=ubd8FU2VmYWa9zNq8snfYYUdTdx5EThfLEqp+3GRLMRpK6TRQIF3vDQVtwhRqw16fS
         fxyNsNnCXgFvr7KAxi3xzxbo+WWrNql28k2uI864GNnMCovlmNbcTmgnJAk5vdDqPLM8
         W/pWbk3waERSvTXuf1pAt1f9Nq6iPuWhtAiTMVAjeQlEJLBuxaBGX2LdLQCZj6HCeW42
         niwbU6ZqHWlPUVhg6NoGvMLQNNyULFb2yCuUJj7zuToXhr2wzxOPwEpjL5qonX0JagYL
         /2z+eK/GsLTjerGmQNAYwDMS6VnMp4AnajjLOaJaclGndB45x4vaH36sRzw+TNwnq7xg
         I5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402147; x=1741006947;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JKe2d60+WlSAD6t2/IsKdHC5kmJu+MWZz25xMIMoOk=;
        b=jMyOm3xZCNHTpk9a0fWDpC1WM1AULy8WovtdgooDApjTHdKhHgjt71y/DgpvItEd1M
         W3SWkToefkLUL2jVzq9sG5u4pdPWVQZfuRJu18VthCBfU9Ol3O3bfUTdk8tSMdLfliJt
         RceSlhLsn1LHmF7WtOIBqabLsSbLD1l3VZI1tMH4ILBazEIBXM8vrjbzQdZ3Ru9/07F7
         /qpf2+s/KH3fDjRr+QkWGbTTt0rCp3QynbyWoxIqptVHt1+aO+i3gUmeCI/XlGV21zJf
         29wGbe5Vm/AysxIZAevlIu1YBjdO8ltl+UGeumJmtbo7u6xe1lsHC9IDMbZ0XCzftBwO
         HIRA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7CX0WVCFGwC6AP2eI0ySTXfP+EuAx5gD5BLlwFq0JiolzxBe7CwQyDxKINtUE8ffaGv73tgwXflj58I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cH0UVfeaoh4/G4QbZ1L03bmeqPY68EXhg3z4jRl4EuxFhNHt
	nPqk5Mav5rWfUKfXgKZTp/ywOz6572m55+Uv9XlgkFN89DRLrKKHDaNsjey8iDA=
X-Gm-Gg: ASbGncsd/pMiYqKfd3RwKzUvZCFf1JzFN12wmBPULYt6gSXBogRZDR17TMdTlr+hdIy
	df5E9bDrGfL4ngK7bO0JojNHqLbx8XusacS1IN30KxJlzJ9BdFLihHa9zRuLbSyRQxpnGsWjXBe
	lmwHDbqTMquqNH8IGv6fXCOfgAZR2wCyeknodnoDPzag/BysrhEnDqpuaDMIlEUwW/L3xbwCZRk
	FIOMvwzj9sJ02LJ7sskYdOMw2zlDgJltRKh/tP15QEbragxPiNfQPiBJHKa5RBuS06tmJJZUsNp
	AD0n4vKyrSys1fhE0NQKelCrIAjQ8Q==
X-Google-Smtp-Source: AGHT+IHIvx/Mzi0ATkCEL7v8mqxYPxS778o/u734+8lN1qwnKFPkNnFzPQqlUpq/kfgg00sUP03rEg==
X-Received: by 2002:a05:600c:358c:b0:439:84ba:5760 with SMTP id 5b1f17b1804b1-439aeae1c8bmr110053185e9.5.1740402145511;
        Mon, 24 Feb 2025 05:02:25 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02e6cf4sm104593555e9.19.2025.02.24.05.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:02:25 -0800 (PST)
Message-ID: <923badeacb9e52b78d276382ae8c06a47c44fbae.camel@linaro.org>
Subject: Re: [PATCH 1/6] dt-bindings: mfd: add max77759 binding
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	devicetree@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, Will
 McVicker <willmcvicker@google.com>, linux-gpio@vger.kernel.org,
 linux-hardening@vger.kernel.org,  "Gustavo A. R. Silva"	
 <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, 	linux-kernel@vger.kernel.org
Date: Mon, 24 Feb 2025 13:02:23 +0000
In-Reply-To: <174040128694.2418814.685647591949303616.robh@kernel.org>
References: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
	 <20250224-max77759-mfd-v1-1-2bff36f9d055@linaro.org>
	 <174040128694.2418814.685647591949303616.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 06:48 -0600, Rob Herring (Arm) wrote:
>=20
> On Mon, 24 Feb 2025 10:28:49 +0000, Andr=C3=A9 Draszik wrote:
> > Add device tree binding for the Maxim MAX77759 companion PMIC for USB
> > Type-C applications.
> >=20
> > The MAX77759 includes Battery Charger, Fuel Gauge, temperature sensors,
> > USB Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
> >=20
> > This describes the core mfd device.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > =C2=A0.../devicetree/bindings/mfd/maxim,max77759.yaml=C2=A0=C2=A0=C2=A0=
 | 104 +++++++++++++++++++++
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 ++
> > =C2=A02 files changed, 110 insertions(+)
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/maxim,max77759.example.dtb: pmic@66: gpio: False schema
> does not allow {'compatible': ['maxim,max77759-gpio'], 'gpio-controller':=
 True, '#gpio-cells': 2, 'interrupt-controller': True,
> '#interrupt-cells': 2}
> 	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77759.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/m=
fd/maxim,max77759.example.dtb: pmic@66: pmic-nvmem: False
> schema does not allow {'compatible': ['maxim,max77759-nvmem'], 'nvmem-lay=
out': {'compatible': ['fixed-layout'], '#address-cells': 1,
> '#size-cells': 1, 'reboot-mode@0': {'reg': [[0, 4]]}, 'boot-reason@4': {'=
reg': [[4, 4]]}, 'shutdown-user-flag@8': {'reg': [[8, 1]]},
> 'rsoc@10': {'reg': [[10, 2]]}}}
> 	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77759.yaml#
> Documentation/devicetree/bindings/mfd/maxim,max77759.example.dtb: /exampl=
e-0/i2c/pmic@66/gpio: failed to match any schema with
> compatible: ['maxim,max77759-gpio']
> Documentation/devicetree/bindings/mfd/maxim,max77759.example.dtb: /exampl=
e-0/i2c/pmic@66/pmic-nvmem: failed to match any schema with
> compatible: ['maxim,max77759-nvmem']

The top-level example in here references the two (MFD cell)
bindings added in the two follow-up patches for gpio and
nvmem. When all three binding patches exist in the tree,
the errors are gone.

Is this acceptable, or shall I add the top-level example only
after the bindings?



Thanks,
Andre'


