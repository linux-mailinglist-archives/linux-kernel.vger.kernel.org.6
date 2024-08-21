Return-Path: <linux-kernel+bounces-295892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E330B95A2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB5428426C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BA415351C;
	Wed, 21 Aug 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kBsJvA79"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE71534E6;
	Wed, 21 Aug 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257189; cv=fail; b=XyUhM3sV4w4WjOROzcOO2nHVLjE82x6m0bX+6NcybXOTIudYlv67VK32HJX0HbafHlLNb4qlIIK9JwvQYo8Y1fB5xpPUJ+kjHvKk7qqyDMt1/7uAiYLFJ8jDb1cWy+JzeE9zDyKeitSUgWJVDEHyfaTjaLEs4xdeeeDp5MuWhbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257189; c=relaxed/simple;
	bh=f4c8a9XMLeTOqFFqv7Q9Yu585Ee3C2Q9Dcc2VtUIJzI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=VIZFETHf2YXgXyUQXfcFuA2rZ13wA3NZg1QGQhRHXBri28SvQMtwEYZI5cPfxLYHSOenzXI6ROOKfFtGKgL7llDIyBbz5CmZ+6wuuUBE7hfB2RdOVY2mKzH4DG7BwdxGDvbtUsRK2T5nEzqcXmR6Hc0TQvhsNxMMoHVQhDlnaCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kBsJvA79; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0lPLUzFzG0kKRxg9mhh9jMBmUT0srf99Qknmxyz9lz1G5mDTknpmKSAXNsLwHe9ZldzKV0LBUUHLjcdhVqivTr/H4MMwgknEuI5nf6iOvDxE4j3NQ9g+JplAZv8XCkl4+Q2qpxa8DP0tf+NNWM5N8TYXxXzA7KGkPIg/PB+2NX6FELBqD3Y/MInyg4HxuWBjDosm4kqRq934N97e3ubZDLkQceT4U2Rmp83rsCMCxrFd2E9s6iId9JGwsjc2Y7MYJ99lqFvPO921lo+TVjopODRRRImMJSZWdHduJXQcvT7t97XAppJmtKkb17VlzYpheiQH1At/yx+Ws+/SqSJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U1lh8osY1QawQa98SHHiK+Txh0mhs+/8ozaE9VKTN0=;
 b=UjN+G21wQ82edXne8TVZAIXWPLO1R4eIKH03aGGURSqr2+D7mpP2W11TRURZ4RgiJkB0HbioFgoJHBnxPqZ3z0Y2ZhX6gNXEqDytJt/qVW2p0ciXqLDvFjSzjk5kXbJC5cRFbFYXyrq/LJ6owNHEsHYRc65v1me86eSZpMNimzgywOUF0zufLrOpjMHLd7Ijr1N53EK7dhCtRQ/mi6+t0aU5D/UuCRI9/aMHwZRDHaosIgxLHpkeFCqHcolOYNh7M6ohw3PGDrWXMe6ev3cnCaIrj2NVNkHdHebuqtMQ1l7BxBVU4jDnOWAYCDuconz9FTJzPXqxl7F9W63Ja0ZZ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U1lh8osY1QawQa98SHHiK+Txh0mhs+/8ozaE9VKTN0=;
 b=kBsJvA79x01IZ35QKI51ZNchIq4ZpUWCO7Sxm6Z/EqUe7thJoBN80jojARUImneo3QbD4ozQAEGdsT8T4Ru3lLyWcy512VvP4gQVOW+KTHeULhff6Bw4Yad/oJ+1hnDoMpOyEjQh/TJwxgMR0is4R+BOG3yOnlKJibi1KEbk38JIyAFcTuX4Z/hZOHF8wO8jngL7ONqYWvecwhHP/SFrQjbgG6MHc3HS+NgbvmXGAOP2fHjsJ5mdyNOy7oLg1FBy1aDZ5jnimk57fh5nrbvPl9Qw79x7zeSG9GNyX4Rrv8eKIXag4dx37vG79TSHMI/MdLKmiA3cLzBug5mLhYLCyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10999.eurprd04.prod.outlook.com (2603:10a6:800:266::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 16:19:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 16:19:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/3] usb: imx8mp: collect some improvement
Date: Wed, 21 Aug 2024 12:19:05 -0400
Message-Id: <20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkTxmYC/zXMQQ7CIBCF4as0s3YMINjUlfcwXSiMdhYFAgZrG
 u4uNunyf3n5VsiUmDJcuhUSFc4cfAt16MBOd/8iZNcalFBa9FKi+1icIzppzprImv4hoZ1joic
 vG3QbW0+c3yF9N7fI/7oTaieKRIFqMGSsphPZ4eqXeLRhhrHW+gOJiIIAmgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724257180; l=1309;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=f4c8a9XMLeTOqFFqv7Q9Yu585Ee3C2Q9Dcc2VtUIJzI=;
 b=D6pl8oAOuKmtAWyUlkeP64UZkxrockNgaKvwk9apBQsD/mKEFxItCqqvUqlsdFQhrNXZ9Kd18
 VVg4d+78yqpC+af7Vl6XFKKFt3MvQs+9rX7MHk+Eb/clKZhdVz3gKOo
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10999:EE_
X-MS-Office365-Filtering-Correlation-Id: bb532f4a-aa71-45e4-1a8f-08dcc1fd1131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFd0eEpETWE1WWFGYVVoM01aWFpjdk5ybmY1M3pYckZnWnRPWGpRTFEwREJt?=
 =?utf-8?B?UU4xMW9md2d5NUMxM0JCeWZGaFdQV2ZuQStZZGRqaE5OYVBmTDdMbkJJWXlQ?=
 =?utf-8?B?ZVdGdTdzczk3MTlvQnYyTVhYcTNiTHNyR01Cb0txRmxIZFJZYzA3cTBBQUkw?=
 =?utf-8?B?THBsYmdZb1M2WndNa25zUGxvRjlFcDAyRnVDRTNlRy9sSVk0V1pvbVdPY3oz?=
 =?utf-8?B?dCtXVFJtbzVONGU1cmhwTStkV25RcGtmZlVzUEZjbzM5c29pcGt1TWJ5Q3hX?=
 =?utf-8?B?TFdqbWdJWHp3eUh6Vld5TXNYeEc2MUhzT0RIOHZ4aGxicVVSMnZHS1R3R2Js?=
 =?utf-8?B?by9mS2l0UDUraVhNSVY1Z3hiTDZiZkVFeWYwdVRUeTRsYUE4dmRnNEhGcngr?=
 =?utf-8?B?Zi9ueVdCQTZZN2JSM3ZndXVjeTk4Y1RzMDRDckxka05DK2ZjeFAzMURnNGhn?=
 =?utf-8?B?bTVpaHU1UGM0NEF1bUQrdVRrUE5DcGI0LzRLaXNValA0bWZMSk9mRDdPU1JN?=
 =?utf-8?B?N2swN1d0MGl0dzBHR09VeGsrSEhPcklMdllkMGFydWdJN25QSDJPQTVMT3dD?=
 =?utf-8?B?bEhrQklZWmpwaDlxejFnWFFVNEFUbktpeHd4U1hpTW9DRjIvcTBwaFY3YVJu?=
 =?utf-8?B?WGtxUEsvazlUdXBUaE5TQUkzZnpvMERJTFJSZFdsaHdaejViRUdrRU16UjFw?=
 =?utf-8?B?R3YyQ2RPME8zZEwwWnBOUytsY3NFQ0dmd1l5Skc3SGFVODk5b0c3cmQ0WnhX?=
 =?utf-8?B?aW0yQ3VqTHZLUTZ4bmxkQmZoL0tLVk11MUJsZ0Zua0FVcUkyMm1xd1d3Ly95?=
 =?utf-8?B?cThXVEVpQzYzSGlGVnR0MmxWNzhPdFdoN213Wk5PNEJCQjBMVnN0ZFZtZkJI?=
 =?utf-8?B?M3ZJSXg3M1JyT2hLT0JqTnN5TlVHVUoyMnMrRnV2ZTVvZDBNRnRyMk8wRUsy?=
 =?utf-8?B?cjJUMHI0cHRDS21KOEp0dEJ4ZG9wQXVqRUFDNzg3T3JHeGN3dUlxWndOaEMx?=
 =?utf-8?B?cXoxempEOUYyb2ZoYzB0UE5hamdrLytoNXZkNW5TMzNONy8rT1NmcXB0S3ph?=
 =?utf-8?B?cGhWTmhGZFZseHJDUFBCUmNSaU1JSEtiR3ByQWQySm05K2RmaWdud25VbW9q?=
 =?utf-8?B?VVM4L3ZJNXN4d2poVzZsM29NNXl4QWpLZFhOQ2YrMlZteWFyUm9zV1U2bVVN?=
 =?utf-8?B?bFJxWFc0R0tjYXhHcWZQejBSY0k2OXB2NTNneitjMTRzUUdqeDQwUTV0eWIv?=
 =?utf-8?B?MHFIUS9lU2NlOGM5VWhnR3dXZjZEeE0vZXBQcmVRZHVnUzlqSExBVVRvMDZN?=
 =?utf-8?B?QU81SlhiYkE4Z29SdWRUdC9FZ3hTU0FFRFZZbFcxNy9SdFRiaHkvYi8xWGxz?=
 =?utf-8?B?M3YyenBEek8zV05vdERWQkZqbEoyQ2FFY2lQcXJvK1h1c1Z5WnBCZ3JvY0NS?=
 =?utf-8?B?M2xvTU1MRGF5dnVqM1Z4ZURKdUxSUGZxTStuS2pmSExnQys3Mkwra1UzV2ZH?=
 =?utf-8?B?Rk85SUNJbndFNHZBU21zU2ZZOENBNWhGYXhzWmZKOVIxRkZyTTQ3eW50anRo?=
 =?utf-8?B?Zmh1QlpGNWFZamk5Y0JMZm1mWFByT3Z1dTJqU3UyOThwWVB4ejdSTUhiYXZp?=
 =?utf-8?B?ZG4wNXpleHNPVnNSaitwNkV1YWdaczFkQTluRlJrUDV1NTRKdGV0NkVxV3Yv?=
 =?utf-8?B?ZW9jVDBtVFhwcWRBeUFuaEZPRWl2SUpQQUNlU0tHV3pNVy9Uay9TSkFOTXRB?=
 =?utf-8?B?VmJYNmlIamRITXdEc1pjVnpQMFVnNWd0SmkwZ3luSERsWnJXT2ZXL3VqN0NJ?=
 =?utf-8?B?cVluS2ROcS9mS0NKaGkxZVk1RVAzdGNCQzU2M2F3ekpGRkhVYlpZc25uc0Jz?=
 =?utf-8?B?RnFFR3VnaXNOWWpvVnJqSjJyUFlRV0w0THl4QS85MTAvTmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNQR3hITTBOMUl4ZDc3bUxSZndBVmtjTXZrb2pLZzVrVlRXaVhLRTROREdL?=
 =?utf-8?B?UnNQSFVHeWtjRlRLakZqTzBUMnN6bVJtTGRZR2dVL3NhNWoyaThuZGFDcVJ0?=
 =?utf-8?B?WEdVeGlua1RhMHFDRnNwV2YzZEErQWhlZ3NGT1p0eGxxTDlUcHloZ1A3Qmdh?=
 =?utf-8?B?WHVkT0VDV0tuWkJPYVRWNE1FZE94K2EvekpMSi92RVVIUEt6ZXZUT2IzMDlS?=
 =?utf-8?B?U05kb3JSKzExM3RqUVJ1cVE2a2NDdVRwZXVtR1I1L0svT1JDSnJSc0w1bVhl?=
 =?utf-8?B?alozRTZVcTk2QldjSldhSnNyeWFhbGYvdTlyM2lBOFRYejZmZUllK3NFL0tl?=
 =?utf-8?B?NUNSOGZMRE45c2p2NnlITHF0V05YTGV4d3NOZklRdTVhN3dqQ2lQTVZLVXFT?=
 =?utf-8?B?enN6czRMMU50Rm1FY08xaWFCcGpSeUsvZHdBcW9LelFLcE5vckhGZmZnb1Zk?=
 =?utf-8?B?dmJ0WXRIVU42VWgrRExTdUxCRnpqMytTL1NSemRrZVkwM1YvbjJCK2sxSmtG?=
 =?utf-8?B?bDE1aVdXM1JWdGo1ZjNiVnFRcGZsNlo0UWYvYnM3b1M1Z1NMZXFZNnB0OHB0?=
 =?utf-8?B?Tk01NkU4ZTYxb244UUNBZWFQeFRkRkRTcURYTkowS21NaUlFcy9iZEgyVk1y?=
 =?utf-8?B?WUNTSDdRazNuQUEydVhTS0hzOVdEZytIU1p1QWUvNVljcEdnOExQN05aSWw5?=
 =?utf-8?B?RVZGcUM0NUJZMzdtZkhyaTBrMnkrSVFQVzBCdnB5Sm9PSndzK01lOFBEckFS?=
 =?utf-8?B?WU1wUWtLblZ4RGdnZ0tSTHpabmFFVEJQdi9SRHovaFBMRDJnY2NGMzVqRWlH?=
 =?utf-8?B?UERrQy84L1lucG8yTDN1NWhCN2VUMTluZzhuVU9pbnEwbC9rMCsrVklJemFN?=
 =?utf-8?B?M0tET3FJYmxCRWxqKzJsWklnN3dlTWpnVTBKOExSV2lreVJnelBUR05rQ1Fp?=
 =?utf-8?B?eU1aTzNiVko0NlJZSSsxNGRCaTJxMXJENlQ5cGMwelNWUGhJV0JwaFZybHlI?=
 =?utf-8?B?VGNRMnQ3SjkzWFc1Y3dkcFd1SG5jWkt5d0lkTVFTVDhvblYrVTl5dlU0cnlq?=
 =?utf-8?B?MkFneWxyK1AxZ0ZwYmdtM05rQjJSbjBqQ0ZMeVZPVmxjSUxaS1RxbEVUOFRt?=
 =?utf-8?B?U08rd08xSnJDTlIwWGlja1A4VE8zVHFMVGlPUmhvU09OT2o0SHdXMEZRWjVW?=
 =?utf-8?B?ZHlBSWtpM0lyNXFMOUFTakRHU1hZeVEycHBCblEvZDhZMXpvL3JrRGFRemtv?=
 =?utf-8?B?dGJXQVE4KzhzNFdNTERrd09idmN5YzNnUUhIU1BTcEpGVzVQSnV2UElGQ2FR?=
 =?utf-8?B?d09EQ2NYQ0pqUEsreGRVcG1YNFB6TFl2N0cyNy9PcnFRYmtlY2xxbFZ5UmJX?=
 =?utf-8?B?NjNGTzVKZ0JtMzc0S20rd1poK1VFWmlCSFo1TzBoczJPSHJKVTJpU243K0VI?=
 =?utf-8?B?alNsRGI4QWQzdTRaQWJZRTkzK0lLTTlNVUcvclhhSHBTMFJTK0VNWlQxSlpo?=
 =?utf-8?B?QlBDclpqdG9PalJKdC8vM3B2YjF1ZVlOaDJkTXk3dU10bjlnWWMyU0p2YUky?=
 =?utf-8?B?RUFyUTBQOWpQOEs5SjBJZ0Mvd2xGdFhXQW1mekZ2VXp0THhscUJzQUJCZUZP?=
 =?utf-8?B?aDMrcE1QbFBnYTRlQ1BnNVI2OFVkeHpkTmU5QUVTQ0pvUllHaDhlYnFHeGNl?=
 =?utf-8?B?ZjdlMUo4QVc4RHdxSkhIN3F4UEtnREJoU09ZR1I1Ymg0SXRWcHVRcTBHNFg3?=
 =?utf-8?B?YXVGakN2clFJdEVpOHFHVFc5RXBHaGNzdzIycnlPQWRrcjFBSXIrUjE5aWxP?=
 =?utf-8?B?Zm42KytIUjJQNkd4LzdmV2ltL2JwcThnV2RqaCtuUVh0MkFoVExadU1KT2U2?=
 =?utf-8?B?WE9oU2o4VXFRSzhackwwK01vTHVBd1FMRWE1cU5oeFRubGxueTRUVHNRaUZp?=
 =?utf-8?B?QmIrZ3UyR29lclprL2FTY1owS251TWRRS1RnOTArYXc5MlQ3TlI2UElZNkV3?=
 =?utf-8?B?T2lCQVVRNjdKemhtMGVJVGNwK09yWE9QSDg1RUJEL013NXI2bGsrQ2Zjcnlm?=
 =?utf-8?B?cEluWHExdW10WjZWQ1hEY3I5TDdYbGhyUzgvQ3dPZ0tXVXRvT2d4bk9RZWtv?=
 =?utf-8?Q?dLr0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb532f4a-aa71-45e4-1a8f-08dcc1fd1131
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 16:19:44.0219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJTcJGRlyBIHZHeupmJ9TYFtQmJRaQBelKx9BAtvsiOo3+Yc0clguy2pJpnJgdIm4aSjtQBG0OjJxPH9QAvwQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10999

Apply two quirk for imx8mp dwc3 host controller:
 usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk
 usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode

Runtime pm and wakeup:
  usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
base-commit: 82313624b2ae5a943d16475a566b65c873989e9f
change-id: 20240711-dwc-mp-d1564eec57b1

Best regards,
---
Frank Li <Frank.Li@nxp.com>


