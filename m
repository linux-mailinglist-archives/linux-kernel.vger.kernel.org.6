Return-Path: <linux-kernel+bounces-355499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB299532E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CF12879FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F371E00AD;
	Tue,  8 Oct 2024 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OxIr73tJ"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC4B1E00BD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400731; cv=fail; b=Ma7J6TwR8lWAlPmWEj5mLF6xuUl3lHxTVNpuMw86yctSODqjr04PfprOwGWvihxwMUe3rwM2ozpJpCADdypoHzfEx8L8MUKQ36JgMFzoumNcwQoIz4+7L+zcKozMk2GlEZTJIiunEep+IVD4HDg1NPSlHXrf0T3GuhZQXtbjmpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400731; c=relaxed/simple;
	bh=+7QPBxnwt2V1GG1U4yxNLheJGHw+eSP4zpbWKxI6V/s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=r14o1sQ7cANzkYEPdcI/iqx6xBKx/uQyjBj+0tx7Lof4XlFnSxszj/7SIrV9E+1oki3FHIZEVGcH6Y7E4S89J4vVnHV6KO9KZyY5ke1I7xhZbD8xzXaPn0n6gR6BRm3esUadu31k36jFscXuMDKEt/yz9jp8HTVsDNu+VZy/ZOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OxIr73tJ; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l59dPJYO4wcJ/RehDy/7mGd+9FhyXAkZjpzagxtxgtGL2Fc/h4eW/ACwuktz6SDwEMfpCrNPaS6Yeh2i2n4fJwlwqLWakTaqSPcXwyHzTK+APQMIluC+SncSAZE+lgdtkjGlm1mDOwRYdYdM0k+zHiUw9olebvQ5iaJUB8JtnjJzhDN83pUn0y48pjXM/Sh0wDCf4dA+Y8uQ5NpihDTpmIIQTeYmiliTqFAOyptY4V7DcQuwYb4xzcOUIDrb9BSRIkk/dGs0E2rKhITHayKuuacSWgHwPkVSRUqtlMeUt81qaPWhr+kOpjrsNecTrKYdjt8XCNHis4luHL84Mzxo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fAfl3zyO+Nj+cRlreqeSBYK06jwDw1fGqD5/PIkPSE=;
 b=wsLy41OJx14hzMU4zyuqWZ9wsrBAoxuPdvBSKiCI57z/6yo/cq46ji8Kaw1LYfA5SNxVpdFTc0JsjJQhWIHqJRil1T44WA2qcgppVwl0WgF5Sxc0rSKXIDvo2II1MBzwfEXAn+oNsCo3uDPJg3LwZMVcm6xg++FGi8SKNmZmYHL7fwEkhc18SDL7gb1aNMM/BoWgbJh9w8Ziutu3oCCmNmWGrXSreECzy9oHTwtSdEYJ6ryKnRLFBt9YQ97Mv3CT9GX43+XRhJVF0KD35GWl4nrXgIMiL/Rd3nkl8CNZNsAoY55ekD82va+M9twG8fBxVNoJSsWC1q31c84cGA7S9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fAfl3zyO+Nj+cRlreqeSBYK06jwDw1fGqD5/PIkPSE=;
 b=OxIr73tJikAyD9i944SZhHCF9mlRLpaXGZsdvRF5ttGckeevfWxGRFkarKXxJ8MrjWCDtxw5n7CTLwcmQ8qhxyAYK7w9m4XUzQSs+a5sGF1nVQMCLW3Q86ya1hmQSwX89pjrHFzr6w/p4YcXNx/Nz136yF5I472MmsJytbUDbER2Q9AhWFxFDp5v7F1xqioF8wFekbu4MtrtY9p3dhUHNWvWXi8xHszyhUe4WHv1f2Oij+rRwA22GU01nGga2tn8Mc0tOEDuux6uaxswyQZ8vg1J7CNy83piZQIkbFJNqPyx1Ub1ICEYaIG/Nq0CNrD5/ZgINEO+ohRbgKfZGvJchg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB8PR04MB7194.eurprd04.prod.outlook.com (2603:10a6:10:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:18:44 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 15:18:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 0/3] I3C: master: fix the address assign issue if
 assign-address is exist in dts
Date: Tue, 08 Oct 2024 11:18:23 -0400
Message-Id: <20241008-i3c_dts_assign-v7-0-96ec93d1f34c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD9NBWcC/3XMSw6CMBSF4a2Yjq3pQyo4ch/GkHJ7gTuwkJY0G
 MLeLUw0MQ7PSb5/YREDYWTXw8ICJoo0+DwuxwOD3voOObm8mRLqLIWQnDTUboq1jZE6z52RRQt
 aA0jHMhoDtjTvwfsj757iNITX3k9ye/+mkuSCm8aW2oEssClvfh5PMDzZFkrmG+sfbDJGi6owF
 VQK7Aev6/oGpO4kKucAAAA=
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>, 
 stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728400720; l=2974;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+7QPBxnwt2V1GG1U4yxNLheJGHw+eSP4zpbWKxI6V/s=;
 b=eoYRNB1Esyjox7DTHyU0EI632GB0WoN/RnXDofnGr9T5O3q6X8ew1NdpHwoOfiqpoSco48xlC
 ZkhCi4i1rYdBLC5NkCUYO3Dc+NpF3mqIBvCbtQmQ4XSfn3TJjfRg0Bj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB8PR04MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 59aa9827-6555-4764-273f-08dce7ac7f64
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?R09kVTRmYnIzQWtaMTRIUzU2VHl1ay96U1pBNENJbVB6SEtBeHJrUHdxSmNm?=
 =?utf-8?B?N1pYUDQvbThlSEZGU2RXdy9NSFlZRWVxZmUxdEFrL1llSmNNaWU0SkxFK0E0?=
 =?utf-8?B?QzZqa2hwbDhkN2FIaGd2RmtwYjlveS9xdExKeU5jLzhTc3RUemcvZEJGVUxT?=
 =?utf-8?B?ZGRQUlJpSDF3ZVVYdThiVlhMT0oxaFIyNDdIdzlKd1ltZTB1MzlHeS9ZclB1?=
 =?utf-8?B?T2hhZ09jYzNXMjdYSGcxdUN3OUswbHl0WHFEdk1aTFZKRXVqWTNQZjIxRjJx?=
 =?utf-8?B?TGx6U1NhelkrcVVxRWsxMjNzQW5MaThyMDQ2WnlMUzNLYjNSNUM2b3VPbFV3?=
 =?utf-8?B?dEcwMkRjNm5xbGxwT1JEQkhCTnBjcWNBNi9NRFRMRjdSbm43czBidE5BUVYr?=
 =?utf-8?B?Y3BabURIYXZ2Z3ZqUFFSZEZaamk4VGthVDRJUmVGcldicnZXUDAxR2VwWVcx?=
 =?utf-8?B?cFgrd0RxeStMZXhaUENFWDJiQlk3bmtUd2Z1U3RxWmVGbWNyVkxwOU9Dcmd5?=
 =?utf-8?B?NndSMWcwWVQ5L2RlMkdqTU9iRmRhQUZZekRlQ1F1V2x0OWNEdmNEc2pBVEdu?=
 =?utf-8?B?ZVUrUFdSUmhueU5FUVhKNWZySFVpQlYvQWtCQjBHUDFEbzE0bGxBMTBiTVgz?=
 =?utf-8?B?QUxDUTdZZldTT3YxcTAzNUtyVDBDb1J1UGZsN1NQaVpkSEd5emFUOGM3dWpt?=
 =?utf-8?B?a1dIL3c4alpBNm5wWW9KeFlCVjROeVZkR2I5Y0VyZkhCTCtZWnpFb0hsTkRy?=
 =?utf-8?B?SGx1TnVCekpqa2UzK0lVL25JMnJhVVh6d2x5aVpUd3ZnOUd4VEtiTlZpeXVm?=
 =?utf-8?B?L0VaM1JyV2xKMHY4clhYdXkvU2JreGQrNkwxbXc5R3NYd2JmMGdFTmFGck9y?=
 =?utf-8?B?NTM1UW05SkxnM3FMTS9vUDlXWWx2cDFTaHlKMkx6SUlWV1ZyMG4yYi9ydGpz?=
 =?utf-8?B?Vjdvb3pNc2VrTENQUmRRclBxblBrMEIybllXOWFOaU9sZWJ2M2VTQ3BOV3h2?=
 =?utf-8?B?U1VRZGU5M1VmeGh3eEFPMU5Jd2RmaUJ6VjE0S3FzRVZtS0hEc0Mwa2Y2dnR5?=
 =?utf-8?B?NzV1R2lTRGZBZnBmcnRkbVRuTks2T0NDSUVXQjBuRDQ5Kzc0Nis5Q0JRYWI3?=
 =?utf-8?B?UElxRS9oVjRKbVR5emt0UGx2UEczTmkrNzQ3Wjc2RDFyM2NyeXpBQm4yUGxD?=
 =?utf-8?B?N1RkTzlLNlZMWnVmM2tkZmIxdXhqVlV2a1NhMkVYU3dUQjREUllXWnVpU3Vz?=
 =?utf-8?B?U2w2aHpSQk83TnBLdWRCTG45VTlYdllqNVl1Z2F1amRKaTR4ajRnL0c0Z0hT?=
 =?utf-8?B?TXd1d2pnTlRyeDMvMWpqc0JlalFHWmpZVkJMaitGTlcxMHBya1BjOUJuSVRZ?=
 =?utf-8?B?T2c5ZHpuMS9rbHBCZzZRRGUrOWVyTHg1aFdSVkY3VUw5eEdjcFR5QnF0b0JC?=
 =?utf-8?B?YTErN1Y3OEplV2huWWlucG5ubEJmWTRwOTM4dW55Q2lyWnY2SUFZdnJ6aHhv?=
 =?utf-8?B?Rk82TnMyai8zSURvRGRvN1o0NlVqNzVsVjd0d3pLWHN4dkI1RExrTGJjTlUx?=
 =?utf-8?B?c3FWWnlOclQybzNRd3lucE1IeG5HdW5Id1dmZ3p2aWM5Y0NJL3hxRitYM1Nw?=
 =?utf-8?B?bkFYcTRSczZZWmFwQXFHNlhCRzBKd2UvR1JSdDJUWmQ0blpyYVEzRlpBUmxX?=
 =?utf-8?B?RUFPMmZnTXlIeEY4Mnd6WUFxQnFTZlYwdEtsOG1LWFFOR0p2KzZrUTN3TDJM?=
 =?utf-8?B?RlJhWnJFQVBoVWxML1lxaXQ0ZHlKRVpsUWx2Wno1RmhwUXhkbm5tQ0Y5U3JQ?=
 =?utf-8?B?YmZhYnM0VTJpbFRWNDdNUT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YSt0elMrMzhjaFJIakNyYSswQi9rT3B4UEp5Y3grVU9MY2UyZGdtUWgrbmIx?=
 =?utf-8?B?cWRjUy9PSGIyOTI3b01tazJYK0VXMDRlU1dqRWFrQ0NVZmRWcFZXTzZKWVlX?=
 =?utf-8?B?WVNYbGFqektGL0hlWTZmbktnRzBBenovSFVMK3NUV2tXSW8rQ2xPc0gyVkJV?=
 =?utf-8?B?NVlYWS9wOFlnUmhSMjJrMGNDVE9aUFhkTlRLd29ONnpOQTNDdExVQkpMOENa?=
 =?utf-8?B?UWd5eFlBcHRyQU93aTVuVHhVNkp1YWtOenBFbVd5cHI3Z1RkekNqUTlvZlVN?=
 =?utf-8?B?RDlQbWt1c09LUlFqRG4zN2hkOTRBdjdheEhkR1V2aXVnZ1NLNE9zZGwzOUF3?=
 =?utf-8?B?MzM3L3BUbHpVa0UzT2ZSQSsrTkpndWd6eVl3MnhMSGc1WXVmRE53T0lBT0sy?=
 =?utf-8?B?Y1lvM3drRUJkMFVRY21hbERWWjhISTBvQkdZcHlKWHBWcnRyY05nZTg5NVRn?=
 =?utf-8?B?Tk5Pbkp4YjhFR0ZBMUljcUhYWGttUWdNNkQ3Y0Iya0pycGdVTE1uSHZ3d0tC?=
 =?utf-8?B?bUxVbzdna3c4ZitUajVyblN2TmdsZDBvT2IrNUVTTW9EdW9YQWp0Nlh3N3hr?=
 =?utf-8?B?aFArT2hUYzIzWHl2TC9hcVh6MkdyUkFNRERkU0dhejdVaTF0RnFwV1pqK0do?=
 =?utf-8?B?K0lLNVFwZWhWNXpuNW5scENOWE90ZEs4a3lXZXJHd0FoVTJPQ2c2SzFmbmll?=
 =?utf-8?B?dGRWV09MZnU2b2FPUVgwcWZFZmQyV0M3WlJlSXRhSEY1NmVvNGRnaDBlRW85?=
 =?utf-8?B?dGNZWGdYbHVvQkhBaitEYXZpVTM1ZHBPa3BNaWd0WVBQL0FYVzJaNk8rN3kw?=
 =?utf-8?B?UlFiaXkyUVFvVEUrblh5Wmo2UnQyaGR3bnN4dERmZUZNTGdVU1pEdm1YeXVr?=
 =?utf-8?B?WG02MithQ3BRUFpRWkllNFo0TUUrY1lyZzBvT0NlRmRnaHpmVjU5OHlRaTgv?=
 =?utf-8?B?YWJBeml0TDBuQWhYazVYa3AvSW1jMDJJZlBWdTZoZFpieFJHV3lrMlE2UVNP?=
 =?utf-8?B?Vk5IN1FwVVhtNDFXM1JIZ1FJblduOVFUbGo4QVNDWklTK1J2cnArRGtFUU1i?=
 =?utf-8?B?eWVvNTZXalk3dHBtWG5rSGZrcVhEWm9FTzNIU3hjRUppT2pOd3BCeEtiYTVL?=
 =?utf-8?B?L0g1L013YnNFNy9uN3VuUWdHWEQ2UU5OTXI0ekswQStlaDcxK2VrUjBNZmcy?=
 =?utf-8?B?ZVhUbFdYczN0YU1zMS9sNmc5Uk9NeldTUXE1MHVpeWFaaU5Fb2RKajJYRzNR?=
 =?utf-8?B?M0tCYnNIallNYkNhclh2VEtRQlduMGtqN2JhaVYxM3dtbk1URzBPZ01nVGZY?=
 =?utf-8?B?cDNRK0lyaktZNkRYT2tyd3RNOU0va1RXT0IzL1YwWlRweGNSakFEWWlvNWI3?=
 =?utf-8?B?Z1ZHSHZCUXZ3L0F2VGFEeWxtTDdCSFVKR1ozL3N3MzhrSktDUFV1dlpLNmJz?=
 =?utf-8?B?cHM0RmZKOURMMHVtL2xSMEpJTldWL3V1ZXpJdDlCQU10bWcwUzRZZTBFcFE1?=
 =?utf-8?B?VGtqcWppc21mSjRrTVRURytuV0JkajJ4YlpuR3c4Z1h3TWRKbWFUS3IzNWRQ?=
 =?utf-8?B?QXJNWjRHZ0pGVERuRWZ6WlZjRHRuRnVER3NrOFA3YWh3ZHhZZzlMdFVtbUhn?=
 =?utf-8?B?QzlEajRpc1o0bWFnbUMvWHRjdWFHc2EwSGNCbXhMalc1SVE4M09aN1Ayb254?=
 =?utf-8?B?RHJ4Z0xvYkNSSWR0ZmRZS3hmWmJDUDNuMVNPSjdtUHB1TW5iRHF1QzZNQjNn?=
 =?utf-8?B?a3dTK1BvaFJHYmpJelBxWXErOG4vR2pUNEkwUWwyeE12R1I5YU56VW5kaHdp?=
 =?utf-8?B?TXVlM0FMaHBicC9RQ0VlODQwMGNxamRVeldyZWxkNEI3V0RRZXdsc3dkWWda?=
 =?utf-8?B?NlBaWHNSTEJUZGxUSjNkSFdFVnRjY0wzeTBjc2k2M1QvNit1ZzdjTlp1WlpS?=
 =?utf-8?B?MVNJL2c5V2lqN0x4cStDM2N2NTVpcG5FNHRBRDJhSEh4UXRUZmloTXBXbW9a?=
 =?utf-8?B?SHhiYW5SZXFIeGhwZmltcXFraHRVMjlSeUFQSDUzVlpZa3pkK21YLy9tQnJJ?=
 =?utf-8?B?OHVURzlLcnB3UGpJTUJOQ3MzOHZqL3VrQ09POW1JeDExZjRKZ0VUWGFWYkdV?=
 =?utf-8?Q?VZ3g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59aa9827-6555-4764-273f-08dce7ac7f64
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:18:43.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //83gv1Nn3sNC2jbEIw6SOWxFfTOc/G71adzeDPXeqC2QuGHnfOmEePKi1GPOimaaQcsiXCsvlSizlbcccX+dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7194

These patches are split from
https://lore.kernel.org/linux-i3c/ZvrAuOBLgi+HtrPD@lizhi-Precision-Tower-5810/#R

There are discussion on
https://lore.kernel.org/linux-i3c/20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com/T/#m16fa9bb875b0ae9d37c5f6e91f90e375551c6366

Basic back ground is
The current framework is
1. get free i3c dynamic address
2. if found dt have assign-address for such device (identify by PID),
change to such address.

There are problem in current implement.
If device A have assign-address 0xa, device B have assign-address 0xB,
which described at dts file.

If device A is not ready during i3c probe, and device B hotjoin happen,
0xA will assign to device B, so if device A hotjoin later, address 0xA
Can't assign to A because B already use it.

Mirquel's opinion is return address B when B hotjoin by scan dts by PID.

The issue is the controller HCI (i3C standard),

I3C HCI Spec 1.2, sec 6.4.1, when do DAA,  "DAA CMD and dynmatic address"
queue to cmd together.  We don't know PID before DAA CMD. So dynamic
address can NOT get based on PID.

When do DAA in HCI, it needs a dynamtic address firstly before get PID
information.

Consider this need more time to discuss, so split from previous big serial
to avoid prevent other fix patches can't be merged into i3c tree.

This patches's overall design:

1. keep current frame's work flow
2. reserver all address, which assigned in dts.
3. the device with assigned address have high priorioty to get such
address.
4. if all address without assigned by dt are used, use offline devices's
assigned address.

To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de
Cc: bbrezillon@kernel.org
Cc: boris.brezillon@collabora.com
Cc: conor.culhane@silvaco.com
Cc: gregkh@linuxfoundation.org
Cc: imx@lists.linux.dev
Cc: linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: miquel.raynal@bootlin.com
Cc: pthombar@cadence.com
Cc: ravindra.yashvant.shinde@nxp.com

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7:
- see each patch
- Link to v6: https://lore.kernel.org/r/20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com

Changes in v2:
- see each patch
- Link to v1: https://lore.kernel.org/r/20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com

---
Frank Li (3):
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_STATUS_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_DESIRED
      i3c: master: Fix dynamic address leak when 'assigned-address' is present

 drivers/i3c/master.c       | 82 +++++++++++++++++++++++++++++++++-------------
 include/linux/i3c/master.h |  9 +++--
 2 files changed, 67 insertions(+), 24 deletions(-)
---
base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
change-id: 20241001-i3c_dts_assign-d615fc33cc1d

Best regards,
---
Frank Li <Frank.Li@nxp.com>


