Return-Path: <linux-kernel+bounces-169171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC488BC470
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA66A1F21643
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC56137751;
	Sun,  5 May 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZkR1H8sm"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AF3136E31;
	Sun,  5 May 2024 22:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714947301; cv=fail; b=uoydbMSlZYWbsOzDQ8b28GVsjSF/lHdiIRqi8ADLI3FtJjHf2h5YTUOwVe+50gG8rueW+ODZ8rG/rCzPnimSY6irTGfX+S+5v7B+A4vpa8w1JhNXMFW3XKnr/ib8JQvOXcvL3s6GeePCbgPsiEqSC3kBHYPNG/DOyAjVVS4qDZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714947301; c=relaxed/simple;
	bh=xDHthho3clLMwVkgJtffn/O2I4fbcl26gyOATRJQtI4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=q29f1SgvD7elKQ0XaKHu4/xtUsbS4gzKtxmg6S9pPPEUccdodJeKU+uosuTWO5Ign0ikWOlTGkBMU3GZ8BbVvhIwt4UGcOJNWMAGa9SC28oEdq/t7CqLDpo1OGKkel+ZlQ61slm65rr0B/T/VGs5syJbow23gtB+SiWHNDCNVcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZkR1H8sm; arc=fail smtp.client-ip=40.107.7.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpXrHYkU1r9I7HIG8fd7j7p+wGF9em05g3MwAq0+6cYtm0YnvO/tCFpJhsejUN75LVxVpJV0frMWm8fnwkEQ6sT4rABHaa+gfyWrugsCn1B+jC2cB92/4Ic3lENSgrBA1VzHcVuxZ7n4wzXV4dTvvJsNHeft+5jnhaGqCaTLdM0bDg4gsPcXtQ2XkW799wVlalG6fqnGrx53bpVPx0B2qkguQYqhMV2lfjzr/M3DZrzlKYMjVjpGgV1AnQXyiBEr2P7Vja339WuhfjcdvOyqooRvnfRV9rRHL9BKsMKHQcPp8B0tYXbjhs1irJNJrVQKOq0mJi+I7HfL0CA2Mw/s3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3LuyELaiSC0sVNX2XPvkzFPVBktsV4F8YpUGnJ4zDs=;
 b=e5yqHjgD8QvreJgU4WmzDzB3pU4LilfkkOamj1dg0HNlaoabRPSfTcgwjHe3xXcd/5bgdc1zxPxhTC8nPpXWhKG5mKYQlYILsJCQjC/CbwN7tYHUWIdvzrT+j4bh8vGPR4JaFcHEX0m9y6kpswvQSm3dpdSwNx3unOnUqL0g/GDXuEmSTQOGBmF52O/58/bs/N+2+AEcVIrau4wmfp1wo89Lh4LWtqLIxLMxBB4fMTbOT73qWYu+A8Dk1N4NQ74tBeSwZLbGSRP3wxMz24CJDRivFIrdaXfm7vUgVMta73r/dnnMnJohfMfBDp8ByL40Rpj2v68azFTuaq9q2Lh7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3LuyELaiSC0sVNX2XPvkzFPVBktsV4F8YpUGnJ4zDs=;
 b=ZkR1H8smxeMOUjWqGVEFFcrtVpa835n2va2uAgHbRSzgnXa/wgmnW0i0UEvIiuC0Vobb9/uE/rrUESxzK+/aYMQOao7jFSKB6LxOGYFIQn+0SbXl+tU/scVwZRxwjZhuW4eMqXhO01/qhWxQIwzhPEU++FKcxZoVvLM3j2Q0JF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6818.eurprd04.prod.outlook.com (2603:10a6:208:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 22:14:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 22:14:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 06 May 2024 06:22:43 +0800
Subject: [PATCH v5 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-imx95-dts-v3-v5-1-5ec9b99cfb2f@nxp.com>
References: <20240506-imx95-dts-v3-v5-0-5ec9b99cfb2f@nxp.com>
In-Reply-To: <20240506-imx95-dts-v3-v5-0-5ec9b99cfb2f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714947780; l=938;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=hxkVlQeaJgJhLHSlZ83jW3veqMTWVj/bEjw+HMyTvrY=;
 b=BRIU5KbIwrcLTQdj7pQTpe8T1iL5pd0Q+L7soD5+0K6lynEHlpQ1d3XbfxJk8zCFOOB5uBwzN
 lmTO8WmhJMlBRxk8iIzUdJBac40Jaa/SQUUafrz8PktNzI8GekoapAa
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 088dc564-2aec-4b38-65ff-08dc6d50cc2e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|1800799015|7416005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXBhMG9TT0VGUVhsZ3VENUZ2MTFINEJIdnFHNXhFOEdvMVA3THlzSjhCTEVQ?=
 =?utf-8?B?WFlPZWhDbEs3eUFsMlRDT0toV0lod1JET3AzeXh5UDZjZFNJM0pxZGhiSkRD?=
 =?utf-8?B?azZzWnliQiswZVlrQUdodjY0Vnc3S29tUkdxN2trMkd3TmJ2L0t6RmR2R3JD?=
 =?utf-8?B?eVVxTjdiNlk1bW9yQTF5bGswWGUxMzZoSlE3Rmh6TzVtRnhJSmJRVkRqM3Fj?=
 =?utf-8?B?ZGcwQnhDUE1zckxyZEhGZXhTZEd1VTNacm9EbEtRTEtnSjlPMVEzck9SREFB?=
 =?utf-8?B?bzg0UFRWYWdqcXNVWktNZ3hVSzY5emVjRkVQVksvdWZONitDWEFyTHFzMjNE?=
 =?utf-8?B?UUw1R2IrODFML211ZWZnZlRBdDArRlFaZkhJYVQ2ODlMK3huL2lQY3dQTmcr?=
 =?utf-8?B?cHhNd1FTVlZucXk3ek1RRmpyOER6Vy80YTVBZmxROWtQcWdWK1k1RHltSWd6?=
 =?utf-8?B?U0ZHQ1ZvV2dLVGVMak9oNXJmODJpcEV0L3Q4b3djS256WHpIZjBqcUdNeEl2?=
 =?utf-8?B?a0dEUU1CSDZhVHVFY2NZWGhXSGlvVXNxQzJScXRxYXlSUW40UnJ2WUZod3Zp?=
 =?utf-8?B?dEFPcGp3K0hiWVdJVldIQkN6ZlJOakJYak1jWWFjWDZ4QVZpUXJZMkJ5bTMv?=
 =?utf-8?B?U2IrZTFrZEs0bkVqdHdFNG0vdy9kUXBBWnhPcjAxWnBpWHJER0JRNmZIb3ox?=
 =?utf-8?B?ZlFYZEVlOEdsTmRUZUg0T3JOY0lURkZuc2NuY0lLNE1rUzhJVWZFd3hVeTRj?=
 =?utf-8?B?WU9XZytJVkYxWFh2eVcrOHJlcUxzMHlSWjdmcklwOEl3bEZXVVhSbjEwdVpu?=
 =?utf-8?B?L1VnU01wWjZ6Y2Jpc0ppU0pybkptZkk1VllNWUs3RDR6OFFHY05SZ1Z1c090?=
 =?utf-8?B?OXVtUUJrbHkrWHcxbjFuSjZxSEpSR3hpeUd5Rzc0WXVLRlJReHJ3aEQzSnpF?=
 =?utf-8?B?clRvbGpuSWFvVVdoWjZXblRoWVlwczdENlFVeHF5UVhraWREVHYvS3NjWVR5?=
 =?utf-8?B?Y1Q0WiszU0RMRS9DUkdyQVVLbTNpNDBoV0tjbkczQUl6cDBUaEUxUFFLYm5q?=
 =?utf-8?B?ZFpzQUNWOXB2b2hQV1M4MFdBckdnZ2RyaUJzVTdub2dEaEN1MkdFbXY3Z3Bz?=
 =?utf-8?B?NERCVlRSajlHdk9nOVp4cEZ6ZGtIdjJiMWNadWc0eTFHOWNUbjZocXdpeUJX?=
 =?utf-8?B?ekU4ZGdLNFhQa0FQN3VBVDVXOHZPb1N3SlE3WnJmVXBkQ2p1eGFlOVM2cFhB?=
 =?utf-8?B?dFlYZVVCcVFqeEJoL3dPYjlWVE1xQ3JBRUl0dzlGbTJHbVlNMVhvWTljc2Y1?=
 =?utf-8?B?QWVxa3QzeGkxOE5MRWR3eUE1dmRxZ05rUFZCSU11UmgxQ3h6VVBTZWx6anRy?=
 =?utf-8?B?K2lVd0hpUDR5ajM1NkJRWlhUV2p6QytxZGhLcnVCZDJsajUyNHlyVDVWdzhi?=
 =?utf-8?B?eUFkRnp3Q0xqQjdGNHh2Rkk2UzlEVG9XTW9XbXA2QkpDVmlIKzhQNVh4RVVT?=
 =?utf-8?B?MkFGWlZjaTRGM0lnbXR0ZzBGN2U3WllGSXR2RUdTYUhYWTZaeE1XQkVjaFVQ?=
 =?utf-8?B?dEZLRUVXRUpnVEtLazZUcDBXKzlyWm0ycU1wREVUVFpibUpCSEV4WnRZVUFi?=
 =?utf-8?B?RjNCU0JTY0tJeVE5WUJhM2ZrcVNaZ1JpWVNrZnFkak1TeTZ0eW9tR0FqYm1T?=
 =?utf-8?B?T1Zud0dGS0loK25HOGc0c2JYRnI3QUJ6ZzdBd3ljUHhteEc4T25HL2JlL2wv?=
 =?utf-8?B?MnpLVWI3bll0NXo1OUhvQXdBaG5RY1hLcWRxb1NlaUpubjRLZitmOTArR21T?=
 =?utf-8?B?WDZHb0lqczk2TUxSOU1sQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWJ5a212aHFVS1psVURIZTZseSszT1V3Z1drbk96UnVFakFia2Z6Z1BiZmRl?=
 =?utf-8?B?L2gxWC85Z3p0ZkFjU3VMazFhSUYvR0tGRHpjYUQ4UWtGMyszQ2plODFnSG1U?=
 =?utf-8?B?R0NzbmQ1cThmTU8waUp3OVk4VEVnQnh5NkhFOHNyWGRqMFUvU3hLMlAzbWVQ?=
 =?utf-8?B?ZE5BK2tsK3RaVmRDZklEVlFZRGk2YkZCVVNuYmJuZ2crdE9pbzNCbmY4VlVp?=
 =?utf-8?B?SEE4d0ZLbXZQN1c1cHNxV0NDZUNidmRTL2JoTjg4ZWd4emU2d1dyU1YrMXp2?=
 =?utf-8?B?QWxjMG84a2VnM3dKV3FOdzVGUFFaekpLV2tuVldxeTBjUjh2ZTRwbkNmeHhN?=
 =?utf-8?B?bnI5ZGltamgydUhkT2lzUERvM0pXc2lveUZNK2tRODR0OEpkaW42d2tGVzVD?=
 =?utf-8?B?L2g3TkREclZ3R2Yya2c1T09POUtkZ1pkYnBhRjNDcXZXTi8rTGJkTG9TWlM5?=
 =?utf-8?B?NFFBbWZMR3pxUldBSmY4RUpUT1B0Ym9haEFhMVluVndjVUcwNWczbjZ5SGZX?=
 =?utf-8?B?cnJUaEU2MmNudmExSXVEenlVeVlzdmUxRnkrNnJhbWMxMUIrMWltWmxPdjZL?=
 =?utf-8?B?UHVidXRaVmd6VUU1SUliaHYySUNGb2lIK0FVTW11VThEYnJrZW85QUt4eU5K?=
 =?utf-8?B?M2lNU1hJbi82Um5Odk0rRTMxV0ZOeS9lS1FYdS9QNCtmWWRaZnkxbm9aU2VS?=
 =?utf-8?B?V1hJTU44cFczc3RXTWljNlZ0VTVpa2xKT0srcmcwdmdZdms1V0VmR1ZsakRz?=
 =?utf-8?B?UktZK0MrSmJqZUFHdnpXc3dtYm5PbEl0aUwyTkgyRGtoV2hPdG5RMkhKOFV4?=
 =?utf-8?B?RWlXaURQbDIwMHp4S1hCdGFoVFRaZlYzMmZnUWxyN0RyWnV2ZzhYRjBLTFhW?=
 =?utf-8?B?cmIxWHlLWmM1N2xPQzdHaDdqajFOemEzV24vcDZISE54ZzZXb3c2RVVSbU1H?=
 =?utf-8?B?MUphZy9UNHF4TExIdU1abi9LWTBDd3drR3E5VTJmL0FtS2xNTHNtblRlZS96?=
 =?utf-8?B?OW9jeC9MYldRaVFuSEdmaVFrejVLRE5ZcVlubklvY01TR1ptYUtEZGpsS2Zn?=
 =?utf-8?B?VytLV0RWR3RlVzBJMnMzbVZoekRPSVFra0dROGRKOUxsR2NaMHRnU0EzcUVL?=
 =?utf-8?B?SHQvRTdtR1ZhRTdtZ0JMMFdOb3lORDZvVmVEVU1NUFlvUEtnaHljZW9sVllC?=
 =?utf-8?B?MUljRDZuT0JkM2NmSldEN3FCbko0UGk0ZUgyNzNqWVA2NlJYNFJsQWxIUDAy?=
 =?utf-8?B?SW5ubHdVdGVsTHdpV2g0a1I2d1F4RTNDYlA0UWcvTVV3L0JLa3NiT1QrU0px?=
 =?utf-8?B?TUFqelY2dmNwOEdQbm9JYmw1RTVqbi9hN3dtazcrUnZDbzk0dzdUOW1USm5t?=
 =?utf-8?B?bmI4eE9kbFBkamJGTUJ2aGNBb0RHTVVSNjY5eUw2TUY4Nmk4Y3pqYkVKT1FY?=
 =?utf-8?B?czdGYnRqdTU1a3czdkVqSmczQlgvbmtoNW5xRDFib3h1bHFIMStQQ1FQa3Zz?=
 =?utf-8?B?akppbUtFajgzc0JnSkJXUStWSzMwL3ZjUzhIN1doL1BrNHlSQ0Jzam8zMC9k?=
 =?utf-8?B?aTVueW5TV2d6UkNoSFExODBMUURiLzloajlDVDI1QWFyRVFnNjJEcDFoV0dk?=
 =?utf-8?B?ZFV4UmcwRUgrdTdqQlR0L2pzeG9GVVR0WHQvRGQvUWVxT3g4ZUhuV1lMdDVN?=
 =?utf-8?B?d0VLeXVIQjNoWlI3TlJVL3FLZ1ZJd3lab1hreVVsTFN1b2ZHSTIrQi9mVDVT?=
 =?utf-8?B?Z2tiblJIMXlFMmxaVTQxb3ZEUjlvNElQb1Q2ckdOa0lmYXhvNGd2UXBzVnZw?=
 =?utf-8?B?NVllb0JHK1ROc3pISnZwRjFXRGNMSnEvZTBpTGkwYlZKQlNjT3FzMVFRbzZU?=
 =?utf-8?B?ejBnL3pRaGhFWDY5VjhNaEtiNHJNd3d2TG1pVDhYelk0akVSSURtSXBOYmw4?=
 =?utf-8?B?anI3bTJKMU5HRzREeDFHZEdXU3JWTGJVYXBxZElXekFZK0Q2ajNMaDJ4bFBy?=
 =?utf-8?B?bmdOV0RaaGs5SUQvSUZXQWlWb1dkWGp6ZG9oK2NRbHJIL0p5MWlCNEdjd1Uv?=
 =?utf-8?B?K3BPUmZEMVJIcFpRajRUcEJYTGlvTnFLa1VpWndyTlM1MWNIZFpiRnA3SG5t?=
 =?utf-8?Q?PEC6Q9u3ruy9uWcZT+KN79z0k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088dc564-2aec-4b38-65ff-08dc6d50cc2e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 22:14:57.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNuKalSa6t/p0V3GDjtH8n6QZwCa/Sa5CD2psM8nQLyxA5f3j1lurGSPH/EIjzDd5K3esdnsetFw8qUhYMcHEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6818

From: Peng Fan <peng.fan@nxp.com>

Add DT compatible string for NXP i.MX95 19x19 EVK board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..5c9014087c17 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1275,6 +1275,12 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
+      - description: i.MX95 based Boards
+        items:
+          - enum:
+              - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
+          - const: fsl,imx95
+
       - description: i.MXRT1050 based Boards
         items:
           - enum:

-- 
2.37.1


