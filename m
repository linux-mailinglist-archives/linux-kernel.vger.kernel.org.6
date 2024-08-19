Return-Path: <linux-kernel+bounces-292449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB272956FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC6F2848DB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C88B16B723;
	Mon, 19 Aug 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y61hzPCY"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC9717332A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083341; cv=fail; b=J8B4mxy/o/NeithIAvt7+obkf60XVHQ2wQL25Cs6uD5ySyIxbZGOq18QQw2hsfPrw6gnPCDvICQ+D9Ph9ditNQVAQiHjoJEWb+huETW4raJ+PGKoznNGmdPsb1xgq9O14Bs+ksYrxxgWNQOZK4KSioagrIH9vkyYEel8E49l6ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083341; c=relaxed/simple;
	bh=nvcmTWDJj+SrtpBzaB8l8keUZ2F8Z2oCpFCzJlzH9us=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QjToahgpBkf79yb5wewKfJdNPwPn9hCkYZdbtjIPP1OTcVYJq6Xl7gRoS6J4Fm3s6AQW8RylKtNR6qQSFOYdzDs0BIrO63qsOKVwrPmNk2NvYhlfuyuGx/TLgq2bWn5dkeYCbqCUYvifpjOomzvNKb7kTUDdOK5pZcyY/Uy+x58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y61hzPCY; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRZUsi/UiARK420EBNqbB4SsChBMTNREhJZZDxv9c9zhcY7cfoPAb0XN0G9eKLkvuEqo48pN/8KkLdut6kY+QVzpc4gluABVIJ3U8rhVSS6GPqC9HIqPJ5MokR4SUi5a1wkrnKDM46ralLwx2e/10EuZ+ydS9ipZEFMrh8ZChAHlX76J6u5sFS/W/qIvQRwcEucCoNiS7bvgyFsQvM9949/yUKltGWuw5mW7/OEd3gq9HeAfgoABwcvC4qgmjawvPmYyF2iMVANgQA8OQ+vBeIGHCMmDfMSU/iIiUQgYz7cV8dx2w5cad5QIg/sk3/AE368dn7MmyhWKUsMBXsPqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk3Sg8K892J5LLK9qnygB0m2WRCfBM/GY0tQ0z2NeDw=;
 b=F8Hg7R2iEOlWCQrQ4xKQ+NSKUaYZ5ItyIQol0SvJbxzdHUqOXK0mwxOBovpUyvpkpE48o+ha5LCOTKQFJOD13Kpf2559SDl0kdPBx7NtqhkkthLBoY7GUkz/cR02pFpiw0IUZl07GLN7y8X4QaGmifBJiuq9DXQulUMBnqHQmWQjk1I3qtXdP9hzuaQ8GMlwv96de5tPs5pS2+ca4exEEXaNBUgH32O5/EZrKZ6ZJocwLCHXowuITW5MMxqXremq79B0UoYyZr8ItKLhMCWIyDjd/QhCRTs0hPTaZYagg1Ny8mThxMvsMO/v0QqBb9qeHHw3LOyngyYWDFAwWVi/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk3Sg8K892J5LLK9qnygB0m2WRCfBM/GY0tQ0z2NeDw=;
 b=Y61hzPCY7DdZu6dPh7EkNDtJ3EGGeS00CmUKTEaIVi2+PDMq4d0Dqg/zFUAJg+CH3n2MlyvGdM/Rw17ZyLPNAUOidUB8iXirDhQqZFB859K/R6n27DWlDRepev/Iyefh0I4ajyf8DWQHllhEV7P8XrjYabYi3Mk8Fs2QWBjVrcZ90hHy7cf7TWYZzNr7U4sziEdtCspvyJqS06O51j5vjuHDy06SWJsorITsTUTuCPgrwXtk2aYs25TND8TWddhldS4lVnJ+aTloGlclCbyRVuz/kbJKGq0zL6OJpajNk3rD7sJPd6lhIB7LO0nHnQ08sZA4dT21Fvfh5Q4STzl7Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9659.eurprd04.prod.outlook.com (2603:10a6:10:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:02:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:02:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 12:01:57 -0400
Subject: [PATCH v3 03/11] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_INIT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-i3c_fix-v3-3-7d69f7b0a05e@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724083326; l=5289;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nvcmTWDJj+SrtpBzaB8l8keUZ2F8Z2oCpFCzJlzH9us=;
 b=ELiX+puj5c7a1rmOAJG04z8hB45bXBVpVH3C6CTavRWD83sSUWHazijgZ05nyDFUViSEmq9f+
 4I87vY0LIYzAFhDQXMdxftWqnxU5faZO88M7QSzBctSk/b+26OHqtdy
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
X-MS-Office365-Filtering-Correlation-Id: f9a7c7fb-bd21-4b49-02c8-08dcc0684b7c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?R2pNU1RNcTN1VlRnZWhldjBZdzhCa3l2dHRQWFpHd3FZSzVabWZidTRVVWZ3?=
 =?utf-8?B?eDdPb3ZmSllnT2Ria3lOaXFzWXhjUzJ1Q2RQam5TTERta09EUXM2V0FwNFJ2?=
 =?utf-8?B?MUhySGYvL2grQituY3ZYWUkvbE9pUStrT0tML0Zqb0lYZkljamVzRU1tK2Yr?=
 =?utf-8?B?cW1yejZmMUlVVDNWRzVCZDBmTjkwc3Z2WTIyNUlpTWlRUGFGMXdLU05CSUlw?=
 =?utf-8?B?aDlWRk5nZU9PRlhnU1dZL2RUV3VSSDJEcnVETHM5aStyakJmbWp1WG5GbzVl?=
 =?utf-8?B?SkZ5YTlsK1JZRllRV0xLK1ZkODd3OEdpeFhPV3hJUGJnTnFjM2Y0eWxNcUdr?=
 =?utf-8?B?OXRKR3hFYy8xRWFINnloOG1xOW50b2V1dCtmbi90dGVKRUhabm5vU3F3S1Bh?=
 =?utf-8?B?cXNxQ1d2TnpveEFoazc1T1RzWWl4blovdmhCcm5icGVXc3krYks5SlRGbTFC?=
 =?utf-8?B?OCsrNGQ1Q1V3TUkvN2NoYUJNcHl6dlcrV1ZGV2VvYm5BUEhJTGxCK3BneEpM?=
 =?utf-8?B?ZUdSRGFlVkw5MFFRcWd0d3dITGJuNjBpcis2cXIyWU9UdFFpTWJOcGd1eTFK?=
 =?utf-8?B?Q3F2MFlZM2M2VGlGUWlGWVNJSGR2K3d5bzhPam5xb0w2TlkzUldNbkQyOGxr?=
 =?utf-8?B?cERPYkJ3VE4vTTkrbDdabTJUalVpYjBMa2toVGpzdjBjOVJZUDFOMEJvZzJC?=
 =?utf-8?B?NFNzRTFYOXoyUmw0Q1ViWkRlVmo2TXJNQ0JKR3BYYTFoVjBheVl1UEhRTFla?=
 =?utf-8?B?eTBBOUpkYjBHRFNlZ2NqbkZ3bC9lY0dUeW1wYnZkYUpPRkZ4cjRUTzZTVHVM?=
 =?utf-8?B?TXRJc1dDaGJXZlZPS1hYLzhLUENxV3A4N2ZtZFRVbmJDYjV3TGQyMXd4UVla?=
 =?utf-8?B?Mnd5RksveVBqNGtmcmZZUUlkMEhtOGNWMzVqOXg3NG91R2NGWVpuUEZob0RN?=
 =?utf-8?B?UGF5aCt4cGFTNkg2dTBsYlpGd3FnQlgyRjFWVHNzSlBVUnY5V0lqdjl0L2Vo?=
 =?utf-8?B?RmNKU1RFSWg0OGcvbFpGbEJDZ3k0cUVjM2FWWHNaZ1RSd1Q2dS9oaTlodnVj?=
 =?utf-8?B?VXVWSVIrZG5Yb2RaSi9TNEN4RmtsenpnaGlyNVB0TEV4WlhKdkhXREozOHJ0?=
 =?utf-8?B?SUxhVklMQ2JUbVd6bjU2aDZ5aWRSOHVZNENtekZ2M3d0VlRBZXJzSm1mWndk?=
 =?utf-8?B?d3RMUmpDNVJxNGcyL2V6TExtRVVHNDJsOEMrRndYQ1JZemFwcFRLcDhVakZo?=
 =?utf-8?B?alh3bFhyS0ZGVnpnUnVPS2h2SFJQdjhZeGVteDlUTlArTnV4ODF0U0ZqVExP?=
 =?utf-8?B?WUlJKzJML291RnNrS3htQkVVK0Q2S0o2S2ozL01xQjF5OXd1Q2hoK3VmZHFx?=
 =?utf-8?B?WGROTzJ1WjFnck9nVytZc0tnejRXaENxNEtOVWg5YllrNVRRaFZuN21MM1RH?=
 =?utf-8?B?b01zdC9wZjcxQzhRMVM5OVhuWmF2a1M3c243S0xITHllT2RKdlRWbENwK1hT?=
 =?utf-8?B?cVJRdy9IenNLVk1tZ1pvNG1FRGJjRHZOUXVURWNRL3VJWnhDTlVsaDVlai84?=
 =?utf-8?B?VGpGN25sTW9WYzFnR252VU1WMEROZlNGM2pObDM2bnlzMjU0c3dDRFF2dXZZ?=
 =?utf-8?B?aFNaLzV1RUp0MUcwdjBQUVhMWW50RGk4YW0yZk0rT1hOcUtubkIycCtneGQv?=
 =?utf-8?B?eXVJQlhyZHBsMERDU2Q2ejdvSVZOOGd5WjZ0dTF4d1VzNUtRU0pJTnRSdGR2?=
 =?utf-8?B?Q3pveXV3U2pGOGZRNkNMeUZFR1ZkNkxXMXlxNkJGc1VhSWR0TFVxRHBhbzBq?=
 =?utf-8?B?SmhHR251S0dIeDZqT1cwYWRVQXRBNzNFa3NYY1FpL2hJWGhaM0tObGN2aGVt?=
 =?utf-8?B?QkNvT1hnQjRtcURzd1JvSTZmOGlvTEJBY3cvRURIVlF1NlE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z2QzWUhxZVpSaTFiS1J0Q0JGb1VnZkVsWDR5MWdLdmJHc0JndXpSRlJWT1FM?=
 =?utf-8?B?Y3ZyeVJiaEpNY2MzSUF6c202WThNSkd3SDEybjJIUzh5N01TY3FsSTFCdk1h?=
 =?utf-8?B?eTd4MGM4TDdlYlFvUXlnUzFQK0M1TjAwMlVMZVZGNHAwRjU4VGJSdnh3K2VM?=
 =?utf-8?B?OVJKSGtqQWtzMXI4dVNqUFpLVEp3Qi85VGpta0QxSnhPYnRJb1UrcHBKMENN?=
 =?utf-8?B?M3NNYzBuV3hyY0IzTUhWRmhTeEE2cjZqcmFBR1NmR3JkaUs0Y3gvOTE3SjU3?=
 =?utf-8?B?a1dSSndhb0RLQk5JOExJQ1ptckhqakN6c0FrWUFXQkpETWJSVVB4c0NIM0ZF?=
 =?utf-8?B?eE1DcW5CQUk0WUFwNjEvYWM3Qlhrek5nVzg0T1UxYmhXdWZTT0FOS0hDRWNx?=
 =?utf-8?B?SlRQNHVtWDNTbzducEdEaW5BUmloSlN0cTFrL2RiakdQaCs4TGp2OHBxQ0NO?=
 =?utf-8?B?RjF6TzJ5K3drN3dBS3FXQ0lwQXFRZFFaNGlpR05QYllIUDlESm01VzBtendK?=
 =?utf-8?B?aXFMTFBlcUo1b2ttTk1iaG9LZHVRTlVFZGhoSytka3kwQytnS0QwSGprT2Qv?=
 =?utf-8?B?K3hMelZqQlQ3VkZONjArbDBnSzd4OUFuZ1A5YkJWVkk5d0NrTjM1YmlhZHl2?=
 =?utf-8?B?dTM3blp6TjJUZEFtVDVVSisxOWdXSVBFL0NLS0hlZFgzT09SZytZVFhpTStt?=
 =?utf-8?B?SGEyQTE5U0VFaFJ5TkpGcTR5S0ZFb0RYcVhtdmYzdFM4U0ZkY3pPN056YmVy?=
 =?utf-8?B?ODNUN0F1NkVVcnRrLzZKQUtVSmRZZXh0VXZTbGZTc0FWS3VvQk5zN2w0S1hZ?=
 =?utf-8?B?V2lVQ3JZdFcyc0pLdFZZWm9tTjhTb2ZYQ3dyanpWL2dUSkp6S3BjQW55NGVV?=
 =?utf-8?B?cnEwdDFNb3hhU1NOOEZTekVsVGV2SXRZSk9QUUtPZGxRWmI2bGxYckVNamR2?=
 =?utf-8?B?WVpWcjVYRVh4eE8vZ0lEZ1BmUmpHd1NkbThhQlRyQytIMVdSS2tiMGxaYkxJ?=
 =?utf-8?B?RWlXUHZMZWpJUmVhK0NITkpJSlRUOFpoN2Fha3o3M0J3SmpNR3lyVS80YjFp?=
 =?utf-8?B?RzJ3WHZUeHloMHJ6WjlETSs4UVFaSGFQSnFCOGs4MVpubDF1aXRLb2kwR1Zs?=
 =?utf-8?B?d2RDSE5qZGNzcFc5UzlUbWNaKytlSlRFSHltVWlKbGpSUk1FUjkzWW9TM2J0?=
 =?utf-8?B?L2N1dkM4azRRd0R2cHBVWWlHZEtIaTJVcHFSY0pnUTArNzg0amt2ZGt4Yjd5?=
 =?utf-8?B?SnJMNVZQbmNhVk1YUHI1VVUvSDZlRVRkWFk2NVNHMGw5MTY3SXlCSzMySnZt?=
 =?utf-8?B?aXdyK3ZpR2N6ZEJrazErY0VWQTNnOXY0dHdjVDVTR29DTGVkdll2Y3pEU1NV?=
 =?utf-8?B?TnROaVEwd3JJZ0pOVkp0RWYwZ2NoeFJlQVhBNG1sMzU1T2NweUZYWTdzWldP?=
 =?utf-8?B?eGdBelp1OHB6Mis4MmV0WTRObENxdUhMemRQZmx5dVhrNUpDSkw5TEJLM0Mr?=
 =?utf-8?B?L2xtZExLWFVDWTBRRytETE9ldHJ5MnVRRUF3WDVQQkVtWFdXQ2w2dEgvUjl4?=
 =?utf-8?B?Mis3RWJlZG9ZWFRVMDUwVExMYjdKWjF6SDBZN3pGM09lRHliam1oS2lzNys1?=
 =?utf-8?B?Vk8xcTJoTzB3ZGEwblpHczdXRDlVNCtSY3VUNWE2b3BHdURjeWl6bXpjT04x?=
 =?utf-8?B?em1IeUpRV2VHSGpBOW5kOHBsOUJPQlhRREFOcmxuMlU3eEhqMzlGYWpzSlpI?=
 =?utf-8?B?VnpBZnNPS3BPNzVBbXNUcHZub0ZBdHBWU0tpK1BiRm9Oa2JNSWRIL1EyR0Rw?=
 =?utf-8?B?ZEkybVFRWXdWQnZiMG1kUUxQQ0ZqcTlNcS93Z2gyRHoyQ3RtTXRpTlBSVzFD?=
 =?utf-8?B?SS9sbUlzTTlDM0N5ZXF6b2luaWJlZmJZYVlBWTF4Qy9XMVVRYnFtMEJNR0ZV?=
 =?utf-8?B?eE5sZmpESVZsS25DeHIvRUFKK0V1UmI2YmZsQmdIYnVpcEd2TGRmaWhVRDkw?=
 =?utf-8?B?NlBZSWtidnlVYUhFMkVYUCtCWjJyT3FHKzJieUJNeHB6bCtpOWdzcGxOWmgx?=
 =?utf-8?B?TEtCSDBqS2dqVTFhczdGdElGRUpmckdlYXR6WmJDU0ZyMlV1bzNkRE1Pd2N6?=
 =?utf-8?Q?5TNd4kAgXoWenoZO5eOdAmqPp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a7c7fb-bd21-4b49-02c8-08dcc0684b7c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:02:15.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6NTMQJNAn+skfnkAXOPDD+Vz9cbW6H076g4axp7SSxnJaugQqEAveTpBvYDpQBn121YlIwZi0BWDAodMdK0PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9659

Extend the address status bit to 4 and introduce the I3C_ADDR_SLOT_EXT_INIT
macro to indicate that a device prefers a specific address. This is
generally set by the 'assigned-address' in the device tree source (dts)
file.

When an i3c device is removed from the bus, the old address status is set
to FREE, allowing other devices to use the address during hotjoin. The
I3C_ADDR_SLOT_EXT_INIT status indicates that an address is preferred by
some devices. The function i3c_bus_get_free_addr() will first attempt to
use unassigned addresses before searching for assigned addresses of devices
that have been removed from the bus, trying to best match the
'assigned-address'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c       | 43 ++++++++++++++++++++++++++++++++++---------
 include/linux/i3c/master.h |  6 +++++-
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 85c737554c940..4281f673e08d8 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -345,7 +345,7 @@ const struct bus_type i3c_bus_type = {
 EXPORT_SYMBOL_GPL(i3c_bus_type);
 
 static enum i3c_addr_slot_status
-i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+i3c_bus_get_addr_slot_status_ext(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
 	int bitpos = addr * I3C_ADDR_SLOT_BITS;
@@ -356,11 +356,17 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 	status = bus->addrslots[bitpos / BITS_PER_LONG];
 	status >>= bitpos % BITS_PER_LONG;
 
-	return status & I3C_ADDR_SLOT_STATUS_MASK;
+	return status & I3C_ADDR_SLOT_EXT_STATUS_MASK;
 }
 
-static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
-					 enum i3c_addr_slot_status status)
+static enum i3c_addr_slot_status
+i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+{
+	return i3c_bus_get_addr_slot_status_ext(bus, addr) & I3C_ADDR_SLOT_STATUS_MASK;
+}
+
+static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u16 addr,
+					      enum i3c_addr_slot_status status, int mask)
 {
 	int bitpos = addr * I3C_ADDR_SLOT_BITS;
 	unsigned long *ptr;
@@ -369,11 +375,22 @@ static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 		return;
 
 	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
-	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
-						(bitpos % BITS_PER_LONG));
+	*ptr &= ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
 	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
 }
 
+static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+					 enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_STATUS_MASK);
+}
+
+static void i3c_bus_set_addr_slot_status_ext(struct i3c_bus *bus, u16 addr,
+					     enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_EXT_STATUS_MASK);
+}
+
 static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
 {
 	enum i3c_addr_slot_status status;
@@ -388,6 +405,14 @@ static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
 	enum i3c_addr_slot_status status;
 	u8 addr;
 
+	/* try find an address, which have not pre-allocated by assigned-address */
+	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status_ext(bus, addr);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
+	/* use pre-allocoated by assigned-address because such device was removed at bus*/
 	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
 		status = i3c_bus_get_addr_slot_status(bus, addr);
 		if (status == I3C_ADDR_SLOT_FREE)
@@ -1906,9 +1931,9 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
-		i3c_bus_set_addr_slot_status(&master->bus,
-					     i3cboardinfo->init_dyn_addr,
-					     I3C_ADDR_SLOT_I3C_DEV);
+		i3c_bus_set_addr_slot_status_ext(&master->bus,
+						 i3cboardinfo->init_dyn_addr,
+						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
 
 		/*
 		 * Only try to create/attach devices that have a static
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 4601b6957f799..c923b76bbc321 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -284,6 +284,8 @@ enum i3c_bus_mode {
  * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
  * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
  * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
+ * @I3C_ADDR_SLOT_EXT_INIT: the bit mask display of addresses is preferred by some devices,
+ *			    such as the "assigned-address" in device tree source (dts).
  *
  * On an I3C bus, addresses are assigned dynamically, and we need to know which
  * addresses are free to use and which ones are already assigned.
@@ -297,9 +299,11 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_I2C_DEV,
 	I3C_ADDR_SLOT_I3C_DEV,
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
+	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
+	I3C_ADDR_SLOT_EXT_INIT = BIT(2),
 };
 
-#define I3C_ADDR_SLOT_BITS 2
+#define I3C_ADDR_SLOT_BITS 4
 
 /**
  * struct i3c_bus - I3C bus object

-- 
2.34.1


