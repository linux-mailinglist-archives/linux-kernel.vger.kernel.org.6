Return-Path: <linux-kernel+bounces-251610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1559306F5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 20:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9971C21485
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862D13DDA1;
	Sat, 13 Jul 2024 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbP6E3Vy"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3DA13D289
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720894927; cv=none; b=Sj2lQgm2ZLDqeV8/ksvTTtH1nRdiAHrVBdlvIWwqeZBCfP9pLFDE5LhnenAO7A3KijgU29hsMDbAdStc2/fVGtky67vxLSWHJ6Lq0OqFZnKDOGuMyQjN846ezF2WAjNGZRCWJc9TL7ISxzB6ecUoxRLvMpmALiedIQI0mX3AYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720894927; c=relaxed/simple;
	bh=wK225UtK9kULJZqIO8UH+sthg1ntv0kXHyAI+XYzS04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn7G/kbTckyEK1sshFLOtlKZn6GcLs72ecgoMfQruRqrMrB7E4KHnUxJCDkrpxe9+VNZaAaFSmCofiIUs6VfkIyv+FDbk1neX0Nah4gOgpsd0XzdF+gFaaHhMQo2K6lX9ZoINUlWxaCNckyVTTkxF9D0/lMR9JByM+j0bNS319E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PbP6E3Vy; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-65fdfd7b3deso4464207b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720894925; x=1721499725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Akd7PvYX49ssVnM7IV++4JO2xnx3E7OhyZAKQW51cYQ=;
        b=PbP6E3Vy1paO7eXsMLM517BNtjLJKcXW42q0Pt4RuwD8L5DWWm+bakcYNSfxhIY2WL
         UU1phzs+kZCBhpzi3Hof9BJl2cF27hK8d8vhCL+NUMvJJJPgPKLK7440bvC1pwzHUszo
         zz0jVbzpa15gNG1/ljbhlHX22UPUhB+X4RzvfJo+V2RT/YJ13sBcu1vzoBRYHlskWdek
         VO7xek+wLf9zQaOoB74lIRr7mJUuFBM9wTphava6TF+MCE5+nU0JB61ipWB4xmuKCRmV
         w2yCmIvRsKi0OYQAE7iZUFQiuEbjw+dLV66XzVUb03ZJxgi+UgBlpjHz1y3jEHguEI7f
         Du4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720894925; x=1721499725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Akd7PvYX49ssVnM7IV++4JO2xnx3E7OhyZAKQW51cYQ=;
        b=XjzdfyL2d+/YjWoP26oRoSsZjEgUMVowoKXjSLik61Jpx9ysMfqsNFQFeXsnHv6qRA
         TKSWin+ElgLe9KO3x8sUTmHMNw0bXE3QS5rdkspmBi1ROPRKhDxmQgsYBUJxTD24ooyj
         lqwJk05tP8FqoH9DkErBHdQfljKkbbLpk33ld68Wdwdum/tojsYlfv/+TOJV4s6Ir0sz
         ecAB7RVP78Po9P6ibv4zS9yPCUvd0/hlfax1aHwLfIfC0dV/zFWWAJ4y33HkVKnQsw9L
         jnbQWEnDhRoQnUZB2X+MxngLQzJhMgp6PvfuV2CxGaSdmuUImA9wB+86R1Xa+jw1PYsW
         B97Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOq0/LO39GN7mT1S0hZ4w61ZI1lXYrUh3vAjUA7WSccK2EeFPwRrwewey5oXQZxfuljF8OBhGO6W4qNzpYt5hqooSQTSdFuZfeJ0Ox
X-Gm-Message-State: AOJu0Yy429S8kqKVfChBOer2uYjBwJl1qxnBPhDqVLld6SjN/gCCtZla
	OL/E1S78Im7c2RmRoMZVFvEn9MntHFbXBsk5DX4SiZzJps2m2UdsrcNk9Ebvi0T3/U+A81tV+Kb
	kxutA0mIAtv0rXSVrahGpxMkkMqTIa6z5DfUOABhvv/vbCKvX
X-Google-Smtp-Source: AGHT+IF7EMeFiP/0SrTpXb2U5NKFBozXUrANl7EuTHc+/YdpAaGakABMFnFuzd0mAN5AT73VZN70QaHdsJw+9r4Kllo=
X-Received: by 2002:a81:a552:0:b0:65f:dfd9:b672 with SMTP id
 00721157ae682-65fdfd9b925mr17814317b3.11.1720894924969; Sat, 13 Jul 2024
 11:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713180607.147942-3-virag.david003@gmail.com>
In-Reply-To: <20240713180607.147942-3-virag.david003@gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sat, 13 Jul 2024 13:21:54 -0500
Message-ID: <CAPLW+4=G=U24jw+KNCibqPQUVFkOp4Rk8AtM3mnJ89+ShW+G0w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: exynos: exynos7885-jackpotlte: Correct RAM
 amount to 4GB
To: David Virag <virag.david003@gmail.com>
Cc: phone-devel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 1:08=E2=80=AFPM David Virag <virag.david003@gmail.c=
om> wrote:
>
> All known jackpotlte variants have 4GB of RAM, let's use it all.
> RAM was set to 3GB from a mistake in the vendor provided DTS file.
>
> Fixes: 06874015327b ("arm64: dts: exynos: Add initial device tree support=
 for Exynos7885 SoC")
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts b/arch/=
arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> index ed2925b4715f..0d5c26a197d8 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> @@ -57,7 +57,7 @@ memory@80000000 {
>                 device_type =3D "memory";
>                 reg =3D <0x0 0x80000000 0x3da00000>,
>                       <0x0 0xc0000000 0x40000000>,
> -                     <0x8 0x80000000 0x40000000>;
> +                     <0x8 0x80000000 0x80000000>;
>         };
>
>         gpio-keys {
> --
> 2.45.2
>

