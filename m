Return-Path: <linux-kernel+bounces-552062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF365A574DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37577A85D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D442561DA;
	Fri,  7 Mar 2025 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="illAF1zh"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41823FC68;
	Fri,  7 Mar 2025 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386340; cv=none; b=A9C+GdaRueMddfn83z683W7DprGGd7Z7WUf4IiYfQPMkrVYfpTzfz6oZARYV2Sca9xKXcaC0vf/YT6okgciVmx3x2e0hT+unS4iZvqZSupzBeMVc2GExQqkLhOwSA5wfpFHzZS32BVXB4rGKuFEbIX+xEAptPtMJykHlFOT3GFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386340; c=relaxed/simple;
	bh=xTON+J8OzvrysxuNQRwrqIVwpO/hkAF5UNeOFyp3wXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qGG/9O12Lzuy8y1htLppwpaueLlsJy8IRJ+WAxYw8HPw41IVD83gQCT45uGUuJkZQyrp2DCoH5vNNTHliq21gMGIGyXBzHPkF/na6/SjREmwZ2fJXobymks44DzPystkQtjLVOFqdCoa/gEYCSXpSvzrhSCH6JU3X9N0kCCLnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=illAF1zh; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527MPVlt485179
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 16:25:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741386331;
	bh=f5jKSlZGlGiJXcnUBFmBH70jB0bTGdkoasIi160iUrs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=illAF1zh0Xwf6POhwM3sBNWxWu1razjKqWENqk0zyQO71S2lpVBGF2rkkp5yZFbP1
	 MN36OCYW/i7kXnvrLmrZxYlUBNkwKqvXrXodCoH1kiZ73yGtvXFjb2TeKDt4j2lZug
	 eIf/5tQdzkSqElocuZ/b3A8qbv2rlrrKsaZ4J7Sg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 527MPVcR046961
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Mar 2025 16:25:31 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 16:25:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 16:25:31 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527MPVPW081358;
	Fri, 7 Mar 2025 16:25:31 -0600
Message-ID: <df3842b2-7a7e-4c54-80dc-927c7eb55b3c@ti.com>
Date: Fri, 7 Mar 2025 16:25:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] Add R5F and C7xv device nodes
To: Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Hari
 Nagalla <hnagalla@ti.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>
References: <20250210221530.1234009-1-jm@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250210221530.1234009-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vignesh, all,

On 2/10/25 4:15 PM, Judith Mendez wrote:
> For am62x and am62ax devices, this patch series adds device nodes
> for the R5F subsystem and C7xv DSP subsystem found in their
> respective voltage domain, based on the device TRMs [0][1].
> 
> This patch series also includes patches for enabling IPC for am62x SK,
> am62ax SK, and am62px SK by reserving memory and binding the mailbox
> assignments for each remote core.
> 
> Also reserve timers used by C7x DSP for am62ax SK board and timers used
> by MCU FW for AM642 SK and EVM boards as per firmware requirements.
> 

Is it at all possible to only pick the first 4 patches of this series
that only enable the core nodes?

I will respin the rest of the series in a different patch series.

~ Judith



