Return-Path: <linux-kernel+bounces-315220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C808796BF73
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A31128A0D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6147D1426C;
	Wed,  4 Sep 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="jM8e3eFA"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2114.outbound.protection.outlook.com [40.107.20.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBF1D79AC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458417; cv=fail; b=CvFSX0wUT3ySlwT1Ckz/yCx/vqLDv1gc5qwEiTTKcqZDa6GVOqsGPnk4ajBL6pIMSjOPedavXSiH5xyMiABOZy9SgBfM9x2SQ+zAVSHIdgp9YVEidSA7xnlWDnoZSrwyY6iO1caeKCIDnP1L1TmiIC9Hm9z21zwy1qd5gDEHFWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458417; c=relaxed/simple;
	bh=rV9LHZY7qGTmuHV0TeTBU/zenakwJjozIpJ6AeIeZto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aK/S+EGhBMcKkEZM3piYrFq1Gqcf52iuRH427VGRDaQOzezKbORS8ObKB3QvLyrcVprZQ7zk/dzhzDxwg/guyLZYWFaSX3HxOrvfTR0g52M1rmmX5QeobG0lOTx9e71I0BMvlq7aEbInuON/N6Cd9kj6BoggUFiKXn6/dHz0yBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=jM8e3eFA; arc=fail smtp.client-ip=40.107.20.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FClP0ybNW2quDBvf6QRm+RWx5MEK0dGfQLoCjIOct3FLYNvFGpNyjo/vJvUvvssOwYNzvRKuh14IgH0ldZ86Z+eV9RVwkZLwIEQnNb8KhM4acT0tm2PBT7RNXzBHc1QaVLCpPxgEWjHP88KXTiiKoJkKEnaDpPkFVXELogO4OFVPouRMyfVr6r3/v2ZECP44jZ3bOhCIcs9M3KhjEyznljrmDT7kAQ49lmxKpXOL5AAObCHqz8DlCFRKhFzDz/yXfklHosMsXMMHeXaMMNuOatXGdEBgwCHFeNwa6F7oSk0BAn7+p6eShAFOpN/+acITU4FtOFcYnJ1zJMHMri/fpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUzaRH7IdLy4C3gFl5NjBW/29bVeFjuQBFrdJeAK7jQ=;
 b=FxB1LSFXYNJYOaUrXzQE6UaZa4oaN0ub7oRFlNRmvW0vZF9zRYchnmlZCx5e6OZOqDfTiywydRKdoaNcfZVc1UmtsvtS/+aPS1b78V2VvI6teVZOja5G+mVt79NxuGTwZkhY+tqWsTu3b982yR0vo1hfuzdXaNhP3p8H0U6NqVlZy9YihYJf6eHUhQilxbcn8sStzDEc9REAYQTeBwqBNRspS9wkpUlpXW7jh1+8sNl/gKzSNnuoATspDZ0svu//r790K55z3oHfW7eekRgCFgxTZWr7A3WBNdKd4T9PAXGuKHfVBr9ZcX+xRqIYWJpjXdAuJNcJTsTfKnaaJDpEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUzaRH7IdLy4C3gFl5NjBW/29bVeFjuQBFrdJeAK7jQ=;
 b=jM8e3eFAxtNKkthcBBvSN3mSFHxevlHB3dIqQXbyAK7tDeJwzu8Nf7fecRFVLgNWMf6yzpnIWZ+jr14gG0+A/wHbLbQ0w8p37GOBPQuI/UTnMyHYmKn5U8Sle63ivPTKJlA02Sfcy5xoiGeVvo1UBWbOvllu5H9Zwk9YE1CZ66Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 14:00:10 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 14:00:10 +0000
Message-ID: <739a8732-532c-4ffc-b3ef-d01793c70d4b@kontron.de>
Date: Wed, 4 Sep 2024 16:00:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/5] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, dominique.martinet@atmark-techno.com,
 linux-imx@nxp.com, festevam@gmail.com, aford@beaconembedded.com,
 Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach
 <l.stach@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240904023310.163371-1-aford173@gmail.com>
 <20240904023310.163371-4-aford173@gmail.com>
 <c882eed1-9f36-4382-89fe-f56dd457a45f@kontron.de>
 <CAHCN7xL4WikbY+k+QdBS64-Kt2oHTQU1i_G44PGJDZZKkRaymw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAHCN7xL4WikbY+k+QdBS64-Kt2oHTQU1i_G44PGJDZZKkRaymw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::22) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM7PR10MB3873:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c906468-44a5-495f-a31c-08dccce9e3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFBJR2JzSTBUOThRK3ZBdjI5Q080M3ZHWXZNcXlhMG9WTEk5VUIwSjZGMUh5?=
 =?utf-8?B?SG5yaWp1YUpORkt3VTY3eEVrOHZ3TllNeXlVaG5DQ2xFRE5NcjFKQ243djhn?=
 =?utf-8?B?UWsvdTBnL0duYjNZMnJabk1LeXhZWVBlUzQ0a1pSd3lzVmdlQ0p4TDdGcmt2?=
 =?utf-8?B?LzZsVlB1b1d6VUl5cjV0NmR2bkh5QTI4MlJ2bXJvblV3K2g0YjR4ZTJnUjVM?=
 =?utf-8?B?SmsrZGg0RDFwY2VvT21mTTJTYUNKazR0ZXhRTitLVlBpYnY3Y0ZUQTg0NjVR?=
 =?utf-8?B?YzNyck1mMlVITlJZZ1BYSzJzclh4REV4T0h3ZU5FaXFFSThiMUE3WWw5NlRn?=
 =?utf-8?B?YVp3YkpBQldIbVA2Y3JtMlRJRmljb1dyZTN0eXZqZThVOXB4TjcwMVRSYjFE?=
 =?utf-8?B?aWpRWVJsR1RCYUZiOVdiMk12QlVxeU84ZmhUWTdtRHNlVzB1ZDZkbzBsQXdC?=
 =?utf-8?B?SDFvaVBCdWFUM2xhUG0vOEt2TDVBcDBWU25DWmdrSGF6dmZSYjRjQ0hib2R3?=
 =?utf-8?B?cm9VNEVLNDB5S2RuSU9XODgvZW5XV1pHT285M2tKdkJRN2JhaHo1Q2pYbmRR?=
 =?utf-8?B?NVNzSjcxT2ZMYjdwY3ZJYkd4UjdyR2V1SVZhbm52c1J5OWs1S1J1bi90Z3pG?=
 =?utf-8?B?SUJNZnZKakdEWXdoaXdaREJCSmpLUEllSVkzR3JScXduRC9UcEZwTjl1ZXRC?=
 =?utf-8?B?WjhpWG4wMzY1dlNjSkExSUVWYXhyK3ZzRjN2enVlQmtrWEl4ZGhXaWx0SXBq?=
 =?utf-8?B?NEpxaTdDL0tKQ0NYbHMxTUZWYnBWWkROSHloWG15TGsyMHlNRGp4YXZBejZk?=
 =?utf-8?B?andIazFMMHBuUDR5MHR1UmVKY2ZFYTh6Lzlhb0c2clpjL0cwMVh5OVpZMm5p?=
 =?utf-8?B?SWh4V3hzMEswK0JGV2RYS1BpTVVlSlFucjRtbytaNTVGNEIzcG5wMTlTVm8w?=
 =?utf-8?B?aEJzSXF3aWttb2gxL2pUcThzRkpsZFY2R3Fld2p5bitqd1JmVXBDMFNKRUcv?=
 =?utf-8?B?emJ2SEdOdFV5K2FsYnB3K2tUUUhSYytNYW5UbEhRUTFCOENjWFM5M0FEVEVo?=
 =?utf-8?B?ajh6T2RPTFUyN3RBZzJvN0d4SVpHdUJtalcxNVdmeFJTNWtjL2dwUzZwVTMy?=
 =?utf-8?B?MG52V0ZNZk95YzQ3YW1YVUlUNU44T0NsWktPT3RwRXZKN2ZpRUNTYzV2U3ZI?=
 =?utf-8?B?aThRbXJHQzYxK25rUXllOG1MMGRTTEpneElBUW51UG53cmo3N3RPaGlZNlV5?=
 =?utf-8?B?ZjBNNEJpMjNkVEwvL2g3em5lamtFcWVZb2Y3VEduYmFxVDhaOWJ4TTJ1cFlJ?=
 =?utf-8?B?UW1Pa0FGeTRuYkw2VitBNGlPNFRSNDVsWjVuM2l3dkxEN0szWVVmRlV3K1J1?=
 =?utf-8?B?MklCSVVSOUpQV2QyYXEyRWRsSDFlS1hhN0dSNTcxMWtnNzlhTzMvQStpN1Yw?=
 =?utf-8?B?SmcwejRsT0o3NS9BOTlFVGtQdVFGTzM4bmIrd0NPVUZxenE0MDNUcFEvL1Mx?=
 =?utf-8?B?ZGwrSEtxejNod2c3SGVTWmYzZytXWmtQMzM5UGVTcnNMOU9KQTlnbHd3TDlt?=
 =?utf-8?B?U2p6TG44L3NUOUcvdm1aUy93VjBWK1EyYVdNUWxwQWluL1BuSG84Vi9zL09S?=
 =?utf-8?B?MCtycXowMlVLQkN5Q3ptbmNad0JEQU5IeHBxK2NDczVQSVZPOVJIZHpqeXRO?=
 =?utf-8?B?Qi9MTTAyUUJ5TUhOMEtKK1V3cnBPc3JGT3l4NGoxbWJlaEVRZmRwUmJ3cFAr?=
 =?utf-8?B?ODhkb3hGQkhYRXpBNDdqM0ZJM21kUjNFS25DTlp6cWJsVDJabGM5dWNoYWVl?=
 =?utf-8?B?OUpsMlR3NkVMRGtLdmJtdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVZmRmN5ZzkzU1N6LzJVeUZteVBlSmN2Y3JPaGh0WlBTOVRTNy9wNHF4eEJC?=
 =?utf-8?B?OVo1bDl3TzBSVHJCY3FWbUU0aEY4RC9XWWViMWRVRlF3elFVMDdORGRCV21X?=
 =?utf-8?B?aVlXaTB2cFI5RnpacG12NGJTRk12dlVLTzR5Tmw1c1YvdklQL251RkNFd2Zh?=
 =?utf-8?B?dTlZMm9ma0pHNWV3ZFVhcE9tRytjUVpHRkxWZytkZTd2cER4OE51bHNUWmEv?=
 =?utf-8?B?SW9MUE9UTVBGZjdjWDl3N2ZLZzlHTW55UkZVY2xkcUFLaEFYNVVtUDA1VGg2?=
 =?utf-8?B?MTRXSTNaTVZOeDVHaERSai9HWkNJQWJ3eHpYenNDRDhCUlJMQ1dqK0drMk1K?=
 =?utf-8?B?aUZ6VGdPVXZwbGIrNWtKZXhqVC9vT3gxbk9YVW12TlRMWUxuQmcxL25vY2di?=
 =?utf-8?B?bXJwS1M5b0FqQTMxV1g0SElTWkpEbkp2SkFxbi91cncrVlV3Mm9vZmFiM1JF?=
 =?utf-8?B?aHFYYVg5Qjk0bE4vbXdUOEtuZmZzV3E4VTV3aHU3alhtMFErQVhYdkVNa2Qy?=
 =?utf-8?B?N0xJdWl0RVZJcEpXYnA5Vjg2T2c2YkFUejdjeExITnpJM0NlTDROVy9xT0pX?=
 =?utf-8?B?bHBLYTZxV2JmUzNNV1lXdkozRlR5SGFYWHZOYmtQdWxObENXc1NOR3ZsenF1?=
 =?utf-8?B?NzNLSlUzanV3Qks4RXIrSTBsbUg5cHdKVHYyQ2l0elpBUjJQSjZCQXdldG9l?=
 =?utf-8?B?SEI1NExvMWpTdDNxWThKMnVnTlBmN005VmN2R2JwTE5maW91TnpmeFppT2Mx?=
 =?utf-8?B?VDVyejQxem1jL0ZMRWhKZHljaDRJWXMrV044V2lCQ01xZ2p3UkpWTnBQR1Ro?=
 =?utf-8?B?MnV4TXQ4ajREd3J3WkVkdmx3OEN0YXJRYWtSRERjVytHREVsVkhoNHFIRnBE?=
 =?utf-8?B?b1pQaTF3eVFsNEsrdmFKNnB6MUo3SkdXUlZST2JXQ1FiSGhOVjNzQUoyOTlX?=
 =?utf-8?B?Y0lnbEhvZnFDWC94MnVLb21rbUd2OFk2RCtjRjlBL2lDUlRVSGxWUGV3bVVP?=
 =?utf-8?B?MkZUUTEzLzl1djNXS1dHZ044M0JmZGRpMFlYdUNycTQ4KzR0eWEwb0labXBw?=
 =?utf-8?B?VjlPTUVDUHpDZTJGN3JYMEZwTm5pY1IxU1lxTVBzNEc3aFE2bmZYWE1LR0lv?=
 =?utf-8?B?WDRNR2hTUndZNXp1WjgzbXZDUkFKNDVoaEhUMGtQM0oxamQ5MVB3Y1ZaV3Jo?=
 =?utf-8?B?cW9qZzMvTHRpdWlXYTNudXg5K0NtNGpEUDhWT3N1WEtLV2twZ1BnVGZzK1ZC?=
 =?utf-8?B?TTlnTWtBZEtCVEJhZC8zYmVIajBoMFdJVnJzTGx4TUFIbWRwR2JtYXRUa3ZF?=
 =?utf-8?B?K0Rad3cxNGFTQXA3UG9MWXhidEtvNzhjUVpYdHBOMnBTMTltdThZUzR3UC8y?=
 =?utf-8?B?aU82VzIvVVFGT2V3NUhDT1NSN3FGdXlFNEE2QlZmRHZvLzBZblhzWHlaQThN?=
 =?utf-8?B?WEdkZkhOeVlyTEtKd3BrN3RFNlYrblZIM1ZPbi9CdnRzbDNNZHZRN3VMSDBn?=
 =?utf-8?B?eVJiWGluUWJtdjJ0ZjM0MUFXZWtMWWYrL3llSzJqNjFOUDZqMTMxUmtHZjJo?=
 =?utf-8?B?elM4RG0xSEFaQjk5QzdnQWpIMzBoWmladmRDajRHaE04SjJ2QkN5Y0lUUTFO?=
 =?utf-8?B?VTZVcVZSTGZ5Yk55SlJMNmNta1dzNytzTDVZTHE1OCtpa2VyTEJXKzFURXhY?=
 =?utf-8?B?V0lHMktHMXpTT1V6bEd4Zi9ZOEdCc1F6L3BKR21GM2tVTHQvY1VnUnVWaTl6?=
 =?utf-8?B?d1ZlTU5ndG02WWxxM3BCVzBuczlnWkRJU3NhdTdiTHNCSCszUkQvdERrYTl3?=
 =?utf-8?B?N2F1N09zQ1JiN29Eb3NQOElwaExmMFRMWlJlWW5EVEhKa0ZiM244NXd1Nnh5?=
 =?utf-8?B?SHQxQXh0VWs4dzd0d2pFM1RQQ3hCdk82NVZKTTBWUE5xRHZkZURucG5wd3RL?=
 =?utf-8?B?TDVaZ3U3WFNzUW1VRjhBem9TSi96WFB5NU9JMStYN2czWGE2OGtUd3dMU0xs?=
 =?utf-8?B?cWlTS2g3NWczOUhhbVZFZWIwYzBHU2pYWVl3SnFIU2V4Sk1wcjZYUFdMUFBx?=
 =?utf-8?B?blIvZmoxMVA4SVc3bmVuNWJGYm9zVEZKdzYvaTVwQy9ST1Z0aS9oRGlTR05E?=
 =?utf-8?B?UzRsU3owSmlMY0NIUmhnY0M3NGRvclZwZnYwaTZWTDcySldLTjR3S3h6Zlc2?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c906468-44a5-495f-a31c-08dccce9e3f0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:00:10.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+iSOcsyxczsg1zzlZETyKAmh5DKXXDxCM0XdjlMhLZSNq42HCZNmQUbqkKzuotx/zqSTUn5KQMVqO+E4K8bL+G5S36XPewov8mvPYqii0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3873

On 04.09.24 3:52 PM, Adam Ford wrote:
> On Wed, Sep 4, 2024 at 8:35 AM Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
>>
>> On 04.09.24 4:32 AM, Adam Ford wrote:
>>> There is currently a look-up table for a variety of resolutions.
>>> Since the phy has the ability to dynamically calculate the values
>>> necessary to use the intger divider which should allow more
>>
>>                        ^ integer
>>
>>> resolutions without having to update the look-up-table.
>>>
>>> If the lookup table cannot find an exact match, fall back to the
>>> dynamic calculator of the integer divider.
>>
>> Nitpick: You have thre different versions of how to spell "lookup table"
>> in the paragraphs above. Maybe you can decide on one... ;)
>>
>>>
>>> Previously, the value of P was hard-coded to 1, this required an
>>> update to the phy_pll_cfg table to add in the extra value into the
>>> table, so if the value of P is calculated to be something else
>>> by the PMS calculator, the calculated_phy_pll_cfg structure
>>> can be used instead without having to keep track of which method
>>> was used.
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>
>> The comments I have are only nitpicks and the patch seems to work fine
>> for me. So feel free to add:
>>
>> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>>> ---
>>> V5:  No Change
>>> V4:  No Change
>>> V3:  Change size of pll_div_regs to include PHY_REG01 (P)
>>>      Create calculated_phy_pll_cfg to containe the values
>>>      Eliminate the PMS calculation from fsl_samsung_hdmi_phy_configure
>>>      Make the LUT primary and fall back to integer calculator in
>>>      phy_clk_round_rate.
>>>      Check the range right away to ensure it's reaonsable rather than
>>>      trying to find a clock only to learn it's outside the range.
>>>      Overall added notes and comments where stuff may not be intuitive.
>>>
>>> V2:  Update phy_clk_round_rate and phy_clk_set_rate to both support
>>>      the integer clock PMS calculator.
>>> ---
>>>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 341 +++++++++++++------
>>>  1 file changed, 235 insertions(+), 106 deletions(-)
>>>
>>> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>>> index 4f6874226f9a..8f2c0082aa12 100644
>>> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>>> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>>> @@ -16,6 +16,8 @@
>>>
>>>  #define PHY_REG(reg)         (reg * 4)
>>>
>>> +#define REG01_PMS_P_MASK     GENMASK(3, 0)
>>> +#define REG03_PMS_S_MASK     GENMASK(7, 4)
>>>  #define REG12_CK_DIV_MASK    GENMASK(5, 4)
>>>
>>>  #define REG13_TG_CODE_LOW_MASK       GENMASK(7, 0)
>>> @@ -38,281 +40,296 @@
>>>  #define REG34_PLL_LOCK               BIT(6)
>>>  #define REG34_PHY_CLK_READY  BIT(5)
>>>
>>> -#define PHY_PLL_DIV_REGS_NUM 6
>>> +#ifndef MHZ
>>> +#define MHZ  (1000UL * 1000UL)
>>> +#endif
>>> +
>>> +#define PHY_PLL_DIV_REGS_NUM 7
>>>
>>>  struct phy_config {
>>>       u32     pixclk;
>>>       u8      pll_div_regs[PHY_PLL_DIV_REGS_NUM];
>>>  };
>>>
>>> +/*
>>> + * The calculated_phy_pll_cfg only handles integer divider for PMS only,
>>
>> Nitpick: Remove duplicate 'only'
>>
>>> + * meaning the last four entries will be fixed, but the first three will
>>> + * be calculated by the PMS calculator
>>
>> Nitpick: Period at the end of the sentence
> 
> 
> Good catch.  I ran these through checkpatch, but I need to tell myself
> not do work on this stuff at night when I am tired.
> Sorry about that.  My grammar isn't normally this bad.  :-)

I know. I already assumed that you were tired as the commit messages get
worse towards the end of the series ;)

> 
> adam
>>
>>> + */
>>> +static struct phy_config calculated_phy_pll_cfg = {
>>> +     .pixclk = 0,
>>> +     .pll_div_regs = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00 },
>>> +};
>>> +
>>> +/* The lookup table contains values for which the fractional divder is used */
>>
>> Nitpick: It seems this comment would rather belong into patch 5/5.
> 
> I put it here because I wanted to distinguish between the table below
> and the variable above which are both of the same structure type to
> explain why we needed both.

Ok, fine.

>>
>>>  static const struct phy_config phy_pll_cfg[] = {
>>>       {
>>>               .pixclk = 22250000,
>>> -             .pll_div_regs = { 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 23750000,
>>> -             .pll_div_regs = { 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 24000000,
>>> -             .pll_div_regs = { 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 24024000,
>>> -             .pll_div_regs = { 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 25175000,
>>> -             .pll_div_regs = { 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 25200000,
>>> -             .pll_div_regs = { 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 26750000,
>>> -             .pll_div_regs = { 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 27000000,
>>> -             .pll_div_regs = { 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 27027000,
>>> -             .pll_div_regs = { 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 29500000,
>>> -             .pll_div_regs = { 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 30750000,
>>> -             .pll_div_regs = { 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
>>> +             .pll_div_regs = { 0xd1, 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
>>>       }, {
>>>               .pixclk = 30888000,
>>> -             .pll_div_regs = { 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
>>> +             .pll_div_regs = { 0xd1, 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
>>>       }, {
>>>               .pixclk = 33750000,
>>> -             .pll_div_regs = { 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 35000000,
>>> -             .pll_div_regs = { 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 36000000,
>>> -             .pll_div_regs = { 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 36036000,
>>> -             .pll_div_regs = { 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 40000000,
>>> -             .pll_div_regs = { 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 43200000,
>>> -             .pll_div_regs = { 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 43243200,
>>> -             .pll_div_regs = { 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 44500000,
>>> -             .pll_div_regs = { 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
>>> +             .pll_div_regs = { 0xd1, 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
>>>       }, {
>>>               .pixclk = 47000000,
>>> -             .pll_div_regs = { 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 47500000,
>>> -             .pll_div_regs = { 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 50349650,
>>> -             .pll_div_regs = { 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 50400000,
>>> -             .pll_div_regs = { 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 53250000,
>>> -             .pll_div_regs = { 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
>>> +             .pll_div_regs = { 0xd1, 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
>>>       }, {
>>>               .pixclk = 53500000,
>>> -             .pll_div_regs = { 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 54000000,
>>> -             .pll_div_regs = { 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 54054000,
>>> -             .pll_div_regs = { 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 59000000,
>>> -             .pll_div_regs = { 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 59340659,
>>> -             .pll_div_regs = { 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
>>> +             .pll_div_regs = { 0xd1, 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
>>>       }, {
>>>               .pixclk = 59400000,
>>> -             .pll_div_regs = { 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 61500000,
>>> -             .pll_div_regs = { 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
>>> +             .pll_div_regs = { 0xd1, 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
>>>       }, {
>>>               .pixclk = 63500000,
>>> -             .pll_div_regs = { 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 67500000,
>>> -             .pll_div_regs = { 0x54, 0x52, 0x87, 0x03, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x54, 0x52, 0x87, 0x03, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 70000000,
>>> -             .pll_div_regs = { 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 72000000,
>>> -             .pll_div_regs = { 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 72072000,
>>> -             .pll_div_regs = { 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 74176000,
>>> -             .pll_div_regs = { 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
>>> +             .pll_div_regs = { 0xd1, 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
>>>       }, {
>>>               .pixclk = 74250000,
>>> -             .pll_div_regs = { 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
>>> +             .pll_div_regs = { 0xd1, 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
>>>       }, {
>>>               .pixclk = 78500000,
>>> -             .pll_div_regs = { 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 80000000,
>>> -             .pll_div_regs = { 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 82000000,
>>> -             .pll_div_regs = { 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
>>> +             .pll_div_regs = { 0xd1, 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
>>>       }, {
>>>               .pixclk = 82500000,
>>> -             .pll_div_regs = { 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
>>> +             .pll_div_regs = { 0xd1, 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
>>>       }, {
>>>               .pixclk = 89000000,
>>> -             .pll_div_regs = { 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 90000000,
>>> -             .pll_div_regs = { 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 94000000,
>>> -             .pll_div_regs = { 0x4e, 0x32, 0xa7, 0x10, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x4e, 0x32, 0xa7, 0x10, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 95000000,
>>> -             .pll_div_regs = { 0x50, 0x31, 0x86, 0x85, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x50, 0x31, 0x86, 0x85, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 98901099,
>>> -             .pll_div_regs = { 0x52, 0x3a, 0xdb, 0x4c, 0x88, 0x47 },
>>> +             .pll_div_regs = { 0xd1, 0x52, 0x3a, 0xdb, 0x4c, 0x88, 0x47 },
>>>       }, {
>>>               .pixclk = 99000000,
>>> -             .pll_div_regs = { 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
>>> +             .pll_div_regs = { 0xd1, 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
>>>       }, {
>>>               .pixclk = 100699300,
>>> -             .pll_div_regs = { 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 100800000,
>>> -             .pll_div_regs = { 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 102500000,
>>> -             .pll_div_regs = { 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
>>> +             .pll_div_regs = { 0xd1, 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
>>>       }, {
>>>               .pixclk = 104750000,
>>> -             .pll_div_regs = { 0x57, 0x32, 0x98, 0x07, 0x90, 0x49 },
>>> +             .pll_div_regs = { 0xd1, 0x57, 0x32, 0x98, 0x07, 0x90, 0x49 },
>>>       }, {
>>>               .pixclk = 106500000,
>>> -             .pll_div_regs = { 0x58, 0x32, 0x84, 0x03, 0x82, 0x41 },
>>> +             .pll_div_regs = { 0xd1, 0x58, 0x32, 0x84, 0x03, 0x82, 0x41 },
>>>       }, {
>>>               .pixclk = 107000000,
>>> -             .pll_div_regs = { 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 108000000,
>>> -             .pll_div_regs = { 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 108108000,
>>> -             .pll_div_regs = { 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 118000000,
>>> -             .pll_div_regs = { 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 118800000,
>>> -             .pll_div_regs = { 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 123000000,
>>> -             .pll_div_regs = { 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
>>> +             .pll_div_regs = { 0xd1, 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
>>>       }, {
>>>               .pixclk = 127000000,
>>> -             .pll_div_regs = { 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 135000000,
>>> -             .pll_div_regs = { 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 135580000,
>>> -             .pll_div_regs = { 0x71, 0x39, 0xe9, 0x82, 0x9c, 0x5b },
>>> +             .pll_div_regs = { 0xd1, 0x71, 0x39, 0xe9, 0x82, 0x9c, 0x5b },
>>>       }, {
>>>               .pixclk = 137520000,
>>> -             .pll_div_regs = { 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
>>> +             .pll_div_regs = { 0xd1, 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
>>>       }, {
>>>               .pixclk = 138750000,
>>> -             .pll_div_regs = { 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
>>> +             .pll_div_regs = { 0xd1, 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
>>>       }, {
>>>               .pixclk = 140000000,
>>> -             .pll_div_regs = { 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 144000000,
>>> -             .pll_div_regs = { 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 148352000,
>>> -             .pll_div_regs = { 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
>>> +             .pll_div_regs = { 0xd1, 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
>>>       }, {
>>>               .pixclk = 148500000,
>>> -             .pll_div_regs = { 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
>>> +             .pll_div_regs = { 0xd1, 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
>>>       }, {
>>>               .pixclk = 154000000,
>>> -             .pll_div_regs = { 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
>>>       }, {
>>>               .pixclk = 157000000,
>>> -             .pll_div_regs = { 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 160000000,
>>> -             .pll_div_regs = { 0x42, 0x12, 0xa1, 0x20, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x42, 0x12, 0xa1, 0x20, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 162000000,
>>> -             .pll_div_regs = { 0x43, 0x18, 0x8b, 0x08, 0x96, 0x55 },
>>> +             .pll_div_regs = { 0xd1, 0x43, 0x18, 0x8b, 0x08, 0x96, 0x55 },
>>>       }, {
>>>               .pixclk = 164000000,
>>> -             .pll_div_regs = { 0x45, 0x11, 0x83, 0x82, 0x90, 0x4b },
>>> +             .pll_div_regs = { 0xd1, 0x45, 0x11, 0x83, 0x82, 0x90, 0x4b },
>>>       }, {
>>>               .pixclk = 165000000,
>>> -             .pll_div_regs = { 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
>>> +             .pll_div_regs = { 0xd1, 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
>>>       }, {
>>>               .pixclk = 180000000,
>>> -             .pll_div_regs = { 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 185625000,
>>> -             .pll_div_regs = { 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 188000000,
>>> -             .pll_div_regs = { 0x4e, 0x12, 0xa7, 0x10, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x4e, 0x12, 0xa7, 0x10, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 198000000,
>>> -             .pll_div_regs = { 0x52, 0x12, 0x82, 0x01, 0x88, 0x47 },
>>> +             .pll_div_regs = { 0xd1, 0x52, 0x12, 0x82, 0x01, 0x88, 0x47 },
>>>       }, {
>>>               .pixclk = 205000000,
>>> -             .pll_div_regs = { 0x55, 0x12, 0x8c, 0x05, 0x90, 0x4b },
>>> +             .pll_div_regs = { 0xd1, 0x55, 0x12, 0x8c, 0x05, 0x90, 0x4b },
>>>       }, {
>>>               .pixclk = 209500000,
>>> -             .pll_div_regs = { 0x57, 0x12, 0x98, 0x07, 0x90, 0x49 },
>>> +             .pll_div_regs = { 0xd1, 0x57, 0x12, 0x98, 0x07, 0x90, 0x49 },
>>>       }, {
>>>               .pixclk = 213000000,
>>> -             .pll_div_regs = { 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
>>> +             .pll_div_regs = { 0xd1, 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
>>>       }, {
>>>               .pixclk = 216000000,
>>> -             .pll_div_regs = { 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 216216000,
>>> -             .pll_div_regs = { 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 237600000,
>>> -             .pll_div_regs = { 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 254000000,
>>> -             .pll_div_regs = { 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
>>> +             .pll_div_regs = { 0xd1, 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
>>>       }, {
>>>               .pixclk = 277500000,
>>> -             .pll_div_regs = { 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
>>> +             .pll_div_regs = { 0xd1, 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
>>>       }, {
>>>               .pixclk = 288000000,
>>> -             .pll_div_regs = { 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
>>> +             .pll_div_regs = { 0xd1, 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
>>>       }, {
>>>               .pixclk = 297000000,
>>> -             .pll_div_regs = { 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
>>> +             .pll_div_regs = { 0xd1, 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
>>>       },
>>>  };
>>>
>>> @@ -322,7 +339,8 @@ struct reg_settings {
>>>  };
>>>
>>>  static const struct reg_settings common_phy_cfg[] = {
>>> -     { PHY_REG(0), 0x00 }, { PHY_REG(1), 0xd1 },
>>> +     { PHY_REG(0), 0x00 },
>>> +     /* PHY_REG(1-7) pix clk specific */
>>>       { PHY_REG(8), 0x4f }, { PHY_REG(9), 0x30 },
>>>       { PHY_REG(10), 0x33 }, { PHY_REG(11), 0x65 },
>>>       /* REG12 pixclk specific */
>>> @@ -415,6 +433,76 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
>>>              phy->regs + PHY_REG(14));
>>>  }
>>>
>>> +static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u16 *m, u8 *s)
>>> +{
>>> +     unsigned long best_freq = 0;
>>> +     u32 min_delta = 0xffffffff;
>>> +     u8 _p, best_p;
>>> +     u16 _m, best_m;
>>> +     u8 _s, best_s;
>>> +
>>> +     /* The ref manual states the values of 'P' range from 1 to 11 */
>>> +     for (_p = 1; _p <= 11; ++_p) {
>>> +             for (_s = 1; _s <= 16; ++_s) {
>>> +                     u64 tmp;
>>> +                     u32 delta;
>>> +
>>> +                     /* s must be one or even */
>>> +                     if (_s > 1 && (_s & 0x01) == 1)
>>> +                             _s++;
>>> +
>>> +                     /* _s cannot be 14 per the TRM */
>>> +                     if (_s == 14)
>>> +                             continue;
>>> +
>>> +                     /*
>>> +                      * TODO: Ref Manual doesn't state the range of _m
>>> +                      * so this should be further refined if possible.
>>> +                      * This range was set based on the original values
>>> +                      * in the look-up table
>>> +                      */
>>
>> There is the strange note "Div by -Div by 255" in the RM. I think it's
>> supposed to define the range, but is missing the number for the lower
>> bound. The upper bound is probably 255!?
>>
>> But we might also leave it like it is here and extend it later after
>> further testing.
> 
> I was confused by that too.  I am not sure how a negative division
> would work in this context.

I assume that's a dash not a minus, meaning "from ... to 255", only that
it misses the first value.

> 
>>
>>> +                     tmp = (u64)fout * (_p * _s);
>>> +                     do_div(tmp, 24 * MHZ);
>>> +                     _m = tmp;
>>> +                     if (_m < 0x30 || _m > 0x7b)
>>> +                             continue;
>>> +
>>> +                     /*
>>> +                      * Rev 2 of the Ref Manual states the
>>> +                      * VCO can range between 750MHz and
>>> +                      * 3GHz.  The VCO is assumed to be _m x
>>> +                      * the reference frequency of 24MHz divided
>>> +                      * by the prescaler, _p
>>
>> Maybe better: "The VSO is assumed to be (M * f_ref) / P"
> 
> I can reword this for better readability.

Ok.

> 
>>
>>> +                      */
>>> +                     tmp = (u64)_m * 24 * MHZ;
>>> +                     do_div(tmp, _p);
>>> +                     if (tmp < 750 * MHZ ||
>>> +                         tmp > 3000 * MHZ)
>>> +                             continue;
>>> +
>>> +                     tmp = (u64)_m * 24 * MHZ;
>>> +                     do_div(tmp, _p * _s);
>>
>> tmp already contains (_m * f_ref) / _p, so we sould be able to reuse
>> that value here and simply do do_div(tmp, _s) without recalculating tmp, no?

Any reply to this comment? Can this be optimized?

>>
>>> +
>>> +                     delta = abs(fout - tmp);
>>> +                     if (delta < min_delta) {
>>> +                             best_p = _p;
>>> +                             best_s = _s;
>>> +                             best_m = _m;
>>> +                             min_delta = delta;
>>> +                             best_freq = tmp;
>>> +                     }
>>> +             }
>>> +     }
>>> +
>>> +     if (best_freq) {
>>> +             *p = best_p;
>>> +             *m = best_m;
>>> +             *s = best_s;
>>> +     }
>>> +
>>> +     return best_freq;
>>> +}
>>> +
>>>  static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>>>                                         const struct phy_config *cfg)
>>>  {
>>> @@ -428,13 +516,13 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>>>       for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
>>>               writeb(common_phy_cfg[i].val, phy->regs + common_phy_cfg[i].reg);
>>>
>>> -     /* set individual PLL registers PHY_REG2 ... PHY_REG7 */
>>> +     /* set individual PLL registers PHY_REG1 ... PHY_REG7 */
>>>       for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
>>> -             writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
>>> +             writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(1) + i * 4);
>>>
>>> -     /* High nibble of pll_div_regs[1] contains S which also gets written to REG21 */
>>> +     /* High nibble of PHY_REG3 and low nibble of PHY_REG21 both contain 'S' */
>>>       writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
>>> -            cfg->pll_div_regs[1] >> 4), phy->regs + PHY_REG(21));
>>> +            cfg->pll_div_regs[2] >> 4), phy->regs + PHY_REG(21));
>>>
>>>       fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
>>>
>>> @@ -462,29 +550,70 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
>>>  static long phy_clk_round_rate(struct clk_hw *hw,
>>>                              unsigned long rate, unsigned long *parent_rate)
>>>  {
>>> +     u32 int_div_clk;
>>>       int i;
>>> +     u16 m;
>>> +     u8 p, s;
>>> +
>>> +     /* If the clock is out of range return error instead of searching */
>>> +     if (rate > 297000000 || rate < 22250000)
>>> +             return -EINVAL;
>>>
>>> +     /* Check the look-up table */
>>>       for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>>>               if (phy_pll_cfg[i].pixclk <= rate)
>>> -                     return phy_pll_cfg[i].pixclk;
>>> +                     break;
>>> +     /* If the rate is an exact match, return it now */
>>> +     if (rate == phy_pll_cfg[i].pixclk)
>>> +             return phy_pll_cfg[i].pixclk;
>>> +
>>> +     /*
>>> +      * The math on the lookup table shows the PMS math yields a
>>> +      * frequency 5 x pixclk.
>>> +      * When we check the integer divider against the desired rate,
>>> +      * multiply the rate x 5 and then divide the outcome by 5.
>>> +      */
>>> +     int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
>>>
>>> -     return -EINVAL;
>>> +     /* If the rate is an exact match, return it now */
>>> +     if (int_div_clk == rate)
>>> +             return int_div_clk;
>>> +
>>> +     /* Fall back to the closest value in the LUT */
>>> +     return phy_pll_cfg[i].pixclk;
>>>  }
>>>
>>>  static int phy_clk_set_rate(struct clk_hw *hw,
>>>                           unsigned long rate, unsigned long parent_rate)
>>>  {
>>>       struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
>>> +     u32 int_div_clk;
>>>       int i;
>>> -
>>> -     for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>>> -             if (phy_pll_cfg[i].pixclk <= rate)
>>> -                     break;
>>> -
>>> -     if (i < 0)
>>> -             return -EINVAL;
>>> -
>>> -     phy->cur_cfg = &phy_pll_cfg[i];
>>> +     u16 m;
>>> +     u8 p, s;
>>> +
>>> +     /* If the integer divider works, just use it */
>>> +     int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
>>> +     if (int_div_clk == rate) {
>>> +             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using integer divider\n");
>>> +             calculated_phy_pll_cfg.pixclk = int_div_clk;
>>> +             calculated_phy_pll_cfg.pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
>>> +             calculated_phy_pll_cfg.pll_div_regs[1] = m;
>>> +             calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
>>> +             /* pll_div_regs 3-6 are fixed and pre-defined already */
>>> +             phy->cur_cfg  = &calculated_phy_pll_cfg;
>>> +     } else {
>>> +             /* Otherwise, search the LUT */
>>> +             dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");> +               for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>>> +                     if (phy_pll_cfg[i].pixclk <= rate)
>>> +                             break;
>>> +
>>> +             if (i < 0)
>>> +                     return -EINVAL;
>>> +
>>> +             phy->cur_cfg = &phy_pll_cfg[i];
>>> +     }
>>>
>>>       return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
>>>  }

