Return-Path: <linux-kernel+bounces-379248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2857E9ADC00
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576491C21F42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF3817D340;
	Thu, 24 Oct 2024 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="BvuGKwKm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tj/GtwTb"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA93176AB9;
	Thu, 24 Oct 2024 06:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750836; cv=none; b=Lt1yc/uQNTvwSMdNMb5LbFNt2OLIA0VRA8nSe7nEHd5smhSk5fTEiRq2LJ6xpUlgcwYJ3riGY4weNX9Ze2iyZlR/eUNaddIyufd1mgljkk9Wi9yRwgmc7bIQWH83OJQZXgPGPxEMNGrw7jNAHVmR+AFEtanIBnL40JZ0ufj2qFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750836; c=relaxed/simple;
	bh=QihDfc0zG+yQhaMjUpH54lbu6ws7YJ3TULK9ohfEJH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gu7o5p3dLigwa8dDIQ2W8t1lYLnFNF2gQMl7gUYE6crXRmyL7JYUUwHFTM03MnGHPqJx51oAF2dqtcU5XPaxirHBE6i/5XQozmnwKqvasYKw5Q9bVaU9CbcoOr/MNalYbd7CeQXGML+APIBdVS75opAvnADKbBNm5Rb1+A0653w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=BvuGKwKm; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=tj/GtwTb reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729750834; x=1761286834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pMfzafKl2ILaN+gwwJJ2kgFQaW+qwP6JHJK7Tm1XA7k=;
  b=BvuGKwKmBqR0ViT+j0T+qpdwk6tCvtcVootVS2WxAkqxVk0QPke2GFeF
   LbdvNzJu4JcNIEy8FHn7LW3bo4ZMRGLkw69FCj84CBbh8rH59kaHZitH+
   E1uBXd7p2HgdG76ixJ0ejBRmcvfl3W9cx5BxM5oSvLwhz5eBERiBhYPP5
   J/38ES9cOVjJqFyopOiG7RIEn1qWDECrjnBXJaNVtnpTHCeuo6jviw7zI
   6O2l5Bu2fBu4iEhBgIZclVYuqNT9y/jTFKuZZY4EikAgFDYHTcK8Q7o0D
   hAGhmU8yT7s4uJXUztV0zMIkGXL6cTPE9noVXA+4bQ8UHnUtntqreARit
   g==;
X-CSE-ConnectionGUID: 4t7TM3LLTQOFvyqzOO/sFg==
X-CSE-MsgGUID: d+7AR5vQR0iTc9Djlj4mtQ==
X-IronPort-AV: E=Sophos;i="6.11,228,1725314400"; 
   d="scan'208";a="39639020"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Oct 2024 08:20:31 +0200
X-CheckPoint: {6719E72F-37-65F98A6A-FADAF7F3}
X-MAIL-CPID: 0FEE07E58522C4DBB3A2AD6C0E15FC33_5
X-Control-Analysis: str=0001.0A682F22.6719E730.0018,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E71C1634B9;
	Thu, 24 Oct 2024 08:20:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729750827;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pMfzafKl2ILaN+gwwJJ2kgFQaW+qwP6JHJK7Tm1XA7k=;
	b=tj/GtwTbL6gXVdNLJ7gPB655tbNog4tCcAeAwFEev5BSFEW/01KjHsPVrw5AurDWZSq5Nc
	J9kwhzdgsloufRxgDEHn2v8ZZTd0oTQKtmBlj5eNNneJSK7KEsq3NOX4GsGoL9Ze7xgv+I
	d2BS8HZuG6HUdT+tTyZfkmevhOkEYJJU9qDsFDQpnjZVaPwbinH5VsZF8u8QIIct580soN
	SMzM7AmMZNSpqQ8USFf9sbBbdAKIzU+YthW/U/uLRiQaVXhVS/NdmXw5MqUG2RoojSaGbC
	1uB4iT5YdDvhWRCIafEu+lajgKzXTiye8Y043ouc9VURWOApIre5e+o57c621Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
Cc: daniel.lezcano@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: timer: fsl,imxgpt: Document fsl,imx35-gpt
Date: Thu, 24 Oct 2024 08:20:26 +0200
Message-ID: <2203796.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20241023185841.1183706-2-festevam@gmail.com>
References: <20241023185841.1183706-1-festevam@gmail.com> <20241023185841.1183706-2-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Fabio,

thanks for the patch.

Am Mittwoch, 23. Oktober 2024, 20:58:41 CEST schrieb Fabio Estevam:
> The i.MX35 General Purpose Timer is compatible with i.MX31.
>=20
> Document the fsl,imx35-gpt compatible.
>=20
> This fixes the following dt-schema warning:
>=20
> timer@53f90000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx35-gpt', 'fsl,imx31-gpt'] is too long
> 	'fsl,imx1-gpt' was expected
> 	'fsl,imx21-gpt' was expected
> 	'fsl,imx27-gpt' was expected
> 	'fsl,imx31-gpt' was expected
> 	'fsl,imx35-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt', 'fsl,im=
x51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
> 	'fsl,imx6dl-gpt' was expected
> 	'fsl,imx35-gpt' is not one of ['fsl,imx6sl-gpt', 'fsl,imx6sx-gpt', 'fsl,=
imx8mp-gpt', 'fsl,imxrt1050-gpt', 'fsl,imxrt1170-gpt']
> 	'fsl,imx35-gpt' is not one of ['fsl,imx6ul-gpt', 'fsl,imx7d-gpt']
> 	'fsl,imx6sx-gpt' was expected
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Do=
cumentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> index a2fcb1e8e74e..9898dc7ea97b 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
> @@ -21,6 +21,7 @@ properties:
>        - items:
>            - enum:
>                - fsl,imx25-gpt
> +              - fsl,imx35-gpt
>                - fsl,imx50-gpt
>                - fsl,imx51-gpt
>                - fsl,imx53-gpt
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



