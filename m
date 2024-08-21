Return-Path: <linux-kernel+bounces-295975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234595A3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE122854E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5FB1B253B;
	Wed, 21 Aug 2024 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lLAMoL3w"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543E1494D1;
	Wed, 21 Aug 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261076; cv=none; b=c0cXBOWsb2UXuKRX+GYfqXWu4QxUg4n+7k3CDAiJE4lmUc0JhzwSPPruXe2jwqjzqbPgRI32QUFxlla+ywMqF6apjtD9lqZd6lCIe/Ts9BPXKoLEcGVnHvH0VmuHwHjSIs6D72pWu2NA+2pd9Sa+pXLb8xLOgwtxiYYiUkL77D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261076; c=relaxed/simple;
	bh=H7HWs2F0AUAuFfUx9gmUQwZMuy9PXh3K7F9aCWky72I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fyPfATymrlcmDwIITYx8cF4yw0GYzT8cFC1tZbu1CwlXnD1nCamHMWw1+l1YfMD7NyWZLSemxeSRhCgZ6hSUoiE2QsaDYGoEBoe70Q2QEXrwgDXvCIPasjUu7CkFGdjNuqcfjZSgfr/BjIf8BBfYU96X6YoxWrpyvcwxAbfYAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lLAMoL3w; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LHONMN014431;
	Wed, 21 Aug 2024 12:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724261063;
	bh=oQGkPxqOsFa04DuZjGzKWhjD4u7KkH85pN8rbcge43Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lLAMoL3wrXTTaioWoKLJq5SihztW6QW63jh5oeGt+IhAZOuiZSfKvI5Jz1SXnbyil
	 dm+CZp/NUhfSpWR0JQsmn8ZZp6o5BF913cAbjS7xQvshODTfs20rNDq4HqP6f2MuH8
	 qdBGjV+TP0Vaqk8+QU1SSQqeDZqHSYxliovQJ6Mg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LHON75001371
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 12:24:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 12:24:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 12:24:23 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LHONFG049791;
	Wed, 21 Aug 2024 12:24:23 -0500
Message-ID: <23ac28aa-cd6e-41e3-ba26-d0a4c02d12fa@ti.com>
Date: Wed, 21 Aug 2024 12:24:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: k3-am654-idk: Add Support for MCAN
To: Nishanth Menon <nm@ti.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka
	<jan.kiszka@siemens.com>,
        Bhavya Kapoor <b-kapoor@ti.com>
References: <20240820193420.29184-1-jm@ti.com>
 <20240821110149.yk3da663fek2a4sy@attitude>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240821110149.yk3da663fek2a4sy@attitude>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On 8/21/24 6:01 AM, Nishanth Menon wrote:
> On 14:34-20240820, Judith Mendez wrote:
> [...]
> 
>> +&m_can1 {
>> +	status = "okay";
> 
> NAK!
> 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

Will fix in v2, thanks.
~ Judith


>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mcu_mcan1_pins_default>;
>> +	phys = <&transceiver2>;


