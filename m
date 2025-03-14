Return-Path: <linux-kernel+bounces-561643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338D6A6147C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF28B1B62D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56120201032;
	Fri, 14 Mar 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="f3SSiXnw"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021116.outbound.protection.outlook.com [52.101.65.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF853B7A8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964685; cv=fail; b=YDC5m9XDg0QavYbpEZEim1kQvZvinQBpV5yi4WdSHXGjU8WIPyCUyXDoL2Q38e3lcCz4iEgaZR4f3ZfnEL++SznN+ZRZo6w7ZOOCzyqBcGRYpX8GhtDJGkj/agO6+2sYcOLo6Y2nZq616oNjWQ97UnVP8GTfE1syXyNgGVOrD/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964685; c=relaxed/simple;
	bh=IuL4di36cPbZ6MO3Aj7c1m/098+eiJZt51X3bdjFEdg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=r+XoX30Y+X8y8ZGAFxJhjnIMk4L6EqHG1Hm6oracnyU5wlxFkmu4YoQelybSL/j3BPvmuVLmfSXBFeDwSOrG7NCQX3kZQ8k4dfpGedzRLEEsdsbTX7xQ6rytnV4LwrH/ZjuM1CslbiGJZERFvgOPD2XfbbuLgmT/p+7jLn3sbWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=f3SSiXnw; arc=fail smtp.client-ip=52.101.65.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ro2hcywl6rQ2bZK21bJKxPQaFg73YMGieEYoZIKng6n8yMypXnCPgU5BNXllPWquoR21gqYRZigXiNFJ5mp0T0LZbuHINwx7hmt+osLXvp8hi8J0GV2c5w0j6YdRF3syMvZcAeqvdqwdYa9PIw/Uwjagpt5mgKeMaTBCckFQkeWBp3lViSDzbsWnZW1QJLgmB5E2JmjWRO+xQnCzxhAKgsBJGOTBSDllSUEEyeHUz0H8i2c8lGYCfGP6kIsITYWt3x/J1kv/ATaCZUlG2szyazWRpkhXYNbZh4MTK1x3rXJHFYOYk8XgoBApzWO47mxCRzd+fVswNU8k6ES2FFacWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCf2+waZi8IsVS0Dh7ZXk+hJXrnbdpJGf8gHBiSbXaU=;
 b=eJkIcbTPj2AZT/uJYwHJzn3fG+qlapLwdCmXicSGh1OVjxhTyiUnBhwdNNGNBJjmhIdRs90FaSeg1EwAhd9jv0v96ZJSY0YcrfRDlLZhQTzCoIhAJOwXvl4PJkUnhWZy51cKezG0HmOET/OUL4wximWoc+Sd3c1kv1C0JFbYTti12mwrM3bQzGxU8gLZqHwLH7hG1Jtv2DXTpbKC202ImD6Kt1h0LWqCzRA4oRlpMU/KvkDApYBCVEhCgavMYQtC23YHAaDj0M2Q6x8uOa9wNn6ytQy1N+CZoED10vPWyCxVIhEe42Prc2+dhxBpyeGMisyzBw0vQl26MqCVWJ8eLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCf2+waZi8IsVS0Dh7ZXk+hJXrnbdpJGf8gHBiSbXaU=;
 b=f3SSiXnwMM8zk0nRyjDn/m9TFebxZ/qrRY0FU3zTznBDTWRvjTFJz66VpYLpXmq0Dg9Zkh3Krkf09Wy5I8+joIUY0MNtw8r0bqeL8q1kYGSCV0TdbotdKFkTzfO9GxFg1I3yQ11XgV2L0hQQHTjz8ks4FTAfIcw8BHCQjai+cL2D4geB/kkwVIRqSz0Nw0DGmOcdTa2dhDt0qysMKNDBFY+RfxYQbV603wm/7+AH6rlbmZBRxTYdx4CaFr4hZ/WlS4aOW+hFkNp47J+htoVuYEM4oIobk0lg6acjFzBTKIWEK0KqCqkCPLmbVAhI4uVPCn6WU30tpCt1yHNfmVWKlA==
Received: from DU2PR04CA0219.eurprd04.prod.outlook.com (2603:10a6:10:2b1::14)
 by AS8PR04MB7656.eurprd04.prod.outlook.com (2603:10a6:20b:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 15:04:40 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::f4) by DU2PR04CA0219.outlook.office365.com
 (2603:10a6:10:2b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 15:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 15:04:40 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.111) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 14 Mar 2025 15:04:39 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PA1PR04MB11034.eurprd04.prod.outlook.com (2603:10a6:102:483::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 15:04:37 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 15:04:37 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-phy@lists.infradead.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Michal Simek <michal.simek@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy-zynqmp: Postpone getting clock rate until actually needed
Date: Fri, 14 Mar 2025 16:04:18 +0100
Message-ID: <20250314150431.28319-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::6) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|PA1PR04MB11034:EE_|DB1PEPF000509F4:EE_|AS8PR04MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: a7daf1d0-f4c1-4528-c912-08dd63098b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?jCa9bQSLAgzz8MFgBoN0S23r6M5BAyUMRY47AYeVQwStorVNvv++hLcvmgml?=
 =?us-ascii?Q?dzmG0rC/9e913bN0H4GVwOwwb3qN+TatFb1wktPNrFJzCczi0ZlVN2mXHeVk?=
 =?us-ascii?Q?C88ebvU8kxOKOSURv1WChDrS/kqp6YmJn8/VwJwQKeuYhTpnD6BbrPbS+kdi?=
 =?us-ascii?Q?iIe9DwkaQ1PZ1hb8lo3oJjj4C+BpuE3t6ga+YcxSdu/KJd6zK8mqvd67kibs?=
 =?us-ascii?Q?XcUHvoBSkq78GarJ0KBPZElzhC/G6GcbKuFYmtUDK5O80n+6sx3eFz3dz5Ra?=
 =?us-ascii?Q?u5RLfzeERrDrd7rE4A/bSZOcb78sY2V5+6i30MODowhnee4M/aPhAaV/+rVB?=
 =?us-ascii?Q?mHmzKx9NQAywlnrwEWGWdnuEbGRyXhUlFcmVVot/6kbgSBmvrxpXSIpBN1WN?=
 =?us-ascii?Q?btx46TWVA6Prui+dtgyDwGA5ZvVD7GfNu4rvBbRx9KahUFMSWqQsMUQQER+l?=
 =?us-ascii?Q?zwCzauLGhDEox7DahnFlx6rjDVegZWUq75gym4LF9Hb3d/Mr9V1b9JhcktpL?=
 =?us-ascii?Q?w3Zkq9wNPYSdeusGUq8QxSVdVIttYPxDxOT1XrSLmxnbbKDK2wEG5P1G8B0M?=
 =?us-ascii?Q?4XxgVhS8NGwiNE3R8hdYUYQhPc6P5eNB3XQR5vIr2IVAQzifSUc1Hc4z/KUw?=
 =?us-ascii?Q?QYnBPlZ3ictM0c7QYG9jWdQzlrMMvnppWQ49AJe2lK4JjYRxlf8w7SeT09tS?=
 =?us-ascii?Q?1W33zNpGw4JU3u6L17Oqjv5cxLlxGCAMRYtqatHjCp7loTzz7wRcxCZnXgdK?=
 =?us-ascii?Q?5Gl1B8oLuRGPwGQSMX0piNwE2TqTzW0B+dXUVP+GLaJYDrqLgGRifXzT+soR?=
 =?us-ascii?Q?VfFgyOvSvJCVgH39yMDWkXZGloVCpULSCE7RHn4/BXGnphinfV2wgbhop/Pz?=
 =?us-ascii?Q?1jOUaCwe7ZzEB32Hl2MnLnghUkDKghznny1QS8HICa7rXqfsKpd25ULxrJAs?=
 =?us-ascii?Q?uGl+znqsGMN19EsHP28cJlrdyEJvLvlENTHYG9LRNiut9jm85ytO4khfNmA1?=
 =?us-ascii?Q?SSbWIJhEvkXZ7MUc6nNfNH/kQVYeOqDg0LdMfw9CqMwxOgT6USXam5cLTgQz?=
 =?us-ascii?Q?tVZZEXYR7M2ytkNVLuMry555RDcNNJzgiiqfFPFdHnOKBQ8mE3KevY+wkT5F?=
 =?us-ascii?Q?mxQ/VBE87dyKhXsX9Z0mHXxsoylAE65XZwCtCurgie0H1Na4VqsLLKclKG3h?=
 =?us-ascii?Q?eMB+cS4QyRIDViJzQ90bYopbs3zkD7kGspZ8/LUTt38kL4NJQV6kNtwKK8Cx?=
 =?us-ascii?Q?zyzHIla/AnCe40VKrjhYHP6CFytnM9eczy1F01KZb8OD2AxjHALQV4VwKGmR?=
 =?us-ascii?Q?j0eyLyEuHuTv+tA9VUKRvViro00a7bbOdOrfS/GNL50dCsydyxZg0eXNdmDG?=
 =?us-ascii?Q?sweV/+WJBFI8giyGp3m0XqFq+XYHaoh2zjZi/F4Vo0dLPECv2JLRxet2ROX2?=
 =?us-ascii?Q?z1dvHk9G0tRB35kTpUuAj8QXhlt5W269?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11034
X-CodeTwo-MessageID: 99f83d17-a6cd-4cac-b32b-9d42b63e4306.20250314150439@westeu12-emailsignatures-cloud.codetwo.com
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.7a5992b5-aa78-4b18-bf5c-70f893b58f48@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f8660d00-9633-4e09-77d9-08dd630989ac
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|376014|36860700013|82310400026|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2h9PdMNYgzi2H5YLAmGI9g4lWuayjRFIIZU0qHX8/s0h8dN4+z6uIe6zRczy?=
 =?us-ascii?Q?s3FZgT0vOJrx030QYcxCiY5UlOW5Naww1gRKe+PUgOH4LSWeV5RPWrOIdwSl?=
 =?us-ascii?Q?uUYQBSTwNByqHZnQip1fmaRP4xDT8yRoX5n5p3TuIUN5TZRSit/Zc8DoopAq?=
 =?us-ascii?Q?Ea9XPmbNV11opIp4+h/cKtBtS6RNlGfQ8CqXjb6EPnMsRYThHghZ0P0UUGVS?=
 =?us-ascii?Q?W0bqxesIzJvtq9QvYFeLCiiLFfeWndVPFgIE9K49UA+vaAU0yV8epiajXioM?=
 =?us-ascii?Q?foSGSQjTJICE6fn0SRXtdSlkukjckwB29IRaOOHLnd2pE20+HqO/HZnc7D0W?=
 =?us-ascii?Q?YZ+4JPWg/zMNcKBYwUEzdHu/4edU4Aiczs7KkqJEdt92rrwRL2VU2YvOIeJ/?=
 =?us-ascii?Q?DQQbBR+oovOUllOFR2LFYvMF8p2/pkbgmeRCabREFV1b3VqDzxowKnBZxsl1?=
 =?us-ascii?Q?mRBoXYRouUxFSNnq6/19HFJmUrc6IdjXSn87se7G/Yum5yvToxtmZNgik260?=
 =?us-ascii?Q?P0DEXGpnUB/yvUG7QfAViJi3eVbF4J5s+A9RSVblTZr431qgsRZ080+k1soG?=
 =?us-ascii?Q?CvHaiINboC8jQ0To+MCt/+SJBajjn8pe1ybTK/0/V7Ek6LT/8BUbGV8otga4?=
 =?us-ascii?Q?03nFaq73Ct6n5Lqt1G//oKEULifWp/rhXds2wEka6Lae+nbQixZ2CVM7m1Cj?=
 =?us-ascii?Q?HAb5hjaTbBHu67gUMoGaH4xkDb6XXqmgGik94jdCEE6L/6q12XHXQfN0JGRn?=
 =?us-ascii?Q?RZxwgrZiOPL4CuTiAIAEZwWxPDN4LoGRWaeOVYMSR2frPsXlcXnr5JZQigiY?=
 =?us-ascii?Q?+dHey0Sin/ppDISoOsQK41KED9zp86brZfwjyfpY6ETscOLzvYVPsDvwYgIh?=
 =?us-ascii?Q?Mk0tQm0TtdUuO7O+v2dUHfndaPigLdJv1MAIvvU9u1VHa2KgZEtE0NDn634f?=
 =?us-ascii?Q?p1YkmS4BOes3NObW1UR0WT01ABwYeEhvQ0WmrKzs1ocu/0qEfx/cnpdm9XQf?=
 =?us-ascii?Q?/8C5FNiVTV0YFmLwYw4J7E09KSKeWBu4Rq4cR51rsxjnqT0pWLw5//5XmhFG?=
 =?us-ascii?Q?es4UoKgH3Kl6WxjnJsjFaku1GZDwwxHxtw1qZ7jqmZ+b+CVrhSLIryOeYJVh?=
 =?us-ascii?Q?2Nbbh+5jHeZd8duJi6nWm/6qsYj9W8sFOyMP4oQZVcQpFN/39WeJMzmaxqyM?=
 =?us-ascii?Q?zN0Bw7aYBI3PgW+pDzLn/tTapE277Pdzg5wg7fwCBTgcV9tpSIRvm3ly4iZM?=
 =?us-ascii?Q?J8vOJb50kju7QcO2fmkXW6OWkcINZ+7zeipxGwfG9qCmgRKaxRPCDKHqOPDk?=
 =?us-ascii?Q?Gf85KU9m0TbcnyiOkmQ69VIYAqPjXBYMOv/j5iucgTahMkRjafMp5orwGfAb?=
 =?us-ascii?Q?+2pztA8hw0PtPlWqkHtET7tnw5zm+C0NqTyfvhQy8dqtRkd0unj+8zJuxyce?=
 =?us-ascii?Q?OVU0573wdLk=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(376014)(36860700013)(82310400026)(35042699022)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:04:40.2267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7daf1d0-f4c1-4528-c912-08dd63098b92
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7656

At probe time the driver would display the following error and abort:
  xilinx-psgtr fd400000.phy: Invalid rate 0 for reference clock 0

This issue was that at probe time, the system has not decided yet whether
the GTR is to be used for SATA (150MHz) or PCIe (100 MHz). The driver
doesn't need to know the clock frequency at that point yet, so wait until
the lane is actually being initialized before requesting the clock rate
setting.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

 drivers/phy/xilinx/phy-zynqmp.c | 61 ++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqm=
p.c
index 05a4a59f7c40..e29e3e51d380 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -222,7 +222,6 @@ struct xpsgtr_phy {
  * @siou: siou base address
  * @gtr_mutex: mutex for locking
  * @phys: PHY lanes
- * @refclk_sscs: spread spectrum settings for the reference clocks
  * @clk: reference clocks
  * @tx_term_fix: fix for GT issue
  * @saved_icm_cfg0: stored value of ICM CFG0 register
@@ -235,7 +234,6 @@ struct xpsgtr_dev {
 	void __iomem *siou;
 	struct mutex gtr_mutex; /* mutex for locking */
 	struct xpsgtr_phy phys[NUM_LANES];
-	const struct xpsgtr_ssc *refclk_sscs[NUM_LANES];
 	struct clk *clk[NUM_LANES];
 	bool tx_term_fix;
 	unsigned int saved_icm_cfg0;
@@ -398,13 +396,40 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
 	return ret;
 }
=20
+/* Get the spread spectrum (SSC) settings for the reference clock rate */
+static const struct xpsgtr_ssc *xpsgtr_find_sscs(struct xpsgtr_phy *gtr_ph=
y)
+{
+	unsigned long rate;
+	struct clk *clk;
+	unsigned int i;
+
+	clk =3D gtr_phy->dev->clk[gtr_phy->refclk];
+	rate =3D clk_get_rate(clk);
+
+	for (i =3D 0 ; i < ARRAY_SIZE(ssc_lookup); i++) {
+		/* Allow an error of 100 ppm */
+		unsigned long error =3D ssc_lookup[i].refclk_rate / 10000;
+
+		if (abs(rate - ssc_lookup[i].refclk_rate) < error)
+			return &ssc_lookup[i];
+	}
+
+	dev_err(gtr_phy->dev->dev, "Invalid rate %lu for reference clock %u\n",
+		rate, gtr_phy->refclk);
+
+	return NULL;
+}
+
 /* Configure PLL and spread-sprectrum clock. */
 static void xpsgtr_configure_pll(struct xpsgtr_phy *gtr_phy)
 {
 	const struct xpsgtr_ssc *ssc;
 	u32 step_size;
=20
-	ssc =3D gtr_phy->dev->refclk_sscs[gtr_phy->refclk];
+	ssc =3D xpsgtr_find_sscs(gtr_phy);
+	if (!ssc)
+		return;
+
 	step_size =3D ssc->step_size;
=20
 	xpsgtr_clr_set(gtr_phy->dev, PLL_REF_SEL(gtr_phy->lane),
@@ -823,8 +848,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
 	}
=20
 	refclk =3D args->args[3];
-	if (refclk >=3D ARRAY_SIZE(gtr_dev->refclk_sscs) ||
-	    !gtr_dev->refclk_sscs[refclk]) {
+	if (refclk >=3D ARRAY_SIZE(gtr_dev->clk)) {
 		dev_err(dev, "Invalid reference clock number %u\n", refclk);
 		return ERR_PTR(-EINVAL);
 	}
@@ -928,9 +952,7 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr=
_dev)
 {
 	unsigned int refclk;
=20
-	for (refclk =3D 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk) {
-		unsigned long rate;
-		unsigned int i;
+	for (refclk =3D 0; refclk < ARRAY_SIZE(gtr_dev->clk); ++refclk) {
 		struct clk *clk;
 		char name[8];
=20
@@ -946,29 +968,6 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gt=
r_dev)
 			continue;
=20
 		gtr_dev->clk[refclk] =3D clk;
-
-		/*
-		 * Get the spread spectrum (SSC) settings for the reference
-		 * clock rate.
-		 */
-		rate =3D clk_get_rate(clk);
-
-		for (i =3D 0 ; i < ARRAY_SIZE(ssc_lookup); i++) {
-			/* Allow an error of 100 ppm */
-			unsigned long error =3D ssc_lookup[i].refclk_rate / 10000;
-
-			if (abs(rate - ssc_lookup[i].refclk_rate) < error) {
-				gtr_dev->refclk_sscs[refclk] =3D &ssc_lookup[i];
-				break;
-			}
-		}
-
-		if (i =3D=3D ARRAY_SIZE(ssc_lookup)) {
-			dev_err(gtr_dev->dev,
-				"Invalid rate %lu for reference clock %u\n",
-				rate, refclk);
-			return -EINVAL;
-		}
 	}
=20
 	return 0;
--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

