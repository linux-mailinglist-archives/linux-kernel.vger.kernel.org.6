Return-Path: <linux-kernel+bounces-292458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1725956FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F3F283B41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FCB189510;
	Mon, 19 Aug 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iEldBPfo"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4452188CDC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083358; cv=fail; b=hpTKE8OVMAHywUooDob9whkP99FoIfG6Ms7d3kqWMrA6lAHenP0zZlYvw1wY3n8gXaLeAJtVLFRsr6RZdPv4OiI1oz75Ht30elgghACRPXg67xgtVWOymQO+jcOD+4LIhMxxS4Zjzki8NetiBPZxaBHfqG2fZC6B2lk/Crqto8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083358; c=relaxed/simple;
	bh=/kxhYgzUferEekPx9wl+SzvtPGPz+R1s1O4alcaJOX4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WiQGkkiMnnsMXT4TWFnG84okkDcpNHL4yTvclq4cnhPX9IxT2wsHAPKP0V3mtLLTGVm8fiyElzghMv5WfQY1Pty/Xe2NA8vhusKVuSNdUNOGW9ODlI8wMKAYArbWFhZmjxn6oC+OLlVC7WQtn3fPQzAqmKCgEiDdaMs2SudIJJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iEldBPfo; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKLc4nTtfI/DbNMDwnuLohrU5pmnwU7GQMjeS2pljVD81NyAC3B3S1OmB8tIgbr+eSw2aFYbOBbpBF5/ZzA/pYtTCRIvZqQj2/NQrgSjpVsvCqflUkQyPwDioZVaU7N7SglFiKYnBL0Fym+UBFrf01+nJ9fY5MWQA7/kfwsaoiN3tWtcgLDIRenvLs726Mrsm3dLtThAIWhPTyBKMBxSt004JDcgn7QYOgvKpj3RNpFHgrfUGfBcKj1Zh9rS2xZsmj4fqnOwnn+VT4EplpdyHq4Ju6l8a3Odo+BCsT1a0MFrmDYSu3dnMnFJHq/+U7veXu9GoPpDF7hyulvnM/Bddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05ymFfDlx3mt6M2jYBSt9COY2d4c3YvJgPLK5JzhTZM=;
 b=c8ggPmEKgEy1wv5qW5BfHrwXZAw57z0W9+rNLUaDiw8AohfqLEdgLEVZhmFIiFk+wuBxhegpo508L5Gr6p/eTSdjpmFalruT8ZL8/oPa17zEgTnAc5UYJVASbydYlbQOeyfZhm7r5ul2iMx9kS36hyljYKRm8I5mPeS0m1g7RvUPw38HJ7O9OMiZWBt4WyajrY46lfhrsjRRT2qHIgRMO3BYjXODHlJzxJxPb0w8vjrEKdd1t2q/tPW8lWUWia84zmbzMme73y6m7r2/WbcCT3Mh3edjxOD68nc/1kgsJk3uC1H8uTe2rf3Tc5OTRtRmjpqVUcjvGVnPgT2oNSXU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05ymFfDlx3mt6M2jYBSt9COY2d4c3YvJgPLK5JzhTZM=;
 b=iEldBPfoPa4CHZSdvVGSJC8AvryvilnMErkGraQB0Gpp9R72NoxzQZmREsSzn/tyKD/tLAsed5Mxw7hGRplQ93rx+Gt569Mad2lu8HE/+mKJqqFOWngh4RGNvvVYHsqYO1YCGQbtWlnEM0gbtciQCbxJKFCVFBBYWp8Zk+WSoPAWUH1ZREeo7SVsa94T6EXl6alJHQ0YOdzVQCGIqpdB6E/v6xaMudH4MI9splMuV7ennHjKCj1zx9mWodLpY5T5lzPS7+KBjvH1dQ/kfdv8YvPWW7SfZ3ULgFl9uw6jcMGZsthWUXh6428aXT+aOCh1zkAhm5HPFoP8S358U3CZkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9659.eurprd04.prod.outlook.com (2603:10a6:10:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:02:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:02:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 12:02:05 -0400
Subject: [PATCH v3 11/11] i3c: master: svc: fix possible assignment of the
 same address to two devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-i3c_fix-v3-11-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
In-Reply-To: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724083326; l=1988;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/kxhYgzUferEekPx9wl+SzvtPGPz+R1s1O4alcaJOX4=;
 b=MoBziw2awxiRpomGR6mnOWKnvE75LqKwPWuK71bCcQ8Hc23Zqeh2jl5t4nWYM9vQmcK/l3aic
 coB0VToW6zZCXZoILMjBR1lJt3UwfIyva6aBZpW0DrZQn3rvfZPEUFX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: aebc813c-6100-4561-9897-08dcc06855ea
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MzQ2VzVFWUJvNnhyY29nOVJKYXpQV2tKSE5zZWpBTVZmMTFScjNJSHJuVmpk?=
 =?utf-8?B?TForTEs4M2o2WGtSeWhRbks0TFlYTmhWTHBMQXFwMjc1NHBpYjBiZ21tRnZF?=
 =?utf-8?B?V3c3V1h2QklLT28yYmhYTjFCVk1pcCtMOGcyVXNXV2JkcE4wMlR5clZsUXhV?=
 =?utf-8?B?Qndja0xHMi9EU2VVVTRvSkJ4UG8yNWU0ZHBHOUJSdmFKdDQ3WTJnVnZRdit6?=
 =?utf-8?B?QlRFNWlCR05GazBMY3p6QXN0N0Z2S3FWN0k5ZlllUy9FRHJIZ1Bib1cvcHVP?=
 =?utf-8?B?NUM1a3R5bnFScFVKdDdRZlFQOHhZUDF1MGd2MHFteXBqUEFMTGN5SzJ0eWgy?=
 =?utf-8?B?dTdBUGVEako4TzBTWUFXVStyemFVWHJQVkxhLzFrVjlLMEVneVloWDRESmph?=
 =?utf-8?B?cVFBamIvS3QyNXlhWnY4b3dkZnczcmVHZHdjdCtidFE1MzV5d0twcGU4Q3Fj?=
 =?utf-8?B?VjRubjhQcmIxci90VTk0bjR6aEt2b2Y3QjZIVDF2aEk2WCtGZUxZelN0VmVX?=
 =?utf-8?B?a1lYTkpaWjBDSkFwTHpYd0FDa3BIRjJ3N29JWGlrbk84U0s0cWIvWUJmeFVq?=
 =?utf-8?B?Z3RVbWlkUW03TUtXMjB4eDl1am9sV3VFREZRdXAxUVNLQlp3ZCtNLzQzV3lr?=
 =?utf-8?B?YlJ2T2VNUnJvVzhhL2w3ZXIrSlZmM3ljMW5QaFFLL2F6SzJIUXlqZDZOQ09y?=
 =?utf-8?B?eU51S210cGFLbTN5M0xPbWEyZ0ZxZURMRWo4eWhNMjNlTlpvV1lRQjMrM0h2?=
 =?utf-8?B?TWprSDVCenF6NENlZG1IUXlnTlV5SURWTmNXZHNPRUpseVg2LzUzS3Z3a29O?=
 =?utf-8?B?cVMwUEFHNGlVTTRnbUxXZXVvNFZXUUdWK0NOSjdpOVl5UUM1dkpaY3VOVXRC?=
 =?utf-8?B?ODNWdG1zUzdPbm91YTJ1SGRaUkJ1RllOVXM5K3JLd21HT2d1em4wWEtSRWIx?=
 =?utf-8?B?V0JBZEx5Mk9ERHJPYXhjcjhxeVdHOXU2UTd5WUdreklRZUZJUjAwMTlkNm5K?=
 =?utf-8?B?MHdQUG1LQWRlV2ZlNTVSeHpLSGMzWVRRNS9ybitaa3J2eDdlSU8weDhkanJ1?=
 =?utf-8?B?eHUvQ3NhMTFXZUhTM1kxcnJuNkg3MnYxbmx5RmNnS2ZpdnA2cUpvMFd2RVRO?=
 =?utf-8?B?eTJ3Q3hoUDQvMmo0anFQcEc1TUk3WXZ4TnpGc2hFNVVuNW1jYW40UzFxb2Fy?=
 =?utf-8?B?TzJld1dyQnVMTVQzZFVZb0VUWXNDUGhMSFh1Y2g2REVqQWNMazB0Z2pmTGFx?=
 =?utf-8?B?dmEvK3pSODNDWFREK3hBS3lSUnVmRzc0Ti8yeHRXeXdrQnVuK0VISkZFMWNF?=
 =?utf-8?B?OEdZYzNBdkVhZURHZDN2M1pDbEJWbGdoWVZTdzAxQUJZRE1yN1J4N1ZLaGcz?=
 =?utf-8?B?SnZMWjNjWDVsQUpRUkduZEpPbGhSclpWN1NqMlZqNkJpcWw4emVnNTVab2JC?=
 =?utf-8?B?ZUsxeHFLYjV1Wkxxd203STZsdWJHNkhSQ3c5SDkveHdzYmZkSHUyTDFoakdR?=
 =?utf-8?B?blk1MDhsWGF2UnVLRnM1WnZPL0pwZ0paaXFuRFpWLzhqWFBnQ3pKOEdpZVhC?=
 =?utf-8?B?VkJkYjFGa1NDUGp6cXVwZ3ZUVWZPdUw0VjR1clBocy9sMG81R1dGbkxQOGwz?=
 =?utf-8?B?dVl5U2dOU201T3JGN0pUR0ZrejlXbXgveitFeHhLMHN3Qyt2OUlaMzV3cU5I?=
 =?utf-8?B?cXZBT0VxM3dYWWFvNC9LMEdNcEVoVUpjZUttVk04RzB4SVNvREtsSTdVV1Fp?=
 =?utf-8?B?TXB0eVhNL3BPZ2dBTkloVitIM2tlNlBVS3cvNmN0M0w0enJZV1JGRGVKRFFN?=
 =?utf-8?B?bTgydFdHQ3NicGdWekhiemdTK0paT0FzcHdCR3UySDlPVVRNNmVrQ3BYdWYw?=
 =?utf-8?B?OU13b1hZL0NlNWRiUGFGMVNvQkx1amFUZ1krY01BSzcwdVE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d01pZldBR2NLWmU4M3pTaEI0c0JvQ1pyWHl1aGdYOWdaOUQ3NCtFbUJkTGVq?=
 =?utf-8?B?SDFtYzk3b1dnVlJ2ZnhZQ2hzRXBBYldpT2tvUXRzWjFIZC9UNW4vKzB6cW5r?=
 =?utf-8?B?MVo2ZityVkRKWUprSWRtN1ZRc2dJa3ZydjRCMXRGSk1Rd2ZSN2I1dkk4a2FD?=
 =?utf-8?B?OHl3Yk9GSk9CZ21Mdi82UjhaWjFrLzd5ZG05VlpROFJlNnpFWGViZjQ2anh1?=
 =?utf-8?B?UGtEazkzQ0xhM09oNTd3ZjFwRGRBUHZ3WUQ5TldVWGx1NUxCZFdkd0VuQVIw?=
 =?utf-8?B?V0YyanVYSm9DVml2MW5LbjB5WmJHaTdxbzNFVDZCRXJCbjZyektFajZMYzY1?=
 =?utf-8?B?bFplL3NYTUVSMk54cmpwRVlaRHo5WUZoNGVsSmQxMmNkWk55UXo0cjA0TGFl?=
 =?utf-8?B?N1JJeDBTdk9iZ1ByeWtBTng5R2Y1UFZ2QmhLZ2NUdDg1ejhmTDFCQzlwbjhw?=
 =?utf-8?B?Zi9oZmVpRzJSZytnK1lKRVhacU9Pa1o4OEFWd2x0V0dsSURrZXJwbFpFOWlz?=
 =?utf-8?B?dlNqaTVjYVBMclI5K3JJZjdUbGt3cm9ueDJITGYycjczSjA2U1lnNFVVYjhz?=
 =?utf-8?B?RWxMTkZnajJuM3cyQk9tUVJIblkxS0t2U0FhYkdIeXdNWWZQL2E1Z2JFLzBw?=
 =?utf-8?B?ZXB6aEQ0U212RXd0dGVZamRDekw3QThjSkZwbGdtWm04eEtiSDZPUEhxNUJ0?=
 =?utf-8?B?ZWpEMi95V1FDWUVQb0l3eFJQaHcyZ1lYS3dXMlVaV2pIS28ydUdUSCtYa0d6?=
 =?utf-8?B?cUYvYVRzYWg2eVFjK3B2VmlMUkRQZXVxRG83a2MzYnpNRzFzM0tWOXh0djkr?=
 =?utf-8?B?ZEthNmNlQzM0YXVQNTh0b3o5Rlk5Wi82MkJBM2JxMGNkR2Z0YUJlNklzZmZy?=
 =?utf-8?B?b3h5em9RVkRFRno1RjdZSlI3WmRBZEhpaXAvOGRsOG92aDQ2dUVVNDhKZTZk?=
 =?utf-8?B?VkowRUd0TVFESGp2M0h1Qm9kYXFMN0hRWGZyVkY2SHI4dG1yb1h1RndsM29J?=
 =?utf-8?B?bzFDdUZiRGtIWjZ0VjMvYnYva0srM3I2QWxYdFpqcTUwR2gwaDk4eVNBeGhG?=
 =?utf-8?B?YVF6V3VqL3BTdGRMQ1Z1RXVHUHRSdSt5N3JHM3R5WDhzanZoS0tmVzVmbGty?=
 =?utf-8?B?UVIwSmV3TWsveEpwVXZya2ZoVVlJYjRJL3BmcjVOcXB6ZEc0bi9tZERVRXht?=
 =?utf-8?B?Wm5NeDBIc25BSFJZUm9OaEk1aDJxT05VRC8rb2c3ak4yZzlDNGVkeDZ1TDhp?=
 =?utf-8?B?SUxWOFRFcXZxYWRqWkpIaXRWd3QyckxjNWJPeVVxUlgyVUo2ZVhOTVRsY1pi?=
 =?utf-8?B?SkhIOGd4Z09teWEwblh0SzNZL3l1S3lyUTUydVZTT1VhNnd5Z3RObHRXOEZr?=
 =?utf-8?B?L212Q0ZkallBSGE1WkVJRnFuYWN4dnMrTTU4VTk5K3Fub25pY2Q5dFZHa0x5?=
 =?utf-8?B?U1JreVRKZURiOTRlTnBQYjRKZ3BSVkcxZjR5aDRQTVJiMzhzNWxOSno2cCtH?=
 =?utf-8?B?WFI3eWNhbk55SXRtdkxjZmQvMVhHV2N2QWFaZWg3ODRhcEZKa0ZXbDJuRS9E?=
 =?utf-8?B?bHp4dDIyZDB4OXJlT3lJcmlzTFBLdXVsc2czYW1id1JKMytjMGF1SHorQzFy?=
 =?utf-8?B?NVBhZEx3Yk1iWkVRb1FlRlpnUGw5TXhEOWhaMytVYUUzQ05PR1UvOFlycjB2?=
 =?utf-8?B?bTlIcVpCUnY1WWZzVGZHTXEvVTFXTmZPdWExdURYeXRHb3FBRkwwNXdEVlc2?=
 =?utf-8?B?TWtZQSs0bmY2a1pqQkg5OUhTeEJJK1lYeWdZWEw4dVlHRys2VlhPT2hqQ1Ni?=
 =?utf-8?B?RS9VZ0xtUWpjVmtOaDNhWXdVY1VwalVyZWVvZTZ2YURGeXZLSUh0clZLeGUx?=
 =?utf-8?B?bWNRVXlSNHJiOVRuY3RrTklDOWZVN3VXV0FRTzFBY1BDK2tPSU04UVlwSGFQ?=
 =?utf-8?B?SU5ycGtHblpCdFpWYlRBR00yWkx5dnBwaHd0UzF4dWFqanA0ODRCcnFreFZ2?=
 =?utf-8?B?dUNBNWJ3Qk5wSHM4NFRkS3l2VkIvbWtVMFlPT3BGdm1wT0RldG1KQlI5NGJJ?=
 =?utf-8?B?WCtGcXBSNnNRSWdTTXNwOWFWQzRYOXhuclhqYk1qdVIwVTMxbmVCclNmTFk2?=
 =?utf-8?Q?w8Uou4SSYmH6p0XDTCqrK0xX+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebc813c-6100-4561-9897-08dcc06855ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:02:33.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ9A1VMGplZ+/0P8woW+FYV1GXQcZYtTrYYf69CDjnYrEQaxyUWJqVSP2Bzzz8S1PzK3Wm5dZaq9OPFQHaqvaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9659

svc_i3c_master_do_daa() {
    ...
    for (i = 0; i < dev_nb; i++) {
        ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
        if (ret)
            goto rpm_out;
    }
}

If two devices (A and B) are detected in DAA and address 0xa is assigned to
device A and 0xb to device B, a failure in i3c_master_add_i3c_dev_locked()
for device A (addr: 0xa) could prevent device B (addr: 0xb) from being
registered on the bus. The I3C stack might still consider 0xb a free
address. If a subsequent Hotjoin occurs, 0xb might be assigned to Device A,
causing both devices A and B to use the same address 0xb, violating the I3C
specification.

The return value for i3c_master_add_i3c_dev_locked() should not be checked
because subsequent steps will scan the entire I3C bus, independent of
whether i3c_master_add_i3c_dev_locked() returns success.

If device A registration fails, there is still a chance to register device
B. i3c_master_add_i3c_dev_locked() can reset DAA if a failure occurs while
retrieving device information.

Cc: stable@kernel.org
Fixes: 317bacf960a4 ("i3c: master: add enable(disable) hot join in sys entry")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 2010495906eb3..003565fddc261 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1042,11 +1042,8 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 		goto rpm_out;
 
 	/* Register all devices who participated to the core */
-	for (i = 0; i < dev_nb; i++) {
-		ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
-		if (ret)
-			goto rpm_out;
-	}
+	for (i = 0; i < dev_nb; i++)
+		i3c_master_add_i3c_dev_locked(m, addrs[i]);
 
 	/* Configure IBI auto-rules */
 	ret = svc_i3c_update_ibirules(master);

-- 
2.34.1


