Return-Path: <linux-kernel+bounces-358375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3C997E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489901F26A93
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66E1B0109;
	Thu, 10 Oct 2024 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="blGeiC9E"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2037.outbound.protection.outlook.com [40.92.90.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC51B533C;
	Thu, 10 Oct 2024 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543559; cv=fail; b=J2FVZ5+7cklqIEhUp0BGHjy3Kjx3SthmOahFeut/P58He07YksBosmPoN2+E5SIK786VAbolbHRPwucCxrOfjX6s6N6MRXdxNNmU+4Mi3NL2oJQhwIwvYfjo0bUzSWIQfAFQbCquqU0GIH5r1gUVtUwjbjfSyDvqq/UlidE0u9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543559; c=relaxed/simple;
	bh=Yl/8CxmsS6s+ZLGpI4+fDnIA9OoPlNyhO4T9KEsWcQY=;
	h=Message-ID:Date:From:Subject:Cc:To:Content-Type:MIME-Version; b=W1miIt7YfvcNw4BnbBNFo7DABvtdVZS28Yv8REIyJ8RaI2N1UNbW3dQM8UwkU55p5BT7Ow//ypC5B8/x0VgP2jmu99z3vGf8MZlGs+eIXKwM+Pvcnv6wiL9+3bmrsFEYxgE1fwKM0L/HzSt3enuHTcL0oc1S7HTskVvEpxi9+uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=blGeiC9E; arc=fail smtp.client-ip=40.92.90.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btH3fp+VZx5wPuEpHJwQA347GeKaDAVUMq+8XJaVue3B0JGE9SRgr6TzDvTtliYr+M7VBFWlEUw6y9z7MUd9WGdyPmWF2WKLNYNOn+AwZa3ZxeDwLpYe9msit4LVtsdymubsgrHsPZYUjOs0tz+GlxGj7hWI3X1VKO3TJvftdaC27p8ZwQtNBp4KFqGc4rpPXh1biu6ZG51EJkD1EzQ9G7vlSW6n4215M3D6UdwHInisTomTbHWvXDkkOmzndvjKjt/XqFRzPq4+2u2k2fZcySYomQqlzXD0H5O3ICqtK2oqTmFfu7ntLRRDYQ3BMYhlVrDdGu+mtIUDPktn/pz/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnI/PSzW7mu6tB1rdnYSTe+5ss6QKmt9vMqAoo/w8Os=;
 b=AQ6kIyPiABZyWeUyjMoqt1+2AO2hPE8/N8av1KcJksMNCHCvBz2CdDDwh4+/pwAaKqevSWJxdSRzc27fpRi5yOo5YQkkIrSUJ7yTAFcD997D+/PF1aUndlrEBDCjv8an+Y6llyyr+HAb+PgguUIT56Wcqr0pawTq4dvJOrywt6SXRSu04gSagrOYAzAaHTQ5Te8pbVdWLOUw7vVh51hVV3PgwySAG/iR0GM4pBtDx4vkAQSUNtjAz1shfS/Kcx8RpOgw7LWV7pG28mOtiv9ShMfWD8BDjh4LMkfhFN0ZxykFfth39r/r53bINNN06/N6CcXHKQ0f6gPC2gQCEhPT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnI/PSzW7mu6tB1rdnYSTe+5ss6QKmt9vMqAoo/w8Os=;
 b=blGeiC9EVou7mvLeKo53ZaVoFTYJF5JpSgMJMdA0LkGoc1PfMWLhP/5bTVs7yQ3yzKysRimCuFGqsYqLeWYt5wQUqUaFj+bEHAptd/269MtABghwZ1uhILR+uzYwb9khg1aT1ZLHc9TjW75CQAJmGBGQA8vl293RhaMA+RHeD2zFvc93wgk9IkpmkY1BdLwj3N00QstsowD3LnXNIIp8J7movQc8I410NDRz9cN0mLCaROXfLHgaV+7PdGZ0V0XKSuK61RXxvXWlXyEdaLMQphX5XZJGQ4PiF1b72Y10rxigoJYo7Eq3ko+st43EWfMi/ioxLcfzBCjhO4W1iIUVMw==
Received: from AS8P190MB1285.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e0::21)
 by AM0P190MB0723.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:19b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 06:59:14 +0000
Received: from AS8P190MB1285.EURP190.PROD.OUTLOOK.COM
 ([fe80::5307:a61:337b:f3fb]) by AS8P190MB1285.EURP190.PROD.OUTLOOK.COM
 ([fe80::5307:a61:337b:f3fb%4]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 06:59:14 +0000
Message-ID:
 <AS8P190MB1285B563C6B5394DB274813FEC782@AS8P190MB1285.EURP190.PROD.OUTLOOK.COM>
Date: Wed, 9 Oct 2024 23:59:10 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Karol Kosik <k.kosik@outlook.com>
Subject: [PATCH] ALSA: usb-audio: Fix NULL pointer deref in
 snd_usb_power_domain_set()
Cc: Karol Kosik <k.kosik@outlook.com>, Jaroslav Kysela <perex@perex.cz>,
 Johan Carlsson <johan.carlsson@teenage.engineering>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To AS8P190MB1285.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e0::21)
X-Microsoft-Original-Message-ID:
 <aef602ec-b3fd-489b-9e36-a22011c1fad8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P190MB1285:EE_|AM0P190MB0723:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f1020c-4bbb-4963-2c8e-08dce8f90cec
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|7092599003|6090799003|19110799003|5072599009|461199028|5062599005|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	HEPZfQRtkkEXFHkKxoqKgmEsagHcwpsCW1OzyC5B/23JmxGG/6xJmX8AHOZoloqhOiyv8B8fG0Shw6Xj2BenAELXIqa6m1cvGgU00AI2Tg0altBQu3ZhLeajWa3wANEsGWGfLlZs0C9Sdra12xtLwOfEPwWeD4uQt0kk7VBdwoJeS4UdMJam0wnIVTS/zOVEZVc6XDOW3J3Y+7wWZ1/lCEzFDwK4bbaxCZ6YXEhsFMCmi/HASpeMXD+tZszPSyXEMIgkbO5MeAJiy4AoIXQECoKf0CeXhG8/OdiazcX2dyT4ISI0OBQT+DXsb6x5HrVtnZC5lWcmXf/eVDoImI6rPQLWOw4dqKkziKU+OZ7PL42xXH9HtsSYm2C21lTfbuwsKL5oAW0wi8n4g+1sCZ3MzjITEC4vSWspo0jXQKIENqSd0KYE15L6n7qftamb6Oyls0Qxmcj+kMpbbmfG6GbWX1kKF//+0kQHBQMlP99rFX90YQqeM0SJHoA3aeRuTPiCLurQfte0/ACd8vfnGI2NSVdV0kdmIdyC1/4FYM73OasZP3DuxPRU+mjsaeASkbC7rnFVrbjl+6kbuqqK6eX0eMT5CHzJswLIQr/efdnVz/e+VYSdNVJ3t4Ie3gfkoClCdNi6JI/BeMq57mauLp4ezIHKJU6p448ZJ0yTAGLVAzy/HJhmJfpAUrEWXYqYCdo7+G6LA+WKw0iJ9HDIn3QlqJNH3Bl62vQUvpFq+cA6ibV/Xb/f8qlXMouQ03VrWUZ+pErr/Yz8kqmg2Gsf/Nga0/SKCSANKnuVSQ5+bKnPsEvcEZM7mGfxaAihOSbA/i9E
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlBLR2FQSVNsMk5SK2xCOEZ1Q1luajZMUzg4Q3NiUWZLSlNCaThJZDBLeGZW?=
 =?utf-8?B?blZtMi84Ui9ML1JSeFQzeTIxQ2hVemRabkptNWtiNkJVajY0UHhtSVNMYjRm?=
 =?utf-8?B?akRmSFRseUllTFpuQkdvdjJ1K0RmL2VFYUttR1RjNzVSSlpTT2Y3b3h1RVZn?=
 =?utf-8?B?cEk2NmUrOEhubzlaVDNVRXhFU0lxbjRyazNza3FETkZIQ1F4WDFIVXY5NG9B?=
 =?utf-8?B?aElCaHZVWkxDakgwa2pLdjY3eXAxU2tlOXJteTB1MHRZOXpQcnozTnNmUFVH?=
 =?utf-8?B?OGhUYUxoeHh6UDgza2RaNS9KR1pmUWx1OHdCNmdFMmh6eHJQS3JPd2FoVnlF?=
 =?utf-8?B?SW1iaEhTUTEvYkc0SVlLSjBSMUF1elppN3o3Mmw3dWYySDEvTDB2OXBSODZi?=
 =?utf-8?B?UDlkQUFKK3VHbFJGK25nUzF4dENTa3ZpUUY0Y1JwdnQzQU04dE4vU3lCck01?=
 =?utf-8?B?Q29mdVMxWXAvcmhRbWJVS2RiamdLU241SGtzRjlTbXhZWDRva1ptRkNMVVVr?=
 =?utf-8?B?VUZxM2d5aGJxTlNxZStYeDFkNEhEckVYWkhOMFdFR2dkQVlDekhacGhqYWtL?=
 =?utf-8?B?dUlaRysrdE4yOHcvU1N0TzhYUFlkMUgrT1dOUWZaYXp1THArbG9ZUDlNbFFx?=
 =?utf-8?B?M3RmYU5wbjZIelZWQmthOVJWZmwxYVR3ZHltNXA2WlBjeGNIb0ROWG5GNDAx?=
 =?utf-8?B?Rmh6T1c1b0t6K2FVM0NDTjNhQTc4NW9QVlNQZjM4TkhMTFMveSt2c2F2V3dK?=
 =?utf-8?B?WlMyZTRxL0MvNTdrTG04Q1hQYVpGeCtHNkJPUU5GeTlZYlJLUTBqRWcrTlFN?=
 =?utf-8?B?aUFCNHA2cE9oTDlsWFV6Zy9hRlJvSWk3K1FQUTB3NTJ6ZVowNTMweUZpa1Av?=
 =?utf-8?B?UmhVN2xTUXRlV3YrTHhmeTd6WEFQMXp1VFM1MVY3b1RTWTFuUWdiVkYrNmE5?=
 =?utf-8?B?YXZseG5FUU9TK3AyVFVxcUlzWkpva2NMZ000aUQ1alhUWmpnRC93VndlYmh4?=
 =?utf-8?B?MHhEdk16SW9lOFJDM3JOV2QxZDJRK2doem1qell2NnRyOEtqeUxyaXlGRlhS?=
 =?utf-8?B?WlZQQlY5VVprNGRKSHNkZEVCUzBxdldneTBZMlFpOWVXREZHQmtLSmlLSmNP?=
 =?utf-8?B?bkxVQm5IcUhOU1dVODZ5VUJpaUZRR2xqV3FyNWJJSmkwQzBDOXhlbEc2Q1JF?=
 =?utf-8?B?Z2p1Y3FVMTFtUzFqTmRHcU9xcVcxNEFNd00xL2J1MDcrcHhhSVhBRmYySUxh?=
 =?utf-8?B?dzZ5dmw2ZUZBdzNscHE5ZHhNZzlXcFcwYW91ZjQ1M0JCV1F5ZWhwMFJzSTE1?=
 =?utf-8?B?OTNpU0FFRG1semFLc1lDa1V3RUMxeFdJTmxGZTN0RlAzTFhsV1Nudmthby90?=
 =?utf-8?B?RERkTzJoWjVidzRSNDk4UVNabUpNZmdMWmlaRGUrUGV1OENvY1diRGdjSEc5?=
 =?utf-8?B?UkcrTWR1ajl5eU1rLzhrZHBxQktFejF0ZUNYN3ZqVGZxcm12alJIS2FLNXFP?=
 =?utf-8?B?YXpSWWlQd3NEQ3pIVHFGOWVWQ0M4ZlpFeGVFR1dYVWk1WGwzZXNkTlIrRkFh?=
 =?utf-8?B?VGlnMmg3UFZET250c2pielMzdFpVaWNFRDZJYXpncGluaE9kOWdtQnRLalRh?=
 =?utf-8?B?Z3NCT01Cazk5ejI2NTBhY0dXOVVPbnpXNE1ucy8xazg1ODBDMXNRV3lUdW11?=
 =?utf-8?B?RU1LYzd3RFNWY2x4SVBnNUJ2Q0toWWpoem0xeDBsTmVzQTVJaFNubXBGaG1I?=
 =?utf-8?Q?yxxTBUSIobBVo6bmPk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f1020c-4bbb-4963-2c8e-08dce8f90cec
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1285.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 06:59:14.5682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0723

Commit adding support for multiple control interfaces expanded struct
snd_usb_power_domain with pointer to control interface for proper control
message routing but missed one initialization point of this structure,
which has left new field with NULL value.

Standard mandates that each device has at least one control interface and
code responsible for power domain does not check for NULL values when
querying for control interface. This caused some USB devices to crash
the kernel.

Fixes: 6aa8700150f7 ("ALSA: usb-audio: Support multiple control interfaces")

Signed-off-by: Karol Kosik <k.kosik@outlook.com>
---
 sound/usb/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index d70c140813d6..c1ea8844a46f 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1067,6 +1067,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
                                        UAC3_BADD_PD_ID10 : UAC3_BADD_PD_ID11;
                pd->pd_d1d0_rec = UAC3_BADD_PD_RECOVER_D1D0;
                pd->pd_d2d0_rec = UAC3_BADD_PD_RECOVER_D2D0;
+               pd->ctrl_iface = ctrl_intf;

        } else {
                fp->attributes = parse_uac_endpoint_attributes(chip, alts,
-- 
2.34.1


