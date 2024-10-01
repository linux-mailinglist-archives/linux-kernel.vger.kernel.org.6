Return-Path: <linux-kernel+bounces-346393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8183498C436
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54421C211EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5524A1CC171;
	Tue,  1 Oct 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b9QXGtMK"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7A1CC16C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802546; cv=fail; b=rvTRbukBXLnnj7oB1Z6VvWDJkhvcpGZYTPQ0S2w9w/UC/wW+2mLnLzPZEcau6KlhCt1Fqz0dsO5qW+BVsPtyUae+5qJLnnxoa00/7T8CeIM4QcggFWDeGCgORNvxp+Bp/g34bHsi043VWyeVtMvpO8faTMbSbVDtmbG2hFu1bv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802546; c=relaxed/simple;
	bh=v9ysb37t9UYUAWV/t/laqr7J4MgebHgEF1/XTNH6RrI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PICyDZn6H97/JY/DUk2zViTEHrTou0ZAvVN182U7okFmjcfkN9ScgZvaMJKJ9xUvqiPGsZdAOLw47XEO6de69MCK2E9CQfPHfyFzPMCYIYFgjN1/ejiNObh1kAMKvHmZsLpoMHxwYBkllub10aiBR9k+VwuMHhDYNkMjFv41wro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b9QXGtMK; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRsOgmo428s8hiWElJ6O+wa2xJ/r4bHfSNt67X/q5gnkwtjeQTaZqyLh15GHeSpivERfHmln1siKn1UNn1YA17RP+ecqp61P1qTGDIplKTmmsRAqXRpxHvySFkedrq1jl2KOtI3jSnqdw75RLUfecupKw0zWtVbD9tEDr6uG135t9O9gqC5DePnqE8zLjomkhK4bPJfsFjhqoiY6XERXLCzhhWaZJPk4NX4+yF56t15yGPj6DtVuSbb4EXdPVqM+Fq2qh1tFJbHrrfAeNRNY9j9YKkxACyRKXSUx1X0iEN9+oRrpxh+kEUBUA09JWwJk3jU0ccEtgxZy5wuu8EJYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq2uhNrumywxyGirPsCsUbtBLGtPk1U0mtxUjUUipPs=;
 b=XroeNa6uCB0EexIMH3FEzazI4qPxyxcqbJ22UsRaBOLxP8nvgBlT7fYyd1mH4PPTFO6qKdVxqXwvCkgWoaVDqXhQYzRWtL1vfIEUlvbJKwLLaDYudciFIGqjUBwuRPWe9UFKUk4IDEb2hFSzzNwTEqBCFJsbJkg/0jhvIeLxlTOxxpVqz1OK+/A4U10kZzaCqUfsnsPpmipDwZSi75uPqMPF0Ad+2jcxk3gG9O0i6CpjKkBPrCSKPtcq3TNu0pBcx63f2fwFEAWu2UvqB0SklmXkk6STfvQjVGugiq6bRKjIWr0E2qWpIfVs9Bc5YiUP9L1oYahi7q+TM/jl9aCZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wq2uhNrumywxyGirPsCsUbtBLGtPk1U0mtxUjUUipPs=;
 b=b9QXGtMKwcjbzkmdG2m3Imw5Z4J+zvEMToWMkjZeCj9i/+BvEiFyWSBnWU1GGKH/Ym8jVNr1fj5lCcCvlkxhzmQ6DvEJScST6N9899D9bJdcyPtCNRhECMqUJV4+TIg4KnuyaO/he45ran0myVUZ9HoOVUhwvQI0vgtdxzNJUtqAU3FTpjAsEbNJO0wQgSP3Hlyu6oG/z91ZGtNgM47A3jebl4M9ePOh4PVUPS8CGAlUYTiJHKv8gekMeMejpof48B6BxDMWGYdYyhyQj27wX7oNwZU0IyzubYSKNosqpCcOeLqnFQZ4wRxwdaBTpvSt8N2Hzqli4imA42qNWrMi1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 17:09:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 17:08:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 01 Oct 2024 13:08:22 -0400
Subject: [PATCH 3/3] i3c: master: Fix dynamic address leak when
 'assigned-address' is present
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-i3c_dts_assign-v1-3-6ba83dc15eb8@nxp.com>
References: <20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com>
In-Reply-To: <20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>, 
 stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727802526; l=3667;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=v9ysb37t9UYUAWV/t/laqr7J4MgebHgEF1/XTNH6RrI=;
 b=vx3zQzJECmDBokBXBNMawCmKn+M4q5bMYJRFCmxNi00KN6/hUifccsdHdL3tD4+LJYp571BjR
 j2vJl0n0e9RB21JlPD32VePEcKtWFrwGQdpiYs5T3CvwLYEdo82Du84
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: 64464f56-528c-430b-e134-08dce23bbdf0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dXMyRW9NR0tTTVVpSTBhWU5CS2cvWWNGTy91dHdvaUxNNTczODh6cjNJUFdo?=
 =?utf-8?B?M290SnFFR2hxaW02dWNqUEh4SU9LUkRXU0tVS0ZCVkl3RXVhcHpkZnJmdW85?=
 =?utf-8?B?Z2pXdXU2ZE1Kd3ZlYXRKK0lOM1daMzI4cVdnNW4wUXNTWXVOS3MvSUJpREMv?=
 =?utf-8?B?Rlg5MTNibDVyZmVqZmNveXliZVJ0TGkwWE4wZGVRSHVoRHJuUVJpalpFczFm?=
 =?utf-8?B?U05OUEhVTGo0S1hYVFFGZktEVmpvV3BLbElKMUF1V3dpeHBFODl1dXEraDF5?=
 =?utf-8?B?Y2hQS1g3Q3dIbGtvZFh4dTFBczdiMGRibHRmaGZSeE03bXg1RDRuZ1dxeFAz?=
 =?utf-8?B?QnIwZ29FdmY2dWk0blpVMmZOVFNIcHd6blI0cURTemxqV0EyOGw2cXZYREVO?=
 =?utf-8?B?OUJpUlVmb1EwLzcxMnBPOGF1UkJFbUVFTnZISjNXaFNGd1FQYWVIVTYrbmJi?=
 =?utf-8?B?eWJ5aWYzTWx3WGIyd2k0dmN5UXhoVkNIb1lhTzVIUHl4elBxUDRKRUFTTmxC?=
 =?utf-8?B?dmQ5NU1IZmJ1OGFNVDNjZlAzZHdaRUs5dnNhZXk1WDVRMFNEWnVSQUk1bm1z?=
 =?utf-8?B?VUJBZnZYTVlDK0lmL3kvWDI3U2R6NDNyRUw2by9rZ3VJckNwZEQyUkdpVlA0?=
 =?utf-8?B?emhadk84ODRETDhOcFhqbE9LWFlZQjNTaWN1V0ZlNmorYWdGUStFRG9RK0tu?=
 =?utf-8?B?WXpEVGFGZnRteUJFa2NxUm5Zd0JLN20xdFBRMWtWMmZmNWNCVmRIeGVubHhp?=
 =?utf-8?B?NnRxdmJZUmJvOXpDUmpJaC9Nc2pUNnM0TkRsdmNUQ1RaSWo1b1pESU1iLzFt?=
 =?utf-8?B?d0pweXVvT2IxWVlEMVB1bGNLU0NjckZaVmVpUHRkWmNGdGtkdGVma29BMHJM?=
 =?utf-8?B?b1lsQVU4Vy91bS8zZFNiZURKNkRLeDQ3dS9rYXc3OGhXOXBzcmFrbDZrVFJP?=
 =?utf-8?B?ckszbzRxTEkrQzFEeGtVZW54amt6NG1WclluRnFvbmhFa3lhbDNvdzlHenNz?=
 =?utf-8?B?K0NxWSszUnEzcG1OWUY5ckNPVG1HL0RacHhZSElReHlxRy8remhlaHFodnRP?=
 =?utf-8?B?a2ZLREFHazBJeVhTY2NwVW1PRW15MWM1VnhMNHNOM3M1TEVYQlp3RW9mN1R3?=
 =?utf-8?B?ZEdZQkpvWDRER0RhMlU1eC81T3dzMVp4Tm9MdmZXWEo4UlZuS3hOK0krOUNB?=
 =?utf-8?B?ZnBYMkZ4dE02VDhZeE5EcFBtN25vUXBYdTRuRzI0STBpNmVlaTBCbW4waVNr?=
 =?utf-8?B?NjQwYTNWT0ZEL1lOWDExdVBjY1JYamF3bFh6akc4VWNxTEpiTVJyRVRkTDBo?=
 =?utf-8?B?Q2VFbmNSMlNlemtiQ0l1U29GUWM5S0JYU0JtN2ZjRGZLWUVxcWJWQWozRlVs?=
 =?utf-8?B?VHAyQ3RXdlBTNzI2YXJiRi9QVG9qRlZhTEZpZnVzMFhJS3JMbUJsb2JQNDkw?=
 =?utf-8?B?M2hOblVwNzlFNTNaYVRpWWdHdFZhMlZ3NUlDb0drUXJLUitxaVYzbk5BMUNG?=
 =?utf-8?B?QnJYZVprR2FoVW8rczhoRnh0NTg4MlplVEwyN3ZIejZ3QlVvVGtqL2lCOFVD?=
 =?utf-8?B?ZjMwT2RSdmZONFVtcFZoVGRjQmorRzIxWUxMRXp0SWRidkpIUGJsY0JGamZv?=
 =?utf-8?B?NEQ4WG1EMFplL3VNMExXeFRlMmNsNVNCc0krUVVXb010WlJoUW9uQ0ZWblQz?=
 =?utf-8?B?OHFHdUlPdlZxVEE5SjNOdEdUTTJQV3BwRHNXaHdOcXZVZ1lwZ1pZUWxXeUdq?=
 =?utf-8?B?a0RKMXJSN1NFUjRHcWtKV0dGYjRLVFpjRGx6ZC9ZSVlHLy9rUWtTZ00wYitB?=
 =?utf-8?B?UHZrdFdZMHlNSmlkbDdBN3RrdjBpWUZ4bk9JVnBaa3VDci9GRytQcnYvZkJt?=
 =?utf-8?B?dS9iMkh4dEtNMHNLa1RoSy94NDdwUWppWFBpZUI4TUlGRHc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UE5SNmFEYm42SXRyaGhmVlBGMkoxK2svOU5sVEFkL05XaVh6VEpIaHA3QU1Y?=
 =?utf-8?B?WDIxaVJ1WkMvZ2x0L0Q4TVUzSzY1N00welNXNzQyRGtRUHYvZEhmT1lWeDZ1?=
 =?utf-8?B?ZDlkYlpIc0lyMkVlSnlXR1ZtNnYzdXVtd2cyTnBSY0FIR2FqVVBoYkxmKzhm?=
 =?utf-8?B?cnNLdkNUeFV5WEQyeTJLaGJFVHhrcmMyZTIwS2VVM2U4Y2NzZ29PWEpEU1N5?=
 =?utf-8?B?Z2ZFM01seDBqV2JIZzlKRVIxbGdpK3dvcVZzSzlDZDY0cFg5THdWbHdiWGxJ?=
 =?utf-8?B?d3BEc1hnV1ZYQTlhQ2c3OUp3Ky80TGljM0tZK3V3amk2Rkt5RDNHU3c3dU4r?=
 =?utf-8?B?ZFZDRElQSXBwcmEwSzgxcVFmRGw0MVl0SkFuRXFPZnQ5Qm1TVVNaVzZsY0VM?=
 =?utf-8?B?YWZPWXZDNXBsaE5xblZjN1lydC82V3hFWHJKcmlKbDFtbllYTDNUU1NtN0Mx?=
 =?utf-8?B?eEdKWmVWNjFaY2ZQZ2tyOGUvZ2wzZHJ2ZUhiM1E0cC84dDZlNFRUQ2svMC91?=
 =?utf-8?B?Z1lWbnFhVzhoUFovdmJiQTIxU1AzY000ZWtKMm9iVEtnMHEvcGx1N3JkNHhB?=
 =?utf-8?B?UVdOMFhFaCsvazZVUXUvNjFMQWx0cEp1ZVZsOE5NNThOaldYMHYydzFnZ21V?=
 =?utf-8?B?WHhWeFFrSFg5SG12RXNqVUpiT3k5d25vNEVsT2ZJVUNpYkNwUGF1NTdqRVVx?=
 =?utf-8?B?YXNyTVJjUlB3NlJrTW01NngrWVUwajkwNmtmd3FNOHVCRnN5em9VRkw4Z00x?=
 =?utf-8?B?cER1enNUSTkwZFJSOGhBek5yanR1YWRmMkN6bmUrSEx3NlFoRStleUpOcEta?=
 =?utf-8?B?L2I2WUdJazNyYSs5L0Q2Qzg0bi9mYzlKbTNWQXJ0SWtmb1AwMko0QWJZb01K?=
 =?utf-8?B?aXQxYnVOMS9hcWNwdlN5WHd1VkNETmRMdFVyUU40Ny9BV3owZU5GZW1vSHlK?=
 =?utf-8?B?bXV2eWRBSWluYzVIZTJ4OG5SNUJ0bmVxakFQSS93VVVEV0x5NkN1YllYYkZl?=
 =?utf-8?B?cTFxM2wvdjE0YWV3ZHFhdTVpMjZuZGxFdXltdFhXL1I2VUQ5RVBscGh3eWZB?=
 =?utf-8?B?aC84WXpWUGhNYnZjaVlSNVV3dy9QWDVtS2hld2w3RDVOdTlrSUhzelV4cEVK?=
 =?utf-8?B?Z0Q1eDhLTFJ0RE9jbGtVb3ZodldvLzNFdDZyNEpwREhpOGZaL3NvMndhMnp1?=
 =?utf-8?B?VG1uUEVhUmJrWkdWeVByNWJRcEVTeWJUa0hIVXQyZTVLbThnRkk2NCtGY3hQ?=
 =?utf-8?B?NzhhWjFlWUJ4L05JTnJkL3ZScGV0bHB4OE1nVjRzWmF4TERhbGdCMXB0eWF4?=
 =?utf-8?B?MWo1dzV5TmdPQm1JSVV6YmhVWGdhZ2dDM1g5VHpvelkxNU1kT3Y4bzdBb0FE?=
 =?utf-8?B?L1gwV2pGdDk4UXoydkpOOUNBNjk0VzA3WDVGKzNaVjcvNjlqT3l2NjRpa1Y4?=
 =?utf-8?B?emhYeTNsemppVUNYc29DRXRpOHk2ZkUyc04wRHRHeklXbkZSVlNuNVQ2L09z?=
 =?utf-8?B?a0NoV2lFWk9pcENmc1FsYW16cFQxOGlnZ05jWGw3MTUxcXEwR0N5SEZmc2Ur?=
 =?utf-8?B?R01DTUZLdXFXYzg4M0pYMW1WeVFnQ2RXU0dZTFV4eGFENkhCbU1SVjRUKzd5?=
 =?utf-8?B?VnFiaEJ6NTk3UTMyNkM5WmRQL0JPbVF1TmZwb2RZWXpvYUpFOW1ROFhYS25z?=
 =?utf-8?B?bGV4TnNCTnBrNDVNKzVHY0x5NHJlSzNSZWgxeWFLNEhKTEtaWUpBd0xpWFIy?=
 =?utf-8?B?ZlhnQi9MQnRhNmlrUFNHL1hQa0h1elFocWxoa2NkZ1laRUs1U2dLOFVWOG9l?=
 =?utf-8?B?SkU5QittQUhCa1c3SUdFZnpCQlN4NVFnbytYSFJSZGJoQnlmS0lOTXMrWHZS?=
 =?utf-8?B?d0hWQXRQdzh1K3ZMT1BRTzJYTzBLY2htQ3l4T0Q1UitoYjYyQkJhbUZIeHRs?=
 =?utf-8?B?aTVySlpGa29jaWYxaFNqcHJkaTFIa2JQZmwrek42dWsxYmF4WnRGK0lZcUdq?=
 =?utf-8?B?Y3hmcHVqZDc0VTBqMEJURDdDL0NXenM0VUJ1V2UzN256VVVFNnZpWnZuVy9m?=
 =?utf-8?B?MXRLUEhqU1l1cFdIcnFBOVk5VnVYYXRhZG4rN01Vb1dEc2JmTEExUWlnSFV4?=
 =?utf-8?Q?kY5O/qeN3/itvLxAEopHAwNyi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64464f56-528c-430b-e134-08dce23bbdf0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:08:59.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GysygEz74+9CNS6PQsDB14H7DYIqpJH+dECNFJRHW2woNlDBfd4vWro/VDk2pKNla5rO7AOq8AoCcYkfEVCQwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763

If the DTS contains 'assigned-address', a dynamic address leak occurs
during hotjoin events.

Assume a device have assigned-address 0xb.
  - Device issue Hotjoin
  - Call i3c_master_do_daa()
  - Call driver xxx_do_daa()
  - Call i3c_master_get_free_addr() to get dynamic address 0x9
  - i3c_master_add_i3c_dev_locked(0x9)
  -     expected_dyn_addr  = newdev->boardinfo->init_dyn_addr (0xb);
  -     i3c_master_reattach_i3c_dev(newdev(0xb), old_dyn_addr(0x9));
  -         if (dev->info.dyn_addr != old_dyn_addr &&
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 0xb != 0x9 -> TRUE
                (!dev->boardinfo ||
                 ^^^^^^^^^^^^^^^ ->  FALSE
                 dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 0xb != 0xb      ->  FALSE
                 ...
                 i3c_bus_set_addr_slot_status(&master->bus, old_dyn_addr,
                                                     I3C_ADDR_SLOT_FREE);
		 ^^^
                 This will be skipped. So old_dyn_addr never free
            }

  - i3c_master_get_free_addr() will return increased sequence number.

Remove dev->info.dyn_addr != dev->boardinfo->init_dyn_addr condition check.
dev->info.dyn_addr should be checked before calling this function because
i3c_master_setnewda_locked() has already been called and the target device
has already accepted dyn_addr. It is too late to check if dyn_addr is free
in i3c_master_reattach_i3c_dev().

Add check to ensure expected_dyn_addr is free before
i3c_master_setnewda_locked().

Fixes: cc3a392d69b6 ("i3c: master: fix for SETDASA and DAA process")
Cc: stable@kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change v3 to v4
- none
---
 drivers/i3c/master.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index a56cb281e6b6d..eae7449f0dacb 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1556,16 +1556,9 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 				       u8 old_dyn_addr)
 {
 	struct i3c_master_controller *master = i3c_dev_get_master(dev);
-	enum i3c_addr_slot_status status;
 	int ret;
 
-	if (dev->info.dyn_addr != old_dyn_addr &&
-	    (!dev->boardinfo ||
-	     dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
-		status = i3c_bus_get_addr_slot_status(&master->bus,
-						      dev->info.dyn_addr);
-		if (status != I3C_ADDR_SLOT_FREE)
-			return -EBUSY;
+	if (dev->info.dyn_addr != old_dyn_addr) {
 		i3c_bus_set_addr_slot_status(&master->bus,
 					     dev->info.dyn_addr,
 					     I3C_ADDR_SLOT_I3C_DEV);
@@ -1968,9 +1961,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
+		/* Not mark as occupied until real device exist in bus */
 		i3c_bus_set_addr_slot_status_ext(&master->bus,
 						 i3cboardinfo->init_dyn_addr,
-						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
+						 I3C_ADDR_SLOT_EXT_INIT);
 
 		/*
 		 * Only try to create/attach devices that have a static
@@ -2133,7 +2127,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 	else
 		expected_dyn_addr = newdev->info.dyn_addr;
 
-	if (newdev->info.dyn_addr != expected_dyn_addr) {
+	if (newdev->info.dyn_addr != expected_dyn_addr &&
+	    i3c_bus_get_addr_slot_status(&master->bus, expected_dyn_addr) == I3C_ADDR_SLOT_FREE) {
 		/*
 		 * Try to apply the expected dynamic address. If it fails, keep
 		 * the address assigned by the master.

-- 
2.34.1


