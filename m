Return-Path: <linux-kernel+bounces-241102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC169927710
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D4B1F22293
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA671AE864;
	Thu,  4 Jul 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gXCJDmMM"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3921AED56
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099292; cv=fail; b=fMZYGw5muTiwlb0QsBPItS4YA+xNt6gwSrHZKmyIeV8Sf65WKNxOcmz7f2KQaGEF1r7OTE8WS/bewsod8TiKLHwrHRu24ELzMWtz3xsABfaTPZL5Rgt/Vizk6ln/67U1XIwT+bQW0Itm2GOeQM5xaW/GLbUZ+1yAw1LD3BJu990=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099292; c=relaxed/simple;
	bh=DHhLXjxTs+NypUB9/UxERUOxX/LU6zaGoJtJE21AofE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rx2Mg5QpdL12lLsjqZu+DZNbVN65JwbV6nu2+lrxS6Eg0aCq0H85lncAE2B/CJOJWUyVgkIaKMHd4wUWnfafAKP06SXBJKe73o29KS1qxHKnQCRqdN7yqLS3fpWDkfpwq8Wf0iD0ckiYT32RrK2+8S/v/e6iUHL5Fk0rUag67lQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gXCJDmMM; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKc2gnVbfWzChcVdz1MOUzt0RlTlR8wpK6lMZ76VItQTF/sOLBysuziX2XOf2h0eY4xC0/+h5sdyLq2DBYHeqbtyMWDbTWIA2vyLSCWHYr5ds/nY2ufQsHZ9nCi70eT3fPXrgBdms/pheFouKVDCoxFAlPaogqkoCTKOg11tJdraZGeANxSHoUypAa4mIl/03j3Jm2B7CC7OXIjaWvW7/Ofo37UMAY4N68i3kxU+0S/7ngClbIO4mVBw4vgzN9pFhslGaxMx+wGUPBT+xcCSVfedgHeyNgY/JUavGA4zUeZipLpGyCdPL+BejlH8qkWgfSOZDg7yYHgOYrcfHI87vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pualSqx0gdiGLDlFTYGFBmBq39trV+/C9DQoWAo688s=;
 b=ie0YXJX2Bvg4TKelBnye9VZQ0FcISBb1iXosv/lsNZxfdWMV6OoWV2aSo2icI67Ci/BOcRxab93+48GOWR1QH03DZE8oywX7j7sb6QlemTl8aO1DsnviICPkxpDsG9uNA0LkTq5+YnL4j5pl9Xc1lI16jJEWfwmwpxRicG2beinonUMhRiJ/2NO8SblV0w1xf3tgiV3cTUQXSVObBAdhT84SVth3lk7Kr8NHeBkEUpwD8iVtCP8YEyZTYSU4FEPDBEwybL2pkQw0aWFBHaPRu74BkMNM+A2IZjDlfHMG97/YTfDdd8LCUa5zFgzKQQq3dg1ib0B8+454K1X4OsQRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pualSqx0gdiGLDlFTYGFBmBq39trV+/C9DQoWAo688s=;
 b=gXCJDmMM6Fec/egtK4ut1osJw0SucdoHs99IqErtQyx1yOUqc9NcoMi7PI5Mgdpbu30BIxc8zeRhOp7JwRy7U+lg9u+QbZquftvoBkCFdMd9Tk8fewviowbK/3WyizPZttT9BODSRiW6IZ9w94tKARqOr26suf9TstzyWxzO5to=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA2PR04MB10422.eurprd04.prod.outlook.com (2603:10a6:102:417::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 13:21:26 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:21:26 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>
Cc: linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 3/4] mmc: sdhci-esdhc-imx: add option to not change pinctrl state in suspend
Date: Thu,  4 Jul 2024 16:21:15 +0300
Message-ID: <20240704132116.2865864-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704132116.2865864-1-ciprianmarian.costea@oss.nxp.com>
References: <20240704132116.2865864-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA2PR04MB10422:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e41fc90-fb7c-42ed-27c7-08dc9c2c34fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXFHSUtJSE02UTRtTDMxRUZraFo1T1BMWVNaUnZUbk5ZNzhFKzYvUWFsak9z?=
 =?utf-8?B?c0xpOEtCS0ZLbS9YdXFRd09UQlV0RjdLbVJjSGhtV0dqTHVueVJZMWRsdGFS?=
 =?utf-8?B?Tlk2Yml3UGpzcGFlY0R3N0RpbW15TWJ0MDdYaDR0N3RlazdWR25wUXptdVo5?=
 =?utf-8?B?dWMrV0c4SitWRTZTOXJRNS9Uc2hjK0dvdDQyVDU0dFFlSEhqMWNDdGtnSTVn?=
 =?utf-8?B?U0xxTWRFZ0VFSG9URW01dWZrTklFdjJ1TXdyYkkya05ZbzZqUGExbCtSQmxk?=
 =?utf-8?B?VlFGYll0QlVHblQ2Z1RzRzdrblA1ZS96VmRlUlYxdWl1UXRsNGtWRnhaMTEv?=
 =?utf-8?B?QjNBZ3UwemZ3UEt3TktnSS82dmJsWU96Mk8xa09JT0p2SlB2WkpEbVdPazVu?=
 =?utf-8?B?RCtOSzJhM0VRN09uUGc1b3JoOW0yNU81QVdaNDgremVQbVNTNXYySzhLRUxh?=
 =?utf-8?B?bmJUMi9EVGliREw3Wk8ydTZaTi9DQy9yWGEvV0NwSVhKbFRpMElhNWlneWd0?=
 =?utf-8?B?am5jVm85YTN0RlNqV1ArV05JK0tKaEhCSjdxN1FIQUhrU2RQZXd1K2llSFZW?=
 =?utf-8?B?bFVBdHRaMGhFdVJ5SVhSMkRTT1BsK1A0NnErWEdpdGcwYTM1anZZWTY0c0o4?=
 =?utf-8?B?ZDU1Ums0eVNWTkZmN3pER2dQakd1Rmw2eDNEbmR5Wk9QM2ZiRzJhQ3BVcEZL?=
 =?utf-8?B?dzRWTEhIdFc2Vzh3U01NNTNDSGVLSmtxUHVOWEcyNVgraGRrZTRDT2RleklL?=
 =?utf-8?B?b2ZIYU1GZHVQdWtnQ29PbFlwRWVka2pMbEZLSlY0T3RiYnFwVGlEeFh6ZXor?=
 =?utf-8?B?azZ2R0tLdDRURUY2ZVRDNnVjU2ZyWXdHYTBFdUFJM1puaTc2bGhBRStTNnpW?=
 =?utf-8?B?Q2FXY1ZzWmpHOTNtdkJmeSt0ZEkySmlBRzZhOTJaT09jMStYYTZaSmtKR2ww?=
 =?utf-8?B?c0VjYzFIQW5pZ3IzanI5ZmpvL2lDNmp6ZytGUWNITUJOeWJOZXgxYlQzckcx?=
 =?utf-8?B?WEx5ZjJLVGpyT3crVTJGSjZIejRjWW83aUxyalN1OWJHaTlQNFRGUHhaOHg5?=
 =?utf-8?B?L3dUR3VJK043YklvZ2pHVklPZWxBOURXR05wTlp4UzFYVlYzZDIvYWcxYVQ1?=
 =?utf-8?B?WWFaWmhpMWhFRTRtN3djYVlZRGZPMlcxYW5aSzJVdEs0L0FQeVdEYVFGdVdP?=
 =?utf-8?B?dWVCWXlTV3Z3YWRBbTRsb0VxZmh6ZTRYRi9KSGs4QUNwSTR2UENpdUVVOGZ0?=
 =?utf-8?B?bGxCN3ZhKzNrUlMyOElLcmQzUXd1Yks0azBuaVlsb2JXbXJXcmhuY2tQbnJ6?=
 =?utf-8?B?M1FEdGRjNHlXdVFlaklYMlF2enZmTWswZ1VCL1pFKzZrS0xtYmtBcUVUWXpk?=
 =?utf-8?B?NTA4R2pSRWJJT1NXNFlTWElGVTJPM2VKUDJIc0diL2VwcEZWam5BYStVells?=
 =?utf-8?B?OG9tWVo0bjNZdm5SMVJkamRnWndLYzFiamZiKzBRWW5McjJkZmNpZjB1ZGxm?=
 =?utf-8?B?WGlFNHBzLy9WcC9tQ25oZTBSRFZoWFU0djFNNlJjV3BFU1UrVi9laHp1WVRP?=
 =?utf-8?B?QjJGeHZ0TGpzMitzMU5GUmJTZnNHMHBIdktEYnRVTnFwSmx0Tm5MWjNabDJU?=
 =?utf-8?B?eUZtVjJGaVJJcHdsNXdUTEdFQ2JUNTdRaUlvcnlUVUtEbTVjRG9XeXF1K1JB?=
 =?utf-8?B?TVB2VUVGVzdYbU5VbFR5V2FVUEptaHAwZi9IQmEweWozaklDT0hnWSs1R1BF?=
 =?utf-8?B?NnJMR215UCtqS2lMRDB1SE1tRFhGZlVWQzYxd3RxWDl0amRhdncxQ2ZBMHho?=
 =?utf-8?B?VFJReWJqMzdXUGFaMUF0dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkorcWRHOThxbnhCbXNOMWdpUWNYZXU5eFk4cFNmeWJPUG91VFQyMzJFcW5r?=
 =?utf-8?B?YTRVdnZ2ek5hRGRpU0hiYUpDcUJWdDIrMGY4eFFJRDRPUWdobzVlT2dtcllO?=
 =?utf-8?B?cHJ6Y2hEdGxVMWJhMDh2WTRXeHdaSVVHNHdiWjVJZG9nSjhsTmt0MHcvWEhK?=
 =?utf-8?B?c2NrbFpCNTI4Yit4KzRZWXVrVm8vM3JvUURtaXZmWHlMN09IZXFVTFZvK1lS?=
 =?utf-8?B?eWZMbWNFaU9wRE44S3lFcGNiUndwUGtsU1NjUmVMWnFjTlBMR1Yxc3E5MUpt?=
 =?utf-8?B?b2htNExjMlNWK3ZSclhkVnZXTS8zUll1Rko3SmVGSFkvVC90YXN2a2djZ0do?=
 =?utf-8?B?Z0ZicFgwNU13djcvYXVHWEVZaTVDVW8wL2tSQ3FRTllHM1l3ZTYwSE41NFZo?=
 =?utf-8?B?RDJnK2p3UGJlNFJTTlkycWo5aHQ4WVhjM0tEMWpKRVhoWnVYb1l0YmdwS3N6?=
 =?utf-8?B?b2VPbE9JVDNlNEk3OE4zNjNKdEhOY2UybWZ3c3UzSTVRRGpqQ1JyRnJmMUQ1?=
 =?utf-8?B?dk9RNTdYMjk2Q0ZZUE0xOEhxYU5ueVV3bGQxWjgxN1o4MXR4S1o3UWdEbFd1?=
 =?utf-8?B?SUhaaDV4MU9NbTN3RU1TQ1lxK1lkclIwSWhRQXFhNnFmV2FobGkyRlZ2RmN2?=
 =?utf-8?B?R1dYeUM4LytoQVNLYXpTcEIzSlRTV3Q4UEd0emI2YzljaU9yV20yTzJCNU12?=
 =?utf-8?B?YUJhb29QUmQ2T3RwdWFDbXhwejBRenZOeWYwc2tlYzA2dnlWZTYwMUE1UzNx?=
 =?utf-8?B?RHRTOWFQOFBxb0dzZ1dkSjhkRFFmdllkeTBOTEV4NjlLVHpTNTMvNkNWcHpi?=
 =?utf-8?B?emVVcUYxUHlmeTg0ZS9SWWhSU3hNaDN3Y1d4YWNROStBVHhRbSs3RzJreFdK?=
 =?utf-8?B?T2l2YWNSL01zUkZBN0hnc2lDWXE2ZGxwS2lzS0lGV3c3TTFaR2Q3Z0ZBYXda?=
 =?utf-8?B?SDd1T242SUQwNmJGTWtyTVluN0xHYlpDVUZMcXpaY1U0b01lQ0JUN1hVNkJy?=
 =?utf-8?B?eHBNQUZJY0VvWTlWeVpxWC9ScnNsWHFqMTdaTDVNd3o5M203cXUwU1VBUzZa?=
 =?utf-8?B?aWZPak9pcjRRNWN2cnJ0b0I1VmxWSXJScVBLVUx0K2Q0SzU0OTZpVVVrZm5w?=
 =?utf-8?B?N0UxdDh6d3N4eVhmZ0gxTXRVRG1UaXN6dVkzcmxIdElBcmZqZnNUekhNeGU4?=
 =?utf-8?B?MEVlMldHQVZ4TVZmT2RiRm4zVDBsRFhTbG5NWXgzeWdueUwycXRUZm5vbzBY?=
 =?utf-8?B?dnRrcFFPUDArTHZnKzh3Z1R4N2orZ1BpT25qeENYNmxPb3lYRkZ1Wk9IRlpq?=
 =?utf-8?B?eW9oK1ZYeGFNMWRxR1lYRDBWZVB1ZDA3WVRTc2FIOHQ4YmhXVXh2WFZ6S3Zk?=
 =?utf-8?B?eG1hOTloNDBzSzNzdWh1cTdQYzNreWNVQUgrMHgrYkZwSEhzN1RYUmVLZzd0?=
 =?utf-8?B?c2JBSTdzWUZpRmt6MHd5Uko4YWRDMnR0aEVuVkhGK1NPRnRBelk3VUpId0lz?=
 =?utf-8?B?dTBBdkVIYXBlaGhUbmZPTlhUTXhoVzQ0eitnQ1ZzRXRTVXRXUEY0cGNYWC9j?=
 =?utf-8?B?aWszNEtRTndNZWtHdWZNY0ZKdzcwVHAzTEtCYXdJU0JzUENHbGNiV3MwSTdZ?=
 =?utf-8?B?SmV0RFl2UDd2bytJY2NhbTNBUE5rSVcxK25sMUZPZWdxWk1ad0FuTVFXeWYw?=
 =?utf-8?B?MG5JNGFJYmVEMi9ta1cza01zMnJQYTVkTUZTTE5GMGl5cXpsM3c4Z3E1aC9X?=
 =?utf-8?B?TXpoNU5TRDgrWkJ6bi9EZDBSOFg0OXFya3ozTitqQy9RN2YwNXkvb1Y1alNM?=
 =?utf-8?B?bzJ4WkJIVDBEY0xzYmJaZTBHMFhSY3EwN2NlVkxaZnQvUDE5aWZXbDVhTmt1?=
 =?utf-8?B?VU9ERTQ2eU1kWXR4SVQ4OTRFT20wbUJ4VlF6Z3F0c0o3Zy83LzMxcSs1RGht?=
 =?utf-8?B?VHNza2lsLzMrUmNaVXdYT05DZmYvcVFZTGljUjZRRHBKckdMTldWQnBiYWx2?=
 =?utf-8?B?KzhRa2d0Yi9SMjV1dkk0b0FrQnM0RlRUWXpWamd4SmJVSjQ0OUZKOFd0Mllr?=
 =?utf-8?B?NHVjdWp2UFdCMHA3OXdiM29iNk5hOHJhQnh1UWVWUjFCb2ZoQXcrcnZ4ZWUw?=
 =?utf-8?B?OGN3Q2pDOUFSU25BSFlZOVpTYXJ0S0NqNHlaMTUxYTBwZjV3MGZ4UlZDSGxl?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e41fc90-fb7c-42ed-27c7-08dc9c2c34fd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 13:21:26.2563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeAFio8L14y3KPezoaauJSbRPsZGiNaM5r1NNU6Lcft7U+gklvJl1N8Mz7szJOllPioxb9N5Cg8o8FlWyUiIcNe4Nf8m+nxXzWKVfScP9i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10422

On some boards such as S32G based, changing the pinctrl state
in suspend routine may not be supported.

For this scenario the newly introduced flag
'ESDHC_FLAG_SKIP_PINCTRL_SLEEP' is used.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8f0bc6dca2b0..c3ff7fccd051 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -204,6 +204,9 @@
 /* The IP does not have GPIO CD wake capabilities */
 #define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
 
+/* The IP does not support transition to pinctrl sleep state */
+#define ESDHC_FLAG_SKIP_PINCTRL_SLEEP  BIT(19)
+
 enum wp_types {
 	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
 	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
@@ -301,7 +304,8 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
-			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
+			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE
+			| ESDHC_FLAG_SKIP_PINCTRL_SLEEP,
 };
 
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
@@ -1884,9 +1888,11 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = pinctrl_pm_select_sleep_state(dev);
-	if (ret)
-		return ret;
+	if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_PINCTRL_SLEEP)) {
+		ret = pinctrl_pm_select_sleep_state(dev);
+		if (ret)
+			return ret;
+	}
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, true);
 
-- 
2.45.2


