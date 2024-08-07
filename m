Return-Path: <linux-kernel+bounces-277862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D88B94A76E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D25B27307
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DFA1E3CA4;
	Wed,  7 Aug 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="by4om9Xv"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7B31E2880;
	Wed,  7 Aug 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032256; cv=fail; b=ML/pvF/wdMHKS6DCogp2Mo/S9JNgLHveazs6j/7Ab6E0AwXiIz6/7Z5tHflw1t17V2hfULuZT1f5iGwYrflB40oCs1Fds8LUXz7JQoF9amJA9QzTazXXCXWPu28Ko2j3VFWg6Skq5r8irB1fKT+Gsa+X27SWmEI3fNKBehmOcsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032256; c=relaxed/simple;
	bh=l7aZaUiT4sXN+cNqE9Mkyg9B2WtoqHT3a6BvSYCuoTY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fcj+tgzJyCvXf/a76thIZGtWaLPimJYQQJZtd1Ao8MI8PApL+eREf7q8eyfFX8B3ujn5uLWkla0Ougiq7UsJh88fXODzoL+56fXUlVYmOimcP/bzUaJbHEf1Ne/hQxhTMXFsX/s2as5ogVnT0uU7cfNow+c++iYF4SWGBHUIxGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=by4om9Xv; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCTqlMMCZ52hhtXwGt/LxpgCKNlXJkTWmpe4Ewc4o/DnV6/SEg0FEmMN7r48cXukzZD/xpf6SuImxKsuMQ8BTcqKY5NPJGcHmJgun+AYITPaM80ceyKDNfln0VtIO/sMaXYtRg2XsnfBZMBugqLPhlt3jcHUpj7FJguhVhB12Ss/wHQacmwCrKVU4LO2tJn2t9sWuBv57Ii13duYYpygCpIY6Y6zVeIbvfLvcA3jI7MAjEZ8NiQ44vSHrreKjZjmb+HG+liWyUH0gZeLQC2/UBSKVS4SHFPM9NtjTrwpRRAcbucGPG8Xvq8xFTwx+i6ae2PHSUA1CCgaSh21evi2Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rop6eQYOZt9R/GCsnj4EGVVeuL965OM+9orug6t738=;
 b=tGbMYmfTNa5wihil0M3jCtxy8rRvffooC0F4RluWnMsZJGy0WzM1oMibWC7UpxTHeWkIQEV565q/xbZSPduqi3raGvetpKNIaUWetXgq6GaCEd+I49EaCUJD7DdP5jh1mSebCmpDshH2eirDX0AuglUHsnTdEfGRcgnFTwPYoJmvQwr77QS90baw3w8aZrWifrOb6/zwyTSi84QHFRZ4YziKLrfVwPb+PEc+jZWjo+CA5iDePSG8gZASRrEaY4+0jGP43EgCGi/4GWwaU4FDy2v7u9Z0R/hVqT/T2EoBKFVJkqaB54PMeStSUO38VT+aC3sMdYiU48rwFr8AA4Vyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rop6eQYOZt9R/GCsnj4EGVVeuL965OM+9orug6t738=;
 b=by4om9XvPjuaeMgrve0JG/JvSgGYJChpeQmD5Gpn1ew8i7iub+e+Wv0Kt4jYtPyTBvOfwKHtwBFcFxR4K2cEHYsZXjamYlJCSfZCyIXql/CR4biz0EXs2oWyl6UTgnAaCsGILlWgOFPNXZ7bGh0neU21ABVZog5cn9667W3YTDkPwqkZm/rchBk7jS4eA9B0R/8PorhyZJSQlgVt2h0soUJKKK/WY+0oqLf7q2YWimd+Wvai4NZUlEAYoq/ekiBQ0tcMjNCcD+xp3nEz3DiXg+xJ/jrpv9CMFFPu4Behujw3fJMYXxp4FMI40VT6pfePaNl7RZVpuoSN1r71SemfCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AM8PR07MB7428.eurprd07.prod.outlook.com (2603:10a6:20b:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 12:04:11 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%5]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 12:04:11 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH] of/irq: Consider device address size in interrupt map walk
Date: Wed,  7 Aug 2024 14:01:54 +0200
Message-ID: <20240807120153.1208858-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::11) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AM8PR07MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e9ed6a-f114-4b41-acda-08dcb6d90c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HD4hCruBNsG7fwNkDINDEeEyrhZWcNDGkSh1YScEm4Xnq6OzyF0VhEqZg+6j?=
 =?us-ascii?Q?M0wpKWQ8CQRTYYdjG6RNb4pMPOg4uilP+VM4/WsXcYU1GCKpSLoZSZjCLb6Q?=
 =?us-ascii?Q?hCvzpS70Ty99BP/QKy5gLd5i4S9z2DeEFRTWAsj3+4Kah4iWsGPCMt5cn+SX?=
 =?us-ascii?Q?67R3nfxvgMBVlLaSQxmOS2lidSNLpASO5Ptdct+bW2tOVCiIFAf9u+bVeS7w?=
 =?us-ascii?Q?TNIDDR9yL08fw1agWnp1BNpfV1NWaoF27290tJA/3yxIEDNFp740FuXsadhi?=
 =?us-ascii?Q?kPhElt9wBTvYVXEGSH/RwmnNZugv6we3kazSoDc0IGw1b8i3/o12xqE8MsxG?=
 =?us-ascii?Q?gYZ+XRyEi6H2TTnfIP582j+J2EtY09OFC8AG/tFB9DWWF6MapuhvhUSnNlHz?=
 =?us-ascii?Q?3RfAmc815LyEp7SSVz4RbSPGYUyDtd8Pm3vZartg/+yBba+caVse1a1QvaTo?=
 =?us-ascii?Q?KI4a2xOUeAJA7q7cbC59PygTaHlGjt+yvAnbXO+fa7r1wszNrEukA1mSQKML?=
 =?us-ascii?Q?O2B020FyN/i08+OL/yepYhsiml76yuGd+n1JPfVVcDTLIYGY1oQQgtaUk4xf?=
 =?us-ascii?Q?eaz9mp4Hvk0wuI5T835yyGR4BsmWJmQFGHqoXjhWYGZbPBgX9UWT+Z5V5O/f?=
 =?us-ascii?Q?hmPVm7bZ9I5oR3oIC7N16dPxDir4PrsGtVsF1YhVhM9RRLHuYkRAM6X8SMUQ?=
 =?us-ascii?Q?+Vx6FRO5osM70wcGVjH8EFyOoofr5fSWfhGDX5ig+H09MdeOnUeGi/zY10/x?=
 =?us-ascii?Q?46bYeMvcE1GCqXbQzwhs0U+BjLNFZzRRA3kUDTlPidhUKGVIfvrHhUNdV0QQ?=
 =?us-ascii?Q?CPt1xsEB+eNjJPwsMGaarYj5OikZPIu6cT59ruvz7ofIdtvAyofD8caElwSm?=
 =?us-ascii?Q?fCZWTnKHbysD25LQLsr89tmWXegHQCZTNLZwtys/vO6LLibKaRaN4RtAUILS?=
 =?us-ascii?Q?CkM/S6M9koZftbMxUVsJtzR2GW2ibxgdTyB/xT3Fq8DOPwytCpg2v+bR1qk5?=
 =?us-ascii?Q?ySyK5vXOQHL1sPqyPMjEtXLtD0o3jatB91QObC0A0lLEY96GuLhBJHWlgKCv?=
 =?us-ascii?Q?rogaQ1vixQ2sZhSOsQQBxdM04/aqF+CIc3aAN7G/lb1pXyu4jo+HKRlXMFOf?=
 =?us-ascii?Q?MSoOliwy6eCCWqbVwZWTap4o8jTCJ55BFq2kLtlcbQmd5zEaAnDS3XShULjk?=
 =?us-ascii?Q?Z8mXApxdDCfxxSf7/uwiV6gToWD97a60nbYjjlxCJomx2qrBIW1Fz7wY88eo?=
 =?us-ascii?Q?9fsQ5GsqKwAvy2gI70FWIamlVvpE5ZxT/t54TKu0Wi1nr8YKI3uyFie24CrV?=
 =?us-ascii?Q?+YpOhGU92Xqv29P1CQKc74Xih3WgBvRT5ZKlG00moKM5TBMLhBC0M7H9Adg/?=
 =?us-ascii?Q?4wOq6pl0DZpf/Mz3rZm4DyBTJDMyRJCmNMVsq6upE+t9t1A03w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NkML66lE5sqgwBH7ZqDUJWZ3qWImlVNhQdiScR2fbNKi57EMAeQ4lLTOgfXA?=
 =?us-ascii?Q?TIX6HVXF88idO5MdPVism4wcbIvfgST+vsbyPVh6gsbhrKaesb+0mRP/OKto?=
 =?us-ascii?Q?oASC7CRV6ZxIVMJaUDCB/Eo54Q4SBsgwFRG54k+1YWhSrDg5jlo0VH5TBLVj?=
 =?us-ascii?Q?yDzh67nDOXggiL+8j0iwhBPRoru9JvgVSfoUdE7d4Zv6pF86h9Lk/agkamWN?=
 =?us-ascii?Q?IEfEEcV6YJRXveouDSYxubaWWRoLrUk74VEnvTJdYm1ImKmCCKYzO4E1P+M2?=
 =?us-ascii?Q?4zmgB0sxDyJf7yFjk/z4+b6WgQEzH0KA1lJh1QM/rU1QiAWVMQOUzZ8kcSAG?=
 =?us-ascii?Q?kFO95P0rLD4vC7f838NdW+pKvVgmKST9jFQFaaCFURH/woOc1mPIzj2Z+fPx?=
 =?us-ascii?Q?eDzsdPSfQ0zaiQrNIkSNrB3Ke8tXTPpWFWZQZ3UIjG83AzxW+1kxTEeKVMbj?=
 =?us-ascii?Q?Vsy85Dt7fbABWXEilpCGcWv5Hiegdpak4p4ZerQgOXXzxSFyhpWLnY4c2RAX?=
 =?us-ascii?Q?gJWsdAiJD9eIVqEce/EzIye8I3qr5OAq42bzDXrGliRy7ZDtlQXI4P7mu7lQ?=
 =?us-ascii?Q?5/VkdQ6CVqajgBveaUzcHJ/qwG5hHe/T9Zf9kUrokPeB6PREE2+3zSgWXb0k?=
 =?us-ascii?Q?sXEJTGV9KdE5K49ODfMqwg+NsH3C/PKX5am5xv3Sr4jAmg1J1GZNvVuYrKx9?=
 =?us-ascii?Q?x2ZdU8Ifkoe9BHoonNUlDY4KFFk2l5O20qg5b5r0tIvmvl8i+2OYetm7/K+7?=
 =?us-ascii?Q?29KEs4WVpzDasq3dL2hzl5fEh95gUWS+KyiqRqK4emU7hOEbp8pIut5k0ZTv?=
 =?us-ascii?Q?1tTFLtEfqXRtoVPh000AsT2p1lmZQ/Dkt9kM8yF6ftI7CZ1GgjnaniiDlKDT?=
 =?us-ascii?Q?v3GCi2WY6mn6OAjgY7yV1JsVjA/+LhRO0jGmet/6MsI7UEEfsn0okA6nto2f?=
 =?us-ascii?Q?vLEblcOx/5o2L9p4Pl5X7KMEro0hrAhWigmhSefV3ME5ZhOh1y1bvU4+DV1H?=
 =?us-ascii?Q?LGckAq6KDTRvYm0rajAmMcFBGt99nbvr8MaNk7gx0FcOL0UuVXnnnR8R31Vy?=
 =?us-ascii?Q?HNzUBRARgiThQIdw1FdxI1VzULdGXNvlhJRmOD+q5lV9OjJmcUj0SJ5Hz+ds?=
 =?us-ascii?Q?5r22x0G+S02YcSg/1F7LB56JKKQwVxsgol7mdlhx1H06JA46s6F2oCfgkGs6?=
 =?us-ascii?Q?a/oH2dcJYchcP3Jc16i8EcK3GzMr+dDfKk+v1VH/h840a8+HyxzD8113bcLP?=
 =?us-ascii?Q?+HIhOCnkoAAu3AbNj/tAsib+8hCa8yhbKjhQECA7Z+IiyLFNBT8qHM0dmlTa?=
 =?us-ascii?Q?yqLU9Rc24vPj8+wG0ZyH1MVoEFGVsooYuj12Vz9T7S9zK50Upf1C+5pWKwUe?=
 =?us-ascii?Q?Zbx6IDrBR0VlH32Fe5C9HDCZFRGaYI+TiY9CbHHcOvnz8g/hiWPD00Hfoff6?=
 =?us-ascii?Q?uCTwswSVORP0qad6kWZERP0vaFmUxkbxoQIye392+VKqWccpRfdGdIfwzwVI?=
 =?us-ascii?Q?Il88rvuqiE8W2sT0ma6jsfpL7R8My6xlAkEKGEqKdQ3lu7C2/rAICoby4vfx?=
 =?us-ascii?Q?av8l9/by9qdNU4XqPLOYJGhZN6ZdZ8LF930hjrNUA0aJwv343qQv+RJ22uFs?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e9ed6a-f114-4b41-acda-08dcb6d90c39
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 12:04:10.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9bY43CbK5oQ3M4KYryCPipiQWAgt1X9azEZn0OOsFs32ctW+XIWATp7YaTLXatGZRnFVQ462kkxY8ZzNvy5G2opwGRZe6EkXYOW1wZy4QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7428

When of_irq_parse_raw() is invoked with a device address smaller than
the interrupt parent node (from #address-cells property), KASAN detects
the following out-of-bounds read when populating the initial match table
(dyndbg="func of_irq_parse_* +p"):

  OF: of_irq_parse_one: dev=/soc@0/picasso/watchdog, index=0
  OF:  parent=/soc@0/pci@878000000000/gpio0@17,0, intsize=2
  OF:  intspec=4
  OF: of_irq_parse_raw: ipar=/soc@0/pci@878000000000/gpio0@17,0, size=2
  OF:  -> addrsize=3
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in of_irq_parse_raw+0x2b8/0x8d0
  Read of size 4 at addr ffffff81beca5608 by task bash/764

  CPU: 1 PID: 764 Comm: bash Tainted: G           O       6.1.67-484c613561-nokia_sm_arm64 #1
  Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.01-12.24.03-dirty 01/01/2023
  Call trace:
   dump_backtrace+0xdc/0x130
   show_stack+0x1c/0x30
   dump_stack_lvl+0x6c/0x84
   print_report+0x150/0x448
   kasan_report+0x98/0x140
   __asan_load4+0x78/0xa0
   of_irq_parse_raw+0x2b8/0x8d0
   of_irq_parse_one+0x24c/0x270
   parse_interrupts+0xc0/0x120
   of_fwnode_add_links+0x100/0x2d0
   fw_devlink_parse_fwtree+0x64/0xc0
   device_add+0xb38/0xc30
   of_device_add+0x64/0x90
   of_platform_device_create_pdata+0xd0/0x170
   of_platform_bus_create+0x244/0x600
   of_platform_notify+0x1b0/0x254
   blocking_notifier_call_chain+0x9c/0xd0
   __of_changeset_entry_notify+0x1b8/0x230
   __of_changeset_apply_notify+0x54/0xe4
   of_overlay_fdt_apply+0xc04/0xd94
   ...

  The buggy address belongs to the object at ffffff81beca5600
   which belongs to the cache kmalloc-128 of size 128
  The buggy address is located 8 bytes inside of
   128-byte region [ffffff81beca5600, ffffff81beca5680)

  The buggy address belongs to the physical page:
  page:00000000230d3d03 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1beca4
  head:00000000230d3d03 order:1 compound_mapcount:0 compound_pincount:0
  flags: 0x8000000000010200(slab|head|zone=2)
  raw: 8000000000010200 0000000000000000 dead000000000122 ffffff810000c300
  raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffffff81beca5500: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffffff81beca5580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  >ffffff81beca5600: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                        ^
   ffffff81beca5680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffffff81beca5700: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
  ==================================================================
  OF:  -> got it !

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 arch/powerpc/platforms/fsl_uli1575.c |  2 +-
 drivers/bcma/main.c                  |  2 +-
 drivers/of/irq.c                     | 64 ++++++++++++++++------------
 drivers/pci/of.c                     |  2 +-
 include/linux/of_irq.h               |  3 +-
 5 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index b8d37a9932f1b..8da36f72b7b48 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -335,7 +335,7 @@ static void hpcd_final_uli5288(struct pci_dev *dev)
 	oirq.args_count = 1;
 	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(31, 0) << 8);
 	laddr[1] = laddr[2] = 0;
-	of_irq_parse_raw(laddr, &oirq);
+	of_irq_parse_raw(laddr, ARRAY_SIZE(laddr), &oirq);
 	dev->irq = irq_create_of_mapping(&oirq);
 }
 
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 6b5d34919c72b..57d946305496a 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -175,7 +175,7 @@ static int bcma_of_irq_parse(struct device *parent,
 	out_irq->args[0] = num;
 
 	laddr[0] = cpu_to_be32(core->addr);
-	return of_irq_parse_raw(laddr, out_irq);
+	return of_irq_parse_raw(laddr, ARRAY_SIZE(laddr), out_irq);
 }
 
 static unsigned int bcma_of_get_irq(struct device *parent,
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index c94203ce65bb3..f3610025a7ed9 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -151,9 +151,29 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
 	return imap;
 }
 
+static u32 of_get_address_cells(struct device_node *node) {
+	struct device_node *tnode, *old = NULL;
+	const __be32 *tmp;
+
+	/* Look for this #address-cells. We have to implement the old linux
+	 * trick of looking for the parent here as some device-trees rely on it
+	 */
+	old = of_node_get(node);
+	do {
+		tmp = of_get_property(old, "#address-cells", NULL);
+		tnode = of_get_parent(old);
+		of_node_put(old);
+		old = tnode;
+	} while (old && tmp == NULL);
+	of_node_put(old);
+	old = NULL;
+	return (tmp == NULL) ? 2 : be32_to_cpu(*tmp);
+}
+
 /**
  * of_irq_parse_raw - Low level interrupt tree parsing
  * @addr:	address specifier (start of "reg" property of the device) in be32 format
+ * @addrsize:	address cell size ("#address-cells" property of the device (parent))
  * @out_irq:	structure of_phandle_args updated by this function
  *
  * This function is a low-level interrupt tree walking function. It
@@ -165,13 +185,13 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
  *
  * Return: 0 on success and a negative number on error
  */
-int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
+int of_irq_parse_raw(const __be32 *addr, u32 addrsize, struct of_phandle_args *out_irq)
 {
-	struct device_node *ipar, *tnode, *old = NULL;
+	struct device_node *ipar, *tnode;
 	__be32 initial_match_array[MAX_PHANDLE_ARGS];
 	const __be32 *match_array = initial_match_array;
-	const __be32 *tmp, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
-	u32 intsize = 1, addrsize;
+	const __be32 dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
+	u32 intsize = 1, ipar_addrsize;
 	int i, rc = -EINVAL;
 
 #ifdef DEBUG
@@ -201,24 +221,11 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	if (out_irq->args_count != intsize)
 		goto fail;
 
-	/* Look for this #address-cells. We have to implement the old linux
-	 * trick of looking for the parent here as some device-trees rely on it
-	 */
-	old = of_node_get(ipar);
-	do {
-		tmp = of_get_property(old, "#address-cells", NULL);
-		tnode = of_get_parent(old);
-		of_node_put(old);
-		old = tnode;
-	} while (old && tmp == NULL);
-	of_node_put(old);
-	old = NULL;
-	addrsize = (tmp == NULL) ? 2 : be32_to_cpu(*tmp);
-
-	pr_debug(" -> addrsize=%d\n", addrsize);
+	ipar_addrsize = of_get_address_cells(ipar);
+	pr_debug(" -> addrsize=%d, ipar_addrsize=%d\n", addrsize, ipar_addrsize);
 
 	/* Range check so that the temporary buffer doesn't overflow */
-	if (WARN_ON(addrsize + intsize > MAX_PHANDLE_ARGS)) {
+	if (WARN_ON(ipar_addrsize + intsize > MAX_PHANDLE_ARGS)) {
 		rc = -EFAULT;
 		goto fail;
 	}
@@ -227,7 +234,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	for (i = 0; i < addrsize; i++)
 		initial_match_array[i] = addr ? addr[i] : 0;
 	for (i = 0; i < intsize; i++)
-		initial_match_array[addrsize + i] = cpu_to_be32(out_irq->args[i]);
+		initial_match_array[ipar_addrsize + i] = cpu_to_be32(out_irq->args[i]);
 
 	/* Now start the actual "proper" walk of the interrupt tree */
 	while (ipar != NULL) {
@@ -254,7 +261,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		 * interrupt-map parsing does not work without a reg
 		 * property when #address-cells != 0
 		 */
-		if (addrsize && !addr) {
+		if (ipar_addrsize && !addr) {
 			pr_debug(" -> no reg passed in when needed !\n");
 			goto fail;
 		}
@@ -274,10 +281,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 		/* Parse interrupt-map */
 		match = 0;
-		while (imaplen > (addrsize + intsize + 1)) {
+		while (imaplen > (ipar_addrsize + intsize + 1)) {
 			/* Compare specifiers */
 			match = 1;
-			for (i = 0; i < (addrsize + intsize); i++, imaplen--)
+			for (i = 0; i < (ipar_addrsize + intsize); i++, imaplen--)
 				match &= !((match_array[i] ^ *imap++) & imask[i]);
 
 			pr_debug(" -> match=%d (imaplen=%d)\n", match, imaplen);
@@ -306,7 +313,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 		newpar = out_irq->np;
 		intsize = out_irq->args_count;
-		addrsize = (imap - match_array) - intsize;
+		ipar_addrsize = (imap - match_array) - intsize;
 
 		if (ipar == newpar) {
 			pr_debug("%pOF interrupt-map entry to self\n", ipar);
@@ -343,7 +350,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 {
 	struct device_node *p;
 	const __be32 *addr;
-	u32 intsize;
+	u32 addrsize, intsize;
 	int i, res;
 
 	pr_debug("of_irq_parse_one: dev=%pOF, index=%d\n", device, index);
@@ -354,12 +361,13 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 
 	/* Get the reg property (if any) */
 	addr = of_get_property(device, "reg", NULL);
+	addrsize = of_get_address_cells(device);
 
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
 	if (!res)
-		return of_irq_parse_raw(addr, out_irq);
+		return of_irq_parse_raw(addr, addrsize, out_irq);
 
 	/* Look for the interrupt parent. */
 	p = of_irq_find_parent(device);
@@ -389,7 +397,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 
 
 	/* Check if there are any interrupt-map translations to process */
-	res = of_irq_parse_raw(addr, out_irq);
+	res = of_irq_parse_raw(addr, addrsize, out_irq);
  out:
 	of_node_put(p);
 	return res;
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5abe..5d4b2ec5a3b13 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -506,7 +506,7 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 	out_irq->args[0] = pin;
 	laddr[0] = cpu_to_be32((pdev->bus->number << 16) | (pdev->devfn << 8));
 	laddr[1] = laddr[2] = cpu_to_be32(0);
-	rc = of_irq_parse_raw(laddr, out_irq);
+	rc = of_irq_parse_raw(laddr, ARRAY_SIZE(laddr), out_irq);
 	if (rc)
 		goto err;
 	return 0;
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index d6d3eae2f1452..74268e33d7305 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -32,7 +32,8 @@ static inline int of_irq_parse_oldworld(const struct device_node *device, int in
 }
 #endif /* CONFIG_PPC32 && CONFIG_PPC_PMAC */
 
-extern int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq);
+extern int of_irq_parse_raw(const __be32 *addr, u32 addrsize,
+			    struct of_phandle_args *out_irq);
 extern unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data);
 extern int of_irq_to_resource(struct device_node *dev, int index,
 			      struct resource *r);
-- 
2.42.0


