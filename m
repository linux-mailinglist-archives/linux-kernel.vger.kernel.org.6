Return-Path: <linux-kernel+bounces-300653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9532195E69D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF721C20A55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0283881E;
	Mon, 26 Aug 2024 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QIHWDJtG"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021103.outbound.protection.outlook.com [52.101.62.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8F33C8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724638322; cv=fail; b=jHctZ+BaxLcfYQrTG1z0i5kz7xQcCFHyfydzxtG12iY7aS2Mqbhori3/e93KLi5LKvVqcmel3795khIykum9JcM/t4nm8oRhoalZNqV1ykNi0iGWQ7nfGbPb2F7j0/3GhbiHdMFCkdiELfFmJJYwg7uZPbx+DyfKvxReVLMRl78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724638322; c=relaxed/simple;
	bh=qr57TuOWggXA2ojbCkHV5vDVEMej5eFfR7NQJE8ZtUI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BEY51GrZOU6fq4wTSDKvep1LvA5WYr7sVyn3zjaeTnDWjjD3HA1a7W+mDUtFNmwJY1PW9E4NK1gdc7oMo7768T2p53v3wYVLbAohXyKhp/V8PIADDHJHNNAlNLdQeHjDigGrmTkI+PyuGb/AfHmT5J4KsbcnjBDM5LjWclIGh18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QIHWDJtG; arc=fail smtp.client-ip=52.101.62.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIFjMrxneMhG+z/RZlkcc+9mgEB3JKUOYPzYukl38cRc1R7GEQdrfOThunUhqtW/6RfwWcaUq/Uy2SAZNRrSKz4hplPPeHhwJruxovHoNpaRgqr7y9NKt8MKryOtac3XUVYPrygj4hmOEbYZTbNUo/wHbP+vq/+ClZ/fi9hQdYea7n6Co5G21rAVamIpD3ufhBQxpdv9cDNkIV7FaY2/XoeuVb0EWxhUXHB9erjcRJO9dHcwQTkMAsK9DDhbQabfx5GREjCeGFLBMSJurUlPmsGGpdBJpYQjaeHZ5OxLrFN8aM978e+i2v6rlChPDpT6St62NesW4xgVGhxmrWYxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Khzt9D+5S1jubdZXQ33VPITjJc3D/2BhyDqrEFHnfjw=;
 b=a106iOzpiZripLZFV2dicew5s8A/W32jRuqnw8Z2wb5TsoX8yWBHxEIlBssa3/qbMlnsI9oM/dB1bA25td1GIvsFFRB346BnhwkXwh2Lk8k/glAs347fU87YWAfvySTXvylnatBALiB0PGlf5nxXMFVJOaDz2SfINlAqM93gOAyXqBPJua/C2iX9B9ifR2marLcdMEJqtpCSsmhCZcj5V/5av3fytAqfNCG2EBq62Ps9+dhrZNMN9XcHanAsn2qQcXoRQG89+SgY3UMtFgVMmZXqcZNCmI5sTOqZkPZwio4Eqb7ofMw1Qf2VOrT4KaYlQyI7FI75Qb+wKnSHwTDqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Khzt9D+5S1jubdZXQ33VPITjJc3D/2BhyDqrEFHnfjw=;
 b=QIHWDJtGHmjtNHBPr3iG3hg8mszhIrm6sMe9uSwBGFzOGlclDiz8OPaFqITFCUPgrT1P0jqjlR+pjOWS8RRzSMOvMA/g7ZR8C7cH90mp8DOYrw6EzS8ad7u8WMYyopdJGAYvc6+nZC1TqljxkAnjS/SoQdcqqodNrtJJRF1R39k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 PH0PR01MB6152.prod.exchangelabs.com (2603:10b6:510:13::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Mon, 26 Aug 2024 02:11:55 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%5]) with mapi id 15.20.7897.014; Mon, 26 Aug 2024
 02:11:55 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: mingo@redhat.com
Cc: patches@amperecomputing.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	vineeth@bitbyteword.org,
	bristot@kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] sched/deadline: fix the bug in dl_task_of
Date: Mon, 26 Aug 2024 10:11:15 +0800
Message-Id: <20240826021115.9284-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::11) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|PH0PR01MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: ff46c31b-cb25-432c-5e31-08dcc57474cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C9EuEU32nJ5cjx0U4lwoRm9YoGTLX98Vvz+KMU1mg3aZkUaHTDtGB+9UtuKC?=
 =?us-ascii?Q?WdbVEHpjGPIbA3Y63W7YL35jUaeaPwn+fNcOI+wQayalxKwxjft5QwPXeXqs?=
 =?us-ascii?Q?zQfGgedNpRyhSR20R4pIY+YDUHSV1nKgpytKyp3faCICU1CAjML9aHbhZG8j?=
 =?us-ascii?Q?E5/ZlH3rVHo5XgtB2e3+RkbnuCDL/2qMQDKUE0Mpd0dE5UAbeqDO5O5UKWim?=
 =?us-ascii?Q?KmAg/06i7KenTOW8c3k0Jrfzp9+N40s8pFlKMgLZjZMzErIvThq6xhVBNUOn?=
 =?us-ascii?Q?TeTsIW/AWixTMjTHE5SqGnTHesScTpjLL//jEzTOairjbj3CnEoYTHpjAcdM?=
 =?us-ascii?Q?19SlYMcw+3HiR0tBocSXoi7IRWpkC9EYnN4lX5etiXAzywj/1+GNzVWz7P5f?=
 =?us-ascii?Q?jH0T0Ce6FlDXPYphm7ilWStCpqRwU1Btegxm2J0YYLsUEFKbillMDo3y/6T4?=
 =?us-ascii?Q?T5O1HLJMrjfS3KcHxhgqDRLRemTQ5g4pCK4b47X8v1m9Jqb8u2ZpW5NRM3Ox?=
 =?us-ascii?Q?LXLwRjlxGEeuc8z1SFsH09dlPc4fQ825tXrMxc4RHVU19TeaoDTAfA+8/V7T?=
 =?us-ascii?Q?jh5vQtUt3FpgiKpESlxsmhUcPjKxSGgEkqgGulQL3ptF6Qvorjnc0pxkbT/u?=
 =?us-ascii?Q?pR2xRKUYdtaVHazd/EElC0gBbb/KH5DIe1UwqVeWcxaoA717tZrX/auOInTO?=
 =?us-ascii?Q?KTDBLDeJes5ZK04xsgpcHmt8B2rDRum72jfMFStocaU80bT7fBwunHtEIOK6?=
 =?us-ascii?Q?WeOtvejb8AAm8+TJIUCxKYxAqQ1dCRw2pf7I9VY22hqGMpTERxMwThFzZNVe?=
 =?us-ascii?Q?CEgbVA85GUzw+chwV2xKpEVRoDI6WFSLYgtfAMnx6naW5dCSSyABA8Uxq8ts?=
 =?us-ascii?Q?U492KnjVm3r2p11dGUsCeOooSzWndKmkaVLibQZq+OCPQ3C0VpQOLhrG+4dX?=
 =?us-ascii?Q?wSdvem9FJmsUWHAeNT0TYK9oc56GHFUFJjZJ2vHl+x73MObGT6vx7e7kOZsK?=
 =?us-ascii?Q?G5iOGywXXY7RfO5H9naIqgbuWBFgpS/69gVMCNGGwA5yYFEstjaHAtAFUEPA?=
 =?us-ascii?Q?fvT8fDOAHchKDnCe0zSKXk3dZEC7H+7II1k5fMlurVElRlNvPr/Mi6+oGTnw?=
 =?us-ascii?Q?IXgFxO8TgLyzpn7H5aHKijGSyrD45Sk034x+EUUPCJrO6XesS9d+UvqulWsU?=
 =?us-ascii?Q?JcI7gIqiLcr7rdyylh+64W+AF9GvPfKJS6xGBohRUJTx5d/rATK4+RBUSa2G?=
 =?us-ascii?Q?SGy0mIbbZkOKMDmvUCv3l5bG4BbGYjTC8PTZ8dMwJihjHX6ApkhnksMAzGmB?=
 =?us-ascii?Q?kQyqVzD4v+hMgsWRxSeYkJZUYtL187dDlzrrv8Kf8L2NtPWBCiCenGU4zSMD?=
 =?us-ascii?Q?1qLCM/xqD5Ee+xYoKIONQpeMl6NSCdC5xsH9o7I5LWXM/f2Lng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zw05Y7E1jTZMyrQVTjg2iGdCHcQ9lOtG6QG0h/IhJDtH83q3s73yIbYHUq7a?=
 =?us-ascii?Q?EemrB9EqVhKA+7s3KzYJ+sZ/k77GPclHAHthpuq+YDqeeDVIucflB8R+tqOH?=
 =?us-ascii?Q?Wa83ys/JtfsgpdOCOyT8Oh8GalsSlk8t2rQXI7su2PU+C/uuIkb6C9t9s+EE?=
 =?us-ascii?Q?2VBc8wbsmkIusbljj4liE/AsIN4B/TVDL2UBXhHLtj+NuY7wr5zTneGTVHC4?=
 =?us-ascii?Q?bTW6J3RDD2weVErV9fsdMvayeBYrMQgQBlf4j0lIBfcQXS4WiG5pstMyQJIn?=
 =?us-ascii?Q?FZLHJ9qsM40puk2WqCMj9qyeq06bFLisQRqQYaYTGsfRz97Cy3VKebE2Kie8?=
 =?us-ascii?Q?cE4KmKnL0yVjaNNg+4gHZI53xopoUZ7sgLv9YcUQWUedVzW4lwzE6MNy/dEX?=
 =?us-ascii?Q?9W50UpydGmZd/LtjQ323Bsuc5Fdqm0yCdarj71WeZyFGafbAXhzsIK+N+SsG?=
 =?us-ascii?Q?ob2mIpE0J3d7/T2lNdVvj4gvR8YUvgIB+00BqFGsJcsjFBDyB/aWDcv4f05Z?=
 =?us-ascii?Q?UN/mLSDdRfHuMnP/8kAv5Z1P4CaPSdHRYbiWIXkodWlIvE1rM78+2aNyLI28?=
 =?us-ascii?Q?lu5JU7ulh2H9et2WjNx5976MpbxTa5xYbbBLa0XG8uWG/MF2gu9/2Mq2+XAY?=
 =?us-ascii?Q?JhgivkkGNYa+ZQ0kZZoai+rwL0FK86G+tfRJko/iO6sJUrLtq+kKEdlE70/X?=
 =?us-ascii?Q?uJOnOsH+Rr/S1a8tTQxaO+KxtFRUN2/89gU8WJHMTFy5cVvptkhee6goHWvI?=
 =?us-ascii?Q?CDAN/AQfPShpz10KIBKUEldcUtdm3EJBZ48j27+OAOHwm+hs8LfJDvw5mMMm?=
 =?us-ascii?Q?OiJJqM1cD6k3fgG7tBVTNoZnDPxfEC3bP9Gprqxt/gbOF6W6zf1mmAC3223B?=
 =?us-ascii?Q?Z19mB+gV46ERXnMC0YdXm+UQRxxjKUcP0UioB+cIAhUZCuZRi398T65uWgIB?=
 =?us-ascii?Q?nu7HaoTy7SS/8W/OETgHzI43YSu4Gy6RmYc+UqtdNV7JJkTVfjGX38ObC8qM?=
 =?us-ascii?Q?+98tnQRHjeHKSunZ/qtHa1qe8C7dM6iLgca5gO6aKvp6T8bnR+U7+uA0gOhS?=
 =?us-ascii?Q?G4bHsaD03JyMcKgjuzgOZ6TMhSRngEvsDKicR3fDf8x81us5MjkZ9MPWIjfa?=
 =?us-ascii?Q?hQutgWinjIuzhK5AHxcCaW/ioOOyLNNcjXnTVEfJGGu9NQ4vSRbgkJtjpaBQ?=
 =?us-ascii?Q?lBDKn5N98AoabASETqtuiC0hte5A2KfqJGd8xjLnr7RMlwEvq+0w8yPc3WhB?=
 =?us-ascii?Q?mKGvetSIDCH1zm5hwcStph6PALOiQWNacKQ/Ni27zbt42HSH1oLzMDEWiy+k?=
 =?us-ascii?Q?Qo3iCflKYTiAhufe2qRK+bZBd/jKhn0Qlzzj9VkqPcxvt0gsEzBBccuxBalB?=
 =?us-ascii?Q?ZZFURirOpU95ZuQVxNaavYeKbNzWBAhKGPbzjG66qJMQPOQGeQ4mlIj4Vr8m?=
 =?us-ascii?Q?3mwBE+MbY6fO86xiNorfoCyIV0FuFBExdGg0FoUp2iQQ+OJIeJXHSa34XgCw?=
 =?us-ascii?Q?T4yY+h+X9UK1Li6Ae6cZIGMHQTmQwl7DkD0AiBwIyqRl6eyf6ZlX3YM/u+NL?=
 =?us-ascii?Q?/p6RLSHOpC4mq3+68UoJTGEqwTrJbL0BpUHAwQ/zxua5GbFpQexq311PQUCP?=
 =?us-ascii?Q?uCt4e8Z8nZZJtZTczxDyzJ4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff46c31b-cb25-432c-5e31-08dcc57474cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 02:11:55.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uVgLAJmO87XyqA/OS/xZyy42Ii8LPPhb6QxxpYqX/1ibIb+oBFs/bq8LMo03Ged9bVYSd1hsrX5zQ3mj9roSfO6owZU8zwemeougqbkYVs52b/z9tH+6R9YIn/f1TXW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6152

When we enable the schedstat, we will meet an OS hang like this:
  --------------------------------------------------------
	[  134.104253] kernel BUG at kernel/sched/deadline.c:63!
	[  134.132013] ------------[ cut here ]------------
	[  134.133441]  x27: 0000000000000001
	[  134.138048] kernel BUG at kernel/sched/deadline.c:63!
	[  134.146478] x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000001
	[  134.153607] x23: 0000000000000001 x22: 0000000000000000 x21: 0000000000000001
	[  134.160734] x20: ffff007dbf1b6d00 x19: ffff007dbf1b7610 x18: 0000000000000014
	[  134.162027] ------------[ cut here ]------------
	[  134.167861] x17: 000000009deab6cd x16: 00000000527c9a1c x15: 00000000000000dc
	[  134.172473] kernel BUG at kernel/sched/deadline.c:63!
	[  134.179595] x14: 0000000001200011 x13: 0000000040001000 x12: 0000ffffb6df05bc
	[  134.191760] x11: ffff007dbf1b6d00 x10: ffff0001062dd2e8 x9 : ffff8000801215ac
	[  134.192036] ------------[ cut here ]------------
	[  134.198888] x8 : 0000000000000000 x7 : 0000000000000021 x6 : ffff0001764ed280
	[  134.203498] kernel BUG at kernel/sched/deadline.c:63!
	[  134.210622] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff807d3dd24000
	[  134.222787] x2 : 000000028b77a140 x1 : 0000003400000000 x0 : ffff007dbf1b6c80
	[  134.229915] Call trace:
	[  134.232353]  dl_task_of.part.0+0x0/0x10
	[  134.236182]  dl_server_start+0x54/0x158
	[  134.240013]  enqueue_task_fair+0x138/0x420
	[  134.244100]  enqueue_task+0x44/0xb0
	[  134.247584]  wake_up_new_task+0x1c0/0x3a0
	[  134.251584]  kernel_clone+0xe8/0x3e8
	[  134.252022] ------------[ cut here ]------------
	[  134.255156]  __do_sys_clone+0x70/0xa8
	[  134.259764] kernel BUG at kernel/sched/deadline.c:63!
	[  134.263412]  __arm64_sys_clone+0x28/0x40
	[  134.272360]  invoke_syscall+0x50/0x120
	[  134.276101]  el0_svc_common+0x44/0xf8
	[  134.279753]  do_el0_svc+0x28/0x40
	[  134.283058]  el0_svc+0x40/0x150
	[  134.286195]  el0t_64_sync_handler+0x100/0x130
	[  134.290546]  el0t_64_sync+0x1a4/0x1a8
	[  134.294200] Code: 35ffffa2 17ffffe3 d4210000 17ffffb4 (d4210000)
	[  134.300283] ---[ end trace 0000000000000000 ]---
	[  134.304890] Kernel panic - not syncing: Oops - BUG: Fatal exception
	[  134.311147] SMP: stopping secondary CPUs
	[  135.365096] SMP: failed to stop secondary CPUs 8-9,16,30,43,86,88,121,149
	[  135.371884] Kernel Offset: disabled
	[  135.375361] CPU features: 0x00,00100003,80153d29,d75ffea7
	[  135.380749] Memory Limit: none
	[  135.383793] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
  --------------------------------------------------------

In dl_server_start(), we set the dl_se->dl_server with 1. When schedstats
is enabled, in the following:
   dl_server_start() --> enqueue_dl_entity() --> update_stats_enqueue_dl()
	__schedstats_from_dl_se() -->dl_task_of()

we will meet the BUG_ON.

So just remove the BUG_ON in dl_task_of to fix the hang.
Tested this patch with memcached in Altra 2P.

Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 kernel/sched/deadline.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0f2df67f710b..76cce7adcb7d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -60,7 +60,6 @@ static bool dl_server(struct sched_dl_entity *dl_se)
 
 static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
 {
-	BUG_ON(dl_server(dl_se));
 	return container_of(dl_se, struct task_struct, dl);
 }
 
-- 
2.40.1


