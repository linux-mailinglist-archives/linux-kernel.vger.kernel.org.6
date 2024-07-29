Return-Path: <linux-kernel+bounces-264932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 792ED93EA50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9261F21BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 00:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92972846D;
	Mon, 29 Jul 2024 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qESNJuGM"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2056.outbound.protection.outlook.com [40.92.43.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56D79F9;
	Mon, 29 Jul 2024 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722213252; cv=fail; b=ltkaTOqLght3WTh4jdGWgdSx8ktEYZi7DLPy6KXtDDXob70FoSUhpU6GJ1gCr7UVk8sVl6RO+8Bs0qae/B9EVOfaT3AEEer46qEO/DUwOPOdTbFwRX4I63g9hiNOBN1Am+tqnxoJos/Y/RDTjBJ4RxAEn5nM7PHW7dJUG0tMqy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722213252; c=relaxed/simple;
	bh=s90Fs5X1h2CE9H56LoHw6aSlkJYAtglywL0ybnMrzP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LqRTbkC+LyeZ+fiG1HaqoBTsBVv+Qg2OW5FUdYKTJe55uUU+GhCqDTMeZICSOFQE2yd0BriI0Krva39v5isMuI9wJefT4pVzHIvwiJFQc2zfKotw12/0POG4zozne5yeLtboroS8d5HmBvVbDI4Vwc7YzsRWBhgRK3ThHiu010o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qESNJuGM; arc=fail smtp.client-ip=40.92.43.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXhSRvnNioOvD6VGGNgst+EOfq5kmVZG04PYLVzYM1TQ4iLh6GsLSWLgMlplT0bAN3weejfGZTghnDMmsDu3qCy3ga3d5+WwCKjRpy9+OQrqY3qxZZIyL7OIdFuPJ/M9YjeZRfhg3gx1FFo0rx/uL2evyCtSQR8DzPqxjyMkkfGUYWAllJm+H1YPIKYmtf8rhtoZGlDOn0wW/WUCqkvTGT8g3JR7MBVDdLW3RMOSFAWtZoogsCMZiGHmi9e7lxKuBRT0crOB/UeLRBi1G91dW9kmrxBhRRBz1HJcd94ijmh6N3hGdt4ZB2Yywsya5/CVMeDNxB5jWrAf+eYjrg7ieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HtuG2ZZZaVrJ6LPlf1+rhKezsom5sIbNjuO1Mg+jGo=;
 b=fWKIbynxCucPJ8ah6WNBtky33h9XUrkOpY2x6CTDoTu7iiJJ6uOeQyUtA2WMQ7OGnTVV3q3qmOzjs+Hhp7S392li6F6dovaYsNHQoTguSCkOH72ElLCG5fMzig3tN/KWJLHFGdnskpfsAaLTCkpAWZuepZ0BYLaNIhZje0tuiZLoOwN9/m16SeNPJQE0wx5NkxuSrI62fx9kdEmnm0/DwDZYnphQ0GQC1xgP0/gAazrIc6g0eQjXvqNX8cPBctWWB1NjV2bEN8QC3g3uPwSExUNXREniVRa50kyQdHSqhlZCnER6l1bcJoVM0Y3JV0p4m37efvHVdk8HlQX2ksuChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HtuG2ZZZaVrJ6LPlf1+rhKezsom5sIbNjuO1Mg+jGo=;
 b=qESNJuGMl4jNyi5InHMMMFH+BaqdEg9VdZnakHpmkfh0u6o1wmpuwDa4LLsZ+izT5FgJTJMSOtECNgfEe0ZnHcUKsvjtl5RPTnxPfak0Wh58WrIoyeOyWGGv1/RH0ui8ZjdsX5eaBqRsjJq0Vpa1PCa8IePr82tionWwsPQ5NLjlbqW2nlKmY8pfz7ZMu6bL/EMryzS3Ba1hKyKMd/IsGErFPwKcmU5NhTLIF12nAtUvuBP39qucdeUbMecfvp8HOuZE9kPMuWoisafEuCNpKyEeSuZfcVRhQztu65W7XVX3m78BuWWcv5zC9p/mvAiss+ad6Rqg+J91+g8R4w2Egw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5383.namprd20.prod.outlook.com (2603:10b6:806:29e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 00:34:09 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 00:34:08 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: cv18xx: add DMA controller
Date: Mon, 29 Jul 2024 08:33:18 +0800
Message-ID:
 <IA1PR20MB4953650A2ED1FD71E05604BCBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB4953BD73E12B8A1CDBD9E1A3BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953BD73E12B8A1CDBD9E1A3BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [VlwX8+aKxslXfr3wCwDogLB9L8UGYxhsE463ZFoMs08=]
X-ClientProxiedBy: TY2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:404:e2::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <172221298392.524972.2800193992300887479.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5383:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c983f7-343a-4189-229d-08dcaf6628cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|5072599006|1602099012|4302099013|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	AoaecdluhVHmTic4M/1MoarX+lznWLk4JwnyOlD7DNCmSrx09Mb9lYrzzr5DVMUFL4Tc0F4JMcuOOhZrv8uPSHpLaGv0XY0h8tKvDqDpYt3gcTm8M8VfegGz8L/64ThJWmXn81DuHrU9rZZW9Z2abaC0aT5RZXmztx9R2lXOamSp7AL8jZ6SOVj+LBzu1w+XNwbIAllBMQ27wxdzokpCPb4MvttJIjPpxZLsZdALIrw4OTH5lwAONJkVDu9RyT5gLyIfnHFaBvqIzYO4mLMVDMGLLEdu6fAHOBcBXJ4wL3JbduPoqph+5l0yqnENA/zBd9HdT06c2DpOQCFORgbu+Nk/bASOq57ar8LFBoSex2nlnauZQ55xfLschmMCknqBKy887yS5YxaU86so8G2TjDCsGEKYZNNBc3kHYMZSRQ+o5kPJyq9c3jyrSWTrZkTaLEtikeuQIloJgTiZDXQY2fp/F3rtq+4lZKsI/BkTURj5Dd3rgOdsO/oVwyX/dKrDPeoYXfDV5fyZwMXZW19Glhv9E5rEK8DieGcSAys34AZyj5shqH9yi+x/blscKeuWdXeMKog5Z7n8/8ay/Yq4rcHzdnEI3hhWjkEg8vWsQHUiaO5xsqTozTAvR9QFz7tMxOD5iUEyXNuXjNizh+1vRu3t083xjHFHbotDaaI3MkmARevt2uQGD0iOfpAOw2sVj/tN/vL8OUHrPzgUSmULfkRBs1uvUP7QUscIgJ1wM8XdmPcCcA/nsQ03kaqI8nPgZm/4SLUfj3BAmim4jjsgjDIfmJWj2E0ImwhFm7Wf+pakFF8Jw5426A6FR0ljpw+9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmVyOTV6SzdWcldYclp0OXBGbmZOK1JtYmRHWnZtb1duZTIwNkhScWpyU2JV?=
 =?utf-8?B?MHl3Zm5Fa0RSbVZYU3V6a01MSkZkNmFzR3FmVTJRY3N4VWhoRUVmVmFMTUtW?=
 =?utf-8?B?clRSaXJFRE8vRTRsTUNueXhXZldtaUhsN3M4MUVVN0ZjeU1LaGtxYjBucmtz?=
 =?utf-8?B?RE83TG9pRldUckdjTGYvMTF5UDJuK3JVSms1allMN3pwVVBzQmpITFp1SFpU?=
 =?utf-8?B?TFFFMDNLMFpnYVlyc3MwMjFvZ3M0TFNkcGFnNjRMQThwZDlNd202YUdoMGhz?=
 =?utf-8?B?V2cybmZXdFV6UjMraWYyMm5SVjV2a0duMW1oZGp6dEczaEp6N21ZdHN4SmN3?=
 =?utf-8?B?SmR3NE5wS0FlK0svaGtTdEtvV0xXQ1pVTlprOUFGVDRYWklDdkFQYlRpSW5R?=
 =?utf-8?B?OC9oZjhobU1FYlppdjBGcU52aFJtN3B6RlpBNVo5U0c1aVVqdGpKTXBXVWQ3?=
 =?utf-8?B?Y1hsVFJpU2w4U2RoaWhQV2gwNWZNbkhuMnhGN1dneEp1WXZkR1RWQk11cC9l?=
 =?utf-8?B?OGN5UXNzb3BkV3hKK01vUVVqZGNOaGhZcU5TR244SjRERytyNmJQd1g1cGN6?=
 =?utf-8?B?YzBlTWdqV2RxbGM1T0JTY3pBRE1POWVNdEU1OXlpb21EUlFDSEJyY2EyOGIr?=
 =?utf-8?B?UHJkbXJiUE9TcUVvVWNsV2Z4eDFkSHlQQTFPaFRvSklHNld6NGZyb3pzVk1k?=
 =?utf-8?B?VTRDUGxqNk85R3BoYjdCamx2VXJFV0I2V0lLY0p1cEpXSDgwT0pJOURLem41?=
 =?utf-8?B?Z1F5N1FTYmZxQlRSWDFFV3hUNEhxYzhrWXdIeUVWWHFUVHp5RU1PVHJsMkRt?=
 =?utf-8?B?Z25RSEhiRk1kcXBuZnNJY3N4WEVCQW0zdXc0YW1mNkNrRzNwSG5VMnZ3Z0x6?=
 =?utf-8?B?L1A1bTkxZkhJaVdLK3VxSDI1K0ZMK0xFdHRMa0t5eGJJbVhBYUtGK2pLOW8x?=
 =?utf-8?B?eXIxQXFQWkl1YjFuNEUrOFR4VmQxSGRNZlZ1WGU0OUk2eVY1bGQ1WWltS2VD?=
 =?utf-8?B?WmpGbnZLMlhXcStxWmtxQWhCRi9GT0pXNnMrSVFGYkJMRUFsclQ3NDg4OE1S?=
 =?utf-8?B?MzkrVUJmakhYS2poMC81amUxK3FBTVdUYXZwaVM3OEhsNnZxMllWSlVxbE1X?=
 =?utf-8?B?Qit4TUlISnI2WUc0ejhORjc1b2VzOXFnQ2NienUyU2RIU1d5L3FZTXhyZmJm?=
 =?utf-8?B?ektwUzMzOEZObGRkME51R1dlUW1LVURUd0xUb1QvM2JxOW5idnJGUWx2NE1V?=
 =?utf-8?B?N0tYZWR4a3UybzU2TEtZSENCY1pYajRER1lWeVdoSG9PejV3QjAwMklaQVYr?=
 =?utf-8?B?NHA0MWlQTU44d0pEUjlWbFp1QlZ3QlViVzhQbE1hWFVzYnlNN21Ua2hSbEMy?=
 =?utf-8?B?R25aRU9GVVJnL09NUjRpNXBlQllxblZxc2Q3bUNJd1FGeVJoYUU3VnU3aFAz?=
 =?utf-8?B?eG1HVlVVVkxJU2VGUTgxZU9MY1FLYjNrQjgvaGxUUk9aRDFiV0ZXdTZvMEV0?=
 =?utf-8?B?UGx5MHNKait5clRFOGNubXJCQjdiZThYdEg5UzEvdWIzLy9xejVqMWFhb3pt?=
 =?utf-8?B?dWNTdDJNZElpYlpkNUNNcTBTclpZb1dteE5ReU9UVXYvenYyemlTUzhEUFJW?=
 =?utf-8?B?UE5xNkNRbjQ4VXRvUThraUYzMlExOVVjbjRXeUFiQWh0VE01bER1WXA4b0Rp?=
 =?utf-8?Q?VoI44AL6ozYoqWU8vq2D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c983f7-343a-4189-229d-08dcaf6628cd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 00:34:08.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5383

On Fri, 12 Apr 2024 16:33:32 +0800, Inochi Amaoto wrote:
> Add DMA controller dt node for CV18XX/SG200x.
> 
> 

Applied to sophgo/for-next, thanks!

[1/1] riscv: dts: sophgo: cv18xx: add DMA controller
      https://github.com/sophgo/linux/commit/e0b2125b9dcf0c7efcee887c9fef93c45b6705e1

Thanks,
Inochi


