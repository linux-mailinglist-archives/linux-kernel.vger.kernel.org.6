Return-Path: <linux-kernel+bounces-331070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B37697A7FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BAE1F23038
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1EC15CD64;
	Mon, 16 Sep 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoXPggEi"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737415B0F1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516395; cv=none; b=Bk+KJ3oFUgJxd7rdOI42OeXh56gNAFSwfiT04dR8yHiXkfY7yIkVhZQf4TuCNuk8vXhdim17QowbZBVdscC9szaOwMyjZ2tmsL+O2KJGHllLiNmy8bzQ1aToYK8dOndFpa2X25+RAq25znk1nZTHx5XWy/x3ZVjvDCuaUMRQwQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516395; c=relaxed/simple;
	bh=uqqd628+uhGIMEaT7YU8Q0Fz08LP/o11gVqgxOVy/sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUiCNUVrokEAyRDnBO9w+1Oacxpfm9oAYStfZ38qTX3lw2Kc65rGbfmzMrzkCLvUh9iei9Qj0qLWp7v1iltmJa0onxPuiqn7HIG0daN2G5q3D1UJrcrq6q0gd5inBBWcI1UlQEj4J8i1QPVkgX3xBH+Nc8lIs2vSnkHSaCoDJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoXPggEi; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e040388737so2406014b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726516393; x=1727121193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c6Q5LEk25O3rZqtoMXlikB22Q5jTShRdeCQOQJhpac=;
        b=QoXPggEiO/9BJ5/Q5QdmHjDfm+vEG8r6nCZnwA4sRYWKsjouw8PZNazhxGRScPxOjK
         asOS1H1XaXfJ4NMggPUuG/1yUlwpTCGIgE1Du0cBUN2V4YBPZS58BP39WE84m8OMSG2e
         Y63ihCFIqnK8MPuUKPnbnxvss25aSEfLk170N2x1yxw+RQ8AMn+8nDLIr9LIrfmePEUM
         8NyV/yi3iOdfemR9T3InP3M9WMw73tVwkCLumd2IdulCeNDm0sds3/JVVTnpSjWktmYn
         dP66DMa5cNSYlQ1AhZxLH/IkLW+PU0gj8wfmO4gf8M+s9GPUu306LssI7anPAX5QA61m
         kzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726516393; x=1727121193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3c6Q5LEk25O3rZqtoMXlikB22Q5jTShRdeCQOQJhpac=;
        b=fMgBQCwyHQEwFSuYQr6jThj7KLNiKjtk6tCBNZNFB6DpLwx+wNwJ6RonCXkTmmtXMT
         Gza/vt3GmH8sJsvm6TxRaOZRYB/jqV/lqRNJrF33ReqLvEMNJVtTud0CHGJYUMVAZ1mf
         juao0NoCnHtRq/UwGN2HXh3pc9qUnXva9yc+fkMbakC68UeP43dR04+YtUMmfLNfGnS3
         b/jx2uVnpejmd7f6qO3qD+pdOadyWfCxbzd0Clb6dHVje28cfUtZtAYxP9F5Fdohaqh2
         RDkUNke+oSfpwFAqUir930vjBX6he3L65kN+w27JXWn+YKwsOqv5G8nPNV74ZQXOKovX
         83eg==
X-Forwarded-Encrypted: i=1; AJvYcCUi4PI6xrTTMy7nIFlyF4bMz+CP9I3X8eRCgxl2DJ3lEMr/87HtiBw3DdXRRQnBVBEFxk39MRFZKjbzP08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzixiCVC7AFXK+jvn6uvEEkaE1rX+0YXRciMKUGwoqmmSAy5Voz
	bfkMmvx7bxyOkx7Lt6051guNc2Jm0AjbgMxmHSu/Uc5R6P8l4fhlyaYs3bA2fynxjNRtUx/nA0w
	o4RG36eNa72aQcdqJBtogJ/2rSJ+vQBxpnCt0TQ==
X-Google-Smtp-Source: AGHT+IFZ2fxbquHr0hJBxa/3ohWhGc6eo3RAx6RxYU89o1TqmSkYcWIeJ1zwgOdMVbqCUmNvRnX3BuMtsfCnt0r4VPE=
X-Received: by 2002:a05:6808:210f:b0:3e0:4cf4:d948 with SMTP id
 5614622812f47-3e071b0dc53mr11129092b6e.38.1726516393181; Mon, 16 Sep 2024
 12:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916-max20339-v1-0-b04ce8e8c471@linaro.org> <20240916-max20339-v1-1-b04ce8e8c471@linaro.org>
In-Reply-To: <20240916-max20339-v1-1-b04ce8e8c471@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 16 Sep 2024 20:53:02 +0100
Message-ID: <CADrjBPp1Esr_y7nuMgEiknDQbDzW7bKu5UKaoRQ7jGYRAFr_Uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: add max20339 binding
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Mon, 16 Sept 2024 at 17:48, Andr=C3=A9 Draszik <andre.draszik@linaro.org=
> wrote:
>
> Add device tree binding for Maxim MAX20339 overvoltage protector with
> load switches.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  .../bindings/regulator/maxim,max20339.yaml         | 171 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 177 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max20339.y=
aml b/Documentation/devicetree/bindings/regulator/maxim,max20339.yaml
> new file mode 100644
> index 000000000000..ef6490cf5a6b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max20339.yaml
> @@ -0,0 +1,171 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/maxim,max20339.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim Integrated MAX20339 overvoltage protector with load switche=
s
> +
> +maintainers:
> +  - Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> +
> +description: |
> +  The MAX20339 is an overvoltage protection (OVP) device with integrated=
 load
> +  switches and ESD Protection for USB Type-C applications. It protects l=
ow
> +  voltage systems against voltage faults and surges. It also integrates =
two
> +  load switches with current limiting, configurable by hard- and softwar=
e.

[nit]: what does "hard-" mean? should this say hardware?

Peter

