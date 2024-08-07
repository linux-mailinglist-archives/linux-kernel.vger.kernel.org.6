Return-Path: <linux-kernel+bounces-277866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E85C94A778
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFC3282518
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D611E4EFC;
	Wed,  7 Aug 2024 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lwq8vWOF"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23181CCB45;
	Wed,  7 Aug 2024 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032399; cv=none; b=ivMa5xf/KZQV71VZml5gzfA7mVlR64G5iqiHZrC2yL5etODzYBAAxWHI7vLijZSAG8XQnYU4UobSiM09lvBneKvUcbO3Pn7BaPWWka9j3XuxKWgHYnhm4BZR+sT/mnYQiMgZmeS0HLCyFOk/t9HLqNZA/NbI62IPHeQdM/n02wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032399; c=relaxed/simple;
	bh=NqaeRJxrKLshN3O8m7T4cHmnxxaz08WSujuk7GonzdE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC5ZyjOahD9ckINN1XftXuPIKQAnDi89WtaVkA8S8oeUJwfNmJ7mvXIYYEtoUhqP/ZAM/kGSO3wNYBE6vGVhY5xpygCGXVjaxRXU9EnjX+Un5TSIBy2Fz0+xEFFPrHj4q9cNh47AADwQdmMpggQivfvF9S0kL/QnouZbnYzrnlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Lwq8vWOF; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477C6UpK125230;
	Wed, 7 Aug 2024 07:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723032390;
	bh=QMMqtZrfUcjL064kj54pKnGZthS74Ldp2uNpvqAiPMM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Lwq8vWOFqcT+/tqKGTK37cpEkzARgx9yU/x/xv2xO32b3f3fk1DSXW1+0/sTdO22P
	 O/fLFllCcYBPdMvQ3DPUN6jmWm2YbozEoglyotA/6EjQ7qnpnp0cKOrbG8v8wbgu3E
	 VYh0KqcbcjMob3xb2+hLbqC2wvLl6YuPjg7OuHio=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477C6U6r068329
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 07:06:30 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 07:06:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 07:06:29 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477C6TD3126716;
	Wed, 7 Aug 2024 07:06:29 -0500
Date: Wed, 7 Aug 2024 07:06:29 -0500
From: Nishanth Menon <nm@ti.com>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
Subject: Re: [PATCH v3 9/9] arm64: dts: ti: Add support for J742S2 EVM board
Message-ID: <20240807120629.3bo2cu3wlpkixwrp@flattered>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
 <20240731-b4-upstream-j742s2-v3-9-da7fe3aa9e90@ti.com>
 <489a9116-0e13-456f-992f-3e265acd9253@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <489a9116-0e13-456f-992f-3e265acd9253@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 15:11-20240807, Beleswar Prasad Padhi wrote:
> For series,
> Reviewed-By: Beleswar Padhi <b-padhi@ti.com>
[...]
> > +/ {
> > +	model = "Texas Instruments J742S2 EVM";
> > +	compatible = "ti,j742s2-evm", "ti,j742s2";
> > +
> > +	memory@80000000 {
> > +		device_type = "memory";
> > +		bootph-all;
> > +		/* 16G RAM */
> > +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> > +		      <0x00000008 0x80000000 0x00000003 0x80000000>;

Sigh.. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

1. "compatible" <- not present
2. "reg" <- present
3. "ranges" <- not present
4. Standard/common properties (defined by common bindings, e.g. without
   vendor-prefixes) <- bootph-all and device_type
5. Vendor-specific properties -> not present
6. "status" (if applicable) -> not present
7. Child nodes, where each node is preceded with a blank line -> not
present

So:

	/* 16G RAM */
	reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
	      <0x00000008 0x80000000 0x00000003 0x80000000>;
	device_type = "memory";
	bootph-all;

??

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

