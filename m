Return-Path: <linux-kernel+bounces-255436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5949340B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387C22820BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1831181D1E;
	Wed, 17 Jul 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFXVMvdX"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8681E4B0;
	Wed, 17 Jul 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234776; cv=none; b=aWEsZja+exM57oP3CGRvB4NuHUELPdi1qgPXaDFeUuD9LDPu7BsxoEgv2xZiFkMW2dnqTjDxzLrQlUUH0LsJGi821+LhVfiBcGsk2I1z9XUx9UkM5sbj33oyVzrKkU3HX8nfVCpr8Y8AIKmXKP3M6wRorRuS2at/sjStjalDYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234776; c=relaxed/simple;
	bh=2S0ab5SdmVZu6CHXw0oDlN+TBmAuaYsarb+i1qS+Q+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbgIy8xJSic0IJNYQicmyZbZPD4NnhmNx3++flzbHGQbKC9UvM/g34FNTlK0SW0txqmuirhkUQbklukGJetxMtnpklDUmbCQdkOVzzdEH+G2L8cC7uxuFLdYqtE7CgEFtKpGNjmqR+OTb383DaJxki5GZdq9fh3aFy4aey9qDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFXVMvdX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee9bca8675so11214381fa.3;
        Wed, 17 Jul 2024 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721234773; x=1721839573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2S0ab5SdmVZu6CHXw0oDlN+TBmAuaYsarb+i1qS+Q+I=;
        b=LFXVMvdXZ9az8v+HdDH7pcprQIEMnFBR1LKVxZk2C/p436uaXenFiVw/vxx5mDxdlU
         BPKwdbM6qd6SN2Yb3zHciHSC2Xr9y/nqDsAfISdJuuPxWZhpxPhpIwH83Lq8irneSPo0
         OKz9zv8Edi2nvGHVR7lBjm+Tbaxrqnfckjmml5+IKqUM2fR1ZK7eG8yvV5V830kwNiEM
         iu9tBwmu5keIUAYrC/TREGPSLVQ3Pw1wFr/AtX484nKNbezy1OrUdxDaDy6ZiZs1wqDG
         dmAzBL3jwiqKJV/VeaK+krMJDzZ3xHr9dV5RTgSos/SiT5y8sqVBXSiHwagT7XMO+Qa7
         hWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721234773; x=1721839573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2S0ab5SdmVZu6CHXw0oDlN+TBmAuaYsarb+i1qS+Q+I=;
        b=CbxwQfDv67GPeLV3eptcA8pXvdo9IeiFalYh7eUzB2iB3elIjOyns/ryxlRCz97und
         rvXUvhigfqHGE3RmBaJ6f3sk6DayjobMmPBz+D+sN7b9Z6qfCRmmallmt49+njeD7YhN
         SH5+Nf8vE9QyrBbxJaG/A+KOap/KwbddcTvCtEWOJpSmNuecS1Hdyxs4rQsp/aK+hDcj
         B7tdq5Tv0Z+HdWC3hYsn/OGSuqkiiWMtnCtBxwzdCM35WKAx+qRU8N7PgsNV36n6PfNo
         eBLE0R+AswpRCrPzbYtggDPSNX7UOZtMOXHjzOgmetOnm+gYI3TMP/fctJFKoLm7ExC7
         rCfA==
X-Forwarded-Encrypted: i=1; AJvYcCWh2HbOq5hZ3rAPv6bW6AbiFVz0gT4BBRFT8xyY0VVgdnhtSHkGlwTDZ0MAny7Bo1R2gS8PDIQVTcA+@vger.kernel.org
X-Gm-Message-State: AOJu0YxOFEoYo739t/hcG1PCR3GDRSa8C5oQIU0UOQAUhAunyJPN01Ij
	mkxqBmXJe6+fdn+TbnUFAhN6KHz5gvNtNVI29WtveT14bQWWkqHFGmPpYmGoEkkMuD1J2Wdd9FO
	uYlX2XYsFFlXQ2kFjwry4U45Yn2w=
X-Google-Smtp-Source: AGHT+IHoe46620+UsVuITlGPh3/c/KNcEkZ5F6Uq8F7R6XszLx9r5KYDXHcT2MQwJr48RLgG03dD62MwkhoqroWKBWc=
X-Received: by 2002:a2e:6e15:0:b0:2ec:4399:9bfc with SMTP id
 38308e7fff4ca-2ef05997667mr23791fa.0.1721234772478; Wed, 17 Jul 2024 09:46:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717-anvil-ashy-544e80a1317c@spud> <20240717-parrot-malt-83cc04bf6b36@spud>
In-Reply-To: <20240717-parrot-malt-83cc04bf6b36@spud>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 17 Jul 2024 13:46:00 -0300
Message-ID: <CAOMZO5DuwjQxMG4dT-_HcLjA_4U-+B2kR8FW1580RFiHcxo6OQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] ARM: dts: rockchip: remove unlikly-to-exist DAC
 from elgin-r1
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	imx@lists.linux.dev, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 6:38=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> The Rohm dh2228fv (really the bh2228fv, the compatible in the kernel has
> a typo) does not support frequencies above 10 MHz, nor per the
> datasheet appear to use either CPOL or CPHA. I suspect that this
> devicetree is abusing the compatible in order to bind the spidev driver
> in Linux. Pretending to have devices on a board for this purpose is not
> acceptable, so remove it.

In the Subject: s/unlikly/unlikely

Reviewed-by: Fabio Estevam <festevam@gmail.com>

