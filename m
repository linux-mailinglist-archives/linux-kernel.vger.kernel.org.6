Return-Path: <linux-kernel+bounces-193900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D3A8D33D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717E5B22A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9358616EC11;
	Wed, 29 May 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLB6bkGs"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C116E89C;
	Wed, 29 May 2024 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976680; cv=none; b=qtBL4GjpLxR8mOY1s7UI/1J5/r62FIcpM1uJwni2AmmIhyyzTtDZ83MroIP5S8g3mMZrX09Iv2q5KkJ3puCDmeM72R0o8+GKJv7yA+ACwgYa7HUWMIeGb7qm66FPx0zruWXAVrlNFaycoauZ3UMKMtPkk34rs9P4N1y4L4iY18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976680; c=relaxed/simple;
	bh=UA64iSZ7F7eTVM3NOd+SF5bb7u0BiT607ti9X6Vn6UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D72+4IfdthPt0DqnPUGhvvnQ/3P3w4pzuEE17p1W1k1/UVhP90rO0BLSAbn1XT7xBIZXicqe37P76H28p3U4X5RpnLag2wASIKx0QF1BZ48+xW0kjZYsfQrmZnDp79jYWU3pIigOOrigsXuI2beXvUMsPkwEusOhqoWdF4QbFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLB6bkGs; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a63036f2daaso226895666b.1;
        Wed, 29 May 2024 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716976677; x=1717581477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tM9NVJO5ERbRVncEwJVxXR7CMcdJybzoYCJKI2cSjJY=;
        b=KLB6bkGs1tpiCY83oiXg1JVML881kETgdz+6enIXqOntkRqVTQfsJ+IxEFpwpCqKin
         3WVDbrISSJS78jqHYkC+iwHmJ+BcaPZ7BVxlR+7gIEHVw0VuqpadZeZp/p/KlMpdziCl
         /8944/gm2g8mySncHatmMk52jOe10jWlkMWp+zRd7++gxe43zjM941S+uuyVPL+wjjnm
         f1V6GAe7EUUa0ktfASt6qYnhlPeY0VhoRxg0QrVAvJWsZhxv/TLE1IzhPRJz397H/HgV
         yIayaULOpy3uC5M6OIYw4oN3DhMA3sVsM6icQPuP5jgGa9q7amc6RONleTD2oq/WAWhQ
         aQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716976677; x=1717581477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tM9NVJO5ERbRVncEwJVxXR7CMcdJybzoYCJKI2cSjJY=;
        b=Vl9Z2RDnJFOR7/y71qsWwMHWu6aB/xgBTFweyhOvtWJ++CXRtNkansw0YS7rhvhml4
         vYJ+4ImK706IB+1oMctj9nSfJ4de+9/e4uCSFuROUjIAezj7HPsVxiXW7mdjMRWUZ3ur
         yt/GSKrPx3FZfIA1igfd/kF7ZHgk+hNpiFHxm9vlFDI1UDxUJUEb+1HAGCjtLKjDEql2
         uqXie+ahbzwX+BoqtyiYvY2TW2oEKpLWEU2cRTn6zlfM8sihxEknIa1+D/dcL+KofnSf
         sdZkjh50UV5pcWgqSq6uprAJ/0TZINt6hftyBVXkhsBoqFpYdXy/W0YbDPLjtprYpsP8
         cTog==
X-Forwarded-Encrypted: i=1; AJvYcCUtTkkWii8bLPZK1fHsmUosvDXpUZrRcueD5v4EPnah4NCXMbh6wVcs8PI8fWk+pr97Osa4c7VR4Z0s5S8HxFszKYpbthooJh8u20OgEVhLxFJf+MJoZL7x2v0m6kOstpY6aB17vEZdog==
X-Gm-Message-State: AOJu0Yy+3G/L2r41KaYp0G5soRaRnZEM4z7cESklX+uuRPFdgJaZ8CHS
	aHD0v+oY4sGbMdrJ82bcWI0JcanHDlDnBiDiJRpvxCWLAXN9Hk0lLcQsbe6VQRaMjwj8Od5hdVe
	ijSqPqyqvi9RaOqXChnyWbb/ntxY=
X-Google-Smtp-Source: AGHT+IGOp5wkK1bnw+0O7gHeuICSWfLY1jISrchSQva5fYlR915OtoYk8ONFoQWe1BvmVTeQqJ5xRZ614/Cf9Ora6bo=
X-Received: by 2002:a17:906:8920:b0:a5a:8ca4:6781 with SMTP id
 a640c23a62f3a-a6265148b7emr800169966b.51.1716976677229; Wed, 29 May 2024
 02:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
In-Reply-To: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 29 May 2024 13:57:45 +0400
Message-ID: <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, wens@kernel.org, 
	daniel.lezcano@linaro.org, didi.debian@cknow.org, 
	krzysztof.kozlowski+dt@linaro.org, viresh.kumar@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragan,

On Wed, May 29, 2024 at 6:14=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Rename and modify the RK3588 dtsi files a bit, to make preparations for
> the ability to specify different CPU and GPU OPPs for each of the support=
ed
> RK3588 SoC variants, including the RK3588J.
>
> As already discussed, [1][2][3] some of the different RK3588 SoC variants
> require different OPPs, and it makes more sense to have the OPPs already
> defined when a board dts includes one of the SoC dtsi files (rk3588.dtsi,
> rk3588j.dtsi or rk3588s.dtsi), rather than requiring the board dts file t=
o
> also include a separate rk3588*-opp.dtsi file.  The choice of the SoC var=
iant
> is already made by the inclusion of the SoC dtsi file, and it doesn't mak=
e
> much sense to, effectively, allow the board dts file to include and use a=
n
> incompatible set of OPPs for the already selected SoC variant.

Indeed, including just one .dtsi for the correct SoC variant and not
having to bother about what other bits and pieces are required to use
the full SoC functionality sounds great! Thanks for putting this
together so promptly!

Some considerations below.

> No intended functional changes are introduced.  (Still to be additionally
> verified if the patch moves forward from the RFC state.)
>
> [1] https://lore.kernel.org/linux-rockchip/646a33e0-5c1b-471c-8183-2c0df4=
0ea51a@cherry.de/
> [2] https://lore.kernel.org/linux-rockchip/CABjd4Yxi=3D+3gkNnH3BysUzzYsji=
-=3D-yROtzEc8jM_g0roKB0-w@mail.gmail.com/
> [3] https://lore.kernel.org/linux-rockchip/035a274be262528012173d463e25b5=
5f@manjaro.org/
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  ...inctrl.dtsi =3D> rk3588-common-pinctrl.dtsi} |    0

Renaming the pinctrl includes seems superfluous - maybe keep them as
they were to minimize churn?

>  .../{rk3588s.dtsi =3D> rk3588-common.dtsi}      |    2 +-
>  ...nctrl.dtsi =3D> rk3588-fullfat-pinctrl.dtsi} |    0
>  .../{rk3588.dtsi =3D> rk3588-fullfat.dtsi}      |    4 +-

To me, "fullfat" doesn't look super descriptive, albeit fun :)

How about we rename the existing rk3588.dtsi and rk3588s.dtsi to
something like rk3588-devices.dtsi and rk3588s-devices.dtsi
(preserving the inheritance between them), and then I add
rk3588s-opp.dtsi and rk3588j-opp.dtsi in a follow-up patch?

Then we keep "thin" versions of rk3588.dtsi, rk3588s.dtsi and
rk3588j.dtsi for board files to include. The mix-and-match of
different on-chip devices and different OPPs then gets transparently
represented within those "thin" .dtsi, something like this:

rk3588.dtsi:
#include "rk3588-devices.dtsi"
#include "rk3588s-opp.dtsi"

rk3588s.dtsi:
#include "rk3588s-devices.dtsi"
#include "rk3588s-opp.dtsi"

rk3588j.dtsi:
#include "rk3588-devices.dtsi"
#include "rk3588j-opp.dtsi"

>  arch/arm64/boot/dts/rockchip/rk3588.dtsi      |  414 +--
>  arch/arm64/boot/dts/rockchip/rk3588j.dtsi     |    6 +-
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 2671 +----------------

Rename detection didn't do a particularly great job here - wonder if
we can do anything about it to minimize the patch size and ensure that
the change history is preserved for git blame...

Best regards,
Alexey

