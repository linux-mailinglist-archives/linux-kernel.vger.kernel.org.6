Return-Path: <linux-kernel+bounces-185758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F268CBA4D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C617A2827EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8D757E5;
	Wed, 22 May 2024 04:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kNwwZBHH"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC026AC8
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716351733; cv=none; b=XOVgBnr+XsCrsIioeRwbQLQQZr3sex25Go+er7WO/YPLeY8IIxGzXc/WVk3x2m/FYGiSZTnLz2TlBuYzhHKbdtUj2m1vVJCyCEUqVIK40dsAgybsQSSiYHzgyndGzu9yMKWMoivL5I7yljLtARNbwnq93a5bWqgsfXRi20fqiJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716351733; c=relaxed/simple;
	bh=CajTorZd9DLhM87nuJXW641UKTLCA2TVF9Pd1/r9uFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pPCesXguzTKiTVsc/AMNy8op1aV6XLzEIWnLlCt07w38Jt7hxrcDbgZYI5PdPrRCLHLALUKp4DOWb6QnhixUL9gx+lAqLbjrQP+JRVhjfGxEFA0n69itZwsallg9rOulkpwXWETmThuFswcTqpFB1Qmvc7qCAZXRocQAo73QSPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kNwwZBHH; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44M4M6WT111115;
	Tue, 21 May 2024 23:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716351726;
	bh=IUts+h7Fpx2A3SV0Ok1ITsD74fx1a6VGbL7IDuYR13k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=kNwwZBHHaEhl+fA9Ty8Uuw9tB4P/Qs9O5PR3jJcC0+eL9xyOVMkenTbjGzHVoJrT/
	 PyVXyqOYBmVJTtFjOdqI9jZGZ90kck952JJSHXBIYkwk6uAIQ5kN/kLnOgAaXkPBjK
	 ZdF1uigHYUrOaN4AOFZnTeFxC+/AZItMQpyGdjGw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44M4M6Ai009804
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 May 2024 23:22:06 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 23:22:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 23:22:06 -0500
Received: from [10.250.224.68] ([10.250.224.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44M4M12c026261;
	Tue, 21 May 2024 23:22:02 -0500
Message-ID: <b46f3643-f2e9-48ce-b326-fa456ec41700@ti.com>
Date: Wed, 22 May 2024 09:52:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: regulator: tps6594-regulator: Correct
 multi-phase configuration
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <jneanne@baylibre.com>, <eblanc@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <j-keerthy@ti.com>
References: <20240521094758.2190331-1-n-francis@ti.com>
 <ecf39bd8-5a97-410f-9dd3-3c63d60b723c@sirena.org.uk>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <ecf39bd8-5a97-410f-9dd3-3c63d60b723c@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Mark

On 21-May-24 4:57 PM, Mark Brown wrote:
> On Tue, May 21, 2024 at 03:17:58PM +0530, Neha Malcom Francis wrote:
>> According to the TPS6594 PMIC Manual (linked) 8.3.2.1.4 Multi-Phase BUCK
>> Regulator Configurations section, the PMIC ignores all the other bucks'
>> except the primary buck's regulator registers. This is BUCK1 for
>> configurations BUCK12, BUCK123 and BUCK1234 while it is BUCK3 for
>> BUCK34. Correct the registers mapped for these configurations
>> accordingly.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Sorry about this, thanks for explaining; I will definitely take care the 
next time.

-- 
Thanking You
Neha Malcom Francis

