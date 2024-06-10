Return-Path: <linux-kernel+bounces-208519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F37390264C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F16B2C5F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8E1411DF;
	Mon, 10 Jun 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SvRgusrj"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AAF13E3F2;
	Mon, 10 Jun 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034987; cv=none; b=KWvR8KbYbJX8l+rGe0H3eVpGwr6Y2/K33r9CsV73tsOGiZ6qEwt+HuH3FnRt9m8YpFUaGfP5xKU35fRcaeGDlSks/mGFaQoVBdgHjNiJUx+1XQFRv3wy2BlIi1+b1zEhBlCAWtmVhUypOknJk0bK60Lkg/i6qx7nMssts0mF/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034987; c=relaxed/simple;
	bh=NdsLQXtIKnQUgcAMngPqTOE8svKUVkptCdvAQ9EX1sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MBVQUEj02pYyXavcxHIMwKJ9Bwg6XsCmzHQnpootSNGm3Ysi01SeFfBORFxdBELSy0kVQz64L86lGTId934jy8matu+NsaBGVVioMxAFtz59AaoU5X7gX2dcmOkfUlVi0PgjCCzthi1+yhMM2aduvti7W5EYkPggsvRzflEBOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SvRgusrj; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AFuACL011756;
	Mon, 10 Jun 2024 10:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718034970;
	bh=7074N/sdQ0CvMJHsCbj+7QDe2Ffm0Xx9w9h9wwazciM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SvRgusrj2t9r/NnEedCblXvdrKOfr5xlMkPqSOjIwqaf55IEDdDPF1hdg26b1vnos
	 4GXJQRHjavMpsfkHz+FS/WqMEStb64RPAw4mOobq4xAUMm24U0GZfw7/qxIh6zmSe5
	 edwMpVra1tohi0lsFhjsS1/rKbo4cDxWFuQtqNPU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AFuATR046511
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 10:56:10 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 10:56:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 10:56:10 -0500
Received: from [10.249.48.175] ([10.249.48.175])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AFuAaa074284;
	Mon, 10 Jun 2024 10:56:10 -0500
Message-ID: <4405d53a-bb9b-24bc-9bbc-b5dbecefdba4@ti.com>
Date: Mon, 10 Jun 2024 10:56:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 4/4] arm64: dts: ti: k3-am62a7-sk: Enable ipc with
 remote proc nodes
Content-Language: en-US
To: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20240605124859.3034-1-hnagalla@ti.com>
 <20240605124859.3034-5-hnagalla@ti.com>
 <1b03ae72-b1c4-4165-b3cc-df85255b9dbf@ti.com>
From: Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <1b03ae72-b1c4-4165-b3cc-df85255b9dbf@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/10/24 02:02, Vignesh Raghavendra wrote:
>> Reserve memory for remote rpoc IPC and bind the mailbox assignments
>> for each remote proc. Two memory regions are reserved for each
>> remote processor. The first region of 1Mb of memory is used for Vring
> s/1Mb/1MB?
> 
Yes, will correct it to 1MB.

 >> +			reg = <0x00 0x99900000 0x00 0x01efffff>;
 > 0x01efffff -> are you sure this is correct? Just missing a byte to a
 > nice round number size. looks like typo of using range vs size?
 >
You are right. Will round it to 0x01f00000.

