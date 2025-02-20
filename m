Return-Path: <linux-kernel+bounces-523447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B300A3D6E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBFC1898346
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6113D1F1307;
	Thu, 20 Feb 2025 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QKYvkgFS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="e4D0OjDS"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0871EE7A9;
	Thu, 20 Feb 2025 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047844; cv=none; b=LA/BS7U8eg8wouQBNdKFIi04s/EnhZTOvGYIXyZL+ekhtmpJUaI/MWSqrTa+rHdvvl+j8KMrgcToKm4LF3FQLXvEnCDBxpb/5rv8o/ceppRPRhqdjSNedjJcl0nRpcNXltbGRVRdMEZEvUE8wnhc2R4mCygJstTswaM2wuHNHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047844; c=relaxed/simple;
	bh=FMrqdU4X4ygtooumfzuVukHhKLau/VpgoB7YFmFsbys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ1QTWj4KAEEmwktwRwv3uahC0J6Dvcg+741+ve1sd0CC+fUXQnB80gu3YZuaMGhmrksIBYQSD2WonB2of/c/JQyVJULLt3GatY8lkouMjGLJBcqJEwXN/jDw/fHY0uOjUPdjGy57bthwJEsPwBS0oomoTbQNNx9nj5uKm7VxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QKYvkgFS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=e4D0OjDS reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740047841; x=1771583841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wh9A1BD/RTEscUaPrQN3XaSi0R1/Qa7MqH53NBxklI0=;
  b=QKYvkgFSi57lgeM1xkPBMaFRjFgxehkG0hrrHmfHlsn+wtbvQt147MiK
   FYqr2qZ5z7OQdgROVPwDlg1B2Hg9hj34hfsrg6UkKeM9Uqnjzp1m9HAT7
   l5AsZ9yv0M/oq4+RvhBrmAzu+WvP5Y90KtADwjCOraOWMd6zyQ7MxxzK4
   68r+23NCKkUA3t1VJkWD5/C0GgeGpVcpE5YrxrBLsllO6NBJs0XPT5r+Q
   wWj9dDfZek94J5VmLj63M522MhxTmWh8BSdn3EF7D/irZaarV9VkFPOlP
   YcD618fMM/3D8igdc2FrZ4/H1WeYCKR+6EVRzMAFg0bFng3QaWwwdd2rA
   A==;
X-CSE-ConnectionGUID: CwnbI0K+RpSL3PTir3jFFQ==
X-CSE-MsgGUID: e3NjdcT0R7yw1SDXUXlCFQ==
X-IronPort-AV: E=Sophos;i="6.13,301,1732575600"; 
   d="scan'208";a="41977185"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 20 Feb 2025 11:37:00 +0100
X-CheckPoint: {67B705CB-2B-B8541F8F-E50F9B0E}
X-MAIL-CPID: 1B5560109A7002A5CA5F1D2F139B739C_2
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC4D6165713;
	Thu, 20 Feb 2025 11:36:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740047815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wh9A1BD/RTEscUaPrQN3XaSi0R1/Qa7MqH53NBxklI0=;
	b=e4D0OjDSA2ZA2GlPxzsqw7tkGSZo29ZHbECBq+JdmCuxym+wVv2+TZDkqLfplc5tSpTR0e
	WtTAKKvnO1SwFM+LEGSmcHVIgFzX2i69wX9Xer2DfxIy8r6H8FLj+WZ7diyyAnEBhd0bTG
	e9jb0QInU+lPP7dXVF1lC1lhyF7uEN8pn4s9p0+eCPzU1S/cqit1zvMCiHMWGwgvZvXrSU
	1QXU66t76OvYPgdFNUlps2CUj8/UhrhunsGGXfQSJ5P2ZPAMaxq29eaF1qINsLrsEi7i5x
	95O1hVVCteRHOEbAhaRi9l/sghRsYJbDlGI1fNDe+sR4sWPgTQ1VN5Z/tBXn+g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: p.zabel@pengutronix.de, robh@kernel.org, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
 shengjiu.wang@nxp.com, Frank.Li@nxp.com, peng.fan@nxp.com,
 laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com,
 Daniel Baluta <daniel.baluta@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: dsp: fsl,dsp: Add resets property
Date: Thu, 20 Feb 2025 11:36:53 +0100
Message-ID: <12614210.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250219192102.423850-3-daniel.baluta@nxp.com>
References:
 <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-3-daniel.baluta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Mittwoch, 19. Februar 2025, 20:20:56 CET schrieb Daniel Baluta:
> On i.MX8MP we introduced support for using a reset controller
> to control DSP operation.
>=20
> This patch adds reset property which is required for i.MX8MP.
>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documen=
tation/devicetree/bindings/dsp/fsl,dsp.yaml
> index ab93ffd3d2e5..923e7f079f1b 100644
> --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> @@ -82,6 +82,13 @@ properties:
>      description:
>        Phandle to syscon block which provide access for processor enablem=
ent
> =20
> +  resets:
> +    description:
> +      A pair consisting of phandle to audio-blk-control and an index ref=
erencing
> +      the DSP Run/Stall bit in audiomix registers.
> +      See include/dt-bindings/reset/imx8mp-reset-audiomix.h for each ind=
ex meaning.
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -164,6 +171,16 @@ allOf:
>              - const: txdb1
>              - const: rxdb0
>              - const: rxdb1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8mp-dsp
> +              - fsl,imx8mp-hifi4
> +    then:
> +      required:
> +        - "resets"
> =20
>  additionalProperties: false
> =20
> @@ -220,5 +237,5 @@ examples:
>                 <&mu2 3 0>;
>        memory-region =3D <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
>                        <&dsp_vdev0vring1>, <&dsp_reserved>;
> -      fsl,dsp-ctrl =3D <&audio_blk_ctrl>;
> +      resets =3D <&audio_blk_ctrl IMX8MP_AUDIOMIX_DSP>;

Am I missing something here? fsl,dsp-ctrl is used to get the regmap from sy=
scon.

Best regards,
Alexander

>      };
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



