Return-Path: <linux-kernel+bounces-218544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C533490C1B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B93C1F2256B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60060199B0;
	Tue, 18 Jun 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACmlPoXY"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7383C848D;
	Tue, 18 Jun 2024 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718676423; cv=none; b=L6VI5sN6f8nif9vOrBIrF9fFXYHaamf4vpRSVJ5SaY3q0YJ0aPVtClN5kxcBlBI7/ZrYr/M81a3OIIZVIAGi53PUIa9eZuqwR4t/44hx6rhYsSEnuyEMwAxhcZSvRhM6vKW/a6i6zU2LbR6XqL3LOWWuodV/T5wQGEDnKImKaTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718676423; c=relaxed/simple;
	bh=tDDhJBx2kQ1aLSfqQqgYyhSVtBWlyuSbl2KCKioVHGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWZtdURztU3FBjmsdN8hE/5tIw52jF6JAvpTem9Dzk0EbeIOWqz+KqLB6/982OKnLECsiVWob4ACqOdhPv1dgBCGwZ8ZTLgl908s2pvPzqvo+aYcrfdDDtAvHFBDVrONXFo/hv5b5EpjemVdZOhimdtLV1xYflABe+y4jrX7mEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACmlPoXY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c4e2cd931aso697032a91.0;
        Mon, 17 Jun 2024 19:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718676422; x=1719281222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHBxFQeQWiychYaWcoZDG4DV0SlUdCq7PLvbbl4B7kM=;
        b=ACmlPoXYju309q5la2OWv0WgFI9aEkp0wPIcemkm3PJF/FelBZNchv26CpXZQ6Qlgy
         JGsVbIvSS/DV6urPWepLXy0FmD5/bneVzG/EffRGXnZSQS8SbXIh+7ZsZCZsye5wiSru
         ptSE7izsnuaJGEi6PLedOvl32s+83E3TnvV27E0pmhyXOaZ4VzMA/fZVd4jANSyYgG6A
         2HQ4Go7Bh/VJcv1NlqeH8fwdq2CudCtZCdbLRu24c57yGuM4mprg4GvILV5fRE2hFDbR
         AwjQczo6inB9ZBL/81zZ9wS3u6BEWlB4G78CQurcyFsFLszTATnybvg+TNKR5ySkai8z
         ThgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718676422; x=1719281222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHBxFQeQWiychYaWcoZDG4DV0SlUdCq7PLvbbl4B7kM=;
        b=FHUIbAn+d+wcbYGtK3GdLW4KqlDttTenWx29mZOjN5DqyJxrNFFrL3ZcC+HNxTWbtg
         18ofoqgp4QZ4z7iCKQqGDq4YGhSXYbfhGWYz5yCqevpmZm/QFFdty0Xmq+s8cQA07mhG
         fZt10avOwCo4SoW4p59WRwc3gLg8qVK1wnZvWvpORgcU6aL0aoiJ+9kFOI6yBjZXAV2t
         NfgpWlD48XMQVW5dE1ig0j6ByzkJx/C5dg2/rj3f4LrPOaxdKnADkjGyuMTO5DFPC704
         mVLn2aipWGmwrNgj5uiP1LjUxg14xLlqap3C0gtMCE54euo+TNWXYVuku+buUjO2UsOn
         A26w==
X-Forwarded-Encrypted: i=1; AJvYcCUjuCN8gTkLWukkb5jranKRKv9VGAlCYJ6ZZ3L7XOQUxNYC5HehSS/glcfSnwv8clUuQwSb6oBYFYMC5bcYs5DgGfYUqdP/TOkFraoOCY9PJVeYM/N02VF5CrlEeSjic0PXF70zJ6AgBA==
X-Gm-Message-State: AOJu0Ywvja3hnWHYbEMd6RRbpw4TkseqebO4/lerZQCUrHYpUKhoc1rt
	Ks2KnXzpHnW4RFB6ItJjJLcAAyDpFXba5wbRQZA2TKsCxFXkUo6kR8xYIKUwplVviQaGDXMISkO
	PKTSEY7ONWsUavc9sN4zP5q/LSTI=
X-Google-Smtp-Source: AGHT+IHXFbCfgwFRqQQzynC26fl0SQoMru8/nbeWeM4xylrZ+LYezcIbS61zdeadnIVSbaoyw+wsp5+0qpHN/34+nqo=
X-Received: by 2002:a05:6a20:1584:b0:1af:cefe:dba3 with SMTP id
 adf61e73a8af0-1bae7b3d2c7mr13813299637.0.1718676421778; Mon, 17 Jun 2024
 19:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617223100.1539796-1-Frank.Li@nxp.com> <20240617223100.1539796-4-Frank.Li@nxp.com>
In-Reply-To: <20240617223100.1539796-4-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 17 Jun 2024 23:06:50 -0300
Message-ID: <CAOMZO5Ck6iME0d4X3fV=wyO2Y6GvX1-=EtxWo7TGLRZjFpABFg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: imx95-19x19-evk: add PCIe[0,1] support
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 7:31=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +       reg_pcie0: regulator-pcie {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "PCIE_WLAN_EN";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               vin-supply =3D <&reg_m2_pwr>;
> +               gpio =3D <&i2c7_pcal6524 6 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;

As this regulator has a consumer, 'regulator-always-on' can be removed.

> +       };
> +
> +       reg_slot_pwr: regulator-slot-pwr {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "PCIe slot-power";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               gpio =3D <&i2c7_pcal6524 14 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;

Ditto.

