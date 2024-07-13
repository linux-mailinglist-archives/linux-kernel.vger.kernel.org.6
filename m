Return-Path: <linux-kernel+bounces-251253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EAC9302B0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 02:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AB41F22AD6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0122F23;
	Sat, 13 Jul 2024 00:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i77Ma4Gl"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2066.outbound.protection.outlook.com [40.92.103.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F738C;
	Sat, 13 Jul 2024 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720829649; cv=fail; b=HRYAjGgsCNuIeONB1TLKt6i2OFivgVvvnMNaRhIYKDPG2o7hY92HnJhIb0SR8lA9xpEP0iL5AHleJ0oAsY0vZHrPafI53Xpgq3/K6NXSH2wa/G4SRZbaQUiGcriZu9Y8j0iVTlii4tFNl87mKIQvqQ2ihRGkdY1S/yvsuX6VrXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720829649; c=relaxed/simple;
	bh=KdjqOp0KxM0wMSD4YwxIHOFhwU537/TtcgYhrrvdYL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jIU/SCYtmk1Xw4/x75YCA0NTwSfWuQpmH2l+gOcuggtBaCd7a7uZDOmJiPEI99UInhREeOJutj0oifuluJ90HFxsSFmgvhyV6B2+mpg7ZYw6y0KbvhrNwHXpPBNjGdNr+nHqJ2Vu7aMsiNW3dLlWFjfnKczztCjG57BsFJFqnZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i77Ma4Gl; arc=fail smtp.client-ip=40.92.103.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gw+mBIuzEsTc8io90gfkOxcFggSYw/TtYlDRJIbFrot2YuSiTzYkZGeYEHsCXoKhapaD4sW6r+K59QUBWFsJLbqKpg8QfdwQh5/8V+b/YzA8J7mDeQFyBcH7O5GTT5SGbDAk8CMPSiklpmy4V77+83SO3ajN4BrtActZpmLeM98SGrHHf4+r08pY/9GGFSvooPSgSFbqa5mhqsl8y13qMM1V65bS4PcwEdoO6m6TyibAbIEQmUxy/PqNHt4bWkMLx7mWjuKzj67P4WiQOdEy/g44F1heyyAZFKL2+Jpf88l6nqXJUG8xMHOm6nXjuEGL+0mafWsupWPPWkV1FL9g1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRiXHZ9s9kcFjjsHAG6YrIsqy0lO2Tc5c64YyhqC8D0=;
 b=cEsoedBMac8/D8D1pG1oWZcAeW1JRGSmhoDDX1HL7S9bBUhXQ3Ty4Qi3jl+YnQQpnwhycwtZWX4YkNCCfmTsDzL/72PDXLg6X5xU0vCPSdVsUeUKOS7fmLBxDMP24nsvsfkK5Un046OR2y8DwmGbMfBiM3LJYidMBj8kEZb/aZ3C758LjY0wXqiGky5e+acbSudk4RDMfuauAO9W8c2wQPZAaqxM1SUvVdVsdabyN4JeIRQqBrH4vCVOiI5/K4I9l6lKuK0OXlyyWvlxkBymYfrpaCJr1igBjn+k68y+IhKTQPxLMKGVKBv+xQb8pPDw1ra0Q16NfZ7gn8MHsZq1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRiXHZ9s9kcFjjsHAG6YrIsqy0lO2Tc5c64YyhqC8D0=;
 b=i77Ma4GlfC+xLlYHWmUDku2rqip7WJkDkLaGAOw3PeH/K9TAq5ksS51nCDpkfH/MvF+HMVIgRUsK7PkndIMmhJLu4WYQXocEQyNuT3tacD1vfVJwU/y3EeS9Z9OLAXcy1rPFBHcToG84ymOkG70dN3jWDo+0UnVa8Tg8DFvFKw3/tHxAuQ9teOr9jy+uMXwKJ7DPhRpiqzW2aPJYzAGPYX900Mwje35n+ktfaBdQAKONVcea/LhTX4+0zeh+VAV/giRo3FSl/wlN3ZEzP4A29uubGJl7wSkvcflRH3dU23kAgWh4j9i6ET0zSuow4aCIQ3Q+Cd84EpBeFI3PO39Eqw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1087.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:173::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Sat, 13 Jul
 2024 00:13:59 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%5]) with mapi id 15.20.7762.024; Sat, 13 Jul 2024
 00:13:59 +0000
Message-ID:
 <MA0P287MB2822B352F67009BA8EF4A312FEA72@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Sat, 13 Jul 2024 08:13:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add board support for Sipeed LicheeRV Nano
To: Conor Dooley <conor@kernel.org>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Inochi Amaoto <inochiama@outlook.com>,
 Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
 <MA0P287MB2822C4E2EEFB67F82458C390FEA62@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240712-bacon-untruth-5230df76fdad@spud>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240712-bacon-untruth-5230df76fdad@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [Y0oH2/RTUiSn5tI+iS7WRKPBENxG3HZl]
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <81a1a424-2140-4623-a45b-b31d5b65e1de@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1087:EE_
X-MS-Office365-Filtering-Correlation-Id: edceeffc-8c73-4c19-8aee-08dca2d0b076
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|56899033|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	6NYPTWewFaK9KWfiJ5eZZpQcZlRx80w6/Wv6h90SBHck8dtiTSRe3UBOF9JeBM6sFRrEKi+wKiQBhPsAzc2Xr4tlwjKSqjyDNo9optdLIdMUZaju/hWduP2sxFWWWvBdTifgJhZZTm26Le95IJqp9tRTDRCgPpF3ANMmYNaC8LOShDo2wGHrIrcuq3eAYezifsmp0N6iHV3vI3PGmt+xtWKFHfB7nev9CGtFCFlJE39yrmEuw/JwoLnp84a8UNiPn83hP1x1PRSFejmd9sBIptb51u6jh3jmQ68uiTceo8Jz2CYX/0OQBBHNz+VxFog8eT0Kq3EcM3Ht1+CjdUxPemjowvX4wJdb+4bve3QomvHbZ8KLuK0UseQH9pgiqh301Tx3ABE5sDZmdRlamfSFUvN1oefCsamVs7BktJG3gLZTSA8DKdcTyrXuX4QswpfsAFrY0JRCt5/Fhl0TJWj6w0t/i1hiIr29EonxtPlVK+Q6TJWz28OsSVLsw1yp4waW/XO1GOtex9AzVLpdUGTfcO6yGnVx0Wt7h+P3CIYwHgHL43vyzcESkfcp+5XOS4/l9dOMOd8nHZS35sNRMd32wS+t6DEs6ERUgz13thLBCTfKEsx6S434tihSVnRH9Uu0bGjPHDTFh3xhmkGx5lamew==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFE3UTZBaUVCMG55WE84ejk5OXVSSjhLV2xqMHVWOVFrNVRnSzVkSndYNktP?=
 =?utf-8?B?c3QyaFlBS2J4R3lSNXhlNFI0Z0Y3KzEzZGhqYWI0MnFzQjRnMDY2L3NvaUJr?=
 =?utf-8?B?OTJPMTZQeENwVW5oa085ckVYTk1uVmV4UkZxamZTVENlZ2FqMkgrcjRDZDVj?=
 =?utf-8?B?Rjhad2tXTjNoTzZCd21nRjhMVTB4RmN5RTRIWVJoZDNUUU5GWmFJcFdUQjVm?=
 =?utf-8?B?L1p5ZzlnU1dVdEZJZHdURTl5bEhHcHBKOTlKdW9jc2NkOEdIdDJqTlRzd2JN?=
 =?utf-8?B?YWNmSVkyMTFtQnBJSjhWOG5uZFU1allLSTA3cWswZjZZVXIyVVBhV21lMmxQ?=
 =?utf-8?B?dEhTRkRzS3ZHUUY4emFyc0puYXlsRW80VzhiOXVnZ3hTNjRHUDhOdWVjTnZa?=
 =?utf-8?B?bFpXY0VrdDlwVE1iT29tQXFoamU3ZkY1UThNMktwYjJVaFEzZzN4SjlXK0lo?=
 =?utf-8?B?SWdjdy85eWJFdHVUaEdpVjltdUp1bFJaWnhjU1BESnFFT1pEYnZvN3UwZXlv?=
 =?utf-8?B?R1k1K2lRSGNkczA3RnNwSFRaQzdEMW9Ub1R4eFRuSnltc1RLU29rbTdzbDlN?=
 =?utf-8?B?Ukc2L3hIaFV4TmMyc2NRNzZSTVI2SUxCalFRUktzbStVbDZNSkNDTkh6TDBq?=
 =?utf-8?B?QWEySTc4V2U1MUxmM1U5alM0ZGY1MlVFSkkwWWo4MVFiaTB2UW9yNWlzTTZC?=
 =?utf-8?B?OGdIbHJFam1VSFBaWEMvUVRwbGtxMWdqWStqMFdtU2ZHTXFDSCtYK0xnOVFZ?=
 =?utf-8?B?N2ZOeWZLMVgyZVE4OEN1WWdicFgwSzR1VHgwNnFVRkJxdHhFTkx2V3djU29W?=
 =?utf-8?B?WiszRDQraExZWWIyV09OZkdqcnVBUXhTZzF0OW8yRVozQUVLQm44M0I0S0pm?=
 =?utf-8?B?SlhtczNvNnI3aXFJWm8rdE82VEM2Wlgwb2tuV2lVVG45V2hncE1sTWdhOFRx?=
 =?utf-8?B?NUNGUDlKRkw5d1M2cXQ0bmh2VFB1WUZMaFFJSllHbDZGZHNsaHVnWmhVUUFv?=
 =?utf-8?B?UkxBSzRyalAwV041ZEVmQTVmM3orNXIzY280SmwvNVJsOERHRUdNRlY3cFgw?=
 =?utf-8?B?TnFURUM5Y3hQZWtDaEdRWFJSUy9MbGRXZG40MjdwczFwNzNJZ25sWWFsQk5m?=
 =?utf-8?B?eGpjN3g4N3M3bGJrRjdnaldKVUZPSE1nNDNpaVgrbGYwY2RJRWlua1djd1Zp?=
 =?utf-8?B?UFIrVVJONk84c0hTZk5uNi9EZDNLUUwvQWRFWkVLUzZPWUEzTEsrNVpBWEFv?=
 =?utf-8?B?Q3NmeDJTdy9xMjY3WXNMWlFyQ3pDQW5XZ2M5cFZabHE5VWtJdytWcDdoQzAy?=
 =?utf-8?B?MWF2NXB2Tzl6ZmlVM3MyOVhQazVsNjVUdVNPclgxNVl1aEprUTlPdXFvQnRV?=
 =?utf-8?B?UG1aNFV3cVVxZjZtRm9xaDdKSHhlVDRiYlRMRmRQMGx2WGlMV01ONzJPbXVs?=
 =?utf-8?B?YjVWYkFRY2VTOWcxNTdHVVVvSDF1RVhXTVVPLzFxWlJ4YllucDJBYi8wbTdu?=
 =?utf-8?B?VDRVczU4NlhXcUhUQXpMaHJhY2FXUVdCSmZhbGowYmlzZ0IvRDFXam9OOEVX?=
 =?utf-8?B?WW1JeTZFMU42RGRlKzF5d3E1RHBJYVg3WmVPYTExcnhBWkM0aVB5TGVVNW90?=
 =?utf-8?B?NmZIUnM0OTNsRVV0OUQzN1FKSDkvUmhNVG9xZlpxT0tMSC82a1AwYnh0WmxG?=
 =?utf-8?Q?Vt0o8n4Xe3GaEMVeZQZX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edceeffc-8c73-4c19-8aee-08dca2d0b076
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2024 00:13:59.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1087


On 2024/7/12 22:15, Conor Dooley wrote:
> On Fri, Jul 12, 2024 at 09:33:46AM +0800, Chen Wang wrote:
>>>    .../interrupt-controller/sifive,plic-1.0.0.yaml    |  1 +
>>>    .../devicetree/bindings/riscv/sophgo.yaml          |  5 ++
>>>    arch/riscv/boot/dts/sophgo/Makefile                |  1 +
>>>    .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 54 ++++++++++++++++++++++
>>>    arch/riscv/boot/dts/sophgo/sg2002.dtsi             | 32 +++++++++++++
>>>    5 files changed, 93 insertions(+)
>> How about letting me PR all the four patches in this patchset? Because they
>> are all related to sophgo, it would be better to PR them together to avoid
>> confusion.
>> Especially about the change of sifive,plic-1.0.0.yaml, my original
>> understanding was that it should be handled by you.
> No, stuff like the plic should really be handled by Thomas as he is the
> interrupt controller maintainer, not by me. Usually though, neither the
> timer or interrupt controller maintainers seem to care about these sorts
> of binding patches which is why they ended up going with the dts.
> Ideally the plic patch would go through the tip tree, but I think
> there's unlikely to be sleep lost over a trivial binding change going
> with the dts user.

Thank you Cornor for your input, I will handle these patches together 
with dts.

Regards,

Chen


