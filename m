Return-Path: <linux-kernel+bounces-314684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E8D96B6C3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457261F25DD7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FE41A727F;
	Wed,  4 Sep 2024 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="dX4KSKRQ"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021096.outbound.protection.outlook.com [52.101.70.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF91474B9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442387; cv=fail; b=QKkXWJ/RQl4VarXpywqQvIGOFhBLQJsRgvuThnzEg2q0ey2q8KiyFONbyBwE+iH67Qwbe4N04J2/v5wNdFGQFyNOPsm3VC6o9iLZk+ChkxEhnXUlvLH/SLyojSMO8vzvFFQ7Qq3WZudw7xek1+A7dcgc7apGu/ioBWlDZAVgLMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442387; c=relaxed/simple;
	bh=LOGGPBkdD0rxAXZEgZWL43NSOM57udelblXichEoc2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GiTN1gW0Yc2uyxMjOMXacl0AtNtGMClSqO7mJUs7pqwFBV/2voqi9er2YFaZND2ZXHeWdbua2Wxsfj8LjuEIb+prZ07E3Z2oB8Un2qwUAQKxyOp/S5QdmjCXbdYzQP6bFVwPkVHO41bjm//PK5c9pPxZbQBfcwO+WCPhrZUCDuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=dX4KSKRQ; arc=fail smtp.client-ip=52.101.70.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxWAv1WqL3o5qEBrvfkv/oYnNQYI69luBfdfi+QfAAJ+eaA1ia3AuXMEaHIv4p2A+SK5P2iyp4w6YWMHeui6Xu0Cv8EVQC2I2ohD5/n8wYZ1fCZWV1QPk/2oN5a8mBN1KyUJ9u7L0m2gWUZnUtOLUumI5LWGo5zJgxUZPV6iGYkPZwMgbf9AQd0GUNewBDj0lb5NQz2EtXzZ3xTj3u548fzD/YTc4tSO09CizQMW1OuA/qwV9mgfnhMpd/KuT140/056Oq7IC+j/xSZXuIgrZrvuOO95UNK3M+lW4G3CFmBJDqr0nQ4yTD5eSqga0s6ccMwm/zGYh16ptMN9JG6gFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0er42cc/hztdT3CKMn6nZbwqmfbBEa0Rl0O1HZq/JfM=;
 b=fDAb/zn86BKPVhPAU/4ySAIDVrQ9TryvRqm3wg1yFrDD+Xht18xkdw3xXO/yH9DEiM5z68HRI5r92xA6bavyCY27myxVNmrRr4qzuYdvcXXlwq4ngpviRc1F8SiK7cSBBaGe7HDhQuqRsxE+06hOROVT2/eM2ZrnLBG/xV5m5fZKeYgkHFRqNgLoS27YUfRWXjBsODw56vIi+ODbPJIqxvWShtmrPDyQlRMncH3/GpwH0UxtUU2bOEX2XB33LdNZ9QOteZaS99pcGdyM1/jgg+d96Fs9wxfEhgeY/GKr+fh8nMuvPl7sxeizQ3dZXWUXx/4dOF+aqPDpYgScMoUWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0er42cc/hztdT3CKMn6nZbwqmfbBEa0Rl0O1HZq/JfM=;
 b=dX4KSKRQFMNo1CH+WMGajVaqkEBOFf7+sZiMcmPoN9er4QmNLkW2yeXa8wjYG9MqfxWSG/98XiXNLCH76rZFhQL8vcDk8KQBFefrg6raD1BMwh0SxKgn0gDKJOigtMHu4O3MzJWQIY5xLT9ayaWevKg4mAukj8uQIpcEUKBF9R8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by AM7PR02MB6356.eurprd02.prod.outlook.com (2603:10a6:20b:1b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 09:32:58 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:32:58 +0000
Message-ID: <4cf89e3d-7164-67b5-0a3c-9e8e4df274eb@axentia.se>
Date: Wed, 4 Sep 2024 11:32:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] mux: add mux_chip_resume() function
Content-Language: sv-SE, en-US
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
 <20240613-mux-mmio-resume-support-v1-1-4525bf56024a@bootlin.com>
 <94069d56-0981-2d69-65c2-901a05758806@axentia.se>
 <f5067055-1470-4386-8839-b4ec2527872e@bootlin.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <f5067055-1470-4386-8839-b4ec2527872e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:208:be::43) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|AM7PR02MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: da57e0ca-9376-480d-405f-08dcccc4904b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUYrVTFoMjhSYmM5dUlzU2RxM0FjV3crSktxVWtqVTBLSXNJaDFjdG80RVhT?=
 =?utf-8?B?U0ExZUM1N2w1V0taNlZCMjJGUFRYK3p1eDhOWVJxVVhkNXhqbUJmQWVHSzhr?=
 =?utf-8?B?U3pZZHJTWkx5SUJZd3FjUDE4Zkk2bkFrbUF3OW9OQjNnM3lOeWpzQU1ObzVW?=
 =?utf-8?B?YjZOUm10Rk40UDRXcWVVenNudVdpV2tYZjJyQ0pwYlFMTzNUMkRrSWFTaFFt?=
 =?utf-8?B?eUJybWlMb1VmWDFocUQ1SDhzKzhXZWlLQnZlVlJaOWx5cXZWaTRyNXFvekpx?=
 =?utf-8?B?UWFjWmpFb3R1SERtNTBOSjFQOFkyZVIvODMvNXlRcWFMNFFKS1pxMXVBaEh1?=
 =?utf-8?B?eVNuUk9jU1pXL0lhMjl5UkdkUjJWOFh1bkNKODVaV3J6SjIzTEpFTyt4ZGxE?=
 =?utf-8?B?cWR0SFhqeTFwMTU0NHhuVjZEMEE3dE5WMnI1cm1zejkxWVJDVk5GTmZKbnhO?=
 =?utf-8?B?MmhrV3o2Um5vRmtNTkE5MnVCaExsZTZycFBORGExbHBxWllMc041WnZsU2NN?=
 =?utf-8?B?dzByOXN1NmlyOUJ2a1FYZXpFYmMrUFBwRDlEQ2FSY0VDNXJrdCtGcytaZDNm?=
 =?utf-8?B?Umk1bURuSzlSNTE5aEdXSUJSU3pYeG0vYVBqM09IalhhalRqaHphbmFoTVJR?=
 =?utf-8?B?ZnJIdjJoV3p6WmdCbjEwQUJyYVVtUEUvMWpBejF0MEcwcGVxcmtiUDVmRjln?=
 =?utf-8?B?bWNaTVRZY1B2SWNxbUdlMGtCbUhZUkNSOHZIQXFydG9nYlU4SjVrZHhweVlk?=
 =?utf-8?B?alhiQjZmU0gzWDNzWE10ZVFlYk9WS0R5cjhkb1ByVkp4aG0wTmdnNS9hdVZW?=
 =?utf-8?B?cFJoQm1SS01ROHRtc0FMZ3ZZNEVGcC9QbW1EWmNsMzk1ZENacDFyeW5iM3hN?=
 =?utf-8?B?b2s1VUExMk9YTkMwWnVIeHd2bDBGbVoyYU80QmpBSkxucTIvV0FrcjYzYjdF?=
 =?utf-8?B?Sk0yQURNKy92bDlaVGc3NTZxM1ludXJJVE1jWk1ScjZ5U3BYaFhCUjQyQ2tF?=
 =?utf-8?B?dWRXYTF4Ylg3KytJbHg1QXhOei9wMitINStsZ3QxalVoU0c4eWNBdXNwYm1a?=
 =?utf-8?B?RlJXakMzWnk4MkE3NmRpN01UdTc0SlpjbG51SVdBbHZlQmgvdXorWVZqTFJI?=
 =?utf-8?B?Y2FkUm9LOVlMczN3ekRrNmZBQ1ZiM3F6Rkp2cFRiREtaaHlCQ0dvT0dhVytm?=
 =?utf-8?B?ZkdpN0VPK1IweXdRZGxhZmhLazRZaE1qMzBwVHJzeDRTcnBZZEdFQnR2d0RR?=
 =?utf-8?B?elBHeDlVcURkZC9WajIzeG5TK21xNk83M04vOFh0eEhqWVhpZFlMUXgwRkg5?=
 =?utf-8?B?Tm9Pc0NtQWNHbFlEcklqdjIyYllvNXdzdFpNM1JuamZEUmVDR3RTamx1RTNo?=
 =?utf-8?B?NUNVYTBqeFNGSnVRZ0E4OXdYZ245NW9RSVZOS0gzZThJcXhQaE5ldUpqYXRH?=
 =?utf-8?B?UTYyRjl2UFRTWjVWQ3pUMS9UbHVIdFNpeThRcGlWeGRpTHVBQUcxemdiYkhD?=
 =?utf-8?B?Q1lMWjAwYXhWT3kxME96Zk9DWnpTVGZpOUpDRWhvVzdIcHhqcTZFWkJMckpo?=
 =?utf-8?B?bnpRb2hvU3VEM2s0Z1ZyTlViTmFVZmJkY2o5a3V1bjJBaUhVOGRYRWpibERz?=
 =?utf-8?B?NlFEbGxQMmdvMkx3MjVwMW5ENXdGZzJLMncxWHFpYnRVQjQySFhSNW5XUURn?=
 =?utf-8?B?dnY0a2ZxMWlUVkY5eXFoZWQ3RVBlOUViQm1yZ1hPOFBqY3VZS0p1V3BJRzNC?=
 =?utf-8?Q?EIYd4RcbUol0826pvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UndjM0JCVnNhT0xWS045bkpBVDF4NFcrZGVYUlRmZ3BFODY0eDhKYkxpaExC?=
 =?utf-8?B?cFhQdnhkYW1RdFZSNDdHdytjZ2RuRjNVRXNETjYrbHJYUkt2cm5aZTlZTUhu?=
 =?utf-8?B?SzAzR0o2QlVHVlpEQllUYlVJeEZpenNuZC9qaWN4dlZRM2JhWkw0ODNnemdX?=
 =?utf-8?B?SkVQVmVjNCtUemJGQ1ZEM1poUjFTQlpqYVI5Y3lKdjFxSkhvMENiVEpXdHJr?=
 =?utf-8?B?Rk5RWktXQVFGNXB3UWwxSndncDZ3Qlg4V1ZSOHlxUlJXY3pZRFpKNnA0cGh6?=
 =?utf-8?B?ZjhhNnp3NjdQUjlSYWgvamVtc2hXcmxrVWo0REZWMW9FU3J1aGNMT3d2RlZZ?=
 =?utf-8?B?aXBYWU91azNnckdzL1FlREtPSTZ1RDFDKzYwRjJsVXlRcHA4M3ZtUzBmeXlN?=
 =?utf-8?B?VGZsRzNpWTJNUFM2ejNlQVdFaGpoN3VjTkx4WmJ3aUpRaHBqcjNZdHNjZUp6?=
 =?utf-8?B?VlhrVHRjZExUcXB2ZThOekpoVjRtWENkelBaQmxCaFhudUpkbURHM09uNENq?=
 =?utf-8?B?NThILzhnS1MrMzJ4R2xWeThNVmRzemtrbWwyWWkxNnNFczd2SFBCQzhXY1dr?=
 =?utf-8?B?QTdJSmFyT2VuR3kzZmRUOTVBWXZHUkVCdGZFR05Ec1Z0R1BQcFJrMjFNM01Z?=
 =?utf-8?B?ckcrMjcvMlNIOFRSK3Iza0RERExZTHY2SlZoRGNVbGwvd2c5UEdNL25XUTdt?=
 =?utf-8?B?bWtSaEs5bzBWSG5VVWNGbGNmeHV5U3NFVU94WG9ub3VWczNEMnRsTDNjSkgy?=
 =?utf-8?B?cDBNbGRyWHYwUFZBaFJ4R0g2R3c4TnlSdUdVY3ZqYzZZZk5UNU1TNTZ1dG11?=
 =?utf-8?B?TU5MRFdDSlFRL0E0WWVwcTByN3BUUmpyRHZZblFiVUlWYzdGeEsyZHVFeWkr?=
 =?utf-8?B?WGd1SGU2U0pFemtkaGtqck4wbmJ4UW4zcXdmRmczUzBuUU4yWE5tN3pyK2V2?=
 =?utf-8?B?aC92SjhFSnZGQjJ6eHZOWElxZDVEbUUvTUJzdnR1dzRUcGhXM3JPdXdERFEv?=
 =?utf-8?B?eklsdnVEY0lzSDNKU2w1RTNWdnhaWCtuSWUwYjc4Nncxdkx5Sm9HdzVkdEVE?=
 =?utf-8?B?aXRCaWRCbURHdjVWRFM5Qi9qaCtGUTlzRHdzTXpHbTlSUGlJejZVdFhvUkZY?=
 =?utf-8?B?Y1BFWFJsQnl5LzJNTGE3cnh1NjYrWEhOMnE5amVnZ0VOcDF3Ty9JN3VFcG8y?=
 =?utf-8?B?dDVKMVVHNzR6L282Y1Zibm55dlRGSUZsdjVWbSt0K2h3Y3lnbWtIdXgxZFRt?=
 =?utf-8?B?T1k0SXJoVkhCOEphL1liZGgxM3B3dkRQajExUEVIZ1YrUnZlUjZkMWNIdVY0?=
 =?utf-8?B?angwbnppaTdlUEhGTzlwTmJod2ZwVFQ0R1lXdlNTTlFhM0kxYjJHV0hQMXUy?=
 =?utf-8?B?czhaV3IxVDVYMGFuekJpMzJYUmZYQXNFSFVaVklIY2Q1dXhlMWFVUENMeW82?=
 =?utf-8?B?c0xVeVhvYTBiRUJjRktIRTFsYmkrUmUvTE8wVmpJb2lEd1R6UG0xK1lseUkz?=
 =?utf-8?B?dU9TK0NDZ0JqUUwzYlpZNDlrTHBpVXZySGJkeC9DeWJ1alZUZGFjTXNGNmps?=
 =?utf-8?B?Zi82aktmYUhudmlRR2d0VitKbTlyWFNOejVMWEpwRHp0WVZEME5SSHpNWTJE?=
 =?utf-8?B?Z1dJRm1ZM3FJUGlKdlRjNDcxVDd3bFgrWGk2OWdQTDlSd05rMGg2UmxnZkgr?=
 =?utf-8?B?dmJocmcrWGRPQ01oL2tMTDFjK1RRcGhNY3RGVDNxMkJLcTdxRG94Y2xzbGQ5?=
 =?utf-8?B?TWNMQU1nSzQ2SGwrbm4wczl0NkRjS2RUV1dJTDNDM3dLeTNNbVlzaFo2VytN?=
 =?utf-8?B?eHN1ejF2MXNPczZCcGV5SnNSZG1ncDRtdkRuRVdSVlNzTWN2UWxpZWs0bDUr?=
 =?utf-8?B?MW9LNDdUSklOOVBMUXJOSWkwdXZmSk5PQzI0ekY1b29Xb1FpR3kwblhvaGVx?=
 =?utf-8?B?TUhKRDZySEdVSUF5VnRVbElia0lTZi9aTHhYekZISWl5ditMNSt2OThwcno3?=
 =?utf-8?B?Rjd1N3NwaHVWYy94RDJhdnRqRmVWQ2tRSCt0NjVWdk1nTUhsLzE0eFJ1MzYw?=
 =?utf-8?B?UXV4U1FYSjROWWdYK1ZmUUdYd0E4OHVRUzUrU3YreldPd2lVV2pmZkpJUGdE?=
 =?utf-8?Q?fD2cs87lilCxeIIC8zHhPTRn7?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: da57e0ca-9376-480d-405f-08dcccc4904b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 09:32:58.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTaThzDGIsiMnNnXchSdfiRkmH7Is9B7tQpvZ7+1Ca9JmeOhCDw1NlGp92utRBnA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6356

Hi!

2024-09-04 at 11:18, Thomas Richard wrote:
> On 9/3/24 15:22, Peter Rosin wrote:
>> Hi!
>>
>> Sorry for being unresponsive. And for first writing this in the older v4
>> thread instead of here.
>>
>> 2024-06-13 at 15:07, Thomas Richard wrote:
>>> The mux_chip_resume() function restores a mux_chip using the cached state
>>> of each mux.
>>>
>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>> ---
>>>  drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
>>>  include/linux/mux/driver.h |  1 +
>>>  2 files changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>>> index 78c0022697ec..0858cacae845 100644
>>> --- a/drivers/mux/core.c
>>> +++ b/drivers/mux/core.c
>>> @@ -215,6 +215,35 @@ void mux_chip_free(struct mux_chip *mux_chip)
>>>  }
>>>  EXPORT_SYMBOL_GPL(mux_chip_free);
>>>  
>>> +/**
>>> + * mux_chip_resume() - restores the mux-chip state
>>> + * @mux_chip: The mux-chip to resume.
>>> + *
>>> + * Restores the mux-chip state.
>>> + *
>>> + * Return: Zero on success or a negative errno on error.
>>> + */
>>> +int mux_chip_resume(struct mux_chip *mux_chip)
>>> +{
>>> +	int ret, i;
>>> +
>>> +	for (i = 0; i < mux_chip->controllers; ++i) {
>>> +		struct mux_control *mux = &mux_chip->mux[i];
>>> +
>>> +		if (mux->cached_state == MUX_CACHE_UNKNOWN)
>>> +			continue;
>>> +
>>> +		ret = mux_control_set(mux, mux->cached_state);
>>
>> mux_control_set() is an internal helper. It is called from
>> __mux_control_select() and mux_control_deselect() (and on init...)
>>
>> In all those cases, there is no race to reach the mux_control_set()
>> function, by means of the mux->lock semaphore (or the mux not being
>> "published" yet).
>>
>> I fail to see how resume is safe when mux->lock is ignored?
> 
> I think I should use mux_control_select() to use the lock.
> If I ignore the lock, I could have a cache coherence issue.
> 
> I'll send a new version which use mux_control_select().
> But if I use mux_control_select(), I have to clean the cache before to
> call it, if not nothing happen [1].
> 
> [1]
> https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/mux/core.c#L319

No, calling mux_control_select() in resume context is not an
option IIUC. That would dead-lock if there is a long-time client
who has locked the mux in some desired state.

I see no trivial solution to integrate suspend/resume, and do
not have enough time to think about what a working solutions
would look like. Sorry.

Cheers,
Peter

