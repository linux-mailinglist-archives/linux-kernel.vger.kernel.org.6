Return-Path: <linux-kernel+bounces-219129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EFC90CA31
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5631D28FEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742AE1A01AE;
	Tue, 18 Jun 2024 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GjMv9Zff"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5110185E41;
	Tue, 18 Jun 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709354; cv=none; b=VlCxsobUcZQnnCd1PGbwPw2AI25d0VjmUe9jHpIECCTxfrl4aBfmBn/4ueGXJA5Md7RYtUqbR0HcBmM/cv7qDixTtbqI6/lzNmfraEZ0JdJUg9CRjCA8hPwnPRCyydCVymDRnIjarBbTPzJpgh3Y7hHjKGuJLeUbq3pGK8EKKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709354; c=relaxed/simple;
	bh=F4NhbZMhSvsAaBCFiLDNXUS9NF6/dJGgw3SGBItPegk=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MzAGUwucGo7HCnzAxPxVmzaoGp539nsXZhm2scbi3DY+KPPAa4FfqTv50BhA/Yb1th/C3a2RG23aChaqueUu1DFiU/0uO2+3QgwNo1+vbptR5NS8YxLVghT3d4IhJZRqZzwNY+oI2xl+Rxrcoe9y75+qAv1Z2QmH6j6AoNsIZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GjMv9Zff; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IBFcuS068163;
	Tue, 18 Jun 2024 06:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718709338;
	bh=6oEPijPeMPuJpSxdn941nytivFxKbLXY2sXGxYO7DlM=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=GjMv9ZffGdmi1I+Ik5liPCb/gS48xXHDfzZHCA3cYuzbSUA1sYu9aN+8bM676GtVQ
	 IDCJxx3vYKXA0dnF354L0Yfy9ZgaThjig5X+Fgr+A2Afj+pvnGjyEUrw0o+A2wdKC3
	 j1O0I4hey4Ddqbw/vHfKP6vjJwOMQNdEtJOBI/kA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IBFcXo101484
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 06:15:38 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 06:15:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 06:15:38 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IBFbcC030601;
	Tue, 18 Jun 2024 06:15:37 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a-main: Enable crypto accelerator
In-Reply-To: <d7eb6b3b-13b5-4587-a2f1-83fe3b30dc21@kernel.org>
References: <20240617-crytpo-am62a-v1-1-ddb719aed71b@ti.com>
 <d7eb6b3b-13b5-4587-a2f1-83fe3b30dc21@kernel.org>
Date: Tue, 18 Jun 2024 16:45:36 +0530
Message-ID: <87jzim4i3r.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Krzysztof Kozlowski <krzk@kernel.org> writes:

...
>> +	crypto: crypto@40900000 {
>> +		compatible = "ti,am62-sa3ul";
>> +		reg = <0x00 0x40900000 0x00 0x1200>;
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
>
> Why do you need ranges? No children here.
Thanks for correcting, Krzysztof.

This got carried from a device with child node.
Sending a v2.

Kamlesh
>
> Anyway, keep the order as in DTS coding style.
>
>
> Best regards,
> Krzysztof

