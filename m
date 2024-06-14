Return-Path: <linux-kernel+bounces-215393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65838909210
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C3F1F23F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5827219DF5A;
	Fri, 14 Jun 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oXzhxdDB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015017BCC;
	Fri, 14 Jun 2024 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718387914; cv=none; b=XYZ8Gej2jBL+W9qOYB4Y49BTCI3nlbTJ7aDKch88reUGsUu9Ej7rinsx99GvDtWKygCf7FyXjVtLo8OSC9eCATVxdTeOAmbjHopxAqNL21Q/nI7FFuHTF2lfO1O3hT1kTtmDv9U8bmijqS27xInxIxdXM+Bdqv4h/+4jYicqx2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718387914; c=relaxed/simple;
	bh=hX6/vwcDgDP9auvxBpQzIAeam1ik3AqwsVBLxy+OLi0=;
	h=MIME-Version:Content-Type:Date:Message-ID:To:CC:Subject:From:
	 References:In-Reply-To; b=V/MCFXHd5vG5Rvcg0s+gX5wMN46YNMs6e3axFuJlnfJbghFwAm8vt6ZoRqw9i/seqghaiEpr0CpLyyL3ZHZxG/9ilupbll6jXDIN5ZY6GOXmIu2Vfexfw3vN8BAznz1HRuO4mCQp+YcIDmZPbuIqF5htg8v7vh5+Ia4E3oI/fWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oXzhxdDB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EHwMTc074684;
	Fri, 14 Jun 2024 12:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718387902;
	bh=MUF9XJqMkmkQjexFkfnks2orcYMhPl0ETqT57VwcVjo=;
	h=Date:To:CC:Subject:From:References:In-Reply-To;
	b=oXzhxdDBBN6Z7mAKkQRbcBdaAdn6UOWQDBkwBt4nVrAf4qa3npVEYqzTSr2sz6EVg
	 dI8PntyPmFLoiZ+Cir9Ekf8g0I8TCo8FpSHR+NNmbHcBjUDotQ4487NkdDdJIn3b/E
	 HFKc95i4HWN8j68E2KnqZvxe4aipItW+enuzZQbs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EHwMOO024310
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 12:58:22 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 12:58:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 12:58:22 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EHwMHt118346;
	Fri, 14 Jun 2024 12:58:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 Jun 2024 12:58:22 -0500
Message-ID: <D1ZXO8F3XN2I.3CTTE245I0TYY@ti.com>
To: Devarsh Thakkar <devarsht@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>
Subject: Re: [PATCH 0/3] Add global CMA reserve area
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.17.0
References: <20240613150902.2173582-1-devarsht@ti.com>
In-Reply-To: <20240613150902.2173582-1-devarsht@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Thu Jun 13, 2024 at 10:08 AM CDT, Devarsh Thakkar wrote:
> Add global CMA reserve area for AM62x, AM62A and AM62P SoCs.
> These SoCs do not have MMU and hence require contiguous memory pool to
> support various multimedia use-cases.
>
> Brandon Brnich (1):
>   arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of global CMA
>
> Devarsh Thakkar (2):
>   arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of global CMA
>   arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA
>
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 9 +++++++++
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 7 +++++++
>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
>  3 files changed, 24 insertions(+)

I'm still a little torn about putting this allocation into the device tree
directly as the actual required allocation size depends on the task.

If it's allowed though, this series is fine for introducing those changes. =
This
uses the long-tested values we've been using on our tree for a bit now. The=
 only
thing that's a little worrying is the missing range definitions for devices=
 with
more than 32bits of addressable memory as Brandon has pointed out. Once tha=
t's
addressed:

Reviewed-by: Randolph Sapp <rs@ti.com>

Specifying these regions using the kernel cmdline parameter via u-boot was
brought up as a potential workaround. This is fine until you get into distr=
o
boot methods which will almost certainly attempt to override those. I don't
know. Still a little odd. Curious how the community feels about it.

Technically the user or distro can still override it with the cmdline param=
eter
if necessary, so this may be the best way to have a useful default.

