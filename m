Return-Path: <linux-kernel+bounces-347989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9E498E12C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590C91F24733
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649E11D0F4D;
	Wed,  2 Oct 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZAHGIQFT"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FE1D0B8B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727887729; cv=fail; b=gQR2z6w1macmUEM5b0FPUMh1dY+aPqTz65lH42U8GI1M54nZqUqPWxZ6VALPPZEAwWzeugLfRi1TkMVnBaLuopNORPpBUGdAFeN6NE+qp2QEAgvfCUAxR4+//NwfKl74fJsTAusqOSDsx1ueJSZPMbjaXSJRe1eA0O4Tr4mSl3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727887729; c=relaxed/simple;
	bh=veN/I1WnqXYqR6mqDVk587fQjPVuQwwSKKmlOc71HVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TUASkVlT3nFFLQNu0sgncagySHFDKaLQh7aQWrLg156SUxizKOBdI5QWpm0TIUXNWmcXom2CW+mv9XZpiW4t9czj2GHwAWSF9mO876Sc0vVAwqNfXmDUY7ZWOcLwxRS8jdugoFhnaF3tJEhV40iEOW5kQVhWNevSmX8j7RK0n78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZAHGIQFT; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9cusT0qFfXq1N4x7iHfX5WfUuNe+L33RD6l9+xuCdTg4Im7JtvRz3hGVMBOxzOCnzV7OOKubLOthiWDJMSEt83D1SZlXduRBqTiVNLiCCPiURf0AM5VCkw3rrLmZZqRdJI6MbUdYEA4IVQsBU8GFdOZEnm0qWNw2Qc38RTnepe//6vKuGs2c5M35+bNXM2HVxzgvLg2jh7NzYBXZaHflcgY4VBo2tyP3E98t0xYvuZkhVU645MqzdZDvhmTnlkhCo2EU4qmLI1YJDGp8qulH1Ik8vs0bvZUYV2ei8SmhtsCJnZapvguqZHw7sKXjwStUfYCsbYUZYd6uKQJFzkNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9CkMO2mxKphlGdVdCM/P0QHnYR4lasxjZth8lJX2cc=;
 b=HVW2FDfFj3KKQRD55eFy3S+NJn9U4Ydm9Sl01kzz9PkRr/oV7Jk3lGhN+m1xBYr6+Zs9kDbRfqTY0xdfKxVvqoFDkf2cz7mxX9/t3WmfZcsL2Y1dxHxTZ2WlsVvXFuLC3ElzMBd4pXQ2SaAZSv3xGMIV8cI/1uMOE6x0f8mMBUYRaKdNZGPgr2g6MJ6RyprWEgOD4330E4OVuNzOHeEyw7tA6iyAJlh98+j+KAgyqYq3oNusN0O445pnBvjgl+RU30CLpG8/sKy72L/fMc0vg0YEwFCrxR2yBPqDtQzB/hrnkIUJx3w14hfNT0/UUYMPp+herJvaQpwTsKoHgy3vsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9CkMO2mxKphlGdVdCM/P0QHnYR4lasxjZth8lJX2cc=;
 b=ZAHGIQFTLtZyUNh/+lrX20rWio/mz6S30qq7OrS4MQgWFU1p+ZCUbRFpvKyFAqbOXOkqvaVW8x6PZb8XP2USAHSIuu03gHR2cgSEMon3EoIICjYFEZsZDwInFPXC3aB4okQ/wNFemXo7YzHQjf3uU3iNXP0a0WV+F21QJfyTDKQ7FUJG8UhGNqdEVq5bIuqEy1htft4Z9ThoOiQz9gcAJJZA5T3n7aDv7BIg1phqs0Ru+Y9H65lxY4mr66slIRc0iOGAugyR5liiH7Do7koFB6yCTzemvccRRk3JZ49JxS9mAJ0HXNR2x7BNIIAb4QceR9knDfBLVUjDwAlkCr+rTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10526.eurprd04.prod.outlook.com (2603:10a6:102:441::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 16:48:43 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 16:48:43 +0000
Date: Wed, 2 Oct 2024 12:48:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, pthombar@cadence.com,
	ravindra.yashvant.shinde@nxp.com
Subject: Re: [PATCH 2/3] i3c: master: Extend address status bit to 4 and add
 I3C_ADDR_SLOT_EXT_INIT
Message-ID: <Zv15UjD9yvJb43MF@lizhi-Precision-Tower-5810>
References: <20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com>
 <20241001-i3c_dts_assign-v1-2-6ba83dc15eb8@nxp.com>
 <20241002094944.5c0c83c8@xps-13>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002094944.5c0c83c8@xps-13>
X-ClientProxiedBy: BYAPR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:a03:60::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10526:EE_
X-MS-Office365-Filtering-Correlation-Id: cb36db8b-0d24-46a3-bb13-08dce3020bcb
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dy93clNubktTMDJKWDlpZTdJMThPMStVRCtxbWc0YjFBVGt4SnNKVEdBK0NS?=
 =?utf-8?B?RDhkQUtnOTZrZndrM1RaT3BBVjZqMWVjZWZEUmwwajdxTmpIdlZETVpLcUtz?=
 =?utf-8?B?V0IzaUZHNDBzZWI5bHlvRnIwWVZqWFVGYmFPckxOWkliK20wNmh6Nm4wR1Ew?=
 =?utf-8?B?QUVLWjNqdmxpYm9udU1ENEJLMGIyN1Y3elJ4Z1ltUldTMjRPV2QwQktNTXNs?=
 =?utf-8?B?UE04cElIVU05UnBwZmQ1WE1FYTJDcE0wYk9FdWRwenRkQzRnUEptWk90NTdL?=
 =?utf-8?B?V3BhNUlPRmg0MWJXaWRlZ0QrY2JZOEZTZUdjMWYrVU9ja1czZFZ6UmhIMEhN?=
 =?utf-8?B?UjVNWTQ4TXUxQmxHaHJDb3M0UmtqclVRS3U2TXB5b05XMkJ4Q2VuMHNMVXpZ?=
 =?utf-8?B?UVhvS1AwSS9MaW9WQk5kbnMwWkxqdU9iQmVxbmVTV0RKZDJJbXBOanlLa0NZ?=
 =?utf-8?B?b2U3R0l1WCtBOG8zdERYWG8yR09tdGNiNlY4d1hSR1NIRk1JTCtMMi9qWDA0?=
 =?utf-8?B?MVBycWdNVDdGSmVoMitvRDlocHAvOXdFdFBmS2pQb08yNVNXeHhZVGtnRUl6?=
 =?utf-8?B?d2I2ZUltU3d6WTF4ZlZMZGw4WnVjbEtEaVhqNUlVdXZ1RXFXZXZnY1crRTA0?=
 =?utf-8?B?NWFFYmtsTm9USExLMksxQzh5Tm5oMTZYcUhpVnVPVUNrSGp2NzcyTkgyR1R4?=
 =?utf-8?B?b3N3d1ZxektvbVQ1TVZOUzhxWC9tRWI0UzRGd2hxbGt1Mjl3blpOdmpXWThx?=
 =?utf-8?B?aTJUVE5SMVpQY01NRURNVG05NWJQY290SEJJd1N3b044b2hobFZDUUs0NGlV?=
 =?utf-8?B?RHB3dExJQTBZZklwUTNDWUJlcm9zVkY0QWhOSFE4SVpoRGROTkI2TmZzbk9E?=
 =?utf-8?B?azZTT0psVUE1bGdUUC9kTXRzbFUrSTVYSm5Xb1E2WUdUNm4rZHRZVXl3TGVY?=
 =?utf-8?B?T1VsNlZOdUR1L29idDh2bzN6NVN4ZHNhakFCT3hlemZpcC9KQ21XU284L21E?=
 =?utf-8?B?NSswNDBKbzgzMUpQTzRJc0VoekMwNmhRUTdKcnNVSDdCMktZZXNFZGpCMzdE?=
 =?utf-8?B?TDB3VnMvdUFSTllFUkVmM3dFZnFNN1RsNTN2Nkp2T25sRFdRMUFFU2ZVcWFL?=
 =?utf-8?B?bUQvaThJNzc3cGkxQWR3c0lXV3dScGZoRVVtYjBKSEZ4bDZHQkkwN3dEYU04?=
 =?utf-8?B?a1JWZGFOdUlOZkZBMG1oSFhzVTVmbmU4Ky80a0FtMVV1VnR5Rk9CS2oyeTUw?=
 =?utf-8?B?QW02a3RmcTdLOGdVSFMrckQrTWFTRGltSFB4L0FPMTF0NmI2aUcwVE4vaE8v?=
 =?utf-8?B?V2NjVlV2TTB4Ym9IbE1NeDRHN1piRkRxcDlzbklNSTRLN3F1VnZlSUQ5cUtP?=
 =?utf-8?B?a2t4dndxRnRYU0dIbWlrYWowZGlqTEZ1ZUNjNFhMTXpXQUQ5NDdJNk1VUUUw?=
 =?utf-8?B?UG9Pam9SaUZDM3FEZVJ5RzhLcVlVbm5UL0phTmg2S3R1UmtzaUYvTjhNOWt0?=
 =?utf-8?B?b3VmbCt5MVRieE1WbDhqS0NVbDVBc09LUU9yVVIyRFhGOUpJODZQOFc5elJk?=
 =?utf-8?B?dUExR2JjeTZ5aWUyVllKVFVXcVRuaHBoUjBZWHdJOXhzeGVoYU1jekdGZHBu?=
 =?utf-8?B?T3h5RTV0OGtKOWZ3V3kzY2JFNHJ0Q24zeVF4V3kzS01qbTNlWFBTeXFJMEFO?=
 =?utf-8?B?eFhKV0tSRnpWL2N5VG1Zay9RWGxxUXRzdnpjNVJubXd6dTZQaHpuN25waTND?=
 =?utf-8?B?MzZMOWgvZnFlRm9qVG5TNmhOY0laeWR0S2gyZ3VuSk9OdFZyK1JCYld1QlFp?=
 =?utf-8?B?dW1nUFBnYkw1VnJmNFo3Zz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZzBrZDFLcmY5MDZsYjRzVGhmK3UrVFZZWXlvNFVjUWNYWUpNUW56eFlYZnpR?=
 =?utf-8?B?WFJrd2tKOUhqS0kwQy9kL3NqMlZUb1VFR2xUcW82RGJKNnF1b3czMUtrejIv?=
 =?utf-8?B?Z1RWUXp4VE5ieitkMm5NRFU2c1NvRXVlTzBYbllhREtIUXU4blp6TlpEbmZJ?=
 =?utf-8?B?VnlUS2lFeU9TS2d1cE5kRGladlJQYkdCTXFHaEMwSUsvMndVVGF4dGg4RnlB?=
 =?utf-8?B?NFpidUozNGNlRjVTM3pZeWRSWitsc2NjN0xONjFXcmh3ZUNoR2o3QUZndjNm?=
 =?utf-8?B?a1p4dlZKTHpRb3pMTmFlUmlzT1NFRHl0bWdkQ2NGc1BVMUFWNWRBellNcnlZ?=
 =?utf-8?B?VnFzMlp1TmlZRXJOWk9QaVdIM0dVWEd3TWVUQWJCay9vNGQ1MlNyaUVnSi9n?=
 =?utf-8?B?RGdSYlV2Tys2alBzTFJjM0czNkQ3ODU4UVVKeWpJM1MxT0tVeHNwVDc2ZkFq?=
 =?utf-8?B?Y0ZMUXF6Rm9BR014enN2WmpqRlJ0c1lrOENMS3dqN3NRdlF6S3lCKzl1MGV1?=
 =?utf-8?B?L1Z5bURrNUUxY2FYR3lpQ2NpbnBOSytUdy90a3pLYzVtWXdtMVcvSVNxYStm?=
 =?utf-8?B?REQyRDNESlJVUDEyVG43WDNScWp6V3BFNWhmUmlicHVWSTVSaEFvVCtzZlFt?=
 =?utf-8?B?OVEzLzdvTVNZSTA2b2VtUWZ1R2tlYXlYQjhJejJrNFZpN2c3d0F3UldoV2lZ?=
 =?utf-8?B?RnZRZGNNTVRoaDluS0ZBUzJ4bENDVDA1RXJMdXoyR016SHU4WVZIYnlCVDVy?=
 =?utf-8?B?RzFjMDlRYnFkTHpZSmlqb3N1TUQyckNNR3kxUjJ4ZHRZTlg5d1RZVVZyYUM1?=
 =?utf-8?B?U3pRaUw2cnY1T08xSk41V1dxeExjenBmTmM5VVJDWVBpZXhtRUtRdDJEK0pI?=
 =?utf-8?B?SEFNazhVRkltYXQvUHpmMlFJRFdLZEhWdndPaTdBSHFpejZiT0lpZ2JNM0FJ?=
 =?utf-8?B?UkYxU3JsNTMvcE52aUVuc21oeWg2Vkp4QkUzMVNHV1A3YzZvRWl5WWVYWkI4?=
 =?utf-8?B?T1VxRjJUZWk4bnhjeUYvZzVHL0RXUXV1QnVzbnQ5UGVoL1VvS010RUdNcjVn?=
 =?utf-8?B?dEZjVVVZWTdORG1ZdGZzaWtKM3c0WFVEeXR6bk9Hcm5MVWt2YjNtdzZLR3hl?=
 =?utf-8?B?M09KRzQ3eDVwNW1nMXJMOTRWbVhDUkN2eFJqMFM0OTZFdEhjb1ZEUmJoc24w?=
 =?utf-8?B?N25LaTFDbGp1RHo2UjRXdWh4OEs4Njl6VVBwQXZ4NUNTWjhVWjYzS0NWN3dL?=
 =?utf-8?B?WEdDeVhSQUZHT3BPT3I4UzFnbG9CZFZjWnJVTTRBMDBKNUpNWTFqTktSMGk0?=
 =?utf-8?B?bUxFeEZPN3pHcVBKRzAyTXRpd2dDU2NrZWFUUnBaRFBzUm5Gc05VRkxMSTRw?=
 =?utf-8?B?ZlN3YktVNWFOSEFqa1J3c2JUTUlFZi83UGhpM2l1c0RKRlJuSFdxYytRanh2?=
 =?utf-8?B?SmsvOTlkYmdUZnI3SXNEVnBEb3o4dE9PNWVoMUJoUUwrQWR4b0xidDZJay82?=
 =?utf-8?B?VkE1djRHYjE2Vmk2VUdGaGtZdnYwY2RSbjErdk0wWUpVc09oUC81dk12dXV3?=
 =?utf-8?B?T085WitWblJxNEpkSFFFcCtacmsybXc2UnZ1ZW5WRVFvS0RVUEI3OEN0WlRz?=
 =?utf-8?B?TnhrWGNFTU1CWFNPWEF6WWE1WUVFcTlFU3NrZVRTRXdMaTFlNFJTQVVUSzNo?=
 =?utf-8?B?V1BSS1QrdUVxck4vaStQQlhvQkM1QTQxYnBSakhNQmx0WmJ4djdpWGcrQ1k1?=
 =?utf-8?B?MVRrMmp1WHk2OThKajBKWmtWZHZJdGtqT3d4bTVnTE9zSnlBak5GcWl1Uk5L?=
 =?utf-8?B?Z1JxeG9NWnlpVlZKS0RXalMyVVNOVkFvTkxZams4L04wV3pvUFl5MTdLN0xO?=
 =?utf-8?B?Y0V2UFdCUzJENUNJRjgvLzBtZk9sRGoyQTRpWTVRVWV0SVV1MmNSaU5MYk5M?=
 =?utf-8?B?UExRcktycVNLdlZRazRlVFpXYWQ3YXVBOC93R0xDc1ZvWDVHazVXVGhUYTU1?=
 =?utf-8?B?Z24zM1Y3WGVzMlkzTmFKdWs3V3dGUHBkclZuRHhEQTVMeWxMMXAvRHppaktz?=
 =?utf-8?B?RzVJQTlESGp2VVNxRXJrVjhwelptYmtPanhidjhzdkxOV2pTaFh4RGIvR0lB?=
 =?utf-8?Q?kcyMV+UKfuV2R9/1t8uyFSdso?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb36db8b-0d24-46a3-bb13-08dce3020bcb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 16:48:43.6607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7O/ibYbnyKtHnTWn91VO6kr/YRLadEZZ6DPqTYqWi7pZdU6X2QPdk11YxrmWzCZeXcF2gdsZ/3un31i69iz7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10526

On Wed, Oct 02, 2024 at 09:49:44AM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> Frank.Li@nxp.com wrote on Tue, 01 Oct 2024 13:08:21 -0400:
>
> > Extend the address status bit to 4 and introduce the I3C_ADDR_SLOT_EXT_INIT
> > macro to indicate that a device prefers a specific address. This is
> > generally set by the 'assigned-address' in the device tree source (dts)
> > file.
> >
> >  ┌────┬─────────────┬───┬─────────┬───┐
> >  │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
> >  └────┴─────────────┴───┴─────────┴───┘    │
> >  ┌─────────────────────────────────────────┘
> >  │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
> >  └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
> >     └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘
> >
> > Some master controllers (such as HCI) need to prepare the entire above
> > transaction before sending it out to the I3C bus. This means that a 7-bit
> > dynamic address needs to be allocated before knowing the target device's
> > UID information.
> >
> > However, some I3C targets want a specific address (called as
> > "init_dyn_addr"), which is typically specified by the DT's assigned-address
> > property. (Lower addresses have higher IBI priority, and the target can
> > adjust this by using the assigned-address property if using DT). The
> > function i3c_master_add_i3c_dev_locked() will switch to this
> > "init_dyn_addr" if it is not in use.
> >
> > Therefore, i3c_bus_get_free_addr() should return a free address that has
> > not been claimed by any target devices as "init_dyn_addr" (indicated by
> > I3C_ADDR_SLOT_EXT_INIT). This allows the device with the "init_dyn_addr"
> > to switch to its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise,
> > if the "init_dyn_addr" is already in use by another I3C device, the target
> > device will not be able to switch to its desired address.
> >
> > If all of above address are already used, i3c_bus_get_free_addr() return
> > one from the claimed as init_dyn_addr and free address slot. This ensures
> > support devices as much as possible.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v3 to v4
> > - rewrite commit message and comment for i3c_bus_get_free_addr()
> > ---
> >  drivers/i3c/master.c       | 68 ++++++++++++++++++++++++++++++++++++++++------
> >  include/linux/i3c/master.h |  7 +++--
> >  2 files changed, 64 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index dcf8d23c5941a..a56cb281e6b6d 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -345,7 +345,7 @@ const struct bus_type i3c_bus_type = {
> >  EXPORT_SYMBOL_GPL(i3c_bus_type);
> >
> >  static enum i3c_addr_slot_status
> > -i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
> > +i3c_bus_get_addr_slot_status_ext(struct i3c_bus *bus, u16 addr)
> >  {
> >  	unsigned long status;
> >  	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
> > @@ -356,11 +356,17 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
> >  	status = bus->addrslots[bitpos / BITS_PER_LONG];
> >  	status >>= bitpos % BITS_PER_LONG;
> >
> > -	return status & I3C_ADDR_SLOT_STATUS_MASK;
> > +	return status & I3C_ADDR_SLOT_EXT_STATUS_MASK;
> >  }
> >
> > -static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
> > -					 enum i3c_addr_slot_status status)
> > +static enum i3c_addr_slot_status
> > +i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
> > +{
> > +	return i3c_bus_get_addr_slot_status_ext(bus, addr) & I3C_ADDR_SLOT_STATUS_MASK;
> > +}
> > +
> > +static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u16 addr,
> > +					      enum i3c_addr_slot_status status, int mask)
> >  {
> >  	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
> >  	unsigned long *ptr;
> > @@ -369,11 +375,22 @@ static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
> >  		return;
> >
> >  	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
> > -	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
> > -						(bitpos % BITS_PER_LONG));
> > +	*ptr &= ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
> >  	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
> >  }
> >
> > +static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
> > +					 enum i3c_addr_slot_status status)
> > +{
> > +	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_STATUS_MASK);
> > +}
> > +
> > +static void i3c_bus_set_addr_slot_status_ext(struct i3c_bus *bus, u16 addr,
> > +					     enum i3c_addr_slot_status status)
> > +{
> > +	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_EXT_STATUS_MASK);
> > +}
>
> Can we drop this helper and instead modify the
> i3c_bus_set_addr_slot_status() prototype to get the mask from its
> parameters?

git grep "i3c_bus_set_addr_slot_status(" drivers/i3c/ | wc

There are 18 places need be modified without this helper function.
are you sue what you want?

Maybe drop i3c_bus_set_addr_slot_status_ext() is good idea by direct use
i3c_bus_set_addr_slot_status_mask().

Frank

>
> > +
> >  static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
> >  {
> >  	enum i3c_addr_slot_status status;
> > @@ -383,11 +400,44 @@ static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
> >  	return status == I3C_ADDR_SLOT_FREE;
> >  }
> >
> > +/*
> > + * ┌────┬─────────────┬───┬─────────┬───┐
> > + * │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
> > + * └────┴─────────────┴───┴─────────┴───┘    │
> > + * ┌─────────────────────────────────────────┘
> > + * │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
> > + * └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
> > + *    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘
> > + * Some master controllers (such as HCI) need to prepare the entire above transaction before
> > + * sending it out to the I3C bus. This means that a 7-bit dynamic address needs to be allocated
> > + * before knowing the target device's UID information.
> > + *
> > + * However, some I3C targets want a specific address (called as "init_dyn_addr"), which is
>
> 				may request specific addresses (called "init...
>
> > + * typically specified by the DT's assigned-address property. (Lower addresses have higher IBI
>
> 				   -'s
>
> > + * priority, and the target can adjust this by using the assigned-address property if using DT).
>
> Can we remove the whole "( ... )" sentence, and replace it with:
>
> 	"... property, lower addresses having higher IBI priority."
>
> > + * The function i3c_master_add_i3c_dev_locked() will switch to this "init_dyn_addr" if it is not
> > + * in use.
>
> 	if it is available.
>
> > + *
> > + * Therefore, i3c_bus_get_free_addr() should return a free address that has not been claimed by any
>
> 					preferably return
>
> 	that is not in the list of desired addresses.
>
> > + * target devices as "init_dyn_addr". This allows the device with the "init_dyn_addr" to switch to
> > + * its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise, if the "init_dyn_addr" is already
> > + * in use by another I3C device, the target device will not be able to switch to its desired
> > + * address.
> > + *
> > + * If all of above address are already used, i3c_bus_get_free_addr() return one from the claimed as
> > + * init_dyn_addr and free address slot. This ensures support devices as much as possible.
>
> If the previous step fails, fallback returning one of the remaining
> unassigned address, regardless of its state in the desired list.
>
> > + */
>
> Please update your commit message as well with these changes.
>
> >  static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
> >  {
> >  	enum i3c_addr_slot_status status;
> >  	u8 addr;
> >
> > +	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> > +		status = i3c_bus_get_addr_slot_status_ext(bus, addr);
>
> So here it could look like:
>
> 		status = ...get_addr_slot_status(bus, addr, <extended>)
>
> > +		if (status == I3C_ADDR_SLOT_FREE)
> > +			return addr;
> > +	}
> > +
> >  	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
> >  		status = i3c_bus_get_addr_slot_status(bus, addr);
> >  		if (status == I3C_ADDR_SLOT_FREE)
> > @@ -1918,9 +1968,9 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> >  			goto err_rstdaa;
> >  		}
> >
> > -		i3c_bus_set_addr_slot_status(&master->bus,
> > -					     i3cboardinfo->init_dyn_addr,
> > -					     I3C_ADDR_SLOT_I3C_DEV);
> > +		i3c_bus_set_addr_slot_status_ext(&master->bus,
> > +						 i3cboardinfo->init_dyn_addr,
> > +						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
> >
> >  		/*
> >  		 * Only try to create/attach devices that have a static
> > diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> > index 2100547b2d8d2..57ad6044ac856 100644
> > --- a/include/linux/i3c/master.h
> > +++ b/include/linux/i3c/master.h
> > @@ -298,7 +298,8 @@ enum i3c_open_drain_speed {
> >   * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
> >   * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
> >   * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
> > - *
> > + * @I3C_ADDR_SLOT_EXT_INIT: the bitmask represents addresses that are preferred by some devices,
> > + *			    such as the "assigned-address" property in a device tree source (DTS).
>
> The naming could be improved, because "extended" does not mean much. I
> believe we should express the fact that this is a desired addressed, so
> what about:
>
> 	I3C_ADDR_SLOT_I3C_ASSIGNED/DESIRED
>
> >   * On an I3C bus, addresses are assigned dynamically, and we need to know which
> >   * addresses are free to use and which ones are already assigned.
> >   *
> > @@ -311,9 +312,11 @@ enum i3c_addr_slot_status {
> >  	I3C_ADDR_SLOT_I2C_DEV,
> >  	I3C_ADDR_SLOT_I3C_DEV,
> >  	I3C_ADDR_SLOT_STATUS_MASK = 3,
> > +	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
> > +	I3C_ADDR_SLOT_EXT_INIT = BIT(2),
> >  };
> >
> > -#define I3C_ADDR_SLOT_STATUS_BITS 2
> > +#define I3C_ADDR_SLOT_STATUS_BITS 4
> >
> >  /**
> >   * struct i3c_bus - I3C bus object
> >
>
>
> Thanks,
> Miquèl

