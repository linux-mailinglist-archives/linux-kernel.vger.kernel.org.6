Return-Path: <linux-kernel+bounces-224675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E5D91259F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496DC1C21908
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BBE154C01;
	Fri, 21 Jun 2024 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zt64GUxw"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D41152790;
	Fri, 21 Jun 2024 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973477; cv=fail; b=a6noL1Kd5RV8N88H+PdIAlcHIsmQt6+KN5bejrP4SGHr+X9WbxHyy6KZOKVYVj6jcSZWB/p+AH8tZCMAxFjkGN94OR6K0mQX9pMz9T5Didj1/ebWS1bKSuS6flHPDLlf1NKTmE7E/10UFrx/NDKjZBbFxQG0yg4cC+1ybFxykwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973477; c=relaxed/simple;
	bh=2O4w2fbifzVCPcq+I/K9SzSABn9DMd6WvDSc+IXCMP4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=sBn+pgiyohrF992angPI1LsYSbxhdBQ98Dc2q6VfBO0dg/lKSAJ/Cg6oSF4xdJgKtXuYNhv0mYQcDgg+wRXVxak2KcP5phDjVBPHOaBjdSjTzXSeAAAy+tywN/GxVqFng2CU7owhEI+9v+euB1Hn/ZRM2Z0/OszWGydxwsTf3nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Zt64GUxw; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdnmAuCUmrDSwdANjfHRRqc5qLn77sZJAQYuXH0io7NuHUFHMBoTG7jTzq4M0PQ7p38MtGCpc23usEceHTntwkTM+EbPu15MzlHZOr00gqwwcl2LHY9/p9QkX+upXtm5aIM9kDTs3kQSnMSTF2chUJtcdSpnh+SUgEjF89WFHNwFsbP649zhA0pdmGY4eoEHgfiProIPEaRO1/KJCES5Zv5bDfA5TppZL/xelWD1U/13osLA4TV4IMjuQ0AZRfN3i0+3Ei6G1kPe6NX/w3gfCUdLHrDP+fqmqAd6TGSjXg4Kyn0Nh3VTRaw36T/C2uq6hbUxVqaolvJr32f0dQX3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06c0cdO8oxiYK9YIf5oc5IlK3qb0lOUc/4QzvmCGIGY=;
 b=djEjdHiqHiEZUyfUSzPA857Q782KJTfTfeiBhg1/J6s8dCV1imVxAQJq6KtU0juMR6x8ot4r4oJA5Yi0X8tpTcjtljnUts1xL3xIr92lPt0g+huxX+ufCIloCuMJfztQsguT4da0NV3fpTcNdA/CTFRnPh0VtsBWOfjmOScwjmWwYuLMly/CnuZ/GdcPiYgNXyfLRJjH1jKdfWU01lvnbM60do5VoJ8w/yzs1KdnZyq109tgHVABwSk5D83WS5mrE6WZWweTWvHOTrbKV91ZV0DFvMuMn8JAJ0Xre2REwjN0RjpVIaB+jfTXp/OMLUXMetKCWn5td9kGwpXxPDb5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06c0cdO8oxiYK9YIf5oc5IlK3qb0lOUc/4QzvmCGIGY=;
 b=Zt64GUxwa8D3OPodSlQDn9qsCFX8Mrs1oHrjOa+Tk99s4hpspHskNs3pTSkJea3GRCTdmHyC8jQXEbUR4twRKigXR8YT2A5liHiu5i/zlFWo7PdJYWRe3hav0t4yFr6Qw3SavkMeurXXbg0KZQ69iztQbbYUv3YJFy32GtA2ApE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DB9PR04MB9553.eurprd04.prod.outlook.com (2603:10a6:10:2ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 12:37:51 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 12:37:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] firmware: arm_scmi: introduce max-rx-timeout-ms
 property
Date: Fri, 21 Jun 2024 20:46:56 +0800
Message-Id: <20240621-scmi-mailbox-v1-v1-0-8ed450735f46@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEB2dWYC/x3MQQqAIBBA0avErBtQC9GuEi3KphpICwUJwrsnL
 d/i/xcSRaYEQ/NCpMyJr1Ah2wbcMYedkNdqUEL1QkuDyXlGP/O5XA9miXZRTlqtO2s01OqOtPH
 zH8eplA/QbHGyYQAAAA==
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718974025; l=998;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=2O4w2fbifzVCPcq+I/K9SzSABn9DMd6WvDSc+IXCMP4=;
 b=atRIIjGxUxhe2P69TuZQn7/Ps3UFnk3+gOKaGGxoetp/+OmkKOM2iut83wUitfSQOH0n4PHUj
 PTgLb6XEq3iBNoyzMzbu/1CX86OjHXN0C0tRxGkS+9BtLUcZC5Pfozi
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DB9PR04MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f9963c-e457-4f73-e77d-08dc91eef68b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|366013|376011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUYyQjM0Wm93bjJUc1FzZCtvRXptd1hSMjBPVEwxVTVtZFpScU1GT0YzZk8w?=
 =?utf-8?B?ZGlBNFpCNS8yK2tiS1hlc0o0UDZaWHVUdXBZck0yQVVDQU8zbzd5OTFjL1Yy?=
 =?utf-8?B?TTZ1S0hFY0ZodWlZVzR2SDF4Z2pQM2JnWnFmaUd0eGZPejhRSGtuZGxDZjEw?=
 =?utf-8?B?MlJCT3MyeGNzVnhBS2JKaHhBblBBZnVwbmRQcDFSVVZRL1psT0UxZGdCMGF3?=
 =?utf-8?B?TVJnZE5hbmZKSDI0czJ6RUp1V2RrbW03djZSTU51dkRLRE5yY3ZFS2xWQWJG?=
 =?utf-8?B?Q3V2RThYN0JDRjlDaUpBTGZRK00vRkROK0ordjJENXdtNjhsdVRnVVVINVBl?=
 =?utf-8?B?RTR1c1VackhxQlVLalhEOVQ5SHdUb28rcGpOclRENm5ZVTRlVzlIQ205OVpq?=
 =?utf-8?B?OElkeDk3cklJYk9UR0tPQWRDWjBFM2V6dFBVMU5McE15RXNJQUNhMUdRcGs4?=
 =?utf-8?B?d3UwY2J1bHVvUk80dW9HWjhNS3Jpcnd2M1JFdnJ2bDd4T0UrVnViYlNEdjNL?=
 =?utf-8?B?bVZzVjNQZ1BhSUpVcHhENUZGeGtqWkVrcVhDcW12NXBhQ0drcWZSYkYzcDZy?=
 =?utf-8?B?MEQrdm9hYmVuR3pDZVNEZDFuZllYSC9rOG5uaC83UHk1czZFQlhJSGhlZEtC?=
 =?utf-8?B?TG0rWTlOcEZkT2wrRnBTUzJmczVMWEV5UUp4dmhRRjgvTDArV0dEL2VCSW1U?=
 =?utf-8?B?Y0d6NC9LNnMrWWlpdElRcWk5WExqWEM1VFZ4K1RjUVQ0RmNEYVlzcU5jS2FL?=
 =?utf-8?B?QjhIc2lmNTZFZHdkRFlneUFQdmd4ZlNTbWI3OWp1ZWwzT05xV1AvVklPTVU4?=
 =?utf-8?B?YTN2VVMvYTQzUEkwdlJabW9RNnYzeEN6SmtkVXVwZXhhUUMrSzU2YlIrVllw?=
 =?utf-8?B?TDVEdWcvTEJOUlk3Y085bTNOVTVkYmhLV3lOelJkdWF0anBDM08zOEQvWEJ3?=
 =?utf-8?B?MnJzN0t2Z2tTeDhJV1lZMnhKNkJvOGsrQ3I0ekgxMDZrZkR3UlpJaC9Fc0xE?=
 =?utf-8?B?Ymc4RkV1NU4rd0sxMEZwbDVwSWZYdStRWjN2REdoWW1zOGZEaGFCOXRXYkVF?=
 =?utf-8?B?bk5iMUtERG1iSnZVUUprcWtDd2lJckMzUCt2Q2plWkRQL1crZ1Vadm01RlV6?=
 =?utf-8?B?aDQ3MlBEK2J0aWJIMmczcDlvTDB4SGNpRVo5UUFNMzRMdVVXSmJSQkszZEEv?=
 =?utf-8?B?SjI0QjZIY2RvaW5BOTI4OGM1UmlSNi9YQ2JaSGVLanVCZFVBZGRFUkhtNW5P?=
 =?utf-8?B?QjAwWVBQaEpEZGtOV0FCMU1VSC9PU0JwWkVjcEJubzFzRGRycTdwMHBsNTJm?=
 =?utf-8?B?Um1QQ3ZhSDZCcldsYUhwZk1PRmNYbmRBYW1mZTVpMXk2YURqcnpMa3V4UVll?=
 =?utf-8?B?MUpmbFYwYnFkR2VnSXZKT3RLeW1GVmpJSXZvYWdoaWFDVTZlVE1LSnc5MWRx?=
 =?utf-8?B?K1ZLcm1UazIzcWt1bWRNcnlRTDgycDZWbFFKU3c1QUVkYnh3VXdnNkhObHpS?=
 =?utf-8?B?NEVENWIydTZDTko3NFVrdlpTQS81V095ditnaThuUmxVVnhvSW5uWXV1Y3cw?=
 =?utf-8?B?Y3hpMEpla1VMNWRNK0szaGRUMlNtdWxrQVQwdW9xZ2xFZVdQckRFL2owWTZm?=
 =?utf-8?B?SVVPTE5aZjl1VCs0Z3RybHd5TGx4dGJvaEVZQU0vTUdkV2xqVUpGZ0NmYVBK?=
 =?utf-8?B?cEs1WGlYcFdRejR5azV0MmNCNXdNV2NMNnRRbWxRLzFxVTZlNnNHektoa0ZK?=
 =?utf-8?B?aS83RHphc1ZnVDZGeEdQL1VsVjNPTytXQ3dNR1NxYTMwZ0hWSHJkcE54N1k5?=
 =?utf-8?Q?mRdJcxaEqBrhD+s0gsg8HSK/ZsI4vPcaWyWr0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(366013)(376011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjJmd2E2ZjZyUkZZSlN1YjJGTzJrZVc5c3hnNmpLcGVSME0rWUljcHAxQmN0?=
 =?utf-8?B?dVNFaDdDNitXZmFhSkNhOGVRV0hEL3RZeERwa0RERFRtR0hzV1VOdTl6VnFa?=
 =?utf-8?B?czlPN1BSSDEzekg1YVJHdDREaENRWFF2SWVVOHBzd0dIZ1lkd21PZnp1RG1l?=
 =?utf-8?B?R29KUlI5NUFHOXlnZlJzYXROb2hmNkdBNGJzNzhXOWN5VkpOK2xIa2N0N3hj?=
 =?utf-8?B?K0pCdlk1OWJFUmVFeXhRWVNBb1JhZFlMeFJQVDBzbEViVkRIbjRtdVFiekNY?=
 =?utf-8?B?MmovWklDVnN1eFhkQ013OXBuQXdrd0pxSDNVV3JEdEpFTXFIUjhlaGkxM3Bn?=
 =?utf-8?B?T3FnWG9Ick8zd0s0aU4zRDhVdnAxR2FDUDNiQzh3OHNOcFNOSVhwLzRRNjEw?=
 =?utf-8?B?b2JCOTdWaDl4bCttUDFueWYzQTlKOFlFMjNmVHBONzBZdWNuSzNEcXUvMVBW?=
 =?utf-8?B?VU9ib2NLZFRSZEJLbWx2OFBTdU1qR3ZiM2diN0l5c1J5TjZtWFVjb3IzSjFa?=
 =?utf-8?B?eVVvRlJRSmdKOHNzNmZ2VllPdFl1VERhUDBBaWwrN1Y4UDZWVGtxcFBxT2Ix?=
 =?utf-8?B?TXRwajBHa2Yyc1lZTzA2aGNVbWN2dnJ1ZEtQWisxZWtvbHdjL2RBd051ZUcr?=
 =?utf-8?B?bml6RU9tVnlPa05DYXVQWW9aZTlDNzlwWjB1ekZSQkNDMVlJUVpZL3Q2RkE3?=
 =?utf-8?B?eFlTQStPVUxPdTFIQkZzVE1RNkNETUVjTUhmVHMxMDZSL1dmWEQ5RWFNWlh0?=
 =?utf-8?B?ZVBneXFuWm13UUVwUlJISldRNXpzVGpYYmE3cy9Mb0M1TnJ1M3FhdWcyMVZh?=
 =?utf-8?B?RlZ3U2dOcEZFZU5IRUlMWDdwMHlyUjdzd3MvNERYb09XNU5DQTVyRnhJWVBx?=
 =?utf-8?B?RUFOWW9WMmpyVnVBenM5L3pNc0RHMWhoVURmamJBK24zczF4T3FHaHR2c3I5?=
 =?utf-8?B?Y21mMzZ3cEU2Y1prWGFTWlRkRzN0aFhTdWFCR1VFSFd0cCs1aEZqZFFNTndS?=
 =?utf-8?B?Zlo2T01IYzBEYW1QMEdBelE3bERvTDUzQS9zdFZaVW1QRFFRb0FpSy9vOHJq?=
 =?utf-8?B?ZmRMQnJlVGhCWVA4MzNZQnNHalZUOGRLV2hOOTBiM0RteEpwMUlXYWZQTWZu?=
 =?utf-8?B?NTkzT0I4eE9kWmhzbGVSRDB0dUVxbnVJYmNmNUN6KzVhNTZKSW5NeWI1SUtF?=
 =?utf-8?B?NEl4WmVYMnRCbmNJZllUMXRWdjJjSnlRcTErclEzSVJZaHZrd1AwWWMzWlNi?=
 =?utf-8?B?ZzcwY0E0dGZWem00SVluZ3J0R0RFU1h3c21TWFNjM2YydEw3b1VnQXkzaEtG?=
 =?utf-8?B?V3J0K2hid2FBSUZqUkdvQzRJaGRqMUdZMHJ0V1JkbHZLQVhuNkY5eEloL2Zt?=
 =?utf-8?B?b2JOR0wvOXptcDFHOFVRenJkOWFnQ2oxNE5JbDdQaUtSOTluSURJWGJ1SEZ6?=
 =?utf-8?B?Z3Jvcm5aS0JLTDNEamtYeFNGQmwrdEltQVo1YzJXRSt2SlNPaWp6YU05ZFJv?=
 =?utf-8?B?TzhlRVFHSkI5WUM5aFBGd2VLTDh3V2l0VTlocVVGOW5hamFhOXdzSTA2R3pJ?=
 =?utf-8?B?VEVsV0tMZlk5VmRrakFQNTVHYVptbGdXcWFmMnQ5Q0YxRVdoUmU3UmhieDBM?=
 =?utf-8?B?ZnlNQXpCRnBFcmtrSm1YcWpWRnVlUHdhTWk4aXo0YldaWmhPNlNwUGNzU1lF?=
 =?utf-8?B?ZW5WT1NNTkhpSGV4cEl1ejNKbFZpY0dSL3Z5K1M4bU40RlNKOFNPSnBGL0Vk?=
 =?utf-8?B?YURrYm9nNDdQVFoyUElhOWRSMUtjalY0TzgxY29xcEY0SFlhOUVtQkkxVmFJ?=
 =?utf-8?B?Z3FGSjJsMFY1Znh1NldkM1pwN3FHOExRWjhWT012ZEdQeit1eWRWU0lLKy9z?=
 =?utf-8?B?ZmZOZnp0TGZndjExanhGVStDWitxVldFM2VldUNuNVkvK1R0MDBzU0d6emlL?=
 =?utf-8?B?ekhObjlPa3RxYnlUbXlOS1lDemFEY3hrOWo0K1BsYzlkclVGSVN4YTI5ZVpO?=
 =?utf-8?B?RnN5SVhXczhEQ3BOcmxzYkVRcktkalNvV1c5cWk0cUFOU2ErQVRCV1JoT0tL?=
 =?utf-8?B?NnYxdUFDOFc5T3hYSlR2VHNpblA2T0RTMmZZeGJJdEorOVhMVFNBOFVXY3Zq?=
 =?utf-8?Q?rRa+F1AlgXeOFTw2tANyD1JCx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f9963c-e457-4f73-e77d-08dc91eef68b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:37:51.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWdBWQ5ohn+ngO/17plnF+zraJ+uqfGnVKPhAaXptTEaHdiPMn8EEfZRpXWBOrkXlSInf3LFeAKHYzDFP2cJFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9553

The current mailbox scmi_desc set the timeout value to 30ms, but
each platform might have its own maximum receive channel timeout value
based on the System Control Management Interface(SCMI) firmware design
and hardware attributes, so introduce a property for that and use it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      dt-bindings: firmware: arm,scmi: introduce property mbox-rx-timeout-ms
      firmware: arm_scmi: set mailbox timeout value from device tree

 .../devicetree/bindings/firmware/arm,scmi.yaml        |  6 ++++++
 drivers/firmware/arm_scmi/driver.c                    | 19 ++++++++++++++-----
 drivers/firmware/arm_scmi/raw_mode.c                  | 11 +++++++----
 drivers/firmware/arm_scmi/raw_mode.h                  |  3 ++-
 4 files changed, 29 insertions(+), 10 deletions(-)
---
base-commit: 76db4c64526c5e8ba0f56ad3d890dce8f9b00bbc
change-id: 20240618-scmi-mailbox-v1-9b2c19663986

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


