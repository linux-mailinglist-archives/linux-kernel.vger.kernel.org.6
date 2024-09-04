Return-Path: <linux-kernel+bounces-315451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8004A96C2DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4930B24FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D351E00BF;
	Wed,  4 Sep 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iQid8nrh"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68611DFE15;
	Wed,  4 Sep 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464971; cv=fail; b=AewFmZNbQ7T6FLfFs4AquGT3xvs3fkTuQCjj728Zf/jwRuKrddYvSjrF37jNyLaczD1xzQp6vSE6h0AQhfgN0cP0fedH3VSUEA5jjzPi7qiqwyJ7ZyeBx9UR3VLkmrT0xNeMeS34g/uTELEu8wNyTjwCEI6d0xVhcvAmrh+H4Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464971; c=relaxed/simple;
	bh=bNmRD3PplE6Pnb33HULOjgrM5HKmNcIatQzFsHXI4QE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=d/Sca4SIyEy2ex116UUeqmNoyzlP+tbrnYKCEGtM1tTisbxe2qAreA5hGiSptZX1vwR+uuhk8ZHCvY6aNX0hHkJWju1ysKxMgTpbXY7tR0JbXExQ8vL7pf906kHyNvEDlt+sDLmmBPjeCTr6mun8P8mYSZCKIsTkS2wKA3K6tqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iQid8nrh; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU4TpDtZxEFyoiLds8ipkSiq4k21ifExXl+8nH6f3/M5H/ExRntvKlkl+Z4RgejlVermchcPCn0SUpLKd0FfCwjK/ftK+QknulGsxpJWabLLwEfhpq1Yl95CXpkKgYQPk6rhAjAC8raj3SPSmyQw1X0sbl000eeiN6brVAvZ73JvYVfmIwxZvZD08zzatXO0Tus4aIX7NLFrQxEJ+jmlNTOd/7+La06gpct+VSIwcQszo65fs3fRWK8ai44s+lSKgxjBgXWiP0XvnvjKnPsETmOM3w0H/+MPz/VszP6XhEmdu/Ie2XcqhGOeF8hGAsOY0yJUN9GUKVI20km96jX+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZduGx+TLlh75toxe5f0tW0RgZ4kHMWhWW7zm7w1ZBg=;
 b=WRwE5E1xdvniW/ZWN6NYTOi67EV2oYc1KijzgPgB9ITwLQ/8ZUfsEZZ6Qi9HbxRxJNVN/5QMO3m0eW106H3eavdoug89yffi0Ojwr9EYLyWGxUoWS8zSciM3aiZU+kr3pb4kiqoBoshHchWmim/DpXlh6F55iT7BI4tJFhXzVKYnXd94iIzk63pqs3H8SaqDsS4TNQF3mxe8MSgiVXSxLbj4jhgF+ZpN5rmwvCr2QHyhcAtNIz+iR9NZ/nppfE5dHdaGBPXMqYxQ/buo2Lhxcuw4WbB1Nhavx5roR9DIXxMUHt41V3HBW2a0E8vRlsuRJWiHTnVpH0BSPXFOEcNyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZduGx+TLlh75toxe5f0tW0RgZ4kHMWhWW7zm7w1ZBg=;
 b=iQid8nrhE5X/rhT9RXYqLYHhWtMQZVDJOaJomXeMDof+3KUqqPGSz+MHmH9orQnD21kPeBxDdZN/y0H1zLAGF9Xc9VvCqPAluS41aWleK0cJro6ddZGYmFK72dPJ6aPBNiHc+9/ueTkE/LACcHw1HVCJaxO9wQx89lTg5HkfhCQHtLv2v2r9pn+Beq8az2WFMUo1QdhaRJLeJa1172iJBoyJMvoKKHnwcq8/nq+YLJx895KeNcpc9Yh2lr3DZPOBa8DsmQcwjRintLdNEAEl9ZrT5mec/bU9cwwYkGLYHIzWGGvCoQA4aY4n7s86c0SJsNsyqNFOhrpP8i5TtFNTlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9859.eurprd04.prod.outlook.com (2603:10a6:800:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 15:49:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:49:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/3] usb: imx8mp: collect some improvement
Date: Wed, 04 Sep 2024 11:49:01 -0400
Message-Id: <20240904-dwc-mp-v3-0-319947736ec0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG6B2GYC/0WNQQ6CMBBFr0JmbQ0dWhBW3sO4gGGQLoCmNRVDu
 LuFBFm+n3lvFvDsDHuokgUcB+PNNEbILglQX48vFqaNDJiiSgspRfshMVjRSp0rZtJFIyEeW8e
 dmffQ4xm5N/49ue/eDXJbjwQeiSBFKrDUrElxxlTex9leaRpgCwQ8pRv+/wbcpBrLJq81YadOa
 V3XH5O29kfPAAAA
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725464962; l=1428;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bNmRD3PplE6Pnb33HULOjgrM5HKmNcIatQzFsHXI4QE=;
 b=sdxFvN6I1yTQYBJxhvHPicVkSKeHIY0mVsKLd175MF885B7zLm7zJ7uoUlFKlzNS5OeGBHvfF
 GQpmmnogPYmBxeigOCwKyDVyquxqltpCNX2y8syc9R22wDa6N6/VfxG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: c9153ccd-9e0f-4ebb-02e9-08dcccf9270f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjJNV3Y0dmhuUHJlTWVaZXBqbm5KR3ljNnpHVGdmVHJmUjZ2cHlrem9pdmNH?=
 =?utf-8?B?N3c2eEVNWGJwcU1LcDFYU3lKQjhGK3ZtY0RtVnpwRHdySVdqU3d3MDlGajdv?=
 =?utf-8?B?SGo1ZzFqSjNXdm5ic3lnMG1sRnJlK1ZJR1lqR0lBQW1yZVJZR3Y2U0FNSXFn?=
 =?utf-8?B?S0ozK2xPMVZzcDd3bEtkb2w4UFRwVjQyYnAraVZORERUVGhlL0JKZU0yNjM3?=
 =?utf-8?B?S3VNY3dWN2lzRjRPNXhUY1lOelR0a09ydEdmTVduSXdVd0kzTEhXN0s2VWN1?=
 =?utf-8?B?VFNkc3IweURHNndjR3E3YlZIcG9KbWdqRDBsQjhxVTZOeURRQmtqSVZreVh5?=
 =?utf-8?B?Nk5GYkZiOGF4TVRpZ1lkRFdSN2R2M3ZERXN6MFV0WTF0SWkwOE8wVHBlYVha?=
 =?utf-8?B?ZmNNR2VUV3RXcmFxMHdZLzExelNFNGRrT1JSYzQ0Q3dPU3hCVjJkUTNnSUYv?=
 =?utf-8?B?c1kwU2dQY2JhTEFVWkoweTB0M2RUbk14MWorbzgwTHYwenVjR2FkQXQyRU1u?=
 =?utf-8?B?WFQ2Y1lTRWpwUS9uUFBEdTVZYjUzbXl5Rms3Tm94T0JDbWNmVlYvc3RTRjdJ?=
 =?utf-8?B?eU04bzU1RzIzVFNJa3cvbUo4M056R2NQcEg3c2dWY3B2Q0VlWEZ0RTgvdmdu?=
 =?utf-8?B?dEJSaWlMQUw4NzVkVGJ0YmVvSGt4bjBseGlmV2h4OGNlR015dlJlTnZTZUgy?=
 =?utf-8?B?NzlnbnZnWnNRaFdqVElPTHk5eXRCRFB4VkJpSG1pSUxDRW9kVFJoYVlScEo4?=
 =?utf-8?B?NkFoQjdKWVcvNTFpYWhXUEdVUnhxdkcrZi9oeW0rU0U3czRUckxXT3U2WnVV?=
 =?utf-8?B?b1R0a3hpQytxT0JkNnRkbmlXckkxa0w3QU90Z1NEWlorc0VnaVE4dGxTdjV4?=
 =?utf-8?B?TjF2UmZFdjVxS3JyNGhzZlR0NGg4T1N4eTBYY29hTldVTUR0ZnFPdkhnOC9U?=
 =?utf-8?B?YlJPdmVSNFdWUDFuQUQyZGtMM3B4bHVzMVVFeGNkQkppRnlJQXIxaWxzeWhR?=
 =?utf-8?B?cEFpQ3YxeGc3SHhEaDFJRS9QZE94djA0NnorYnZEcDZSK0xJSmxLbFRkaHVM?=
 =?utf-8?B?TytmZ2xybTg3amNMV0pSck9pSVNlQWs5VDNmOEMrN0xiYnl0em11dkhVNUpV?=
 =?utf-8?B?SVpGZVZrYlRwVkFKcDkyazdqWjhHeUFnUHdrbnpoY3M1aXVBZEQ4bmY4dDBq?=
 =?utf-8?B?c2taMFRZSDFRY2N4aGd3RmMvVmFTRnV3RHVkN2w2WE82c2N0bUh2VTdGZERp?=
 =?utf-8?B?a3ZNcFhJR29kOWZTc2pkeUdGNGljSDg1ZlZSOGhlb0U0ZWZtZGkxaDNncGpU?=
 =?utf-8?B?Y0dJbjBrbXhZNENZN3pMVXJpa3RuUGFNejJzV3Q1S0FmNlAwSVV2Q0pnNTI2?=
 =?utf-8?B?OXgxeWVyTXJwQ2hST2p0NXFwMUcrS0orSk9LTklhRG9yaERDQU83Mng0TE5j?=
 =?utf-8?B?OW5qbTNUNExzODhLalpodDhCK3ZYVFZibXBxaHlXb0NwQlhZRnNMb2ZjZVNN?=
 =?utf-8?B?NzFRb2ZrRnYvRlZzQUlEOTlya00va3J5YnBvbUNUeXZLR1p1T251SVVXbG9s?=
 =?utf-8?B?azhDM3FpMFlMN25lN2RwNkpEZ0dXbmJmTldiUTBTYmQrYnRuWGltSm9seTlI?=
 =?utf-8?B?bGx6aVpOaUljbnpwMXZHZjhpRHRTZjA0cVB1K0hsZkVBcG9qWktLUVZvcmFE?=
 =?utf-8?B?ZGdZRWVXc2hHbVNtOTBOdG5jVEdXVG0xbi8wZzRjajJVZ1VGdEVrUW12a1dl?=
 =?utf-8?B?UDBFSnpkY1VNZk42aVN4a3lMbi9PbVdEcWgrZENkcjBpSG4vMG1nOGFybmo0?=
 =?utf-8?B?SFJjM2gycXIybUVDRyt1NGJLa3Z4RG5xL1RhdENxbFA3WXhjTXRKSit3S0Z5?=
 =?utf-8?B?R1JiWkJPNHROZDZTU0MvU2M1QXlDZE9tTnFsdWFDWFpNVWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDdabkxQdjFHOUJ0ZzhZY0FTc0NJUlYyeG9RMnk3bGxuOXo1eDhnd2Z6K243?=
 =?utf-8?B?NTNqS3RCRk1PODVGZ1FXbUUwbEVpYndPTVBQM0t3ZjJNZC9kTzBRY3djQ2ta?=
 =?utf-8?B?ZG81N21vdXV4UzE5MmV2Wm05S0oxUWFCRTVTbDNoMnJuNlFNT3BiMGw3NWZI?=
 =?utf-8?B?OFh3ZU84ajdDNmlqZnprd2RYdXluWWd2NE1lbkxoZm9tQXBycXJ3QjFiV29G?=
 =?utf-8?B?TlAwVHk4eklHWmNueUZjSi8xblVFQ2VsWE1CbStadEdKbVJ1dHpJQ2VUWkk2?=
 =?utf-8?B?QXlTM0kwN0FicnB0bW5jVDRHclNtdkR6OTJZR295dzkxMEU0WkNsZ2srajBl?=
 =?utf-8?B?SXhBUEdhT1JuQUF1UUg4N1Y4WCtHeWE2MjdLYkgwTEZQL1VjQVlxQk9sM0li?=
 =?utf-8?B?dDF0UmY1WGgwTUpBVmRGdzNOenh1cmoyLzJXVndnOHZmMFZGSHdpYTFPZlZl?=
 =?utf-8?B?VkJBU0liekRXQzFlUW8wWVMrL2twR1l1d1oyMjdKRm02bmtObEszL3JmR3Y4?=
 =?utf-8?B?WmlIOGNxYzlMREV3SzFQOXRDcDBHamNrcWVrYWgrdis3bWkwYW5TcGVEQm1B?=
 =?utf-8?B?aExRUEZYTWdQaEJXYTE1RVErbUg1TGptV3IzSHhCVWdZRzNmRXJmdDNyVjM1?=
 =?utf-8?B?QVUrdkRLZTRqRnFmVDNvelVTTmhzWnpXelp4ZFNZdVJieTNXNXdhNzM3SDlI?=
 =?utf-8?B?WEh5N0ZUOHAwN1JNM2ZsUlk2ajNFVTVOcGsxKzZmQkFmdml3L1VWK2ozUEZI?=
 =?utf-8?B?Q2lWaE16Wkc4eGZEZ2FWQ05yU3loUTUzemx5cFBqTzRLQ0xjK1FEc3pYRUtT?=
 =?utf-8?B?L3RVYStIVkVPdTFUclorNkdQeDEreE5adEQreUg0RFZOS1Q3VFB3R2VKcFBl?=
 =?utf-8?B?MVUvU1VnK0JkOTJGL3lEenV5b2ZnalFwMkZIT0hrcXc1QmgwRDVPZnBoYTVj?=
 =?utf-8?B?OHhKa1ROeXNsblhLS2kxRjVyWkNoYms4L2IyZUVyakJBL053MEowV0ttR0F4?=
 =?utf-8?B?azJ0SjY5dXgyZjUwc2pMbjN4Tk1CVHNGUmdWUnZ2NEl0dzdoZ29mMGhyQ1Vm?=
 =?utf-8?B?ampJbWlWWW5jck9zdERRTUtBT0hjcGd3TmUzUXR5RjdCWXNHNE96QnN0T1NH?=
 =?utf-8?B?bjAzT0NWc3gyOUtzYlVWTlBmRmdhYWprV0liMG1WOTk4NHpleC83UEdyVG00?=
 =?utf-8?B?c0lNK2dEVGRvc3RoUlZRdTFNUUIyd2VENEtpWlZYTWZmSkQvMDhwMGcvbFhW?=
 =?utf-8?B?SUVEeEFUZVdZWkdFQWMrMkhpeHFydk9IUCtvWWVKZ0IyOU9yMzhiVGFVUlVB?=
 =?utf-8?B?cGgvR0hjamRXUm11YTRiSDRISEZPNEZNc3hsb3JJYnNLSDMvMHlrdlc5L3o4?=
 =?utf-8?B?bSt0Y3FRODRNMmYzTG1KeTBKb1M5LzhSTkZiQjBWdExibFlaVzJ0eWJ4MHZv?=
 =?utf-8?B?QnVaNVZpU29tSHlMb1FEOVRnRkVYZWlMRitGbkIxUWIvVWliaklsbytBVytO?=
 =?utf-8?B?c1FZTnNjVG5BaWlBMStKWkdxMS9TVHlGdXZ4VDNEZk8rVEpNS3dQTHB4OU5B?=
 =?utf-8?B?TWNFYlV6aDEwQlhlNndaMzJldCswWG51UDJsZ0hONDV4dmdxUnQ1SjRJNjRh?=
 =?utf-8?B?OXh2YWhWZlhzSmFET3phTGZhOGl1YTd6bFRSUlVPMTU2T1dpSjY4Y0M4Wmpk?=
 =?utf-8?B?QzFFUHpid2VJYXcwYkljRXhqK2dlc2RFaG02cnFjR2d6RlZOVUc5ZTIzYVll?=
 =?utf-8?B?WXZvUWFTVGVnMHpEcER4S0hZbkU5K056dFBpanFCang2emV3WHlsVlM1ZkQy?=
 =?utf-8?B?ZnJYL0pjVDBqbitVaVhPMC8zK3B4S2gyMk1DeitFcW41M3R6cHZEdTUrelVI?=
 =?utf-8?B?bllqNHloZWIzcjVvZkZPcXZvRUhoZmZieVhhYkJjWnNDcHBlQjRuMm5Sb0U0?=
 =?utf-8?B?QnVVUktSVmRwWkt0a3pKMUwybk1TWnVTYXVyRXNiMGFFMi9rOEVzVFRjN2pZ?=
 =?utf-8?B?bHdrakR5aHRGZ1ZJRnFqbUM3cFpiMldQSmJJYkxYTitNYWFpU0lJUENJK2M4?=
 =?utf-8?B?WENjSEYyRUs1MTBDZ29TZ3M2M1dwbnpEVFpOeXo0alBTNXNtLzExWjgzV1Ns?=
 =?utf-8?Q?XpIZk+FK1i1i+I0aFzcAZcoOK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9153ccd-9e0f-4ebb-02e9-08dcccf9270f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:49:25.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpVDhn3Uty47hnleT5bJqw7nhV9CQn17uSE7r4KFXDnEn45PkW1zfHuIiw0bQiSC8D2YnR2MbMnNjJaBan430g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9859

Apply two quirk for imx8mp dwc3 host controller:
 usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk
 usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode

Runtime pm and wakeup:
  usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- see each patch
- Link to v2: https://lore.kernel.org/r/20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com

Changes in v2:
- Remove patch dwc3: core: add a core init flag for device mode resume
The problem can't reproduce in latest kernel. pm_runtime_get() in irq
handle return false because run time pm already disabled at
device_suspend_late(). So runtime_resume will not happen before system
resume.
- Link to v1: https://lore.kernel.org/r/20240712-dwc-mp-v1-0-295e5c4e3ec9@nxp.com

---
Frank Li (2):
      usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk
      usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode

Li Jun (1):
      usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep

 drivers/usb/dwc3/dwc3-imx8mp.c | 33 +++++++++++++++++++++++++++------
 drivers/usb/host/xhci-plat.c   |  6 ++++++
 2 files changed, 33 insertions(+), 6 deletions(-)
---
base-commit: fdadd93817f124fd0ea6ef251d4a1068b7feceba
change-id: 20240711-dwc-mp-d1564eec57b1

Best regards,
---
Frank Li <Frank.Li@nxp.com>


