Return-Path: <linux-kernel+bounces-346278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF10F98C22D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFAF1C2273E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3F11CC15B;
	Tue,  1 Oct 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iusyqb+h"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213201CB331
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798633; cv=fail; b=JNQNklZZk2AN/onBhSNrvFUWJZg+nNE2penc8pdBFW6qwVKlzjcrIKUQIaknxL17T/lUwS5R4vOUn2MU0k6mZn28/pjOZYsQndfnFQTP3f1JKOCpZiojKv61qiCaE84FvAlGZB5hncSH7Dfds7TsFU6sxPBr7V5QVcVXajGbXZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798633; c=relaxed/simple;
	bh=Lzz1dEezZFI4AwXDduLO9+qDTwqAGzmLOSOsxS0fuR4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OVrq8XvRNKFf0eDt1sqNU8+JS+wJmQ5Xbi4+CAeDmjvmXtoGkIaFOI7IudZ/Hz+udpnpflw8glKiyl0d+gUYGZYaQiKXCF8Y9eXtfAz/Yqil9mX9NW12e3a7dvJz2V7vh54/KeCH8kj5pHnA5UJB58U+IhisQuT/5gb2bfYtv08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iusyqb+h; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CX7JH/69AAEYU85xxdbHUz7zfutJFhkzK4dVtVNxKLDvURXCVBGkAl1QRaGkPkbeHx5zrBYONJ7ytvSlKb2I+yt5IrxdzvRnr8CjDjfwYU8NGl6zoDoWHHsiVzQx+LvZCxBOid3xYYSV3zXmCZ61vXKV5G3/0gfT8LmxtREbxG9JMLPNKCyvX4rITRmWRDkjgOkaFqngojmo7zijm43bPZppuxjAstC5hi54ns1WEhKvdb1Tse4HNIwi+Ni5ViZnY4geNlIytUJkYP4I/fubOcejzqbev0/YuVgM2Mart4PFtQXwTUwEKUDntCRhdm/tzktzKTBoQgTeDDBWbmH9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cRfK2j38fogPonMcQkqHwej6AD1wb6XToeJuSU7HUk=;
 b=swipQALJinw05jynUvaosaQuylaulEVHifKmmjCbynuavD42L8mMtqp2HelBJ+RYY5QgE53EvnywTTPd6U4Yde56Ymoa6BmyCeVn5tgjj2ixmdst2Z2gPE63mdYYUs3gOxOD5ScMCej+bmXiAkNc2v07OcLG9izuQe9PJ5P2SAGN/oEN478Rd/eeH4eu92kk4hLsyZR0EV9T2vbnacL7zeob6ldj01W8ENguH1T5fcvCk+dtmWS6wNCXqB9/6FQO8X5NKe12qlYiCRM9fn37fKYuAZhHZjwl3tsaGwSugBp4/TF/27F/13MfdpusGfkNRjZFm2IJHxyebiS/WFmSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cRfK2j38fogPonMcQkqHwej6AD1wb6XToeJuSU7HUk=;
 b=Iusyqb+hjM/wIDyvF7O+GGlDmACAn6r5Zo9DMmOTtA/EZ5CDxH00I3j47iemPxCzQ1lmjIom1qndPLaXJV+Y6zsbWhXK0B3q2Yg5VvjYGmotZ5NiyorC1gzVr25nUbuwTM5rWHc/RAj2AiYOOlnWa5+I7qkA62TipveQYIWsZ1A1CudX1FQoyatZEwAGKadqCfrldlhRzEBm3luJGcK7683Eo3NawmsQU3ufUL2ItpF9quItOVriy1E2OwKpsee4aIDBIJwqByH6Lr+2+C/8t05TKDEalHCsSp2FcXEQlmDJP9AmCTDB45dsewSOLBBK32cT9OGQ+B8jp96kHWTPVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10437.eurprd04.prod.outlook.com (2603:10a6:800:216::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 16:03:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 16:03:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 01 Oct 2024 12:02:55 -0400
Subject: [PATCH v5 6/6] i3c: master: svc: fix possible assignment of the
 same address to two devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-svc-i3c-hj-v5-6-480ab8aed849@nxp.com>
References: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
In-Reply-To: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727798616; l=3184;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Lzz1dEezZFI4AwXDduLO9+qDTwqAGzmLOSOsxS0fuR4=;
 b=TEXoN3k0liEFXoQbSInw+FiOr88enzOfH63V69sf7J/hRdxFHRKNOpX6qM5ZoBKPzNlJpLOAt
 xLOfabkDbAlAdRypyYDKOEaM4PFYpLyRZOM0vs04xLapuGC51v5u0FW
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10437:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c6114b-3274-49aa-bc1e-08dce232a1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzMwNVFnL1pXNzJVUWRYaXNHNFRmbkxlbmRQZTFTVWgxSFFwSDJ6VGpsV1Iy?=
 =?utf-8?B?UnpKYjhEdFNzS2lEMFZQcFJLUjZEOFpuckczTGcrMElwYkdRSkxRQTN6N3dj?=
 =?utf-8?B?bzl4TlU3N2MyUm1YalhjSmV2TGMrcWF3M25hYVBHUmpOT2JTaXhpdXNMWCtB?=
 =?utf-8?B?eWkzdFJheE5qbXgzbHJ4Sk5IV0krV05HRy9mTEl5dnVZNnlhWUVaZ1lHUGpr?=
 =?utf-8?B?VUxXaHd6cERZMDRhUVNtdlBvVmIwQi9jbW0vMExlNDJxUk5BQmZxSmt2aE9u?=
 =?utf-8?B?U3NHSjBROC9IZFRZMEU5SVIvS0MwMVZjcnhBcFBodytHYXdOdUZzamVtd2R6?=
 =?utf-8?B?b3VkNHAwOEVQcmw4WDdlcFBxeXRxeWk1N2VOQUpEbk53YTFEcnlLclZJR3Z5?=
 =?utf-8?B?Z1JoSjJybzgyaXJLWlhqTERlclBVYVl6SUJIUEg0L01PL0k1d3V5MTRlVjBU?=
 =?utf-8?B?VmZrYVN0R1hJaGNmZUtCa2wwUFdmN3VaYVZjSmdIWUtSVDJlQkVPVE1CcXVV?=
 =?utf-8?B?V293ckg1aUtZOSt6VkdiQmZ3QlFYajIybldXWkcycFBadzB0QW9CZ3hBaW4x?=
 =?utf-8?B?ZVY1UGZucVFuZTNtR2pVUjlyQ2sya3hOYVdxWmR3SkNuR1RhRm96STN0VDdw?=
 =?utf-8?B?WUdjMll1ZzQxU1NGeWpLT0hFejVldWJkRjNOSDZKY0tVZnZzZXFSUEx6YURt?=
 =?utf-8?B?TnhNT1lnYkZmN3I2NjNJK0xQSHNaTWxzc0l6MVVzR0RCSS9WNmcwalA2eWZX?=
 =?utf-8?B?V2RCSzRsb3k4b0VMckdOay9CMlZRaGVmSVo5KzBHMmhBR3lmRmxJc256MitI?=
 =?utf-8?B?SWVFQ0R6TVVmakFMZ0VBSlR3SUFHZTNOY0ZRbEtob1FmU3h2MTN4SUthakth?=
 =?utf-8?B?UURMMkRjQUxhWkZDU1dSTGwxSnR0eVFhOExBd3FCOG15WFk3ZjZKN0kva2sr?=
 =?utf-8?B?NVhsL1FPWHJnc1AzaSt3R1dFRStUYnVwV2tXUGs4Q0pyZlg5eXRSdmRMckJp?=
 =?utf-8?B?NTRDdjBPbVVoaG9wWTc5Y1N5MVorSmtkSW84OEhTbmRFdk5sbkJObEcwaTN2?=
 =?utf-8?B?cXo1LzcvanNyQktUdkRETE9kNktub21RVFVHaDMrcUFXQ3FzeGtmc00rcC91?=
 =?utf-8?B?azNTbTVVUFltU0NzaUhabUcrdTcvbWhWMDUyYS9peG1abnZzRkZobW1wV05J?=
 =?utf-8?B?UXhDWjA2bS9lUDJaQlQvaEJ1cFlhZnVFaTYvbDVzVlVJL1QrU25WQmZKa2pD?=
 =?utf-8?B?UEIzSklQSGxiZ0N4NU1KZDBPb0VGbVd1RnpLRk12eCtaRHNqdHJwZFNnV2xh?=
 =?utf-8?B?VVNYZU1jSXhTZERhNmxGa0g4VmdhZ3hsNmxnaVdCdFN4VWhGWUxPa3BoNDln?=
 =?utf-8?B?WGxkNlQ0cmt4M0RnZGJlZTR0anNRUThJc0NNd3MxM3ZJa1kzODk4N1VzdUFO?=
 =?utf-8?B?aGdGa1pjQUFvMWhmUTJ1dDkyQUJEd09OSTFMUlZTWjAxcUpvN0crWUZNclRs?=
 =?utf-8?B?YmptZWZtdktjLzFZZUdSTkFLU2pIekVjVTBDS29aME9LQ2lUbjhSSFgyeUFO?=
 =?utf-8?B?VFZiMU9nd0N5aFROeG8razRIMGxCczZZVElMMk1iUnhza01iQkhEUHlMdXBZ?=
 =?utf-8?B?RExhK29kZXdXMVZyUTJEazZsaDAxa0tQNmlwUllpVllVVUNuVGk4TTNQajYv?=
 =?utf-8?B?WS9zWjI0SGpQNjR2Tk5HMGQ0NnRxNk8vYUNhS2Y2M1NsK0FCaVhFc0J4cnBk?=
 =?utf-8?B?bm9mQnJxNkpKSmNEbEFXWVdFRWdyOE9XbVNaSFhxV21vUzkvT2t3M0xJYnM2?=
 =?utf-8?B?b201S2ZOeVN3S1FzVDJacFRKUHV6bUFxWkFZN0RnU21MUUY4Rllvem5vZHVL?=
 =?utf-8?B?cVZyZzVFKy9pNmMyc3VBNlFiSFc3eFl1Z0FWcGNxUlc2S0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnlDZm00MGNuMFFZWGpXZXBrZDlJcmdOQ0E5VE4vdmtMdTV3T3gzekNJcDc3?=
 =?utf-8?B?Q0JOZU5OdVNubEpLS3NMZVRyQzFVVTJxS3U4TVFWYURBMW9zdFA5VjRSb1hF?=
 =?utf-8?B?dTdhYUJPbVVLc2ZSdlJTeDJSVFdvU2IzNzZLV3B6K1diSzl5cXZkVXVwVmwr?=
 =?utf-8?B?Y2w2S0xTOHEvWG9nMkxMMDBUc2NoS2hBckpZZzVjYnNrN1VDVkJMcVowUmhj?=
 =?utf-8?B?YWVma1hhd09IZFpBL3RCY1RtQkFiOS96Y25ZS0ZkNzAwbDZvK3ZZZUhSWVBL?=
 =?utf-8?B?YW5LU2YwSmcvUEo2UTc1ekpVdVkyQ0orOFJWUEJxWXYvSko2NEkvT2lkc05Y?=
 =?utf-8?B?bDVRT0JYajF2WHZReTlEUy9YUk94NWJGMGh5YW1aSFp1b3JsNDFTNGNEWW8v?=
 =?utf-8?B?d2lvd0E3MEJBbSsyWjVJZ3VVUHVsVWhkN1hUcWkxenBNZGN6SjhjQ0xsR21a?=
 =?utf-8?B?U3gyWFRwakxJZjI1MHRYMGRkZmdLME9OditPbmYvOXRXV0hwOVp3N0szTTRt?=
 =?utf-8?B?aVBzR0xFWGVIWGY3dXJEVkFuYTdlaXZnUjNEUlJFQXdZKzdWbGprVk96R2NZ?=
 =?utf-8?B?RVU0UGl2cVhxODhQZVVQa0cwQzJJTmpTRWVMa2F3endPQnBuSk10N09FdmhH?=
 =?utf-8?B?YnNvMzVuZ3BmeUtTak9LT3phajZrMFFHU0lEcHRPT3c3MjVpcGtlNVpXWFZr?=
 =?utf-8?B?S3Q0RXBxNVJiVHc4WEpsWnlpKzYrVGRZclpEK3gzbTQyOEY5V1cxa2daQVNy?=
 =?utf-8?B?Ri9hVlFRenJoVStyaXo3ZnRzRHlaL3RYOTBNV0ZhUkswalJJVzZPbFcrZWwy?=
 =?utf-8?B?SEVUNTF0dllKYVlnZlBuZklPbC9ycGFoMlV4ejJvYk8wSXNYcG9ZOUNJeGZX?=
 =?utf-8?B?YlhmM0d4SzgwTGVGajAxaXBPNC9nM3oyMWVXcE41U0RpWFFNY1B1cVh6Q2Fy?=
 =?utf-8?B?aXVKeEYxWFl0SzhzMGcrc05yTDVESWlKSC80cit4QjkyYjdxYjFpaStLT0NK?=
 =?utf-8?B?U3lvWTNSSlRLc2lja1hSdy8rb1lhRHB4dEJocmJDVU1SZWwveVZSYnlSU3Ro?=
 =?utf-8?B?bkd4RXRnWHJPejlPWFduT0J5cDh5M2VtUXliSTF3OWhzMHV3NjBlWHM0NlNG?=
 =?utf-8?B?U1pNbXVzNmg4T2J2YXZrL2dZbE5aU0ROd3dtcC9YQkduT244QmtvNDU5YzFn?=
 =?utf-8?B?QVJqN3RvdWNJcUJqSjZDVEdodzVyd1NrRUsvaTZ0eVdmcDhiRkVkQ0FGd0l1?=
 =?utf-8?B?S1N4b0Q2ZlJSRkROUzNqYnRjY2ZiZURmR0czdm9pVjFwQy82OXJWSjBmeFU4?=
 =?utf-8?B?akV1bmhoYTBuOS9JZVhlaHIra0JiOWlCSjhqeit6L09QQ3VnZGc4bXNKdzJz?=
 =?utf-8?B?V0UzZlZXZUplS2hneUpjWERWeElQdlFSSmZwSml6dWFIak5qUGp1VlRaK1hS?=
 =?utf-8?B?Wm12TDU3RlV0ZmVhUUQzWWhpT0pIRDhsU1U0Z0FyUWNFNGJPU2FTSE1PTVQ1?=
 =?utf-8?B?RHpSakh0NTFHU0YvN0F6Rm4waU52Si9FMzNSemVmUnNOazlSL0pWUXU1VjZv?=
 =?utf-8?B?Zkc4Q1VVbWdLQ1M3ZDJUY2hxZk94RWFRMytOQkEyNm9tcnBPcktZSUpjMTlO?=
 =?utf-8?B?eTltOVdzVTFkam9JUTJ5dW5mcUE4OGVwWDdMUWlQcXk0dHZjZHF0SWhkeDNG?=
 =?utf-8?B?WFVMNGlmQitEWmVFdlZRZEdWODRKQ2RMQnY3RWFVMkhxS2NXaUhOa0ZoK0hI?=
 =?utf-8?B?b1FXdHFBZGlyQTgwaVVtYkFyVVZUYjVway8zeCtiMDh1eWdZWVFrRkFtaFhE?=
 =?utf-8?B?VytYZzJFZFAxeWt6U1pKNFlhVys3c1pVbis1S0xKTFVyVXEyd0FWd1BIM0J6?=
 =?utf-8?B?NmJrMk5ZdHYvQU5CUkxiUEhMVUNRWkF5bGVQRllyNGxoQkFqbVQvRTZvQWFL?=
 =?utf-8?B?Nm1CL3VrcEhFdTNTd1V4YzRkMCtWbmQyMnJiY2NJd21xWWdpUmxHUFlpMVI2?=
 =?utf-8?B?M0t3aVF3NnV3UWU5amJrYkJKQTI1SmFBTjBDMk5qYUNPWnJqQ0NnMXk4TTU3?=
 =?utf-8?B?Z2dGRFNvN0FCRmdUNVpSNFZGVTVLT1NMZ3daR21EcHB0dWtVL3dqL3EzbXI4?=
 =?utf-8?Q?v6L8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c6114b-3274-49aa-bc1e-08dce232a1cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:03:47.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ethg2vEHRd6OS0onETZUDnWLTAFeEJH6+QrxXx8RWpOejfhxNDLx5QETYcr4WJNE17NzSJywseWDD1ZYuxt2GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10437

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
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- add comments about not check return value
- add miquel's review tag
---
 drivers/i3c/master/svc-i3c-master.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 3388c9af63fcc..7dc52111ee0f1 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1103,12 +1103,27 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 	if (ret)
 		goto rpm_out;
 
-	/* Register all devices who participated to the core */
-	for (i = 0; i < dev_nb; i++) {
-		ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
-		if (ret)
-			goto rpm_out;
-	}
+	/*
+	 * Register all devices who participated to the core
+	 *
+	 * If two devices (A and B) are detected in DAA and address 0xa is assigned to
+	 * device A and 0xb to device B, a failure in i3c_master_add_i3c_dev_locked()
+	 * for device A (addr: 0xa) could prevent device B (addr: 0xb) from being
+	 * registered on the bus. The I3C stack might still consider 0xb a free
+	 * address. If a subsequent Hotjoin occurs, 0xb might be assigned to Device A,
+	 * causing both devices A and B to use the same address 0xb, violating the I3C
+	 * specification.
+	 *
+	 * The return value for i3c_master_add_i3c_dev_locked() should not be checked
+	 * because subsequent steps will scan the entire I3C bus, independent of
+	 * whether i3c_master_add_i3c_dev_locked() returns success.
+	 *
+	 * If device A registration fails, there is still a chance to register device
+	 * B. i3c_master_add_i3c_dev_locked() can reset DAA if a failure occurs while
+	 * retrieving device information.
+	 */
+	for (i = 0; i < dev_nb; i++)
+		i3c_master_add_i3c_dev_locked(m, addrs[i]);
 
 	/* Configure IBI auto-rules */
 	ret = svc_i3c_update_ibirules(master);

-- 
2.34.1


