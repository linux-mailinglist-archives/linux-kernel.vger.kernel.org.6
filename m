Return-Path: <linux-kernel+bounces-268704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21CD94281B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E171C22B59
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ACA1A76CF;
	Wed, 31 Jul 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ARYNlTtR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iJF8x8QE"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06721A7207;
	Wed, 31 Jul 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411298; cv=none; b=WPEM/79apJLrRMoeCJzFKommyS4whQuQFGexpQRxOMMkcLiZcMRuvBFm+8/SDLhdL1WjOT+PNfWntiPTF2+PW7Q+oanTjrnHL8h6uhsrxNhSCKrGQSZv9w22H1JhYajQqA1ij9fPVYwZaCGIk+wvGRfojVrjUk0y560RJaQmi4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411298; c=relaxed/simple;
	bh=ozN94OUaSV+qUnOWTJkp/n0iGRlevsBOJu6CRBHDP9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tm4a8w6IBsjHP3eP1h/JLJJjpJirVLQlBbhZ7rQ2XgXqvYE2mN6OPlWbcNJW7wwI35Nzvpqlw3vle5eM1ujYCljxZU6qOgVLE+KYuBpnf3NveVoD74nhrT+lyfsUPko8m2UeIjH59PhGv6l0KrjWO2kW/W4nYCJvLkAYLTkPY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ARYNlTtR; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=iJF8x8QE reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1722411294; x=1753947294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ozN94OUaSV+qUnOWTJkp/n0iGRlevsBOJu6CRBHDP9A=;
  b=ARYNlTtR4hLxl64sjP4bvJW9NCqQEZ/vVPUgUkRWa2ouE90RKZF6X0ze
   blgv/Urswz+Vu1CP12tAgXuVFwly9QB77rgGQzp67JXWxZwA+AiByARgt
   u5RmtwnXkB2ZlP5Mfzg6HaRnQ32CJXNlc41T1R4X9/jLAg8nXZwHWR6Y4
   G3DEqLjUBVspPsK5A7ORW9bVtI1bq/YkLcTKd/qiD0p1afNtpQRkmCa1D
   NTerym4XUwlI2RwxoXvocUZLH+3hoZkmLS37NgLHDsILZTNryCnFyRLQx
   /mdrT89yWxoE8QZwECv4zRreC4VRU0WbeZQmNSu+JnMaH5gplWfNZ+Rdo
   A==;
X-CSE-ConnectionGUID: zeSNXCMjSQOP8X8w9cXcCA==
X-CSE-MsgGUID: Q1I8fI1RSjO/+CPpEouPEw==
X-IronPort-AV: E=Sophos;i="6.09,250,1716242400"; 
   d="scan'208";a="38163919"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 31 Jul 2024 09:34:51 +0200
X-CheckPoint: {66A9E91B-16-CA1431AC-CF855369}
X-MAIL-CPID: F72C2235984EF8E6293148F69F44A936_1
X-Control-Analysis: str=0001.0A782F1B.66A9E91B.00F1,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8FDE1164654;
	Wed, 31 Jul 2024 09:34:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1722411287;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ozN94OUaSV+qUnOWTJkp/n0iGRlevsBOJu6CRBHDP9A=;
	b=iJF8x8QEiMpj/SoZW5+stk7l4LElzGnPSvrp5kRRKLsIgc47Foe2/M0skGZTTEGVE/WjoM
	D5sjQFjvZeUnrNA+/rg3GVrW041b7LI8DQsBnWC/cQZ/e3OzNhQoUZj6NFGmtxDgQhfyOH
	R8tuhofoOzdcpWsqO4Q8a0dwhRhfUT7PkNKpirGjF7G53n+PZ5lwPRBd6V37XymRdF7aQh
	ijFygVkpNukehGGQwhWNlWJUfu+3PeDLlmUrqDPesUSWYYUw6arazguUd4xXR0SwetAFEC
	7KMfuO+4TW3neMhwtBapxMryPf6Epp4+NaoJ31rRYBFFvMY7TWMzjOFBPLbi5w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: usb: microchip, usb2514: Add USB2517 compatible
Date: Wed, 31 Jul 2024 09:34:47 +0200
Message-ID: <6694660.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <54a4f7a5-6c56-48da-bc28-d01f39d9ec5b@kernel.org>
References: <20240731071950.989113-1-alexander.stein@ew.tq-group.com> <6728a670-84aa-4b1c-8aa5-1cde84b97adf@kernel.org> <54a4f7a5-6c56-48da-bc28-d01f39d9ec5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Mittwoch, 31. Juli 2024, 09:32:43 CEST schrieb Krzysztof Kozlowski:
> On 31/07/2024 09:27, Krzysztof Kozlowski wrote:
> > On 31/07/2024 09:19, Alexander Stein wrote:
> >> USB2517 is a 7-port variant of this USB hub. Add an USB compatible
> >> based on USB vendor & product ID.
> >>
> >> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> >=20
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Of course assuming there is some user? If so, where?

There is: arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
introduced by commit ba9943f47dca1 ("arm64: dts: mba93xxla: Add USB support=
")

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



