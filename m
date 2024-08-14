Return-Path: <linux-kernel+bounces-286492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C50A951B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408BE2873D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462A1B142E;
	Wed, 14 Aug 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cgqqtEkn"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D611AE03E;
	Wed, 14 Aug 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641192; cv=none; b=ZLs1QaFlnLABojcJzAlnzhHND+H4W/2eO6w2FkJbLIF0xGqtDaGRW2DuaUnxzZE/qQtM3EhApGHjBS3nJyrb4Q6GAn5xApih4GbB+J+k+emXIhE4EXjFS2BkZpch9utnm61u2XZt1tlOvea/SZsmjeu7QQJNG2V/KvZZYe/+slI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641192; c=relaxed/simple;
	bh=Lap9RepfxPNbgYgoTk2PQp9C73pLg2NDY7BBW3lLHko=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gUSkYs5forBDuTbjYC4Lty6C/8DmR1/vFUHmBeBMAxcSWC9WBfGHV9VCQ3GpMb5zuNt+/NDEobeEEB9VJkV5CRnc4W55n3nr7op7LLrd/sCf2+a48E0jcBz9blP0A7qt0z6exKpKm7F+gK+maWz6yAAigjHRURY9D3MwCGwNaL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cgqqtEkn; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E5pcXY028298;
	Wed, 14 Aug 2024 08:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=13RG2GUsoWgTGmx65gaXSY4h+Yz3SFHumOMusCTz1q4=; b=
	cgqqtEkncIq40NKKWDlPlem00TigdTNwykXOZ81jXINZ3MDzHorByXh2CPIvQOMu
	4EfLem7MrneaZJQT8bIP8MNNb4mvoBAEQXMgENZMNyyx4slUMsZoTJM0Th9lT8r9
	0s2Qg46WtS7k7YrJnuGuInDVqJcXIYWssx8BoPaSpYotDGVytS0IMVendTlOHQN4
	5E3+K2LUnpCWg+dKDKw/zGL/dXVPTePr+l1LSKayR0BOUwX/qRKPVkEKJz9XIykF
	zsPY4i/NQj00WnHVs8zxKkNo4Zq+zX6Y68Et6HYeIdrL7hriQmmDE3rQ1+ggB+fS
	cm71ecZaXf54y0W+HEoKvw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40x5kwmk2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 08:13:07 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 Aug
 2024 14:13:05 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 14 Aug 2024 14:13:05 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 20EAE820241;
	Wed, 14 Aug 2024 13:13:05 +0000 (UTC)
Message-ID: <155bcc8e-3c53-4554-b359-be7628e4b302@opensource.cirrus.com>
Date: Wed, 14 Aug 2024 14:13:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: serial-multi-instantiate: Don't require
 both I2C and SPI
To: <hdegoede@redhat.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20240813112105.21218-1-rf@opensource.cirrus.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20240813112105.21218-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VyHSoT_88ZEMF4ETj5jQDf1j69xrEGH5
X-Proofpoint-GUID: VyHSoT_88ZEMF4ETj5jQDf1j69xrEGH5
X-Proofpoint-Spam-Reason: safe

On 13/08/2024 12:21, Richard Fitzgerald wrote:
> Change the Kconfig dependency to (I2C || SPI) so that it doesn't
> require both bus subsystems to be enabled. Make a few small changes to
> the code so that the code for a bus is only called if the bus is being
> built.
> 
> When SPI support was added to serial-multi-instantiate it created a
> dependency that both CONFIG_I2C and CONFIG_SPI must be enabled.
> Typically they are, but there's no reason why this should be a
> requirement. A specific kernel build could have only I2C devices or
> only SPI devices. It should be possible to use serial-multi-instantiate
> if only I2C or only SPI is enabled.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>   drivers/platform/x86/Kconfig                  |  2 +-
>   .../platform/x86/serial-multi-instantiate.c   | 32 ++++++++++++++-----
>   2 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 665fa9524986..c286742b34ba 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -999,7 +999,7 @@ config TOPSTAR_LAPTOP
>   
>   config SERIAL_MULTI_INSTANTIATE
>   	tristate "Serial bus multi instantiate pseudo device driver"
> -	depends on I2C && SPI && ACPI
> +	depends on (I2C || SPI) && ACPI

Please don't take this version.
It works better as:

	depends on ACPI
	depends on (I2C && !SPI) || (!I2C && SPI) || (I2C && SPI)

so if I2C or SPI =m then SERIAL_MULTI_INSTANTIATE must be
built as a module.

I will send a V2 with that change.

