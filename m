Return-Path: <linux-kernel+bounces-531220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8179CA43DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B1F188EA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3101D26772C;
	Tue, 25 Feb 2025 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S8L5F5IQ"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013004.outbound.protection.outlook.com [52.101.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27A2676F1;
	Tue, 25 Feb 2025 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483296; cv=fail; b=tmA7qXAsbfYKU+oyZouhmuR3j2JOWmz6MGaKTZSakeAgAr+GV4y8FOR5c1hUcAZZVWwdAqLJKUHwDKtw3GKhfYWztHAFrg2WZlGfngYgTQnGjV8EP/Dst8mJmWO+luRDJISsWCwpsAr5dONwu9RAHtJl8nQVfHz9kT8jxkK6G4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483296; c=relaxed/simple;
	bh=Y9QkFEirhw3V2DCfqSN3bdPnI9mAbmGdRw2zT4oXGb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GhWV+RnKde5JW/79aogeLx175NfJgO9viPAQEogjHz36/EPzLNy2iVLLtw0c3CGwxOPMpUScFOcKVfS7mNJ1T523/63KxKsUgaBupYLkLIPQ9RdBh4Q7KOc/D9l9UUpI3r/Ine5IesswHu3cXIr9K6KSg85rH9OCkv+4jIlxeXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S8L5F5IQ; arc=fail smtp.client-ip=52.101.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIV4os2IMw2iJAgtcTNUv/wck/rDI4OmTyQuaSRPD+gtsaJrJLKKPxQspRCcnHQH22Zsqg5BhjW1/3dRY5o341cg6OVYqPNM/Ya2nnGep/PxHLRKlcoBgtOt6dtIVpLngjYjF0dtwVB+Ci6BzQ7eGH3lkVI2/xopFXJ7c46PQE7TjB8fXHxG76uBUdbVpKhFDvFOOpxyGh3aKrQig62mUwBSLWPOH6LvzJBUS+HEctQEVGSbrtNEpA+Inx+yfH355I6gV8U4bCTV5g6WkMrZro4HkJNjaJEsW9wGqM2/V2y4ps+S7a0o01S6E2mN5MWMUO5rHLR2QnRPEj8zGYVErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9QkFEirhw3V2DCfqSN3bdPnI9mAbmGdRw2zT4oXGb4=;
 b=ptNEBPwbumkKBZFHNwqHbAhvlO9yJys4iW0FJnwK7q37zUnk0t6v9TtIvjOIGUzUeH+nIL118OQ+UIzvYIZTKF9+Q9dP4OjsXyBqJUFjaKsuuGC3MVKPeWj614meFGpsrlCaKvpsO5Ilwb+9bDLpArrRM3xGGq6nT9PkU9D+9wYo9vBV/aTZ1LOAcAGBm2iLvEMXW9i9CnflIQpFh/UaLs6yrGHPo6TgnUzPrcSIa+p93f/p9XzA+iXsjz8ZJ23ljdMVrghf0oOSm2RdDMfMZx/Cqv8Enjy3veJlJ2VvLFHKCY2Nof1h15mi4Jt5EzYk37KjzuykgPlj0AOwzRBM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9QkFEirhw3V2DCfqSN3bdPnI9mAbmGdRw2zT4oXGb4=;
 b=S8L5F5IQQOctw6pT49a8JEndFVhv+eZDzpu8WMKIi0/MZHfcbNKWvR5+xMRTSXS5u21Ki7lZG8RSvWVbmJhEvqB9LgqvCuC+DC/sIn2W/8QEsnP7csXtpj73pNixBbHd2CAMTrtqDHfOyYNcGO+4UcD8X58FlPNFdjpKtuGYd8ELbe8t89h6jl0/FczAdrF4xekjXFBv5b5hIweOIh+1CBvft0FowMo/lMIoxZITYM81zlZONPul9iLme2N/Err6Ah87knXCVyvm7rIQQw1pqoxTgVZSmlal7RtaMV7Y/kA7OOL/+Q50Gt+cAO6M55vZPeLPT5C04eBD1zugR1NgBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7599.eurprd04.prod.outlook.com (2603:10a6:102:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 11:34:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Tue, 25 Feb 2025
 11:34:51 +0000
Date: Tue, 25 Feb 2025 20:42:03 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, Chuck Cannon <chuck.cannon@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 3/5] firmware: arm_scmi: imx: Add LMM and CPU
 documentation
Message-ID: <20250225124203.GA31590@nxa18884-linux>
References: <20250121-imx-lmm-cpu-v1-0-0eab7e073e4e@nxp.com>
 <20250121-imx-lmm-cpu-v1-3-0eab7e073e4e@nxp.com>
 <Z5DhM1VLv2uCCVwT@bogus>
 <PAXPR04MB8459D4C2CA3D5AE58B2B509788E02@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z72ZxspU3hfGZWez@bogus>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z72ZxspU3hfGZWez@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e93eac-9d75-45d1-ecf5-08dd55906a92
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LgrcCPnTkSLeM2jmYQre5QKt1GlSczvIsvzeksZkAOogzaf1aSOdz8lKGSr9?=
 =?us-ascii?Q?jL+Tsd1N0GR1B2e9Yfwly4j2zPjzwaxVaqzWFgw3W3JvwxCgIlX+yytghx49?=
 =?us-ascii?Q?dXZp0w9ePg0tfxFpFjeBwGwTo7j7eMouWCIU27neMwc+Onc8Z7egcvMRqoJh?=
 =?us-ascii?Q?FZrUmvDXDwFqKuePx+xqzxW7xjuYkWS4imw+3Kf09KRlpVYdYt/EQSMXgCbf?=
 =?us-ascii?Q?6KP2X3/vBxhXWH/gtqNkwA/lbJ/EKJmfiYyC5o09xNIp8EPLCZ7HUiqvrmNY?=
 =?us-ascii?Q?N95mKZ2mPHhO1J7yDCZAjIOiuUzeAxlVU5e7DGUNpTISimYL/pBgrga8Shwo?=
 =?us-ascii?Q?1LhzS84ndptzlsJYkb8nxAUsZJO2ljAZm5CXQJWm2hIHy2+uuqqs/IK2wAJb?=
 =?us-ascii?Q?xvcF8NZMTncYoyDsql0F3V3RnDw7Mf5tndvD6o1xua/yqE+8VXTAvVzqOoK3?=
 =?us-ascii?Q?/8xQI0bfLn1L2myFwqpfNDMXlvOOl1qnhUzBexeWnLNT+yJjgjvaHvTvdkZA?=
 =?us-ascii?Q?S+xjOkoOcV6AhBTXywnPl/Fjq3dkp6dJWSRphw9vpJArNJlGXcw1p4TApXcG?=
 =?us-ascii?Q?wAWZClnqpbJCSS1HfxCvTp4hZURkcVZUN7/dZoU4W2yqQ2PeEeWcN+ygnpv8?=
 =?us-ascii?Q?xP1kNkkzEB6HxV+/4xLI+o6T65OXQRebf8XsDhleXmQkxer8OAYgJJTQVO3p?=
 =?us-ascii?Q?RSlpcgCDueFmR7TUMHnN6ds4zFB3JUBtCsYeLsM7o46i65tep+ldKyXxNHa+?=
 =?us-ascii?Q?PO8y10qcxnANh6XQreLi/kDGhrXxLMS2XLHnlvRtTn6JFGw4QMtTNkYT3z+P?=
 =?us-ascii?Q?vQeQbXDQAP9fuFvBJbDtVTYDIm6CLMJfY+g9SqgRU83xXWuvQghIiHjQm+zM?=
 =?us-ascii?Q?1ASaYmzVobcXRHSO8d8FiUjtIp9ZcguEK/8eNSy5l1ilb4uR8oI66aNDj8e/?=
 =?us-ascii?Q?ngy9FkwAn4YdEaltWGn1nF4DTyFz5yln/FWghmNjPPQX+PeFGFodeCJ7/PrD?=
 =?us-ascii?Q?ByLCCczHKtmCxQGf9bKIaufNL5xD16pxk0hdngKR3/6kNBJBQYU1aGijDbQA?=
 =?us-ascii?Q?klG/EHOfZKazFYessTleB3wVSpGRkgkbqxxsur8ycBExW81/TrKqGF+x6ACq?=
 =?us-ascii?Q?/LPAFMnphjhtWsJuz2XNsmaMYtnCuUVy5SAVaGmhIKynkkPlyHlLNIwITS7r?=
 =?us-ascii?Q?QLweH+qo4KdWDsmiI0Wi+kUQy/Qpdouad2iNUQo9urfeqPTjD8/zvUTJNgjf?=
 =?us-ascii?Q?gj3ZbH6pH/4ywGt2rtDk6F2TSHVQWQNZkEypPsAjMXU0G/4CHFAqyUnVFqFE?=
 =?us-ascii?Q?R46o+aRBNpkPLKzrZEq3vBuNto7pIH4FN1WBTNPBor3YZRox0MmSgSiLuJh+?=
 =?us-ascii?Q?Km47WS7qSl34mA2L6nBeHEqq7RDM0kOQoLK5Fk+5MRZ4mL8AKDMHQ4HQ3ain?=
 =?us-ascii?Q?Vz/2S11LROvAV/7lztfI7Pb8ZF4cgJ37?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xVB2Nz+aLyJTTLL9RFWA5nOQT2KImgKXGLtz7GHGrJEIoiklsx5JaAWfhxvZ?=
 =?us-ascii?Q?ZZfu2Ib+AGS8oP0FvwUUorxVUY+eXjkx7au9LRxYCT/J+KtNcJuK+YJaOFJW?=
 =?us-ascii?Q?GU4a2St0eMmeU4/Wis9nqaeQJAEjqCjzeH/T0PaVJmN5AyvLvozys4LL0n3D?=
 =?us-ascii?Q?aMuS5iOYSH0g9TxS0dZ7RTwqY/kHtbPeVfljahgX2ZLajXEz2Rg7j4S/JeNN?=
 =?us-ascii?Q?Wy70pQ/qp5tYrkt24R6UDMS/gRqULzmXeZKRCU+h6bUsxVgIKbqoAFcfSLaC?=
 =?us-ascii?Q?AJwoTPd0BtCi1bjDXatGCc2VK77knAvRctXYQSXkXsPveFhAsBk7H0UuvLQP?=
 =?us-ascii?Q?6PDTaItFdI+HlhIYmML5gOCXsVOzT00CTEOqUiYAx/ZXKT5ZykDjiF/0PY7L?=
 =?us-ascii?Q?0aOwo1nSnsAUGWMwvodamYxOElgsnmsP/bBouO5m/q+D0H2qs4ckLIOdO5ov?=
 =?us-ascii?Q?T2iV1FV4Y/pl5qN/5L63zTvIbMpnYg1rtf9B4O4OjCY4ZQ780LnzK5Jek5uB?=
 =?us-ascii?Q?Gi1Hyq6qd8GW1HlVxQo6uES+hiiX7xmvZ4MWuD5ejvwF5hKha5mMF88BnW+T?=
 =?us-ascii?Q?MoJS0MmcAz75elA0DUI++8AcGRDUhGq3wQjj2CH0xjXQorWk+kBhohzgYDeA?=
 =?us-ascii?Q?s47N7tHAFVC2FlbErNB2ZQX4LcT2zX2PqPZ8uU56O+K9G9Bg5RyKkvhMgm83?=
 =?us-ascii?Q?KSoG30dld4nho+gm6iVOfR1YE6WXA59CUB8WdiATzjyY/w2T4E9hRAnWHVKt?=
 =?us-ascii?Q?qbUUldXgRKbczj9jqs8aQawzsuD1y3WQvHKn+Zv4J6gJdrxqwIjtoeiwMp1g?=
 =?us-ascii?Q?2fcoihzqage8BxCjK2TbKTAR4wuTSEHdj4r2kEuiDsIWT4lDkLyViET+7MYo?=
 =?us-ascii?Q?qzu+WIEzE0xVUVGTU8ZdIwwDCdPF+d7QIyBI0sc3Yw4iH1ZZ69xECRJ+RSEP?=
 =?us-ascii?Q?Q/GomZHno7b8ZDN16RrZ26iwpGMUJ3J8ijJt+oQ5VJWVw/oIAsAdFXx8Y/Vf?=
 =?us-ascii?Q?yGVFvlaS0byGf1UIsE5o38ejA0gSxczhTf7xlkmYP/0pfkFU20HbctWXaeOt?=
 =?us-ascii?Q?VULWo9XmYvjdnMIbVJDu8U9vepQHMXH08SDQqt0MaLc7z/iuhhBS7u7eliRP?=
 =?us-ascii?Q?KBVXyzJd+hfBBWRDgxBLsFMrjKDCaThfy2zaitxpSrR0mGJTrtaaUuavJzIn?=
 =?us-ascii?Q?SF18wE0IC1bOFX0Q41l2ey2BzcGv0ELYF2mMyuwVLutGcZYByPAmZe60pPPn?=
 =?us-ascii?Q?n15eoVoT93dYGoc5h4rJP8R4piWdsfMUkLtNwL9ifumfi81qrPcXMiJU3r+T?=
 =?us-ascii?Q?iVia6gKYjFS0QOrKSIYKAJhtq+03ZBj4iil8s3s8+m05NK2HG+NfgMZxT+np?=
 =?us-ascii?Q?ug4mI7IFu+ZCsHXXdV+gAccWLrN/KSyrETjr+X1KB2HfxKwL9ePAg/4G3MdB?=
 =?us-ascii?Q?3Rm7kXmGK+i+gTV8Bu8jP8946QljtUXiBgebgEAM76I27/ESHd6K2MqIyMuh?=
 =?us-ascii?Q?Fn2rtHx2YJgnKl0cezNFhkN3SyP6ex79/KdY1B0tuZd9xWJz/Qwxdi6SkLI1?=
 =?us-ascii?Q?mKiaCKR3PnEeGjxPtvRkowyxtfLDzKMLZ04cTekW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e93eac-9d75-45d1-ecf5-08dd55906a92
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 11:34:51.0393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFMMW8rKyWVdXf93V88M4HtF6/hq5YDsF3dTEdqkyVWSsk2yloVU19nwvRHd66jUP938NdH57ckNjfwy0Ot9tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7599

On Tue, Feb 25, 2025 at 10:21:58AM +0000, Sudeep Holla wrote:
>On Thu, Jan 23, 2025 at 01:30:43AM +0000, Peng Fan wrote:
>>
>> This is to manage the M7 core by Linux. I just put more documentation here.
>> CPU protocol is also used by ATF to manage AP cores.
>>
>
>Good
>
>> > Also what other CPUs are we talking here.
>>
>> M7 core
>>
>
>Are they referred by any other name in the system ? I reason I ask is using
>plain "CPU" is too generic and confusing. At the same time using "M7" may be
>too specific. I am trying to see if there is any middle ground.

"CPU", if you mean the protocol name SCMI_CPU, there is no good choices.
I could add a note that "CPU indicates the various cores of i.MX SoC,
one CPU represents one core"

The documentation origin from https://github.com/nxp-imx/imx-sm
hard for me to drive a change to use other name.

Anyway if you have ideas, I could bring to our firmware owner.

>
>> In general I would like to
>> > explore the possibility of collapsing this with LM protocol. CPUs within
>> > LM is LM's responsibility to bring up. And CPU can be seen as an LM for
>> > sake of this vendor protocol. I am not get into details here yet before I
>> > can understand what these CPUs are really in the system and why we
>> > need this.
>>
>> Our system supports M7 and A55 in one LM, so A55 use CPU protocol to
>> manage M7. When M7 and A55 in different LM, use LM protocol to
>> manage M7 LM.
>>
>
>The LM(assuming Logical Module/Machine) is an abstract construct, it should
>apply to even subset of components within an LM. Just wondering what are
>specific reasons do you think applying LM protocol you have on those M7
>CPUs alone in A55+M7 LM would not fit well.

We have internal mail "NXP-ARM SCMI OEM extension" between NXP-ARM that I
could not post here. In that mail, LM is explained.

It is the LM protocol design that it only applies to the whole LM.
If the LM has A55+M7, A55+M7 will both be handled.
If the LM only has A55, A55 only be handled.
If the LM only has M7, M7 only be handled.

When M7 + A55 in one LM, using LM protocol to handle M7 will make A55 not
work properly. The current linux usecase is remoteproc, that means
stop M7 will make A55 also stop. So need use CPU protocol here.

When M7 and A55 in separate LM, using LM protocol to handle M7 LM works well.
The usecase is still remoteproc. In separate LM, A55 CPU protocol will be
blocked to handle M7 CPU per firmware security.

Hope this helps explain.

Regards,
Peng

>
>--
>Regards,
>Sudeep

