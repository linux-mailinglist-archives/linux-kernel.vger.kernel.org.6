Return-Path: <linux-kernel+bounces-382432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA089B0D94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A8A1F25240
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A65020D4F2;
	Fri, 25 Oct 2024 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="TUVfF4wb"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2126.outbound.protection.outlook.com [40.107.20.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0976C20D4EC;
	Fri, 25 Oct 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881657; cv=fail; b=X0/zZzTcsu7Br0e3tZ/Q/S3DWdgp8PO4A4kMZLpowVIXpKstx9oojAoR6wVzKODNG/mp7nIPqK/mF3sAxUsMR7FHq2mx8Rx1/u6CjiRMUXiqeWumGHm86/9sZy0hULWY6arRl2w9t1ryzEMOQeluLLd6R9/iDXNbHyusSVf2CtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881657; c=relaxed/simple;
	bh=RkuscObSxnMTL01jj3Q4VYHkp0y1vZU7w1cOs33XfSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LQXj/GMN0mYLDlRGO5UAUHXSzLlPkNwJtwjP/tWOdrXvpro62ihdbb+6pV4Z5wsn4JG7lLy9K6qaJkm13lNLByRAxepGPlM0uXD4LCBJV8Np9pnu9J1iXaSnxp5+2yekPvfOWVS5kYkXp6pSlugvTe0ht0dLVTF+5/Lmn46e2BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=TUVfF4wb; arc=fail smtp.client-ip=40.107.20.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBqRrS8IaCSpqjGAO4LVMuni3EzRhtvcspBS0txyVVL03pLmza7mHAwQybx+lDFu0FDDRbxd9LoV7W7TsJjah+6sDvx3RP9LezG5pYQMxk91pKpadrPdBD7d3TEXJyQOcMluSeLiAggAmgUYKD6eogeqQkJsBw2cqQ0vMqb1BXPOti3EKbN2khA4eMb3aT8Kq3y7tUy1HEyiP7+it0yncscVlKJwjS11MDQymjVczPwwT4TUWmnNZnU/kgSiz8UZ38eJomyFOyfK/vTrKOom/K0P2R6DrbRI7kdJPeZUUzkiwlADRoESHwuTpIl7gE+mWbYuXY6nK9AOS0MazUfiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUz9VPzrcslSeFzoRB4pm4GOo3YZBbVZkyoedPcYcL0=;
 b=NLmpLwsz2attjpgVdvt1VxKtZOWCF0mBvsW9OBHkkPazRiNI49qHkXRbjshtkNX8bNu5ImvW07n6a9u+T9fh6YY/Rzme86PN2DK7gqDYGuvqnsxnlEEams+ftnXTchybcLBkkYQlBaAUr5U0G85VuJy8aSIY11B2N9obStXYT8AZZi1S3i/jMyO7RRboy0ZoQn2ylP//gDeXK45/hLqM+KVf7CPjtf7TcBJiSS37/XOrLWvN8Qj+zwOtjJ767skQk3Gj3NrYbZ2pQ6MjIZXB7zliKWrDCghDmNC9ogDaP277mrnmPudC0GBQHa8cNAFGjeyYJmo6aERHgtGmgkMB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUz9VPzrcslSeFzoRB4pm4GOo3YZBbVZkyoedPcYcL0=;
 b=TUVfF4wbM18sUIMnCveUSB6IGQwCHnvNuDhPiFJ56LjTxXLxFbkgt6WDBZHenrXLrdlUvXXdmbHNk5efBVZSpUsNBptYpBezV0JAeEgDku4R3F0cwhkjAAaz6WfnrvD3ksE4V4pLZlvl/jYB9fbI8lbMoROUrC5HcyenCRIi/mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AS8PR04MB7910.eurprd04.prod.outlook.com (2603:10a6:20b:288::15)
 by GVXPR04MB9903.eurprd04.prod.outlook.com (2603:10a6:150:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 18:40:38 +0000
Received: from AS8PR04MB7910.eurprd04.prod.outlook.com
 ([fe80::7acd:fca0:f5c0:4e99]) by AS8PR04MB7910.eurprd04.prod.outlook.com
 ([fe80::7acd:fca0:f5c0:4e99%7]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 18:40:37 +0000
Date: Fri, 25 Oct 2024 19:40:33 +0100
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: Armin Wolf <W_Armin@gmx.de>
Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
	corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Larabel <Michael@phoronix.com>,
	Casey Bowman <casey.g.bowman@intel.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
Message-ID: <ZxvmIVb9TNrUsKxI@laptop>
References: <8d70bb6a-c6fd-49de-a494-e97c093827e9@gmx.de>
 <ZxkLz6QBahA7WAyh@laptop>
 <ab6cfea0-a091-4039-94ac-9a26f3df5da5@gmx.de>
 <Zxk5ZwG-61iVP3Qm@laptop>
 <8c4209a4-f6d4-4289-9c57-0ef0188149f3@gmx.de>
 <e1a3a8d980f2c2ff9ffe4f43b91ddffc81d85265.camel@linux.intel.com>
 <01b95adb-3ae9-4619-9652-12a5ddafeb82@gmx.de>
 <73e2e4708cdafe42541eaf047727aa6cf3966248.camel@linux.intel.com>
 <ZxudaA3pCoD4Qlls@laptop>
 <2addb438-c8e5-42b0-80b9-b7320efc5f66@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2addb438-c8e5-42b0-80b9-b7320efc5f66@gmx.de>
X-ClientProxiedBy: MR2P264CA0125.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::17) To AS8PR04MB7910.eurprd04.prod.outlook.com
 (2603:10a6:20b:288::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7910:EE_|GVXPR04MB9903:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d14b727-42de-4b08-9fb7-08dcf5248477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|41320700013|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWJ5V0dCK0ZRenZGZE4vazNKVnFwNzBKQm1keS9WWmVlM0ViMjhtbDVtejRa?=
 =?utf-8?B?RWF0QkZicUw4c3hoQ3VuRTRKZ1cxUHY5ck9jWXZROUhKbm5YRSs2b1I5d1lm?=
 =?utf-8?B?S3RMc1U1eGNZcHdlZDNIdzRONmdVNUp6WG1FbWxUQWZIZGFMUFBIeUdvcldB?=
 =?utf-8?B?MzRLZjdzTzFzdUJQc0RTQ2lOVnphUmdkdlpoM2drbUgzanpEU214MC82eG5T?=
 =?utf-8?B?eDViWTlnRkdqd3VUNTRYSTBXT3l5MEtQZDUxSXQ5bHNqMWFOSVFObUZscE5V?=
 =?utf-8?B?RmdvN05oK29jcVV2eHlNUERRSXpTbEpXdkdQdTBDR1AyOGg0bDFBY1g3Y2E0?=
 =?utf-8?B?RmE1VEVQMDFMNy9KK1pXWHM5WkJKcVdqY0dUdGRYRngySjhUN1dYZEJIeFJP?=
 =?utf-8?B?eUtNKzlvOXc2REY3V3RCdk8vWGlySHpwa1ZhVmc1K0NmTms5VVN6dkFCaG9L?=
 =?utf-8?B?RWpGUGdENDJHbWtCQ0lSeklwaXBEWUZJTzVXTjk1S0U0Y3FQUDV1MEFIaHZj?=
 =?utf-8?B?dXpSVGowbzA2L1dCZ3pJV09adG9EVjJUTFlQcEs5K2VOZ2EwcTZidkFmb3JK?=
 =?utf-8?B?V0RNTElVc2VMQlpZaGw2WHhWZTJkcExsd1BiaU0vZDZSQjhtcXNqcWtoeE91?=
 =?utf-8?B?OUN6Z2FJaFVBWmZlZzJTVE10Z05MWTIyVHpIOWJ2SFQrVVdVTWp5Ty8rU3hG?=
 =?utf-8?B?cVRPVlV5ZkFtYy9UekpXOGFkbXUzV01jblVyTG0wcWJQQ00zcDFRUHlmRG51?=
 =?utf-8?B?djdpNTBjaDFaZnFXMFBOMnFTczB6SFdkVUpMOGl5LzB4bmo3WUorK2MvR3FH?=
 =?utf-8?B?RVhFT1FtVzlwNVdudjhtaWpBcFJsZnE5d256TFNodVZjQjNldmlWSUVrMUF6?=
 =?utf-8?B?YVJJODVXVE5WcnJxcEozbmI1bGJaUTBPYmttc0FuWG1vY0tteEFJdmdOYXY5?=
 =?utf-8?B?NFlyVkpUL0M3MlN6OVZEVkdIb2RvZEhYUDU2WGlJQzlGeDBzUVBaejVhZW0r?=
 =?utf-8?B?SnVCV0hCWXAzdTl5b3JPc21KVUFVQlZBUUlaZVZpanNWRWU0T1E5SWxNT3ZL?=
 =?utf-8?B?YVpmZmFxWEFMREJjWUVkS0RCN2tFWEh0MDFqVjh6dWJiMWFvY1dESmcyTTl2?=
 =?utf-8?B?ckRkVGtyUi9NWlFsaUhtcXV3V3Q1NmF4K3VDMUxEcDduUC9oclc0RVdJZ2Jl?=
 =?utf-8?B?UzFaRnBIKy9hTXFrMFN0UGE0QVdUOEh1SzYxMDRCcVZZYlVqMmIzTDhvaE5j?=
 =?utf-8?B?d0dzdUZaNUtTNU4wQVRjTlZJUjJwSDBPWmJoMHRoZW5hQlorb3l0YW1zeHZw?=
 =?utf-8?B?TjlDV3FSTVdMcFdLVHpBNFJaR1EzMS9KTFljTmRsaTljYit2SyswN2FDdCtY?=
 =?utf-8?B?WDE5aG1UUG4wNkNaYjNIRUNabS9ISWlMcDk3aSthN3FiUjFiSG54cUNmVytH?=
 =?utf-8?B?VFU5ZUJJK2dROTRZZENTN0c2MFVjT3p3bCtSRmJ1dkZ5S1dCZUxrenBLWVk0?=
 =?utf-8?B?RmdVbFoyV0ZGVEcrRVlhSkF2VEJ0aGNmMHNPN2cvV1dYUGwrZFRYZ2R4eHdH?=
 =?utf-8?B?YVk3VWJaUGM5QjA1ZFp2SVNFREVodHd1b0U4U2gvU3JCU3hVNndRU2t2aW9U?=
 =?utf-8?B?K0Jrd0lCYURMUTBna1U0SSthTFRFT0J6V0d6SGhsWUJKT25DbG56WnEvREUr?=
 =?utf-8?B?MjJlanV6WEs1cVhvcTk4azRXMVZaSGowbDVKWU9takpNbFlPSXJNT3h5M29w?=
 =?utf-8?Q?qIL/LBxQ1vMxMT1wXFbkiHsus8NNlAv5EoXttvu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXRKNkFWblZaWTRaUGZtZUYxSGxNVEVCZzdGZkI1WERjYVdlNkRwYzJoSS92?=
 =?utf-8?B?RWZHTE1hWGRaL3ljUzF2Y045UTdxZ2lvbllvRDZjMGJhYUNycTFBaUc0MytO?=
 =?utf-8?B?U3FuT0pUa2FkbC9CZUxKL2lFK002TTI4RitWZmpEbEFtWkFTSEc5ditUZU1Z?=
 =?utf-8?B?TmxiUDhPQXNhY2Z4QmxINWRlb0tqNWFtYWVzcWtaaFVVMXJYd0tDK255UjdR?=
 =?utf-8?B?b1dKVm41UUVMWVFDakk1QkJoajNySjhyRUU2SmIwdEt0SkFSQWpqYlk4cS9s?=
 =?utf-8?B?aGtBOExKMmpLTlJBK3ZvYldKMlFrcE9pR0thOUxQYjVOdVJxSVNDM3Yxa1FS?=
 =?utf-8?B?TTNaaWhyaFVWdmdHTDJYV2FCRTZZVjR3RVRIYmtsMlZDSFI3TjRYWXVCKzls?=
 =?utf-8?B?aldLcWRFVHBrbk01Ykl5ZDc5RzI4SEF2ZnVFS091MDI4eitFMzVDc1Y1aGZV?=
 =?utf-8?B?QzV5MWdBVXZPdlkveFZTZ2JLM3JKb2t5elRjUnNmWGZOZmJsSW03cE1UcjRv?=
 =?utf-8?B?RUQ2S2dEWlEwL0ZFMmQrK0pzRDRUd1hTS3ZoSnY4UkdMQ09nN21iS3J3cnpL?=
 =?utf-8?B?b1JudXdocEh0NzhNdFhlUFhDa2tCOGZuNEFVcTdZNGJHZGhHQ1lEUGgvb3Vw?=
 =?utf-8?B?M0hHUzk1T29DTElSUU5uNzNVVGZ6YmRjbmZLL050WUlVaC9MWjA0R3hBTHAr?=
 =?utf-8?B?UUlsVEVyMDNlZlJ2NXg0Q0Fwd1dCK1Rzcm1hM0YyR1VMSGFGbmRSYW9VK1pm?=
 =?utf-8?B?S3hnajJ4aWsyWnBLUnFBS3FuNFN4ZWt5VHhGZWZidHBaclJPcHJOZlZEWS9Y?=
 =?utf-8?B?eUhnY2RNRWhZTDQrdFpoWEZBaTlvRmNRMTlqcWR4WG8xakJaYmI4a3QrRmhs?=
 =?utf-8?B?cXhXSHJqZlhGTVZKRkJFb0dWbHJUZzhXRG41STFreDR4bTZXZzhSSnhvb2Z1?=
 =?utf-8?B?T3I0NDB0c3IxZkQ5MkVVcytpRHpGbGNIOHgraEMrcnduYWg2QTFiUmZXSDZ5?=
 =?utf-8?B?QWFOTDFmamtCeTREZTNmTnlWWE84bk1xdk1XM2FQdW5lbmdlWWxXeXlvSEVY?=
 =?utf-8?B?UFhYS0lwblNja1Rsai9QTlRUNzQvdlBHY0ZrR2tQc21jQm43R2xraGRodkY3?=
 =?utf-8?B?RUczSTdkeVVPbEVOWTAyZ2RBU3pvbURDbjkrOHZNTlM0d3p3R2M1UnU2VnlZ?=
 =?utf-8?B?Q1JMeFBVMEEySEZ6V0g2NWFScFBDOUxpUG5pSVY2MjVITGtCVFVhUXdaWDVv?=
 =?utf-8?B?ZGVvaU1pdURGMWRPVVhoQk9sQzBnM3p1MG8wVmsvZWN0bGg3ZmM4U2QybzJI?=
 =?utf-8?B?VzFaNjRZN3ZjdGxjUU93WGZ6a0ExbjU3YzhQYXNBZVNhQVUxa3I4N3RXVllp?=
 =?utf-8?B?dkF1VEdHVzBjOEhURzNrbG9KYVZsMmQ0Rm1USXRoWFY3RS93NjlwU2d6N2Fa?=
 =?utf-8?B?OEY1emNaVFJMSTVKRVZoQ2h0K0ZTWS9HNkhwR1B2aDBRd3VYMExScFcrUmtk?=
 =?utf-8?B?QkNkb0Jqd0lmdUw2KzRMVnhra3pobGJmdjFvbXpCb0Vnd0FUWnF4cEY4SjMy?=
 =?utf-8?B?ak5wbTR3YlVLWlNmNy9teHhGOFNOTFRTSHJtOUlBZy9PeGRiNllRU1RxM1Z3?=
 =?utf-8?B?NGJ4ZVhGcnFXa3NCN1g5SDN6WkZtbk9reWVIenF3UWhkRjNLOUI2RUI0c2hk?=
 =?utf-8?B?K2lQeHB4amdkRU92K3NMMWd1b2xjVnV4Tkt3QnFzeW1xZTBKcG9kMlBVd0xE?=
 =?utf-8?B?QWExR2ZDaWZWZEVKazBwYlNQMEcraXhJQ0JPTEs3SVZLRStjVGNxWnZIMzJ0?=
 =?utf-8?B?MlluYnpJbUU3QVBJYmNFV3AxQmwwenZNNXY4dlFPYzlkc2M1Mi83WW1RVXE5?=
 =?utf-8?B?a1hXUlJQcjR4OHpwSEZEWWVvdFZDY2pPcmZFYkVYdmlqdUV5T2VvdjU0QStr?=
 =?utf-8?B?UDg5UnZiR2hkaUoyN3JVQTVad1ExLzJDQWtwZnlvbE13eHBXeXB3SGRXSTNO?=
 =?utf-8?B?UzIwTVB1NHZiVVNpNUtjUlV3dkYzcnRjd0FlcUM1U0ZQRmJYaENNZEpUNlAz?=
 =?utf-8?B?eG1VdnRTME1IK2ZXcWR3Mm5EVENqc2hMZFBaTWM3QmI2eGFOWkNteVQydmRM?=
 =?utf-8?B?Nk9QemdNcjlOd3hJUEluUHJqK1d6N3N1ZE9XZGo3ZjlmTTA3Rk9Id3FaOWQ4?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d14b727-42de-4b08-9fb7-08dcf5248477
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 18:40:37.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3HYE1/CXhO5cnVFGnxK1O41BCToOZ+qgIxYfgxKDNjD0nGTySHJoRvSGcQdH1EBucHxGNR+ixFohmpCpDr9rMeZ3oYPBI+dEdv/8JSfzhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9903

Hello !

On Fri, Oct 25, 2024 at 08:33:06PM +0200, Armin Wolf wrote:
> Am 25.10.24 um 15:30 schrieb Mohamed Ghanmi:
> 
> > On Thu, Oct 24, 2024 at 11:15:31AM -0700, srinivas pandruvada wrote:
> > > On Wed, 2024-10-23 at 22:32 +0200, Armin Wolf wrote:
> > > > Am 23.10.24 um 22:15 schrieb srinivas pandruvada:
> > > > 
> > > > > On Wed, 2024-10-23 at 20:57 +0200, Armin Wolf wrote:
> > > > > > Am 23.10.24 um 19:59 schrieb Mohamed Ghanmi:
> > > > > > 
> > > > > > > On Wed, Oct 23, 2024 at 06:31:17PM +0200, Armin Wolf wrote:
> > > > > > > > Am 23.10.24 um 16:44 schrieb Mohamed Ghanmi:
> > > > > > > > 
> > > > > > > > > Hello !
> > > > > > > > > On Sun, Oct 20, 2024 at 09:42:45PM +0200, Armin Wolf wrote:
> > > > > > > > > > Am 20.10.24 um 21:05 schrieb Armin Wolf:
> > > > > > > > > > 
> > > > > > > > > > > Am 20.10.24 um 08:50 schrieb Srinivas Pandruvada:
> > > > > > > > > > > 
> > > > > > > > > > > > Some recent Asus laptops are supporting ASUS
> > > > > > > > > > > > Intelligent
> > > > > > > > > > > > Performance
> > > > > > > > > > > > Technology (AIPT). This solution allows users to have
> > > > > > > > > > > > maximized CPU
> > > > > > > > > > > > performance in models with a chassis providing more
> > > > > > > > > > > > thermal head room.
> > > > > > > > > > > > Refer to [1].
> > > > > > > > > > > > 
> > > > > > > > > > > > There are major performance issues when Linux is
> > > > > > > > > > > > installed on these
> > > > > > > > > > > > laptops compared to Windows install. One such report
> > > > > > > > > > > > is
> > > > > > > > > > > > published for
> > > > > > > > > > > > Graphics benchmarks on Asus ASUS Zenbook S 14 with
> > > > > > > > > > > > Lunar
> > > > > > > > > > > > Lake
> > > > > > > > > > > > processors [2].
> > > > > > > > > > > > 
> > > > > > > > > > > > By default, these laptops are booting in "Whisper
> > > > > > > > > > > > Mode"
> > > > > > > > > > > > till OS power
> > > > > > > > > > > > management or tools change this to other AIPT mode.
> > > > > > > > > > > > This
> > > > > > > > > > > > "Whisper" mode
> > > > > > > > > > > > calls to set lower maximum and minimum RAPL (Running
> > > > > > > > > > > > Average Power
> > > > > > > > > > > > Limit)
> > > > > > > > > > > > via thermal tables. On Linux this leads to lower
> > > > > > > > > > > > performance even when
> > > > > > > > > > > > platform power profile is "balanced". This "Whisper"
> > > > > > > > > > > > mode
> > > > > > > > > > > > should
> > > > > > > > > > > > correspond to "quiet" mode.
> > > > > > > > > > > > 
> > > > > > > > > > > > So, when AIPT is present change the default mode to
> > > > > > > > > > > > "Standard" during
> > > > > > > > > > > > boot. Map the three platform power profile modes as
> > > > > > > > > > > > follows:
> > > > > > > > > > > > 
> > > > > > > > > > > > Power Profile Mode      AIPT mode
> > > > > > > > > > > > -----------------------------------
> > > > > > > > > > > > quiet            Whisper
> > > > > > > > > > > > balanced        Standard
> > > > > > > > > > > > performance        Performance
> > > > > > > > > > > > ------------------------------------
> > > > > > > > > > > > 
> > > > > > > > > > > > Here AIPT mode can be detected by checking presese of
> > > > > > > > > > > > "FANL" method
> > > > > > > > > > > > under
> > > > > > > > > > > > PNP HID "PNP0C14" and UID "ATK". If AIPT mode is
> > > > > > > > > > > > present,
> > > > > > > > > > > > this takes
> > > > > > > > > > > > precedence over the existing VIVO thermal policy.
> > > > > > > > > > > > These
> > > > > > > > > > > > modes are set
> > > > > > > > > > > > using "FANL" method.
> > > > > > > > > > > > 
> > > > > > > > > > > > Although this “FANL” method is not used in the Asus
> > > > > > > > > > > > WMI
> > > > > > > > > > > > driver, users
> > > > > > > > > > > > have used this method from user space [3] to set AIPT
> > > > > > > > > > > > modes. Used this
> > > > > > > > > > > > as a reference.
> > > > > > > > > > > > 
> > > > > > > > > > > > Link:
> > > > > > > > > > > > https://www.asus.com/content/laptop-asus-intelligent-performance-technology-aipt/
> > > > > > > > > > > > # [1]
> > > > > > > > > > > > Reported-by: Michael Larabel <Michael@phoronix.com>
> > > > > > > > > > > > Closes:
> > > > > > > > > > > > https://www.phoronix.com/review/lunar-lake-xe2/5 #
> > > > > > > > > > > > [2]
> > > > > > > > > > > > Link:
> > > > > > > > > > > > https://github.com/dominiksalvet/asus-fan-control/issues/151
> > > > > > > > > > > >    # [3]
> > > > > > > > > > > > Tested-by: Casey Bowman <casey.g.bowman@intel.com>
> > > > > > > > > > > > Signed-off-by: Srinivas Pandruvada
> > > > > > > > > > > > <srinivas.pandruvada@linux.intel.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >       drivers/platform/x86/asus-wmi.c | 93
> > > > > > > > > > > > +++++++++++++++++++++++++++++++--
> > > > > > > > > > > >       1 file changed, 89 insertions(+), 4 deletions(-)
> > > > > > > > > > > > 
> > > > > > > > > > > > diff --git a/drivers/platform/x86/asus-wmi.c
> > > > > > > > > > > > b/drivers/platform/x86/asus-wmi.c
> > > > > > > > > > > > index 7a48220b4f5a..06689d0f98c7 100644
> > > > > > > > > > > > --- a/drivers/platform/x86/asus-wmi.c
> > > > > > > > > > > > +++ b/drivers/platform/x86/asus-wmi.c
> > > > > > > > > > > > @@ -100,6 +100,11 @@ module_param(fnlock_default,
> > > > > > > > > > > > bool,
> > > > > > > > > > > > 0444);
> > > > > > > > > > > >       #define
> > > > > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO    1
> > > > > > > > > > > >       #define
> > > > > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO    2
> > > > > > > > > > > > 
> > > > > > > > > > > > +#define AIPT_STANDARD                0
> > > > > > > > > > > > +#define AIPT_WHISPER                1
> > > > > > > > > > > > +#define AIPT_PERFORMANCE            2
> > > > > > > > > > > > +#define AIPT_FULL_SPEED                3
> > > > > > > > > > > > +
> > > > > > > > > > > >       #define PLATFORM_PROFILE_MAX 2
> > > > > > > > > > > > 
> > > > > > > > > > > >       #define USB_INTEL_XUSB2PR        0xD0
> > > > > > > > > > > > @@ -333,6 +338,9 @@ struct asus_wmi {
> > > > > > > > > > > >           struct asus_wmi_debug debug;
> > > > > > > > > > > > 
> > > > > > > > > > > >           struct asus_wmi_driver *driver;
> > > > > > > > > > > > +    acpi_handle acpi_mgmt_handle;
> > > > > > > > > > > > +    int asus_aipt_mode;
> > > > > > > > > > > > +    bool asus_aipt_present;
> > > > > > > > > > > >       };
> > > > > > > > > > > > 
> > > > > > > > > > > >       /* WMI
> > > > > > > > > > > > *****************************************************
> > > > > > > > > > > > ****
> > > > > > > > > > > > ***************/
> > > > > > > > > > > > @@ -3804,6 +3812,19 @@ static ssize_t
> > > > > > > > > > > > throttle_thermal_policy_store(struct device *dev,
> > > > > > > > > > > >       static DEVICE_ATTR_RW(throttle_thermal_policy);
> > > > > > > > > > > > 
> > > > > > > > > > > >       /* Platform profile
> > > > > > > > > > > > *****************************************************
> > > > > > > > > > > > ****
> > > > > > > > > > > > **/
> > > > > > > > > > > > +static int asus_wmi_write_aipt_mode(struct asus_wmi
> > > > > > > > > > > > *asus, int
> > > > > > > > > > > > aipt_mode)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +    int status;
> > > > > > > > > > > > +
> > > > > > > > > > > > +    status = acpi_execute_simple_method(asus-
> > > > > > > > > > > > > acpi_mgmt_handle,
> > > > > > > > > > > > "FANL", aipt_mode);
> > > > > > > > > > > > +    if (ACPI_FAILURE(status)) {
> > > > > > > > > > > > +        acpi_handle_info(asus->acpi_mgmt_handle,
> > > > > > > > > > > > "FANL
> > > > > > > > > > > > execute
> > > > > > > > > > > > failed\n");
> > > > > > > > > > > > +        return -EIO;
> > > > > > > > > > > > +    }
> > > > > > > > > > > > +
> > > > > > > > > > > > +    return 0;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >       static int
> > > > > > > > > > > > asus_wmi_platform_profile_to_vivo(struct
> > > > > > > > > > > > asus_wmi *asus,
> > > > > > > > > > > > int mode)
> > > > > > > > > > > >       {
> > > > > > > > > > > >           bool vivo;
> > > > > > > > > > > > @@ -3844,6 +3865,26 @@ static int
> > > > > > > > > > > > asus_wmi_platform_profile_mode_from_vivo(struct
> > > > > > > > > > > > asus_wmi
> > > > > > > > > > > > *asus, int m
> > > > > > > > > > > >           return mode;
> > > > > > > > > > > >       }
> > > > > > > > > > > > 
> > > > > > > > > > > > +static int asus_wmi_aipt_platform_profile_get(struct
> > > > > > > > > > > > asus_wmi *asus,
> > > > > > > > > > > > +                          enum
> > > > > > > > > > > > platform_profile_option
> > > > > > > > > > > > *profile)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +    switch (asus->asus_aipt_mode) {
> > > > > > > > > > > > +    case AIPT_STANDARD:
> > > > > > > > > > > > +        *profile = PLATFORM_PROFILE_BALANCED;
> > > > > > > > > > > > +        break;
> > > > > > > > > > > > +    case AIPT_PERFORMANCE:
> > > > > > > > > > > > +        *profile = PLATFORM_PROFILE_PERFORMANCE;
> > > > > > > > > > > > +        break;
> > > > > > > > > > > > +    case AIPT_WHISPER:
> > > > > > > > > > > > +        *profile = PLATFORM_PROFILE_QUIET;
> > > > > > > > > > > > +        break;
> > > > > > > > > > > > +    default:
> > > > > > > > > > > > +        return -EINVAL;
> > > > > > > > > > > > +    }
> > > > > > > > > > > > +
> > > > > > > > > > > > +    return 0;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >       static int asus_wmi_platform_profile_get(struct
> > > > > > > > > > > > platform_profile_handler *pprof,
> > > > > > > > > > > >                           enum platform_profile_option
> > > > > > > > > > > > *profile)
> > > > > > > > > > > >       {
> > > > > > > > > > > > @@ -3851,6 +3892,10 @@ static int
> > > > > > > > > > > > asus_wmi_platform_profile_get(struct
> > > > > > > > > > > > platform_profile_handler *pprof,
> > > > > > > > > > > >           int tp;
> > > > > > > > > > > > 
> > > > > > > > > > > >           asus = container_of(pprof, struct asus_wmi,
> > > > > > > > > > > > platform_profile_handler);
> > > > > > > > > > > > +
> > > > > > > > > > > > +    if (asus->asus_aipt_present)
> > > > > > > > > > > > +        return
> > > > > > > > > > > > asus_wmi_aipt_platform_profile_get(asus,
> > > > > > > > > > > > profile);
> > > > > > > > > > > > +
> > > > > > > > > > > >           tp = asus->throttle_thermal_policy_mode;
> > > > > > > > > > > > 
> > > > > > > > > > > >           switch
> > > > > > > > > > > > (asus_wmi_platform_profile_mode_from_vivo(asus, tp))
> > > > > > > > > > > > {
> > > > > > > > > > > > @@ -3874,26 +3919,42 @@ static int
> > > > > > > > > > > > asus_wmi_platform_profile_set(struct
> > > > > > > > > > > > platform_profile_handler *pprof,
> > > > > > > > > > > >                           enum platform_profile_option
> > > > > > > > > > > > profile)
> > > > > > > > > > > >       {
> > > > > > > > > > > >           struct asus_wmi *asus;
> > > > > > > > > > > > -    int tp;
> > > > > > > > > > > > +    int ret = 0, tp, aipt_mode;
> > > > > > > > > > > > 
> > > > > > > > > > > >           asus = container_of(pprof, struct asus_wmi,
> > > > > > > > > > > > platform_profile_handler);
> > > > > > > > > > > > 
> > > > > > > > > > > >           switch (profile) {
> > > > > > > > > > > >           case PLATFORM_PROFILE_PERFORMANCE:
> > > > > > > > > > > >               tp =
> > > > > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> > > > > > > > > > > > +        aipt_mode = AIPT_PERFORMANCE;
> > > > > > > > > > > >               break;
> > > > > > > > > > > >           case PLATFORM_PROFILE_BALANCED:
> > > > > > > > > > > >               tp =
> > > > > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > > > > > > > > > > +        aipt_mode = AIPT_STANDARD;
> > > > > > > > > > > >               break;
> > > > > > > > > > > >           case PLATFORM_PROFILE_QUIET:
> > > > > > > > > > > >               tp =
> > > > > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> > > > > > > > > > > > +        aipt_mode = AIPT_WHISPER;
> > > > > > > > > > > >               break;
> > > > > > > > > > > >           default:
> > > > > > > > > > > >               return -EOPNOTSUPP;
> > > > > > > > > > > >           }
> > > > > > > > > > > > 
> > > > > > > > > > > > -    asus->throttle_thermal_policy_mode =
> > > > > > > > > > > > asus_wmi_platform_profile_to_vivo(asus, tp);
> > > > > > > > > > > > -    return throttle_thermal_policy_write(asus);
> > > > > > > > > > > > +    if (asus->asus_aipt_present) {
> > > > > > > > > > > > +        ret = asus_wmi_write_aipt_mode(asus,
> > > > > > > > > > > > aipt_mode);
> > > > > > > > > > > > +        if (!ret) {
> > > > > > > > > > > > +            asus->asus_aipt_mode = aipt_mode;
> > > > > > > > > > > > +            goto skip_vivo;
> > > > > > > > > > > > +        }
> > > > > > > > > > > > +    }
> > > > > > > > > > > > +
> > > > > > > > > > > > +    if (asus->throttle_thermal_policy_dev) {
> > > > > > > > > > > > +        asus->throttle_thermal_policy_mode =
> > > > > > > > > > > > asus_wmi_platform_profile_to_vivo(asus, tp);
> > > > > > > > > > > > +        ret = throttle_thermal_policy_write(asus);
> > > > > > > > > > > > +    }
> > > > > > > > > > > > +
> > > > > > > > > > > > +skip_vivo:
> > > > > > > > > > > > +    return ret;
> > > > > > > > > > > >       }
> > > > > > > > > > > > 
> > > > > > > > > > > >       static int platform_profile_setup(struct
> > > > > > > > > > > > asus_wmi
> > > > > > > > > > > > *asus)
> > > > > > > > > > > > @@ -3905,7 +3966,7 @@ static int
> > > > > > > > > > > > platform_profile_setup(struct
> > > > > > > > > > > > asus_wmi *asus)
> > > > > > > > > > > >            * Not an error if a component
> > > > > > > > > > > > platform_profile
> > > > > > > > > > > > relies on is
> > > > > > > > > > > > unavailable
> > > > > > > > > > > >            * so early return, skipping the setup of
> > > > > > > > > > > > platform_profile.
> > > > > > > > > > > >            */
> > > > > > > > > > > > -    if (!asus->throttle_thermal_policy_dev)
> > > > > > > > > > > > +    if (!asus->throttle_thermal_policy_dev && !asus-
> > > > > > > > > > > > > asus_aipt_present)
> > > > > > > > > > > >               return 0;
> > > > > > > > > > > > 
> > > > > > > > > > > >           dev_info(dev, "Using throttle_thermal_policy
> > > > > > > > > > > > for
> > > > > > > > > > > > platform_profile support\n");
> > > > > > > > > > > > @@ -4538,6 +4599,7 @@ static int
> > > > > > > > > > > > asus_wmi_sysfs_init(struct
> > > > > > > > > > > > platform_device *device)
> > > > > > > > > > > >       static int asus_wmi_platform_init(struct
> > > > > > > > > > > > asus_wmi
> > > > > > > > > > > > *asus)
> > > > > > > > > > > >       {
> > > > > > > > > > > >           struct device *dev = &asus->platform_device-
> > > > > > > > > > > > > dev;
> > > > > > > > > > > > +    struct acpi_device *adev;
> > > > > > > > > > > >           char *wmi_uid;
> > > > > > > > > > > >           int rv;
> > > > > > > > > > > > 
> > > > > > > > > > > > @@ -4593,6 +4655,29 @@ static int
> > > > > > > > > > > > asus_wmi_platform_init(struct
> > > > > > > > > > > > asus_wmi *asus)
> > > > > > > > > > > > 
> > > > > > > > > > > > asus_wmi_set_devstate(ASUS_WMI_DEVID_CWAP,
> > > > > > > > > > > >                             asus->driver->quirks-
> > > > > > > > > > > > > wapf,
> > > > > > > > > > > > NULL);
> > > > > > > > > > > > 
> > > > > > > > > > > > +    /*
> > > > > > > > > > > > +     * Check presence of Intelligent Performance
> > > > > > > > > > > > Technology (AIPT).
> > > > > > > > > > > > +     * If present store acpi handle and set
> > > > > > > > > > > > asus_aipt_present to true.
> > > > > > > > > > > > +     */
> > > > > > > > > > > > +    adev = acpi_dev_get_first_match_dev("PNP0C14",
> > > > > > > > > > > > "ATK", -1);
> > > > > > > > > > > Is there really no way of changing the AIPT mode
> > > > > > > > > > > through
> > > > > > > > > > > the WMI
> > > > > > > > > > > interface?
> > > > > > > > > > > I would prefer using the WMI interface if available,
> > > > > > > > > > > since
> > > > > > > > > > > the
> > > > > > > > > > > firmware might
> > > > > > > > > > > assume that FANL is only called through the WMI
> > > > > > > > > > > interface.
> > > > > > > > > > > 
> > > > > > > > > > > Do you have a acpidump from a affected device?
> > > > > > > > > > > 
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Armin Wolf
> > > > > > > > > > > 
> > > > > > > > > > I found a acpidump from a ASUS device with a matching
> > > > > > > > > > FANL
> > > > > > > > > > method. It seems that this method
> > > > > > > > > > can indeed be called using the WMI interface using the
> > > > > > > > > > DEVS()
> > > > > > > > > > WMI method:
> > > > > > > > > > 
> > > > > > > > > > [WmiMethodId(1398162756), Implemented] void DEVS([in]
> > > > > > > > > > uint32
> > > > > > > > > > Device_ID, [in] uint32 Control_status, [out] uint32
> > > > > > > > > > result);
> > > > > > > > > > 
> > > > > > > > > > If Device_ID is 0x00110019, then Control_status is passed
> > > > > > > > > > to
> > > > > > > > > > the FANL ACPI method.
> > > > > > > > > > 
> > > > > > > > > > It also seems that support for AIPT can be queried using
> > > > > > > > > > the
> > > > > > > > > > DSTS() WMI method:
> > > > > > > > > > 
> > > > > > > > > > [WmiMethodId(1398035268), Implemented] void DSTS([in]
> > > > > > > > > > uint32
> > > > > > > > > > Device_ID, [out] uint32 device_status);
> > > > > > > > > > 
> > > > > > > > > > Using Device_ID 0x00110019, the returned device status
> > > > > > > > > > seems
> > > > > > > > > > to contain the following information:
> > > > > > > > > > 
> > > > > > > > > > - 16-bit current AIPT mode
> > > > > > > > > > - 4-bit unknown value (possible values 2, 3 and 7, maybe
> > > > > > > > > > number of supported modes or some kind of bitmap?)
> > > > > > > > > > - 1-bit with is set when (GGIV (0x0907000C) == One) is
> > > > > > > > > > true
> > > > > > > > > I just saw this conversation and i think that the behaviour
> > > > > > > > > this
> > > > > > > > > patch will implement in the driver was already implemented
> > > > > > > > > in
> > > > > > > > > this patch
> > > > > > > > > that got added to kernel v6.12-rc3:
> > > > > > > > > https://lore.kernel.org/platform-driver-x86/20240609144849.2532-2-mohamed.ghanmi@supcom.tn/
> > > > > > > > > 
> > > > > > > > > this patch introduced
> > > > > > > > > ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO
> > > > > > > > > 0x00110019 which is the device_id that changes the fan
> > > > > > > > > profiles. the
> > > > > > > > > naming is not clear because it was initially intended to
> > > > > > > > > add
> > > > > > > > > support for
> > > > > > > > > fan profiles for vivobook laptops but it ended up adding
> > > > > > > > > support
> > > > > > > > > for a lot of modern laptops.
> > > > > > > > Nice, you are absolutely right.
> > > > > > > > 
> > > > > > > > So this patch series is effectively already upstream, very
> > > > > > > > good.
> > > > > > > > I did some research and found out
> > > > > > > > that the status of this device id contains the following
> > > > > > > > data:
> > > > > > > > 
> > > > > > > > Status          Supported Modes
> > > > > > > > -------------------------------
> > > > > > > > 0x00[1]300[xx]  0 1 2
> > > > > > > > 0x000700[xx]    0 1 2
> > > > > > > > 0x000200[xx]    ??? (ODV0)
> > > > > > > > 0x000700[xx]    0 1 2
> > > > > > > > 0x0a0700[xx]    ??? (ODV0)
> > > > > > > > 
> > > > > > > > While i have no clue about the meaning of the remaining bits,
> > > > > > > > i
> > > > > > > > can report that the first 8 Bits
> > > > > > > > contain the current thermal mode. Maybe adding support for
> > > > > > > > this
> > > > > > > > would be nice, so the current
> > > > > > > > thermal mode can be read directly from the hardware.
> > > > > > > > 
> > > > > > > > I also found out that on some models the thermal mode
> > > > > > > > actually
> > > > > > > > modifies the ODV0 variable which
> > > > > > > > is consumed by int3400_thermal and exposed to the Intel
> > > > > > > > Thermal
> > > > > > > > Daemon. So maybe the lackluster
> > > > > > > > performance also has something to do with it.
> > > > > > > > 
> > > > > > > > > a point that Srinivas Pandruvada mentioned about RAPL
> > > > > > > > > (Running
> > > > > > > > > Average Power Limit)
> > > > > > > > > is valid for a lot of modern vivobook and zenbook laptops
> > > > > > > > > but i
> > > > > > > > > think
> > > > > > > > > it's unrelated to fan profiles.
> > > > > > > > > 
> > > > > > > > > a lot of asus laptops that have intel cpus suffer from
> > > > > > > > > power
> > > > > > > > > throttling.
> > > > > > > > > for exemple in my case using windows, changing fan profiles
> > > > > > > > > will lead to max power
> > > > > > > > > changing to the values indicated in the table below (asus
> > > > > > > > > vivobook 16x
> > > > > > > > > pro k6604) which leads to higher performance than linux
> > > > > > > > > 
> > > > > > > > > fan Profile             power limit
> > > > > > > > > -----------------------------------
> > > > > > > > > Whisper                 50watts
> > > > > > > > > Standard                120watts
> > > > > > > > > Performance             149watts
> > > > > > > > > ------------------------------------
> > > > > > > > > 
> > > > > > > > > However in linux, even after changing to the appropriate
> > > > > > > > > fan
> > > > > > > > > profile,
> > > > > > > > > the power is still capped at 50watts and i found the reason
> > > > > > > > > why
> > > > > > > > > 
> > > > > > > > > here is the results of using the powercap-info command:
> > > > > > > > > 
> > > > > > > > > intel-rapl-mmio
> > > > > > > > >       enabled: 1
> > > > > > > > >       Zone 0
> > > > > > > > >         name: package-0
> > > > > > > > >         enabled: 1
> > > > > > > > >         max_energy_range_uj: 262143328850
> > > > > > > > >         Constraint 0
> > > > > > > > >           name: long_term
> > > > > > > > >           power_limit_uw: 30000000
> > > > > > > > >           time_window_us: 55967744
> > > > > > > > >           max_power_uw: 55000000
> > > > > > > > >         Constraint 1
> > > > > > > > >           name: short_term
> > > > > > > > >           power_limit_uw: 55000000
> > > > > > > > >           time_window_us: 2440
> > > > > > > > >           max_power_uw: 0
> > > > > > > > > intel-rapl
> > > > > > > > >       enabled: 1
> > > > > > > > >       Zone 0
> > > > > > > > >         name: package-0
> > > > > > > > >         enabled: 1
> > > > > > > > >         max_energy_range_uj: 262143328850
> > > > > > > > >         Constraint 0
> > > > > > > > >           name: long_term
> > > > > > > > >           power_limit_uw: 157000000
> > > > > > > > >           time_window_us: 55967744
> > > > > > > > >           max_power_uw: 55000000
> > > > > > > > >         Constraint 1
> > > > > > > > >           name: short_term
> > > > > > > > >           power_limit_uw: 157000000
> > > > > > > > >           time_window_us: 2440
> > > > > > > > >           max_power_uw: 0
> > > > > > > > >         Constraint 2
> > > > > > > > >           name: peak_power
> > > > > > > > >           power_limit_uw: 200000000
> > > > > > > > >           max_power_uw: 0
> > > > > > > > >         Zone 0:0
> > > > > > > > >           name: core
> > > > > > > > >           enabled: 0
> > > > > > > > >           max_energy_range_uj: 262143328850
> > > > > > > > >           Constraint 0
> > > > > > > > >             name: long_term
> > > > > > > > >             power_limit_uw: 0
> > > > > > > > >             time_window_us: 976
> > > > > > > > >         Zone 0:1
> > > > > > > > >           name: uncore
> > > > > > > > >           enabled: 0
> > > > > > > > >           max_energy_range_uj: 262143328850
> > > > > > > > >           Constraint 0
> > > > > > > > >             name: long_term
> > > > > > > > >             power_limit_uw: 0
> > > > > > > > >             time_window_us: 976
> > > > > > > > >       Zone 1
> > > > > > > > >         name: psys
> > > > > > > > >         enabled: 0
> > > > > > > > >         max_energy_range_uj: 262143328850
> > > > > > > > >         Constraint 0
> > > > > > > > >           name: long_term
> > > > > > > > >           power_limit_uw: 0
> > > > > > > > >           time_window_us: 27983872
> > > > > > > > >         Constraint 1
> > > > > > > > >           name: short_term
> > > > > > > > >           power_limit_uw: 0
> > > > > > > > >           time_window_us: 976
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > as seen by the output of the command, the intel-rapl-mmio
> > > > > > > > > is
> > > > > > > > > causing the
> > > > > > > > > throttling as it sets power_limit_uw to 30 watts
> > > > > > > > > (readonly). so
> > > > > > > > > the current fix
> > > > > > > > > that i'm currently using is disabling the intel-rapl-mmio
> > > > > > > > > leaving only
> > > > > > > > > the intel-rapl which sets power_limit_uw to 157watts using
> > > > > > > > > this
> > > > > > > > > command: powercap-set -p intel-rapl-mmio -z 0 -e 0
> > > > > > > > > 
> > > > > > > > > this will lead to the laptop being able to reach it's
> > > > > > > > > maximum
> > > > > > > > > power
> > > > > > > > > limit.
> > > > > > > > > 
> > > > > > > > > after doing this, when i change the platform profile
> > > > > > > > > through
> > > > > > > > > sysfs the
> > > > > > > > > laptop will start behaving as described in the table above
> > > > > > > > > exactly like
> > > > > > > > > windows.
> > > > > > > > > 
> > > > > > > > > in conclusion, the asus-wmi driver already has the platform
> > > > > > > > > profiles
> > > > > > > > > (a.k.a fan profiles)
> > > > > > > > > implemented and I think that the power throttling is caused
> > > > > > > > > by
> > > > > > > > > either
> > > > > > > > > intel Power Capping Framework or asus bios.
> > > > > > > > Or the Intel Thermal Daemon somehow does not properly support
> > > > > > > > intel-rapl-mmio
> > > > > > > > or is not installed.
> > > > > > > This was exactly it. the Intel Thermal Daemon wasn't installed.
> > > > > > > now
> > > > > > > everything is working as expected!
> > > > > > > 
> > > > > > > Best regards,
> > > > > > > Mohamed G.
> > > > > > Interesting.
> > > > > > 
> > > > > > Srinivas, can you verify that the Intel Thermal Daemon is
> > > > > > installed
> > > > > > on the affected
> > > > > > Asus machines?
> > > > > > 
> > > > > > I begin to wonder why this thermal daemon is a userspace
> > > > > > component,
> > > > > > stuff like thermal
> > > > > > management should use the thermal subsystem inside the kernel.
> > > > > Thanks for detailed analysis here.
> > > > > 
> > > > > Here the problem is not thermal daemon or INT340x (I am author of
> > > > > both).
> > > > > 
> > > > > The ODVP variable is input into thermal tables. These thermal
> > > > > tables
> > > > > are defined by Asus via DTT tables. This results in matching
> > > > > certain
> > > > > max and min power limits and also various temperature limits.
> > > > > 
> > > > > By default the laptop in question will boot with max limit of 17W,
> > > > > which is limit for whisper mode match based on ODVP variables.
> > > > > There is
> > > > > a SEN1 limit of 50C, once the limit reaches to 50C, you need to
> > > > > throttle upto 12W as per thermal table.
> > > > > 
> > > > > If you stop thermald, yes, you will stay in 17W, so you will not
> > > > > see
> > > > > throttle but your SEN1 (seems skin limit) limit will be violated.
> > > > > Also if you remove the rapl_mmio driver, that will also work as no
> > > > > means to set power limits.
> > > > > 
> > > > > Windows will do exactly same. Meeting thermal limit is a
> > > > > requirement.
> > > > > 
> > > > > But on Windows this ODVP variable will be set to 0 to match
> > > > > standard
> > > > > mode. This will result in matching rules which will set the max
> > > > > power
> > > > > to 22W and min to 17W also increase thermal limit to 55C. So
> > > > > essentially lost 5W of performance.
> > > > > 
> > > > > Here WMI method as you correctly found out matching VIVO thermal
> > > > > policy. But it will not set ODVP variable unless you call a WMI
> > > > > method
> > > > > to set the mode via DEVS() on the same device ID. So although
> > > > > platform
> > > > > power policy will say "balanced" it is actually "Whisper" for
> > > > > thermal
> > > > > policy. On Windows when system boots the Asus service will set to
> > > > > standard and will set the ODVP variable to 0 and will match the
> > > > > correct
> > > > > table.
> > > > > 
> > > > > After Luke's help, I can do a work around from user space to change
> > > > > the
> > > > > power policy to any other policy than balanced and then again set
> > > > > to
> > > > > balance. This will result in setting the policy to standard via
> > > > > DEVS()
> > > > > and also set the correct ODVP variable.
> > > > > 
> > > > > This driver on unload change the vivo thermal policy to default.
> > > > > But
> > > > > doesn't change that to default on load time to match the default
> > > > > platform power policy. So rmmod and modprobe of driver should also
> > > > > fix.
> > Thank you Srinivas for the insights!
> > 
> > > > > Thanks,
> > > > > Srinivas
> > > > > 
> > > > Good point, so basically throttle_thermal_policy_set_default() need
> > > > to be called during
> > > > initialization of the thermal profile. Maybe you can send another
> > > > patch which implements this?
> > > I have already tested this change. But this seems a regression, so want
> > > to confirm first as it was intentional. The following commit removed
> > > the call. If it was unintentional, Mohamed can try to submit a change.
> > > 
> > > 
> > > commit bcbfcebda2cbc6a10a347d726e4a4f69e43a864e
> > > Author: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> > > Date:   Sun Jun 9 15:48:49 2024 +0100
> > > 
> > > Thanks,
> > > Srinivas
> > This was definitely not intentional. I'll write a patch asap
> > I also want your opinion on adding naming changes to the commit to
> > future proof the patch as it has been proven that it implements platform
> > profiles for various modern laptops other than the vivobooks and to
> > avoid any future confusion about the use of the patch
> > 
> > Best Regards,
> > Mohamed G.
> 
> I already prepared two patches containing fixes for the asus-wmi driver. If you want
> i can send the necessary patch.

Amazing! yes Armin go for it

> Regarding the name change: i am fine with a rename of the constants. But please wait till
> i send my patch series, since otherwise there is going to be a merge conflict.

definitely i'll wait for your patches


Best Regards,
Mohamed G.

