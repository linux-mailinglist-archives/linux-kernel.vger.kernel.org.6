Return-Path: <linux-kernel+bounces-528478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE729A41816
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB701890B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FF3242927;
	Mon, 24 Feb 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FRARJhhU"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035D0192B95;
	Mon, 24 Feb 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387926; cv=fail; b=QG3OYVHmmboHB+8inRRmWbRKGbIifB32MAQegU5/KCUhvmR+hSohg/wMJeDZEC0/zHPqhw8UFYeTrzARWDJMVguY7ciVuwbFFxhD0e7glMJMWg87Pmoq4xJGn8RNqDUCtszSCKpjaD2pgyxy0YP2jojlLJvRDC+FnOyx4KeEVUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387926; c=relaxed/simple;
	bh=6eU5rz1VtR4YcB/G5pRbGak5CxlUkEKltQxv2dwIR/I=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pKj5Zq5k2+T/yPOlJ2eS/WmC8zhnq2aVCXE3d+svztDyyffoWaKz3eD9SSD8A/Md7uBAMUxHuuRwcm4A7APWwjisUJRL+rVzucqDKOEqSEyttu3ciVq+NsL8Nu7XhxwJZuZIBB5qkqVKSoScsT9a3rVXU4QJBwqLwwlwNZx83lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FRARJhhU; arc=fail smtp.client-ip=40.107.249.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGjJhau6Bt+QxCUZim6kXa8loxiIB5W8XDyFLDzP1dWZ8H+3ZqDCh8tjBzcOykxMhlQp/Bahm9dpAnWjW4CPQ201oQMNM4f/tFqXYDEIglXPIQkmAnShO3DDpCs94NlbSWAKFRdkFKVFVodDYGYKyisg/tojAGkHLRzlocaQuNE4IUGpeQRzxXWaUCl/W8Te10ukR5V5eDNpzSOEEXLAn2O1LRpXnjXy6UiWDnN2XUqIoSph55LxLVyYSzAOJlOQvou9T6/YNXtH55yP3kOSqhxk7RhDQTT+PXix7CZ+gbMHJ/0JZnO1wflOgyCLmWyDA74sr69PRPzJp4HfgcEzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLHelfl+Lu3KpW393HVp4ZNILaggRW8zbTrGp0b2xms=;
 b=cIBMSN/aPmMydwQXZzDbDJFqPyEoNWPmzevyDnFzaF7+w5gJfmmadPDvtuTEcJ583AHSEkZeuX8K6ahlbcvWzaTphuQ5cqh/kuoF79gNMU3caYG4kpkJ1etC2IHHIbvCx98VkbDuaSU7Z4vpdtSwK9GtIWp5ObkpkBiosyWMj8V2FDx2YPh9ldW4j+8roPsalhZZKWKg4cl7HFYq3nuuX1I/FaqrEU7/QLfrOMgd/909WOK1WlHuNxEPOkFUzFFih385U75iC0Arw04XLfyUjSnq7TrGyFpvkntkBSU4/Pr6uAc6JkAJucaNi/IJg7Nqh0lNZknGLIu6MV2WZli77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLHelfl+Lu3KpW393HVp4ZNILaggRW8zbTrGp0b2xms=;
 b=FRARJhhUNP3IIYg4SlPvv36HeYPxeuOMDVDbndlKfs+5ynO9KxplsCkYLA8Ctvb++YZxfCXLG+QNDOe4sXXpQASLv3MaSz8Zzz0OtqtBdJmgM1j1TgwsxsQAtSJaFOmqGKYt0EyxwVbzGx2XTyh4fqtJF89galK5MMJtECGHQYtcCvxsjKovi/bgLQK73hDj+VS9Udj20A8f7xFeAdqwqhkGG9ZzLRBr2w1lxyuaFDAFPizrmontanwYE/H/+g/9qOoGvOnKVHU2MmvA3g0j4CRke0sEGKQDqBjd8xLQSXozlReHzhG0jMZgJkhZUOv3U3SgSUBv8Sdb4g9MbCSLyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by GVXPR04MB10706.eurprd04.prod.outlook.com (2603:10a6:150:219::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 09:05:21 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 09:05:19 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH 0/2] ASoC: dt-bindings: fsl: Reference common DAI properties
Date: Mon, 24 Feb 2025 17:04:11 +0800
Message-Id: <20250224090413.727911-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|GVXPR04MB10706:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d2dd77-79ba-4773-e517-08dd54b25c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bAPBklr9gVV/I1XK8m+FXHqvwC2jdAWSUxNQkGOlMjTHJEU6nWqt6lOSzgzd?=
 =?us-ascii?Q?0mRWb7bCBnc0yLB0Gw4fBxm7SdqCJhYwGliV5DNaWBoo149RKijm2I6sqbyp?=
 =?us-ascii?Q?EUfWgIrk8473Qw9wWi8syEBghxjT58y09O5Zc73ysgQXYZihPZymmz2BtRgo?=
 =?us-ascii?Q?2ohYGKaBkEZnzUDdr39hrRq04kY9f9QQImE41DzVxpVKjlmGoBcmzGMmR/XT?=
 =?us-ascii?Q?dWGbgfb/ObJCt4bWXwZOh752isJeerGLr6J3RRH0wPMXVCIbAY014Ll9Dosk?=
 =?us-ascii?Q?E0kVDgVD02imWPP9+CC4ntuLiGuS/tsXvygE0jJ6cTTibfA88PDy85e6IUzL?=
 =?us-ascii?Q?nuilKQMc7iaotlnVUBz82oLT1NWGiGDMM9F7ng46eAx5l/KtbSDQ+4buFv38?=
 =?us-ascii?Q?gynp7/eaQMj/JC//yFjzqA3gpZ7kpT704DufD/5FOe6L1JrIZ8gJbkyABzYY?=
 =?us-ascii?Q?ECcs8dzHZLgJIwvZAbZJhcOinGQLPNsxBdW7rNSvpwhJR6a7HiFtg+qOt3r9?=
 =?us-ascii?Q?4Pq3RD8EYw/5lPw6JYWWtVVPdlnbArvHOvy8efVADZXBfrAPRkUib9kJzhZJ?=
 =?us-ascii?Q?iLGySRBX4Xm69B5DeHBsqSbd9MJRSmzShm8G5LABQRagm8aNO+z8Ba8h5raH?=
 =?us-ascii?Q?2aoTG2vT2hRtp6By9LfdxtS0DKWdxWxB8o0n1pmVBUg2t/WWtKQp3jGUOEva?=
 =?us-ascii?Q?b8+dJPMUQcPuM3dehychjCryP2aFNIjHtjyzWctMg4Ug4c5Qqlm8Gc10NewK?=
 =?us-ascii?Q?RqvwGzD5kCfgteIK4h16/PGP2Vn58456xyzzGcQbHHgLRdiqdE8fp93rzOoe?=
 =?us-ascii?Q?DduMeHtdWRNcq/16GQyDb5wytpqA4R1Y4UEEjNRAcSn/sIbu1NE6aUvhBfOb?=
 =?us-ascii?Q?5VpvYMhtSbJCktGwX/bE9MdFavrkz2UgdkooSBbBIWNzhjcIxtNQuU7rkLGQ?=
 =?us-ascii?Q?74Hg+OJTJYy0rxsvlUseISSYwgDry7lVj+yHr77OXQWibuPeU+Pj5uGBWUlb?=
 =?us-ascii?Q?qberzte16TTCaiyl3ipTGETPaKGOlj5cLcRG6c0+5HaDt6iIhpQ8PWyQZeIv?=
 =?us-ascii?Q?EzTAXGqvEbmWBlWOmol8N7qEReKQjuszP49vV/wsC6tpKSvfBqRsOkAgoahS?=
 =?us-ascii?Q?rRscOBBRgWSbtaV7SAHAqvwKVUT7N4phe7UEzsLpA1dAI7mWr4EEooddvTMS?=
 =?us-ascii?Q?6q/hWA5aE81P7GmfetijfVxPI906SLSHQA+kHdKJnmcZmPh4juuE12g6OTK7?=
 =?us-ascii?Q?gd+7H4hvpybf3lPAO8mSqKleAvtgRonaDqXX0Bmb+BzuweXmWtI9uJio8MTb?=
 =?us-ascii?Q?vDi3Mb/VB11sAHKIg1RfNgVgOcD75uAHgYyvY9rtoHGGwnJmI30iXemFcw3N?=
 =?us-ascii?Q?ipabo33xRPL6ky3xs89nK1LjpO68zXYFm3KsbqxN3ZQAwLnqINF+povVcA4s?=
 =?us-ascii?Q?/UFDWL3OjZtopmfXkuk5aNdcNMBDH9Xj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jGNUC0m+zFY63V9hs50Y4n4D5Oxw9H742sy74jTfhtSOljN0av/uK18SFacL?=
 =?us-ascii?Q?qK3/38q/BEuz4kzQYnX2F86Xp7u06CZmo2dkuzuohksIq4sTepkAc9voG36D?=
 =?us-ascii?Q?OyxCt7bGE6ASeOqWJQZJBeFqNIVZ2xPKsQjvzXme7tX4LFnAeJBeFhkWVR9e?=
 =?us-ascii?Q?imVCUQ1FhRW6sn+41hmlQES2dHrw2K6PI/gj59u0hxfzAraJiVMP6TLPrhbp?=
 =?us-ascii?Q?g3dpdvUuRvP+CH052mp1ITfWDUSzBFabbLb1p5JLoIVlUbysgotS5hzWKy4s?=
 =?us-ascii?Q?GP2eUVlnnDQmjXaIEG4Y10nn9XxHOf+Eii2to8Q5aUqnm6lcIGoIn4/+vGxk?=
 =?us-ascii?Q?D5TuZMR8bJ6eBD+3/aLF/tkUtn3hVlRUtuc6OOAtKhYSDb3yWgvlsn0tR1h4?=
 =?us-ascii?Q?Db0IaxUT0BPd+lCEw4A+u6H39iwnnzJ7xvJ1O/vsXNcAKgE6Zy+J0AeEL3WD?=
 =?us-ascii?Q?VA2mLiG8lOFqxibetnHypx1+HUPkHIpgB6qQvkDL/dOf+eQejPcvNhpWlIsB?=
 =?us-ascii?Q?lSrXPq5hU+at8nQGVDgXpXTwiocoVgXHtq9VraiXtv4sqy+4eCnfp8LviCul?=
 =?us-ascii?Q?dCQGofqwunAHjSmjmz2EdrW5/0MMrKv9gnGsrByN0AcPuwN9O/Pvk8xdff93?=
 =?us-ascii?Q?iMOyUOj7MOwRaIFy/GohURv4nxZehk/q2BqSihRwSSvE7RMe64nZHBGIAlNH?=
 =?us-ascii?Q?DBvKkG1G8jCZ6gBv0ceJAr0i7AjdUa1Q2JgPfs7yUfdicVP4BT7pCyUea9Jv?=
 =?us-ascii?Q?q2/QKqoiAg/TfK4PUMP1F+8tqUp5xdLpRukV/GOLCYyQHERZqB9SFHbQQBiB?=
 =?us-ascii?Q?WcLE//01TLoPXzHwofwei4hbBCIL3qOZ5ybCRSZSxPW7GUTdb0hxqo3Y4vYH?=
 =?us-ascii?Q?rURpbfqeqWZPFbBtsntkpmTxkhr7m5qS8OjZEx69dQGrJ99Nn5Km+vjzFDiQ?=
 =?us-ascii?Q?uVYg77usB8TNmaUmcIzSroncj1hj7OVTFMDXBif65IMiL2XKIilRwOZLdK0K?=
 =?us-ascii?Q?3tkwpFFm4Gm/YCPwUlhYr65alyDC92IfvCuY16FCTk+T+sww+Mr1V3Jl988O?=
 =?us-ascii?Q?69QqK+HndLxkWjdxzzH0wygMgbwv89hL2xhfBksazDw+9I4vGrdqDt9MneKb?=
 =?us-ascii?Q?UiUk819MW6uO36BtCv5vBtIXz8L/1sWG+WqfUhh3Pf0goTe0JYChAoSWwdz4?=
 =?us-ascii?Q?rKdcdiDp+sWczSX6ZAdONw5ZJQ2JifDeUclCJBLa1OmJqqhXZ8JjcXwhtVFH?=
 =?us-ascii?Q?NNEklx9VbuDxQqhi/a/yFpURVV25SayEvYjT/gh2iq6znISiiEVM5fOfxfdL?=
 =?us-ascii?Q?SRL3uNYgOk3dw4sM3Tfd+soDYzG+/9nVVMP82iiM5E8LDY0m4XRH9Dp3x/nl?=
 =?us-ascii?Q?5i1EgW01m97rzSCDrE2F7xUUD2HHVmB6Ebgbd8y+LHNb/kYL9PMZSYYuJr7T?=
 =?us-ascii?Q?VlEW4H16sLGXUXFgMIPwE5lNs6vID4n+WOv0w0Rpy5aehKybDT+XA+ElQ1bs?=
 =?us-ascii?Q?T279Gr0KcmhASqrDXLT7XjzKETXj2R/izvXM0GVFdPeko9qm2Qkt7kxfvdSo?=
 =?us-ascii?Q?dI+P4rhYGn5A3uNqUdG5YwXLWF76GWNPv8kI81nY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d2dd77-79ba-4773-e517-08dd54b25c74
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 09:05:19.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zr9fFYLerOV0UI+Y6oIBWMhYMIyJOnoLMlr6MnPnpfsbTOQMZ9sO6plnKDzNcx/wC4zm9JFKETH+v/fgvAejBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10706

Reference common DAI properties for fsl,easrc and fsl,imx-asrc

Shengjiu Wang (2):
  ASoC: dt-bindings: fsl,easrc: Reference common DAI properties
  ASoC: dt-bindings: fsl,imx-asrc: Reference common DAI properties

 Documentation/devicetree/bindings/sound/fsl,easrc.yaml    | 5 ++++-
 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.34.1


