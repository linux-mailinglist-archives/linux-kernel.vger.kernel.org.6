Return-Path: <linux-kernel+bounces-403415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B49C3561
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EB31C21622
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68949848C;
	Mon, 11 Nov 2024 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="MNStzfhR"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010036.outbound.protection.outlook.com [52.101.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1BE28EC;
	Mon, 11 Nov 2024 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731285217; cv=fail; b=e9EFPUizYlo9KW4R7VhJgapWCxRUcofXkSrarDYF6P9idVKfjuiXq5CZkkZBz3sVJCCa15wTngdQdeIo7/9HP1uWWqdbIXyo+1WF+CfMY578ZEjEGUyTQGeypmFljtcv9ZCO9vmvVn6+ZrKVJJRYqnkTe+5KHLvrtdF4PbrNO9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731285217; c=relaxed/simple;
	bh=U/aiHFUCY46COgzTY9FyM0Wb7jMFLAa0jyl/0bjrSkA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nH51NbqPShJ98p131J5YFWGSXVq3vu6Rl8zFJEL0i8H8Uv/XwfNabhrZUU+94Xh1F2ljbyis9mxrwmSuoYuUAOvh3sOGuAB0XV19ZzkcckgTXjAQg/0VbWMIrxKKQF3nteR5rrfzd8SwN4nUZyMYcxOOGKXMlekMmBzzhbR32AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=MNStzfhR; arc=fail smtp.client-ip=52.101.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3anCAQVQN3H7SRZjyD6FyG3/OgBbsun4TTDYCI/UUT4xtZdXbKsaAKGIA38lQuNYhznKR82ucGU3Ga5vg0ygiIz+uihSREevQVIV2ShlVQZmJwJHuwARVOjzY9mpBFt7PVjCWINKIVqiJ7hrsE8p2nftUyXhY8C2BSkGgSbsFYmQwybgDcwkaUuarxgBNHhPoi3UINWOk47+vLzzTnTlTpLrAIcGcLQcXGbngEabnGx5Taii2Nbq6mFzranop23s47r+VAbsBljv+YCJD4iqBDLK1zJQirCIWnmk6utjIpJMNBhNe4QYVGl/Qhoj+250pYaD6CYuYeX9ciDLdaDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE+y65FUFO7x7W8rEathTQ6X7uxB3RdgWFh02svs/GY=;
 b=BoVLpw94qAnneGefGvFxQKqFj7Au4reAzmLIPwPSbU0MLlTATBvl9RvATEXt6HP2u6ExHN3K0o8rSTafFhhqytZwpgjJLkYXD3AaOtE8+xkB60YLGiV08LvoAFCGNi5EqAoM38P3Y1Ms8ivDihhcmszYtLnQ/70HW18x2nEdV57WyhZ36ZhUDwq1LfvFU6ZHrWZL+vlKtjUZgW5/q6i1eFfk+h3yHpKpXVSp/tzxkZCY546bAGfQBRKqc1VHQM2NoSACOgvKOHewgFEa4orMTs4+YuV3bn9eBlshfeljYCi5uVB8v7qIJT3/BjJM57Sbif/UljyNzUEWxdoP2YVzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE+y65FUFO7x7W8rEathTQ6X7uxB3RdgWFh02svs/GY=;
 b=MNStzfhRurMhI0ptD/zqt8XgM4o+fya8WZGGueUwEv8TN9s4dy+U9SHBqfuIVwscykdA39Ek5vxx2bsKfoLZLkbhocnnk2lVnSgqYSqhoo2IByd7WZLIoSP70c8KTFbac6FbwvE7HwBvPedGbxhG+xMisZACOd4tJeIdUwQd8Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY4PR01MB13351.jpnprd01.prod.outlook.com
 (2603:1096:405:1dc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 00:33:31 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 00:33:31 +0000
Message-ID: <87msi6mwxa.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: John Watts <contact@jookia.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: audio-graph-card2: Purge absent supplies for device tree nodes
In-Reply-To: <20241108-graph_dt_fix-v1-1-173e2f9603d6@jookia.org>
References: <20241108-graph_dt_fix-v1-1-173e2f9603d6@jookia.org>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 11 Nov 2024 00:33:30 +0000
X-ClientProxiedBy: TYCPR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:405:4::17) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY4PR01MB13351:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d95dc79-fa77-4ffb-999a-08dd01e877bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mUniKylrp/wwhX2oV2w1lX/3P2l3ckN81JXC20nZzebYK7TkPkmPfwpQwRD6?=
 =?us-ascii?Q?BIN3sv8kKXECX6gajXHENfu/gsUG/MzkhPMi4ab5q/HltcfL+kPDW+bMFveR?=
 =?us-ascii?Q?RqMo76juIPIU3ysNhWvdkNkdaf31qNv4eeDggU98YgXpcbB16QjRsJCY0T3Z?=
 =?us-ascii?Q?99ebXgRGQR4J7KiMbrUkrf4rjRtn17S/I2bJoOFIup0LF20H6l5sk2Viwa15?=
 =?us-ascii?Q?7X523sTwygwwInf+3xFfSknFOzrE09CTktDgOn/HcElTN07QjsYBvfBFVk5T?=
 =?us-ascii?Q?3j6oAJPRK7wonSKmS3tFjuZDkGQJjpKCG9RFlUTyR/UuWgLxx1HQx4kRrrUZ?=
 =?us-ascii?Q?5z+SF1rNDNOAt8qtKRMR/QUoSwbYlW6vDQDARLBZOAmW/ZgmT5+SeN2Oj4s8?=
 =?us-ascii?Q?gTJVtIFEzEVGi6+0StO9I4PzhIunRu5xkSBL/I9EWoIi2IskZGxTeYQHAHwP?=
 =?us-ascii?Q?ap4PstRmb9O28rRwTmiDCCBDD0WDPJc3zGGztmvdPuOk0Zfim+XmmpQ5tBcH?=
 =?us-ascii?Q?mHyOLIBrJuNv6czgw96JP6v+0zfm+UOx2e0d6mcI3HljzXqhgBD1HoeRGkMn?=
 =?us-ascii?Q?5MgsZ+xx2jvRKicKbmCQOISkvWI4wRlfZ4ztVsPc89R+3fu5865NIhW3SgUo?=
 =?us-ascii?Q?YdmY61qhAnHfzgZCGiUBcrBHqRJ1Jj49GHbWSlXSYMRfRKltKk6iK4t+ln+V?=
 =?us-ascii?Q?lJbG1t9bMgOTHveoTImILxBde5lx64FcJV9gDehiMEib27ypQ/mWIVMAxF/d?=
 =?us-ascii?Q?1yPByvt/BXW4ZXFGjrhmssfrBjuOKzhXSX9PpKAx73OgORsPXSnBfOym2p7s?=
 =?us-ascii?Q?jXNBEdnlu05aD96yijeg8PAGXWgvXQ+nu1Cq2CWGMfqDBXTRFmgGpjUzbJm3?=
 =?us-ascii?Q?Y0maDWfnS3HG7PfWjloK4FOuihzH9UbReitDp85/0w8fogrTzyADww/MiC0i?=
 =?us-ascii?Q?Hlcy142raFDdaGKa6hjhO9EAxLPLaLRdGUgJPIRGHn8AYUA1sOdJVbyrS8M8?=
 =?us-ascii?Q?OwqqhSrfD+g/zCmRDw9bWHzRxM7h9aNAEZMlPBXUGOM9LCdoiaz7Sfq+jAh9?=
 =?us-ascii?Q?7jJnCcHw+zWVcDtFkU+8LIeQmqT6bFNPl9ip5heMerAqssz/mW7Mn8tN38bP?=
 =?us-ascii?Q?rkeP3etTUk4nnyJkBPLdQ3jLbjb7EtoJceGKxss8b1IcdvEn8qxpPOer5Ci0?=
 =?us-ascii?Q?hnyfzPkOLkkagXRFtXS51Qy/f1vN0N28xWfEoExOEc7AwSKrnXm4wMZyuD2v?=
 =?us-ascii?Q?dQF54T3spxKQ0LH+AIXTgsEa+b9GnSgDNLrcpQtmCcumsA90THZ+pcdNkLuq?=
 =?us-ascii?Q?KcRVhJaRJtvnbjhVvjAxPpZLA1eunO+au/FBHZe8iGFSFQRoOUpIHre+03Vn?=
 =?us-ascii?Q?tKifBl0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BfzzmMDIStn70kYDF3wv+7qdWA7vPrXBa3x8jNP+s7nPqEksLBegcOQpgLrb?=
 =?us-ascii?Q?BguVOeg7JZUTFWPo5TazBjEZ/fq6IK8nwH+YJCF26CtemDkoXx+qBOYZXw7F?=
 =?us-ascii?Q?wvckaQ2SoVJCdmV9f9QEyKF69mruyXNfTyLbvnJyjW+pZiWBx1+0Wkf4fYkw?=
 =?us-ascii?Q?lSHuC9BZMD6FBzy9+qP9eximokltdJFqgY14cEhFF36vd91rms/7yILObzU8?=
 =?us-ascii?Q?VDIIDCdNcBnB1reRQIXHmwYVO1e/1JYgw3SD86GQUBsrz3NjYJKzE8LUD7Q+?=
 =?us-ascii?Q?yFvHizs0tB7lLqzVQ9eH929CZ7t1/sD4eLnqP2JWi1hG2Yp2Bac2VFvbOaVt?=
 =?us-ascii?Q?cmKCmwTFz2orHu9GT/3mdsjf33eiXQA/hTnuPbQEX1mIufO7SS5NYJWam0nw?=
 =?us-ascii?Q?MHYy9mU+FMUhc4IGDv9OH9qQlNYhPJ7zATIFVpBwgJQ61tVfe9BFvMFnxMrL?=
 =?us-ascii?Q?HlLvYtr49CYemTxsCuDk5i5vRPvHMYFxOtvqDLhyEGyiWVogSnGM7hr5nIP9?=
 =?us-ascii?Q?4bkYc5ymkEpe4aFdd7p20h3M4lF0XSFQ9ns4Z1Zs+EAboImiVZS3DPKGXpMZ?=
 =?us-ascii?Q?230yYVHPI4ZCu2LklTr5dmUnmB5EyBsayXKpglFtqgMclJedF/JhZCb1zcPf?=
 =?us-ascii?Q?Kp26zflv6Hxngz1ymNkMOSWWhCDhQdDnaOYcNqSJYcsK3D4OvvJAwO/2+L6U?=
 =?us-ascii?Q?RUQpgUBYJUPa4CrHwDlidp+M/eIa2fGO9CcuU1nUIzbYIiEcS/jITv4MD5mJ?=
 =?us-ascii?Q?/Aa61T67DRhrIKZ1tHCJdhwPxoRXKs+KxcMtIwWu6ZSHL0TtGzVw1ITX5+wU?=
 =?us-ascii?Q?PP11Hpkm/NS08qYo+9SkjUBExgRrAo8qAaArphlOdvlZ1iUYfVOPsma/ZK9e?=
 =?us-ascii?Q?gEYkkrKcwUmnZkIMVSKyNmvjchPXPwdIGlrzIeIdBd4br4qDlBEZRj7ffCEX?=
 =?us-ascii?Q?dnLhymO2l5zSwVD/JQRvXYs4xRkwMo4Q+QcKSZAope0CfeMUNDzHO+TqgIv8?=
 =?us-ascii?Q?22PFN/QP0F86+ymfHZGAnXj9bHljKFe2zhKVwlMgy6O6/L44nJsXiD9wjg0Q?=
 =?us-ascii?Q?ABiNcuz3BWSOv1QA7igz0XrcvvgETPavI5qkvd9pW+V8dDIG8WxZCTIVobwa?=
 =?us-ascii?Q?VUX+SfcS5HSa7wscegPaJeEj/G9UdYwz7XCzkHKaQnZeQpDQEgYW90j8BsNo?=
 =?us-ascii?Q?8/oHpfjXbFJOGlQsUM3WxEQDIMS8mEvgUqLzoUFVAGIlPuKVyMlaGbCDQQOp?=
 =?us-ascii?Q?A9YStezHFPegZALiBrAsTf44d5vD4p2S/QY7yj2jAbK/TaTAx5D9hWUV5sre?=
 =?us-ascii?Q?pdFNrz0KkTSSUrJfwuTGaQq5BKqg+EfMedWNr1SIkwDZre7SeuR7/kPaW1vE?=
 =?us-ascii?Q?XqUMD4atIA402NtbjhHnu/nPRoxypRBuSrSI4SVCsE75t2pITumEd03tF4Qd?=
 =?us-ascii?Q?OPA6C309cVFvTkNcfVk+cVA6Imj1ptnDkA4soyIXCK/lrm3rMuL+rwTLAAs7?=
 =?us-ascii?Q?izwKm0OJf2wgbogUB2Sq8mhikMG+BLC5JXTFcdsCXX5e7YdhOKb1BoTwH5cJ?=
 =?us-ascii?Q?8nvuDKHOFGaiysK3UEykov5YfIeNYMptF+1J6HnZiXm316B3CGavuiT6vBvQ?=
 =?us-ascii?Q?wwFtrhvVvyyfeBZHgZfL2/s=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d95dc79-fa77-4ffb-999a-08dd01e877bb
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 00:33:31.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VoRm3o+Mw1smDGdM5YqFTd1vGt2UGSa/FXCSdh2gkNyOjqsvHzBjRxfFxlQC6RvBCXkeVVQwAaBmL9n/nX+ghopbAPMEMqdrnooA54ydvD27OurTar2Im0OWm4sEPr0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13351


Hi John

Thank you for your patch

> The audio graph card doesn't mark its subnodes such as multi {}, dpcm {}
> and c2c {} as not requiring any suppliers. This causes a hang as Linux
> waits for these phantom suppliers to show up on boot.
> Make it clear these nodes have no suppliers.
> 
> Example error message:
> [   15.208558] platform 2034000.i2s: deferred probe pending: platform: wait for supplier /sound/multi
> [   15.208584] platform sound: deferred probe pending: asoc-audio-graph-card2: parse error
> 
> Signed-off-by: John Watts <contact@jookia.org>

I had (not same this but) similar issue before.

	a2187d0dadfc308551bbb1b8d6caee69e2ad4744
	("ASoC: dt-bindings: renesas,rsnd: add post-init-providers property")

Your patch also solve my issue too.
It seems your one is more simple and reasonable solution.
# I will post revert above patch after this

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you for your help !!

Best regards
---
Kuninori Morimoto

