Return-Path: <linux-kernel+bounces-317776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3F396E3AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996C71C22492
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE641A3BAB;
	Thu,  5 Sep 2024 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BAv5aUoX"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013021.outbound.protection.outlook.com [52.101.67.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB691A01C1;
	Thu,  5 Sep 2024 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725566805; cv=fail; b=bi0CDFGJBf6Sbg9RCuq9hZyuFqEMeQcM9+Lz/Az/BSmsX7phi2dd+3vq3GgJGvG0SwQ90w/NyPY7p4gnyo0F2IMVJkaTS3ORt5KaflI3xwSYhdNNYz1XfgUYEW3M1phIqpN87IUsuUKmDk/hvTHzn4XGwhTlhrwk65+e952RbJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725566805; c=relaxed/simple;
	bh=CnUCYtJpFgxDlRdwMDi1lTVA9hZVdAmvmi8iysk172U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qInTgaKQVJ8ictpC98pZvLKYUceOObSpfuhiD98pyCNN6Pqb7WyH2K+GCCoQY0Bf7WiZVbmTHVHbTm8kR9bgcmR+djd5nUqg0SadjyxeKEMjmRJ7Pa0XXoduhTMlHTEz+EYS3vKbsYHxA5ce8OXgCfhgX4p3iONRLVci+LXf7Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BAv5aUoX; arc=fail smtp.client-ip=52.101.67.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfjUWRR/y+m5JXwpksAJ38+0VxQ9nteLUZT6yu/C3OmED7lRRt8/lQeD/zeRiY5UfGPVlm+vtkxxzjzOHJbAI36wZmmVdXwYjZTRByG2rwcy0/w54fWFxeOwNAQoBvEGv1XDMO/0roRQwavmz5ge8AeqTAmI0hFKWswAbbj2eWFB6/+j3340MdgVpH9b3im/vyE+bi5G/isp3yNiUSee7AvN6mu4iihs6d9ZCZVThnQBxUjLMI7vDET5sPBreJA9VgBrvE5dToeJ36/gnsCrkILdQQB3G5CJAsYzOuQ6plFjGa0JuY+k42CkCp4s9SwG3/W+mFt3B+ekhqm49Ws4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h77DnQeqNcdMIKEC1tpJuVU06z31B8AeAik+xegFNg4=;
 b=jO3HN5IFTC2IDnUpBT60bUotNnP8euGrtJrQphiXsVTghgnm/v0MvoWKruuCC0O0GlHRwOr7ma0dQ6BdUdZYwgbEGaFgM4wD/Tudsy1bCTbZUKLnO4kb+J4Vy0z9UPQZEEOYh0BQT7Emch4xx8Fp59DJN9JLDeBmdnRWI+7gwb9+cMhqs/jVebrSluocW8MJscx8Xkb3OvMEj+gOUnJvEKI3+K3oopwVmhSX8hO2F9PkpX5XpA+d5+QkHWayUH+8RElLyCMLRwTpWafp/sAt2m8BkyGWwrUOZAwCP1F4aR+YQutQ2Wn6NqL5Pg0TrGB5R2yX4Jxi/Xe08DvSnYrgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h77DnQeqNcdMIKEC1tpJuVU06z31B8AeAik+xegFNg4=;
 b=BAv5aUoX4iSU5a5BknqErVC7MdBXQZxSuEyeZdqX+sFRkALpcQd68BlJzVFn/1CgEDOIZpHL4WWjrV/3oDOTo341Y0dmq07FKo+LlxGojO1FvzPWoBNQ04XvumBecwCUVORU2wKkNqqJ/4zyFlktJgLZV69UZL2z7PggbUek9SK0PkU9GQULkMxOiOFSuHlp5I1xlC2ucm2X6CBkVkngTwvZ/6AL4l4rwj/XNUcQwWkU+kf68f8tmTUFVyjO2yYcsl41AP13OQ+g6cZ/PpekM7aA6gv5bhkcWVfca8lN2j5t6+RbcUZ3gAYfEYEP3L0xCOQvkFHvY9Pn0IyzlK8FCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8423.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 20:06:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 20:06:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 05 Sep 2024 16:06:20 -0400
Subject: [PATCH v4 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-dwc-mp-v4-2-aedaeacf0556@nxp.com>
References: <20240905-dwc-mp-v4-0-aedaeacf0556@nxp.com>
In-Reply-To: <20240905-dwc-mp-v4-0-aedaeacf0556@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725566789; l=2068;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CnUCYtJpFgxDlRdwMDi1lTVA9hZVdAmvmi8iysk172U=;
 b=yglSI41unccvsj7IcMiZ+i3X6/p0CwebkPdlDdNU6ZQ/UbxpapjCQXEnntyB7B8NdHU6zi9ed
 BDK2mK4YRyUBtxGidLpgB5W17OFuLhQ6zbiVfZmPV3a0efYXtEJusWo
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 2141d74b-de21-4e01-d315-08dccde64161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjFxdWRiTHhrakVqbTNZSjJlK1czM1luYjlEY0ZyRDllN0pQdmxSSXIvV1I3?=
 =?utf-8?B?ODdDdURZSVJJR244a3NjYmlzWWEwTlBzTmNWOWlvWUxaZHFuMFl6QlF4ekNl?=
 =?utf-8?B?WmFWb0NJczliR1hnUlNiSWZraDQ4ZDlsc3FDWFNZOEMwdEh2QkxiNDdaQ3BC?=
 =?utf-8?B?ZFRoRHpLZHlmdlFocVRKZHh5VXVpL1lDS0ZaRHBPUXJRb01LNmdaL3lYK3dY?=
 =?utf-8?B?WGtKMmRic2FjS0Fqc2FmZjV1R3ZGTFROdXI5RDQ2cCtYWGoyeGFqbEhudzEy?=
 =?utf-8?B?cVQ4Wnk2czJXYXlweDhCOXBJYTlNdlhzQXZERWlHeGU2U21iWWVlQ3dpZzRH?=
 =?utf-8?B?U0ZyZnZzM0RxZklDc3pYcSs3aUZlVDJmY3pna1VBdTRERlhUTlZBQ3lRWTNq?=
 =?utf-8?B?TzF5b2FTaDBBd3FTbk1KbnJwcU1kMU5zTHhQazFUTG8wQUFHNW80TlkwSEZa?=
 =?utf-8?B?by9wK09ZaW5ZekxYNGtUcWkxU3pScFFkU2JLZWtkbVJOYlJrRWZXM2x4b0hB?=
 =?utf-8?B?TUJROFRhRmVuS2NUY3J4SDhqS3hIa0pPNnpraGd3bUNsazVTN1JsYjJ5TGZH?=
 =?utf-8?B?Z0Z0Y2tmT0ZTaTJGd0lvV2x0M2crT0JQRUFoZWtYZ056dTNtMFJrVVREMFdo?=
 =?utf-8?B?SGxWQm5oVHRxbC9KWWNtbVpJS1VBeTJFbi9ncERHbXBWMmFiS015QktpMjc4?=
 =?utf-8?B?Vm4yNnE0VmUwZGVzS1F6aW95eFlzSnZqdEhIMG1zYndkc2Z5MVBQb0x6SndQ?=
 =?utf-8?B?L2ltOGZaVW5QdlkzK29PcStCRWxWZE1JZ1ZvM0VQUHNQWTdQQVZkOE1Ec2ZZ?=
 =?utf-8?B?YzF6UUF5NEFHdGFMdFR4NUpROFdtZ0JyelJEMGFYdndYdWdKc0c4aWlwSkRx?=
 =?utf-8?B?NW1HZ000OUxTbWFPS2Ztazk2Qm1YdW03OHVJanFNeWZrT3piZnI4MXlOZ1Vm?=
 =?utf-8?B?VXZHQkxGdnFVbGJpbmgrU1E0Q3JyU2k0OHpJUDBUTUhENFZZRWlqWDJLSEQ4?=
 =?utf-8?B?RFFhempMRzBaL2cyVWw4K0hid28yWTVZdzBFZy9xV0g1SU5NNmtjMjRNSXF6?=
 =?utf-8?B?MW56SzhCT1Z0eEw3Qm1lb1VFNFBlV2hzcGczMFJhZjdsUXVNM2h2YmhxcWhV?=
 =?utf-8?B?SWYwbmVNVWlzL0MxcmxnV1RGTWdndmUvbWpMTE5LQVh0Vmt1RE8rWjlvNXFh?=
 =?utf-8?B?Y0pVc09oUU8rQVpHWks0QTY3NVlQby9heUx5OGNyRWh5VlRnTHFSZWJ3bWg0?=
 =?utf-8?B?QU03ck1ZRysxRFlhVmdFRG1ZT3hqcVNhR2NuSlc3eG94bHNjdjZ2NVZRd1Vs?=
 =?utf-8?B?aHFBSUdyRWc1aWRpZGZzSzhtenMwWFVkUGx5SjljQ1EwbjVSUkZWWXU3Zi9N?=
 =?utf-8?B?WnIrSmhPbTBnSFdvVDR4Z0JUSFIvdTIwekpRVmFPU0kzbm9zRjNqUnhCR3hF?=
 =?utf-8?B?WVNNNE5sc3NvRWw3VFRzSlRadjlvYVpYaHRsL3FmMjlGSjR6RjAzWW03c0FR?=
 =?utf-8?B?em5nRGNtWUtHZGlDVnlEWkxOcWFKNzM2WlFMWGUzS09RdW1yMmxab0o0OWRl?=
 =?utf-8?B?dmIrL1J2Yk9QV1UwVmZEcFIvUDZoL1lDTDZzam1iWmVZVnpmc1BwWTk3Zlor?=
 =?utf-8?B?d2RRdTdRQmE3Y0U1aXNIQ2xvOGdCVTR3ckU3Qldab2ZxMUFVdVhndDlYUFl4?=
 =?utf-8?B?OTlPMmthdFU2QlBsSjByYzhZRlkrUE9ETmVzeUhWL1E1Rkh2MERTVnhzYTNj?=
 =?utf-8?B?STNmdlluVVdtdGkxeWN2Tm82UHNaMUl5cU1lZ0ljRk8zT2tlVWNXTDVVYjRv?=
 =?utf-8?B?RGxUK0NYK1FtOFNGcHpRS01mOUJ2RUMzN3JaVUV2dWk5eHZFNGo2aFhTcC9x?=
 =?utf-8?B?Y2RIRmhON1BzV1BuTjlKUW5OZVNseXlxaEF3T2FjY2Q1RFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjdjYTArblRaaklLUTU0L09uWUxLdHlzTFNqOXBrNUJEY3BuZmZhVFo3MEIy?=
 =?utf-8?B?M3lHTzNzdlJiZHNLWThYaGZZYlNtSXZTUEdXZS9rOXFoZkNrMDROeGltMU1v?=
 =?utf-8?B?NHQ4OW4veENja0UvQkl0b251a1I0MWM1anUwR0YvdWoranQxZzNHN21nRjdh?=
 =?utf-8?B?SHU1ZVJ0azIxeTBLSzFxeFI2eFB3OHVRZkY2UEs1MFordVUzZkxsWk5wRGl1?=
 =?utf-8?B?cXVOd1NPYiswZTd5UGN6ajZOOXhsV0JMSlZSUm1ic3l3VUZQaFBLcy9lajk2?=
 =?utf-8?B?WmkzZG9QZlFaQXFEMDEyQjlQK1p4Y0tsaVJjRTlmbVUzcmY0azZ5OGdpVnA1?=
 =?utf-8?B?bTh6ekFTSlI3Q0RCNVNCWEZXVXRFcmpVckdhdnB1VTErZDVyL0Uzd2pEYkNa?=
 =?utf-8?B?T0NPRWU1NnlwY1c0amV0ZlBBaTdhWFk1Mk9uV2ZxeHd2RkJKNEwzQTdLYWJr?=
 =?utf-8?B?aHFxTEZaZlRZN1VIZ21zbVpMZjMyQnNPbWZPYjVkVFVjdUgvYTVuSVNzd2ZY?=
 =?utf-8?B?OTlZSXFXTjlxYjhpK044aENvK2pjTUdjcnZLWHJWSm1paUpMU1d6bXprcGQ3?=
 =?utf-8?B?TXlXSno3Um93Y08xcWNwVjlDSkhqdWFJTnBFQlpURkZLRzBtTWNSR0FzdENv?=
 =?utf-8?B?a1lmSlhrMzlqMUtlUHNkUlZpbThkVUs4YW9EeVUxUWV5azR4UmU5dzJaSjBm?=
 =?utf-8?B?K0FzdVVLaGRDZW5ldEhrQTZneXJ1aVZCbUl3eEgzaVR3K00xdjJXcFlzT05D?=
 =?utf-8?B?MGZVWW0xT24xL0V3THFOVmk1SkVJR1pYNUdRMnZSSnRHNGJxZjNCTlZWczNl?=
 =?utf-8?B?R3JzSGNxOVI4cVViWXdYcU9zRzdNSmhESitMeGRJUzY3eW1vVHoxSmgyV3Ni?=
 =?utf-8?B?UW0vcXMrZXowd09JaWNNZTZ3d2J4SVR4QmgrN3N2M3k5K2h6MTQvMXZ2dVZu?=
 =?utf-8?B?d2lEb1V3N2hlL2FLb1R4bGpUWStFUUFCa2lkU2pNNUNZZ2lhZUVnbjErK2Yx?=
 =?utf-8?B?c041SDUyMUV3U0lwNDRoa0VuTjIwTjZkTmJ4VXY4cWdjZ2VwV0VHcVg4eG5o?=
 =?utf-8?B?L01TVVkzczRydU9YLzV1cGNDMkIxQ2lyYlJhMG14S3JpL0t4VVdoUmYwUGJF?=
 =?utf-8?B?TGFESHdVeUxkQlJTemwwRmxZS3FJdnVOck9qRGRPL3ZscUdhNFRpU1EvS1d0?=
 =?utf-8?B?T0duZlV1UzdaT1MvMGtsbmp5bkIvNTFnd2FySHEzU2xpRG9IaFRDNFNVLzJH?=
 =?utf-8?B?S0FVSEhrVU4yeFlacjFYaVJLeGVuWVlRV3U5N2lxL05mejcyZnB0WjdpZVd5?=
 =?utf-8?B?dkFVOTIreFFmMDJ4blBsWmFaM2tuaHVDc1ZIZ3ljL3BEUHBjSy81MktCeEV2?=
 =?utf-8?B?UHhWdkZHakZTbDRyMFMzckprMWRPaWtRR1FhWFBibWdRYVRqNitCOVBUUUVM?=
 =?utf-8?B?anZFbmtwMit3Z2FKU3NFT2tjWjZsalU5eUNYTnBUaUJFbDZacmZzc0REb0ZF?=
 =?utf-8?B?dVliV0tWdmdNcU8rdnhVMWRML2VxMlNiQzB3MUlWRjFTQ0R1L1ZYemlzeUpE?=
 =?utf-8?B?YUpZSlRLcjJjSFBsN1d3b0NhckIxYzQwbW9BaTJPblFhZ2pWSERaN2ZXeGpm?=
 =?utf-8?B?QWdTU2hrYVRJUy96U3d4WERPSVlGNU02ZDEyMnBDOVZjTEdYWkJSaTVlREJt?=
 =?utf-8?B?TlVPK293eDhKSk93dTExeGt0S3dreEpCUCt1cVN1TEphOFY3UzRjSDBkNGdD?=
 =?utf-8?B?WXlsVGt2aVRUV09uS3UzdG95T3Nab0FIdmJxdGhsKzBRUDMvblpmb1FmU0cx?=
 =?utf-8?B?TWVLSzNsVEtRN0FlaE03RnliK3hsL0lBRGVCNFJmM2xmWGVjVjlhQ2tiTzVG?=
 =?utf-8?B?c0ZTdE94NEhVU0xZaTNCaU14QVZCend0T1dqOE5Lcjg5V2JJcUxsWWtuTFIr?=
 =?utf-8?B?WTl6aFBTUHIva1hJMU91cHdUOXBEeWlKblMxSmZieUxEcTJVWENQQ1BGRXZR?=
 =?utf-8?B?K0c1WlFZRStGd1FSSFVTUkpTSjliZnFNL1NHT1ArOEV3WVBrVmlITDN2TjU1?=
 =?utf-8?B?ZVR6VW4xeHMrVWkwbmdIeXg0Y2hKckI3WnZGQUpELzRJMVQ0eHFBZitpbkdh?=
 =?utf-8?Q?r7VxJUImjGjeEytr4nedIfW6h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2141d74b-de21-4e01-d315-08dccde64161
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:06:40.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzUNMBPZqd/5vdpTLSyYWJVwAndB7LUWAg39hW5aIXZ7LxIpyl1mDKbIM57WSnFC52i2Zw5yFghyyIj0tU8evQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8423

Add 2 software manage quirk properties (xhci-missing-cas-quirk and
xhci-skip-phy-init-quirk) for xhci host.

dwc3 driver have PHY management to cover both device and host mode, so add
xhci-skip-phy-init-quirk to skip PHY management from HCD core.

Cold Attach Status (CAS) bit can't be set at i.MX8MP after resume from
suspend state. So set xhci-missing-cas-quirk.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- rework commit message to descript why need set quirk.

Change from v1 to v2
- use {0}
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 8b88649b569fe..f62f6f960e501 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -145,6 +145,17 @@ static irqreturn_t dwc3_imx8mp_interrupt(int irq, void *_dwc3_imx)
 	return IRQ_HANDLED;
 }
 
+static int dwc3_imx8mp_set_software_node(struct device *dev)
+{
+	struct property_entry props[3] = { 0 };
+	int prop_idx = 0;
+
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-missing-cas-quirk");
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-skip-phy-init-quirk");
+
+	return device_create_managed_software_node(dev, props, NULL);
+}
+
 static int dwc3_imx8mp_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -207,6 +218,20 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto disable_rpm;
 
+	dwc3_np = of_get_compatible_child(node, "snps,dwc3");
+	if (!dwc3_np) {
+		err = -ENODEV;
+		dev_err(dev, "failed to find dwc3 core child\n");
+		goto disable_rpm;
+	}
+
+	err = dwc3_imx8mp_set_software_node(dev);
+	if (err) {
+		err = -ENODEV;
+		dev_err(dev, "failed to create software node\n");
+		goto disable_rpm;
+	}
+
 	err = of_platform_populate(node, NULL, NULL, dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");

-- 
2.34.1


