Return-Path: <linux-kernel+bounces-308719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DCF9660D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B1E1F22D71
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26DC192D6C;
	Fri, 30 Aug 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JCYxv9KC"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A907017DE1A;
	Fri, 30 Aug 2024 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017639; cv=fail; b=XBbeXiFllAmDZmqWWqG6cNl7Qps2q1N8s9D5Amj/jF4+pB2SBh8o3TADlzsS75VpWxmiiTvrtp8Byb7b0iSCtAcVOJC2xKCeDhvxSPMsrEmLXpNJ343MrliIcvamsXe0jDN+N4n1hktsDok9nikhbm3DLFTjCX8O3NODuZIfBoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017639; c=relaxed/simple;
	bh=WPRO2okk4tTPpEkz0n/ODNdxDh153Uvmb59tM1AyaIY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OATUXjEb4ts6jJGUkgllE2Ma00ks8OXmJrgD39sZnqDgPQBfI3P9qf5ujr3wBwEB0dRNo+znVkc9h4+yxT4tpVftTH48renu2zQGRRT1MylNE8Ss8/+WMdwf5xpthmUtjLt57dtMxGRLz6mqcurZ21yr5HFyCsE3uwlPdXcYx5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JCYxv9KC; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akcn7Gww7vr/viceXh+WDHd3MJdraw+IRlxJXrQkbbZdxFD/+E1NP7sgS+XZwO4Vecs7RncYQ8gXYJNPhUUv9CVmdA8j2l2gUEU4dHs/qmBvNyxTbvWbFQuZ1OPH0elGitBkoHgc3/QtK05aDzJtEIS2M5MQIZ6AXM1mYUxfo9n7nRY6T73+OnAq/piHpL3chMHCt9k0EchIbu2aNfaZvCvorRHhcG+VTZv9pR56lLkxr8EeyqDPEgkeD3XXJqfKyfg1eMcb9Rn7ymg5Iji98GDpazYueQd6/KYO/rqkWC5WMTsmLtS10nPzlmyIHt1Ry684KwHY40A3NwN8ndG0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC15+Rb4u95VrIsR3H23t6uVNwVTtMbSXu/Vbhq6MSE=;
 b=f5QwfU6r+Wnldjb91HkA6dTew70UBkrQQ4gGNAxARrnszHTZ0JtN1xfEa9I7y4DxD155rMVq/aaHgRBYdJnP6KQTNc+ynUVnSMH9M5ec7neSONE2ZDhjjTw48ubZd/6hIeQrARioKkpb5zqfCY7wVCAD0w/4hHQvCIaAE2A9AGJFxtGvinQwqvI7pvRBZl8qRZC5ob3dEakkv5DCzNmlF540bkPPZE8ZBZ4JhvQOagsFPSnm1XFh/QKYzfU6JO4gPzy0GKrcD3ck1SpTKdom5dZLX2xv2Q9We7h9oQ83BnFxNqn1I14Tlzlt6+VUJhOzLUa0ucG1sWkyp8ojdol3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC15+Rb4u95VrIsR3H23t6uVNwVTtMbSXu/Vbhq6MSE=;
 b=JCYxv9KC7JrNNHp/IMKjagN5vwvwM1Nxa8img/NmkL+BA4HVkWokpQkeO5gEFxz0kHQB747lMxquRN7Ii+BUD2LXFUbNVNydEMFSFslvXhkWL1TcjZU2TxSC+XxKWkc43eaMOAYx1TydVygZ87rgMDxhhM9TcByYBXSBSYMrP+jg8xIABtNDd4zxikmClVrlp9u3TFjg+2f7jOIlLaFq86skpI0VZkMX7umgUQFcVUyBZteDGpI2WtDi7pNDagRv9H38qnCPE/n9gNq3AeREQ88DMkcgHFT1sRAxcM8BSt/g7Za7J8RVXmcLfi0YMziWyyU89gpo3tEdq66imOu1mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 11:33:52 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 11:33:52 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v2 0/2] add S32G2/S32G3 uSDHC pinmux
Date: Fri, 30 Aug 2024 14:33:45 +0300
Message-ID: <20240830113347.4048370-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: c6af252e-dbd9-45d0-81d4-08dcc8e79f8e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHJUaHFFOEs4bTM4bE44Qm1kUWNLbUk1Vlp3RmZzTVhuSXhWenZYeU1LK3Y4?=
 =?utf-8?B?bVgyWGxMQjJqZWxXVk1BbGpDaEc5S2RLNm5LQ1dXeVphVEk1WTlNc1BzR0FF?=
 =?utf-8?B?d2phc1BiTTJLVFJwc053RjRlNTlBbkNUUnlWR3dzdTNMNFZ3aFhXb1FZaXli?=
 =?utf-8?B?VlIxYTBxQzlhdVVET0VEazE3TU9jT01ZNElocjRFZ2NjU1d4RStpSTkrc3Uz?=
 =?utf-8?B?WkREKy8rcDFWN0VpOWpTNml2b2NyQ2VIUEJSRUN4M2NpcXp6c2liL3FyZ1Fz?=
 =?utf-8?B?QnZwakVlSTNIOW96LzEwT2JzdyszTUxtMGRCTk5TNTRtUm1uNVVoVE4wdE5x?=
 =?utf-8?B?S25OUEw1ZElPbjE2THdZcllTYVd1OVlpZWdOMFZQcEVKUG1ZR3VkZWRlU2dj?=
 =?utf-8?B?bTF1b0xTUHhKd1o1QzExOExnVHhqSzIrSU9kOTdneXBaQUd3TXVkSWtKVWNG?=
 =?utf-8?B?Z2MzRGlHME9OS3V5bXRXRk1xdUYxMGs4SGVBNS9oYW9lSVQ2czRyOW52YmtV?=
 =?utf-8?B?WlA5bVZoMVhCbG1vZVczQitwZDYyNXJmWTVxNlRWMGU3eEJjWi9QOTlRT1Zu?=
 =?utf-8?B?dFBnNGNXcDdmL1RuMnJKRW5PSkJwbElpVWdjQml6cWI4T1BDTUh2dGpjVDFu?=
 =?utf-8?B?aWZNVjM4T3hwbk5udVJPRWd5aEtyVWNYRnNXUGdRM1paYUIxQm96YkhkZWR4?=
 =?utf-8?B?WDNmVFNXYURxNmlkbk1oNGxjYTJ6UmhMS3RRSitZMUtNVHFmYThUNUd0MkM5?=
 =?utf-8?B?V3dRTWNSOHR0ZEJXcEdnNGI1WEprbU9RTjBaQm9RRUNHWUkrV1hyR1NmUmJJ?=
 =?utf-8?B?c2JpTjhQZ0FBcVh5VzlrM0FtQ2xVbEJtWjEyZ01hcUt3ZXphZGFzdlNEUDdj?=
 =?utf-8?B?bXd5ZlA2TVdlODdtSFRHbGtuMDNXQnRGdFA2L1VmSjlKTi9uY0pwVTdGcDBj?=
 =?utf-8?B?SzNMYWpZWXJSS3ZNV0t1MFJjKzByeUFOb2pPOFN6bnM3QkpaYUZMSGRiNVdw?=
 =?utf-8?B?U0ZESEdLTDdyRnFrc2JXTnRXaEl4cWlsaEVObnorTXBCRUd6SnNYNlY0TnZz?=
 =?utf-8?B?YlhGSDdwMTBtdUZxZUFYbXA5VW1DSFQ0cGVjUWdMZnFySDVuUGRnQ2JZQW5i?=
 =?utf-8?B?Y3Rvai9OOFB6YzBML0lDTFVSSy9yZ2pLTktMck9zT1d2dDl2VHA5OGR4VFVz?=
 =?utf-8?B?U3doVDg2RFRuTDhQaEdyUS8yR255NmJzbGhsVW9sUFpjd3NySWNoWHhwWXp2?=
 =?utf-8?B?cnliWHE0akxPWHJpeFVBMDRYc29QMFJtbTZRdGpRVHpUb2NvR3dKVCtEZVhj?=
 =?utf-8?B?S1JTZEVsUXN4Vkozb0xmZzExbDR2L3BGSG9UZEJrRW5wZkJpZFMxRnZKSUVk?=
 =?utf-8?B?bE9oMVowRWhzcE1tMWRGVXdJRUlBL212K1FlSVI5dVJpQ20wRko0LzB4dXZT?=
 =?utf-8?B?c0d6UUxFL1JKN1d4cFdaUE9jOTRycGsxUXRWL1piYjd2Q0tRTHptRkZ5Y1pv?=
 =?utf-8?B?MUZWVDhUWnFONko2U1ZlU240dy81Q3pOdi9JdXVScTQvYjVwU1IxSHZ5M3lo?=
 =?utf-8?B?V0Jjc2FYSzgwK2pmR2ZqajMzM2pEcjRCNndLb3Q4RXNMRUxZTlBMNkZ2RFhz?=
 =?utf-8?B?ZkljS0ZyTEh2TkxDYi9DdFl1TnhZOGlxcDc3K1d0NkdST3BlVjlDcDZwVlRw?=
 =?utf-8?B?SnpIN1dGWXp4UlVrMlM1dVgycHZ1bmJrTzMzTVlTaUFyQTF2TGxVOFFzdHdP?=
 =?utf-8?B?NEhWNVVBMkZ6UStwMVBoYVdrZnA5MkJyZXRLblN0bGNxN0kwc2gxVUxzNWdh?=
 =?utf-8?B?dXE4b0lpWFB5Yk9xYUs4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U29OVWx5dFlha1dUdXpGRTQ0MWVkcXhjaXhOWDJrdzRlN1pndXMxOWlJM284?=
 =?utf-8?B?ODJrWmpwclRNZTYzMjViVzIxOHZncGFsRFVrOFRvSW92dnA3VmpabzFwdlc3?=
 =?utf-8?B?WHBDdVVjOHFkV3M4ZG5wcXRhT3BNM2RIS3AyV3ZPL1RwSjBVcTNkNHNZVDRu?=
 =?utf-8?B?a0hHNmhiY1JJekxIb1lRckprS1NjUHo4aFJPcE5naDRUU0NYbmJqSVltL3NE?=
 =?utf-8?B?MldIZlBoVUd0a3ZHMzZteENwMEpheFVVSTh5V083S05uOFVDSjlrWS9lVVg1?=
 =?utf-8?B?eEJrVmMrdUtNNUluVDBIWjh1VVVTc28xT21KNFBBeEtaa0xaQm5QQ0NHYlIy?=
 =?utf-8?B?dzhkQ0ZoQVEyVEJzZzhobmxueDdQMk5FWHBwUGNFNzFFekRoSUZXQzliL1FR?=
 =?utf-8?B?UysxMDhxLzd3SmtxajlSMENCcFdJaVhMYUxreENKSmpiWHFFZkxIZ2RKdFJk?=
 =?utf-8?B?bGd4RVcybnZmdUJrMHNtVms5VmlieWZ1MkVRRS9xcURPaEFRdnRxQjJUUWJo?=
 =?utf-8?B?emhkZW9lR1Vmd0FZR09tSk1wMm5vVGpjK1dZTlFxVGpaZzB0UFJyemp2WUlu?=
 =?utf-8?B?Q29TaS8vMEE3dEtBVFVDVG4yNUF0MEwzUUtlNzBGOXNnd3dTVjlxN0gwTUoy?=
 =?utf-8?B?WFo5ZEF4Wk5qNW9IVTJ4WC9XUmlEdWZiWFE4bWxWenB3ODZMUFZXTVh6aDRL?=
 =?utf-8?B?c0kwT05hSmhsejZPUGMrbmU5R2pzMXBGa1VnTUw5NmtTL1JhMmpvclBHeXpy?=
 =?utf-8?B?TndFR3BmZnpwVWhnY1ZZK041MStmbDBOdE9GQURPNjJnSEszZXhOQlU1NjNX?=
 =?utf-8?B?VGc4RWJKeGN3a2NPSHdoMnV0ZWp1UjcwcWdSdWt1K1l1M3FmR29ieTNldzAy?=
 =?utf-8?B?TzZnaXljY09hdFUxRnpTUGFZNExtZkRqblRBWUt3VW5UVDAzR0VMV3NybVRr?=
 =?utf-8?B?THlkUmUxczM0L3dUWXlvb0RTcDZkZEJBek1jS0YvaFg2SzhGd1V0SjJSaE9L?=
 =?utf-8?B?T2dBSk5waWx5dlIwZ2NjQ3lEejRUbEtHTUtLdEVvS3pRUGpQSTBueUpwakEz?=
 =?utf-8?B?dkpiY2dtUVA2RmZ1VGdMa2R4MitGdGt4QzhEZ01RQnJOUVk4aEI5QU8yQ09G?=
 =?utf-8?B?UW8xQk9aejBWYWtqa05oTG9WZDNDU2kydE8vRjNpVm1WVThZT2hERHJ1Z2pa?=
 =?utf-8?B?NVdlUzdlTXFBY2RPRW5nRjRtd2lOT05jYXVpM1B5c0JpS0tUdkRid0dZZkpU?=
 =?utf-8?B?ZmlBRTZxakpKYm1CcjJFZG1oUDlkdmd1NjhjNWVPaDJaTk9IMUJkU3lTVkty?=
 =?utf-8?B?ZE5Mc2NtUXhQMVZnblptMGlKWUhqUk5TcDZqWUNIUHpsa0NjQ3h6RXlhRldt?=
 =?utf-8?B?cFQvMHNJeWVSVWJIWGt5bHdINFA3ekQweU50Wlc0SG05OUlHcGR5ajhobk5w?=
 =?utf-8?B?Ty9ic1hadGMrczNIa0ZOZTkxQk9Wbm9pcWMrM2lhWXl3bFdBTnNvWnYzMTM3?=
 =?utf-8?B?Zy9rQVJhRkdLNzIrdUQ1UW1FMGJaSDBmTGRqdk5pSjZwTys2TllOYWh5aGJh?=
 =?utf-8?B?dWhoTVRjcXg2dEp0UmQ0elg1N3VRWUZHT1JMTzdSK2s5OHBzOHRkNlpzdkp0?=
 =?utf-8?B?UzFQa1pVUm83NzVtSHY0YjU0WVFpNTltSm9QNSs4emxiNU1yRHY2ZE1FRW5W?=
 =?utf-8?B?ZDJFa0JtMFpFcDBrcjFoOFNBKzZxK1l2QjMwWkVPanFwRkpRWVh6cEJUeTVG?=
 =?utf-8?B?VDFEcThRajJxdUcyQlh5RFVESVFDZElvL0NSVjJiVDI5QXBJM3Uwc1llbE5L?=
 =?utf-8?B?c09Hcm1qTGN3QWJyOUJFWWNoalh2SlYvL0dVRDB2dzNMRzd1UjlDMlc3SjFC?=
 =?utf-8?B?TUVEeVNza2d2ck4wRkxtcjhtOWRrczVYcUtNTEYyTGp1cDg5cXF0UE53VXRG?=
 =?utf-8?B?Nzh2NnplRWdSK05CN0tXZUNVVGNYb3JKTFFLK0EwNEdqYk5YQU1nSThjSW9C?=
 =?utf-8?B?SmVvZWlvOVZib29zMHlGZi9hWktOUENxeVMvS3c3aExTa0YranV6L1JCNWxO?=
 =?utf-8?B?VGYzMHVpOS9RdGlhRVJoaGlva0ZjamJDYThFbXFZdmxXL3dXOWNaZ3VHS05n?=
 =?utf-8?B?czlxc0hINDZBNWNsQzNCRnRQSmNkSFZ3L043Nk0wWnlBMTN1ckxQMzVLOFBZ?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6af252e-dbd9-45d0-81d4-08dcc8e79f8e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 11:33:52.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhymTK3RQUX+JIqte903JqRQ+bnkC6KF+Qu5NJUYWHlr2O2mDpb5jiaMOzkiYFTEl9lZKmrfdeolSDUuIMyVYU5/vo4saf4crJas1C1srcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

This patchset adds 100mhz & 200mhz pinmux support for uSDHC.
Hence, UHS modes would be supported on NXP boards which enable
usage of VCCQ voltage supply @1.8V by default, with no additional
hardware (board) changes required, such as S32G399A-RDB3.

Changes in V2:
- Added patch for disablement of UHS modes for NXP boards
where VCCQ voltage supply is set to 3.3V by default.
- Fixed S32G2, S32G3 dtb checks warnings related to uSDHC
pinmux renaming.

Ciprian Marian Costea (2):
  arm64: dts: s32g: Add S32G2/S32G3 uSDHC pinmux
  arm64: dts: s32g2: Disable support for SD/eMMC UHS mode

 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 153 ++++++++++++++++++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |   5 +
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  13 ++
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 153 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |   4 +
 5 files changed, 328 insertions(+)

-- 
2.45.2


