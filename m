Return-Path: <linux-kernel+bounces-552258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F86A577A7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901F01715BD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 02:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C3E374FF;
	Sat,  8 Mar 2025 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jDRqEP9m"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2048.outbound.protection.outlook.com [40.92.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D77AD4B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741401178; cv=fail; b=UdjfDd6XmX9HA1ovkYv8cR0T9UCBsYhKYmnNhtI2DZjY+l8DoIIb2y8xB+9ep7ZYhtYcBXvqBgxHB4sBMisJi/4Uo/WrrdOt6pJ0oUVvkpG7922eYVua+OpUcBqOzPbKEZPmzTNKLcf5WfPyrALZUIpzlmgK+238DzbDkYXDkUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741401178; c=relaxed/simple;
	bh=L9y7+KjIXW9IpjizBRVFKof/lLiCpBQCVCwSP+woX/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ps9nJBYhk1JgWZVsOzHrZEnJHDNTAN+Rt/APDSqqhfSGuTnPeDAdMs/C6NYEl6QJRerDWZ7w0B96a2SSgbQI/SNDx/ILeLuCMPVRa0RmH6RvUQhpLLXGDsT4AWppCb68QtmPUXpMJMyh9/o+OLzGDUQ7glI7X+bd3PXtxr5h50Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jDRqEP9m; arc=fail smtp.client-ip=40.92.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Srh2AcV5NC3rpCes0IEYfhmD4Enjg7CoNxFk7GgHr/mFhzUgxyxQ9jvm9kzFaTrfCOqPwoD7vwTAi9HGYCC1Oml0qaAH/EhbO4UBLlkXUI/Ut6NUu7Z1rcGrPm43NYh1v1kf4tE75XhhddYx0FDw/GNmGNm6wd49Kv3B8FukNnHQq18Focv8cdPQeNfvdlZJaT196n0wpOP7CutgbE1dGbpjQNfHdmkqxvbm2WuodLeoeQaj6fb5NFNeK3z/hHqDkWVUQLJtMJA4qDVmOHYZrsyIVk7sjS4OaLwKv7T2KSpOioQztGEi0qRXNaENikhYd/TMqfM8+rEPphjdR5SXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnSKFdugOop3p0Y+xgj3cV9KNmSdl5IhicOEt7uN7Nc=;
 b=NrptZa4RGkfpee3FCWXXDAVu2RaxWUvC7wMJ6sECHb4q+tWDzBOihjEiYHgD5HUt6rtLff2EjgwWUFs+PcFr+cfu6msettLEc5C7RLRqRs5HdYThTob5aUSL0ViBmABXLaotqDQp2lUzI1oEgQG3LEiDwCEZwgxgG+5YR7+TET9uUBj5okD5WD7odtiKcUwxxdlIbzav1XgEb0X+gO+uV2HSfLUvYUfWya8EqM1GCUi9c5xU+lExz9zq3zEwmB1BzJTNogtk01EI55NKNp00cfMmpTykBzjcqxjmWb6qvGL7gxzRO7pSjQTvvrJk1r0r2pJNsVZeCuoTrbjjekhu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnSKFdugOop3p0Y+xgj3cV9KNmSdl5IhicOEt7uN7Nc=;
 b=jDRqEP9msEjbWqRXyFefoJtyrKLpiC6v87Rp+vqhXdiJkYz0tgZRpm0RdyhFmOC3WGhmOv0SnQ4QlroK04M+AYeQqfdaAdH4a/KsrHAUQ9YRtClRw+2sxtsvaJUWDnODufmBpdEwuoyKwvUr3DCoCB9ATAtVKXW8k3aP9QJbUyIKPamzBlVA4m7Mo9/KTneveRj5Zn8lWAlnZRu2f2XeMzoRwLE12H5rB0zJRYlxT6neqbSxu2V6o3lxyD0NYPvgHCoEmeCR5OdwS0p5C6/dfXdos7c7OpMFvJlvMqw1iiBfegKFMzoKfr1Iuet0A5nIIVpfMMJE4vSWm0esdhWERg==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Sat, 8 Mar
 2025 02:32:54 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%6]) with mapi id 15.20.8511.019; Sat, 8 Mar 2025
 02:32:54 +0000
From: stephen eta zhou <stephen.eta.zhou@outlook.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource: timer-sp804: Fix read_current_timer() issue
 when clock source is not registered
Thread-Topic: [PATCH] clocksource: timer-sp804: Fix read_current_timer() issue
 when clock source is not registered
Thread-Index: AQHbjzhdEoIDDREG80im9Sg8sdgpJbNnhnaAgAD97+A=
Date: Sat, 8 Mar 2025 02:32:53 +0000
Message-ID:
 <BYAPR12MB3205811E28AD92FD6610F886D5D42@BYAPR12MB3205.namprd12.prod.outlook.com>
References:
 <BYAPR12MB3205C9C87EB560CA0CC4984BD5FB2@BYAPR12MB3205.namprd12.prod.outlook.com>
 <198fe423-e797-4a82-a509-ee06ca05466e@linaro.org>
 <e6cda34e-f363-4fae-897f-f4deb7c6bddc@kernel.org>
In-Reply-To: <e6cda34e-f363-4fae-897f-f4deb7c6bddc@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|SA3PR12MB9159:EE_
x-ms-office365-filtering-correlation-id: 8b4a468d-e5b7-4ea1-80f8-08dd5de98788
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|19110799003|461199028|15030799003|8062599003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?MHkBOCwAIQQ1rZAB/mR2ko+2amE8OsKlx+8+PVKg4YT+RbsCAlAs1N8b?=
 =?Windows-1252?Q?e3ldneAMrvXJB/31HeL1WEp2g2w1zanEZJfztdr8AHeUz8YWjJT3ynVF?=
 =?Windows-1252?Q?F+MeLuyUNEsdvCHhlTOIfTPxzCR99sRJPU1wtYTPFHfP7P7vPzPfEber?=
 =?Windows-1252?Q?8YEKySX1ot5IYSSIkeK7wFduDaZTLir6ZdSq+YJN+lE++AvW8Fqkg1Gf?=
 =?Windows-1252?Q?w/VYBMbSFbAOTwZIjAym7MxZ8Fb+Bokr9XngzebiEziGerawCdN8ByQe?=
 =?Windows-1252?Q?/HRsE4pKk+yKbPYsFALK1ZivTJWVTFi2NXiTVbNpnxecwxnhuI2Los4z?=
 =?Windows-1252?Q?P4/u73zITepNTK+FeuoridXBwlAh/jjuLeCFP9pSpIyO+rFR26tUH39E?=
 =?Windows-1252?Q?MkWCqWreiEeKVvguXuoeunNtXMUJgY46sdNALP5UWelLiACrotSuzesu?=
 =?Windows-1252?Q?UVqrLR1yUnWpfjSzepMzQ/9UlJjG6HUuA9UyHcR/RYoDXu2xlXWA0igg?=
 =?Windows-1252?Q?cTw4ifo2UwGQpHxSODhVahmIAZ8pszjhb2/9fzujkBYjwKJT/DiH++sV?=
 =?Windows-1252?Q?3OSJxqkZo0oIWvrWqp+q54cPtPLrBLshcnmEzGxof7MSJkr5JgyZJ1OA?=
 =?Windows-1252?Q?rVTbuawUxID6fspw1fQEBoOvbyIjBQ6wC4zzEBMzFTqqAh1fCxPuAlP8?=
 =?Windows-1252?Q?9TnpKhSgxSqlFxEF4oHct6TGhcrjvGMnR+J1ekWAsaQvupquMN+GsFOt?=
 =?Windows-1252?Q?uP/cQcMTJlrD4ph3Ajuhxe9yFLjt6PjE719wHhtqsO2U/79p6OqCZzfi?=
 =?Windows-1252?Q?EhBqowK8npckKnPt+gYqjfsPl5KsAdmw+LIjaVbpHFi3a+qzGo+6Ubpy?=
 =?Windows-1252?Q?hzCVcZpP60rgUrJ2ePn2L3gwGLApupCA61/pgyTnepVn+4veHLzn5qI6?=
 =?Windows-1252?Q?N1rT6VeGYKOxw0mTPC3VHi1EmybLX38kylb6m/GKPkpnssgBd+qKN2+A?=
 =?Windows-1252?Q?tUn5/dcWvunmqK68sF5rFkWBDqUSOpLoOcdhqJYeLDFIs1oLdwQEbK8F?=
 =?Windows-1252?Q?yk4UmMdhsZtXAGbIalWwQkpeGEdcbQMXozmsclHIq0ggeSGIZsADxBSE?=
 =?Windows-1252?Q?bG7je5+xXN6kzUPlACL+j/C/DrKLI59J1EI+sacPTSqx2A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?6rw45bp9rv79a9SbEHGp+RFkziZuQjFlD/8dkgBdkIHSsF34pwumAmoS?=
 =?Windows-1252?Q?+adK7oIHvMeFbemZ3AKJorwTJMcXqOKItFk+sZsU9GCFeO0BNAGO53rs?=
 =?Windows-1252?Q?mSG3LffX+k+smUwhekz2jAI0KCV5f4bh7QybgnEgPC4QsFuqPjzxh6yS?=
 =?Windows-1252?Q?9IfiNB5rSzijpYs6l+OPmrTUH8kkggTkE9X7pyIqkQLF2suyXr3Q7T3W?=
 =?Windows-1252?Q?pm3ZzMUDEIVnwWJHukllVjwj3kSSaqiVv4YEkPE+jIycQRxO/tPWD5pa?=
 =?Windows-1252?Q?4LnznTgrg6xC6tyvpL1d012R3k/I1ykyQ74HI5+A2FjDtsS1VpAtyFHy?=
 =?Windows-1252?Q?/JgB1l0M61W0/9sapVdXTB5Wmlj9K8n6jQEf5f34MNWmCtVPq7sbnkcT?=
 =?Windows-1252?Q?XKEhMxd0+A8BDv2PVJPsaypJN5F5wtzOQFhfFY/TM0rUh4D1ccTWLfqt?=
 =?Windows-1252?Q?trHY7N22WXN/wMYlPRuvyMlgE0keKje39aHq9AsQv1zys+80cKstFCx/?=
 =?Windows-1252?Q?y/7xxzcOWg58p5MITHpa3lcssVblCPv2E6a6ku+Suoo3ookkGL4zFee6?=
 =?Windows-1252?Q?xOssyj1t4HYTqg/dcQslDV9lmBBdeXaWp4k+W6dUL2n4i7Ssy3EVD2lq?=
 =?Windows-1252?Q?fQ+kX/VIZWUF6JOytVbilfs/zXGwSMi6+ip9Zn9qodJYsBrfTf7lP5Et?=
 =?Windows-1252?Q?ZRDMkmXT/owR1hUIx9ayP4cdAKnvEdeif3T6Kec48j0FfjL2C0vg3mAH?=
 =?Windows-1252?Q?blroxn3qs4VTLbfzx2l23Wf27VQfz9rrF6kcsNzy1hGQxqCCP4XODeAP?=
 =?Windows-1252?Q?zuPdpR7srvn2YJk2D3rlENmDXLaWa5KzoD8hbxcaNvn2ky4/z2nBv4oR?=
 =?Windows-1252?Q?FoxppX9BlZVlpsRdLj5kCcpsDtuWSXixjm/u/klQNEeHvig8NNzJ3QBK?=
 =?Windows-1252?Q?JcZFoTN6J1JBsUsaCCCpIpMQp5F/b/BsAWTY9+YUqNRzt68UzblGQCNR?=
 =?Windows-1252?Q?wYtSaUf4ItpbgJaaRuY86XB3jIqYLkESI90dceiVEFAe5kMrKNbcXf4g?=
 =?Windows-1252?Q?8JnCuKnNb/ZqZ54FYhmw7blQW8nyriBU5JqmrNB0aMQhugmmq0C0cXxY?=
 =?Windows-1252?Q?6slub3e77uf0ocX/5RpSFf7CYzJBUzOtF405BKOnYI5gUdGff8KF/+VQ?=
 =?Windows-1252?Q?aqFxNU2+zIzxDxCwxQTnQsv3en5HC5QygmGvTTQ8X+IjU63oC4Kk3naC?=
 =?Windows-1252?Q?W09o75QbYbDpL8CWIhCdtSy9NS2iHeaHagvJ8JKdL2CgpshgPR90Gj6Z?=
 =?Windows-1252?Q?thSDjuLWzchKOr4i7IgQjMtWDfq7mDXmjChwNqsOfrer3HF/?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4a468d-e5b7-4ea1-80f8-08dd5de98788
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2025 02:32:53.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159

> In case you actually consider applying this - some of the patches or=0A=
> their descriptions were generated by sort of AI tools, thus approach=0A=
> with caution.=0A=
=0A=
> It was already pointed out that patches might be a garbage output of AI.=
=0A=
> Also they were not tested, even though what is claimed here "debugging=0A=
> on ...".=0A=
=0A=
Hi  Krzysztof=0A=
=0A=
I want to point out that this code was debugged by me personally, and I can=
 provide a complete debugging record. =0A=
I want to point out that the reason why my answers to some of the previous =
patches are a bit AI-like is because I am a bit reserved about submitting c=
ode to the kernel community, and I am worried that some answers may not be =
friendly, so I used AI to polish some of my answers.=0A=
=0A=
But I must point out that this is the result of my own debugging and the so=
lution I came up with after careful consideration.=0A=
=0A=
Thanks=0A=
Stephen=0A=
=0A=
________________________________________=0A=
From:=A0Krzysztof Kozlowski <krzk@kernel.org>=0A=
Sent:=A0Friday, March 7, 2025 19:17=0A=
To:=A0Daniel Lezcano <daniel.lezcano@linaro.org>; stephen eta zhou <stephen=
.eta.zhou@outlook.com>=0A=
Cc:=A0tglx@linutronix.de <tglx@linutronix.de>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH] clocksource: timer-sp804: Fix read_current_timer() i=
ssue when clock source is not registered=0A=
=A0=0A=
On 07/03/2025 09:10, Daniel Lezcano wrote:=0A=
>=0A=
> Hi Stephen,=0A=
>=0A=
> thanks for the proposed fix=0A=
>=0A=
> On 21/02/2025 04:46, stephen eta zhou wrote:=0A=
>> Hi daniel=0A=
>>=0A=
>> While debugging on the vexpress-v2p-ca9 platform, I discovered that the =
read_current_timer API wasn't functioning correctly. The issue was that the=
 SP804 driver lacked ARM32 support and did not register read_current_timer.=
 To add ARM32 compatibility, I=92ve submitted this patch. Without it, using=
 SP804 as the timer on ARM32 causes issues with boot_init_stack_canary when=
 inserting the canary value into the interrupt stack, and also affects entr=
opy generation and collection, resulting in incorrect rdseed values.=0A=
>=0A=
> It is better to put that information in the changelog and provide a=0A=
> fixed format of the patch description.=0A=
Daniel,=0A=
=0A=
In case you actually consider applying this - some of the patches or=0A=
their descriptions were generated by sort of AI tools, thus approach=0A=
with caution.=0A=
=0A=
It was already pointed out that patches might be a garbage output of AI.=0A=
Also they were not tested, even though what is claimed here "debugging=0A=
on ...".=0A=
=0A=
Best regards,=0A=
Krzysztof=

