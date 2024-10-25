Return-Path: <linux-kernel+bounces-381770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8959B040B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A303280DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139C212191;
	Fri, 25 Oct 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="dMwZANMK"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2120.outbound.protection.outlook.com [40.107.241.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373FF21219F;
	Fri, 25 Oct 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863036; cv=fail; b=mpYSuVmOuNUMkeXeSY6uqB+KbFixdk9815G/dVjH1InEeeUSSk0Bs7uhN5PDVThyI7mt7Ir/w+fvJ09cDzFE3MC7PLjVGw1BwfVuPq8MayHuc2s214UWCr0aZ+VcuFpSJeTycShpHjYcLoCMmlcd8GLDGC8LSsS4b0NWShdtZeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863036; c=relaxed/simple;
	bh=x1S19u6F4sFQaQeHCy8pq74aAYNaE6bXG2ApaZFVOos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fC55vNfqCD9LmFzpNMyygxsiBW8SxTT7EuLU0BcI1/Rqic0NFfQmoaKzNOWgDGtl7TxeUhCLGTg2fqq8U1xtoNWlCEMB8J6tuA5WPIl6oq22AyAqs3MWjxaIUh887uvat18yp+oeRf1CqzKs1QwsHJzdiBel5VLmppWUagvKkxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=dMwZANMK; arc=fail smtp.client-ip=40.107.241.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/64+Z7SdDcV+TqVmNv2bh6kP1MV56kAoW7iHUOpvsGYtgBB66T6s9tNgViPiugoSBivX1XC0M31iNqXk/R0tu0eWyBQWWDeNgGBQ7pswKgz8LKejlQVyzKW+NYBWYjm8Ov5jSxVT5EMiTUrDNffDsCOotod39PvFVx2N04HYfpstdUzPv0SzXCkfAuwP1WevhqVHPtu0taCLfMnnlFUJgsSTkxgKlPcITmIjzdSajeSxUzK7Rbsm2+EIrcvBY3e9kMhqeUTJ0X9Q5vJmet5uju3Ml46+jfEQXaNInvWE9nVci9YMlpMtOffqmTa2ZXueza1Yud8rwZR9eH85MEyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvVKy+akeDx4oiwtt+vGK+o4ap2Fo0ZK5R46McfhxmE=;
 b=ROzXep6hR5YPDrMA26L12sJP0cJOqs8T+my92R1LYz4Filjfv4EX9THbthre9kOB7AQWJQ29C3MCgXIUlMpVl4tIoaBWBntwUYyEK3+2co8feb/3kNcQf4XKRBfAMyjJ8hF0DGR1trMQHjl1CObWYqSzB2iiS7E11CgtXjoJyMPj1XcufF7E7U8gXNGg4EfnFtNcYcRyautT77KMa95Uhrfa3NWDPyT9PEG2ksdiQkcOnrsBHXQje9YvgEw+ikq5lhs+Wo594v5/XeMjM42+vzzQYOksvYemMbEN098uNJePF5sPxMm6unWg/x/dVJ/2cgDVR1Lwsp9erWdg31tnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvVKy+akeDx4oiwtt+vGK+o4ap2Fo0ZK5R46McfhxmE=;
 b=dMwZANMKBSPUrDmAYiLaoqdnMzv+rIMRDyHQp5D5OVQHivRm3a20Z3UwP+a3GxBkltI4PYyZjB7P5gYcmlymmIOhY2R3vVZW9+IEpkGAVqsuSu10OS8vnY7+JfX8DIlHM7i4PWqRrmbLi1swQ+pX9PZsCQH0jNoLTQ4bGwuTzp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AS8PR04MB7910.eurprd04.prod.outlook.com (2603:10a6:20b:288::15)
 by PA1PR04MB10365.eurprd04.prod.outlook.com (2603:10a6:102:442::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 13:30:22 +0000
Received: from AS8PR04MB7910.eurprd04.prod.outlook.com
 ([fe80::7acd:fca0:f5c0:4e99]) by AS8PR04MB7910.eurprd04.prod.outlook.com
 ([fe80::7acd:fca0:f5c0:4e99%7]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 13:30:22 +0000
Date: Fri, 25 Oct 2024 14:30:16 +0100
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>, corentin.chary@gmail.com, luke@ljones.dev,
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Larabel <Michael@phoronix.com>,
	Casey Bowman <casey.g.bowman@intel.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
Message-ID: <ZxudaA3pCoD4Qlls@laptop>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
 <8d70bb6a-c6fd-49de-a494-e97c093827e9@gmx.de>
 <ZxkLz6QBahA7WAyh@laptop>
 <ab6cfea0-a091-4039-94ac-9a26f3df5da5@gmx.de>
 <Zxk5ZwG-61iVP3Qm@laptop>
 <8c4209a4-f6d4-4289-9c57-0ef0188149f3@gmx.de>
 <e1a3a8d980f2c2ff9ffe4f43b91ddffc81d85265.camel@linux.intel.com>
 <01b95adb-3ae9-4619-9652-12a5ddafeb82@gmx.de>
 <73e2e4708cdafe42541eaf047727aa6cf3966248.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73e2e4708cdafe42541eaf047727aa6cf3966248.camel@linux.intel.com>
X-ClientProxiedBy: MR1P264CA0211.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::13) To AS8PR04MB7910.eurprd04.prod.outlook.com
 (2603:10a6:20b:288::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7910:EE_|PA1PR04MB10365:EE_
X-MS-Office365-Filtering-Correlation-Id: 8002d21f-408b-45df-c50b-08dcf4f92c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|41320700013|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUd6VHNUUURlVEptYk1wQnA1ams3OEtGRXlLRWsxazVITmE0b2pWVDc0MlNY?=
 =?utf-8?B?cFMzd1huTTNuaThoek5lbEpyUytwa28yVnd1bDJDSGFvb29WK0Y2RGxmRk85?=
 =?utf-8?B?ZzRHeDFhL1NzNmN2dnV5by96ZFR3aHNlbHpDR25palZnMG9naXZFUFhjbW5t?=
 =?utf-8?B?TWxWWmUvM0ppODJzU21jeVpLVUJVMGVickpKTnJUWmxmN1JKb3pJVFY2bVIx?=
 =?utf-8?B?b1RZNWhyUi93VTBwWHBUTXlJdWtMUGFTTE52bmJWSWgzQmpBUWxzdExTK0lS?=
 =?utf-8?B?NUFVRU1uUHJwZlNzT0wyYng1b09DUFRxMS9abDBGNHBINkM0UG93UjczUTRq?=
 =?utf-8?B?bEtWcUxMUXdxL0svZFdLRWlZV2hrRlBUbHUvWDIwakdiOW9yd3JId05OWnNv?=
 =?utf-8?B?RXc0WXB0UWV0RWNyNG1xbGpIcHhjbUpBRERKY3lJL0tyUjZVWTFXVjBnM09Z?=
 =?utf-8?B?eWdpSlVsaitnTFhVMmYwTEtGcFByVG8vVGdhL0FHWnpiVldiQUhodjFtbmhi?=
 =?utf-8?B?ak9jSlRDTDRQdHBCK0haVFJkZFpZb2JSU2QzVjNxTnU3TkFYaU9HbHM4Tk9N?=
 =?utf-8?B?TWFmTWdVNUtEZWxxb0tCU2pFdXRqWFdaM1N2MVAvY1FqWURGdnlMZll3Zzk2?=
 =?utf-8?B?b2JlRlB4UGswTkl2a214VGRocmJMY0t0dDI3cExwUFAxSzZyUjRUaS9WWkxn?=
 =?utf-8?B?QjRFbjl0c2V1eTJtNTlFQ0NZYk02VGNha1J3SGdpNDVmbWRyNW9tYWpQZ2hn?=
 =?utf-8?B?QTd1SWpOdmwzeUFkNFA4dUgyN1YrMzBQVDNhWUN2alRiRzRKK1RyMlQxaDJp?=
 =?utf-8?B?VHJNNWJCRjJBd21Mc04rL1hGalpSZmhrQVNaZ1pVbVVWOExsVGtOb1crQkc2?=
 =?utf-8?B?d1B0RkVBZVcxZjVkZ2JoRDdDNlRPR29IUVJ3bWp2bWhQVDBpd0NSODg5SzU2?=
 =?utf-8?B?MjJQckk2STcrMXRUbkRMY2J3U3YwSlNCYThDTlZ5YUFuVGZrUjRsamZzUDhn?=
 =?utf-8?B?bnFFWlZTMGFDTytuV004NTRXdjY3QkJJTTUya3ZSYlVBWkllWlM2WEdTekxq?=
 =?utf-8?B?MkdHa2pQYnNMem83TURrWlNoS3dBdXd3UWQ4OWtIeDVLOEQrSEp2cXhOYUpY?=
 =?utf-8?B?MUxnTVlEd29HNFBRZ041Y1phejFFa2lCSkVLdlZCdE1VMTFxRlBhY3pUWi9O?=
 =?utf-8?B?OTNleEtVemNiM1hKZWZZbTBDMFdnK1ZVZWxieXhGWVUvWmIraVZqVE52TER6?=
 =?utf-8?B?RFJBT1BOdEYwY0xYSXhuSzZsQmc3TnlvcHZPcE5VQ0FRdzNGclZTYVJmQ2Jl?=
 =?utf-8?B?TkhGTGQzQ2VpcUppSktVblQzT0pSdWRlY1MrRjRQSlpMWHRRUGJkYk5mOUEy?=
 =?utf-8?B?MVBzRmxlN2lzZzN1dmZzbllOaGRtQkpiNEUzMzhOdEpTM1ZkRHNINWQwdlNE?=
 =?utf-8?B?MnhHK0lPMnpBaGpnamJNbFJabW8zNlduRHl4V2t2UXdESnh5Y0RieVhycER0?=
 =?utf-8?B?L0hsZGtNNmNqTXlZL21QKzZOcTFsNCtmT0dmcVg1MDlEckNRVFU1WEJVVnJ3?=
 =?utf-8?B?Y0VOY29wS045NDdEeDRJRE15RVhXYW1Yc2I4UjNpZUpPSWt6V0EveHpJTnU0?=
 =?utf-8?B?MS9lNUZWajc1V1YyMjdWYW4vTFNRQWlua3BWUTNjWFVob3VLalJwWktDZkdO?=
 =?utf-8?B?aUpLbmhHRjZheXlpQjJRRGpJREduOHM1aEJDOGFCRjNzcDRSa3RHS1U0aW8y?=
 =?utf-8?Q?CRcpPQpBMGe/T69vW8U7C4unNYLlwkrY6PCn05N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDFvS0VVNGMwRE9ndDBhTTR4UEtKdzJwTkswRGRXNGt5K01PZEpudFQ2ejlN?=
 =?utf-8?B?ZU1zOUhDK0VOSEJKd0VNc2xWNWtGU1F4Mm9VVytYMXQ0U21KRzY0NE9oQUlx?=
 =?utf-8?B?L25JSTBtaU83NlY2aURrTUcyaDVHOGFvS2pCTUtwdTlLQmZrdWM4WFRyRDVT?=
 =?utf-8?B?cHJORXp6N0xjK3ZZbzZKREdTOUVmRHQ3ODlwTVFzQWRmMFFZdDI4UnFrZThz?=
 =?utf-8?B?elRDbVYrMEhwMHArYlkzNzNqQU1wZElWR0NsaDlwVXhFOHdHbzN2WmZRTndS?=
 =?utf-8?B?RWw4bkJWV3dLNWtiZUxqOUFTY256b21Rd0hINDNvNEFGZ05nL21jd3BSYTdB?=
 =?utf-8?B?azltM01Lbm5Va0RKZXZqVXM1L3IvNEo2dldtVGtyTmxUdjRLUWhLNDlaYWZ0?=
 =?utf-8?B?d2REL21hSHV5c3ZQZGFYNE9QSnJUQ3FTaVBvVGF5cXphdzJHei9vSE54Q0I5?=
 =?utf-8?B?TWsrRnJvYWZ2dnNobzZXS0ZpeFZTaXkybTFyZmNCM1BwY3ZPbUp2U3g3cjZT?=
 =?utf-8?B?cytRZ0FSOG9mS1Y1TnhndUlyN0J3Qnd2dFk4dmxiQ0pGZlJxQ0Y1TWVqMnIy?=
 =?utf-8?B?Skt4OHh3NlNQUVEvK2tDQWZlZkd0Q0w2MTFWYThWbzlpUkh1L2RFd2lRcGJ0?=
 =?utf-8?B?VGVqdEVmaU15cld0RkUzRVB0T3NzZmV2SDFZNzhBUm5XQm1CQ2Z5UlhKUGFM?=
 =?utf-8?B?RVZWTTNuSExvTW5YNVAvR3krV21jSHpYZnZsbEpib2p0aGFiZUk4S0lXNjRa?=
 =?utf-8?B?cjAzclRjWXJIQ2gzK3k2Ky9sQmdhbm1zc2g0a0RjVzRldGc5RFR2YlJpZWk4?=
 =?utf-8?B?SjBYYTVLTTNjc0s0ak44VlF2ZkppZVBDSWtBTFdXTlJsdEl1bFVGU3RGdEx0?=
 =?utf-8?B?bUQ4M20wU2xZUXFQWFdzcEdtOTlaQmRCRHhaVkJOd2lnZmdKZEprdHZ5bWU0?=
 =?utf-8?B?eCtad0lhZnBEUkZ5NHJ6UXBMYjNTRjhxeTR5Mmw2RkF0OHpPOXVZSlFCeHdv?=
 =?utf-8?B?RVlURGZ3cC9yYWltRzhIYksxZXBaT081MnpaVGtqTDVnRzJCSjIxQmNGakcz?=
 =?utf-8?B?bklRUzMvd3ZJVGdGVCtWNWtHNmhCU09Nc1V4ZHVtVTZSWUdEbFI4Ymd3S014?=
 =?utf-8?B?dVFybUx2TXIwZ29BMkN4Y0N6UVF0NXgrUnQxZUgzdUxTZ2ZmWTZUZEI2a0Qr?=
 =?utf-8?B?TjBxRnVIMmE5NU9zeGcrR1ZHRzR4T1h6OGcxZjBVVEZKUUh4a2FVOFNUVTlh?=
 =?utf-8?B?eklnNmtSSWF4czd1OU1MR2IxNEdUQldFdS9pdVdYN0s2VGhFOVJaeEhBVWNo?=
 =?utf-8?B?VmxMWVl1em1aTit4WUFVcThBdjIwYXBzYVMwMnl6S053YldHbUNSSDZoZ253?=
 =?utf-8?B?N25PU2ZDclIvNWxMemNHQUZ4RUlzOVppU0FqT1drN1ZoNWV1YmlOVlRmMTlG?=
 =?utf-8?B?WnBEamxkLzE2b0JCSm43QVFYazVoZ3FVeUdTTjdRQllLL29FYkorT004Z0FZ?=
 =?utf-8?B?ejREN0RuTWZiL0haTllvTUZRV3VPSVpVTnB4VExIcXFLZklHWkFvdEhPTDFU?=
 =?utf-8?B?R1FHeXZKaDh2cUxUSVUyNVFqWjhjMUJMaXlCdk40U3I4YWk0UXUvb1lPVlZm?=
 =?utf-8?B?Mk5LY2NHT3k0ZnoweHY5b2pFamlaeE1peXp4dFlqV1JTRmhhTkRQSEZtbGpY?=
 =?utf-8?B?Rkw3MjBMeFJoa2U4aG5wZ0srb05sNVh4b0YvSFNhVG1FY1pFcVhkVkZjbDRT?=
 =?utf-8?B?cU9GeXNSaUNydGk2Ukwweko2dXZLNnN6S1pVZWQ2RTRpMXgydlZXdUVaRnNS?=
 =?utf-8?B?a3ZhMFArdlk2N1ltdERKemF5S2pnd08zWXJSWlhWTWNLWGJEdjdzS0tFMjgr?=
 =?utf-8?B?c3pXZy8xR0U5YW9CRVppSDBtRklhd05Ua1huNjBIRHlnWUJvV3N0U3FYTHdZ?=
 =?utf-8?B?ZGdnQTFRdUc2dmM4VllrS3ExU1dsd0c1RVpiRUpuMDhQQkIyQTF2eFlPOHcr?=
 =?utf-8?B?WXFETUsvYTlCREFtSE5BS21XcWZpOGJvbUVSbDdTSVdFa2xtN3cxYXM2NmNy?=
 =?utf-8?B?dVlnL1N3b0MwclR0QlA5Z09qMmJhMGlkdnNCWGhyN1RNaTJaSE9GbS93WkFT?=
 =?utf-8?B?UUMrbkF1dHVyUmwyMWlybjNNZUhqTS9oYXE1V0lXdS9OcHRySitMRkZVK3Q0?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8002d21f-408b-45df-c50b-08dcf4f92c80
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:30:21.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bN0+lXYRn0EDIf9Rm04Q519hxwxvcrytlRbFemxWHz0AlwsTuk4xflzwbBad0EZZO3GpJx14+go4EScEYzZggBuSOQWsyaTTlehuphTnNpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10365

On Thu, Oct 24, 2024 at 11:15:31AM -0700, srinivas pandruvada wrote:
> On Wed, 2024-10-23 at 22:32 +0200, Armin Wolf wrote:
> > Am 23.10.24 um 22:15 schrieb srinivas pandruvada:
> > 
> > > On Wed, 2024-10-23 at 20:57 +0200, Armin Wolf wrote:
> > > > Am 23.10.24 um 19:59 schrieb Mohamed Ghanmi:
> > > > 
> > > > > On Wed, Oct 23, 2024 at 06:31:17PM +0200, Armin Wolf wrote:
> > > > > > Am 23.10.24 um 16:44 schrieb Mohamed Ghanmi:
> > > > > > 
> > > > > > > Hello !
> > > > > > > On Sun, Oct 20, 2024 at 09:42:45PM +0200, Armin Wolf wrote:
> > > > > > > > Am 20.10.24 um 21:05 schrieb Armin Wolf:
> > > > > > > > 
> > > > > > > > > Am 20.10.24 um 08:50 schrieb Srinivas Pandruvada:
> > > > > > > > > 
> > > > > > > > > > Some recent Asus laptops are supporting ASUS
> > > > > > > > > > Intelligent
> > > > > > > > > > Performance
> > > > > > > > > > Technology (AIPT). This solution allows users to have
> > > > > > > > > > maximized CPU
> > > > > > > > > > performance in models with a chassis providing more
> > > > > > > > > > thermal head room.
> > > > > > > > > > Refer to [1].
> > > > > > > > > > 
> > > > > > > > > > There are major performance issues when Linux is
> > > > > > > > > > installed on these
> > > > > > > > > > laptops compared to Windows install. One such report
> > > > > > > > > > is
> > > > > > > > > > published for
> > > > > > > > > > Graphics benchmarks on Asus ASUS Zenbook S 14 with
> > > > > > > > > > Lunar
> > > > > > > > > > Lake
> > > > > > > > > > processors [2].
> > > > > > > > > > 
> > > > > > > > > > By default, these laptops are booting in "Whisper
> > > > > > > > > > Mode"
> > > > > > > > > > till OS power
> > > > > > > > > > management or tools change this to other AIPT mode.
> > > > > > > > > > This
> > > > > > > > > > "Whisper" mode
> > > > > > > > > > calls to set lower maximum and minimum RAPL (Running
> > > > > > > > > > Average Power
> > > > > > > > > > Limit)
> > > > > > > > > > via thermal tables. On Linux this leads to lower
> > > > > > > > > > performance even when
> > > > > > > > > > platform power profile is "balanced". This "Whisper"
> > > > > > > > > > mode
> > > > > > > > > > should
> > > > > > > > > > correspond to "quiet" mode.
> > > > > > > > > > 
> > > > > > > > > > So, when AIPT is present change the default mode to
> > > > > > > > > > "Standard" during
> > > > > > > > > > boot. Map the three platform power profile modes as
> > > > > > > > > > follows:
> > > > > > > > > > 
> > > > > > > > > > Power Profile Mode      AIPT mode
> > > > > > > > > > -----------------------------------
> > > > > > > > > > quiet            Whisper
> > > > > > > > > > balanced        Standard
> > > > > > > > > > performance        Performance
> > > > > > > > > > ------------------------------------
> > > > > > > > > > 
> > > > > > > > > > Here AIPT mode can be detected by checking presese of
> > > > > > > > > > "FANL" method
> > > > > > > > > > under
> > > > > > > > > > PNP HID "PNP0C14" and UID "ATK". If AIPT mode is
> > > > > > > > > > present,
> > > > > > > > > > this takes
> > > > > > > > > > precedence over the existing VIVO thermal policy.
> > > > > > > > > > These
> > > > > > > > > > modes are set
> > > > > > > > > > using "FANL" method.
> > > > > > > > > > 
> > > > > > > > > > Although this “FANL” method is not used in the Asus
> > > > > > > > > > WMI
> > > > > > > > > > driver, users
> > > > > > > > > > have used this method from user space [3] to set AIPT
> > > > > > > > > > modes. Used this
> > > > > > > > > > as a reference.
> > > > > > > > > > 
> > > > > > > > > > Link:
> > > > > > > > > > https://www.asus.com/content/laptop-asus-intelligent-performance-technology-aipt/
> > > > > > > > > > # [1]
> > > > > > > > > > Reported-by: Michael Larabel <Michael@phoronix.com>
> > > > > > > > > > Closes:
> > > > > > > > > > https://www.phoronix.com/review/lunar-lake-xe2/5 #
> > > > > > > > > > [2]
> > > > > > > > > > Link:
> > > > > > > > > > https://github.com/dominiksalvet/asus-fan-control/issues/151
> > > > > > > > > >   # [3]
> > > > > > > > > > Tested-by: Casey Bowman <casey.g.bowman@intel.com>
> > > > > > > > > > Signed-off-by: Srinivas Pandruvada
> > > > > > > > > > <srinivas.pandruvada@linux.intel.com>
> > > > > > > > > > ---
> > > > > > > > > >      drivers/platform/x86/asus-wmi.c | 93
> > > > > > > > > > +++++++++++++++++++++++++++++++--
> > > > > > > > > >      1 file changed, 89 insertions(+), 4 deletions(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/drivers/platform/x86/asus-wmi.c
> > > > > > > > > > b/drivers/platform/x86/asus-wmi.c
> > > > > > > > > > index 7a48220b4f5a..06689d0f98c7 100644
> > > > > > > > > > --- a/drivers/platform/x86/asus-wmi.c
> > > > > > > > > > +++ b/drivers/platform/x86/asus-wmi.c
> > > > > > > > > > @@ -100,6 +100,11 @@ module_param(fnlock_default,
> > > > > > > > > > bool,
> > > > > > > > > > 0444);
> > > > > > > > > >      #define
> > > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO    1
> > > > > > > > > >      #define
> > > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO    2
> > > > > > > > > > 
> > > > > > > > > > +#define AIPT_STANDARD                0
> > > > > > > > > > +#define AIPT_WHISPER                1
> > > > > > > > > > +#define AIPT_PERFORMANCE            2
> > > > > > > > > > +#define AIPT_FULL_SPEED                3
> > > > > > > > > > +
> > > > > > > > > >      #define PLATFORM_PROFILE_MAX 2
> > > > > > > > > > 
> > > > > > > > > >      #define USB_INTEL_XUSB2PR        0xD0
> > > > > > > > > > @@ -333,6 +338,9 @@ struct asus_wmi {
> > > > > > > > > >          struct asus_wmi_debug debug;
> > > > > > > > > > 
> > > > > > > > > >          struct asus_wmi_driver *driver;
> > > > > > > > > > +    acpi_handle acpi_mgmt_handle;
> > > > > > > > > > +    int asus_aipt_mode;
> > > > > > > > > > +    bool asus_aipt_present;
> > > > > > > > > >      };
> > > > > > > > > > 
> > > > > > > > > >      /* WMI
> > > > > > > > > > *****************************************************
> > > > > > > > > > ****
> > > > > > > > > > ***************/
> > > > > > > > > > @@ -3804,6 +3812,19 @@ static ssize_t
> > > > > > > > > > throttle_thermal_policy_store(struct device *dev,
> > > > > > > > > >      static DEVICE_ATTR_RW(throttle_thermal_policy);
> > > > > > > > > > 
> > > > > > > > > >      /* Platform profile
> > > > > > > > > > *****************************************************
> > > > > > > > > > ****
> > > > > > > > > > **/
> > > > > > > > > > +static int asus_wmi_write_aipt_mode(struct asus_wmi
> > > > > > > > > > *asus, int
> > > > > > > > > > aipt_mode)
> > > > > > > > > > +{
> > > > > > > > > > +    int status;
> > > > > > > > > > +
> > > > > > > > > > +    status = acpi_execute_simple_method(asus-
> > > > > > > > > > > acpi_mgmt_handle,
> > > > > > > > > > "FANL", aipt_mode);
> > > > > > > > > > +    if (ACPI_FAILURE(status)) {
> > > > > > > > > > +        acpi_handle_info(asus->acpi_mgmt_handle,
> > > > > > > > > > "FANL
> > > > > > > > > > execute
> > > > > > > > > > failed\n");
> > > > > > > > > > +        return -EIO;
> > > > > > > > > > +    }
> > > > > > > > > > +
> > > > > > > > > > +    return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >      static int
> > > > > > > > > > asus_wmi_platform_profile_to_vivo(struct
> > > > > > > > > > asus_wmi *asus,
> > > > > > > > > > int mode)
> > > > > > > > > >      {
> > > > > > > > > >          bool vivo;
> > > > > > > > > > @@ -3844,6 +3865,26 @@ static int
> > > > > > > > > > asus_wmi_platform_profile_mode_from_vivo(struct
> > > > > > > > > > asus_wmi
> > > > > > > > > > *asus, int m
> > > > > > > > > >          return mode;
> > > > > > > > > >      }
> > > > > > > > > > 
> > > > > > > > > > +static int asus_wmi_aipt_platform_profile_get(struct
> > > > > > > > > > asus_wmi *asus,
> > > > > > > > > > +                          enum
> > > > > > > > > > platform_profile_option
> > > > > > > > > > *profile)
> > > > > > > > > > +{
> > > > > > > > > > +    switch (asus->asus_aipt_mode) {
> > > > > > > > > > +    case AIPT_STANDARD:
> > > > > > > > > > +        *profile = PLATFORM_PROFILE_BALANCED;
> > > > > > > > > > +        break;
> > > > > > > > > > +    case AIPT_PERFORMANCE:
> > > > > > > > > > +        *profile = PLATFORM_PROFILE_PERFORMANCE;
> > > > > > > > > > +        break;
> > > > > > > > > > +    case AIPT_WHISPER:
> > > > > > > > > > +        *profile = PLATFORM_PROFILE_QUIET;
> > > > > > > > > > +        break;
> > > > > > > > > > +    default:
> > > > > > > > > > +        return -EINVAL;
> > > > > > > > > > +    }
> > > > > > > > > > +
> > > > > > > > > > +    return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >      static int asus_wmi_platform_profile_get(struct
> > > > > > > > > > platform_profile_handler *pprof,
> > > > > > > > > >                          enum platform_profile_option
> > > > > > > > > > *profile)
> > > > > > > > > >      {
> > > > > > > > > > @@ -3851,6 +3892,10 @@ static int
> > > > > > > > > > asus_wmi_platform_profile_get(struct
> > > > > > > > > > platform_profile_handler *pprof,
> > > > > > > > > >          int tp;
> > > > > > > > > > 
> > > > > > > > > >          asus = container_of(pprof, struct asus_wmi,
> > > > > > > > > > platform_profile_handler);
> > > > > > > > > > +
> > > > > > > > > > +    if (asus->asus_aipt_present)
> > > > > > > > > > +        return
> > > > > > > > > > asus_wmi_aipt_platform_profile_get(asus,
> > > > > > > > > > profile);
> > > > > > > > > > +
> > > > > > > > > >          tp = asus->throttle_thermal_policy_mode;
> > > > > > > > > > 
> > > > > > > > > >          switch
> > > > > > > > > > (asus_wmi_platform_profile_mode_from_vivo(asus, tp))
> > > > > > > > > > {
> > > > > > > > > > @@ -3874,26 +3919,42 @@ static int
> > > > > > > > > > asus_wmi_platform_profile_set(struct
> > > > > > > > > > platform_profile_handler *pprof,
> > > > > > > > > >                          enum platform_profile_option
> > > > > > > > > > profile)
> > > > > > > > > >      {
> > > > > > > > > >          struct asus_wmi *asus;
> > > > > > > > > > -    int tp;
> > > > > > > > > > +    int ret = 0, tp, aipt_mode;
> > > > > > > > > > 
> > > > > > > > > >          asus = container_of(pprof, struct asus_wmi,
> > > > > > > > > > platform_profile_handler);
> > > > > > > > > > 
> > > > > > > > > >          switch (profile) {
> > > > > > > > > >          case PLATFORM_PROFILE_PERFORMANCE:
> > > > > > > > > >              tp =
> > > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> > > > > > > > > > +        aipt_mode = AIPT_PERFORMANCE;
> > > > > > > > > >              break;
> > > > > > > > > >          case PLATFORM_PROFILE_BALANCED:
> > > > > > > > > >              tp =
> > > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > > > > > > > > +        aipt_mode = AIPT_STANDARD;
> > > > > > > > > >              break;
> > > > > > > > > >          case PLATFORM_PROFILE_QUIET:
> > > > > > > > > >              tp =
> > > > > > > > > > ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> > > > > > > > > > +        aipt_mode = AIPT_WHISPER;
> > > > > > > > > >              break;
> > > > > > > > > >          default:
> > > > > > > > > >              return -EOPNOTSUPP;
> > > > > > > > > >          }
> > > > > > > > > > 
> > > > > > > > > > -    asus->throttle_thermal_policy_mode =
> > > > > > > > > > asus_wmi_platform_profile_to_vivo(asus, tp);
> > > > > > > > > > -    return throttle_thermal_policy_write(asus);
> > > > > > > > > > +    if (asus->asus_aipt_present) {
> > > > > > > > > > +        ret = asus_wmi_write_aipt_mode(asus,
> > > > > > > > > > aipt_mode);
> > > > > > > > > > +        if (!ret) {
> > > > > > > > > > +            asus->asus_aipt_mode = aipt_mode;
> > > > > > > > > > +            goto skip_vivo;
> > > > > > > > > > +        }
> > > > > > > > > > +    }
> > > > > > > > > > +
> > > > > > > > > > +    if (asus->throttle_thermal_policy_dev) {
> > > > > > > > > > +        asus->throttle_thermal_policy_mode =
> > > > > > > > > > asus_wmi_platform_profile_to_vivo(asus, tp);
> > > > > > > > > > +        ret = throttle_thermal_policy_write(asus);
> > > > > > > > > > +    }
> > > > > > > > > > +
> > > > > > > > > > +skip_vivo:
> > > > > > > > > > +    return ret;
> > > > > > > > > >      }
> > > > > > > > > > 
> > > > > > > > > >      static int platform_profile_setup(struct
> > > > > > > > > > asus_wmi
> > > > > > > > > > *asus)
> > > > > > > > > > @@ -3905,7 +3966,7 @@ static int
> > > > > > > > > > platform_profile_setup(struct
> > > > > > > > > > asus_wmi *asus)
> > > > > > > > > >           * Not an error if a component
> > > > > > > > > > platform_profile
> > > > > > > > > > relies on is
> > > > > > > > > > unavailable
> > > > > > > > > >           * so early return, skipping the setup of
> > > > > > > > > > platform_profile.
> > > > > > > > > >           */
> > > > > > > > > > -    if (!asus->throttle_thermal_policy_dev)
> > > > > > > > > > +    if (!asus->throttle_thermal_policy_dev && !asus-
> > > > > > > > > > > asus_aipt_present)
> > > > > > > > > >              return 0;
> > > > > > > > > > 
> > > > > > > > > >          dev_info(dev, "Using throttle_thermal_policy
> > > > > > > > > > for
> > > > > > > > > > platform_profile support\n");
> > > > > > > > > > @@ -4538,6 +4599,7 @@ static int
> > > > > > > > > > asus_wmi_sysfs_init(struct
> > > > > > > > > > platform_device *device)
> > > > > > > > > >      static int asus_wmi_platform_init(struct
> > > > > > > > > > asus_wmi
> > > > > > > > > > *asus)
> > > > > > > > > >      {
> > > > > > > > > >          struct device *dev = &asus->platform_device-
> > > > > > > > > > >dev;
> > > > > > > > > > +    struct acpi_device *adev;
> > > > > > > > > >          char *wmi_uid;
> > > > > > > > > >          int rv;
> > > > > > > > > > 
> > > > > > > > > > @@ -4593,6 +4655,29 @@ static int
> > > > > > > > > > asus_wmi_platform_init(struct
> > > > > > > > > > asus_wmi *asus)
> > > > > > > > > >             
> > > > > > > > > > asus_wmi_set_devstate(ASUS_WMI_DEVID_CWAP,
> > > > > > > > > >                            asus->driver->quirks-
> > > > > > > > > > >wapf,
> > > > > > > > > > NULL);
> > > > > > > > > > 
> > > > > > > > > > +    /*
> > > > > > > > > > +     * Check presence of Intelligent Performance
> > > > > > > > > > Technology (AIPT).
> > > > > > > > > > +     * If present store acpi handle and set
> > > > > > > > > > asus_aipt_present to true.
> > > > > > > > > > +     */
> > > > > > > > > > +    adev = acpi_dev_get_first_match_dev("PNP0C14",
> > > > > > > > > > "ATK", -1);
> > > > > > > > > Is there really no way of changing the AIPT mode
> > > > > > > > > through
> > > > > > > > > the WMI
> > > > > > > > > interface?
> > > > > > > > > I would prefer using the WMI interface if available,
> > > > > > > > > since
> > > > > > > > > the
> > > > > > > > > firmware might
> > > > > > > > > assume that FANL is only called through the WMI
> > > > > > > > > interface.
> > > > > > > > > 
> > > > > > > > > Do you have a acpidump from a affected device?
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > Armin Wolf
> > > > > > > > > 
> > > > > > > > I found a acpidump from a ASUS device with a matching
> > > > > > > > FANL
> > > > > > > > method. It seems that this method
> > > > > > > > can indeed be called using the WMI interface using the
> > > > > > > > DEVS()
> > > > > > > > WMI method:
> > > > > > > > 
> > > > > > > > [WmiMethodId(1398162756), Implemented] void DEVS([in]
> > > > > > > > uint32
> > > > > > > > Device_ID, [in] uint32 Control_status, [out] uint32
> > > > > > > > result);
> > > > > > > > 
> > > > > > > > If Device_ID is 0x00110019, then Control_status is passed
> > > > > > > > to
> > > > > > > > the FANL ACPI method.
> > > > > > > > 
> > > > > > > > It also seems that support for AIPT can be queried using
> > > > > > > > the
> > > > > > > > DSTS() WMI method:
> > > > > > > > 
> > > > > > > > [WmiMethodId(1398035268), Implemented] void DSTS([in]
> > > > > > > > uint32
> > > > > > > > Device_ID, [out] uint32 device_status);
> > > > > > > > 
> > > > > > > > Using Device_ID 0x00110019, the returned device status
> > > > > > > > seems
> > > > > > > > to contain the following information:
> > > > > > > > 
> > > > > > > > - 16-bit current AIPT mode
> > > > > > > > - 4-bit unknown value (possible values 2, 3 and 7, maybe
> > > > > > > > number of supported modes or some kind of bitmap?)
> > > > > > > > - 1-bit with is set when (GGIV (0x0907000C) == One) is
> > > > > > > > true
> > > > > > > I just saw this conversation and i think that the behaviour
> > > > > > > this
> > > > > > > patch will implement in the driver was already implemented
> > > > > > > in
> > > > > > > this patch
> > > > > > > that got added to kernel v6.12-rc3:
> > > > > > > https://lore.kernel.org/platform-driver-x86/20240609144849.2532-2-mohamed.ghanmi@supcom.tn/
> > > > > > > 
> > > > > > > this patch introduced
> > > > > > > ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO
> > > > > > > 0x00110019 which is the device_id that changes the fan
> > > > > > > profiles. the
> > > > > > > naming is not clear because it was initially intended to
> > > > > > > add
> > > > > > > support for
> > > > > > > fan profiles for vivobook laptops but it ended up adding
> > > > > > > support
> > > > > > > for a lot of modern laptops.
> > > > > > Nice, you are absolutely right.
> > > > > > 
> > > > > > So this patch series is effectively already upstream, very
> > > > > > good.
> > > > > > I did some research and found out
> > > > > > that the status of this device id contains the following
> > > > > > data:
> > > > > > 
> > > > > > Status          Supported Modes
> > > > > > -------------------------------
> > > > > > 0x00[1]300[xx]  0 1 2
> > > > > > 0x000700[xx]    0 1 2
> > > > > > 0x000200[xx]    ??? (ODV0)
> > > > > > 0x000700[xx]    0 1 2
> > > > > > 0x0a0700[xx]    ??? (ODV0)
> > > > > > 
> > > > > > While i have no clue about the meaning of the remaining bits,
> > > > > > i
> > > > > > can report that the first 8 Bits
> > > > > > contain the current thermal mode. Maybe adding support for
> > > > > > this
> > > > > > would be nice, so the current
> > > > > > thermal mode can be read directly from the hardware.
> > > > > > 
> > > > > > I also found out that on some models the thermal mode
> > > > > > actually
> > > > > > modifies the ODV0 variable which
> > > > > > is consumed by int3400_thermal and exposed to the Intel
> > > > > > Thermal
> > > > > > Daemon. So maybe the lackluster
> > > > > > performance also has something to do with it.
> > > > > > 
> > > > > > > a point that Srinivas Pandruvada mentioned about RAPL
> > > > > > > (Running
> > > > > > > Average Power Limit)
> > > > > > > is valid for a lot of modern vivobook and zenbook laptops
> > > > > > > but i
> > > > > > > think
> > > > > > > it's unrelated to fan profiles.
> > > > > > > 
> > > > > > > a lot of asus laptops that have intel cpus suffer from
> > > > > > > power
> > > > > > > throttling.
> > > > > > > for exemple in my case using windows, changing fan profiles
> > > > > > > will lead to max power
> > > > > > > changing to the values indicated in the table below (asus
> > > > > > > vivobook 16x
> > > > > > > pro k6604) which leads to higher performance than linux
> > > > > > > 
> > > > > > > fan Profile             power limit
> > > > > > > -----------------------------------
> > > > > > > Whisper                 50watts
> > > > > > > Standard                120watts
> > > > > > > Performance             149watts
> > > > > > > ------------------------------------
> > > > > > > 
> > > > > > > However in linux, even after changing to the appropriate
> > > > > > > fan
> > > > > > > profile,
> > > > > > > the power is still capped at 50watts and i found the reason
> > > > > > > why
> > > > > > > 
> > > > > > > here is the results of using the powercap-info command:
> > > > > > > 
> > > > > > > intel-rapl-mmio
> > > > > > >      enabled: 1
> > > > > > >      Zone 0
> > > > > > >        name: package-0
> > > > > > >        enabled: 1
> > > > > > >        max_energy_range_uj: 262143328850
> > > > > > >        Constraint 0
> > > > > > >          name: long_term
> > > > > > >          power_limit_uw: 30000000
> > > > > > >          time_window_us: 55967744
> > > > > > >          max_power_uw: 55000000
> > > > > > >        Constraint 1
> > > > > > >          name: short_term
> > > > > > >          power_limit_uw: 55000000
> > > > > > >          time_window_us: 2440
> > > > > > >          max_power_uw: 0
> > > > > > > intel-rapl
> > > > > > >      enabled: 1
> > > > > > >      Zone 0
> > > > > > >        name: package-0
> > > > > > >        enabled: 1
> > > > > > >        max_energy_range_uj: 262143328850
> > > > > > >        Constraint 0
> > > > > > >          name: long_term
> > > > > > >          power_limit_uw: 157000000
> > > > > > >          time_window_us: 55967744
> > > > > > >          max_power_uw: 55000000
> > > > > > >        Constraint 1
> > > > > > >          name: short_term
> > > > > > >          power_limit_uw: 157000000
> > > > > > >          time_window_us: 2440
> > > > > > >          max_power_uw: 0
> > > > > > >        Constraint 2
> > > > > > >          name: peak_power
> > > > > > >          power_limit_uw: 200000000
> > > > > > >          max_power_uw: 0
> > > > > > >        Zone 0:0
> > > > > > >          name: core
> > > > > > >          enabled: 0
> > > > > > >          max_energy_range_uj: 262143328850
> > > > > > >          Constraint 0
> > > > > > >            name: long_term
> > > > > > >            power_limit_uw: 0
> > > > > > >            time_window_us: 976
> > > > > > >        Zone 0:1
> > > > > > >          name: uncore
> > > > > > >          enabled: 0
> > > > > > >          max_energy_range_uj: 262143328850
> > > > > > >          Constraint 0
> > > > > > >            name: long_term
> > > > > > >            power_limit_uw: 0
> > > > > > >            time_window_us: 976
> > > > > > >      Zone 1
> > > > > > >        name: psys
> > > > > > >        enabled: 0
> > > > > > >        max_energy_range_uj: 262143328850
> > > > > > >        Constraint 0
> > > > > > >          name: long_term
> > > > > > >          power_limit_uw: 0
> > > > > > >          time_window_us: 27983872
> > > > > > >        Constraint 1
> > > > > > >          name: short_term
> > > > > > >          power_limit_uw: 0
> > > > > > >          time_window_us: 976
> > > > > > > 
> > > > > > > 
> > > > > > > as seen by the output of the command, the intel-rapl-mmio
> > > > > > > is
> > > > > > > causing the
> > > > > > > throttling as it sets power_limit_uw to 30 watts
> > > > > > > (readonly). so
> > > > > > > the current fix
> > > > > > > that i'm currently using is disabling the intel-rapl-mmio
> > > > > > > leaving only
> > > > > > > the intel-rapl which sets power_limit_uw to 157watts using
> > > > > > > this
> > > > > > > command: powercap-set -p intel-rapl-mmio -z 0 -e 0
> > > > > > > 
> > > > > > > this will lead to the laptop being able to reach it's
> > > > > > > maximum
> > > > > > > power
> > > > > > > limit.
> > > > > > > 
> > > > > > > after doing this, when i change the platform profile
> > > > > > > through
> > > > > > > sysfs the
> > > > > > > laptop will start behaving as described in the table above
> > > > > > > exactly like
> > > > > > > windows.
> > > > > > > 
> > > > > > > in conclusion, the asus-wmi driver already has the platform
> > > > > > > profiles
> > > > > > > (a.k.a fan profiles)
> > > > > > > implemented and I think that the power throttling is caused
> > > > > > > by
> > > > > > > either
> > > > > > > intel Power Capping Framework or asus bios.
> > > > > > Or the Intel Thermal Daemon somehow does not properly support
> > > > > > intel-rapl-mmio
> > > > > > or is not installed.
> > > > > This was exactly it. the Intel Thermal Daemon wasn't installed.
> > > > > now
> > > > > everything is working as expected!
> > > > > 
> > > > > Best regards,
> > > > > Mohamed G.
> > > > Interesting.
> > > > 
> > > > Srinivas, can you verify that the Intel Thermal Daemon is
> > > > installed
> > > > on the affected
> > > > Asus machines?
> > > > 
> > > > I begin to wonder why this thermal daemon is a userspace
> > > > component,
> > > > stuff like thermal
> > > > management should use the thermal subsystem inside the kernel.
> > > Thanks for detailed analysis here.
> > > 
> > > Here the problem is not thermal daemon or INT340x (I am author of
> > > both).
> > > 
> > > The ODVP variable is input into thermal tables. These thermal
> > > tables
> > > are defined by Asus via DTT tables. This results in matching
> > > certain
> > > max and min power limits and also various temperature limits.
> > > 
> > > By default the laptop in question will boot with max limit of 17W,
> > > which is limit for whisper mode match based on ODVP variables.
> > > There is
> > > a SEN1 limit of 50C, once the limit reaches to 50C, you need to
> > > throttle upto 12W as per thermal table.
> > > 
> > > If you stop thermald, yes, you will stay in 17W, so you will not
> > > see
> > > throttle but your SEN1 (seems skin limit) limit will be violated.
> > > Also if you remove the rapl_mmio driver, that will also work as no
> > > means to set power limits.
> > > 
> > > Windows will do exactly same. Meeting thermal limit is a
> > > requirement.
> > > 
> > > But on Windows this ODVP variable will be set to 0 to match
> > > standard
> > > mode. This will result in matching rules which will set the max
> > > power
> > > to 22W and min to 17W also increase thermal limit to 55C. So
> > > essentially lost 5W of performance.
> > > 
> > > Here WMI method as you correctly found out matching VIVO thermal
> > > policy. But it will not set ODVP variable unless you call a WMI
> > > method
> > > to set the mode via DEVS() on the same device ID. So although
> > > platform
> > > power policy will say "balanced" it is actually "Whisper" for
> > > thermal
> > > policy. On Windows when system boots the Asus service will set to
> > > standard and will set the ODVP variable to 0 and will match the
> > > correct
> > > table.
> > > 
> > > After Luke's help, I can do a work around from user space to change
> > > the
> > > power policy to any other policy than balanced and then again set
> > > to
> > > balance. This will result in setting the policy to standard via
> > > DEVS()
> > > and also set the correct ODVP variable.
> > > 
> > > This driver on unload change the vivo thermal policy to default.
> > > But
> > > doesn't change that to default on load time to match the default
> > > platform power policy. So rmmod and modprobe of driver should also
> > > fix.

Thank you Srinivas for the insights!

> > > 
> > > Thanks,
> > > Srinivas
> > > 
> > Good point, so basically throttle_thermal_policy_set_default() need
> > to be called during
> > initialization of the thermal profile. Maybe you can send another
> > patch which implements this?
> 
> I have already tested this change. But this seems a regression, so want
> to confirm first as it was intentional. The following commit removed
> the call. If it was unintentional, Mohamed can try to submit a change.
> 
> 
> commit bcbfcebda2cbc6a10a347d726e4a4f69e43a864e
> Author: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> Date:   Sun Jun 9 15:48:49 2024 +0100
> 
> Thanks,
> Srinivas

This was definitely not intentional. I'll write a patch asap
I also want your opinion on adding naming changes to the commit to
future proof the patch as it has been proven that it implements platform
profiles for various modern laptops other than the vivobooks and to
avoid any future confusion about the use of the patch

Best Regards,
Mohamed G.

> 
> 
> 
> > 
> > Thanks,
> > Armin Wolf
> > 
> > > > Thanks,
> > > > Armin Wolf
> > > > 
> > > 
> 

