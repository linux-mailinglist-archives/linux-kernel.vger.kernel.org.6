Return-Path: <linux-kernel+bounces-359369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D82998AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86BA1F25749
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA831CB526;
	Thu, 10 Oct 2024 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="BoG6Q6tm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="qzQ9HpE+"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AB1CB305
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572046; cv=fail; b=s6akFzhPtidYHsynNxgD4MPZQv1Ufb2ABieo8QKsSmZ0uKlzA6yGR8jeFA9aE0y3KXVlLmgLeNEH9EjnLqJHvHahQ16GLI02bFN2ujFcjXkXOH+xpiqJyyzefZlao5981uUJ23vwG2Us5T4noo4SDbL2m1c3c1UoY+m2Z6Kl0qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572046; c=relaxed/simple;
	bh=TrcPH/TwtEiOLOfaCCBgkConQjqnGWucq2/v0aCef6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DDLJIil2FTbtnL0UDKglsh84ZZw8DS+ld9WMLI2/B6iuSzCD7WV0cbbYIKaUPbx7yCSB8ja0CbLy0rKCN7bJhwfsbvdX0Q8TVY3gDEfrymFMU+V5V8sK3521z/Naa3Cs0PaTCTpgV+lxy+0PpAOZygs7ee7DB63WKjXJnIVhhHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=BoG6Q6tm; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=qzQ9HpE+ reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 48E6A2B7BF7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:53:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728572036;
	bh=TrcPH/TwtEiOLOfaCCBgkConQjqnGWucq2/v0aCef6c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BoG6Q6tmS8+dDJv+ZWPfxSCE4E1A72oknDQ0w46dXeTc4U5iYfyzCGFCHsj474oKB
	 CBh9hiGG90IyvL+5hnIfUkdogXfwao1RJbD9MgXk/mcueSklZKx4DQPspgAuwqLbgL
	 wVVBVAUT3tEzD6vxn2+bENOMfGZxOK2Yi9zrNKOs=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id E4A152B814A; Thu, 10 Oct 2024 16:53:55 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012049.outbound.protection.outlook.com
 [40.93.76.49]) by fx403.security-mail.net (Postfix) with ESMTPS id
 D90502B7D66; Thu, 10 Oct 2024 16:53:54 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2915.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:38::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19; Thu, 10 Oct
 2024 14:53:53 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8048.013; Thu, 10 Oct
 2024 14:53:53 +0000
X-Secumail-id: <f7ea.6707ea82.d6d6f.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGUWBZtZy5IGWiQL69UO4PA8gXk8dFlw7IjDrqUMIIJn+/67tARPF+53SB90f4msIjV3d9Q87JxGfS3vHtbvpmOom6dNeWpPG5hs1wsu7SAHpQkwV2zcnfBi+QJigDfwvhz626NSbdinZIqDpgYlQ1xP6zS5uyu41LPPIF0jczppKlDnOZeH0CXFBvOUxSBa1HzNk0DXChWCfS5lmnZvsbHweMk6qoXmk+3wtfOOgPATqFVG67nMbyI3yO9dGwDmH1y03gWfaQfmU0dfufWamCx10dNfgrAU+fyQzBLfsACR0v/xmF4tz37RZq4jH6gaNvb/hl5xtC5gvUxDD8HGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj7AoXQXHK6ptYmsXynnCfWQTzUviXo/P8yDonxl6W8=;
 b=lfNEIJf3uSe8i+UmmS74zh/XtFI6NTE90Q+6AQgaSBgb+bYRjpJB1OOZ0nqsxg4VTQQd3C6MqIWDsFrgyWGH0Vn8quRIGarQqwSWQ0HiuLQFtcclHb+bgAvZfjeuX233Q8c45Vaxkmx4XkQ8AORepsFN/qLT6glLW9175SE1tPdVmv5YPuyIr+LOgQfi03mmTN8Z46BnZJz0t88BAM6xWYCvX/qgQ93Ay0Rr/R/SRelUg14n9zvRdNUrxV5KXUfIG6FZez9BIiRRoKItLDDW9VEpMuf3nt7typ0HaSSJgxcTQk8HMcUE/Mzw3me3GX+nhtPpm3oZaVg5uCQSpU+H1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj7AoXQXHK6ptYmsXynnCfWQTzUviXo/P8yDonxl6W8=;
 b=qzQ9HpE+SJjCend2WOgfhAcJFqDTbYYGzPDXv2Aj6U8xAKQeawz4x2Mtt2i//HYdyKK0YbYZzQ98Ib/6WxaE42ez64uaFo9pf2PUN6qUZ4nk2BBfvekMuhitTx+XYrwmlv+eaaeS9lF5nAPe/tc/VILiIl/18rFgQeEC/5q3InvwI/ZW+jnTxy+azWT5gPo5Z9JsEFKQdQrWC42c8QbHb+yE3S1G5e3HMFWdRz7LApkuPrAJazJM8KkNymvMZwbjnix3Oo963raJ/QCisMxJADYtC9ISFv53cCtktB/aS7JwxLudlHWiKdOJwiVW86VbmOwbIF9zdExrnEEDFKk6WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <ac39c5f3-4ced-449e-8a42-45641b8243c4@kalrayinc.com>
Date: Thu, 10 Oct 2024 16:53:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead
 of UML
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, Yann Sionneau
 <ysionneau@kalrayinc.com>
References: <20241010124601.700528-1-jvetter@kalrayinc.com>
 <877cag11zb.wl-tiwai@suse.de>
Content-Language: en-us
From: Julian Vetter <jvetter@kalrayinc.com>
In-Reply-To: <877cag11zb.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB2915:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfa9bae-d767-4ce8-ea7a-08dce93b5bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: sn/BstGKjfYYCiGSxwj/5RBZeboo1PW5MZllj/otmvscxGi4+Uyxy+0XtzHm/F1zfDFbqzCfBPEJXvTd9xo3aWPJXJ9AZvWrC/z+rj+0CDvN1QTchWMhEWcztI+Xepie+RyY4CXAbVZ3WPNFfvEnByh3QXjHygkGQGugDBfWZU04PUQEghzBoFCXiAF2HUBLeXBJ3K3oDDz5Y7YFVSKzTWv/cRfHi8xqRFVyQacwqRekdjUelxPLS/cB1gF85033uroNFXfzuEFQxOpA/AWMNkzNbdPEfHD6cvS9moV0sE3BlBvTCGzExZJVxNDxcEBGL/j1pDXSAzDKI8ES3flkLOELko/mdIneyENJekGvPoplNMP9Lh4ewEynJmM7aWKYofSg0JEIwUPnixJCk3guw3F3zQ4ajt9Sx5bJkytoCPCx3EERDxdOFIuB5IezY3iM4DKMU7vCVKanfXazEbnEp+hi0RrXm4xMq8u/xOwLKffYeN4dlKQxdA9PslfaYCYj/Xv55NsND8mTJAoee67aL9D/pV8l1jqLuahGzdRUR2R+j6NbsSG4EX5oD8kEYdgZw8iEXPI3Q9ErXnVdFn40uVfnf9E2zxElfD0wAbDcILJECr3uc3LHWjp/U2BBJFhS/JMoWTT9JSGvex+VEhDb5UWdi0TCZ3ySGdm0t9mnxJJp+ZkaLGD+YBW3rEMqwxboT0oGQuYDXVxgFVsFxNs0FWPl/xsMbyGsxpD2jIwTFSJzjalnyr1hwrPzbhfK9wBGNrhwuuEsC66rPWeXSc7TRMEXy7phXF4tX8e2LugMuD84zejUWwz5otLPUe7T59ppUfOBZ+ddv0QRIwK0XSH2nh425kvvKITxkO5lPX5g0YWD+/6+NLPqnu66QPbJcHuYu9gruTC4ZmuF4U52cUFQvb1DySzjbjNp9Nsh43UIgMP6v0acOscyanbxI8fyXSSrFTB
 bbj6j4CuUXmCuUD0rjcyvMPWJVIg3YPAu2eVTd8zp35skkn5FdCDsmPVIEHUzK/bADf2aWRS4ECFiaYjsHDAOHmQdKEbHEYHslqrpv1jLAISkqnA9Mxa/2NjHh27wV4GHc4Z0/fAPv5Oz2xf/w9SwyyNHVofhSFpPojqbH9JbPSTyHlfkQRb9jgiwmDXEzEdJ/mw4hrbTMkZ7ssQE8ZJgQZAeOkQ4FDwd6on4YGOHVbQgAdIes7PRJiQgdHxrXi4WDc2gTuY7cCe9P3k/D4npQlJ62PFYmRAT8z+c7fmfP9zbwhWdyILHvkNPkJVI2/hSHvWYY9rrtuVmVtg6hc+jvYpc0gH16IvAN3kwOM58RdkUiWTsp7kftNBgvhk73C0qPMf7Wr8mhchtRVHoLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GHPDfeuY9dETlbRbDi38ZqQ2zraUwGVfQVh6YUUy/VYA70kEK3wvmEmCXzYqK9CYJ/EZkpVHcqbYDd+mkjOWdGFwYT5AHHoNZH5R8d6o/+2HpmrXhEQjMWg8RNgG/ToP1CKBg4uF/2BzMQkNpTHUbY+w1Hi2vF/wREXc1/pUCLAyNo/RELx4Qy/NJuA/tCkYwdxeGLNW6PI6uClHGw521Bcf5/fD09MQ6rYvswiWRMJZyxjFlpovPgJ7kauuhB7IpQDmhU82FBY+EFwydXv89R4hnqSU4Vr29C3YQH1E3dKfVAwFm9zX/F4L69atkRKHZCiFineqHnEZOSZo1wdxnauSee+keKpy8qklsE8OWz5y+5x3t8oBk5/YXVCHbR2zr+/mZTG0w3QBivT4F+BSC8mpeJrtNEGektdmIdo78IBYnyRuxR6DpDMGxBtSB31MVEi+Ktu5hy0M2MCXZieMyXMYcpi6KeHfmmvN9atfnt2l6t3B4RhK9h8vWOajSZB8JWk7BM51iJ4zDPV/pMn0BUuB9gfpiT/57+WmAaGZWfZSyXWU2K2bWDvu1lSbthEYtcPfaxAV9oIgmkFiRzmMlLGEKOyQptKwU5ggM8alRQ/qG8YfErSnolyeO44+sgciuz4GH7y/V7Rh4D8pZg8klRMSARGzIUlkqzHYfNknjp3PCrKS48MKMPc7T0l1Zt9FWfGFSW25TIJV5hOpeDdgmP3fcl1sasO0IO8U8MQPqmJw2yLRYThuANr+GpGPeG1e9FZx+A+Aal9lN6Pfz+XDoe/uQFqHKDkbjDttkVpZOFODpFQT82kXYZAqhUgy8p1IsVm6ETHOM9vG/EYAnC58bu+UpC6teZUYSWqZhjIJyOFkdlwZNHfyK0a89OTnCsQ7JVVHTOpXQjepcrBKRq0MYvJWhD9sH2fScDBF/VX3/6vQ/5MENUI7s8cjDTpJa111
 k+Jjb8gezZV4GyvOKSxwExgjFW179Ld4SLz2uPh90pyeqYg+0MoXKqaARrz361avdfg1rJIoMBx1htdVDjFH1YvAdcH1nQ7G+h+URhpoPTC1TiC9FNVfDCbNU+tdgG67ed12L0KUKalvZ11ts3mgPJI3/WW9pO8soyFIkIeWJEuBQSfCl8Xg9sXEEgwRoyqUvYIjxHmGOrpYK36e9L9iV0ylUIChY0hA3nzfejwocjBitGFYmngd5VZ812Z5tIjUS4cStNY+kNDynI4yjFuuEZDSw+h2dYx3o13JdgObUqx8+yfvVxC0g5QwkGaFllJZ/N+dhIqD3PV89hO1dc9wFNEvUhrx4It4p2FpIYbMP/dnwrYd0kXpZNOx1LLGvmAphNVEk53PpsoJkKRvaRSAVnQcRMejCwOjYzdi2gTGl78s/SsUFttEajBMiKEl9uGyfiLUAd3Cptq/w2v538bkw1WqhzajeNwoaoT2YQ9zhdNLZIbFNDKkRrQ140j2mpVf5/xPJm3LJAs8FKax5ECo+cRPZLYn41p+i5+PVvK+3fcMcKOXHngaD+wyLqY782nBODXwKGtCZRMUvbXpO00qSf+BAwnlhQ1jc9PUYTgddpgV2rYRl0DXfpUIXM5FNw1O
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfa9bae-d767-4ce8-ea7a-08dce93b5bd3
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 14:53:53.4034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAV/CJTCJ/eILmpP4sEgq+TgnhgkLkHzjlPAypDaHG1hAx49OAn39XFqHMzmj1VzjH8MRP0a3a2Ea51dX8p+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2915
X-ALTERMIMEV2_out: done



On 10/10/24 16:12, Takashi Iwai wrote:
> On Thu, 10 Oct 2024 14:46:01 +0200,
> Julian Vetter wrote:
>>
>> When building for the UM arch and neither INDIRECT_IOMEM=y, nor
>> HAS_IOMEM=y is selected, it will fall back to the implementations from
>> asm-generic/io.h for IO memcpy. But these fall-back functions just do a
>> memcpy. So, instead of depending on UML, add dependency on 'HAS_IOMEM ||
>> INDIRECT_IOMEM'.
>>
>> Acked-by: Takashi Iwai <tiwai@suse.de>
>> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
>> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> 
> This is expected to be applied via sound.git tree?

Yes. At least I have abandoned this patch as part of my big patchset for 
the IO memcpy. Instead I try to integrate the different parts piece by 
piece in the different subsystems and archs. I thinks this is better, as 
suggested by Arnd.

> Then I'll happily take it.
> 
Thank you!
> 
> thanks,
> 
> Takashi
> 
>> ---
>>   sound/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/Kconfig b/sound/Kconfig
>> index 4c036a9a420a..8b40205394fe 100644
>> --- a/sound/Kconfig
>> +++ b/sound/Kconfig
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   menuconfig SOUND
>>   	tristate "Sound card support"
>> -	depends on HAS_IOMEM || UML
>> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>>   	help
>>   	  If you have a sound card in your computer, i.e. if it can say more
>>   	  than an occasional beep, say Y.
>> -- 
>> 2.34.1
>>
>>
>>
>>
>>
> 
> 
> 
> 





