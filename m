Return-Path: <linux-kernel+bounces-204911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2A78FF4E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A10528A10C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6141D71B20;
	Thu,  6 Jun 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TtEHHK+U"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1F6E61B;
	Thu,  6 Jun 2024 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699651; cv=fail; b=TsBLcaSZo4QLvc6y6FiMCBvCYynxx7/NWUkKfT9nS+RJaPsW/f4PDVE8KeBGBBV3SAxUsF2viZkDZWoY+8QGkE8O8ZDh3jXYNGzqFqr9brfAQmOaR2WYRLcjqeuEPtP9+EEtLLQXLMthLUJ6CKcLCWrgu5F0UyxPEPrpEz5cszE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699651; c=relaxed/simple;
	bh=wwKcCvjh2THnjztvtf5usgNLOblQQHq2amLNdLYCtOs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DJrd4E9GWoX2Z4w8tOQCK4KkmjpB9+EGcoAnqLBl/p1kbZVOetExBNMo6ZfZKZdqQJBfo2lm+k5G4JUsbgDebz41MVd/k0l+jp+ufrteFENp8sW1ICsG+S9NS9lmbdoAcXnuQgcTqc1CMxozhqK0FbHSWM5F9AUSRfnjzQuq+bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TtEHHK+U; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGqXryzBOh531w5M84BEAVOlb3bPxHSZZY1yOC+/R13b5h3LmzUHQvhl+Nx3wc5wgNbAlv0CG0a5NGozGDjUoollRn5QiCploOp98Usxa4AIHxoT3WUBniXGRThLRN6aPAPjwPZirdFEoZ5mKugXIqhynSC7aUp3YEIPaJZZ1WTuAP5MNwL+7VWj1ZPynUb52MYNRXKxeMGgHO2CsEsrbSiu9LLjL1hKxyHbDPMIGZgArXpXh3tJihWWQzUDB2NN/tf9H15LID/XTom45xS0Wc1bCqqzdlWHNzytB0I6UGqWPzNQN8km9lQEAQse6zjAAxbTplj1L1Qwloyc6+IS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56NK9IpX14FIl5PU7gRV4JOyVKj0mweZ1H5dCNIAhW0=;
 b=oGNgUd6on/O9dfj14WAoFRFcRAEdMcqTw0etWxaUbzFQSee9DmuvacGy4Z2BzsmPrWW4zYtzc8Vic7CyOA/sy58woSVeW+Uzq5oUn6bVpQZn0ldVHEJVYYla+fdbLZhquI0SWc7JwKOC25RAPk/FZQRY8uI2Vth1NPBOFbV2u+4eNPUZldSyfi6ZDYVmWxAsP2c5Cb/zHM5C9iyBVPnmNufdhjfjBUtJ7cugzW+Y6L1OBNJE8aMpGwAaMpBjBSNxs1+hzJGYJ3KUJ7irAHPOtcR4aUnv3LzK95OJd7YzeK+2aMIzb9jUJF4UFXadudvtt9/igExkX97GdgpOZcoxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56NK9IpX14FIl5PU7gRV4JOyVKj0mweZ1H5dCNIAhW0=;
 b=TtEHHK+U2jhfcZEp6fsm+bBjqcNpA0+AZxtCEp+YwIAYRVePCEmFTxIQI/tm92Wzum4I8XvX3GMJdiuJfbJr6gDEzE6RKLzygR3jKBlAkfZGXKP4YB1jIUHzoTZkwes7qDGazAiVP8K3U6HZm4t4+lwsxhYrNZI9mk02rsZWqZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 18:47:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 18:47:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Jun 2024 14:46:57 -0400
Subject: [PATCH 3/7] arm64: dts: imx8qm-mek: add cm4 remote-proc and
 related memory region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-imx8qm-dts-usb-v1-3-565721b64f25@nxp.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717699632; l=2911;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wwKcCvjh2THnjztvtf5usgNLOblQQHq2amLNdLYCtOs=;
 b=6Ek7lGsQxrwVbD8FmiSjG0D+3yFqQsiPjw7AvyWJw3jxhNHen/as8EfWBq6iPHqHC+EJitDIY
 0Keb9jVBqNJCJkRuxcM3BqdoWNIkQFeu7rcnx4k2uKQxvRSYc0uYYZZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: b433ea6f-0fbd-42bf-b031-08dc86591ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N24wMmpscHhuaTJyWW91em9nY3lBdVF4eGFxWnE0SXJPSDRidjJHMjlqR3Qw?=
 =?utf-8?B?bWJXZ2E5aGJLTWVOaVFvRWRPYzB6cWdJNHhNdGE1Ui9UeThuVEUzR3J2NEhn?=
 =?utf-8?B?eGI4Y1RQNVBhR3ROU08vS1dieG9tVEtvSUlCZU9GL0F4QjV0RUtkbmRxNHlU?=
 =?utf-8?B?Z0plS1JGTlFBMllzNTZOQmppMjZWMzZPTkY4ZERPM01HYXQxdVpzZkN2UElv?=
 =?utf-8?B?d3B4cmtjeGxrQzVuOWtENFdhV1JvT1NVaVNMYXF0aU9rR1kzbUhMZ3lRcWFx?=
 =?utf-8?B?WVN5M253ZnVBbzMyQ2lyUUk3WWlGbUFFeWFpdVJVVnluR2FIczRUK05YanFh?=
 =?utf-8?B?eFhIdFNkN1J0NmVnNkpmYlh1S3VMWXFQMERBU2s1eFIxblRQUW1XcGt1czRJ?=
 =?utf-8?B?YjYxazNtdXlHVkNxc3JqSWZxY284T1ZOY0Y5TTdyS3BhVTVSS0wySVpEM1Zq?=
 =?utf-8?B?WWpORWg1Y0hNRUorMGdxN0dpR2p0MzRNMXlmb3pTRUVkRDNmQWRlWVJGM0hK?=
 =?utf-8?B?cm1ZNElOdUNPTzZCcllxUlZ4R0FwaDlhemx0ZzdXM3UyLzRPa2V2NnppNmF1?=
 =?utf-8?B?eC9JVjl1OC9xaWxIVDQ1Q2REU3hqc3VvenpOSFRyMzFHQzVtWEJjbzYwMlJu?=
 =?utf-8?B?UkQrM1hjQVpaTlFJMVUwWTFwb0NQNSs0L2YyR3FKcXgwVkhXTWhPY1h6ZUxr?=
 =?utf-8?B?bFpzZmpxU2pnUThpWUN0YWdLMkRqUERCd21JSDhvUUFtVy9oa1FRY2tMeFp5?=
 =?utf-8?B?aExWSmFYYWdKN2NydjhmTHNEOXE0Kytqc2JiT3lJOWVseHdhdmIvYmo4Z3Bt?=
 =?utf-8?B?MSt3YjNra2NvQ1d2bCs5TkVodXU3V01RWjRGRW11YjNCa1JwRGtxQzd4VnBa?=
 =?utf-8?B?MVVBbjJ5ZWpFbHc3L3ZBR1UxN2pnaGR3SXI3WTE0S3psa0l6RjlTVVErQmhO?=
 =?utf-8?B?Y0dQRTUxMFpJUXFtd04yNldFQUo5Wlg5enBITHlSUm9qRUV2SGUyWGpaWDNS?=
 =?utf-8?B?ZDY3NiswMjByc0lDaHNWaXBpNHREQjhXSy9ldERkNUUzTS9reTRnN1czYUZw?=
 =?utf-8?B?bDZiOVJjbGZldUJUMVBIM0JKZE5RZHNjRmg2cjdlalNzTG9MejlQSTdkd3Br?=
 =?utf-8?B?OWdkN2hZVlpDeVFubHdOQVJiK3RjSG1QZWlJTzd3cXIzcG5NcWUxRGZJbHZD?=
 =?utf-8?B?Z25EbGVJWk9adnlhbTN5YWw0QkNIYTRIZVE1bXVoTEx5anVVbnR5bUhwMjl4?=
 =?utf-8?B?cVdkaDJ2aHNCS1BQRk52aFRNWW5hbHdlcXFzN1ZCUjNKbE1GNE1tWUV1ZnVU?=
 =?utf-8?B?SWd4YlhNWURreWkrWjlKYWF1Qk5hVnVBcXROeVRLNWFSUksrUUJnYncvNkdx?=
 =?utf-8?B?cW1nNW5EZjhuQjFGR2xvZ0lheHNmaHFPR0owcTE2VUs3RmI5eklBcys2OGEy?=
 =?utf-8?B?NlRINlZKZHVFb1hQZm9hazNZOVN6VHRhcjlHTFovS2RXWVAxcGVpNEZydXVE?=
 =?utf-8?B?bEQzdzc1ekVKaGVMYjNFWFBpT0hQYW0ybUhQMG9jSHU0UFh1SVFDZVdpME1Z?=
 =?utf-8?B?WktnRTAzTTJBY0QxcHp4ZmNJWmFya1NoRlNkZm5KTGJPSVhDNXpUNURTZXJ2?=
 =?utf-8?B?ZlJkRTlVLzlmZEUwQXJKL1BVMGNHcmw0cnN5QTNOb2w3MzdFSzVGK0RjVnB2?=
 =?utf-8?B?ckFaMjA2VHNSSWJtaGVuSHdML0JZejZMSjhCM1M3akJVL3FFNkV4MldmQ3ZR?=
 =?utf-8?B?eW1tRnFac0J5Qy8rODJhblNDTS9nb0F0OUpxRTZCSUVwRkFZYlRvNFAvcGo4?=
 =?utf-8?Q?1F8C2To/eRtnuOKu+LkB01G+x5NlRPXkmmJGY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWNqc3JPS000Sy9wQXVlR1Jzc1ZGWG5QZ3dvMzl6eXFVdUQvOWNHUS9EUTE0?=
 =?utf-8?B?TURUTS84NFdqaDlqM3I4OGR2NC9uWHJYWE5vNGtzVHZ0TFNybWVJOGZ2UDMy?=
 =?utf-8?B?RCszRHpSYjFlbW1HNE1jYzkydEZ1QmFTZ3MyQnFXdlM2Z1JEUm9vaGhMY1Vy?=
 =?utf-8?B?Sko5RUVkUTJGRHFkNGhlZmZiQmRzTjJNRVdRU29TNTllU2pWVFphL240Kzdx?=
 =?utf-8?B?M25PYVNKd3hHSzY0aUJUa2VtRkhrenc3WWhtRVB5UTlMc2dyanNPbm1vNHhD?=
 =?utf-8?B?ZUtQMDhDRTlOYmFjUnVXYUdDRzUyK3M5SlRYdFBaWnVrUWRNNHdqUndmWm5s?=
 =?utf-8?B?b3A1c3FyRzc3V2xVTlpPUVNVbVpRSmtDNm5CK2VZS0prRzBPeHl5TVFJeXho?=
 =?utf-8?B?eGZnTUdnQ2MydDZEUDhNV1RNT21yM25zQXQzRGVMN1BxcWVvM28yU3RwNzdL?=
 =?utf-8?B?MVJzVE9vWEhEeUltNTBDbURzdUNqQW1Ic0RaUys5clh5RzVhZXdkRlpIQmlh?=
 =?utf-8?B?c0RFeVdhMkZ6K1dNeFdJU1JkaVNjdStlQUZyaU9TUmZycnh6YWkrVFI0aWg3?=
 =?utf-8?B?dk1MNXdDODJRZzNGa0k3ZGFhTkF3OVhVUGk2TWxTV2NRTFRmZnhYZGZ4MG5Y?=
 =?utf-8?B?c2sxNktoNjNNOFpQZFBmQUY0VUY2bmY4Wis3QzVqb0IyOWxtdStoYUUzR2RX?=
 =?utf-8?B?UklvVDBGaWU1L0FqN1RST1pLeUhCS0RzUW93U1ZuQVErN3M4Si9XdklIbkxZ?=
 =?utf-8?B?cVNpek5qMEs0aFZJdkxuOWlxNmNpMWNNMUpTdjVpdGFhWFJaMFZKV2c5Q2sw?=
 =?utf-8?B?bzdYRnAvM0QzL1lTajBKMUFIN0owR1oxSnoxNm9HbnR0Q0dpMlQxRWptOUZh?=
 =?utf-8?B?R1J6TlNqTWRkSEwvWVNXSkJrSjhTWndCM1pEQzc2c2VSUHNXekxFSE9BT3hK?=
 =?utf-8?B?dXprZXpPaldUSnFXTnNwRGNBMERsMW1CSUwvY1FuYndYWFR5UDl0NStoZ3JS?=
 =?utf-8?B?ampzUUpjdWtzZWlLTjBOZkVpNmpObHBscnhHTlNXR3FRVmpXRXRNR0tBY0tY?=
 =?utf-8?B?UjhZNks3U2hqYzdCeC9SRS9wZmc5TEtYWTlhVEVFT0xybTdqSjBBdkNJTThC?=
 =?utf-8?B?WFBGenp3QkMwQXRiY1laTkp1TUdLQnpQcCtRY3JWbEZRbkxmNGJaT3lObmwx?=
 =?utf-8?B?N1lCY3pFRzc3R3lUc052dWhHRG9SVHZ4enBkaXF3cHB1YkRMMStWTGNrVTAv?=
 =?utf-8?B?a05mMng4R3ZLZjFnaktRUjk0c25pUVI4RDZSR0Y3QVBaeUdrajE0V0MvblFR?=
 =?utf-8?B?WTVBMzU5cEhFbThxbFdjT1l1K3VuZ1d1WkdmaU1XQWtzdURjU3ZiUHhjajIr?=
 =?utf-8?B?ZCtKeHlKUXJNdW9MN2Z4NG1EMGR0U2c2SSsrS3hZVzY3T045c2Y5WFpwWExY?=
 =?utf-8?B?dGVoeENhNmN0QnY0S0psRnBCZWVBeDRVSkJJUEIwdGx0cndmemgzWFEyaGxh?=
 =?utf-8?B?SlVIbUtuWTNzMTNVQ3BZbHc2MFZkTmppMDQrZ2piR0J2YWR0bEZCTmx0K2hp?=
 =?utf-8?B?NWFQWEcrSU9XWFJNVVFIRXZ0UW1QYXhqRFNucXRKSTQxb1RUT095cFpzOHpa?=
 =?utf-8?B?OVFEdzdSMUlYNERPY0RjMWl2aVNUT1piSXNVV05NcHJVcFA5MVphWTdCOVoy?=
 =?utf-8?B?WnhxZS9HN1pIbmwvOTdJTnpLRGZYZmZkdHJNN1pvYlg4RGFpQXFEdkNFS05z?=
 =?utf-8?B?SndIQkpNcXFNT2FKYzBxWnMxSVJFejZBdnZYcHR1VnlubWVlVDhKTm44Z2x1?=
 =?utf-8?B?MktINmcyYU1sUFAzWTJDUGt4ZUpJUmlyOWxDKzJZN01qWkhtTGRBTmxXeGV5?=
 =?utf-8?B?TWVpNmMwTVNsa012N3dFdFRxeTM1TktFMUJZYkgrYlI4aVY2dGdBY3VlVGVZ?=
 =?utf-8?B?WGdVZ0FOeWFOclBvSG56SW80dEFDWityUDJGNkc2MFRhaWYwdmVQTmExS09D?=
 =?utf-8?B?L1VzWW5kaGc5dDBqT3FWdXBFa0NEQUx6eGtxcTFYR3JCbXVSdmU4TDBTNmhu?=
 =?utf-8?B?dDNxWVlFOEc1UlNtRlpiRVk2TVFFWHNCd1A1SFNLZmFhTjBIRDZ1UmpyakZp?=
 =?utf-8?Q?4sxKgKlc+RurQyMFgwaAyQjAL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b433ea6f-0fbd-42bf-b031-08dc86591ba6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:47:25.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovQ/7dHKmSWORTwpzt+WTfvIudfejZdoF45aWnD8u2Q6EIsm3HT/sPX01fPAF/DepgknyYosL1+ErgPZiD3eYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069

Add two cm4 remote-proc and related memory regions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 93 ++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index c024be33fbcce..dbd478af2e474 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -31,6 +31,68 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		vdev0vring0: memory@90000000 {
+			reg = <0 0x90000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: memory@90008000 {
+			reg = <0 0x90008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: memory@90010000 {
+			reg = <0 0x90010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: memory@90018000 {
+			reg = <0 0x90018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table0: memory@900ff000 {
+			reg = <0 0x900ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: memory {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90400000 0 0x100000>;
+			no-map;
+		};
+
+		vdev2vring0: memory@90100000 {
+			reg = <0 0x90100000 0 0x8000>;
+			no-map;
+		};
+
+		vdev2vring1: memory@90108000 {
+			reg = <0 0x90108000 0 0x8000>;
+			no-map;
+		};
+
+		vdev3vring0: memory@90110000 {
+			reg = <0 0x90110000 0 0x8000>;
+			no-map;
+		};
+
+		vdev3vring1: memory@90118000 {
+			reg = <0 0x90118000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table1: memory@901ff000 {
+			reg = <0 0x901ff000 0 0x1000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -133,6 +195,37 @@ sound-wm8960 {
 				"LINPUT1", "Mic Jack",
 				"Mic Jack", "MICB";
 	};
+
+	imx8qm-cm4-0 {
+		compatible = "fsl,imx8qm-cm4";
+		clocks = <&clk_dummy>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu5 0 1
+			  &lsio_mu5 1 1
+			  &lsio_mu5 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table0>;
+		power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;
+
+		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
+		fsl,entry-address = <0x34fe0000>;
+	};
+
+	imx8qm-cm4-1 {
+		compatible = "fsl,imx8qm-cm4";
+		clocks = <&clk_dummy>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu6 0 1
+			  &lsio_mu6 1 1
+			  &lsio_mu6 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev2vring0>, <&vdev2vring1>,
+				<&vdev3vring0>, <&vdev3vring1>, <&rsc_table1>;
+		power-domains = <&pd IMX_SC_R_M4_1_PID0>, <&pd IMX_SC_R_M4_1_MU_1A>;
+
+		fsl,resource-id = <IMX_SC_R_M4_1_PID0>;
+		fsl,entry-address = <0x38fe0000>;
+	};
+
 };
 
 &adc0 {

-- 
2.34.1


