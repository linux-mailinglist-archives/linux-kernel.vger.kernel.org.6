Return-Path: <linux-kernel+bounces-197971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B707E8D7162
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 19:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0BC1F21B82
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F40B154BFB;
	Sat,  1 Jun 2024 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgry/rEx"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3709E154BE2;
	Sat,  1 Jun 2024 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717263800; cv=none; b=rKs1jjC6xGQ9BmmWQ9BftBLCCwpOFeFkBfd5mqjsfrOPdk/bqplZdyhBnAnQBrGdgenOH4G5x0HAyMs1FV/xfQ4Gg++AyhIgzqSk+N8FmOCk1om7dfWXjNLTUrZ5WJbeug6JITUIXiHJwjH4P8BKbnUTfdTDfjtjkgdPp9Ivdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717263800; c=relaxed/simple;
	bh=W0wuE5Of9oClh7yyA2twjLsZUMGP7wIYysfR+SJ1z5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDNw546trP38Y1ASjoc9DFBG+VV0rmedPKyNsJTfrCFZUIsA2KbFlaa1sNDugCZgqBx7wEPROIPIdcDLzl8TYaxhIEqp++cQNhV+c3aoV4vPqjlt/+wJfxht0Yxrt0qR2fkZMO781RU6sa8hXvSu+0H9mssP0M79Szb35svF218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgry/rEx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c1afeb259cso404285a91.0;
        Sat, 01 Jun 2024 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717263798; x=1717868598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buYYkTl8li7ctanCOVUPnpm17gP2d9IWbg1xZ7qYW0A=;
        b=dgry/rExAfKfdbKfRj4vmtqnfvUAlbINiMejm2XWiA5iWu9mnGv3kMOo3E4ABLgF+5
         K/kMBnfd8yg1upAacxkbk9TDb+49PBo+4PW8nG1aTnMs/59kAHWjEcFi/BA+tb/hNMjq
         evJ1qQVMio3nIXctsHcZb8nUdhLRMS3OejHZu0+dpLAXRlMWJ0L7Y+oFdT0CXj9GaEun
         xvRIFFdHfkjxdOqa8vjHn3kOcjigwnzOOeZtNdRSZL7PAL5+qFo+ayloR9IrGhdmJJDy
         1O43Tx7YHakdDMpxW8oQn6n4Am/5OkbpEMgBZ+LJEOJRXDNg3xXGYwDqsSDaSTYmtSNs
         47Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717263798; x=1717868598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buYYkTl8li7ctanCOVUPnpm17gP2d9IWbg1xZ7qYW0A=;
        b=fdH2AQBTLBTbkYu46l9OSDtC/fzEqT+nhKLwa8/r5LMW2/9LRPFq6VWul4drZWjesc
         SPVM9FAOa6wZ12lI0piW2/yFjVMRyjFgGs3t+nUKTLWqjux3TTBdLBuuiT3gerUXeo3T
         yYgL4FGwqUM3kbkis2PVh0VJ4aL8Ge7IVGEJrn5xBF7dkPvWHxSYo2yIzJ9mEF6D8cb3
         tIZUOV3mKdkQZ+yc2wNV1TRUsW4blyGJQtcUcfCqnUOHDSGViNas4SjuiEFGxsA/UIJL
         hxFp+1cdxfZZCGqaE45hxixogJ4yXNkS2aZyvt4Mq6mANAj0mCUSSJVd4RL4NDzRRgp5
         Vxbg==
X-Forwarded-Encrypted: i=1; AJvYcCUHs/b4Dkuq57+UXuHSezm9t8Cu8KN/u+YXx4ChLgUj7/Ok/Uk56PsDLlzwoWBzDm++NzGff1IhOgign9UEAheWIiP5Yd6c6jHvkPN5dNtQ9HkfHk+eTzDXT6adSTLfCnDjh0EqsaxctA==
X-Gm-Message-State: AOJu0YxmnnAK1sUx13jW7MFlhgv9ynuyFAAp9TliCjkNdvlZHndR+8J3
	ay+wziUuxmN0U197JXNX/hpN3ywKBPmRz/QvZT+rRTlb/ULvrqtyw/pVboK/5FugNgMRqOoZjwf
	0rtrGMz8AfJd1Z+etfYRmco1uOEo=
X-Google-Smtp-Source: AGHT+IH30qJm5Dn9kjIOog7TjJO9dDrnfu32rz4HIS3cmy1sSKziWOx6W7hrqbBQnUIoV06Ofw6MzPxn1IUshT9zD8I=
X-Received: by 2002:a17:90b:3b4c:b0:2c1:aa9e:1781 with SMTP id
 98e67ed59e1d1-2c1dc4b9529mr4732595a91.0.1717263798460; Sat, 01 Jun 2024
 10:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601135230.89980-1-aford173@gmail.com> <20240601135230.89980-2-aford173@gmail.com>
In-Reply-To: <20240601135230.89980-2-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 1 Jun 2024 14:43:07 -0300
Message-ID: <CAOMZO5CVrEEj20v+EDX7rmCvW29wL+gD37mfMZAp-uY=tnz-rQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] arm64: dts: imx8mp-beacon-kit: Fix errors found
 from CHECK_DTBS
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 10:52=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:

>         adv_bridge: hdmi@3d {
>                 compatible =3D "adi,adv7535";
> -               reg =3D <0x3d>, <0x3c>, <0x3e>, <0x3f>;
> -               reg-names =3D "main", "cec", "edid", "packet";
> +               reg =3D <0x3d>;
> +               reg-names =3D "main";
>                 interrupt-parent =3D <&gpio4>;
>                 interrupts =3D <27 IRQ_TYPE_EDGE_FALLING>;
>                 adi,dsi-lanes =3D <4>;
>                 #sound-dai-cells =3D <0>;
> +               avdd-supply =3D <&buck5>;
> +               dvdd-supply =3D <&buck5>;
> +               pvdd-supply =3D <&buck5>;
> +               a2vdd-supply =3D <&buck5>;
> +               v1p2-supply =3D <&buck5>;
> +               v3p3-supply =3D <&buck4>;
> +

The extra blank line is not needed.

Thanks for fixing the dt-schema warnings:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

